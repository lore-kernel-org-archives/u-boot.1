Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F9AFCD1284
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 16:53:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B88F883DF;
	Thu,  4 Apr 2024 18:52:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="s31KTtyF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4971883DF; Thu,  4 Apr 2024 18:52:57 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D87587DCA
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 18:52:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-343d2b20c4bso320746f8f.2
 for <u-boot@lists.denx.de>; Thu, 04 Apr 2024 09:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712249575; x=1712854375; darn=lists.denx.de;
 h=content-transfer-encoding:organization:autocrypt:content-language
 :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s6cDqREbLHI/zYd7s9AoenXPcmTJ2h4XSsQf8sOeiAA=;
 b=s31KTtyFdzQyPzGl4KBjDnoqY+LeLjiQXVnSWWQggQVD63lXrGIjL7GHv/QSzLO4f9
 Wm1hmgWZHKuAPa+iNROFPyeE20r4rW5gPa49pEEfHjyE+ffZ8Qz9rbSNP1Tg24jhyjAA
 YhrY7iFVOx7xxkL4e1L6/GxvIYGPz5NA2hFS4iNmuYX9BgSVD9IJJYIVKvHYz/P9Jvdk
 JD4PScqVWOooF6M54dT0yWV2y/68qN3F5ZnxpCkmDjH2h4b5Sgb4vRS0w2nM1meOjTQ9
 7qfEpdrAgUouaL4LQWx39Oys3mfk6Rd5EhQqorjhbHAXU8EmV2rmsph2S6qC7mf383U9
 t4Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712249575; x=1712854375;
 h=content-transfer-encoding:organization:autocrypt:content-language
 :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s6cDqREbLHI/zYd7s9AoenXPcmTJ2h4XSsQf8sOeiAA=;
 b=QNwChu2/8dVnAUapU2B7JI8S+CM3da8jXSURNu0Qp78G5jZ7RxBBDmEZNSLqI3JTfw
 nLqI2u9CLJ6dJxdx6w3ja2q32p1E5bz607sE5EsUO4GBLoiXiUmi+4Dw+ffgkev2KgaY
 AUF5D5gkbBz5/mXGSVxzR1ftlBS+tdGCbmQgJXzfneleFOcEaVzUQ/tfFWivgOvhG/ir
 +ms5ecGwVEaedRLvBBzzaIb7rZf612TrXl0bME44OQCNcjjOQiAmpMIRTjEQOkk6/deL
 Xp145a/xH2shGnOGMvj5VpdXkyhc8ThfF3JrZSZn9stB8JGuvLHbHjqt23I80fY/0K6F
 uLiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtzlnRiM+R824ShvqGauEjryvXN5jUvY1zoHkaOt8/Ye8mp63qkCW1syrLZf9W38sYSyC4r0KrbkjGQjXt/dAnf5Kj6w==
X-Gm-Message-State: AOJu0YyH2uyU9Y3Etug0xkyBEsj8MJgimSS+Y6dm5d3lS24HE78wnPAD
 kVJDg0+QeVHuL6QVL7IV7Hb6g0XY5CfpFpqaFiGCh1IPBVXo47XsvlUcreGlXaT10WlK4ilGzZK
 NvwA=
X-Google-Smtp-Source: AGHT+IEIZ5ZW/IcevXx39YD22zbJK42F6XlOIra7Zmy+tZvbN670CcR0+N/5MAX1M8tOuKi0ARJvKQ==
X-Received: by 2002:a5d:4903:0:b0:343:688d:2cbf with SMTP id
 x3-20020a5d4903000000b00343688d2cbfmr90898wrq.60.1712249574354; 
 Thu, 04 Apr 2024 09:52:54 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:5910:95db:d5a3:46d6?
 ([2a01:e0a:982:cbb0:5910:95db:d5a3:46d6])
 by smtp.gmail.com with ESMTPSA id
 ay26-20020a5d6f1a000000b0034355b7e995sm9685183wrb.13.2024.04.04.09.52.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Apr 2024 09:52:53 -0700 (PDT)
Message-ID: <da4b216a-fc52-4a1c-8ebe-2509ab36d7be@linaro.org>
Date: Thu, 4 Apr 2024 18:52:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [GIT PULL] Please pull u-boot-amlogic-next-20240404
To: trini@konsulko.com
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Reply-To: neil.armstrong@linaro.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Tom,

