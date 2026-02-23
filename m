Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72B96EEC2AD
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 23:22:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABDEB83DCB;
	Tue, 24 Feb 2026 00:22:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bkUOvOFp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43E2083D3D; Tue, 24 Feb 2026 00:22:53 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B362F83981
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 00:22:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7d4c4cacf78so1774394a34.0
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 15:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771888969; x=1772493769;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=udK2O66ys2zSQ/GNIxIrGozmB2HKsgvjKoY9S4yiyDg=;
 b=bkUOvOFpyIJMpch0EPGmbQyHsgbSe+48sZsw7E0/qTjG5758rjm++bpoOmlFQ5tCMw
 X9Lxlv+Y4JXLulIlHKXJ6h2fF5l5ORyL6TPdGLWH/hxyDMmsF59VqSZqOSEpV0ydUzkg
 NwG5XvKqrPykI0NV3RuqgYpJS0AQhbsdvDkxmqHQcA7zmLuLqjCwufxYGNovuVisgq+l
 3VmmGdBP0XP5htDKK/REAJ7/35B7nbLMx/WLtjKQRLzd3+tBktnW9ELl6nQlbtVyq37l
 kWvNA+rYK0/c6cxZ5BbO5B8G4yNkuAiRQqYSFWvXAQ/f41PspAOJM05TwSiemc6tXBW3
 qwQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771888969; x=1772493769;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=udK2O66ys2zSQ/GNIxIrGozmB2HKsgvjKoY9S4yiyDg=;
 b=k9eDmCN6UMrQnwyKIKQEFHBUJs/7gIjhXsBV/ic4MFu2LtOjr2TBu5xSIwzvUuCmPJ
 9Tvo3FyqIucim9m19iEav73KPAdh2R0uukF7whsC0ClYXjTtJJk2FYOllCx7OrIsezUL
 Dm7w2XUGYOUeAhMUheBR/1xHR+Y13r9NhEOPQU3Wm4gtFOjCdlq5QLxZgrNieRbKAap5
 fj4N5TzMuxfZoAJKtJF54nqH53C/t57VkMWYT2N5peBJkDkfBxt0YndT55mY0X1UjlFr
 R4uRwOtZR7NB14RIdpZ73PSz2AymKa/58vV/iicORAwQkivk5LP8Ke8wRRQWzcw0DWLD
 GrKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOV14sG5yCarD7SzLObb+KdxPxf8X/27cK2bcOGeOwI7qlTPOm6QFT4wq0quOg0lRFwobgwXQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwRKo2WZBW9IHzNKXRV0k+EvXKXsilb9ot7SL6GdThbrtZu/Tvg
 sTJ65PvyZ2x+sPd7SXYOf+WdY1FXFTfZ2Fosw6aI7vo9VVa8yO9NBFk47M7o0SNuN0M=
X-Gm-Gg: AZuq6aL6TPczrKRPbtstzzorxUnD9b+//aU6xNn54aegi7hobRqsp1yJfGIuTewnbc+
 TXh+OS67zJF+LhAiXAtZYHeOkdujDfVbpKhwWU7ShaxY2jTNfsmcvsZgVC6iclj41WbMYw+MdOg
 xII3DYkljlnEvk8nhnK/Amw/pcBR2pjGuuZP1ud6gcFEjX8n+kELO3A/+jXGJi78UGfsDQbRRaD
 J2KBBQyzcuS1u+RrjRA7KBbYJHuwyjHFuVRx2Lq6SUS7yuTnYb1jLtOyKImZjnPG5ddmgoGaJ0m
 SSUOyVF5j/u63alxNyR34dvPlcAzm0z37qI/+pEPK9VlCd2SxhtO3tXb1O1HsggTn0AaKGZhZdd
 Rdw1VZP3M8Y8Z/LSBAtEbyWuLlqyHsSv6eLtU8ZggL68DYM9280qsO8118oTvvitXdTgpdzwmqW
 jN5rcJJ/k6eKpX6LX/ZSbXoX95d/Ja
X-Received: by 2002:a9d:6c09:0:b0:7cf:e41d:f0b0 with SMTP id
 46e09a7af769-7d52bf3ecafmr5414282a34.18.1771888969380; 
 Mon, 23 Feb 2026 15:22:49 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:cb87:475c:5c04:ac92])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52cf78736sm8911230a34.5.2026.02.23.15.22.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 15:22:48 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/7] clk: mediatek: clean up flags
Date: Mon, 23 Feb 2026 17:21:52 -0600
Message-Id: <20260223-clk-mtk-remove-clk-bypass-xtal-flag-v1-0-a7dc97bc2660@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXOwW6DMAzG8VdBOc8dcduNoWnae1Q9OMFlFoR0c
 Yaoqr57Mzj+v4N/vhvlJKymre4m8SwqcSphXyrjf2jqGaQrbbDGtxpxD34cIOQBEoc485rudiV
 VWDKNcBmpB4+MvkEi5w6mXLomvsiyKqfz1ol//wqWt9EEVqUVa6vPzbLvqxNyY5uP4kQ/KMwIN
 fhu31jf1Uc82m9Ht1Fc4p2P4esfc6TlrRiC5LaKSXqZXidesjk/Hk/ExbNi7wAAAA==
