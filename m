Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B33CCA471
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 11:37:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F45F836C1;
	Fri,  3 Oct 2025 13:37:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ePrQwIvD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4005E836C8; Fri,  3 Oct 2025 13:37:32 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46EC3836B4
 for <u-boot@lists.denx.de>; Fri,  3 Oct 2025 13:37:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-46e29d65728so12539195e9.3
 for <u-boot@lists.denx.de>; Fri, 03 Oct 2025 04:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759491448; x=1760096248; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=qAaJmGeeiKejemYWNhIeBdatrLjH4HfNoNXKUkzhs8k=;
 b=ePrQwIvDr+d1ucbsa6HXK2zjfIUgx/YUIsDwgXLOZVVeFfooGhppfZGgFbO+PMtFJq
 DodGugsRv/+325+A+jCKuuCnTh0RlW9S/EN0K8jGO5xbfxMpp1ziivcHKHG/xcRUXF66
 vJLoGicyTq7e1NOTFM2rGFrotKKX1hLYnS57FYL1H9EY29nQeUIcyh2T9k/c6PTi9SVX
 xyGvoIMZBtQRkpD5rCCtsstID/9pcNa48iPjFhDH5wY6o4YuRBFb3K/Itayic7GuqC0p
 AAdAHCT+vFga/Xt2w1cMTyHbiu3ytAw1L7/RFUq5d1fCu6XpvVsyfm7lQVPMiuMK1jRw
 OqZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759491448; x=1760096248;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=qAaJmGeeiKejemYWNhIeBdatrLjH4HfNoNXKUkzhs8k=;
 b=KprOkVm0YiM1yRjwrb6WUAtRJQz4R9DVlQ2IPUS+bYBd4vkdNyf1ppvepNDWHKKKkG
 A590pmY8bb6uuk7Xr58Kq4QYgeY4c17k5IIr+BEvjcLCnJusKyOp/U6x8rHbsTjEIfn1
 yOIojs06xR2d4azLKb+bEqqxQ3VNPLIvGvpCRYYUrdcgq/klaUTpL8CvbyewruGgl1U6
 yyl0TneP0Ofu2pHgyLH2h0vtakp5rAgSz5AHgPlqDAdFeSPG7Blf5EfowzDhwOw/NMpU
 ib6Ur4ku7ZUBP/csEnPrG9CbEURcZm5gBn7Gw4Ikwh/iCy1dRhM/sCPc3G1C9k9nGaPd
 BeeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQGt0Dg6mbmcXBtAAd1g+l3GPAhy88lgQOP1NaU52ToceIRpAuHCwZsLa42pkRIaTjgiPmnQA=@lists.denx.de
X-Gm-Message-State: AOJu0Yyk5/IwrUpIgQK1zlnQ0PqrYxQPd06F6Ze+zxG3vivfC9LtN8TO
 pmK3sFVgDF+S3WW3bWCqkm7St/KxMuNiMFIEMkEhOLRsnqyYXZoQ3IK07tKyCsUDiSQ=
X-Gm-Gg: ASbGnct7NZxK9pWQQdabcZCB9V+n1v9a27opzP+16ZPag9qrvdmeC7C/djynGPjF9QE
 BqarlVVy3Lld/Z10OzCEa2RX1Qc+/XMW0IW1cHRGmYB3YK6xVPOt2Ggmm3oEc/ZyXaCIU2UCNXf
 H8588u8YxZ6QfKHUo36qXPpnRbpS5vRp0iraktKeL3ftKsUrBJbigrrTHHFCq6pz68sjnqmvl6U
 4DQsDp7eHBALQXacI+2W8ljuYnaur8+tRROKUAwqfsfhA36E5Al9leRLZZ7Z+TxbXrueTJ3BT+O
 jZl9v1mVqEWcWdXkUd7Unf0CtFlQ+yTrksrg2gfgARn5j5Tjq1FaA+7cPaSs3z5HUve2cRrU6Z9
 rDzUFkPlGmfrNPWajPn0Bf2AX2nTW3i7DnlfVLOvFl/riVj1tqZy1XgDQMCKDcgcYFg1AYJizw3
 2HuRb6phkF7Rjc859U8IlVNt6JlOo8BOjK5NgaCQ==
