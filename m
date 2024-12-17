Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0792BE77184
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 11:08:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D985E8029E;
	Tue, 17 Dec 2024 12:08:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="H8IRBYeR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 340448029E; Tue, 17 Dec 2024 12:08:03 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4E94801CF
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 12:08:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BHB7tG93466760
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Dec 2024 05:07:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1734433675;
 bh=5jcqt89UA7vJyZzdGjV2TbABqRwAm5lwfB39hZsGOEE=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=H8IRBYeRjQ5Z/+Ce87dCbBbMyiE6TNxa46HmyOIhfGU6UcFNGs4GYmlZ01tOB+EaT
 wh/fkrHZlpTfEG/8H4yzGj/W/xDI/TNdYymUxhQZtme1zGNLKFhP5mizU62Rte1i7/
 C1Q5Wi9uT/zJlzVFxDOM4QP6I1JHb1k4pjVsMJEQ=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BHB7tcG127404
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 17 Dec 2024 05:07:55 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 17
 Dec 2024 05:07:54 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 17 Dec 2024 05:07:54 -0600
Received: from [127.0.1.1] (uda0497581-hp.dhcp.ti.com [172.24.227.160])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BHB7Wbd013855;
 Tue, 17 Dec 2024 05:07:50 -0600
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Tue, 17 Dec 2024 16:37:21 +0530
Subject: [PATCH RFC 4/8] soc: Add information to identify the J742S2 SoC family
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241217-b4-upstream-j742s2-v1-4-13a6a127b344@ti.com>
References: <20241217-b4-upstream-j742s2-v1-0-13a6a127b344@ti.com>
In-Reply-To: <20241217-b4-upstream-j742s2-v1-0-13a6a127b344@ti.com>
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, Lukasz Majewski
 <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Aniket
 Limaye <a-limaye@ti.com>, Beleswar Padhi <b-padhi@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734433652; l=2823;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=EtcRFTdEyj6YQEnuvk7S0u9CauiF4UZthhpCyIHvtco=;
 b=+VL83zHXMGWOMJKRL3KL0xIWnvvVYWokueNnld+GdmK6X6j81erzB22gRDJTD5lqNENx47WvB
 QMEUmlUMei5AjR38jKr5JOqHv/hz4ozx7/YBTTLnhGFQ6hOLLL6ahU/
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
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

J742S2 has the same part number as J784S4 but JTAG_DEVICE_ID has a
PKG bit that tells about J742S2.

Add support for reading JTAG_DEVICE_ID and set family as J742S2 based
on that.

Link: https://www.ti.com/lit/pdf/spruje3 (TRM)
Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 arch/arm/mach-k3/include/mach/hardware.h        |  2 ++
 arch/arm/mach-k3/include/mach/j784s4_hardware.h |  4 ++++
 drivers/soc/soc_ti_k3.c                         | 17 +++++++++++++++--
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-k3/include/mach/hardware.h b/arch/arm/mach-k3/include/mach/hardware.h
index b191d53a0f580aacd9283f06f057b47858864fe5..a26af0b6e3c95693ea6f144a3274ee193767c6c9 100644
--- a/arch/arm/mach-k3/include/mach/hardware.h
+++ b/arch/arm/mach-k3/include/mach/hardware.h
@@ -62,6 +62,8 @@
 #define JTAG_ID_PARTNO_J722S	0xbba0
 #define JTAG_ID_PARTNO_J784S4	0xbb80
 
+#define JTAG_DEVICE_ID_PKG_J742S2 0x7
+
 #define K3_SOC_ID(id, ID) \
 static inline bool soc_is_##id(void) \
 { \
diff --git a/arch/arm/mach-k3/include/mach/j784s4_hardware.h b/arch/arm/mach-k3/include/mach/j784s4_hardware.h
index 0ffe238cdaef99e3889abf8016427f54ce69b6ac..14eb739ba7301a56ef739602cc864ae1723cf637 100644
--- a/arch/arm/mach-k3/include/mach/j784s4_hardware.h
+++ b/arch/arm/mach-k3/include/mach/j784s4_hardware.h
@@ -15,6 +15,10 @@
 #define MCU_CTRL_MMR0_BASE				0x40f00000
 #define CTRL_MMR0_BASE					0x00100000
 
+#define CTRLMMR_WKUP_JTAG_DEVICE_ID		(WKUP_CTRL_MMR0_BASE + 0x18)
+#define JTAG_DEV_PKG_MASK			GENMASK(2, 0)
+#define JTAG_DEV_PKG_SHIFT			0
+
 #define CTRLMMR_MAIN_DEVSTAT				(CTRL_MMR0_BASE + 0x30)
 #define MAIN_DEVSTAT_BOOT_MODE_B_MASK			BIT(0)
 #define MAIN_DEVSTAT_BOOT_MODE_B_SHIFT			0
diff --git a/drivers/soc/soc_ti_k3.c b/drivers/soc/soc_ti_k3.c
index a3acca4d394273aad53efd3eee200ecdda50c31b..f8e64395ae3f18513837a88cf91d340fc11bb346 100644
--- a/drivers/soc/soc_ti_k3.c
+++ b/drivers/soc/soc_ti_k3.c
@@ -18,9 +18,14 @@ struct soc_ti_k3_plat {
 static const char *get_family_string(u32 idreg)
 {
 	const char *family;
+	u32 jtag_dev_id;
+	u32 pkg;
 	u32 soc;
 
+	jtag_dev_id = readl(CTRLMMR_WKUP_JTAG_DEVICE_ID);
+
 	soc = (idreg & JTAG_ID_PARTNO_MASK) >> JTAG_ID_PARTNO_SHIFT;
+	pkg = (jtag_dev_id & JTAG_DEV_PKG_MASK) >> JTAG_DEV_PKG_SHIFT;
 
 	switch (soc) {
 	case JTAG_ID_PARTNO_AM62X:
@@ -51,8 +56,16 @@ static const char *get_family_string(u32 idreg)
 		family = "J722S";
 		break;
 	case JTAG_ID_PARTNO_J784S4:
-		family = "J784S4";
-		break;
+		{
+			/* Keep default family as J784S4 */
+			family = "J784S4";
+			switch (pkg) {
+			case JTAG_DEVICE_ID_PKG_J742S2:
+				family = "J742S2";
+				break;
+			}
+			break;
+		}
 	default:
 		family = "Unknown Silicon";
 	};

-- 
2.34.1

