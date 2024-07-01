Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 631B5C2BD09
	for <u-boot@archiver.kernel.org>; Mon,  1 Jul 2024 08:48:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B185E88671;
	Mon,  1 Jul 2024 10:48:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IpnOkAKp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DC9888675; Mon,  1 Jul 2024 10:48:52 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E171C8866B
 for <u-boot@lists.denx.de>; Mon,  1 Jul 2024 10:48:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-52cd87277d8so2755602e87.2
 for <u-boot@lists.denx.de>; Mon, 01 Jul 2024 01:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719823729; x=1720428529; darn=lists.denx.de;
 h=content-transfer-encoding:organization:autocrypt:content-language
 :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jUvdH3IXhEmKAjhpbxVrzYZY642aKB40M8uAj9K8WhA=;
 b=IpnOkAKp3mDwTWzrQCkc+hxR6ul+LtyhnvwD4vZXgV8oCUQwsMkIdVHDtUe8l/7URC
 NiR5ZSNg3UWQ6OLcaHhPOa3qsUe3xG6t5UnxUDxPa9btM1uFuF4CYI6u3oC03NGuA6Lc
 J3Q33073DdHNdpQH1uILO/QWvi0Pg8HPYB38z7GFypfcjTrWIudhFmXk47GEvmYlmh6q
 vpirk6Bl6vN7GcFNX5wGT8VmH0BAHMadYNCdgmGJ41MMFmAvhds6fXsTagPfTGuqFDcF
 JVyZtAlbfYkpyHwx4nVzXi6bYLjJBKNqP5EFjx67Rp6R2bdVY8TqVG1+R6A02OTdfmqT
 MeBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719823729; x=1720428529;
 h=content-transfer-encoding:organization:autocrypt:content-language
 :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jUvdH3IXhEmKAjhpbxVrzYZY642aKB40M8uAj9K8WhA=;
 b=jxBKbzOI+5oI+OKeonDp5Z/nb0XRGKsjNjr44poyItPgeBA8mlwwTKZ83zLFVLKw2S
 EDuvX/FbGAwAY72g0F1cczECmRb6C/igMuN2Egft3xKSGCN0mte2WamXo9VUyI24lO+A
 Ox6mfCr7N/l+0hnWfF3Oj7wXeuEXjXn9r69SRA5bQrpFVp5DKMWhwZfefWk4mJ2hFxdB
 rRjQu7w4A+tSD4jiXJVLEjFd7JADkJ4g5MgwTjbyExJb1a4GM7ReulRpXNl5HloPX4L5
 x/tsV6KN2yOItzSrSDEqkgssDf4OWeCRGkoRgTS5XdHVwC9jhx9N1S4/NLF7SdyTth1Z
 xfGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBUzBR8WHi7kVpZdTRoeJGfxGiTSG0LlrFC1eQbPWSQg/IMsX1EUJkG8bmVbbGQmuBhRM/DKD+yFzC/+rVmxokHJseBQ==
X-Gm-Message-State: AOJu0YwLdaSvsjg31F4G4HvJMyvtIyQIsXYQlWWYuk8SndXAo4BpDJ9n
 c/6R1is7wfBwGxWvTW7BEb+0VkZp7A7SzGTSysI1O2PG8pvOxyMtJH4NFjxXY9uTqhXZy4f69HZ
 6vPcYww==
X-Google-Smtp-Source: AGHT+IH4nK5l053KkmUPRiCdT8mRwhKf7gXLnj3rNWqk0vLPhXOAoXQ5TJMOsKhVFoWSYFBgrxupWQ==
X-Received: by 2002:a05:6512:31cc:b0:52e:76d5:9504 with SMTP id
 2adb3069b0e04-52e82651c26mr3838107e87.3.1719823728742; 
 Mon, 01 Jul 2024 01:48:48 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:4719:99ea:652b:10d0?
 ([2a01:e0a:982:cbb0:4719:99ea:652b:10d0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af3c25esm143339375e9.9.2024.07.01.01.48.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jul 2024 01:48:48 -0700 (PDT)
Message-ID: <a4690cd1-33ef-4537-885b-6782c135c43b@linaro.org>
Date: Mon, 1 Jul 2024 10:48:47 +0200
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

A set of changes to switch meson dwc3/usb PHY to set_mode callback for switching USB mode,
and a driver declaration fixup for meson_axg_gpio.

Thanks,
Neil

The following changes since commit a7eada24327a40f7ef6c55c220e119839c9d4227:

   Merge tag 'v2024.07-rc5' into next (2024-06-24 13:34:52 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-20240701

for you to fetch changes up to 96e1a156e90a0674b21c56e7121b17a9211176ec:

   meson: Correct driver declaration for meson_axg_gpio (2024-06-26 11:19:57 +0200)

----------------------------------------------------------------
- Switch meson dwc3/usb PHY to set_mode callback for switching USB mode

----------------------------------------------------------------
Neil Armstrong (5):
       phy: meson-gxl-usb2: add set_mode callback
       usb: dwc3: meson-gxl: switch to generic_phy_set_mode
       phy: meson-gxl-usb2: remove phy_meson_gxl_usb2_set_mode
       usb: dwc3: meson-gxl: drop usb-gx.h and make dwc3_meson_gxl_force_mode static
       usb: dwc3: meson-g12a: drop usb.h and make dwc3_meson_g12a_force_mode static

Simon Glass (1):
       meson: Correct driver declaration for meson_axg_gpio

  arch/arm/include/asm/arch-meson/usb-gx.h      | 17 ---------------
  arch/arm/include/asm/arch-meson/usb.h         | 12 -----------
  drivers/phy/meson-gxl-usb2.c                  | 30 ++++++++++++++++-----------
  drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c |  2 +-
  drivers/pinctrl/meson/pinctrl-meson-axg.c     |  4 ++--
  drivers/pinctrl/meson/pinctrl-meson-axg.h     |  2 +-
  drivers/pinctrl/meson/pinctrl-meson-g12a.c    |  4 ++--
  drivers/usb/dwc3/dwc3-meson-g12a.c            |  2 +-
  drivers/usb/dwc3/dwc3-meson-gxl.c             | 18 +++++++++-------
  9 files changed, 35 insertions(+), 56 deletions(-)
  delete mode 100644 arch/arm/include/asm/arch-meson/usb-gx.h
  delete mode 100644 arch/arm/include/asm/arch-meson/usb.h
