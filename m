Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB869C47258
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 07:25:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EE7787873;
	Wed, 31 Jan 2024 08:25:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="zhuzAOfS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 622E387960; Wed, 31 Jan 2024 08:25:04 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B0D48780A
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 08:25:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=2760384811=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 40UKu9lA028720; Wed, 31 Jan 2024 08:24:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=MrOvRBewA7I+Nm5Rh6HG7+I0Kn3Uz7s8vFatr4a5gPk=; b=zh
 uzAOfS3NWLlS2y+XXY2lxYekZJXqMSjztyoxl/mVfgPcpMPyHrH1iO0+PrdawWwY
 bJI+1asX5K24vRzydSdUNxdlrqRcmsJpaSzGywry1F5FtmDZ90EAG9ygjSoPKGey
 75gn0QNXQnKcQqS/2SZKX8p848jiX/zT78AAVLk2iGk3b8BjyNfbTwMImhpeK4aq
 Yy/Oh9LEzYi4mDZ8uftNxnvmR5hk4lzPaGzbZyAvn6Eoe9sSuEf/ONVTXHHfd6c9
 N4ie6CGGpHK7j9ubaKvoL0c/ZLdVm4aHdKAOOpBLWsIAcHaHXPL8kp5mRkmBIdjm
 z2exnBkpkGosnlcmGEkA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vvqu8xj2d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 Jan 2024 08:24:56 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 52C54100057;
 Wed, 31 Jan 2024 08:24:54 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2138D22D165;
 Wed, 31 Jan 2024 08:24:54 +0100 (CET)
Received: from [10.201.20.205] (10.201.20.205) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 31 Jan
 2024 08:24:53 +0100
Message-ID: <ce7047e0-ec7f-4718-90eb-d923921a8370@foss.st.com>
Date: Wed, 31 Jan 2024 08:24:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: regulator: Fix error code in
 regulator_list_autoset()
To: Dan Carpenter <dan.carpenter@linaro.org>, Przemyslaw Marczak
 <p.marczak@samsung.com>
CC: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Simon Glass <sjg@chromium.org>, <u-boot@lists.denx.de>
References: <06ee0d87-35f0-4fe4-87b2-e498b2263ee5@moroto.mountain>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <06ee0d87-35f0-4fe4-87b2-e498b2263ee5@moroto.mountain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.205]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_02,2024-01-30_01,2023-05-22_02
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



On 1/31/24 08:09, Dan Carpenter wrote:
> This condition has a bitwise & vs logical && typo so it only preserves
> odd number error codes.
> 
> Fixes: 3b880757abca ("dm: regulator: uclass driver code cleanup")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/power/regulator/regulator-uclass.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/power/regulator/regulator-uclass.c
> index 77d101f262e2..de2bb3b1cd88 100644
> --- a/drivers/power/regulator/regulator-uclass.c
> +++ b/drivers/power/regulator/regulator-uclass.c
> @@ -390,7 +390,7 @@ int regulator_list_autoset(const char *list_platname[],
>  		ret = regulator_autoset_by_name(list_platname[i], &dev);
>  		if (ret != -EMEDIUMTYPE && verbose)
>  			regulator_show(dev, ret);
> -		if (ret & !error)
> +		if (ret && !error)
>  			error = ret;
>  
>  		if (list_devp)


Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
