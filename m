Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 325E1E77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 15:04:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 476F18021D;
	Thu, 19 Dec 2024 16:04:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBDEE8022B; Thu, 19 Dec 2024 16:04:07 +0100 (CET)
Received: from smtp-bc0f.mail.infomaniak.ch (smtp-bc0f.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::bc0f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1E018021A
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 16:04:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YDYjK1fN2ztYL;
 Thu, 19 Dec 2024 16:04:05 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4YDYjJ39W4zs26; Thu, 19 Dec 2024 16:04:04 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Thu, 19 Dec 2024 16:03:41 +0100
Subject: [PATCH RFC] image: apply FDTOs on FDT image node without a load
 property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241219-extlinux-relocate-dtb-when-dtbo-v1-1-fe5eeb8fd4f1@cherry.de>
X-B4-Tracking: v=1; b=H4sIAMw1ZGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDI0NL3dSKkpzMvNIK3aLUnPzkxJJU3ZSSJN3yjNQ8ECNf1yTZ3NTYLM3
 CwiDJSAloSkFRalpmBdiGaKUgN2el2NpaAKeBiep2AAAA
X-Change-ID: 20241219-extlinux-relocate-dtb-when-dtbo-4c7536f880b2
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marex@denx.de>, Heiko Stuebner <heiko@sntech.de>
X-Mailer: b4 0.14.2
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

A FIT image which is NOT using -E when created by mkimage - that is with
image data within the FIT - will fail to apply FDTO if the base FDT
image node does not specify a load property (which points to an address
in DRAM). This is because we check that the FDT address we want to apply
overlay to (i.e. modify and likely increase in size) is not inside the
FIT and give up otherwise. This is assumed necessary because we may then
overwrite other data when applying in-place.

However, we can do better than giving up: relocating the FDT in another
place in DRAM where it's safe to increase its size and apply FDTOs.

Suggested-by: Marek Vasut <marex@denx.de>
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Tested with extlinux with:
- conf node with multiple fdt entries
- conf node with base fdt + conf node with fdto (stored in fdt property)
- FDT image node with load property (behavior unchanged)
- FDT image node without load property

I'll be frank, I don't really know what I'm doing here and I'm on
holidays for a month in a few hours, so take this with a bigger grain of
salt than usual (hence the RFC). It works (tm) for now.

Cc: Heiko Stuebner <heiko@sntech.de>
---
 boot/image-fit.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index 7d56f0b5e6ed39a75e029b09dc95d605835c0f91..088482c4d5d2e194cce66f10b0acd9e586f826b2 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -2392,13 +2392,18 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
 	image_end = addr + fit_get_size(fit);
 	/* verify that relocation took place by load address not being in fit */
 	if (load >= image_start && load < image_end) {
-		/* check is simplified; fit load checks for overlaps */
-		printf("Overlayed FDT requires relocation\n");
-		fdt_noffset = -EBADF;
-		goto out;
-	}
+		/* Cannot overlay an FDT stored inside the fitImage, so let's relocate */
+		char *of_flat_tree = map_sysmem(load, len);
 
-	base = map_sysmem(load, len);
+		len = ALIGN(fdt_totalsize(load), SZ_4K);
+		if (boot_relocate_fdt(&of_flat_tree, &len)) {
+			printf("Required FDT relocation for applying overlays failed...");
+			fdt_noffset = -EBADF;
+			goto out;
+		}
+
+		load = (ulong)of_flat_tree;
+	}
 
 	/* apply extra configs in FIT first, followed by args */
 	for (i = 1; ; i++) {

---
base-commit: 69bd83568c57813cd23bc2d100c066a17e7e349d
change-id: 20241219-extlinux-relocate-dtb-when-dtbo-4c7536f880b2

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

