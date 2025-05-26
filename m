Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C2C4C5AD49
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 10:17:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C5E882B0E;
	Mon, 26 May 2025 12:16:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QZpPYQdg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E82FF836D5; Mon, 26 May 2025 12:16:16 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C68B1836C1
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 12:16:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-85b3f92c866so35563239f.3
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 03:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748254573; x=1748859373; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YzSnOYxCAcr1DAya76JEcmTBGJPgmmiNemCU25tvTlE=;
 b=QZpPYQdgOf/QRwcPxecqPzBdV8UPpWEvcBNHxUe2PM1nMO9GPsSZkhPsRmnLrXqBfG
 rNLWlgXWNH1FUcjjF+2u0jkUqR87HAemWB29sHbI65YKbcUGJMV9/WF7zNkIdHIwjQZa
 IdifFhBzN46+QLWcUYZ9lv2cb1CtPS6sLFKQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748254573; x=1748859373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YzSnOYxCAcr1DAya76JEcmTBGJPgmmiNemCU25tvTlE=;
 b=BV6Z3aoAsgWI6/NhxPOS6cLXnyrhJh10LenQRS+C5seZyFB7S5L3bjazLbYEN2vmST
 NoF+qVGKDeFNwcyR1pIxHaxQVtV0lSyqfeF2SRPPBTjpXkCXSfpcrcJZ9io4Vw2J+7dZ
 LKNU4c4JV0m6lPTK2FsFXnRLklSvWmGtqw6SSz5CAdvkcdQKSO4pqVhfD5OWAzh4kMMW
 Uigyia625q5LJkQxcP5HzwbuMrRuGVLC/7FSY6Vyj8u6JeYmTJxs4u6fY1ZU0ce4X00O
 WhmqFhPwoh7kS3qhks97VtW95OmVuYPSpBFa5Oani5C64dh9QVAMpJY8jEANPU8Mg5WB
 BPbA==
X-Gm-Message-State: AOJu0Yx1yOAMdR2IXO3ViNGweSxZ1TfmPl2slppFDr2qhxu57afaYzU5
 x+HBZKblUX9cxZJPbjavdL6HCzcltEafQXC6L5+Dy08cNkAzQuZe/aBgKvLrNHT9t5XRkahxF7P
 SvAcbIqeG
X-Gm-Gg: ASbGncsFn2Agk9WZSn4Inow/2BByRULJ/hvZ5SwZ1m2fDiLtMPbSm/rFU7zD/Of4Ki4
 WzBS7j5FbpZl1xSkhMhjMnmAQhNhrKZuZz6CA6IhjB7cGFxfmAcSUUE9rVmUcE/RN2P0QBYOClb
 fqAtgIHTzU6dpyFTL4YuQuMdTlk0U9cgaHACBhNt7oWIo3pJWDPWPnLorvdbIWWDRntV8/Ncsze
 jIUndHSf29DJJ6LSwjqAalQhUMHL9geFZeOyYeuPTLlsTCit7a6dWOeqxJYj9tZ9B/KFnRcLtn5
 DwkZ0y2FoZ7BHPR4AsE6llQv/O7hhBRPCgGxElsuwFJGjoOEOvUlTwwQ+xN/S/LcyTsuJMcYJQ7
 /hKfvZHlkUFSl
X-Google-Smtp-Source: AGHT+IFThhctLliOkUkOX9Y1ykfDiG00zN6VUKoMCrtQmFb5kH81sFayPTBtJQs97wFpLr6LOuU2Pg==
X-Received: by 2002:a05:6602:3e98:b0:86a:235c:15f8 with SMTP id
 ca18e2360f4ac-86cbb6c78d0mr1071281339f.0.1748254572952; 
 Mon, 26 May 2025 03:16:12 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4fbcc3b19aasm4679249173.52.2025.05.26.03.16.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 03:16:12 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v5 06/25] rockchip: dts: Specify the phase in the image
Date: Mon, 26 May 2025 04:14:52 -0600
Message-ID: <20250526101541.3254628-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250526101541.3254628-1-sjg@chromium.org>
References: <20250526101541.3254628-1-sjg@chromium.org>
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

Add 'u-boot' as the phase for the images intended for use with U-Boot
proper.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/arm/dts/rockchip-u-boot.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index b8a3d6b6273..54b567cc3c7 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -64,6 +64,7 @@
 				compression = FIT_UBOOT_COMP;
 				load = <CONFIG_TEXT_BASE>;
 				entry = <CONFIG_TEXT_BASE>;
+				phase = "u-boot";
 				u-boot-nodtb {
 					compress = FIT_UBOOT_COMP;
 				};
@@ -82,6 +83,7 @@
 				arch = FIT_ARCH;
 				os = "arm-trusted-firmware";
 				compression = "none";
+				phase = "u-boot";
 				fit,load;
 				fit,entry;
 				fit,data;
@@ -101,6 +103,7 @@
 				arch = FIT_ARCH;
 				os = "tee";
 				compression = "none";
+				phase = "u-boot";
 				fit,load;
 				fit,entry;
 				fit,data;
@@ -123,6 +126,7 @@
 				compression = "none";
 				load = <(CFG_SYS_SDRAM_BASE + 0x8400000)>;
 				entry = <(CFG_SYS_SDRAM_BASE + 0x8400000)>;
+				phase = "u-boot";
 
 				tee-os {
 				};
-- 
2.43.0

