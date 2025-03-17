Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85C18C28B30
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 04:55:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B04F581B5B;
	Mon, 17 Mar 2025 05:55:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="VMAyluLv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8C718197F; Mon, 17 Mar 2025 05:55:02 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B3A180F4C
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 05:55:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52H4stnG2231322
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 16 Mar 2025 23:54:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1742187295;
 bh=6j7RaJu5pZDvosDIcB3ZSJv+iDG3kWvALJFSBIPPYSo=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=VMAyluLv0XGWtVOVktzaSbHpyYstpZAlcjKWjQ60+zPskHIUUQ5ox4LC9rd2BJZqW
 boFPwW9vxjlnBt0xxtLKUy1w5qeJ3iHfmg7xGZzeeKgW081kKbJtnAXMf1jlKxVZ68
 1EFf2DfizUbNUOz8XiAutVHfsmAhD5wM3yf0D5qA=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52H4st9r007549
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 16 Mar 2025 23:54:55 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 16
 Mar 2025 23:54:55 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 16 Mar 2025 23:54:55 -0500
Received: from [127.0.1.1] (uda0497581-hp.dhcp.ti.com [172.24.227.253])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52H4sXBf058287;
 Sun, 16 Mar 2025 23:54:51 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Mon, 17 Mar 2025 10:24:23 +0530
Subject: [PATCH v4 4/8] soc: Add information to identify the J742S2 SoC family
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250317-b4-upstream-j742s2-v4-4-4ba88bfd357a@ti.com>
References: <20250317-b4-upstream-j742s2-v4-0-4ba88bfd357a@ti.com>
In-Reply-To: <20250317-b4-upstream-j742s2-v4-0-4ba88bfd357a@ti.com>
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, Lukasz Majewski
 <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Aniket
 Limaye <a-limaye@ti.com>, Beleswar Padhi <b-padhi@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Davis <afd@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742187273; l=2132;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=liWuxB9Yec2iumlhjjudQXtNiMUfTJ9P1qIgqCVrYRQ=;
 b=XymwWqraqIYiqJgk8pxpFTG9q4s5mLY3K0EtL1nZCpYla9cj950dYbxEINxbGi6PqHLBBbE/0
 q8H9TWrLNQZCIFw4x1FOhMR+0bf7TOUkgv6Iwzg6BTdZWr61Dl4yzn2
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
 arch/arm/mach-k3/include/mach/hardware.h |  6 ++++++
 drivers/soc/soc_ti_k3.c                  | 16 ++++++++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-k3/include/mach/hardware.h b/arch/arm/mach-k3/include/mach/hardware.h
index b191d53a0f580aacd9283f06f057b47858864fe5..1657697fbd818c05d57fd4792062e91a01e3ed66 100644
--- a/arch/arm/mach-k3/include/mach/hardware.h
+++ b/arch/arm/mach-k3/include/mach/hardware.h
@@ -62,6 +62,12 @@
 #define JTAG_ID_PARTNO_J722S	0xbba0
 #define JTAG_ID_PARTNO_J784S4	0xbb80
 
+#define CTRLMMR_WKUP_JTAG_DEVICE_ID		(WKUP_CTRL_MMR0_BASE + 0x18)
+#define JTAG_DEV_J742S2_PKG_MASK		GENMASK(2, 0)
+#define JTAG_DEV_J742S2_PKG_SHIFT		0
+
+#define JTAG_ID_PKG_J742S2	0x7
+
 #define K3_SOC_ID(id, ID) \
 static inline bool soc_is_##id(void) \
 { \
diff --git a/drivers/soc/soc_ti_k3.c b/drivers/soc/soc_ti_k3.c
index a3acca4d394273aad53efd3eee200ecdda50c31b..b34cbd08e0732b15ff96364afe0372ece205272d 100644
--- a/drivers/soc/soc_ti_k3.c
+++ b/drivers/soc/soc_ti_k3.c
@@ -18,8 +18,12 @@ struct soc_ti_k3_plat {
 static const char *get_family_string(u32 idreg)
 {
 	const char *family;
+	u32 jtag_dev_id;
+	u32 pkg;
 	u32 soc;
 
+	jtag_dev_id = readl(CTRLMMR_WKUP_JTAG_DEVICE_ID);
+
 	soc = (idreg & JTAG_ID_PARTNO_MASK) >> JTAG_ID_PARTNO_SHIFT;
 
 	switch (soc) {
@@ -51,8 +55,16 @@ static const char *get_family_string(u32 idreg)
 		family = "J722S";
 		break;
 	case JTAG_ID_PARTNO_J784S4:
-		family = "J784S4";
-		break;
+		{
+			/* Keep default family as J784S4 */
+			family = "J784S4";
+
+			pkg = (jtag_dev_id & JTAG_DEV_J742S2_PKG_MASK) >> JTAG_DEV_J742S2_PKG_SHIFT;
+			if (pkg == JTAG_ID_PKG_J742S2)
+				family = "J742S2";
+
+			break;
+		}
 	default:
 		family = "Unknown Silicon";
 	};

-- 
2.34.1

