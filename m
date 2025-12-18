Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E7F9D68BD9
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 08:13:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBAA783C2B;
	Thu, 18 Dec 2025 09:13:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MBGfVD7n";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h0LwPfFK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DCE083C54; Thu, 18 Dec 2025 09:13:46 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63F0483C28
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 09:13:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BI1YY99813750
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 08:13:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=RI09YbvdLiYgkry/U20Pw2g/
 M6Ti4HOFtgqVH2NgtVA=; b=MBGfVD7nhz2sRgMl7sO2bV0mU6WzpLdTKUJpRAB/
 g96th3ztG8Kgq1LfHrW0pHGj6Eat6xnTM/lzBufG2M2PDPeXCXoiRm98u0/PuvZP
 9n2ulcmkWkXmGKIGdjieGOzFYHcKh3/TDo02/ypxPZp+qW5mYJMletWNE60M1l+r
 wUyiKvSieMzlprzBWMIgifz+N/gEvOfpv98HoDDSKiGk6dtbLmsMyHDpIOAw1pCe
 2RFABOGrMnYWu2LkUfo6WrNBVuQku9+rE65nDD9GJPBWdxh9i/zU+Pb1ccc0v52N
 tYypkmJVo2d8kiCilmZgIJ6UAjyY2V/BgAfn38OfTAnIww==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b40v7a67w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 08:13:41 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-29f2381ea85so7895375ad.0
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 00:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1766045621; x=1766650421; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RI09YbvdLiYgkry/U20Pw2g/M6Ti4HOFtgqVH2NgtVA=;
 b=h0LwPfFKLxQCjZXhlWXMCBwYWRcFpSp/hmUBhiczEMS34YNixQ4vSG4LpKCryPZcSu
 5ypcNHliY9G17bN6TQyMG1CArhf+G2oUOTkzHHAh5ohjA9xT/KQixp31dt8fUqVM1uCY
 oyWZluq1aV205It3twaLOr/a88tJzeTHIKe9CWGvZypi4wt7jgXeMn2GTKf+ITqrZgnX
 WozQJoRFO5m6nsFIRX9sRoCzY+oedAWLYjPj2B10u95B0xXdIAgVhjrxyQrhD2zyp1zm
 HOUFx8Md4POyDvR9xfhUlSiTbUeMHfbC2ZoGMc8vHu9tqtsHnQd4hkAqG/3IKCGpeGKY
 p5SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766045621; x=1766650421;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RI09YbvdLiYgkry/U20Pw2g/M6Ti4HOFtgqVH2NgtVA=;
 b=MO0RuHcPs0lCpuPWGf1Q3zKrHGsJQ0nErReB7qXn7SpLUanqkiJQA5Q0MhpSxcya37
 Xe9WoInXywX+IvDZnp7ganNFlnhsSBgPrY9gIXhmXH3nPhHEHs6kX5ibLBh5z9Tl0ou+
 PrKsGl2byyc0Hj8gdLm/2jN4Mqlq0qeXqMQs6roAX+HlF0vdiHYMTs2LKxmLp17HxO/J
 EqVfteQVXAfqQvXPpOnjfw5BhHOzwJ9aY9hEI3a/BXmYbMZnnK0rDKvkZSKUgeSYinlC
 DW625M6mk3BJiGjzkk2DHU7qyfp3aM3GVuZ2hfZoKlhA7GJo15PuW2CzlcBhMotcPS1t
 /JYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfiiN9NQAfCFWUymO8oBhCyEWA8Ig5ni1Zv9i7oVQmzrK0itgXShmrwL4sLtMgzu2RKajUm8o=@lists.denx.de
X-Gm-Message-State: AOJu0Yzf9tdpurGJlBAl0SvAIBgI2OoQ1QZHBEQLqj85hKk7OqToUsAK
 ZF/rO0FPZ/19faQHfVOW+MLYcnkc95WDkEAVU8hqLpWFyPWg9gPDMCQcYIsgXGju5PEKeoTBZ+B
 FMLWR29ZXKEsUp72BE2LXLHYXOvPkJ20jI1qb1zPgK6KQmPnSGc/HavHt
X-Gm-Gg: AY/fxX5Rua9V4nqe8R/pCgG1ntZU36SpSZ7gAgCe+d7HbTAdAvXbq+am3xvEjwo1qdR
 WmZsx1b3xYkqfg1Q3koPCX+2JRogK71m7/ZFYRod8483b3G7xkln4rELt4KMIa6quTVNR1g9Zqj
 TFz0Z2iDnc90caBxE/JW+pYuJXqCcI3CZD+/aYHMkPwvHiHApWAFKzbzXFkNmPZbStR5v2VSsZl
 VUaO85KpyewCY5jnIJoeS5uCDvMrbSM2PmYR1jIp6uuSbtJB3yhFQQo/rGZdeKIpSV8ifdUQubI
 E4si24ybv75VHDs1y2AXwXqt2mDCBXs1TbyGQgGqemHAoAofCqLrRJvt2F4p66mkk4miJQhEyRF
 IgKdlDX04eofc6sxg7JLInT9AsSgZtL2lU9e480SiG/lFFIz0vI2U6ybIBu+zLqZu76wWTqLV73
 etF7q7qGzFMrRVUDXaM5MTGX99G0v0AoF50fkRXQ8=
