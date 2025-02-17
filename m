Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB241C021A9
	for <u-boot@archiver.kernel.org>; Mon, 17 Feb 2025 13:28:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EEE380F0B;
	Mon, 17 Feb 2025 14:28:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="UdZ6sBqX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C99580C7E; Mon, 17 Feb 2025 11:57:37 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D2CD80F5F
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 11:57:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j-keerthy@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51HAvVm7507833
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Feb 2025 04:57:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1739789851;
 bh=Qrj5CC+RI37wf/dpdTF4gURa7E4+McNbZAd1/algolo=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=UdZ6sBqXPcHEBURGYNmSh5bsEFUZa58p7yQbZ3XwByOOKcgnimEMuOQbhexm9tiXr
 UslFHUc1yz3Grh1GPukQGRT28o16xdiVW2CRCzHh0elpgkGJsMEC3ujZNSkcYkFgUX
 gv4wnAr0mKolP7/HB8JDiWCxrRoPYt+p0p9WWaxs=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51HAvVV4009216
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 17 Feb 2025 04:57:31 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 17
 Feb 2025 04:57:31 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 17 Feb 2025 04:57:31 -0600
Received: from ubuntu.myguest.virtualbox.org ([10.249.128.48])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51HAvPXl071781;
 Mon, 17 Feb 2025 04:57:29 -0600
From: Keerthy <j-keerthy@ti.com>
To: <trini@konsulko.com>, <vigneshr@ti.com>, <bb@ti.com>, <sjg@chromium.org>
CC: <j-keerthy@ti.com>, <u-kumar1@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH 1/2] arm: mach-k3: j722s: Initialize MCU & MAIN Domain ESMs
Date: Mon, 17 Feb 2025 16:27:17 +0530
Message-ID: <20250217105718.3109-2-j-keerthy@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250217105718.3109-1-j-keerthy@ti.com>
References: <20250217105718.3109-1-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-Mailman-Approved-At: Mon, 17 Feb 2025 14:28:17 +0100
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

Initialize MCU & MAIN Domain ESMs as a prerequisite to enable
watchdog reset functionality. The ESM aka error signalling module
is primarily responsible for sensing the watchdog reset event.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/mach-k3/j722s/j722s_init.c | 32 +++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/mach-k3/j722s/j722s_init.c b/arch/arm/mach-k3/j722s/j722s_init.c
index f8c5c2a5edc..af211377e7c 100644
--- a/arch/arm/mach-k3/j722s/j722s_init.c
+++ b/arch/arm/mach-k3/j722s/j722s_init.c
@@ -27,6 +27,9 @@ struct fwl_data cbass_main_fwls[] = {
 u32 bootindex __section(".data");
 static struct rom_extended_boot_data bootdata __section(".data");
 
+#define CTRLMMR_MCU_RST_CTRL	(MCU_CTRL_MMR0_BASE + 0x18170)
+#define RST_CTRL_ESM_ERROR_RST_EN_Z_MASK  (~BIT(17))
+
 static void store_boot_info_from_rom(void)
 {
 	bootindex = *(u32 *)(CONFIG_SYS_K3_BOOT_PARAM_TABLE_INDEX);
@@ -161,11 +164,40 @@ static void k3_mem_init(void)
 	}
 }
 
+static __maybe_unused void enable_mcu_esm_reset(void)
+{
+	/* Set CTRLMMR_MCU_RST_CTRL:MCU_ESM_ERROR_RST_EN_Z  to '0' (low active) */
+	u32 stat = readl(CTRLMMR_MCU_RST_CTRL);
+
+	stat &= RST_CTRL_ESM_ERROR_RST_EN_Z_MASK;
+	writel(stat, CTRLMMR_MCU_RST_CTRL);
+}
+
 void board_init_f(ulong dummy)
 {
+	int ret;
+	struct udevice *dev;
+
 	k3_spl_init();
 	k3_mem_init();
 	setup_qos();
+
+	if (IS_ENABLED(CONFIG_ESM_K3)) {
+		/* Probe/configure ESM0 */
+		ret = uclass_get_device_by_name(UCLASS_MISC, "esm@420000", &dev);
+		if (ret) {
+			printf("esm main init failed: %d\n", ret);
+			return;
+		}
+
+		/* Probe/configure MCUESM */
+		ret = uclass_get_device_by_name(UCLASS_MISC, "esm@4100000", &dev);
+		if (ret) {
+			printf("esm mcu init failed: %d\n", ret);
+			return;
+		}
+		enable_mcu_esm_reset();
+	}
 }
 
 static u32 __get_backup_bootmedia(u32 devstat)
-- 
2.17.1