X-Change-ID: 20260223-clk-mtk-remove-clk-bypass-xtal-flag-c2e2c82aabb4
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2643; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=n+3cqOvWtvSnXDt0pHCdluH+ldR2+t9l402th/1y66s=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpnOEU99mrobPGfAb06sWjNmxKs+YxICU25PvR7
 ZHzcGv6z9SJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaZzhFBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ACzQH/2uoYn14IbJ2mdIlRmRn4/IEFHnH6BjAQxJm3qi
 6Zt7nxIGcUTv39dWtzfcFVyPh1dHagpfcV6p7jnM2WljW6vgfB+p+pAM6/Np66uebMCTu7jLEfK
 Vl35pGOZ1tc2B8+G45HmGXMJZMTLXeEz9dP0y2m4Po6yIArwgYuYtEf35zNQeWIwjd+/a6hSB5N
 lh0yQIMvtzmYTdRwhvNQOLo5VsizeR9T9vbvgLxG8Yjrqo/wF0UVcEwEQSkZCYUbc3L5mFn0PfI
 ZwFXGqZ5xuLw4lKcXMtB//Tee74Xvj75Sytsm2prK2F8nqz2K9zj3Fhev3tSpG6qyrcEP7alEnA
 GFDE=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

The main point of this series it to get rid of the CLK_BYPASS_XTAL flag.
It was a bit of a hack to allow mux clock parent arrays to contain both
CLK_XTAL and CLK_TOP_* clocks. It's usage doesn't work in all cases and
is easy to get wrong.

In the meantime, we have added CLK_PARENT_MIXED and struct mtk_parent to
handle mux clock parents properly. There just a few drivers that were
not making use of this yet, so those are converted. Then we can remove
the problematic flag.

There are also a couple of other patches to give better names to some
of the existing flags while we are cleaning things up.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
David Lechner (7):
      clk: mediatek: rename HAVE_RST_BAR
      clk: mediatek: rename CLK_DOMAIN_SCPSYS
      clk: mediatek: add MUX_GATE_MIXED macros
      clk: mediatek: mt7622: change to struct mtk_parent
      clk: mediatek: mt7623: change to struct mtk_parent
      clk: mediatek: mt7629: change to struct mtk_parent
      clk: mediatek: remove use of CLK_BYPASS_XTAL flag

 drivers/clk/mediatek/clk-mt7622.c | 334 ++++++++--------
 drivers/clk/mediatek/clk-mt7623.c | 777 +++++++++++++++++++-------------------
 drivers/clk/mediatek/clk-mt7629.c | 448 +++++++++++-----------
 drivers/clk/mediatek/clk-mt7981.c |   2 +-
 drivers/clk/mediatek/clk-mt7986.c |   2 +-
 drivers/clk/mediatek/clk-mt7987.c |   3 +-
 drivers/clk/mediatek/clk-mt7988.c |   3 +-
 drivers/clk/mediatek/clk-mt8183.c |  12 +-
 drivers/clk/mediatek/clk-mt8188.c |   6 +-
 drivers/clk/mediatek/clk-mt8195.c |   6 +-
 drivers/clk/mediatek/clk-mt8365.c |   4 +-
 drivers/clk/mediatek/clk-mt8512.c |   4 +-
 drivers/clk/mediatek/clk-mt8516.c |   4 +-
 drivers/clk/mediatek/clk-mt8518.c |   4 +-
 drivers/clk/mediatek/clk-mtk.c    |  14 +-
 drivers/clk/mediatek/clk-mtk.h    |  16 +-
 16 files changed, 820 insertions(+), 819 deletions(-)
---
base-commit: 8fd76675efbe7af785ccc1ba1ac8b9f7e10f6715
change-id: 20260223-clk-mtk-remove-clk-bypass-xtal-flag-c2e2c82aabb4
prerequisite-message-id: <20260217-mtk-mt8189-clocks-v2-0-cd381cd05251@baylibre.com>
prerequisite-patch-id: 81f2dd4fd7c1632736c08180d6b9f6aef5fe1e7f
prerequisite-patch-id: 0414664c8d24f8303d238aa1c4389072ba9f8613
prerequisite-patch-id: b63492590bec532b0347be3b495cd1779b0ad3ce
prerequisite-patch-id: 9e03fea677d2d9b5ae6860e700f62b27db270e64
prerequisite-patch-id: 3d5661f9e55292a30f57617848a7b10e67844402
prerequisite-patch-id: ccbc73b2bc1dc41beb295604088d63773cea15ef
prerequisite-patch-id: b33a67f241d097c90de822f33c0f82b9de1890f7

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

