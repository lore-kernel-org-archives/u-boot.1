Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11CD9D12D41
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 11:21:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86A2683F64;
	Wed,  3 Dec 2025 12:21:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="m7OzGakx";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IaFk9rig";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8493F83F6D; Wed,  3 Dec 2025 12:21:35 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E26783F39
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 12:21:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5B3B4kUG2626976
 for <u-boot@lists.denx.de>; Wed, 3 Dec 2025 11:21:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 u8hkAE6XXW9XcT2UOrYZH6a4UPQJyFuXT7VUws2NgBM=; b=m7OzGakxUbHfksZg
 j/1bJjc2oIfAJejhdlOarxT+G4Ouz8rPcUptWCKiImANVZnUFFhY0TZHKnBVO2OA
 E+eLiBFyIwPTOQtlpmXyBEif1EF7Ubcz19i7e9cTYqA8An3R/R3p5AUoWsmOiTF7
 8tK+4+LoyTaOFTGjNtVn40ktigbThOKIpCqjsczxjWCnxlVnt/Ku04p3F1QpsOKv
 WCc5vP0Q7cgRMf1tLCtKdSDO3//tmpSsW68y+MTdoeoXjiHXjYEwH0yTF9ZkAU/T
 MugdowTRwvsNDqe9py35GjEwIsPXRrO0M0eK60r7qW3rQ54Rcoian3BzQFDkWNwd
 I4Ws+g==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4atm1281b6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 03 Dec 2025 11:21:31 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3437f0760daso11600040a91.1
 for <u-boot@lists.denx.de>; Wed, 03 Dec 2025 03:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1764760890; x=1765365690; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=u8hkAE6XXW9XcT2UOrYZH6a4UPQJyFuXT7VUws2NgBM=;
 b=IaFk9rigwV8n2BpViooogirN1mvgtyYHcWqu7xvY/iRkrU1hF9HdL7Nt7T/c9UbzOR
 BAFPZ6jPyGCzd78qVzQqiJ5xRjes1R75sXJ+bMCYcfeUjwkAaAbtpGBTtvYq7BmL9WC0
 uhHlcZaf4dXX8EkPZchHBUwEV4jQ+222jNqCIfewaROsA/Yh7lSNQYaCw3gzzUDSUjvy
 Q/IYe12SYaA7adpLd/Xa8EtZroDzo2Mx9FmAmZ6b2o8ikwMiFdFL2AAniF0OYaJszfCF
 mEn0dRYYUbYVAELCD9VBgEcYri91v9RHUHSfGJ4L6E1uFIMHo2hykgzKET4aiuxySywS
 NvVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764760890; x=1765365690;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u8hkAE6XXW9XcT2UOrYZH6a4UPQJyFuXT7VUws2NgBM=;
 b=wMee4Ew8UFam86xi804SzdDaCSV1lFf1IUdnCjNU2RhgJbXzSk1tM0pSvS4bWoyO33
 71n6cYw9uv81n7RpVZp7vrYZyHSFvvXJWEJNgS/j0XIu37CRjA8cw+haOIr3Kxjwd85l
 tJLTuebPtXvETOwSQ83wVEkw/sl7dCP007PxqBAYWcfT7gkdjsQ5vMpuM3hprcBVyZYZ
 Yh/wHiHbhf5pbugo97qJsECTCslqRfPS1IC5+yUUyYK4N0Uvz7l2ck2qxenpObHN/776
 LEsyJ4ii27rRuOfft0EM3zE7HuresaCCjvrh1JC9Pz2UvA9/gJadbiWU8G+8xNcgdR5J
 VCTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOOPBkEvNl7q7tHZAstN71Ei1Gl12UOTJ/tz3F73XwxDWnokT1fk8BwQGkiZEgB6H59bnp6X0=@lists.denx.de
X-Gm-Message-State: AOJu0YxIsD0okZeTLPG0EheqccviMZoLAUjp5DLpZNbG35vYlbo/HMzd
 r/lu8hmIkk7YzDvi8R2S0cIML5Fl71t4xUImD9Q+xF0E4WyduA1H+8CPIZ+IlPAmetv1ZCIFCV0
 b4ctK1lskE6cWzj6KkNHsog3i6q6wXTqZOTJAcUQ+XtqJRZes84nxT/E2
