Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40764ECD6D3
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 18:13:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 628438367F;
	Wed, 11 Feb 2026 19:13:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hNMRKmvi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 298738388D; Wed, 11 Feb 2026 19:07:09 +0100 (CET)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC7CE83015
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 19:07:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-409440b98b5so1388276fac.2
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 10:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770833225; x=1771438025; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2abSkKRbNEPwfj5haOUiQaNSmPGygjWGjSSsUOEwKc4=;
 b=hNMRKmviXLKSOXe+O31FQOmgQNjT71TMKCdSBuHie/WJsmAKY4EIZ+UzHfikLkuoCM
 +bu38Ny4gCVobhYO9BUzR65pWqB6M694NbCS3M+MG8On7weAOkg6FCt/ekdJ8u8Ik+5p
 SVYjVTvlxG/0MBxKr6xXNoPMXSyJBsemEc0ALjKpB9HdV5oIpb6QhfrvX3fMOUidzCbJ
 IPHy4zoJfX6v+U/XDR4IBZnivgRtQNfWl10BgyLsiKOySbgst2wqg4JttwikaT8LHDjk
 NzxwCn7L6y3BGMmJDm5qV4Tx6O8DbgVRJ47eFwgA6tkLSpEqN2dTDv9OWEHI6p65bSU3
 eNSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770833225; x=1771438025;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2abSkKRbNEPwfj5haOUiQaNSmPGygjWGjSSsUOEwKc4=;
 b=w0NSu6fPBBbaTdOXajDcXuDF0OTxfaeVwP0wdFvQnE7CUUx/yr3ubH9+eq9VoqCEZB
 49v3njt4yFNMrJmwX7R+jFEiWmgvLNu1BtBwxwdOXo6tqn1jNVBWy8ClPecAUjJIQGt9
 Lfinc3pLdo5v4jRJr62Bo2yUk7mL9KPwLHhdcekejCQxPelwvUN4dSFN5Eyd9J3lEOsD
 3yYIry1jGSPkK9AApI+NfiLvZvzVQ3rKv95Y+ut5Ihf9Hh+42SiPAh0d/BdwCsi3pTo+
 h9UyEn5LS6Gpcgg1wH/YDZWjiBBly8cbn1z2/BHIDLorCOTR01qk1wQTyKglsVFBJmsP
 zr3g==
X-Gm-Message-State: AOJu0Yw/1t/GQCAkWcAY1NACJlZKsXqJZY3JlGz44+lh9tU6w0k3b+p5
 SZvEnT02KRG1KGEXVj+347yqxPzm6TOuGlenEoLjqL0TamCzdJ7j9Mps4UtvZg==
X-Gm-Gg: AZuq6aIREkMmJWOsSjYixo8Ba9f1kCFeD0lrdQ9rd8OS/6/2Sqid5k+1XtrVGREkJK0
 L89cBfgO1NSFba1lurWcsH+M5BcFufelzhhz6fzPFJsZtG6hOo0q4a3xAK3fLTAxBCYcR8SAYar
 QLMPPkyxZdifXthf7JWEgHekAS+Gq/IgCISFxK+MNQrs3BzLJ0e/Fmuk8l417bffg+OCwOcSdZM
 iMZQl2mcu4fhaEDbQtzC76Umm5w0ixdOUn4VzEPxgrPdL+etRzGP4JHBTFi2hW/LbKG7CgRiLSJ
 fzWabalIKce1DKUxuFbQTMpPtChDELiR6PMJCJMID71YUjqYFZbm2tSULxlYO/stvD1OQuPZOQt
 kHNeDmjNoDSvLchKXRhx+6Hy6A0QdilWBwo+XKs9Zo4wB2fLI+jQM0/mfXYD/U1z8UCUkoGinzh
 DoMx4oPb92RkJM9yfJL18ePoKbLTxpXpiTb08uiQ9q0Q2drFn5qm/gT6RV/M4W38KjjYX1WSkdf
 mR4/yNGUozu9dtFdmWgeWbgn4rubyhUZytDUJvV1KGsa2YbTrPH1teYD50wT/Q=
X-Received: by 2002:a4a:e902:0:b0:66d:f6a5:af97 with SMTP id
 006d021491bc7-67598d27ca7mr38662eaf.23.1770833224370; 
 Wed, 11 Feb 2026 10:07:04 -0800 (PST)
Received: from james-x399.localdomain (71-218-105-26.hlrn.qwest.net.
 [71.218.105.26]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-674730110a9sm1131310eaf.5.2026.02.11.10.07.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 10:07:03 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
To: u-boot@lists.denx.de
Cc: James Hilliard <james.hilliard1@gmail.com>,
 Jamie Gibbons <Jamie.Gibbons@microchip.com>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 David Lechner <dlechner@baylibre.com>
Subject: [PATCH v4 1/1] image: fit: Apply overlays using aligned writable FDT
 copies
Date: Wed, 11 Feb 2026 11:06:44 -0700
Message-ID: <20260211180645.3313596-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 11 Feb 2026 19:13:22 +0100
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
---
 boot/image-fit.c | 163 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 124 insertions(+), 39 deletions(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index 3ed69b5f7bc..c70b7707c00 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -2368,6 +2368,75 @@ int boot_get_setup_fit(struct bootm_headers *images, uint8_t arch,
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
@@ -2380,18 +2449,12 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
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
 
@@ -2434,18 +2497,25 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
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
@@ -2489,48 +2559,61 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
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
@@ -2541,6 +2624,8 @@ out:
 		*fit_uname_configp = fit_uname_config;
 
 #ifdef CONFIG_OF_LIBFDT_OVERLAY
+	if (fdt_noffset < 0)
+		free(base_buf);
 	free(ovcopy);
 #endif
 	free(fit_uname_config_copy);
-- 
2.43.0

