Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5629FC8303C
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 11:16:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAB09832AF;
	Tue,  8 Jul 2025 13:16:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OykVuvnD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B08BD83043; Tue,  8 Jul 2025 13:16:45 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB6A1830B4
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 13:16:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4531e146a24so28270025e9.0
 for <u-boot@lists.denx.de>; Tue, 08 Jul 2025 04:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751973403; x=1752578203; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VcMM7Au1wofWTXYi/7XkOF012okmJUykcXd9cYxh/4s=;
 b=OykVuvnD7ekuIPYPmPXUSQbpuNTOKk9vZIZQUh5CM/muk6k2ZV7dXBTyJnYhoThviW
 RIYQK3fFN3qkTZ53p1GCgt3qJOKHouQBKdwwicUFYKZrxcXMNU4sMf+Tl/x+NEe+XzSc
 f36o9DZXL5UeO86no4naiuMxvstIcfM/dfZ24EPQVnFlX2ERIEQHSgyk9tFVesQeP5a3
 8vgkcEgKynt69xVN80U6WL7LYchr479XisIB4G4lrgIPKFY7BWJBrIOb8RhUwusTeMjM
 Mf1jH+D+2AMtti3MgdhP07L9qEmM59LB0wPvXTJ9hAPG8s2hk/0boihqiBFXoXrM7UhC
 eGNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751973403; x=1752578203;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VcMM7Au1wofWTXYi/7XkOF012okmJUykcXd9cYxh/4s=;
 b=G9QGy5ayzNdC4cAxKdXSknH1KyCnGku9Uq4KWlo6eL2kuueKySq8riV74vyXQv8fxL
 dhzJFh/ru1glkNU1SPbeMUjrJZ2GVERR92/Wtjs5Ko6jyajZfY3FlcOqt6Kk0U6bhn6B
 wKxac7nLMLD4A/wvuUDZ21qJl4K2Z0xReeZPV3qSSDezvYrzt37wmNVmyk5J9qi9c55b
 MgXaNZaYYmhFejtE3wQv1KLObEDofecNcZkLPnUrPnGsm6nZPC+QsAl7R4M4aBjeF7gA
 +LYaTVl3cw7nqwVWYWcaJz75/wuM9LaiFlIVoxckGnR897CZFqpiKNluH+xxmTKPjEa2
 Jk3Q==
X-Gm-Message-State: AOJu0YzrLTKKpCdkRzqqdoCpq7kc9zDdHrKA84b3a/ND8XgFiq3zMhCH
 P9+ClGFPJdV0GoyZq2al8/zfsfVG4ySc+D/cRnL7VZwpdv1OkUFyCJy2np3RjueXY1yRMFasy/n
 /dKIH
X-Gm-Gg: ASbGncuCdXHgMf7xIiiZWcvSiv694Ba3nVRdTq2vL9rejADVwp4V8fxPt6WR3g2ymtM
 fWqEhgXNtoT3XrDFrgW8FZ446UA/1ntKr0b+zsiKJnZnEJ1qXZPvO+8Q6jlBtCn1WEC0IyynYmE
 UqdaJ6BSQmxxh7EZNv1enShd5Z6vIqc+fKdNEYKFJxa7b7rTvF4zcE2WkoqZfcsyfosMb2e6Ru/
 zJmYqCXrgNniXTZJiKQJl074iLcsEuO1xEn+LYHAwLBo5yPh7cMnb/rO4ghnNWqLPuz7T1qbZ4R
 juVGXy2JCT0pNlGdGOMl+0LQodYr09gsEcEQVRtxzP8JehUgKPBgTq62saFDqmslCWpnWD8LfNP
 vxiJWxXKvsIA7
X-Google-Smtp-Source: AGHT+IHh/Py+Zi1Nt9lGqekfeXXUhEuDp+5WtKpnuqAr2qpn/yttbMMXcxrtfkXis3YxkkG4cV3KVQ==
X-Received: by 2002:a05:600c:8411:b0:450:cabd:160 with SMTP id
 5b1f17b1804b1-454cd4b49c8mr26583175e9.3.1751973403207; 
 Tue, 08 Jul 2025 04:16:43 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:e07:801:a08:6480:3e01:6cde])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454cd3d806bsm19168985e9.33.2025.07.08.04.16.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 04:16:42 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 08 Jul 2025 12:16:41 +0100
Subject: [PATCH 1/2] fs: exfat: Perform NULL check before dereference
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250707-exfat_fix-v1-1-e5783978cd11@linaro.org>
References: <20250707-exfat_fix-v1-0-e5783978cd11@linaro.org>
In-Reply-To: <20250707-exfat_fix-v1-0-e5783978cd11@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

In the functions exfat_pread and exfat_pwrite there is a NULL check for
ctxt.cur_dev but this has already been derefenced twice before this
happens.
Refactor the code a bit to put the NULL check first.

This issue found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 fs/exfat/io.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/exfat/io.c b/fs/exfat/io.c
index 77cd2dfb6dc..d80eece6850 100644
--- a/fs/exfat/io.c
+++ b/fs/exfat/io.c
@@ -442,12 +442,15 @@ off_t exfat_get_size(const struct exfat_dev* dev)
 ssize_t exfat_pread(struct exfat_dev* dev, void* buffer, size_t size,
 		off_t offset)
 {
-	lbaint_t sect = offset >> ctxt.cur_dev->log2blksz;
-	int off = offset & (ctxt.cur_dev->blksz - 1);
+	lbaint_t sect;
+	int off;
 
 	if (!ctxt.cur_dev)
 		return -EIO;
 
+	sect = offset >> ctxt.cur_dev->log2blksz;
+	off = offset & (ctxt.cur_dev->blksz - 1);
+
 	if (fs_devread(ctxt.cur_dev, &ctxt.cur_part_info, sect,
 		       off, size, buffer))
 		return 0;
@@ -457,12 +460,15 @@ ssize_t exfat_pread(struct exfat_dev* dev, void* buffer, size_t size,
 ssize_t exfat_pwrite(struct exfat_dev* dev, const void* buffer, size_t size,
 		off_t offset)
 {
-	lbaint_t sect = offset >> ctxt.cur_dev->log2blksz;
-	int off = offset & (ctxt.cur_dev->blksz - 1);
+	lbaint_t sect;
+	int off;
 
 	if (!ctxt.cur_dev)
 		return -EIO;
 
+	sect = offset >> ctxt.cur_dev->log2blksz;
+	off = offset & (ctxt.cur_dev->blksz - 1);
+
 	if (fs_devwrite(ctxt.cur_dev, &ctxt.cur_part_info, sect,
 		       off, size, buffer))
 		return 0;

-- 
2.39.5

