Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B094AC43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 01:46:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45DCE84AC8;
	Tue, 30 Jun 2026 03:46:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="HwNbht15";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WPkP67AK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A736284ACF; Tue, 30 Jun 2026 03:46:05 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12FA0848D2
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 03:46:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65U1JFGA414316
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 01:46:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /ca3GfvQgpLpcmXmmq5DQzeTlsFTRLJvez3S/ek3R7k=; b=HwNbht15Oih/fUQl
 AILuOogR0kVsOEMg4nuwWFk3LBrG/OaXPG7xkxmZYkKGwKsdWWIo8ZX+OCr17SZf
 6xmTHo6OPwG9ddGoxR1fHkEh8MRrpGkaQ/P2sYQiQP9LpDn1fDMsL+ppRkdivCb4
 RGJjtDKZfA+eWB6X+P1xaT0Wmi9B4HyS6PSgYVgDIRftNyJTRxMQx06OmhI23K29
 UszFpLZAnnp5G+87AeYfYZR3Cvo3jcIZRccz32kFfH5TmUvzjqi6RlHE5Mcp3HFR
 HdKpCxMbEDVjju1eJCUvDwfJDx6a2RiJ7G6N7YzxMQJzaug3IOL1MNqJLnCOlE26
 4YjNrw==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3pdkuhx9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 01:46:01 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-138acbc0e69so18801903c88.0
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 18:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782783960; x=1783388760; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/ca3GfvQgpLpcmXmmq5DQzeTlsFTRLJvez3S/ek3R7k=;
 b=WPkP67AKXgiMsfp/3o+zPUAY3lO8iQ/F0eU726DuVe4RriLgx1JNzE45yk7dIQfAAz
 3ZNPZ1/9E9aU/YMfrurXJWBFjIJezDhxJkHXPUneZ9Nz97jqvLKJJvCFXLSNKajOYwvw
 /OpZTanFrhJ1Z0KAC4992rhGF+16czRQiHndp66srs0N1GbFGU/GYA4Ruq28196NSjiv
 r08nyPUSQdKmClaRzlx6h3v4MReTDcIQtAyinec9zcDZZ0IUqxrZddIyb+DuzUhjGi7w
 rWyuS4Ew0WANvzvf7TP6uvmR8OJ8+FHmuMVfO2UmT0MWQuFhXqXL6PJjx4ydccGPwb7O
 /aRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782783960; x=1783388760;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/ca3GfvQgpLpcmXmmq5DQzeTlsFTRLJvez3S/ek3R7k=;
 b=EVJ0CMC0QuMv0kUm/A0ffzf4XFJFeb8QiY8ZqLK76QrtzNaqNsvKEu47cUqSAU4UbO
 kZ3+MIPqh1ucqAK7gqLCXO9xZcR57NVCwqYX/3NGX6zm4qB5uwvALWASKy5dP5L5E2ru
 1IRgfGG/jM7kl9cn/hVBnMwgwl11uCwQmoguWWJyf8MxCXhVcOCFEYwprxyF0NN7TUV4
 ldN7+RexUUc0C8QdHLDzyw9+PR8rThRjyBdk9kb720UC41AbYWZO0KiLnZIshIelHmc/
 MraOxHVxNSGAXPvwPFywXbDgUzDJtqh0rwAB4lK1E/FvrVLAcMni+zfGU0WJvAJ6hOrX
 BOiw==
X-Gm-Message-State: AOJu0Yzppqt8cZUNGqfMypAY2VUH/jVT7SX7jKL8KRW/4WQlvjgQdo8K
 IdhO14fcHZop4o+aFC36Ja1+z4gVYgW6OeTO9PcQwaVZgHUI/X5/UvcFPIXPXfP+Hb1ubZTvpdh
 uHugwS5CffsnR4mRNFps7nnK+o9SMnHON9imro6aiaxGBxBnzHRqEdMlm
X-Gm-Gg: AfdE7cnIolJm+GWlPUsLYVK+VTYiyS78+RDZUAv2Qhj8FJANt92f3cqfp5OQJmZJJP8
 I2v5V8Ced673wNfKyYr5VHh47Olgh/NqSAPfK4WEHxhGHWXITj3x3x9mmOamDT5HCqQ1iLG/qyb
 Ous3sBtSsdysFLfHJhLLSC9tUunM4IL7D6SwfBV3I2JKw/t5x2atg7Wg6UWLXAGKtMG4ZLE8/NN
 VXgAwo+oBE/+d2y86UHGUSzwii47CWaqf/QmGqo/tCIJdxBOWiP6/IKQditkuYYiCbcL/Nj5va7
 GY5Px6IHRTX00LroHxpPTDUBCu2qjBr586L5kMto5d+4baIHR4CDNmiFs/yvpk9zCARlkB9caBZ
 Cinzg8IjIUI9rSLFen0PzQu1Nr+tdarBhv/oa7ai8wTy69vs=
X-Received: by 2002:a05:7022:faa:b0:139:ed5d:1b5d with SMTP id
 a92af1059eb24-13b2a1cdccdmr998086c88.43.1782783960049; 
 Mon, 29 Jun 2026 18:46:00 -0700 (PDT)
