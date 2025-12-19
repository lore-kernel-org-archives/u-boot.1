Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94D96D767C7
	for <u-boot@archiver.kernel.org>; Fri, 19 Dec 2025 10:32:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5DBB80050;
	Fri, 19 Dec 2025 11:32:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BuPcm47J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D72E80077; Fri, 19 Dec 2025 11:32:52 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 080298003E
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 11:32:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47775fb6cb4so10294215e9.0
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 02:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766140368; x=1766745168; darn=lists.denx.de;
 h=content-transfer-encoding:organization:autocrypt:content-language
 :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sWTpmjAkQnB5pDtjtyF4kzRBOmjFn5a0N6wX+RDlrK8=;
 b=BuPcm47JciR4OzztA4Fbu7x6RAKUKGxMLdIG5x4rLgVbR81RARz3vCqLZgjfwVETEq
 mf8b1+W2CSDFGDHBoEvAfwKJo8t96Gr1k7qsZKFKSHJdJhPpkjxi2n4ifKgUtVxyeuj6
 /JYwr7vKBvbx51mWubfFZeMgh8KQAmpUZIwkyuy0YozyD+xtgA27Oj1pZIUFu0HjZQaJ
 iUtlIXzLLYpz45EW8ipxdZdm+wqGQJi+woQX5qjU/XFrixabb9xr2Z+sTATNtrYO+rc4
 h+tyEAX7UUBVujZkrLY8auCGxvHEuUHJLa6hpydaMU4kuOD/slfQm4VH4DD4jVftr1VR
 know==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766140368; x=1766745168;
 h=content-transfer-encoding:organization:autocrypt:content-language
 :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sWTpmjAkQnB5pDtjtyF4kzRBOmjFn5a0N6wX+RDlrK8=;
 b=giBSqX5yKRPfkOSgGpgHd9jJSe8YcOwlNh/OC1JI8q/AoiKJFx4z7NIL1CbL1aS55L
 ayY1Cv1fbq4rDHm+IRU6CeqoDF2xKjH+yXNFRiPexiCPI5TCggMN3oPlfw+lHbmoa5tx
 H//XT7LDidynX9Wfl4AJ2AXqrcQJ57fH6R4ghC9QYA7/ObgC55IJiDtA3lM9xHuPXlGX
 dwSHmJ2VW9ynyjPOhpPN6BTslbXz3sVQYXTydSawtKbQ5GuMmClSIiwRbQwmJL+5C+jR
 5j+ovvdf4SLgpChoIWDBvyc8uXyd5jannDps8N+6PxQrszFhuMhuSZNhJJWCFTqKxIMQ
 iVEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyMhelHrHwPWLoqYX4SeZLO45nx/uK07wsdtcjNiup0JUyUFbjLKMHOFbruZImCOGsYosGM4s=@lists.denx.de
X-Gm-Message-State: AOJu0YyUFBIgrA7MxU4gSOQQBKayIWjyU4oj4kaM61KSOpWZEOxPtI7G
 PIuYI8yfvhWdIIguAZ9eUvSpeLhFbn3NigY2jDWe4k0znQ8Mm04wg/4AQPnb/mfGtBQ=
X-Gm-Gg: AY/fxX4DlgNwmzdIOL0h4nZIyBq+7KcafaSZGZazeQpxFTiYOALA873EH9wlwI5icJq
 ClIXtV/ukY4H3QDCzgLVYM8VFFmS68WczJFJu9xZYJhRiMvOl9ZXtl2k2NCZXXMVQLwCQL2DUni
 +pbadGTs5HXhgBOoTI6Thpcz3xc92v2JwSY57JxjaJ2ETk+HeasaGtCB6mXcmx+namCsqWT7yFb
 aOJ/gPbcpJwHNdAoKaJtubODqDDx4Ga83JaGYkAInnUb/6H8dC+Ialm4IX7MWVCxb2NozBPytRg
 o8SlY4zRwA57KoZonuYTVhqx/905/JypFmpbnpEHyi8F3WgrIXFDTUrZzzRwgPLHjpuseyzp3Ql
 737SRXKlGgWsZXU/9b5XUPJQ6QLXx+K1/jMHd08CZPPc6TfPKO0P6ABKjilfQN2OOeQKo6Z6PrH
 k7GGATwysZFAtXnLYNzmxg5u8a3j/xv/sGa8xw+cWQVvdOPesuBnCy520wYz9gY1w=
