Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36FECCDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 06:49:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 124AA8477A;
	Mon, 16 Oct 2023 08:48:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qw+R7UIk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5ED1D868C0; Mon, 16 Oct 2023 08:48:14 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B02D86DB3
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 08:48:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-32d9cb5e0fcso2406418f8f.0
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 23:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697438888; x=1698043688; darn=lists.denx.de;
 h=content-transfer-encoding:organization:autocrypt:content-language
 :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dG3EozR2YbBz5CU77OJ09WvCXbTkaKIOcH++cobCu3Q=;
 b=qw+R7UIkv1Eh89NmV18fgISD3ErCuGa5G+HKA5eN8cwAyh4pnKVZyqcr3Ifll2nSLQ
 higrpBUoOJjBo7NqmCdnVGaNzUQvoLdL6qxyhJU93GHNv4qS0hbxJoZ363d9lxCPES08
 DP8L4Vx7lsM+JQj+4Jy0O1Bkmt50tjZ7Eucz7oeYah5xLLaCLTHancrYytaahxMlF+p7
 EPI/Caelh2S3cnOiYhzoZDCh4I5UnoaF9rViTpKKQ2bnK8Gjv+n8/FCD6/y2wlyDcye5
 Eq3muCe3ivcp/4hPrbIRSyYRYZWfenuTcclzWPAU5J2vcNyhKhb7T5d85qCF2OnSSEru
 RzoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697438888; x=1698043688;
 h=content-transfer-encoding:organization:autocrypt:content-language
 :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dG3EozR2YbBz5CU77OJ09WvCXbTkaKIOcH++cobCu3Q=;
 b=ROaT6Dg8mXe4Saw3atNRuHj7WZPJlbh/Q6ZKwK30ok3OSfOPgKDsOpiZ9cZnvgBniO
 KjDEtVCYo+5PWt29y8E88UnTt7yoVZuXzOqjLLUtd0jI+FcPVUkSWo1Aswr8FHW0NuVZ
 +ls7nBnQlcl6HFEFitFQrC4yHoKVSVUwbht0g/njQ0deEyHL9z1vCb/ZE6w7c6TCUYja
 IO1b7okmR8eyVdwU9w/LrhFV7gUJyb3y07WCJaY1D4YBobhPlIVncAJ2Wi1sabqRvqxE
 /EeKo1L8Z4EOsuSm/9Uxokjz8P4+Zo20JAdZ+HY15QqBAhwjL8iPPlwmUGpBnNZWYlXE
 glLg==
X-Gm-Message-State: AOJu0YzMGj+zm8ILP3TCfNoc3ddl3T+aL8aVS3Cgf7EY99lHN1HNSo6q
 mS/LACCGGEmuLE9Y9cEOHfZGfA==
X-Google-Smtp-Source: AGHT+IEM2q/GdnT+0quhIXgKdqJEXtDYrHZ1Ck8Mx3R9lsMzoEqAZ4gozdC4nbknV2jkm4uRztA22w==
X-Received: by 2002:a5d:620f:0:b0:31f:ef77:67e4 with SMTP id
 y15-20020a5d620f000000b0031fef7767e4mr24493727wru.37.1697438887721; 
 Sun, 15 Oct 2023 23:48:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:b5ab:4a16:fd45:8130?
 ([2a01:e0a:982:cbb0:b5ab:4a16:fd45:8130])
 by smtp.gmail.com with ESMTPSA id
 dj16-20020a0560000b1000b003198a9d758dsm9575932wrb.78.2023.10.15.23.48.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Oct 2023 23:48:07 -0700 (PDT)
Message-ID: <555f51df-c50f-4118-bf74-3619965cd828@linaro.org>
Date: Mon, 16 Oct 2023 08:48:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [GIT PULL] Please pull u-boot-amlogic-20231015
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
Organization: Linaro Developer Services
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

A set of changes mostly concerning Amlogic A1 & S4 SoCs for USB, Secure Monitor
and RNG bringup.


The CI job is at https://source.denx.de/u-boot/custodians/u-boot-amlogic/pipelines/18138

Thanks,
Neil

The following changes since commit 997bef3c6d22d12c7fd092fb831bf94d114c9f6f:

   Merge branch '2023-10-11-port-gen_compile_commands_py' (2023-10-11 13:25:01 -0400)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-20231015

for you to fetch changes up to 7cd53e0d5203f8e25bb69d2e675769888fcbc754:

   arch: meson: use secure monitor driver (2023-10-15 12:23:48 +0200)

