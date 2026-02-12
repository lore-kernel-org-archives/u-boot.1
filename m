Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FDE9EEA84F
	for <u-boot@archiver.kernel.org>; Thu, 12 Feb 2026 20:38:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F4748367F;
	Thu, 12 Feb 2026 21:38:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SF8NgXfg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 880A983A47; Thu, 12 Feb 2026 20:44:55 +0100 (CET)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 315F783015
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 20:44:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7d4bd4db87aso108053a34.2
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 11:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770925492; x=1771530292; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=t+sMgDSd+veqvwIElGpZjoGOF91Uw+3O52H0oxEcFdI=;
 b=SF8NgXfgGyMN9FCyCXx4zO8f66rYllOWkbZD/nWEc4sSh/2/gXjicNVnjc+od4Y3kX
 XCOaGp2Dgq5uTbmlzVzEs17ohCOm6C/9llDSegj/l4FEFYY1VWyqJNmTfCEMl0iXMtao
 g87qBgP3/HDeF0WMkN/ZurJxNf1AZsTWVCKMY/20Lns6w0dvjtUq7ZGj+HYK547nivBe
 sIfj2ovhyV1w76TYg2SfUknwIRz4R3ZAW20og9BOpBl3aKwaU/gvi/s2TD09M9GcEWru
 EGxWtRjsKf81R8A2KZQXi9cpPyouenZ3MmeO27DgS71gK7r+gWk6CJA+HRL598SjPhmS
 mdww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770925492; x=1771530292;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t+sMgDSd+veqvwIElGpZjoGOF91Uw+3O52H0oxEcFdI=;
 b=SKIi7a89K2si08TfQI/azv3dYjdCvhw56pvJyjWoqMVl27r9G8Ts+Ug5H9SvlbWjKK
 C4IZSzOd47Kk18LjFZyMByFwqHpZEy6PV7bAbSngugibdaOo9LPNZYmB8skUrsvRNi22
 NBgdxbYpmTUoGpn3rp0wBjRMgsfykXW2KYucwOENl5ubC9hVVxtzDJw6QtgxhoPM0VDE
 h4HpbPIrQyjkKeKQXB6lQAM+VJJhbBSEX6LVAT9s4kStaTz2OyitmTFMs8OObS7LjYiV
 JisWNdwsva+i42lRH78UilCz6e0MkvAbGYYIMlR4KBRsrQisbVv2YRF1hWGrr4Z1Pft9
 PNog==
X-Gm-Message-State: AOJu0Ywt/zpHPtvX5Wwhet9HD7TN773sBIks9BnJtlDZbntkwaipMiSY
 SL7psy7nmEg0Rrq4fl2nWIvAONnLbPjsH1Tzj9vZbqToF0plg/pu4eC0ezVflw==
X-Gm-Gg: AZuq6aIUuLrYhd4/hs1lSNmj0BJj7eVdivk0/Nn+NapJy5BvCwL/JwzF84As37ETMqC
 obGq10hLjU0JoVlUf2ES/1A7W09e1x0t6N7NbmufVM3wMADUNe39QepXIqcdskg1rDBXVh1EYqS
 pwRT25jqUS/hfD9z+FuY8fP1ocGAM0QmUY8rHIDKSGs7W9Kistua/28xcfG4mLuTRdSY4Tr9A+c
 qcFtt/P2bzlPT8boekBpMFT7pIpwmCvFtEbQsIzIxrC5Tl3vUj9MxgFjFtQ0+ZDbhagy++XEMwW
 91KoFWppmMxzbLILJNKlNVoFwpU9OHcUMyPGkX2UsmYtmZ9HEMvCmnpy01y/CFd9aTMGf223gO2
 Z3l5dB2Kgmog9J4MXaILeTre8Z71BYqXI3DcfwVXIzmg584FNxKaf+KEcCbpFFf65nneU5f63mx
 fSYnPINslnPOl683zMhw/w6FmoKhCi9Bl1ljDOLA2DU3shzDvwsRnrdnO6GnOYnFApsjy53HJml
 NhXWQXdQUiHWeITmxvsB4Gn7yt7FjrylG7ayYdBeNLgZ58v8ayzLtCRxhKvw5A=
X-Received: by 2002:a05:6808:1391:b0:45e:b160:76e2 with SMTP id
 5614622812f47-4637fae7094mr1613216b6e.6.1770925491609; 
 Thu, 12 Feb 2026 11:44:51 -0800 (PST)
