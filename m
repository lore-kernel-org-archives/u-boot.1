Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5227ED0C84C
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 10:43:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFD23836AC;
	Tue, 13 Jan 2026 11:43:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="OzoAbg+A";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PDWssb7F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7076C836AC; Tue, 13 Jan 2026 11:43:44 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 901068352B
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 11:43:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60D7AZsw2607176
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 10:43:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mVyv7Q5/FrjRcnUYZGgCAp77f4b/U1tetpJi2brNpzw=; b=OzoAbg+AJcNFAbpW
 EHJkAr7ohaY3VY8kFp6hbWBrN5H+oGhcvU1DzFvxOAhsZU5eG7ZWQDIguggOqRAf
 doD33qrn8kLUkxoIJtiHB9xmlr/cUjsREa7RjbjBwnZ4CTo8PfUw1t5nWyfhq9l2
 +r1t0cnLtLoYRT5DMn+omfS9hUhxBDK+rImKe0OBuGHkUJ7OW7DTWVsGbE79hkQS
 stK8dP4awygbqmWBteIicnaqSeOuTKM2XDAsRGhSZP5LN/luy7R2yhAWVkN/AHCu
 sS1kLrLEMLhoKFL8Okh+TPCKF5Ln8fHmXprYOKOh7G8AwVr5IJkCi2hiWrM3OdTm
 qtGy2g==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bn7uytb8n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 10:43:39 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2a13be531b2so76485005ad.2
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 02:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1768301019; x=1768905819; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mVyv7Q5/FrjRcnUYZGgCAp77f4b/U1tetpJi2brNpzw=;
 b=PDWssb7F8+mJ24JblXV1TP1JeBtDIsvEtu1roLip7eRTGz4McRClB79bRnXKJbpaHY
 UhbgFVj2AqBu4uEYwxzk0ClR8Ae55U+oO+trfwQzx6oCFycoXo1hhEeuBY3lcboGxkDE
 Vu7crZTeGdHFRdrARROWkMJrNP40TMBUBkAYVlMjv9Xf9mZqoZZUvC/13/WIZlWnX5XL
 O0Z3gfHVO4T2sUYFmY70dunU7kS+4zqMxpsvcgOFyA1UIIUN30okR9qvd8B4W5T1oBSK
 RwDcGqN+mHGv2zgzCBKhJJFgjUBZfC7ZGR2BbFNN8E7aShnn1TK5tBjyUWOKQ17jxV+N
 /dIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768301019; x=1768905819;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mVyv7Q5/FrjRcnUYZGgCAp77f4b/U1tetpJi2brNpzw=;
 b=XJO8P1q42CuvpJJVmQ73aX/NJkT6Z6RxDf3QBOnhh8q1WxsQ9DKSd4jPegdZLH/deo
 8LbbBqDaZ7vSrAbhWq3YG9QcrSfZwQRYEHQUB4OPdzgvugQOQ09naKdOd2ntK3b3Yi9u
 HBY6/V+Mx8pEXv5IT/9DTTqWLk2lky9/j2NYNQEzpmr95yxS0okpyq/DGABEk3wFp2pL
 H71KE4yN4ynyY+T2a2Tvxaek5iJ0lCmZGU0hCx2J6hijyJKVjwt7/cy4dPGmscQ5CgCR
 dV+HO63lIfXc1DR9k8QTHYKAB91S3CJrqLPcvH4No8RSp5Kn8D+fLC7kf3R9Vc1Y7wOE
 hPPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOt0Eu4Uj53Cojl8hvXz8p5+8Hzi2zDmdWhwDO2HaSffT8E01bFHkxvwdjVFWVsvXUSGCc9Qs=@lists.denx.de
X-Gm-Message-State: AOJu0YxqDtMXoUiLzoZsticz5BmLPrXyt2JXyCOmJkP9NlSbqYfHDy3X
 XfZxkFt0YnjF6dCehtXZ5UlwU3XL4Fmk9KMS13QlJuJcD7I6LecNa0OilgOUnI5SxmCGDohzaOA
 l27yLWsOk7pMSzgkEFPYUcALEGc0eB93SFXH4r6oVrlglaeBww0eUQ2DY
