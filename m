Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41B26D74951
	for <u-boot@archiver.kernel.org>; Fri, 19 Dec 2025 05:34:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6089880077;
	Fri, 19 Dec 2025 06:34:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="C4Zvxl0z";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gjkYaXsq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57F30800AB; Fri, 19 Dec 2025 06:34:18 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45B8380050
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 06:34:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BJ4c9PY3939327
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 05:34:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QeEWlPPngIsU3TBe1Ps8M44AIJkrkdgIgCvz3w7/HDA=; b=C4Zvxl0zHbuybElw
 wDy+rUITK7oDtNxbyB2ceFjknFJP5mGHkDjtZxytXJO2F+XGBz9VlVZarB36qV1N
 s5K/0ZTVg3+vWrG4n2NDyPF4PDpR5avSO+Hkd485rc4pG3XnvriZZBK+8KffWnXO
 12nmtZ68L2mzf01sptpSWAi9zfCz3MtEaGjVV2QTSbA2TKyrZG2BfKEzgldLAJal
 bVAw3jeV4JUe3/nVXbOZdvZJWR8mQAuKKpOATFKmP975LSRR6mrQFUFLAGh+wsTf
 BNvzwf2Y2hQQAndzuHmEU7W66ZnJDhjs1dnjZSDGfhPJIlb97tHFZhEYA5BkR4HY
 oXKtIw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b4r2c1bnt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 05:34:13 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-7b80de683efso2508493b3a.3
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 21:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1766122452; x=1766727252; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QeEWlPPngIsU3TBe1Ps8M44AIJkrkdgIgCvz3w7/HDA=;
 b=gjkYaXsqJo5QsMpNgBaNKzy+tF4Gnvh8dKkdpzv+vsWZwoBANrNIcbWNvdGNIbrlSM
 y6iTOTlT8KWdXBQuu/V+SlJiXc20N2n0A6wfEogcmFr56zOBe7G8LCiMN+V+1UewAI4v
 GhWmCngdleE8eceQSbhT/NROZ5AqxSKWOXgjEgPOyveAfiQd2JX6qZoeVmu2VAns5JnF
 zKVAhbaC/TEteZVctN00KD+p/f80h/t+FV3LboMaFX7rbVP/0nyK8nImjaq758K1deoo
 b5omJtNs/6+5uuAURyTsnPDgojhmlix7LAlcjQt7yYuvotEzAM7qOKOAOTqOW2bvwSrd
 CZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766122452; x=1766727252;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QeEWlPPngIsU3TBe1Ps8M44AIJkrkdgIgCvz3w7/HDA=;
 b=KX/qb/1OxftGjR4gGp1jO/S5NFzWldNL0aEuWOL2IUnP8zYVPGohAFaD/OZR3mL+AZ
 xLpgX0s+D8TclSKpp/+Eib4zxs7B6EI36lMcJY2r0HMIizqEmSEoqCgNyfxmTkxrauqw
 bxE0iSIxiuRDQnbav1t2WjbeZDtPAQFDe0ZZxXrkQ50d9CG/063rpXvoYLOrPIlG4Uk2
 28GlFsU3bry3gcjzxr+kzA6PIzC6M2jlYOkIRwy2bC/Ne7JQ7OgLK6kZmptBrj3TRqc9
 I6a9isq9bCpKGXhBYx9cWvw01zjb+9biUHby7eJAKbBI0d69izltWKhc0/IBIKKYRjrN
 D3Og==
X-Gm-Message-State: AOJu0YwOUBJPMFWJ5u1znFA2yJagtPVkh61fcBa1tSzXkfokdyKJnyCw
 EV89i5CnRjFmltDjhEEf29snlAR03ZdMV9I3Cc3OlvkS4gvWoxCi8mpMB5kmnIeTRaOhV1sXMJs
 f+WuGUHmAEDPKnfKFivxyiZTtf0e70XLBmDtvJBSa5KSnzjR9wYq1uXOGJoIunDs5
X-Gm-Gg: AY/fxX73TT0sIZ20O8nbXB63jPll/QxXy0Z1GiCShSAuUXNcU9BxEDTeCGMrazNrGH3
 cXkXVGUIYMSiT7t8CEtkDRWBImBaaKy/28cv5by5yCzj0lOXRyHW2+SLy214oOaaHATJ9tyiTLy
 0LfIK6XG84wY4j5yXNMTE50zx+w6LIWCVgJI8rr1PYWXOi0aO54Fjq/fGio62WczfGJ0LyrSDgl
 CkRtOxoOh9jgYhQR5ArnIKKCozSpyacdHxryXjsm6Luv1Wj8VFZIl7ZfcKo1gVwFLynyaN4Ffjc
 u+RrPP6c3cw0kgV2bWWxD+hSVBN6dDEotfzl3hGmCaWqlf5r+oxog+b7aME6GD60g3QDAVgCUYA
 NPBZK9N/w6EoLsJGKojpI3BZC0Q6el9Q5OiSJUgK7psldmA==
X-Received: by 2002:a05:6a21:99a2:b0:350:26ed:769b with SMTP id
 adf61e73a8af0-376a9de5688mr2019284637.44.1766122452440; 
 Thu, 18 Dec 2025 21:34:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMIwkfuwRaEZEzIAvm1JCdcIRHtYde8PMzc4EOxrQLT2KWMlIu0oV6+Dz+LZ+n+Cb8GJ3o8w==
