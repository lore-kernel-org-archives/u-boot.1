Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85D41C004C0
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 12:41:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B62E2878EB;
	Mon, 23 Oct 2023 14:41:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="k0Lc1/pe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED69C878D6; Mon, 23 Oct 2023 14:41:47 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A301B8782C
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 14:41:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4083ac51d8aso26146595e9.2
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 05:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698064905; x=1698669705; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5cnPFABFPBFaCPTSr4ChUhUhj5DMXSyZtG+7/7ZXQNg=;
 b=k0Lc1/pePorJqx3rS4rzRLHp1kXD4/P8khosmlqJVx088XT3Qvl9hgZZqWJDypu950
 6BsXOzdLbIBnSfZOrMIbdx+9DcnVisvcI0p1XS2jM1T4NQJr4EIFJSdmRMVm5jDXT+tb
 7mUl4XZzh/gvwJdaUuumSYqvbq8McYhN9ohNxqJ9RDYizF+AaszcfOr+QSraRPcicyHH
 BjHolbNw3I9VQ5kcsb6+TnKkb0XsNpBRBmWcjxLNZLc8p2YQ4LuyZGTdtdAbXWGnySeX
 cP9RODo/GMXNsr7dnAxV3Liu7rB9GCvoFPYqw6oahJgCmCQIUF6NoOC3vBjmN7NrpREq
 /OZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698064905; x=1698669705;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5cnPFABFPBFaCPTSr4ChUhUhj5DMXSyZtG+7/7ZXQNg=;
 b=JgX/K+lOCoQowO3UXlCvnN1aps7mW6F9sqfiyVXw94DJdkyiTn58ArvBW0M4CaLmaG
 t9pu3AFKGY4xu8kVUuf/DbokW8h3eDJ+L6kbXiI9I9x8WD7S1v8fytQVnUDpjLXaFuyC
 0HHdVKmjO5QZEbL8CeQjgIFI59ZSqVpXYXcuY7EhynCimWwwJmrFhfDLREZK2tXqLguB
 8r20IngPl8Y3ugnC8o30HOTt5qpRTKYz9FFqoHzqXvRq4mx1AmQgU4vVz9WWi6RJqWVm
 0TJ77wuAIAzdFuxx5GKlCr8l6MgEMbMe/HtCtNCNAzXVqN2vrJEF2LgMFh7gHWmISOXH
 23ig==
X-Gm-Message-State: AOJu0Ywo0bW7U/QUwPPocJIbinYaIgWcDwhMpNyx+ujQDpZRT/PcxcqY
 qjJt0Ha1K34DcWReBX4IKWYH9Q==
X-Google-Smtp-Source: AGHT+IGtj8vSl5FaJtybvMrLCUrtUklR9aCw158giQgef0PTTl96Z+ynYX8LOIDarZl5dBUZza/pVw==
X-Received: by 2002:a05:600c:4588:b0:409:7d0:d20b with SMTP id
 r8-20020a05600c458800b0040907d0d20bmr657350wmo.24.1698064904970; 
 Mon, 23 Oct 2023 05:41:44 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:982:cbb0:a36e:a5d9:26ae:74b1])
 by smtp.gmail.com with ESMTPSA id
 h14-20020a05600c314e00b003fbe4cecc3bsm14230609wmo.16.2023.10.23.05.41.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 05:41:44 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/4] ARM: meson: Add boot over DFU RAM as an USB boot step
Date: Mon, 23 Oct 2023 14:41:33 +0200
Message-Id: <20231023-usb-dfu-boot-v1-0-df9d121c67c1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP1pNmUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDINYtLU7STUkr1U3Kzy/RTTMxtzCxTLNMSzI2UQJqKShKTcusABsXHVt
 bCwCNnvptXgAAAA==