----------------------------------------------------------------
- add Amlogic A1 clock driver
- add Amlogic A1 reset support
- add USB Device support for Amlogic A1
- enable RNG on Amlogic A1 & Amlogic S4
- move Amlogic Secure Monitor to standalone driver

----------------------------------------------------------------
Alexey Romanov (18):
       dt-bindings: reset: add Meson A1 reset bindings
       reset: add support for Amlogic A1 family
       phy: get rid of raw hex values
       phy: move clk enable/disable in init/exit
       phy: support Amlogic A1 family
       dwc3: add support for Amlogic A1 family
       ad401: enable USB stack
       meson-a1: dts: add hw rng node
       meson-a1: dts: add ao secure node
       drivers: rng: add support for Meson S4
       drivers: introduce Secure Monitor uclass
       sandbox: add sandbox sm uclass driver
       sandbox: dts: add meson secure monitor node
       sandbox: add tests for UCLASS_SM
       sandbox: defconfig: enable CONFIG_SM option
       drivers: introduce Meson Secure Monitor driver
       arch: meson: sm: set correct order of the includes
       arch: meson: use secure monitor driver

Igor Prusov (3):
       dt-bindings: clock: Add Amlogic A1 clock bindings
       clk: Add clock driver for Amlogic A1
       a1: clk: Add missing USB_PHY_IN and USB_PHY gates

  MAINTAINERS                                        |   1 +
  arch/arm/dts/meson-a1.dtsi                         |  11 +
  arch/arm/include/asm/arch-meson/clock-a1.h         |  23 +
  arch/arm/mach-meson/Kconfig                        |   1 +
  arch/arm/mach-meson/sm.c                           | 116 ++--
  arch/sandbox/dts/test.dts                          |   4 +
  configs/ad401_defconfig                            |   3 +
  configs/sandbox_defconfig                          |   1 +
  drivers/Kconfig                                    |   2 +
  drivers/Makefile                                   |   1 +
  drivers/clk/meson/Kconfig                          |   8 +
  drivers/clk/meson/Makefile                         |   1 +
  drivers/clk/meson/a1.c                             | 729 +++++++++++++++++++++
  drivers/phy/Kconfig                                |   2 +-
  drivers/phy/meson-g12a-usb2.c                      | 235 ++++++-
  drivers/reset/reset-meson.c                        |  42 +-
  drivers/rng/meson-rng.c                            |  72 +-
  drivers/sm/Kconfig                                 |   9 +
  drivers/sm/Makefile                                |   5 +
  drivers/sm/meson-sm.c                              | 198 ++++++
  drivers/sm/sandbox-sm.c                            |  76 +++
  drivers/sm/sm-uclass.c                             |  55 ++
  drivers/usb/dwc3/dwc3-meson-g12a.c                 |  79 ++-
  include/dm/uclass-id.h                             |   1 +
  .../clock/amlogic,a1-peripherals-clkc.h            | 168 +++++
  include/dt-bindings/clock/amlogic,a1-pll-clkc.h    |  25 +
  include/dt-bindings/reset/amlogic,meson-a1-reset.h |  76 +++
  include/meson/sm.h                                 |  19 +
  include/sandbox-sm.h                               |  18 +
  include/sm-uclass.h                                |  72 ++
  include/sm.h                                       |  67 ++
  test/dm/Makefile                                   |   1 +
  test/dm/sm.c                                       |  65 ++
  33 files changed, 2095 insertions(+), 91 deletions(-)
  create mode 100644 arch/arm/include/asm/arch-meson/clock-a1.h
  create mode 100644 drivers/clk/meson/a1.c
  create mode 100644 drivers/sm/Kconfig
  create mode 100644 drivers/sm/Makefile
  create mode 100644 drivers/sm/meson-sm.c
  create mode 100644 drivers/sm/sandbox-sm.c
  create mode 100644 drivers/sm/sm-uclass.c
  create mode 100644 include/dt-bindings/clock/amlogic,a1-peripherals-clkc.h
  create mode 100644 include/dt-bindings/clock/amlogic,a1-pll-clkc.h
  create mode 100644 include/dt-bindings/reset/amlogic,meson-a1-reset.h
  create mode 100644 include/meson/sm.h
  create mode 100644 include/sandbox-sm.h
  create mode 100644 include/sm-uclass.h
  create mode 100644 include/sm.h
  create mode 100644 test/dm/sm.c
