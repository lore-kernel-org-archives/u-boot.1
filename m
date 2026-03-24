Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95173E9A758
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 10:15:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C6D480077;
	Tue, 24 Mar 2026 11:15:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ULZTr+u0";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GIrCAvON";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B4BC8352B; Tue, 24 Mar 2026 11:15:07 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7A9880050
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 11:15:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62O8xnGg2323354
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 10:15:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=fPs1Jf96UrOwl1Ey2WeKdV0o
 m4qVQNS94v2U45zvVrE=; b=ULZTr+u0JWG14nso0PeGwgrMHLH4SiYeA2uxa6wC
 emvxpvEAErJjXFezDW1ONhPXKlVEm2z96RuAPGoy9gw+/V88Z9prRsA5McX5NHXN
 fvNVfc879mdu34Uzlvj5C9TycP13O8PcqtIkVAVqBIQjk8SyXaJFQkG5gGhggTqn
 BVkqYh461PN7imiG0W6HcwHzcWzgNnByTEiY1rHjwKm77t7HFrsx8v5TfV9vwWTs
 dGXZMYX0NR08Ea4eCJ518zpdIgrNQE+0WAThXJJax+VzCRDlxGYq8z4sB5U/p6V6
 Ae9ko5mud3NndZBUJqTnuEv0vt+OIBUkQC6kvdQBk6ZU5g==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3qkerafy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 10:15:03 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-82c675116f1so578626b3a.2
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 03:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774347302; x=1774952102; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fPs1Jf96UrOwl1Ey2WeKdV0om4qVQNS94v2U45zvVrE=;
 b=GIrCAvONJSmYWh7drZnUSXWswUBIAQ79/K6shgr1IN/M92UB5kaGAPOxrtw5E9oprr
 /vc2Zgxw6dyJIcRUWOFFSbz3B1IqC6HKsCXBHHyjGJixiBDF30AgNq/9Xy1nDEBZSgJe
 bBY5AfLgTQIuQmVS1AjaC8Py3+XRuIPfh2jokQxwT4u9jzgtFj1/kkyZ+yS93JaureAF
 bRNmRlOus6Txru1WbSwq1vkRKnxKBqnEO44WRkMdGRxj/nsmLxcjJjXEUV3rVynRfD3e
 2LLk8jcXbU3YNkDmPTw0lPlXjMraqn9JQb0+eTX0H7XmV7ZkVJoZlv1i1gGf5YCGFI1B
 YhEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774347302; x=1774952102;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fPs1Jf96UrOwl1Ey2WeKdV0om4qVQNS94v2U45zvVrE=;
 b=Hyf1mIbiJQ4m09yp8Q+h7zFKXqkN1zh4FKhEkqTOQVSkvDwt56GifCD4fTosvKLPRG
 6ljVSZpxq/KGftXkmkVzH3Pd9yEtIeAdfxkmeTAeKaGQoUmCtKb5beg77L14pN3/VxFi
 BN6f2QVH7W033CGV1dOjizHhO/TaJ7uBAXdSHhvuHkPeMevaLNG8hDrdgXoZKf2nwT/W
 suhdP2eY3qMMMSAr76yvW/j7m4DHKp2GIamX0wLM0UrBVgWBsOq5h6OH6TQ2qyXz8hDv
 6W8FOwEqAvDVedQkFpEwrdIg2LK3UDe1SQbqrZ4AZXYllO5tU0wT9o/pj6NnturcQpnR
 dC4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWYQKzDvaYV8P5rc4ExI5+lwPkw45KBUt1UyU6rAoMGmebQJAvFKOkFjGokusXFfEjiL27lGE=@lists.denx.de
X-Gm-Message-State: AOJu0Yw9HH5RBwYix9pTXWXXBy11nNLlwr92dy8EtScNy3otIDveF4fZ
 3rxZng7ryBAZnZbXqHD2CqfR6O9HJHhTvN/lH4Q6sOx0WYoVEpzVxTa77u+U93LmuJ2QBEdfKlj
 KrTIZDBwctDQMBSydJOwpR5Y9/FLM/1NmbxvA06DHTz1p5FF0Ng9YZhTX
