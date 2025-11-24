Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 392E2CFD313
	for <u-boot@archiver.kernel.org>; Mon, 24 Nov 2025 16:19:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8947283E62;
	Mon, 24 Nov 2025 17:19:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="C+xgE7fY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dPg8plHM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6441783E63; Mon, 24 Nov 2025 17:19:32 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAACF83BF1
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 17:19:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AOFv14k4058991
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 16:19:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZZHBWxALcG6ICsdCIG7eOrpAJWfQF5pKcAvBQyMPcSY=; b=C+xgE7fY9OLepSO7
 6Tt2X1zU+HPMJp+vY1vPNtzbTMt16xzm2+MFFGBoU4uq61Yz5ANxwf8xQzRvpHV8
 ct2By4uozTWFbjRe8F+ZLloFti7x6vzQSs30ivX0g+yZ7AcwBvjEGRO6trMVfLbP
 rqpjhl1njSCE+mGzs1EWJjoZukSdH4rwN9bt/hmxewZwV0YhAdHSq1KkePXgLOfp
 eG+hnPs/k1uv5pZwisO7/paXJZK9xQWxflJ3VYSdSaJATXmcHhsP2Iwbped1p7al
 UuDm3RaL/BPuHjob6uhvv3a9FNUZ8Twra2eXRRt3drUmOw6lnIQzDs/s5MPYQY3l
 ffOX8A==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ama09amqy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 16:19:22 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-29806c42760so179429065ad.2
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 08:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1764001162; x=1764605962; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZZHBWxALcG6ICsdCIG7eOrpAJWfQF5pKcAvBQyMPcSY=;
 b=dPg8plHMFHv75t1W0QDvAEGf8ftEq024HQSe+dPRJGZjKfuiUA3qc94AYX6agJlC8y
 07ko9tXTWTO8tl3F99npM/wzDPBYznWi9qzOonmzka1TQgUTSPS5BLG+tNXHrptMIprG
 2KXu2wOLcxDP8/H8IuLKAN681Ux1l7qllYgtEwtuS0E7HnawuLwWat25pKrMcLrn+jgO
 xK8PEccgsV7HHIymX6geWP/vsuTpac01zg9NG74Y328UX/Hs5mK05u1RG7vuaE0nY1fI
 nEGztyiudYOiyvOJMe4Ue9C3xTYiY16Y+AoOH+cZysllol7icF0u8Oby3A9WsklWJ5gh
 GeNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764001162; x=1764605962;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZZHBWxALcG6ICsdCIG7eOrpAJWfQF5pKcAvBQyMPcSY=;
 b=MK7CyawyML2noGoc8ooAQqgjXRXNI4WBh7hxPq6xKCx7mdbmD5t2ALUBIsOlhYTw1c
 iop+4o3ZjWPVQlgbOqWcBW2Zoa5VfMv9i+P2ngdsAB2H96UAW+lhRF52TSF/7v2RMNOL
 Hpmxz5YQGbS8yO5RELp3gQiylO62R89BJHvwBnokfSaETnI4DzwObIju2zImEG0jPyCB
 LrMuwYWp8otxJAH7F5BbDeFXplQGfazIwN6KoXfw5egk0jr5ZJngKk+RxyN9sb21BNor
 xruswPwH9WsdZi5gKsWka4CnxU32Yfai3ADtnXYqKSognUwccf1E3whOodcHfYtzfQtE
 sxHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYAFok6GcWP021Aenvw8CFRBhfSKmBkHXQTPRA2c35mNpPQ81w3QQiBbaLbUV18EPaN1xYyEo=@lists.denx.de
X-Gm-Message-State: AOJu0YxDjUIcw7LG370HJO3osKBEqPfP0Y9WLLJlOagvuzHK7gWqi5Qi
 rSk9NH0qEiXxFZuMOwtI/+VuQgQ4P48dFfI/yHJ5sPoVTP0bS2WQSqn49Qm5TfHo5iKtSPZF12a
 kIYtCWeYkN0MpkmsGelt65v393nO4KzK/OhTVpjoaHXJzn/HihBcDMOnH
X-Gm-Gg: ASbGnct2t2DNyh8qtUIk0GjAwYJv5hRinfM59+S01+SvXNzWfJzN5QPDTbQDcV3Nllc
 RBmoGXhqbKz2JLdQoP+KnIU2Y0CTw3GXYDrFh9DdX9ws1Kb8eNBGk1uBAUq4h0XPPJ73jQkftRI
 HtPy24OvlKWNKL0yJhryxKap98r6rbAPmhAoR056FVmDfR9317g25XOPRLBaZCldY6RcpkUoirx
 nF3Gjo8dbwuhEZqHtKmolhYlvcAkAlJK6JlEHDzYQvJUOaVnUeQ3NhOtGrwVJJM+x+/uAmhmCo+
 Gr/8mhen7HO57NP+t8dW5QRBFKJTsTXnbw+XG2bAyA1chTW6i17hX4bKnHH3T+l3o941t9lPBMb
 l70MFiJwtxAZzXA48boAyCmKhDwH/k3nl7ImOJuQQxOu3vA==