To: Christian Hewitt <christianshewitt@gmail.com>, 
 Vyacheslav Bocharov <adeep@lexina.in>, 
 Beniamino Galvani <b.galvani@gmail.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3451;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=nbBq2P4CX/p5+oBzaDTLTAOa9TdVkm/K0vgzlOTLf+w=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlNmoDMTRDZk4gBKDWTTYX1+Vd26NiMZaC6HWJ6
 DiHrBOLaw+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZTZqAwAKCRB33NvayMhJ
 0dR/EACYhACtvu2uVmL8H9ZMH9ZjzJiRt/b7qze3WCu5zaA90U9FdC99tv4BjHOw5d5phD9XiQB
 rsDb/tkLFOxISKGkcdLHLL7RVWId1tj4O+w+TuhcvrPZcbhBknwGPgt4Ja9vB+Eo2UdpmlNpIp8
 9WaoMA0rBS6kcsi5g8NlYJpXXm7z2t92hcGyDAwUKb5czqTqrfKaVYaz0VhqNY1jgc60eYsm2ro
 k68iCAXxvva/1ayNKa5wqvLrfsmFaNisYUIHTnE8R1YiqZaBE7jU213cAR0zqTn+SxOZqCzWI1Q
 gT8yZH4+tChDNOLlJNh1eeHqmxgVKp56LvXsor8DIh36/RyNPj2/ro+WFs7jfhRUVq92fDnMEev
 UwjG5yQnL+A8YanDkxeXz+Oe12G+0Cn2STJfFZvzd72xU3qoG3LqwqsZP2UFLjKRNIesLuS2Ok7
 Oua4fHEq+5BlUD2ItnIOJYP/zDWOctCM1B1yl3hnNkEpO/8KToTnOt9kyFzr6iImhamprz3sqwM
 d3MCAuDk57KyRQXp1SCf5IakAXZSk171yjlCOtXZ+J65IDHZ1Qo+sB3XoACtIW76OmdLA+wEekX
 fHVy90JGSIljm/RoQjiHPQAal8ZFe4ESTOh7jyX4R0nifVEE9fx3sX34iyEl3Dm5wRPvwBYneqR
 FqekqwpEovs7ZUQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

Add boot over DFU RAM as an alternate to running script at
a fixed address like done today.

The main culprit is that it's not possible to do that
on G12A/SM1 platforms due to changes in the USB boot protocol.

With this, U-Boot will present a DFU device with a ram slot where
the Host could write a fitImage or legacy U-Boot image, then with the
detach command boot will continue trying to boot the uploaded image.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (4):
      ARM: meson: enable FIT with LEGACY_IMAGE_FORMAT on all configs
      configs: meson64: declare addr out of EXTRA_ENV_SETTINGS
      configs: meson64: add alternate USB DFU boot target
      ARM: meson: enable USB DFU + RAM on Amlogic boards with USB Gadget

 configs/ad401_defconfig                   |  2 ++
 configs/bananapi-cm4-cm4io_defconfig      |  6 ++++
 configs/bananapi-m2-pro_defconfig         |  6 ++++
 configs/bananapi-m2s_defconfig            |  6 ++++
 configs/bananapi-m5_defconfig             |  6 ++++
 configs/beelink-gsking-x_defconfig        |  6 ++++
 configs/beelink-gt1-ultimate_defconfig    |  6 ++++
 configs/beelink-gtking_defconfig          |  6 ++++
 configs/beelink-gtkingpro_defconfig       |  6 ++++
 configs/jethub_j100_defconfig             |  6 ++++
 configs/jethub_j80_defconfig              |  6 ++++
 configs/khadas-vim2_defconfig             |  6 ++++
 configs/khadas-vim3_android_ab_defconfig  |  4 +++
 configs/khadas-vim3_android_defconfig     |  4 +++
 configs/khadas-vim3_defconfig             |  6 ++++
 configs/khadas-vim3l_android_ab_defconfig |  4 +++
 configs/khadas-vim3l_android_defconfig    |  4 +++
 configs/khadas-vim3l_defconfig            |  6 ++++
 configs/khadas-vim_defconfig              |  6 ++++
 configs/libretech-ac_defconfig            |  6 ++++
 configs/libretech-cc_defconfig            |  6 ++++
 configs/libretech-cc_v2_defconfig         |  6 ++++
 configs/libretech-s905d-pc_defconfig      |  6 ++++
 configs/libretech-s912-pc_defconfig       |  6 ++++
 configs/nanopi-k2_defconfig               |  4 +++
 configs/odroid-c2_defconfig               |  4 +++
 configs/odroid-c4_defconfig               |  6 ++++
 configs/odroid-go-ultra_defconfig         |  6 ++++
 configs/odroid-hc4_defconfig              |  6 ++++
 configs/odroid-n2_defconfig               |  6 ++++
 configs/odroid-n2l_defconfig              |  6 ++++
 configs/p200_defconfig                    |  4 +++
 configs/p201_defconfig                    |  4 +++
 configs/p212_defconfig                    |  4 +++
 configs/radxa-zero2_defconfig             |  6 ++++
 configs/radxa-zero_defconfig              |  6 ++++
 configs/s400_defconfig                    |  6 ++++
 configs/sei510_defconfig                  |  6 ++++
 configs/sei610_defconfig                  |  6 ++++
 configs/u200_defconfig                    |  6 ++++
 configs/videostrong-kii-pro_defconfig     |  4 +++
 configs/wetek-core2_defconfig             |  6 ++++
 configs/wetek-hub_defconfig               |  4 +++
 configs/wetek-play2_defconfig             |  4 +++
 include/configs/meson64.h                 | 49 ++++++++++++++++++++++++++-----
 45 files changed, 278 insertions(+), 7 deletions(-)
---
base-commit: 9a0cf3993f71043ba08c315572c54622de42d447
change-id: 20231023-usb-dfu-boot-f47849f9fb34

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

