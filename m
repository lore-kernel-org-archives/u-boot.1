Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B3F6C4167B
	for <u-boot@archiver.kernel.org>; Thu,  7 Dec 2023 15:02:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 507EA87215;
	Thu,  7 Dec 2023 16:02:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GkI8nROp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8B74870F6; Thu,  7 Dec 2023 16:02:31 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7970586BA8
 for <u-boot@lists.denx.de>; Thu,  7 Dec 2023 16:02:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3334a701cbbso1067816f8f.0
 for <u-boot@lists.denx.de>; Thu, 07 Dec 2023 07:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701961349; x=1702566149; darn=lists.denx.de;
 h=content-transfer-encoding:organization:autocrypt:content-language
 :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UFcceIOfJiFud0Bq+7/kJ+Zi9Ce9xN1K0UxRI0JMhRQ=;
 b=GkI8nROpYVs8jealjKD2M/8qJwvla681xkNNU5ni7VzKZL5q1tzVQQKsRFhxB4JYmF
 X4tW9fn4G1uja74sLfhahdluOcoatdESFyU8K8VMuaWXAVLJ67YY+c7ZXO1gBZXjU1ql
 2rKJAjzQClXDlpgMH30JVKIBjcADNaa3ryV9BoH2ToUjBpR46TTuFAFezfGp+uvfLVMY
 4bH/sOR3skf84ti4XjUyHIsoc+CJb1G6d0mRQDESECSpojYD4ZLXrPL7RtaXt7RFja2T
 IFPy0cK7Rqe5l0qhDVIXPManXnBOX6PiFgNpQU/sC0har71tcjTDvXs2Gt+GhzE0F+zt
 GAEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701961349; x=1702566149;
 h=content-transfer-encoding:organization:autocrypt:content-language
 :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UFcceIOfJiFud0Bq+7/kJ+Zi9Ce9xN1K0UxRI0JMhRQ=;
 b=A6RPSbd7NSN0VoYfmxpbyNsAZ2i14Rm+e9AmP47AyxnRlDupeON/w13OfVpDE2gPbC
 /PrWQtySx4C9l9nR89uWFIfk1vbF07JSO+UQhCuTEWxsbEFVNyaKfDD/RpD7oPcQMFw4
 VPSARWihHsfImpN4blCa1ePpVANGiUPY9JYSjUjNJOkaljN6SQBiH5wCL8jR6MIU3Ns/
 r/BJ5MFOON2/QLj3uPziz8notmT8Y8eqOip5CRog7TY7e2+8RCY8rrqUSqOApon3Pv94
 glKw4QNZS3GnOfqhiXRrYSW9gG+XIRYqQkYgZcjZUL+u7NfkmOgrzqi+kQFXR85xPPoO
 tWqg==
X-Gm-Message-State: AOJu0YwLRjP/rc0zxNiauiP/EepBhFhrHPn4mrzLaC/aKFnOl6cUVMJ6
 b+rc+K+eR1pkkrGos5Tg0xuK0Q==
X-Google-Smtp-Source: AGHT+IEQq/xZYTutj9f8RAPtRKqvfFfODqgw5VhF9A3JqCIvSm8Cquf0gXnW64vTr1IDTN/H+/nXPw==
X-Received: by 2002:a5d:6348:0:b0:333:1a41:c1d with SMTP id
 b8-20020a5d6348000000b003331a410c1dmr1054631wrw.33.1701961348825; 
 Thu, 07 Dec 2023 07:02:28 -0800 (PST)
Received: from [192.168.7.189] (679773502.box.freepro.com. [212.114.21.58])
 by smtp.gmail.com with ESMTPSA id
 d14-20020adff2ce000000b0033349de2622sm1640168wrp.94.2023.12.07.07.02.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Dec 2023 07:02:28 -0800 (PST)
Message-ID: <54bab289-477a-41a5-86c0-8647ba2a1610@linaro.org>
Date: Thu, 7 Dec 2023 16:02:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [GIT PULL] Please pull u-boot-amlogic-20231207
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

A little fix to add the missing DM_USB_GADGET config for the amlogic boards

The CI job is at https://source.denx.de/u-boot/custodians/u-boot-amlogic/pipelines/18828

Thanks,
Neil

The following changes since commit 2f0282922b2c458eea7f85c500a948a587437b63:

   Prepare v2024.01-rc4 (2023-12-04 13:46:56 -0500)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-20231207

for you to fetch changes up to 4005729c0de234ffcf36465f6471755617b42375:

   configs: meson: enable missing DM_USB_GADGET (2023-12-07 09:36:19 +0100)

----------------------------------------------------------------
- Add missing DM_USB_GADGET to amlogic boards

----------------------------------------------------------------
Neil Armstrong (1):
       configs: meson: enable missing DM_USB_GADGET

  configs/bananapi-m2-pro_defconfig | 1 +
  configs/bananapi-m2s_defconfig    | 1 +
  configs/libretech-cc_v2_defconfig | 1 +
  configs/odroid-go-ultra_defconfig | 1 +
  configs/radxa-zero2_defconfig     | 1 +
  5 files changed, 5 insertions(+)
