Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96060CDB482
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 17:47:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5661586689;
	Sun, 15 Oct 2023 19:47:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697392073;
	bh=Q3D67Y23BlLqS+CKX/zhiNCAMoPkmw0phYsQaCGiZ7U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oN9tC3p5D0HqhtTuT6nwuDSDgX1KeoOFgvuiJuDh5n6P+0YX1t/fRk5biU5Atn6Uo
	 rr5gXGhM/OWH8arnhymZX2FmVuf47q87fmdCBWmlhlyQsjAgBdiUg3EzqqO08qY71b
	 RM3kCHjzJRNqmrg7wccVySXVo2Sti/5f0s0JU9BFHUhI9GyKDOysUyuCam7q31AiAM
	 e4IuZehqrw6N0XoE3VJzzBZDdqAeypsBmn4MhKookD5gaqDHxZDUOxc761b6fxWXdP
	 b9/jg3F2hbJoa9BFKIMxo4MmAlBUsOEk1VsaXmXUW7rmnE3Fk6HUef5K+1vZzmLODb
	 62HKTtNlRdwQA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 49EBE864F3;
 Sun, 15 Oct 2023 19:47:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1697392061;
 bh=Q3D67Y23BlLqS+CKX/zhiNCAMoPkmw0phYsQaCGiZ7U=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=kWeOac0Ugkl5LMHc9gOSMsV0AKmqZHHbXprzyngdNjFP3W7T8o9mgyBqwxUiIevzm
 Py24LBISeyRDG5dwnZpCmAr1qBsD5Fv1tsNOKMOxjqo7fNfS7ULQvHCZQgf2sh2T96
 aDuq0OHZ/R+pNRa04F6wcFPAgXAD/tyLcnnx8uqdZtZolFJ5SFlfSIzceVMOOVUClg
 6xQaVMCQRnVfCUVAT7Eg+aza6qLxnBx52+4rrwG1Nsg4GJUDbEEtBR4pL6pjStaXJt
 lMFTC4rQ5vI6tRKskjqWSEFs5HY2hsGsz8Khtg1wW1DZYTUrQa+sd0mhkFWIZXh5PS
 bDEqnvIN/oMxA==
Message-ID: <5d82ca71-6ec4-4778-b85d-778eb2ade602@denx.de>
Date: Sun, 15 Oct 2023 19:47:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] imx8mp-evk: Add USB0 OTG support
Content-Language: en-US
To: Fabio Estevam <festevam@gmail.com>, sbabic@denx.de
Cc: peng.fan@nxp.com, u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>
References: <20231014211208.550381-1-festevam@gmail.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20231014211208.550381-1-festevam@gmail.com>
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

On 10/14/23 23:12, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> Add USB0 OTG support.
> 
> Currently, the USB0 OTG nodes are not enabled in the Linux kernel
> devicetree.
> 
> For this reason, enable the USB0 OTG nodes inside imx8mp-evk-u-boot.dtsi
> for now.
> 
> Also select several useful options such as USB gadget and fastboot.
> 
> Tested by running "ums 0 mmc 2".
> 
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---
> Changes since v1:
> - Selected CONFIG_PHY=y and CONFIG_PHY_IMX8MQ_USB=y. Previously the ums
> command was working only after booting via USB serial download mode.
> Now it also works after booting from SD card.
> 
>   arch/arm/dts/imx8mp-evk-u-boot.dtsi | 14 +++++++++++++
>   configs/imx8mp_evk_defconfig        | 31 +++++++++++++++++++++++++++++
>   2 files changed, 45 insertions(+)
> 
> diff --git a/arch/arm/dts/imx8mp-evk-u-boot.dtsi b/arch/arm/dts/imx8mp-evk-u-boot.dtsi
> index 6784ed2e7c92..43f13a9c22f7 100644
> --- a/arch/arm/dts/imx8mp-evk-u-boot.dtsi
> +++ b/arch/arm/dts/imx8mp-evk-u-boot.dtsi
> @@ -111,6 +111,20 @@
>   	bootph-pre-ram;
>   };
>   
> +&usb3_phy0 {
> +	status = "okay";
> +};

Keep the list sorted, _0 goes before _phy0, doesn't it ?

> +&usb3_0 {
> +	status = "okay";
> +};
> +
> +&usb_dwc3_0 {
> +	pinctrl-names = "default";

Is this ^ pinctrl-names without pinctrl-0 property needed ?

> +	dr_mode = "peripheral";
> +	status = "okay";
> +};
> +
>   &usdhc1 {
>   	bootph-pre-ram;
>   };

With that fixed:

Reviewed-by: Marek Vasut <marex@denx.de>