X-Gm-Gg: AY/fxX7TvPXowkS2kf2lgaYuI2oAYmrdM5Ug2U5YSCpZ6XHhMqezM0LoKS/W+lh28ZX
 oVDzrUsaraOL3w6R9JkQJ3bLfzoeZ++yqlY+vqxz2wLchhapZgXFs+m/WT8Y3SP1AmkyQecv1T5
 JA5kte5QSiXURrwB70Vx5Tfuuztw/Ix0Uh18gDh2Lc+hPHdrVES8a8qNrryF+ZyEeTzErGUMNQj
 Xq2maSt7/rl1TG2HgbmRhLhNXZuEynwO74in6RhWKIAI4TWV0RzQFxBVYdG7eNIMc5+hxd/CTeW
 eoyDlhd11V05CxrhsBMgN31rtP8QCir+meP8zZ3fzsYbq8YTqYuZ+hmqpWSw76Y6hM3MAFuieyd
 M+kSaNZ7SmRZTVejKE3+Mc92VZYPAtOrG0zPcY4/J/Q==
X-Received: by 2002:a17:902:e851:b0:29e:9407:a8cb with SMTP id
 d9443c01a7336-2a3ee4fed2bmr207610535ad.40.1768301018439; 
 Tue, 13 Jan 2026 02:43:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGEepAUIKELvGQynZvWGJmQkfV18uXD2hQQbFYTmf9vGViDKJp99sPk6nH/xZ4wNZR/FYiC6g==
X-Received: by 2002:a17:902:e851:b0:29e:9407:a8cb with SMTP id
 d9443c01a7336-2a3ee4fed2bmr207610145ad.40.1768301017710; 
 Tue, 13 Jan 2026 02:43:37 -0800 (PST)
Received: from [10.152.222.235] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3cd4bd8sm196162325ad.102.2026.01.13.02.43.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jan 2026 02:43:37 -0800 (PST)
Message-ID: <3354f9f0-12ba-4e7b-9f9e-f638c3606dd4@oss.qualcomm.com>
Date: Tue, 13 Jan 2026 16:13:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/4] power-domain: Add QCOM RPMH Power Domain Driver
 Support
To: Sumit Garg <sumit.garg@kernel.org>
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 jh80.chung@samsung.com, rui.silva@linaro.org,
 ilias.apalodimas@linaro.org, quic_varada@quicinc.com, me@samcday.com,
 marek.vasut+renesas@mailbox.org, miquel.raynal@bootlin.com,
 alif.zakuan.yuslaimi@altera.com, tien.fong.chee@altera.com,
 w.egorov@phytec.de, u-boot-qcom@groups.io, u-boot@lists.denx.de,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
References: <20251222114823.2146775-1-aswin.murugan@oss.qualcomm.com>
 <20251222114823.2146775-2-aswin.murugan@oss.qualcomm.com>
 <aU5Zi7yVPWOiv_B5@sumit-xelite>
Content-Language: en-US
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
In-Reply-To: <aU5Zi7yVPWOiv_B5@sumit-xelite>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: GYZ9gpaQc1kGYjEINX4g9wAe_2Y37-DL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA5MSBTYWx0ZWRfX7PEG+siUGJna
 +arIqIaCw90ifyBH46fhRkIGQknIyuOIgIlXGVucZ8ekMOLPkir/0pXjq9VXSBRHl8eMN8KQkJH
 yGgBvmZ44t3XlLFzpxayaRDKdrgrbszERzNS6C+E7l5J/OVxPnnSaVQZK2xHGe9Mitf+ArP0K2H
 WToyt3/Kxyu1p5KmKlQcx6vF1l3AJaplAflDGVTqm0IJQ79S/GNslIEy+p+0lBJmHZmwdBYHlim
 xFHHrt8/T0Yf9GhUTOhe7Q5mMKpUHbWBvEevz6qFF7Z1Vz/Wym2qkSffzPEYeY41woFxv3HC74r
 V7E3mRj93n1YLqezJnann2f86YjmCnhye+QnFpJazvbJ2WrFH/hp1s81fh2L0A0KFluFwQtporO
 JAcAQNr6viaaDAcrW+voXE5C/xJ8vPP51XBU+GbCgNa7CqilotGE93aQZ/IuKvmsJ7emmtmKTt4
 1pBKrR+YuBA7pOQhncw==
