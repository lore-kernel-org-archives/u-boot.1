Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B90C3DA59
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 06:23:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7334E88C69;
	Sat, 20 Jul 2024 08:21:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hfuzqHcL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 685D188C60; Sat, 20 Jul 2024 08:21:00 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD57B88BF2
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 08:20:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-368313809a4so930112f8f.0
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 23:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721456455; x=1722061255; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=URI6J860r16viHgnoYGjOKe/MZEf787lw8CXQifNESw=;
 b=hfuzqHcLXEIAqMQYNMTkFOjlhuz/rmiSJyqkAwsC+iZJD5mNq98mqQzf7d0c+fQwNN
 KqJccUx6hlKCZ4PyyVGLPkFYekmng84URCS9HeQ/bb3VLC/M1TDIQj7SZ90SHfG/PsvN
 OvPdmKG/pq5pb3XufBA5gDv5ap/75lE8ZJFFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721456455; x=1722061255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=URI6J860r16viHgnoYGjOKe/MZEf787lw8CXQifNESw=;
 b=v8krqBxjrhzTbzv3on/WNKMo0XFBn5Dezeqs8B+MGd+V4cALjg0TCk+tefrbitR00F
 2gxLzKl737BJ9K5GiN5Q+beph4L0giCOQhpaZ8GfA5FeMT+DmekAfuPq4ql81iFBlCkL
 Dx+m2QYMKFrLy0k+ppwfcLWmUs8NzZkUREqXU/TY0FE1bzHBQOiBwahWT86MMk8rp6N8
 kcbphs4wU7Ol78Bf7ZMP/fUNgAtpLOn6KL30yL/SLXJsGc3cwtAn2bu8oACFH9iQpLx/
 Dx7MNEsEJ2GBWLMUpa+YWzMYdRltrjNb6p6xjWQz+AgU7fxndU929W7U8WD01QU1e6Pa
 vHsA==
X-Gm-Message-State: AOJu0YxF91oUX4R0onqqgEHl+TRPIrGY/TfZlNkTXo/Us3XjzGQWoOkG
 clmw9vXVbm6646vtHJCRhP2TWA8BzR+M2EKxlxmqbSTRoxykozqqDinqb//yJNaNTc3bqjgQPXU
 =
X-Google-Smtp-Source: AGHT+IG4a21wkmH3NSwZe6TMRrdYdEQHVYk3cVCcuE5Vkysmz10Yib2pBdh9UErHMQasM8h1PNXaUQ==
X-Received: by 2002:adf:f34c:0:b0:363:337a:3e0 with SMTP id
 ffacd0b85a97d-36873dc1f2dmr2966253f8f.1.1721456455187; 
 Fri, 19 Jul 2024 23:20:55 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36878684773sm3226281f8f.7.2024.07.19.23.20.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jul 2024 23:20:54 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng@tinylab.org>,
 Johan Jonker <jbx6244@gmail.com>, Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 14/14] blk: Correct comment for
 blk_get_devnum_by_uclass_idname()
Date: Sat, 20 Jul 2024 07:17:06 +0100
Message-Id: <20240720061706.2644229-15-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240720061706.2644229-1-sjg@chromium.org>
References: <20240720061706.2644229-1-sjg@chromium.org>
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

Update the comment to match the function. Fix the indentation while we
are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/blk.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/blk.h b/include/blk.h
index 7c7cf7f2b10..1fc9a5b8471 100644
--- a/include/blk.h
+++ b/include/blk.h
@@ -650,7 +650,7 @@ struct blk_driver *blk_driver_lookup_type(int uclass_id);
 struct blk_desc *blk_get_devnum_by_uclass_id(enum uclass_id uclass_id, int devnum);
 
 /**
- * blk_get_devnum_by_uclass_id() - Get a block device by type name, and number
+ * blk_get_devnum_by_uclass_idname() - Get block device by type name and number
  *
  * This looks up the block device type based on @uclass_idname, then calls
  * blk_get_devnum_by_uclass_id().
@@ -660,7 +660,7 @@ struct blk_desc *blk_get_devnum_by_uclass_id(enum uclass_id uclass_id, int devnu
  * Return: point to block device descriptor, or NULL if not found
  */
 struct blk_desc *blk_get_devnum_by_uclass_idname(const char *uclass_idname,
-					    int devnum);
+						 int devnum);
 
 /**
  * blk_dselect_hwpart() - select a hardware partition
-- 
2.34.1

