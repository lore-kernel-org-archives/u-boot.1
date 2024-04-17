Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B83C4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 09:02:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D94988457;
	Wed, 17 Apr 2024 11:02:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="sDMPBViC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3EE48845A; Wed, 17 Apr 2024 11:02:53 +0200 (CEST)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD5A38842B
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 11:02:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=4837253909=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 43H7ix0A005483; Wed, 17 Apr 2024 11:02:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=uM92mgvbt0Xq+1Qci9tM2Fta1RARSIcAxLvdfj+EgBo=; b=sD
 MPBViCCROfwGz7GIdn1B+dMaisUZ+wiNFe9dstCN36KLKIu/BdOLPZ/l9+a7sCf2
 xI+Z725gVmmf0vvALzKGUk0NWKyk1Oh6nhOc2ac9udtvolt3e/MnW71eoPWdnwUS
 72sBHLzNnwnD2gPAC280Y0395xntjQWcdAVGzRHpbO7/SUHYtyscKgZRZvh+l0A4
 rXXvtSu4QxwoRZi6Pr+PNVIbcXk4oft6n5R9ImI6Tekr+jg3kbu55Xvf9qtovvC5
 cKX1xgHMzK9bbx9XvDDwxsMYTe5hA92KCPUuz9LD63XlfoVMaKJX9G/2fcg+tDS8
 0R00vSGEmH6LUfh4SgxA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xg50hx9x8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Apr 2024 11:02:45 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id DBD0340044;
 Wed, 17 Apr 2024 11:02:41 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 873BB21058A;
 Wed, 17 Apr 2024 11:02:12 +0200 (CEST)
Received: from [10.48.86.112] (10.48.86.112) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 17 Apr
 2024 11:02:11 +0200
Message-ID: <8602799a-7c52-4308-a58e-4986de57210b@foss.st.com>
Date: Wed, 17 Apr 2024 11:02:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mmc: stm32_sdmmc2: Fix AARCH64 compilation warnings
To: Patrice Chotard <patrice.chotard@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, Sean Anderson
 <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>
References: <20240308142614.2700185-1-patrice.chotard@foss.st.com>
 <20240308142614.2700185-2-patrice.chotard@foss.st.com>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20240308142614.2700185-2-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.86.112]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_08,2024-04-16_01,2023-05-22_02
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

On 3/8/24 15:26, Patrice Chotard wrote:
> When building with AARCH64 defconfig, we got warnings, fix them.
>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>
>   drivers/mmc/stm32_sdmmc2.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/stm32_sdmmc2.c b/drivers/mmc/stm32_sdmmc2.c
> index d4982a14281..39ae79ba129 100644
> --- a/drivers/mmc/stm32_sdmmc2.c
> +++ b/drivers/mmc/stm32_sdmmc2.c
> @@ -220,9 +220,9 @@ static void stm32_sdmmc2_start_data(struct udevice *dev,
>   
>   	if (data->flags & MMC_DATA_READ) {
>   		data_ctrl |= SDMMC_DCTRL_DTDIR;
> -		idmabase0 = (u32)data->dest;
> +		idmabase0 = (u32)(long)data->dest;
>   	} else {
> -		idmabase0 = (u32)data->src;
> +		idmabase0 = (u32)(long)data->src;
>   	}
>   
>   	/* Set the SDMMC DataLength value */
> @@ -463,8 +463,8 @@ retry_cmd:
>   
>   	stm32_sdmmc2_start_cmd(dev, cmd, cmdat, &ctx);
>   
> -	dev_dbg(dev, "send cmd %d data: 0x%x @ 0x%x\n",
> -		cmd->cmdidx, data ? ctx.data_length : 0, (unsigned int)data);
> +	dev_dbg(dev, "send cmd %d data: 0x%x @ 0x%p\n",
> +		cmd->cmdidx, data ? ctx.data_length : 0, data);
>   
>   	ret = stm32_sdmmc2_end_cmd(dev, cmd, &ctx);
>   



Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick

