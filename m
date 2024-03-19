Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 365A1C54F7D
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 14:43:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2F4F87F6F;
	Tue, 19 Mar 2024 15:43:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bAtKn9ll";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BE8387F46; Tue, 19 Mar 2024 15:43:09 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 206E887DA7
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 15:43:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-34175878e3cso1306631f8f.0
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 07:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710859385; x=1711464185; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zTsUZdmN/g4CYxLO8500+Jh8NefQmKzz6J4+ay95guE=;
 b=bAtKn9llnan0muTbBMbWlz+7X8igvcTjLQ2rMN5O2Icnk9100U75TCdMJO4sj2cxcO
 5s1xN0Mr3IwLrwEJB+Lp3t0EpEi1vEkINgO/2ztaFDN7Daf9c6ajDLusSt5sgjN6reZP
 dv9EaQpysNDrI5nHHCSzMAfrG3h1bgQNtsHLc2FKpHw59MksN5e1Xva3n6TQQw8fj/+w
 uqJsmsKRNVPUeQwrNSjP1/Qar9t3vBhw6s6b/iDHZmdHIZp7E3NHi1aTQFl3qW/l1eVA
 gkpX5+gpqiT2YAJ/4DLaaaC/omVpOCIoyAnDczbQNWfXqi7jy8LL3eKl9rV4LUrkXLeM
 g9IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710859385; x=1711464185;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zTsUZdmN/g4CYxLO8500+Jh8NefQmKzz6J4+ay95guE=;
 b=fEnNL+oFgoi/GMa0xca/j0Cu+E8O/PoHsS70YSA4ZI1eN9Sa+CE6vAQxO/3f7DZuMI
 WEnaK+awkx0RiBzk7a4JPbpf/lNaNRiZ3lnL0D2FI9fQ5R+ayyzk/KaYstXgU0olwuA5
 VzslLOG6CAAUZlmGyyX3A105vi61DquKVTjGhQXNTEf1ZKvCkMeLjn540z1sWIXCKaYL
 ZaMFdzV5vJJagfzO1DLhVlEkHFOkIdJXVuqbaqm7cIsgR6ECtntwcUl6W2JtQ9zV2Pj/
 j5HoYkeNTu1kssXKR76vLgvBfYtyz8vzln1WFhjlUkk78Lg/Xk7HPZ+fgG3QUd1or4oP
 qG7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNQP8+FJ6ueC5hC8PliJ2bzAEpecge0a90Rw94ZqhgJlE75S6TuYICAwDWQ9G+1CvHx+2WEWW1An1iHUdxPB0d6ZrHeQ==
X-Gm-Message-State: AOJu0Yxuujw5XRFVU3sR8ToFHqKCTC7a7WgCs/RVh5b7ZJE7PAIAqavA
 c17RePRKmBfsEpOLRM1Df/HT4nUKP0U4gzJE8VpGxdMTdWqbe8Lb91iPs2JZnvB/EHg/NIGvCPO
 m4n4=
X-Google-Smtp-Source: AGHT+IHRiq8xXSPaj1DtPfRrSCrgY1T5ux0ZgKb3Iwm5xKfdyEH0dI2ceDF7uFnPLVkpj28sKmJ5Ag==
X-Received: by 2002:a5d:5508:0:b0:33d:a185:17ec with SMTP id
 b8-20020a5d5508000000b0033da18517ecmr10403204wrv.4.1710859385483; 
 Tue, 19 Mar 2024 07:43:05 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 by1-20020a056000098100b0033e18421618sm9029036wrb.17.2024.03.19.07.43.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 07:43:05 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/4] arm: meson: Switch to using upstream DT for GXL, GXM,
 AXG, G12A, G12B & SM1 SoCs
Date: Tue, 19 Mar 2024 15:42:59 +0100
Message-Id: <20240319-u-boot-of-upstream-v1-0-f82bc9fe69c0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHOk+WUC/x3MQQqAIBBA0avErBvI0qCuEi0sx5pFGpoRSHdPW
 r7F/xkiBaYIY5Uh0M2RvSsQdQXrrt1GyKYY2qaVTScGTLh4f6G3mM54BdIHyl4qaQ0ZRRpKeAa
 y/PzTaX7fD98IJkBkAAAA
To: Tom Rini <trini@konsulko.com>, Vyacheslav Bocharov <adeep@lexina.in>, 
 Christian Hewitt <christianshewitt@gmail.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=8443;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=o6EeqEMyxxWngAY/eN6odYbSSCM6u6IEO8P+BWj22a8=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBl+aR2o0YZLqJcW7BI+7kdG1WJxzsoarvDKir/hAJh
 Tt726BmJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZfmkdgAKCRB33NvayMhJ0VTWD/
 9gC2Abo2Qp54EJgINLW8EPBQJE3Mn2rypmq+90Pv3/nmuHmQzd5bl1kYRAotTNYW0RB8AnakXG+DCR
 EwXhtKqbql7c1tTsiOboLZmyAfPSFxxnTJ9Oh1IIRfMg1bfX04/Sq51Y698XwOJQ4Vm7klI/gvDEDO
 S76MwjJHx+XvJgUj1qqwC8ygfYtqbTg86sOblyU66e4QukqAXqFtnBhuNDNnjutQkmiAeEKDfCZZi7
 m3+vvgweTsegPkQ2zsVkA36zD12wr9YYhX6SnPxcsz/IAx2ygThAbRFxQsW9i8PchcPXhLOnp8Ij6H
 5uj0TzZF//vMz7UXrfww1/i3+U8/8SyTHn1DIICyaSVXxvtsKFmTRexAkzUBO4rGaF1+W2/9A+J9xH
 Xk1aML7qvhtx/HWoOsGkf0KN5oqMuJYRXaStOYL8COa5HwZvBKgwbSGuIEpbvzuTS/tUC3BNwF+VFe
 Q0aNELUIQi4/UqaeuP4sGnmQS/waAE+7Xoa9SR+dwMJ+F/LKjfXpziHHMxkkgPJAZdktupsWxPNlDD
 /K8DQ1zXlGNmpMZa++H/p4y5HeQYGs1VZm+a4zzdmpXR8doerEztZlSXEYq0BmfzgHoDvfv03AwSZA
 aGwx3Pj1zyApybTMW3Fk/DekAvfs4vOGAguPjE/HRP/9SxAbR/CQYCwYcn0Q==
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

Enable OF_UPSTREAM to use upstream DT and add amlogic/ prefix to the
DEFAULT_DEVICE_TREE. And thereby directly build DTB from dts/upstream/src/
including *-u-boot.dtsi files from arch/$(ARCH)/dts/ directory and
drop redundant files from arch/arm/dts directory. Only *-u-boot.dtsi files
kept in arch/arm/dts directory for these boards.

Keep A1 DTs locally since the architecture is still young.

