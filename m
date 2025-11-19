Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D632CF34C1
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 15:02:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C163283EDE;
	Wed, 19 Nov 2025 16:02:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oFIJYdMN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49E1D83EF9; Wed, 19 Nov 2025 16:02:56 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDF888397D
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 16:02:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-42b38de7940so3775983f8f.3
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 07:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763564573; x=1764169373; darn=lists.denx.de;
 h=content-transfer-encoding:organization:autocrypt:content-language
 :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9JCjToc29gC8ylMyj8lOtgoiUgSPLw+mZlb85MDOGFU=;
 b=oFIJYdMNliFsJk+69XND0SJ//4HDYkHvdiXSg64oYWHSge1U+Am0AbCb+6LwzXhKpD
 mqkEOV2v26ylOyb11MGJU627IfUHAgekfOVcAHkvo28Xp6PXgpJ8H2dfMqeSKBNyIFXe
 Sysoq9e+8hT61/OtVc5bjqWMI8panDx64z2pxvEdSiX1AbUEnBuEFoEYikdFaCE6NtVD
 c6RR+dL0VXRMAzuJekqqf9CAn2bomQFrT0w7+WQK3K//gQdA2WaTQnyh/97GPT6h54SK
 5ZxPYxkKh2g4zzmJjk3vJH+g+hnuP21nAXUGUR413ETryy9O41popdQy6415HZRqFaWu
 B64A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763564573; x=1764169373;
 h=content-transfer-encoding:organization:autocrypt:content-language
 :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9JCjToc29gC8ylMyj8lOtgoiUgSPLw+mZlb85MDOGFU=;
 b=gRRuvrOdxVW7eydh+WzcTRzjaoSZUDAnQ9ZxfZagqF6GZ1Iibof7demaqpp7jqV0vc
 xMPB0Vw+RqNRxUPE/Nwrs8q3lCMWjHxDuC6nTGdNYchCgrKWjRIXG4GzUQrzwMr62CG1
 gpAiHFyfIzu53cgl9QdW3nmoMbXQQ8hvwQpRXCa6jYbs5jJk3+0HeJM35FWM3KxbjXmt
 qGDzn3Q8BJe5J/fdZeDa1+IVyNA+8rsSFaKjapeO+DUbahCe6vTxlq9Jnsk+EOO0lK2+
 D+i8uKJg0lMzEN4pL/nfTqWv9MsN01n1Ircg4Ot4jZn3GToW+TVmZ3aumuFSxwHwNx5n
 oKoA==
X-Gm-Message-State: AOJu0YypZOEEo6x4QT/D2yHSydNOruwonDzrpZ0slOryR06H40roN59N
 WUX0kFRy6QlROjT6P3YBgviVIBaotAeeeS/mY5PqIW/yMbdFp03dHeqQCet3oAna/tw=
X-Gm-Gg: ASbGncuIyeJSNAaQglrdaa287HDfAp0G4weswThDfjpIqIq4+ZkZrFlg+ygzMy/KaOB
 zMUJ82s/4r2Ae5MB+6y4Ace4HEj+Y5PkreqTnMyg3fTOhIfxXwg4H7IVkDuPNvjnYSeVI81TDcW
 NJgSqvkU6u6TaQUMvButqofphTuh+5eVbAPwmyl9WEKy0Uz1tCL/FnEBITOBRzK5HeyVrKaPEvO
 1JHO2n7/+FbV1fbV8WRrvxs+sgYSFGtmR1Xwp58O1NWktAKKGtQvsqtyu1W5TRBLdwGEqfWsouv
 9BhMZUBwdQIYhRZOqYqIpGa1HqEnSXEAvRYKw0BBjXS+81u04sNThkEXemddxIJY9TvziKe8SdN
 6vv3LgXSPHIaXA8MXpx47U3f40pjHrR6Q+lTJQ29gKVU0POylLsb96gSRrpSY8MgYKQcVNhxrIq
 fhvPwXv5Nu25o6RffCRaaVT1iBshRL+ZrStuqSP30dYz83HuBdv+cV481RD2xo5cY=
X-Google-Smtp-Source: AGHT+IFuxdEvEN6e6ghrF+8ExWMWtRVfa+CRqya+fYcAHEqKlJcVLUoXZkxFqcC5s81yU2YzVbRRYQ==
X-Received: by 2002:a05:6000:2f83:b0:42b:3c3e:5d2e with SMTP id
 ffacd0b85a97d-42b5932345dmr19339496f8f.1.1763564572955; 
 Wed, 19 Nov 2025 07:02:52 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080:263d:925b:a11f:ae36?
 ([2a01:e0a:3d9:2080:263d:925b:a11f:ae36])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53dea1c9sm38562044f8f.0.2025.11.19.07.02.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Nov 2025 07:02:52 -0800 (PST)
Message-ID: <11b6ec24-6cdd-488c-8a96-ca4a6396d288@linaro.org>
Date: Wed, 19 Nov 2025 16:02:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [GIT PULL] Please pull u-boot-ufs-20251119
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

This is small set of final UFS fixes for the current relase.

Thanks,
Neil

The following changes since commit 69cc92d6869b8ff4591e5b8850872da34934bab9:

   Merge tag 'efi-2026-01-rc3' of https://source.denx.de/u-boot/custodians/u-boot-efi (2025-11-15 08:05:45 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-ufs.git tags/u-boot-ufs-20251119

for you to fetch changes up to d4f80bddc58115744d681a332144e9a9371d1f59:

   ufs: rcar-gen5: Use a unique U_BOOT_DRIVER name (2025-11-17 10:28:45 +0100)

----------------------------------------------------------------
- Sort again the UFS Kconfig & Makefile
- Use unique name for the rcar-gen5 ufs driver

----------------------------------------------------------------
Marek Vasut (1):
       ufs: Keep Makefile and Kconfig sorted one more time

Tom Rini (1):
       ufs: rcar-gen5: Use a unique U_BOOT_DRIVER name

  drivers/ufs/Kconfig                 | 28 ++++++++++++++--------------
  drivers/ufs/Makefile                |  4 ++--
  drivers/ufs/ufs-renesas-rcar-gen5.c |  2 +-
  3 files changed, 17 insertions(+), 17 deletions(-)
