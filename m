Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF44D3B7E5
	for <u-boot@archiver.kernel.org>; Mon, 29 Dec 2025 01:49:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04C6683C28;
	Mon, 29 Dec 2025 02:48:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DhV2w//3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0684583AAE; Mon, 29 Dec 2025 01:05:57 +0100 (CET)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B69868003E
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 01:05:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=aargri@gmail.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-450b2715b6cso5198403b6e.0
 for <u-boot@lists.denx.de>; Sun, 28 Dec 2025 16:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766966753; x=1767571553; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QRgrgy/VNnQLi0dzNsVjhu5DSSLa36kMAYZu8Rc9wNw=;
 b=DhV2w//3dDjMFSq7/xQ3qAicGeWdjufe/V5BxaPGaq3VI9QNCYwk0E+dPWnk+zZ5/b
 8ADM5P8mK2MU0W51Y34VDwHCxMu0ZDHK8KfBIbAslbL7a3UJgPx8hp1bArri4QgKQjW2
 QkrXrOic2Wq3YAWVKPIpG+B2xZY2+H455wcrtIxgv5icL/xTAmoSjzwByg8AbSHLaNBx
 4XOQ6S5GFZ/JndSZ8MbfWWNzm5E2inUYdJIVKILWhqYhnpuXSDm9h4b5JFXC6+0LUHWr
 M+eXWa1YmRZEaN+YeOfwLMvB38EjmX6eY6D955QKHCYJF3z75/QtXEVqtHGc+mnJxzPY
 u0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766966753; x=1767571553;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QRgrgy/VNnQLi0dzNsVjhu5DSSLa36kMAYZu8Rc9wNw=;
 b=CFWV1sVtsuQFfEaLtMLXsB6TLkrcnEzJ1RHkU3Rziu8YUMnV7g002VqQB9RrNiJpQc
 PL9Gp0unoLqrH47x4bJH5YHRxB5SsoEx7h3USDmghFdN6Z+3iUoTB9hI7v9g3yv7w8mL
 pBE/suAmaqxwON7o5pPkToGQbyUaTlr6IbPsszMvcOtQZ7Xxxar7X12wg0jI50WIs9Pc
 fdIEgT6s5D2tLQTeKSHJqju0m1caJVWwhFUGtT3DwFKvZPtwHvScmoBhot94NgnFjX8K
 raOIw8TwdGEYBUgVU0o4Mwv9TdS7gOExlLBODBNx88+MpXQwJZuQeBzBcvjgf3+LAorC
 UVFg==
X-Gm-Message-State: AOJu0YwRGF2hi5qZgfRWg01Z7FHZM0gajav1shKpPnBuve8jMiNhAbC1
 YfI8lkBJ9UbHR6yAhyiyYuCr9FwrHITN7gUW5wlPENWRIGNV9LRvDs2G
X-Gm-Gg: AY/fxX7G0YlsS5ZCOzC0ux4oIES4COLOX2Z3EbQuz80Yu1B0AknMTFOuVsGGA864j3n
 fTknp44Bm4Wtr7zYIvuhKZA3Liny8yGZFC/dSH4QXB3UAKxDcJmMPKyNw2zZU16JhRQkspCbrRu
 s4+/JCI9M8ltlsbf+3WBRqfnN8/lE62cc00xdEGkEsExetufhXaJ/sCnYLKdChnUFyxQaGjlTGz
 cqPWFroxUVdoWKpEmPlsgWjb+XyvHj6d3JdCbFVloBPsvJOSjUolUTWA0rnYLAqXK2+bimyDg7M
 4yiYCVky4bVvmK2uqpON3MPLs+bUj0+hEHIkmvKUIdAMYjEw3GxLrHVldSs5pQODlCqh0v98fM+
 dkoE4OOM6gR8N0aRyZnPQcrL+fftep0G9lZREUbeLYqe9MO/EGRyKyABHPjg1x9siGyn9ZQQhNl
 ZHV3tgaLeKuEi1LTb3r+P4AH1SFggkr6w4GW8YrcBYw5+laYsFYMjRzZXi
X-Google-Smtp-Source: AGHT+IHOGR1UxlayeoWpEsElgeGOrnawVEIFhxh+GbqFp0MezylcsmdSy/KsQxGGtdCin9XxAUyzhg==
X-Received: by 2002:a05:6808:181e:b0:442:5fa:290d with SMTP id
 5614622812f47-457b211f88fmr10924909b6e.43.1766966753444; 
 Sun, 28 Dec 2025 16:05:53 -0800 (PST)
Received: from [127.0.1.1] (172-2-191-226.lightspeed.clmboh.sbcglobal.net.
 [172.2.191.226]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cc667f9468sm19397294a34.28.2025.12.28.16.05.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Dec 2025 16:05:52 -0800 (PST)
From: Aaron Griffith <aargri@gmail.com>
Subject: [PATCH 0/5] rockchip: sdram: allow reading memory info from TPL on
 non-ARM64
Date: Sun, 28 Dec 2025 19:05:22 -0500
Message-Id: <20251228-rockchip-tpl-use-atags-v1-0-8ac5140c3763@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMLFUWkC/x3M3QpAQBBA4VfRXJuy6yd5FbkYazAR2w5S8u42l
 9/FOQ8oB2GFJnkg8CUq+xZh0gTcTNvEKEM02MyWxtoKw+4WN4vHw694KiMdNCn2Yz6YguoicwQ
 x9oFHuf9x273vB9jH/gpoAAAA
X-Change-ID: 20251226-rockchip-tpl-use-atags-bf3d14a840ca
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Johan Jonker <jbx6244@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Xuhui Lin <xuhui.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, 
 Chris Morgan <macromorgan@hotmail.com>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 Aaron Griffith <aargri@gmail.com>
X-Mailer: b4 0.14.2
X-Mailman-Approved-At: Mon, 29 Dec 2025 02:48:58 +0100
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

The RK3506 TPL provides memory info to the bootloader via ATAGS. There
is already an implementation that reads this information on RK3588 and
others, but it is currently gated behind CONFIG_ARM64. The RK3506 is
*not* ARM64.

This patch series aims to allow this code to be used on non-ARM64, by

 * adding a new config option to read this info from the TPL,
 * allowing the ATAGS memory area it uses to be set in config headers,
 * placing truly ARM64-specific logic behind CONFIG_ARM64.

I'm working on upstreaming RK3506 support, and this is the first patch
series of hopefully many in that direction.

Signed-off-by: Aaron Griffith <aargri@gmail.com>
---
Aaron Griffith (5):
      rockchip: sdram: add option to read bank information from TPL
      rockchip: sdram: remove redundant configuration checks
      rockchip: sdram: allow config headers to override ATAGs location
      rockchip: sdram: refactor bi_dram logic into separate function
      rockchip: sdram: only reserve BL31 and use mem_map on ARM64

 arch/arm/mach-rockchip/Kconfig |  11 +++
 arch/arm/mach-rockchip/sdram.c | 195 ++++++++++++++++++++++-------------------
 2 files changed, 118 insertions(+), 88 deletions(-)
---
base-commit: 0f6ff53d55ba254de8a995c2a2f5a313acd40ac7
change-id: 20251226-rockchip-tpl-use-atags-bf3d14a840ca

Best regards,
-- 
Aaron Griffith <aargri@gmail.com>

