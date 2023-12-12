Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6573EC4167B
	for <u-boot@archiver.kernel.org>; Tue, 12 Dec 2023 13:52:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95CED87732;
	Tue, 12 Dec 2023 14:52:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="phKiZwfT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20672877DF; Tue, 12 Dec 2023 14:52:40 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1551A87682
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 14:52:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40c38e292c8so20413485e9.0
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 05:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702389157; x=1702993957; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9BUGwmGFcDY+IhkUcSuijLh2l7kcVUOWbu+kR/rDWbU=;
 b=phKiZwfTv7563iOV27+UNo2gQhdSSptydbKWYDUHlAYofIcL/PlFmaj3n25mI+OGY5
 wNpzMirUHVy4+m3BX03sklmTm8v0rUf06AjH93RN2hHlYQKm/Fi37xewLIBkDVq6EpuG
 B5VQXE46wnNVifGrH7iGSPj0LgEwErBevS6yfu3tLxFxRDGrjv+wb1VpmOt7BLKghPLL
 MtodjRI8i1j9PRVXGgoLnYiB+7+cEewv52gn4pmIrRE3aG7f/PUzyAvCqjRdaA/KY45+
 NSwD1frxgl1JLC08HQ8x/b9Ctryc6C/QQJKmsXojnrrAy89vIvicmS6z64D3YohAAArM
 Amog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702389157; x=1702993957;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9BUGwmGFcDY+IhkUcSuijLh2l7kcVUOWbu+kR/rDWbU=;
 b=fVKFFxdJw+R4wAGMc8THYWNmdlfpAkyni0iWR+3haIRXkeQmVx7rAsySvb8Ac5cdVx
 PKCgurdjRXmnjnA27YUhGPQOPuTFuHZpxJflzxVbUhaJHD3Zk4z2JhBtCdddbBin1tox
 jMi0Zpqlbe0K5o8qgpHYBKVt33uM7U6RR8dKn/Fyy11OMrr806CtcYimqKoH8ujwh43J
 drQ5WF/N3x3VN/thxEHYAruK81WkesNv/V0gC79+6B2gyM+JSh47oW/jrqE9O2zr2qO7
 NNQz0/zDSfYKHozgfqrVC24HQEMV2x4U5u90+WrYjfrhl+iBHq/IaeMLoMv3Gx7do43i
 4QYw==
X-Gm-Message-State: AOJu0Ywa0x8CEH06JrAEfZ3gF6qcejxTb/TjyKUv/DdRZva8DbnHlEap
 n4bGXZR5CIyZTDQ4ANW7US4YDA==
X-Google-Smtp-Source: AGHT+IE/N4ehX3YPS1Mg48s3oTq63npB+iNLIAHcwOx23LifD9Q50HlXvXqCqJfioxO71ZREbXgObw==
X-Received: by 2002:a05:600c:4ca7:b0:40b:29e7:c150 with SMTP id
 g39-20020a05600c4ca700b0040b29e7c150mr3306972wmp.0.1702389157416; 
 Tue, 12 Dec 2023 05:52:37 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:982:cbb0:5894:fa62:26b4:bf82])
 by smtp.gmail.com with ESMTPSA id
 he15-20020a05600c540f00b0040b5517ae31sm18910339wmb.6.2023.12.12.05.52.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Dec 2023 05:52:36 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/2] ARM: meson: introduce GXL MDIO mux driver and switch
 to Linux v6.4 DT
