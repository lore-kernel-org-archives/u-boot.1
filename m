Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC566CCA470
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 09:21:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B54B807C0;
	Wed,  1 Oct 2025 11:21:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mPukSIV3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB9AC81D6A; Wed,  1 Oct 2025 11:21:13 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B08F800B1
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 11:21:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3ee12332f3dso5461015f8f.2
 for <u-boot@lists.denx.de>; Wed, 01 Oct 2025 02:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759310470; x=1759915270; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=FFPY2yi9N+p+gmeGX9REDdV9ugVJBcSaShPpInxU3vg=;
 b=mPukSIV3klhvaxe4g/dr5Y4Bmve4Y1pkQKfXTL2iLqbQz6ythbe06ZvDZofx3jNCGN
 bT1DgP2QYxGkFxBvuz/bbm31SICVkiPRcvt/7pObJHWVVuiKQrcvt/6u35uHTYZ3rp9R
 coBk49XpX0mCBEkOv0lq5ECyFMiTV2j5ncij53XB12w/h2TieTXCr2BYoQDCPoffuMOH
 dUZsjDQZ9rpc3lWRJ+7YyQ1yOkI35mh1PeMf3ICpnUNsXvrYkZIvSBCMmWFf5ZAY6k3X
 f4BodpHBu5Mb/R+qeDxwjSR9DLeg52kWeePSeiIYiXzBWnKSrFo+DNZ64m+Gff2ZowM+
 1WVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759310470; x=1759915270;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=FFPY2yi9N+p+gmeGX9REDdV9ugVJBcSaShPpInxU3vg=;
 b=pc02UY/pbbIPmHI3WZtKz6pj0xRVp3cVcfzN225/q/XrHLi3d6Ma4Mov/HQ0Hm/hh2
 4Px+lObdD/CxxpEG91lOGBltnEA3sVsV0WGTHFNBErUzyshM472VlxHi6eKH8N8WTX6m
 xsOd4QvpUDGyYcssYJ5n2n5P9BlAPgB1l1QdCvZ3WtGYlWwbxC2eLU1+7JwhyjN+Dp4m
 gMdbHIfYNQm9KY0sRO95mbXkMhzH4zlD6rfycmo4K0OJAtFdIKrAfF3Ld60gkeYZS6V7
 3YrOBBMeSpzh4z91DBLj986FKvtgnH39v/D7delo/2tr+9iLz+wsrsND81Ei4+ysd2Oz
 SbVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkgNLkaOgwgXQOX+qpKr0kHzwJG6rRIYBPNLI0cIcATADFMgotZ+wGSfb9KLhs2eut93MfC8I=@lists.denx.de
X-Gm-Message-State: AOJu0YxgHcBkK/3h2IJ+5Being+0VtkHBVfQh1tC+oEgKll4l0IzYs/c
 x7qlIFJF1vyUGevG9FtGnmOetrYJzdvNT2NFjGsihBkHsd4hl2xDMhGlXz6KofCP8EA=
X-Gm-Gg: ASbGncs21PXgPz0g94snuD26c4XoJ5LIFvpp9Si2pkrLIoPXiIVJLBFUF98ol99BFFA
 XXVPF8SPuC1DX1QHJcGgo03xrCMmkHdZOUWvKSDMAKMkIoQaqkGUxLjmrFgpSmWxDP10OtXwKD0
 FyVKfOZ3ghGEQsGxama3l1UMG/uk/FezzbDiXdm8QCfl3tR1jIlDyk/0AWlqFA8coOaRo2teSmd
 Po3Ae17zxO17g7ZFRTKWoF6ZTj5ACaQdAJcbt7eUAT/EXUzaOBZnByj4jQI4iIC3vlEOu20jDEn
 WCGrnNcB4rwsWR9uyD6p3YgD9uAGt2wILWGP8ykZi2lZpuqIJKhiPq1JmvDf4/rnFsU+cMPbSkE
 22o0RbHW3DoAuZIM8fVqmnLkmCgSbyd8/KwWavNQn7NiRUsCxv3k0FPn2ikCUFz3nUnznyQz9+n
 BWcuyfWN2IbyK5SL5fi7PoEfEohEiZqTF4FA==
