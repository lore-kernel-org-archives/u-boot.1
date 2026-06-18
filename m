Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B63BCD98F2
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 10:38:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EAC98460E;
	Thu, 18 Jun 2026 12:38:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="c8A/koNS";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BhhDDexm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D14584874; Thu, 18 Jun 2026 12:38:08 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B04580287
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 12:38:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65I8DORR3399723
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 10:38:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hoZz1W3lZm0Y7mc+xDPOQoPSXZ6yWPR7b8K/3NetDJc=; b=c8A/koNS5yPerBdy
 zsF/qCRc6Oen1Mc+ukbDrs5FuagJsiwjVyVkP+abi9JIzWF7AE5/baX/tj6KSkiL
 EYlzAx33dP+LKa8AcXsuo/7dI351+MRgFb7WSrZV9n6mzKi9bweOWb+xn243pG3R
 6hUXgmsPLdhGWpzaQdrn3ed3J+ukS+PZKyN0TCR2B0W99u3+TjKxftBNP1yf956d
 MAEKtmP8T72q3MnrmC7LWguHbrzKp7tgh+WadqzNpUZTyR5PVdfIxWp2cJgOwdLO
 muPHh/iJVlakZZOtc8BKQ8465C63VMKK8xZiaMx677LX5DWhYcQWqfadPTHCWnOn
 wBsg/Q==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev0vk30c2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 10:38:04 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c88da04b71dso561409a12.3
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 03:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781779084; x=1782383884; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hoZz1W3lZm0Y7mc+xDPOQoPSXZ6yWPR7b8K/3NetDJc=;
 b=BhhDDexmJtJB0SAvUq1HrzQV3s6dxz1rbAhChu4pKZcAicO4RH5h+1pfTaWZsopXyT
 a7yiOCSUib661p1I1LwGjONJNyzW8GiqcMfQnv88SpFw/HR9fcrzIgS2cAaltGmCb1kX
 r4G8PBg6DrEUoKEgnEuvwhlLjmkeMtAy8ZcQrEaFuTg+FZaGKEOPY21LcIbrLTz97sEQ
 +LAFErkF+9IUOYSBpjBfdEKEKF8XPExLximyqn3DkiWvD8Js+OOjIWWzTwhpDUxbpyZZ
 t0pj80cOsRNFkmRD6tBg+pKfjHH4sByffaFvHV8YiC56gFdTm73NhiDBtt1qvq97dwQp
 QIRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781779084; x=1782383884;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hoZz1W3lZm0Y7mc+xDPOQoPSXZ6yWPR7b8K/3NetDJc=;
 b=FzsX/DbWAqYz4HxjBGztrMcOk2udb29urfLLaVjJU/2zWFac+mrIkYQqyqcFQHO6xP
 tOPY72+9EM7Fi0BMzQCUNRT6tXVfRGMOT2v4i2ScERHWykypgWS3eSAyExVwfQCpgRn9
 oo54He50tmQ9fuoRy/wuiWn0+smStakhYMZ8clpY2XEhY3sL41vgTpw1ah2qhPuKyEQ/
 z9pn8Ttk230R5nWdXmOB5Y5D1zr3f8eSWLq1v11pqmGicJuybZVMyW6pY6FHvUVWDhHP
 fnhrzxLvrfdHEv59iTDGnKJc/dnYoBDeZqM5CJL8pNxAbwdRHLfjjot0fcpx/Ht+2F5U
 TSmA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/eMaAgwhIKC8h7Wfq/ECN0r8re0SHfnFO9q7ROydw9l8SdatMZ3mSbszdeGJtxMDRD9cIJ7nI=@lists.denx.de
X-Gm-Message-State: AOJu0YzgZO5eF769eMEt4+eh99rGn7wFZgaSRZlW4EabwaatnbRZSNCs
 mie0K38dCGBVjAqau+u9jWllyyNBXQXjAm9djAIDKwF/7uNqdrTSffhRkZhQiugTt20bOAWh0e4
 +XNZSIxMNmE6IpyRR8BXrCPKdsqiS+z7uj7wZssOZGwVJ02kt3DNBalxc
X-Gm-Gg: AfdE7ckiUDDF/iktbwxzB7opt5BKiW+o7dUpa9ffblMuqNW4/dS150+akn2/XZS7OSe
 jFdxT8Dxui5xqN8ka6S2WYn02PteTsohnqs2HlfcXBggT4HF5OMt1rXSG6n0w94uzdTZGV5FxMF
 TSpli3Z7GJR8hEsBu8qGZBfQTNRO8rHPmu6czNNFymTQgkFDkzLG9s2JdwCQAGlaq3qG7S5ITbw
 nMZHhHbKVS/2uoBQYy74Bz90t57ZIjJ4g8UQntK/Bc8yoQIQINAwlhRphBmH7cAI5HUYjmfAMX0
 ilNhoZww+HNxJAWiR2lYoLDTZ9MacYPcr9fyRZYgzA6D5LhjrXy+2+EzCUfx6B78TTtxl5RByRW
 pnnpLERimOOCaVDfYlNH+us8OT5m8zTdsGbi5FMB2oBxUjFNl
X-Received: by 2002:a05:6a20:d497:b0:3b4:669c:ee32 with SMTP id
 adf61e73a8af0-3ba4f6424b1mr2682994637.37.1781779082279; 
 Thu, 18 Jun 2026 03:38:02 -0700 (PDT)