X-Authority-Analysis: v=2.4 cv=bpdBxUai c=1 sm=1 tr=0 ts=696621db cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=dzElHwdj4eIH3R0NP8QA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: GYZ9gpaQc1kGYjEINX4g9wAe_2Y37-DL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_02,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601130091
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


On 12/26/2025 3:16 PM, Sumit Garg wrote:
> Hi Aswin,
>
> Thanks for the driver port.
>
> On Mon, Dec 22, 2025 at 05:18:20PM +0530, Aswin Murugan wrote:
>> Added support for Qualcomm RPMH power domain driver, responsible
>> for managing power domains on Qualcomm SoCs. This is a port of
>> the Linux RPMHPD driver [1] and sa8775p related changes.
>> The
>> power domain driver currently has support to power on and off
>> MMCX power domain of sa8775p;
> IIUC, the MMCX power domain relates to multimedia use-cases. Do you have
> any such use-case for that in U-Boot? IOW, I don't see a user of the
> RPMh functionality you are trying to add in this patch-set.
>
> Yes, MMCX is tied to multimedia, and in our case, it is required for 
> display initialization in U-Boot.
>
>
> If it's just meant for now to not have live DT fixups then having just
> the stubbed power domains will be sufficient.
>
> -Sumit
>
> Yes, the purpose of introducing stubbed power domains is to eliminate the need for live Device Tree fixups related to power domains
>
> -Aswin
>
>
>> support for other soc entries power
>> domains are stubbed, in future, the required soc support can be
>> added.
>>
>> [1]:
>> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pmdomain/qcom/rpmhpd.c?id=3d25d46a255a83f94d7d4d4216f38aafc8e116b
>>
>> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
>> ---
>> v7:
>> - No changes to this patch in v7
>>
>> v6:
>> - Initialized ret with 0 in rpmhpd_probe()
>>
>> v5:
>> - Changed the first argument passed to rpmh_write as pd->dev
>> - Added (ulong) casting in rpmhpd_match_table to address the warning.
>>
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
>>    in rpmhpd_power_on() & rpmhpd_power_off()
>> ---
>>   drivers/power/domain/Kconfig       |   8 +
>>   drivers/power/domain/Makefile      |   1 +
>>   drivers/power/domain/qcom-rpmhpd.c | 278 +++++++++++++++++++++++++++++
>>   3 files changed, 287 insertions(+)
>>   create mode 100644 drivers/power/domain/qcom-rpmhpd.c
>>
>> diff --git a/drivers/power/domain/Kconfig b/drivers/power/domain/Kconfig
>> index 0ad885c9e8b..48e841c638e 100644
>> --- a/drivers/power/domain/Kconfig
>> +++ b/drivers/power/domain/Kconfig
>> @@ -90,6 +90,14 @@ config MESON_SECURE_POWER_DOMAIN
>>   	  Enable support for manipulating Amlogic Meson Secure power domains.
>>   	  Support for Amlogic A1 series.
>>   
>> +config QCOM_POWER_DOMAIN
>> +	bool "Enable the QCOM RPMH Power domain driver"
>> +	depends on POWER_DOMAIN && ARCH_SNAPDRAGON
>> +	help
>> +	  Generic RPMH power domain implementation for QCOM devices.
>> +	  The RPMH power domain driver is responsible for managing power
>> +	  domains on Qualcomm SoCs.
>> +
>>   config SANDBOX_POWER_DOMAIN
>>   	bool "Enable the sandbox power domain test driver"
>>   	depends on POWER_DOMAIN && SANDBOX
>> diff --git a/drivers/power/domain/Makefile b/drivers/power/domain/Makefile
>> index 8e03f620437..1c2c64b0964 100644
>> --- a/drivers/power/domain/Makefile
>> +++ b/drivers/power/domain/Makefile
>> @@ -22,3 +22,4 @@ obj-$(CONFIG_TEGRA186_POWER_DOMAIN) += tegra186-power-domain.o
>>   obj-$(CONFIG_TI_SCI_POWER_DOMAIN) += ti-sci-power-domain.o
>>   obj-$(CONFIG_TI_POWER_DOMAIN) += ti-power-domain.o
>>   obj-$(CONFIG_ZYNQMP_POWER_DOMAIN) += zynqmp-power-domain.o
>> +obj-$(CONFIG_QCOM_POWER_DOMAIN) += qcom-rpmhpd.o
>> diff --git a/drivers/power/domain/qcom-rpmhpd.c b/drivers/power/domain/qcom-rpmhpd.c
>> new file mode 100644
>> index 00000000000..f51bc9a4bbb
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
>> +#define RPMH_ARC_MAX_LEVELS	16
>> +
>> +/**
>> + * struct rpmhpd - top level RPMh power domain resource data structure
>> + * @dev:                rpmh power domain controller device
>> + * @pd:                 generic_pm_domain corresponding to the power domain
>> + * @parent:             generic_pm_domain corresponding to the parent's power domain
>> + * @enable_corner:      lowest non-zero corner
>> + * @level:              An array of level (vlvl) to corner (hlvl) mappings
>> + *                      derived from cmd-db
>> + * @level_count:        Number of levels supported by the power domain. max
>> + *                      being 16 (0 - 15)
>> + * @enabled:            true if the power domain is enabled
>> + * @res_name:           Resource name used for cmd-db lookup
>> + * @addr:               Resource address as looped up using resource name from
>> + * @skip_retention_level: Indicate that retention level should not be used for the power domain
>> + */
>> +struct rpmhpd {
>> +	struct udevice	*dev;
>> +	struct power_domain pd;
>> +	struct power_domain *parent;
>> +	unsigned int	enable_corner;
>> +	u32		level[RPMH_ARC_MAX_LEVELS];
>> +	size_t		level_count;
>> +	bool		enabled;
>> +	const char	*res_name;
>> +	u32		addr;
>> +	bool		skip_retention_level;
>> +};
>> +
>> +struct rpmhpd_desc {
>> +	struct rpmhpd **rpmhpds;
>> +	size_t num_pds;
>> +};
>> +
>> +/* RPMH powerdomains */
>> +static struct rpmhpd mmcx_ao;
>> +static struct rpmhpd mmcx = {
>> +	.res_name = "mmcx.lvl",
>> +};
>> +
>> +static struct rpmhpd mmcx_ao = {
>> +	.res_name = "mmcx.lvl",
>> +};
>> +
>> +/* SA8775P RPMH power domains */
>> +static struct rpmhpd *sa8775p_rpmhpds[] = {
>> +	[SA8775P_MMCX] = &mmcx,
>> +	[SA8775P_MMCX_AO] = &mmcx_ao,
>> +};
>> +
>> +static const struct rpmhpd_desc sa8775p_desc = {
>> +	.rpmhpds = sa8775p_rpmhpds,
>> +	.num_pds = ARRAY_SIZE(sa8775p_rpmhpds),
>> +};
>> +
>> +/* stub RPMH power domains mapped for unsupported platforms */
>> +static struct rpmhpd *stub_rpmhpds[] = {};
>> +
>> +static const struct rpmhpd_desc stub_desc = {
>> +	.rpmhpds = stub_rpmhpds,
>> +	.num_pds = ARRAY_SIZE(stub_rpmhpds),
>> +};
>> +
>> +static const struct udevice_id rpmhpd_match_table[] = {
>> +	{ .compatible = "qcom,sa8775p-rpmhpd", .data = (ulong)&sa8775p_desc },
>> +	{ .compatible = "qcom,qcs615-rpmhpd", .data = (ulong)&stub_desc },
>> +	{ .compatible = "qcom,qcs8300-rpmhpd", .data = (ulong)&stub_desc },
>> +	{ .compatible = "qcom,qdu1000-rpmhpd", .data = (ulong)&stub_desc },
>> +	{ .compatible = "qcom,sa8155p-rpmhpd", .data = (ulong)&stub_desc },
>> +	{ .compatible = "qcom,sa8540p-rpmhpd", .data = (ulong)&stub_desc },
>> +	{ .compatible = "qcom,sar2130p-rpmhpd", .data = (ulong)&stub_desc},
>> +	{ .compatible = "qcom,sc7180-rpmhpd", .data = (ulong)&stub_desc },
>> +	{ .compatible = "qcom,sc7280-rpmhpd", .data = (ulong)&stub_desc },
>> +	{ .compatible = "qcom,sc8180x-rpmhpd", .data = (ulong)&stub_desc },
>> +	{ .compatible = "qcom,sc8280xp-rpmhpd", .data = (ulong)&stub_desc },
>> +	{ .compatible = "qcom,sdm670-rpmhpd", .data = (ulong)&stub_desc },
>> +	{ .compatible = "qcom,sdm845-rpmhpd", .data = (ulong)&stub_desc },
>> +	{ .compatible = "qcom,sdx55-rpmhpd", .data = (ulong)&stub_desc},
>> +	{ .compatible = "qcom,sdx65-rpmhpd", .data = (ulong)&stub_desc},
>> +	{ .compatible = "qcom,sdx75-rpmhpd", .data = (ulong)&stub_desc},
>> +	{ .compatible = "qcom,sm4450-rpmhpd", .data = (ulong)&stub_desc},
>> +	{ .compatible = "qcom,sm6350-rpmhpd", .data = (ulong)&stub_desc },
>> +	{ .compatible = "qcom,sm7150-rpmhpd", .data = (ulong)&stub_desc },
>> +	{ .compatible = "qcom,sm8150-rpmhpd", .data = (ulong)&stub_desc },
>> +	{ .compatible = "qcom,sm8250-rpmhpd", .data = (ulong)&stub_desc },
>> +	{ .compatible = "qcom,sm8350-rpmhpd", .data = (ulong)&stub_desc },
>> +	{ .compatible = "qcom,sm8450-rpmhpd", .data = (ulong)&stub_desc },
>> +	{ .compatible = "qcom,sm8550-rpmhpd", .data = (ulong)&stub_desc },
>> +	{ .compatible = "qcom,sm8650-rpmhpd", .data = (ulong)&stub_desc },
>> +	{ .compatible = "qcom,sm8750-rpmhpd", .data = (ulong)&stub_desc },
>> +	{ .compatible = "qcom,x1e80100-rpmhpd", .data = (ulong)&stub_desc },
>> +	{ }
>> +};
>> +
>> +static int rpmhpd_send_corner(struct rpmhpd *pd, int state,
>> +			      unsigned int corner, bool sync)
>> +{
>> +	struct tcs_cmd cmd = {
>> +		.addr = pd->addr,
>> +		.data = corner,
>> +	};
>> +
>> +	return rpmh_write(pd->dev, state, &cmd, 1);
>> +}
>> +
>> +static int rpmhpd_power_on(struct power_domain *pd)
>> +{
>> +	int ret;
>> +	unsigned int corner;
>> +	struct rpmhpd **rpmhpds;
>> +	const struct rpmhpd_desc *desc;
>> +	struct rpmhpd *curr_rpmhpd;
>> +
>> +	desc = (const struct rpmhpd_desc *)dev_get_driver_data(pd->dev);
>> +	if (!desc)
>> +		return -EINVAL;
>> +
>> +	rpmhpds = desc->rpmhpds;
>> +	curr_rpmhpd = rpmhpds[pd->id];
>> +
>> +	/* Do nothing for undefined power domains */
>> +	if (!curr_rpmhpd) {
>> +		log_warning("Power domain id (%ld) not supported\n",
>> +			    pd->id);
>> +		return 0;
>> +	}
>> +
>> +	corner = curr_rpmhpd->enable_corner;
>> +
>> +	ret = rpmhpd_send_corner(curr_rpmhpd, RPMH_ACTIVE_ONLY_STATE, corner,
>> +				 false);
>> +	if (!ret)
>> +		curr_rpmhpd->enabled = true;
>> +
>> +	return ret;
>> +}
>> +
>> +static int rpmhpd_power_off(struct power_domain *pd)
>> +{
>> +	int ret;
>> +	unsigned int corner;
>> +	struct rpmhpd **rpmhpds;
>> +	const struct rpmhpd_desc *desc;
>> +	struct rpmhpd *curr_rpmhpd;
>> +
>> +	desc = (const struct rpmhpd_desc *)dev_get_driver_data(pd->dev);
>> +	if (!desc)
>> +		return -EINVAL;
>> +
>> +	rpmhpds = desc->rpmhpds;
>> +	curr_rpmhpd = rpmhpds[pd->id];
>> +
>> +	/* Do nothing for undefined power domains */
>> +	if (!curr_rpmhpd) {
>> +		log_warning("Power domain id (%ld) not supported\n",
>> +			    pd->id);
>> +		return 0;
>> +	}
>> +
>> +	corner = 0;
>> +
>> +	ret = rpmhpd_send_corner(curr_rpmhpd, RPMH_ACTIVE_ONLY_STATE, corner,
>> +				 false);
>> +	if (!ret)
>> +		curr_rpmhpd->enabled = false;
>> +
>> +	return ret;
>> +}
>> +
>> +static int rpmhpd_update_level_mapping(struct rpmhpd *rpmhpd)
>> +{
>> +	int i;
>> +	const u16 *buf;
>> +
>> +	buf = cmd_db_read_aux_data(rpmhpd->res_name, &rpmhpd->level_count);
>> +	if (IS_ERR(buf))
>> +		return PTR_ERR(buf);
>> +
>> +	/* 2 bytes used for each command DB aux data entry */
>> +	rpmhpd->level_count >>= 1;
>> +
>> +	if (rpmhpd->level_count > RPMH_ARC_MAX_LEVELS)
>> +		return -EINVAL;
>> +
>> +	for (i = 0; i < rpmhpd->level_count; i++) {
>> +		if (rpmhpd->skip_retention_level && buf[i] == RPMH_REGULATOR_LEVEL_RETENTION)
>> +			continue;
>> +
>> +		rpmhpd->level[i] = buf[i];
>> +
>> +		/* Remember the first corner with non-zero level */
>> +		if (!rpmhpd->level[rpmhpd->enable_corner] && rpmhpd->level[i])
>> +			rpmhpd->enable_corner = i;
>> +
>> +		/*
>> +		 * The AUX data may be zero padded. These 0 valued entries at
>> +		 * the end of the map must be ignored.
>> +		 */
>> +		if (i > 0 && rpmhpd->level[i] == 0) {
>> +			rpmhpd->level_count = i;
>> +			break;
>> +		}
>> +		debug("%s: ARC hlvl=%2d --> vlvl=%4u\n", rpmhpd->res_name, i,
>> +		      rpmhpd->level[i]);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int rpmhpd_probe(struct udevice *dev)
>> +{
>> +	int i, ret = 0;
>> +	struct rpmhpd **rpmhpds;
>> +	struct rpmhpd *priv;
>> +	const struct rpmhpd_desc *desc;
>> +
>> +	desc = (const struct rpmhpd_desc *)dev_get_driver_data(dev);
>> +	if (!desc)
>> +		return -EINVAL;
>> +
>> +	rpmhpds = desc->rpmhpds;
>> +
>> +	for (i = 0; i < desc->num_pds; i++) {
>> +		if (!rpmhpds[i])
>> +			continue;
>> +
>> +		priv = rpmhpds[i];
>> +		priv->dev = dev;
>> +		priv->addr = cmd_db_read_addr(priv->res_name);
>> +		if (!priv->addr) {
>> +			dev_err(dev, "Could not find RPMh address for resource %s\n",
>> +				priv->res_name);
>> +			return -ENODEV;
>> +		}
>> +
>> +		ret = cmd_db_read_slave_id(priv->res_name);
>> +		if (ret != CMD_DB_HW_ARC) {
>> +			dev_err(dev, "RPMh slave ID mismatch\n");
>> +			return -EINVAL;
>> +		}
>> +
>> +		ret = rpmhpd_update_level_mapping(priv);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static const struct power_domain_ops qcom_rpmhpd_power_ops = {
>> +	.on = rpmhpd_power_on,
>> +	.off = rpmhpd_power_off,
>> +};
>> +
>> +U_BOOT_DRIVER(qcom_rpmhpd_drv) = {
>> +	.name = "qcom_rpmhpd_drv",
>> +	.id = UCLASS_POWER_DOMAIN,
>> +	.of_match = rpmhpd_match_table,
>> +	.probe = rpmhpd_probe,
>> +	.ops = &qcom_rpmhpd_power_ops,
>> +};
>> -- 
>> 2.34.1
>>
