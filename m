Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CFD5C83013
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 10:02:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65C0882F4E;
	Wed,  2 Jul 2025 12:01:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XewjDjLg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 420F882F30; Wed,  2 Jul 2025 12:01:42 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CDBF800D7
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 12:01:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3a50fc7ac4dso3070654f8f.0
 for <u-boot@lists.denx.de>; Wed, 02 Jul 2025 03:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751450500; x=1752055300; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HoF/Zwp7b6L8RjPOtOJ5Zfy75f05MEelFwZ4AwcKnDk=;
 b=XewjDjLgZzJIMrjHKpTpqvkDIWPbwBKx3eyZs20ArDgQGxlLuJ+GGUBe3nIrLtEhSb
 8f+kUc1NXTAX1YY0JzDYT0PFkHXI/jMU/ZPi/GL4cVQODy5JP5YZwAx70JzjXEtvTo5C
 hkPUi3dsbIfFhaT7C/ECrKwF5cYR55nkm9AtUtEkMWhB17roN8g9hospp6zwhdA8ihSH
 OeIKAh0/iW671rpOzrWLclk2u+FDoGsxBUD3auWGIRO19S7RlyZpXJPauETfa+MDE5jz
 51Xf5JUJo7Um6fxwuMEX1gQzxUIiX/pfhQdfb7CCp6+ImNYdCI5ocT1umUa7dqJZLBNX
 cn5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751450500; x=1752055300;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HoF/Zwp7b6L8RjPOtOJ5Zfy75f05MEelFwZ4AwcKnDk=;
 b=mEf6qk8GEtT5FpCnBAPk/YcHvRGbcO+r540SBI+SjohKNIVv+pq7fHjEHJHsSeNgxz
 /WM9fA9GzrlFqJocXNNcnNtWVfHds3Jjm/+K1mdnNp7qFzW6qg14f/W+VH/aZlQGbWa3
 MlTEQtpgl/xNKQSRFyR5Zjjr3OER82H8G75LmC/0THRdOllhBz7SJCH5Np/fgbw9P2OJ
 6Br2MgTf87UdGCKX94+Ah5ENAZpbEle4YPS2qjxbw/KUYsu4bnQtTixA+CAE6rjxa5Bj
 +00VJQxHXxPb7xHdLafB0Xemma4G9EIHuw1hqRBAd2VMl9OqeHaJEnZVfBUKdPfenTSk
 odeA==
X-Gm-Message-State: AOJu0YzEx8D/iNj5JWxnLAgHQZyHMjNJiO3PLNld/PAy7cZZ0oX38t2A
 XkMq7yUjMixEhSbmH05UC19kv30OKZAcQdv4u5T7tcrTsMk9cnePu6NJ5WF0p+S88Eo=
X-Gm-Gg: ASbGncsuHS+XhPamlwKxbW+NnLxFUZltxMHkBkbwc3H0Z5MfekWssur3rYIfQKTiKoP
 sHKpeJoCtwEG6dDBtXT0APVEE+awljRC41hnAlMj8+zze9M7P9zTLfdsW5b2tNToX+hmcfBFpme
 KhE+Goc9DlwJRVcfQW9+gWXtY5zGLN+NerWrXxyRJCO2AdmSRgnT/bbzVv8zJiQmjJ4kjLNVC4y
 zbN/3Stod7/m71JMVSbwHmlB1fkU8cuHUyTZGY5Mdq7/ZfWdskSEyhKoBXbeOQG2vWA8o8Gh+O0
 sN0ALhVCKqAvnt+Sv+aRkRLVOFrs4Qq7+Mmlg3HCs6C/LB1lSMOGNzctoUf9xrPhb+NgBr8gw94
 omlqiYagKeYIWYA==
X-Google-Smtp-Source: AGHT+IEur9lrmx1YNpQbahxkqk3V0X3eO0prtzvoLnLR7iyzY5NtTLMfAwBSjxIOE3yLkXBBWL6zoQ==
X-Received: by 2002:a05:6000:1acc:b0:3a5:3b03:3bc6 with SMTP id
 ffacd0b85a97d-3b1ff9f5908mr1799834f8f.28.1751450499466; 
 Wed, 02 Jul 2025 03:01:39 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:e07:801:2aa3:3d9f:604c:fc30])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c7e74fbsm15850233f8f.10.2025.07.02.03.01.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 03:01:39 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 02 Jul 2025 11:01:38 +0100
Subject: [PATCH v2 3/3] efi_loader: Prevent free of uninitialised pointer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250701-efiloader_fix-v2-3-eb6db16bbe4e@linaro.org>
References: <20250701-efiloader_fix-v2-0-eb6db16bbe4e@linaro.org>
In-Reply-To: <20250701-efiloader_fix-v2-0-eb6db16bbe4e@linaro.org>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Adriano Cordova <adrianox@gmail.com>, Tom Rini <trini@konsulko.com>
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

Taking a goto to out_of_resources before receive_lengths is assigned
will result in an attempt to free an unitialised pointer. Instead
initialise receive_lengths to NULL on declaration to prevent this from
occurring.

This issue was found by Smatch.

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 lib/efi_loader/efi_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
index 8e708d8d350..3d092523dd5 100644
--- a/lib/efi_loader/efi_net.c
+++ b/lib/efi_loader/efi_net.c
@@ -1130,7 +1130,7 @@ efi_status_t efi_net_register(struct udevice *dev)
 	struct efi_net_obj *netobj;
 	void *transmit_buffer = NULL;
 	uchar **receive_buffer = NULL;
-	size_t *receive_lengths;
+	size_t *receive_lengths = NULL;
 	int i, j;
 
 	if (!dev) {

-- 
2.39.5

