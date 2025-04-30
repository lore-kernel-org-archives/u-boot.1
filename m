Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8A6CC369DC
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 10:43:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03C5282B37;
	Wed, 30 Apr 2025 12:43:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="YsaBHc1p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DB178210F; Wed, 30 Apr 2025 12:42:59 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7416D82B3D
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 12:42:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-patra@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53UAgsa23362530
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Apr 2025 05:42:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1746009774;
 bh=irZG+CLY62aJ5CQcAADPN4jHIU1P2UhEZGAPlng8Zi4=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=YsaBHc1pGGBR9oeq2nm4u5oNAtqTUS8h5w4B3c8QD9RJxGDyNcyCRyl0GsEoU5FOS
 TR5ijcrceJafmYEWBxm70zlpyMeXcjfe6WKMSJyiA7DiWRZpMUuFOW0A2OKKQRkwcl
 +Sp6ywLsjVMpxGv4xfiOgMVfEGWVsRJuvWc/mLfY=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53UAgs1C041922
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 30 Apr 2025 05:42:54 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 30
 Apr 2025 05:42:54 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 30 Apr 2025 05:42:54 -0500
Received: from aparna-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (aparna-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.139])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53UAgcZq053918;
 Wed, 30 Apr 2025 05:42:51 -0500
From: Aparna Patra <a-patra@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <afd@ti.com>
CC: <d-gole@ti.com>, <vigneshr@ti.com>, <n-francis@ti.com>, <nm@ti.com>,
 <bb@ti.com>, Aparna Patra <a-patra@ti.com>
Subject: [PATCH 2/3] arm: mach-k3: am62a: Fixup thermal zone critical points
Date: Wed, 30 Apr 2025 16:12:35 +0530
Message-ID: <20250430104236.2611089-3-a-patra@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250430104236.2611089-1-a-patra@ti.com>
References: <20250430104236.2611089-1-a-patra@ti.com>
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

Read the max temperature for the SoC temperature grade from the hardware
and modify the critical trip nodes on each thermal zone of FDT at
runtime so they are correct with the hardware value for its grade.

Signed-off-by: Aparna Patra <a-patra@ti.com>
---
 arch/arm/mach-k3/am62ax/am62a7_fdt.c          | 37 +++++++++++++++++++
 .../arm/mach-k3/include/mach/am62a_hardware.h | 18 +++++++++
 2 files changed, 55 insertions(+)

diff --git a/arch/arm/mach-k3/am62ax/am62a7_fdt.c b/arch/arm/mach-k3/am62ax/am62a7_fdt.c
index 56fd658202..40833ca392 100644
--- a/arch/arm/mach-k3/am62ax/am62a7_fdt.c
+++ b/arch/arm/mach-k3/am62ax/am62a7_fdt.c
@@ -45,12 +45,49 @@ static void fdt_fixup_canfd_nodes_am62a(void *blob, bool has_canfd)
 		fdt_del_node_path(blob, "/bus@f0000/can@20701000");
 }
 
+static int fdt_fixup_trips_node(void *blob, int zoneoffset, int maxc)
+{
+	int node, trip;
+
+	node = fdt_subnode_offset(blob, zoneoffset, "trips");
+	if (node < 0)
+		return -1;
+
+	fdt_for_each_subnode(trip, blob, node) {
+		const char *type = fdt_getprop(blob, trip, "type", NULL);
+
+		if (!type || (strncmp(type, "critical", 8) != 0))
+			continue;
+
+		if (fdt_setprop_u32(blob, trip, "temperature", 1000 * maxc) < 0)
+			return -1;
+	}
+
+	return 0;
+}
+
+static void fdt_fixup_thermal_zone_nodes_am62a(void *blob, int maxc)
+{
+	int node, zone;
+
+	node = fdt_path_offset(blob, "/thermal-zones");
+	if (node < 0)
+		return;
+
+	fdt_for_each_subnode(zone, blob, node) {
+		if (fdt_fixup_trips_node(blob, zone, maxc) < 0)
+			printf("Failed to set temperature in %s critical trips\n",
+			       fdt_get_name(blob, zone, NULL));
+	}
+}
+
 int ft_system_setup(void *blob, struct bd_info *bd)
 {
 	fdt_fixup_cores_wdt_nodes_am62a(blob, k3_get_core_nr());
 	fdt_fixup_dss_nodes_am62a(blob, k3_has_dss());
 	fdt_fixup_video_codec_nodes_am62a(blob, k3_has_video_codec());
 	fdt_fixup_canfd_nodes_am62a(blob, k3_has_canfd());
+	fdt_fixup_thermal_zone_nodes_am62a(blob, k3_get_max_temp());
 	fdt_fixup_reserved(blob, "tfa", CONFIG_K3_ATF_LOAD_ADDR, 0x80000);
 	fdt_fixup_reserved(blob, "optee", CONFIG_K3_OPTEE_LOAD_ADDR, 0x1800000);
 
diff --git a/arch/arm/mach-k3/include/mach/am62a_hardware.h b/arch/arm/mach-k3/include/mach/am62a_hardware.h
index ab281129d7..0ec04a72f5 100644
--- a/arch/arm/mach-k3/include/mach/am62a_hardware.h
+++ b/arch/arm/mach-k3/include/mach/am62a_hardware.h
@@ -28,8 +28,14 @@
 #define JTAG_DEV_VIDEO_CODEC_SHIFT			14
 #define JTAG_DEV_DSS_MASK			GENMASK(16, 13)
 #define JTAG_DEV_DSS_SHIFT			13
+#define JTAG_DEV_TEMP_MASK			GENMASK(5, 3)
+#define JTAG_DEV_TEMP_SHIFT			3
 
 #define JTAG_DEV_HAS_DSS_VALUE			0xD
+#define JTAG_DEV_TEMP_AUTOMOTIVE        0x5
+
+#define JTAG_DEV_TEMP_EXTENDED_VALUE    105
+#define JTAG_DEV_TEMP_AUTOMOTIVE_VALUE  125
 
 #define CTRLMMR_MAIN_DEVSTAT			(WKUP_CTRL_MMR0_BASE + 0x30)
 #define MAIN_DEVSTAT_PRIMARY_BOOTMODE_MASK	GENMASK(6, 3)
@@ -126,6 +132,18 @@ static inline int k3_has_canfd(void)
 	return (dev_id & JTAG_DEV_CANFD_MASK) >> JTAG_DEV_CANFD_SHIFT;
 }
 
+static inline int k3_get_max_temp(void)
+{
+	u32 dev_id = readl(CTRLMMR_WKUP_JTAG_DEVICE_ID);
+
+	u32 dev_temp = (dev_id & JTAG_DEV_TEMP_MASK) >> JTAG_DEV_TEMP_SHIFT;
+
+	if (dev_temp == JTAG_DEV_TEMP_AUTOMOTIVE)
+		return JTAG_DEV_TEMP_AUTOMOTIVE_VALUE;
+	else
+		return JTAG_DEV_TEMP_EXTENDED_VALUE;
+}
+
 #if defined(CONFIG_SYS_K3_SPL_ATF) && !defined(__ASSEMBLY__)
 
 static const u32 put_device_ids[] = {};
-- 
2.34.1

