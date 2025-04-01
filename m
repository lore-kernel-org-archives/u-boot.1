Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA89C36014
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 12:33:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3D168210A;
	Tue,  1 Apr 2025 14:32:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="K6pdr3v9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 299F882047; Tue,  1 Apr 2025 12:10:59 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85A6D8006D
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 12:10:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id A00DCA44601;
 Tue,  1 Apr 2025 10:05:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E363C4CEE4;
 Tue,  1 Apr 2025 10:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1743502255;
 bh=t+fYL2vHnrFdz9VnQaC1DQUO07mQWbHGohW7GtWgil4=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=K6pdr3v9oLSNWfThylQu3EwPBL4iLQHkjM67o0GUmGxp2TsUGmOpYncb2W6oOdgT5
 KUrDskg8yv+ST5TC1KpewptzdS6/0OlDh1KGswh98s/7OAJyLWiU8Ks2U6aqTibpp3
 hZ1U9KSVnqN7dAVDtvD9rjrZGaifgCmanKS0xhsy/NL17Y/ichtE9Fq6sx67Av5rtE
 KuhgBhndHbQg82a5WixhY2tj+bHhcLiU5FUCjAgYjBjmALSXZ/dZIw5DvuGwRAFoC2
 0heMOkykFfndNpnuBvo8QNE4GFR8NVfsVTbBqqS31hKbWozzupOBEdMTjflFGjuN+u
 EcX4NlDAttTQA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Zixun LI <admin@hifiphile.com>, Eugen Hristev
 <eugen.hristev@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: Zixun LI <admin@hifiphile.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 2/3] ARM: dts: sam9x60: Add USB gadget DT node.
In-Reply-To: <20250331162611.1557759-3-admin@hifiphile.com>
References: <20250331162611.1557759-1-admin@hifiphile.com>
 <20250331162611.1557759-3-admin@hifiphile.com>
Date: Tue, 01 Apr 2025 12:10:51 +0200
Message-ID: <87v7ronqdw.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Tue, 01 Apr 2025 14:32:32 +0200
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

Hi Zixun,

Thank you for the patch.

On lun., mars 31, 2025 at 18:26, Zixun LI <admin@hifiphile.com> wrote:

> Add the USB gadget DT node for the sam9x60 SoC's.
>
> Signed-off-by: Zixun LI <admin@hifiphile.com>

Nitpick: title (subject) should not finish with a period (.)

This can be fixed up by the maintainer that will apply the patches.

Eugen, This is assigned to me on patchwork:
https://patchwork.ozlabs.org/project/uboot/list/?series=450655

Can I pick up all 3 patches or do you prefer to pick up [2/3] and [3/3] ?

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>  arch/arm/dts/sam9x60.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/arch/arm/dts/sam9x60.dtsi b/arch/arm/dts/sam9x60.dtsi
> index 3b684fc63d5..ea2647e5fc9 100644
> --- a/arch/arm/dts/sam9x60.dtsi
> +++ b/arch/arm/dts/sam9x60.dtsi
> @@ -69,6 +69,19 @@
>  		#size-cells = <1>;
>  		ranges;
>  
> +		usb0: gadget@500000 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "microchip,sam9x60-udc";
> +			reg = <0x500000 0x100000>,
> +				<0xf803c000 0x400>;
> +			clocks = <&pmc PMC_TYPE_PERIPHERAL 23>, <&pmc PMC_TYPE_CORE 8>;
> +			clock-names = "pclk", "hclk";
> +			assigned-clocks = <&pmc PMC_TYPE_CORE 8>;
> +			assigned-clock-rates = <480000000>;
> +			status = "disabled";
> +		};
> +
>  		usb1: usb@600000 {
>  			compatible = "atmel,at91rm9200-ohci", "usb-ohci";
>  			reg = <0x00600000 0x100000>;
> -- 
> 2.49.0
