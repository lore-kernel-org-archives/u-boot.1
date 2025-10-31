Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A72CFCCF9F8
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 10:12:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0F7883642;
	Fri, 31 Oct 2025 11:12:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ARuYwr0G";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XjUnTP5E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86629836F0; Fri, 31 Oct 2025 11:12:36 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 439F68331F
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 11:12:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 59V1n3kX1572066
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 10:12:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fuyv9Qf6NHtKrG6rRjNZXbsxEzf8+7BSnah3di7lIls=; b=ARuYwr0GK3t+yQqW
 gWpymvG2BEuy3QlN/gq/O9OvBCV9lkUqpp237q17VfEdS58y9sWoZfj2uYdwz71d
 TmiN07nJ1HZ7bs59SCv6vT7OW4WtnIvb1e4CVXNB3WQqhHk5HktP1haQI++da2/S
 Sr2dRhJIuV94h5IJm5hTtkcGUnwYqOqvM+asC+1z+igwQb5u/UH0POH7Yz7/Rt4j
 0OJIcf2/9ZqzyxjKPPI676ZVoAK9eTcQrX/K1DDscN/OX9Zn51PBrviNRQu25FXv
 n3ATgzj6KdCPTENa4fzqD/Qgt/L68D59qs2SEXplHX00J0lce0iD3NFDthWgOvlH
 RmD10Q==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4ksc17yu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 10:12:32 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-7810912fc31so2142565b3a.3
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 03:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1761905551; x=1762510351; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fuyv9Qf6NHtKrG6rRjNZXbsxEzf8+7BSnah3di7lIls=;
 b=XjUnTP5EZcD1gsrQNOtbyYdyi+eBsM57tozgVaNrGCxsJLhgEKHC78mBglRNDynlzt
 UlxKsr8SjBAf0T4l3jdnP2nH7rdNsEBo34lIFfsyMb31Y2i8434YoxLCLm2t8574Aitz
 bob77vM2rh/cPF0GZDj3S9oatl+Z+WtIuakOkdMtCtydHdIIqCWSEUD6yE5s0XK+VCPz
 S/Qf/mvnd79yE1VJvVriEuNZEMQRamOIic5AhCdzR7VtQVGoElE0U99ZuFmOxvU7HYUs
 XITTDIl5wc4AAb5JLUD75BQzqHUaBkjsOrt8bHFZFSd0VZr3URYX3lmvJPbG/JlEgCCU
 RdGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761905551; x=1762510351;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fuyv9Qf6NHtKrG6rRjNZXbsxEzf8+7BSnah3di7lIls=;
 b=kQPuBXFVA1+844dwqKMn2+uufIlh5E65vxp5PrfpgEzTUYcYviD4tZpb1k1wrZAYPB
 gpF6aX9l6Jv1a/aeGd0J0rBUxYNa4mbeM380qL4yw/bYb6qySr/4OBoQtAmTqFQmLQTc
 vzz8k4nEqHm6OUNTgdHVg3U6BvoJ4BIF1xySs+iebq9zUPYovn9h2TDOtPjH8o6bOz6D
 agljNWYHR1mTOqhe2vNBV+FGy7NFXbk9/mfEO7DgHNS0kuP5c4HwHzewT68sfcZryzLP
 C9/8W8MTqZseuOKryyDJ+o479/oGukufpsO431dmOke2pyhRW6a/mLaK+F7CRySHxpo4
 uWpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/mOW4jHGRUIAceMwziRRarWUSKU+vW66tNnpo7npsbDv+QPQEsvhs8fx62+LY+P4whjf70QA=@lists.denx.de
X-Gm-Message-State: AOJu0Yx4z+BI4B2mny86gDjLo8BBVOg9LNZBcyXNPVibapDQSiGYDTrC
 qm5l1tNVdGf6ZOoYGhhVP04u8lrTP0LSmj8nzuX2qktOqo/HFDTlBUBwvYGZsF6sZJCVvO9vB/O
 cge1UewHuqScHRDTMTcD9qtj8Id6jgpJF7NkaZslHf6sSocm7hAwD8BYF
