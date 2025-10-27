Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1FF0CCF9EA
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 13:00:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BEAA838BB;
	Mon, 27 Oct 2025 14:00:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="uL+aBgR1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C35E83885; Mon, 27 Oct 2025 14:00:19 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56D3283700
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 14:00:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59RD0DgJ2412477;
 Mon, 27 Oct 2025 08:00:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1761570013;
 bh=809ssjUS0VNpbxzWq3d5KFjUgw4h0R3sHxn31nefYec=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=uL+aBgR1Pc8EqKfKoDtYDeYTAyFvnYRyvuKeZax3OYrok9kJQqdUgGzl+bRXK91BU
 qCtsU9w8s36lsh+67+pk2JXqvf7TVqXVoEkV5QB8nYNyNiS7tBmMKupwpOnCtE6EgW
 ZIB3KOyvuo3uLWmXhup1kBX0nvrLbCXi1rgI5TOY=
Received: from DLEE207.ent.ti.com (dlee207.ent.ti.com [157.170.170.95])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59RD0C051241023
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 27 Oct 2025 08:00:12 -0500
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Oct
 2025 08:00:12 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 27 Oct 2025 08:00:12 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59RD0BYV680261;
 Mon, 27 Oct 2025 08:00:12 -0500
From: Anshul Dalal <anshuld@ti.com>
To: 
CC: Anshul Dalal <anshuld@ti.com>, <afd@ti.com>, <b-liu@ti.com>, <bb@ti.com>, 
 <m-chawdhry@ti.com>, <n-francis@ti.com>, <nm@ti.com>,
 <trini@konsulko.com>, <u-boot@lists.denx.de>, <vigneshr@ti.com>
Subject: [PATCH v8 3/8] mach-k3: common: enable falcon mode from R5 SPL
Date: Mon, 27 Oct 2025 18:29:58 +0530
Message-ID: <20251027130004.2156121-4-anshuld@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027130004.2156121-1-anshuld@ti.com>
References: <20251027130004.2156121-1-anshuld@ti.com>
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

We use the spl_board_prepare_for_boot hook to call k3_r5_falcon_prep
which is ran after tispl is loaded but before jump_to_image.

In k3_r5_falcon_prep, we find the boot media and load the kernel FIT
just as standard secure falcon mode (since spl_start_uboot returns 0
now). Once the kernel and args are loaded.

Now when the flow goes to jump_to_image, we do the regular pre-jump
procedure and jump to TFA which jumps to the kernel directly since we
have already loaded the kernel and dtb at their respective addresses
(PRELOADED_BL33_BASE and K3_HW_CONFIG_BASE).

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 arch/arm/mach-k3/common.c    |  8 +++++++
 arch/arm/mach-k3/common.h    |  4 ++++
 arch/arm/mach-k3/r5/common.c | 45 ++++++++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+)

diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index 04a0f232d84..c446d1c47fd 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -360,6 +360,14 @@ void spl_perform_arch_fixups(struct spl_image_info *spl_image)
 
 void spl_board_prepare_for_boot(void)
 {
+#if IS_ENABLED(CONFIG_SPL_OS_BOOT_SECURE) && !IS_ENABLED(CONFIG_ARM64)
+	int ret;
+
+	ret = k3_r5_falcon_prep();
+	if (ret)
+		panic("%s: Failed to boot in falcon mode: %d\n", __func__, ret);
+#endif /* falcon mode on R5 SPL */
+
 #if !(defined(CONFIG_SYS_ICACHE_OFF) && defined(CONFIG_SYS_DCACHE_OFF))
 	dcache_disable();
 #endif
diff --git a/arch/arm/mach-k3/common.h b/arch/arm/mach-k3/common.h
index 52d3faaab5c..5807d358464 100644
--- a/arch/arm/mach-k3/common.h
+++ b/arch/arm/mach-k3/common.h
@@ -52,6 +52,10 @@ void do_board_detect(void);
 void ti_secure_image_check_binary(void **p_image, size_t *p_size);
 int shutdown_mcu_r5_core1(void);
 
+#if IS_ENABLED(CONFIG_SPL_OS_BOOT_SECURE) && !IS_ENABLED(CONFIG_ARM64)
+int k3_r5_falcon_bootmode(void);
+#endif
+
 #if (IS_ENABLED(CONFIG_K3_QOS))
 void setup_qos(void);
 #else
diff --git a/arch/arm/mach-k3/r5/common.c b/arch/arm/mach-k3/r5/common.c
index 6269b33f66b..439dd92ef54 100644
--- a/arch/arm/mach-k3/r5/common.c
+++ b/arch/arm/mach-k3/r5/common.c
@@ -376,3 +376,48 @@ void board_fit_image_post_process(const void *fit, int node, void **p_image,
 	}
 }
 #endif
+
+#ifdef CONFIG_SPL_OS_BOOT_SECURE
+
+static bool tifalcon_loaded;
+
+int spl_start_uboot(void)
+{
+	/* If tifalcon.bin is not loaded, proceed to regular boot */
+	if (!tifalcon_loaded)
+		return 1;
+
+	/* Boot to linux on R5 SPL with tifalcon.bin loaded */
+		return 0;
+}
+
+int k3_r5_falcon_prep(void)
+{
+	struct spl_image_loader *loader, *drv;
+	struct spl_image_info kernel_image;
+	struct spl_boot_device bootdev;
+	int ret = -ENXIO, n_ents;
+
+	tifalcon_loaded = true;
+	memset(&kernel_image, '\0', sizeof(kernel_image));
+	drv = ll_entry_start(struct spl_image_loader, spl_image_loader);
+	n_ents = ll_entry_count(struct spl_image_loader, spl_image_loader);
+	bootdev.boot_device = spl_boot_device();
+
+	for (loader = drv; loader != drv + n_ents; loader++) {
+		if (bootdev.boot_device != loader->boot_device)
+			continue;
+		if (loader) {
+			printf("Loading falcon payload from %s\n",
+			       spl_loader_name(loader));
+			ret = loader->load_image(&kernel_image, &bootdev);
+			if (ret)
+				continue;
+
+			return 0;
+		}
+	}
+
+	return ret;
+}
+#endif
-- 
2.51.0

