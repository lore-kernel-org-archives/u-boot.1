Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08C85CCA470
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 18:37:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF077800D7;
	Tue, 30 Sep 2025 20:37:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zog/F1vy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A7B2802C1; Tue, 30 Sep 2025 20:37:12 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CA06800B1
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 20:37:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-46e47cca387so44403605e9.3
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 11:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759257429; x=1759862229; darn=lists.denx.de;
 h=content-transfer-encoding:organization:autocrypt:content-language
 :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ONjENpCRmhqAi8gk6hWzUM8u623rvhaxpiHxoiPqHwY=;
 b=zog/F1vy5vWlLkQZR3DH1DZfd8xnD28cw+sMi1ywangm+sPs7Tio4O+rMVQF0lo7L3
 3Fwkgc+UF/ah9t3LpbAgffbygwZuENM4OfQvsAw6APboh+2MtQZY06P+RMrZd8ELZFXb
 aQoy5hBG62CrOC/uRZn1z6KO48eMzstTYXWdNq2kRB18VRVFXN+HPAhGVpK2KvHv8WjP
 TnHE1DIpMecZu3jLYE76cIfUjGgZYTGvzJpXA703G9YCLnbEfVlMehKlUi9BmDPYm71q
 3pJC6ZHLslNWdNeuDFTFcsAivzT6WWyEZX9/pXWptbbKTOuEEo3Aw3E2orVf0RYoydGu
 +KtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759257429; x=1759862229;
 h=content-transfer-encoding:organization:autocrypt:content-language
 :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ONjENpCRmhqAi8gk6hWzUM8u623rvhaxpiHxoiPqHwY=;
 b=PDFu/4px30PnIdUG+YS2cGe3bPe9Z9X+6SDGPVbe1ZMJ0Wbl1AKz3vcGknrHk0TsXR
 5WzeFLyiVRKKv8jQeRaCEw48C9Agx3JPnhup+szoPmM49oP6RLJR/LFyF1fR4LWqqIDe
 IU7fmyKXNZGaaBCB6cz5qGvFeWJOeh+uy/GGx2Ap/ZkL0SRi7tQiMVPQ8Cxq7vNU8Vdl
 8GYnZRBYxmEBumwt7m67lqNANAiFXC7/xDi1oeFMQ4vjZ/36cl4Z6nST+aAdO6s+afIf
 hgqz4YsE/y9/2gkPT07LgSc7O915XfKxGGX8BAi8KrlpKx5ZrKSq42lMpbhWZt4rmQMY
 ddCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdUUFokrWgTR32xdrMUzMkXaXoZioUC9gAOpcxqPWnFhlsjrv9o2a8GQkBS4yFcKxy64BF8nA=@lists.denx.de
X-Gm-Message-State: AOJu0YxqvCsyw0wXEGbcPuJU2jjdChVUytYK+KcPNNzYUCXpttWZy+iJ
 1M7UpvwrbySTjBWXrhWCkS5muOOgrQOnyrkcLHGzXnAH6/s586k0v6rtGwws30c893k=
X-Gm-Gg: ASbGnctIexhNMFi7WtpjWINn9ButQE7winRa+4Ul83ZOun7j3hxaaBQMFoD7+xJ3Dw6
 gHkj+B2BPwosvZs0hWOC7o5IGEGH62jrugNPmRGUZMTtBbXRF1ObILfdrafdIThFK0D8uliimUI
 XEtYzwR3OoMlXq7k4mYnB0s0rnnWdOJU4xIpzoOSrLVyieBo+6Tjx5VrjvmOSo1cx/6xkDkVf7I
 RCQnqLkc/hhQPT88cca43w1gKDGwDwYiRJ2vgkur7HSOj5G1eW0K+w+j2ZH9hixy+99EwdwRVNA
 IJZTLrDT3d3iIHVpy/HYhnmrRhFqY9RfYDPL2bO55buum8ctbd9nHM6FJVSvu8zLAmoWVPJ+8UK
 pPGN6WPKxLmMFdKWhc0l5FSNHBiwUn+soKZcntPW6oFQVtLzIQd7UGne24ZEtBoGxbLTLArGDAs
 bzmjNN9nhkWwGzL/6KsSKU36v+E2jZRPG3Rw==
X-Google-Smtp-Source: AGHT+IGWQlHfGrMuIA7R4JZCPoXvtDiDSv4tTOgiLMZjF0GHz3YeALSoEY6c5vPFJbiSNNPqVjtugQ==
X-Received: by 2002:a05:600c:37cc:b0:46e:3cd9:e56f with SMTP id
 5b1f17b1804b1-46e6126ae01mr7415875e9.6.1759257428379; 
 Tue, 30 Sep 2025 11:37:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:9459:14e0:525e:d859?
 ([2a01:e0a:3d9:2080:9459:14e0:525e:d859])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e619c3b75sm4430225e9.7.2025.09.30.11.37.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 11:37:08 -0700 (PDT)
Message-ID: <e59bed17-8d4b-4a08-9091-e8805f7df1d8@linaro.org>
Date: Tue, 30 Sep 2025 20:37:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [GIT PULL] Please pull u-boot-amlogic-next-20250930
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

Here's a small set of Amlogic changes for the next release.

Thanks,
Neil

The following changes since commit 9710d98e8942151fc0c62d54100d9d27e8263d04:

   Merge tag 'doc-next-2025-09-27' of https://source.denx.de/u-boot/custodians/u-boot-efi into next (2025-09-27 09:49:01 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-next-20250930

for you to fetch changes up to d521fa32cc692a44c7c11d4b2a86f371d614e727:

   ARM: amlogic: fix JetHub D1 eth mac fallback generation (2025-09-30 20:32:15 +0200)

----------------------------------------------------------------
- set reversed bit when using internal phy on GXL SoCs
- support gpio toggle command for amlogic gpio
- fix saradc
- remove unreachable in meson clk driver
- Stop premature exit from for loop in meson pwm driver
- fix JetHub D1 eth mac fallback generation

----------------------------------------------------------------
Andrew Goodbody (3):
       adc: meson-saradc: uint cannot be less than zero
       clk: meson: Remove unreachable code
       pwm: meson: Stop premature exit from for loop

Neil Armstrong (1):
       net: mdio: mux-meson-gxl: set reversed bit when using internal phy

Viacheslav Bocharov (1):
       ARM: amlogic: fix JetHub D1 eth mac fallback generation

Yang Xiwen (1):
       pinctrl: meson: support gpio toggle command

  board/amlogic/jethub-j100/jethub-j100.c | 22 +++++++++-------------
  drivers/adc/meson-saradc.c              |  8 ++++----
  drivers/clk/meson/g12a.c                |  2 --
  drivers/net/mdio_mux_meson_gxl.c        |  3 ++-
  drivers/pinctrl/meson/pinctrl-meson.c   | 20 +++++++++++++++++++-
  drivers/pwm/pwm-meson.c                 |  3 ++-
  6 files changed, 36 insertions(+), 22 deletions(-)

