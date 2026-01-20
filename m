Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 470EDD2ED11
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 04:31:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A60328389A;
	Tue, 20 Jan 2026 05:31:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="KTILd1dY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JCUZBNMh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9013839DF; Tue, 20 Jan 2026 05:31:08 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83AE482A9E
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 05:31:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60JHANfY1905335
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 04:31:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aWjbcgPUWgFmln8Mm6C3yOv/ziwdjHuavBqfkfsyYfw=; b=KTILd1dY4gLY9GL2
 ZJN3m4/S75PZSj5YYNg2PGnP4m6DviWfvh7G9BiNVEDirYKodIJe9h2xM10WKLty
 S8aHlWe8txfkxAZepY/p3BkvxVwbP5ffUe9O509cLiFF3LmchsPPI8slQaqu9s7r
 9mKdSB9ienumYDKe7jwGWoO53sJ7waDpbG99fim/QtmIqokN1gaYefwT4L3QClBw
 AViFaaev7fYvPl+mSMCY/5DOPlh3zDYaXuzAYdjaRTA31HZ8HrqqH6Pp4wLaqWQP
 9qdR9RDtcKz6zlS7wnZcRO2JRJzgfCkmWAR3xpfdHWlfVeuUcPjiuo32EtQLOYAP
 98eO3w==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bsgmub037-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 04:31:04 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-34c66cb671fso5156445a91.3
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 20:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1768883464; x=1769488264; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aWjbcgPUWgFmln8Mm6C3yOv/ziwdjHuavBqfkfsyYfw=;
 b=JCUZBNMhcfdyLzpC7OyT77mEpqhBR6rzFgpJc3iwj+NjUUGn1oGSTSx9UFdwxBZvq0
 qXB9bNUpN7cEyWUDA/zKHUhAWSma/vMBDpTsgCFU6iKaCaIeg9n+BQlohrcJWPv6Jitc
 TKLSwp2haTj7gtCbCst1a3I1Hkj7fd6GJM3BE4hb7zrsA9xhxOSODkCvm8qrtMtceYlB
 t8khSoqMMuS61kFYZHnaTlTwusCQ+1WQowWmrG8wwjFteJ1LA5ZmAOJ8XEKpB1A5i8dx
 lx1ku0s1OrViSA4gGSFSGEXlwofzeuvtGmY4vaRpNTt7oROgAYKE07wCWO1JMclx9SWp
 dqtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768883464; x=1769488264;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aWjbcgPUWgFmln8Mm6C3yOv/ziwdjHuavBqfkfsyYfw=;
 b=acGDwP18F0qWKG8Rti49146W+sWlI7QYXVLfkOtKM0MTpEWBhQlXpdYWAf/+tuusMF
 F+16Vr4CdWT5B0/gtVJ3jKttrkoV2XG2C3gRXMt7GczUkWBPwEBPwzPlI2DlgLivkQxB
 wSb4V6gsF3N52fJM2fsTwTqitwwclcwALs9vn0fHyIPnKE9s5rZEB0aNRzZ7pARv2jiw
 UORIj1w086q4O2jCBo3/BmuU24G62z2Oyx/EW2V8oxLHQcD1cBPvoFYHR8LZx8J7jIvV
 a7t31nZereADC3LTFeQrz4sdWED7n6u0k8x0256oH236YrO8D2fRM/c4enYjTn9+q/Sc
 mqRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfwy8HHhSrt6vqMCW+6twPt50HEUm6UxF21jnKf3GFQ7HRjaapYNzhvN0Ze99LbRdjw4Hf32M=@lists.denx.de
X-Gm-Message-State: AOJu0YzUtlkIxp9th2iG8apbHVO+/111Lt8J0Y7Mdc5vkGgqkDRK74Mj
 MvDjrHKbHAo83NEbha3CDLzPucudL+Tif8u3ptcMvpxfEPppV35aalwAd7jR0JfWbYwKo2MBOwW
 fCwDB6X5+pcoHPGEN6s1OKd+h1tg/amjp1FniAjoDCsk19SA30ES//CBv
X-Gm-Gg: AY/fxX79aPHkwJ859EAOFlhzOAnvz89fnLLpzRG+Sz1+7KvMxKj27vE0XDgL2TCYea/
 dX7d6PrI9cWQ5DTiDW/mlcCXx0jXZTdTdHlpxgVxEzw5oRoRBejUpgS+bhQXq7xn5z4TzVYtVD/
 xHf7AtaKxD+smKS1EMg2i/SFvvkwi1bipxYC7UOcVLk64212+VSPkLMch2dE9fxDBL2mu4d1FXF
 B+QMYmuG2150KWhouTAIDMa4yJWpPKoDFV47SyL+AWLfZhdNhMaE2JnzS4czgu2SHjgElFW1pGf
 w9pp8K+bRWqiNVytPY2AuhazgjimRP+ky/zETGZymWuIHUgRXW8u5E4dgX26aAxXy1Wr0HsE3Ny
 64bPeyc0YTOiP1NuvRFs3pgdWRFJNpkCbOj11mezYw/A+Xg==
X-Received: by 2002:a05:6300:4096:b0:35d:2172:5ffb with SMTP id
 adf61e73a8af0-38e45e34bfemr669485637.47.1768883463892; 
 Mon, 19 Jan 2026 20:31:03 -0800 (PST)
