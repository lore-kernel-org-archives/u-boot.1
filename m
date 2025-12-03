Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C53D12D47
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 11:36:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1399583F6D;
	Wed,  3 Dec 2025 12:36:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fnpn5n0n";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="imE/9Xuw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DE6583F85; Wed,  3 Dec 2025 12:36:51 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8700683F39
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 12:36:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5B3BRqUr1975053
 for <u-boot@lists.denx.de>; Wed, 3 Dec 2025 11:36:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MJ9wMwOtgKDNVtz7099oEEYCIjPdUQOQS29LWiPFikc=; b=Fnpn5n0nD5ym3vx9
 CED1RkPmWTli+V0q1cdnhnQL6SfkCnRz1s1/vUBVsOY/95DHI4Nmgk6od79iGM6J
 6bKFiwGSvrw7Zi39D5m9pZQzAl/IciBdJOmDnkG4zy2FvnpF2wwSUg1fp7hdeeuo
 TkRNgrYk+3HAeL2X1IELDGjMC4c1x6RG1C0zzb9M0QgUcfYH8rxROZvnQ15JTZ1s
 fUZMsfM+VFy4cESZI6zC1lqImfH20I3IAET/S7NdRAeqzOwqvrKpY0AthfGkkbaC
 f2xFHaMlxniZcIMhAQhHixWFLbHuTIezbI7U9VpyBvmGXVrPqzZ+YYA6URep/c0+
 N+2seg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4atmbtg0rh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 03 Dec 2025 11:36:46 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-7b9ef46df43so6528251b3a.1
 for <u-boot@lists.denx.de>; Wed, 03 Dec 2025 03:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1764761806; x=1765366606; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MJ9wMwOtgKDNVtz7099oEEYCIjPdUQOQS29LWiPFikc=;
 b=imE/9Xuwx4DdmaJ6hKO4OUiK9bHSjMd4HAep6Nlgp/jvFH6ESLGLhcOSB6qGs2tSJ2
 fheS+eapPugHFxdSqDbpEnrq5MQty4cTDQCWMIeEm6ByQY7wlb0EdWXz4NVucwJUg2/2
 iEyGueyRzpOyeX++8qxykbOM5Rxxrqp+ZX9phePcm25Iaq6yaDBl5gcHKzTUK34Tugol
 xnZwA+7pdzsiFWM4XX+U9Txduf3twOx6SA5lmjJ2YlVRH9ZdULHvZ6bi6GN4RNihMBz0
 FRVrO0sn0W8tMPhN52hvWmRhH1PsCelkqW/DwL1Hb8Tq/6AY55M2nBnOm3d/1p7rpsXF
 TVxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764761806; x=1765366606;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MJ9wMwOtgKDNVtz7099oEEYCIjPdUQOQS29LWiPFikc=;
 b=TaEl5ulBIHPJV3r3E+ZJ+ABymkaFd0etq5ROoNRMShoOzJ9PhuCn+1EpXBbLAB30VE
 6tdStnwea9R8TU87BFX+YNM+eXmEIHy4rM+9oZcSsyH9ZaQdEXoH1yfezgho3R0J+07l
 zwJgy4LIL088OmDrZr4ClsP2Ld7oZOzyT/8ItxSf91TwWmdMqmxgJP3i7QcYmgowJCxW
 PeT0gfued51Dw4xGoqOCNqvTwRKL12SCryaciNy/2n/8W3cZmAGIOcfml5RV3jOWl+lw
 qfwOIL1Mn5bFO8f8t5f0aqyjz4H1quoJn2C1aoV9sVv0Nk1EL21oLEl+JgHiwWHgOGYZ
 /HWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlG3jfbyaj2jpkb4UIiSaHyHDLtUUmTVwjPk+6pY8llMsuaOB5J3Fz9r4jUex+saZXvoWyLmk=@lists.denx.de
X-Gm-Message-State: AOJu0Yyzn1jDDGqYv8IgYpG9HJjZdNRALEYGoN3cuBFM1Pe6qGTov7Wn
 nLXZP6m1eoNZBiXlOHhyOw8EdtaiUBZ2EUxPEJCZAYGOZxKgeDzipVDR3G/WqPClC4/65PfE5RB
 jR9q2dy1CvYMN3rgv8+DkQK6NTNTWW3edsh1IMpcSWR1w7wpheJyHHTau
X-Gm-Gg: ASbGncvVJyWllTCrSiULcjKINv513LZP6WKoNYBJHzyBlqHNDRaX2L2OEvXhR1Lt/5v
 2VnsY8VMtpj00DoKyBalvq5tYKJFdKwWcAKXx+FFWX0Syq35Sq3R/wU9FR+Vgh6dxBzXJzsSNnP
 WbAB0LJ55Wbr4LPEdCCU13qhGxzw93ehlHM33sF6axMzZqoaglGBqIhrAQuq067+m1XQSUbdDwS
 Rfx8KYHIbdL2uq74iuun/1fRuiU4vQvd2ia9JLGP30kMTJFgdNH8P5x6S2yBVxBf63X0eym8cnE
 51E9hGFeQgeF86631j1djLoIPf+pbk5Ua3kRmPJ/XjgfLSoll7QfcyECP7e4o5mz9VV6VwVdlmt
 A5cQXNXlgf+2gy94+uZ2z+p57OYmgWCW9moTfLw3+j1lYGcw=
