Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A51C9EC94
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 14:49:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E56483935;
	Mon, 12 Jan 2026 15:49:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SDXM5KXB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAD1983936; Mon, 12 Jan 2026 15:49:39 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33B8B838A5
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 15:49:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-64b608ffca7so10095384a12.3
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 06:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768229377; x=1768834177; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/R2/gS9LmL0+dZ5hPCm5ZBf+ZvEJfZCyx7mHWh7WFKo=;
 b=SDXM5KXBQfoBiGZpxk9UZSF53XXyT2jxeKaEWCWiU8bckc+HWPlN4tLt7aIgQSKmfV
 Ptwz9cdHEd23yVlMB6vjqKzEEUZpEQw/F3eHWwYcj9Igl/NZ9KIfApooM927RY6/zdFZ
 UguEIsUb612sznu2IjJuuAi+8TL/n15sV9nLv/wl8iLHy/UMSsQ29pSf2K2dRWBqu4zI
 pRXfff8v0oeaFaYzPDA5Ko0CNxpUkka2vjm/Xx69z9SycuNVBiTwEvFTx/9bw8q6yqT0
 ARdyuvrdh3UGiI7kV/2s+zUTME0qzzdEM532rAGpUWcQAmywSM82oIZVSMjc3KuruX7P
 M1Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768229377; x=1768834177;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/R2/gS9LmL0+dZ5hPCm5ZBf+ZvEJfZCyx7mHWh7WFKo=;
 b=K10R6sfSUPAC1aDK17I3xLMK9p3B/Ji0eRPI0frEjV17OoSUzcf/jmT7a/YSA0Xb3l
 n8g7SUacHe0We2SGifjnlELmFH8s5Civj3IwkeRFVLJ0IkXeqf3Uj0q7KlhKsUyVQ6Te
 hh1pP7niKUp2jP+V87/GLcW35y4Kztw1+syBQ4ZyS7sY7h5We0Cco2hVwZalDvE2RJlO
 ccEPn2M4b7YGSbkBPwDAXjRZkoRrBG47/+Ni1YZJCHwyRny0kt+1GfxumwKq61PlcJ+P
 CIr6EK2VVnbZ9fpmGEwdvo91MiFYUdQVfUhXSoL6WegboL6dt2Uvq6dZnV1U9MDQokqF
 1m2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVW0WjXyptwv1moWyD2QA26ubF5ZhQFRWwRitPQiKoX6oSD2MyXcZbVwmIk/bMn7a7U8UsTltk=@lists.denx.de
X-Gm-Message-State: AOJu0Yyo9KQ68V58muZCs/4tkfyjgbZ/r/tAcTIIDmlPacdN0gBxA61/
 8YuVPz16k3ymShytOwdBx3xjEOxswOBif/RaFS0UArjKgcbCebKbfVcO+QNsv7vbTdY=
X-Gm-Gg: AY/fxX4qo1Fj9Ycp96U3KZkQu+OyniwNBQlFDlXDfSuotsBuzC5NZ26bZxvughCetdP
 P57dqrXlfZah8VW4dX+76rhArpfkepjdDBXgD9oSNlS43EQnRP9ZdS6wI/Ww4Jus7SVVjUutkk6
 evBgXJ9cSxyY1uRf5Pxs/iQAC30OQ7K5VzzIPPKJwQC+FPPlWNQ90gfkXacpE6O41ILsI+OkLhJ
 +mnFjpGmdBLrnFqxo+JWxR5pl8UhZeyj+P4C5cXV2KeMnzcHkE9M3dr1vHtekdwAIAly/aIkgM0
 3GzYD4nrg8Tgo5WcvwULfGg43RprOuKYI2age6mmKOweCTl/0B1CcdTsDAUhpcBwDne48I3bgru
 kXRo8xHc7CVyaUJkG3dwpeqjWRxT/qz3VsOUYqfq7UnIw0h2EkgXhBEgwpdu+JcrDLgVuICtpGq
 K1SebAmk6iMfOQkZ3nQF+84fG1z3Suf0SsuvK0u4pjgoVjzVHbwu9yTTaxDY5b+Q==
X-Google-Smtp-Source: AGHT+IEnquXirvBalpBhEPYbdg/zdX0mXg0rAiQB9nvqvpc8ExAnfrHbLtj5vmMUaUT7R6I0LvQE8g==
X-Received: by 2002:aa7:dd47:0:b0:64d:1a1:9dee with SMTP id
 4fb4d7f45d1cf-65097e49cf1mr16575771a12.16.1768229376637; 
 Mon, 12 Jan 2026 06:49:36 -0800 (PST)
Received: from lion.tail248178.ts.net (p5b29e30b.dip0.t-ipconnect.de.
 [91.41.227.11]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6507bf65c07sm17786640a12.23.2026.01.12.06.49.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 06:49:35 -0800 (PST)
From: Casey Connolly <casey.connolly@linaro.org>
To: Casey Connolly <casey.connolly@linaro.org>,
 George Chan <gchan9527@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, Marek Vasut <marek.vasut@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Subject: [PATCH] usb: gadget: fix vendor/product id for qcom
Date: Mon, 12 Jan 2026 15:49:30 +0100
Message-ID: <20260112144933.3992369-1-casey.connolly@linaro.org>
X-Mailer: git-send-email 2.51.0
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

Due to a typo the defaults for Qualcomm were never actually
set, this got missed in the original patch (maybe time to rename
ARCH_SNAPDRAGON...).

Fixes: 934647d49c61 ("usb: gadget: Introduce usb gadget vendor/product default id for ARCH_QCOM")
Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/usb/gadget/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index 7e08aeab9043..ebb306852a65 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -60,9 +60,9 @@ config USB_GADGET_VENDOR_NUM
 	hex "Vendor ID of the USB device"
 	default 0x0955 if ARCH_TEGRA
 	default 0x1f3a if ARCH_SUNXI
 	default 0x2207 if ARCH_ROCKCHIP
-	default 0x18d1 if ARCH_QCOM
+	default 0x18d1 if ARCH_SNAPDRAGON
 	default 0x0
 	help
 	  Vendor ID of the USB device emulated, reported to the host device.
 	  This is usually the board or SoC vendor's, unless you've registered
@@ -88,9 +88,9 @@ config USB_GADGET_PRODUCT_NUM
 	default 0x350a if ROCKCHIP_RK3568
 	default 0x350b if ROCKCHIP_RK3588
 	default 0x350c if ROCKCHIP_RK3528
 	default 0x350e if ROCKCHIP_RK3576
-	default 0x4ee0 if ARCH_QCOM
+	default 0x4ee0 if ARCH_SNAPDRAGON
 	default 0x0
 	help
 	  Product ID of the USB device emulated, reported to the host device.
 
-- 
2.51.0

