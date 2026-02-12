Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4647DEEA871
	for <u-boot@archiver.kernel.org>; Thu, 12 Feb 2026 23:48:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 301D083AAB;
	Fri, 13 Feb 2026 00:48:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LqbhHxfW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC2B683015; Thu, 12 Feb 2026 22:34:33 +0100 (CET)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57E7780FA1
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 22:34:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7d4c383f2fcso60473a34.0
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 13:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770932070; x=1771536870; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EXp0889hDb2Dn26MJ06U2PbpaDHOhvHxlWhfepZl/WQ=;
 b=LqbhHxfWWQWvy7OZf1ONYjbnXpNZnXWZwitWlFVakIHkDkrwXI6QkxUUhPjzGAqT4C
 OS0/8zJmOfNp/+fpUlnWi2/7nIFqnCl4yCsREX28sIVrZ+zfFBh1IPKm1ZrshrkaqReY
 7RkLbWIqaSiPyy4TILfHIjSi1e1a3wjBGn2Jov7zG5YvCRGmkUkyo+HXu7sM+9orjhjq
 aSfTEXaI7YFMSx49eOIRZdsNt4akVsAYcPSrqvBSP/O4kVIjT3ghPyf4hCFppx/UJ0V1
 KeecC8i7tK6ZBbk/NJ7H78wUE++WGWRBfNybgS4jQt6GaitHs6kbKqJeqNN7KfsM2Y/T
 O++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770932070; x=1771536870;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EXp0889hDb2Dn26MJ06U2PbpaDHOhvHxlWhfepZl/WQ=;
 b=sPUBq2XK08D70MasGTPlHHr0H+Cwi3Z5uAhZ3wsNDYh9m/VmeK25IW5bpEIYH518hF
 XqQrjnwwowogDUE6EaRoEtik4+LOhfrzKxYw7MmCEvAVKFn0Hc3rifsEFLqzLgyjxj+G
 e7VnqiFnVS/j88XjV/g6yePv2IGRFj88FXi+6hMAOHAxb56ypcJ1fe4jDf0LX1W9GvMW
 v+0CcJpW7L3WEtIlhImeG9Ph3S91AVBQv78SoOA0xl77viUmrcXNjfQqqly8NK81RIaW
 gQhO2uBuNlsiLalxHxbd4s3rHfuHUL4O5m0pDnQycLNStt3NAjbqdXhRTqJCSPueZi8/
 g0Rw==
X-Gm-Message-State: AOJu0Yyho+zgvP9dIOXSdb5UeE0CoqjVArswB6F4UCRj5Ht2RzCwaK7A
 pKwQuaNALTTQ0mNIMocEfl04yy6F3erR9IF3UGK9afHxXBQC+pE5GP/GNyoz4w==
X-Gm-Gg: AZuq6aLOE1Cs/cfzfp3FyiTmskP2GzC8OaV7H16VLGqS3g1lhUd3l7LY3u34tLogQvU
 lX9zSxbPo7BCzXjDO4g34Mo1DB8yb69fsykOY85dxEOWQXWTUnllecxZ1PZiJ3WIjnlvDZM6+Xo
 vh4paThF1rPcn1sLo5OTNxp6/a7xywdosbYFAdWMz9QnUi9qXZsdJsbvt6dCb9sJUG+50OK8VBS
 zmSxj7DhTe0LGs94yVQ2U6kOp40ht+0xPHzyJvDD1H/VMTXQws/D/0JkBqxuUPHGB2aQTzJGGVj
 pRMg3at/SlZMxzslepEdJGRslHfNxF5HpvixPZ68VaWx0bg4m/7rcaWazgHA6JNUZ6Xhh7r7Ex0
 7NZ1iBVD9D8dvvulqoBrgEhjDnVFBsTHmTGPf8xTyahA6q2YmXYxOfBdWmztQD5vsD+ghfKTA0O
 fPnrdSWnmpqrgfPiJaDCJDAsyD+mTDlOzMFPJdz9knJztGBMVqbfkkmAYBiDx6BpnPXxL+houmV
 DgPwSIC9/GTdZLUuTU1vDgJXykaZtV3zNwDwHxSmgcCnlIY1LpxXjFxUmgU6nw=
X-Received: by 2002:a05:6830:348a:b0:7cf:e4a1:8b79 with SMTP id
 46e09a7af769-7d4c2fe5e0dmr248316a34.7.1770932069721; 
 Thu, 12 Feb 2026 13:34:29 -0800 (PST)
Received: from james-x399.localdomain (71-218-105-26.hlrn.qwest.net.
 [71.218.105.26]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4a76f9483sm4886337a34.20.2026.02.12.13.34.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 13:34:29 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
To: u-boot@lists.denx.de
Cc: James Hilliard <james.hilliard1@gmail.com>,
 Jamie Gibbons <Jamie.Gibbons@microchip.com>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 David Lechner <dlechner@baylibre.com>
Subject: [PATCH v6 1/1] image: fit: Apply overlays using aligned writable FDT
 copies
Date: Thu, 12 Feb 2026 14:34:09 -0700
Message-ID: <20260212213410.822845-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 13 Feb 2026 00:48:26 +0100
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
Changes v5 -> v6:
  - add comment clarifying packed DTB size calculation and why this path
    should not use fdt_totalsize() for growth estimation
---
 boot/image-fit.c | 165 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 126 insertions(+), 39 deletions(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index 3ed69b5f7bc..ddc64debb14 100644
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
 
@@ -2434,18 +2493,31 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
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
+	/*
+	 * Track packed DTB data size (same as libfdt internal fdt_data_size_()).
+	 * fdt_off_dt_strings() is an offset from the blob start, so this includes
+	 * headers/reserve map/struct blocks. Do not use fdt_totalsize() here since
+	 * it includes free space and would overestimate growth requirements.
+	 */
+	len = fdt_off_dt_strings(base_buf) + fdt_size_dt_strings(base_buf);
 
 	/* apply extra configs in FIT first, followed by args */
 	for (i = 1; ; i++) {
@@ -2489,48 +2561,61 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
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
@@ -2541,6 +2626,8 @@ out:
 		*fit_uname_configp = fit_uname_config;
 
 #ifdef CONFIG_OF_LIBFDT_OVERLAY
+	if (fdt_noffset < 0)
+		free(base_buf);
 	free(ovcopy);
 #endif
 	free(fit_uname_config_copy);
-- 
2.43.0

