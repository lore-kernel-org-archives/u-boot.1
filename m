Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E183C25B75
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 20:13:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF678882EF;
	Wed, 15 May 2024 22:13:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Lw0QF9TX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C99F882DF; Wed, 15 May 2024 22:13:36 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5415A882FA
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 22:13:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maximmosk4@gmail.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-51f3a49ff7dso9553658e87.2
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 13:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715804013; x=1716408813; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zZgbJ45i/wZY/aOIMdKGl28fs34TbJbqlWgCwQltcCY=;
 b=Lw0QF9TX4Yys7KlC/LQpwEw++BnDY3BV5WZCCOE2LprOxKR4zJYj3mmMQwkITg2ht1
 28hD65YQriYMYpGR5vzBH8TIhyerX+3UHIxWVs3qM+w1rYQaXwuwAg7dMfJmlKDOoGZ3
 eYhBMoy9m4hAgRBLYLE3b9l0yvIpZurZ2V4tuGDHBv3gXT4ip+ZJj+/6hU2JAh0UZK58
 Ee2AnQCMrDnNcu6Le+V97WsZajdqfm9D3lD4sSQOp5xxzyPN5ZpvHpdy7Wjmhv+XoL1d
 wzXuYyNjOvNQxk4aL/1EYRJUpIqylYD87FSh1eT6t2MTUCtDXHcxH85rSx+TSqIiWZjQ
 x4cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715804013; x=1716408813;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zZgbJ45i/wZY/aOIMdKGl28fs34TbJbqlWgCwQltcCY=;
 b=OHTe5Qm/KVooUuTtMi5DVcsHHVu5HxXpI6BZyDJWk+wr7gC9PxR42Q48L8WQKGb7Of
 ZBZf85zxx8M5PdvQb/MQA3Rn02XC9/EyXz6BD4sCXQZ9ISxI+gzb9J1oQw00Cg2HpOGR
 WY+opS2/Udbe610Oeh0K+iY/+IpIsSBAjQnT7+hCoS1ppCEl3fJSpYc+c3+1gG3uYCzQ
 Wb+8JEAq0mwf/IN2Ic4e+/zzUiP0UQQh++agGEnASlvIOBc4mWjlRY3Dl1rgX9KCO6Pb
 QQ3orKf/u2Qh4dDIEpmxzUqSdv99p1n+J5jrvg58W7UFHFvgI9tjZgAzyjwbEu/g9aiN
 z/fg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUD5yxqQRzXagrphgNWjuY52GSm0966FgRN55lvnU75oo+X7gqUiiNDXeDG+Y/FqD4rk5DiN/Z7ITroB2LV7NiOuX94Rw==
X-Gm-Message-State: AOJu0YylZuWPP6HMRSbAyoRcNeox7LBpv8/7tnoKgIBrY3TxslrE4iRw
 WlNHNDVKqX3qh4pDzqjhhaHO/QcevDlyu6lP+kWKGFZcX+I+90eu
X-Google-Smtp-Source: AGHT+IGsxL9C0UxwMaTf6wczpKaMQZ3B2AZpZ3TGtoyN9lQx1dEvl4ILdSKD2p+4jwDHtLkYK0L5Xw==
X-Received: by 2002:a05:6512:3da2:b0:522:2fa0:c3f5 with SMTP id
 2adb3069b0e04-5222fa0cd89mr12822367e87.62.1715804013449; 
 Wed, 15 May 2024 13:13:33 -0700 (PDT)
Received: from localhost.localdomain (109-252-12-58.nat.spd-mgts.ru.
 [109.252.12.58]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-521f35ba6e9sm2680046e87.82.2024.05.15.13.13.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 13:13:32 -0700 (PDT)
From: Maxim Moskalets <maximmosk4@gmail.com>
X-Google-Original-From: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
To: trini@konsulko.com,
	sjg@chromium.org,
	u-boot@lists.denx.de
Cc: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>,
 Maxim Moskalets <maximmosk4@gmail.com>
Subject: [PATCH] dm: use newly added linux/compat alloc functions
Date: Wed, 15 May 2024 23:13:30 +0300
Message-Id: <20240515201330.28015-1-Maxim.Moskalets@kaspersky.com>
X-Mailer: git-send-email 2.39.2
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

Signed-off-by: Maxim Moskalets <maximmosk4@gmail.com>
---
 include/dm/devres.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/include/dm/devres.h b/include/dm/devres.h
index 697534aa5b..27761deb6d 100644
--- a/include/dm/devres.h
+++ b/include/dm/devres.h
@@ -266,17 +266,13 @@ static inline void *devm_kzalloc(struct udevice *dev, size_t size, gfp_t gfp)
 static inline void *devm_kmalloc_array(struct udevice *dev,
 				       size_t n, size_t size, gfp_t flags)
 {
-	/* TODO: add kmalloc_array() to linux/compat.h */
-	if (size != 0 && n > SIZE_MAX / size)
-		return NULL;
-	return kmalloc(n * size, flags);
+	return kmalloc_array(n, size, flags);
 }
 
 static inline void *devm_kcalloc(struct udevice *dev,
 				 size_t n, size_t size, gfp_t flags)
 {
-	/* TODO: add kcalloc() to linux/compat.h */
-	return kmalloc(n * size, flags | __GFP_ZERO);
+	return kcalloc(n, size, flags);
 }
 
 static inline void devm_kfree(struct udevice *dev, void *ptr)
-- 
2.39.2