X-Google-Smtp-Source: AGHT+IFOfD/3OwTeUiCvb6519RUM98GNNj0ObHmEfzpQActHhbiG3lWsXNGjpxC5F6TGTn5nUXJ0rA==
X-Received: by 2002:a05:6000:420a:b0:3da:37de:a3c2 with SMTP id
 ffacd0b85a97d-425577f44cemr1759784f8f.24.1759310470338; 
 Wed, 01 Oct 2025 02:21:10 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:f45f:c590:9006:d394?
 ([2a01:e0a:3d9:2080:f45f:c590:9006:d394])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb985e080sm26113356f8f.24.2025.10.01.02.21.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 02:21:09 -0700 (PDT)
Message-ID: <90c0de06-ca53-4df1-8d9e-fe4415fafdd8@linaro.org>
Date: Wed, 1 Oct 2025 11:21:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v4 2/4] power-domain: Add QCOM RPMH Power Domain Driver
 Support
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>, trini@konsulko.com,
 casey.connolly@linaro.org, sumit.garg@kernel.org, jh80.chung@samsung.com,
 rui.silva@linaro.org, ilias.apalodimas@linaro.org,
 christopher.obbard@linaro.org, me@samcday.com, quic_varada@quicinc.com,
 marek.vasut+renesas@mailbox.org, sughosh.ganu@linaro.org,
 miquel.raynal@bootlin.com, balaji.selvanathan@oss.qualcomm.com,
 sjg@chromium.org, u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250711143851.1490617-1-aswin.murugan@oss.qualcomm.com>
 <20250711143851.1490617-3-aswin.murugan@oss.qualcomm.com>
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
In-Reply-To: <20250711143851.1490617-3-aswin.murugan@oss.qualcomm.com>
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

