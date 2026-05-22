Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9703CD5BAC
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 08:48:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 718B5841D7;
	Fri, 22 May 2026 10:48:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="es4cYqwB";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eaf/gyo8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45CD48432A; Fri, 22 May 2026 10:48:54 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FDF183E76
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 10:48:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64M7XBjC778703
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 08:48:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZfqpTUX0OeI/beKB4KoXFsyWvVf3umgnzQ3dR+VI+9U=; b=es4cYqwB6iBbJDYb
 L0qIX+a2aYLtqb3JG3/9GPangenptGklWqQsQmmIIFc6XMjoiulPENeztY22bZP1
 uKwGFIejrukbAoHAGVnJ1Jgz3dFTRKkoclQ0Zn7dKDr+lPqUGe+YplUJvMGs/vQi
 4eWwWVliBc0RyitNUfXIWvPxJwSENEeEehs/QQdkXfE/4L5gA1SN8f41/h+OYb7G
 k3DAO62VoHpez8RkZdhh8DRzP/sBILIMOF+0CZanpxri8E5+KSkZxM9d8GmDMy0f
 RnrPPKzelXV8ZNyMtxye7/BtKSYfocSUhbMSordnT24KskWmyyX92sE1B+bcWjGy
 NLLfhw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eac7asur5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 08:48:50 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-841127f960fso1770080b3a.1
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 01:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779439729; x=1780044529; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZfqpTUX0OeI/beKB4KoXFsyWvVf3umgnzQ3dR+VI+9U=;
 b=eaf/gyo8VxZbexiqqF7SVMWD3UD+M9VCZG0D0w8rKnhob1AieaNW/9w6lpjMYxtykn
 9AW00+U4baRPFkhGC3DxhryAMkKRT4dvuU3MQAQ6VVG3jL5aMQzosH+7d66oiJLNhF7r
 ZJYkUxH1CAMQDIrwlVoVzDYY2o99zesKU0oR6ADAT3EWuIn+/kKpa84mq6ZjRIjx1QO7
 lY44vLL1vPWEyrhLrpIB1Lw9mLXgxNJmDwAgZc23zOkLu7oeOEzp+YtJDgOh9dCMaVQ5
 HbrXWnNijwgCUHapowEproA3hEE0fLEL0jgBt7kK+NDvDRCOjbqVN3bxI+FghXhASqdZ
 GOaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779439729; x=1780044529;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZfqpTUX0OeI/beKB4KoXFsyWvVf3umgnzQ3dR+VI+9U=;
 b=KWIEq86QsKXDGzJBrC9j9E+YV/XsINmGYkEpHuQKlnvbIQ0TPRTlnnDUctsbmldta6
 id7/SIrk2vjD4tQWj2QSWBvI4sdZLcZ+C8TLZ7EM7GwfPHuXtb9wVID9d6Ja+bAzY/Ct
 rUmzauZXjqZePmhQXO1KMs0I6H6EbroVNBN/ryKvcdB6VRPIf0jV3U0pudjkQxZvXKZy
 VmuDMEQ/iLvf1f6T3R3rKRaIW33BLCQ3vlx2FHtsWdz0eTUzbMPUEKlXVmOh8K08Phx1
 wQ62PrX/+G5qqjxKoVB3onJGaWli/R4W3GYPnqLxG6k8ikjpd9eLj8BzjNNIx+VZ/GQS
 D5qA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9EzCNOfbip/gPx0KlYvgT/5HM3D+9a6rnpR9ElhgXAYwFsYZdSYD0TITW68EVlg7/h3Egc1RU=@lists.denx.de
X-Gm-Message-State: AOJu0Yyoa74K447Szt1RGspQZWbun8bhkFSma0traTb9k8Vz7yGeJxD+
 4n0A0qgaWteh5xiIx1EJXNaqMC/CBEbk8CRyujHvGrs56SRC6cvOYeKfLKNNRhzlbH3GGEtYT/G
 3oblpwF7XrVNT5Fss4W0QK8TKfC6IX+NiP/kNE2SqFBVieavc8RZC9kvA
X-Gm-Gg: Acq92OEL/cH/5J231YcNaStb7aeLvpjMIj/Oi/0H4w9blcoN0Axh0NSlAo4uejbQ6e4
 icsyCl363Pxx1AiICVwC6ytOUTmgfv9yW3m072+XGkahzOocbenDTQ0E1Z+r3aS0ieSkMSvR205
 fjfrPV0382JYIUQVY6zFFGprIIYfYQHfqaL9lZM1TGSfD6kHplKuO8vswZjtYjSABsOs5hW91I4
 SnVy7tWzK8mFZ7bnZszpf6nifdG0noTYnKVn/PgRxMGoLNg6MnPVWkSw+HmBea7+MUMYLQg0da+
 bvVsC7brMUNtt7xoauRNlHy8JOc0mGLGqj+bYunGoImweiKGIX+vVpf8swy1s+ZpJKL0beljqbl
 518RqghRebh8s8vvRnprYiDbGB7lC4wCRWrnq5hBHx5sTQLnxForQwing35EFgpDiCA9hvQ==
