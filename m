Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60CE5E7B5E4
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 09:57:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDC4C874D4;
	Wed,  4 Oct 2023 11:57:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="DdbKp9HO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE5AC874D7; Wed,  4 Oct 2023 11:57:10 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07F2F874D3
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 11:57:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=8641a2a2c4=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 3944WE37012638; Wed, 4 Oct 2023 11:57:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=aDEywfdr9wyiETC0pOvQxdfp9aJwttniaAgwt0NGVHU=; b=Dd
 bKp9HOFkvnvZBGy0HgDhhJPkEKjc70e8tdl5LAt+h7ZZqCaWF3uBpdBTsQJisMl2
 WNGVEyJpQZnW2bxaV9uOVU4l/LyPZByyZcTe1dteHy1xi2KfXDl+lHqdITS/+Osv
 /7vwvwyCuk2Aa1QjHO5JIc3traJfDBE9vmBmI3Sn0IFFDR4Mga3sYvrryOYdjrnm
 9p/AaECUxc5thSCNszr0YwoK2e+LbzG7x9PcDyES+zJKbIslk2ktHNNtKxRSnGN9
 3Y41QUYGj16ZYjBAKH3FUTKpLKV7Xp54c09BiIUks5R8NFEpTFVwP3vcILsTfY9Z
 pA7KCWQqpWmff2XYb40w==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3te93g0fey-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Oct 2023 11:57:08 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2E9BB100053;
 Wed,  4 Oct 2023 11:57:08 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 270DA22F7A5;
 Wed,  4 Oct 2023 11:57:08 +0200 (CEST)
Received: from [10.201.22.165] (10.201.22.165) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 11:57:07 +0200
Message-ID: <fb1f4a63-40b5-e675-70a5-2b80e93f945a@foss.st.com>
Date: Wed, 4 Oct 2023 11:57:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 5/6] configs: stm32mp13: add support of usb boot
Content-Language: en-US
To: Patrice Chotard <patrice.chotard@foss.st.com>, <u-boot@lists.denx.de>
CC: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20230926150924.1150082-1-patrice.chotard@foss.st.com>
 <20230926150924.1150082-6-patrice.chotard@foss.st.com>
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20230926150924.1150082-6-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.22.165]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_01,2023-10-02_01,2023-05-22_02
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

Hi,

On 9/26/23 17:09, Patrice Chotard wrote:
> From: Patrick Delaunay <patrick.delaunay@foss.st.com>
>
> Add support of USB key boot in distro boot command.
>
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>
>   include/configs/stm32mp13_common.h | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/include/configs/stm32mp13_common.h b/include/configs/stm32mp13_common.h
> index d36fbf00548..5b0658ced92 100644
> --- a/include/configs/stm32mp13_common.h
> +++ b/include/configs/stm32mp13_common.h
> @@ -35,9 +35,16 @@
>   #define BOOT_TARGET_MMC1(func)
>   #endif
>   
> +#ifdef CONFIG_CMD_USB
> +#define BOOT_TARGET_USB(func)	func(USB, usb, 0)
> +#else
> +#define BOOT_TARGET_USB(func)
> +#endif
> +
>   #define BOOT_TARGET_DEVICES(func)	\
>   	BOOT_TARGET_MMC1(func)		\
> -	BOOT_TARGET_MMC0(func)
> +	BOOT_TARGET_MMC0(func)		\
> +	BOOT_TARGET_USB(func)
>   
>   /*
>    * default bootcmd for stm32mp13:



Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick



