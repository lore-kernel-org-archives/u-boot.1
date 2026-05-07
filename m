Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88735CD343F
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 15:25:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9D5E84A7B;
	Thu,  7 May 2026 17:25:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XybYr2/T";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gIbspwEo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2E2084ADD; Thu,  7 May 2026 17:25:41 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C18484A44
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 17:25:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 647BTrH1682778
 for <u-boot@lists.denx.de>; Thu, 7 May 2026 15:25:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kLlIvB12g+n12hiCi+MMmkBPyde6nykwNuD6bRl9B7c=; b=XybYr2/TE1g5WFIE
 w6nvqubDUxRjQpaqBSxJJqE6ky8F2OKL2WKcTIKkYPQ93D29iBMmrcoyRBg5t2aL
 PlSxFFsYlINqLEDjtJ2sq9XnOFACxdPPBLtE7YVbwe1HrLMhMYWVjsOIkCTqF870
 r370mJO+XBQ5fKTalKMtWHH9VAzpxSoAZZkywGIjJkBx7rb97vFBkL+0DnzPYDgv
 KcovytjcLdW9+ZfHaOXtxvDLBB0cHrb9xlSZsusE67iXkkHiJmBvY2wQ86g3p+wX
 vMVd3PMfNqq+MiXzfW0zWYruTzolUFXqF5i22lQBX3rl2e82B3kFRBhJMw0/eoCu
 ccWiUQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0mhat8fc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 15:25:36 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-82fa6c3a77cso644694b3a.3
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 08:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778167535; x=1778772335; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kLlIvB12g+n12hiCi+MMmkBPyde6nykwNuD6bRl9B7c=;
 b=gIbspwEoYtnvJAV26srZm5qIFNdEMzJElMg0T98fCAMIwA2MOm5lw7cJcvg48j8w3o
 ZxA9oPTZuQKjKr+Gl3rNk4ZX2UOKGc6Zn2pBZy6Y5BYrHjlbVR4Y5QJpaeN9qfDCSYQk
 mo/1mcMjZQTiVvQHrURcZtjnqSjK/tIcR1QaEzKunv1hBMQy/KLhVDEVAsCsIirkp9+4
 mjncmGFix58vjCb9j3miYDaX5ue7C92p7rQ+2fjC0d0GPCQi1rQMhWWnS4v7W0IDWKvS
 r4WDtMABh7fQtIgz4djVKNvD6U9IzkdqKRlte7w/Ibx8G14hBxJFSnFFw4MjPt/QXdXI
 IBIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778167535; x=1778772335;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kLlIvB12g+n12hiCi+MMmkBPyde6nykwNuD6bRl9B7c=;
 b=Sm58IwFE0EFAyVj53mPGJZ5JGOxur12KE8bQck0sfnD6lWS/RRj4GmAc3YEfbOzVuF
 YOFs3a0nxAUgdUpg4l4PFTBaYV57aCUOz4vTgX56Lf6TS75LA2EzJEbR/EEEYurj9sYv
 eDpQir2kWE+Jw1YV+qIglGHIIQCcXKlmPIPI4il+uWZbyfARc807qkMtGguba0vZEXVo
 9EKV3wIzbjkcx+GnbIX0CmGLXnQCU7gUXFxfNcQXb4R/U6M0gWiF0rdyR6uxWF0oZ7Hy
 xa3JSLcnKOj5XdVFmt3Dwd2hstqfelgtYjsbw0zdu2p2GYCrfIIYnzoSdUbp8FOv1y8d
 doJA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Z9DhSawrwuQ18pW0ZQh+wiwkWuVsJzMF7CpJh9g4Wi/ldUartQtumrt60zL800HGiB7hej08=@lists.denx.de
X-Gm-Message-State: AOJu0Yw5YsyoCGhTpxmB8BFpzo06FdCihuUEbDuKfPG51C3sHT3EgBPM
 MdJ57USp5oZAT8Tu9qAjghesTilxwKvbCVfqmRnGzk0tOeOWE3kMI9ylmUZWs5keGGhzyhYAt4W
 WzpBtCLbd6opydvs0zoW/hIgJSNDbHfRPCEa2T0fBYenlQdysaeIdrN9v
X-Gm-Gg: AeBDievBLhsPr468gFgPXSHAL21hCwrX26gS2sByXVj1dvYyLFIo6YJTjIvwMpxX4I1
 IHLQh0WfA3j9WA6Lljj6awHkWghb9bSXdqFZmjQVdKWIZJdX15tqb+zwOd518RBev6VpKwc0tP6
 67Pi40kHV7Eln8hw7w67xgfUBXCIsWFjiAa9D/dZpKdEk1lxbeA85gPVqqvyUOyLiY+71zxqyFR
 A5UMoJKaSdz7vPyFwyjmjlYgsrCDPIZp8oBeqkdMPcsorq78UYZbNrdrZiFTDaUHtW+OsMz1f0x
 xOr0Ra3zu1KZQLNAMyvwnPdTC0btNT2nPEXm+uhhGUaK/VUadO9RZ9GowcHCSDXCj2tQyJUt+qj
 AJXcPZSzSkKxNgEzsUBuWPFzXJE2soWvmwn6VCWm/oAhO5YMc4kg3YkwZaCyaSCot2MtI