Please pull this migration to OF_UPSTREAM for all Amlogic SoCs family
except the newer A1 family.
In Addition, there's a few fixes & updates for the jethubj100 board.

Thanks,
Neil

The following changes since commit cdfcc37428e06f4730ab9a17cc084eeb7676ea1a:

   Merge tag 'u-boot-dfu-next-20240402' of https://source.denx.de/u-boot/custodians/u-boot-dfu (2024-04-02 22:37:23 -0400)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-20240404

for you to fetch changes up to 114df8b5339e503b50b6ac1a61bf1daac57c2e11:

   dts: meson: Drop redundant G12A, G12B & SM1 devicetree files (2024-04-04 18:48:46 +0200)

----------------------------------------------------------------
- jethubj100: fix config, MAINTAINERS & update docs
- Switch GXL, GXM, AXG, G12A, G12B & SM1 to using upstream DT

----------------------------------------------------------------
Neil Armstrong (5):
       configs: meson64: remove amlogic prefix in fdtfile when CONFIG_OF_UPSTREAM is selected
       dts: meson: Switch GXL, GXM & AXG to using upstream DT
       dts: meson: Drop redundant GXL, GXM & AXG devicetree files
       dts: meson-g12a: Switch to using upstream DT
       dts: meson: Drop redundant G12A, G12B & SM1 devicetree files

