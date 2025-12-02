Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC9C6D116F6
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 14:42:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6AFA83E69;
	Tue,  2 Dec 2025 15:42:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ERyxlVwQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A52B983E69; Tue,  2 Dec 2025 15:42:48 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E29CE83E70
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 15:42:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-47795f6f5c0so33511505e9.1
 for <u-boot@lists.denx.de>; Tue, 02 Dec 2025 06:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764686564; x=1765291364; darn=lists.denx.de;
 h=content-transfer-encoding:organization:autocrypt:content-language
 :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nZF3dx2C5OgYwAz3vwqFbZoBLKqOEsj1TcgD25St02g=;
 b=ERyxlVwQ3nOBXyxqtErY5dIq5Z8ItBQf1UM14ccl8wi8VrVGp5TiPToNF28c/MQFBL
 ukNXTv2VdnKyzMgGbxT+0BbGFCHmT1TcEp62f1pG8kKD50Gbt3c5fNTX7q+2I8+qgv+q
 tooJ4nLTJZskZ4fKRerf8sOoRRXKouf+bDm4mV2oxbZXs2dAIN//b6P9BNqcdO1bjTHn
 V0EOe+nmvl3M0ueyf2FgISFU+37IprPCidRn2htJRx8saXbUOYm0wdZxP+pYyDs3Nzto
 NyiMPcTwK7uIzDneBPfvi0JdyGojd7FHy9G0DOijIFZQr4amV4IlPS/9xZljwJ603He5
 a4DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764686564; x=1765291364;
 h=content-transfer-encoding:organization:autocrypt:content-language
 :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nZF3dx2C5OgYwAz3vwqFbZoBLKqOEsj1TcgD25St02g=;
 b=vg9hgqUAAphZdKI0wa0BqYMlgNpih/GBAkbz1Mb/GTx1Qoq1c7q3tiUew5jNzGg/7w
 aar3yEVn1U+UmDGMii2I2UPwKHEy96F7i+7GEEPSUtBZQ5p/+Fytng7SXXWtDQFfP+mM
 bcDKHItgh5iY057d9TLgmvqxCjm41xofCy6E8B5WXQUu1tuVWlWbUF88s8LPdcWAFauJ
 r/QwlQXj9TLVHfb7ddhJpoEW5P7hLi7T4L5x5UCQn4IcGpDad7dY+XML4fPnJnT6DlSd
 V8a5HmPtZvMIhcZYNpzQYVwZ+pGvTl+YiPTMSSnf6iz0LrRXWfXTQoSOnE+Lx5BSLePJ
 isbw==
X-Gm-Message-State: AOJu0YzhQ4qkf5LdirgHD8mhGRhxom3XcXT2YMLsi6aQWxlGInJup8j9
 VXjL52+04d0U0Kci+lJ7uFXurw5zT2CZq9UhDKDLuPgXmYNHf2ZpN+1flwDbQyHQR2Y=
X-Gm-Gg: ASbGncv1yMT3sxFLhdZ6VitQbvbB7K3bZejItkhpWFQwEU6K3gZIeGOnuzbsAzOCAWc
 mN9tfKZKfiKEYEwj31dJdkGKWNm3PgnOpkXTrcotfunqe31JVqPs8ITm/ZB3K4JX94WgGPHOCeZ
 O2qt9GPHR/F4MIZJjjAUKjCoCKbHcv+E68Wd7bv16HntuyotuczGhal+VdJuZZjBodGcsNsBnfe
 9d0lmQ4QXa/onDv1eMapR9Tv1bcDbAIiGkXvyCmgtb2Pm3lfXq1+BZNvy/HkhpEQGBE6EB1wMo9
 cIiwfDQdnBZ/Ym9mZB4Tx8780hFKiemJ7ZOIq8qEivLaqZAt2yQQYFfcwYMuhW1zBSwsqzg27Wu
 sglQomBa8B7ICAEpYkIwzo1Tta0fNhMf4m6kr21wHNDoa5qIjAX0ihJ/IvnPX/2h2MRk18lYGr4
 X1JkXAHpmVifL0KdVTB5Wxc7VCFeIKzbFi51S0asBaGElgutBkmV0PB5Ri0FWODScGsZH3lXI=
X-Google-Smtp-Source: AGHT+IEdvz21m7+UnlRqnyBlXnqakq1rgVCWoQMsObUY5c4iQ/aFpprMebToj9Dnb3h3uGKwYfNDsA==
X-Received: by 2002:a05:600c:6c48:b0:477:7f4a:44ba with SMTP id
 5b1f17b1804b1-477c0162ec8mr289159945e9.4.1764686564148; 
 Tue, 02 Dec 2025 06:42:44 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080:91b9:4aec:412:4abf?
 ([2a01:e0a:3d9:2080:91b9:4aec:412:4abf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4790b0cc186sm359997845e9.13.2025.12.02.06.42.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Dec 2025 06:42:43 -0800 (PST)
Message-ID: <46c9238a-869a-45d4-ad7c-8da3103c8c83@linaro.org>
Date: Tue, 2 Dec 2025 15:42:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [GIT PULL] Please pull u-boot-ufs-20251202
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

This is the second batch of UFS config renames from Marek.

Thanks,
Neil

The following changes since commit 4a4871e3dc38f3f771d2713b805e79e6191b4297:

   Merge tag 'v2026.01-rc3' into next (2025-11-24 09:34:29 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-ufs.git tags/u-boot-ufs-20251202

for you to fetch changes up to b71967457883eddc022dc376251ad3c5c5d9c163:

   ufs: ti: Rename CONFIG_TI_J721E_UFS to CONFIG_UFS_TI_J721E (2025-11-25 16:38:22 +0100)

----------------------------------------------------------------
- Second batch of UFS config renames for Cadence/Qcom/Rockchip/TI

----------------------------------------------------------------
Marek Vasut (4):
       ufs: cadence: Rename CONFIG_CADENCE_UFS to CONFIG_UFS_CADENCE
       ufs: qcom: Rename CONFIG_QCOM_UFS to CONFIG_UFS_QCOM
       ufs: rockchip: Rename CONFIG_ROCKCHIP_UFS to CONFIG_UFS_ROCKCHIP
       ufs: ti: Rename CONFIG_TI_J721E_UFS to CONFIG_UFS_TI_J721E

  configs/am69_sk_a72_defconfig    |  4 +--
  configs/j7200_evm_a72_defconfig  |  4 +--
  configs/j721e_evm_a72_defconfig  |  4 +--
  configs/j721s2_evm_a72_defconfig |  4 +--
  configs/j784s4_evm_a72_defconfig |  4 +--
  configs/qcom_defconfig           |  2 +-
  drivers/ufs/Kconfig              | 58 ++++++++++++++++++++--------------------
  drivers/ufs/Makefile             |  8 +++---
  8 files changed, 44 insertions(+), 44 deletions(-)
