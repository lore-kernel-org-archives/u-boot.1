Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ACE7CD98ED
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 10:36:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C8BB8460E;
	Thu, 18 Jun 2026 12:36:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZlsSs1MR";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aMeScTuI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B23FB847C3; Thu, 18 Jun 2026 12:36:20 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14BDE80287
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 12:36:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65I8DrRC2246930
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 10:36:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GYBzbvkZa0i+fxBad5YI8gQTMtJA5LmIB5J4+OdCnho=; b=ZlsSs1MRDTbw8bSG
 nJ/gP6wcv9r/b4YT/yS0t1WMiSju5L+gaNrSiMstLiDLiFGhL3AoEpIWLCOegdOD
 iU2mo/Fior0laMqui2KFORCtisEDBnlKs0L1z9r5+2BPjPsUf/o2coR1x2SIzvgr
 y4rDh6Ypr3+2yQPOhtRmCaw8ggbq2xcjtjyJBJlz3Y/ja8pSOEkFVgpdX8DyligF
 cKJusW1Zo9YJX6kER7IoXOGB4fUegz8eGb3UqLh7jBGRctvmquZTlSe9ifeIR5xX
 +0zhU3ub6DUCRlEz/i8ytVhA9A6LMbIFrhfFpKQ/fjnaXdOHYkt6FB4lpq+zOwBM
 qFNSMg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4euw9vmg3h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 10:36:16 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2c6bc237b5aso14584245ad.2
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 03:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781778975; x=1782383775; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GYBzbvkZa0i+fxBad5YI8gQTMtJA5LmIB5J4+OdCnho=;
 b=aMeScTuIOVK7CptGnAX/wcjU0yflBVQNqtOr5P7ZDoH8+5SNp8J4gUM0yetLECQcPN
 O3XSTGZ2esfYtJU4JU9R3ngWiUwHUKVbK2cbLfbUvqMmIHw2pQVTOlnbspWaz6GgcKEK
 q8UpMsQF+MvKYRBGBW9q74qcdjhl4yRWj5poA3hHTRQDs8S747V50JNcuyjmoreg8P7o
 wCtT+2SGVvS11O6Iol9HKlZKQMu9V60POzmZkZCGFuDNLZQI2aH0pHG4A02/524ni0dT
 UsFAyXQNDqarbQFGTL/p45E8ybbNRC1lRN6rr/v3bexq8WGdq+Yd2RpvvvTo+L0lULig
 cVLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781778975; x=1782383775;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GYBzbvkZa0i+fxBad5YI8gQTMtJA5LmIB5J4+OdCnho=;
 b=l9FqCYQ/7eKvCvSfQZe87ZegDGy+jAb2Ij2eZvNXsfvkBVk86YXRji7PodYm7hS33l
 JNCKhoODOjCxssDzP9wvs7Px9QkStlgOOyPK7YcpdzRquI+c3odgtTqoq6JXViF/kkQe
 holE5jJj/SURo8gRF8LaD+08fAexl3j98jIEGY1aZFgivnqAV+NSnHZdR3CtSDTewKCr
 l8RVTvzgINRwjxQXi6NUQrz5UIEszsZBKP2kaERRo2d2D6giJdEFJarizijSiOnEA47b
 OOnoFPtqo2V3IV20Y8BgVNtoHDIFGuBbnx6dmxrbokh2NbGm5EURQ0D/w1dCHAzJkTod
 5rsQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ90JI0IUy40uIIp6ukZVm/ug3oUtyE1gv/pPz1mqF1OqTHd2TuKcbsXtGp4+ycZ+uX9NyxDYVA=@lists.denx.de
X-Gm-Message-State: AOJu0YwGx3xKpzfWQFWafgUOHWc4cDE2vGmJiXEkUlStJ63Loz+NUIdp
 rtUnZtDw+gUZ4ydtG1hHf26lCxskkUdfEmFASiMstYB5OispCHoaGacNh86W/nUvPHaYbWf3YFX
 /DjaLjV+D+J4beK6i57izEshuBS4HHErD2l7PGXQh4zxt0GAv0YUgNxtH
