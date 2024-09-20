Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86B46CF58DD
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 08:15:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDD2B893FE;
	Fri, 20 Sep 2024 10:13:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Itbn6uUL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7FD489456; Fri, 20 Sep 2024 10:13:43 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF2F1893FE
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 10:13:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5c25554ec1eso2296440a12.1
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 01:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726820021; x=1727424821; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dqrR2g4vRbRxqTzt6nDklN7XppB6y0QBRyTd5zPGYqE=;
 b=Itbn6uULMUtYX2j6hZqmso8OMagkNOfRF8RNQwfxZee6PFsxrIiCFEHJKm+kaNpXsB
 WEbHG5M85JWONY1vfyhJrMPSNXEecaD1mEWvz9T/2JIVdy+yAF8g5TPFVf41MLl5NP0i
 PcBY/QnoOxd0yb7k0W1hvEOdB8f9L9dGLLZN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726820021; x=1727424821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dqrR2g4vRbRxqTzt6nDklN7XppB6y0QBRyTd5zPGYqE=;
 b=nHQgntM4hEHlMc5UVAP9gvDOKMPtvnJXbzwoOnJZ+gN5EbNWT+kJwNwUGPO86vqADY
 vM6hdKijG+1C1MQXEYBeTbW7wwkQ3FIQszoB0nTpMr2zHPBe44AthhofRF9t30uOD2a4
 JOZoqiPNO9ZDB/Tqh4zM2R856xXjx5B6ZY7ochdphxBD9bPRNUqQbQSOm6UB2ABvd7b9
 O4vr2hrGdgw/riJvtOJ1jhKQL8cVoWNtTkZthXxIegIYc1v018yOgSSnZV6GiRRwCvtQ
 3uhDsOVA4it1I6yt/wCxKDmFGTxFkkIIJ5WOYJr4XQErTQwlbS38LrXJp07bKk+8CTYG
 e94w==
X-Gm-Message-State: AOJu0YwGE8MjxZXzw25dTyNZqEVpHX0YM77Qcr/m7XuEoxNT6S4CgOQs
 JsIR+gM8yQGhL57QqaYEHugrXS94esuuUcO0cJO8KgRiilSqy2DHC8SkAeteKpiS/n7kkbl4cdq
 xz0pu
X-Google-Smtp-Source: AGHT+IGJ3tPDI7T4jOKz3+cIWDxoetGI+nayGrbz/M/4sWk5VW82K5uTD4tNJ9pCDQA1ei5UiWQNIQ==
X-Received: by 2002:a05:6402:278b:b0:5c2:6083:6256 with SMTP id
 4fb4d7f45d1cf-5c464db69d9mr1116226a12.10.1726820021101; 
 Fri, 20 Sep 2024 01:13:41 -0700 (PDT)
Received: from chromium.org ([83.68.141.146]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c42bc88cf7sm6804447a12.90.2024.09.20.01.13.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 01:13:39 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Kever Yang <kever.yang@rock-chips.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Marek Vasut <marex@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Suniel Mahesh <sunil@amarulasolutions.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 13/18] spl: Add some more debugging to load_simple_fit()
Date: Fri, 20 Sep 2024 10:12:52 +0200
Message-ID: <20240920081309.140426-14-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240920081309.140426-1-sjg@chromium.org>
References: <20240920081309.140426-1-sjg@chromium.org>
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

Add debugging of image-loading progress. Fix a stale comment in the
function comment while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/spl/spl_fit.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 614dea9ae18..303d5416b59 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -190,7 +190,7 @@ static int get_aligned_image_size(struct spl_load_info *info, int data_size,
 /**
  * load_simple_fit(): load the image described in a certain FIT node
  * @info:	points to information about the device to load data from
- * @sector:	the start sector of the FIT image on the device
+ * @fit_offset:	the offset of the FIT image on the device
  * @ctx:	points to the FIT context structure
  * @node:	offset of the DT node describing the image to load (relative
  *		to @fit)
@@ -243,11 +243,14 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 	if (!fit_image_get_data_position(fit, node, &offset)) {
 		external_data = true;
 	} else if (!fit_image_get_data_offset(fit, node, &offset)) {
+		log_debug("read offset %x = offset from fit %lx\n",
+			  offset, (ulong)offset + ctx->ext_data_offset);
 		offset += ctx->ext_data_offset;
 		external_data = true;
 	}
 
 	if (external_data) {
+		ulong read_offset;
 		void *src_ptr;
 
 		/* External data */
@@ -270,6 +273,10 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 
 		overhead = get_aligned_image_overhead(info, offset);
 		size = get_aligned_image_size(info, length, offset);
+		read_offset = fit_offset + get_aligned_image_offset(info,
+							    offset);
+		log_debug("reading from offset %x / %lx size %lx to %p: ",
+			  offset, read_offset, size, src_ptr);
 
 		if (info->read(info,
 			       fit_offset +
@@ -336,6 +343,7 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 		else
 			image_info->entry_point = FDT_ERROR;
 	}
+	log_debug("- done loading\n");
 
 	upl_add_image(fit, node, load_addr, length);
 
-- 
2.43.0

