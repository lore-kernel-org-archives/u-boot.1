Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68BA1EB5967
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 05:22:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E59383B72;
	Wed, 11 Feb 2026 06:22:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="efPowO2q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 782F883BF4; Wed, 11 Feb 2026 03:14:24 +0100 (CET)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 254FA83A47
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 03:14:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-662efd1bdd4so279793eaf.0
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 18:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770776060; x=1771380860; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cO/fzXWwKYkLyIi6u3vAyp8pnmdS3K6zjykRGn+5gZ0=;
 b=efPowO2que/bVCIMmgfUeqmrtwVwkAnOXIq4UUfQsH3xGpvqDqETrXDl+QzezWtBY3
 SRPbZzwNG7dAf4lg9MyUXCIx0C0VKcZ7H8KHrThSxjzJ871ZVLpDCLGbxA+YCWlAiwvl
 +AkOgTJAvWUvU0fUV4E+fimIJRgnSzppjmE5K62oUoLkwTMx95HURl9N+vzlQwt/ib5i
 +vs6JMvlCMElBUt70VQJnjTxAbVejwngceoZp8UAxwzznF4cqRzFGhJTfM+OKIYEQcNs
 PPraa+wmxn9i8ernSasB4MeWRx9LE24ijoYmyCb7eypaTFFdXuXThOjBTKb7pr5l/Gr7
 s7BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770776060; x=1771380860;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cO/fzXWwKYkLyIi6u3vAyp8pnmdS3K6zjykRGn+5gZ0=;
 b=pN4Th4zCPtBdtdMRdDDrBhTd2QmhUg8PgnfnPal5Ak8Xp3dxmRsmfdTdb+O/2uqAPG
 1qIYofwrcnWzyiYe/IWxgoNn6BUxOkHhedFP4KIU65IeogAczTskaZ7R4ikoMjO/o0rN
 fORPnG6uZuTGQc1JpTwcmoZzQttMg66iW3wKtt2U9YZ4y3mt0qO1Jk+sRK6bojXBsYXx
 QOWJDjvTyQeBJ2+mfuV4g1Dtp182z3unCR3bcGaxJsVkUqUhQDBZYAzbshbp7dAyfPSw
 i0fjq0S+mO52VIIIWXCPZaFaKyUImhPockB5HhqFps99w3ExbbXNo7gMirn8Q+p9Wkre
 9NUQ==
X-Gm-Message-State: AOJu0YyeuphAc6J8AT9p9N/k8rfqGlEEVtsiJJ0g3nbvJz6gu7/7a6rL
 W6Hrh+HCFSybjQ/wVpWKyBrFCMpmE6GXR6Z8etrW/ceT9kXQqzYn3KryeaCCTA==
X-Gm-Gg: AZuq6aIYvh8rLJiZ9KZSN2Gr239u7ZZp+CBgLTRgC5IJIEOZt1PF30uobnP6qD7jYOM
 x4/iyViYVf8S+HCsLkCpJdsUvMYEejt0J9tMRD3a+xMkJ5P9C5hYVFSgHTavGyE6A59fVLUXMb1
 B46SsQBbyWlNxmzRsSWPAmBS3jubA4xgvETEX+ssK9Y5yJTmQMfxcnFGxQ9YLh6pZUlKkLwR15y
 TeeKzVV8I+L65R/Kc6RJjqwPgZ08jcINWahYlFYoBUq+BSJ2VXFviN/t9X7qr+T/5trFWeKkzpU
 A0w/4wE0hiecfkIN8nyI3lOosf+n3zT5D1cMNbJB6dG57/kDbthV7UdjiO2O3V+VfxXfpd4lmma
 T1GY1aucKaLBP33crKcjQtjVVxkG/QoBNyNuFyTrYEa6TuauJwfP57hvN1KGr+tJlN6UmRH364z
 nDTpKOBoRKWL6oUN6dLXmZtZMxyVcWWH0V30hMnPggVvnCrDpKmy5ZZX4jFo8Vh/bDwaK2H0zjT
 7I2kC2jDyKoaIsv++jf4uW9lpC736kj250H+MzvLkK32vRpo8kXM8KAZspaIxqYasawimo8Cg==
