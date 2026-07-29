Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E78CC54F51
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 09:14:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2EBD9409EC;
	Wed, 29 Jul 2026 09:14:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4OL-HRP3ZacA; Wed, 29 Jul 2026 09:14:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BE97F408F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785316454;
	bh=js/kIVBcCCFOGSc9klp15bjU5Fmiz6w34BfR4aW9+is=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=bkxFhWWfQ6cDHcvhHIEZMmvlsLy7Xq86iwsN+VFtTVQyim5LstDlr54l6QYLctPVj
	 +Pkr2F88fs/UQrTrrlDgEmNieEBf1m9QOGMzc6QkuUsDTZGNPp2+cN08btzXFKYNui
	 Sul2ccv2TxSlcHtVOmBQaNDgckUM2OOfDkcDPCvm5R1OwL7HBSHYPEAfpZmu9Rv8os
	 USE5+gOAe4LsCan+VoesuptP6L1KqUTD4xfs+jcH8wr80KK8y9MQhehaEtvOnA+4j8
	 +S66ttHma9Qs5E912UtwNtbDgGPXjtisgI7wA/K1640OTlzi6NAgK0nszOEiNRf4qh
	 jKToecvk6Fhtg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BE97F408F2;
	Wed, 29 Jul 2026 09:14:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 54EB03B0
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 09:14:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3ADEA4009C
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 09:14:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dqbbhwRx91Cv for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 09:14:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=badhrinath.s@oss.qualcomm.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 11FA04004B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 11FA04004B
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 11FA04004B
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 09:14:10 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9E5B8494B; Wed, 29 Jul 2026 11:14:08 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75E8C8404D
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 11:14:06 +0200 (CEST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66T7fHSZ1310100
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 09:14:04 GMT
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqa33153m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 09:14:04 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cb48f41343aso1547321a12.1
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 02:14:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785316444; x=1785921244;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=js/kIVBcCCFOGSc9klp15bjU5Fmiz6w34BfR4aW9+is=;
 b=kakKoabOhsO7tvtQCjJCE33658WjKHHwFUyTXPOY/3DU4gXIJjxAg7Z8PIM/9Eyac8
 KnjB9QuDW0ABbGR4lW3eNz6zWf575GPgkIJI7AhrSDZSvmiBJ4dKAwWZmQz0u6xp9jas
 F3OrDJlICZEBsD4Ya62rX2vutveoveFiouZxH5nJJtHiAPKY0M6SxwusjPQJSXYVC8zH
 8ffrWYBxCP32dltGwnWK0Vrma47BmbpfYnydF7CBWGacZ5qML+clbwHt8kt2WOsaOkls
 CH9C/S3IDsFydb7RAFvqOEKcGxfpBU4ag5uzYhnBAiHJb2hn4vlClMXrKZe6DO0hi6Du
 Pygw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpc+M1qLFK1xJCBsfUdL6IaQ0pkd6GhXHVHjgpoiuIzk2MqWv42arUMX/8bDAgDXmXH8D8jgt8=@lists.denx.de
X-Gm-Message-State: AOJu0YwzkdyegygtdyAAxGT0h+RlM+ErCEQ6ZW4v2DlJf8GZ16g78YMl
 32zRDxw3L1e+tLFaQO/nWTmVvcOE6LdciEQ0qS/lpuGIn5RgOTKENaUuinyinzr5iFg8VW86PRk
 0IkoKifQCeThJ4sMOvru2JE9GL5J136gLUotqw4ESOKX7jW7UQQPqlkiE
X-Gm-Gg: AR+sD12VzmMBK3w2UFZVNa3NFA5WhnO8E9/lPpjOYDp3yOQ3mWcG3Mwiw9ofozTPuBh
 eB94tJLWMnx+q7OAoHa1nzrfusspajmEpYI+bemOxHYc+loncOG9tn0lTp8CxoR+z0cwNtlCDwI
 BoOvcGxbTWU5+HQTjp31/rI3OJtz+9vR8WorVV0MUcsdWhMTJugEhOa0XZLehCben/nnOd3yqSo
 lRcnEm9IbmuofcVjv4n9kPqMlzRSnefmKLOG4/ytK+pH5487KUOIQZrLyivkvjMQogo31ItvqZ/
 CZuXqpimGGnhLA26RBg1aedDvJsqcsksTQa+TOmxTGKjLOljL+hp38vOZ3TqF9H/y1eguUw2N6k
 DpS72SCFofZ5WDZ/RnxV2Un8ktjxRDI8=
X-Received: by 2002:a05:6a20:734c:b0:3c3:80bc:1540 with SMTP id
 adf61e73a8af0-3c8e45ceb7fmr1752193637.3.1785316443689; 
 Wed, 29 Jul 2026 02:14:03 -0700 (PDT)
X-Received: by 2002:a05:6a20:734c:b0:3c3:80bc:1540 with SMTP id
 adf61e73a8af0-3c8e45ceb7fmr1752169637.3.1785316443269; 
 Wed, 29 Jul 2026 02:14:03 -0700 (PDT)
Received: from [10.152.205.146] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504b12cdasm8742827eec.1.2026.07.29.02.13.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2026 02:14:02 -0700 (PDT)
Message-ID: <1de37d37-a8c0-4887-9e31-63d98dc66ef2@oss.qualcomm.com>
Date: Wed, 29 Jul 2026 14:43:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] configs: Add defconfig for ipq9650 RDP488
To: Casey Connolly <casey.connolly@linaro.org>, trini@konsulko.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, lukma@denx.de, michal.simek@amd.com,
 adrian@mainlining.org, danila@jiaxyga.com,
 aswin.murugan@oss.qualcomm.com, david.wronek@mainlining.org,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20260716062318.4121929-1-badhrina@qti.qualcomm.com>
 <20260716062318.4121929-5-badhrina@qti.qualcomm.com>
 <f1900b5d-5701-41aa-94bc-8145a337dd91@linaro.org>