Viacheslav Bocharov (3):
       board: amlogic: jethubj100: fix common config header
       board: amlogic: jethubj100: update MAINTAINERS
       board: amlogic: jethubj100: update docs

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
  board/amlogic/jethub-j100/MAINTAINERS              |    2 +-
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
  doc/board/amlogic/jethub-j100.rst                  |   11 +-
  include/configs/jethub.h                           |    2 +-
  include/configs/meson64.h                          |    8 +-
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
  120 files changed, 58 insertions(+), 21518 deletions(-)
  delete mode 100644 arch/arm/dts/meson-axg-jethome-jethub-j100.dts
  delete mode 100644 arch/arm/dts/meson-axg-s400.dts
  delete mode 100644 arch/arm/dts/meson-axg.dtsi
  delete mode 100644 arch/arm/dts/meson-g12-common.dtsi
  delete mode 100644 arch/arm/dts/meson-g12.dtsi
  delete mode 100644 arch/arm/dts/meson-g12a-radxa-zero.dts
  delete mode 100644 arch/arm/dts/meson-g12a-sei510.dts
  delete mode 100644 arch/arm/dts/meson-g12a-u200.dts
  delete mode 100644 arch/arm/dts/meson-g12a.dtsi
  delete mode 100644 arch/arm/dts/meson-g12b-a311d-bananapi-m2s.dts
  delete mode 100644 arch/arm/dts/meson-g12b-a311d-khadas-vim3.dts
  delete mode 100644 arch/arm/dts/meson-g12b-a311d.dtsi
  delete mode 100644 arch/arm/dts/meson-g12b-bananapi-cm4-cm4io.dts
  delete mode 100644 arch/arm/dts/meson-g12b-bananapi-cm4.dtsi
  delete mode 100644 arch/arm/dts/meson-g12b-bananapi.dtsi
  delete mode 100644 arch/arm/dts/meson-g12b-gsking-x.dts
  delete mode 100644 arch/arm/dts/meson-g12b-gtking-pro.dts
  delete mode 100644 arch/arm/dts/meson-g12b-gtking.dts
  delete mode 100644 arch/arm/dts/meson-g12b-khadas-vim3.dtsi
  delete mode 100644 arch/arm/dts/meson-g12b-odroid-go-ultra.dts
  delete mode 100644 arch/arm/dts/meson-g12b-odroid-n2-plus.dts
  delete mode 100644 arch/arm/dts/meson-g12b-odroid-n2.dts
  delete mode 100644 arch/arm/dts/meson-g12b-odroid-n2.dtsi
  delete mode 100644 arch/arm/dts/meson-g12b-odroid-n2l.dts
  delete mode 100644 arch/arm/dts/meson-g12b-odroid.dtsi
  delete mode 100644 arch/arm/dts/meson-g12b-radxa-zero2.dts
  delete mode 100644 arch/arm/dts/meson-g12b-s922x-bananapi-m2s.dts
  delete mode 100644 arch/arm/dts/meson-g12b-s922x.dtsi
  delete mode 100644 arch/arm/dts/meson-g12b-w400.dtsi
  delete mode 100644 arch/arm/dts/meson-g12b.dtsi
  delete mode 100644 arch/arm/dts/meson-gx-libretech-pc.dtsi
  delete mode 100644 arch/arm/dts/meson-gx-mali450.dtsi
  delete mode 100644 arch/arm/dts/meson-gx-p23x-q20x.dtsi
  delete mode 100644 arch/arm/dts/meson-gx.dtsi
  delete mode 100644 arch/arm/dts/meson-gxl-mali.dtsi
  delete mode 100644 arch/arm/dts/meson-gxl-s805x-libretech-ac.dts
  delete mode 100644 arch/arm/dts/meson-gxl-s805x.dtsi
  delete mode 100644 arch/arm/dts/meson-gxl-s905d-libretech-pc.dts
  delete mode 100644 arch/arm/dts/meson-gxl-s905d.dtsi
  delete mode 100644 arch/arm/dts/meson-gxl-s905w-jethome-jethub-j80.dts
  delete mode 100644 arch/arm/dts/meson-gxl-s905x-khadas-vim.dts
  delete mode 100644 arch/arm/dts/meson-gxl-s905x-libretech-cc-v2.dts
  delete mode 100644 arch/arm/dts/meson-gxl-s905x-libretech-cc.dts
  delete mode 100644 arch/arm/dts/meson-gxl-s905x-p212.dts
  delete mode 100644 arch/arm/dts/meson-gxl-s905x-p212.dtsi
  delete mode 100644 arch/arm/dts/meson-gxl-s905x.dtsi
  delete mode 100644 arch/arm/dts/meson-gxl.dtsi
  delete mode 100644 arch/arm/dts/meson-gxm-gt1-ultimate.dts
  delete mode 100644 arch/arm/dts/meson-gxm-khadas-vim2.dts
  delete mode 100644 arch/arm/dts/meson-gxm-s912-libretech-pc.dts
  delete mode 100644 arch/arm/dts/meson-gxm-wetek-core2.dts
  delete mode 100644 arch/arm/dts/meson-gxm.dtsi
  delete mode 100644 arch/arm/dts/meson-khadas-vim3.dtsi
  delete mode 100644 arch/arm/dts/meson-sm1-bananapi-m2-pro.dts
  delete mode 100644 arch/arm/dts/meson-sm1-bananapi-m5.dts
  delete mode 100644 arch/arm/dts/meson-sm1-bananapi.dtsi
  delete mode 100644 arch/arm/dts/meson-sm1-khadas-vim3l.dts
  delete mode 100644 arch/arm/dts/meson-sm1-odroid-c4.dts
  delete mode 100644 arch/arm/dts/meson-sm1-odroid-hc4.dts
  delete mode 100644 arch/arm/dts/meson-sm1-odroid.dtsi
  delete mode 100644 arch/arm/dts/meson-sm1-sei610.dts
  delete mode 100644 arch/arm/dts/meson-sm1.dtsi
  delete mode 100644 include/dt-bindings/gpio/meson-axg-gpio.h
  delete mode 100644 include/dt-bindings/gpio/meson-g12a-gpio.h
  delete mode 100644 include/dt-bindings/gpio/meson-gxbb-gpio.h
  delete mode 100644 include/dt-bindings/gpio/meson-gxl-gpio.h
  delete mode 100644 include/dt-bindings/power/meson-axg-power.h
  delete mode 100644 include/dt-bindings/power/meson-g12a-power.h
  delete mode 100644 include/dt-bindings/power/meson-gxbb-power.h
  delete mode 100644 include/dt-bindings/power/meson-sm1-power.h
  delete mode 100644 include/dt-bindings/reset/amlogic,meson-axg-audio-arb.h
  delete mode 100644 include/dt-bindings/reset/amlogic,meson-axg-reset.h
  delete mode 100644 include/dt-bindings/reset/amlogic,meson-g12a-audio-reset.h
  delete mode 100644 include/dt-bindings/reset/amlogic,meson-g12a-reset.h
  delete mode 100644 include/dt-bindings/reset/amlogic,meson-gxbb-reset.h
  delete mode 100644 include/dt-bindings/sound/meson-aiu.h
  delete mode 100644 include/dt-bindings/sound/meson-g12a-toacodec.h
  delete mode 100644 include/dt-bindings/sound/meson-g12a-tohdmitx.h
