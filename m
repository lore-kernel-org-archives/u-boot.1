Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B091C71136
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 20:26:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3066382CBC;
	Wed, 11 Jun 2025 22:25:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qxEG4ywX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC2BF82B0F; Wed, 11 Jun 2025 22:25:14 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D96E082CBC
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 22:25:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a5257748e1so216767f8f.2
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 13:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749673512; x=1750278312; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GdBw1BLSy/tFF/waQ+VEoCTJeCTIQ7FsDYgsbOpsBXI=;
 b=qxEG4ywX+m4SkpZJP9qCf+I9xRmMIMApae4I0m7jGOv8M+9sPTFlaXdCddjKwx8iJR
 IVPmZkMilsNfvYXEpOs9w8izCFFX9bwR1Xbrxv/nJAi+tBSI+pmjDVH7S74E5GZ0y2jt
 nXEiHqeQ8jAmxyD380c5XXHGWeGw5KB97/ApzNvI6cqrfaK8u1wHeaYltYnc9bbzhFh6
 qfcGqwkNApzXq8XQYsJL8rweaSsIH/M+WMzmD4m5zHAqKJZW3NjX5dRwbq3NWTx+BLjP
 nGkFHoTltdeHxJbgTQQFS/I9GaQtrxPbg9pErMLSX42uKaWsP6tkTl7PcPPGl3tEdtem
 /Acw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749673512; x=1750278312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GdBw1BLSy/tFF/waQ+VEoCTJeCTIQ7FsDYgsbOpsBXI=;
 b=vXALJFDoe4rtUeSJJIB7Xarng7Sq1tix+niF/5oO0KTlDQ2uXbZ8LrY0Kej4i6zilf
 FTRN+5KED9H8QDGCENgQ2e8C2zAGkOGFBBwJuxD+CDAuZp3lRZSZMs2TaoIi6S+5uDpw
 N/YxWHuXOxg+PZMFEKYNpVEJ7rctsRFDknAg4tnL9BfoGpSXLZRfNQyoi3GBifB0vweu
 T4Kf4kneJ0gmz2aGVBjwadVIZfyqYlk7xgLN2cMCZ5hmZ7aXREYlSYr0JGhUybRECW0E
 0phJM8SRS/B3B8hxjRAY5WLHTinr/ifH4SRqEJRZAX8r5dvMbQcwv4vsS59FIwxvlSpO
 b84Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXECwsA8zJznwgag/ECp253DVGDAteiE/CyJqfxeOUiAVwVnGG+bPOaui+DAWvSilYCNq4lsE8=@lists.denx.de
X-Gm-Message-State: AOJu0YydcL5ugGW9HwO8oHD5db03PXjfR9wsSoDxwnX7xEwgaPPO7WXN
 8jaz80s08uUAI/J8tICq1lHYNGcbFABtVVysYg6iDVvTL6oDLccWJvEANsNrySYpvwg=
X-Gm-Gg: ASbGncvLQ8bBYkaMm7A2qd2goMiyx8P7ma8U3qwIMQANwARbpHE81ho4rpTneUUHevs
 b1Kjx1LRvHstSruUlRMqodxLImTzOt/9tmugKquFHkPBDpD+kGXoDTquZaBueDX2DY0hDAmaMmi
 pa9AapbipxYS3z8LU7w0kb566wRvRLGSyitWJXegTIELbJMvM5hGHUrXcDQpb4D2pzArBtCCogX
 ujDZBE25LM+TvxyhBh6s0fnLLABNiXk2P8SdXYkvFKM9p17OaymR7lSNoAKz2AcZzXm2+p8ouGM
 13VWT/oVXpEVsAjtp5MAucgJD6I3PIAE9yhLnC/QDwA1aZOLP92jPRlI6qcv0yZa8LHzmhm0B6E
 EaQi3hW01VpZHfHQEOzYfQ+SFWINfXdSlsGIsrek1
X-Google-Smtp-Source: AGHT+IHWFJbCXtHHUQMvpRIejB4GiYGBdKrULghh/mzrppra0H4Y5vKL4AdkdCCWNRbRnYt5UeWP9A==
X-Received: by 2002:a05:6000:310c:b0:3a4:f5f6:b4ab with SMTP id
 ffacd0b85a97d-3a561349f27mr182059f8f.30.1749673512323; 
 Wed, 11 Jun 2025 13:25:12 -0700 (PDT)
Received: from localhost.localdomain (ppp089210105145.access.hol.gr.
 [89.210.105.145]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a561a3c538sm12071f8f.50.2025.06.11.13.25.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Jun 2025 13:25:11 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Michal Simek <michal.simek@amd.com>, Yao Zi <ziyao@disroot.org>,
 u-boot@lists.denx.de
Subject: [PATCH v2 08/13] gcc-9: silence 'address-of-packed-member' warning
Date: Wed, 11 Jun 2025 23:24:35 +0300
Message-ID: <20250611202449.2317279-9-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611202449.2317279-1-ilias.apalodimas@linaro.org>
References: <20250611202449.2317279-1-ilias.apalodimas@linaro.org>
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

Backported from kernel
commit 6f303d60534c ("gcc-9: silence 'address-of-packed-member' warning")

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Makefile b/Makefile
index bd0866dc4579..f05c70073b85 100644
--- a/Makefile
+++ b/Makefile
@@ -800,7 +800,6 @@ ifdef CONFIG_CC_IS_CLANG
 KBUILD_CPPFLAGS += $(call cc-option,-Qunused-arguments,)
 KBUILD_CFLAGS += $(call cc-disable-warning, format-invalid-specifier)
 KBUILD_CFLAGS += $(call cc-disable-warning, gnu)
-KBUILD_CFLAGS += $(call cc-disable-warning, address-of-packed-member)
 # Quiet clang warning: comparison of unsigned expression < 0 is always false
 KBUILD_CFLAGS += $(call cc-disable-warning, tautological-compare)
 # CLANG uses a _MergedGlobals as optimization, but this breaks modpost, as the
-- 
2.49.0