Content-Language: en-US
In-Reply-To: <f1900b5d-5701-41aa-94bc-8145a337dd91@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA3NSBTYWx0ZWRfX3sVezofTSv/F
 O3+4qvx6YnJwIyjAYrnoLsFvM0bZrTsqMt2Qn71+wF0W3RZFCTp1tOImwSy0ptDiJto21jdSEgh
 8UvAbmvMFqaCM7K8IbE5StAAVeTh7GFen3ox+q7SX4xwIcME/LIbKEFMrqaJ0Ggxx1Ldl46GKk9
 C+5IgWnoySi2BmBWyoV5/L+8y5QvKjTkkGUO4WyxubioY2Wfqy/wIKdx65v7SdCaAIxiqAIlFJP
 wNbJNSW+6ihv8MvboBUVTvCNWoJLb5h+rr89wEc7pZMXe0Uo86gADWsh1ns9+Bemtx99kfQUmvp
 5rkdaalcdZPZ849W2ahV7F4R2txGsZsiXjFVrFCLyiLPkb4DBMV0MTxly0ZdeKsI3hXFh3zqmyW
 IIpGIuA86rFWRkUkEJlhuAfoD9uMCMZxKKJ6Z7b21RByHVk/VsC1g0cWrBrs0FX4z0eK5NUQDP/
 T7s3S8e/5Pd3lzbTllA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA3NSBTYWx0ZWRfX1x5TaicouqNj
 nb0F/Rp6MhEkqaB8afeE6ydYVExAomOe7IuNN9VZIIRqBasGVUpaDcAroyXlQ/BhqCZfoNWSwwN
 MYYrAz0hsQAQNdweLXhJRuytac1Z97s=
