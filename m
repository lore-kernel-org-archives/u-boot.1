Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5138C4450A
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 05:44:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C84F84AE3;
	Wed, 15 Jul 2026 07:44:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="OjPoMm2y";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ia9YFkoc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7619883FF5; Wed, 15 Jul 2026 07:44:14 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C1FE84AF5
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 07:44:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66F3laVK2504653
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 05:44:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=5isHtaimzWuXd8bLa3HVW1Vm
 UAZt5gobP4jeCh9swpQ=; b=OjPoMm2yGHhVLXgph5eTj1i9GKSJLpaxKsMIdzRS
 LZ84G2Gt0P6FAuE+6MIa5T7vrZ83Q/hTAVTG7Ypdpk2XY0jMRA39UGVvF05p04R4
 V8JO11qaqsCwFkSeJOT8pJ/m8f4dnGIemf0NQr1Q+LZ5Nsw4SNDwyqsqMa/YeWIL
 uP3UG1Iz7oOiJT9S5Pki/P80I/cxovudmuqB7/YCTDtGRl6Pst8wJP57eN5xcExV
 uGiScbxhU8/n0yyeS4ZqtLbZP1KDk6Eak9b1xOPFUHszq3gBVuQfVrWaQhTi4T/8
 4uHbel3ogC9pVaramHOjmbA6mG71ZFdo6VK4qL9R7s8Bug==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdwk318c2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 05:44:09 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c916d17dd43so8503213a12.3
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 22:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784094249; x=1784699049; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5isHtaimzWuXd8bLa3HVW1VmUAZt5gobP4jeCh9swpQ=;
 b=Ia9YFkocwECYemShmxzWp4hICGbW5caVL0QB/JYteL7Wbt4d2sEIc7eOt8Pbh07BGc
 dKw4o3tmVlhTjNVPAMhZBQED1uNm95FiuD/JRyeQ8MpZ9TfEYqwi8yIBv0UmIeLpQiFW
 Byd9yHnNocB38LAQuEN45LFxMjT0bsFj+034duP7ZQsm8jslFZ5KdEfQgPkNWQZDqrEs
 AYrkZ61iHyRMl5sOePg63nu7R6svAOdrtjn1DoyAxRyPAw3+xrnGP0wh2aCfTGCM5Q11
 U0MCNiiHq4mQNA91dtXbEkYiR3cFJ2DWkOGuRUT9ekgVsjDtd3cTJKdVlycElilA9yJ7
 mBWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784094249; x=1784699049;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5isHtaimzWuXd8bLa3HVW1VmUAZt5gobP4jeCh9swpQ=;
 b=oJtKNYrI0CLkoJYXRr3b+cYrQ6JDcbiI4U3BwoJ+gfZWoOuaPW792grn2uGUcl6hua
 jSP9SQdZI4WWBJ9uEBS++nLCr1m60JEw/r15JrnCrqlLSBDBYyhN066ZMbxDxZEK4UXq
 c4NKc5MO4JPWn2zGeHen6Eijj2ZDGDaV/5G8o0xCvQi7Z4WXI4p9/HaQzmumtrt2oMO8
 1mOIGcLR75kKF+RK0Atk+t3RpV59iQyyhVqqChKoj5G1CmcAZOcnaPArdTmTMoplJkYI
 l/4AnBLMSnStdGedjBmUD16g9i0NOXEzqDqAIaDJPx1DJOWJ+oa3kqcjFv00fVsAVasI
 /MZA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoneXRYPDX0TuO3FBIfewaGBPmGQDoMfGZDAwoWKV7U8iDlD3GT4DQiPjL4as6JtHfACVt/aes=@lists.denx.de
X-Gm-Message-State: AOJu0Yy7gITw1d+q2mnQKLRF8S9OAllqYk3z+G4UXyENwDUe1IQ6kHsD
 sJLwaVpbxvaoyHiBg/kGcySmhE4wlbuSqy5H/xpnFCDIpRI6k0tWtg4xx2MIbUYpC8mriEvZB9E
 gOnB9V4JRVzGSbko1/oLW1rZdTbgvMwKumxiPHY8A2Lfb0oFyPJihn0FuWUZrFBMe
