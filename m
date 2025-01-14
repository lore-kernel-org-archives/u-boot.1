Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12ADAE77188
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 17:42:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A4238060C;
	Tue, 14 Jan 2025 18:41:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1736876513;
	bh=AQtFMwfFS1FblTd2LXCB7mNYXTMtPIBTWiQO0761PkY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j/eN1IT8sNZe0fSXwqYJ24lPm2/IzmQoV3WwoKv2UKsmSYe5YYobvyDHt6zd0wBxQ
	 1qkdcYrDWBCebMeNvvzJejy+3I87OQImHHysqdkoSqlXLDM14IVEpD0X/T1OVaP9nf
	 b9FXc/wfPe3IqJlqfHgB/KDAtL4oRrNXyy0Z/2llpqTDp7a+b/SM1JmR1FHM/5ggPf
	 tXf8i3LZH3RJJVhLNF8vgIDHjpc6xhapp0qHK0ZghyuOl6AIN/kqLXROCCxyX+e7ah
	 PXFIfqjFTfP8UhHYcc0hhYWbnJf4rem3TIumY4LZUJxw4YTlJExMeEJ3+f7KRah+Dv
	 0hKvXIMLdWm7w==
Received: by phobos.denx.de (Postfix, from userid 109)
 id D965F806FE; Tue, 14 Jan 2025 18:41:51 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E598F8022E
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 18:41:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="flH1Ua2d"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 22B91101C6205; Tue, 14 Jan 2025 18:41:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1736876509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AQtFMwfFS1FblTd2LXCB7mNYXTMtPIBTWiQO0761PkY=;
 b=flH1Ua2dId9LsZoz1yI5sssKV63MO70Xr7CzmKQGkMFB86AoZ3Bpv4I+1KVsDQgIY4VE4H
 M3H7vRZ0pyOZYLvdk3sx5N3QRCSkoY4vK3qmdRQlezAwYc5myEriH415UzyHxRSs5FMP+I
 tBnYuNlslbCiquR34X6vBC/ZgHF+cDmTsGqUZNcfFhZ+6r+EES18Ru7ZPn5g/h3u5C6oyP
 pOFA6GYEXEgkjQMaYkTTXRTou4U/21ebKcHvDtLhVuVIoZURuViYEyxwPJripWb0NcsBn0
 bJSNMd/nZcG8j7mVeh064xyXS2mlCJzLvXIZkN3RAvNttZ1oB+QxIoCC3BwVQg==
Message-ID: <de9e66e1-ab5a-4d46-9ec9-b19627f4ea9b@denx.de>
Date: Tue, 14 Jan 2025 15:54:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] dw3-generic: Add dependencies whith SYSCON and
 REGMAP
To: Patrice Chotard <patrice.chotard@foss.st.com>, u-boot@lists.denx.de
Cc: Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sjoerd Simons <sjoerd@collabora.com>, Tom Rini <trini@konsulko.com>
References: <20250114144528.1612168-1-patrice.chotard@foss.st.com>
 <20250114144528.1612168-7-patrice.chotard@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250114144528.1612168-7-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 1/14/25 3:45 PM, Patrice Chotard wrote:
> Since addition of STiH407 support in dwc3-generic, SYSCON and REGMAP
> support are needed.
> 
> Add dependencies with SPL_REGMAP and SPL_SYSCON for:
> qcm6490, imx8mp_evk, phycore-imx8mp, librem5, qcom,
> xilinx_versal_net_virt, amd_versal2_virt, xilinx_zynqmp_kria
> xilinx_zynqmp_virt.
> 
> Add dependencies with SPL_REGMAP and SPL_SYSCON for am57xx_hs_evm_usb.
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Marek Vasut <marex@denx.de>
> ---
> 
>   drivers/usb/dwc3/Kconfig | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
> index 0100723a68b..ef82a3e9626 100644
> --- a/drivers/usb/dwc3/Kconfig
> +++ b/drivers/usb/dwc3/Kconfig
> @@ -26,6 +26,10 @@ config USB_DWC3_OMAP
>   config USB_DWC3_GENERIC
>   	bool "Generic implementation of a DWC3 wrapper (aka dwc3 glue)"
>   	depends on DM_USB && USB_DWC3 && MISC
> +	select SPL_REGMAP if SPL
> +	select SPL_SYSCON if SPL
> +	select REGMAP
> +	select SYSCON
Why was this not needed so far ? Or is this a bugfix ?
