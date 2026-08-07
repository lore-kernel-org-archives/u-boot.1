Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67517C5AC7A
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 12:38:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DA05C812CA;
	Fri,  7 Aug 2026 12:38:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WmmriPPDETE4; Fri,  7 Aug 2026 12:38:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 007B98112C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786106289;
	bh=1m8+j8Z8URFOZy76gDvdnjCVljozzo9jso5mYZBpor4=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=dc8t/yD32mdN17jP/hLEZRuZ/I1z+eFA38Fg1jq2AS3081ejVcgJvbcAWPD02zDEm
	 0AO8Pt6J81i9IMvDsO1A6y8GEhkUkAJ6T5ZGVGRaNxuCRu1t3C5yTGm8913CK2MTZa
	 8h2yteK4H2Z5A/YIRDiqFE7OjeQmLfiXH48mhTC6+uvr7iXzSw9QF17yDYAIK5LDpr
	 zUWRVMSTrsLhnve/jICGSmOvjvXbWD+8whT/dBGjz/JAbkr2kUeaf5aP0M1Yr1ram4
	 elDGFAjDTw46VEXNgyGIl2stYhNf3E7cGqI4VXZTG3SBpfZfvfiFTGwVNgLYNmXmIF
	 Kymg1fPJu2K/Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 007B98112C;
	Fri,  7 Aug 2026 12:38:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 214F0198
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 12:38:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0905140A5D
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 12:38:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jFRG42vNwsLa for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 12:38:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C040D40A46
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C040D40A46
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C040D40A46
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 12:38:06 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4955de8797cso23096775e9.3
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 05:38:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786106285; x=1786711085;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1m8+j8Z8URFOZy76gDvdnjCVljozzo9jso5mYZBpor4=;
 b=UG+c/lXGP5NH0s6TISLIM0mi7LAzCYs8TSsHVsuU2uJ/Y9liiVvbRHz5OYF1xpdm+Q
 S70msSrZRjdxhxc46frT4P2I0C3j7a4oQkz0ABqkvr/hsQzgukW+RqN8sXUnLW16BtFH
 i0HXpFCVbqfedNX+rLXz5u/nHSpILg4JsYkPgsmzcLysREbAMzPgd39zxsCmHkTdg+eM
 /+VjH+FZRVq0g9SdXifUbAmJ+eNp4QqJVDWF0PPWssX8yiHwV7K+afclA4oAkefKYqqd
 aRulvrjn/6HSzMd+wZKd8vmIKLGD4Nncag0gMNW6mEGj2D5mYbr8aPpUCHCaLYmOcLsN
 j/3g==
X-Forwarded-Encrypted: i=1;
 AHgh+RrXeuRLiG7lX3eqWypYwc+IC4/D094T9dP35Sf9ChgYrHzJW1g5arXVa8KmaiM1ksHWQrvuDQ8=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyktnSN1Q7rpX0WMjgdhL+sjNslAV1wpxavzBW8CzAZDv0lKwD2
 B2yWQEMR1YLxLHPf0PWY/Yl1Ih7Ml91OzqrjYcUXQQ8DTFEasTtWCKIy7/V6DbxR7Tc=
X-Gm-Gg: AR+sD11LErCs34VvQntf2cYB1CQsuBvaYq5OQiVv+izf8FilMGyXq7D/Z/9IcjqxQju
 DPrXErbqoYEWZvO+qk6uCfL9HPvT/+VvDQcsillsTAmd3mfbZxBeti4UaLrM3sF+BJkZn5vZ2f0
 pBp9cYXzlkf7TrSBuQ2D8uH2GLJpf3IZtZ6B+KeHHRb9xMGzdORn6eD8yOAiJwzCk/j6ruxDZNb
 zVcObSCwNdgpeC5NxM2DXU6zDKJs2Eo/gBgG1mgiYipX2+ts7/PVZrG85dowp5oCvG5PvWehtOm
 z5z4i2YvbaDdPWOFOXOLdWmsBhCBbwnVrMZs1sclSz/IiuQHCGmfhXZ8yGj3BIqSpI2wANdBtZn
 FaYpL3w5sdtWNufORY5Jplr6GzSuQ3tLGl1KAsVgxpGuJamM4CyYW4uWWC3+emcLoY9o8YCZWuX
 H3g7bVXnlmfFs3dvDoxgoyeXpXHM7PXuNyF0HgWmBGMO+sG+b9RuTtHHPsjBXAGgo58aGW77F0z
 WsTC4DjipoAJM+100YOloplLaG6kIKXAJ01Ss7fc0JnkbrmyJZm/wyK
