Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9475C0218D
	for <u-boot@archiver.kernel.org>; Sun, 26 Jan 2025 18:44:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3039F80FBC;
	Sun, 26 Jan 2025 19:44:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="X9u3F/vJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A891080FD6; Sun, 26 Jan 2025 19:44:05 +0100 (CET)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 630AB80F53
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 19:44:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-844e1eb50e2so100423139f.0
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 10:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737917041; x=1738521841; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fMOccdZCng0WR6b3bkxqOmM7WDva3c8AE3gzHhrLIAk=;
 b=X9u3F/vJwZR7YvZduL6cKWLmb1TpwbKDqRawifuT0/OBAaTUuddkgl9ThutqkbEh7j
 nqO4hASI068angW0YpTiptZuTrShf/8S/B19jnYhs5NMO6914Aa02fpNUOmVd3ggbVsX
 OvA0jBwxiVdNAXAT9yBtIs1giRTiXBPf0nwc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737917041; x=1738521841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fMOccdZCng0WR6b3bkxqOmM7WDva3c8AE3gzHhrLIAk=;
 b=p2FQMIQbAB9OwJs384rtFFkoZOrCBdpfe7NvZYpKVvqJhz59yNuLsHHn7CJBmtc4hB
 5W+VQsf5m1nj6Ko5k29L6GP4oHRBIFlzcou1avZgRLAZjebn9rR5oOveid8StCCXyBiE
 gxc+PKnGPXrpklI5FcczOXCpOA1Hh5o2v0OfTWR/f2Kmp5PUL65Eyuoa2ppAf8zZc2MB
 xgSmO6KIMgJm9K32juy4TeX9PJNvSz+P1Np1O97VD7u9yap+mnbMmngF+4HpaMPMFaqi
 QGgU0O4h0RqbDmXANVqbneBMz+a787DE3Wi3ISPdOfJ8PWHRKCCyriCi42PrQi9MnRBi
 QVjQ==
X-Gm-Message-State: AOJu0YyE9/5Kr9+oQ5F3qMnwQ8a52J6xlEOWG/Ld9W/KpWhWlMPlPhp2
 0d2tsNj0/EJXzxrJ5fvQ5CI/qVhp1/SzcRswpwtZLgvatlK+uQikvcjneAIgJxhcpzI6zcCX80I
 =
X-Gm-Gg: ASbGncsdOaHBbBeEu7/DGnQLlLKWuF+dLNG/ukMTfxN0vfuGYAfhs8Bo127RN39uk80
 HARQfhdquszVUeClIpEHrUiqRzZ33t7CKr0CsIVkty9z8t7Y4p60joVOip5+4YG8Y0LRhsZhgP8
 STmq0pYBlTmaDrDYzRFoIRX6MjA5LYzCc+hE80g0LSErx4ic8P/Wlz7M/CH+/2ZwkV8CKKfl6jS
 YreGUMDbcYQH9k6Mb0LT2bJo/KzBsHUA40I59wM2oE1Ar6owg8LfAUK5dtKvuQrJcNNxj4O0kEj
 V897G/q4hftGddVHOYz/OR6J9qe3IK4fO+A1HS8YYciZTZqeWpEa
X-Google-Smtp-Source: AGHT+IFy79l5EQcjdrr5LLLHQKRGBkZV2dXZHrGM4O4F/T+NWUZ96P7do4DILE+ewHql3tHim5GK3w==
X-Received: by 2002:a05:6602:4186:b0:807:f0fb:1192 with SMTP id
 ca18e2360f4ac-851b6169a31mr3155724339f.1.1737917041424; 
 Sun, 26 Jan 2025 10:44:01 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ec1da317fesm2160641173.42.2025.01.26.10.43.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jan 2025 10:44:00 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 07/19] spl: Support selecting images based on phase in simple
 FIT
Date: Sun, 26 Jan 2025 11:43:17 -0700
Message-ID: <20250126184333.4058848-8-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250126184333.4058848-1-sjg@chromium.org>
References: <20250126184333.4058848-1-sjg@chromium.org>
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

At present the simple FIT-loader always loads images, ignoring whether
they are intended for the next phase or not.

VBE packages up several images in the same FIT, some destined for VPL
and some for SPL. Add logic to check the phase before loading the
image. Return -EPERM in that case and handle it gracefully.

Fix a unnecessary re-computation of read_offset while here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/spl/spl_fit.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index ac8462577ff..6c068a842d9 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -199,7 +199,9 @@ static int get_aligned_image_size(struct spl_load_info *info, int data_size,
  *		the image gets loaded to the address pointed to by the
  *		load_addr member in this struct, if load_addr is not 0
  *
- * Return:	0 on success or a negative error number.
+ * Return:	0 on success, -EPERM if this image is not the correct phase
+ * (for CONFIG_BOOTMETH_VBE_SIMPLE_FW), or another negative error number on
+ * other error.
  */
 static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 			   const struct spl_fit_info *ctx, int node,
@@ -218,6 +220,25 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 	const void *fit = ctx->fit;
 	bool external_data = false;
 
+	log_debug("starting\n");
+	if (CONFIG_IS_ENABLED(BOOTMETH_VBE) &&
+	    xpl_get_phase(info) != IH_PHASE_NONE) {
+		enum image_phase_t phase;
+		int ret;
+
+		ret = fit_image_get_phase(fit, node, &phase);
+		/* if the image is for any phase, let's use it */
+		if (ret == -ENOENT || phase == xpl_get_phase(info)) {
+			log_debug("found\n");
+		} else if (ret < 0) {
+			log_debug("err=%d\n", ret);
+			return ret;
+		} else {
+			log_debug("- phase mismatch, skipping this image\n");
+			return -EPERM;
+		}
+	}
+
 	if (IS_ENABLED(CONFIG_SPL_FPGA) ||
 	    (IS_ENABLED(CONFIG_SPL_OS_BOOT) && spl_decompression_enabled())) {
 		if (fit_image_get_type(fit, node, &type))
@@ -278,10 +299,7 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 		log_debug("reading from offset %x / %lx size %lx to %p: ",
 			  offset, read_offset, size, src_ptr);
 
-		if (info->read(info,
-			       fit_offset +
-			       get_aligned_image_offset(info, offset), size,
-			       src_ptr) < length)
+		if (info->read(info, read_offset, size, src_ptr) < length)
 			return -EIO;
 
 		debug("External data: dst=%p, offset=%x, size=%lx\n",
@@ -456,7 +474,9 @@ static int spl_fit_append_fdt(struct spl_image_info *spl_image,
 			image_info.load_addr = (ulong)tmpbuffer;
 			ret = load_simple_fit(info, offset, ctx, node,
 					      &image_info);
-			if (ret < 0)
+			if (ret == -EPERM)
+				continue;
+			else if (ret < 0)
 				break;
 
 			/* Make room in FDT for changes from the overlay */
@@ -817,7 +837,7 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
 
 		image_info.load_addr = 0;
 		ret = load_simple_fit(info, offset, &ctx, node, &image_info);
-		if (ret < 0) {
+		if (ret < 0 && ret != -EPERM) {
 			printf("%s: can't load image loadables index %d (ret = %d)\n",
 			       __func__, index, ret);
 			return ret;
-- 
2.43.0

