Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16E32CD4F4A
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 14:38:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A99758469F;
	Mon, 18 May 2026 16:38:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dyIkt6uy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A64D83EF9; Mon, 18 May 2026 16:38:14 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E2AB846A4
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 16:38:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-44e1ebb3122so1355868f8f.2
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 07:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779115092; x=1779719892; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=Gna6dynhWQrnSh91QR51H1J4qxdrDPfJakmzmtbFASs=;
 b=dyIkt6uyUrbuzFVyg39WzWQfdt8nBQpzu2pCzIgSO/lZ5Lp4adS4hX2Q7u6mlvbAel
 IokdCp6TwxD4X/GUjL8zYwrH/0Lq5G6KMBNmkB1L76UO74TLCd6vuFoKe/hU4IVsWXD+
 zGr0Auo0LGnRA7m2ZnNHUrvFvZrqh2v4eBry7sf2cJ25Qn3WQAacwZlVLqNm7jl56fK3
 MardHmL6n1gTW9cv7ALsfPFf3u4ThqnRYsHUZADIfQTv7+j/2YkzMrr9zCeG53H9jHmS
 cV9i56MOyeWO5bIldIDPVcWmrMUi7Cdtr5WIaEdOxw/QYMk03P95JU8Bo/BuWX3LmgPC
 0+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779115092; x=1779719892;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gna6dynhWQrnSh91QR51H1J4qxdrDPfJakmzmtbFASs=;
 b=XBRzLXdIjptqlhN8YGA5LUZ9/4FcZCEAfOhhtHwtOhdywqTXuTvGUBA4eD3rYkQ+wE
 8mrXM4Hv0cwkZ3sah/MkCpIZC+XsFkmteloIcj6oU6JgNTCvv7z5XMwA20g4BNvx3ZfO
 NWZ2JQGQ6+XrJZDYt/ULTHj4rweNgrqRHQ7Bh9K8JzC7F48pVsyTJv1GmVseVHqOqRWj
 gFnysVlzXrjQ8SrOAiJJoKKI9DC4xXVJIsliNRq9zOITdNsoWnMfFn6kzBUcEpqLEO3v
 hf3ReYUT3OqV5ciTQ8eUhg1qhKtGfTdK3hNoxc+2kWrJxIbhh86kosalFlARTjwPivH0
 QQLQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/iBWkBzqjBbd8R5KrHTuMk0ShzCAOjR5Kw1I0NQPpNmyVgts4gFuXHOzZVGzSe3elzrVYmRkA=@lists.denx.de
X-Gm-Message-State: AOJu0YwxfPqPI0FWDM5DMP4BDvkKiWIT4/7sEnxd+sfkjNoFgByDQlBn
 IGSSt0n1gA4lfx9Im9mqCYGg7ZxWAINaaOmFRQdLMtTUXQkyk4NCK9A0YhO3TNa0mOY=
X-Gm-Gg: Acq92OE90QdS470Z29HZDT1hHEIrjHq02ySjnsCW2oTX7kSvGc2xUsmdCGx64J8W3bb
 NHwB/j6cYc7/uD5fLRZ6/Z4TiAw/EkoPdpYOwy0W0ld8h6Dzf5EYsGK3DGthB0Wd+QrwOV3PQyf
 uKVP20qp6GuhVSuT95OCj2uOW8Qn42xDdLS7twZa1eMkphyttdJPY/nazH3XwErFQZBkvtXbJDc
 H5ZIuvlvF8eHinqq6yd4qN/+fNgO5+yvUSc5DH/PmevyzUT3OnJe+cq+qeSxk6fHUxljpvk1zDl
 wywagG/XA7EpMJaiXc8m1ga9rH+CXlWpRgtIVwBr/pGeJbsJYYnj13Ag3pH2WlZp88SDIxdbaDB
 YvH9OKyW/YNh35ggwdRVOEYczFrz0mVkZWugAeVdT+Xd2eH4ZDAXnssCN8qS5PqLpm2MehIMAHN
 h1k+bn2XSM1bfebb+iuyh2DoHYHFJfdvzy0Epp40/7b1z2vZS8Fi9JMkgHwKEaasGTci48X0VLB
 +0baFc=
X-Received: by 2002:a05:6000:2c10:b0:450:e5fd:e1a1 with SMTP id
 ffacd0b85a97d-45e5c35dcc2mr25240103f8f.3.1779115091455; 
 Mon, 18 May 2026 07:38:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:1029:e3c5:362e:1250?
 ([2a01:e0a:106d:1080:1029:e3c5:362e:1250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9e768acesm40484603f8f.7.2026.05.18.07.38.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 07:38:11 -0700 (PDT)
Message-ID: <c9ccab52-4054-4fa2-af1c-d16d05a3c99d@linaro.org>
Date: Mon, 18 May 2026 16:38:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 11/15] soc: qcom: smem: add build infra
To: Casey Connolly <casey.connolly@linaro.org>, u-boot@lists.denx.de,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alice Guo <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Raymond Mao
 <raymond.mao@riscstar.com>, Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Heiko Schocher <hs@nabladev.com>,
 Michal Simek <michal.simek@amd.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
References: <20260504-b4-modernise-smem-v2-0-c01ec2ff3886@linaro.org>
 <20260504-b4-modernise-smem-v2-11-c01ec2ff3886@linaro.org>
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
In-Reply-To: <20260504-b4-modernise-smem-v2-11-c01ec2ff3886@linaro.org>
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

On 5/4/26 20:57, Casey Connolly wrote:
> Build the new SMEM driver port, and select it when ARCH_SNAPDRAGON is
> selected, since it will be a hard dependency for Qualcomm platforms.
> 
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>   drivers/soc/qcom/Kconfig  | 8 ++++++++
>   drivers/soc/qcom/Makefile | 1 +
>   2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index 8243805e46a3..cdd9e30f43e5 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -24,5 +24,13 @@ config QCOM_RPMH
>   	help
>   	  Say y here to support the Qualcomm RPMh (resource peripheral manager)
>   	  if you need to control regulators on Qualcomm platforms, say y here.
>   
> +config QCOM_SMEM
> +	bool "Qualcomm SMEM support"
> +	help
> +	  Say y here to support the Qualcomm SMEM (shared memory) client driver.
> +	  SMEM is a shared memory region that is used to pass information about
> +	  the hardware (e.g. DRAM layout, PMIC configuration, etc) between bootloader
> +	  staged and the OS. If in doubt, say y.
> +
>   endif # SOC_QCOM
> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
> index 78fae8bbfa16..f4102f9155a8 100644
> --- a/drivers/soc/qcom/Makefile
> +++ b/drivers/soc/qcom/Makefile
> @@ -1,4 +1,5 @@
>   # SPDX-License-Identifier: GPL-2.0+
>   
>   obj-$(CONFIG_QCOM_COMMAND_DB) += cmd-db.o
>   obj-$(CONFIG_QCOM_RPMH) += rpmh-rsc.o rpmh.o
> +obj-$(CONFIG_QCOM_SMEM) += smem.o
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