X-Gm-Gg: ASbGncsZ8zMZ1V107pFe8RVUZTBU5SxkWQIJ+bE8nGZ/65eJkZfg+IQK89R4m21FukW
 5Tmlq0dkFl8xV7DTBefXI2UFASbnQ1zKK4vtdnVo2UfB3cHADZlGcyWByzLVOjh8OS0foaxk/rk
 HqqTlb0IPi4o1ly84IqWPt3XIuLJAJU6FgO/QHmsg/RX3cVvRiFO2qwsxoUQ10H33eQjSmW1S9X
 qzCMbWkf7wHEZS1kXobHl+WZMxG8Uk8QUXWJxPBUhXkEmTg6byadvKnRCr1iBoEIfjprS+BXks9
 pdnVLgqkCLW3ugKj4fjDeujDQmcIiqJCkIsGfrZMNxGbOdB9hkMJ6jbSBBm85sqSzke5Nk19+Y4
 61NB6glBdKRAVyFKoaPKD/uMjffrzbaY=
X-Received: by 2002:a05:6a00:2d9f:b0:7a2:710d:43e7 with SMTP id
 d2e1a72fcca58-7a7799aff2emr3668631b3a.24.1761905551475; 
 Fri, 31 Oct 2025 03:12:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlLkyjNqWx/vJ2Qi5RJ/OmvtL0RRZpkMaukX2M/Lw+reqXV0MfGHgVHy17Bd/jeypU1XZi+g==
X-Received: by 2002:a05:6a00:2d9f:b0:7a2:710d:43e7 with SMTP id
 d2e1a72fcca58-7a7799aff2emr3668580b3a.24.1761905550882; 
 Fri, 31 Oct 2025 03:12:30 -0700 (PDT)
Received: from [10.152.202.155] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a7db681f4asm1666151b3a.62.2025.10.31.03.12.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Oct 2025 03:12:30 -0700 (PDT)
Message-ID: <3af79816-26e0-4403-988f-29858bf569d3@oss.qualcomm.com>
Date: Fri, 31 Oct 2025 15:42:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] mach-snapdragon: fixup power-domains
To: Neil Armstrong <neil.armstrong@linaro.org>, trini@konsulko.com,
 casey.connolly@linaro.org, sumit.garg@kernel.org,
 jh80.chung@samsung.com, peng.fan@nxp.com, rui.silva@linaro.org,
 ilias.apalodimas@linaro.org, christopher.obbard@linaro.org,
 quic_varada@quicinc.com, me@samcday.com,
 marek.vasut+renesas@mailbox.org, michal.simek@amd.com,
 alif.zakuan.yuslaimi@altera.com, tien.fong.chee@altera.com,
 balaji.selvanathan@oss.qualcomm.com, miquel.raynal@bootlin.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20251027113312.3815169-1-aswinm@qti.qualcomm.com>
 <20251027113312.3815169-4-aswinm@qti.qualcomm.com>
 <ea83aa0d-9db8-4a7a-8b4e-bf32c9aa4ffc@linaro.org>
Content-Language: en-US
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
In-Reply-To: <ea83aa0d-9db8-4a7a-8b4e-bf32c9aa4ffc@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDA5MiBTYWx0ZWRfX6YQ+hp/CXFQz
 hyBGM6f6xxDzRu9/v1ew/PCzjdsTIvSegKobJs6TTF/rS3PjDYqIdGLAibn9P/zk7If9jKuzA2q
 ELXvbZyrtyRVHsRzgtt6hEhn9o7XvtZF3taS+15Fh3/Ibp18h4DlB4rRkS77NAeEcHYBDUY3CMd
 ySqwe/JqJtno/yzbexGOrW1CYKc0fNhyaMP+zmZVlmnZEpZNh5fHW8+LrV4XYc8J+qwk0RmrIfc
 uw1CtNdduwRXssnxPJejuoEDHNhYzw4JAvikaZlzfFn9Bw/z3fGkMaJtuYCD7uSdYFjev/BNmxw
 2ZE+kdb7wAto1bzMKgSutsHreiJZbGKB4GBNQjIvyUKDP7/nHEvdKgYoQ2lPNoQ6/TMHhzGJAMu
 yM0EdN13GD0Smbms1wqdj2vEG3HrkA==
