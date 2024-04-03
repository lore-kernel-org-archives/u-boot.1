Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25055CD1288
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 13:59:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D4D688397;
	Wed,  3 Apr 2024 15:59:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="BPnUa9qO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D78D4881E5; Wed,  3 Apr 2024 15:59:21 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8D6C8838F
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 15:59:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1712152759; x=1714744759;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=x6EaKDP8E6Q7esSNcwbRWsyc5onCaAqIWGiEa+AJFkc=;
 b=BPnUa9qOCgRvZj2qxbd9pAlTgpjV02sMI9coTQYOKpvZA2/slLiNgKJtl3HtBII5
 RFIB3aIJfE8aWBxpW5wqLuZCVMsegDwZYKJs/tdGvW4zRETkluNShZHC/3G1WAic
 WG9WlU5Llwxzrh+okgNFVus/QbCtWC4sf/T5mjR33x8=;
X-AuditID: ac14000a-fbefe7000000290d-01-660d60b745b8
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 0D.D4.10509.7B06D066;
 Wed,  3 Apr 2024 15:59:19 +0200 (CEST)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 3 Apr 2024
 15:59:19 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>
CC: <nm@ti.com>, <upstream@lists.phytec.de>, <bb@ti.com>, <vigneshr@ti.com>
Subject: [PATCH v2 3/3] board: phycore-am62x: Extend for better environment
 handling
Date: Wed, 3 Apr 2024 15:59:11 +0200
Message-ID: <20240403135911.1987293-4-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240403135911.1987293-1-w.egorov@phytec.de>
References: <20240403135911.1987293-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLLMWRmVeSWpSXmKPExsWyRpKBR3d7Am+awY+DGhZz3xxgtXjz4yyT
 xdu9newW3e/ULf6f/cDuwOpx9s4ORo/+7hZWj+M3tjMFMEdx2aSk5mSWpRbp2yVwZfx7Vl+w
 QKSi6e1P5gbGTsEuRk4OCQETiW+Xm5i7GLk4hASWMEk8n7WTBcJ5xChxueMFK0gVm4C6xJ0N
 38BsEQEpiZedG4E6ODiYBbwl7k5jAwkLC4RIzJ60mB3EZhFQkZi6/iALiM0rYCnRdOIrM8Qy
 eYmZl76D1XAKWEncvXAKbKQQUM3N352MEPWCEidnPgHrZQaqb946mxnClpA4+OIFM0S9vMSL
 S8tZYGZOO/caan6oxNYv25kmMArNQjJqFpJRs5CMWsDIvIpRKDczOTu1KDNbryCjsiQ1WS8l
 dRMjKMhFGLh2MPbN8TjEyMTBeIhRgoNZSYS324E3TYg3JbGyKrUoP76oNCe1+BCjNAeLkjjv
 6o7gVCGB9MSS1OzU1ILUIpgsEwenVAPjKqnZSW9P73LoOfH4S5yZiKtPXU2t/M/cE4eu9i2T
 ke+qCbL8bledMylhjnLwnouPfq3efnKvxpNtdV2vp+Uczywr26d4w0LH0pFrtdv84M6vWr/i
 p3TmHpxf0dZ75muvfdT7gvNbD256OOnjuqw2s+mTvNs+L9M/d2zfqwncuqtapjTe84i5pcRS
 nJFoqMVcVJwIANRE/fJgAgAA
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

Select environment location based on the device we boot from.
Also, introduce a "boot" variable that represents the current boot
device and can be used by scripts.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 board/phytec/phycore_am62x/phycore-am62x.c | 64 ++++++++++++++++++++++
 configs/phycore_am62x_a53_defconfig        |  1 +
 2 files changed, 65 insertions(+)

diff --git a/board/phytec/phycore_am62x/phycore-am62x.c b/board/phytec/phycore_am62x/phycore-am62x.c
index 91a24018c40..618b4c370d1 100644
--- a/board/phytec/phycore_am62x/phycore-am62x.c
+++ b/board/phytec/phycore_am62x/phycore-am62x.c
@@ -57,3 +57,67 @@ void spl_board_init(void)
 	       MCU_CTRL_DEVICE_CLKOUT_32K_CTRL);
 }
 #endif
+
+#if IS_ENABLED(CONFIG_ENV_IS_IN_FAT) || IS_ENABLED(CONFIG_ENV_IS_IN_MMC)
+int mmc_get_env_dev(void)
+{
+	u32 boot_device = get_boot_device();
+
+	switch (boot_device) {
+	case BOOT_DEVICE_MMC1:
+		return 0;
+	case BOOT_DEVICE_MMC2:
+		return 1;
+	};
+
+	return CONFIG_SYS_MMC_ENV_DEV;
+}
+#endif
+
+enum env_location env_get_location(enum env_operation op, int prio)
+{
+	u32 boot_device = get_boot_device();
+
+	if (prio)
+		return ENVL_UNKNOWN;
+
+	switch (boot_device) {
+	case BOOT_DEVICE_MMC1:
+	case BOOT_DEVICE_MMC2:
+		if (CONFIG_IS_ENABLED(ENV_IS_IN_FAT))
+			return ENVL_FAT;
+		if (CONFIG_IS_ENABLED(ENV_IS_IN_MMC))
+			return ENVL_MMC;
+	case BOOT_DEVICE_SPI:
+		if (CONFIG_IS_ENABLED(ENV_IS_IN_SPI_FLASH))
+			return ENVL_SPI_FLASH;
+	default:
+		return ENVL_NOWHERE;
+	};
+}
+
+#if IS_ENABLED(CONFIG_BOARD_LATE_INIT)
+int board_late_init(void)
+{
+	u32 boot_device = get_boot_device();
+
+	switch (boot_device) {
+	case BOOT_DEVICE_MMC1:
+		env_set_ulong("mmcdev", 0);
+		env_set("boot", "mmc");
+		break;
+	case BOOT_DEVICE_MMC2:
+		env_set_ulong("mmcdev", 1);
+		env_set("boot", "mmc");
+		break;
+	case BOOT_DEVICE_SPI:
+		env_set("boot", "spi");
+		break;
+	case BOOT_DEVICE_ETHERNET:
+		env_set("boot", "net");
+		break;
+	};
+
+	return 0;
+}
+#endif
diff --git a/configs/phycore_am62x_a53_defconfig b/configs/phycore_am62x_a53_defconfig
index ef6d08591a2..8e6f1786d81 100644
--- a/configs/phycore_am62x_a53_defconfig
+++ b/configs/phycore_am62x_a53_defconfig
@@ -34,6 +34,7 @@ CONFIG_BOOTSTD_FULL=y
 CONFIG_SYS_BOOTM_LEN=0x800000
 CONFIG_BOOTCOMMAND="run mmcboot; bootflow scan -lb"
 CONFIG_DEFAULT_FDT_FILE="oftree"
+CONFIG_BOARD_LATE_INIT=y
 CONFIG_SPL_MAX_SIZE=0x58000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x80c80000
-- 
2.34.1