X-Received: by 2002:a17:903:1ac3:b0:269:b6c8:4a4b with SMTP id
 d9443c01a7336-29b6be77f41mr142094635ad.6.1764001162339; 
 Mon, 24 Nov 2025 08:19:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFThAUMtsjz+/n3AKoRdiN4Zo3Hx0H8HrHTtj4K9WHx19wwN/Qu32OxBqHgArev0KWPpD9+g==
X-Received: by 2002:a17:903:1ac3:b0:269:b6c8:4a4b with SMTP id
 d9443c01a7336-29b6be77f41mr142094235ad.6.1764001161875; 
 Mon, 24 Nov 2025 08:19:21 -0800 (PST)
Received: from [192.168.0.3] ([183.82.31.131])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29b5b25c104sm141271175ad.54.2025.11.24.08.19.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Nov 2025 08:19:21 -0800 (PST)
Message-ID: <49744bd5-bafb-414c-a761-e8faf83e0cf7@oss.qualcomm.com>
Date: Mon, 24 Nov 2025 21:49:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/6] drivers: usb: dwc3: Add delay after core soft reset
To: Marek Vasut <marek.vasut@mailbox.org>, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com, marex@denx.de,
 ilias.apalodimas@linaro.org, rui.silva@linaro.org,
 luca.weiss@fairphone.com, quic_varada@quicinc.com,
 mkorpershoek@kernel.org, u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20251119152530.4175628-1-balaji.selvanathan@oss.qualcomm.com>
 <20251119152530.4175628-3-balaji.selvanathan@oss.qualcomm.com>
 <39057967-fc84-46e3-a250-53e877c242d0@mailbox.org>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <39057967-fc84-46e3-a250-53e877c242d0@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: pebDfIEtQfJjLNctbkNjpCyCgPr1pP4N
X-Authority-Analysis: v=2.4 cv=PdHyRyhd c=1 sm=1 tr=0 ts=6924858b cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=JdFg733T8uQF556z/T/deA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=kv_A79fCu33pd85-ikIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI0MDE0MiBTYWx0ZWRfX1lLp9yis1rF4
 pvQiRSXKx6Y1v3NaRhpTr5st+XKwABDYgv1HQRWqq0vZ0yw6jIS2vToxKHmna9aEKoFYjW3TQz5
 AeLNWCAlY1qo5/97yQ0SGbcgHK7SzfDttnRuDfWkn1LdUk0V1hSL2KGAW9UDecN+61AsPoKQ9Rr
 9UL71HCxQRwlq7IwILMjmS/ur69mlzleDlIjRog5iXA36XxgH0CIs446O4s1drielmvXhDQZZwY
 lrlittpyc/d+rAGqB3KBJF9ufmkZ9NcAqJjzmbMKv6cYPcr0j/Qmq20ocQOUxvVadaCp0ycbENA
 QwEpLO5PR/HhLXRAyqQIW2SajI/gEsvHU1hZdKTZNIXjuwewDkvQxuFMSvoSdXyLpM4AS/sPXP5
 2ZhANEnZNiL3+zjMcxkCF+tR0gXonA==
X-Proofpoint-GUID: pebDfIEtQfJjLNctbkNjpCyCgPr1pP4N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-24_06,2025-11-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511240142
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

Hi Marek,

Thanks for the feedback. Pls find replies to your queries below.

Thanks,

Balaji

On 11/21/2025 7:36 PM, Marek Vasut wrote:
> On 11/19/25 4:25 PM, Balaji Selvanathan wrote:
>> Add a 100 ms delay after clearing the core soft reset bit to ensure
>> the DWC3 controller has sufficient time to complete its reset
>> sequence before subsequent register accesses.
>>
>> Without this delay, USB initialization can fail on some Qualcomm
>> platforms, particularly when using super-speed capable PHYs like
>> the QMP USB3-DP Combo PHY on SC7280/QCM6490.
>>
>> The change is taken from following upstream Linux implementation:
>> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/dwc3/core.c?id=3d25d46a255a83f94d7d4d4216f38aafc8e116b0 
>>
>
> Is this the correct commit ?
>
> 3d25d46a255a ("pmdomain: qcom: rpmhpd: Add rpmhpd support for SM8750")
>
> It seems it is not, so which commit added that 100ms delay to Linux ?
Sorry, this is the correct commit that adds the delay: 
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/usb/dwc3/core.c?id=f88359e1588b85cf0; 
Have updated the same in this respin:
https://lore.kernel.org/u-boot/20251124155503.2839766-3-balaji.selvanathan@oss.qualcomm.com/ 

>
>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>> ---
>>   drivers/usb/dwc3/core.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index 847fa1f82c3..ff0bca0dd8e 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -94,6 +94,8 @@ static int dwc3_core_soft_reset(struct dwc3 *dwc)
>>       reg &= ~DWC3_GCTL_CORESOFTRESET;
>>       dwc3_writel(dwc->regs, DWC3_GCTL, reg);
>>   +    mdelay(100);
>> +
> Is this DWC3 specific or QCOM specific delay ?
It is DWC3 specific delay.
