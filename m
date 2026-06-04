Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B03CD6E4A
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 12:46:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AA7F848DF;
	Thu,  4 Jun 2026 14:46:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SxQeu8ue";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 793D9848EB; Thu,  4 Jun 2026 14:46:01 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FAF884879
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 14:45:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-490be03d47bso5492185e9.0
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 05:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780577158; x=1781181958; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=f3mNJcYV5kEPaEIisXGtpXRrbxXE/3e1q1Zt4OIdxOg=;
 b=SxQeu8ueuT6E4z76zPuiWfe7KophFEySztcFNlWqUb1PFkmNAnkYWFWCC7UbL2iNp5
 i+70+noLxFPjLV3yIms5MHMvJlFlyrKiSPX8baAHsDwnFdUkxeOoFHp8oghKDdGvUgoo
 /0DBINZgU2bJbHlz8d+PtSjrjohmFG6Z56y+CpOOD+C5tJyO6EvbMKCU5fYvkAkMijou
 r4cEn/mf1hAlaLIUVrFS3sH8YnhdAvVOgcVWjgtQKVmhoJPUbOXTx6hG9L1vnIJzQW+w
 ffuilpwcVuJ/ho4/nPkioO4trPrLBfEBM7p5A8k1M3QByUKeHrGJ4xlLXKjWNUDO1ulK
 OC7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780577158; x=1781181958;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f3mNJcYV5kEPaEIisXGtpXRrbxXE/3e1q1Zt4OIdxOg=;
 b=ekX9MlK8OyMcDt3LYqBoNKPkeS/PHD3vbq2kHdrEcQbc5g3xCU3Pz3NuOs5ljaIao6
 6+1dSnYL7vpxr+YbAPpE76C1TR9QdhQ2eBzI31iBCT6SMDA350LoNxchUPZUAylm5kEs
 uigJVNo2q5LoZkz7AQFKuSzFMIw8tQweRqeH3tLA2qgHcx9hBzjZmRZ03YCP+3c//mAe
 5I4w2CwEyL/J5xkK/H+14EiFGrDeZRBWLlTQrVEPR9/mpAhr0yVAxV+iMWGYo7Oh6EqT
 W/85GrNjwRVsfag0RL53XFimX93CCdZ6l+Rqg0sUNDJJvRwc7CWIkY+s+dOe6dHo+VQT
 jw5g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8fPUim+hexejB2Xg2gcLeDhcepQ6Jn8UhZcDtBEsBngI8SJAnltYOqy3kH2IJcvTeGA/T1wC4=@lists.denx.de
X-Gm-Message-State: AOJu0Yx0E1eZUy2qv+hpLAUHI8F0PS4Bl1OoDvmTsBFiSnTrDVbDX50W
 BMIjnFRbXXYphCmLfUcN2H8li90qbUxN2gxJ/+sgczacW/J2KVod1WgRg/zKKQcV5IY=
X-Gm-Gg: Acq92OHsvXbXBePIF76RMVvzqqQwwVqHvbOs50pqSXCW8h984M86LxMKM5wdm0r9dAC
 72ftXav69vUaHpQpvUYU3by3dF3SYjTJSzkgx4xjpUStUUFMt/ijBk22Yq/G1IaMkogcljXxGQD
 mqUwLpeweMCrO64qDfNXbd/QzglMX/Cl0SgY2yJiWW9WvhlldvEos8cRu3bqMyPskMqTfd1s9Ti
 MSJSiQbO4XK6lFVuxFlZ+CUoq7GTlOscJWvHNGOjSCABGZ+/2x1DvUitkqk4k6IXEqkJnVP6Ki6
 aQc2yL3Vacet5H+4lZmmyKSOA1FNW/bvmd5flCTQtObvapnHlcVlWxGgGUxiUS8wsZPjIx7+h8Y
 vMCu2PpiD/7/oKDXY3ABHrfLp6UHKvd6ae2IXbawsyvfopY8rwz8v1V65WzTowQxQ52q82AWuBG
 Q2jOiN6CMkoeEQfjYoLTa/swcH4dtZeJ7PezDJ5DbMWscm4j9KzoxAEd/vu0R8sUuy9+87XFZw2
 oODGEQe3qfAQt4=
