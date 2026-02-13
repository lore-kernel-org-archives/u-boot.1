Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D913EDF027
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 09:19:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B63D83015;
	Fri, 13 Feb 2026 10:19:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="nxpKfAtU";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FvL+Lqtz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EBC383AA9; Fri, 13 Feb 2026 10:19:10 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DBDE80FA1
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 10:19:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61D6vg7U421430
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 09:19:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=pm5hBDdRaVicWzfndqJ82vF7
 th1oW0YGHUe0zcE0KjA=; b=nxpKfAtUm9aUxANaWSvSCH9Nw01dRcjwtImx28p1
 73rarmobnO1RZrMMPTdoUO40rD6JujC/wmFgGfXP04ekNkRVCKJGo45p4Xk6owCD
 o+SDfOFHnrEScaK5T2Cp+FcMiGwnrXG5YHhPQLvTLitk3yiBhhzlPNq/JGQnTR5t
 pcia0kdgwUuL1Z6Y3jlI23KMEmO6CQ+RJOODIMUvROk3JbFdAAu7XrnBBJw1SiXZ
 rfFGJgtXKLCfppC6kjvL786+hMno9+iiWoeHB03jT72p1sIEj8AZwSaIxm0hBfJZ
 sI2/GpkV2HJ8KTx79VsN40l/FP//4k3Jy+ki3gzv+/e8LA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c9cy4ce95-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 09:19:06 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-354490889b6so1997701a91.3
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 01:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1770974345; x=1771579145; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pm5hBDdRaVicWzfndqJ82vF7th1oW0YGHUe0zcE0KjA=;
 b=FvL+Lqtz1pST7jUN9CU4ehUUqhI9eVQSYyO5huPO41y3uA0pQFUc7pKl1Vhakjn4AV
 0BIXOD3+d7hDrCc33IL9yMHFqaC3iy5KpeZVxesWPen5zCDoSbU3Xy0RTg+oEtkBMUOt
 Q91OtB3/XSSYxS+lvcBA3Hxx2gPIGH9vJiEUpS1uR1B8BuZl5PguvvTeJYaKNRFzgLqY
 HMq9q5H1akva0Vmhdwo3wd2QhkERgrtOo1R37ytKGQbaP/uQZStIo2oJlN+ErnNLyFbF
 AqC6SdVtDkqLVmevpb0vSf33ykpgNt7TDOCIWN+nAsKpnbNv0f9d0u/Io94ozmFo0uJH
 2B+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770974345; x=1771579145;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pm5hBDdRaVicWzfndqJ82vF7th1oW0YGHUe0zcE0KjA=;
 b=W/N8HYRRXd/bq9wVDoQJPYOKOai8cpwkv3YlD8SOQpKIrGQere8Hxd233ofIbxJV/a
 WpdLyaCNUmHpybTmTN+KSbZJlEwkSZ0KnmAZsTqqU2VAjTa/AY5WEZ+18s0STa0cchvC
 WzJUxRPK7fYt5wmhVks+RnP8tCSQIy+RkQKrHmYwIvnWPiX3sfxOD5ww3sxikDLJh3Bu
 CUMvtVDwBTJx6z7lKJ1vhf1yMnnbImw2KzuOr5yX671931hZ95qppCMTq76UMPb+2M6A
 CUH9OIPDJyM/80wfuepVTVZZE+y0VyLzGjYyDqGZfFUJJR4ock2BIYUAJ500Eu7GKtV4
 Sd7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSFbE18+/uHHV0/Liniocj+YnXpx9Ik+R2PTVzSWa5LHg+yUqfKdQe40+uiJlX2fCLjrJBzuQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzYV34l2Uql13l2oFRJHTDyn45jmfwtSJ/GRcYMYb/BGIYKGupz
 B8TPJ05ehgfH0g1YGafUoGs+1d1a79ox3WPfOSL7ERWkCgulPFZGGuRVwH9I4SY28666z0vXLFb
 BU+a0sdbMQAQkR/BEVDR+nYLgTcXfRVV4CKjGNU2+pQI1+//mmGi/Xnvczgj+MaG9
