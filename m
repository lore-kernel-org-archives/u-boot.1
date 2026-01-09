Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA36DD232E2
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 05:44:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFA7884158;
	Fri,  9 Jan 2026 06:44:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="J+kLsf3X";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HXY4w4QW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44DB38415D; Fri,  9 Jan 2026 06:44:55 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD0C184150
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 06:44:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 609513HU408244
 for <u-boot@lists.denx.de>; Fri, 9 Jan 2026 05:44:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1ou9zMVUcwFtm3yuNjB97fHMJXEuSxpNEntlrOV1cEk=; b=J+kLsf3XjhQ1PxuM
 x+PECsHdK5crSdN3lkauW0NbHZ0e8+lGTC08DjcitoiyUQe/nbyQmc22Epe10OTV
 wim/StOHtN+DYW84panYrsxQGvSfOUO+zkHQHmqvECUOdTGZ2MVo1UNaW9Rc4pIE
 yCmZAEvxrjyImUSYbzMyTjwjlO9SmBzx2VmiUsd6ri/Ko1oVjhWObxaRzXCxySRV
 Is05gnzI8zRhUpRw4D+4FfVOsTs0dz46LtZJ7WbyyswtKzK4mE4+xxNuy92vw5gS
 MwcApeAPOheclpBX75AZBWs7/hr2zYpmZsjvwUmc5ZINufZhaRwjtt5coFNV3xve
 k+3e1Q==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bjb39u1wh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 09 Jan 2026 05:44:50 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c196fa94049so1759794a12.0
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 21:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767937490; x=1768542290; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1ou9zMVUcwFtm3yuNjB97fHMJXEuSxpNEntlrOV1cEk=;
 b=HXY4w4QWv0QihghdscOXBLXGtcjgzbySmG/nbxE0L05FEA00bgG0DUsW0DBRz1rE/8
 skIVAdHkhfcLHHJzk7HVHsRDnBmOq9tXOXnaGx0Y6bEaWMlAWLEIQ7VL0B7or9WO3IbH
 sa0UEhXV3Br3QutmWZy75pPHBa14sULdH8yvn1P/wqqUtxAmFfYjn7G+NFQBUTWC8Ffu
 Nu8tNB16EnIw8Fe/U975XaikCRtb4yke0rpQBbRPPeL4DXPE/8bQYsCnorJdenS6RQuG
 2RoOP9RTWrlijEh9ILxKblK5TUqIwqgIGoS9XR4NlKN2OoxTVS9KWQm6G7uoFDbnT7zE
 V9Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767937490; x=1768542290;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1ou9zMVUcwFtm3yuNjB97fHMJXEuSxpNEntlrOV1cEk=;
 b=WVEnJmWX6mfB92omKAc1vx0IQby41V0k9WdgKZyV0MpBINv+UrQpKkjX2JMeJg11Rq
 Xu9xAWFwsMRh26p+UQ3kW1xWjYY/qV76odYt9QAW3IMvycVo1tu5SDxGIWbqgiUe6Cjv
 Or5B3SaeEhWkfM/CMY+N0Dp4nGQx4YqRGG8C9yvUJWv3e3/OJXIjbLWGy1b8biWIFhFF
 EbP9b/nxAnfvkFjkai4JAochkaarv15MiwUy001e35+9xvLxdRx1JQBvCN/LxdoDkPU5
 pDGExcQDfrf5LNhvBB1HiTYXZ3aTpmf4ve9QxbejL/JGM3wUC1TybUCSBJLDttwr+/LU
 lejg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVmTjKLaileMxhl6D8Ky3DU8krKcrIN3pE2oi8+6ESThn5RLiHxlbsWZ7IQAhQR9/LVymGRfc=@lists.denx.de
X-Gm-Message-State: AOJu0YyEK6TtnqxffWL6zx8T2c6JHiyxUbOdpvmfQq+mxcTZnxIn29ub
 aOvet+YPnlMhMITP3VXgeWRbUbxe7nYIyEGswiGTbKv6QADsxx4d5AruUemZWg6llvGNcbT3NdZ
 AxgD30MWD0z/S4h1vaZfEB7TFxYd/OtyYlD7Ltj4yqCreyKviy2Roh0bY
X-Gm-Gg: AY/fxX5zHz5jsjRAe6BZoRSJUzYnz0YVi/bnSfVrrSbnnTeJedcIDvmvWL8oX26vEjm
 W+MFCBXv2cR1o5XllpSq8l8deIy6d7ZEARanaZcRhCbcCxEpmJNMb63nFdLj+jHrqpIvyeAA98d
 K+qYwa8vGQHyp2TaAYLhvr49Ib08rqjxMSK9QMhUFqURc9i7r9qAq5qWKlLGftwrlfEf2OVAzyA
 sOMmI31dIFz4/wKQnPvTyUkWe+nHQ9InitdxLh/gQqP1n5KEmbIWVj1IkKbFcuv0xoVsbmd2j5n
 rp/F0xzyMuWRASzaSWDGzX1HEtGmwDnN/9TKbaMrQPO2UHhjVtvPnv196zB/RxMhgIasDbjzYSC
 aHyMOiudMOdCGCxbhSJFUn0lFftlT9b+rvTwMtjTh5bw4xR8=
