Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84155CCF9EB
	for <u-boot@archiver.kernel.org>; Wed, 29 Oct 2025 10:55:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECE65800B6;
	Wed, 29 Oct 2025 11:55:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="D9M+RK3o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D38A9800D7; Wed, 29 Oct 2025 11:55:54 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46A798004F
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 11:55:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3f0ae439bc3so4416819f8f.1
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 03:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761735352; x=1762340152; darn=lists.denx.de;
 h=content-transfer-encoding:organization:autocrypt:content-language
 :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KVduHldS/XUM32HxZkDl0WGK2r33+6/qm4u41PgvosE=;
 b=D9M+RK3oweU3MBNsxFjtff+S5tR/+V73xXLJxyqDlNjYuWiPrzGGbTvaFK2uCJdiZL
 +FceJX87kKR7s/NCX1Tn9DUgIPfONEiPf55YEQ4N5Kl1kSywzea5dilD6fLz8aU+ASPh
 MaucY3PxAdxAkzA0B1P4cujkiyyMW+2yYA1+VlETO6f7z80kYOmcKuIcKLmfbds+/dFk
 ELqtdLwbbSgyVQfwDo8vdNzPQaakIzJqYlZadIZxdCO6drEw5yJca5WjT/7ONzp0gVZU
 TwQgH2HMOjYG6Qn3QfpD7iKeVGUiCfCXYwI1LunBWaeQfoJUL+y7EHxusekJS5wFyoHN
 q+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761735352; x=1762340152;
 h=content-transfer-encoding:organization:autocrypt:content-language
 :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KVduHldS/XUM32HxZkDl0WGK2r33+6/qm4u41PgvosE=;
 b=YLviIj2+xCARUXxkA9QVHqpYFoI1OtZcpBCbchewWSz04386YhXRk49nYsYl19Gidp
 o6emz6Gn6Uf5MoOqpv2S7euko1Tg47qfai12JRMJIXjTzNAqSrXe38UHKXwaJsNKFqHq
 NEUK0wGBOsUKUIOWGa6XmXxoA6mUQeRwRydE/w5/feQinYWQPE7rUVNLLYHUY84SqPI/
 CfApG28v4oOfP6kTg861drIQJYOskXqgPoeg0N48Yt+Y90eoGDIa3cZTlmIE2Kb/1Lic
 78kaEBDbZxpUAEAB2svIWIsD0toY8mR/gUZWyP+qup9dKYqieBygVBS7s6DOhM/ncWp2
 LrZA==
X-Gm-Message-State: AOJu0YyTz6kxsAzvzXL0FiFJt1bZncvw0y3id4ERMjZLj5vXIavnm0gC
 ggFX0Zzcgp0viIqnkloudYPuGdaaE+Syfw4ZHO1dLFqMhCczPfpcSxYEeRrADtyGSqY=
X-Gm-Gg: ASbGncuEEU0BgF5d4An9VhqKuL5ol8xNlTeXTHeT+Uv4Q70tOMKSBICBwv5o+sVeN5g
 r5DH0vHjbxi7XoJhp1xLWHN7PtuanK85HENtV8IvwTto0+9guMeGSIn/E8ynGbxLWkkhfxg5Dje
 uEv9c533btgnsJpViO6rN9PK8xXI7mjnLZ54Wb7qA19IttWD0NwB2/rPVMyhhva5SDFYK+ImW8R
 T3/q96EIooQHX8zSDdltV7bt1NPETYYexqntKaaceX+IVvRSSIfQEOVH35y/x8F1N1V3zizAEBF
 pVArxDa2+qioqqxg0ivswtMNs5GgU0y87qCZbg399ZqjfU3v04ZL/jqbsye3QBt3PZFCo9VZBag
 Tvgojzhds6lbdRiH+SxHxgBbQ5skVC/xgvQDwvfmk78kWLNlNc+0jNRIVdjcSk4nwkZ4jf0w0vn
 W3ooDqbaidsWkkaA85YTUz369qObdHLtk9vmYiNItpLj9Nv08oIg==
