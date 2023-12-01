Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8307C4167B
	for <u-boot@archiver.kernel.org>; Fri,  1 Dec 2023 10:05:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08A3B875FE;
	Fri,  1 Dec 2023 11:05:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="PFAz6n33";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1610687623; Fri,  1 Dec 2023 11:05:23 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB05C8718C
 for <u-boot@lists.denx.de>; Fri,  1 Dec 2023 11:05:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0699fcb2c2=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B14pjlM005262; Fri, 1 Dec 2023 11:05:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=gpouJDjg5FYpjImXqqZaB07eNjKHDK3TwGy3h7gChG0=; b=PF
 Az6n33r7Vk9+sp56zOuesjRJ5a19TZ1Ch4ywz/u6Gm+EyXB4cF0P6xmduKDlkV+0
 s/RZ+8cHczRBXsgdvzR3Vp76yxuZ05+7qgTr+apNv91LlOyKzykqn7LhpMyJDW2n
 U1skAmQT9frbTmRvZCXf3lt3fKulJ9ksxNtufDcthrl7hXudOWzK0/Tu+d6dP/3c
 /MVnbaWZafV4VvUc59L+mfEkZFNVyh4Fsv8qHK7NSGqP1xDVlwqUATOebxONy/gq
 1Ub+lnuU5IroLmTKyHGVQWxCe/NluH12oevrjzhSzRR8U9qxiDxh1+HoUSAPJzBt
 Nkf/utkKHPIqpBqnROPw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3unffe6jpn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 01 Dec 2023 11:05:18 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 62D11100079;
 Fri,  1 Dec 2023 11:05:18 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 16D0D214D04;
 Fri,  1 Dec 2023 11:05:18 +0100 (CET)
Received: from [10.252.6.183] (10.252.6.183) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 1 Dec
 2023 11:05:17 +0100
Message-ID: <9fce2a8a-9305-4080-806d-cf1e80c58f24@foss.st.com>
Date: Fri, 1 Dec 2023 11:05:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tee: optee: don't fail on services enumeration failure
To: Etienne Carriere <etienne.carriere@foss.st.com>, <u-boot@lists.denx.de>
CC: Jens Wiklander <jens.wiklander@linaro.org>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>
References: <20231129123753.1906956-1-etienne.carriere@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20231129123753.1906956-1-etienne.carriere@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.252.6.183]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-01_07,2023-11-30_01,2023-05-22_02
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



On 11/29/23 13:37, Etienne Carriere wrote:
> Change optee probe function to only warn when service enumeration
> sequence fails instead of reporting an optee driver probe failure.
> Indeed U-Boot can still use OP-TEE even if some OP-TEE services are
> not discovered.
> 
> Fixes: 94ccfb78a4d6 ("drivers: tee: optee: discover OP-TEE services")
> Signed-off-by: Etienne Carriere <etienne.carriere@foss.st.com>
> ---
>  drivers/tee/optee/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> index 9a9b697e91..5308dd58ce 100644
> --- a/drivers/tee/optee/core.c
> +++ b/drivers/tee/optee/core.c
> @@ -841,7 +841,7 @@ static int optee_probe(struct udevice *dev)
>  	if (IS_ENABLED(CONFIG_OPTEE_SERVICE_DISCOVERY)) {
>  		ret = bind_service_drivers(dev);
>  		if (ret)
> -			return ret;
> +			dev_warn(dev, "optee service enumeration failed: %d\n", ret);
>  	} else if (IS_ENABLED(CONFIG_RNG_OPTEE)) {
>  		/*
>  		 * Discovery of TAs on the TEE bus is not supported in U-Boot:

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
