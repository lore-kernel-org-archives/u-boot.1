Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC23C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 14:34:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 649A486BF7;
	Mon,  6 Nov 2023 15:34:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="skkvzjKg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A34DF86D0E; Mon,  6 Nov 2023 15:34:35 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D6A6869CA
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 15:34:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40891d38e3fso32062115e9.1
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 06:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699281272; x=1699886072; darn=lists.denx.de;
 h=content-transfer-encoding:organization:autocrypt:content-language
 :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=h1CxC4/YldoRD/TOfl1wGaaYrst695jdTuse57HfZ6Y=;
 b=skkvzjKgZq+6evCaDdyAP0ueTF5cAJXdngW0LWYpZLmd0PXjmMkWNEJBTBj3pI3OMv
 bPpF7YtWtqBD3T2TgpEepFYFyY4ViZEs3kgJszD/Q3qtqbDUiBYOBKbImBFl+dnXOkJx
 0+3SEJPNtDRypuUfLggFM7H3bn0gXVEJmbK+n9eUBEidZu4lDdIgK41ykWxRsAPKbULo
 VNyt2wSahwJXbMvyXizzci6wxnWRZMuIWvl7U+7/eXB0g7iU+BH3NDgT3oQ2wLH/mbEK
 jx2f5i7W0B3zKVZegF0tosqthMDgVsy9qakRc38Bqti80VQ0kC8DH1wHlr+yQ3jFcEcB
 CyPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699281272; x=1699886072;
 h=content-transfer-encoding:organization:autocrypt:content-language
 :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h1CxC4/YldoRD/TOfl1wGaaYrst695jdTuse57HfZ6Y=;
 b=KhMVrQTz++8+lTgm1vD0b8cXFmm7B2BcDmQ6s1UmfBwpPkpLffzNY2d3HTCBtCT4LQ
 YUrRp4RG6YZphyHYHJOzQfBX3OlQWW62hNu2R9ZAhGrj2CW3cNkejjWkx6X7+NNLk0EG
 3JeZPlPNlcz280TewG8l9o2LT6k5eOPNW0fyJQd3ETvXXv169Tbq9xLH2tK3rgADqK9V
 jTr8IJXvaFIwpQIgBvodAJorEtiQA0c6sJ7fAoYJ6HWHGYrPoGbDlSMFWK3lFom0U/Kc
 mGj+OT36+ssM3Y+WdcYHuXyj125CooWbHBl0tJjQ0sEpaq/Lp6TL/wniih9RU1fd3hZD
 0lTw==
X-Gm-Message-State: AOJu0YwPXcucUvk325khXMAg2dBZgv5xrILGfkrJ6NChgc3z0CEcw0I5
 KVL1Cz2EYRKzMLFEdXaihszUQg==
X-Google-Smtp-Source: AGHT+IEeVZfUX0LQMbHqId7/KE/WrVB8KGY0u7JfjCZ0a3m/+Ote6lhiZ9q9ymQvEfLJkMQ6SjBSNw==
X-Received: by 2002:a05:600c:1c90:b0:405:37bb:d942 with SMTP id
 k16-20020a05600c1c9000b0040537bbd942mr24639950wms.4.1699281272590; 
 Mon, 06 Nov 2023 06:34:32 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:7a54:34e:8001:fb7d?
 ([2a01:e0a:982:cbb0:7a54:34e:8001:fb7d])
 by smtp.gmail.com with ESMTPSA id
 gy14-20020a05600c880e00b00403b63e87f2sm12106245wmb.32.2023.11.06.06.34.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 06:34:32 -0800 (PST)
Message-ID: <93fdf4b5-db69-47ec-86bc-94741d362b24@linaro.org>
Date: Mon, 6 Nov 2023 15:34:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [GIT PULL] Please pull u-boot-amlogic-20231106
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

A little set of fix for:
- also enable DFU RAM boot for libretech-ac, since it uses a different config header
- SM probe fix
- A1 USB missing clocks

The CI job is at https://source.denx.de/u-boot/custodians/u-boot-amlogic/pipelines/18452

Thanks,
Neil

The following changes since commit a4c83bda17196bf5d1ce640844595aaeced6465e:

   Merge branch '2023-11-03-assorted-tegra-improvements' (2023-11-04 09:55:39 -0400)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-20231106

for you to fetch changes up to c550e81171940932664a85bda315a6a073aae23c:

   ARM: configs: libretech-ac: enable USB_DFU like in meson64.h (2023-11-06 09:46:05 +0100)

----------------------------------------------------------------
- fixup to also enabled DFU RAM boot for libretech-ac
- sm fix to bind child sm devices in the device tree
- add missing A1 clocks for USB stack

----------------------------------------------------------------
Alexey Romanov (1):
       clk: a1: add new clocks for USB stack

Dmitry Rokosov (1):
       drivers: sm: bind child sm devices in the device tree

Neil Armstrong (1):
       ARM: configs: libretech-ac: enable USB_DFU like in meson64.h

  drivers/clk/meson/a1.c         | 6 ++++++
  drivers/sm/meson-sm.c          | 1 +
  include/configs/libretech-ac.h | 1 +
  3 files changed, 8 insertions(+)
