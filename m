Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53006C44501
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 06:32:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2161849AA;
	Thu, 16 Jul 2026 08:32:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="lzNCpyB5";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PAj0arRF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4622984B48; Thu, 16 Jul 2026 08:32:52 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8231807C4
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 08:32:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=badhrinath.s@oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66G3wamB1754298
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 06:32:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 l5941pDUMVnKM3XD3V89uyPOys1ueGmcbKWNTHrieS4=; b=lzNCpyB5G01DuY3M
 h6aU0Y2LFLq48oXjOtIkZjFKepXkGtll3w7jxcIW1wcDPb8kOy/Z8mu7Q1Sxenhe
 FFUcC2k22nbdUYrktDvRommjw+V2pvlRpwSGvIDgsTg9Px9ugctIH6YoDQ2fAQ7n
 HGaaWsztYz+zYlx9QkKYmaGtifELIgZNOYcQ2i4M18ATUdoLYdm84OVt9GOLZJIJ
 6btvN8XtXOmoxeA6ZJyJGFIfWIouyzK6X0Dx3weIIZ2hStN7qGE3AEhFeRsC9edS
 yWh4CLHZ5HO2VU/98BeLSTx35sffw64gETsgUAxH5Iyb/6vE9TjQoH4klHmnOn+d
 3exQcQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fe855cb8v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 06:32:47 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c856470fe9fso2703598a12.2
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 23:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784183567; x=1784788367; darn=lists.denx.de; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=l5941pDUMVnKM3XD3V89uyPOys1ueGmcbKWNTHrieS4=;
 b=PAj0arRF9jkgH1BXffefLJsl2CSvCmJBSdbIge6mSoiZ+73te3+0i4RghXmjx8yBgT
 8Ow7GuZaxVo14sQokReOrykFbyyFXRIB4WqJzteBYis5iLAikcVFEKaGdACmqYOA7AL+
 skStLhwN/5JvSSJ/DeF5UwkOXwKqT8eXFrAuDUwvHDSgx1vsXkekGs19r7J66LOWY9rr
 CLsvHeyk2C2J/+0ZRrR+9dbB/FYADv29ZXjHhdMCkN+eXc5+wWC/MbrfKX40FRqv/rw5
 aGUzG53wMFiT0JoUtqiREgB62olb8HgBkttfD/EeXafJdgZAeUaqzr7qBybV09jqZUkH
 g3JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784183567; x=1784788367;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=l5941pDUMVnKM3XD3V89uyPOys1ueGmcbKWNTHrieS4=;
 b=pixZhBM3hcKOyxmi7E29r5B1w0cNYEs48BRplqu2F8NA21qDJfYzAMMalizX/h8FHW
 wNOeAwF1LZXsIOHiHRa9ouFDQ2CaSWeYpapOtMF+PKX6vRjcyZKybBXgyw7+PfU/N4ym
 J2Z/5goa7f761URDbPGgAeupNicQvBwjNLvW5elaP6VNn9gOxfa2vOChz8xmdsRNFVsk
 HTMUdmzz32InqN5OTS34dGvdj/NNn0dlodTQfidpSVykwJbgO5xhGCeR1vLf8nj+cCNF
 ki0It4jEHJqfdOr0p/85BO3FdFFbtW4PIB2qrDVWG5DAEA9QOJZaTtR8VqtpwBwHrrcK
 POLg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq/+ZPNABy4meUDIUe+eZDKJg0F9svu8IPq8aOX5ADIFaXCo9vvHccAv1d1twij7L1ipsQ5qdU=@lists.denx.de
X-Gm-Message-State: AOJu0YxBmUTI8BsGaAX61x5xpbCXH4d/qKTby9shRngMf5n7malUj0FC
 112QJ7y9ModA1h1fxhqBuRC/R0nhaq/rFJ1B01Ka7v2iKEw9DoX1dQOlZmtzinXhvjRA7E4LBNl
 fuM3GDx49hRoKbBmQtKsDpe4QfUT1RHSCur89/7tUUhP/8EhaFR4LfEi8
X-Gm-Gg: AfdE7cnCQVbxqwYZ/WZrBrrYtj74+W79QMeajZHk4aH1mSagMUQzot2CcBfq49RpiYL
 i35NKte7QJqGmcerEUBVVRW1uCXj7rjr4FtplKslrsZh5IZrUbkPvemB11yAZXaS+hoA6a3kg7J
 8cmqN4MdBBCDWmZOJfpO8mUNgSmK55+HgQBFhg2qutJloYadf54sekhjmHZWGsf5iIv19zx6Hp5
 QPgzbW7IYDud0hmp5tRcgy2821QiDtfPxm+rJktSGuvFX2aKjNxiuAIeheM/F/aQXI8dUq9Aygk
 zo5KeLiNOgXkkha82mOKcia2giZpaVVsY7uVS3J1JCaeTwxOGXD/IN1ecyjvZWmTCIsaP7gjHbv
 IA03Gfn1BiVLhiNCWYSnOj/ngK/8ws1k=
X-Received: by 2002:a05:6a20:9149:b0:3bf:aa1f:4881 with SMTP id
 adf61e73a8af0-3c110ad509cmr21301967637.56.1784183567065; 
 Wed, 15 Jul 2026 23:32:47 -0700 (PDT)
X-Received: by 2002:a05:6a20:9149:b0:3bf:aa1f:4881 with SMTP id
 adf61e73a8af0-3c110ad509cmr21301939637.56.1784183566598; 
 Wed, 15 Jul 2026 23:32:46 -0700 (PDT)
