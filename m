Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E2F2C3ABC9
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 13:07:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7839D82935;
	Sat, 10 May 2025 15:07:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YYIwolWS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECE1182935; Sat, 10 May 2025 15:07:04 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C6CE82A8C
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 15:07:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5fbeadf2275so5170439a12.2
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 06:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746882422; x=1747487222; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mzuNeStJlBtOgvmwd6scab2CCE7SluziW2q3IIDR8N4=;
 b=YYIwolWS83crp7/eSZ8OkonfU2SjND646KH4sgzVxYIhsvga8mwAaptXVWaS0glPtf
 3GEJAltFmkQrgf4EjvGoLFLpU13xvCB73CeXhJkC6GcoJtclLSg3UMsWyx16xzImipqy
 EvnaZZZPfqAN1tEnOocm97PA6ojST9TsQ67CE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746882422; x=1747487222;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mzuNeStJlBtOgvmwd6scab2CCE7SluziW2q3IIDR8N4=;
 b=hO8Cnz1uR2RTTtbFWcazWUYYiLjsySzgnFfHx1x95GM1Hn0QzMz7Q2cs4FCj3bwsQe
 qfVYpiXdqm0sHaGNCTxyT8sbIcLCIBQyiwd1yARSOpqn4Dt286zugbDT0xwRBJyhhRmO
 Twd1lCMmdCU9tnd5HVxc8d2sUe+8ZjQ1aHoSYtCzREsPn+sApDQ/EaAYO76GaEyKVOW5
 pXoiCMyfzFvdamE4dnl0akBnJIcn9PmnnLWthNT6C5UaASqanDjDH0rHynqIV+oGVIL3
 sSyfJt8/uiAs+QG3e7i2AdCINXAClmkg3dER2aMGShUjp5Z8BNe356NNlUgosI5h48TY
 AGWA==
X-Gm-Message-State: AOJu0YziC5/97ebgtIZYbneVNwHerZpt2SrpWolbhyYZQDIltGxGOZ7O
 XlWO50nAzXSPrznJLroY5xKMmPkLz2xzj391hhzarus6TmnwJJtYPpkN7IFP/w201AtMye0p7Z2
 7uq9rpNVksg==
X-Gm-Gg: ASbGncvmPEjxTlExFBY5rYpAVXvwK1LlU/J6jCNaIg+T0VKEBpRKWpF3+PhYmqx3cmg
 YMKDiliGAXKLvru1uySUzKRB0zAS/sx3S4W6XMb9RK6tM2cHnnxR1LFAylxz1U4QT+vI/zfMk68
 GbP0SJW+OfLKemPsycN1EbN7e0iiWRjD7BuuWQ8uBaXzgGoqJlSn2o6wYEjvZDUp50Pzoasi5tH
 90bMx8rWXo1ww5xMZlk3i9bECFRrKRyVjo29KUu8x62RaEIhDMU8FSt8dubTx33mynNMdt9AXNR
 6uGcGWWQ4f/QhNPC0b0U2M+2YP+ovRFRDr+8zZcYhEesxu4=
X-Google-Smtp-Source: AGHT+IEdL0eQBj+5iO0UYhlq+HIT84oQNMtqsrzhfKOYEyzdesHduNlpG2SsXV74UJ4M6oMpsBoPCQ==
X-Received: by 2002:a17:907:a2c5:b0:ad2:2e9d:7516 with SMTP id
 a640c23a62f3a-ad22e9d75a1mr300070266b.59.1746882421734; 
 Sat, 10 May 2025 06:07:01 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad24085b44fsm52272966b.149.2025.05.10.06.07.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 May 2025 06:07:01 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Richard Weinberger <richard@nod.at>, Tom Rini <trini@konsulko.com>,
 Uma Shankar <uma.shankar@samsung.com>,
 =?UTF-8?q?=C5=81ukasz=20Majewski?= <l.majewski@samsung.com>
Subject: [PATCH v3 03/10] ext4: Avoid expr in declaration in
 ext4fs_get_bgdtable()
Date: Sat, 10 May 2025 15:06:09 +0200
Message-ID: <20250510130642.1575114-4-sjg@chromium.org>
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

Move the expression into the body of the function so the ordering can
be adjusted.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 fs/ext4/ext4_write.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/ext4_write.c b/fs/ext4/ext4_write.c
index d109ed6e90d..8e6179c4a99 100644
--- a/fs/ext4/ext4_write.c
+++ b/fs/ext4/ext4_write.c
@@ -108,7 +108,9 @@ int ext4fs_get_bgdtable(void)
 {
 	int status;
 	struct ext_filesystem *fs = get_fs();
-	int gdsize_total = ROUND(fs->no_blkgrp * fs->gdsize, fs->blksz);
+	int gdsize_total;
+
+	gdsize_total = ROUND(fs->no_blkgrp * fs->gdsize, fs->blksz);
 	fs->no_blk_pergdt = gdsize_total / fs->blksz;
 
 	/* allocate memory for gdtable */
-- 
2.43.0

