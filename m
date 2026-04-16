Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A483AF433E8
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 06:00:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0805A84246;
	Thu, 16 Apr 2026 08:00:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ItQ+mXV7";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aTyRJM7O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6263583C2B; Thu, 16 Apr 2026 08:00:16 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C71B484222
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 08:00:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=gurumoorthy.santhakumar@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63G05GKL2972370
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 06:00:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 t2/6qD74bJNqC6Q28bC3z7BMqUNbG6tpxiBCxf/99+M=; b=ItQ+mXV76zx7f05n
 qAZA7W54H4221DczFTtoljOomKRqIg0zpXHmPmj/3jB3wTgqD8gpikboGa8jxC2a
 nIN75EXkrgNR4wfpV1EKuqxaUk0Rcm9GxhrYGRRzKNQ8j/oJ7+qlagolOHaNwHTR
 yXqneHZR0NMHLeNjswKJM5jCvjNSRVZLmVtfAwxnsK+LJc9OzQv0PCngTyj0AQ89
 ap8NVyo81+BqQeB+aN8weWiwEryo69s0ocEic+dLKfCd0aJJNptKNoC6ei+ojWOL
 lEyFQvr4nQZ8c29ZLlSR7y2ly3Fc1Y1wkhcK55ovV+xDTTKoKxSSznVVdAoog4dT
 DcHLaw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dj74gbx49-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 06:00:09 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c7962325ba0so1507473a12.0
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 23:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776319208; x=1776924008; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t2/6qD74bJNqC6Q28bC3z7BMqUNbG6tpxiBCxf/99+M=;
 b=aTyRJM7O/yA2oJNppSfgfoLAiluXOf3CVJ0WRh30UYMUhynQjKzaaJHKZslR1JFapy
 e8VNQtm5Lzu2GuAuX9UR3OD4B7gEuhHGumavA+ouHnQQIhZH2GshY2paiPgK3X1X2Xjm
 ly8fqPpiILrx7gC3vgki3Cwsd9jUCb7dcUd6FJq8lcJ8S38NYH7iEEySaN5ilGaFQ+EG
 Z3zYk3WAmxcxtH+fdqKMzRk9LpMvJqFTwGAF/Hiqvz4ANcxCatFngre9vJ/3Run51QGd
 JSwKpYR1tLewrVRRs/ysKyN9vJJ9qDSWxVxzTz8PCjND1ttmAEs455bX7nKSU3xHnIZj
 nO4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776319208; x=1776924008;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t2/6qD74bJNqC6Q28bC3z7BMqUNbG6tpxiBCxf/99+M=;
 b=hm5dOEGtTuZmwEY3SfUaxnOiidxBhwDmOh6frhbg1U0FyAE5to2lGEs1VhW0g2iWZ+
 mduLVfhI95TK5+Y4jpXct++OwEw2wmFyvSB60AaV9a4C04FxCbs3EqjpGBheY/8qWrKe
 kJmQQorYqNUxbggEZ3oCVVzTBLWGXEIhwky8fyFWTsw+TEr2QYob/w2u3QDzW+u8iS1o
 7aW+doPBlmTH4PAbM0WZK329SPRgF1wv2TczDhnwAZFI3ooog0stenrVOiMVX+dMJm3c
 cih2QqKOWU3j2vZ2phTWtAIH254JP1EuHGOwyXmTwx6ti6HvYweILsvybDs9tbh7yyFE
 aoDQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8geVxiMWRsteb29d7yvHrJvvoWy98SQ4yi/97ChXIs2rQ2U837yY/dDt9wAyooNpjc0P1ahJg=@lists.denx.de
X-Gm-Message-State: AOJu0Yy037SAZpR+CNRpwqPJPRcrxNAcG5rXI2prPOeTUYcDeMIYzkfR
 ZuFpPNatHm0IqnYMoGnkC08bZaNSENBGi5NuHL/5S6VwLph01fpSSRYpubgRooGvGttL4pf1w8d
 5ZydvRLkyFBSBKvjbn/YZvyc3j6UV8XMAclD0HbC61KoQaF4s/iuYB9ED
X-Gm-Gg: AeBDietLexsPO6qE/3wbL92deaOy09qpR2OaXuEu8DOvp7rVDAOSZTmyL2j8exSW2Xr
 o9zkaHlHmpMYDoqvQwKmnljzAakF8wAOY327a7aPUuznl7KQdoGuZmwou02ColZr34imKd3NBIS
 FytEPvLjcvSh16V1C4ofpjdl/J12HJkG7mve+TNZ/oEijA5/x46x3OnU/AQIBjnKvqI7y+Nlewb
 ahh/W41yjtNDKl51vIKjNekv/H7SMQr0FWOO6CASm9xRhDW3Etg+auuptR3uO+PUhkG0wCKN+6p
 /gU7K+Mj89u94oIBmnzP+ml6ZJIHZIi6U6F1EzoeXDMS3D8G0Ne0uR90d5uKqFlr1ybyHamRrGH
 iQbEv7uWFmw4PVWlK+zHzwJoKaaXYsoAwqbhwCt6ffLpImqOLMTdviqqhms9978OqRz0324W+Dp
 RH