X-Received: by 2002:a05:6a00:bc8a:b0:7a1:6124:c470 with SMTP id
 d2e1a72fcca58-81943adb94bmr11157551b3a.8.1767937490023; 
 Thu, 08 Jan 2026 21:44:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHxj4Whdi7ALOytbFvJ/KEdTROl5MJSYwkNH+S46kCwSZcuWSCdJKDWT5i1IAW75HlWgZxwlw==
X-Received: by 2002:a05:6a00:bc8a:b0:7a1:6124:c470 with SMTP id
 d2e1a72fcca58-81943adb94bmr11157537b3a.8.1767937489561; 
 Thu, 08 Jan 2026 21:44:49 -0800 (PST)
Received: from [10.151.41.119] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-819c52f8ff7sm9238985b3a.37.2026.01.08.21.44.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 21:44:49 -0800 (PST)
Message-ID: <252bf198-ebb4-4668-a758-ecc85695a5ed@oss.qualcomm.com>
Date: Fri, 9 Jan 2026 11:14:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] Clear RPMH TCS state before kernel boot
To: Casey Connolly <casey.connolly@linaro.org>, trini@konsulko.com,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, me@samcday.com,
 sughosh.ganu@linaro.org, gchan9527@gmail.com,
 aswin.murugan@oss.qualcomm.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20260108101721.3411854-1-balaji.selvanathan@oss.qualcomm.com>
 <868d749b-6f06-423b-85f0-26f57f66c9e6@linaro.org>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <868d749b-6f06-423b-85f0-26f57f66c9e6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: xbjbqOVaI0YnpD4ZjpuNXW54aOaUNu6m
X-Authority-Analysis: v=2.4 cv=X7Jf6WTe c=1 sm=1 tr=0 ts=696095d2 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=fEMYM8UHhkmdgwX-MiAA:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDAzNyBTYWx0ZWRfXw8MBT+oCygpB
 btDFCp9XYpTLaBpf5ipayEzd/1Ag8eYevsJkfX73hlOME68YWzLRJ5xH+zta7ra8fq1ABxVXYk+
 dsARrIuvqf9S3iYwt+4OWdijlmJdr4wglRwpemXsoXeX4O42FUxIaPyHhijnIhBcbsZ5OgJJiUc
 uhIGVulwoaGXdeLuqiT+Il6KFJjD2D8DoLHmAsnzSC2yRgzP4bFvR2skYBm/kXdk0/XlHiLcTUx
 bOngU5oXUIUc8vfKIziK0i5haESd13JT2TouTWmrew+po+9+FUg3ArO0NRtsPLz9Q6XHadDieGE
 mi+ZcwoTPVEqW0jeTTO1z5sDJ2jMmpjKvk8Xaq/EPpc8quleGA6prrzqPjXEm8l8FD4dnwRsOll
 SrV17VluCHAOVu+ULdjfG2QLqDgveJVRGnorM92Be0LqsgCpnd2byjfQtq8hd7U2s8/qTpwhiQz
 //5trZRCy3Z+z6uiuiQ==
X-Proofpoint-ORIG-GUID: xbjbqOVaI0YnpD4ZjpuNXW54aOaUNu6m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_01,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601090037
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

On 1/9/2026 2:01 AM, Casey Connolly wrote:
> Hi Balaji,
>
> Can you give this series a try and see if that resolves the situation?
> We ran into the same issue you're describing here and this (particularly
> patch 1) fixed it.
>
> https://lore.kernel.org/u-boot/20260108-rpmh-regulator-fixes-v1-0-d1b5b300b665@linaro.org

Tried your patch series and its working. We can use your patch going 
forward. Thanks.

Regards,

Balaji

>
> Kind regards,
>
> On 08/01/2026 11:17, Balaji Selvanathan wrote:
>> Clear RPMH TCS hardware state before kernel handoff to prevent
>> timeout errors during kernel RPMH driver initialization.
>>
>> U-Boot RPMH operations leave TCS registers configured. This series
>> clears TCS state via device removal and board_quiesce_devices.
>>
>> Balaji Selvanathan (2):
>>    soc: qcom: rpmh-rsc: Clear TCS state before kernel boot
>>    arm: snapdragon: Add RPMH cleanup in board_quiesce_devices()
>>
>>   arch/arm/mach-snapdragon/board.c |  14 +++++
>>   drivers/soc/qcom/rpmh-rsc.c      | 101 +++++++++++++++++++++++++++++++
>>   include/soc/qcom/rpmh.h          |   9 +++
>>   3 files changed, 124 insertions(+)
>>