X-Received: by 2002:a05:6a21:99a2:b0:350:26ed:769b with SMTP id
 adf61e73a8af0-376a9de5688mr2019260637.44.1766122451951; 
 Thu, 18 Dec 2025 21:34:11 -0800 (PST)
Received: from [10.151.40.76] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c1e79a17fdesm910810a12.8.2025.12.18.21.34.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Dec 2025 21:34:11 -0800 (PST)
Message-ID: <4e912159-3b7d-4ba0-886c-d62ad1a3654e@oss.qualcomm.com>
Date: Fri, 19 Dec 2025 11:04:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "drivers: scsi: fix inaccurate block count
 reporting in scsi operations"
To: Tom Rini <trini@konsulko.com>, Tony Dinh <mibodhi@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>
References: <20251209025634.14466-1-mibodhi@gmail.com>
 <20251212145056.GR303283@bill-the-cat> <20251216170641.GY303283@bill-the-cat>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <20251216170641.GY303283@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: XJ4ewuuLsRdlzwKO1L4BfJep51YcrMPN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDA0NCBTYWx0ZWRfX0+F+E3xRS73o
 ynAHULyfPQdiHojChNvse5kHUycuaNEE4Hg+uK4gOAvb8vUKLhTcFsenPWB3KbcMhRnOJjksekQ
 7HVBw9sYQzQxEchZK4sz8c2wR1J5MrHHCENGx6DewG2vnfA+aqv/rbQWR4WfC352rul+GSLwvD5
 l7g/EbdF9goUzIv2UYgJk363AyYBYcE7CbohQOK55JWHmDYX/GE3GEt2gm1aCsPO8P8hqOpJxOy
 yNAAqP64KWEzCgG0HJX5YmkG8S8a2lycq/U211LhqJZUjaIcY53ae2zAZxw5FhDqtL6HLdsuCbe
 PDXwD3D4bdkpRWs6kf7oNpUiuvO5u1hSz7pwp8bZzupSWj5KwfnCa0D48r40mQSr0LW2PuLs/2w
 4jBh5IfsUxR9W733ldU6m2JBIhQ9DMJMbDs7cb9k+e5cGOKSf0+xIwnNakDm71r9IjnIRfhN2IW
 EZH7TDpTSHfBTvbrN4g==
X-Authority-Analysis: v=2.4 cv=feSgCkQF c=1 sm=1 tr=0 ts=6944e3d5 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=hChhh0lVhKCKRVj7VHIA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: XJ4ewuuLsRdlzwKO1L4BfJep51YcrMPN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512190044
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

Hi Tom,

Apologies for late reply. Somehow missed the mail.

Upon analysis, it seems the most likely root cause is Tony's 238GB disk 
triggers the CONFIG_SYS_64BIT_LBA code path in scsi_read function. Any 
read beyond block 268,435,455 blocks enters this path.

'blks' is decremented both inside the 64-bit LBA block AND after 
successful scsi_exec(), causing incorrect block count tracking and (most 
likely) the data abort observed.

The fix is to remove 'blks -= blocks;' from inside the 
CONFIG_SYS_64BIT_LBA block in scsi_read() function.

Hi Tony, can you please check with this change?

Tom, shall I raise a new patch for this now?

Regards,

Balaji

On 12/16/2025 10:36 PM, Tom Rini wrote:
> On Fri, Dec 12, 2025 at 08:50:56AM -0600, Tom Rini wrote:
>> On Mon, Dec 08, 2025 at 06:53:52PM -0800, Tony Dinh wrote:
>>
>>> This reverts commit b32dda34506b4f486bc803d0c7251f987edd2455.
>>>
>>> Currently, scsi is broken and causes data abort. I did a bisect and found
>>> that this commit was the cause. Reverting it and scsi is working again.
>>>
>>> === Error Log with data abort
>>>
>>> U-Boot 2026.01-rc4-tld-1-g0e0a198a68be (Dec 08 2025 - 17:42:05 -0800)
>>> Synology DS116
>>>
>>> DS116> scsi reset
>>>
>>> Reset SCSI
>>> scanning bus for devices...
>>> Target spinup took 0 ms.
>>> SATA link 1 timeout.
>>> AHCI 0001.0000 32 slots 2 ports 6 Gbps 0x3 impl SATA mode
>>> flags: 64bit ncq led only pmp fbss pio slum part sxs
>>>    Device 0: (0:0) Vendor: ATA Prod.: FUJITSU MHY2250B Rev: 890B
>>>              Type: Hard Disk
>>>              Capacity: 238475.1 MB = 232.8 GB (488397169 x 512)
>>>
>>> DS116> ext2ls scsi 0:1 /boot
>>> data abort
>>> pc : [<3ffa5d3e>]	   lr : [<3ffc1515>]
>>> sp : 3fb65ad8  ip : 0000000c	 fp : 3fb7f220
>>> r10: 00002710  r9 : 3fb6aed0	 r8 : 3fb85e40
>>> r7 : f10a8100  r6 : 000003e8	 r5 : 000003e8  r4 : 3fb65ae0
>>> r3 : e38e39c1  r2 : 00000000	 r1 : 3fb65ae0  r0 : 00931767
>>> Flags: Nzcv  IRQs off  FIQs off  Mode SVC_32 (T)
>>> Code: 3ffd b510 6803 460c (6bdb) 681b
>>>
>>> Signed-off-by: Tony Dinh <mibodhi@gmail.com>
>> Any comments Balaji ?
> Again, any comments Balaji? I'm otherwise inclined to take this revert
> this week and sort things out again in the next branch / post v2026.01.
>
