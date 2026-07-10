Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1B8DC43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 13:23:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BB1284AC5;
	Fri, 10 Jul 2026 15:23:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="I2FcvwhB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7588084A9E; Fri, 10 Jul 2026 15:13:57 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53C3884A8D
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 15:13:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 038113FA70
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 13:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1783689235;
 bh=RJ3GGnhNuZDAEpYzr1/55Hs/JSfFvDwwEhVJ1zumPzM=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=I2FcvwhBgo7QcSyYaCSZ1lXmS1E0T7tAIFb8S6xz+I4xeq4zpKdpxQUYVuGqzUEtG
 SoikrX98+wOZjzrJkpm6Y/mjRLhZabUDi6XKa7VX9u/aPLqG2os0CEyku+3t3IeyvE
 FzRwrYeHpbWOzpFmfM0X17PdYQ5SPQB1+cHgpTuowjwmPAOuNN6aLk6R9L4iE9mInx
 1TDKqzXb6Sm2ALnhvQQUts1GrBkukTSgBOcS3rHPuK9NRa8TLZs1kNWGdw6+Xdkijs
 av3vBGUULdIEe2mEOAJyaAaAURZIiZXjNfHVDjcfkdRhasM3gPLPN4DVvmy/VZYAsj
 9rkpI7gExLnWoxRBzctxtqcL4/kxwQWRNxfb017I7OruQNkloFxpCZVqEJ/k5Fkbgd
 ijPcV2arenRitNp5qI+FxojOyI8x3lvX94Nz6YH8+k7LjYc6guCuXpt4QGerUxtsST
 KPS091udLPv8LCOADU82trRuojl0XHWiON3hM21idrgSyibhBNq3Zn9Djo/cAUsisZ
 s6xAcGXUH3tcYgZNENvFK7ZHIkE1+RgUd2jhFwN/2RU9CD4YEE7Yi4208wGlIefm/J
 DXzIArE4b8hN0lN7hKQpqP/a/MIFDQFN8WNzkUx4d+p8EeiUmBk3KENLK2MUX4Lw23
 URzg4Fv7NTapnSWMEdU1n614=
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-848452dd146so2567140b3a.2
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 06:13:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783689233; x=1784294033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RJ3GGnhNuZDAEpYzr1/55Hs/JSfFvDwwEhVJ1zumPzM=;
 b=Ur0Q8mMahptW6+Cqp5R4r0ElMYWeRMHDKNVkCbQxNPTiPJWfK4v6LMbETIlLJNkpWh
 8jyrE0kcVV83x4g/6KwXGOY8K/Opzz9Zbm7HPj/DaI0+fpTGWmVVupGbwzJbe0EmcPMA
 Hwqsx8vgHkBuJ3RxluRgmXBrU7yD2NjUylxxwI0typLHntmPHkI5En/iJhftlE/gYaUu
 rD0qjUkH+WhlT9lwTzDQXQtWce2NaA/Y+ljLyzUyXdVGc4uEoN14T5JxIE0h8P+TB3J7
 EeE2FEvIoGTAGaPt9nZPGmtiACBirxPjwvhRtqEg7og1Y4K/v6eD0a6qSQyYvkD3E6zB
 CVmQ==
X-Gm-Message-State: AOJu0YyihbYbyCcBasWWHvvdph4e3J00al3CjmpReTCIp0Zx8emOHc+P
 XFe9DewapFyFleRvhPonUj+Q6YlpwbtlClSLiq0WhEyeM+SXUOsEFoXnIG99r3p5ERDIXZfdQ4O
 fXaVyDyYT1Jy9yQB2pyTeEMC/C3VHqTbnB3xCAYFS7pXnJDBk5sP1wInOTgV98/oaKUnD1zEo2t
 MWX1s=