Date: Tue, 12 Dec 2023 14:52:26 +0100
Message-Id: <20231212-u-boot-gxl-mdio-mux-v1-0-9adaa5cc7afb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJpleGUC/x2MQQqAIBAAvxJ7biHXQ9BXooPmZguloRVC9Peky
 8AcZh7InIQzDM0DiW/JEkMV1TYwryZ4RnHVgTrSihThhTbGE33ZcHcScb8K2rmjno2t1FDLI/E
 i5b+O0/t+LKAZvmUAAAA=
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Vyacheslav Bocharov <adeep@lexina.in>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2338;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=ZsmYVHwF4M3dGS48W89NNzTaz+xd2A268ATIJBvSscI=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBleGWgETt4mMwuF/+U8/yIFZ5+kkS0oSQy6xoPR
 AMtTaVkStiJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZXhloAAKCRB33NvayMhJ
 0TrhEACWRbbGE9B0MNgJkE8zWhpaa7mlI7CF6kYGlU4kKpP21DTFkoEZQYFuGMNhdVSUkDLhp1D
 3lrFEtkxGEkv5nRRPDemnoFK/5EOv7Msy7X+/ZBWQP0/Hwk/DJYhJaY8qgk0ppyYjhuyYolAWD4
 NxZQQ1TyeI2WomyaeaN2b1dHbTsBXRydgIEHW14eQk9+9Q9PifpgEWRjAfOb5PjsHGtktNoQByW
 zlkK+YKt69gSRuHb67ygOXKjBBLmu5e83TuFMLqGWK9y8ijm+aa18CHYqoPNveOm5iPp6WMADUo
 swFcQ12LcBkOonGmC8+tiE2lczgf67Wr0RjrrfCM+qyKk18FKXjG4X9j5FwqyCBhSAxlQ4x06eN
 mjOHHSsMyBj1NhXNXkpooXajUQbJ9bT97zQvWbqTqd3DUmM/alpDExwDklGMPQMYcO/gru8ngB1
 y+cCtPX9YO79ILkHkACKlwzu+svnUt7gQRaMXJZs+kbiFlIcdj9VczOI24nn86Xdp8lKnVvudEz
 OWKJL0HWNgOpwrzF8WU99j0uzrMPmQn7tIzPLM2A8M3IURuxVW/X8r8qKHVd2l+8b3RHl/8Aqko
 n7hzjkE2/YuA7zt7ubQ/mvEWv0jE/sao6mEm6tu+GB0H24NlEpogF81b+gavfDbYkbFnYIEOu1d
 h6PaBXXXmCSxIug==
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

Linux v6.4 uses a new MDIO mux driver for GXL boards, let's port the driver
to U-Boot and sync the GXBB/GXL/GXM DT to make use of this driver.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (2):
      net: Add Amlogic GXL MDIO Mux driver
      ARM: dts: sync Amlogic GX DT to Linux v6.4

 arch/arm/dts/meson-gx-libretech-pc.dtsi            |   4 +-
 arch/arm/dts/meson-gx.dtsi                         |  21 ++--
 arch/arm/dts/meson-gxbb-nanopi-k2.dts              |  13 +-
 arch/arm/dts/meson-gxbb-odroidc2.dts               |  26 ++--
 arch/arm/dts/meson-gxbb.dtsi                       |  18 ++-
 arch/arm/dts/meson-gxl-s805x-libretech-ac.dts      |   2 +-
 .../arm/dts/meson-gxl-s905w-jethome-jethub-j80.dts |  12 +-
 arch/arm/dts/meson-gxl-s905x-khadas-vim.dts        |  16 +--
 arch/arm/dts/meson-gxl-s905x-libretech-cc-v2.dts   |   3 +-
 arch/arm/dts/meson-gxl-s905x-p212.dts              |  68 ++++++++++
 arch/arm/dts/meson-gxl-s905x-p212.dtsi             |  21 ++--
 arch/arm/dts/meson-gxl.dtsi                        |  43 ++++---
 arch/arm/dts/meson-gxm-khadas-vim2.dts             |  15 +--
 arch/arm/dts/meson-gxm-wetek-core2.dts             |   2 -
 configs/beelink-gt1-ultimate_defconfig             |   2 +-
 configs/jethub_j80_defconfig                       |   2 +-
 configs/khadas-vim2_defconfig                      |   2 +-
 configs/khadas-vim_defconfig                       |   2 +-
 configs/libretech-ac_defconfig                     |   2 +-
 configs/libretech-cc_defconfig                     |   2 +-
 configs/libretech-cc_v2_defconfig                  |   2 +-
 configs/libretech-s905d-pc_defconfig               |   2 +-
 configs/libretech-s912-pc_defconfig                |   2 +-
 configs/p212_defconfig                             |   2 +-
 configs/wetek-core2_defconfig                      |   2 +-
 drivers/net/Kconfig                                |   7 ++
 drivers/net/Makefile                               |   1 +
 drivers/net/mdio_mux_meson_gxl.c                   | 138 +++++++++++++++++++++
 28 files changed, 342 insertions(+), 90 deletions(-)
---
base-commit: 65eed687729c28431d38c6c9174da4d878fb107f
change-id: 20231212-u-boot-gxl-mdio-mux-bc027eab0273

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