X-Received: by 2002:a05:6300:4096:b0:35d:2172:5ffb with SMTP id
 adf61e73a8af0-38e45e34bfemr669461637.47.1768883463369; 
 Mon, 19 Jan 2026 20:31:03 -0800 (PST)
Received: from [10.151.40.21] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-352677ec702sm3192767a91.5.2026.01.19.20.31.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jan 2026 20:31:02 -0800 (PST)
Message-ID: <55809fdb-1da8-4e4a-810a-62d034d1e745@oss.qualcomm.com>
Date: Tue, 20 Jan 2026 10:00:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] arm: dts: qcs615-ride: Remove unsupported USB
 clock reference
To: Sumit Garg <sumit.garg@kernel.org>
Cc: trini@konsulko.com, aswin.murugan@oss.qualcomm.com, lukma@denx.de,
 seanga2@gmail.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, alexeymin@postmarketos.org,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20251114063804.3835132-1-balaji.selvanathan@oss.qualcomm.com>
 <20251114063804.3835132-2-balaji.selvanathan@oss.qualcomm.com>
 <aU5h8TrvG7GALEMc@sumit-xelite>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <aU5h8TrvG7GALEMc@sumit-xelite>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDAzNCBTYWx0ZWRfX6e1lRKOvqhym
 SGGPzt/mI3DnRz+fbRkUaA9CSEZAHuVYFRLDrs9OPHsaf/7PtPMdviFj7diBfegECq1fmIMQx8B
 YBGcPScYR4scsGKYqD5MwiTitQyN4sBU2CRJ/7xZktNvlMQrtjYWfv/LxJBocQM9s/IlK9VFyah
 Qg1ImipzjcwmLo6de2QnWTV5Cz2c03EAKeHO2HBtFr5kIzhOZFzYVTjTP2EuM9GE4qPhXAANuwB
 aECWqS9gkIKlCjjx8+rgW0Swo0TzRmpu7llpANw6Cb53feUQ/7MlwKeYCrD+mtUl+nBTwRt7lFa
 DuFD9pSYeSxJsHINHTx6BO7ZqFSxrbRtydRKgD6pTnAJgD9PHkzhbAVS/IK6ogM8wg6PujIqLvh
 gljpZSZM90rpO9QeZYIHfA6vFVfjtGnRnmi5IKIKSk5ZKqkURIfQTyazcl7ehWJSVO4tELZWX0F
 9FN4Y3wtq2MpGtNtqbw==
X-Authority-Analysis: v=2.4 cv=Is4Tsb/g c=1 sm=1 tr=0 ts=696f0508 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=nfy7SHvoiUpjxo61HXgA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: OuSk1RN4EVOLkIgF5ZZac9E_Pfy8ukiB
X-Proofpoint-GUID: OuSk1RN4EVOLkIgF5ZZac9E_Pfy8ukiB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-20_01,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601200034
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

Hi Sumit,

Thanks for the feedback. Please find reply below.

On 12/26/2025 3:52 PM, Sumit Garg wrote:
> On Fri, Nov 14, 2025 at 12:08:02PM +0530, Balaji Selvanathan wrote:
>> Remove GCC_USB3_PRIM_CLKREF_CLK from the USB controller node as it is
>> not implemented in the U-Boot clock driver. Keep only the supported
>> clocks to avoid clock warnings during boot.
> Rather than overriding DT, why can't this be implmented in U-Boot? And
> how why it isn't an essential clock for U-Boot operation?
>
> -Sumit

GCC_USB3_PRIM_CLKREF_CLK seems to be a reference clock that is enabled 
by earlier boot stages before U-Boot starts: The clock is already ON 
when U-Boot starts - verified during boot. This is a reference clock 
with hardware voting mechanism, not typically controlled by software.

Without this override, we get "Clock 152 not found" warning message (as 
it is not there in the QCS615 clock driver.

Regards,

Balaji


>
>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>> ---
>>   arch/arm/dts/qcs615-ride-u-boot.dtsi | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/arch/arm/dts/qcs615-ride-u-boot.dtsi b/arch/arm/dts/qcs615-ride-u-boot.dtsi
>> index 68fffc70fcb..d8af124cc27 100644
>> --- a/arch/arm/dts/qcs615-ride-u-boot.dtsi
>> +++ b/arch/arm/dts/qcs615-ride-u-boot.dtsi
>> @@ -11,4 +11,18 @@
>>   		      <0x0 0xc0000000 0x0 0xc0000000>,
>>   		      <0x1 0x80000000 0x1 0x00000000>;
>>   	};
>> +	soc@0 {
>> +		/* Remove GCC_USB3_PRIM_CLKREF_CLK from usb_1 node to avoid U-Boot clock warnings */
>> +		usb_1: usb@a6f8800 {
>> +			/delete-property/ clocks;
>> +			/delete-property/ clock-names;
>> +			/* Keep only the clocks that are implemented in U-Boot clock driver */
>> +			clocks = <&gcc GCC_CFG_NOC_USB3_PRIM_AXI_CLK>,
>> +				 <&gcc GCC_USB30_PRIM_MASTER_CLK>,
>> +				 <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>,
>> +				 <&gcc GCC_USB30_PRIM_SLEEP_CLK>,
>> +				 <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>;
>> +			clock-names = "cfg_noc", "core", "iface", "sleep", "mock_utmi";
>> +		};
>> +	};
>>   };
>> -- 
>> 2.34.1
>>
