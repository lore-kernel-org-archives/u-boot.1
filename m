Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E45A0C83F1B
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 06:59:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6F138338D;
	Thu, 17 Jul 2025 08:59:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="o7t/hjxI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 425F783394; Thu, 17 Jul 2025 08:59:20 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5734C8334A
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 08:59:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 6B337A5773B;
 Thu, 17 Jul 2025 06:59:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89C72C4CEE3;
 Thu, 17 Jul 2025 06:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1752735557;
 bh=23ENywhLkfLmTLTsYRIAMaP8bL73AFK07VkFbb7+r2U=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=o7t/hjxIFNH6cdh25rjmmWq5U4z+YfwGOMvdUjTY6PIekqoDdHlWcR265qyAdiSa6
 W+Ugo3E7j/rEVjtrmwDZDT2SwrMakq6Wjba43zO7T0SLWqlrTN1RUXM1w4XbuQesn8
 6XY72IqoNO4jOdN2IotpLCdiwF7ch+scQYDtIJUyKICaCyIIK4HxxYKjoqJ0Y3QV3R
 fhYAsixzqCMAkOeGpRU+kK1g0pjy6jp2o/3Fd3bhyR5jJ8kvHLjw8nvu4BCw7zpzMp
 5lAZ/Nu2p9bhUn/yZdigdglM3GL2Wd2jvfTF/S30nTWu6gMDFgd3NjYcLTGItEL6Yn
 N2pfHutkpbiBQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini
 <trini@konsulko.com>, Marek Vasut <marex@denx.de>, Minkyu Kang
 <mk7.kang@samsung.com>
Cc: Minkyu Kang <promsoft@gmail.com>, Simon Glass <sjg@chromium.org>, Oliver
 Gaskell <Oliver.Gaskell@analog.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Greg Malysa <malysagreg@gmail.com>, Nathan
 Barrett-Morrison <nathan.morrison@timesys.com>, Jerome Forissier
 <jerome.forissier@linaro.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Roger Quadros <rogerq@kernel.org>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 2/9] usb: dwc3-generic: Add Exynos850 support
In-Reply-To: <20250709222926.24671-3-semen.protsenko@linaro.org>
References: <20250709222926.24671-1-semen.protsenko@linaro.org>
 <20250709222926.24671-3-semen.protsenko@linaro.org>
Date: Thu, 17 Jul 2025 08:59:14 +0200
Message-ID: <87qzyf2th9.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Sam,

Thank you for the patch.

On Wed, Jul 09, 2025 at 17:29, Sam Protsenko <semen.protsenko@linaro.org> wrote:

> The only thing needed from DWC3 glue layer for Exynos850 is to enable
> USB clocks. The generic glue layer driver already does that. Add
> Exynos850 dwc3 compatible string to enable support for this chip.
>
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>  drivers/usb/dwc3/dwc3-generic.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
> index 21452ad15693..3cda2b74b7e3 100644
> --- a/drivers/usb/dwc3/dwc3-generic.c
> +++ b/drivers/usb/dwc3/dwc3-generic.c
> @@ -704,6 +704,7 @@ static const struct udevice_id dwc3_glue_ids[] = {
>  	{ .compatible = "fsl,imx8mp-dwc3", .data = (ulong)&imx8mp_ops },
>  	{ .compatible = "fsl,imx8mq-dwc3" },
>  	{ .compatible = "intel,tangier-dwc3" },
> +	{ .compatible = "samsung,exynos850-dwusb3" },
>  	{ }
>  };
>  
> -- 
> 2.39.5
