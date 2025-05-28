Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A742EC3ABB2
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 04:11:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8EFC838BB;
	Wed, 28 May 2025 06:11:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="h0oQr1yq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 168AB838BF; Wed, 28 May 2025 06:11:37 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6222C831C8
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 06:11:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54S0EKSx012741
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 04:11:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZAxuABe40iDbJ95SeGV6aINBUOtHzP7Gl4ZlOxIbNmw=; b=h0oQr1yqE4okbQli
 WQMl/cxzSW0cw9sevBGjaajrij/OBtpEpYZauIR08+ty3yY8CYZn5K2WAQUMkbpv
 Vui6NpER6+O5XBekMy3GB2gmU7VpULBDEwUb5BDFHxr0lfzfiDL0EXl4d7PfAIpl
 X4rthb+UHx9rXGS0B0o/cLpBKJ0fJK12xmydBGWB5qN+YzxhfZCTcbSFhR3qUeRP
 kcgC8BVZ2L+7QZssLFXrx+xvv/YOZ4Vs5TP4tIymAHkhUdp/6iTR5p6PcFtjpbLf
 xDcE61WiLJaCSILbmkGXJJ6axsRyia648gUmycGMi19OZ+ecZlPxlsZUs6s0IugF
 GvKW6g==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46w691bfpm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 04:11:32 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-73e0094706bso5372418b3a.3
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 21:11:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748405491; x=1749010291;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZAxuABe40iDbJ95SeGV6aINBUOtHzP7Gl4ZlOxIbNmw=;
 b=Fcca5J9yxliF+6j0L80NqP/X1M/Dtlz6kGMRUNmbmqrqwSlneT8CiY/Zx1WDsRS2Z0
 Ucaw1l3mCdZYTobrF+f0F7i4Ie1ppOuIco6KUSqMpGpekTRIRlsTC7l8wuL0hWT+Jwaj
 jbUPvgONTkU8l8K4dTQWw+MEc0fCyct5k1OwPlS9mEaCIC/AIgqsRfEK3/SsdaTNtTUZ
 +T6OSxuWGdTDcCTk1a3nSAstQedTRuW3u2hLHJN0F04vl/FtSanZSqpi6Tlp8PxtrI9e
 OX7bgr5BR+okinXiIP7HdKtWu2d3glKdx4II856M+omcRpHaZNAOEyHrcW10a8Q6Z+Kg
 f4CA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqhJj1M6XeUEBSBhn0KIaTh82FikjMuwC1o+iBpKBq6ID9mkvJS6s2pG7mPKW//TkxhqXZTGc=@lists.denx.de
X-Gm-Message-State: AOJu0Yxxkz7aRqUMsSedFvh2ISy9KesU2oRP2Q0YznS6tj2LxrA1bQwp
 rdrE7b2MfJmnw04HWHnbLat9KZL1CFAC936TVSkZQQ8Kwr8sE86AmGBOVLD7iUouTQC8knn0KSn
 0nfDQDgug54kYto0A0NKDb3AEcMpIivPbB7uQQx5CZytGAvHZEcu0tT2I
X-Gm-Gg: ASbGncsSHBQyTDcFE4LOxRGHoBGqXhox+TflpPiBrnN7+Lxco5LU6JmJYACX3eZh9ty
 I1GkUn2DJkGvCZXDwD+Esri6meTYi32y5fGzsSNe2hzTgGtQvis2rAJTRd8duQL4V0ftajl7bRP
 BUJkI/+jRw7xDvR3X917vwNN57xAow91ZPaOSGOODqqTmoWUOapbbdIuq/uP7tew3RQO4cwCje0
 MhzAUVxjEUYCLFjjta+qhnJ5FS9ETqBTgnTMLPxhe3/MM/gyrIaFqx1HApQEFJIiLJmNqs5Ryct
 fuphJpkHHksspvgyN8Q2aSwlN2ed91VYSvyD8yn7be1Jpg==
X-Received: by 2002:a05:6a00:10cb:b0:740:6fa3:e429 with SMTP id
 d2e1a72fcca58-745fdf46524mr19164910b3a.11.1748405491499; 
 Tue, 27 May 2025 21:11:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELJ7iKEIJiRijSr6cJDz2N9PTLgqR65iLkQ1vS11iNfmdhRwMCad71kRLMfI3svvLZ9IR8FA==
X-Received: by 2002:a05:6a00:10cb:b0:740:6fa3:e429 with SMTP id
 d2e1a72fcca58-745fdf46524mr19164870b3a.11.1748405491057; 
 Tue, 27 May 2025 21:11:31 -0700 (PDT)