X-Google-Smtp-Source: AGHT+IHE3x8SDUiRwxNfGZ2qxjw3MfDuuQ3OajLsMDoA4xyQtRFUSxU5439dtxgqH7vAuZLJetWvrA==
X-Received: by 2002:a05:600c:35c4:b0:475:dd9a:f791 with SMTP id
 5b1f17b1804b1-47d195869e7mr24528085e9.28.1766140368292; 
 Fri, 19 Dec 2025 02:32:48 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080:254d:4d6d:3f4e:5bd1?
 ([2a01:e0a:3d9:2080:254d:4d6d:3f4e:5bd1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3a33c1csm36332845e9.1.2025.12.19.02.32.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Dec 2025 02:32:47 -0800 (PST)
Message-ID: <e151667a-9f5b-4baa-84b6-5a243ec88545@linaro.org>
Date: Fri, 19 Dec 2025 11:32:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [GIT PULL] Please pull u-boot-amlogic-next-20251219
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Tom,

Here's a set of Amlogic changes, the principal change is the initial SPL implementation
for GX SoCs, ditching the vendor BL2 by an open source implementation.
Then a frequency lowering on the MMC driver and support for EFI capsules
update for all Amlogic boards.

Thanks,
Neil


The following changes since commit 66be03b7ee19444b23aae3990a434a7470fc1641:

   binman: blob_dtb: improve error message when SPL is not found (2025-12-10 13:45:29 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-next-20251219

for you to fetch changes up to 6e844dd4df6765e5e772b5606a675c16fe98d9ac:

   board: libre-computer: use common Amlogic EFI capsule support (2025-12-11 17:27:15 +0100)

----------------------------------------------------------------
- Add u-boot SPL support for GX SoCs
- meson_gx_mmc: reduce maximum frequency
- Add support for EFI capsule updates on all Amlogic boards

----------------------------------------------------------------
Ferass El Hafidi (11):
       mmc: meson_gx_mmc: add minimal non-DM driver
       serial: serial_meson: add minimal non-DM driver
       arm: meson: initial u-boot SPL support for GX SoCs
       arm: meson: spl: add support for SPL DRAM init
       arm: dts: meson: add meson-gxbb-u-boot.dtsi
       arm: dts: meson-gx-u-boot: add binman configuration for U-Boot SPL
       board: amlogic: add kconfig fragments for SPL
       spl: meson: set SPL max size for GX SoCs
       doc: board: amlogic: add u-boot-spl documentation
       arm: meson: add support for EFI capsule updates
       board: libre-computer: use common Amlogic EFI capsule support

Jonas Karlman (1):
       tools: mkimage: Add Amlogic Boot Image type

Nick Xie (1):
       mmc: meson_gx_mmc: reduce maximum frequency

  MAINTAINERS                                        |   1 +
  arch/arm/dts/meson-gx-u-boot.dtsi                  | 125 ++++++
  arch/arm/dts/meson-gxbb-kii-pro-u-boot.dtsi        |   2 +-
  arch/arm/dts/meson-gxbb-nanopi-k2-u-boot.dtsi      |   2 +-
  arch/arm/dts/meson-gxbb-odroidc2-u-boot.dtsi       |   2 +-
  arch/arm/dts/meson-gxbb-p200-u-boot.dtsi           |   2 +-
  arch/arm/dts/meson-gxbb-p201-u-boot.dtsi           |   2 +-
  arch/arm/dts/meson-gxbb-u-boot.dtsi                |  27 ++
  arch/arm/dts/meson-gxbb-wetek-hub-u-boot.dtsi      |   2 +-
  arch/arm/dts/meson-gxbb-wetek-play2-u-boot.dtsi    |   2 +-
  arch/arm/dts/meson-gxl-u-boot.dtsi                 |  20 +
  arch/arm/include/asm/arch-meson/boot.h             |   2 +
  arch/arm/include/asm/arch-meson/clock-gx.h         |  14 +
  arch/arm/include/asm/arch-meson/dram-gx.h          | 341 +++++++++++++++++
  arch/arm/include/asm/arch-meson/dram-gxbb.h        | 168 +++++++++
  arch/arm/include/asm/arch-meson/dram-gxl.h         | 193 ++++++++++
  arch/arm/include/asm/arch-meson/dram-settings-gx.h | 296 +++++++++++++++
  arch/arm/include/asm/arch-meson/dram-timings-gx.h  | 117 ++++++
  arch/arm/include/asm/arch-meson/gx.h               |  41 ++
  arch/arm/mach-meson/Kconfig                        | 112 +++++-
  arch/arm/mach-meson/Makefile                       |  12 +-
  arch/arm/mach-meson/board-common.c                 |  16 +
  arch/arm/mach-meson/capsule.c                      |  61 +++
  arch/arm/mach-meson/dram-gx.c                      | 419 +++++++++++++++++++++
  arch/arm/mach-meson/dram-gxbb.c                    | 174 +++++++++
  arch/arm/mach-meson/dram-gxl.c                     | 167 ++++++++
  arch/arm/mach-meson/spl-gx.c                       | 168 +++++++++
  arch/arm/mach-meson/spl-gxbb.c                     | 113 ++++++
  arch/arm/mach-meson/spl-gxl.c                      |  39 ++
  arch/arm/mach-meson/spl.c                          | 123 ++++++
  board/amlogic/p200/spl-odroid-c2.config            |  38 ++
  board/amlogic/p200/spl-videostrong-kii-pro.config  |  39 ++
  board/amlogic/p212/spl-libretech-cc-1gb.config     |  36 ++
  board/amlogic/p212/spl-libretech-cc-2gb.config     |  38 ++
  board/libre-computer/aml-a311d-cc/aml-a311d-cc.c   |  14 -
  board/libre-computer/aml-s805x-ac/aml-s805x-ac.c   |  13 -
  board/libre-computer/aml-s905d3-cc/aml-s905d3-cc.c |  14 -
  boot/image.c                                       |   1 +
  common/spl/Kconfig                                 |   1 +
  doc/board/amlogic/index.rst                        |   1 +
  doc/board/amlogic/pre-generated-fip.rst            |   9 +
  doc/board/amlogic/spl.rst                          |  77 ++++
  drivers/mmc/meson_gx_mmc.c                         |  79 +++-
  drivers/serial/serial.c                            |   2 +
  drivers/serial/serial_meson.c                      | 119 +++++-
  include/image.h                                    |   1 +
  tools/Makefile                                     |   1 +
  tools/amlimage.c                                   | 255 +++++++++++++
  48 files changed, 3449 insertions(+), 52 deletions(-)
  create mode 100644 arch/arm/dts/meson-gxbb-u-boot.dtsi
  create mode 100644 arch/arm/include/asm/arch-meson/dram-gx.h
  create mode 100644 arch/arm/include/asm/arch-meson/dram-gxbb.h
  create mode 100644 arch/arm/include/asm/arch-meson/dram-gxl.h
  create mode 100644 arch/arm/include/asm/arch-meson/dram-settings-gx.h
  create mode 100644 arch/arm/include/asm/arch-meson/dram-timings-gx.h
  create mode 100644 arch/arm/mach-meson/capsule.c
  create mode 100644 arch/arm/mach-meson/dram-gx.c
  create mode 100644 arch/arm/mach-meson/dram-gxbb.c
  create mode 100644 arch/arm/mach-meson/dram-gxl.c
  create mode 100644 arch/arm/mach-meson/spl-gx.c
  create mode 100644 arch/arm/mach-meson/spl-gxbb.c
  create mode 100644 arch/arm/mach-meson/spl-gxl.c
  create mode 100644 arch/arm/mach-meson/spl.c
  create mode 100644 board/amlogic/p200/spl-odroid-c2.config
  create mode 100644 board/amlogic/p200/spl-videostrong-kii-pro.config
  create mode 100644 board/amlogic/p212/spl-libretech-cc-1gb.config
  create mode 100644 board/amlogic/p212/spl-libretech-cc-2gb.config
  create mode 100644 doc/board/amlogic/spl.rst
  create mode 100644 tools/amlimage.c
