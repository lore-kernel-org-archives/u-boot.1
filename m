Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95396CD343B
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 15:26:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E105084915;
	Wed,  6 May 2026 17:26:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="cAF7hC+L";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JoY2tRBM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A29B184915; Wed,  6 May 2026 17:26:51 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D81C8490D
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 17:26:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 646E0jOf2427853
 for <u-boot@lists.denx.de>; Wed, 6 May 2026 15:26:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WNLhBpSfreKRlpNk1tw7b6qZn5vYQ3O6hfdGpaFPGuo=; b=cAF7hC+LUnVPt3c4
 X0Cg9E9LRdIUmPB+ojXQZeo1Eo+czSvqPyV0nTn7EluKZSRT1scXQGE3RdZzYTVv
 0WDHzqm3hEB69VM4g1gDhPgb8gHhZFlg5hKrK+nC2RsxLibh0wUGwpT0NyU00IlA
 oaYYwQXJ3h4xNOPxJqV5bZBoeZzWLmXFX4GnQY7OPRhXMjuZ8hfoKV6DjDLsQCdC
 WQXba9PB6FfwfrRy/N20GBh6frqoDt2nuq2GkbFZFQsd1yDlTjUbq2xSHO9t1qbX
 ZOlljbF4IBHmnlAY5T9HXWDAhHkSn9lOJ0NLXOJHcIHbCky82zKX11eJb/t+URaA
 CeMFyw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e01ph1r50-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 06 May 2026 15:26:47 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-36514eb1194so8469911a91.2
 for <u-boot@lists.denx.de>; Wed, 06 May 2026 08:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778081207; x=1778686007; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WNLhBpSfreKRlpNk1tw7b6qZn5vYQ3O6hfdGpaFPGuo=;
 b=JoY2tRBMuwyqGD0VUp+5NsEbeww7gT57zV9noOeNeV4M/YxipiZf23xbeDpRE+o8qK
 rNd1NtkvxjrLW3fdBl/Mg83uGG/TM/ido0fNF1yCO6kaFKkXlVg6H+zXktxHgboBYQHv
 /3Ii5jLfyx5ge8GoPl+uzQmovSOOifympAoocTglbJ0KoEH25HZZjin+TScSA4ArbA5P
 DHikH3wFgNMaNX1yD1I2nlKutgcFZK3nyb5iI3SGsHCEZZRIiJQD5Xw6gfPa4SRoCPAc
 QFghzqz9A+Sz2UljqT46djBeQITWdsAV1cZYMn/leSH5lOScPw497mvLaJexKSDtooP2
 A8Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778081207; x=1778686007;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WNLhBpSfreKRlpNk1tw7b6qZn5vYQ3O6hfdGpaFPGuo=;
 b=JQqHAUEz7bPANKYadNFRZGEN5goL6gkz+zDfmcdh68VF8YMGYVOVjFs7/3DZrGg5HA
 Eh1R5J2o985cWFIXzo/myfvtjMIxLxv5Ohi3zGFV5xOr2p1+qv/R29xud7fFHyj8q+lQ
 pAYoD3rhT4wQ0lZ2elvT6p450TLHsunD0bDtRcYjpUxEt5Y4h1Du7x5sq7dH3fXxPCSh
 gx/o0mlJFu6eIe6OWphwVcqKv+ufkxFZ+yAqLLwaSAdKBKcxcWNIfHA8BmMVs97pllFG
 JorDK7e0OgtjBHLp+uyKCIyGOXNk6apRtkuo4uN4MPOd/aABa/ZX0p9JPa6kVCSsmoeA
 hV8w==
X-Forwarded-Encrypted: i=1;
 AFNElJ9I6a8fvGYgSG2hWqfKjqZkfjCEPXrRCK6JZMXnWE6hvQ+nhSMApDBcFDHGVcDZY8AnxrXtGKc=@lists.denx.de
X-Gm-Message-State: AOJu0YzQXlfM5UpMmiHLCcXc4+67/WL0BEMyD99q50wMDIPEXu5n4wcc
 oBrH7RVj+uDdUOkHoWa3n9TIV740MeCxlvoq6IVZRyzD1yKdpb0uIdbJ68qfV1LgYK5i2DxW6Kp
 ND+LR6WLaBgeQIcbDJXH5zhxUGXGgpNG26Ki4bHAt3i7IYrL6NwTwMn9r