X-Received: by 2002:a05:6a00:a256:b0:837:6bb9:acb7 with SMTP id
 d2e1a72fcca58-83a5805d724mr8266829b3a.0.1778167535329; 
 Thu, 07 May 2026 08:25:35 -0700 (PDT)
X-Received: by 2002:a05:6a00:a256:b0:837:6bb9:acb7 with SMTP id
 d2e1a72fcca58-83a5805d724mr8266788b3a.0.1778167534774; 
 Thu, 07 May 2026 08:25:34 -0700 (PDT)
Received: from [192.168.0.6] ([183.82.29.229])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-839682a20ebsm9439126b3a.53.2026.05.07.08.25.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2026 08:25:34 -0700 (PDT)
Message-ID: <f27cc86e-886f-4832-9ed0-d6dc9c7c7866@oss.qualcomm.com>
Date: Thu, 7 May 2026 20:55:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: dwc3: Fix crash on fastboot exit due to incorrect
 memory free
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>,
 Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>,
 u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Chris Morgan <macromorgan@hotmail.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Casey Connolly <casey.connolly@linaro.org>
References: <20260507-usb-v2-1-3958b8732553@oss.qualcomm.com>
 <87fr43d2le.fsf@kernel.org>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <87fr43d2le.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE1NCBTYWx0ZWRfX+4ekMUf82dmg
 d/tRqYSUIptifCNWrJfe6RdCC1evmPtRndNtmGmt3qgHfncPOTgAsXuQWbx1ATw4xHOnrezzDdE
 s8lAvtskvnZ3asjcrKjhPATtb6cnNmkaUGU8bKSQvmDSiiqhUGWte4Zi8nH2pl5soZ1/S/I9PJk
 5qVSaTi2QivCBH9U/DSovX1UU8/kI2qLkZxg4b9cLtTcQ0jlNEf8+26G9omkPJUOntUrwTK5W7m
 9xO/yxJTIPNSl54HXzkH5aM6cRWt4KYBFo9lIkDdOf7OfphuB2jppiLRo61tjNCeN16zAy/9U4d
 w2wy+eE1qtEhlPmQGaiAErX/S1HT5LgXkuaEvn8WiRS9eg5sSXEy3iqbAzNRH371aF9Trn7INAd
 8ujn7g5myV0DYYJJaloOGc4s2ld8b7uE0cdx4YRaTlA0bEKuGLYDi70r7GFsDGwA545umA0sAsa
 Lny29iapybMT2QZgrNA==
X-Proofpoint-ORIG-GUID: u3UDzuNErqfyE_JtrQf9Tt3h4aXE-6zC
X-Proofpoint-GUID: u3UDzuNErqfyE_JtrQf9Tt3h4aXE-6zC
X-Authority-Analysis: v=2.4 cv=ReWgzVtv c=1 sm=1 tr=0 ts=69fcaef0 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=QSexx7ugTgw61ZAVApU5FA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=FiGvj3fQRKTR5oEpz4QA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605070154
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


On 5/7/2026 2:21 PM, Mattijs Korpershoek wrote:
> On Thu, May 07, 2026 at 10:06, Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com> wrote:
>
>> The dwc3_free_one_event_buffer() function incorrectly called free()
>> on event buffer structures allocated with devm_kzalloc(). This
>> caused heap corruption and a synchronous abort when exiting
>> fastboot mode via "fastboot continue".
>>
>> Device-managed memory is automatically freed when the device is
>> removed, so manual deallocation causes the heap allocator to access
>> corrupted metadata.
>>
>> Fixes: 884b10e86a05 ("usb: dwc3: core: fix memory leaks in event buffer cleanup")
>>
>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> Ah, and I missed a nitpick. Fixes should be part of the commit footer.
> Same block as in the Signed-off-by:
>
> See: https://docs.kernel.org/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes

Hi,

Thanks for the feedback; Pls find respin here: 
https://lore.kernel.org/u-boot/20260507-usb-v3-1-402b37fc2154@oss.qualcomm.com/

Regards,

Balaji

>> ---
>> Changes in v2:
>> - Added Fixes tag in commit description
>> - Link to v1: https://lore.kernel.org/u-boot/20260506-usb-v1-1-e0f426bb1e42@oss.qualcomm.com/
>> ---
>>   drivers/usb/dwc3/core.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index 0dee14c8b59..be198041f08 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -208,7 +208,6 @@ static void dwc3_free_one_event_buffer(struct dwc3 *dwc,
>>   		struct dwc3_event_buffer *evt)
>>   {
>>   	dma_free_coherent(evt->buf);
>> -	free(evt);
>>   }
>>   
>>   /**
>>
>> ---
>> base-commit: 3cdd19089f1b1b7cd08530f33ff4708abcfd426c
>> change-id: 20260507-usb-34b404ff063a
>>
>> Best regards,
>> -- 
>> Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