X-Google-Smtp-Source: AGHT+IFcY6HP4ehb0QYy92W+NHSO3iAe0m30P6YdHfqeglTJK4nn8cTd2UlRDGkWXqTmWR6X7zgdVA==
X-Received: by 2002:a05:600c:83c4:b0:46e:3f75:da49 with SMTP id
 5b1f17b1804b1-46e71172a04mr19634905e9.37.1759491448307; 
 Fri, 03 Oct 2025 04:37:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:1516:b5be:def8:9a0b?
 ([2a01:e0a:3d9:2080:1516:b5be:def8:9a0b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e7236267bsm28881945e9.16.2025.10.03.04.37.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Oct 2025 04:37:27 -0700 (PDT)
Message-ID: <fd613b53-2681-4db6-a44c-85c076ddc322@linaro.org>
Date: Fri, 3 Oct 2025 13:37:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v4 2/4] power-domain: Add QCOM RPMH Power Domain Driver
 Support
To: u-boot-qcom@groups.io, Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 trini@konsulko.com, casey.connolly@linaro.org, sumit.garg@kernel.org,
 jh80.chung@samsung.com, rui.silva@linaro.org, ilias.apalodimas@linaro.org,
 christopher.obbard@linaro.org, me@samcday.com, quic_varada@quicinc.com,
 marek.vasut+renesas@mailbox.org, sughosh.ganu@linaro.org,
 miquel.raynal@bootlin.com, balaji.selvanathan@oss.qualcomm.com,
 sjg@chromium.org, u-boot@lists.denx.de
References: <20250711143851.1490617-1-aswin.murugan@oss.qualcomm.com>
 <20250711143851.1490617-3-aswin.murugan@oss.qualcomm.com>
 <186A538DC06C545F.26372@groups.io>
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
In-Reply-To: <186A538DC06C545F.26372@groups.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 10/1/25 11:21, Neil Armstrong via groups.io wrote:
> On 7/11/25 16:38, Aswin Murugan wrote:
>> Added support for Qualcomm RPMH power domain driver, responsible
>> for managing power domains on Qualcomm SoCs. This is a port of
>> the Linux RPMHPD driver [1] and sa8775p related changes. The
>> power domain driver currently has support to power on and off
>> MMCX power domain of sa8775p; support for other soc entries power
>> domains are stubbed, in future, the required soc support can be
>> added.
>>
>> [1]:
>> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pmdomain/qcom/rpmhpd.c?id=3d25d46a255a83f94d7d4d4216f38aafc8e116b
>>
>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
>> ---
>> v4:
>> - Added all SoC entries from the Linux driver and stubbed it
>> - Removed "qcom_rpmhpd" driver
>> - Removed unused members in struct rpmhpd
>>
>> v3:
>> - No changes to this patch in v3
>>
>> v2:
>> - Added ARCH_SNAPDRAGON dependency to QCOM_POWER_DOMAIN Kconfig
>> - In qcom-rpmhpd driver, the un-supported power domains are handled with warning
>> ---
>>   drivers/power/domain/Kconfig       |   8 +
>>   drivers/power/domain/Makefile      |   1 +
>>   drivers/power/domain/qcom-rpmhpd.c | 278 +++++++++++++++++++++++++++++
>>   3 files changed, 287 insertions(+)
>>   create mode 100644 drivers/power/domain/qcom-rpmhpd.c
>>
>> diff --git a/drivers/power/domain/Kconfig b/drivers/power/domain/Kconfig
>> index 5f5218bd8b5..1456df96cd1 100644
>> --- a/drivers/power/domain/Kconfig
>> +++ b/drivers/power/domain/Kconfig
>> @@ -82,6 +82,14 @@ config MESON_SECURE_POWER_DOMAIN
>>         Enable support for manipulating Amlogic Meson Secure power domains.
>>         Support for Amlogic A1 series.
>> +config QCOM_POWER_DOMAIN
>> +    bool "Enable the QCOM RPMH Power domain driver"
>> +    depends on POWER_DOMAIN && ARCH_SNAPDRAGON
>> +    help
>> +      Generic RPMH power domain implementation for QCOM devices.
>> +      The RPMH power domain driver is responsible for managing power
>> +      domains on Qualcomm SoCs.
>> +
>>   config SANDBOX_POWER_DOMAIN
>>       bool "Enable the sandbox power domain test driver"
>>       depends on POWER_DOMAIN && SANDBOX
>> diff --git a/drivers/power/domain/Makefile b/drivers/power/domain/Makefile
>> index 4d20c97d26c..950f83972dc 100644
>> --- a/drivers/power/domain/Makefile
>> +++ b/drivers/power/domain/Makefile
>> @@ -21,3 +21,4 @@ obj-$(CONFIG_TEGRA186_POWER_DOMAIN) += tegra186-power-domain.o
>>   obj-$(CONFIG_TI_SCI_POWER_DOMAIN) += ti-sci-power-domain.o
>>   obj-$(CONFIG_TI_POWER_DOMAIN) += ti-power-domain.o
>>   obj-$(CONFIG_ZYNQMP_POWER_DOMAIN) += zynqmp-power-domain.o
>> +obj-$(CONFIG_QCOM_POWER_DOMAIN) += qcom-rpmhpd.o
>> diff --git a/drivers/power/domain/qcom-rpmhpd.c b/drivers/power/domain/qcom-rpmhpd.c
>> new file mode 100644
>> index 00000000000..906af2aa0ba
>> --- /dev/null
>> +++ b/drivers/power/domain/qcom-rpmhpd.c
>> @@ -0,0 +1,278 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// Copyright (c) 2018, The Linux Foundation. All rights reserved.
>> +// Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
>> +
>> +#include <dm.h>
>> +#include <dm/lists.h>
>> +#include <power-domain.h>
>> +#include <asm/io.h>
>> +#include <linux/errno.h>
>> +
>> +#include <power-domain-uclass.h>
>> +#include <soc/qcom/cmd-db.h>
>> +#include <soc/qcom/rpmh.h>
>> +#include <dt-bindings/power/qcom-rpmpd.h>
>> +#include <dm/device_compat.h>
>> +
>> +#define RPMH_ARC_MAX_LEVELS    16
>> +
>> +/**
>> + * struct rpmhpd - top level RPMh power domain resource data structure
>> + * @dev:                rpmh power domain controller device
>> + * @pd:                 generic_pm_domain corresponding to the power domain
>> + * @parent:             generic_pm_domain corresponding to the parent's power domain
>> + * @enable_corner:      lowest non-zero corner
>> + * @level:              An array of level (vlvl) to corner (hlvl) mappings
>> + *                      derived from cmd-db
>> + * @level_count:        Number of levels supported by the power domain. max
>> + *                      being 16 (0 - 15)
>> + * @enabled:            true if the power domain is enabled
>> + * @res_name:           Resource name used for cmd-db lookup
>> + * @addr:               Resource address as looped up using resource name from
>> + * @skip_retention_level: Indicate that retention level should not be used for the power domain
>> + */
>> +struct rpmhpd {
>> +    struct udevice    *dev;
>> +    struct power_domain pd;
>> +    struct power_domain *parent;
>> +    unsigned int    enable_corner;
>> +    u32        level[RPMH_ARC_MAX_LEVELS];
>> +    size_t        level_count;
>> +    bool        enabled;
>> +    const char    *res_name;
>> +    u32        addr;
>> +    bool        skip_retention_level;
>> +};
>> +
>> +struct rpmhpd_desc {
>> +    struct rpmhpd **rpmhpds;
>> +    size_t num_pds;
>> +};
>> +
>> +/* RPMH powerdomains */
>> +static struct rpmhpd mmcx_ao;
>> +static struct rpmhpd mmcx = {
>> +    .res_name = "mmcx.lvl",
>> +};
>> +
>> +static struct rpmhpd mmcx_ao = {
>> +    .res_name = "mmcx.lvl",
>> +};
>> +
>> +/* SA8775P RPMH power domains */
>> +static struct rpmhpd *sa8775p_rpmhpds[] = {
>> +    [SA8775P_MMCX] = &mmcx,
>> +    [SA8775P_MMCX_AO] = &mmcx_ao,
>> +};
>> +
>> +static const struct rpmhpd_desc sa8775p_desc = {
>> +    .rpmhpds = sa8775p_rpmhpds,
>> +    .num_pds = ARRAY_SIZE(sa8775p_rpmhpds),
>> +};
>> +
>> +/* stub RPMH power domains mapped for unsupported platforms */
>> +static struct rpmhpd *stub_rpmhpds[] = {};
>> +
>> +static const struct rpmhpd_desc stub_desc = {
>> +    .rpmhpds = stub_rpmhpds,
>> +    .num_pds = ARRAY_SIZE(stub_rpmhpds),
>> +};
>> +
>> +static const struct udevice_id rpmhpd_match_table[] = {
>> +    { .compatible = "qcom,sa8775p-rpmhpd", .data = (ulong)&sa8775p_desc },
>> +    { .compatible = "qcom,qcs615-rpmhpd", .data = &stub_desc },
>> +    { .compatible = "qcom,qcs8300-rpmhpd", .data = &stub_desc },
>> +    { .compatible = "qcom,qdu1000-rpmhpd", .data = &stub_desc },
>> +    { .compatible = "qcom,sa8155p-rpmhpd", .data = &stub_desc },
>> +    { .compatible = "qcom,sa8540p-rpmhpd", .data = &stub_desc },
>> +    { .compatible = "qcom,sar2130p-rpmhpd", .data = &stub_desc},
>> +    { .compatible = "qcom,sc7180-rpmhpd", .data = &stub_desc },
>> +    { .compatible = "qcom,sc7280-rpmhpd", .data = &stub_desc },
>> +    { .compatible = "qcom,sc8180x-rpmhpd", .data = &stub_desc },
>> +    { .compatible = "qcom,sc8280xp-rpmhpd", .data = &stub_desc },
>> +    { .compatible = "qcom,sdm670-rpmhpd", .data = &stub_desc },
>> +    { .compatible = "qcom,sdm845-rpmhpd", .data = &stub_desc },
>> +    { .compatible = "qcom,sdx55-rpmhpd", .data = &stub_desc},
>> +    { .compatible = "qcom,sdx65-rpmhpd", .data = &stub_desc},
>> +    { .compatible = "qcom,sdx75-rpmhpd", .data = &stub_desc},
>> +    { .compatible = "qcom,sm4450-rpmhpd", .data = &stub_desc},
>> +    { .compatible = "qcom,sm6350-rpmhpd", .data = &stub_desc },
>> +    { .compatible = "qcom,sm7150-rpmhpd", .data = &stub_desc },
>> +    { .compatible = "qcom,sm8150-rpmhpd", .data = &stub_desc },
>> +    { .compatible = "qcom,sm8250-rpmhpd", .data = &stub_desc },
>> +    { .compatible = "qcom,sm8350-rpmhpd", .data = &stub_desc },
>> +    { .compatible = "qcom,sm8450-rpmhpd", .data = &stub_desc },
>> +    { .compatible = "qcom,sm8550-rpmhpd", .data = &stub_desc },
>> +    { .compatible = "qcom,sm8650-rpmhpd", .data = &stub_desc },
>> +    { .compatible = "qcom,sm8750-rpmhpd", .data = &stub_desc },
>> +    { .compatible = "qcom,x1e80100-rpmhpd", .data = &stub_desc },

All those are missing ulong) casting, please re-spin by fixing all the warnings
and test it correctly.

Thanks,
Neil


>> +    { }
>> +};
>> +
>> +static int rpmhpd_send_corner(struct rpmhpd *pd, int state,
>> +                  unsigned int corner, bool sync)
>> +{
>> +    struct tcs_cmd cmd = {
>> +        .addr = pd->addr,
>> +        .data = corner,
>> +    };
>> +
>> +    return rpmh_write(pd->dev->parent, state, &cmd, 1);
> 
> 
> This is wrong, it shoudl be rpmh_write(pd, state, &cmd, 1),
> since rpmh_write gets the parent in get_rpmh_ctrlr().
> 
> Neil
> 
>> +}
>> +
>> +static int rpmhpd_power_on(struct power_domain *pd)
>> +{
>> +    int ret;
>> +    unsigned int corner;
>> +    struct rpmhpd **rpmhpds;
>> +    const struct rpmhpd_desc *desc;
>> +    struct rpmhpd *curr_rpmhpd;
>> +
>> +    desc = (const struct rpmhpd_desc *)dev_get_driver_data(pd->dev);
>> +    if (!desc)
>> +        return -EINVAL;
>> +
>> +    rpmhpds = desc->rpmhpds;
>> +    curr_rpmhpd = rpmhpds[pd->id];
>> +
>> +    /* Do nothing for undefined power domains */
>> +    if (!curr_rpmhpd) {
>> +        log_warning("Power domain id (%d) not supported\n",
>> +                pd->id);
>> +        return 0;
>> +    }
>> +
>> +    corner = curr_rpmhpd->enable_corner;
>> +
>> +    ret = rpmhpd_send_corner(curr_rpmhpd, RPMH_ACTIVE_ONLY_STATE, corner,
>> +                 false);
>> +    if (!ret)
>> +        curr_rpmhpd->enabled = true;
>> +
>> +    return ret;
>> +}
>> +
>> +static int rpmhpd_power_off(struct power_domain *pd)
>> +{
>> +    int ret;
>> +    unsigned int corner;
>> +    struct rpmhpd **rpmhpds;
>> +    const struct rpmhpd_desc *desc;
>> +    struct rpmhpd *curr_rpmhpd;
>> +
>> +    desc = (const struct rpmhpd_desc *)dev_get_driver_data(pd->dev);
>> +    if (!desc)
>> +        return -EINVAL;
>> +
>> +    rpmhpds = desc->rpmhpds;
>> +    curr_rpmhpd = rpmhpds[pd->id];
>> +
>> +    /* Do nothing for undefined power domains */
>> +    if (!curr_rpmhpd) {
>> +        log_warning("Power domain id (%d) not supported\n",
>> +                pd->id, 0);
>> +        return 0;
>> +    }
>> +
>> +    corner = 0;
>> +
>> +    ret = rpmhpd_send_corner(curr_rpmhpd, RPMH_ACTIVE_ONLY_STATE, corner,
>> +                 false);
>> +    if (!ret)
>> +        curr_rpmhpd->enabled = false;
>> +
>> +    return ret;
>> +}
>> +
>> +static int rpmhpd_update_level_mapping(struct rpmhpd *rpmhpd)
>> +{
>> +    int i;
>> +    const u16 *buf;
>> +
>> +    buf = cmd_db_read_aux_data(rpmhpd->res_name, &rpmhpd->level_count);
>> +    if (IS_ERR(buf))
>> +        return PTR_ERR(buf);
>> +
>> +    /* 2 bytes used for each command DB aux data entry */
>> +    rpmhpd->level_count >>= 1;
>> +
>> +    if (rpmhpd->level_count > RPMH_ARC_MAX_LEVELS)
>> +        return -EINVAL;
>> +
>> +    for (i = 0; i < rpmhpd->level_count; i++) {
>> +        if (rpmhpd->skip_retention_level && buf[i] == RPMH_REGULATOR_LEVEL_RETENTION)
>> +            continue;
>> +
>> +        rpmhpd->level[i] = buf[i];
>> +
>> +        /* Remember the first corner with non-zero level */
>> +        if (!rpmhpd->level[rpmhpd->enable_corner] && rpmhpd->level[i])
>> +            rpmhpd->enable_corner = i;
>> +
>> +        /*
>> +         * The AUX data may be zero padded. These 0 valued entries at
>> +         * the end of the map must be ignored.
>> +         */
>> +        if (i > 0 && rpmhpd->level[i] == 0) {
>> +            rpmhpd->level_count = i;
>> +            break;
>> +        }
>> +        debug("%s: ARC hlvl=%2d --> vlvl=%4u\n", rpmhpd->res_name, i,
>> +              rpmhpd->level[i]);
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static int rpmhpd_probe(struct udevice *dev)
>> +{
>> +    int i, ret;
>> +    struct rpmhpd **rpmhpds;
>> +    struct rpmhpd *priv;
>> +    const struct rpmhpd_desc *desc;
>> +
>> +    desc = (const struct rpmhpd_desc *)dev_get_driver_data(dev);
>> +    if (!desc)
>> +        return -EINVAL;
>> +
>> +    rpmhpds = desc->rpmhpds;
>> +
>> +    for (i = 0; i < desc->num_pds; i++) {
>> +        if (!rpmhpds[i])
>> +            continue;
>> +
>> +        priv = rpmhpds[i];
>> +        priv->dev = dev;
>> +        priv->addr = cmd_db_read_addr(priv->res_name);
>> +        if (!priv->addr) {
>> +            dev_err(dev, "Could not find RPMh address for resource %s\n",
>> +                priv->res_name);
>> +            return -ENODEV;
>> +        }
>> +
>> +        ret = cmd_db_read_slave_id(priv->res_name);
>> +        if (ret != CMD_DB_HW_ARC) {
>> +            dev_err(dev, "RPMh slave ID mismatch\n");
>> +            return -EINVAL;
>> +        }
>> +
>> +        ret = rpmhpd_update_level_mapping(priv);
>> +        if (ret)
>> +            return ret;
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>> +static const struct power_domain_ops qcom_rpmhpd_power_ops = {
>> +    .on = rpmhpd_power_on,
>> +    .off = rpmhpd_power_off,
>> +};
>> +
>> +U_BOOT_DRIVER(qcom_rpmhpd_drv) = {
>> +    .name = "qcom_rpmhpd_drv",
>> +    .id = UCLASS_POWER_DOMAIN,
>> +    .of_match = rpmhpd_match_table,
>> +    .probe = rpmhpd_probe,
>> +    .ops = &qcom_rpmhpd_power_ops,
>> +};
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Groups.io Links: You receive all messages sent to this group.
> View/Reply Online (#2311): https://groups.io/g/u-boot-qcom/message/2311
> Mute This Topic: https://groups.io/mt/114163755/900740
> Group Owner: u-boot-qcom+owner@groups.io
> Unsubscribe: https://groups.io/g/u-boot-qcom/leave/13197875/900740/1403832380/xyzzy [neil.armstrong@linaro.org]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 

