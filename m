Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 308C3E77198
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 04:50:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9389C80607;
	Wed,  8 Jan 2025 05:50:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Y9BgJZDd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6ABC6803DC; Wed,  8 Jan 2025 05:50:06 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14E0E805FD
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 05:50:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-patra@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5084o1OA3051527
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Jan 2025 22:50:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1736311801;
 bh=42ertIb+8MmaeEU4IyStPtVtgbpKgS/AL96X+sPGBT0=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=Y9BgJZDdiyXhXzm+kfeZlPrvZdf5UAL9GN4YLWo2geHEP0r/pq9QbOQs7PZOQWF8A
 Ars8n9JpqEI7JE7qs6Eu3p+wDbfhgz5xvnUZj89zQ2KthvZ/juW9A93DWyQOg1p5jn
 4mnx+b+lGR5ap9Ai+9DT9LCO7K1A3zUQBgKOpBak=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 5084o0G3019174
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 7 Jan 2025 22:50:00 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 7
 Jan 2025 22:50:00 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 7 Jan 2025 22:50:00 -0600
Received: from aparna-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (aparna-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.31])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5084ngo1130961;
 Tue, 7 Jan 2025 22:49:58 -0600
From: Aparna Patra <a-patra@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <bb@ti.com>
CC: <d-gole@ti.com>, <vigneshr@ti.com>, <n-francis@ti.com>, <nm@ti.com>,
 Aparna Patra <a-patra@ti.com>
Subject: [PATCH v2 3/4] arm: mach-k3: am62p: Fixup a53 max cpu frequency by
 speed-grade
Date: Wed, 8 Jan 2025 10:19:38 +0530
Message-ID: <20250108044939.392785-4-a-patra@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250108044939.392785-1-a-patra@ti.com>
References: <20250108044939.392785-1-a-patra@ti.com>
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

AM62P SoC has multiple speed grades. Add function to delete
non-relevant CPU frequency nodes, based on the information
retrieved from hardware registers. Fastest grade's maximum
frequency also depends on PMIC voltage, hence to simplify
implementation use the smaller value.

Signed-off-by: Aparna Patra <a-patra@ti.com>
---
 arch/arm/mach-k3/am62px/am62p5_fdt.c          | 12 ++++++++++++
 .../arm/mach-k3/include/mach/am62p_hardware.h | 19 +++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/arch/arm/mach-k3/am62px/am62p5_fdt.c b/arch/arm/mach-k3/am62px/am62p5_fdt.c
index 96194cebcd..2c40fa5a59 100644
--- a/arch/arm/mach-k3/am62px/am62p5_fdt.c
+++ b/arch/arm/mach-k3/am62px/am62p5_fdt.c
@@ -74,12 +74,24 @@ static void fdt_fixup_thermal_zone_nodes_am62p(void *blob, int maxc)
 	}
 }
 
+static void fdt_fixup_cpu_freq_nodes_am62p(void *blob, int max_freq)
+{
+	if (max_freq >= 1250000000)
+		return;
+
+	if (max_freq <= 1000000000) {
+		fdt_del_node_path(blob, "/opp-table/opp-1250000000");
+		fdt_del_node_path(blob, "/opp-table/opp-1400000000");
+	}
+}
+
 int ft_system_setup(void *blob, struct bd_info *bd)
 {
 	fdt_fixup_cores_wdt_nodes_am62p(blob, k3_get_core_nr());
 	fdt_fixup_video_codec_nodes_am62p(blob, k3_has_video_codec());
 	fdt_fixup_canfd_nodes_am62p(blob, k3_has_canfd());
 	fdt_fixup_thermal_zone_nodes_am62p(blob, k3_get_max_temp());
+	fdt_fixup_cpu_freq_nodes_am62p(blob, k3_get_a53_max_frequency());
 	fdt_fixup_reserved(blob, "tfa", CONFIG_K3_ATF_LOAD_ADDR, 0x80000);
 	fdt_fixup_reserved(blob, "optee", CONFIG_K3_OPTEE_LOAD_ADDR, 0x1800000);
 
diff --git a/arch/arm/mach-k3/include/mach/am62p_hardware.h b/arch/arm/mach-k3/include/mach/am62p_hardware.h
index 2f1c8517e6..95af5c5c54 100644
--- a/arch/arm/mach-k3/include/mach/am62p_hardware.h
+++ b/arch/arm/mach-k3/include/mach/am62p_hardware.h
@@ -26,6 +26,8 @@
 #define JTAG_DEV_CANFD_SHIFT			15
 #define JTAG_DEV_VIDEO_CODEC_MASK			BIT(14)
 #define JTAG_DEV_VIDEO_CODEC_SHIFT			14
+#define JTAG_DEV_SPEED_MASK			GENMASK(10, 6)
+#define JTAG_DEV_SPEED_SHIFT			6
 #define JTAG_DEV_TEMP_MASK			GENMASK(5, 3)
 #define JTAG_DEV_TEMP_SHIFT			3
 
@@ -118,6 +120,23 @@ static inline int k3_get_max_temp(void)
 		return JTAG_DEV_TEMP_EXTENDED_VALUE;
 }
 
+static inline char k3_get_speed_grade(void)
+{
+	u32 dev_id = readl(CTRLMMR_WKUP_JTAG_DEVICE_ID);
+	u32 speed_grade = (dev_id & JTAG_DEV_SPEED_MASK) >>
+			   JTAG_DEV_SPEED_SHIFT;
+
+	return 'A' - 1 + speed_grade;
+}
+
+static inline int k3_get_a53_max_frequency(void)
+{
+	if (k3_get_speed_grade() == 'O')
+		return 1000000000;
+	else
+		return 1250000000;
+}
+
 #if defined(CONFIG_SYS_K3_SPL_ATF) && !defined(__ASSEMBLY__)
 
 static const u32 put_device_ids[] = {};
-- 
2.34.1

