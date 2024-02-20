Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E5D7C48BC3
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 10:48:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2938587D4D;
	Tue, 20 Feb 2024 11:48:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1708426106;
	bh=AL1dYR1UI/9oDKVX2W2IRrS7G6AmmtGRHaNzqh0q2ME=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X2wMlm00k1uVghQMkFX4l8Mgp8sbYUQv0j6onLGV9J5cb6sV74f35Cg+TNfCAfKsB
	 vZx4CNSEFFpXJjvQET/uxy3rc88HkIlx7oWRApy46ef/TV363UnaZJYlgpvWkYGPnv
	 LZqb0CgAKwBwZoQ3u2wXtIYu+9LE4398Sp0CGSi6sbhdhu6FBt7JY/I320bkWvW0Ft
	 W7Via37K14H8CNwGp+Q2CN3ztM2ESt2v37ZGZPRlsJwPiRvyNsfzkL+hhxZN4m+e0z
	 YRGqjNPUMoOnnoPAwoRNQpd5mKW/6n5ANNrLFN48eNOgqgi/mltuto+Mu5Y4htRTLr
	 ePBHdGIdBHpcA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 8521087D2F;
 Tue, 20 Feb 2024 11:47:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1708426060;
 bh=AL1dYR1UI/9oDKVX2W2IRrS7G6AmmtGRHaNzqh0q2ME=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=eDfSv2EoPXFDpgoN1Plusr27o7DTmdWkdR/SzcqvUb8RqwmW6T64BRpYzAn5G/3nF
 ydKooot4XDGsmLi47HvkwA57+gPRBmli732xHbs2uBdyckffLBcyZ1f826ZdiMohJD
 VlfJUEPXCGAjGt3k7AfF+4FGp+eYBILpHOwa25I4oisa4IxTPO2CZWrUj/IVobJtlT
 Cp+x9KQO/HSOplJcgkdB4YLCJoMj/sNGS8wo/dTcjPi3F284m+ti+aaCJUisLFVO3C
 28ThMDYWffgHgFFPC6tBoi80I3hiHMNvu+ZduvKZW6Fyn70cOHqLX8iHJrUFo3EJkV
 EEJAYIsiBE9WQ==
Message-ID: <9f76db03-6fc2-4443-a711-df95d069a412@denx.de>
Date: Tue, 20 Feb 2024 11:47:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: ehci-mx6: Add i.MX93 support
Content-Language: en-US
To: Mathieu Othacehe <othacehe@gnu.org>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Shiji Yang <yangshiji66@outlook.com>,
 Ye Li <ye.li@nxp.com>, =?UTF-8?Q?S=C3=A9bastien_Szymanski?=
 <sebastien.szymanski@armadeus.com>, Fabio Estevam <festevam@gmail.com>,
 Simon Glass <sjg@chromium.org>, Mathieu Othacehe <m.othacehe@gmail.com>
Cc: u-boot@lists.denx.de
References: <20240219170531.14959-1-othacehe@gnu.org>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240219170531.14959-1-othacehe@gnu.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 2/19/24 18:05, Mathieu Othacehe wrote:
> i.MX93 uses the same USB IP as i.MX8MM. It can then reuse the ehci-mx6
> driver.
> 
> Reviewed-by: Marek Vasut <marex@denx.de>
> Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
> ---
>   drivers/usb/host/Kconfig    | 6 +++---
>   drivers/usb/host/ehci-mx6.c | 2 +-
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index 0dd5736433c..f96027d7bd2 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -210,10 +210,10 @@ config USB_EHCI_MX6
>   
>   config USB_EHCI_MX7
>   	bool "Support for i.MX7 on-chip EHCI USB controller"
> -	depends on ARCH_MX7 || IMX8M
> +	depends on ARCH_MX7 || IMX8M || IMX93
>   	select EHCI_HCD_INIT_AFTER_RESET if ARCH_MX7
> -	select PHY if IMX8M
> -	select NOP_PHY if IMX8M
> +	select PHY if IMX8M || IMX93
> +	select NOP_PHY if IMX8M || IMX93
>   	default y
>   	---help---
>   	  Enables support for the on-chip EHCI controller on i.MX7 SoCs.
> diff --git a/drivers/usb/host/ehci-mx6.c b/drivers/usb/host/ehci-mx6.c
> index a9ed5e7a0d5..a35fcca43a2 100644
> --- a/drivers/usb/host/ehci-mx6.c
> +++ b/drivers/usb/host/ehci-mx6.c
> @@ -538,7 +538,7 @@ static int ehci_usb_phy_mode(struct udevice *dev)
>   			plat->init_type = USB_INIT_DEVICE;
>   		else
>   			plat->init_type = USB_INIT_HOST;
> -	} else if (is_mx7() || is_imx8mm() || is_imx8mn()) {
> +	} else if (is_mx7() || is_imx8mm() || is_imx8mn() || is_imx93()) {
>   		phy_status = (void __iomem *)(addr +
>   					      USBNC_PHY_STATUS_OFFSET);
>   		val = readl(phy_status);

Applied, thanks