X-Gm-Gg: ASbGncvDVPgpvEzG5AUK4ySNCJw7hAudoZRFTH7sBgWf59dXqztYhycvYmgCZjMkyGY
 TSkrGCBSBU2r9NP1OE95HJHg58qAOof92ZILd6g0R6pjY7SNvuJjV7hUf7GRjh8ynEzSdy6C4Qw
 Hp+QHZZ2i2lrgxO7jNjUZTCIXWMJHY1CyzdrBS2W/+WxT8FGRZN8YUILM6TeOhLrb/i+2i3Hruo
 y2nQkOHLJUiNMSkEj18x6n0ZrQ7+RPM7nIy18QF0QatV6aOUsJnVar8MA1jtv+xp9HDJsy48CMc
 YMwY8wGXvENyTCzd9eup9t8MkBs+cUH7wvd7r2eeea2U9nsiJ+edRiTOijw+6H2VWOk3O35NAGL
 6aR6BDAohycIC2a/J1rmQhq9BoAco20OaeRFXt4Nq5RhpdEw=
X-Received: by 2002:a17:90b:1c92:b0:340:ad5e:ca with SMTP id
 98e67ed59e1d1-34912700a15mr2772761a91.12.1764760890434; 
 Wed, 03 Dec 2025 03:21:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFM3qeR/ou07c0Sw/pJrN/TDw/HMJZhcLXOE3Rxa7ececvOCefTF5VHy/J44w7uO+goE8Ly9Q==
X-Received: by 2002:a17:90b:1c92:b0:340:ad5e:ca with SMTP id
 98e67ed59e1d1-34912700a15mr2772688a91.12.1764760889806; 
 Wed, 03 Dec 2025 03:21:29 -0800 (PST)
