Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97CE3EE20A6
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 15:13:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7ECE383BC8;
	Fri,  6 Feb 2026 16:12:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="D68VHZMR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94D4D83AAD; Fri,  6 Feb 2026 16:10:27 +0100 (CET)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED6CD838FA
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 16:10:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=4901bbfe9=Jamie.Gibbons@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1770390625; x=1801926625;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=CC3EQjdo+f2xD6zKZ7cIPJS7t6ZokERNIegElmBLKnw=;
 b=D68VHZMRVFrmBCtNjU4LQAErSFoLR4Oz/0RxY1QQdh7VMU2qge+u/ihY
 MQV3s2dby92I/ilDBJCV01JEa6UyjL6gAzqWm27BIWLqJ6njw3E0aIQkz
 00LRcD2iDd8uLvkUcOEp0wYDz6MMDl2a35zG/Dmjr16sUdsGxLlMTFJ4/
 fm/bHRauFEB/qLFmrtfJCazWYhGXA26GNYelzzFiOApDdS2zRa0YDDzDS
 P0SjY06gaoauvypgqBHJf2nuN+UeFJN3lTitEK7lDd/R8F7S0kjZSyVTb
 qjAGBFiEZZYfVfT9Mtp2+LVkiE8bgQVDTX2Bqy6qe7fPDWt1bNbKij0MW w==;
X-CSE-ConnectionGUID: HFyJVTckRX+gxKFdAlg+UQ==
X-CSE-MsgGUID: fmRFbLoyRe6ZiCmm10dF6g==
X-IronPort-AV: E=Sophos;i="6.21,276,1763449200"; d="scan'208";a="284422988"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 06 Feb 2026 08:10:23 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 6 Feb 2026 08:10:14 -0700
Received: from jamie-dev.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 6 Feb 2026 08:10:12 -0700
From: Jamie Gibbons <jamie.gibbons@microchip.com>
To: <u-boot@lists.denx.de>
CC: Conor Dooley <conor.dooley@microchip.com>, Valentina Fernandez Alanis
 <valentina.fernandezalanis@microchip.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon Glass
 <sjg@chromium.org>, Leo <ycliang@andestech.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Cyril Jean <cyril.jean@microchip.com>,
 <jamie.gibbons@microchip.com>
Subject: [PATCH] boot: image-fit: Add runtime flag to always relocate overlays
Date: Fri, 6 Feb 2026 15:14:57 +0000
Message-ID: <20260206151457.4104515-1-jamie.gibbons@microchip.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Fri, 06 Feb 2026 16:12:47 +0100
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

Some platforms require device tree overlays (DTOs) to be 8-byte aligned
when applying them with libfdt. Previously, the code did not guarantee
this alignment, which could result in alignment errors during overlay
application.
Introduce a new runtime parameter, always_relocate_overlay, to
boot_get_fdt_fit(). When set, overlays are always copied to an 8-byte
aligned buffer before being passed to fdt_open_into().
This resolves issues with FDT overlay application on platforms that
require strict alignment.

Fixes: 8fbcc0e0e839 ("boot: Assure FDT is always at 8-byte aligned address")

Signed-off-by: Jamie Gibbons <jamie.gibbons@microchip.com>
---
 boot/image-fdt.c |  2 +-
 boot/image-fit.c | 23 +++++++++++++++++------
 include/image.h  |  5 ++++-
 3 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/boot/image-fdt.c b/boot/image-fdt.c
index a3a4fb8b558..33fd4248acd 100644
--- a/boot/image-fdt.c
+++ b/boot/image-fdt.c
@@ -431,7 +431,7 @@ static int select_fdt(struct bootm_headers *images, const char *select, u8 arch,
 				fdt_noffset = boot_get_fdt_fit(images, fdt_addr,
 							       &fit_uname_fdt,
 							       &fit_uname_config,
-							       arch, &load, &len);
+							       arch, &load, &len, true);
 
 				if (fdt_noffset < 0)
 					return -ENOENT;
diff --git a/boot/image-fit.c b/boot/image-fit.c
index d2b0a7daccc..a3fa2a01463 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -2370,7 +2370,8 @@ int boot_get_setup_fit(struct bootm_headers *images, uint8_t arch,
 #ifndef USE_HOSTCC
 int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
 		     const char **fit_unamep, const char **fit_uname_configp,
-		     int arch, ulong *datap, ulong *lenp)
+		     int arch, ulong *datap, ulong *lenp,
+		     bool always_relocate_overlay)
 {
 	int fdt_noffset, cfg_noffset, count;
 	const void *fit;
@@ -2492,11 +2493,21 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
 		ov = map_sysmem(ovload, ovlen);
 
 		ovcopylen = ALIGN(fdt_totalsize(ov), SZ_4K);
-		ovcopy = malloc(ovcopylen);
-		if (!ovcopy) {
-			printf("failed to duplicate DTO before application\n");
-			fdt_noffset = -ENOMEM;
-			goto out;
+		if (always_relocate_overlay) {
+			ovcopy = aligned_alloc(8, ovcopylen);
+			if (!ovcopy) {
+				printf("failed to allocate aligned DTO buffer\n");
+				fdt_noffset = -ENOMEM;
+				goto out;
+			}
+			memcpy(ovcopy, ov, ovlen);
+		} else {
+			ovcopy = malloc(ovcopylen);
+			if (!ovcopy) {
+				printf("failed to duplicate DTO before application\n");
+				fdt_noffset = -ENOMEM;
+				goto out;
+			}
 		}
 
 		err = fdt_open_into(ov, ovcopy, ovcopylen);
diff --git a/include/image.h b/include/image.h
index 34efac6056d..9b174ea6233 100644
--- a/include/image.h
+++ b/include/image.h
@@ -707,12 +707,15 @@ int boot_get_setup_fit(struct bootm_headers *images, uint8_t arch,
  * @param arch		Expected architecture (IH_ARCH_...)
  * @param datap		Returns address of loaded image
  * @param lenp		Returns length of loaded image
+ * @param always_relocate_overlay	If true, always copy overlays to an 8-byte
+ *			aligned buffer before applying (prevents alignment errors)
  *
  * Return: node offset of base image, or -ve error code on error
  */
 int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
 		     const char **fit_unamep, const char **fit_uname_configp,
-		     int arch, ulong *datap, ulong *lenp);
+		     int arch, ulong *datap, ulong *lenp,
+		     bool always_relocate_overlay);
 
 /**
  * fit_image_load() - load an image from a FIT
-- 
2.43.0