Received: from [10.152.205.146] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3140e531c6csm7824744eec.8.2026.07.15.23.32.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jul 2026 23:32:46 -0700 (PDT)
Message-ID: <f47035e8-7dc0-4f37-a2c4-abb768acf0f0@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 12:02:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] arm: dts: ipq9650: Add override dtsi
To: Casey Connolly <casey.connolly@linaro.org>, trini@konsulko.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, lukma@denx.de, marek.vasut+renesas@mailbox.org,
 michal.simek@amd.com, quic_varada@quicinc.com,
 luca.weiss@fairphone.com, danila@jiaxyga.com,
 balaji.selvanathan@oss.qualcomm.com, aswin.murugan@oss.qualcomm.com,
 adrian@mainlining.org, david.wronek@mainlining.org,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20260610053655.2825589-1-badhrinath.s@oss.qualcomm.com>
 <20260610053655.2825589-4-badhrinath.s@oss.qualcomm.com>
 <c281dc48-a940-4d6f-a886-040a75d6a0b0@linaro.org>
Content-Language: en-US
From: Badhrinath S <badhrinath.s@oss.qualcomm.com>
In-Reply-To: <c281dc48-a940-4d6f-a886-040a75d6a0b0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: TLG0RaBxjSTJbaceRZZUwujdFcQC7uQ0
X-Authority-Analysis: v=2.4 cv=KOlqylFo c=1 sm=1 tr=0 ts=6a587b0f cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=XqHo_Dx6wMs_QF-6aooA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDA2NiBTYWx0ZWRfX1yxzDHns1ZkH
 6aNFUhZ02GwLuKS5/WWKivYv92OHkzPM+7NlKMyIcTsEscdIf4nDEsTvHGcvz3f84NYNFexQ8ES
 OT4Poy94tHiR/He4H2wEBuraMt25rmG8W99ZIUvbrwtFr/i41spyaBOvKNW1bIcNYNJGmmX5VwM
 LVeyZ23eAc9fw+6f/6Vo9HTZQOLETcUlrLK5UwjODXHU36QwX9jDi4i+OrvxAmPVR036w0BmntG
 Q01q9kPQnJz21n3+nRJKIviRj8JoS7otrjQ7nhSixdTpeUkSEcG86m/gsLMCaLeKuSoiCU6COz2
 +DpYcjcOYkrNMnXSbtfq86apFk3urdiy469W50F3xGTOd6tWvbuJ7jq8KkmoeUZ/xXal5fimn/O
 /s/S7kJdLtx6Clr3KvtcfMBNr0d+XuFWPbfkUxkop4SSCK/QpZWJcqb5HvLYo1nhdt3KxxXTbX0
 SpumbiW2Zxm8LEO7Kyg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDA2NiBTYWx0ZWRfX9xr2zxwgqCh3
 6rgAMmJp9pE28DN15xzpL5SCAyHCeevsiAh+utJ5igijr2MWUroJzQj0VA86CH/rYTE6tZREqcY
 NsGQl8xlooc+gz8sxy75UwYefuqIMMc=
X-Proofpoint-ORIG-GUID: TLG0RaBxjSTJbaceRZZUwujdFcQC7uQ0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160066
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

On 6/30/2026 9:14 PM, Casey Connolly wrote:
>
>
> On 6/10/26 07:36, Badhrinath S wrote:
>> Add U-Boot specific device tree overrides for IPQ9650 RDP488 board.
>> This includes memory configuration and SDHCI reset configuration.
>>
>> Signed-off-by: Badhrinath S <badhrinath.s@oss.qualcomm.com>
>> ---
>> Changes in v2:
>> - Fix SPDX license identifier to GPL-2.0-only (reported by Ferass)
>>
>>   arch/arm/dts/ipq9650-rdp488-u-boot.dtsi | 29 +++++++++++++++++++++++++
>>   1 file changed, 29 insertions(+)
>>   create mode 100644 arch/arm/dts/ipq9650-rdp488-u-boot.dtsi
>>
>> diff --git a/arch/arm/dts/ipq9650-rdp488-u-boot.dtsi 
>> b/arch/arm/dts/ipq9650-rdp488-u-boot.dtsi
>> new file mode 100644
>> index 000000000000..4733fc7ccd08
>> --- /dev/null
>> +++ b/arch/arm/dts/ipq9650-rdp488-u-boot.dtsi
>> @@ -0,0 +1,29 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * IPQ9650 RDP488 board device tree source
>> + *
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> + */
>> +
>> +/ {
>> +    /* Will be removed when SMEM parsing is updated */
>> +    memory@80000000 {
>> +        device_type = "memory";
>> +        reg = <0x0 0x80000000 0x0 0x20000000>;
>> +    };
>> +
>> +};
>> +
>> +&sdhc {
>> +    sdhci-caps-mask = <0x0 0x04000000>;
>> +    sdhci-caps = <0x0 0x04000000>;    /* SDHCI_CAN_VDD_180 */
>> +
>> +    /*
>> +     * This reset is needed to clear out the settings done by
>> +     * previous boot loader. Without this the SDHCI_RESET_ALL
>> +     * reset done sdhci_init() times out.
>> +     */
>> +    resets = <&gcc GCC_SDCC_BCR>;
>
> Send these fixes upstream please.> +

Removed the sdhc node from this patch as requested. The sdhc-related 
changes will be upstreamed separately by the kernel team. Regarding the 
memory node, it is currently required as a temporary workaround until 
the SMEM parsing changes are merged.

Link to v3 
https://lore.kernel.org/u-boot/20260716062318.4121929-1-badhrina@qti.qualcomm.com/

Thanks,

Badhrinath S

>> +    status = "okay";
>> +};
>