X-Received: by 2002:a05:6a21:3383:b0:2fa:26fb:4a7b with SMTP id
 adf61e73a8af0-369affecf43mr23207603637.57.1766045620805; 
 Thu, 18 Dec 2025 00:13:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2N2LsaUfTcdZ3bR61zhkyuJUYpi6PRCQiy1RYbH25mTyN2CzpoHlE6B09/KCndshCHUBxvQ==
X-Received: by 2002:a05:6a21:3383:b0:2fa:26fb:4a7b with SMTP id
 adf61e73a8af0-369affecf43mr23207564637.57.1766045620327; 
 Thu, 18 Dec 2025 00:13:40 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c1d2fa22858sm1553218a12.19.2025.12.18.00.13.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 00:13:39 -0800 (PST)
Date: Thu, 18 Dec 2025 13:43:30 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com, marex@denx.de,
 malysagreg@gmail.com, vasileios.bimpikas@analog.com,
 utsav.agarwal@analog.com, arturs.artamonovs@analog.com,
 nathan.morrison@timesys.com, peng.fan@nxp.com,
 kory.maincent@bootlin.com, patrice.chotard@foss.st.com,
 sjg@chromium.org, jerome.forissier@linaro.org, ziyao@disroot.org,
 stefan.roese@mailbox.org, mkorpershoek@kernel.org,
 alif.zakuan.yuslaimi@altera.com, hs@nabladev.com, rui.silva@linaro.org,
 ilias.apalodimas@linaro.org, luca.weiss@fairphone.com,
 quic_varada@quicinc.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [PATCH v3 6/6] MAINTAINERS: Add entry for Qualcomm PHY drivers
Message-ID: <aUO3qkhzxxHLJLM3@hu-varada-blr.qualcomm.com>
References: <20251203110735.1959862-1-balaji.selvanathan@oss.qualcomm.com>
 <20251203110735.1959862-7-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251203110735.1959862-7-balaji.selvanathan@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: M37fYvAzpBI62Cf2BhqR2o7n7fl34Dqq
X-Proofpoint-GUID: M37fYvAzpBI62Cf2BhqR2o7n7fl34Dqq
X-Authority-Analysis: v=2.4 cv=f8JFxeyM c=1 sm=1 tr=0 ts=6943b7b5 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=IHqtQ3gG_8ZEl9bKhdEA:9
 a=CjuIK1q_8ugA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDA2NiBTYWx0ZWRfXw5yfkNUcXwJi
 8LJOdko6xuLsTooxYrCdPE6u07jBzg05Jj3prdprc0P2lUPjjZXX1MCIZL+TfNhYs8R2k1hA90B
 y+qbLVsZhs8WW/qBQEnmqU/cg4LzDqCCmGN8xW0/cBwMKme5tR94iHsodkBd2iDfkCaBYqo6rXT
 TGMLU41Bd2qQ8OxH8avMD4qJlIhCqdb0WaiwgC89Qop2I8Bh9e6UQezCjudk/fluOR3CFTE1YXQ
 W0W7cfvTfXSkxk6e7Cn7sPpSS6rlkEc+p5AZ5GPCRIF4gItI3+UM7AOZN6d4hIPPEfUo+SV4F+0
 HDBDoQPctmfnb1MP+vJUn/GfzJZT7PZfDc+3WO3t8v+VplgT2wCdGi9aVhMjMjDTmA7w29apNz0
 oDGvrzVpf67o3AjKg8ehJ15nsxfNjQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512180066
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

On Wed, Dec 03, 2025 at 04:37:35PM +0530, Balaji Selvanathan wrote:
> Add the file pattern for Qualcomm PHY drivers to the MAINTAINERS file.
>

Reviewed-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>

> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b43dae882b3..9093ae35b65 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -672,6 +672,7 @@ F:	drivers/*/*/pm8???-*
>  F:	drivers/gpio/msm_gpio.c
>  F:	drivers/mmc/msm_sdhci.c
>  F:	drivers/phy/msm8916-usbh-phy.c
> +F:	drivers/phy/qcom/
>  F:	drivers/serial/serial_msm.c
>  F:	drivers/serial/serial_msm_geni.c
>  F:	drivers/smem/msm_smem.c
> --
> 2.34.1
>