X-Gm-Gg: ATEYQzwzkDNRgjCGSkbyZnKPctm6X8nbUPE1yf4dyrcmayZyb7QNqC47XGINwQuzBA9
 ST/2bczo+HHaHY7cHlXIT99cOO3WdkeFyaPA7blS4Vl6Ttv0XaffrPaHR6GqMdFBejcntdrSEOz
 LHf2FKZVpXOLoLJnddTvcMSYQuSZBRybyxND+L3s7H3zz80LwWdd2qIW0Zd2DWzANga7yfrowDv
 Je11UePoGk0nPcWMqqN7ldrvPjQRc81uO0a0IcO6VKIFeXbqlHYbP0vpGbmtG9oJZU994bqR4y9
 WENFr7uM38jJYWbr+yLil2WTNBcLz23gAyyQ/agxNe8hHmUxbR1UATTv8Ka3pataZN1RVV2ruqn
 OUArRf+cRCZ10oWJ2Y2btf+ma46KMR7T3JGUgeq1CMXaDoTmCuKsD7r0ARAF2tn2Iud6IJ7ubT8
 badXcqxBs/OhwTwq+r7tATMbxqFbSUBXTIwiyh8gJf4wnMJH19KYk=
X-Received: by 2002:a05:6a00:928d:b0:824:9edb:454 with SMTP id
 d2e1a72fcca58-82a8c2ef6d0mr14569070b3a.37.1774347302203; 
 Tue, 24 Mar 2026 03:15:02 -0700 (PDT)
X-Received: by 2002:a05:6a00:928d:b0:824:9edb:454 with SMTP id
 d2e1a72fcca58-82a8c2ef6d0mr14569031b3a.37.1774347301715; 
 Tue, 24 Mar 2026 03:15:01 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82b040da438sm12235559b3a.43.2026.03.24.03.14.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 03:15:01 -0700 (PDT)
Date: Tue, 24 Mar 2026 15:44:53 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Simon Glass <sjg@chromium.org>, Jean-Jacques Hiblot <jjhiblot@ti.com>
Subject: Re: [PATCH 2/3] drivers: mmc: uclass: Set removable flag based on
 device tree property
Message-ID: <acJkHTO/6l8LNb9c@hu-varada-blr.qualcomm.com>
References: <20260324-emmc_sd-v1-0-883a45538b6e@oss.qualcomm.com>
 <20260324-emmc_sd-v1-2-883a45538b6e@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324-emmc_sd-v1-2-883a45538b6e@oss.qualcomm.com>
X-Proofpoint-GUID: 79TzhX6g3nI1CzOTy4ZXMRiXzuGHwX5n
X-Proofpoint-ORIG-GUID: 79TzhX6g3nI1CzOTy4ZXMRiXzuGHwX5n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDA4MSBTYWx0ZWRfX/Toz9nBZzThY
 IXIq+NHlPOHU9DZn1sVLjnf/2e6dZ3g5XoK4JhCLOSKXYi5mwZJSfwmdpFm36DPk77+j0A68PNz
 LdiGuwvNCFIuQuFZe+KDi6EGVRiajaSOW+qclk2xAvewxna5SZdU88GBrbww9gJ3lgj7kuNvhzj
 2EYcvASz36OpsFjXBe8lcGAyI7KTZcxMsqfwI1yGmhceuI55PZxy1JNEuc+DirkjOPCKwhJYA9o
 lRTidIetlujJl/qnR9XR8vA8+gQEcIMKI8/aVU+OOEUJv29lDWaDsSnLEhz8c32mtD5tZUpBgTf
 g1DBkT1mYhM9u8UZjAyWSNOrt6P8RQ2Voi4ZIuwkyIsP/r2a5lwHV7IrkRJtgdHfDQWnPukr/gG
 AtiZo/BBd/nhEZW6csgERh48+cubtZzqeiW+YugGmphf0ULqWSrZ77pbpW8c3514AT/WjiRWWa/
 ec6SBqIt7a+OkmRLdTw==
X-Authority-Analysis: v=2.4 cv=Veb6/Vp9 c=1 sm=1 tr=0 ts=69c26427 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=0QS2TLFTIzAymdrKPJUA:9 a=CjuIK1q_8ugA:10 a=zgiPjhLxNE0A:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_02,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
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

On Tue, Mar 24, 2026 at 11:22:35AM +0530, Balaji Selvanathan wrote:
> The block device removable flag should reflect whether the MMC
> device is physically removable (SD card) or soldered (eMMC). This
> information is specified in the device tree via the "non-removable"
> property and stored in the MMC_CAP_NONREMOVABLE capability flag.
>
> Update the removable flag in the block device descriptor after
> successful MMC initialization to properly reflect the device's
> removable status. This allows the block layer and upper layers to
> distinguish between eMMC and SD cards for appropriate handling.
>
> The default removable=1 is set in mmc_bind(), and this change
> overrides it only for non-removable devices after confirming
> successful initialization.
>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>  drivers/mmc/mmc-uclass.c | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
