Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C505CD342C
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 04:39:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7665B84903;
	Thu,  7 May 2026 06:39:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="PrAktIaL";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a9b7VhSP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B43F8490D; Thu,  7 May 2026 06:39:12 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AF8A848FD
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 06:39:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64745o6I879575
 for <u-boot@lists.denx.de>; Thu, 7 May 2026 04:39:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mnY8pIyNJlMEjfxYUfYGdqyHaYYc73N0QKyzcLkpTQM=; b=PrAktIaLvPTcILxO
 ZmELockNjRBbhlgIQIvazqNnfAoey8CFoT1edjOInoHPNkunTzDL5VDmqEFN/KrO
 7p8+mh6wfQ6yX0XyOAhmTRgsuqw4LyCQLM3kB/G6QcsObSVsHOrHx5RP+or8hOON
 eFIS1xbqCku1Q6bBrfxVXnbJgdehIF5Rr8a92zs2pNLj8+PIDTUa1LgMFVz5brgt
 QItVZOxZf0uIRLVMuRjzxeUrkiFYDgD4fbRPoUmm90NXpivgyv9LUO++sUEomPlL
 1iyLQaEW6L18QNx/irqBm6DOWdrgUDIM8SmTj6aQDPErwh2N6Sm6uCMTPgsj6wwP
 uczi4Q==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0kdq02gc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 04:39:03 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-365ff2ab7beso527870a91.1
 for <u-boot@lists.denx.de>; Wed, 06 May 2026 21:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778128742; x=1778733542; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mnY8pIyNJlMEjfxYUfYGdqyHaYYc73N0QKyzcLkpTQM=;
 b=a9b7VhSPvxgF9d29U191l5Hhren8xlZyKnCLmfxO/9WJOOc4UJI/p5gS2FYDuoY0jJ
 /UiyUQMKzPX/wCWhCJPwt/z2opFaHuL82YSAW6YckWsoqwxk3UVjpyy6PLfDkq2j7A0y
 Xk3r9EOSayDnX43PvHEthH96/Wt7MYzMxMOdj+wjiqTBWb5KaLDl4fAhn5uPQzUlIF/c
 GtpOXnaoTVCZHPrnorKAzggoNLsrnMYHMT788/7MUvlHIWXlDP4MNTg80lRl7ao1uRq5
 7DsNWatrhHhXmryIRz42Nst3HYTAaZPlo7MkxE0/EWA/eU+ZJGYsbyRsOhIygYWkgRs5
 f0rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778128742; x=1778733542;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mnY8pIyNJlMEjfxYUfYGdqyHaYYc73N0QKyzcLkpTQM=;
 b=PUWobLSXMOq8hl/XTMvDahhpWWpZptnB9FrrZkDQ4vBeyMI5A3JRP/dcYBABFItEGU
 6KXqP/61M6Qez+0FDn2nAyJ9PB0bxQmF//qfq/aKvD+hGf79URQClUL4E+La9VN08/T7
 qvA/1kHaSu3DBXGFDjmp9AeM4+ANXtAKyCBUXc5roUyczBeqRgy+gONgPHTuMbAFWuyf
 jSJxqlc9aeN11Z/sAXSr4KvHHMXrITZJ8v+UfJNwCWgRGA1vFzKxdN+JZbvt1K4HOp1Y
 dlme8q7Je7jjXrxFn1sCjZPLHKA2Brps7vsG19JIDjHtrMWvaNK+0dSz8hPSOpNfekaD
 Z6EA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/F95wrmzFAXNOuuAglvEGFpkoKZQY5o5o9D/j8d/Rl3RVzWmd3QUvHSTyGQCxe3aonmCaKh18=@lists.denx.de
X-Gm-Message-State: AOJu0YyNplXAR/vfRM/kikf+KuR+CQsTKCol9xUsZuFTPyVn/uOdR9Pp
 9kFF9UpgtalCEnmmWuXQf/SmBbXDRIvMgYvxrW0YcA9LjpzkEsP3io6K0xKrzuxvx+8son4ep9r
 cTmEDupMNZV7xVgAA05FZBzQwIqzM8kyW5aQGYcD3NuQPZeXLypTH+EXO
X-Gm-Gg: AeBDietTqdp6IPNBr9KMsKOtP41Vy611EYFS7MuMs5SymL06Ez0YcflBY/7j6l4s/fp
 VKaEp2RUOFpMrZQHd1CQKNuvBHyyc7BHWzl7JCBBMWdIn5A9rZ8uYino0VT6pocmui4FdFky5on
 ODNgxQbKdcq2o3I9l+rZxzRezNBpe7zrWiNT1wjaBX3u8kcbf/jTqK51lCe7YHzymP1t+fWTdu6
 0OmpWG4mMWsd7a7Vrild8MJBUeI+NsUaok5vBc+/rPfTf2RfMS69NmJz6eDKJuC0U/hXEjelDkT
 udShs91v6IMUmeIVUvmMk2HYp3S7NosnRQex+WGPYIvvIe//fQqoyVZuvBTIW52DnILRAWwMmgl
 3PnNqDIlUHPC6bqxnVYVbxh53agOlij2RWn3u2Grw6izamullSIFr/K4ay7EJh1Ibw+Xy
