Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59E7ACD6E4A
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 12:49:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA21884948;
	Thu,  4 Jun 2026 14:49:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LRtUPH0N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B8E584949; Thu,  4 Jun 2026 14:49:51 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29AE38490B
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 14:49:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-490ae94a89eso6542645e9.1
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 05:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780577388; x=1781182188; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=QVwuKktNCXL7nGL2a8Nd6TKwboqW8IrwL9L/lfzW+jQ=;
 b=LRtUPH0NsP7rkZaiK7Oxb9nhTdjhg8IF7+0ObwAaBShSewo0UVM8avJOfHj5PLZVpA
 tDZw3CVcZanfd3A0yDWypf7sNNxAWBRgtpyFiuFqMzttA/UpWxHiOA82ZA364K1X/q7J
 Fd38DhWTgB3sO4n39cW6X/GJKlGUwsVwKem8i2e0D+Nh4O0+Lxb42suz4Apq3SCF7ZOA
 N6RFH4Q4Ev6HYcbT1uisTW8tYuOEZALyIvPXUV1lIFnbd6n3aI3oO+rYuoWbiaEO4Ra3
 6AurimeZhubOACi6HaBQoR6xV8/fgcsrQ/0e80VV2SGnJDgybMDyzMAkQhcZX9JdUhn2
 ItZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780577388; x=1781182188;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QVwuKktNCXL7nGL2a8Nd6TKwboqW8IrwL9L/lfzW+jQ=;
 b=fRIezUhzQjM0joROxFtVHJ3QG8+5eMJ6HLUkkdBXB1Ca2CyTcSSniQ//9vp9elTlhJ
 fMxus7ycEV8J3MFPHimbttG8aH0Jj0PVk0vPKllFm1s5tEMS+U9H2gTLc80LO5hcNVod
 2RC3LWm6ZNkhlO59IX3kFl7TyJXaiaKYs6FVLFg9ipkiHljCH9jshVyhdjUiGzbAg2sL
 vGczZ9knFRI3hPrmxEzRKVydRqk9KIElKGPezsZCycUonPvqG6FBf1c0DDgZT/xJ4a5Y
 ET+r3PoZuoho+6vF6RhkWpkfMlRDFztF4IyUSAgBaT+NSvrMzuJwZKOmdggyM9jEE7jd
 I3IA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9NALWTYOUCEsMNQ/p84Hg+GQ4QyFZBKLR1XEJveAyQLCWDb0jKHSuwr2oNm/EeGiuCqbczqhg=@lists.denx.de
X-Gm-Message-State: AOJu0Ywx4BPW+D44lJ4bPlTXwfFaGnafFT3K0K5JlnHs5o6315FZj7Qa
 nr5izmt0CVTbCuFzdxWSKWjFqj0sNNaOcq0tOw8ZzNhIk6GuR2ucjDbzYYqLIgfqj1o=
X-Gm-Gg: Acq92OFuYIq1Pg83M+c4KkiO53pCGvIK2TWZir8o5VuxERnD5LEt49BenhxU4JPe511
 gS5zoQ/lJVPTBDDEtYhIDwRuw7vvS30asd3OGyKUfonZJDEGwg+rOrR2OXLkUAS0ePbFdNaZDPy
 0AB7UXVCPkj9GWL0lXhSkTzopHRCAvtZUa764Vd+/wWa/iQM159NU3EYpWhVGz/+tsPD8tiPMV/
 TM4+v95nZ1RV8a7woAbN2m++eB8pVZ/I1cInWV+sxWvtjp77K0Hlhi/+rAk8eEHqEA5bXW4wsOW
 UI1KAfO43JEZq/OrrAR9me2Fjeb2FIu17j0brygRDSqtN+PXCsVWYRDrNwsNH1zy28PkeOKUfgK
 1oOYJun8CZFzdVIXKb2vL0f0fNN+S981wyHcoeckYWc4tVVLD3Qv+icTmtb0beYmnRYgAR8w1/A
 rUi5EMOwRNS849/6YYZ0lIUt4hDHu6XEe9bEmOChyyeBPHr1Wt8uZ9hS7nuB4dwCljXsN/wElX9
 NEHbwZe3j36Rqo58+e4To7NGA==
X-Received: by 2002:a05:600c:c84:b0:490:389:7644 with SMTP id
 5b1f17b1804b1-490b5fe0e36mr126264935e9.17.1780577388134; 
 Thu, 04 Jun 2026 05:49:48 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:dbd:100f:afd5:9221?
 ([2a01:e0a:106d:1080:dbd:100f:afd5:9221])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490b7e6c774sm78871125e9.1.2026.06.04.05.49.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2026 05:49:47 -0700 (PDT)
Message-ID: <237ca49f-ed59-428f-9423-e16b2bb6c7b2@linaro.org>
Date: Thu, 4 Jun 2026 14:49:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH PATCHSET 5/6] ufs: add ufs_tool to Kconfig and Makefile
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
 <20260604-ufs_tool-v1-5-741ed00232c0@mobileye.com>
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
In-Reply-To: <20260604-ufs_tool-v1-5-741ed00232c0@mobileye.com>
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

On 6/4/26 13:25, Raz Ben Yehuda via B4 Relay wrote:
> From: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
> 
> Add support for the UFS tool to Kconfig and the Makefile.
> The HBA ID defaults to 0 and can be overridden by the user.
> 
> Signed-off-by: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
> ---
>   drivers/ufs/Kconfig  | 15 +++++++++++++++
>   drivers/ufs/Makefile |  1 +
>   2 files changed, 16 insertions(+)
> 
> diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
> index 49472933de3..8f67d916a72 100644
> --- a/drivers/ufs/Kconfig
> +++ b/drivers/ufs/Kconfig
> @@ -8,6 +8,21 @@ config UFS
>   	  This selects support for Universal Flash Subsystem (UFS).
>   	  Say Y here if you want UFS Support.
>   
> +config UFS_TOOL
> +	bool "ufs tool"
> +	depends on UFS
> +	help
> +	  Add a UFS tool implementation for querying, printing, and updating
> +	  UFS descriptors and configuration parameters.
> +	  Please see doc/README.ufs for details.
> +
> +config UFS_HBA_ID
> +	int "Id of the ufs hba"
> +	depends on UFS_TOOL
> +	default 0
> +	help
> +	  Default UFS HBA ID.

As my previous review, nack, please add this as a parameter
of the ufs commands.

> +
>   config UFS_AMD_VERSAL2
>   	bool "AMD Versal Gen 2 UFS controller platform driver"
>   	depends on UFS && ZYNQMP_FIRMWARE
> diff --git a/drivers/ufs/Makefile b/drivers/ufs/Makefile
> index e7f3c1d30c4..0e472782261 100644
> --- a/drivers/ufs/Makefile
> +++ b/drivers/ufs/Makefile
> @@ -4,6 +4,7 @@
>   #
>   
>   obj-$(CONFIG_UFS) += ufs-uclass.o
> +obj-$(CONFIG_UFS_TOOL) += ufs_tool.o
>   obj-$(CONFIG_UFS_AMD_VERSAL2) += ufs-amd-versal2.o ufshcd-dwc.o
>   obj-$(CONFIG_UFS_CADENCE) += cdns-platform.o
>   obj-$(CONFIG_UFS_MEDIATEK) += ufs-mediatek.o
> 

Add the Kconfig and Makefile at the same time as the c file,
not separately.

Neil
