Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB185CE7B0C
	for <u-boot@archiver.kernel.org>; Thu, 28 Sep 2023 09:04:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 393268652A;
	Thu, 28 Sep 2023 11:04:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JU/mDcfd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C805D869CA; Thu, 28 Sep 2023 11:04:41 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A22A3864CD
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 11:04:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-32167a4adaaso12109966f8f.1
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 02:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695891879; x=1696496679; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=C560Nh+KV3R8eIM8i9TQVF4mEeqUj4ionnt9HrBHDDo=;
 b=JU/mDcfdBVKHMD4nr/ZSfUFDVvAk51FPKC9GyEuO+nHn+9hfSw/tv/UOj9q/hHBB4b
 Sdmbx/33y5wabavJSWod7nmT4zkEX5xcDsY48VtCkvN5+LZ2FNVWLScDzOorSfAVygnY
 3jitrjqAw9aYj+L54yccknXhwOGXHcftgephPur5i6JF7Wau0b1RK2bSoH2qvoVQQ08t
 3STq3fEwiVaRBBULqEwUev5236rFhdu+TimDwFocal0wLuqCfWKk7dc9pus4tvAVtDBT
 5lQJB5tZKNB6BdOkwmmNjsIUYGuU3WPlMM3DInVZSVWc1T4jEHnzNdYGf6y6aA6GUZdg
 pO2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695891879; x=1696496679;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=C560Nh+KV3R8eIM8i9TQVF4mEeqUj4ionnt9HrBHDDo=;
 b=BHhXNCx59R3zOrVQOmdES05Yh+hjp3nF6W+HWnflJkSjfLEwjWN8s5iQT0LtGy3FWI
 vB/xWLJfBnuqjphMfLbXbgHMsW95PzosWGjaxkZ7TUoe4z2zJtUHjGUSOPvu63yzMTN4
 N9ilYCSuE5WrQetng0i75IrpmyT2i5z6UaoOU8DWi8VxduhD0fe21wBgz5srBnCMG17I
 cYu5bCHa4OgdMNl3X+L35HRicPPGYe0yWvQMNPaHwf98apK3CtnMoTnNOvr8IKV2a2db
 ekLJzG8T86ihxQZ6t+DP/Y5+EoTcQeOAufvbVlPRxlcM+WWOHTbow2jHZOme0pJDA4C5
 2I0w==
X-Gm-Message-State: AOJu0YyqZVXtLJQgFZE2IUzoVcJ0jmP9Hiqp5dxfwlrax+LRoi/Dc8Hy
 e0qKLFKrrxHI1jde9kyUTc7ZZQ==
X-Google-Smtp-Source: AGHT+IEtvwmHMYQNKHk0sPd9zMH7JZrX5jZX9y6BHkELPSkuzZFuyqQ/DMQqExMRTVaFQ4RLXONYwg==
X-Received: by 2002:adf:f3d2:0:b0:317:6ef1:7939 with SMTP id
 g18-20020adff3d2000000b003176ef17939mr612667wrp.23.1695891879078; 
 Thu, 28 Sep 2023 02:04:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:17b1:9dda:a3d1:a0b6?
 ([2a01:e0a:982:cbb0:17b1:9dda:a3d1:a0b6])
 by smtp.gmail.com with ESMTPSA id
 bo12-20020a056000068c00b00323287186b2sm10034504wrb.29.2023.09.28.02.04.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Sep 2023 02:04:38 -0700 (PDT)
Message-ID: <f61de215-b962-452b-b72d-ba4cf354d6f1@linaro.org>
Date: Thu, 28 Sep 2023 11:04:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [RFT PATCH 0/2] mmc: meson-gx: improve MMC reliabilty
Content-Language: en-US, fr
To: Jerome Brunet <jbrunet@baylibre.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
References: <20230915160130.352099-1-jbrunet@baylibre.com>
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
In-Reply-To: <20230915160130.352099-1-jbrunet@baylibre.com>
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

Hi,

On 15/09/2023 18:01, Jerome Brunet wrote:
> Amlogic MMC on the GX (and later) SoCs has been problematic for years,
> especially with u-boot.
> 
> Linux has been fairly stable for a few years. It is using a fixed phase
> setting with Core = 180, Tx = 0 and Rx = 0 (the latter cannot be set
> starting from the v3 MMC IPs)
> 
> Still the results were not good with those settings with u-boot, on some
> sm1 based platforms. U-boot then started using a 270 core phase for sm1
> only.  This worked for most sm1 platforms but problems persist on others.
> 
> The proposal with this patchset is to use 270 for the ID phase, 180
> otherwise.  This works well on the platforms I have tested (Libretech's
> boards and VIM3L)
> 
> It would be great if others could test this and report whether this work
> for them or not.
> 
> If the results are good, this might be ported to Linux as well (... but the
> situation is less critical there)
> 
> Jerome Brunet (2):
>    mmc: meson-gx: clean up and align on Linux settings
>    mmc: meson-gx: set 270 core phase during the identification
> 
>   drivers/mmc/meson_gx_mmc.c | 50 ++++++++++++++++++--------------------
>   drivers/mmc/meson_gx_mmc.h |  9 +++++--
>   2 files changed, 31 insertions(+), 28 deletions(-)
> 

I'll apply on my test branch which triggers my autobuilder providing ready-to-boot
binaries for most of the supported platforms:
https://gitlab.com/superna9999/amlogic-u-boot-autotest/-/pipelines

Neil
