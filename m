Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB92BCD37B4
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 14:09:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7D3686722;
	Sun, 17 Sep 2023 16:09:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="mAQEDxun";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="TrDsydyV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 515708662F; Sun, 17 Sep 2023 16:09:13 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EBE486552
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:09:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4RpVCp1mppz9sW2
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 16:09:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j+q1SM0wMyEzKFLQQFhwYQOzais67s3kKFQaFKoGKx8=;
 b=mAQEDxunUDqXb08bo+j+P7/iH1zo/y3TMv2W+m0JKG/TLUcJhEnzQ7euHnRBXgzueY2xZG
 1tZdvgM0tsUnpmbVMBb52bjICu+LYzzyhIJjQdssTnfO+ASf6F2fhr+R1OA9m9PzccRJRk
 QIDHzdBCtxIypEiuvJNdDU9CYLVBayj0TSl7CXSMV4j7c+K1SWw9586jCgcD8HypeXsvDQ
 csDNfnUB9K7ygdmspZDjGJ5Qqu8WvrE9Rbc/EHb1qL/6zlSNMJZ6zoT4BpJTvMJG05tMp6
 uQaWm76QpZlfUab7dL038f5QW/XoJoB+btLfkK/869Kt+Gtdere+xujM+LjWVw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694959748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j+q1SM0wMyEzKFLQQFhwYQOzais67s3kKFQaFKoGKx8=;
 b=TrDsydyVHToJOa/bit+EuvdMfzMa/XXOsJUZHBCa3lxJbLJffmkkSAJCtUP6VGpiVObTk4
 B8RKXAM0QrldvH9HDZzLgtm67K5QlO/QZYD9g5EtJjmBurpMNWMNaMUXQmXEuArxTlXgFb
 LV7+NpGrk2LCfUvtnRM9ybVRsy+V1l3pZiFN+fIx2oyeFFLD00FoPzYb8EgPHERDE6L7ao
 9LSZ56clJMO+3ywHr2i2T2vA9DhPU0F7iAK+wNEjn7hqpAVztphmOyFnNP4xj5hg0eo3Qk
 kdooulxRG/K77I9Z05D2AJRoHNk93FTGLShUFk1qJSXbfPZccGiwIN1370pOag==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 02/18] pinctrl: renesas: Rename RZ/A1 R7S72100 PFC tables to
 RZ/A1
Date: Sun, 17 Sep 2023 16:08:33 +0200
Message-Id: <20230917140849.379711-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230917140849.379711-1-marek.vasut+renesas@mailbox.org>
References: <20230917140849.379711-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 372a5e21fef4aa7986b
X-MBO-RS-META: my4weusfs6egf6wweaye54rbfwf3kzbw
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

Rename pfc-r7s72100.c to pfc-rza1.c to match the file name with Linux.
Rename the Kconfig symbol to match.

No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/pinctrl/renesas/Kconfig                            | 2 +-
 drivers/pinctrl/renesas/Makefile                           | 2 +-
 drivers/pinctrl/renesas/{pfc-r7s72100.c => pinctrl-rza1.c} | 0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename drivers/pinctrl/renesas/{pfc-r7s72100.c => pinctrl-rza1.c} (100%)

diff --git a/drivers/pinctrl/renesas/Kconfig b/drivers/pinctrl/renesas/Kconfig
index 0ea39b4a3f1..32f44e5bbd7 100644
--- a/drivers/pinctrl/renesas/Kconfig
+++ b/drivers/pinctrl/renesas/Kconfig
@@ -131,7 +131,7 @@ config PINCTRL_PFC_R8A779G0
 	help
 	  Support pin multiplexing control on Renesas RCar Gen4 R8A779G0 SoCs.
 
-config PINCTRL_PFC_R7S72100
+config PINCTRL_RZA1
 	bool "Renesas RZ/A1 R7S72100 pin control driver"
 	depends on CPU_RZA1
 	default y if CPU_RZA1
diff --git a/drivers/pinctrl/renesas/Makefile b/drivers/pinctrl/renesas/Makefile
index 8e59104ecf1..f9a68794eb9 100644
--- a/drivers/pinctrl/renesas/Makefile
+++ b/drivers/pinctrl/renesas/Makefile
@@ -19,5 +19,5 @@ obj-$(CONFIG_PINCTRL_PFC_R8A77995) += pfc-r8a77995.o
 obj-$(CONFIG_PINCTRL_PFC_R8A779A0) += pfc-r8a779a0.o
 obj-$(CONFIG_PINCTRL_PFC_R8A779F0) += pfc-r8a779f0.o
 obj-$(CONFIG_PINCTRL_PFC_R8A779G0) += pfc-r8a779g0.o
-obj-$(CONFIG_PINCTRL_PFC_R7S72100) += pfc-r7s72100.o
+obj-$(CONFIG_PINCTRL_RZA1) += pinctrl-rza1.o
 obj-$(CONFIG_PINCTRL_RZN1) += pinctrl-rzn1.o
diff --git a/drivers/pinctrl/renesas/pfc-r7s72100.c b/drivers/pinctrl/renesas/pinctrl-rza1.c
similarity index 100%
rename from drivers/pinctrl/renesas/pfc-r7s72100.c
rename to drivers/pinctrl/renesas/pinctrl-rza1.c
-- 
2.40.1