X-Gm-Gg: AZuq6aIMSWhAJOLsp2O2HRq4LvjFRfp9hEoOp4+97WNFrvU61AcXyHfklpgYvythH7I
 45/+dhdPva5EOAq2ZWnbkiRu0C182q6HolAO6Sdup69BgR9yqhOYUergEpDyd/932GU77dloDMI
 TUn8SqCtVLLmGolh2B3H+m3SMyvrraijfLb+IrbDlI3oV+UtFIN9/wiB6R/kXxj8PYCDS5e3h+k
 ImW0+1cBJPeYAJ1yDAirVu/n5M6VwUH4zvRGB/UY7w+076zDLY17dfGOG8Xm7OLLJh2WFefr/il
 1708J5SVkjF52uxtOKsC2Rn8aTJmI2fu+Z40bBb3PI3QJCEtfphns5RF8kGP6GueiJeT+m54AQG
 m99vraLmX4zv08mwYhBVFvm6LjaL5DDvjXqr0qX20SCtu96uZs57rHT2XTVSnjoe51W6uKdi5j6
 5PdFGiM2TzU9ZegcIRf4wV/d/NuRl0LytrBso/HHxy2vrEsN1GQ9w=
X-Received: by 2002:a17:90b:524b:b0:354:a065:ec3b with SMTP id
 98e67ed59e1d1-356a7a88d7fmr1864078a91.27.1770974344768; 
 Fri, 13 Feb 2026 01:19:04 -0800 (PST)
X-Received: by 2002:a17:90b:524b:b0:354:a065:ec3b with SMTP id
 98e67ed59e1d1-356a7a88d7fmr1864040a91.27.1770974344349; 
 Fri, 13 Feb 2026 01:19:04 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-356629314fbsm11295977a91.0.2026.02.13.01.19.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 01:19:03 -0800 (PST)
Date: Fri, 13 Feb 2026 14:48:57 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Tom Rini <trini@konsulko.com>, Biswapriyo Nath <nathbappai@gmail.com>,
 Alexey Minnekhanov <alexeymin@postmarketos.org>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH 3/3] phy: qcom: qusb2: Add QCS615 QUSB2 PHY support
Message-ID: <aY7sgexswDYpfRC2@hu-varada-blr.qualcomm.com>
References: <20260213-talos_usb-v1-0-4c4355d61437@oss.qualcomm.com>
 <20260213-talos_usb-v1-3-4c4355d61437@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260213-talos_usb-v1-3-4c4355d61437@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: A6BIR3soRvDWo9mqpLLgAkro5sGti5I6
X-Proofpoint-GUID: A6BIR3soRvDWo9mqpLLgAkro5sGti5I6
X-Authority-Analysis: v=2.4 cv=XvX3+FF9 c=1 sm=1 tr=0 ts=698eec8a cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=wBC4jXNDNMgW5193PK8A:9 a=CjuIK1q_8ugA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDA3MSBTYWx0ZWRfX1buAXNyoM4IQ
 ciq8RxQ2AwrRxTroCHybuY8Y7x/LgXhZy+ALwIfpAGYeV1CfMiOf6gwPtyAu640sJGV41ECM5EC
 XB713H9OYxjnS1u+1a/q7aRZPQa9L0q6jOx2ylfydTFIaWXsBLM3AhN4pCQSk/URqRro0aIAE97
 4Hwicy7cgzdCqyF0yFuN3Vq6lfhEmcnRWjlBTEuO+mS7oR9Xnq+WRFqvOmcz60q4cI/uWtBOmm0
 FfhVFwt2S1mNX0nfD731eyRO7qJUrtveej7+ltGzz4OTvoAoR/2CTgX4EI0HJDeeix/IIn1zjVe
 i7xlLoqZ7grvdNN22w9BqvQXbncJI/mZtmS4r32K520KgVuGnCeVRIoAgRL/Oyaiha5kre5PBUo
 SpoxoNfs1Y0D+KgNupKUnqeonaFzhyYHenwA8OCfqWliy5jZJIOrojCjXQfkZEHRGKigNdTBJIq
 JQhpZ2OGwxM9N4sTN7g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_01,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602130071
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

On Fri, Feb 13, 2026 at 02:31:20PM +0530, Balaji Selvanathan wrote:
> Add support for QCS615 QUSB2 PHY by introducing platform-specific
> initialization table and register layout. The implementation reuses
> the IPQ6018 register layout and defines QCS615-specific tuning
> parameters for proper USB PHY operation.
>
> Taken from Linux commit 8adbf20e0502 ("phy: qcom-qusb2: Add support for QCS615")
>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

S-o-b should be after R-b.

-Varada
