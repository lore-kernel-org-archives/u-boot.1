Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44216C47258
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 01:25:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7CB3878FF;
	Thu, 18 Jan 2024 02:25:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="VzhGGiAu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32C3F87AD0; Thu, 18 Jan 2024 02:25:19 +0100 (CET)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69A9787887
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 02:25:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20240118012510epoutp0477f8dd187f21c5f653ba580971a1181e~rTJqQu5zb1139611396epoutp04D
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 01:25:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20240118012510epoutp0477f8dd187f21c5f653ba580971a1181e~rTJqQu5zb1139611396epoutp04D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1705541110;
 bh=nq4XWaTElSONguayKqQJy4QHgSmIlcSnz8WOEl3fZiQ=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=VzhGGiAuZUYJoHELAaU+KggwEvfQt1feAz5SA58+qz7nB48WJiWC/mY0f3oN9uLmE
 zQw7vg5QGbQa7RzaXo2Fm/B47CVMT1sk8kJBoOMMC7t4Yam6Ez7xugy8cbv47W8eiB
 keLD2nV+2U6sy/W3U6qC6xvZu4AmeNtwQYizFlho=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTP id
 20240118012510epcas1p2443969e0d51ce8131c1a7abe140fb8ee~rTJqB_wOY3040530405epcas1p2s;
 Thu, 18 Jan 2024 01:25:10 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.38.232]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4TFlRT36tsz4x9QF; Thu, 18 Jan
 2024 01:25:09 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
 epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 3A.BB.08572.5FD78A56; Thu, 18 Jan 2024 10:25:09 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20240118012509epcas1p24e2ab8a49d2a924dccff9c661d223fe4~rTJo3p0SO2959929599epcas1p20;
 Thu, 18 Jan 2024 01:25:09 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20240118012509epsmtrp13878ee3656b4bd12ea5166d527f71a2d~rTJo3Cuqn1299912999epsmtrp1c;
 Thu, 18 Jan 2024 01:25:09 +0000 (GMT)
X-AuditID: b6c32a33-55c16a800000217c-8a-65a87df516ae
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 D2.EC.18939.5FD78A56; Thu, 18 Jan 2024 10:25:09 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20240118012508epsmtip18bfa1364a6d040d9f059841cbc603e06~rTJomQJWx1698416984epsmtip1N;
 Thu, 18 Jan 2024 01:25:08 +0000 (GMT)
Message-ID: <e81db1be-66f0-4160-8927-9819530ecd46@samsung.com>
Date: Thu, 18 Jan 2024 10:25:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mmc: Avoid buffer overrun in mmc_startup()
Content-Language: en-US
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, Peng Fan
 <peng.fan@nxp.com>
