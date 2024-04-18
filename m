Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB5A9C4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 18:40:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43C3B8868F;
	Thu, 18 Apr 2024 20:40:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZQXLYkY1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DF5B886AB; Thu, 18 Apr 2024 20:40:14 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 201F88868E
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 20:40:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-418c979ddf3so9344895e9.0
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 11:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713465609; x=1714070409; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sjLHACBgK+vcRDWMtkjchysDpTpet5WiqkUXD1z9gtU=;
 b=ZQXLYkY1kq+wv0mbycEE/e1KFbDedd+8LZFT/cmCslOIMyPbXfvumOM723zCHvrYd8
 X/rO3T8wL9rC7TxxzRrBYVUCI42OLrMPi74c/CorXbNf0/y64N9ZlC6YsU/OtuPTUV8k
 6sFIUJBBpmS7qo4kW0SiNaAYbHkc3a4eRSlaBtW9xlQMzeWIJ8DEha2o87J9rcosWPo8
 /i9mv/KXKx5T7uL/OUOMMTOOYSy0TPqqZAGf7CFt/O3ENUhf6tZ/G7ZpyhwGM4ikfZ25
 HD57RnyXko5djcnZcYwUgEjOfYaml7yS/3n6J7xmApAI4fwzMHCiXYo3J7vpLQ0B1krU
 1aaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713465609; x=1714070409;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sjLHACBgK+vcRDWMtkjchysDpTpet5WiqkUXD1z9gtU=;
 b=oLamPUUTUI/VtP335Vu8sd/V3A0oFVSBFdPtQrnx+m5W8MVplpzmrqvEaIGwNie/1c
 yNzKPXvf6Lizmc2UZiN1pWMx7JaPVyMZiPdi8t/ryEuq9SvioanPaST97mPaUXjZXeSn
 llw8gf32ZzYk9m2Nim8LCV4TsgVLhWBv6M5zrn92Me5XcWzMJ8kW4bAA7XfmGyJCN7Ca
 jww0VyToAZt4LI9EPERiHRIbEgJ0FrMpESsCt3I4GIhdS3oOeNN+1phYvPM2y9KPzS0k
 m4Zd9XjnczDGZVJxFUXs7DrOdt6669wpkMQUPatek0XsmH5YBXiutb8zqqhJ73wNShyU
 +pZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZ8NsFSR6KktYfpvUZWmLQJD39YX3TFoIMxp0qJxiMD6BKNc7+SqJi9HcMYcW8W0smh/yFSP0kLDyl82TagrCVjfwQtQ==
X-Gm-Message-State: AOJu0Yy3gdUtr6zMop2qjs73rKgNNhsB+OkUgrj2xncsW5ECfv8HdXBu
 zIrUJRV02uGoIaZcvBy+E7hK2cDx1PKjAjg9SXbkchhciStj9dN6ZxSVNzmoEEE=
X-Google-Smtp-Source: AGHT+IGGpEFdz0vn87RV8POkmxT40Css0xZtRV5FHGqWhTKxbHYTVifSXLIa4LgcXKx7ck3bGW7elw==
X-Received: by 2002:adf:f284:0:b0:33e:7f51:c2f8 with SMTP id
 k4-20020adff284000000b0033e7f51c2f8mr2298584wro.36.1713465609433; 
 Thu, 18 Apr 2024 11:40:09 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 y5-20020adfe6c5000000b003436cb45f7esm2451408wrm.90.2024.04.18.11.40.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Apr 2024 11:40:08 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v4 0/3] upstream DT compatibility
Date: Thu, 18 Apr 2024 19:39:55 +0100
Message-Id: <20240418-b4-of-upstream-build-vendor-v4-0-d404deff386e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPtoIWYC/43NQQ6CMBCF4auQrh1TS5XgynsYFi2dwiTYkik0G
 sLdrZzA5fcW/9tEQiZM4l5tgjFTohgK9KkS/WjCgECuWCiptNSyBasheljntDCaF9iVJgcZg4s
 Mrm+01b5R2BpRCjOjp/dRf3bFI6Ul8uc4y/Vv/a+ba5DgZXtzKPvrpbaPiYLheI48iG7f9y/2v
 I7cxwAAAA==
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2646;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=HjouCWgGS/9nBbORaA1EPkaeBgM4pFZxOqP1tuGirE8=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhjTFTPY1mudvPO2a3uYZukwt9lfvn+rjzXa8Yqlxh7Pjl
 uo05EztKGVhEORgkBVTZBE/scyyae1le43tCy7AzGFlAhnCwMUpABOZeY2RYWE4+515XBeyNz31
 zGf9n3p910o99uxl1dtuZBxe9mbuv2SGf8ZCale/3J7wNdvGc6Ulu8FaFstLbALHvpyK+FfwZ3H
 Ub00A
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

This is a subset of [1]. With more platform maintainers switching to
OF_UPSTREAM I didn't want to get in the way (it has also proven more
difficult than I hoped to remove only the fully compatible header
files).

This series removes only the dt-bindings headers which contain generic
data like GPIO flags, input event codes, etc.

It then implements support for building all DTBs for a vendor with
OF_UPSTREAM_BUILD_VENDOR. This removes the need to maintain a set list
of DTBs that can be built by U-Boot and opens up the possibility of new
boards becoming supported "by default" just by landing their DT
upstream.

[1]: https://lore.kernel.org/u-boot/20240321-b4-upstream-dt-headers-v2-0-1eac0df875fe@linaro.org

To: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
To: Lukasz Majewski <lukma@denx.de>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Stefano Babic <sbabic@denx.de>
To: Fabio Estevam <festevam@gmail.com>
To: NXP i.MX U-Boot Team <uboot-imx@nxp.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de

Changes in v4:
- Fix imx6dl-brppt2 board which had an incorrect relative include path
- Link to v3: https://lore.kernel.org/r/20240409-b4-of-upstream-build-vendor-v3-0-f096de0c513b@linaro.org

---
Caleb Connolly (3):
      arm: dts: imx6dl-brppt2: fix gpio.h include
      dt-bindings: drop generic headers
      dts: support building all dtb files for a specific vendor

 arch/arm/dts/imx6dl-brppt2.dts                 |   2 +-
 dts/Kconfig                                    |  24 +
 include/dt-bindings/ata/ahci.h                 |  20 -
 include/dt-bindings/gpio/gpio.h                |  42 --
 include/dt-bindings/input/gpio-keys.h          |  13 -
 include/dt-bindings/input/input.h              |  17 -
 include/dt-bindings/input/linux-event-codes.h  | 806 -------------------------
 include/dt-bindings/interrupt-controller/irq.h |  19 -
 include/dt-bindings/leds/common.h              | 106 ----
 include/dt-bindings/mux/mux.h                  |  17 -
 include/dt-bindings/phy/phy.h                  |  26 -
 include/dt-bindings/pwm/pwm.h                  |  14 -
 include/dt-bindings/spmi/spmi.h                |  10 -
 include/dt-bindings/thermal/thermal.h          |  15 -
 include/dt-bindings/usb/pd.h                   |  88 ---
 scripts/Makefile.dts                           |  13 +
 16 files changed, 38 insertions(+), 1194 deletions(-)
---
base-commit: 2c3fa4b8add3cb6a440184ab67debc6867d383c0

// Caleb (they/them)