X-Google-Smtp-Source: AGHT+IERYZ/tI7ezMfNPTZ8hZWBPXW2UZ2q8vFgP6gmQqzZKoKI3IkRjxOGq99VFGAWuk7U8x8HCtA==
X-Received: by 2002:a05:6000:2089:b0:428:4354:aa43 with SMTP id
 ffacd0b85a97d-429aef83083mr1871166f8f.18.1761735351614; 
 Wed, 29 Oct 2025 03:55:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:cad:2140:3447:eb7a:cb9f:5e0?
 ([2a01:e0a:cad:2140:3447:eb7a:cb9f:5e0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952cbb2bsm26077167f8f.13.2025.10.29.03.55.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Oct 2025 03:55:51 -0700 (PDT)
Message-ID: <df0e58ef-a00c-41b7-a872-7be468d92252@linaro.org>
Date: Wed, 29 Oct 2025 11:55:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [GIT PULL] Please pull u-boot-ufs-20251029
To: trini@konsulko.com
Cc: u-boot@lists.denx.de, Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>
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

This is a set of UFS changes, including fixes and cleanup plus 3 new
platforms support.

Thanks,
Neil

The following changes since commit 23987e10905146def3ab61e55ec912c6e742efdc:

   Prepare v2026.01-rc1 (2025-10-27 16:10:23 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-ufs.git tags/u-boot-ufs-20251029

for you to fetch changes up to 3351fe7ecc1ac717c23e9ad2c16e1fe4a7b84fd2:

   ufs: Add UFS driver for Renesas R-Car X5H (2025-10-28 17:35:46 +0100)

----------------------------------------------------------------
- ti-j721e: Correct error detection
- Fix wrong bitfield usage for Data Direction in Transfer Request
- Add support for sending UFS attribute requests
- Add bRefClkFreq attribute setting
- Add ufshcd_dme_enable() and ufshcd_dme_reset()
- unipro: Add PA_SCRAMBLING property
- Cleanups:
  - Keep Makefile and Kconfig list sorted
  - Fold ufs-uclass into ufs and rename to ufs-uclass
  - amd-versal2: Fix indent
  - Call ufs_scsi_bind() from uclass .post_bind
  - renesas: Update Kconfig entry help text
- New plaforms:
  - Rockchip UFS
  - Mediatek UFS
  - Renesas R-Car X5H UFS

----------------------------------------------------------------
Andrew Goodbody (1):
       ufs: ti-j721e: Correct error detection

Igor Belwon (3):
       ufs: unipro: Add PA_SCRAMBLING property
       ufs: Add MediaTek UFS driver
       MAINTAINERS: Add UFS to MediaTek section

Jared McArthur (2):
       ufs: Add support for sending UFS attribute requests
       ufs: Add bRefClkFreq attribute setting

Kunihiko Hayashi (1):
       ufs: Fix wrong bitfield usage for Data Direction in Transfer Request

Marek Vasut (6):
       ufs: core: Keep Makefile and Kconfig list sorted
       ufs: core: Fold ufs-uclass into ufs
       ufs: core: Rename ufs.c to ufs-uclass.c
       ufs: amd-versal2: Fix indent
       ufs: Call ufs_scsi_bind() from uclass .post_bind
       ufs: renesas: Update Kconfig entry help text

Shawn Lin (2):
       ufs: core: Add ufshcd_dme_enable() and ufshcd_dme_reset()
       ufs: rockchip: Add initial support

Tuyen Dang (1):
       ufs: Add UFS driver for Renesas R-Car X5H

  MAINTAINERS                         |    3 +
  drivers/ufs/Kconfig                 |   62 +-
  drivers/ufs/Makefile                |    7 +-
  drivers/ufs/cdns-platform.c         |    8 -
  drivers/ufs/ti-j721e-ufs.c          |    6 +-
  drivers/ufs/ufs-amd-versal2.c       |   18 +-
  drivers/ufs/ufs-mediatek-sip.h      |   56 +
  drivers/ufs/ufs-mediatek.c          |  395 ++++++
  drivers/ufs/ufs-mediatek.h          |  210 ++++
  drivers/ufs/ufs-pci.c               |    8 -
  drivers/ufs/ufs-qcom.c              |    8 -
  drivers/ufs/ufs-renesas-rcar-gen5.c |  268 ++++
  drivers/ufs/ufs-renesas.c           |    8 -
  drivers/ufs/ufs-rockchip.c          |  203 +++
  drivers/ufs/ufs-rockchip.h          |   88 ++
  drivers/ufs/ufs-uclass.c            | 2303 ++++++++++++++++++++++++++++++++++-
  drivers/ufs/ufs.c                   | 2093 -------------------------------
  drivers/ufs/ufs.h                   |   14 +
  drivers/ufs/unipro.h                |    1 +
  19 files changed, 3595 insertions(+), 2164 deletions(-)
  create mode 100644 drivers/ufs/ufs-mediatek-sip.h
  create mode 100644 drivers/ufs/ufs-mediatek.c
  create mode 100644 drivers/ufs/ufs-mediatek.h
  create mode 100644 drivers/ufs/ufs-renesas-rcar-gen5.c
  create mode 100644 drivers/ufs/ufs-rockchip.c
  create mode 100644 drivers/ufs/ufs-rockchip.h
  delete mode 100644 drivers/ufs/ufs.c
