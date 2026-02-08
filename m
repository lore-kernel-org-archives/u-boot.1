Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3073EF06FB
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 00:07:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 244C08341A;
	Mon,  9 Feb 2026 01:07:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LQhe8adz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1A9083642; Sun,  8 Feb 2026 23:37:43 +0100 (CET)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77C9E805D7
 for <u-boot@lists.denx.de>; Sun,  8 Feb 2026 23:37:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-662f5c4665eso1418716eaf.2
 for <u-boot@lists.denx.de>; Sun, 08 Feb 2026 14:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770590260; x=1771195060; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IqFq8nsYflsqyI3/dCnBG7Qn9qujfSH4rQSEYDqIUB8=;
 b=LQhe8adzjBN2Vu9FxGrDxB1hAuS/adogo2ip97/GBBn3zFQFqOVOsSIkqmdIaqnkWN
 S6OquAx7eZxbmKIJK0H1rUyj+/dJDO20JBdhE1lW9nlZ+HfvrifdE4F13GJiMzA/U4Rp
 0CzbGgOoEwIn8PTLpBcgV6RNzJ3GvqgFIEvuJkqn/JVei+zuJVoiT9ATAYA0xELuWf0K
 KTa8gKV94fVgqx07goNsP2nwRS2XA9hvODRAUeUut7k8GOhlosogvadVDOuUgJOTigLO
 bvNGSoDxh5GcZLRDv1dbVx14KGb6QZga6NmDKIRV1t/5wkBRrhcaT4xl65r/wupbqBuK
 kd0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770590260; x=1771195060;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IqFq8nsYflsqyI3/dCnBG7Qn9qujfSH4rQSEYDqIUB8=;
 b=pTnSxNdLgTsoUMcKCFCkmLSQZj1EXkahv51BmgAcjyXxMFBw9TSKyGiJ4uXwvXnlWo
 aKhJw+8FO1/yGwIWAN/I0tSeVZKy344/urVU3M99zdZ7b+h3IGpAs8O6PY+Y4Bl4OOsR
 NISI6UKiJnfqYCsPEL6nWpBvwyhDWrIkN1RqmBN+BDZnWUUbAhZh50L4ix6yhwUnWi6x
 kHsAVjTVOfZa3y0fk2tw/U0ai2VhlUj2HaRvgDa3JELT0wxhtPqgG5ccNSjVDqTJAbph
 5a7gh78GUZJ3CD6l6NTOK1x7be1ED00JwW81iAmbqnVEkpizGvV80WwW9GzX+W+9LjQI
 oqIQ==
X-Gm-Message-State: AOJu0YzeYdNOUGzW+3vpkho6eS5rDvwF+OjJvbeH2Z1+6gPPbzud3uAe
 dV6hppcte25UdSH+7gZo0jcSxEHDdy88b6ysKTpnei1imStJt0u/tWxBqMRYhg==
X-Gm-Gg: AZuq6aJQ+EcMXY+vKq8ukb6cPGwXihm2+yu1lViUzS7Y0NLNAVqKVhTWYoHv0sUbKcT
 n7JyG1R+RvdRPsJYt9DUgvX5YcI6L87Z68wqIfdfXDLcA2mJLO30Mc559CY0UV514XSIUWibuN6
 Vz8sz2DpZ7mxAqaleD1JLM1v+15aIaGTPqAmi8UegmEzLpN5FD2J9O8EvlTGCNVpD5wzXIBg+VJ
 1w6oXA8CHKnvtptY0eijtzN+Tyjz0T54P6rme26TUy0nGM2oEfz7byiSTXOgyFJkNwZKJXMdAS1
 NH/7KDw10oIzJtXCJwnEoYiiMKZyjG9vIN+HWjou2zaWkzaQS1SsF5jJIoMNgsL9riVkPFIz7QH
 LDYrJzE9hrhu98rMQC+JMOCnV6G1WsE/1bf73crSOFvalpK9k2RQ9K4blxrqEy21hox4eZYO4bR
 O5UP8jkfz+hHgOL8MExg2Km1FlXOTn+0nEESW0d1b1zn7lt3jlvU2kLizNHf2FwEFzsTciOgFoN
 ar4PDVvOzZo3dEhgdq2rBvk89KAdCjMnEOYVHL5bruPlz9ga0p67m38bE1R6Q==
X-Received: by 2002:a4a:bc85:0:b0:66d:fb53:8279 with SMTP id
 006d021491bc7-66dfb5383dcmr2467185eaf.2.1770590259580; 
 Sun, 08 Feb 2026 14:37:39 -0800 (PST)
