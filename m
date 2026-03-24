Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73B51E9A75C
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 10:05:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBAD480077;
	Tue, 24 Mar 2026 11:05:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ajeGbOTm";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GAZt4aqT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87BFF80212; Tue, 24 Mar 2026 11:05:50 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF51580050
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 11:05:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62O7RAds2371344
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 10:05:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hzbwu3nAAOSCUpGAuJvQ++azYK+xKuCR89Zu7Gw6qFQ=; b=ajeGbOTmrcuEyx/R
 WwAZOZDaek/FD/60+h7u49KzVqydjc2b52zXDzZtHxrkheYpnFU1mI75Y7kfFg6k
 ENoFmKy4qGrTV5mlhQTi8MNd3Tx2udb4up9oOoGJg/N9NQOtVasXDXOGFALhxtCx
 rfxl4smAEhVgkmfiGkGiI+D5OyYVLb3PJMj8hiCYxuGyB5HF1YBLtppOd0JY0gwe
 kLg6EdAL18chtLoEtJqEU777jxLFulTFhd/6CcBZxr7ADniXZRj4QRlzyXWai/sN
 OSps+5C2erEwU3uMot8S+1xnWJmOahUGxj/c4dOyRCqrDrXZudWQTvXSYtV268A8
 vRSD7g==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3p830jj6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 10:05:45 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2adc527eaf5so10783515ad.0
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 03:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774346745; x=1774951545; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hzbwu3nAAOSCUpGAuJvQ++azYK+xKuCR89Zu7Gw6qFQ=;
 b=GAZt4aqTWLK9rUHP9knS32NHBJbTOaPz20u5HY3K6nR6civVu8pdPskpGbJDHH4x31
 3SQp6TGmuJymbgsDX1vKGwQQou1oYJlywz7rHVtYMDVeVKAbfaks6XEb88A70i0i51mQ
 foQ5/Jsebqb6LPB1gnKr3U+9iATuBuWM4bUFjPo2erLSn6HU0ll0Hzg0C9HoSmHKG5sL
 /LcuUK422owOee9Jpll7sOlaaMLm7fGEDvVoc4yL3QHi9G4AlTKJ18mcAdO8QEK+Ouvn
 jclo6Z4zPdI+B6wfxJXnVUH5QCRzYxY/I8YByzHY0fSQnX8kDbh+292P05iLmEdOkINz
 tMwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774346745; x=1774951545;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hzbwu3nAAOSCUpGAuJvQ++azYK+xKuCR89Zu7Gw6qFQ=;
 b=osD8UWqmcFK/q9dWwcKWfVPiCTFfefk//oD6q1to/bU6RbCHxegiYzTE64EqqxfFFf
 BO6BWGXYwiSPkq2IHdiG8t7M2L9fpPyx6KSwP05fAxHBGgqi9pkssiRhJ9HCHcyWF9O1
 StAPd/pqPQQOD653gke+e5EKE/xr/wPWPIZ+fP+4sFcev7ZNQ9MUBovG7Y2E+lrC/NZM
 xWCa67ic2JubAB6yJwhGrmMJPBHAU3H2SYj+lHIlYfIXWN7Xw2unNxGU55TBIWlXA/zz
 fXp2LWsoouY9vo3ceN5ThNV3NOae1ygI6xWi58gDZpN+/VgzbeIzp7ZjhD29G/2yC6NO
 I2fA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlJuckwnxSGCNnIEIFdEfNQTvd/+0ObqNaRZAKl8ZHeG8kZQe9o0ephcdvcc1qRwcX9/9hboY=@lists.denx.de
X-Gm-Message-State: AOJu0YzWh0hXATRZdu9L5eb0ZVlDiDwPTz+2VofjAHSWQuysqbWxKkwi
 NUJKJ5VLoxnR0+/T5nuSpdmaDR/4ELd/LQ4jEOKSZeCHoJho/yVBdQhe6DbuS6o5mFpY4alu0Ql
 /gg4MJUIOnZjIiJa0jdj+VMSgXCq5A/BVIEbNVs8y7/UEaAEe8ITuoZTW
X-Gm-Gg: ATEYQzy8el08XJcAupGalyKZZ/PxSDkO7SJ9S+hru73UdqH0+SggX+zlPS0r0pbwoD6
 2+6fhNlPT2ud8vlrtb47yjWtSalUS6AcztDWyV28TB1tmeopidOjeCDFdGw2Vl1qHCKo9g1UpOn
 WN8a7rxtKlGO5MctHnqOrxEIq3k8s+ZT6l4TFZV1HNl9+q3NvrTatRRmMuhS9dIetkWUGszA06p
 keXMyg4COwKKlHjE644YNxo6n5dc0Afqfwg1oYWie4h9Nm889el7W+0gm0AV4G+TEifFas7g17W
 2pIB9GeOrVFnAINJnzFJcO15PrUTZszrRfzVCGvincgNiN1r7u28zs2OHpZNUY7gba/9pYIYFPN
 xVm9QmHMXXpI+6xQlXA64PEJiIsmjuuOBHI8HYNLkiWwhAnL1qmRxxcDejKQ=
