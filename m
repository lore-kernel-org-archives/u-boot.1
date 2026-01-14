Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C676D31A3B
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 09:57:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7668E80081;
	Wed, 14 Jan 2026 10:57:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="rG2ERFv/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7BB280325; Wed, 14 Jan 2026 10:57:00 +0100 (CET)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B882C8003E
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 10:56:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 91D6EC2087B;
 Wed, 14 Jan 2026 09:56:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 384756074A;
 Wed, 14 Jan 2026 09:56:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id F2EC1103C8951; Wed, 14 Jan 2026 10:56:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1768384617; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=cN0foBtMgAISnUuRBhth3euHIkjQVEMZWHH3mSyhr7Y=;
 b=rG2ERFv/+x4EYuzAvd4zmTherp9/XfNXWbPsc8AXtCaQjfewYAR+EKz+3VBZ2ohzzlVIUj
 uKBZpMoaSHxvN3G2sZ3bYAmgld1nsVZtueiXVUKq1PggVKVrNg99dmic74dxQhUIiirOhL
 bXSGrXQwQuTYTQMB9C43162xtiqLKzMxalQO5XtsCm8XjzsXYQA5EV9pMWmPBxUNXF/6PN
 nFLnce4KZ+5/w57ipttLvOLfzze2NGybx/+ArinDhRmB3C3UaQgn9w7D91CemJ6JymrbaH
 sedmdwW9zdl2+matoftDuOG+GUOUBD7PEwQpDhUqkUG6kyIR6q9MiN+ErIVw9g==
From: Kory Maincent <kory.maincent@bootlin.com>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, thomas.petazzoni@bootlin.com,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] fwu-mdata: Allow multiple metadata storage drivers to be
 enabled
Date: Wed, 14 Jan 2026 10:56:53 +0100
Message-ID: <20260114095654.736511-1-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Change the Kconfig from a "choice" to a conditional block, allowing
multiple FWU metadata storage drivers to be selected simultaneously
instead of being mutually exclusive.

This enables systems with FWU metadata on different storage types
(e.g., both GPT-partitioned block devices and MTD devices) to have
both drivers compiled in. The board can then select the appropriate
driver at runtime based on the devicetree description.

The change converts FWU_MDATA to a menuconfig and replaces the
"choice/endchoice" block with "if FWU_MDATA/endif", making
FWU_MDATA_GPT_BLK default to 'y' for backward compatibility.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 drivers/fwu-mdata/Kconfig | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/fwu-mdata/Kconfig b/drivers/fwu-mdata/Kconfig
index 42736a5e43b..59571ac01ea 100644
--- a/drivers/fwu-mdata/Kconfig
+++ b/drivers/fwu-mdata/Kconfig
@@ -1,4 +1,4 @@
-config FWU_MDATA
+menuconfig FWU_MDATA
 	bool "Driver support for accessing FWU Metadata"
 	depends on DM
 	help
@@ -6,16 +6,14 @@ config FWU_MDATA
 	  FWU Metadata partitions reside on the same storage device
 	  which contains the other FWU updatable firmware images.
 
-choice
-	prompt "Storage Layout Scheme"
-	depends on FWU_MDATA
-	default FWU_MDATA_GPT_BLK
+if FWU_MDATA
 
 config FWU_MDATA_GPT_BLK
 	bool "FWU Metadata access for GPT partitioned Block devices"
 	select PARTITION_TYPE_GUID
 	select PARTITION_UUIDS
-	depends on FWU_MDATA && BLK && EFI_PARTITION
+	depends on BLK && EFI_PARTITION
+	default y
 	help
 	  Enable support for accessing FWU Metadata on GPT partitioned
 	  block devices.
@@ -28,4 +26,4 @@ config FWU_MDATA_MTD
 	  (or non-GPT partitioned, e.g. partition nodes in devicetree)
 	  MTD devices.
 
-endchoice
+endif
-- 
2.43.0