X-Gm-Gg: AeBDieuQxPJ9FEfOUOVkoirMEbVv1Q4SH9pSBw3oVDHinospPaTOxMnyWnU6QIeeJsY
 avJiWJPUxYl/iaZxQtITkgYWGhhdyZk4ZVnA7uBfJkkpsJA99Af8jivETK5GAQ+lSWkl4/TmsnW
 4V4cp7gSm4K+17Gzp99z9XeAajgwfz2rynBKeXD0f9n8ZkEULwUQYFBkjru9VViP/3pULEvmDgj
 ONUlh7C8XJhH6t/bt+2vaAy8vLWB6jKSwEJebj7j/e+IlbL3ECGvxgVOoO+ii/LIHo6RAhzHWrC
 Z+J6MBhcNBrhEnR2oHQwdERBTns4AdkDHUwb4u4jELgGLzIeL0KFA9n37wt1eTlYW5OAQsTy1aj
 C0nokxNrYDO6UF7u/innLHdKxlyvfzF3qwP8L4y/Z0sZmB9xTPgwdKREsBkwnGUm9ZOQL
X-Received: by 2002:a17:90b:5484:b0:35d:a3b4:2f00 with SMTP id
 98e67ed59e1d1-365abad4670mr3609255a91.8.1778081206635; 
 Wed, 06 May 2026 08:26:46 -0700 (PDT)
X-Received: by 2002:a17:90b:5484:b0:35d:a3b4:2f00 with SMTP id
 98e67ed59e1d1-365abad4670mr3609220a91.8.1778081206182; 
 Wed, 06 May 2026 08:26:46 -0700 (PDT)
Received: from [192.168.0.6] ([183.82.205.89])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-365b08feeb0sm1907423a91.2.2026.05.06.08.26.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 May 2026 08:26:45 -0700 (PDT)
Message-ID: <437a2860-fecf-4f45-bbe4-3fb9e8958b6a@oss.qualcomm.com>
Date: Wed, 6 May 2026 20:56:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc3: Fix crash on fastboot exit due to incorrect
 memory free
To: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Chris Morgan <macromorgan@hotmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
References: <20260506-usb-v1-1-e0f426bb1e42@oss.qualcomm.com>
 <a74a7a66-c1f1-4d6e-b85a-49ecc8e2e882@mailbox.org>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <a74a7a66-c1f1-4d6e-b85a-49ecc8e2e882@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDE1MiBTYWx0ZWRfX3gvXhkLkAmna
 YhVQpffmSwuxtuCp/d4hXBChspw3iPpnmK8qyP99V1/PxfnZD/EeZWdhn1BfWAJ3aOwyFVrYEFL
 bs7p7bNecaJUpRZIqcoGB4K3DWpAP6aYy/ZP0OXiA5XKs2Zbo6NtY7qQ09Jn6iEwCT3hngov/aT
 EkURhHY/FOWZ1QekFBv6qIum/ii2wm8AVZD12i+rgznAYSfV0spgDZJioEmIFk+aQBYBGCX95qA
 455xueNyL5Oa7qSdWtvuIeaj5nuqUsLT0tifr7NzIVOyIcdQjJPemKScqHwb0q90kFRPQLQ4UyK
 RKkIZ/qXkHMbsHddkjqcs2Q3DMueK/bbtfPe9B70ORerS+OBGJI3SgviTlFzjilbtfBNaA7Gmee
 t0ZCEW73ZNZpR9AY0NhUnuQ2dXVgNZOyOzM5AFoC/OdPjmtIkNKmy2fJZ2W9zjDEg0OqLF3Isur
 gyEglAHEbPJev0XT93g==
X-Proofpoint-GUID: DsPFqYTz9MEosZldIuO0KjzQ5lLLYDXs
X-Proofpoint-ORIG-GUID: DsPFqYTz9MEosZldIuO0KjzQ5lLLYDXs
X-Authority-Analysis: v=2.4 cv=MYhcfZ/f c=1 sm=1 tr=0 ts=69fb5db7 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=f+zF1XwuGwr39dz+bZsZhg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=fRbKdbYq64vAyn_CajkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0 adultscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605060152
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


On 5/6/2026 4:55 PM, Marek Vasut wrote:
> On 5/6/26 8:14 AM, Balaji Selvanathan wrote:
>> The dwc3_free_one_event_buffer() function incorrectly called free()
>> on event buffer structures allocated with devm_kzalloc(). This
>> caused heap corruption and a synchronous abort when exiting
>> fastboot mode via "fastboot continue".
>>
>> Device-managed memory is automatically freed when the device is
>> removed, so manual deallocation causes the heap allocator to access
>> corrupted metadata.
>>
>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>> ---
>>   drivers/usb/dwc3/core.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index 0dee14c8b59..be198041f08 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -208,7 +208,6 @@ static void dwc3_free_one_event_buffer(struct 
>> dwc3 *dwc,
>>           struct dwc3_event_buffer *evt)
>>   {
>>       dma_free_coherent(evt->buf);
>> -    free(evt);
>>   }
>>     /**
> Does this need:
>
> Fixes: 884b10e86a05 ("usb: dwc3: core: fix memory leaks in event 
> buffer cleanup")
>
> ?

Hi Marek,

We remove only "free(evt)"; "free(dwc->ev_buffs);" from this patch 
(884b10e86a05 "usb: dwc3: core: fix memory leaks in event buffer 
cleanup") is needed.

Regards

