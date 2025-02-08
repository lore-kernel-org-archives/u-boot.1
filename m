Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA3B2C02198
	for <u-boot@archiver.kernel.org>; Sat,  8 Feb 2025 17:13:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F26DC80A09;
	Sat,  8 Feb 2025 18:12:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gGNFFg0e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5D1980B9F; Sat,  8 Feb 2025 18:12:39 +0100 (CET)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7680E80BB1
 for <u-boot@lists.denx.de>; Sat,  8 Feb 2025 18:12:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-844e12f702dso80908539f.3
 for <u-boot@lists.denx.de>; Sat, 08 Feb 2025 09:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739034755; x=1739639555; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tlr4TgYYuTVbGVQW3zPeUio0BxSDqCB1SEH81N4zXuo=;
 b=gGNFFg0eTVYSEi2UAjPbM/SHsfZB9JD/kAYGw4GOB0L1moK90Z2rQHOdvEcVimLu58
 5sMuHKP0MsGFecnORJIDW0rlG3px2VH8FSUtqxBDnd7Li3zWeFwvAvBDyVhn82Yp67E8
 c4+no9YcYY5pQ04Ccj59ZPguZd8d4Kk5OIAho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739034755; x=1739639555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tlr4TgYYuTVbGVQW3zPeUio0BxSDqCB1SEH81N4zXuo=;
 b=VAli4i5R2e61so5PT6g5FxsPLTcaAG7JMHf3ofmg92goaNCVV7dpqeGfeF4TPZDSSI
 6/4bofuAdS78Z+ybanCkOLc4cBQ7ZyKf8wTTCjC/mTcFibco1/IddveaP9cR1Zs8B7nC
 xd0os2p5Lpv5Dg07UMS144aF0Cz43p1rNFQ6/ncft8lwXDAT7bNYP9QJ2T8OEJV4HNy4
 W/V9LHdQtv14FW5VOaIyohpl6twWfl2cSM6e+qfKXEzS5avPYzEvbagiKdZbeQLzo+dW
 QB3E0oC98f5UQzVH28B9opUqKJ3uYIfnhd9pb7sAP2IUknIU3uUaHAPXDmnMgq0eixrj
 1oig==
X-Gm-Message-State: AOJu0YzPLp9SKs/5ETuc8+lDCtSEO4imBthg8JoSrSjpnuqI3U0dFU4z
 b+Kh0FPYFWXmI7ZuIkFiYz6KORYJGCb6o8n1lA0p/G9aqVTSkzxBmdS0GeFJa475MpWKfHhCv/Y
 =
X-Gm-Gg: ASbGnctYtZryfGRCrcq168mqzxNHJ3b0RHIXbL5Bjg/NY49r1B2n6C3dWdt/pz4Qlj8
 ylS5qRHb934FkYpSj+HZmBLT/PO43m/MwIFnJDDHHERxB6UOSqnM/exh7qycutVaNgom++T0gu4
 gan9KScl2ZWeLm8/hsb6HPOV8Bu6CufRv4Fctnmx4kAAYodX+XCImmOUqBVIaNbcp/SkxPG8rVu
 8ixqemDteouuZlL706/+8dnBebB3ocdwWXyjIEw+w9VkELFFjAgZDrMoLXp6A7EngpUwcSu9Mo+
 R0/NICgHZ+V0Y7uec2iJaS2rGTFFhqglQ3saTa4Qj+r9UIRdfp5Z
X-Google-Smtp-Source: AGHT+IFS/g5M1mW07Uf8CSW95aWYgEJTjXKAEx/NHB7M45A6MIvy49G1xfiLyTijTGnDQO732cquaQ==
X-Received: by 2002:a05:6e02:216a:b0:3cf:fd28:852 with SMTP id
 e9e14a558f8ab-3d13dd0280fmr76709965ab.3.1739034755711; 
 Sat, 08 Feb 2025 09:12:35 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ece80badb5sm371754173.68.2025.02.08.09.12.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 09:12:34 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Janne Grunau <j@jannau.net>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 13/29] efi: lmb: Avoid access to _start
Date: Sat,  8 Feb 2025 10:11:33 -0700
Message-ID: <20250208171154.1305761-14-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250208171154.1305761-1-sjg@chromium.org>
References: <20250208171154.1305761-1-sjg@chromium.org>
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

The app does not have this symbol. Also the memory where the app is
loaded is not under U-Boot's control.

There is no sense in relocating from one alloced region to another.
U-Boot is not able to relocate to the top of memory, nor decide what
other parts of memory are used for.

For these reasons, the EFI app skips relocation. It is not running at
the address pointed to by the _start symbol.

So disable this reservation for the EFI app.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

Changes in v2:
- Expand commit message to explains that EFI_APP skips relocation

 lib/lmb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index 588787d2a90..420eae4d0b8 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -560,7 +560,8 @@ static void lmb_reserve_uboot_region(void)
 		lmb_reserve_flags(rsv_start, bank_end - rsv_start + 1,
 				  LMB_NOOVERWRITE);
 
-		if (gd->flags & GD_FLG_SKIP_RELOC)
+		if (!IS_ENABLED(CONFIG_EFI_APP) &&
+		    (gd->flags & GD_FLG_SKIP_RELOC))
 			lmb_reserve_flags((phys_addr_t)(uintptr_t)_start,
 					  gd->mon_len, LMB_NOOVERWRITE);
 
-- 
2.43.0

