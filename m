Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A442D68BE4
	for <u-boot@archiver.kernel.org>; Sat, 16 Nov 2024 07:17:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C08F896EE;
	Sat, 16 Nov 2024 08:17:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="tbxBJFOF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37E76896F6; Sat, 16 Nov 2024 08:17:03 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3DCF896EE
 for <u-boot@lists.denx.de>; Sat, 16 Nov 2024 08:17:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-limaye@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4AG7Gx523309192
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 16 Nov 2024 01:16:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1731741419;
 bh=kCHjejeP/Kkeur6R39Ren1mp+2baKIrIwaLasick8I4=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=tbxBJFOFfcdd+EkgyI0d2KF0Xh4lto3GhEy3OMxCw3AVrrSWC3uNTpJZjvh59muCA
 sfF6jI890PS4JNX/QviPBNdgqB1QPlqHioG6ArMSjv6B+mSGYgHw0VxM5ywPZaR01+
 9UK9AOChs2ODt6gLW0Pw8XFC59fyUnByAC8M7et0=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4AG7GxjJ022876
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 16 Nov 2024 01:16:59 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 16
 Nov 2024 01:16:58 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 16 Nov 2024 01:16:58 -0600
Received: from PSDKL-Workstation0.dhcp.ti.com (psdkl-workstation0.dhcp.ti.com
 [172.24.227.91])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AG7Gg66129041;
 Sat, 16 Nov 2024 01:16:56 -0600
From: Aniket Limaye <a-limaye@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>
CC: <u-kumar1@ti.com>, <reidt@ti.com>, <m-chawdhry@ti.com>, <nm@ti.com>,
 <n-francis@ti.com>, Aniket Limaye <a-limaye@ti.com>
Subject: [PATCH v3 5/5] configs: j7200_evm_r5_defconfig: Define K3_OPP_LOW
Date: Sat, 16 Nov 2024 12:45:19 +0530
Message-ID: <20241116071615.839623-6-a-limaye@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241116071615.839623-1-a-limaye@ti.com>
References: <20241116071615.839623-1-a-limaye@ti.com>
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

From: Reid Tonking <reidt@ti.com>

Define new CONFIG_K3_OPP_LOW under arm/mach-k3/Kconfig and add default
value to j7200_evm_r5_defconfig

Signed-off-by: Reid Tonking <reidt@ti.com>
Signed-off-by: Aniket Limaye <a-limaye@ti.com>

---
v3:
- Add Kconfig dependency on K3_AVS0
- Update commit msg to make it more clear
- Link to v2: https://lore.kernel.org/u-boot/20241023130033.1826413-6-a-limaye@ti.com/

Signed-off-by: Aniket Limaye <a-limaye@ti.com>
---
 arch/arm/mach-k3/Kconfig       | 7 +++++++
 configs/j7200_evm_r5_defconfig | 1 +
 2 files changed, 8 insertions(+)

diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
index f3f42b39213..c73396bfbf3 100644
--- a/arch/arm/mach-k3/Kconfig
+++ b/arch/arm/mach-k3/Kconfig
@@ -103,6 +103,13 @@ config SYS_K3_BOOT_CORE_ID
 	int
 	default 16
 
+config K3_OPP_LOW
+	depends on ARCH_K3 && K3_AVS0
+	bool "Enable OPP_LOW on supported TI K3 SoCs"
+	help
+	  Enabling this will allow Socs with the proper efuse to run at a lower
+	  MPU core voltage and adjust frequency according to SoC trm
+
 config K3_EARLY_CONS
 	bool "Activate to allow for an early console during SPL"
 	depends on SPL
diff --git a/configs/j7200_evm_r5_defconfig b/configs/j7200_evm_r5_defconfig
index f036a6fd46b..217759e5d1b 100644
--- a/configs/j7200_evm_r5_defconfig
+++ b/configs/j7200_evm_r5_defconfig
@@ -102,6 +102,7 @@ CONFIG_K3_SEC_PROXY=y
 CONFIG_FS_LOADER=y
 CONFIG_SPL_FS_LOADER=y
 CONFIG_K3_AVS0=y
+# CONFIG_K3_OPP_LOW is not set
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_SPL_MMC_HS400_SUPPORT=y
 CONFIG_MMC_SDHCI=y
-- 
2.47.0

