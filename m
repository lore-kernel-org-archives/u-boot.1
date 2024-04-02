Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9295ECD1284
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 23:29:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8A6888049;
	Wed,  3 Apr 2024 01:29:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="spI/9WhO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF4908811A; Wed,  3 Apr 2024 01:29:20 +0200 (CEST)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2258C879F3
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 01:29:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20240402232914epoutp016140e16f67ab2cfb1d3e248ec4a064c1~CmmIZ9XLr1080010800epoutp01L
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 23:29:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20240402232914epoutp016140e16f67ab2cfb1d3e248ec4a064c1~CmmIZ9XLr1080010800epoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1712100554;
 bh=4GA26NqmlsPc0Qt3+IkmOB4q/7TTYLSdNY1T8vSxsek=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=spI/9WhOxFArKa3Yb/9SzwkG2RYVdry4fkxM3JfjChUkFu8L8v5HpgYaQj/Fwun6I
 ex4wff2Z2jeMHkwOEj/P2WSD837P55p1Ybzo0rn06YnwB9en3BdE7AJXT0Gyc92r40
 tv+kIefTvxwKyRGINM0wKc63cBl5usEuGCeYJTK4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTP id
 20240402232914epcas1p4c36a036580ac5af66ae1c119b4cdea97~CmmIMPN3X3267932679epcas1p4q;
 Tue,  2 Apr 2024 23:29:14 +0000 (GMT)
