Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1DD3CCD1BE
	for <u-boot@archiver.kernel.org>; Thu, 23 Oct 2025 12:09:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CBD48334F;
	Thu, 23 Oct 2025 14:09:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="phKoq4Po";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF638835B0; Thu, 23 Oct 2025 14:09:11 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 819A08323A
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 14:09:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N6xYJm005790
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 12:09:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NVX6i6nd5pv3MI2oFLsACvTchOFeHUHEGkdvKpoBRqU=; b=phKoq4PoWuvPtVNW
 t27SJtinxWmALXuW8qcJD6viN/uxgcKkDB0GamCnLrSZLzoNup0Swb/KpBVoVXYi
 +RirZHO5wnzTSKDT7tESU3icUke0leDes2EWSMRkMluIUgPY+Wm8utE4WsC+43H+
 keY3D8YSZ0dfTnyUKl1CUr43x3rFSMvFMdUqVpuv/GzRq9UeVWdCQRr1e3BVzwj0
 mwys5Pq0bYjmzA+YpBfLCSY1CSCyQtSNJAIVTKwdviAEid3Yoz9ppP88Mg/IjNGL
 djf0IJDDiT4SuX/wrYiLhA2ed7brAfPBGanQT9ExrpWxIIVpf7Fx5fG3tOLjMVkX
 n/jk6w==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v27j88dq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 12:09:06 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-27c62320f16so7657235ad.1
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 05:09:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761221345; x=1761826145;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NVX6i6nd5pv3MI2oFLsACvTchOFeHUHEGkdvKpoBRqU=;
 b=bG0Mml9XcXS+9ND7SVldoLSGnk6ohRwUBttnxeCWzuHgCbwacJylikFkL+7hFHQjWJ
 tdMOCHJWjI15XIwqlF62g0z7UKhtRWEDxzHOeRZLxW9cbNjB495cUJRSjEMWiuTOecXc
 N7GwOHr8Q2gQdgZwp2YuH9b08/9U3jaMYcmn1271OY9GrBmOK3Sdh3sX6NqY7+97pw/r
 /4kZjsw2PiKcOVEBttFTfpHTiX9aczg8PeKl/kHwz6A68454xU0bvYYk7WWtRs01pGVm
 aBMjFPYUs98hAie4D8PoXUObxTYgLF2oZyRLc4P6muQ8/FPItbG3FeYPn5EhR3BdRg5k
 sWyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIKem9p6UkdjqtSmzGBosKmR1tpQa6rjI4MBdooYCl1eWVXzKafhWFkNGFmT9tgZ4jiHctCSY=@lists.denx.de
X-Gm-Message-State: AOJu0Yyxq8sR3+i+2e/kEde8gPS3Eh6Do4yP+3lVez9qwJghOyAyfnsz
 uvouAPMXtRbCCECQGST/WOzAUDTReYggJ7+mQKcmsTdg+T4/NQzAPZZER4TvxvYLYuFrzxkxfwL
 4z1NVvPHDD+Hm72iCz591ni+BvpE9IGy7CrBIBGZD2k33SHvQsxU5q7aF
X-Gm-Gg: ASbGncsVYsAarcmj8g892kJurV49E/IVwlpM1n8EEpm/wK8ixjdHgwtGNRTfVrmUSD8
 Sh1IKdwwHsejMyUAOpClkjeF3rUUESmEt1IqI7GipAHhsy51+ivuSD7tbBkFHzd7G7w4sFz48xV
 N4bt5WVaog0EPWw82vK89OmSTuqeLSzcaMCRFlyD/dwPz6BK9eUGswyQe2VfzAev7zp/svZVRMH
 b4fAGLnU0uk0liEHSajmWRmXgQIMxBsjoCJZIpEgZ8wn4iJ/XT98IxEwyEGx7HuRP6bdP63aWLO
 5IrJPCHyzi6EqMoIHwa/sffqrf7SHpSw6OsMOZnFDTY/n2y5LsqlGRYbI2ll5iq1EtCn6ylF/Xv
 8NbXhzsQQZhgF9rGTAnKwbndNdq/4emc=
X-Received: by 2002:a17:903:19e6:b0:273:31fb:a872 with SMTP id
 d9443c01a7336-290c9c89c81mr301027825ad.6.1761221344400; 
 Thu, 23 Oct 2025 05:09:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzhgfibGo/BCH3kT23RLV4BVilC3j5YbQs96wLuP8bVnF3+hYRZibQgsFuXtBIxdN3HWGOnQ==
X-Received: by 2002:a17:903:19e6:b0:273:31fb:a872 with SMTP id
 d9443c01a7336-290c9c89c81mr301027265ad.6.1761221343730; 
 Thu, 23 Oct 2025 05:09:03 -0700 (PDT)
Received: from [10.152.211.230] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2946e243a59sm21423605ad.109.2025.10.23.05.08.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Oct 2025 05:09:03 -0700 (PDT)
Message-ID: <f19c0fe1-8134-4650-b0a6-a4d8d65d2850@oss.qualcomm.com>
Date: Thu, 23 Oct 2025 17:38:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] power-domain: Add QCOM RPMH Power Domain Driver
 Support
To: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot-qcom@groups.io,
 trini@konsulko.com, sumit.garg@kernel.org, jh80.chung@samsung.com,
 rui.silva@linaro.org, ilias.apalodimas@linaro.org,
 christopher.obbard@linaro.org, me@samcday.com, quic_varada@quicinc.com,
 marek.vasut+renesas@mailbox.org, sughosh.ganu@linaro.org,
 miquel.raynal@bootlin.com, balaji.selvanathan@oss.qualcomm.com,
 sjg@chromium.org, u-boot@lists.denx.de
References: <20250711143851.1490617-1-aswin.murugan@oss.qualcomm.com>
 <20250711143851.1490617-3-aswin.murugan@oss.qualcomm.com>
 <186A538DC06C545F.26372@groups.io>
 <627f4122-6f60-4b3c-adac-370f6e736a97@linaro.org>
 <db30c6d4-8cca-4f2e-a26d-bac73cf82d1b@linaro.org>
Content-Language: en-US
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
In-Reply-To: <db30c6d4-8cca-4f2e-a26d-bac73cf82d1b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxOCBTYWx0ZWRfX8TWmTjdJwSor
 bXruPRdEf7ZzvMv/ae/v9guOakuVAuZnyoOfiQK8EhDgkzACWCd3L80upfyK3xZKXEyabu0aISD
 NKUpDyiNu9lD+xIuJhTQb7IhM4oxlZF7QLTFsEkOPaAjJB1UNuY/yqxF/kuFA1jMWiXFlZ4MLrG
 G8ALei/FNypRy0htGXUYYelz8xWbew2WZb8OWtFOKoBSFWQ2zpBdvLBUZw2bMRsdGYj86mpXAGU
 NUnRhnflNr4ZgWkOUrd7W/l7pM4PFzCeDgBTTLDwcFAr/vbJMoSbCHSIsL7y+8aefggywGIKqma
 covbxh0mUnNJPPlNq/8GruhxxikkQjcUD/p6FRO7xx8vTgJrQor/FKgQYY5ux6WZM08o+bGtvXw
 Y5LKn1ejHn01Ti5fGOZkFU4I6Di/kg==
X-Authority-Analysis: v=2.4 cv=G4UR0tk5 c=1 sm=1 tr=0 ts=68fa1ae2 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=xjGz-wBMAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=VXhVMjoDq_s40RHWo9IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=dmbvPvuLAiAwK5y7oBu2:22 a=cvBusfyB2V15izCimMoJ:22
 a=poXaRoVlC6wW9_mwW8W4:22
