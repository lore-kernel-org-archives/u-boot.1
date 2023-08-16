Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B221C04A6A
	for <u-boot@archiver.kernel.org>; Wed, 16 Aug 2023 13:23:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17E1C869D3;
	Wed, 16 Aug 2023 15:23:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="ZZWGrNTz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0E76869E0; Wed, 16 Aug 2023 15:23:45 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 371DD869D3
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 15:23:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=6592a39e51=patrice.chotard@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 37GDKTsp002367; Wed, 16 Aug 2023 15:23:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=VXwEMDub7QUzURVXtk2Y1UF2uVpPONA9jMkhfuoSg7o=; b=ZZ
 WGrNTzGuX06sucPnRjWV9EDb98bzqt+xyViOEVkcomNe8m1eLOliTJMOI7QSpw7X
 KFSFn3UVKQo78ERmcU0bwlr/dFW7oUx0mD75xHhpqr5iUOunGayqGUWk65jMMW66
 hQ2S7PXvV/Q/4JhXfaZvYn86TOSLjF/FjeQG5eK6Rv8t26AyNvH+3aRvL1PBwOdx
 LQAU3Z5bhS5whZYBpANvIRfVFyW3pMAW17df3Tjm3JHfMYBcJhBUi7GYte8Gkpcb
 98Y8WKFWPmkDwU/IW1SkyWX3vn7dLL2ZT44aWH50xfWMSSV4zw276ATQePvzrZrv
 x5vf3km8Ax4oLeHNChZQ==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3sgth61xu1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Aug 2023 15:23:42 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 51DF710005D;
 Wed, 16 Aug 2023 15:23:41 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node4.st.com [10.75.129.133])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4ABA123D419;
 Wed, 16 Aug 2023 15:23:41 +0200 (CEST)
Received: from [10.201.20.38] (10.201.20.38) by EQNDAG1NODE4.st.com
 (10.75.129.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 16 Aug
 2023 15:23:40 +0200
Message-ID: <4de67859-8088-0d24-1aa1-5b1c78a226ed@foss.st.com>
Date: Wed, 16 Aug 2023 15:23:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] clk: stm32mp1: remove error for disabled clock in
 stm32mp1_clk_get_parent
Content-Language: en-US
To: Patrick Delaunay <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>
CC: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, U-Boot
 STM32 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20230623150449.1.I2f1f79c3a6283502490ee63fc158237bd43efa2f@changeid>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20230623150449.1.I2f1f79c3a6283502490ee63fc158237bd43efa2f@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.38]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To EQNDAG1NODE4.st.com
 (10.75.129.133)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_12,2023-08-15_02,2023-05-22_02
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



On 6/23/23 15:05, Patrick Delaunay wrote:
> To disabled a clock in clock tree initialization for a mux of STM32MP15,
> the selected clock source index is set with the latest possible index for
> the number of bit used. Today this valid configuration cause a error
> in U-Boot messages, for example with CLK_ETH_DISABLED, when this clock
> is not needed for the used ETH PHY without crystal:
> 
>    no parents defined for clk id 123
> 
> This patch change the level of this message to avoid this trace for
> valid clock tree.
> 
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> ---
> 
>  drivers/clk/stm32/clk-stm32mp1.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/stm32/clk-stm32mp1.c b/drivers/clk/stm32/clk-stm32mp1.c
> index 4f4524fcb2c6..615028769495 100644
> --- a/drivers/clk/stm32/clk-stm32mp1.c
> +++ b/drivers/clk/stm32/clk-stm32mp1.c
> @@ -881,7 +881,8 @@ static int stm32mp1_clk_get_parent(struct stm32mp1_clk_priv *priv,
>  		return sel[s].parent[p];
>  	}
>  
> -	log_err("no parents defined for clk id %d\n", (u32)id);
> +	/* clock is DISABLED when the clock src is not in clk_parent[] range */
> +	log_debug("no parents defined for clk id %d\n", (u32)id);
>  
>  	return -EINVAL;
>  }

applied on stm32-master

Thanka
Patrice
