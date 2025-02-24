Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7283C021A4
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 23:09:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0771D81196;
	Tue, 25 Feb 2025 00:07:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eH/OEXPL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18CF0810ED; Tue, 25 Feb 2025 00:07:39 +0100 (CET)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA16D80F12
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 00:07:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3d1987cce10so39788605ab.3
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 15:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740438455; x=1741043255; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B0teTz8VB7qBHHw32SJpt8MR6+uPFQRq39wPMmlhV20=;
 b=eH/OEXPL2JA4tV0+WnbK1K8lf8NCYOg4uRa5Dk78VXXuza9dTzN/jc0cg+rUzP6Lcl
 C3JWJhkVs0xYW4ciGJHBj8S/EDKtOx171B6FYumsdhS8uiVUvVt7r3SfMeHbpwMfppPE
 0oIki+fgpbxrkBcVVvKVBZ77H6xbu5kIubEuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740438455; x=1741043255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B0teTz8VB7qBHHw32SJpt8MR6+uPFQRq39wPMmlhV20=;
 b=sfx3mgUkoA+zZhCBn8iYCx6ZSm11T9DcHZ8gVkGBWcxJ5FZNHM7wQTbMANOXXm49+U
 v3oOo04ujDHQeZvtZcRAStO5BYBZLR1/SpMYTv3uzU7dqz70hna6KJy0rGR06ak7OWpO
 5vFz8mrML2fqhIWGiY614Qs3rzAqESpdIwRYU/hFfef3NxhT6D9dyjxHQl9pzL4xlEAd
 hSX1PYf+pIh4EepeIEKG4QVs1KAL2o6GXeIM5brwLfjnHM5YestMrGBj/BJLMKAgaNCS
 pW4I/p7IuInRSkDeeKYeMysKacOtI2usHQYRKGfM+qSbuOEj2jja+xpWTJdzOuGbcK9/
 JcCQ==
X-Gm-Message-State: AOJu0YwNQiVyfdRz3Ib8admtmZyfUeKyI7C6l0+w5ajkan61h8ArxQVX
 +IXPgBmDgLWiJgAtRd96DP9wJTGYuuaALxCUg8OmlIgM+x+usHuRZwzJ0gQrhIeGHToO0OYwlZ8
 =
X-Gm-Gg: ASbGnctQORsACWlfnnNfABt/KUhHyqwmMIQ+kpIeRdyIsOl6w9KLAr3maFjf2ipVvJi
 NoEI3hw/KgE8vOP7ZtmKJlD2HS0SC+iqo+SuxZEJUHd0CGjZZLOm/SX2xmVTvztYv1e+sVTpV+T
 G0s9HBjLf/IZEL6M2gisNzn/tog9WmnBXorRIW1m4WNk+kwsdYnVIFRdxsbKwM3FkJ9sEN4B/y3
 JclPEztGOTlLN6SqH87idH/o7I3fSFfJVIfJsj2kvVe9g0Q+kUfgztt4jh/hvV4R32qwE273Nxp
 TVD0qW6wlnchG6B6SxYl6r57T3jwDfiTokgZmeSsDVPDUt0U0RQ++8Z6g6fFRcg=
X-Google-Smtp-Source: AGHT+IEcGw0ZQAXXvh7TmE/i/qjZdl4OSSSdOO0N6k6a83QNCNT6tpp4won1lc72fluuZIakUPrsfg==
X-Received: by 2002:a05:6e02:b49:b0:3ce:8ed9:ca94 with SMTP id
 e9e14a558f8ab-3d2caf01b16mr139858105ab.14.1740438455134; 
 Mon, 24 Feb 2025 15:07:35 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f04752e026sm113941173.107.2025.02.24.15.07.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 15:07:34 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 18/44] x86: Rename the _D dirty flag
Date: Mon, 24 Feb 2025 16:06:07 -0700
Message-ID: <20250224230640.2665206-19-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224230640.2665206-1-sjg@chromium.org>
References: <20250224230640.2665206-1-sjg@chromium.org>
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

This value happens to be used by ctype.h so chose a different name.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Add new patch to rename the _D dirty flag

 arch/x86/cpu/i386/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/cpu/i386/cpu.c b/arch/x86/cpu/i386/cpu.c
index 845e00ca439..b108f724c51 100644
--- a/arch/x86/cpu/i386/cpu.c
+++ b/arch/x86/cpu/i386/cpu.c
@@ -596,7 +596,7 @@ int cpu_has_64bit(void)
 #define _RW   BIT(1)	/* write allowed */
 #define _US   BIT(2)	/* user-access allowed */
 #define _A    BIT(5)	/* has been accessed */
-#define _D    BIT(6)	/* has been written to */
+#define _DT   BIT(6)	/* has been written to */
 #define _PS   BIT(7)	/* indicates 2MB page size here */
 
 /**
@@ -620,7 +620,7 @@ static void build_pagetable(uint32_t *pgtable)
 
 	/* Level 2 has 2048 64-bit entries, each repesenting 2MiB */
 	for (i = 0; i < 2048; i++)
-		pgtable[2048 + i * 2] = _PRES + _RW + _US + _PS + _A +  _D +
+		pgtable[2048 + i * 2] = _PRES + _RW + _US + _PS + _A +  _DT +
 					 (i << 21UL);
 }
 
-- 
2.43.0