Received: from james-x399.localdomain (71-218-105-26.hlrn.qwest.net.
 [71.218.105.26]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-66d391ae639sm4779452eaf.7.2026.02.08.14.37.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Feb 2026 14:37:38 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
To: u-boot@lists.denx.de
Cc: James Hilliard <james.hilliard1@gmail.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH 1/1] image: fit: Apply overlays on a writable FDT copy
Date: Sun,  8 Feb 2026 15:37:15 -0700
Message-ID: <20260208223715.3721340-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 09 Feb 2026 01:07:56 +0100
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

boot_get_fdt_fit() relocates the base FDT with boot_relocate_fdt()
before applying overlays. That uses the bootm memory map and can
overlap with the FIT buffer when the FIT is loaded into RAM, corrupting
data needed to load the kernel and ramdisk.

Allocate a writable copy of the base FDT with memalign() and
fdt_open_into(), grow it as needed for each overlay, and apply the
overlays to this buffer. Also check fdt_pack() errors and free the
temporary overlay copy after each application.

Fixes: 881f0b77dc8c ("image: apply FDTOs on FDT node")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 boot/image-fit.c | 91 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 67 insertions(+), 24 deletions(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index 41ab1f552b0..922a3606f47 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -2356,18 +2356,12 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
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
+	void *base, *ov, *ovcopy = NULL, *new_base;
+	void *base_buf = NULL;
+	ulong base_buf_size = 0;
 	int i, err, noffset, ov_noffset;
 #endif
 
@@ -2410,18 +2404,32 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
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
+	base = map_sysmem(load, len);
+	base_buf_size = ALIGN(fdt_totalsize(base), SZ_4K) + CONFIG_SYS_FDT_PAD;
+	base_buf = memalign(SZ_4K, base_buf_size);
+	if (!base_buf) {
+		printf("Required FDT copy for applying DTOs failed: out of memory\n");
+		fdt_noffset = -ENOMEM;
 		goto out;
 	}
 
-	load = (ulong)of_flat_tree;
+	err = fdt_open_into(base, base_buf, base_buf_size);
+	if (err < 0) {
+		printf("Required FDT copy for applying DTOs failed: %s\n",
+		       fdt_strerror(err));
+		fdt_noffset = err;
+		goto out;
+	}
+
+	load = map_to_sysmem(base_buf);
+	len = fdt_totalsize(base);
 
 	/* apply extra configs in FIT first, followed by args */
 	for (i = 1; ; i++) {
@@ -2482,8 +2490,34 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
 			goto out;
 		}
 
-		base = map_sysmem(load, len + ovlen);
-		err = fdt_open_into(base, base, len + ovlen);
+		/*
+		 * Ensure the base FDT buffer is open and has enough room for the
+		 * overlay. Grow it on demand.
+		 */
+		need = ALIGN(len + ovcopylen + CONFIG_SYS_FDT_PAD, SZ_4K);
+		if (need > base_buf_size) {
+			new_base = memalign(SZ_4K, need);
+			if (!new_base) {
+				printf("failed to expand FDT for DTO application\n");
+				fdt_noffset = -ENOMEM;
+				goto out;
+			}
+
+			err = fdt_open_into(base_buf, new_base, need);
+			if (err < 0) {
+				printf("failed on fdt_open_into while expanding FDT\n");
+				free(new_base);
+				fdt_noffset = err;
+				goto out;
+			}
+
+			free(base_buf);
+			base_buf = new_base;
+			base_buf_size = need;
+			load = map_to_sysmem(base_buf);
+		}
+
+		err = fdt_open_into(base_buf, base_buf, base_buf_size);
 		if (err < 0) {
 			printf("failed on fdt_open_into\n");
 			fdt_noffset = err;
@@ -2491,13 +2525,20 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
 		}
 
 		/* the verbose method prints out messages on error */
-		err = fdt_overlay_apply_verbose(base, ovcopy);
+		err = fdt_overlay_apply_verbose(base_buf, ovcopy);
+		if (err < 0) {
+			fdt_noffset = err;
+			goto out;
+		}
+		err = fdt_pack(base_buf);
 		if (err < 0) {
 			fdt_noffset = err;
 			goto out;
 		}
-		fdt_pack(base);
-		len = fdt_totalsize(base);
+		len = fdt_totalsize(base_buf);
+
+		free(ovcopy);
+		ovcopy = NULL;
 	}
 #else
 	printf("config with overlays but CONFIG_OF_LIBFDT_OVERLAY not set\n");
@@ -2515,6 +2556,8 @@ out:
 		*fit_uname_configp = fit_uname_config;
 
 #ifdef CONFIG_OF_LIBFDT_OVERLAY
+	if (fdt_noffset < 0)
+		free(base_buf);
 	free(ovcopy);
 #endif
 	free(fit_uname_config_copy);
-- 
2.43.0