On 7/11/25 16:38, Aswin Murugan wrote:
> Added support for Qualcomm RPMH power domain driver, responsible
> for managing power domains on Qualcomm SoCs. This is a port of
> the Linux RPMHPD driver [1] and sa8775p related changes. The
> power domain driver currently has support to power on and off
> MMCX power domain of sa8775p; support for other soc entries power
> domains are stubbed, in future, the required soc support can be
> added.
> 
> [1]:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pmdomain/qcom/rpmhpd.c?id=3d25d46a255a83f94d7d4d4216f38aafc8e116b
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
> v4:
> - Added all SoC entries from the Linux driver and stubbed it
> - Removed "qcom_rpmhpd" driver
> - Removed unused members in struct rpmhpd
> 
> v3:
> - No changes to this patch in v3
> 
> v2:
> - Added ARCH_SNAPDRAGON dependency to QCOM_POWER_DOMAIN Kconfig
> - In qcom-rpmhpd driver, the un-supported power domains are handled with warning
> ---
>   drivers/power/domain/Kconfig       |   8 +
>   drivers/power/domain/Makefile      |   1 +
>   drivers/power/domain/qcom-rpmhpd.c | 278 +++++++++++++++++++++++++++++
>   3 files changed, 287 insertions(+)
>   create mode 100644 drivers/power/domain/qcom-rpmhpd.c
> 
> diff --git a/drivers/power/domain/Kconfig b/drivers/power/domain/Kconfig
> index 5f5218bd8b5..1456df96cd1 100644
> --- a/drivers/power/domain/Kconfig
> +++ b/drivers/power/domain/Kconfig
> @@ -82,6 +82,14 @@ config MESON_SECURE_POWER_DOMAIN
>   	  Enable support for manipulating Amlogic Meson Secure power domains.
>   	  Support for Amlogic A1 series.
>   
> +config QCOM_POWER_DOMAIN
> +	bool "Enable the QCOM RPMH Power domain driver"
> +	depends on POWER_DOMAIN && ARCH_SNAPDRAGON
> +	help
> +	  Generic RPMH power domain implementation for QCOM devices.
> +	  The RPMH power domain driver is responsible for managing power
> +	  domains on Qualcomm SoCs.
> +
>   config SANDBOX_POWER_DOMAIN
>   	bool "Enable the sandbox power domain test driver"
>   	depends on POWER_DOMAIN && SANDBOX
> diff --git a/drivers/power/domain/Makefile b/drivers/power/domain/Makefile
> index 4d20c97d26c..950f83972dc 100644
> --- a/drivers/power/domain/Makefile
> +++ b/drivers/power/domain/Makefile
> @@ -21,3 +21,4 @@ obj-$(CONFIG_TEGRA186_POWER_DOMAIN) += tegra186-power-domain.o
>   obj-$(CONFIG_TI_SCI_POWER_DOMAIN) += ti-sci-power-domain.o
>   obj-$(CONFIG_TI_POWER_DOMAIN) += ti-power-domain.o
>   obj-$(CONFIG_ZYNQMP_POWER_DOMAIN) += zynqmp-power-domain.o
> +obj-$(CONFIG_QCOM_POWER_DOMAIN) += qcom-rpmhpd.o
> diff --git a/drivers/power/domain/qcom-rpmhpd.c b/drivers/power/domain/qcom-rpmhpd.c
> new file mode 100644
> index 00000000000..906af2aa0ba
> --- /dev/null
> +++ b/drivers/power/domain/qcom-rpmhpd.c
> @@ -0,0 +1,278 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2018, The Linux Foundation. All rights reserved.
> +// Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
> +
> +#include <dm.h>
> +#include <dm/lists.h>
> +#include <power-domain.h>
> +#include <asm/io.h>
> +#include <linux/errno.h>
> +
> +#include <power-domain-uclass.h>
> +#include <soc/qcom/cmd-db.h>
> +#include <soc/qcom/rpmh.h>
> +#include <dt-bindings/power/qcom-rpmpd.h>
> +#include <dm/device_compat.h>
> +
> +#define RPMH_ARC_MAX_LEVELS	16
> +
> +/**
> + * struct rpmhpd - top level RPMh power domain resource data structure
> + * @dev:                rpmh power domain controller device
> + * @pd:                 generic_pm_domain corresponding to the power domain
> + * @parent:             generic_pm_domain corresponding to the parent's power domain
> + * @enable_corner:      lowest non-zero corner
> + * @level:              An array of level (vlvl) to corner (hlvl) mappings
> + *                      derived from cmd-db
> + * @level_count:        Number of levels supported by the power domain. max
> + *                      being 16 (0 - 15)
> + * @enabled:            true if the power domain is enabled
> + * @res_name:           Resource name used for cmd-db lookup
> + * @addr:               Resource address as looped up using resource name from
> + * @skip_retention_level: Indicate that retention level should not be used for the power domain
> + */
> +struct rpmhpd {
> +	struct udevice	*dev;
> +	struct power_domain pd;
> +	struct power_domain *parent;
> +	unsigned int	enable_corner;
> +	u32		level[RPMH_ARC_MAX_LEVELS];
> +	size_t		level_count;
> +	bool		enabled;
> +	const char	*res_name;
> +	u32		addr;
> +	bool		skip_retention_level;
> +};
> +
> +struct rpmhpd_desc {
> +	struct rpmhpd **rpmhpds;
> +	size_t num_pds;
> +};
> +
> +/* RPMH powerdomains */
> +static struct rpmhpd mmcx_ao;
> +static struct rpmhpd mmcx = {
> +	.res_name = "mmcx.lvl",
> +};
> +
> +static struct rpmhpd mmcx_ao = {
> +	.res_name = "mmcx.lvl",
> +};
> +
> +/* SA8775P RPMH power domains */
> +static struct rpmhpd *sa8775p_rpmhpds[] = {
> +	[SA8775P_MMCX] = &mmcx,
> +	[SA8775P_MMCX_AO] = &mmcx_ao,
> +};
> +
> +static const struct rpmhpd_desc sa8775p_desc = {
> +	.rpmhpds = sa8775p_rpmhpds,
> +	.num_pds = ARRAY_SIZE(sa8775p_rpmhpds),
> +};
> +
> +/* stub RPMH power domains mapped for unsupported platforms */
> +static struct rpmhpd *stub_rpmhpds[] = {};
> +
> +static const struct rpmhpd_desc stub_desc = {
> +	.rpmhpds = stub_rpmhpds,
> +	.num_pds = ARRAY_SIZE(stub_rpmhpds),
> +};
> +
> +static const struct udevice_id rpmhpd_match_table[] = {
> +	{ .compatible = "qcom,sa8775p-rpmhpd", .data = (ulong)&sa8775p_desc },
> +	{ .compatible = "qcom,qcs615-rpmhpd", .data = &stub_desc },
> +	{ .compatible = "qcom,qcs8300-rpmhpd", .data = &stub_desc },
> +	{ .compatible = "qcom,qdu1000-rpmhpd", .data = &stub_desc },
> +	{ .compatible = "qcom,sa8155p-rpmhpd", .data = &stub_desc },
> +	{ .compatible = "qcom,sa8540p-rpmhpd", .data = &stub_desc },
> +	{ .compatible = "qcom,sar2130p-rpmhpd", .data = &stub_desc},
> +	{ .compatible = "qcom,sc7180-rpmhpd", .data = &stub_desc },
> +	{ .compatible = "qcom,sc7280-rpmhpd", .data = &stub_desc },
> +	{ .compatible = "qcom,sc8180x-rpmhpd", .data = &stub_desc },
> +	{ .compatible = "qcom,sc8280xp-rpmhpd", .data = &stub_desc },
> +	{ .compatible = "qcom,sdm670-rpmhpd", .data = &stub_desc },
> +	{ .compatible = "qcom,sdm845-rpmhpd", .data = &stub_desc },
> +	{ .compatible = "qcom,sdx55-rpmhpd", .data = &stub_desc},
> +	{ .compatible = "qcom,sdx65-rpmhpd", .data = &stub_desc},
> +	{ .compatible = "qcom,sdx75-rpmhpd", .data = &stub_desc},
> +	{ .compatible = "qcom,sm4450-rpmhpd", .data = &stub_desc},
> +	{ .compatible = "qcom,sm6350-rpmhpd", .data = &stub_desc },
> +	{ .compatible = "qcom,sm7150-rpmhpd", .data = &stub_desc },
> +	{ .compatible = "qcom,sm8150-rpmhpd", .data = &stub_desc },
> +	{ .compatible = "qcom,sm8250-rpmhpd", .data = &stub_desc },
> +	{ .compatible = "qcom,sm8350-rpmhpd", .data = &stub_desc },
> +	{ .compatible = "qcom,sm8450-rpmhpd", .data = &stub_desc },
> +	{ .compatible = "qcom,sm8550-rpmhpd", .data = &stub_desc },
> +	{ .compatible = "qcom,sm8650-rpmhpd", .data = &stub_desc },
> +	{ .compatible = "qcom,sm8750-rpmhpd", .data = &stub_desc },
> +	{ .compatible = "qcom,x1e80100-rpmhpd", .data = &stub_desc },
> +	{ }
> +};
> +
> +static int rpmhpd_send_corner(struct rpmhpd *pd, int state,
> +			      unsigned int corner, bool sync)
> +{
> +	struct tcs_cmd cmd = {
> +		.addr = pd->addr,
> +		.data = corner,
> +	};
> +
> +	return rpmh_write(pd->dev->parent, state, &cmd, 1);


This is wrong, it shoudl be rpmh_write(pd, state, &cmd, 1),
since rpmh_write gets the parent in get_rpmh_ctrlr().

Neil

> +}
> +
> +static int rpmhpd_power_on(struct power_domain *pd)
> +{
> +	int ret;
> +	unsigned int corner;
> +	struct rpmhpd **rpmhpds;
> +	const struct rpmhpd_desc *desc;
> +	struct rpmhpd *curr_rpmhpd;
> +
> +	desc = (const struct rpmhpd_desc *)dev_get_driver_data(pd->dev);
> +	if (!desc)
> +		return -EINVAL;
> +
> +	rpmhpds = desc->rpmhpds;
> +	curr_rpmhpd = rpmhpds[pd->id];
> +
> +	/* Do nothing for undefined power domains */
> +	if (!curr_rpmhpd) {
> +		log_warning("Power domain id (%d) not supported\n",
> +			    pd->id);
> +		return 0;
> +	}
> +
> +	corner = curr_rpmhpd->enable_corner;
> +
> +	ret = rpmhpd_send_corner(curr_rpmhpd, RPMH_ACTIVE_ONLY_STATE, corner,
> +				 false);
> +	if (!ret)
> +		curr_rpmhpd->enabled = true;
> +
> +	return ret;
> +}
> +
> +static int rpmhpd_power_off(struct power_domain *pd)
> +{
> +	int ret;
> +	unsigned int corner;
> +	struct rpmhpd **rpmhpds;
> +	const struct rpmhpd_desc *desc;
> +	struct rpmhpd *curr_rpmhpd;
> +
> +	desc = (const struct rpmhpd_desc *)dev_get_driver_data(pd->dev);
> +	if (!desc)
> +		return -EINVAL;
> +
> +	rpmhpds = desc->rpmhpds;
> +	curr_rpmhpd = rpmhpds[pd->id];
> +
> +	/* Do nothing for undefined power domains */
> +	if (!curr_rpmhpd) {
> +		log_warning("Power domain id (%d) not supported\n",
> +			    pd->id, 0);
> +		return 0;
> +	}
> +
> +	corner = 0;
> +
> +	ret = rpmhpd_send_corner(curr_rpmhpd, RPMH_ACTIVE_ONLY_STATE, corner,
> +				 false);
> +	if (!ret)
> +		curr_rpmhpd->enabled = false;
> +
> +	return ret;
> +}
> +
> +static int rpmhpd_update_level_mapping(struct rpmhpd *rpmhpd)
> +{
> +	int i;
> +	const u16 *buf;
> +
> +	buf = cmd_db_read_aux_data(rpmhpd->res_name, &rpmhpd->level_count);
> +	if (IS_ERR(buf))
> +		return PTR_ERR(buf);
> +
> +	/* 2 bytes used for each command DB aux data entry */
> +	rpmhpd->level_count >>= 1;
> +
> +	if (rpmhpd->level_count > RPMH_ARC_MAX_LEVELS)
> +		return -EINVAL;
> +
> +	for (i = 0; i < rpmhpd->level_count; i++) {
> +		if (rpmhpd->skip_retention_level && buf[i] == RPMH_REGULATOR_LEVEL_RETENTION)
> +			continue;
> +
> +		rpmhpd->level[i] = buf[i];
> +
> +		/* Remember the first corner with non-zero level */
> +		if (!rpmhpd->level[rpmhpd->enable_corner] && rpmhpd->level[i])
> +			rpmhpd->enable_corner = i;
> +
> +		/*
> +		 * The AUX data may be zero padded. These 0 valued entries at
> +		 * the end of the map must be ignored.
> +		 */
> +		if (i > 0 && rpmhpd->level[i] == 0) {
> +			rpmhpd->level_count = i;
> +			break;
> +		}
> +		debug("%s: ARC hlvl=%2d --> vlvl=%4u\n", rpmhpd->res_name, i,
> +		      rpmhpd->level[i]);
> +	}
> +
> +	return 0;
> +}
> +
> +static int rpmhpd_probe(struct udevice *dev)
> +{
> +	int i, ret;
> +	struct rpmhpd **rpmhpds;
> +	struct rpmhpd *priv;
> +	const struct rpmhpd_desc *desc;
> +
> +	desc = (const struct rpmhpd_desc *)dev_get_driver_data(dev);
> +	if (!desc)
> +		return -EINVAL;
> +
> +	rpmhpds = desc->rpmhpds;
> +
> +	for (i = 0; i < desc->num_pds; i++) {
> +		if (!rpmhpds[i])
> +			continue;
> +
> +		priv = rpmhpds[i];
> +		priv->dev = dev;
> +		priv->addr = cmd_db_read_addr(priv->res_name);
> +		if (!priv->addr) {
> +			dev_err(dev, "Could not find RPMh address for resource %s\n",
> +				priv->res_name);
> +			return -ENODEV;
> +		}
> +
> +		ret = cmd_db_read_slave_id(priv->res_name);
> +		if (ret != CMD_DB_HW_ARC) {
> +			dev_err(dev, "RPMh slave ID mismatch\n");
> +			return -EINVAL;
> +		}
> +
> +		ret = rpmhpd_update_level_mapping(priv);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct power_domain_ops qcom_rpmhpd_power_ops = {
> +	.on = rpmhpd_power_on,
> +	.off = rpmhpd_power_off,
> +};
> +
> +U_BOOT_DRIVER(qcom_rpmhpd_drv) = {
> +	.name = "qcom_rpmhpd_drv",
> +	.id = UCLASS_POWER_DOMAIN,
> +	.of_match = rpmhpd_match_table,
> +	.probe = rpmhpd_probe,
> +	.ops = &qcom_rpmhpd_power_ops,
> +};