X-Gm-Gg: AfdE7clIDOCllED34OYvwggTkJRoQjVzK9nI3S2GhTEfthTPTZniDJHv7PSON3dFeJu
 kfyq7GmniXHP/apNUAov9f0rjNIPIqWKVtkID1eC8EUvkLGOIWDVREg8PI+zQ4iJGRmm92uiOmM
 T5f0Oft07QIuc15ocwLgPcQIBxElVO++YdammS5wrACygcXQq9G9XsQNueKMdkSTY9pxIV0jh0u
 b9MdNwAesFf6EznVLABq+YnuuJ6ytq04PTWWEHDoP9wQ70BFa4ATOgxbkTUzQTVIP2aVzgUsz/S
 xRxxcQzT/Lv+FC7Yc3dwYBM6rCSKhY1xMrm0z6sDLur7fzFpXytsJa1ipGd8w8+ZTd/ImzdoBct
 LEWpB2T9V0nJqhROIgpQ/tbBW3H+qm0LrKdHyk0laHSREAxElXZI4i8/A82co7sR6SOnKGNedGS
 324wGHGTCeZyyKCNMb8plE+gxijQD6ckVOhrd2bt/f
X-Received: by 2002:a05:6a21:3297:b0:3c3:69d0:c573 with SMTP id
 adf61e73a8af0-3c36c48a9bbmr1434080637.68.1784094248813; 
 Tue, 14 Jul 2026 22:44:08 -0700 (PDT)
X-Received: by 2002:a05:6a21:3297:b0:3c3:69d0:c573 with SMTP id
 adf61e73a8af0-3c36c48a9bbmr1434059637.68.1784094248424; 
 Tue, 14 Jul 2026 22:44:08 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b987fc629sm48534341c88.0.2026.07.14.22.44.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 22:44:07 -0700 (PDT)
Date: Wed, 15 Jul 2026 11:14:01 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: guohaoprc@163.com
Cc: "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de,
 Bryan Brattlof <bb@ti.com>, Tom Rini <trini@konsulko.com>,
 Yao Zi <me@ziyao.cc>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Vishal Mahaveer <vishalm@ti.com>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] board: ti: am62x: Fix build without TI_I2C_BOARD_DETECT
Message-ID: <alceIU3at7mEURSh@hu-varada-blr.qualcomm.com>
References: <20260715-am62x-no-board-detect-v1-1-2969faec1001@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715-am62x-no-board-detect-v1-1-2969faec1001@163.com>
X-Authority-Analysis: v=2.4 cv=Yc6NIQRf c=1 sm=1 tr=0 ts=6a571e29 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=Byx-y9mGAAAA:8 a=EUspDBNiAAAA:8 a=GgQJ5DKRVZ7hj79r504A:9 a=CjuIK1q_8ugA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: zPLwrNIdRc5IOBRB_RjFq8UdGI4rlFdn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDA1MiBTYWx0ZWRfX2Y/5uiwC8FKp
 qJ5hYxaA9k6QoE/sBKUMoGaCtxm0Uzkj69G+8oykCaazMWFOQN8CdCqf2youkeBTEH3001Tb7Yx
 zxpGzRmBf6R0Sv1QU9lQjEzNfqtkBMHFZRHSauHxrq5/aI30lCCrK/1JbsHIZSjoyyKmopEOvaM
 lyEmRRlJAW0CKo1bEqlruwbARL/CHRWg7vXbHoCejxaqP3C4sBf5dSJXHiDwYNm0qfEDvBxyz3f
 CgX0l7vP1dPky0n9ZYcebWEqnUEB9cCo2fMZu3gkwSjg2CJWhmEdq9X84/Pz7sAHUOWAypu7ROp
 iFUsmNy4C2UKXdGq7NmKp4Otv/IEudCXghi2QVcUJDfHRHBPgdmdHZq/5iJ+EqcJ3XibgAAoD+1
 d9LK273glY4swoNE30LrqU+qN9uWAwYDOTpKbGMrtLCgtahqHlVax//ZIGMDYAINMkoL+XuxJDm
 dEID/Ce85QviUN/pkzA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDA1MiBTYWx0ZWRfX2Yck3Lz4IqTj
 uLBwVpc+vwnL050j1JZ1rfynw5ov1fXlYsy4JpWMRROQQP58me7rP2e6rQpxVAgphxzjc32uCxY
 fiqctdgS6lU910ootSVRvY7OyF7RgSg=
X-Proofpoint-GUID: zPLwrNIdRc5IOBRB_RjFq8UdGI4rlFdn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150052
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

On Wed, Jul 15, 2026 at 11:32:26AM +0800, Guo Hao via B4 Relay wrote:
> From: Guo Hao <guohaoprc@163.com>
>
> setup_board_eeprom_env() and setup_serial_am6() are only available when
> TI_I2C_BOARD_DETECT is enabled.
>
> IS_ENABLED() does not remove the guarded statements during preprocessing,
> so disabling TI_I2C_BOARD_DETECT results in an implicit function
> declaration error. Use a preprocessor condition to match the condition
> used for the function definition.
>
> Fixes: ff1b83c095c2 ("board: am62x: Add support for reading eeprom data")
> Signed-off-by: Guo Hao <guohaoprc@163.com>

Reviewed-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>

[ . . . ]
