Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FEF4C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 10:43:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84E5C870B7;
	Wed, 20 Dec 2023 11:43:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xNk+KNqz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF68486CF4; Wed, 20 Dec 2023 11:43:55 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9C6C870B7
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 11:43:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40c339d2b88so59134345e9.3
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 02:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703069033; x=1703673833; darn=lists.denx.de;
 h=content-transfer-encoding:organization:autocrypt:content-language
 :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GRgUN4Cgb6/CN21v+aOuyOjxrnWKjuw+yAeeRTJm/ug=;
 b=xNk+KNqz5EUWDF2SSUCbuxiJ7d/Fc6KUuBw16fqRl8M1GZjgCX2vlHqvVh3Juud4WC
 ApJbaLUms5EdOiOjkSIvMJTb+cWEPC8Md5B9LGI+z98NFSUXHoG5WmSIuTwIZZlOtuzZ
 lrzC7iAjPO9aoD5VJNNZrt8+ro0b/hYqQneCMKMfbKWhEd/IkfWXYtN4SLbIJ60p1YLJ
 ldxJ99vVYUbXadPMpQLVOpcPTMzdUrfCnqPv3aBlvia2XV0nvqD9HzEXRP7I2/rJBck7
 JKlgCDuxHW68HR5i9k9niDfBxz9G1Y3nGh1LdVp7AfSgB50v3ECsJWM8inX2Xt2ZVZku
 joHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703069033; x=1703673833;
 h=content-transfer-encoding:organization:autocrypt:content-language
 :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GRgUN4Cgb6/CN21v+aOuyOjxrnWKjuw+yAeeRTJm/ug=;
 b=MNYYQr2F3Vug6uix3zOyPc7OUk93+hc1fZo76ZveDKsaHArUGpwVA81HaBnnzzY6Xe
 wHlL3p0/6/VBBxj66FlO3wsyutkoHmkTByGMAUYznLA3ow/bP5EaUkcivzkGVB9k2xE5
 0EpUbX1jTlQZn5FLSfGI0P3pNGjnn7sHN31K9PzKt06p9FBwnQczZZKnTIfzSPlOCb6X
 5mKVkdeW/RV8yzxutxYamg3cvgfWmZw0tSQ05IrAEN3eLt5rZq/2bXjfjgibpf9kXDW9
 0wl3Q4ur69KgUUW2gbi+n4HLxQ6jfg3iaLWEivUPZC2spTsg8ON9MeX1jekCcn6/zNyc
 V3NA==
X-Gm-Message-State: AOJu0YzBoAW6t4ickMSUy2sNmlRx2cMtmprdSmbgkyw/Da628TvOJQm/
 Ai++5EIfwnrhdMqXUrPWQdu9tQ==
X-Google-Smtp-Source: AGHT+IGbHLOYOkN4hp5cIsS3b+Q2Hizmv+3QQmLM6rz+RonUB8kjny3jlBM6W5kjmzN95N0qveWJSg==
X-Received: by 2002:a05:600c:5409:b0:40d:3786:dad1 with SMTP id
 he9-20020a05600c540900b0040d3786dad1mr293867wmb.19.1703069032967; 
 Wed, 20 Dec 2023 02:43:52 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:459:bfad:2ed9:2cb3?
 ([2a01:e0a:982:cbb0:459:bfad:2ed9:2cb3])
 by smtp.gmail.com with ESMTPSA id
 x12-20020a5d650c000000b003366c058509sm1894342wru.23.2023.12.20.02.43.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Dec 2023 02:43:52 -0800 (PST)
Message-ID: <8c32e92f-810f-434b-ba77-3074490458bd@linaro.org>
Date: Wed, 20 Dec 2023 11:43:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [GIT PULL] Please pull u-boot-amlogic-next-20231220
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

Please pull into next branch support for the new GXL MDIO mux along
with a Linux v6.4 DT sync, this will permit using upstream Linux DT
as-is on GXL & GXM based boards.

Thanks,
Neil

The following changes since commit a6f86132e30a407c7f96461df53c62fbe52e2b54:

   Merge branch 'next' of https://source.denx.de/u-boot/custodians/u-boot-riscv into next (2023-12-18 09:56:58 -0500)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-next-20231220

for you to fetch changes up to 4d4fbf04158a5b2d4fff5a35ea0a2d6c18d250cb:

   ARM: dts: sync Amlogic GX DT to Linux v6.4 (2023-12-19 11:24:38 +0100)

----------------------------------------------------------------
- Add support for new GXL MDIO mux, with driver and Linux DT sync from v6.4

----------------------------------------------------------------
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
  create mode 100644 drivers/net/mdio_mux_meson_gxl.c
