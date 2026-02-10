Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 073CAEB26FD
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 19:00:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A63A8367F;
	Tue, 10 Feb 2026 20:00:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TOM8E9wZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B518D8388D; Tue, 10 Feb 2026 19:55:06 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B6CF8366F
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 19:55:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7d1866473b0so3442292a34.1
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 10:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770749703; x=1771354503; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xXes4qrXHroI/2gAt1p+W1wSHvU9FM/IraXzq7dSC7g=;
 b=TOM8E9wZwV3xtMbk08M8Q6DwiA1uXH3GXkVyT3A+dZEuwEBJLjlpQArJ5HLtCwRG56
 WcjJdiBDoo7gayCaJfAKCOti5t3UcKcMcM7IAjtF0/MytfSSDLxxKoqdzcWpdlHdv6S5
 b3yxFJjT3Nd5TxLTJN9U/IBDz/0IiXjGIPq9O7gcFMKP9GP8oOPB1DDuj3X8cer7+s0d
 szQm53743B6jSIXnFkLQGIXn2KtHI09zVLQN5gZooNBVWteENX6halc269Ll8b69DbOe
 7HMscQiRSspjv+39XbV3ktmunY/4wUVJ6ySt01Nz653u56UabbcfQDYibFiS7KcsQCsq
 eAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770749703; x=1771354503;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xXes4qrXHroI/2gAt1p+W1wSHvU9FM/IraXzq7dSC7g=;
 b=LEJkjeqzsspdUqAAAL1jdZmK17EH6ewb//+44quLsuIvLSISRw6wcmBC1pdDn4EtNh
 btzU37Ai3aWBl8UUtJw2D7EGMdxQGAk/GphQGcA37nW+uQtZ7/JdxnIm+JIcTh0Fsvur
 yU4ZMq7rSZqaRSHaI4jBO37L5An5Iduw0rVRLmPVeoP2vJDmYEevHIXuI8ixL11kpTs9
 2bu/aVC+k2ab+ty2br+L1+6ot/7VwVCnaHqpb/jtkFzzUoUNYaI9aXXk0kPR1FSR4XVQ
 OjhU0JqKRRd6HAydrVr8bhA4nLYywWHS1B0W5JY2UYvi2xpVNB/MERFyrDdKloIAg8g6
 qP0Q==
X-Gm-Message-State: AOJu0YyxSDh9Uv/wRPVh8wPl6+zYtN+EFVqIi7EO8zTeYSNzaU8KP9G2
 P9A8K7Gg+3DgXYbCrx3pFlwhzY6NyFH+AULoUdPyXUOw7R2EiyRbxu3gQPr8mQ==
X-Gm-Gg: AZuq6aL8pu+ZKIHrxOf2lTzx3zFDddilWMzGRBkrcseiaUvgZVssPm1dd1yBEyCLECa
 rg66s/hff+6KJ5CRf/itZc2/RacDiKtWkFXpOPczqzCHiOygYXvIzXtegCR0tjUvciYdpCwAeLC
 Vt46JwQ9kwOWavpGcZcdaNzeRQHK0Pch9yxJVcm/nCYfM36aZGrRuJ2ylXqjBXV0CM3yEyoZ7UU
 fcDqhixT0T+IEiR/OIte10vr8XAeScKdum8phr5OKTvmOeYXuVHCh5uzht72eH0TJEreS6tEfiI
 BI6B8Jz7b76cDWlB8tSoBTW9thEmug0U1tdablBAr5eKcOX52bcqHokX6/myWrxNpUniVUmDS57
 gV/5G4zZilxqhSRxNdN+jk+o8L2cCJFIiQLwMnXWHh1GiF0rOUV6CRugEwFxg85qt2D4Rawg9+v
 gQdIhm0SD7gK8vxS/SrCb7CfZQAbBy7ZWNQlpg9ok82hZ3gFgMdLSQlwkVxP8t5SptPJQ1zw0eU
 foMAV06VPFFezn6Txul/Fa03SS1zl4FKUOeGn81LHoRyTwoGl9ceDaTHr7awWo=
X-Received: by 2002:a05:6830:2b21:b0:7ce:2b15:de88 with SMTP id
 46e09a7af769-7d4998bba07mr1586750a34.26.1770749702794; 
 Tue, 10 Feb 2026 10:55:02 -0800 (PST)