X-Received: by 2002:a05:7022:faa:b0:139:ed5d:1b5d with SMTP id
 a92af1059eb24-13b2a1cdccdmr998068c88.43.1782783959553; 
 Mon, 29 Jun 2026 18:45:59 -0700 (PDT)
Received: from [192.168.0.2] ([49.206.98.162])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b2aba6fe2sm2111476c88.9.2026.06.29.18.45.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2026 18:45:59 -0700 (PDT)
Message-ID: <b6ec1ca0-9730-4f16-b7ee-8d05d3080d03@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 07:15:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] qcom_defconfig: Enable MSM8916 USB PHY + ChipIdea
 UDC
To: Sam Day <me@samcday.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>,
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Kever Yang <kever.yang@rock-chips.com>, Peter Robinson
 <pbrobinson@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, George Chan <gchan9527@gmail.com>,
 =?UTF-8?Q?Petr_Bene=C5=A1?= <petr.benes@ysoft.com>,
 Heiko Schocher <hs@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Paul Sajna <sajattack@postmarketos.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Luca Weiss <luca.weiss@fairphone.com>
References: <20260527-msm8916-usb-v2-0-343e1e32e77b@samcday.com>
 <20260527-msm8916-usb-v2-3-343e1e32e77b@samcday.com>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <20260527-msm8916-usb-v2-3-343e1e32e77b@samcday.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=R8Uz39RX c=1 sm=1 tr=0 ts=6a431fd9 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=CsUhQXafTRZYNWj/SImrtA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=lKQ-AihTAAAA:8 a=lakxK_eWJdsRTjABPisA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22 a=K6G5NyU7usMl-irPePdK:22
X-Proofpoint-GUID: bhBF1NG7A1DWl88tExXLVy8mpJJnrwQ0
X-Proofpoint-ORIG-GUID: bhBF1NG7A1DWl88tExXLVy8mpJJnrwQ0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDAxNCBTYWx0ZWRfX0/thrn+Godqd
 boKa5DFpU3mR7Kxc7cZxp35ir+BEqmJSqufw4GWyPWkZsb+p4cMUY6XNAe0tZGzTx6O2FjfhShs
 hOEf15A4UqJ7pMJm9/nIVFCeFyNjmpRQjn/LhWCXz8GBE837v12RrlbAzh3UG8xuy3ysezaqMN2
 vHY148TfIy/H8yyFnwu/VqFtHtRlnAkCQpGlZSqXIL4daewUgu5Ffomnh8M+9S2n6HpQO8VrV7Y
 pA/MrgO2iiHjRUmxnD04iVezKekM05rNcCn79LeWILHCS2ZTyaN+hed8foBbHWF0tunRjw8Ub2H
 mVlfh8ZM88r9UZzf8HTAnRsfx1F2x5amIq6Lepm11ziNUnQoSWRrkUjQD8iJn/Ez5JRP1GZTFR+
 2EVSH7hnNUxGKsIV0AyI6BubIXpgKWaeDq1mur/jECn/Ryp+BknhRyNqwHT4UuLSrItQmIdF+jF
 9nE2nN91i09bM+XfzhA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDAxNCBTYWx0ZWRfXwFbYO+vV40zP
 BymPSVLLkM2iKqQvqA7bT06iM77mXcdLzdRq6UNN8kZaiDiVmdE629HFbHTQM0Bo6wMti8CJxH1
 Hsv2wA5VNwrr85yuGVndA0nRZFKaRVw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300014
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

Hi Sam,

Thanks for the patch.

On 5/27/2026 6:08 AM, Sam Day wrote:
> Now that the ChipIdea UDC driver supports USB Gadget driver model, we
> can enable it alongside the dwc3 generic driver.
>
> Signed-off-by: Sam Day <me@samcday.com>
> ---
>   configs/qcom_defconfig | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index d0d54ec5a70..75e22f01f17 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -108,7 +108,6 @@ CONFIG_DWC_ETH_QOS_QCOM=y
>   CONFIG_RGMII=y
>   CONFIG_PHY_MICREL=y
>   CONFIG_PHY_MICREL_KSZ90X1=y
> -CONFIG_PHY=y

Is this change related to the goal of this patch? Maybe we can have this 
as seperate patch?

Regards,

Balaji

>   CONFIG_PHY_QCOM_QMP_UFS=y
>   CONFIG_PHY_QCOM_QUSB2=y
>   CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2=y
> @@ -139,9 +138,12 @@ CONFIG_SYSRESET_QCOM_PSHOLD=y
>   CONFIG_USB=y
>   CONFIG_USB_XHCI_HCD=y
>   CONFIG_USB_XHCI_DWC3=y
> +CONFIG_USB_EHCI_HCD=y
> +CONFIG_USB_EHCI_MSM=y
>   CONFIG_USB_DWC3=y
>   CONFIG_USB_DWC3_GENERIC=y
>   CONFIG_USB_GADGET=y
> +CONFIG_CI_UDC=y
>   CONFIG_UFS=y
>   CONFIG_UFS_QCOM=y
>   CONFIG_VIDEO=y
>
