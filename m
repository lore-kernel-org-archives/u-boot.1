Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D3DC5AD49
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 14:24:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C32B82DB7;
	Mon, 26 May 2025 16:24:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="m5VAHLDQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF1BF82F00; Mon, 26 May 2025 16:24:48 +0200 (CEST)
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com
 [IPv6:2a00:1450:4864:20::544])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5ED4682D4A
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 16:24:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.czechowski@thaumatec.com
Received: by mail-ed1-x544.google.com with SMTP id
 4fb4d7f45d1cf-602c4eae8d5so4500429a12.1
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 07:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1748269485; x=1748874285;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1C3tWUj7xQ6RC97Dc7He2P0F+AdKjLWmiRVHSp2AvrM=;
 b=m5VAHLDQuZiXViv0tF9fgLsKlMHnEKJbmfU5yy1WZrWcgIXuxtYud0PNUleQJ9IKeG
 uyy2DcTDKd57yvDFcQljL1evTJ5Gf1F4iAY/Mlb6pmUjvRYw9oQlQIiIe6qH8NBlDqnR
 00WSf9ENrrJ4ksqPBztmhvy7SdbWR/GrN+waqM0b3ilvUse0aBTv52Mm9unMo3XH6HuA
 +7sRhegty707E0SY2TTl388cAj5iROoXJ8rtpo97mjhPcCG9+gFEmc6KNFg1umV51Zc1
 iJkjU7dIRzPSzCRaY8kl56bfecXHD0lFTvzxdXwuM6i5aP1tDJ0IR07NGjJ1UK6NqefK
 IqvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748269485; x=1748874285;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1C3tWUj7xQ6RC97Dc7He2P0F+AdKjLWmiRVHSp2AvrM=;
 b=gN8e/BmKSi3qT74vlmK9b6sJ0xK0NhPxwwubRuixJg18W3r7m5+IDYNsRaB7jl4fdt
 8pVAxcj+uDkzaZjmQgsQZiDHHibJlf1u1/hsohJwTdrDG3p0EnnUVvyoDMfGMfBs6GDd
 zX48YRbDaicAXnVnjC0DiN7aWGjLYaSJzeYyPdVE2y3CIgKarXztcm1VC32EGmDlAJr/
 T8ZHbkUZQ4sCqsjBLTvsBI5ck5Q29kYVb0LHXftlJBec8Z/l3qUc85afibYxqEnTFWwd
 2oXo+KaloSvPwi2uTHCq+76ch/gDFlRYCgctY2w4xRZfOpK+bjc7fAPaFV0jthW1XuLA
 /Kmw==
X-Gm-Message-State: AOJu0Yzwx5YYaRdGCZpBzg0iND1uGoC+GFWnysHF/TqrMx72lzQL8FgU
 OKHK9YkZcGVPXVdK0yo7+NCVeN9B0oDsMtK0wGiSmAQg70pDme0X6NFn9ISUPoOf0DXl/o0mKuG
 xWIMXwreKqw==
X-Gm-Gg: ASbGnctg0jurQvUH1mqOVMtZpOgUhWEkE66X1EzQYykbDY+I/loBlAfB1Fs23qxDVor
 pQ10L+JI/842nM6OY6723iXQFwsMmUdz072+IK7IY6KFkAFEuenCiLYi2tX/vp0BoU1fXvQ54Sh
 DCt85ax/Be74PpMUArZCFuHmuSDHzZ2GKgWnxGzUwmqnchvnhoZlgrDhfSANigyHeKMoN9QH486
 Df5NwPuoW+/eqWxNuT5xqeE/faVe688SHtx+7KLSg7XdOl1QAtuoFRccNyck0cJj/QaUo2LLjgH
 QuxmeNzBKeivlvi8egNlUnv/g1s4WzMTdE+gtE6F71ir+pWKezg+9haPIeE2UzQJ
X-Google-Smtp-Source: AGHT+IETOdCoEE0R5hD4bU3vtFgtQFDT0ev8ik0W1J5RV05SgRW0sSUfSC7KzGkeguerDXcKhdeQjQ==
X-Received: by 2002:a05:6402:3550:b0:5ff:f3f2:d88e with SMTP id
 4fb4d7f45d1cf-6028d7b033dmr10429080a12.12.1748269485582; 
 Mon, 26 May 2025 07:24:45 -0700 (PDT)
Received: from [127.0.1.1] ([91.90.172.13]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6045c6d25dcsm2926950a12.8.2025.05.26.07.24.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 07:24:45 -0700 (PDT)
From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Subject: [PATCH v2 0/5] Extend usb_onboard_hub driver to support Cypress
 HX3 hub family
Date: Mon, 26 May 2025 16:24:19 +0200
Message-Id: <20250526-usb_onboard_hub_cypress_hx3-v2-0-f382415da84f@thaumatec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJN5NGgC/42NTQ6CMBBGr0JmbU1/RNGV9zCkKcNgu4CaDhAI4
 e5WTuDyvS953wZMKRDDo9gg0Rw4xCGDPhWA3g1vEqHNDFrqUl50KSZubBya6FJr/dRYXD+JmK1
 fjNCVUffKdIpaglzISxeWo/6qM/vAY0zrcTarn/2vOyshhUEsnbzK6obdc/Ru6t1IeMbYQ73v+
 xeWwAeaygAAAA==
To: u-boot@lists.denx.de
Cc: Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
X-Mailer: b4 0.13.0
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

This patch series extends the usb_onboard_hub driver to allow for
support of more types of onboard hub devices, and adds the Cypress
HX3 hub family.

First patch in the series updates the bind function, so that it no
longer uses hardcoded compatible strings.
Next patch simplifies the code, by removing unnecessary dm_gpio
function call.
Third patch updates the remove function, which allows the prevent
issues with usb devices reenumeration, in case of calling
"usb reset". Although the issue could still occur in case of invalid
initial state of reset gpio, it is minimized with no impact on main
usb_hub driver.
Fourth patch extends the driver with support for multiple power
supplies, the same way it is done in kernel driver.
Finally, last patch provides hub data and of_match table entries
for Cypress HX3

Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
---
Changes in v2:
- Replaced the method for finding hub in bind function with
  uclass_find_device_by_ofnode, which seems more appropriate 
- Added new patch that removes unnecessary dm_gpio_free call
  in usb_onboard_hub_remove
- Create separate static method for disabling supply regulators
- Update error handling in probe function 
- Link to v1: https://lore.kernel.org/r/20250425-usb_onboard_hub_cypress_hx3-v1-0-3cc5a06087cf@thaumatec.com

---
Lukasz Czechowski (5):
      usb: onboard-hub: Use the ofnode to check if the peer-hub was probed
      usb: onboard-hub: Use devm API do automatically free the reset GPIO
      usb: onboard-hub: Set the reset gpio pin before freeing
      usb: onboard-hub: Add support for multiple power supplies
      usb: onboard-hub: Add support for Cypress HX3 family

 common/usb_onboard_hub.c | 103 ++++++++++++++++++++++++++++++++++++-----------
 drivers/usb/Kconfig      |   1 +
 2 files changed, 80 insertions(+), 24 deletions(-)
---
base-commit: 10f48365112b164bee6564033ab682747efcb483
change-id: 20250425-usb_onboard_hub_cypress_hx3-2831983f1ede

Best regards,
-- 
Lukasz Czechowski <lukasz.czechowski@thaumatec.com>