X-Gm-Gg: AfdE7clNTihk9EnmxRKHqWDAoFLG7CC9WOxqn2S286wcaVAyIsnEXF6m+GwgYcK7BfQ
 WPoFiNE+oJBtl0BRHCGLakhQOa+IchuW6b4r4HsoV8HKem2l1cJ1X5nYu1RnfkE+lf611QPhxzZ
 sgJ5NqbgFi2pu2w5BgpAF/Zz+4KwJSHZxGuiZpbgCJ1YVwlmmW4t2SkbwR18rnkqNyDTYWmruy0
 /uGg8Rl4ItteYBH2mjF6WB/xLAJm7abXL7OSZHBuZysAcmaDPQkMqf0tSRr/2YVr2a8PQXpuEy7
 fxlsdvxApyycf7QyUtJNp79rXpmxnKpd0h3VaWTrI4EdO4YcHVyX9zCu5z3jGpuBPeexYsQPzOq
 3yp9MhWUt1CvgMw79banuFFMq1b3iCm7w4XCs5NU/0IzI9ud9
X-Received: by 2002:a17:902:c950:b0:2c0:db23:4c1 with SMTP id
 d9443c01a7336-2c6e471a271mr36682255ad.5.1781778975409; 
 Thu, 18 Jun 2026 03:36:15 -0700 (PDT)
X-Received: by 2002:a17:902:c950:b0:2c0:db23:4c1 with SMTP id
 d9443c01a7336-2c6e471a271mr36681755ad.5.1781778974939; 
 Thu, 18 Jun 2026 03:36:14 -0700 (PDT)
Received: from [10.151.41.150] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c42f7c5535sm198612935ad.18.2026.06.18.03.36.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2026 03:36:14 -0700 (PDT)
Message-ID: <c339c864-4734-484c-b5a0-519d90dbbec7@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 16:06:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] arm: snapdragon: Add snagboot support for
 Lemans-EVK
To: Casey Connolly <casey.connolly@linaro.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tingting Meng <tingting.meng@altera.com>, Alice Guo <alice.guo@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 George Chan <gchan9527@gmail.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Michael Srba <Michael.Srba@seznam.cz>, Simon Glass <sjg@chromium.org>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
References: <20260616-sngboot-v3-0-6fb0dee8125c@oss.qualcomm.com>
 <64718934-b054-4c47-9d01-dc6fac01dbd7@linaro.org>
 <tgqh8m.i5334p2b63jo@postmarketos.org>
 <095e2faf-1f06-4139-bd9b-1d278b60ddff@linaro.org>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <095e2faf-1f06-4139-bd9b-1d278b60ddff@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: HSiE2fdVEld_ZEkIEhMa7lGMN9L9oPsD
X-Proofpoint-GUID: HSiE2fdVEld_ZEkIEhMa7lGMN9L9oPsD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA5OCBTYWx0ZWRfX/7sn8mrOeDdw
 XixIlfDEKl8w21GlGcS4gTije4ryGP1a4binvV5x9UqY/qaATtNDHn/FGNYOWVt8itq6Iyr3WiQ
 Z6OyCDxgusADJ1dd0QHzxS4dwpAaamZfEw8+fHak5frfhq7z1mk7QgJEWtxEcDWS/FhA3qqSgGg
 4WbaD5TjNobu0qOmCAK1uKnshvc/XlqQ8J9T1xGZ/6BJhbAcb05dsYtmVKW4xumKI37QE1E27V/
 fisnznEBILM+z8YRsQuakDm6wydhPWZEzoYj86te4NyGMhhwWBrxZYTfXKX1rt2IHSWDwq4aUwZ
 1It1C5QINCecNse4pLOCodAaZMIbxZJn6si99dr+gXH+thDqIixrlJOlOxDto/GVmc0jrDT3LrG
 fhJeNm7cyBBK4vsKFDe92Jt5E5s5Ak56MCOER80dQhVZbjLQZshqFZyHGHpwHLULkIW8xe081IW
 oOo622VegjRpOYZ87Zw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA5OCBTYWx0ZWRfXzOroffILhMAu
 1Okxi30ZjQb6Di+JmmmLEUprmVBwuyYFY/UNzVk0cRaHQBNR4tTJW3yCbKNBICokhCiE81o05Dj
 eDNjMMdKX17affNvYUBOXwMBtPuNe+U=