X-Received: by 2002:a05:6a00:10d3:b0:7b7:631a:2444 with SMTP id
 d2e1a72fcca58-7e00eb72335mr1920351b3a.22.1764761805739; 
 Wed, 03 Dec 2025 03:36:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE75zbKFVfzbzyO4zscG7JQayKYKhXPcfFtIs9sDpiTx4i0nlbuigQQCCQy6TmufFKcrJtzCA==
X-Received: by 2002:a05:6a00:10d3:b0:7b7:631a:2444 with SMTP id
 d2e1a72fcca58-7e00eb72335mr1920328b3a.22.1764761805244; 
 Wed, 03 Dec 2025 03:36:45 -0800 (PST)
Received: from [192.168.0.5] ([183.82.204.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7d15fb1417csm19818052b3a.60.2025.12.03.03.36.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Dec 2025 03:36:44 -0800 (PST)
Message-ID: <9bba86af-74c9-4540-a32b-3c5d12eddad5@oss.qualcomm.com>
Date: Wed, 3 Dec 2025 17:06:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] arch: arm: dts: qcs6490-rb3gen2: Override USB3 PHY
 clocks
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
 <20251124155503.2839766-6-balaji.selvanathan@oss.qualcomm.com>
 <bc4f1b0e-36b5-4cf1-a6f4-4f595db40ced@linaro.org>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <bc4f1b0e-36b5-4cf1-a6f4-4f595db40ced@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=KNBXzVFo c=1 sm=1 tr=0 ts=693020ce cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=wdA8WxWTYlLD3QqB3+K4dA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=GZkVBmGwvfKU06HuWzkA:9 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: e77jtqFeXcurkYw-gpKYyiAkf9zSgHq5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAzMDA5MiBTYWx0ZWRfXxw0WWgF/KuNu
 vlZNkqBYjqZOAwVFXreqp/iOGf9LoBPbvNuj13a1qnSGDJu6cUZlwVG9pXvnMm0f2ffIjGHHtFf
 u/ttWK8ryvukO2bg0er5Q0X3AKSgqTmfZqhA9HiEuLH2BEuNJNK5fesXwNoL7cne1tqSmEmSV2c
 TDNOIYG3kamVv64LLqZj6tTZRl1k+Ng49uVOzjJzAWI2iQZprYWWOlfGJKjjgrVU4WWzj9TmlUQ
 dENVyhiwe7Zku8uU4QDN40QEAkDhyq0gdjCq7rSgA4RtD5V2yvEtubJBX3MdLwMGfS7oEfpS3hK
 EnopI4CnR4t9+tDIMbMkUZs0y5XHeMUK13M5HA6e7df/hCzt6qRSb8ILYtdsktJemvngRo4iFeG
 yLF0aHEiuQhGhdUI+DzOI90LTK7GBA==
X-Proofpoint-ORIG-GUID: e77jtqFeXcurkYw-gpKYyiAkf9zSgHq5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-02_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 bulkscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512030092
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


On 11/26/2025 7:56 PM, Casey Connolly wrote:
> Hi Balaji,
>
> On 24/11/2025 16:55, Balaji Selvanathan wrote:
>> Override the USB QMP PHY clock properties to use only GCC clocks
>> supported in U-Boot, removing the unsupported RPMH_CXO_CLK from
>> the qcs6490-rb3gen2's device tree.
> That clock should be handled by the stub clock driver, are you seeing an
> error without this patch (with CONFIG_CLK_STUB=y)?

You are right. With CONFIG_CLK_STUB=y, it is working fine without any 
additions in override dts file. So have removed this patch in this 
respin: 
https://lore.kernel.org/u-boot/20251203110735.1959862-1-balaji.selvanathan@oss.qualcomm.com/

Thanks,

Balaji

>
>
>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>> ---
>>   arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi b/arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi
>> index 50674b692ed..14669b50821 100644
>> --- a/arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi
>> +++ b/arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi
>> @@ -22,6 +22,14 @@
>>   	/delete-property/ usb-role-switch;
>>   };
>>   
>> +&usb_1_qmpphy {
>> +	clocks = <&gcc GCC_USB3_PRIM_PHY_AUX_CLK>,
>> +		 <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>,
>> +		 <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
>> +	clock-names = "aux",
>> +		      "com_aux",
>> +		      "usb3_pipe";
>> +};
>>   // RAM Entry 0 : Base 0x0080000000  Size 0x003A800000
>>   // RAM Entry 1 : Base 0x00C0000000  Size 0x0001800000
>>   // RAM Entry 2 : Base 0x00C3400000  Size 0x003CC00000