X-Proofpoint-GUID: 5TERjNG3WCbqcQT-owVMjnULvQb1hp45
X-Proofpoint-ORIG-GUID: 5TERjNG3WCbqcQT-owVMjnULvQb1hp45
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0 clxscore=1011
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510180018
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean


On 10/20/2025 7:41 PM, Casey Connolly wrote:
>
> On 01/10/2025 11:24, neil.armstrong@linaro.org wrote:
>> On 10/1/25 11:21, Neil Armstrong via groups.io wrote:
>>> On 7/11/25 16:38, Aswin Murugan wrote:
>>>> Added support for Qualcomm RPMH power domain driver, responsible
>>>> for managing power domains on Qualcomm SoCs. This is a port of
>>>> the Linux RPMHPD driver [1] and sa8775p related changes. The
>>>> power domain driver currently has support to power on and off
>>>> MMCX power domain of sa8775p; support for other soc entries power
>>>> domains are stubbed, in future, the required soc support can be
>>>> added.
>>>>
>>>> [1]:
>>>> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/
>>>> linux.git/tree/drivers/pmdomain/qcom/rpmhpd.c?
>>>> id=3d25d46a255a83f94d7d4d4216f38aafc8e116b
>>>>
>>>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>>>> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
>>>> ---
>>>> v4:
>>>> - Added all SoC entries from the Linux driver and stubbed it
>>>> - Removed "qcom_rpmhpd" driver
>>>> - Removed unused members in struct rpmhpd
>>>>
>>>> v3:
>>>> - No changes to this patch in v3
>>>>
>>>> v2:
>>>> - Added ARCH_SNAPDRAGON dependency to QCOM_POWER_DOMAIN Kconfig
>>>> - In qcom-rpmhpd driver, the un-supported power domains are handled
>>>> with warning
>>>> ---
>>>>    drivers/power/domain/Kconfig       |   8 +
>>>>    drivers/power/domain/Makefile      |   1 +
>>>>    drivers/power/domain/qcom-rpmhpd.c | 278 +++++++++++++++++++++++++++++
>>>>    3 files changed, 287 insertions(+)
>>>>    create mode 100644 drivers/power/domain/qcom-rpmhpd.c
>>>>
>>>> diff --git a/drivers/power/domain/Kconfig b/drivers/power/domain/Kconfig
>>>> index 5f5218bd8b5..1456df96cd1 100644
>>>> --- a/drivers/power/domain/Kconfig
>>>> +++ b/drivers/power/domain/Kconfig
>>>> @@ -82,6 +82,14 @@ config MESON_SECURE_POWER_DOMAIN
>>>>          Enable support for manipulating Amlogic Meson Secure power
>>>> domains.
>>>>          Support for Amlogic A1 series.
>>>> +config QCOM_POWER_DOMAIN
>>>> +    bool "Enable the QCOM RPMH Power domain driver"
>>>> +    depends on POWER_DOMAIN && ARCH_SNAPDRAGON
>>>> +    help
>>>> +      Generic RPMH power domain implementation for QCOM devices.
>>>> +      The RPMH power domain driver is responsible for managing power
>>>> +      domains on Qualcomm SoCs.
>>>> +
>>>>    config SANDBOX_POWER_DOMAIN
>>>>        bool "Enable the sandbox power domain test driver"
>>>>        depends on POWER_DOMAIN && SANDBOX
>>>> diff --git a/drivers/power/domain/Makefile b/drivers/power/domain/
>>>> Makefile
>>>> index 4d20c97d26c..950f83972dc 100644
>>>> --- a/drivers/power/domain/Makefile
>>>> +++ b/drivers/power/domain/Makefile
>>>> @@ -21,3 +21,4 @@ obj-$(CONFIG_TEGRA186_POWER_DOMAIN) += tegra186-
>>>> power-domain.o
>>>>    obj-$(CONFIG_TI_SCI_POWER_DOMAIN) += ti-sci-power-domain.o
>>>>    obj-$(CONFIG_TI_POWER_DOMAIN) += ti-power-domain.o
>>>>    obj-$(CONFIG_ZYNQMP_POWER_DOMAIN) += zynqmp-power-domain.o
>>>> +obj-$(CONFIG_QCOM_POWER_DOMAIN) += qcom-rpmhpd.o
>>>> diff --git a/drivers/power/domain/qcom-rpmhpd.c b/drivers/power/
>>>> domain/qcom-rpmhpd.c
>>>> new file mode 100644
>>>> index 00000000000..906af2aa0ba
>>>> --- /dev/null
>>>> +++ b/drivers/power/domain/qcom-rpmhpd.c
>>>> @@ -0,0 +1,278 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +// Copyright (c) 2018, The Linux Foundation. All rights reserved.
>>>> +// Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights
>>>> reserved.
>>>> +
>>>> +#include <dm.h>
>>>> +#include <dm/lists.h>
>>>> +#include <power-domain.h>
>>>> +#include <asm/io.h>
>>>> +#include <linux/errno.h>
>>>> +
>>>> +#include <power-domain-uclass.h>
>>>> +#include <soc/qcom/cmd-db.h>
>>>> +#include <soc/qcom/rpmh.h>
>>>> +#include <dt-bindings/power/qcom-rpmpd.h>
>>>> +#include <dm/device_compat.h>
>>>> +
>>>> +#define RPMH_ARC_MAX_LEVELS    16
>>>> +
>>>> +/**
>>>> + * struct rpmhpd - top level RPMh power domain resource data structure
>>>> + * @dev:                rpmh power domain controller device
>>>> + * @pd:                 generic_pm_domain corresponding to the power
>>>> domain
>>>> + * @parent:             generic_pm_domain corresponding to the
>>>> parent's power domain
>>>> + * @enable_corner:      lowest non-zero corner
>>>> + * @level:              An array of level (vlvl) to corner (hlvl)
>>>> mappings
>>>> + *                      derived from cmd-db
>>>> + * @level_count:        Number of levels supported by the power
>>>> domain. max
>>>> + *                      being 16 (0 - 15)
>>>> + * @enabled:            true if the power domain is enabled
>>>> + * @res_name:           Resource name used for cmd-db lookup
>>>> + * @addr:               Resource address as looped up using resource
>>>> name from
>>>> + * @skip_retention_level: Indicate that retention level should not
>>>> be used for the power domain
>>>> + */
>>>> +struct rpmhpd {
>>>> +    struct udevice    *dev;
>>>> +    struct power_domain pd;
>>>> +    struct power_domain *parent;
>>>> +    unsigned int    enable_corner;
>>>> +    u32        level[RPMH_ARC_MAX_LEVELS];
>>>> +    size_t        level_count;
>>>> +    bool        enabled;
>>>> +    const char    *res_name;
>>>> +    u32        addr;
>>>> +    bool        skip_retention_level;
>>>> +};
>>>> +
>>>> +struct rpmhpd_desc {
>>>> +    struct rpmhpd **rpmhpds;
>>>> +    size_t num_pds;
>>>> +};
>>>> +
>>>> +/* RPMH powerdomains */
>>>> +static struct rpmhpd mmcx_ao;
>>>> +static struct rpmhpd mmcx = {
>>>> +    .res_name = "mmcx.lvl",
>>>> +};
>>>> +
>>>> +static struct rpmhpd mmcx_ao = {
>>>> +    .res_name = "mmcx.lvl",
>>>> +};
>>>> +
>>>> +/* SA8775P RPMH power domains */
>>>> +static struct rpmhpd *sa8775p_rpmhpds[] = {
>>>> +    [SA8775P_MMCX] = &mmcx,
>>>> +    [SA8775P_MMCX_AO] = &mmcx_ao,
>>>> +};
>>>> +
>>>> +static const struct rpmhpd_desc sa8775p_desc = {
>>>> +    .rpmhpds = sa8775p_rpmhpds,
>>>> +    .num_pds = ARRAY_SIZE(sa8775p_rpmhpds),
>>>> +};
>>>> +
>>>> +/* stub RPMH power domains mapped for unsupported platforms */
>>>> +static struct rpmhpd *stub_rpmhpds[] = {};
>>>> +
>>>> +static const struct rpmhpd_desc stub_desc = {
>>>> +    .rpmhpds = stub_rpmhpds,
>>>> +    .num_pds = ARRAY_SIZE(stub_rpmhpds),
>>>> +};
>>>> +
>>>> +static const struct udevice_id rpmhpd_match_table[] = {
>>>> +    { .compatible = "qcom,sa8775p-rpmhpd", .data =
>>>> (ulong)&sa8775p_desc },
>>>> +    { .compatible = "qcom,qcs615-rpmhpd", .data = &stub_desc },
>>>> +    { .compatible = "qcom,qcs8300-rpmhpd", .data = &stub_desc },
>>>> +    { .compatible = "qcom,qdu1000-rpmhpd", .data = &stub_desc },
>>>> +    { .compatible = "qcom,sa8155p-rpmhpd", .data = &stub_desc },
>>>> +    { .compatible = "qcom,sa8540p-rpmhpd", .data = &stub_desc },
>>>> +    { .compatible = "qcom,sar2130p-rpmhpd", .data = &stub_desc},
>>>> +    { .compatible = "qcom,sc7180-rpmhpd", .data = &stub_desc },
>>>> +    { .compatible = "qcom,sc7280-rpmhpd", .data = &stub_desc },
>>>> +    { .compatible = "qcom,sc8180x-rpmhpd", .data = &stub_desc },
>>>> +    { .compatible = "qcom,sc8280xp-rpmhpd", .data = &stub_desc },
>>>> +    { .compatible = "qcom,sdm670-rpmhpd", .data = &stub_desc },
>>>> +    { .compatible = "qcom,sdm845-rpmhpd", .data = &stub_desc },
>>>> +    { .compatible = "qcom,sdx55-rpmhpd", .data = &stub_desc},
>>>> +    { .compatible = "qcom,sdx65-rpmhpd", .data = &stub_desc},
>>>> +    { .compatible = "qcom,sdx75-rpmhpd", .data = &stub_desc},
>>>> +    { .compatible = "qcom,sm4450-rpmhpd", .data = &stub_desc},
>>>> +    { .compatible = "qcom,sm6350-rpmhpd", .data = &stub_desc },
>>>> +    { .compatible = "qcom,sm7150-rpmhpd", .data = &stub_desc },
>>>> +    { .compatible = "qcom,sm8150-rpmhpd", .data = &stub_desc },
>>>> +    { .compatible = "qcom,sm8250-rpmhpd", .data = &stub_desc },
>>>> +    { .compatible = "qcom,sm8350-rpmhpd", .data = &stub_desc },
>>>> +    { .compatible = "qcom,sm8450-rpmhpd", .data = &stub_desc },
>>>> +    { .compatible = "qcom,sm8550-rpmhpd", .data = &stub_desc },
>>>> +    { .compatible = "qcom,sm8650-rpmhpd", .data = &stub_desc },
>>>> +    { .compatible = "qcom,sm8750-rpmhpd", .data = &stub_desc },
>>>> +    { .compatible = "qcom,x1e80100-rpmhpd", .data = &stub_desc },
>>>> +    { }
>>>> +};
>>>> +
>>>> +static int rpmhpd_send_corner(struct rpmhpd *pd, int state,
>>>> +                  unsigned int corner, bool sync)
>>>> +{
>>>> +    struct tcs_cmd cmd = {
>>>> +        .addr = pd->addr,
>>>> +        .data = corner,
>>>> +    };
>>>> +
>>>> +    return rpmh_write(pd->dev->parent, state, &cmd, 1);
>>>
>>> This is wrong, it shoudl be rpmh_write(pd, state, &cmd, 1),
>> Sorry rpmh_write(pd->dev, state, &cmd, 1)
> I'm confused how/if this worked before... Aswin any chance you can
> respin and confirm?
>
> Kind regards,>
>
> Sorry for the late response, will check on this and get back ASAP.
>
> Thanks,
> Aswin
>>> since rpmh_write gets the parent in get_rpmh_ctrlr().
>>>
>>> Neil
>>>
>>>> +}
>>>> +
>>>> +static int rpmhpd_power_on(struct power_domain *pd)
>>>> +{
>>>> +    int ret;
>>>> +    unsigned int corner;
>>>> +    struct rpmhpd **rpmhpds;
>>>> +    const struct rpmhpd_desc *desc;
>>>> +    struct rpmhpd *curr_rpmhpd;
>>>> +
>>>> +    desc = (const struct rpmhpd_desc *)dev_get_driver_data(pd->dev);
>>>> +    if (!desc)
>>>> +        return -EINVAL;
>>>> +
>>>> +    rpmhpds = desc->rpmhpds;
>>>> +    curr_rpmhpd = rpmhpds[pd->id];
>>>> +
>>>> +    /* Do nothing for undefined power domains */
>>>> +    if (!curr_rpmhpd) {
>>>> +        log_warning("Power domain id (%d) not supported\n",
>>>> +                pd->id);
>>>> +        return 0;
>>>> +    }
>>>> +
>>>> +    corner = curr_rpmhpd->enable_corner;
>>>> +
>>>> +    ret = rpmhpd_send_corner(curr_rpmhpd, RPMH_ACTIVE_ONLY_STATE,
>>>> corner,
>>>> +                 false);
>>>> +    if (!ret)
>>>> +        curr_rpmhpd->enabled = true;
>>>> +
>>>> +    return ret;
>>>> +}
>>>> +
>>>> +static int rpmhpd_power_off(struct power_domain *pd)
>>>> +{
>>>> +    int ret;
>>>> +    unsigned int corner;
>>>> +    struct rpmhpd **rpmhpds;
>>>> +    const struct rpmhpd_desc *desc;
>>>> +    struct rpmhpd *curr_rpmhpd;
>>>> +
>>>> +    desc = (const struct rpmhpd_desc *)dev_get_driver_data(pd->dev);
>>>> +    if (!desc)
>>>> +        return -EINVAL;
>>>> +
>>>> +    rpmhpds = desc->rpmhpds;
>>>> +    curr_rpmhpd = rpmhpds[pd->id];
>>>> +
>>>> +    /* Do nothing for undefined power domains */
>>>> +    if (!curr_rpmhpd) {
>>>> +        log_warning("Power domain id (%d) not supported\n",
>>>> +                pd->id, 0);
>>>> +        return 0;
>>>> +    }
>>>> +
>>>> +    corner = 0;
>>>> +
>>>> +    ret = rpmhpd_send_corner(curr_rpmhpd, RPMH_ACTIVE_ONLY_STATE,
>>>> corner,
>>>> +                 false);
>>>> +    if (!ret)
>>>> +        curr_rpmhpd->enabled = false;
>>>> +
>>>> +    return ret;
>>>> +}
>>>> +
>>>> +static int rpmhpd_update_level_mapping(struct rpmhpd *rpmhpd)
>>>> +{
>>>> +    int i;
>>>> +    const u16 *buf;
>>>> +
>>>> +    buf = cmd_db_read_aux_data(rpmhpd->res_name, &rpmhpd->level_count);
>>>> +    if (IS_ERR(buf))
>>>> +        return PTR_ERR(buf);
>>>> +
>>>> +    /* 2 bytes used for each command DB aux data entry */
>>>> +    rpmhpd->level_count >>= 1;
>>>> +
>>>> +    if (rpmhpd->level_count > RPMH_ARC_MAX_LEVELS)
>>>> +        return -EINVAL;
>>>> +
>>>> +    for (i = 0; i < rpmhpd->level_count; i++) {
>>>> +        if (rpmhpd->skip_retention_level && buf[i] ==
>>>> RPMH_REGULATOR_LEVEL_RETENTION)
>>>> +            continue;
>>>> +
>>>> +        rpmhpd->level[i] = buf[i];
>>>> +
>>>> +        /* Remember the first corner with non-zero level */
>>>> +        if (!rpmhpd->level[rpmhpd->enable_corner] && rpmhpd->level[i])
>>>> +            rpmhpd->enable_corner = i;
>>>> +
>>>> +        /*
>>>> +         * The AUX data may be zero padded. These 0 valued entries at
>>>> +         * the end of the map must be ignored.
>>>> +         */
>>>> +        if (i > 0 && rpmhpd->level[i] == 0) {
>>>> +            rpmhpd->level_count = i;
>>>> +            break;
>>>> +        }
>>>> +        debug("%s: ARC hlvl=%2d --> vlvl=%4u\n", rpmhpd->res_name, i,
>>>> +              rpmhpd->level[i]);
>>>> +    }
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static int rpmhpd_probe(struct udevice *dev)
>>>> +{
>>>> +    int i, ret;
>>>> +    struct rpmhpd **rpmhpds;
>>>> +    struct rpmhpd *priv;
>>>> +    const struct rpmhpd_desc *desc;
>>>> +
>>>> +    desc = (const struct rpmhpd_desc *)dev_get_driver_data(dev);
>>>> +    if (!desc)
>>>> +        return -EINVAL;
>>>> +
>>>> +    rpmhpds = desc->rpmhpds;
>>>> +
>>>> +    for (i = 0; i < desc->num_pds; i++) {
>>>> +        if (!rpmhpds[i])
>>>> +            continue;
>>>> +
>>>> +        priv = rpmhpds[i];
>>>> +        priv->dev = dev;
>>>> +        priv->addr = cmd_db_read_addr(priv->res_name);
>>>> +        if (!priv->addr) {
>>>> +            dev_err(dev, "Could not find RPMh address for resource
>>>> %s\n",
>>>> +                priv->res_name);
>>>> +            return -ENODEV;
>>>> +        }
>>>> +
>>>> +        ret = cmd_db_read_slave_id(priv->res_name);
>>>> +        if (ret != CMD_DB_HW_ARC) {
>>>> +            dev_err(dev, "RPMh slave ID mismatch\n");
>>>> +            return -EINVAL;
>>>> +        }
>>>> +
>>>> +        ret = rpmhpd_update_level_mapping(priv);
>>>> +        if (ret)
>>>> +            return ret;
>>>> +    }
>>>> +
>>>> +    return ret;
>>>> +}
>>>> +
>>>> +static const struct power_domain_ops qcom_rpmhpd_power_ops = {
>>>> +    .on = rpmhpd_power_on,
>>>> +    .off = rpmhpd_power_off,
>>>> +};
>>>> +
>>>> +U_BOOT_DRIVER(qcom_rpmhpd_drv) = {
>>>> +    .name = "qcom_rpmhpd_drv",
>>>> +    .id = UCLASS_POWER_DOMAIN,
>>>> +    .of_match = rpmhpd_match_table,
>>>> +    .probe = rpmhpd_probe,
>>>> +    .ops = &qcom_rpmhpd_power_ops,
>>>> +};
>>>
>>>
>>> -=-=-=-=-=-=-=-=-=-=-=-
>>> Groups.io Links: You receive all messages sent to this group.
>>> View/Reply Online (#2311): https://groups.io/g/u-boot-qcom/message/2311
>>> Mute This Topic: https://groups.io/mt/114163755/900740
>>> Group Owner: u-boot-qcom+owner@groups.io
>>> Unsubscribe: https://groups.io/g/u-boot-qcom/
>>> leave/13197875/900740/1403832380/xyzzy [neil.armstrong@linaro.org]
>>> -=-=-=-=-=-=-=-=-=-=-=-
>>>
>>>
