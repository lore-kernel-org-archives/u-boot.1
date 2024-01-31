Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2B4CC48285
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 07:10:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E93287BCB;
	Wed, 31 Jan 2024 08:10:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TW4zddjd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C877087BCB; Wed, 31 Jan 2024 08:09:59 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7AEA87B75
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 08:09:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40e7e2e04f0so51924895e9.1
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 23:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706684995; x=1707289795; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5DXQdyyJaU1C0zQnBc+GL3iWnNrQehbwx5dihcB+ErU=;
 b=TW4zddjdAHtHiUCSuw+etsGMCZnJYrReN8IxpZUcI2B/wrNtR9+v3L5NQt4ZhR8wgo
 j/qUqpX1MbDhBXaHOUhm/b0ldKms0ZmPFsVEtmwoq5QvVcslwtTnd8E68aBzr/G4TgcG
 duXNml7gbylbxR/UVjCSzqv+VYOaI2rhqVZqEJ1wwJUmJjQP0OJuFTgF+sq7mXLYHhnn
 /qEdISM0gkPRSTX5KBioINoclun1pUYReDPepTbTQvtN9ePWZzifvggzXl9jHcDy0Kvs
 itWzaf1Ck/MOPm+RLGXjUIBqFdDmk5V+qlkSeMnyIiz/9VayIMg1SbzaM3KIw+E+TsYx
 hLyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706684995; x=1707289795;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5DXQdyyJaU1C0zQnBc+GL3iWnNrQehbwx5dihcB+ErU=;
 b=Y7a0zSZ+zqGXU/Ha+LKZW2d3sCpb/wg271yHrQTCv4Tpa8iMl4ivpVOBSqrj+pWEVM
 T9gGRAUtHS7ta3ScyJOxw0oC49br9AUvdmJj1eNMM3cowFi605qYdA1tFu+M3WPXSb9q
 yzmKqppRnYMbfoWelEOFXY01ITs94Zl8mEzdAqOTLkGxwS3msYZjNUp45PyPRHvnxi7C
 oQ8ldYpfVZD0DOKKXRHkBqMCBJol7DQPVUsIGpbvmgbaaLwuVffgnFh4HrrON1fbovzt
 EJn0LujGcSzdEdnRvqituYewIquuvAQYKvpOltgk9NUgLU0EGzzuIlNQZu9khyIIY9EB
 8bgw==
X-Gm-Message-State: AOJu0Yxc6ukBFOeYaAeMzSQXNpjZKxeFq0AdOxfPOJUYWuMc4ivdBz5r
 k2s/rBQYekK1M1s/BYccQETBDftwOrgxijmKfFtYbYf6GT22z4CNdVlkOQWZWjbEk/Xq/vlo3oL
 i
X-Google-Smtp-Source: AGHT+IFLNN/vL9e07VqA7BHXH5GSYSS2M9jdc1Cchwb1S8+z9STD/U6LLQOEGz2Lx8GYlFQNw7X+og==
X-Received: by 2002:a5d:49c3:0:b0:33a:e73a:bd4c with SMTP id
 t3-20020a5d49c3000000b0033ae73abd4cmr436279wrs.42.1706684995370; 
 Tue, 30 Jan 2024 23:09:55 -0800 (PST)
Received: from localhost ([102.140.226.10]) by smtp.gmail.com with ESMTPSA id
 bj12-20020a0560001e0c00b00337d6f0013esm9208099wrb.107.2024.01.30.23.09.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 23:09:55 -0800 (PST)
Date: Wed, 31 Jan 2024 10:09:52 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Bin Meng <bmeng@tinylab.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
Subject: [PATCH] blk: host_dev: Fix error code in host_sb_attach_file()
Message-ID: <e2f1eea9-8ed6-4081-991c-b1348b7d1c55@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
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

This error path should return -EINVAL instead of success.

Fixes: e261fbf34785 ("blk: host_dev: Sanity check on the size of host backing file")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/block/host_dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/host_dev.c b/drivers/block/host_dev.c
index 30c74157934a..52313435a0cb 100644
--- a/drivers/block/host_dev.c
+++ b/drivers/block/host_dev.c
@@ -61,6 +61,7 @@ static int host_sb_attach_file(struct udevice *dev, const char *filename)
 	if (size % desc->blksz) {
 		printf("The size of host backing file '%s' is not multiple of "
 		       "the device block size\n", filename);
+		ret = -EINVAL;
 		goto err_fname;
 	}
 	desc->lba = size / desc->blksz;
-- 
2.43.0