CI built & tested at:
https://gitlab.com/amlogic-foss/amlogic-u-boot-autotest/-/pipelines/1219273552

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (4):
      dts: meson: Switch GXL, GXM & AXG to using upstream DT
      dts: meson: Drop redundant GXL, GXM & AXG devicetree files
      dts: meson-g12a: Switch to using upstream DT
      dts: meson: Drop redundant G12A, G12B & SM1 devicetree files

 arch/arm/dts/Makefile                              |   36 +-
 arch/arm/dts/meson-axg-jethome-jethub-j100.dts     |  361 ---
 arch/arm/dts/meson-axg-s400.dts                    |  602 -----
 arch/arm/dts/meson-axg.dtsi                        | 1957 ---------------
 arch/arm/dts/meson-g12-common.dtsi                 | 2493 --------------------
 arch/arm/dts/meson-g12.dtsi                        |  385 ---
 arch/arm/dts/meson-g12a-radxa-zero.dts             |  405 ----
 arch/arm/dts/meson-g12a-sei510.dts                 |  566 -----
 arch/arm/dts/meson-g12a-u200.dts                   |  308 ---
 arch/arm/dts/meson-g12a.dtsi                       |  140 --
 arch/arm/dts/meson-g12b-a311d-bananapi-m2s.dts     |   33 -
 arch/arm/dts/meson-g12b-a311d-khadas-vim3.dts      |   41 -
 arch/arm/dts/meson-g12b-a311d.dtsi                 |  149 --
 arch/arm/dts/meson-g12b-bananapi-cm4-cm4io.dts     |  165 --
 arch/arm/dts/meson-g12b-bananapi-cm4.dtsi          |  388 ---
 arch/arm/dts/meson-g12b-bananapi.dtsi              |  521 ----
 arch/arm/dts/meson-g12b-gsking-x.dts               |  133 --
 arch/arm/dts/meson-g12b-gtking-pro.dts             |  142 --
 arch/arm/dts/meson-g12b-gtking.dts                 |  163 --
 arch/arm/dts/meson-g12b-khadas-vim3.dtsi           |  107 -
 arch/arm/dts/meson-g12b-odroid-go-ultra.dts        |  722 ------
 arch/arm/dts/meson-g12b-odroid-n2-plus.dts         |   31 -
 arch/arm/dts/meson-g12b-odroid-n2.dts              |   15 -
 arch/arm/dts/meson-g12b-odroid-n2.dtsi             |  303 ---
 arch/arm/dts/meson-g12b-odroid-n2l.dts             |  125 -
 arch/arm/dts/meson-g12b-odroid.dtsi                |  445 ----
 arch/arm/dts/meson-g12b-radxa-zero2.dts            |  489 ----
 arch/arm/dts/meson-g12b-s922x-bananapi-m2s.dts     |   14 -
 arch/arm/dts/meson-g12b-s922x.dtsi                 |  139 --
 arch/arm/dts/meson-g12b-w400.dtsi                  |  425 ----
 arch/arm/dts/meson-g12b.dtsi                       |  146 --
 arch/arm/dts/meson-gx-libretech-pc.dtsi            |  447 ----
 arch/arm/dts/meson-gx-mali450.dtsi                 |   61 -
 arch/arm/dts/meson-gx-p23x-q20x.dtsi               |  324 ---
 arch/arm/dts/meson-gx.dtsi                         |  675 ------
 arch/arm/dts/meson-gxl-mali.dtsi                   |   17 -
 arch/arm/dts/meson-gxl-s805x-libretech-ac.dts      |  319 ---
 arch/arm/dts/meson-gxl-s805x.dtsi                  |   23 -
 arch/arm/dts/meson-gxl-s905d-libretech-pc.dts      |   16 -
 arch/arm/dts/meson-gxl-s905d.dtsi                  |   12 -
 .../arm/dts/meson-gxl-s905w-jethome-jethub-j80.dts |  247 --
 arch/arm/dts/meson-gxl-s905x-khadas-vim.dts        |  237 --
 arch/arm/dts/meson-gxl-s905x-libretech-cc-v2.dts   |  313 ---
 arch/arm/dts/meson-gxl-s905x-libretech-cc.dts      |  356 ---
 arch/arm/dts/meson-gxl-s905x-p212.dts              |  134 --
 arch/arm/dts/meson-gxl-s905x-p212.dtsi             |  213 --
 arch/arm/dts/meson-gxl-s905x.dtsi                  |   18 -
 arch/arm/dts/meson-gxl.dtsi                        |  940 --------
 arch/arm/dts/meson-gxm-gt1-ultimate.dts            |   91 -
 arch/arm/dts/meson-gxm-khadas-vim2.dts             |  424 ----
 arch/arm/dts/meson-gxm-s912-libretech-pc.dts       |   62 -
 arch/arm/dts/meson-gxm-wetek-core2.dts             |   85 -
 arch/arm/dts/meson-gxm.dtsi                        |  216 --
 arch/arm/dts/meson-khadas-vim3.dtsi                |  534 -----
 arch/arm/dts/meson-sm1-bananapi-m2-pro.dts         |   97 -
 arch/arm/dts/meson-sm1-bananapi-m5.dts             |  221 --
 arch/arm/dts/meson-sm1-bananapi.dtsi               |  435 ----
 arch/arm/dts/meson-sm1-khadas-vim3l.dts            |  113 -
 arch/arm/dts/meson-sm1-odroid-c4.dts               |   48 -
 arch/arm/dts/meson-sm1-odroid-hc4.dts              |  140 --
 arch/arm/dts/meson-sm1-odroid.dtsi                 |  449 ----
 arch/arm/dts/meson-sm1-sei610.dts                  |  616 -----
 arch/arm/dts/meson-sm1.dtsi                        |  550 -----
 arch/arm/mach-meson/Kconfig                        |    4 +
 configs/bananapi-cm4-cm4io_defconfig               |    2 +-
 configs/bananapi-m2-pro_defconfig                  |    2 +-
 configs/bananapi-m2s_defconfig                     |    2 +-
 configs/bananapi-m5_defconfig                      |    2 +-
 configs/beelink-gsking-x_defconfig                 |    2 +-
 configs/beelink-gt1-ultimate_defconfig             |    2 +-
 configs/beelink-gtking_defconfig                   |    2 +-
 configs/beelink-gtkingpro_defconfig                |    2 +-
 configs/jethub_j100_defconfig                      |    2 +-
 configs/jethub_j80_defconfig                       |    2 +-
 configs/khadas-vim2_defconfig                      |    2 +-
 configs/khadas-vim3_android_ab_defconfig           |    2 +-
 configs/khadas-vim3_android_defconfig              |    2 +-
 configs/khadas-vim3_defconfig                      |    2 +-
 configs/khadas-vim3l_android_ab_defconfig          |    2 +-
 configs/khadas-vim3l_android_defconfig             |    2 +-
 configs/khadas-vim3l_defconfig                     |    2 +-
 configs/khadas-vim_defconfig                       |    2 +-
 configs/libretech-ac_defconfig                     |    2 +-
 configs/libretech-cc_defconfig                     |    2 +-
 configs/libretech-cc_v2_defconfig                  |    2 +-
 configs/libretech-s905d-pc_defconfig               |    2 +-
 configs/libretech-s912-pc_defconfig                |    2 +-
 configs/odroid-c4_defconfig                        |    2 +-
 configs/odroid-go-ultra_defconfig                  |    2 +-
 configs/odroid-hc4_defconfig                       |    2 +-
 configs/odroid-n2_defconfig                        |    2 +-
 configs/odroid-n2l_defconfig                       |    2 +-
 configs/p212_defconfig                             |    2 +-
 configs/radxa-zero2_defconfig                      |    2 +-
 configs/radxa-zero_defconfig                       |    2 +-
 configs/s400_defconfig                             |    2 +-
 configs/sei510_defconfig                           |    2 +-
 configs/sei610_defconfig                           |    2 +-
 configs/u200_defconfig                             |    2 +-
 configs/wetek-core2_defconfig                      |    2 +-
 include/dt-bindings/gpio/meson-axg-gpio.h          |  116 -
 include/dt-bindings/gpio/meson-g12a-gpio.h         |  114 -
 include/dt-bindings/gpio/meson-gxbb-gpio.h         |  148 --
 include/dt-bindings/gpio/meson-gxl-gpio.h          |  125 -
 include/dt-bindings/power/meson-axg-power.h        |   14 -
 include/dt-bindings/power/meson-g12a-power.h       |   13 -
 include/dt-bindings/power/meson-gxbb-power.h       |   13 -
 include/dt-bindings/power/meson-sm1-power.h        |   18 -
 .../reset/amlogic,meson-axg-audio-arb.h            |   19 -
 .../dt-bindings/reset/amlogic,meson-axg-reset.h    |  123 -
 .../reset/amlogic,meson-g12a-audio-reset.h         |   53 -
 .../dt-bindings/reset/amlogic,meson-g12a-reset.h   |  137 --
 .../dt-bindings/reset/amlogic,meson-gxbb-reset.h   |  161 --
 include/dt-bindings/sound/meson-aiu.h              |   18 -
 include/dt-bindings/sound/meson-g12a-toacodec.h    |   10 -
 include/dt-bindings/sound/meson-g12a-tohdmitx.h    |   13 -
 116 files changed, 42 insertions(+), 21511 deletions(-)
---
base-commit: b145877c22b391a4872c875145a8f86f6ffebaba
change-id: 20240319-u-boot-of-upstream-46454fded5ea

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