X-Received: by 2002:a05:6a00:1d9e:b0:835:38db:82f6 with SMTP id
 d2e1a72fcca58-8415f69ea9cmr2795183b3a.36.1779439729515; 
 Fri, 22 May 2026 01:48:49 -0700 (PDT)
X-Received: by 2002:a05:6a00:1d9e:b0:835:38db:82f6 with SMTP id
 d2e1a72fcca58-8415f69ea9cmr2795154b3a.36.1779439729062; 
 Fri, 22 May 2026 01:48:49 -0700 (PDT)
Received: from [10.151.41.190] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84164e9ec47sm1505384b3a.32.2026.05.22.01.48.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 01:48:48 -0700 (PDT)
Message-ID: <b735e9de-4149-4520-839b-d730bef088cc@oss.qualcomm.com>
Date: Fri, 22 May 2026 14:18:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] configs: qcom: enable FIT capsule support by default
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Minnekhanov <alexeymin@minlexx.ru>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
References: <20260522-capsule-v1-0-ff0ac9978d48@oss.qualcomm.com>
 <20260522-capsule-v1-5-ff0ac9978d48@oss.qualcomm.com>
 <CAC_iWjK7JxPaDDe7CZt6O_MdGr-wvVkPLmsXR6Pc9V9JWnigzg@mail.gmail.com>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <CAC_iWjK7JxPaDDe7CZt6O_MdGr-wvVkPLmsXR6Pc9V9JWnigzg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: pKtXN1QeZ0W9ChS348yZ7bp2ofEZ-GDl
X-Authority-Analysis: v=2.4 cv=JrbBas4C c=1 sm=1 tr=0 ts=6a101872 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=yG67udE4ScOC-Wf4i7AA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: pKtXN1QeZ0W9ChS348yZ7bp2ofEZ-GDl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDA4NyBTYWx0ZWRfX/3qC/K2JRhcK
 yTV0TPSJU/lfWcEn79Nm3I3Z2GgPTPYAWhEByjfVIUJjQfGyvKMhY8Z9MSFgsUpSSgk1YcSfKbV
 pzM5tP7LnYJ6aiDgQA4E5bu6Qwo+rdGmSIyPuq8YqF/DaLBKdW66dpL4NLaVbqqjYvNwLPJHKqw
 CYgSzH8Zq1dDep4rApU9BaHuWf2XBIL1w1SMi75wf5PWnl3n2vb7+SGbHKkfiinmQ4qOieet26V
 VilRpRaQZxecRSjLjE7YtpqkWco4VbbTgQJM1rHU5YInXW9HTjP8PtcdT5LMojQ89WwSmUmnFJt
 ZakwPdJgpYOfpkhf+VHOmWJVKFGZcOKy4uLw+5TtzECGFwGz6cZVswcRidZxKvrNUsU7WLbgN9n
 k52XpWJxot1lRtwLbVplrwkGYbV/3FOlvGVNbSHnBvHl673rx7waCNyJsy8MmFypqlcPUdEbuen
 05ph7Utz0XbkL8nZvIw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220087
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

Hi Ilias,

On 5/22/2026 12:16 PM, Ilias Apalodimas wrote:
> Hi Balaji,
>
> On Fri, 22 May 2026 at 09:10, Balaji Selvanathan
> <balaji.selvanathan@oss.qualcomm.com> wrote:
>> Switch from CONFIG_EFI_CAPSULE_FIRMWARE_RAW to
>> CONFIG_EFI_CAPSULE_FIRMWARE_FIT in the default Qualcomm
>> configuration.
>>
>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>> ---
>>   configs/qcom_defconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
>> index d0d54ec5a70..25059d2e6b4 100644
>> --- a/configs/qcom_defconfig
>> +++ b/configs/qcom_defconfig
>> @@ -9,7 +9,7 @@ CONFIG_SYS_LOAD_ADDR=0xA0000000
>>   # CONFIG_EFI_HAVE_RUNTIME_RESET is not set
>>   CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
>>   CONFIG_EFI_CAPSULE_ON_DISK=y
>> -CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
>> +CONFIG_EFI_CAPSULE_FIRMWARE_FIT=y
> Why? The reason we added FIT back then is that we lacked capsule
> authentication. Is there a reason you prfer FIT images in a capsule?
>
> Thanks
> /Ilias

We want to use the existing FIT based framework (in efi_firmware.c), 
where we store binaries of multiple firmware in a single FIT image and 
then we place that FIT image in a capsule's payload. By this way, we can 
update multiple firmware ('s partitions) using a single capsule.

Regards,

Balaji

>>   CONFIG_BUTTON_CMD=y
>>   CONFIG_FIT=y
>>   CONFIG_FIT_VERBOSE=y
>>
>> --
>> 2.34.1
>>
