Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F30C83F2E
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 15:01:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4055488CC5;
	Thu, 29 Aug 2024 16:58:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UQ+k5xSL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A75CE88C8F; Thu, 29 Aug 2024 16:58:31 +0200 (CEST)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71C5C88C9A
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 16:58:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-829e3fbcae0so34922339f.0
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 07:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724943508; x=1725548308; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zIv81WrdEaGFh4AlWO6uZxqWOl3pcyfYnBqBpExsB1E=;
 b=UQ+k5xSLXjRk6X4hBtKeVCVWGrG97czXLt5AZsgEIoHg78HXchGOfneSole50UXeoL
 R92oWRwTZMYs2Q0/raAoAERrbdU/zE9NlOh1x0UCsbGNQyPtfK5d4SlufYgWneOPgUWl
 oBy3e7OjpDDG4OfInR8L9DX4ZIhbnBjo1bSkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724943508; x=1725548308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zIv81WrdEaGFh4AlWO6uZxqWOl3pcyfYnBqBpExsB1E=;
 b=fPYsOxECRFvBSZ1+gCbCwtFHItQ2wF2Lbrk7z3OFi4uCnuZ2heFA746JLq8ejSMTKG
 lA/XtsssZ4tJxeyS9FISVAte/ivRvqgTxWWsr7Psl1aML9gZGGfiaTYbICPr8QhG3E+O
 bKB/CzR6pGq3Bv2G29FyFNBTcV32gCajnI4jsVVD8pSibaMYpsvMmAqLOcaTJvY7L9qW
 X3ZFed1DgL4zPjJfjGSV7a7HXqXd0Hl3CyTyAT0WEhREy6ki9BM30kA6pEj3KdgNX2Nv
 AHJGnR/aLTh/v/SopKkrbGRe1gVi/NB0VdEEBfN0jLINL7iy7dvn9sTJdDrudAFvIKw6
 LPZQ==
X-Gm-Message-State: AOJu0YxQHtLrELJEn6vgOY0/gOLApBtN0bxONTsUUdzEgNzw32ABtTmC
 GUk2cXtE8ZYzH3D9KuROHc6FN0sX+dbvg1WrnORuI5mH7xHkUzshsISoM+ijdaGlLpVvTR5JCiU
 =
X-Google-Smtp-Source: AGHT+IGQAUOHip+5tlDUIXkbbUUmg9d7n6/gjPdv2J/1Z3ORR+pNs+X/etDCkUWDX9maO35jbjutXA==
X-Received: by 2002:a05:6602:29d3:b0:803:f97f:59e0 with SMTP id
 ca18e2360f4ac-82a10d8820bmr396288339f.0.1724943507999; 
 Thu, 29 Aug 2024 07:58:27 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ced2dcdd2bsm284900173.21.2024.08.29.07.58.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 07:58:27 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Kever Yang <kever.yang@rock-chips.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Marek Vasut <marex@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Suniel Mahesh <sunil@amarulasolutions.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 14/19] spl: Add some more debugging to load_simple_fit()
Date: Thu, 29 Aug 2024 08:57:57 -0600
Message-Id: <20240829145802.1827952-15-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240829145802.1827952-1-sjg@chromium.org>
References: <20240829145802.1827952-1-sjg@chromium.org>
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
2.34.1