X-Received: by 2002:a05:6a20:d497:b0:3b4:669c:ee32 with SMTP id
 adf61e73a8af0-3ba4f6424b1mr2682892637.37.1781779080989; 
 Thu, 18 Jun 2026 03:38:00 -0700 (PDT)
Received: from [10.151.41.150] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c88949d0d91sm3434243a12.24.2026.06.18.03.37.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2026 03:38:00 -0700 (PDT)
Message-ID: <a6acd114-152f-4ad4-8347-da921c60c0c3@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 16:07:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] arm: snapdragon: Make SYSRESET_PSCI optional
To: Casey Connolly <casey.connolly@linaro.org>, u-boot@lists.denx.de,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
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
 Michael Srba <Michael.Srba@seznam.cz>, Simon Glass <sjg@chromium.org>
References: <20260616-sngboot-v3-0-6fb0dee8125c@oss.qualcomm.com>
 <20260616-sngboot-v3-1-6fb0dee8125c@oss.qualcomm.com>
 <3566a21d-b560-4b32-831f-c4eb988586d3@linaro.org>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <3566a21d-b560-4b32-831f-c4eb988586d3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: QMQ8hnsaHGDqVoN6vfepRmsvNAkPJZ8B
X-Authority-Analysis: v=2.4 cv=DNy/JSNb c=1 sm=1 tr=0 ts=6a33ca8c cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=AcxecPEDErLH2BMamQsA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: QMQ8hnsaHGDqVoN6vfepRmsvNAkPJZ8B
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA5OCBTYWx0ZWRfX5IhHLcPERA+k
 +zD9DWYGF+wfsWiEAktHPVdMDgB2waf4WMdseBgoYKGMn/tsKdaiRFwvQIgykN/UH9hDcTARZV4
 Qw3wStK1IFWYTZKj2zd++N8xMsCEiiQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA5OCBTYWx0ZWRfXwxOgyJ9GOVww
 cPhVVRrvh3AzvQ+TZv3otVL/JjwvMOzL+zKyRM2jYtEFshZ/f99xyj29qYbtdf/RSJQkfYYwkeG
 chq6bL9pNncmG6XYt8wsCmRpNjleJ4SKeYBEQwrpUNLYabDBdscjD8adHyC1mLQ0cb+b6ZOFfAz
 tk0/quKkQx+e0+A9rrfTXQodwQKutYT2Fo2vZ94zTsGGrdKWH45yx4XY+VEEXDGfknVAoHyYAFI
 xQ7f8XP1IZsXERA+SwQGbSyqINdnzh5xoraU0yk4xGB7JgLmR129E5xf7YS/2EEyzby6paDaHU5
 9JzLBY2ZSy4nKOUvimRQ49hX/89fHE4bXuqR/nR0QUg1addxhZVd93YiMR45bg/Lkb3B09MM3wg
 ZKsHxRIeQZgfGI2Yd/msEpqsV4xTR2Dg65/Lkj72gkZqdI+R45eESwDZzP9zrH9YmERGiuoC1Qa
 9+krCtT+CTgdHwqJA4Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
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

On 6/16/2026 6:21 PM, Casey Connolly wrote:
> Hi Balaji,
>
> On 16/06/2026 11:22, Balaji Selvanathan wrote:
>> In snagboot mode, U-Boot is loaded directly by XBL without a prior
>> bootloader to initialize PSCI firmware. Forcing SYSRESET_PSCI via
>> 'select' causes failures in this scenario. Change to 'imply' to
>> allow it to be disabled when PSCI is unavailable.
> General feedback, I assume you're not writing these descriptions by
> hand, they are overly verbose and don't convey much useful context. This
> doesn't need to be a paragraph, just:
>
> "In snagboot mode, there is no PSCI firmware and U-Boot will crash if it
> attempts to make PSCI calls so disable it in this case."
>
> It isn't acceptable to send me patches like this that have a full
> sentence explaining how it changes a 'select' and an 'imply', i can see
> that from the diff.
>
> Please do better, take 30 seconds to write a sensible commit message.
> This goes for everyone with an @oss.qualcomm.com email

Apologies!! We will try to be consise in our commit descriptions going 
forward.

Regards,

Balaji

>
>> Reviewed-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>> ---
>> Changes in v3:
>> - No changes
>>
>> Changes in v2:
>> - Newly introduced in v2
>> ---
>>   arch/arm/Kconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index 514bf2000b4..a6d36f39069 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -1150,7 +1150,7 @@ config ARCH_SNAPDRAGON
>>   	select SAVE_PREV_BL_FDT_ADDR if !ENABLE_ARM_SOC_BOOT0_HOOK
>>   	select LINUX_KERNEL_IMAGE_HEADER if !ENABLE_ARM_SOC_BOOT0_HOOK
>>   	select SYSRESET
>> -	select SYSRESET_PSCI
>> +	imply SYSRESET_PSCI
> Let's not allow disabling SYSRESET_PSCI in defconfigs.
>
> 	select SYSRESET_PSCI if !QCOM_SNAGBOOT_MODE
>
>>   	select ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR
>>   	select MMU_PGPROT
>>   	imply OF_UPSTREAM
>>
