Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F34C4C4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 16:00:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1490F871D0;
	Tue, 14 Nov 2023 17:00:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="pUevQw+X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6820C86940; Tue, 14 Nov 2023 17:00:05 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0004586940
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 17:00:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AEFxwei129320;
 Tue, 14 Nov 2023 09:59:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699977598;
 bh=e9bi79Pxg6ZC8A+1QO2lmLzJXZab7t8u/HEY3+wBH6g=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=pUevQw+XKjG9kBOGMp3IvXi+o3+lRDR0Rdmsc0N+f/dd6HXWwQppyDArN4zxNAKTD
 a7tlYgcrQNR1QC29v+G9602ZkHJYHwTBKSt3fYTyrFa46B0r9LDTqZM9HpizO5s7fg
 0RAiVISvLUoBcYtinZQgxb5FsDdFPSeQRJbKYuLQ=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AEFxwLk067469
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 14 Nov 2023 09:59:58 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 14
 Nov 2023 09:59:58 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 14 Nov 2023 09:59:58 -0600
Received: from fllv0039.itg.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AEFxvpU021295;
 Tue, 14 Nov 2023 09:59:57 -0600
From: Andrew Davis <afd@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Nishanth Menon <nm@ti.com>
CC: <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>
Subject: [PATCH 2/3] arm: mach-k3: Remove incorrect checks for SPL build
Date: Tue, 14 Nov 2023 09:59:49 -0600
Message-ID: <20231114155950.296644-2-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231114155950.296644-1-afd@ti.com>
References: <20231114155950.296644-1-afd@ti.com>
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

The kconfig option SPL means this build supports SPL but not that
this build is SPL, nor that this build is the SPL running on R5.
For options that are for R5 SPL use CPU_V7R.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/mach-k3/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
index 9168bf842dc..4d19cf3e353 100644
--- a/arch/arm/mach-k3/Kconfig
+++ b/arch/arm/mach-k3/Kconfig
@@ -111,7 +111,7 @@ config K3_EARLY_CONS_IDX
 
 config K3_LOAD_SYSFW
 	bool
-	depends on SPL
+	depends on CPU_V7R
 
 config K3_SYSFW_IMAGE_NAME
 	string "File name of SYSFW firmware and configuration blob"
@@ -158,7 +158,7 @@ config K3_SYSFW_IMAGE_SPI_OFFS
 
 config SYS_K3_SPL_ATF
 	bool "Start Cortex-A from SPL"
-	depends on SPL && CPU_V7R
+	depends on CPU_V7R
 	help
 	  Enabling this will try to start Cortex-A (typically with ATF)
 	  after SPL from R5.
@@ -172,7 +172,7 @@ config K3_ATF_LOAD_ADDR
 
 config K3_DM_FW
 	bool "Separate DM firmware image"
-	depends on SPL && CPU_V7R && (SOC_K3_J721E || SOC_K3_J721S2 || SOC_K3_AM625 || SOC_K3_AM62A7) && !CLK_TI_SCI && !TI_SCI_POWER_DOMAIN
+	depends on CPU_V7R && (SOC_K3_J721E || SOC_K3_J721S2 || SOC_K3_AM625 || SOC_K3_AM62A7) && !CLK_TI_SCI && !TI_SCI_POWER_DOMAIN
 	default y
 	help
 	  Enabling this will indicate that the system has separate DM
-- 
2.39.2