Received: from james-x399.localdomain (71-218-105-26.hlrn.qwest.net.
 [71.218.105.26]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d46479964fsm10194046a34.22.2026.02.10.10.55.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 10:55:02 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
To: u-boot@lists.denx.de
Cc: James Hilliard <james.hilliard1@gmail.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v2 1/1] image: fit: Apply overlays using aligned writable FDT
 copies
Date: Tue, 10 Feb 2026 11:54:54 -0700
Message-ID: <20260210185455.2409242-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 10 Feb 2026 20:00:28 +0100
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
---
Changes v1 -> v2:
  - also fix alignment issues
---
 boot/image-fit.c | 158 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 118 insertions(+), 40 deletions(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index 41ab1f552b0..68fb75c8389 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -2344,6 +2344,52 @@ int boot_get_setup_fit(struct bootm_headers *images, uint8_t arch,
 }
 
 #ifndef USE_HOSTCC
+#ifdef CONFIG_OF_LIBFDT_OVERLAY
+static int boot_get_fdt_fit_into_buffer(const void *src, ulong srclen,
+					ulong extra, ulong min_dstlen,
+					void **fdtdstbuf, ulong *fdtdstlenp)
+{
+	const void *fdtsrcbuf;
+	void *tmp = NULL;
+	ulong fdtdstlen;
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
+	fdtdstlen = ALIGN(fdt_totalsize(fdtsrcbuf) + extra, SZ_4K);
+	min_dstlen = ALIGN(min_dstlen, SZ_4K);
+	if (fdtdstlen < min_dstlen)
+		fdtdstlen = min_dstlen;
+
+	*fdtdstbuf = memalign(8, fdtdstlen);
+	if (!*fdtdstbuf) {
+		free(tmp);
+		return -ENOMEM;
+	}
+
+	err = fdt_open_into(fdtsrcbuf, *fdtdstbuf, fdtdstlen);
+	free(tmp);
+	if (err < 0) {
+		free(*fdtdstbuf);
+		*fdtdstbuf = NULL;
+		return err;
+	}
+
+	*fdtdstlenp = fdtdstlen;
+
+	return 0;
+}
+#endif
+
 int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
 		     const char **fit_unamep, const char **fit_uname_configp,
 		     int arch, ulong *datap, ulong *lenp)
@@ -2356,18 +2402,12 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
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
 
@@ -2410,18 +2450,27 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
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
+		if (err == -ENOMEM)
+			printf("Required FDT copy for applying DTOs failed: out of memory\n");
+		else
+			printf("Required FDT copy for applying DTOs failed: %s\n",
+			       fdt_strerror(err));
+		fdt_noffset = err;
 		goto out;
 	}
 
-	load = (ulong)of_flat_tree;
+	len = fdt_off_dt_strings(base_buf) + fdt_size_dt_strings(base_buf);
 
 	/* apply extra configs in FIT first, followed by args */
 	for (i = 1; ; i++) {
@@ -2465,46 +2514,73 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
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
+			if (err == -ENOMEM)
+				printf("failed to duplicate DTO before application\n");
+			else
+				printf("failed on fdt_open_into for DTO: %s\n",
+				       fdt_strerror(err));
 			fdt_noffset = err;
 			goto out;
 		}
 
-		base = map_sysmem(load, len + ovlen);
-		err = fdt_open_into(base, base, len + ovlen);
-		if (err < 0) {
-			printf("failed on fdt_open_into\n");
-			fdt_noffset = err;
-			goto out;
+		/*
+		 * Ensure the base FDT buffer is open and has enough room for
+		 * the overlay. Grow it on demand.
+		 */
+		need = ALIGN(len + ovcopylen + CONFIG_SYS_FDT_PAD, SZ_4K);
+		if (need > base_buf_size) {
+			void *new_base;
+			ulong new_size;
+
+			err = boot_get_fdt_fit_into_buffer(base_buf, base_buf_size,
+							   0, need, &new_base,
+							   &new_size);
+			if (err < 0) {
+				if (err == -ENOMEM)
+					printf("failed to expand FDT for DTO application\n");
+				else
+					printf("failed on fdt_open_into while expanding FDT\n");
+				fdt_noffset = err;
+				goto out;
+			}
+
+			free(base_buf);
+			base_buf = new_base;
+			base_buf_size = new_size;
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
@@ -2515,6 +2591,8 @@ out:
 		*fit_uname_configp = fit_uname_config;
 
 #ifdef CONFIG_OF_LIBFDT_OVERLAY
+	if (fdt_noffset < 0)
+		free(base_buf);
 	free(ovcopy);
 #endif
 	free(fit_uname_config_copy);
-- 
2.43.0