X-Received: by 2002:a05:6820:160a:b0:672:afe2:4b7d with SMTP id
 006d021491bc7-672ecc31aecmr1846736eaf.42.1770776060564; 
 Tue, 10 Feb 2026 18:14:20 -0800 (PST)
Received: from james-x399.localdomain (71-218-105-26.hlrn.qwest.net.
 [71.218.105.26]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40eaef220cesm338128fac.9.2026.02.10.18.14.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 18:14:19 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
To: u-boot@lists.denx.de
Cc: James Hilliard <james.hilliard1@gmail.com>,
 Jamie Gibbons <Jamie.Gibbons@microchip.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v3 1/1] image: fit: Apply overlays using aligned writable FDT
 copies
Date: Tue, 10 Feb 2026 19:13:50 -0700
Message-ID: <20260211021351.2678571-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 11 Feb 2026 06:22:44 +0100
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
---
 boot/image-fit.c | 161 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 124 insertions(+), 37 deletions(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index 41ab1f552b0..09a57bbb670 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -2344,6 +2344,75 @@ int boot_get_setup_fit(struct bootm_headers *images, uint8_t arch,
 }
 
 #ifndef USE_HOSTCC
+#ifdef CONFIG_OF_LIBFDT_OVERLAY
+static int boot_get_fdt_fit_into_buffer(const void *src, ulong srclen,
+					ulong extra, ulong min_dstlen,
+					void **fdtdstbuf, ulong *fdtdstlenp)
+{
+	const void *fdtsrcbuf;
+	void *tmp = NULL;
+	void *dstbuf, *newdstbuf;
+	ulong dstlen, newdstlen;
+	int err;
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
+	if (dstbuf && dstlen >= newdstlen && dstbuf == fdtsrcbuf) {
+		free(tmp);
+		return 0;
+	}
+
+	/* Try to reuse existing destination buffer if it is large enough. */
+	if (dstbuf && dstlen >= newdstlen) {
+		err = fdt_open_into(fdtsrcbuf, dstbuf, dstlen);
+		free(tmp);
+		if (err < 0)
+			return err;
+		return 0;
+	}
+
+	newdstbuf = memalign(8, newdstlen);
+	if (!newdstbuf) {
+		free(tmp);
+		return -ENOMEM;
+	}
+
+	err = fdt_open_into(fdtsrcbuf, newdstbuf, newdstlen);
+	free(tmp);
+	if (err < 0) {
+		free(newdstbuf);
+		return err;
+	}
+
+	free(dstbuf);
+	*fdtdstbuf = newdstbuf;
+	*fdtdstlenp = newdstlen;
+
+	return 0;
+}
+#endif
+
 int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
 		     const char **fit_unamep, const char **fit_uname_configp,
 		     int arch, ulong *datap, ulong *lenp)
@@ -2356,18 +2425,12 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
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
 
@@ -2410,18 +2473,25 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
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
@@ -2465,46 +2535,61 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
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
-			printf("failed on fdt_open_into for DTO\n");
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
-			printf("failed on fdt_open_into\n");
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
+	}
+
+	err = fdt_pack(base_buf);
+	if (err < 0) {
+		fdt_noffset = err;
+		goto out;
 	}
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
@@ -2515,6 +2600,8 @@ out:
 		*fit_uname_configp = fit_uname_config;
 
 #ifdef CONFIG_OF_LIBFDT_OVERLAY
+	if (fdt_noffset < 0)
+		free(base_buf);
 	free(ovcopy);
 #endif
 	free(fit_uname_config_copy);
-- 
2.43.0

