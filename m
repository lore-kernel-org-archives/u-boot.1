Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16926C282D0
	for <u-boot@archiver.kernel.org>; Fri,  7 Mar 2025 08:01:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B834810EB;
	Fri,  7 Mar 2025 09:01:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="G1KkhIPn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F0CF810EB; Fri,  7 Mar 2025 09:01:47 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F270980F0B
 for <u-boot@lists.denx.de>; Fri,  7 Mar 2025 09:01:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52781hkq202625
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 7 Mar 2025 02:01:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1741334503;
 bh=hKavpUTopJcQ3xhqFe1pu8I4gGzn2t/XPkrEl7k0S/E=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=G1KkhIPnoCSuSvWYiPp19J9DgCNocpDyhNrvg26fWjVownuepf82Z8lJgfrpXhJ5X
 zbv9KgJpfWkF1EbjFhcTd3zEgwibXOd+Dx/T6m6clT/hOkmVreXIN32DbIjYaORi97
 Xft9fMjrDnTdgS5Zf/Odmetq8MJFdrOrwiML2cBA=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52781h46027040
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 7 Mar 2025 02:01:43 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 7
 Mar 2025 02:01:42 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 7 Mar 2025 02:01:42 -0600
Received: from localhost (a0543016.dhcp.ti.com [172.24.227.86])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52781gdJ096676;
 Fri, 7 Mar 2025 02:01:42 -0600
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>
Subject: [PATCH 10/10] mach-k3: common: add falcon support for 62[axp]
Date: Fri, 7 Mar 2025 13:29:52 +0530
Message-ID: <20250307075954.2575030-1-anshuld@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307075541.2571104-1-anshuld@ti.com>
References: <20250307075541.2571104-1-anshuld@ti.com>
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

We use the spl_board_prepare_for_boot hook to call k3_falcon_prep which
is ran after tispl is loaded but before jump_to_image.

In here, we find the boot media and load the image just as std falcon
flow (since spl_start_uboot returns 0 now). Once the kernel and args are
loaded, we perform fdt fixups on the fdt accompanying the kernel (if
loaded as FIT) or the loaded up args and return.

Now when the flow goes to jump_to_image, we do the regular pre-jump
procedure and jump to ATF which jumps to the kernel directly since we
have already loaded the kernel and dtb at their respective addresses
(PRELOADED_BL33_BASE and K3_HW_CONFIG_BASE).

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 arch/arm/mach-k3/common.c | 105 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index fa8cd93d664..6e41aa8318b 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -263,8 +263,113 @@ static __maybe_unused void k3_dma_remove(void)
 		pr_warn("DMA Device not found (err=%d)\n", rc);
 }
 
+#if IS_ENABLED(CONFIG_SPL_OS_BOOT) && !IS_ENABLED(CONFIG_ARM64)
+static bool tispl_loaded;
+
+int spl_start_uboot(void)
+{
+	if (!tispl_loaded)
+		return 1;
+	return 0;
+}
+
+static int k3_falcon_fdt_fixup(void *fdt)
+{
+	struct disk_partition info;
+	struct blk_desc *dev_desc;
+	char bootmedia[32];
+	char bootpart[32];
+	char str[256];
+	int ret;
+
+	strcpy(bootmedia, env_get("boot"));
+	strcpy(bootpart, env_get("bootpart"));
+	ret = blk_get_device_part_str(bootmedia, bootpart, &dev_desc, &info, 0);
+	if (ret < 0)
+		printf("Failed to get part details for %s %s [%d]\n", bootmedia,
+		       bootpart, ret);
+	sprintf(str, "console=%s root=PARTUUID=%s rootwait", env_get("console"),
+		info.uuid);
+	ret = fdt_find_and_setprop(fdt, "/chosen", "bootargs", str,
+				   strlen(str) + 1, 1);
+	if (ret) {
+		printf("Could not set bootargs: %s\n", fdt_strerror(ret));
+		return ret;
+	}
+	debug("Set bootargs to: %s\n", str);
+
+#ifdef CONFIG_OF_BOARD_SETUP
+	ret = ft_board_setup(fdt, gd->bd);
+	if (ret) {
+		printf("Failed in board fdt fixups: %s\n", fdt_strerror(ret));
+		return ret;
+	}
+#endif
+
+#ifdef CONFIG_OF_SYSTEM_SETUP
+	ret = ft_system_setup(fdt, gd->bd);
+	if (ret) {
+		printf("Failed in system fdt fixups: %s\n", fdt_strerror(ret));
+		return ret;
+	}
+#endif
+
+	return 0;
+}
+
+static int k3_falcon_prep(void)
+{
+	struct spl_image_loader *loader, *drv;
+	struct spl_image_info kernel_image;
+	struct spl_boot_device bootdev;
+	int ret = -ENXIO, n_ents;
+	void *fdt;
+
+	tispl_loaded = true;
+	memset(&kernel_image, '\0', sizeof(kernel_image));
+	drv = ll_entry_start(struct spl_image_loader, spl_image_loader);
+	n_ents = ll_entry_count(struct spl_image_loader, spl_image_loader);
+	bootdev.boot_device = spl_boot_device();
+	if (bootdev.boot_device == BOOT_DEVICE_SPI) {
+		if (strcmp(env_get("mmcdev"), "1") == 0)
+			bootdev.boot_device = BOOT_DEVICE_MMC;
+		else
+			bootdev.boot_device = BOOT_DEVICE_EMMC;
+	}
+	bootdev.boot_device_name = NULL;
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
+			fdt = spl_image_fdt_addr(&kernel_image);
+			if (!fdt)
+				fdt = (void *)CONFIG_SPL_PAYLOAD_ARGS_ADDR;
+			ret = k3_falcon_fdt_fixup(fdt);
+			if (ret) {
+				printf("Failed performing fdt fixups in falcon flow: [%d]\n",
+				       ret);
+				return ret;
+			}
+			return 0;
+		}
+	}
+
+	return ret;
+}
+#endif
+
 void spl_board_prepare_for_boot(void)
 {
+#if IS_ENABLED(CONFIG_SPL_OS_BOOT) && !IS_ENABLED(CONFIG_ARM64)
+	k3_falcon_prep();
+#endif
 #if !(defined(CONFIG_SYS_ICACHE_OFF) && defined(CONFIG_SYS_DCACHE_OFF))
 	dcache_disable();
 #endif
-- 
2.43.0