Received: from [192.168.0.5] ([183.82.204.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34910a80656sm2473525a91.0.2025.12.03.03.21.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Dec 2025 03:21:29 -0800 (PST)
Message-ID: <69375261-2c75-4093-9dd3-a3a97505c417@oss.qualcomm.com>
Date: Wed, 3 Dec 2025 16:51:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] arch: arm: mach-snapdragon: Make USB speed fixup
 configurable
To: Casey Connolly <casey.connolly@linaro.org>, trini@konsulko.com,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@denx.de,
 seanga2@gmail.com, marex@denx.de, malysagreg@gmail.com,
 arturs.artamonovs@analog.com, utsav.agarwal@analog.com,
 vasileios.bimpikas@analog.com, ian.roberts@timesys.com,
 nathan.morrison@timesys.com, peng.fan@nxp.com,
 alif.zakuan.yuslaimi@altera.com, kory.maincent@bootlin.com,
 sjg@chromium.org, jerome.forissier@linaro.org, ziyao@disroot.org,
 stefan.roese@mailbox.org, mkorpershoek@kernel.org,
 rui.silva@linaro.org, ilias.apalodimas@linaro.org,
 luca.weiss@fairphone.com, quic_varada@quicinc.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20251124155503.2839766-1-balaji.selvanathan@oss.qualcomm.com>
 <20251124155503.2839766-5-balaji.selvanathan@oss.qualcomm.com>
 <15b7482e-166b-43df-8a76-cdf150575872@linaro.org>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <15b7482e-166b-43df-8a76-cdf150575872@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAzMDA5MCBTYWx0ZWRfX6+/ILzETj36H
 8ygBGSIvVqHeznORV92s9/L/4n/bAa3Jgoj/MfYky8hHOowKJZrvJcV74v6wRXcP13KfycwNih1
 W6B6nQiryLems4MUuUBS7u+6etL9A1F9xuczl6tx1QompEF9kqssfGvbySN6+CiSLCKkB4d2V4C
 qaBEuve91KCin6SWm8vjF+DgLvCVEpbyod5kFz1mUIUSY0ox1/KYe4P/7B3KbntD7rJzV45G5dP
 0gvn2YwzHMty4d2P9SibIyIG6s+pUp0VCIUWIBk+8lVdJVJkMTH/c+mTPl0ls/xu/T/m9zPcJ0V
 iLjYOdUNW7mXGy/o01NKgw3jYbdFuODMVUY4EiSkKM+TBkfwSOBAWp1GDI/HOsqVPNxIcxmAme3
 pHEM3sgRVY0knNz0qhS+LwwtiG1Lvw==
X-Authority-Analysis: v=2.4 cv=JY6xbEKV c=1 sm=1 tr=0 ts=69301d3b cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=wdA8WxWTYlLD3QqB3+K4dA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=SUcHXZHRZ00BxVqsa5AA:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: 8TE6HBnaYDSZEI_5DUXydkX8SlaFzbiF
X-Proofpoint-ORIG-GUID: 8TE6HBnaYDSZEI_5DUXydkX8SlaFzbiF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-02_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512030090
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


On 11/26/2025 7:54 PM, Casey Connolly wrote:
> Hi Balaji,
>
> On 24/11/2025 16:55, Balaji Selvanathan wrote:
>> Add CONFIG_QCOM_USB_FIXUP option to allow platforms to disable
>> the USB speed limitation fixup when they have proper super-speed
>> USB support in U-Boot.
> In general, we prefer to handle cases like this at runtime rather than
> compile time. Could you rework this to check for the "qcom,sc7280-dwc3"
> compatible and just skip the check in that case? I would also propose
> adding a log_warning() in the fixup case so that folks working on other
> platforms know to add their compatible too.
>
> Obviously that's still not an ideal solution, maybe it would be possible
> to implement the Super Smart (tm) fix and actually check if a driver
> /will/ bind to the ss-phy node before the fixup, it depends how slow
> that would be.
This is good idea. Actually, I have implemented the super smart fix 
rather than hardcoding

"qcom,sc7280-dwc3" in code. The respined code is here: https://lore.kernel.org/u-boot/20251203110735.1959862-5-balaji.selvanathan@oss.qualcomm.com/;
The code checks if the SS PHY driver is indeed available and if it exists, then it skips doing
USB HS fixup.
The entire time to check if the SS PHY driver is available is ~125ms. Request to say if this is reasonable.
The power domain fixup is taking ~98us (mentioning just for comparison).
Thanks,
Balaji

>
> Kind regards,
>
>> Currently, U-Boot limits USB to high-speed mode on all Qualcomm
>> platforms by fixing up the device tree at runtime. This was
>> necessary because most platforms lacked super-speed PHY drivers.
>>
>> However, newer platforms now have proper QMP PHY drivers that support
>> super-speed USB. For these platforms, the fixup is counterproductive
>> as it prevents the hardware from operating at its full capability.
>>
>> This change:
>> - Adds CONFIG_QCOM_USB_FIXUP (default y) to maintain backward
>>    compatibility with existing platforms
>> - Wraps the fixup code with #ifdef to allow selective disabling
>> - Allows platforms with super-speed support to disable the fixup
>>    via their defconfig
>>
>> Platforms without super-speed PHY drivers will continue to work
>> as before with the fixup enabled by default.
>>
>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>> ---
>>   arch/arm/mach-snapdragon/Kconfig    | 10 ++++++++++
>>   arch/arm/mach-snapdragon/of_fixup.c |  4 ++++
>>   2 files changed, 14 insertions(+)
>>
>> diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
>> index 976c0e35fce..6c53aeef597 100644
>> --- a/arch/arm/mach-snapdragon/Kconfig
>> +++ b/arch/arm/mach-snapdragon/Kconfig
>> @@ -29,6 +29,16 @@ config SYS_MALLOC_LEN
>>   config LNX_KRNL_IMG_TEXT_OFFSET_BASE
>>   	default 0x80000000
>>   
>> +config QCOM_USB_FIXUP
>> +	bool "Enable USB speed fixup for Qualcomm platforms"
>> +	default y
>> +	help
>> +	  Enable runtime fixup of USB device tree nodes to limit USB to
>> +	  high-speed mode. This is needed on some Qualcomm platforms where
>> +	  U-Boot doesn't support super-speed USB.
>> +	  Disable this for platforms that have proper super-speed USB support
>> +	  in U-Boot.
>> +
>>   config SYS_BOARD
>>   	string "Snapdragon SoCs based board"
>>   	help
>> diff --git a/arch/arm/mach-snapdragon/of_fixup.c b/arch/arm/mach-snapdragon/of_fixup.c
>> index eec2c0c757e..6a64168f67e 100644
>> --- a/arch/arm/mach-snapdragon/of_fixup.c
>> +++ b/arch/arm/mach-snapdragon/of_fixup.c
>> @@ -27,6 +27,7 @@
>>   #include <stdlib.h>
>>   #include <time.h>
>>   
>> +#ifdef CONFIG_QCOM_USB_FIXUP
>>   /* U-Boot only supports USB high-speed mode on Qualcomm platforms with DWC3
>>    * USB controllers. Rather than requiring source level DT changes, we fix up
>>    * DT here. This improves compatibility with upstream DT and simplifies the
>> @@ -115,6 +116,7 @@ static void fixup_usb_nodes(struct device_node *root)
>>   			log_warning("Failed to fixup node %s: %d\n", glue_np->name, ret);
>>   	}
>>   }
>> +#endif
>>   
>>   /* Remove all references to the rpmhpd device */
>>   static void fixup_power_domains(struct device_node *root)
>> @@ -157,7 +159,9 @@ static int qcom_of_fixup_nodes(void * __maybe_unused ctx, struct event *event)
>>   {
>>   	struct device_node *root = event->data.of_live_built.root;
>>   
>> +#ifdef CONFIG_QCOM_USB_FIXUP
>>   	time_call(fixup_usb_nodes, root);
>> +#endif
>>   	time_call(fixup_power_domains, root);
>>   
>>   	return 0;