X-Received: by 2002:a17:903:4b47:b0:2ae:cfb5:a7a1 with SMTP id
 d9443c01a7336-2b0826f7c33mr131380565ad.20.1774346745058; 
 Tue, 24 Mar 2026 03:05:45 -0700 (PDT)
X-Received: by 2002:a17:903:4b47:b0:2ae:cfb5:a7a1 with SMTP id
 d9443c01a7336-2b0826f7c33mr131380225ad.20.1774346744404; 
 Tue, 24 Mar 2026 03:05:44 -0700 (PDT)
Received: from [10.152.199.49] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b083516aa6sm189887595ad.9.2026.03.24.03.05.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Mar 2026 03:05:43 -0700 (PDT)
Message-ID: <3241fa45-d60e-4957-8aee-23eb9f39a451@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 15:35:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Enable USB High-Speed support for QCS615
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Lukasz Majewski <lukma@denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, Tom Rini
 <trini@konsulko.com>, Biswapriyo Nath <nathbappai@gmail.com>,
 Alexey Minnekhanov <alexeymin@postmarketos.org>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
References: <20260213-talos_usb-v1-0-4c4355d61437@oss.qualcomm.com>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <20260213-talos_usb-v1-0-4c4355d61437@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDA4MSBTYWx0ZWRfX3RS0s+6fwTNQ
 0nn3jTYLludP8ybklLUEkgUyeyukfQ21skLHx5vZBrl+d6+ePq2Zxwm5Xt8AmRGsfdTXaxAZVNe
 1mpgMRxztZewljg887EJrRgSKJcDjO1QLn4yRhgRMOrG2hE/07xEwnOUQ+izOKLt7tbbE3yvGuD
 LhxABeS5HhFDJq35FCXRjdi1BMR/fZlqSdxOPtOvpmGrwTaXI5qgu0B2ha/zYNor9ZJ2NQGH0WY
 E2LKGAnPGb/D5tnUpc2nbCrCE6z2yCCMunMwrkuipji3k9J5r5bed9zvaQY3p8cgUykJV+bIJjR
 Bq/vPcBGGyU8Eo3BMIR8knBLuw00THDmLt4RPeqmwwhYmervUJzRCo439ZzqnyI8+FS85czUk9C
 3YlduIb6gk3RCI73M7BneERT3lC/noDqR1lHoqD8ZK+6WEbOUapNdncjEO71Uzivp15I06HLVC0
 1qvHx3XxNRVm1bwHLyQ==
X-Proofpoint-ORIG-GUID: VTOowq9eu3azxfj4L54WuK6gYJnxe2LT
X-Authority-Analysis: v=2.4 cv=F6hat6hN c=1 sm=1 tr=0 ts=69c261f9 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=lqErckFYKtvNrwHFpeYA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: VTOowq9eu3azxfj4L54WuK6gYJnxe2LT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_02,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240081
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

Request to pick up this series in qcom-next.

Thanks,

Balaji

On 2/13/2026 2:31 PM, Balaji Selvanathan wrote:
> This series enables USB High-Speed functionality on QCS615 by
> adding missing clock support and QUSB2 PHY support.
>
> ---
> Changes in v3:
> - Implemented GCC_USB3_PRIM_CLKREF_CLK in clock driver instead of
>    using device tree override (addressing review feedback)
> - Dropped the device tree override patch from v2
> - Link to v2: https://lore.kernel.org/u-boot/20260120042551.650113-1-balaji.selvanathan@oss.qualcomm.com/
>
> Changes in v2:
> - Updated to the reference commit for the QCS615 QUSB2 PHY support
> - Link to v1: https://lore.kernel.org/u-boot/20251114063804.3835132-1-balaji.selvanathan@oss.qualcomm.com/
>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>
> ---
> Balaji Selvanathan (3):
>        clk: qcom: qcs615: Add GCC_USB3_PRIM_CLKREF_CLK support
>        clk: qcom: qcs615: Add GCC_AHB2PHY_WEST_CLK clock support
>        phy: qcom: qusb2: Add QCS615 QUSB2 PHY support
>
>   drivers/clk/qcom/clock-qcs615.c   |  2 ++
>   drivers/phy/qcom/phy-qcom-qusb2.c | 38 ++++++++++++++++++++++++++++++++++++++
>   2 files changed, 40 insertions(+)
> ---
> base-commit: fd53b78a796335fe3d9f85637657a93991b708a6
> change-id: 20260213-talos_usb-cc965d78decb
>
> Best regards,