Cc: u-boot@lists.denx.de, Eugeniu Rosca <erosca@de.adit-jv.com>
From: Jaehoon Chung <jh80.chung@samsung.com>
In-Reply-To: <20240104034942.102500-1-heinrich.schuchardt@canonical.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnk+LIzCtJLcpLzFFi42LZdljTQPdr7YpUg8dnxC1W/W9hsrjQeJPd
 4seqL6wWb/d2sjuweMxq6GXzmNW+mt3j7J0djB4b3+1gCmCJyrbJSE1MSS1SSM1Lzk/JzEu3
 VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAdqppFCWmFMKFApILC5W0rezKcovLUlV
 yMgvLrFVSi1IySkwLdArTswtLs1L18tLLbEyNDAwMgUqTMjOWDt9MVNBK3/F8z/bWBoYf3J3
 MXJySAiYSMze1sTYxcjFISSwg1HixfO5UM4nRok1D0+wwTlPuqayw7Q0dM5ggkjsZJT4sXY2
 O4TznlGi6dMTJpAqXgE7ie4n51m7GDk4WARUJU7/5oUIC0qcnPmEBcQWFZCXuH9rBthQYQFn
 iTVXG8DizALiEreezAcbIyIQJTHx+g1miLi9xL5rrWwgNpuAjsT2b8fBajgFPCTmb30IVSMv
 sf3tHGaQeyQEPrJL3P7bAHW1i8SWruMsELawxKvjW6DiUhIv+9vYIRqaGSWWLjnICuH0MEr8
 a7jOBlFlLLF/6WQmkG+YBTQl1u/Sh9jGJ/Huaw/YkxICvBIdbUIQ1SoSl16/ZIKZf/fJf1YI
 20PixVaQJ0GBNZtRYubtqawTGBVmIQXMLKQAmIXkoVkImxcwsqxiFEstKM5NT002LDCEx3dy
 fu4mRnCK1DLewXh5/j+9Q4xMHIyHGCU4mJVEeP0NlqUK8aYkVlalFuXHF5XmpBYfYjQFxs5E
 ZinR5Hxgks4riTc0sTQwMTMyNrEwNDNUEuc9c6UsVUggPbEkNTs1tSC1CKaPiYNTqoHJ5E2S
 lt/EKDXj70VvUq7anvr5s2uxtUky58rn7GsO1yT/NdmhfMJC1D/Z+VjcsvdNyaKfP5wV28cx
 8V77C6M3K27Y+ieHLrHc9Hj6nepgtto1BsZZTP6THoUE5s6sL9a8c12NaWLWtDWnVyVed18m
 KWcsGyx53tnF3yXzJ9OxD6u4t0Wwd2gdN5ugJleVql4493eqwIncvXMy9jrYXvhrGnah1ec/
 b3NzcdGk25uDXh+d6dvc7tYTOjXNVfrJ2097XeJXvDvj3HjtUOqhN+rKTWkT3nwWeXbGknPj
 F41IHvaFKa7PdtoL1DxIOtex2dVwX5XX4zItCR/96xc2CTAs2cY5sWiyHZu85MU3rzuUWIoz
 Eg21mIuKEwGy9e6+GgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDLMWRmVeSWpSXmKPExsWy7bCSnO7X2hWpBiv3slis+t/CZHGh8Sa7
 xY9VX1gt3u7tZHdg8ZjV0MvmMat9NbvH2Ts7GD02vtvBFMASxWWTkpqTWZZapG+XwJWxdvpi
 poJW/ornf7axNDD+5O5i5OSQEDCRaOicwdTFyMUhJLCdUWLHocusEAkpic9Pp7J1MXIA2cIS
 hw8XQ9S8ZZTY/GYdWA2vgJ1E95PzrCA1LAKqEqd/80KEBSVOznzCAmKLCshL3L81gx3EFhZw
 llhztQEsziwgLnHryXwmEFtEIEri8NFZjBBxe4l911rZQGwhAXeJ55/2MIPYbAI6Etu/HQer
 5xTwkJi/9SEzyFpmAXWJ9fOEIFrlJba/ncM8gVFoFpIrZiHZNguhYxaSjgWMLKsYRVMLinPT
 c5MLDPWKE3OLS/PS9ZLzczcxgiNAK2gH47L1f/UOMTJxMB5ilOBgVhLh9TdYlirEm5JYWZVa
 lB9fVJqTWnyIUZqDRUmcVzmnM0VIID2xJDU7NbUgtQgmy8TBKdXAJHdOMl5C/tZz3eZH+SaL
 8htOyU5b6XtJgG3RYt1z8/cUr16z2OUD7xIrKVXDrmnhu69pF3K9e6w8pepV6bsgqVo53q0c
 F2vmrc49rfJQ7P/spbEZ8fld6yIFe/5p/PkgcG9X9Kugw2wrvlTN5Q+/HHrHaVLe5GNOIlME
 gn5zT/AVjbfknrOtLkD9+BOBs3cb2Tsmsc1MENrcmvfU9eCj5t9f8/LfmM4Iy+Q8enr60hNb
 /u2r1Z+0Uejzw5fXCkVnPslOO/Aifp+MXOhVlg7+j3fLE6+W6BzaOm3rqfijrcGJ6p2fPt/r
 +s+/5HFitPjLe3kXLnvP+rDZ/KWL0f2fQtMsjwkW3mUUsFLm8i5jKFBiKc5INNRiLipOBACz
 SfSN7wIAAA==
X-CMS-MailID: 20240118012509epcas1p24e2ab8a49d2a924dccff9c661d223fe4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240118012509epcas1p24e2ab8a49d2a924dccff9c661d223fe4
References: <20240104034942.102500-1-heinrich.schuchardt@canonical.com>
 <CGME20240118012509epcas1p24e2ab8a49d2a924dccff9c661d223fe4@epcas1p2.samsung.com>
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

On 1/4/24 12:49, Heinrich Schuchardt wrote:
> If the CSD register contains a reserved value (4 - 7) in bits 0:2 of the
> TRAN_SPEED field, a buffer overrun occurs. Resize the mapping table.
> 
> According to the original report
> https://lore.kernel.org/u-boot/20180826231332.2491-11-erosca@de.adit-jv.com/
> reserved values have been observed resulting in a buffer overrun.
> 
> Reported-by: Eugeniu Rosca <erosca@de.adit-jv.com>
> Fixes: 272cc70b211e ("Add MMC Framework")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> ---
>  drivers/mmc/mmc.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
> index d96db7a0f8..00f4964aae 100644
> --- a/drivers/mmc/mmc.c
> +++ b/drivers/mmc/mmc.c
> @@ -1570,13 +1570,20 @@ static int sd_read_ssr(struct mmc *mmc)
>  	return 0;
>  }
>  #endif
> -/* frequency bases */
> -/* divided by 10 to be nice to platforms without floating point */
> +/*
> + * TRAN_SPEED bits 0:2 encode the frequency unit:
> + * 0 = 100KHz, 1 = 1MHz, 2 = 10MHz, 3 = 100MHz, values 4 - 7 are reserved.
> + * The values in fbase[] are divided by 10 to avoid floats in multiplier[].
> + */
>  static const int fbase[] = {
>  	10000,
>  	100000,
>  	1000000,
>  	10000000,
> +	0,	/* reserved */
> +	0,	/* reserved */
> +	0,	/* reserved */
> +	0,	/* reserved */
>  };
>  
>  /* Multiplier values for TRAN_SPEED.  Multiplied by 10 to be nice
> @@ -2560,6 +2567,8 @@ static int mmc_startup(struct mmc *mmc)
>  	mult = multipliers[((cmd.response[0] >> 3) & 0xf)];
>  
>  	mmc->legacy_speed = freq * mult;
> +	if (!mmc->legacy_speed)
> +		log_debug("TRAN_SPEED: reserved value");
>  	mmc_select_mode(mmc, MMC_LEGACY);
>  
>  	mmc->dsr_imp = ((cmd.response[1] >> 12) & 0x1);