X-Received: by 2002:a05:600c:4e86:b0:496:c2fd:1731 with SMTP id
 5b1f17b1804b1-4995e07f47dmr37773825e9.1.1786106284549; 
 Fri, 07 Aug 2026 05:38:04 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:66e6:6f30:5a76:1cc2?
 ([2a01:e0a:106d:1080:66e6:6f30:5a76:1cc2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48002145589sm5983494f8f.1.2026.08.07.05.38.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2026 05:38:04 -0700 (PDT)
Message-ID: <b2dd2649-c45b-4bad-997e-8a4787be6bf1@linaro.org>
Date: Fri, 7 Aug 2026 14:38:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 4/7] interconnect: qcom: Add QCS8300 interconnect driver
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>,
 Casey Connolly <casey.connolly@linaro.org>, Johan Jonker
 <jbx6244@gmail.com>, Luca Weiss <luca.weiss@fairphone.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20260806-b4-monaco-v1-0-8d7b4e2f4fe1@oss.qualcomm.com>
 <20260806-b4-monaco-v1-4-8d7b4e2f4fe1@oss.qualcomm.com>
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
In-Reply-To: <20260806-b4-monaco-v1-4-8d7b4e2f4fe1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786106285; x=1786711085;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1m8+j8Z8URFOZy76gDvdnjCVljozzo9jso5mYZBpor4=;
 b=f+zy8tC4Xd8oSU8oMot0PtIt+WyosNiBTvOea277z3Mh5vmMEy7m1xqWaqwovpvSmL
 mWh9R3X1RkxNhMAiyd7J38AxXJQ+ZKY8iX51t6+IHDic3igEAf45ziot+7LXgEn7c6s0
 UQ4hp9ovdlgAo9FfSi4uBo3KKZlmJLHsYr4rCk6Zgotl3pDJURBXhRYaKRGflIV+YYnJ
 JoFH4jzvD+uBdbZdfr38oFhdTjxZPp8TzjrZqd1T9+H1mBeqHDcGq5mEBZ52cIpSt9JU
 Gwp+PeX6n4ZJsWlDptt3kr9OqlWyish/9szVjUW5LSW8G0/6AKgraWGlHUyxHJSpSjeI
 3ItQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=f+zy8tC4
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 8/6/26 18:12, Balaji Selvanathan wrote:
> Add the interconnect (NoC) driver for QCS8300.
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>   drivers/interconnect/qcom/Kconfig   |   6 +
>   drivers/interconnect/qcom/Makefile  |   1 +
>   drivers/interconnect/qcom/qcs8300.c | 269 ++++++++++++++++++++++++++++++++++++
>   drivers/interconnect/qcom/qcs8300.h |  24 ++++
>   4 files changed, 300 insertions(+)
> 
> diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
> index b105c3a1f9a..906f2fa604a 100644
> --- a/drivers/interconnect/qcom/Kconfig
> +++ b/drivers/interconnect/qcom/Kconfig
> @@ -5,6 +5,12 @@ config INTERCONNECT_QCOM_RPMH
>   	  Enable support for the interconnect helpers to vote with
>   	  the RPMh subsystems in Qualcomm SoCs
>   
> +config INTERCONNECT_QCOM_QCS8300
> +	bool "Enable interconnect support for QCS8300 SoC"
> +	depends on INTERCONNECT_QCOM_RPMH
> +	help
> +	  Enable support for the interconnect driver for the QCS8300 SoC.
> +
>   config INTERCONNECT_QCOM_SM8650
>   	bool "Enable interconnect support for SM8650 SoC"
>   	depends on INTERCONNECT_QCOM_RPMH
> diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
> index a33a65bd82e..6ba69269621 100644
> --- a/drivers/interconnect/qcom/Makefile
> +++ b/drivers/interconnect/qcom/Makefile
> @@ -4,4 +4,5 @@
>   #
>   
>   obj-$(CONFIG_$(PHASE_)INTERCONNECT_QCOM_RPMH) += icc-rpmh.o bcm-voter.o
> +obj-$(CONFIG_$(PHASE_)INTERCONNECT_QCOM_QCS8300) += qcs8300.o
>   obj-$(CONFIG_$(PHASE_)INTERCONNECT_QCOM_SM8650) += sm8650.o
> diff --git a/drivers/interconnect/qcom/qcs8300.c b/drivers/interconnect/qcom/qcs8300.c
> new file mode 100644
> index 00000000000..db5316af2cb
> --- /dev/null
> +++ b/drivers/interconnect/qcom/qcs8300.c
> @@ -0,0 +1,269 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + *
> + */
> +
> +#include <dm.h>
> +#include <interconnect-uclass.h>
> +#include <dt-bindings/interconnect/qcom,qcs8300-rpmh.h>
> +
> +#include "icc-rpmh.h"
> +#include "qcs8300.h"
> +
> +static struct qcom_icc_node xm_ufs_mem = {
> +	.name = "xm_ufs_mem",
> +	.id = QCS8300_MASTER_UFS_MEM,
> +	.channels = 1,
> +	.buswidth = 8,
> +	.num_links = 1,
> +	.links = { QCS8300_SLAVE_A1NOC_SNOC },
> +};
> +
> +static struct qcom_icc_node qns_a1noc_snoc = {
> +	.name = "qns_a1noc_snoc",
> +	.id = QCS8300_SLAVE_A1NOC_SNOC,
> +	.channels = 1,
> +	.buswidth = 32,
> +	.num_links = 1,
> +	.links = { QCS8300_MASTER_A1NOC_SNOC },
> +};
> +
> +static struct qcom_icc_node qnm_aggre1_noc = {
> +	.name = "qnm_aggre1_noc",
> +	.id = QCS8300_MASTER_A1NOC_SNOC,
> +	.channels = 1,
> +	.buswidth = 32,
> +	.num_links = 1,
> +	.links = { QCS8300_SLAVE_SNOC_GEM_NOC_SF },
> +};
> +
> +static struct qcom_icc_node qns_gemnoc_sf = {
> +	.name = "qns_gemnoc_sf",
> +	.id = QCS8300_SLAVE_SNOC_GEM_NOC_SF,
> +	.channels = 1,
> +	.buswidth = 16,
> +	.num_links = 1,
> +	.links = { QCS8300_MASTER_SNOC_SF_MEM_NOC },
> +};
> +
> +static struct qcom_icc_node qnm_snoc_sf = {
> +	.name = "qnm_snoc_sf",
> +	.id = QCS8300_MASTER_SNOC_SF_MEM_NOC,
> +	.channels = 1,
> +	.buswidth = 16,
> +	.num_links = 1,
> +	.links = { QCS8300_SLAVE_LLCC },
> +};
> +
> +static struct qcom_icc_node chm_apps = {
> +	.name = "chm_apps",
> +	.id = QCS8300_MASTER_APPSS_PROC,
> +	.channels = 4,
> +	.buswidth = 32,
> +	.num_links = 1,
> +	.links = { QCS8300_SLAVE_GEM_NOC_CNOC },
> +};
> +
> +static struct qcom_icc_node qns_gem_noc_cnoc = {
> +	.name = "qns_gem_noc_cnoc",
> +	.id = QCS8300_SLAVE_GEM_NOC_CNOC,
> +	.channels = 1,
> +	.buswidth = 16,
> +	.num_links = 1,
> +	.links = { QCS8300_MASTER_GEM_NOC_CNOC },
> +};
> +
> +static struct qcom_icc_node qns_llcc = {
> +	.name = "qns_llcc",
> +	.id = QCS8300_SLAVE_LLCC,
> +	.channels = 4,
> +	.buswidth = 16,
> +	.num_links = 1,
> +	.links = { QCS8300_MASTER_LLCC },
> +};
> +
> +static struct qcom_icc_node llcc_mc = {
> +	.name = "llcc_mc",
> +	.id = QCS8300_MASTER_LLCC,
> +	.channels = 8,
> +	.buswidth = 4,
> +	.num_links = 1,
> +	.links = { QCS8300_SLAVE_EBI1 },
> +};
> +
> +static struct qcom_icc_node ebi = {
> +	.name = "ebi",
> +	.id = QCS8300_SLAVE_EBI1,
> +	.channels = 8,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_node qnm_gemnoc_cnoc = {
> +	.name = "qnm_gemnoc_cnoc",
> +	.id = QCS8300_MASTER_GEM_NOC_CNOC,
> +	.channels = 1,
> +	.buswidth = 16,
> +	.num_links = 1,
> +	.links = { QCS8300_SLAVE_UFS_MEM_CFG },
> +};
> +
> +static struct qcom_icc_node qhs_ufs_mem_cfg = {
> +	.name = "qhs_ufs_mem_cfg",
> +	.id = QCS8300_SLAVE_UFS_MEM_CFG,
> +	.channels = 1,
> +	.buswidth = 4,
> +	.num_links = 0,
> +};
> +
> +static struct qcom_icc_bcm bcm_sn3 = {
> +	.name = "SN3",
> +	.num_nodes = 2,
> +	.nodes = { &qns_a1noc_snoc, &qnm_aggre1_noc },
> +};
> +
> +static struct qcom_icc_bcm bcm_sn0 = {
> +	.name = "SN0",
> +	.keepalive = true,
> +	.num_nodes = 1,
> +	.nodes = { &qns_gemnoc_sf },
> +};
> +
> +static struct qcom_icc_bcm bcm_sh0 = {
> +	.name = "SH0",
> +	.keepalive = true,
> +	.num_nodes = 1,
> +	.nodes = { &qns_llcc },
> +};
> +
> +static struct qcom_icc_bcm bcm_sh2 = {
> +	.name = "SH2",
> +	.num_nodes = 1,
> +	.nodes = { &chm_apps },
> +};
> +
> +static struct qcom_icc_bcm bcm_acv = {
> +	.name = "ACV",
> +	.enable_mask = BIT(3),
> +	.num_nodes = 1,
> +	.nodes = { &ebi },
> +};
> +
> +static struct qcom_icc_bcm bcm_mc0 = {
> +	.name = "MC0",
> +	.keepalive = true,
> +	.num_nodes = 1,
> +	.nodes = { &ebi },
> +};
> +
> +static struct qcom_icc_bcm bcm_cn0 = {
> +	.name = "CN0",
> +	.keepalive = true,
> +	.num_nodes = 1,
> +	.nodes = { &qnm_gemnoc_cnoc },
> +};
> +
> +static struct qcom_icc_bcm * const aggre1_noc_bcms[] = {
> +	&bcm_sn3,
> +};
> +
> +static struct qcom_icc_node * const aggre1_noc_nodes[] = {
> +	[MASTER_UFS_MEM] = &xm_ufs_mem,
> +	[SLAVE_A1NOC_SNOC] = &qns_a1noc_snoc,
> +};
> +
> +static const struct qcom_icc_desc qcs8300_aggre1_noc = {
> +	.nodes = aggre1_noc_nodes,
> +	.num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
> +	.bcms = aggre1_noc_bcms,
> +	.num_bcms = ARRAY_SIZE(aggre1_noc_bcms),
> +};
> +
> +static struct qcom_icc_bcm * const system_noc_bcms[] = {
> +	&bcm_sn0,
> +};
> +
> +static struct qcom_icc_node * const system_noc_nodes[] = {
> +	[MASTER_A1NOC_SNOC] = &qnm_aggre1_noc,
> +	[SLAVE_SNOC_GEM_NOC_SF] = &qns_gemnoc_sf,
> +};
> +
> +static const struct qcom_icc_desc qcs8300_system_noc = {
> +	.nodes = system_noc_nodes,
> +	.num_nodes = ARRAY_SIZE(system_noc_nodes),
> +	.bcms = system_noc_bcms,
> +	.num_bcms = ARRAY_SIZE(system_noc_bcms),
> +};
> +
> +static struct qcom_icc_bcm * const gem_noc_bcms[] = {
> +	&bcm_sh0,
> +	&bcm_sh2,
> +};
> +
> +static struct qcom_icc_node * const gem_noc_nodes[] = {
> +	[MASTER_APPSS_PROC] = &chm_apps,
> +	[MASTER_SNOC_SF_MEM_NOC] = &qnm_snoc_sf,
> +	[SLAVE_GEM_NOC_CNOC] = &qns_gem_noc_cnoc,
> +	[SLAVE_LLCC] = &qns_llcc,
> +};
> +
> +static const struct qcom_icc_desc qcs8300_gem_noc = {
> +	.nodes = gem_noc_nodes,
> +	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
> +	.bcms = gem_noc_bcms,
> +	.num_bcms = ARRAY_SIZE(gem_noc_bcms),
> +};
> +
> +static struct qcom_icc_bcm * const mc_virt_bcms[] = {
> +	&bcm_acv,
> +	&bcm_mc0,
> +};
> +
> +static struct qcom_icc_node * const mc_virt_nodes[] = {
> +	[MASTER_LLCC] = &llcc_mc,
> +	[SLAVE_EBI1] = &ebi,
> +};
> +
> +static const struct qcom_icc_desc qcs8300_mc_virt = {
> +	.nodes = mc_virt_nodes,
> +	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
> +	.bcms = mc_virt_bcms,
> +	.num_bcms = ARRAY_SIZE(mc_virt_bcms),
> +};
> +
> +static struct qcom_icc_bcm * const config_noc_bcms[] = {
> +	&bcm_cn0,
> +};
> +
> +static struct qcom_icc_node * const config_noc_nodes[] = {
> +	[MASTER_GEM_NOC_CNOC] = &qnm_gemnoc_cnoc,
> +	[SLAVE_UFS_MEM_CFG] = &qhs_ufs_mem_cfg,
> +};
> +
> +static const struct qcom_icc_desc qcs8300_config_noc = {
> +	.nodes = config_noc_nodes,
> +	.num_nodes = ARRAY_SIZE(config_noc_nodes),
> +	.bcms = config_noc_bcms,
> +	.num_bcms = ARRAY_SIZE(config_noc_bcms),
> +};
> +
> +static const struct udevice_id qnoc_of_match[] = {
> +	{ .compatible = "qcom,qcs8300-aggre1-noc", .data = (ulong)&qcs8300_aggre1_noc },
> +	{ .compatible = "qcom,qcs8300-system-noc", .data = (ulong)&qcs8300_system_noc },
> +	{ .compatible = "qcom,qcs8300-gem-noc", .data = (ulong)&qcs8300_gem_noc },
> +	{ .compatible = "qcom,qcs8300-mc-virt", .data = (ulong)&qcs8300_mc_virt },
> +	{ .compatible = "qcom,qcs8300-config-noc", .data = (ulong)&qcs8300_config_noc },
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(qnoc_qcs8300) = {
> +	.name = "qnoc-qcs8300",
> +	.id = UCLASS_INTERCONNECT,
> +	.of_match = qnoc_of_match,
> +	.probe = qcom_icc_rpmh_probe,
> +	.bind = qcom_icc_rpmh_bind,
> +	.unbind = qcom_icc_rpmh_unbind,
> +	.ops = &qcom_icc_rpmh_ops,
> +	.plat_auto = sizeof(struct qcom_icc_provider),
> +};
> diff --git a/drivers/interconnect/qcom/qcs8300.h b/drivers/interconnect/qcom/qcs8300.h
> new file mode 100644
> index 00000000000..2dc523d127e
> --- /dev/null
> +++ b/drivers/interconnect/qcom/qcs8300.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * QCS8300 interconnect IDs
> + *
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#ifndef __DRIVERS_INTERCONNECT_QCOM_QCS8300_H
> +#define __DRIVERS_INTERCONNECT_QCOM_QCS8300_H
> +
> +#define QCS8300_MASTER_UFS_MEM			0
> +#define QCS8300_SLAVE_A1NOC_SNOC		1
> +#define QCS8300_MASTER_A1NOC_SNOC		2
> +#define QCS8300_SLAVE_SNOC_GEM_NOC_SF		3
> +#define QCS8300_MASTER_SNOC_SF_MEM_NOC		4
> +#define QCS8300_SLAVE_LLCC			5
> +#define QCS8300_MASTER_APPSS_PROC		6
> +#define QCS8300_SLAVE_GEM_NOC_CNOC		7
> +#define QCS8300_MASTER_GEM_NOC_CNOC		8
> +#define QCS8300_MASTER_LLCC			9
> +#define QCS8300_SLAVE_EBI1			10
> +#define QCS8300_SLAVE_UFS_MEM_CFG		11
> +
> +#endif
> 

Casey: Feel free to pick it

Acked-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
