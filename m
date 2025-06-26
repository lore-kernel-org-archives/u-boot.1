Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3AA0C7EE32
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 12:06:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E0F682E34;
	Thu, 26 Jun 2025 14:05:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="lczZeudl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88134809A5; Thu, 26 Jun 2025 14:05:45 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8678782D21
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 14:05:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55QC5YMW2450039;
 Thu, 26 Jun 2025 07:05:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1750939534;
 bh=cpR99oDZ24/J38ZasXdHF4diIOLLMpAmvrbPEsTxwjo=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=lczZeudlARr7kQq7CJRO5TnYjDs4HlPjQPXzdAOTfbWjKoet5XAwLsZMmEZ7j2Oxx
 AeZse86VrK/YOFLXIBw1aeAnZzB5nkJbWCHLhk0s/I87sqGljuLyyxl46VCn2OyuHS
 Uy1B9bm3aSqEa0tMUIhm0UzqElWOB5APZDZCzqUg=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55QC5YUs3603896
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 26 Jun 2025 07:05:34 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 26
 Jun 2025 07:05:34 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 26 Jun 2025 07:05:34 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55QC5XE5967456;
 Thu, 26 Jun 2025 07:05:33 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <nm@ti.com>, <bb@ti.com>
Subject: [RFC PATCH v1 4/4] cmd: Kconfig: disable loading raw images in secure
 os boot
Date: Thu, 26 Jun 2025 17:34:42 +0530
Message-ID: <20250626120443.1405409-5-anshuld@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250626120443.1405409-1-anshuld@ti.com>
References: <20250626120443.1405409-1-anshuld@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Raw kernel images can not be authenticated so disable loading such
binaries in secure falcon mode. This change restricts the falcon mode
SPL to FIT as the only viable boot image which can be authenticated.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 cmd/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index ed741d43cea..8eb55dd7f6e 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -353,12 +353,13 @@ config BOOTM_ELF
 
 config CMD_BOOTZ
 	bool "bootz"
+	depends on !SPL_SECURE_OS_BOOT
 	help
 	  Boot the Linux zImage
 
 config CMD_BOOTI
 	bool "booti"
-	depends on ARM64 || RISCV || SANDBOX
+	depends on (ARM64 || RISCV || SANDBOX) && !SPL_SECURE_OS_BOOT
 	default y
 	help
 	  Boot an AArch64 Linux Kernel image from memory.
-- 
2.49.0

