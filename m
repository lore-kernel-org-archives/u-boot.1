Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CA4FD6ACE6
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 11:17:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2D7C83D8A;
	Thu, 18 Dec 2025 12:17:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EvQOUnct";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC85E83D7D; Thu, 18 Dec 2025 12:17:09 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BA9D83C54
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 12:17:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4779adb38d3so3574145e9.2
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 03:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1766056627; x=1766661427;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cBqgKJ9GGlWp2mqVHeKAXW1L6ZF7A7vn2VkOgfNCT6w=;
 b=EvQOUnctBRICR1mInpV9yqbTnlQ15ViM2HlIo7INyZfsG45Yo/sa2kg/CmET/JcNa2
 9NIta7+pkEflZwT+2BWwESh2AsuaKUI8IettG+ytqjiGQNZtMvSeMIO32RDHbUmY2Vu5
 FeUPvnP1XSf05yPMvbArj+groIN2v76F5R5IF6pQbLd938uprEkFHei/duMPP6GhRKWa
 bLNpsDvEHsnGSrZBSORAdVOxtK6wdQOv5pFh3d3OEvNuURy6j01gXaOglylI7aWkyzjx
 r154S+aIJhI32q40SZwpKSkikWFfj4h/FXotG/5c21XyoVK/Utz4EHKIJNsaL+2U6uoO
 TmgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766056627; x=1766661427;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cBqgKJ9GGlWp2mqVHeKAXW1L6ZF7A7vn2VkOgfNCT6w=;
 b=IgFsrzAMPaLSlC+mAkbz9XgIQSV/1LYeJomBoUherQiPG5RLk/2i7XMj06sJyM2BOc
 wbkntEs0cMOorqMD1NKvCkkjCRQBNDjioVBiwgmC5+mbqWpUwPrL4a8Y41hZPwtZ9o5B
 Dh32LuMAeAq44ypM5Rqw9Heia7NwTWCFX2B//+JY8B9qjSj5is1ShbUdROMcW8kn4EKr
 skPB+pACbyFJmDEWI90euw3UEz+h/8RUVSgiXGzcsu0fZavtk9gJweyxceecpQrURBTV
 xVCnVqBENvwPmeUK/ELZssvW7ObZRFVB2p7Fa+4YlvTuMXzIYA3ThDtjPZU2RLDU98wQ
 BZCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMqEzATLuOWJF8WSMbxk9pkuNBonbKZW2U1emqa7jHSidIJlAUqzLU2TVcXABTFIxno+3cC74=@lists.denx.de
X-Gm-Message-State: AOJu0YwqmXrCpOw8B4eooiTgjgs4DDp0j3QFpM9KvMzba9yBbEcmII1R
 cY+QpNjGecyOns3q7EdVMyDKFLc5TTFSbzLSEbm5TdtnkqhYdIPBCe+OuZAXFN+iPck=
X-Gm-Gg: AY/fxX7tvKOaZdcZhggMuwZwzLUlPiOwweYr9MqGPIb+HP5CO8FoXT9Yiu9PS52IzV8
 VUyAri+dHtz5ssNIjhmbNSH+z9cyxPzIiYGqtUDBuu4NiI9ipP6oX8QziAPpkCNcxvZFs2d0fhj
 C2eGP6zAei5pgZHyqzFe6KxUnhe+3kaxKGTgt9F3DTwzQjheOkr0Mv+8EeNL2aRz8QjOgF7+4EI
 6/acKWr3gwPaDkCrl4SiRFwoAD/doRPpgzz4fqPewfh76I1Kct5WfPNUqT2/PcOYM2L5PJg+pzd
 iKJQQfNuoRRqsWvLx5c3LEL1/Kefeb3X/C/xZuYFMyTKiHvK8vnCXMGUA2ZJgQGhfTYCUVwQ76G
 lBWbc4kqKTbMbp9oRQskDj8NwFRccmVa9Iy+TbuqZetXYjEXKwMBWWLDHwFRsXWMgY+30V8p9+T
 iiPAapK5NwYJaFYw==