X-Authority-Analysis: v=2.4 cv=YJKvDxGx c=1 sm=1 tr=0 ts=6a33ca20 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=NEAV23lmAAAA:8 a=xjGz-wBMAAAA:8 a=KKAkSRfTAAAA:8 a=vLTgU25daypPW6Nt0ckA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=dmbvPvuLAiAwK5y7oBu2:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180098
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

Hi Casey,

On 6/17/2026 8:37 PM, Casey Connolly wrote:
>
> On 16/06/2026 18:42, Ferass El Hafidi via groups.io wrote:
>> Hi,
>>
>> On Tue, 16 Jun 2026 12:26, "Casey Connolly via groups.io"
>> <casey.connolly=linaro.org@groups.io> wrote:
>>> Hi Balaji,
>>>
>>> On 16/06/2026 11:22, Balaji Selvanathan wrote:
>>>> This series adds support for running U-Boot in snagboot mode on
>>>> Qualcomm Snapdragon platforms, targeting the Lemans-EVK board.
>>> You didn't respond to my reply on v2 of this series.
>>>> Snagboot is an open-source, scriptable flashing framework that provides
>>>> an alternative to the proprietary Firehose protocol for device
>>>> provisioning. Like the traditional EDL+Firehose flow, Snagboot uses the
>>>> Qualcomm boot ROM recovery mode (EDL) and Sahara protocol to download
>>>> and execute bootloaders. However, instead of using the proprietary
>>>> Firehose programmer, Snagboot loads U-Boot into DDR and uses the
>>>> standard fastboot protocol for device flashing.
>>> Glad to have some more info here. Please also add a doc page with this
>>> information as well as a list of supported platforms.
>>>
>> I suppose they are talking about this snagboot: https://github.com/
>> bootlin/snagboot
>>
>> But what's confusing me is there is no mention of any Qualcomm board,
>> nor any PR to add support for it. Is that in some downstream tree
>> somewhere? (to be clear I'm just someone interested in understanding
>> this better, snagboot is a very cool project that already supports
>> plenty of SoCs and it's great if it has or will have qcom support)
> ah yep, there's a fork here
> https://github.com/qualcomm-linux/snagboot/tree/qcom-next
>
> Balaji: it would be great if you would include context like this in the
> cover letter.

Yes, the mentioned repo is where we are doing changes to bring Qualcomm 
(for Lemans EVK) support to Snagboot.

Sure, will include these details in the cover letter and also address 
other feedback comments in v4 respin, which I will send shortly.

Regards,

Balaji

>
> Kind regards,
>
>> Best regards,
>> Ferass
>>
>>
>> -=-=-=-=-=-=-=-=-=-=-=-
>> Groups.io Links: You receive all messages sent to this group.
>> View/Reply Online (#3922): https://groups.io/g/u-boot-qcom/message/3922
>> Mute This Topic: https://groups.io/mt/119832159/8413174
>> Group Owner: u-boot-qcom+owner@groups.io
>> Unsubscribe: https://groups.io/g/u-boot-qcom/
>> leave/13197796/8413174/1557304080/xyzzy [casey.connolly@linaro.org]
>> -=-=-=-=-=-=-=-=-=-=-=-
>>
>>