X-Received: by 2002:a17:90a:d646:b0:356:21e9:73ff with SMTP id
 98e67ed59e1d1-366055e69demr999253a91.11.1778128742351; 
 Wed, 06 May 2026 21:39:02 -0700 (PDT)
X-Received: by 2002:a17:90a:d646:b0:356:21e9:73ff with SMTP id
 98e67ed59e1d1-366055e69demr999227a91.11.1778128741710; 
 Wed, 06 May 2026 21:39:01 -0700 (PDT)
Received: from [192.168.0.5] ([183.82.205.86])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-365b4f75f25sm4362822a91.10.2026.05.06.21.38.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 May 2026 21:39:01 -0700 (PDT)
Message-ID: <5c6feffa-1f21-45df-ae2e-c313393593cc@oss.qualcomm.com>
Date: Thu, 7 May 2026 10:08:56 +0530
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
 <437a2860-fecf-4f45-bbe4-3fb9e8958b6a@oss.qualcomm.com>
 <6320a41d-77ce-402a-935e-ea5b6566452c@mailbox.org>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <6320a41d-77ce-402a-935e-ea5b6566452c@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=P6IKQCAu c=1 sm=1 tr=0 ts=69fc1767 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=zmnrgFrZdAT0tyz+jvxjSw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Mteuuo-1QxKlh2dnY80A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: h3deT1XKx_C6KQ5mdEp3facwdxEo6eez
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDA0MiBTYWx0ZWRfX79g9N4lx0GMw
 9YDSh9olfKRsP/0WbHAmy6qOWLPifX4Nj0HIQJSsLCSAv0vFjbCElHXTJ6Uh6YlxMABheDubcqZ
 bFQZQX6U6pXt2KasJukyRmjad0u4l2sZmkghIb2hC1LZ6PAZdKnbxYs94Qn6vWb904UeQU5R9kG
 eQ6iZom2stC9/KeejtATXYRhlj4Pv361vFE00Zq1cKrqTirJyd6mWUD2xoQiZbTredo2wXWhH7/
 H6oOZjRJPnCt9oHdq5wasqbt7p+Qe05LjST2Zx4LrL9b53Trcju1rz2mpaU6VwLkqpBuMN7n0iR
 SUDaDY56Er2vjTHNO5h4RFLePt3iWf5EF7FN+UdmtWZRmC0QQxAXUed8MDCbi3ZB/t2BSYkiZkN
 ac9GGQUQ8Z5gOSVWWMEf84dc8hQj44WOD20FGGdvwLwEZ80x2JB6OZPbULYLnrYeOUtQzl4PqGh
 E2+ZgWAhNTfbfP3xV8w==
X-Proofpoint-GUID: h3deT1XKx_C6KQ5mdEp3facwdxEo6eez
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 clxscore=1015 bulkscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605070042
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


On 5/6/2026 8:58 PM, Marek Vasut wrote:
> On 5/6/26 5:26 PM, Balaji Selvanathan wrote:
>>
>> On 5/6/2026 4:55 PM, Marek Vasut wrote:
>>> On 5/6/26 8:14 AM, Balaji Selvanathan wrote:
>>>> The dwc3_free_one_event_buffer() function incorrectly called free()
>>>> on event buffer structures allocated with devm_kzalloc(). This
>>>> caused heap corruption and a synchronous abort when exiting
>>>> fastboot mode via "fastboot continue".
>>>>
>>>> Device-managed memory is automatically freed when the device is
>>>> removed, so manual deallocation causes the heap allocator to access
>>>> corrupted metadata.
>>>>
>>>> Signed-off-by: Balaji Selvanathan 
>>>> <balaji.selvanathan@oss.qualcomm.com>
>>>> ---
>>>>   drivers/usb/dwc3/core.c | 1 -
>>>>   1 file changed, 1 deletion(-)
>>>>
>>>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>>>> index 0dee14c8b59..be198041f08 100644
>>>> --- a/drivers/usb/dwc3/core.c
>>>> +++ b/drivers/usb/dwc3/core.c
>>>> @@ -208,7 +208,6 @@ static void dwc3_free_one_event_buffer(struct 
>>>> dwc3 *dwc,
>>>>           struct dwc3_event_buffer *evt)
>>>>   {
>>>>       dma_free_coherent(evt->buf);
>>>> -    free(evt);
>>>>   }
>>>>     /**
>>> Does this need:
>>>
>>> Fixes: 884b10e86a05 ("usb: dwc3: core: fix memory leaks in event 
>>> buffer cleanup")
>>>
>>> ?
>>
>> Hi Marek,
>>
>> We remove only "free(evt)"; "free(dwc->ev_buffs);" from this patch 
>> (884b10e86a05 "usb: dwc3: core: fix memory leaks in event buffer 
>> cleanup") is needed.
> The Fixes tag is only a reference for posterity, to trace which 
> previous commit this change repairs. The change itself is fine. Thanks !

Hi Marek,

Got it. Thanks for the feedback. Have added fixes tag and respinned: 
https://lore.kernel.org/u-boot/20260507-usb-v2-1-3958b8732553@oss.qualcomm.com/

Regards,

Balaji

