Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E8B6C02180
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 01:29:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B846E806FE;
	Thu, 16 Jan 2025 02:28:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CCnKuDF+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B80A080793; Thu, 16 Jan 2025 02:28:07 +0100 (CET)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7B5780786
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 02:28:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-844e1eb50e2so13757439f.0
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 17:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736990882; x=1737595682; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+0Hlgb9yw82Y+5RZzizEgRdghBr2FRa2s3+HhQkY9C4=;
 b=CCnKuDF+azUVT2ozhKj0iS+cDGW2Z5ObgDswhhAx/bI1cTKhlxoK0l46bT3ye3t7R5
 UCMOATekm0S28ZYHGgl6OpRxcIdrDbVXWBT0p4c5FDlSrxlm6GES+SMzjrPQkD1Y15rp
 SOO4poTpYChWAONH50htnz9KDjDuFqUvvQLkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736990882; x=1737595682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+0Hlgb9yw82Y+5RZzizEgRdghBr2FRa2s3+HhQkY9C4=;
 b=s1IdyV8pmBwJPLE8MDcQ6S7CBzHgQ4uDgE9CeW5rZphE8XgyZMd0zPzlZ5bG6oF34l
 wYg8L+Ul232Kk355aPcZHdlNxDp0EEkLMF63d3umNzVxa9psAZMyUTtTRQfyzywACi4H
 0oya5axyA8SkUM/OxgQWgbvP2qa5GcVAyAGSX55WDUzyr+SF8Ll+2lkYfP4NfYPapgzc
 RUIRsav+bFSo6WyhxwaOx4bLRzp9pWmInRQbykaYXTFqGmkglQPUWvZu4o4Xri4ByCzZ
 ASrbsFf+ct42LKF8BC6IdDNn3wnduoSsH4egiea7+S2qkUhY8l6xQ+zgaC/pAHimOnV7
 B6Tg==
X-Gm-Message-State: AOJu0Yxhbcc6cMYHaInDV1ubefkahUtCf4tsaBGBf1D09DeWyOIIz//4
 /HlB53pt+coL/yBb31nj0NQsx+7XyRuUHvkUWc8jpav6Y+IzCXEuWdyguBi1hds5DaO1vpUz9WI
 =
X-Gm-Gg: ASbGncvVl9UwnZjEpGGd9oEPqSGkKOt0Cxzx9ZhvRIp4SUwxWRbKHGpb9vAnAAiHVa4
 LyOxe4Ost84m/PwNmS8EyfyKuHUzNmdBsdpTpMjBWRZiA7bBa+Cn9YEI/N0TalXdVmP602MHiLH
 e/yDDqwnmv3kYA/6sb7bFmaUve8lUpF/JDAuimOjbW4Zd7Xs6ihBj+UHJwXT6+nAaw1f8y05L1/
 XyAH5AvOPlpROk6a0wFW3/R0id9VqQlcFAqcUQWkii2/GzqAx0CWHHgAyVwY9F+wpzEn0iw2U9a
 cLwJ/1BTQjo6oacDPQ==
X-Google-Smtp-Source: AGHT+IG1+D2Y2/C1duwF7LTHInru2htwOsYVouZyZgJNxt0eDXqnlUdP1S0FxAtakrJK3+PPfJ4oTw==
X-Received: by 2002:a05:6e02:1a2f:b0:3ce:6758:2500 with SMTP id
 e9e14a558f8ab-3ce67582947mr117075595ab.13.1736990882349; 
 Wed, 15 Jan 2025 17:28:02 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3ce4add8570sm42587725ab.32.2025.01.15.17.28.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 17:28:01 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 10/22] vbe: Allocate space for the FIT header
Date: Wed, 15 Jan 2025 18:27:11 -0700
Message-Id: <20250116012723.2820301-11-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250116012723.2820301-1-sjg@chromium.org>
References: <20250116012723.2820301-1-sjg@chromium.org>
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

(no changes since v1)

 boot/vbe_common.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/boot/vbe_common.c b/boot/vbe_common.c
index 0105d550bdf..5f45724f74b 100644
--- a/boot/vbe_common.c
+++ b/boot/vbe_common.c
@@ -114,6 +114,7 @@ int vbe_read_fit(struct udevice *blk, ulong area_offset, ulong area_size,
 	struct bootm_headers images = {};
 	enum image_phase_t phase;
 	struct blk_desc *desc;
+	ulong aligned_size;
 	int node, ret;
 	void *buf;
 
@@ -133,20 +134,37 @@ int vbe_read_fit(struct udevice *blk, ulong area_offset, ulong area_size,
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
 
@@ -169,7 +187,9 @@ int vbe_read_fit(struct udevice *blk, ulong area_offset, ulong area_size,
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

