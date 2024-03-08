Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89394C5475B
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 10:22:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD6FA8801E;
	Fri,  8 Mar 2024 11:22:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="8DHqibpl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A40D88065; Fri,  8 Mar 2024 11:22:07 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 570338800D
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 11:22:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=3797bb48b6=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 4284US1G015304; Fri, 8 Mar 2024 11:22:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=5cirgJkPRSXlobuSZLHu6J6iFfzosFiWcqXGfLrkQfo=; b=8D
 HqibplpvFGgSUHYALwtF2AG6/+vb0f6tFKxg92TrsTWD59wc7YzC/2slXpZe09Ei
 zKmZ0oe+Yv/gHOJwnA8tpOv+4c3c/QaxLUrWi5rRb/gsiJZHkqxsAWCUo592jCVj
 Lejckf+yAqioRNC7jz+t80jNd9e5+BZ/I8USGxqXSN4uY8TIgpewql80TGhlVala
 FP4D2+j1HhR09dIRUxc7fI/BYAOMjN3xt1b9A+vFSaqHhBcMUKPDlAoe7HRH3Lwu
 sKN9ZbTAb9p6ILdcCBbNaoY4k93PrjL0zJBFLLvU+B9cPI89EzCYyRQUOzDMuJAe
 QYMQ4U6XZ4ojbEbYY22Q==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3wmej5j6m8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Mar 2024 11:22:04 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 2CB7240044;
 Fri,  8 Mar 2024 11:22:01 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5BDC225F4BF;
 Fri,  8 Mar 2024 11:21:47 +0100 (CET)
Received: from [10.252.7.115] (10.252.7.115) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 8 Mar
 2024 11:21:47 +0100
Message-ID: <b2f87ba8-3131-4304-8d81-9fc227ab4314@foss.st.com>
Date: Fri, 8 Mar 2024 11:21:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] stm32mp: cmd_stm32prog: add dependencies with
 USB_GADGET_DOWNLOAD
Content-Language: en-US
To: Patrick Delaunay <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20240207141154.1.If0aa2d32c2ffde32ed1d87ab8a088db67bc2d25c@changeid>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20240207141154.1.If0aa2d32c2ffde32ed1d87ab8a088db67bc2d25c@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.252.7.115]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_07,2024-03-06_01,2023-05-22_02
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



On 2/7/24 14:12, Patrick Delaunay wrote:
> This patch avoids compilation issue when CONFIG_USB_GADGET is deactivated
> in defconfig, with undefined reference to run_usb_dnl_gadget and to
> g_dnl_set_product.
> 
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> ---
> 
>  arch/arm/mach-stm32mp/cmd_stm32prog/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-stm32mp/cmd_stm32prog/Kconfig b/arch/arm/mach-stm32mp/cmd_stm32prog/Kconfig
> index 8f91db4b46b9..589276282e44 100644
> --- a/arch/arm/mach-stm32mp/cmd_stm32prog/Kconfig
> +++ b/arch/arm/mach-stm32mp/cmd_stm32prog/Kconfig
> @@ -17,6 +17,7 @@ config CMD_STM32PROG
>  config CMD_STM32PROG_USB
>  	bool "support stm32prog over USB"
>  	depends on CMD_STM32PROG
> +	depends on USB_GADGET_DOWNLOAD
>  	default y
>  	help
>  		activate the command "stm32prog usb" for STM32MP soc family

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