X-Received: by 2002:a05:600c:5250:b0:490:bde3:d112 with SMTP id
 5b1f17b1804b1-490bde3d25bmr44374235e9.30.1780577157653; 
 Thu, 04 Jun 2026 05:45:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:dbd:100f:afd5:9221?
 ([2a01:e0a:106d:1080:dbd:100f:afd5:9221])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46028a6dce6sm7706581f8f.30.2026.06.04.05.45.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2026 05:45:57 -0700 (PDT)
Message-ID: <ba6826dc-8b08-4a97-9e71-419743649856@linaro.org>
Date: Thu, 4 Jun 2026 14:45:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCHSET PATCH 0/6] UFS-TOOL
To: raz.benyehuda@mobileye.com, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, Kory Maincent <kory.maincent@bootlin.com>,
 Yao Zi <me@ziyao.cc>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Macpaul Lin <macpaul.lin@mediatek.com>, Michal Simek <michal.simek@amd.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Jared McArthur <j-mcarthur@ti.com>, Shawn Lin <shawn.lin@rock-chips.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>, Alexey Charkov <alchark@gmail.com>
References: <20260604-ufs_tool-v1-0-741ed00232c0@mobileye.com>
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
In-Reply-To: <20260604-ufs_tool-v1-0-741ed00232c0@mobileye.com>
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

Hi,

On 6/4/26 13:25, Raz Ben Yehuda via B4 Relay wrote:
> This is version 2 of the ufs-tool patchset.

No need for that, the version should appear in the email subject.

I don't know why you added "PATCHSET" everywhere and why you didn't force it as v2 version.

> 
> Patch [1/5]: UFS tool implementation for querying, printing and configuring UFS descriptors.
> Patch [2/5]: Remove the static qualifier from selected functions to allow access.
> Patch [3/5]: The cmdline UFS tool.
> Patch [4/5]: Add support for the UFS tool to Kconfig and the Makefile.
> Patch [5/5]: Documention of the ufs tool.

This is not a good summary of the patchset, explain why you implement
this, and the high level technical details and use-cases.

Neil

> 
> Testing:
> - Built for x86_64 and RISC-V.
> - Tested on RISC-V hardware.
> - No regressions observed.
> 
> Changes in v2:
> - Replace printf() with log_err().
> - Clean up code style and adopt reverse Christmas tree ordering.
> - Add HBA ID support with a default value of 0, overridable by the user.
> - Add documentation in .rst format.
> 
> Signed-off-by: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
> ---
> Raz Ben Yehuda (6):
>        MAINTAINERS: Add myself to the list of UFS maintainers
>        ufs: add UFS descriptor/configuration utility support
>        ufs: Expose selected UFS functions
>        ufs: ufs tool
>        ufs: add ufs_tool to Kconfig and Makefile
>        ufs: doc/usage/cmd/ufs.rst
> 
>   MAINTAINERS              |    5 +
>   cmd/ufs.c                |   93 +++-
>   doc/usage/cmd/ufs.rst    |  217 ++++++++
>   drivers/ufs/Kconfig      |   15 +
>   drivers/ufs/Makefile     |    1 +
>   drivers/ufs/ufs-uclass.c |   18 +-
>   drivers/ufs/ufs.h        |   16 +
>   drivers/ufs/ufs_tool.c   | 1231 ++++++++++++++++++++++++++++++++++++++++++++++
>   drivers/ufs/ufs_tool.h   |  394 +++++++++++++++
>   9 files changed, 1977 insertions(+), 13 deletions(-)
> ---
> base-commit: 0c035ff60c1e8caee7fccd2673ce75380dee825b
> change-id: 20260604-ufs_tool-3bd50111593f
> 
> Best regards,
> --
> Raz Ben Yehuda <raz.benyehuda@mobileye.com>
> 
> 