X-Received: by 2002:a05:6a00:2447:b0:82f:37:f590 with SMTP id
 d2e1a72fcca58-82f0c3459a8mr26642382b3a.42.1776319208232; 
 Wed, 15 Apr 2026 23:00:08 -0700 (PDT)
X-Received: by 2002:a05:6a00:2447:b0:82f:37:f590 with SMTP id
 d2e1a72fcca58-82f0c3459a8mr26642326b3a.42.1776319207716; 
 Wed, 15 Apr 2026 23:00:07 -0700 (PDT)
Received: from [10.152.192.83] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f74c3b680sm2107759b3a.41.2026.04.15.23.00.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Apr 2026 23:00:07 -0700 (PDT)
Message-ID: <3156b6d4-96a9-4af7-827a-03b23b4c3435@oss.qualcomm.com>
Date: Thu, 16 Apr 2026 11:30:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] usb: dwc3: core: fix memory leaks in event buffer
 cleanup
To: Marek Vasut <marek.vasut@mailbox.org>, marex@denx.de, trini@konsulko.com, 
 mkorpershoek@kernel.org, macromorgan@hotmail.com,
 casey.connolly@linaro.org, felipe.balbi@linux.intel.com,
 quic_varada@quicinc.com, u-boot@lists.denx.de
References: <20260414055013.2978223-1-gurumoorthy.santhakumar@oss.qualcomm.com>
 <3f3a5163-7f59-4d02-8fe2-983cdd03b6cf@mailbox.org>
Content-Language: en-US
From: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
In-Reply-To: <3f3a5163-7f59-4d02-8fe2-983cdd03b6cf@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDA1NCBTYWx0ZWRfX2HyJTTXw89tK
 HNWssmkqx8MgHt16SHx2FP0y7MSQJ2tlowRkWE+SgQ7+nfTYpGy5Ky12c1JE1iuK9VXeuYNqzs6
 1y/8JCj138r2nAqzztpepER1CZXxGxvV4rWCnUjZ2kXsirrB2sj47I8c6mc4118jaFl8Yz/qB4L
 x9hDvMB/MkI94dLyY8zPd5rmKUBaXOwgknGd+hBfn6LJrPfW1HN6zYkK+wv/u5Vfq1lazZvNWXl
 8qUAK82opjEbgCsq5yV/+2zOKe5XrPlwBxKBVeQL3E0BmGilQFjVuIfgpNZg/yz0XPf/ipEangR
 O1FPLKG9IMybT5PpMwRgJmBFjmDnn9PZpclQTAinXOpKb/kNk+2we8ZgWkgEIDNrlP7W0CaKt0Q
 JLPlWzsPG34ov+USV4TKxAQLHAp9L3aOCdpz5qedGbTOWzsVpdBB4ZlcX8DJ3qwpkjrLjb8JDyp
 l1JoVf5JQ4SU5dE3+Uw==
X-Proofpoint-ORIG-GUID: 8L90s-won88Q4d063mKCYBjDsoTqIp94
X-Authority-Analysis: v=2.4 cv=ZIfnX37b c=1 sm=1 tr=0 ts=69e07ae9 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=j6LRPXVh1NLD0A5ZYvwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: 8L90s-won88Q4d063mKCYBjDsoTqIp94
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 phishscore=0 clxscore=1015 malwarescore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160054
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
Thanks for the feedback, please find my reply below,

On 4/14/2026 11:41 AM, Marek Vasut wrote:
> On 4/14/26 7:50 AM, Gurumoorthy Santhakumar wrote:
>
> [...]
>
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -206,6 +206,11 @@ static void dwc3_free_one_event_buffer(struct 
>> dwc3 *dwc,
>>           struct dwc3_event_buffer *evt)
>>   {
>>       dma_free_coherent(evt->buf);
>> +
>> +    if (evt) {
>> +        free(evt);
>
> It is valid to call free(NULL) , the if (...) conditional is not 
> needed here.
   I'll address this in V2 patch.
>
>> +        evt = NULL;
>
> Is this assignment needed ?
> no, it is not needed
> I'll address the same in V2 patch.
> Thanks & Regrds,
> Guru
>> +    }
>>   }
>>     /**
>> @@ -252,6 +257,11 @@ static void dwc3_free_event_buffers(struct dwc3 
>> *dwc)
>>           if (evt)
>>               dwc3_free_one_event_buffer(dwc, evt);
>>       }
>> +
>> +    if (dwc->ev_buffs) {
>> +        free(dwc->ev_buffs);
>> +        dwc->ev_buffs = NULL;
>> +    }
> Same two comments apply here.
