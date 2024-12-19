Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43946E7718A
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 18:31:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 909E4803CB;
	Thu, 19 Dec 2024 19:29:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Pjuf+Wqq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D222D8035E; Thu, 19 Dec 2024 19:29:48 +0100 (CET)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92B67802B4
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 19:29:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-844e394395aso37828139f.3
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 10:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734632985; x=1735237785; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7fOVaUbxSDJQRCfCvQ51TYMcbMsmkYpFVeSIAd7BULc=;
 b=Pjuf+WqqS6Ie/W++0vbrcK/TMGj6w0t4LI+lVVT/ZMej6BZ6IGufjNOmwl15Y7+19k
 yztPvlob0HjgemT+hvWpqVkKCP+GVonhHApuNhr80PAOjRu7hA7xydMOskZfleiL1qcU
 0B7BT0ih6SfpPZaCDujEeh+f/Z8CSMLkmQBVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734632985; x=1735237785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7fOVaUbxSDJQRCfCvQ51TYMcbMsmkYpFVeSIAd7BULc=;
 b=ccMARU4oLiDQjq0z/NVRsA7HDv2WtJY73ViSoNAVnsdYg8XMUHSyrPsbpdSIOe13Z+
 tpYOJvtcSN3dIuN5VJU1TYr1dGKTCdDUp3rT9hHi3PcnWiW8uvkM45QVLsNeIiifNCiP
 FUaxAdE7xlVOfNrMgQegWIGf/3meKu3GvetsVFCMxRDr+S5OMYvIf6GsZQlZIrrdVMQx
 5zUKTZXjcI+YcCuxOwcmXM4kiTkfZ7dstDl7Ai6KLDRqjS09OFVQRW31hpcGWiSYA4aA
 J0Y+Db/BXn34o3uVgihwWWiDZz1ZJxHlLNIe4KU6LbhwuKMay/WijueKDx99UuQZwEtU
 gCIQ==
X-Gm-Message-State: AOJu0Yww3GsfTMOe2Pr87Zj5mXdiZYQcH4ZJ5qooUNCTGgvjjIIYgZB8
 Bketi9Cs5aZEwiZDYLVSmJYIHrvuzRQuhL90QU61Jc3EaEE+qeDckn2fhoOshMMXotxKGMN6uNc
 =
X-Gm-Gg: ASbGncv8G4Rm/WkuZ+sw1JjuKtuzb6s/b96b4n2PplRyMO+SOzb4CQ8wNO4+lSdcVAs
 0bX3fEFx5NwcgG97TGZX0w2sAVQD2mj7PiJABPMP+y+Jmv6aU7nzAm9zpvRKG24HU7ypq14Jfi4
 J1jQQu1umia20RLz7q439q06uccve43kCR3dPxraDTMp0mfL5hyOHf5Vxx+fHDl+v3zLx9c3/Du
 eYLV0HfN+G1DqNmG9ZXYifjw/csHOr4MVFas4uKs7MV1TIw1OUI0OObm501YG8npRo8PPyKe0uU
 J8zyAMCoPElzMqzBhg==
X-Google-Smtp-Source: AGHT+IFUDAKpUiDxQpGOqon8mg4fSRY0jtKO8oUqHVFyB8rmMghGjrmU5eWWNVEa1Ve3TV4/2i53Xw==
X-Received: by 2002:a05:6602:15c6:b0:82c:d768:aa4d with SMTP id
 ca18e2360f4ac-84987c35e58mr475564139f.9.1734632984790; 
 Thu, 19 Dec 2024 10:29:44 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e68bf676c6sm393655173.50.2024.12.19.10.29.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 10:29:43 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 14/19] spl: Add some more debugging to load_simple_fit()
Date: Thu, 19 Dec 2024 11:29:02 -0700
Message-Id: <20241219182907.2609704-15-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241219182907.2609704-1-sjg@chromium.org>
References: <20241219182907.2609704-1-sjg@chromium.org>
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
index ef40a50082c..ac8462577ff 100644
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
2.34.1

