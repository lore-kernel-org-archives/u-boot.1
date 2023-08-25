Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1342C3DA6F
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 18:04:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAB8A86ACF;
	Fri, 25 Aug 2023 20:03:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="BpwVMekz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1830F86AF7; Fri, 25 Aug 2023 20:03:20 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1B0C86AC1
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 20:03:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37PI37we117350;
 Fri, 25 Aug 2023 13:03:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692986587;
 bh=/CQPIhpasHZrUj/2SjlERPW4zi6K+aTETf7OwNOkTj0=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=BpwVMekzNgmGWMGyJ6jAy9HrTXTdF+iNyrsP1L1IvhJO5bQCIE3kBzjXQE7Pvz+V4
 PLA7H/2jZeNZV94O5jSP4VYrzSC7IEgzn8gt+LAJA5KuSz/Eyp0zqEfRGOdm4ne6to
 Hi5kW6kCLgky/UG1B0Z4ZAEsqdISfH9mvrtKUAf0=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37PI37FI124003
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 25 Aug 2023 13:03:07 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 25
 Aug 2023 13:03:06 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 25 Aug 2023 13:03:06 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37PI36A1026941;
 Fri, 25 Aug 2023 13:03:06 -0500
From: Nishanth Menon <nm@ti.com>
To: Neha Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, Simon
 Glass <sjg@google.com>
CC: Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>, Robert
 Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 <u-boot@lists.denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>
Subject: [PATCH V6 14/20] configs: am62x_evm*: Enable EMMC_BOOT configuration
Date: Fri, 25 Aug 2023 13:02:59 -0500
Message-ID: <20230825180305.69515-15-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230825180305.69515-1-nm@ti.com>
References: <20230825180305.69515-1-nm@ti.com>
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

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
No change other than picking up reviews, tested tags along the way.
V5: https://lore.kernel.org/r/20230824031101.3460411-13-nm@ti.com
 configs/am62x_evm_a53_defconfig | 1 +
 configs/am62x_evm_r5_defconfig  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/am62x_evm_a53_defconfig b/configs/am62x_evm_a53_defconfig
index 1807df8bbee9..112125673699 100644
--- a/configs/am62x_evm_a53_defconfig
+++ b/configs/am62x_evm_a53_defconfig
@@ -70,6 +70,7 @@ CONFIG_TI_K3_NAVSS_UDMA=y
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