Received: from [10.152.199.49] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-746e340965dsm289607b3a.117.2025.05.27.21.11.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 May 2025 21:11:30 -0700 (PDT)
Message-ID: <473c791e-3ae5-4971-8632-632bbaa8e327@oss.qualcomm.com>
Date: Wed, 28 May 2025 09:41:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] Add Qualcomm Watchdog Driver Support
To: Neil Armstrong <neil.armstrong@linaro.org>, trini@konsulko.com, sr@denx.de,
 casey.connolly@linaro.org, sumit.garg@kernel.org, sjg@chromium.org,
 jonas@kwiboo.se, jerome.forissier@linaro.org, raymond.mao@linaro.org,
 ravi@prevas.dk, hs@denx.de, arturs.artamonovs@analog.com,
 devarsht@ti.com, nathan.morrison@timesys.com,
 bastien.curutchet@bootlin.com, ian.roberts@timesys.com,
 festevam@gmail.com, vasileios.bimpikas@analog.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250526093153.3387410-1-balaji.selvanathan@oss.qualcomm.com>
 <66da4aea-c47c-48d4-a9fd-35c5b63dfb16@linaro.org>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <66da4aea-c47c-48d4-a9fd-35c5b63dfb16@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=WfoMa1hX c=1 sm=1 tr=0 ts=68368cf4 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=53EZ7TDeAAAA:8
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=_JDYb9XYqTFTpSYka_sA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22 a=4uUo5ylOvWPqrpBE2UM3:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 0MMLQmRt9xeiILxV9ZM6-IJaTfehzeUc
X-Proofpoint-ORIG-GUID: 0MMLQmRt9xeiILxV9ZM6-IJaTfehzeUc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDAzNCBTYWx0ZWRfX5OhiDR9efMKG
 JRosKuGH1r8xge87hYfrp7nLanG4aGOWMfl3kW+XjUQf1r0ulne9G5knGMyz/g4tPaOy1felwvG
 1wTH9wNmeH2HRfvQ+lavq+WD0vlb7MoNzwy3coY76lvkuPovOPeKexosv2BcaDXmludnH/jdv7v
 94A9fNuc+BEHncgrEb3nuKPiJ2O+hiT7ThJIZqPHsPgZoRFZYdjHZtLclLB3RWNjLeqteHSQBg0
 6QlM/PFWo6O/jfCPvr9UYpJNelQ4yNUPWO8yL76UKchGASISp6WGlgXEPXR2UL8/Mbvdg3eS3zf
 UyfMyX/KDRsL897nwWslpiV5qIIZF3qRuVR8AVMy5F5zWtcOGWc0KuVkzqYbOEniiEdzZMX8O6W
 fxQ6PFERhywgeNWjbOQckvrv9TxhRC8ExzjGEsSxlVW0OeZ6UILAsIKx0eJR9wCVCF+ryDci
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_02,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505280034
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

Hi Neil,

The submission you shared misses timeout setting support in the watchdog 
driver. So have added that support (on top of the submission you shared: 
https://lore.kernel.org/all/20250422-b4-qcom-wdt-v3-1-730d4d5a858d@paulsajna.com/) 
and created a new patch: 
https://lore.kernel.org/u-boot/20250527124926.128413-1-balaji.selvanathan@oss.qualcomm.com/ 
<- Please go through this.

Regards,

Balaji


On 5/26/2025 5:50 PM, neil.armstrong@linaro.org wrote:
> Hi,
>
> On 26/05/2025 11:31, Balaji Selvanathan wrote:
>> This patch series introduces support for the Qualcomm watchdog timer
>> in U-Boot. It includes a new driver based on the upstream Linux
>> implementation and integrates the driver into the
>> early boot initialization sequence.
>
> A watchdog support has already been submitted at [1]. Can you check
> if some support is missing on this implementation instead ?
>
> [1] 
> https://lore.kernel.org/all/20250422-b4-qcom-wdt-v3-1-730d4d5a858d@paulsajna.com/
>
> Thanks,
> Neil
>
>>
>> The first patch adds the Qualcomm watchdog driver under
>> drivers/watchdog/, while the second patch updates board_f.c to
>> initialize the watchdog when CONFIG_QCOM_WATCHDOG is enabled.
>> This ensures that the watchdog is properly configured during
>> early boot on Qualcomm-based platforms.
>>
>> Balaji Selvanathan (2):
>>    drivers: watchdog: Add Qualcomm Watchdog Driver Support
>>    common: board_f: Enable Qualcomm watchdog initialization in board_f
>>
>>   common/board_f.c            |   2 +-
>>   drivers/watchdog/Kconfig    |  17 ++++
>>   drivers/watchdog/Makefile   |   2 +
>>   drivers/watchdog/qcom-wdt.c | 194 ++++++++++++++++++++++++++++++++++++
>>   4 files changed, 214 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/watchdog/qcom-wdt.c
>>
>