X-Authority-Analysis: v=2.4 cv=Q8PfIo2a c=1 sm=1 tr=0 ts=69048b90 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=tvshNE4mzlgVatfoYFEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: uYDXAtlYjz8kTwWrDbb7hie08rZ--6TN
X-Proofpoint-GUID: uYDXAtlYjz8kTwWrDbb7hie08rZ--6TN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310092
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


On 10/28/2025 6:32 PM, neil.armstrong@linaro.org wrote:
> On 10/27/25 12:33, Aswin Murugan wrote:
>> From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
>>
>> RPMH power domain properties were initially removed from the
>> device tree due to the absence of driver support. Since RPMH
>> power domain driver is added now, the fixups are removed.
>>
>> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
>> ---
>> v5:
>> - No changes to this patch in v5
>>
>> v4:
>> - Reverted the inclusion of qcom-rpmpd.h header in pervious versions.
>>
>> v3:
>> - Removed OF_LIVE_SA8775P config, since there is no SA8775P specific 
>> fixups are done
>>
>> v2:
>> - Removed the power domain fixups, since the power domains are 
>> handled in qcom-rpmhpd driver
>> ---
>>   arch/arm/mach-snapdragon/of_fixup.c | 31 -----------------------------
>>   1 file changed, 31 deletions(-)
>>
>> diff --git a/arch/arm/mach-snapdragon/of_fixup.c 
>> b/arch/arm/mach-snapdragon/of_fixup.c
>> index eec2c0c757e..93c16821e54 100644
>> --- a/arch/arm/mach-snapdragon/of_fixup.c
>> +++ b/arch/arm/mach-snapdragon/of_fixup.c
>> @@ -116,36 +116,6 @@ static void fixup_usb_nodes(struct device_node 
>> *root)
>>       }
>>   }
>>   -/* Remove all references to the rpmhpd device */
>> -static void fixup_power_domains(struct device_node *root)
>> -{
>> -    struct device_node *pd = NULL, *np = NULL;
>> -    struct property *prop;
>> -    const __be32 *val;
>> -
>> -    /* All Qualcomm platforms name the rpm(h)pd "power-controller" */
>> -    for_each_of_allnodes_from(root, pd) {
>> -        if (pd->name && !strcmp("power-controller", pd->name))
>> -            break;
>> -    }
>> -
>> -    /* Sanity check that this is indeed a power domain controller */
>> -    if (!of_find_property(pd, "#power-domain-cells", NULL)) {
>> -        log_err("Found power-controller but it doesn't have 
>> #power-domain-cells\n");
>> -        return;
>> -    }
>> -
>> -    /* Remove all references to the power domain controller */
>> -    for_each_of_allnodes_from(root, np) {
>> -        if (!(prop = of_find_property(np, "power-domains", NULL)))
>> -            continue;
>> -
>> -        val = prop->value;
>> -        if (val[0] == cpu_to_fdt32(pd->phandle))
>> -            of_remove_property(np, prop);
>> -    }
>> -}
>> -
>>   #define time_call(func, ...) \
>>       do { \
>>           u64 start = timer_get_us(); \
>> @@ -158,7 +128,6 @@ static int qcom_of_fixup_nodes(void * 
>> __maybe_unused ctx, struct event *event)
>>       struct device_node *root = event->data.of_live_built.root;
>>         time_call(fixup_usb_nodes, root);
>> -    time_call(fixup_power_domains, root);
>
> I think the fixup should be removed only if QCOM_POWER_DOMAIN is 
> enabled, no ?
>
> Neil
>
> In line with the previous review comment in thread Re: [PATCH v1 0/4] 
> Added QCOM RPMH Power Domain Driver - Casey Connolly 
> <https://lore.kernel.org/u-boot/5afbdafa-a0f9-4146-b64e-8869f68bc7f8@linaro.org/#t>, 
> which recommended the complete removal of the fixup code, we have 
> removed it accordingly, also the QCOM_POWER_DOMAIN config is enabled 
> by default in qcom_defconfig
> Please let us know if you would like any further changes or adjustments.
>
> Thanks,
> Aswin
>
>>         return 0;
>>   }
>
