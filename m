Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1950FEE49AB
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 18:41:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7BF5864A1;
	Tue, 22 Aug 2023 20:41:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="HhnmmfA8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD2808649D; Tue, 22 Aug 2023 20:41:46 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48F3E86482
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 20:41:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37MIfeYd080360;
 Tue, 22 Aug 2023 13:41:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692729700;
 bh=V2W0MN9law2wpm+4+WAqevY+8V9v4mZ2dM3CGTwjPZ0=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=HhnmmfA8cvU7gfTK0FLjjBnWhBqkzMPMjvoX71u2elyCPzDN3p5Hehyg/JL7eAHjU
 Pmvds/cRz+8b1bFcCRtnTsrOwx6mZcfG2Fc7rlhHFAxRqLFdlKGQRBgWZvgbMXWvkW
 PZNcPl9/HjZhS3WLHTyeuYTfTpFS7ki68xnIQMgY=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37MIfe4V031100
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 22 Aug 2023 13:41:40 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 22
 Aug 2023 13:41:40 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 22 Aug 2023 13:41:40 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37MIfehD126907;
 Tue, 22 Aug 2023 13:41:40 -0500
From: Nishanth Menon <nm@ti.com>
To: Neha Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>
CC: Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>, Robert
 Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 <u-boot@lists.denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>
Subject: [PATCH V4 2/8] configs: am62x_evm*: Enable EMMC_BOOT configuration
Date: Tue, 22 Aug 2023 13:41:29 -0500
Message-ID: <20230822184135.2328409-3-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230822184135.2328409-1-nm@ti.com>
References: <20230822184135.2328409-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Enable EMMC boot support for AM62x evm base configuration.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
New patch

 configs/am62x_evm_a53_defconfig | 1 +
 configs/am62x_evm_r5_defconfig  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/am62x_evm_a53_defconfig b/configs/am62x_evm_a53_defconfig
index d55caabe22c9..824a99b9b6cc 100644
--- a/configs/am62x_evm_a53_defconfig
+++ b/configs/am62x_evm_a53_defconfig
@@ -69,6 +69,7 @@ CONFIG_TI_K3_NAVSS_UDMA=y
 CONFIG_TI_SCI_PROTOCOL=y
 CONFIG_DM_MAILBOX=y
 CONFIG_K3_SEC_PROXY=y
+CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ADMA=y
 CONFIG_SPL_MMC_SDHCI_ADMA=y
diff --git a/configs/am62x_evm_r5_defconfig b/configs/am62x_evm_r5_defconfig
index 3c5f36729842..489ee943fe31 100644
--- a/configs/am62x_evm_r5_defconfig
+++ b/configs/am62x_evm_r5_defconfig
@@ -92,6 +92,7 @@ CONFIG_DM_MAILBOX=y
 CONFIG_K3_SEC_PROXY=y
 CONFIG_SPL_MISC=y
 CONFIG_ESM_K3=y
+CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ADMA=y
 CONFIG_SPL_MMC_SDHCI_ADMA=y
-- 
2.40.0

