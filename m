Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75468C369DC
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 10:43:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 500F682B33;
	Wed, 30 Apr 2025 12:43:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="pGCmrKyR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99CC082B33; Wed, 30 Apr 2025 12:43:04 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E279C82B78
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 12:43:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-patra@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53UAgxBK3362538
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Apr 2025 05:42:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1746009779;
 bh=MWguxrO1i/yZCZ4SICD5Nkto1vFqv/kU9PrOCVgA5fo=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=pGCmrKyR1C1+IUreoJ3NK8OTXiIbcvSYPz7zyOjwgA3TOJ2ef1RijnFMlTDMxKGs1
 cUblAuN1M9rPR2VQAIoWp+ZP3GgSHNQZhgTUgZdC2V8meeQHKlqHStiNSGgc/fKEkv
 Zdj/a3q2b07uywWDzvdmyBoJpdpE7W+WOFmyJlmk=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53UAgxoN007710
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 30 Apr 2025 05:42:59 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 30
 Apr 2025 05:42:58 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 30 Apr 2025 05:42:58 -0500
Received: from aparna-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (aparna-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.139])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53UAgcZr053918;
 Wed, 30 Apr 2025 05:42:56 -0500
From: Aparna Patra <a-patra@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <afd@ti.com>
CC: <d-gole@ti.com>, <vigneshr@ti.com>, <n-francis@ti.com>, <nm@ti.com>,
 <bb@ti.com>, Aparna Patra <a-patra@ti.com>
Subject: [PATCH 3/3] arm: mach-k3: am62a: Fixup a53 max cpu frequency by
 speed-grade
Date: Wed, 30 Apr 2025 16:12:36 +0530
Message-ID: <20250430104236.2611089-4-a-patra@ti.com>
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

AM62A SoC has multiple speed grades. Add function to delete
non-relevant CPU frequency nodes, based on the information
retrieved from hardware registers. Fastest grade's maximum
frequency also depends on PMIC voltage,hence to simplify
implementation use the smaller value.

Signed-off-by: Aparna Patra <a-patra@ti.com>
---
 arch/arm/mach-k3/am62ax/am62a7_fdt.c          | 14 +++++++++++
 .../arm/mach-k3/include/mach/am62a_hardware.h | 23 +++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/arch/arm/mach-k3/am62ax/am62a7_fdt.c b/arch/arm/mach-k3/am62ax/am62a7_fdt.c
index 40833ca392..9526c5b255 100644
--- a/arch/arm/mach-k3/am62ax/am62a7_fdt.c
+++ b/arch/arm/mach-k3/am62ax/am62a7_fdt.c
@@ -81,6 +81,19 @@ static void fdt_fixup_thermal_zone_nodes_am62a(void *blob, int maxc)
 	}
 }
 
+static void fdt_fixup_cpu_freq_nodes_am62a(void *blob, int max_freq)
+{
+	if (max_freq >= 1250000000)
+		return;
+	if (max_freq <= 1000000000) {
+		fdt_del_node_path(blob, "/opp-table/opp-1250000000");
+		fdt_del_node_path(blob, "/opp-table/opp-1400000000");
+	}
+	if (max_freq <= 800000000) {
+		fdt_del_node_path(blob, "/opp-table/opp-1000000000");
+	}
+}
+
 int ft_system_setup(void *blob, struct bd_info *bd)
 {
 	fdt_fixup_cores_wdt_nodes_am62a(blob, k3_get_core_nr());
@@ -88,6 +101,7 @@ int ft_system_setup(void *blob, struct bd_info *bd)
 	fdt_fixup_video_codec_nodes_am62a(blob, k3_has_video_codec());
 	fdt_fixup_canfd_nodes_am62a(blob, k3_has_canfd());
 	fdt_fixup_thermal_zone_nodes_am62a(blob, k3_get_max_temp());
+	fdt_fixup_cpu_freq_nodes_am62a(blob, k3_get_a53_max_frequency());
 	fdt_fixup_reserved(blob, "tfa", CONFIG_K3_ATF_LOAD_ADDR, 0x80000);
 	fdt_fixup_reserved(blob, "optee", CONFIG_K3_OPTEE_LOAD_ADDR, 0x1800000);
 
diff --git a/arch/arm/mach-k3/include/mach/am62a_hardware.h b/arch/arm/mach-k3/include/mach/am62a_hardware.h
index 0ec04a72f5..64e4a379fa 100644
--- a/arch/arm/mach-k3/include/mach/am62a_hardware.h
+++ b/arch/arm/mach-k3/include/mach/am62a_hardware.h
@@ -28,6 +28,8 @@
 #define JTAG_DEV_VIDEO_CODEC_SHIFT			14
 #define JTAG_DEV_DSS_MASK			GENMASK(16, 13)
 #define JTAG_DEV_DSS_SHIFT			13
+#define JTAG_DEV_SPEED_MASK			GENMASK(10, 6)
+#define JTAG_DEV_SPEED_SHIFT			6
 #define JTAG_DEV_TEMP_MASK			GENMASK(5, 3)
 #define JTAG_DEV_TEMP_SHIFT			3
 
@@ -144,6 +146,27 @@ static inline int k3_get_max_temp(void)
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
+	if (k3_get_speed_grade() <= 'N')
+		return 800000000;
+
+	else if (k3_get_speed_grade() <= 'R')
+		return 1000000000;
+
+	else
+		return 1250000000;
+}
+
 #if defined(CONFIG_SYS_K3_SPL_ATF) && !defined(__ASSEMBLY__)
 
 static const u32 put_device_ids[] = {};
-- 
2.34.1

