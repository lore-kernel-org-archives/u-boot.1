Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E50E77188
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 12:47:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5597E80317;
	Wed, 18 Dec 2024 13:47:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="FdMA3/dO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 328B38027E; Wed, 18 Dec 2024 10:30:44 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7E9180288
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 10:30:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-patra@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BI9Udgu136648
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Dec 2024 03:30:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1734514239;
 bh=1MtwABCcmqeJlfSkmcMsvuRz064W0i3jEVrZa6KEDAc=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=FdMA3/dODOlbEEvieTi5axESsXGnoq4zmytZ4WD9VDQHOpL5bumWb0HQVHJwzPvMy
 S5YZs/mam3MbnWXEBd/tLhrLk/2cV9kDIZQE5nOGeYSGu0kv6nKF9ymw+88f7wBUvU
 MK9yhZRO9NflDGM2c1WjL6GUefJYyHRMpjcMaJNU=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BI9Ud9M064903
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 18 Dec 2024 03:30:39 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 18
 Dec 2024 03:30:38 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 18 Dec 2024 03:30:38 -0600
Received: from aparna-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (aparna-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.31])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BI9USGG060685;
 Wed, 18 Dec 2024 03:30:36 -0600
From: Aparna Patra <a-patra@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <bb@ti.com>
CC: <d-gole@ti.com>, <vigneshr@ti.com>, <n-francis@ti.com>, <nm@ti.com>,
 Aparna Patra <a-patra@ti.com>
Subject: [PATCH 2/3] arm: mach-k3: am62p: Fixup thermal zone critical points
Date: Wed, 18 Dec 2024 15:00:24 +0530
Message-ID: <20241218093025.45701-3-a-patra@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241218093025.45701-1-a-patra@ti.com>
References: <20241218093025.45701-1-a-patra@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-Mailman-Approved-At: Wed, 18 Dec 2024 13:47:15 +0100
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
 arch/arm/mach-k3/am62px/am62p5_fdt.c          | 37 +++++++++++++++++++
 .../arm/mach-k3/include/mach/am62p_hardware.h | 17 +++++++++
 2 files changed, 54 insertions(+)

diff --git a/arch/arm/mach-k3/am62px/am62p5_fdt.c b/arch/arm/mach-k3/am62px/am62p5_fdt.c
index e88760ea51..96194cebcd 100644
--- a/arch/arm/mach-k3/am62px/am62p5_fdt.c
+++ b/arch/arm/mach-k3/am62px/am62p5_fdt.c
@@ -38,11 +38,48 @@ static void fdt_fixup_canfd_nodes_am62p(void *blob, bool has_canfd)
 	}
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
+static void fdt_fixup_thermal_zone_nodes_am62p(void *blob, int maxc)
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
 	fdt_fixup_cores_wdt_nodes_am62p(blob, k3_get_core_nr());
 	fdt_fixup_video_codec_nodes_am62p(blob, k3_has_video_codec());
 	fdt_fixup_canfd_nodes_am62p(blob, k3_has_canfd());
+	fdt_fixup_thermal_zone_nodes_am62p(blob, k3_get_max_temp());
 	fdt_fixup_reserved(blob, "tfa", CONFIG_K3_ATF_LOAD_ADDR, 0x80000);
 	fdt_fixup_reserved(blob, "optee", CONFIG_K3_OPTEE_LOAD_ADDR, 0x1800000);
 
diff --git a/arch/arm/mach-k3/include/mach/am62p_hardware.h b/arch/arm/mach-k3/include/mach/am62p_hardware.h
index 339562722d..2f1c8517e6 100644
--- a/arch/arm/mach-k3/include/mach/am62p_hardware.h
+++ b/arch/arm/mach-k3/include/mach/am62p_hardware.h
@@ -26,6 +26,12 @@
 #define JTAG_DEV_CANFD_SHIFT			15
 #define JTAG_DEV_VIDEO_CODEC_MASK			BIT(14)
 #define JTAG_DEV_VIDEO_CODEC_SHIFT			14
+#define JTAG_DEV_TEMP_MASK			GENMASK(5, 3)
+#define JTAG_DEV_TEMP_SHIFT			3
+
+#define JTAG_DEV_TEMP_AUTOMOTIVE        0x5
+#define JTAG_DEV_TEMP_EXTENDED_VALUE    105
+#define JTAG_DEV_TEMP_AUTOMOTIVE_VALUE  125
 
 #define CTRLMMR_MAIN_DEVSTAT			(WKUP_CTRL_MMR0_BASE + 0x30)
 #define MAIN_DEVSTAT_PRIMARY_BOOTMODE_MASK	GENMASK(6, 3)
@@ -101,6 +107,17 @@ static inline int k3_has_canfd(void)
 	return (dev_id & JTAG_DEV_CANFD_MASK) >> JTAG_DEV_CANFD_SHIFT;
 }
 
+static inline int k3_get_max_temp(void)
+{
+	u32 dev_id = readl(CTRLMMR_WKUP_JTAG_DEVICE_ID);
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