X-Proofpoint-ORIG-GUID: DA2wDJ2S51MRv2cgOdkvHAT6ndwijDb6
X-Authority-Analysis: v=2.4 cv=Ap/eGu9P c=1 sm=1 tr=0 ts=6a69c45c cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=gu6fZOg2AAAA:8 a=EUspDBNiAAAA:8 a=NPwWjleplIkqdMfNX1kA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22 a=2RSlZUUhi9gRBrsHwhhZ:22
X-Proofpoint-GUID: DA2wDJ2S51MRv2cgOdkvHAT6ndwijDb6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_03,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290075
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 js/kIVBcCCFOGSc9klp15bjU5Fmiz6w34BfR4aW9+is=; b=bhD44LoftBJOMDAb
 90TNnXd4P4O5ZSs6uEqw/cFR+tpDaOTHJiuySCMdr0Hv63FDVbkf7OOuwkwsO+Mj
 a8bIvsHkaR6Muyx+rH7GU0GfYw/bUa6EHxPp2H30kukoNLkdsJjG4Kp2pfenPnDD
 Oriz4pBClIYqrr/n8oqqHevswAMAhvVr2P9Xdb2iNzVNbI54JAlfew+tgMU0iO0B
 pcJ2e3aU7p96RB+YMqdqfBsWpYYiu7YKbsezsmt/eWYByZ7fehxfApJojHgkvhHU
 bwwRCK2LV1Zwum8lL9+K7uWqbQVBV+8rqh9gPXV94GmCqcT6p2RiC/dl65/UloAG
 FCYI1g==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785316444; x=1785921244; darn=lists.denx.de; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=js/kIVBcCCFOGSc9klp15bjU5Fmiz6w34BfR4aW9+is=;
 b=UxDSm+mM4dsaVGSiXqyD+OGAe6cG1l7ZB2ZEDlTm9pY1QQq0oweDt0D8xs2W6+xKLn
 27SawCp+Z1OgkkEw+zfFlybFEtfDgxbg8avaEEK2Ue8oHj9PaQmC/At2umq/nMPPgA2s
 ESTHc5aGkpu8Cb50qhehzpYGJpi6BDMIvdmxBZ69O4OGo0ZSTUH7uTnMeDnDIako2BZD
 /piixNQKeOhQgiFdqg6mmz/8KQvNEY40rk2eOcdAzXnqNy4zy1mJ+eA+8+qjNUA0SUan
 EAbm8zbPRQ8nXtzVyJctuTQg5c9rKnnDm30ObcJbANAkkCzjBp1pha7qEspcVMUvVZ3F
 ulSQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org; spf=fail
 smtp.mailfrom=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=bhD44Lof; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=UxDSm+mM
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=badhrinath.s@oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bhD44Lof";
 dkim=pass (2048-bit key;
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.b="UxDSm+mM"; 
 dkim-atps=neutral
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
From: Badhrinath S via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Badhrinath S <badhrinath.s@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Casey,

On 7/16/2026 4:50 PM, Casey Connolly wrote:
> Hi Badhrinath,
>
> On 7/16/26 07:23, Badhrinath S wrote:
>> From: Badhrinath S <badhrinath.s@oss.qualcomm.com>
>>
>> Add default configuration for the IPQ9650 RDP488 board with eMMC boot
>> support.
>>
>> Signed-off-by: Badhrinath S <badhrinath.s@oss.qualcomm.com>
>> ---
>>   configs/qcom_ipq9650_mmc_defconfig | 21 +++++++++++++++++
>>   configs/qcom_ipqdefconfig          | 37 ++++++++++++++++++++++++++++++
>>   2 files changed, 58 insertions(+)
>>   create mode 100644 configs/qcom_ipq9650_mmc_defconfig
>>   create mode 100644 configs/qcom_ipqdefconfig
>>
>> diff --git a/configs/qcom_ipq9650_mmc_defconfig 
>> b/configs/qcom_ipq9650_mmc_defconfig
>> new file mode 100644
>> index 000000000000..de730067359c
>> --- /dev/null
>> +++ b/configs/qcom_ipq9650_mmc_defconfig
>> @@ -0,0 +1,21 @@
>> +#include "qcom_ipqdefconfig"
>> +CONFIG_SYS_INIT_SP_BSS_OFFSET=0x180000
>> +CONFIG_TEXT_BASE=0x8a280000
>> +CONFIG_NR_DRAM_BANKS=24
>> +CONFIG_ENV_SIZE=0x40000
>> +CONFIG_ENV_OFFSET=0
>> +CONFIG_DEFAULT_DEVICE_TREE="qcom/ipq9650-rdp488"
>> +CONFIG_SYS_LOAD_ADDR=0x90000000
>> +CONFIG_DEBUG_UART_BASE=0x1a98000
>> +CONFIG_DEBUG_UART_CLOCK=14745600
>> +CONFIG_SYS_PBSIZE=1024
>> +CONFIG_CLK_QCOM_IPQ9650=y
>> +CONFIG_CMD_MMC=y
>> +CONFIG_ENV_IS_IN_MMC=y
>> +CONFIG_MMC_SDHCI=y
>> +CONFIG_MMC_SDHCI_ADMA=y
>> +CONFIG_MMC_SDHCI_MSM=y
>> +CONFIG_PINCTRL_QCOM_IPQ9650=y
>> +CONFIG_DEBUG_UART_MSM_GENI=y
>
> Do we really need debug uart in here?
it's not strictly necessary. I've removed the DEBUG_UART configs in v5 
'[PATCH v5 0/4] Add U-Boot support for Qualcomm IPQ9650 SoC' - MARC 
<https://marc.info/?l=u-boot&m=178530478539468&w=2>
>
>> +CONFIG_DEBUG_UART_ANNOUNCE=y
>> +CONFIG_SYS_MALLOC_LEN=0xC0000
>> diff --git a/configs/qcom_ipqdefconfig b/configs/qcom_ipqdefconfig
>> new file mode 100644
>> index 000000000000..6a7f3c1b4ac6
>> --- /dev/null
>> +++ b/configs/qcom_ipqdefconfig
>
>
> Does this defconfig build a functional image? Or is it only ever meant 
> to be included by board specific defconfigs? If it's the latter case 
> then this should be a config fragment instead (just rename the file to 
> qcom-ipq.config or something).
it's only meant for inclusion by board-specific defconfigs, not as a 
standalone build. I've renamed it to qcom_ipq.config in v5 '[PATCH v5 
0/4] Add U-Boot support for Qualcomm IPQ9650 SoC' - MARC 
<https://marc.info/?l=u-boot&m=178530478539468&w=2>
>
>> @@ -0,0 +1,37 @@
>> +CONFIG_ARM=y
>> +CONFIG_SKIP_LOWLEVEL_INIT=y
>> +CONFIG_POSITION_INDEPENDENT=y
>> +CONFIG_ARCH_SNAPDRAGON=y
>> +CONFIG_DEBUG_UART=y
>> +CONFIG_REMAKE_ELF=y
>> +# CONFIG_EFI_LOADER is not set
>> +CONFIG_FIT=y
>> +CONFIG_FIT_VERBOSE=y
>> +# CONFIG_BOOTSTD is not set
>> +CONFIG_OF_BOARD_SETUP=y
>> +CONFIG_USE_PREBOOT=y
>> +# CONFIG_DISPLAY_CPUINFO is not set
>> +CONFIG_DISPLAY_BOARDINFO_LATE=y
>> +CONFIG_HUSH_PARSER=y
>> +CONFIG_CMD_PART=y
>> +CONFIG_OF_LIVE=y
>> +CONFIG_CLK=y
>> +CONFIG_MSM_GPIO=y
>> +# CONFIG_I2C is not set
>> +# CONFIG_INPUT is not set
>> +CONFIG_MISC=y
>> +CONFIG_QCOM_GENI=y
>> +CONFIG_MTD=y
>> +CONFIG_DM_MDIO=y
>> +CONFIG_DM_ETH_PHY=y
>> +CONFIG_DWC_ETH_QOS=y
>> +CONFIG_DWC_ETH_QOS_QCOM=y
>> +CONFIG_RGMII=y
>> +CONFIG_PHY=y
>> +CONFIG_PHY_QCOM_QMP_UFS=y
>> +CONFIG_PHY_QCOM_QUSB2=y
>> +CONFIG_PINCTRL=y
>> +CONFIG_PINCONF=y
>> +CONFIG_MSM_SERIAL=y
>> +CONFIG_MSM_GENI_SERIAL=y
>> +CONFIG_SOC_QCOM=y
>
