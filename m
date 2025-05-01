Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91189C369D9
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 01:14:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 960268219D;
	Thu,  1 May 2025 03:14:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q2TdHdJp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CA6D8209C; Thu,  1 May 2025 03:14:39 +0200 (CEST)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E99358209C
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 03:14:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-22435603572so5113495ad.1
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 18:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746062075; x=1746666875; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7/WwYLf8JREKRCXf+WUj0JKUVVc0RxaQ1+MqHMY/xqQ=;
 b=Q2TdHdJpqSTlnnrsNdc3OWlxcP+EScx22XzwfrKa3xWY+rIHuVIiGOINkoYjt8QjJu
 phWUnA0JL0lmLgne+dro/L8hqebj1hSXUnGWy3Qk4UpkPGz4L+WGltkm4CZ0KJqPLRxq
 I5yRsbrbS246y7h9/NPvxUsZflRKqThowc+LYQnlfCEFSFLM/2Yd5AE0wyvmLEn79FNr
 XvboP8ElBvDdflwry/WdaVFg8jaqdMrDfJxC1X/s68WH55QcvZvrjMIqHxoaFD6N39aq
 LJisfUmXvEE9KyK2C11pbW6Ixm3TtAisN/lFYfkIgjoeaVgu/HIVXTiP9Zw5mcl87NKF
 7RqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746062075; x=1746666875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7/WwYLf8JREKRCXf+WUj0JKUVVc0RxaQ1+MqHMY/xqQ=;
 b=DJe03DvAlBdiUj0M5zHIN5i3P34hmahkNOWe8IqvSpv8/VH/2QzfH4XDSVkp49CbIf
 F0PxCnGV3TrOk3E7txGeeWSRu0oH5dTBlanS5lUTpuhwGfMazPjWpHMsg0KXY2nBQ4Ga
 lLGBoxuqijha34azptEocusogQb2StLE+6ffnY1Po4KcAFydmJH2EzxZOr0OpkQt8Bih
 F5qOl+JeT/b2R3C174+FIg5p0mh+64dnrIyexCVP0hRtBlViHPZzXCoVnl4RH1QJ0444
 ivBHITXC7n9ztJm8dKo0vIQjmToSEZ5wI8XsgDRHU+MDvFF5V9LBvAyBXOjJ9rWK38to
 FfdA==
X-Gm-Message-State: AOJu0Ywy2NuGxwzEDz7SuKRPl4/qex6UnJIku+ZBNQiaoKwuq2Ui9Jey
 pR8+z39cyR2SxTBuU96x3aXtpfOczW1MgW/tia1ruYsz0bWqHQnqyRl6mCOs
X-Gm-Gg: ASbGncvZtalJwd0RaQ2Z1GiOflNZJvLPMtwBuVj4xii0yj1cQzcKkk0nbChQHFCrKXn
 re7Q+nfZUvkAtxlzxejZXQjoMWT3FnSOvQX9ojL5vuwJ8vbRJLTmlhFErBotHjHSiYHXE8oe2pc
 /BNp7YWYtL04bDFkvAqMkQBLy19XTZlWg/IUmJs7WxFTTalBXAM/vbouKiIiSyeagG9UTPXQ0Dw
 4c2f2LHpxdQLuhGZX7od1OK/tu8yQ/mh5/qFrCL401aIgrZPAW1YH/9+87OQAynnaM4R0FG3uZf
 CGaVGmGPPsSfErMPewuwba38E7LKsVpOw0obuquAzrn/Oz2rBA==
X-Google-Smtp-Source: AGHT+IGyhyxG0bIZI4961nCZ6PbFrMhphcY0tCiFB0Zxa7ciU/DwRPmBDEA1zcZM0G27ljH0Wqi/uQ==
X-Received: by 2002:a17:903:1a30:b0:220:e63c:5aff with SMTP id
 d9443c01a7336-22e08639c4dmr8947345ad.47.1746062075417; 
 Wed, 30 Apr 2025 18:14:35 -0700 (PDT)
Received: from adriano.. ([190.215.87.40]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db52214fdsm128736615ad.251.2025.04.30.18.14.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 18:14:35 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 trini@konsulko.com, o451686892@gmail.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 2/2] efi_loader: fix typo initd_sz to initrd_sz
Date: Wed, 30 Apr 2025 21:15:14 -0400
Message-ID: <20250501011514.2209452-3-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250501011514.2209452-1-adriano.cordova@canonical.com>
References: <20250501011514.2209452-1-adriano.cordova@canonical.com>
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

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---
 lib/efi_loader/efi_bootbin.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
index 637f2c0d195..db4478ee0bf 100644
--- a/lib/efi_loader/efi_bootbin.c
+++ b/lib/efi_loader/efi_bootbin.c
@@ -215,7 +215,7 @@ out:
  * Return:	status code
  */
 static efi_status_t efi_binary_run_dp(void *image, size_t size, void *fdt,
-				      void *initrd, size_t initd_sz,
+				      void *initrd, size_t initrd_sz,
 				      struct efi_device_path *dp_dev,
 				      struct efi_device_path *dp_img)
 {
@@ -235,7 +235,7 @@ static efi_status_t efi_binary_run_dp(void *image, size_t size, void *fdt,
 
 	/* Set initrd if provided */
 	if (IS_ENABLED(CONFIG_EFI_LOAD_FILE2_INITRD)) {
-		ret = efi_initrd_set_from_mem(initrd, initd_sz);
+		ret = efi_initrd_set_from_mem(initrd, initrd_sz);
 		if (ret != EFI_SUCCESS)
 			return ret;
 	}
-- 
2.48.1

