Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC78C3ABC3
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 13:07:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B611482AF4;
	Sat, 10 May 2025 15:07:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IbCvhgkx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF43282B45; Sat, 10 May 2025 15:07:11 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16177826AA
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 15:07:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5f7ec0e4978so5391379a12.1
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 06:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746882429; x=1747487229; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gipdm/GRXps3ZLD3X07JydlzsqDnTY6w5NFkotyVlkI=;
 b=IbCvhgkxbyzZt0Ps70GB7HghbzFMrihuzdl/EuGKM7ZymESyqzukzOEFY7cHfW6Acy
 Zo9AoEnfKOJA3DS5DGCHZH5wohMZa7vsYNZqjaUHdX7p+NNiMcFU4XBNUHBusFwfMyQH
 hEIiyZr5Wt/4ZY4r52/y3W8blp6ZiodjjoM3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746882429; x=1747487229;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gipdm/GRXps3ZLD3X07JydlzsqDnTY6w5NFkotyVlkI=;
 b=dbKijIR9pTzbG5umwOXMz3jJeBisgsn8eZZnf0xbqtNmss9cWkG1A/T40b8bUJgkKb
 20aziu5xCDzF0Vuvp2ed/QZR6XjZ6qbpW3MjojnukBwfqiEtcwMZycwYVJFJLiVzLu3f
 cO2+eGB9P5tpJ0MEoKiRGFBRD45yNTDOj63qzPZGH3xcKF9HdKRW/wV39Dh+rcEykiO0
 71xkzb5grLtfiQcKJQPjY2F/UNMc7tyn32HRkzVMxFPSf/8UC8mZ9kQkOnCbhv9Lev5Y
 m4sfkoXKwvgfrHKDnduAHVa73JY0lDeaGYSo0XhSHD1GZphpOhew4dCxZ8I+L8EkLtB5
 kQhw==
X-Gm-Message-State: AOJu0YwR2JO1Rx5riVcNqwXn0eDre9D4zBpFnishGI6V3M0+RDv5B5JF
 qOiRbejZWMbL5qkJ8vpNRltC2VuuVYqsYOfjjEZcT3jGfRUczIK4wHk+VtjPvHZpCOafJSnnyg9
 E+AjlOotuGg==
X-Gm-Gg: ASbGncul9w9XZ11/XqLIFv+E3L/WLjs0rLi6TTua0phTvAh+8QWt98W7XihFQ8+oNaR
 KilY6P01KGlWJ50vYUEgoEEVLI6FjcAc23y15HniDlx12Kt9ahktSqlauHksezEIFQv5G90Oa4x
 SWvrZquCL3gN8MbXi8nluf+dFdOXCA0Ru/ACO1IqTLTU9Rbx0kbFqPKq1A7FEQ2DhtKdfD5zWmC
 ckZNXdG+QOVpJWDe/oMfXdgPxB4vmHTEkO9298wpIq00PfZEfFpz/u2q0aRb+g6iwKBj9e32X9s
 9RecrEn/N8aeBDsCLHT0o5o9VtrT0QvVMsOHvStXIKSiFbM=
X-Google-Smtp-Source: AGHT+IENGg4SwaTVDJ9jNV/H+EdQ1TuhJJWeO6SXXqkO83EwV4at0zWLBhi/1kJISDGzIL96QAVvAg==
X-Received: by 2002:a17:907:1c08:b0:ad2:2ed0:74a9 with SMTP id
 a640c23a62f3a-ad22ed07544mr330080866b.59.1746882428759; 
 Sat, 10 May 2025 06:07:08 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad24085b44fsm52272966b.149.2025.05.10.06.07.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 May 2025 06:07:07 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Richard Weinberger <richard@nod.at>, Tom Rini <trini@konsulko.com>,
 Uma Shankar <uma.shankar@samsung.com>,
 =?UTF-8?q?=C5=81ukasz=20Majewski?= <l.majewski@samsung.com>
Subject: [PATCH v3 07/10] ext4: Replace multiplication with an existing
 variable
Date: Sat, 10 May 2025 15:06:13 +0200
Message-ID: <20250510130642.1575114-8-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250510130642.1575114-1-sjg@chromium.org>
References: <20250510130642.1575114-1-sjg@chromium.org>
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

Since gdsize_total is known to be a multiple of blksz, there is no need
to recompute the value later in the function. Just use the variable, to
avoid what might look like an overflow.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 fs/ext4/ext4_write.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/ext4_write.c b/fs/ext4/ext4_write.c
index f9d5eccb2ca..e77fb383a90 100644
--- a/fs/ext4/ext4_write.c
+++ b/fs/ext4/ext4_write.c
@@ -125,7 +125,7 @@ int ext4fs_get_bgdtable(void)
 		return -ENOMEM;
 	/* read the group descriptor table */
 	status = ext4fs_devread((lbaint_t)fs->gdtable_blkno * fs->sect_perblk,
-				0, fs->blksz * fs->no_blk_pergdt, fs->gdtable);
+				0, gdsize_total, fs->gdtable);
 	if (status == 0)
 		goto fail;
 
-- 
2.43.0