Received: from james-x399.localdomain (71-218-105-26.hlrn.qwest.net.
 [71.218.105.26]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4636b065d46sm3386543b6e.12.2026.02.12.11.44.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 11:44:51 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
To: u-boot@lists.denx.de
Cc: James Hilliard <james.hilliard1@gmail.com>,
 Jamie Gibbons <Jamie.Gibbons@microchip.com>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 David Lechner <dlechner@baylibre.com>
Subject: [PATCH v5 1/1] image: fit: Apply overlays using aligned writable FDT
 copies
Date: Thu, 12 Feb 2026 12:44:16 -0700
Message-ID: <20260212194417.771967-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 12 Feb 2026 21:38:32 +0100
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

libfdt expects FDT/DTO blobs to be 8-byte aligned. When loading the
base FDT or overlays from a FIT, the mapped buffer may be unaligned,
which can break fdt_open_into() on strict-alignment architectures.

boot_get_fdt_fit() relocates the base FDT with boot_relocate_fdt()
before applying overlays. That uses the bootm memory map and can
overlap with the FIT buffer when the FIT is loaded into RAM,
corrupting data needed to load the kernel and ramdisk.

Allocate writable, 8-byte aligned copies of the base FDT and overlays
with memalign() and fdt_open_into(). Grow the base buffer as needed,
apply overlays to it and pack the final tree. Free each temporary
overlay copy after application and check fdt_pack() errors.

Fixes: 8fbcc0e0e839 ("boot: Assure FDT is always 8-byte aligned")
Fixes: 881f0b77dc8c ("image: apply FDTOs on FDT image node")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Cc: Jamie Gibbons <Jamie.Gibbons@microchip.com>
---
Changes v1 -> v2:
  - also fix alignment issues
Changes v2 -> v3:
  - do not print on -ENOMEM errors
  - let boot_get_fdt_fit_into_buffer() reuse buffers and handle rounding
Changes v3 -> v4:
  - rebase on master
Changes v4 -> v5:
  - refactor boot_get_fdt_fit_into_buffer() to use a single cleanup path
    and avoid duplicated free(tmp) handling
---
 boot/image-fit.c | 159 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 120 insertions(+), 39 deletions(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index 3ed69b5f7bc..4e271303db2 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -2368,6 +2368,71 @@ int boot_get_setup_fit(struct bootm_headers *images, uint8_t arch,
 }
 
 #ifndef USE_HOSTCC
+#ifdef CONFIG_OF_LIBFDT_OVERLAY
+static int boot_get_fdt_fit_into_buffer(const void *src, ulong srclen,
+					ulong extra, ulong min_dstlen,
+					void **fdtdstbuf, ulong *fdtdstlenp)
+{
+	const void *fdtsrcbuf;
+	void *tmp = NULL;
+	void *dstbuf, *newdstbuf = NULL;
+	ulong dstlen, newdstlen;
+	int err = 0;
+
+	/* Make sure the source FDT/DTO is 8-byte aligned for libfdt. */
+	fdtsrcbuf = src;
+	if (!IS_ALIGNED((uintptr_t)src, 8)) {
+		tmp = memalign(8, srclen);
+		if (!tmp)
+			return -ENOMEM;
+
+		memcpy(tmp, src, srclen);
+		fdtsrcbuf = tmp;
+	}
+
+	newdstlen = ALIGN(fdt_totalsize(fdtsrcbuf) + extra, SZ_4K);
+	min_dstlen = ALIGN(min_dstlen, SZ_4K);
+	if (newdstlen < min_dstlen)
+		newdstlen = min_dstlen;
+
+	dstbuf = *fdtdstbuf;
+	dstlen = dstbuf ? *fdtdstlenp : 0;
+
+	/*
+	 * If the caller already provided a large enough writable buffer,
+	 * and we're not moving the FDT, nothing to do.
+	 */
+	if (dstlen >= newdstlen && dstbuf == fdtsrcbuf)
+		goto out;
+
+	/* Try to reuse existing destination buffer if it is large enough. */
+	if (dstbuf && dstlen >= newdstlen) {
+		err = fdt_open_into(fdtsrcbuf, dstbuf, dstlen);
+		goto out;
+	}
+
+	newdstbuf = memalign(8, newdstlen);
+	if (!newdstbuf) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	err = fdt_open_into(fdtsrcbuf, newdstbuf, newdstlen);
+	if (err < 0)
+		goto out;
+
+	free(dstbuf);
+	*fdtdstbuf = newdstbuf;
+	*fdtdstlenp = newdstlen;
+	newdstbuf = NULL;
+
+out:
+	free(newdstbuf);
+	free(tmp);
+	return err;
+}
+#endif
+
 int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
 		     const char **fit_unamep, const char **fit_uname_configp,
 		     int arch, ulong *datap, ulong *lenp)
@@ -2380,18 +2445,12 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
 	char *next_config = NULL;
 	ulong load, len;
 #ifdef CONFIG_OF_LIBFDT_OVERLAY
-	ulong ovload, ovlen, ovcopylen;
+	ulong ovload, ovlen, ovcopylen, need;
 	const char *uconfig;
 	const char *uname;
-	/*
-	 * of_flat_tree is storing the void * returned by map_sysmem, then its
-	 * address is passed to boot_relocate_fdt which expects a char ** and it
-	 * is then cast into a ulong. Setting its type to void * would require
-	 * to cast its address to char ** when passing it to boot_relocate_fdt.
-	 * Instead, let's be lazy and use void *.
-	 */
-	char *of_flat_tree;
-	void *base, *ov, *ovcopy = NULL;
+	void *ovcopy = NULL;
+	void *base_buf = NULL;
+	ulong base_buf_size = 0;
 	int i, err, noffset, ov_noffset;
 #endif
 
@@ -2434,18 +2493,25 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
 	/* we need to apply overlays */
 
 #ifdef CONFIG_OF_LIBFDT_OVERLAY
-	/* Relocate FDT so resizing does not overwrite other data in FIT. */
-	of_flat_tree = map_sysmem(load, len);
-	len = ALIGN(fdt_totalsize(load), SZ_4K);
-	err = boot_relocate_fdt(&of_flat_tree, &len);
-	if (err) {
-		printf("Required FDT relocation for applying DTOs failed: %d\n",
-		       err);
-		fdt_noffset = -EBADF;
+	/*
+	 * Make a writable copy of the base FDT for applying overlays.
+	 *
+	 * Do not use boot_relocate_fdt() here: it allocates from the bootm map and
+	 * may overlap with the FIT buffer (still needed to load the kernel /
+	 * ramdisk) when the FIT is loaded into RAM.
+	 */
+	err = boot_get_fdt_fit_into_buffer(map_sysmem(load, len), len,
+					   CONFIG_SYS_FDT_PAD, 0, &base_buf,
+					   &base_buf_size);
+	if (err < 0) {
+		if (err != -ENOMEM)
+			printf("Required FDT copy for applying DTOs failed: %s\n",
+			       fdt_strerror(err));
+		fdt_noffset = err;
 		goto out;
 	}
 
-	load = (ulong)of_flat_tree;
+	len = fdt_off_dt_strings(base_buf) + fdt_size_dt_strings(base_buf);
 
 	/* apply extra configs in FIT first, followed by args */
 	for (i = 1; ; i++) {
@@ -2489,48 +2555,61 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
 		}
 		debug("%s loaded at 0x%08lx len=0x%08lx\n",
 				uname, ovload, ovlen);
-		ov = map_sysmem(ovload, ovlen);
-
-		ovcopylen = ALIGN(fdt_totalsize(ov), SZ_4K);
-		ovcopy = malloc(ovcopylen);
-		if (!ovcopy) {
-			printf("failed to duplicate DTO before application\n");
-			fdt_noffset = -ENOMEM;
-			goto out;
-		}
-
-		err = fdt_open_into(ov, ovcopy, ovcopylen);
+		err = boot_get_fdt_fit_into_buffer(map_sysmem(ovload, ovlen),
+						   ovlen, 0, 0, &ovcopy,
+						   &ovcopylen);
 		if (err < 0) {
-			printf("failed on fdt_open_into for DTO: %s\n",
-			       fdt_strerror(err));
+			if (err != -ENOMEM)
+				printf("failed on fdt_open_into for DTO: %s\n",
+				       fdt_strerror(err));
 			fdt_noffset = err;
 			goto out;
 		}
 
-		base = map_sysmem(load, len + ovlen);
-		err = fdt_open_into(base, base, len + ovlen);
+		/*
+		 * Ensure the base FDT buffer is open and has enough room for
+		 * the overlay. Grow it on demand.
+		 */
+		need = len + ovcopylen + CONFIG_SYS_FDT_PAD;
+		err = boot_get_fdt_fit_into_buffer(base_buf, base_buf_size, 0,
+						   need, &base_buf,
+						   &base_buf_size);
 		if (err < 0) {
-			printf("failed on fdt_open_into: %s\n",
-			       fdt_strerror(err));
+			if (err != -ENOMEM)
+				printf("failed to expand FDT for DTO application: %s\n",
+				       fdt_strerror(err));
 			fdt_noffset = err;
 			goto out;
 		}
 
 		/* the verbose method prints out messages on error */
-		err = fdt_overlay_apply_verbose(base, ovcopy);
+		err = fdt_overlay_apply_verbose(base_buf, ovcopy);
 		if (err < 0) {
 			fdt_noffset = err;
 			goto out;
 		}
-		fdt_pack(base);
-		len = fdt_totalsize(base);
+		len = fdt_off_dt_strings(base_buf) + fdt_size_dt_strings(base_buf);
+
+		free(ovcopy);
+		ovcopy = NULL;
 	}
+
+	err = fdt_pack(base_buf);
+	if (err < 0) {
+		fdt_noffset = err;
+		goto out;
+	}
+	len = fdt_totalsize(base_buf);
 #else
 	printf("config with overlays but CONFIG_OF_LIBFDT_OVERLAY not set\n");
 	fdt_noffset = -EBADF;
 #endif
 
 out:
+#ifdef CONFIG_OF_LIBFDT_OVERLAY
+	if (fdt_noffset >= 0 && base_buf)
+		load = map_to_sysmem(base_buf);
+#endif
 	if (datap)
 		*datap = load;
 	if (lenp)
@@ -2541,6 +2620,8 @@ out:
 		*fit_uname_configp = fit_uname_config;
 
 #ifdef CONFIG_OF_LIBFDT_OVERLAY
+	if (fdt_noffset < 0)
+		free(base_buf);
 	free(ovcopy);
 #endif
 	free(fit_uname_config_copy);
-- 
2.43.0