X-Gm-Gg: AfdE7cn7C9546CQqWP39Tvxspdhd+kaOATUVeFOGKEcDcy8Z4Rb9gUO8Q8dBd8fvYBC
 lqnUDU0pkumjIWNL7AX0SX0+fM2ElMRMyZFLd3M2pwPhL6tQKbm6khVK75mngvA4wYc85EI0KEv
 LFfuFysV1yrsMXH9qKM2g6UXIDGAMaua7W4MNwpDIEfAtR3lzVzYlbnyVK+cP/8y1eQenD4ujsM
 FPShnKu+Aq47DBoHVXcg2BPozapzFT2NPsdIJtS0HbQx91EPBA4qp+y4YZUKW+r+o7xbvBz2+Sx
 AZ9j3rhi8DaB3VqlEOKEqPYH2aDMUUbh6vmml18nrYNuDIEn250g4BEpCJVhYyRHMcZwSIoyOzF
 gWCcbAzixB4w5v3skCCfNkF5SWU8EbLi6CHPzy63xWMaqH9b+mfMqrheErzsnI9x9Oj6Gfn6HKv
 VveRyx
X-Received: by 2002:aa7:888e:0:b0:848:2f77:e2d8 with SMTP id
 d2e1a72fcca58-8484390d246mr10306991b3a.65.1783689233022; 
 Fri, 10 Jul 2026 06:13:53 -0700 (PDT)
X-Received: by 2002:aa7:888e:0:b0:848:2f77:e2d8 with SMTP id
 d2e1a72fcca58-8484390d246mr10306964b3a.65.1783689232467; 
 Fri, 10 Jul 2026 06:13:52 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8483262a17dsm5650461b3a.4.2026.07.10.06.13.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 06:13:51 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 Nora Schiffer <nora.schiffer@ew.tq-group.com>,
 Ludwig Nussel <ludwig.nussel@siemens.com>,
 Daniel Golle <daniel@makrotopia.org>
Subject: [PATCH v2] bootm: teach handle_decomp_error() about the noload
 decompression buffer
Date: Fri, 10 Jul 2026 13:13:29 +0000
Message-ID: <20260710131331.1388164-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260705145445.2339-1-aristo.chen@canonical.com>
References: <20260705145445.2339-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 10 Jul 2026 15:23:55 +0200
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

For a compressed kernel_noload image, bootm_load_os() allocates a
per-image decompression buffer of ALIGN(image_len * 8, SZ_1M) rather
than the global CONFIG_SYS_BOOTM_LEN. When decompression fails on that
path, handle_decomp_error() still prints

    Image too large: increase CONFIG_SYS_BOOTM_LEN

