Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98FC9C4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 09:16:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28DBC871DF;
	Thu,  9 Nov 2023 10:16:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="7ZIAr52N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7186871E6; Thu,  9 Nov 2023 10:16:17 +0100 (CET)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F5128715C
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 10:16:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=9677b570d6=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 3A96fxha015570; Thu, 9 Nov 2023 10:16:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=t6FnOUoY+7I/ax8znBD7xNjRv0OFmZ85H6riXf38StM=; b=7Z
 IAr52NW3cxMkxES6Vz+SESpEdJm+32wXNuiZBVRIBvLZRwhdrAbycORxERznFJYE
 +0fhhu6NfeVQvrFtso26qhftAW7cPysgdGuz86m0hnUoY1UrJs3fg4bI/oceBuIz
 Fv5z8182CPc8skHqj2TPVZjaA/Ys0qE77D4pUT1IMTdUW5F/7JXH/mAnjl4YlW0I
 jsIBP2ZlP3/iOiwDq2q6KjIFJuMfb/X6FG5CJfmGRASOXA6BIWGpCe+cstC0kdFo
 7uNci5V8O0Wo0PxJZ1Qdw3/nr4xzIrRKoEX4nOfCN/A1DPRj0oCWePydwZe4QyqF
 SAuVpLeT1HwoM3DDL6kg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3u7w22fkm2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Nov 2023 10:16:15 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0151510005A;
 Thu,  9 Nov 2023 10:16:15 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EF7C027ED32;
 Thu,  9 Nov 2023 10:16:14 +0100 (CET)
Received: from [10.201.22.165] (10.201.22.165) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 9 Nov
 2023 10:16:14 +0100
Message-ID: <309f81b6-a9fc-4c80-937c-4874dff84ab6@foss.st.com>
Date: Thu, 9 Nov 2023 10:16:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 7/9] pinctrl: pinctrl_stm32: Add stm32mp2 support
Content-Language: en-US
To: Patrice Chotard <patrice.chotard@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20231027144304.1002307-1-patrice.chotard@foss.st.com>
 <20231027144304.1002307-8-patrice.chotard@foss.st.com>
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20231027144304.1002307-8-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.22.165]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_07,2023-11-08_01,2023-05-22_02
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

On 10/27/23 16:43, Patrice Chotard wrote:
> Add stm32mp2 compatible.
>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>
>   drivers/pinctrl/pinctrl_stm32.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/pinctrl/pinctrl_stm32.c b/drivers/pinctrl/pinctrl_stm32.c
> index 8bb7588714a..7120b8edba0 100644
> --- a/drivers/pinctrl/pinctrl_stm32.c
> +++ b/drivers/pinctrl/pinctrl_stm32.c
> @@ -505,6 +505,8 @@ static const struct udevice_id stm32_pinctrl_ids[] = {
>   	{ .compatible = "st,stm32mp157-pinctrl" },
>   	{ .compatible = "st,stm32mp157-z-pinctrl" },
>   	{ .compatible = "st,stm32mp135-pinctrl" },
> +	{ .compatible = "st,stm32mp257-pinctrl" },
> +	{ .compatible = "st,stm32mp257-z-pinctrl" },
>   	{ }
>   };
>   


Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick

