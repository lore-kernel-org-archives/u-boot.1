Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E1CDD711D5
	for <u-boot@archiver.kernel.org>; Mon, 22 Dec 2025 04:31:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F5BC83C28;
	Mon, 22 Dec 2025 05:31:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="LkfTu0ok";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EOSlu88p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F22B383DEB; Mon, 22 Dec 2025 05:31:19 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FF6D83BF1
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 05:31:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BLIrF7w3109737
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 04:31:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HP3Np/P4RnvuBu2OTW3oe4sIlrBuHQ28NPyWkBAXuTE=; b=LkfTu0ok59ufTvt6
 NX6gr8FaOxMSVxkD8maoTgOoC72FIcvbHJaWKUZmJ9MLNz3jQzpfiIaC255oF2+S
 7ALRgcELCcsniPOoI70GCjk5GSXxTWbCC7/tggwxkgh6mnhJt5EwVKe6mFjY0Gpu
 5k/Su5a9CB6061D9pTYRqzfhfMNiqgTXwD4UJT/wNI9Z+qVrznjb2XI/D4aq5Hek
 4naS6360tBSK1VbY2XSFPYbrKIuJGawp2GtNfjzUrwUIG3nlrNUWgwyA350vWwr7
 nXRd76e4GOXLqQsVw+4R3xzGakE57A/LD1m5yLFL6ghCI5uf/zuq8b9B0EDpmX26
 /iiXmQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b69ahhwbb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 04:31:15 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2a13be531b2so78003995ad.2
 for <u-boot@lists.denx.de>; Sun, 21 Dec 2025 20:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1766377875; x=1766982675; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HP3Np/P4RnvuBu2OTW3oe4sIlrBuHQ28NPyWkBAXuTE=;
 b=EOSlu88pOyoBnVG1A3kxPBnP/WKZ7RzTZW6AWiGcNY/lXNP/5YCB251dUZl1EM0YxG
 ugv7azqUh/KRoodCFOnN9XhGqoJ8umD8NpjE5BW2DEe4HyFI3ozKEApbtSxiFAZ2UlUK
 h0zI49tYtlyUjJuPgXkc0YkPStFT4Imd0LnSpdZxTyyRn+P6AYz8ffmTe64YAF7IiFI9
 dU88nkWncob24cg9V0npiS6eHnUpsjJXSMldFK7O5pFxg9aT8cV+KAv2X2SEzkDgMLVt
 UiluUefwW1SpVe36yoCO9y6I2WG3TamFT3uQF17sKoh0KZ0q7PaTyDb1T+Wsopv6O2gL
 P2Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766377875; x=1766982675;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HP3Np/P4RnvuBu2OTW3oe4sIlrBuHQ28NPyWkBAXuTE=;
 b=WGVBqtHjVUOv7hXrNXOhnnHrV5yYEFbZlGCJPEbSvBjlxCRcJYnwreqErotL2oTm6J
 jv+0WCi2CJGBt0sikMXhcSmZMkM/6Braalzuhp5H0Dv0i0V9HbjSYI0wqi5gA6d9jvZQ
 qzftiPqYWzXorSCf7BOrhmClHX8f/SYE4jCUmrj5MgcQ/FaJ9eW7KoBxw3YKfEslvs/9
 iYt8Rq53rAkZOhmanOtp4qZHZJ2FViPTYAIo34itYorScyApM+NGSlrgxSdvZcCUI/lE
 CCTXj2bskyMnJJuBW8rae28s4umBrAaz0iTuSaKToBlAEBqOFI/iUFtudeZdJ5gz/99T
 Bcmg==
X-Gm-Message-State: AOJu0YwrWMdLvn4nfvJXaDDYiJN1nbCQuVCJepV1oiAKwKHcWwclr94R
 NkVozQfFuen0xWlkdK7gQLAvUz60X7hSEPy6Qgb44S8EbHeehFFjrUcTIA9kA5hXdNKNHQ/qpxe
 Qupxf/jhLRRg9cgB2UGKrDsS6hOxHV8kUi3Q6lIMfNiL4oaKXBTmIdLi/
X-Gm-Gg: AY/fxX65p933gccFHJq6ZD0AP815mYIT0LYklUT3NxsXC4C8tmLIUYZiiTv2m65ATu6
 0TOZFEcxTKWJ3TJaYzfgs5VjtNSZd4rYmVFEF5ZuTaolYSky09h441r4iB05LdF1dsPf4HQUy15
 7Wc+7Hpl365Z7pdFtQNT/F77CoC/LHKjxkOS3zwoCH05bIAWpibRfY/wc13R/T7NA7bZ7EnRpzL
 u4Ak12ws825Rz8TzVOorU/0ADLjxsDlKwrm9n5Z2bvwCJLk+xP8+mf8bMzZv7pKnYnPO9lQINAU
 lMCTEWMST0yXHmwNiTQZrLhdg/JRwRVsIaYMcKNgFN4u9lHrb7lVOnvcVAsB/oFXooKQDRDPHw9
 KzcH05YPikMhwBVusZMW4Vx37iGBBt/CqDZ3OEP/f3fnIPrE=
X-Received: by 2002:a17:903:3d0b:b0:2a0:c58c:fdd2 with SMTP id
 d9443c01a7336-2a2f2425808mr114326455ad.26.1766377874790; 
 Sun, 21 Dec 2025 20:31:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFSblt0WX+wkgsrXPz6OoV96sakFruchZZ0fan6cxQn0EKsH1SwQbIivSA9h2XOadSb/63Gw==
X-Received: by 2002:a17:903:3d0b:b0:2a0:c58c:fdd2 with SMTP id
 d9443c01a7336-2a2f2425808mr114326325ad.26.1766377874296; 
 Sun, 21 Dec 2025 20:31:14 -0800 (PST)
Received: from [10.151.41.129] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3c82a9asm83612455ad.30.2025.12.21.20.31.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 Dec 2025 20:31:13 -0800 (PST)
Message-ID: <041e5a5e-8b55-4632-8e6f-f8a05852894f@oss.qualcomm.com>
Date: Mon, 22 Dec 2025 10:01:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "drivers: scsi: fix inaccurate block count
 reporting in scsi operations"
To: Tony Dinh <mibodhi@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>
References: <20251209025634.14466-1-mibodhi@gmail.com>
 <20251212145056.GR303283@bill-the-cat> <20251216170641.GY303283@bill-the-cat>
 <4e912159-3b7d-4ba0-886c-d62ad1a3654e@oss.qualcomm.com>
 <20251219162939.GS303283@bill-the-cat>
 <CAJaLiFw6if8r85LdAvus-QKhHixB9nMSLSKEnbPbESSY0zecAA@mail.gmail.com>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <CAJaLiFw6if8r85LdAvus-QKhHixB9nMSLSKEnbPbESSY0zecAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=JuH8bc4C c=1 sm=1 tr=0 ts=6948c993 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=k-42gJp3AAAA:8
 a=Nac1WdTTP3TmCCZC0OoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=uCSXFHLys93vLW5PjgO_:22
X-Proofpoint-ORIG-GUID: mBW0GV94rCRxokhn2ecssNNj3hAwSpnx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDAzNyBTYWx0ZWRfX8QrlVxOwIBU0
 R2NXbNtbLRU+JSEs3n2YPXRZHJql4+HXUdLARqqJInWhht8Fn8YNuiXq3/joVmaDny9+nBq0avU
 A68wRtHTqGonhu/VFEwHu0h8ZZC84S9+2QAJ4DR2Ilex1hOdGpZvo4QPlaShOfG4dhB1wYdPRxV
 DtYdjIMTsFbNMQpIsgGX3PlR5MeXr4WIEoGZVfpNTM134f1yYMaCxDuQDr0+favmftIWL4y0kR2
 1K0n9GR5xAtWCbupLmTDoWIJnT7CF4ekwAZFNprw7TQrQ9HVUp+R628r/MOvFPQsj6GQFk+EMJe
 kXRGaKzGm+7rrWRpfSMDYOcpgbVD3Fvv2sy2X0YHz7wd2nGytIOF7zRKdQAyEoZYTfARx9V7RzA
 b54tHUL0wAKdgnbC/P6s5ubgIk+YqQdbGVfwKwTk69Qi+p3S2zm3GRnkfw5wZCaiA7uL/BR4KMK
 O6OS8whLleFbWmUIfQA==
X-Proofpoint-GUID: mBW0GV94rCRxokhn2ecssNNj3hAwSpnx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_05,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 adultscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512220037
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


On 12/20/2025 2:47 AM, Tony Dinh wrote:
> Hi Balaji,
>
> On Fri, Dec 19, 2025 at 8:29 AM Tom Rini <trini@konsulko.com> wrote:
>> On Fri, Dec 19, 2025 at 11:04:07AM +0530, Balaji Selvanathan wrote:
>>> Hi Tom,
>>>
>>> Apologies for late reply. Somehow missed the mail.
>>>
>>> Upon analysis, it seems the most likely root cause is Tony's 238GB disk
>>> triggers the CONFIG_SYS_64BIT_LBA code path in scsi_read function. Any read
>>> beyond block 268,435,455 blocks enters this path.
>>>
>>> 'blks' is decremented both inside the 64-bit LBA block AND after successful
>>> scsi_exec(), causing incorrect block count tracking and (most likely) the
>>> data abort observed.
>>>
>>> The fix is to remove 'blks -= blocks;' from inside the CONFIG_SYS_64BIT_LBA
>>> block in scsi_read() function.
>>>
>>> Hi Tony, can you please check with this change?
>>>
>>> Tom, shall I raise a new patch for this now?
>> Thanks for looking in to this now. Yes, please post a proper patch for
>> it so Tony can test and add a Tested-by if it works, that'll make
>> pulling to master before release easiest.
> FYI, I will be traveling a week from now. So it would be best if you
> can send the patch in the next couple days. Otherwise, someone else
> needs to do the test in time for the Jan 05 release.

Hi Tony,

Have posted patch for this: 
https://lore.kernel.org/u-boot/20251222042533.2024310-1-balaji.selvanathan@oss.qualcomm.com/

Request you to add Tested-by acknowledgement.

Regards,

Balaji

>
> All the best,
> Tony
>
>> --
>> Tom
