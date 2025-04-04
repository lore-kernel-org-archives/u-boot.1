Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 793AFC36010
	for <u-boot@archiver.kernel.org>; Fri,  4 Apr 2025 08:40:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5909828D0;
	Fri,  4 Apr 2025 10:40:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fk1XBdiE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1886828D0; Fri,  4 Apr 2025 10:40:34 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E05B828BC
 for <u-boot@lists.denx.de>; Fri,  4 Apr 2025 10:40:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43cec5cd73bso9956155e9.3
 for <u-boot@lists.denx.de>; Fri, 04 Apr 2025 01:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743756032; x=1744360832; darn=lists.denx.de;
 h=content-transfer-encoding:organization:autocrypt:content-language
 :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4ILSkJoOKj+XeT2UHR0pMDQfEYLAP0SBkYYIJx1Hsnc=;
 b=fk1XBdiEcuEQG9rXKeFNSZirvUHLakwdIqrlHg2bibmr46rcfn3W7NpVw28rr39/Hl
 UFL8VEIRCFtt2gKGdmNuEvj68q53j5vS7yAai/SQohu5XY1EZmC1DiI9TwfVtkC7ZHQh
 FsMyyuSxtf8cVwwyYRCYij0TZXLBwcVTTZNlbTW20t3Bfre4h2rSjGDdAde7PNdf/s53
 BnFPEVlTpPcCs1Cs4QGwplDcwQbJMok3T6ySLzhEVg9vjjZamu+31wEUynvWHhBJT6dS
 Iy1SUQdcZkFEy9AhQsSoDe1WkA89xHAkuuQYKpo/QwdE5M3Sx1wWNLFWSzcVsvgvD5MU
 hkpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743756032; x=1744360832;
 h=content-transfer-encoding:organization:autocrypt:content-language
 :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4ILSkJoOKj+XeT2UHR0pMDQfEYLAP0SBkYYIJx1Hsnc=;
 b=PH4i7iY2gO2+y5apfrqL0L+hRaabWr3mwLYy6R5r3gikd+bh9DOqahHqerjCMYk1Nb
 STEGRIEvxfDiz6sPYSRkBzq1zJOH663W4GRTXvUYRYPOHdU9G9pEIYBObO6FgRsFmxWQ
 7qCtNQn1TfEmed2YX/zo7e0QXHs/hq9RN/aA0WxDLPHBLNsl78wgvXqjss+uP5UNaA3/
 uqZLF1iKPo3MvRVrWHOUvkwAhiTNh9godocaHmbJfuIuzsuAjZBCekki0AUVRWwwdQCF
 ikgefIDbh/FdoXI+JkRckLUwZOk9GdI6DfCaY/8veKv6yqyyKuHzDnOxhz2/VEEhC9PE
 Wr8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoYdaE/93aHUP2GzsDjULbzP03gkwTDTJt9baCp+ye4+OQmnA2yCWJgwsejMzLBaVxr73GTU0=@lists.denx.de
X-Gm-Message-State: AOJu0YwD7fwrNZkrJ72r7YCWLdhGqUsstpMIkH/9nygp1NFuHtlVv2ns
 k7efZA4F8jrTtO+KjTu5ea2EfSPr0nBSX/3J6S06GU/otgXEXbQzAwH6yuNsU3A=
X-Gm-Gg: ASbGncuo+OgVU301SaPiLfnrz6tt43zk2WnNG+ZxRAeYxosXcFpua8ZgV+d8K9PwM0c
 SyqSI1LWgvJcS1kiDwcP45KI4wteeQ1ho0363AWSPPcVXeCbgw91gxEx9GeRB8543MxTMsI50vS
 LhhgOH03jvpa3g/IenHg/BzKRY/6gArVcXjtgP4GdXZ29QR7hmPpiTxeaIKl8XxxeDYAyMQaf+b
 rTem6SpIXAE1JzQu99HQCCao6MVhIcE9uKmK/lvfs6PqiaGbafAZGGTI3D1pSsfdV5IccWFr6wU
 kwOQ5z4+ZQUebEi0boe8N/OJJSIMmy4q08Vf6sLQxWD/9l+Y8S8c1IsfuHlW51/t6LwdphvrQsG
 rj1TgRjGXuo1tqkMZJlXuDYWEzIM/dA==
X-Google-Smtp-Source: AGHT+IGU5jbPZ5HW4NsnxVQQUVK5PxURbOZilt7sN/Ch0Uk05jtSHgQclPw8MEOxbZHMiGI4Tc3LhA==
X-Received: by 2002:a05:600c:4713:b0:43c:e2dd:98ea with SMTP id
 5b1f17b1804b1-43ecf9c7731mr16552425e9.22.1743756031764; 
 Fri, 04 Apr 2025 01:40:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:19b:8166:6e82:3840?
 ([2a01:e0a:3d9:2080:19b:8166:6e82:3840])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec17b1352sm42475745e9.37.2025.04.04.01.40.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 01:40:31 -0700 (PDT)
Message-ID: <d1de0302-ad3a-44ba-ad1a-73cc1b6f34f1@linaro.org>
Date: Fri, 4 Apr 2025 10:40:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [GIT PULL] Please pull u-boot-amlogic-20250404 into master
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

Here's a last minute fix for the libre-computer boards fixing the capsule update feature.

Thanks,
Neil

The following changes since commit 82b69fc4224432d5aefa7ca750d950374cbc7fb2:

   Merge tag 'efi-2025-04-rc6' of https://source.denx.de/u-boot/custodians/u-boot-efi (2025-04-03 07:31:28 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-amlogic.git tags/u-boot-amlogic-20250404

for you to fetch changes up to c5fd2c7ac7fa4835339ea09ead2884794314c9d8:

   board: libre-computer: check interface before comparing it in set_dfu_alt_info() (2025-04-04 10:37:40 +0200)

----------------------------------------------------------------
- check interface before comparing it in set_dfu_alt_info() to avoid hard crash on capsule update

----------------------------------------------------------------
Neil Armstrong (1):
       board: libre-computer: check interface before comparing it in set_dfu_alt_info()

  board/libre-computer/aml-a311d-cc/aml-a311d-cc.c   | 2 +-
  board/libre-computer/aml-s805x-ac/aml-s805x-ac.c   | 2 +-
  board/libre-computer/aml-s905d3-cc/aml-s905d3-cc.c | 2 +-
  3 files changed, 3 insertions(+), 3 deletions(-)