Received: from epsmgec1p1-new.samsung.com (unknown [182.195.38.236]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4V8PGd2jv8z4x9QF; Tue,  2 Apr
 2024 23:29:13 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
 epsmgec1p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
 1A.0D.19431.9C49C066; Wed,  3 Apr 2024 08:29:13 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20240402232912epcas1p1df0a76336eff985fb53b770990bb05c1~CmmG-YoEX0146501465epcas1p1L;
 Tue,  2 Apr 2024 23:29:12 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20240402232912epsmtrp2f24a8357ea0c759d5a88b7e553b2723e~CmmG_x-xC1423014230epsmtrp2K;
 Tue,  2 Apr 2024 23:29:12 +0000 (GMT)
X-AuditID: b6c32a4c-1d1ff70000004be7-0c-660c94c99b4d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 A0.AB.19234.8C49C066; Wed,  3 Apr 2024 08:29:12 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20240402232912epsmtip2daf19704b219e1303565f5320308c4c4~CmmGvJUD_1275712757epsmtip2H;
 Tue,  2 Apr 2024 23:29:12 +0000 (GMT)
Message-ID: <b4b0e56f-8fc3-423b-a163-a0809552e8bf@samsung.com>
Date: Wed, 3 Apr 2024 08:29:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mmc: Avoid buffer overrun in mmc_startup()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, Peng Fan
 <peng.fan@nxp.com>
Cc: u-boot@lists.denx.de, Eugeniu Rosca <erosca@de.adit-jv.com>
Content-Language: en-US
From: Jaehoon Chung <jh80.chung@samsung.com>
In-Reply-To: <20240104034942.102500-1-heinrich.schuchardt@canonical.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupik+LIzCtJLcpLzFFi42LZdlhTT/fkFJ40g49TRSxW/W9hsrjQeJPd
 4seqL6wWb/d2sjuweMxq6GXzmNW+mt3j7J0djB4b3+1gCmCJyrbJSE1MSS1SSM1Lzk/JzEu3
 VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAdqppFCWmFMKFApILC5W0rezKcovLUlV
 yMgvLrFVSi1IySkwLdArTswtLs1L18tLLbEyNDAwMgUqTMjOuPnxEkvBCv6KU6t/sDYwTuXp
 YuTkkBAwkZhwv5eli5GLQ0hgD6PE8UuNzBDOJ0aJvu8r2eGcWxuWMcG0TL3eCJXYyShxrPs8
 I0hCSOA9o8ScL/ogNq+AncSs+99Zuxg5OFgEVCS2XKiBCAtKnJz5hAXEFhWQl7h/awY7iC0s
 4Cyx5moDWFxEIEpi4vUbzCA2s4C9xL5rrWwQtrjErSfzwW5gE9CR2P7tOJjNKeAhMX/rQ6h6
 eYntb+eAfSAh8JFdYt/adlaIo10kriz8zQ5hC0u8Or4FypaS+PxuLxtEQzOjxNIlB1khnB5G
 iX8N19kgqowl9i+dzATyDbOApsT6XfoQ2/gk3n3tAXtSQoBXoqNNCKJaReLS65dMMPPvPvkP
 dYOHRPfV+9CAm80osW7yDbYJjAqzkAJmFpJHZyF5aBbC5gWMLKsYpVILinPTU5MNCwx181LL
 4VGenJ+7iRGcKLV8djB+X/9X7xAjEwfjIUYJDmYlEd6f3pxpQrwpiZVVqUX58UWlOanFhxhN
 gTE0kVlKNDkfmKrzSuINTSwNTMyMjE0sDM0MlcR5z1wpSxUSSE8sSc1OTS1ILYLpY+LglGpg
 KrhQ/z+Tw5NTP4tVfX11XcOMl1P3pEvNzuueJCJ9qJihxPja+s3crv4ey5vZl+k6idV1/Hr0
 rfsAd/FWiW8bu7unH+Xf3v7AqM7A49DENcpuP86rLmBMnrFL+mifYs0Ss1Ub34m92lhl4Nfv
 vth1YvnbOVuWS05ZctAt8/nOhzyL5oo5CQUL1R/nsveavFzO4VPwhKfi62JDDzwKOSF7f22j
 13TJi/yFrS8ObPz3j2lD0/k5F0uE5/7J+h97r1BryZTfzzzuBu4vVcmZ5NC86Ofj9k9Rgcdi
 LSKPBx0tCvyede7XjLAlHrKqa6vdRS1Y+yvf1dsKL3yT91Yh5Q3jF0sJ/6vnFtzkDUh02Nt3
 UomlOCPRUIu5qDgRAD/yw1EdBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDLMWRmVeSWpSXmKPExsWy7bCSvO6JKTxpBov+G1qs+t/CZHGh8Sa7
 xY9VX1gt3u7tZHdg8ZjV0MvmMat9NbvH2Ts7GD02vtvBFMASxWWTkpqTWZZapG+XwJVx8+Ml
 loIV/BWnVv9gbWCcytPFyMkhIWAiMfV6I3sXIxeHkMB2Rokrcz8yQSSkJD4/ncrWxcgBZAtL
 HD5cDFHzllFi3auHjCA1vAJ2ErPuf2cFqWERUJHYcqEGIiwocXLmExYQW1RAXuL+rRnsILaw
 gLPEmqsNYHERgSiJw0dngY1hFrCX2HetlQ3EFhJwl3j+aQ8zRFxc4taT+WDnsAnoSGz/dhzM
 5hTwkJi/9SEzyFpmAXWJ9fOEIMrlJba/ncM8gVFoFpIrZiGZNAuhYxaSjgWMLKsYRVMLinPT
 c5MLDPWKE3OLS/PS9ZLzczcxgiNAK2gH47L1f/UOMTJxMB5ilOBgVhLh/enNmSbEm5JYWZVa
 lB9fVJqTWnyIUZqDRUmcVzmnM0VIID2xJDU7NbUgtQgmy8TBKdXAVC5fGSuy5MOVmJSMlLmb
 53kytf6sZvsaw/BL0y7iVO2iNp7+CzZnHqy5uPVZRmKXZB17rtkU61f/0m+b50xn810R9WBO
 s3pe4pQF4oZKrNNiLN8/mv5yjsimrslX5/+t8Lmz2KSsWalV6dDvec87LMRfM+tN5/h+SllA
 K7Lz86mc+CMpG+eWtEyz1Cz1ns5XP/n3ymO/Pm765TP9y2rb2R/bK49v+Wt48eCtX0vWi86b
 yPA85JDtmgesLKdLlS+k2N16sP/9mYXurY/cu60uL/8nm312xZO21QrHPsk8La2P3icu+dLs
 4H5tZdWToRY9b/r/7ngmc9u0p8zz77Q1ZgttQtPPP540+2bK9CRjFmYlluKMREMt5qLiRAC1
 L+3I7wIAAA==
X-CMS-MailID: 20240402232912epcas1p1df0a76336eff985fb53b770990bb05c1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240402232912epcas1p1df0a76336eff985fb53b770990bb05c1
References: <20240104034942.102500-1-heinrich.schuchardt@canonical.com>
 <CGME20240402232912epcas1p1df0a76336eff985fb53b770990bb05c1@epcas1p1.samsung.com>
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
> Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Applied to u-boot-mmc/master. 

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

