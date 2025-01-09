Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97DCAE77197
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 12:31:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C49AE801F5;
	Thu,  9 Jan 2025 13:30:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gAGBzz4+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA2A48005B; Thu,  9 Jan 2025 13:30:41 +0100 (CET)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42FD280658
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 13:30:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-844e1020253so25168039f.3
 for <u-boot@lists.denx.de>; Thu, 09 Jan 2025 04:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736425837; x=1737030637; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p9sl9Nipbb9lBYiTwaPEbxI4Ozj2MV3oSUFXl9zHCzU=;
 b=gAGBzz4+JLgRYYlSFMRbulPSzk8nq0kb4iaHkoHt7zlCXbOdzjzdu7Q4EAwsJdf8U6
 tN131hFnUiVIY5eRzGxNDYYDWykJvWkolpbJ4BTqRhlmImgl4aKqMWY6vcmRwTHiOH0k
 jkdJm12Gny6iUCrbpjiYE5gDPpR9kq7RlyxRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736425837; x=1737030637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p9sl9Nipbb9lBYiTwaPEbxI4Ozj2MV3oSUFXl9zHCzU=;
 b=hRh0DVgKf0fbB3KMGEtJ8JcVqAWwGqrxr8TEqa2tK1WLP8Ju4YQSDQxdH6qnkKmfC0
 BFL+L0fKaTLxeqBHcegb1ofmKQHi3g+//KFIwlehri9KipKk/1Qfk3i8KpZpo6VJsl1y
 GbxGAgKFOih0onaB7Usr0LzlcIY9vLoHrs1xkeGEmwgmWWlVIAdUUKDYzTUsW5itZTr2
 J5I1Cayn3gOXakdm+2E39Iiq4HURFhW/OFg22qJIctnaQtm474q1zht8OW9CXkkcl6oq
 P8ZFNJI9CtvSYGPHlQUFR5XFFdCEakKxImyAjXCECreUVYgDpTjMzfuKsN7YQm/Airux
 P7hA==
X-Gm-Message-State: AOJu0Yy2DVXgAmEEPOuHjRFO1ADWhv2YuC3QnI9aYTgxa0SPLozCUn2m
 Penfdxp5Zmq3Lk9aCnmHQkHIdnjjn7lIdZUvwTAdo8PcCVgYEOJ5LtE7hRb9+8Dyk1rNo/oD5i4
 =
X-Gm-Gg: ASbGncunfawUFr+2jqdEzPo3G07MMeMxczg3xAlStzyydiNPqQvx5eEGIi+QsSrY6wr
 e274L2c/NOBP0dk4bRoW+CLOWGPA3TEjFlDy/3DZTRShi6MPbfx1QsbH+T3GAnEvaiKodNN9Brx
 JMAef6hI5KMQtAOTBr9LhHtu5aRz06LpU8QToEXA8TTlebdkbD8ZC6UQePoPCu0pPPKXJ+Z14cz
 eKvR48Ig7Do/NHY9UX+xZ575vS23FTwGQAHAa5rZkzC/1eacIWmuphkoABtuGFVXfpkxcMrKzCe
 yeU+EyrGwLbsUREDOg==
X-Google-Smtp-Source: AGHT+IExo5hbP/XLTxUf8clkKIKFIFJHLw4QrSEvxC7y1HBG6lT/tvZ0tIu82i7y1ClUfrFl+czAWg==
X-Received: by 2002:a05:6e02:1f09:b0:3a7:8720:9de8 with SMTP id
 e9e14a558f8ab-3ce3a86a27amr52118455ab.5.1736425836983; 
 Thu, 09 Jan 2025 04:30:36 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f836csm281678173.20.2025.01.09.04.30.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 04:30:35 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 03/15] vbe: Allocate space for the FIT header
Date: Thu,  9 Jan 2025 05:29:58 -0700
Message-Id: <20250109123010.4005298-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250109123010.4005298-1-sjg@chromium.org>
References: <20250109123010.4005298-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

It is convenient to use TEXT_BASE as a place to hold the FIT header, but
this does not work in VPL, since SDRAM is not inited yet.

Allocate the memory instead. Ensure the size is aligned to the media
block-size so that it can be read in directly. Improve the
error-checking for blk_read() and add some more debugging.

Keep the existing TEXT_BASE mechanism in sandbox to avoid an
'Exec format error' when trying to run the image.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/vbe_common.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/boot/vbe_common.c b/boot/vbe_common.c
index c009337ef3f..d2d20cabe00 100644
--- a/boot/vbe_common.c
+++ b/boot/vbe_common.c
@@ -27,6 +27,7 @@ int vbe_read_fit(struct udevice *blk, ulong area_offset, ulong area_size,
 	struct bootm_headers images = {};
 	enum image_phase_t phase;
 	struct blk_desc *desc;
+	ulong aligned_size;
 	int node, ret;
 	void *buf;
 
@@ -46,20 +47,37 @@ int vbe_read_fit(struct udevice *blk, ulong area_offset, ulong area_size,
 	if (size > area_size)
 		return log_msg_ret("fdt", -E2BIG);
 	log_debug("FIT size %lx\n", size);
+	aligned_size = ALIGN(size, desc->blksz);
 
 	/*
 	 * Load the FIT into the SPL memory. This is typically a FIT with
 	 * external data, so this is quite small, perhaps a few KB.
 	 */
-	addr = CONFIG_VAL(TEXT_BASE);
-	buf = map_sysmem(addr, size);
-	num_blks = DIV_ROUND_UP(size, desc->blksz);
-	log_debug("read %lx, %lx blocks to %lx / %p\n", size, num_blks, addr,
-		  buf);
+	if (IS_ENABLED(CONFIG_SANDBOX)) {
+		addr = CONFIG_VAL(TEXT_BASE);
+		buf = map_sysmem(addr, size);
+	} else {
+		buf = malloc(aligned_size);
+		if (!buf)
+			return log_msg_ret("fit", -ENOMEM);
+		addr = map_to_sysmem(buf);
+	}
+	num_blks = aligned_size / desc->blksz;
+	log_debug("read %lx, %lx blocks to %lx / %p\n", aligned_size, num_blks,
+		  addr, buf);
 	ret = blk_read(blk, blknum, num_blks, buf);
 	if (ret < 0)
-		return log_msg_ret("rd", ret);
-
+		return log_msg_ret("rd3", ret);
+	else if (ret != num_blks)
+		return log_msg_ret("rd4", -EIO);
+	log_debug("check total size %x off_dt_strings %x\n", fdt_totalsize(buf),
+		  fdt_off_dt_strings(buf));
+
+#if CONFIG_IS_ENABLED(SYS_MALLOC_F)
+	log_debug("malloc base %lx ptr %x limit %x top %lx\n",
+		  gd->malloc_base, gd->malloc_ptr, gd->malloc_limit,
+		  gd->malloc_base + gd->malloc_limit);
+#endif
 	/* figure out the phase to load */
 	phase = IS_ENABLED(CONFIG_VPL_BUILD) ? IH_PHASE_SPL : IH_PHASE_U_BOOT;
 
@@ -82,7 +100,9 @@ int vbe_read_fit(struct udevice *blk, ulong area_offset, ulong area_size,
 	log_debug("loaded to %lx\n", load_addr);
 
 	/* For FIT external data, read in the external data */
-	if (load_addr + len > addr + size) {
+	log_debug("load_addr %lx len %lx addr %lx aligned_size %lx\n",
+		  load_addr, len, addr, aligned_size);
+	if (load_addr + len > addr + aligned_size) {
 		ulong base, full_size;
 		void *base_buf;
 
-- 
2.34.1