which is misleading: increasing CONFIG_SYS_BOOTM_LEN does not help
because the smaller per-image buffer is the actual bound. Commit
2ff26c1e378d ("bootm: fix overflow of the noload kernel decompression
buffer") worked around this by printing a follow-up note right after
handle_decomp_error() returned, but the boot log then reads as two
contradictory sentences.

Introduce enum bootm_decomp_limit and pass it into
handle_decomp_error() so the helper picks the right message in one
place. For the per-image path it now prints

    Image too large for the per-image decompression buffer (0x100000 bytes)

quoting the actual buffer size; the global path is unchanged. Drop the
trailing note in bootm_load_os() so only one line is printed.

Suggested-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
Reviewed-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
 - Use %#zx and drop the (ulong) cast on buf_size, which is size_t. (Simon)
 - Reword the per-image "Image too large" message to say
   "per-image decompression buffer" instead of hard-coding
   "kernel_noload", matching the generic name of the enum, and update
   the sample output in the commit message to match. (Simon)
 - Drop the accidental double "noload" in the enum kerneldoc example.
 - Carried Tom's and Simon's Reviewed-by; all above are cosmetic and
   don't change the semantics.

 boot/bootm.c | 38 +++++++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index 803d6406be4..3bce8586834 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -575,6 +575,18 @@ static int bootm_find_other(ulong img_addr, const char *conf_ramdisk,
 #endif /* USE_HOSTC */
 
 #if !defined(USE_HOSTCC) || defined(CONFIG_FIT_SIGNATURE)
+/**
+ * enum bootm_decomp_limit - What bounded the decompression buffer.
+ * @BOOTM_DECOMP_LIMIT_GLOBAL:    Global CONFIG_SYS_BOOTM_LEN limit.
+ * @BOOTM_DECOMP_LIMIT_PER_IMAGE: Per-image buffer sized from the
+ *                                compressed image (e.g. the
+ *                                kernel_noload decompression buffer).
+ */
+enum bootm_decomp_limit {
+	BOOTM_DECOMP_LIMIT_GLOBAL,
+	BOOTM_DECOMP_LIMIT_PER_IMAGE,
+};
+
 /**
  * handle_decomp_error() - display a decompression error
  *
@@ -585,11 +597,14 @@ static int bootm_find_other(ulong img_addr, const char *conf_ramdisk,
  * @comp_type:		Compression type being used (IH_COMP_...)
  * @uncomp_size:	Number of bytes uncompressed
  * @buf_size:		Number of bytes the decompresion buffer was
+ * @limit:		Which allocation actually bounded the buffer, so the
+ *			hint points at the knob the reader can act on
  * @ret:		errno error code received from compression library
  * Return: Appropriate BOOTM_ERR_ error code
  */
 static int handle_decomp_error(int comp_type, size_t uncomp_size,
-			       size_t buf_size, int ret)
+			       size_t buf_size,
+			       enum bootm_decomp_limit limit, int ret)
 {
 	const char *name = genimg_get_comp_name(comp_type);
 
@@ -598,10 +613,15 @@ static int handle_decomp_error(int comp_type, size_t uncomp_size,
 		return BOOTM_ERR_UNIMPLEMENTED;
 
 	if ((comp_type == IH_COMP_GZIP && ret == Z_BUF_ERROR) ||
-	    uncomp_size >= buf_size)
-		printf("Image too large: increase CONFIG_SYS_BOOTM_LEN\n");
-	else
+	    uncomp_size >= buf_size) {
+		if (limit == BOOTM_DECOMP_LIMIT_PER_IMAGE)
+			printf("Image too large for the per-image decompression buffer (%#zx bytes)\n",
+			       buf_size);
+		else
+			printf("Image too large: increase CONFIG_SYS_BOOTM_LEN\n");
+	} else {
 		printf("%s: uncompress error %d\n", name, ret);
+	}
 
 	/*
 	 * The decompression routines are now safe, so will not write beyond
@@ -628,6 +648,7 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
 	ulong image_start = os.image_start;
 	ulong image_len = os.image_len;
 	ulong decomp_len = CONFIG_SYS_BOOTM_LEN;
+	enum bootm_decomp_limit decomp_limit = BOOTM_DECOMP_LIMIT_GLOBAL;
 	ulong flush_start;
 	bool no_overlap;
 	void *load_buf, *image_buf;
@@ -644,6 +665,7 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
 		phys_addr_t addr;
 
 		decomp_len = ALIGN(image_len * 8, SZ_1M);
+		decomp_limit = BOOTM_DECOMP_LIMIT_PER_IMAGE;
 		err = lmb_alloc_mem(LMB_MEM_ALLOC_ANY, SZ_2M, &addr,
 				    decomp_len, LMB_NONE);
 		if (err)
@@ -663,10 +685,7 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
 			   decomp_len, &load_end);
 	if (err) {
 		err = handle_decomp_error(os.comp, load_end - load,
-					  decomp_len, err);
-		if (os.type == IH_TYPE_KERNEL_NOLOAD && os.comp != IH_COMP_NONE)
-			printf("Note: noload decompression buffer is %#lx bytes (not CONFIG_SYS_BOOTM_LEN)\n",
-			       decomp_len);
+					  decomp_len, decomp_limit, err);
 		bootstage_error(BOOTSTAGE_ID_DECOMP_IMAGE);
 		return err;
 	}
@@ -1288,7 +1307,8 @@ static int bootm_host_load_image(const void *fit, int req_image_type,
 	free(load_buf);
 
 	if (ret) {
-		ret = handle_decomp_error(image_comp, load_end - 0, buf_size, ret);
+		ret = handle_decomp_error(image_comp, load_end - 0, buf_size,
+					  BOOTM_DECOMP_LIMIT_GLOBAL, ret);
 		if (ret != BOOTM_ERR_UNIMPLEMENTED)
 			return ret;
 	}
-- 
2.43.0