X-Google-Smtp-Source: AGHT+IHw82YltqfFSAad5awFyQzJi/6mftWpIqQ3UgjEJUQSpnZXPgdRKBtBjFPHYETgKC0/wJ1FeQ==
X-Received: by 2002:a05:600c:c4b7:b0:45d:e28c:875a with SMTP id
 5b1f17b1804b1-47a97193f3amr169110575e9.31.1766056626783; 
 Thu, 18 Dec 2025 03:17:06 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860:3734:1277:36b8:3f57])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be273f147sm38070965e9.7.2025.12.18.03.17.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 03:17:06 -0800 (PST)
From: "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>
Subject: [PATCH v4 0/5] android: add bootconfig support
Date: Thu, 18 Dec 2025 12:16:55 +0100
Message-Id: <20251218-bootconfig-v4-0-5bbbdb0be1dc@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKfiQ2kC/13MSw6DIBSF4a0YxqWBKxbtqPtoOgC86k1aacCQG
 uPei076GJ6T/N/CIgbCyM7FwgImiuTHPNShYG4wY4+c2rwZCFBSQs2t95PzY0c9B31CUNpi0wD
 LwTNgR68du97yHihOPsy7nWB7N6aSQupvJgEXvHbaQQdYKa0u1sx3sgGPzj/YJqXyU0upfuoy1
 wZqW8uytaYRf/W6rm8VWtDx5QAAAA==
X-Change-ID: 20241128-bootconfig-276e247be992
To: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Julien Masson <jmasson@baylibre.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>, Nicolas Belin <nbelin@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Aaron Kling <webgeek1234@gmail.com>, George Chan <gchan9527@gmail.com>, 
 Sam Day <me@samcday.com>, Jerome Forissier <jerome.forissier@linaro.org>, 
 Maxime Fournier <mfournier@baylibre.com>, Eddie Kovsky <ekovsky@redhat.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Guillaume Ranquet <ranquet.guillaume@gmail.com>
X-Mailer: b4 0.14.3
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

This patchset add support of android bootconfig partition[1] in u-boot.
With Android boot image v4, all androidboot.* arguments must be
passed via bootconfig instead of using the kernel commandline.

[1] https://source.android.com/docs/core/architecture/bootloader/implementing-bootconfig

Signed-off-by: Guillaume La Roque (TI.com) <glaroque@baylibre.com>
---
Changes in v4:
- Create some subfunction.
- Update some variable name.
- Link to v3: https://lore.kernel.org/r/20251114-bootconfig-v3-0-a28b813dba90@baylibre.com

Changes in v3:
- fix test check
- reate subfunction for bootconfig append
- Link to v2: https://lore.kernel.org/r/20251017-bootconfig-v2-0-8c7c2f2e5474@baylibre.com

Changes in v2:
- Add test
- Add new command to be able to load and read bootconfig before booting
- Somes fixes to works with sandbox test
- Link to v1: https://lore.kernel.org/all/20241128-bootconfig-v1-0-0e63a5dae82c@baylibre.com/

---
Guillaume La Roque (TI.com) (4):
      boot: android: Add sandbox memory mapping support
      boot: android: Add bootconfig support
      cmd: abootimg: Add 'get ramdisk' command
      test: abootimg: Add test for bootconfig handling

Mattijs Korpershoek (TI.com) (1):
      boot: android: import addBootConfigParameters() from AOSP

 boot/image-android.c                        | 255 +++++++++++++++++++++++++---
 cmd/abootimg.c                              |  35 +++-
 test/py/tests/test_android/test_abootimg.py | 108 +++++++++++-
 3 files changed, 364 insertions(+), 34 deletions(-)
---
base-commit: 5d4c94181c1ca835039cb27563f1a2d51e0a99db
change-id: 20241128-bootconfig-276e247be992

Best regards,
-- 
Guillaume La Roque (TI.com) <glaroque@baylibre.com>

