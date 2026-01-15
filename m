Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 825BFD41144
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 09:21:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0017C80077;
	Thu, 15 Jan 2026 10:21:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cTdKFrF7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A93F1803F5; Thu, 15 Jan 2026 10:21:51 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 596728003E
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 10:21:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 9D691440E5;
 Thu, 15 Jan 2026 09:21:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1F5EC19421;
 Thu, 15 Jan 2026 09:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768468907;
 bh=7IyQryXy3O75TXORrelw2Dlado2gFjhCYefwZFLlZ5U=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=cTdKFrF7oxhO+95oCiWKZ5ihZS1naYvcHsC/k0frVep6RUMDSiReIquRyt2wewmFS
 Ue+8899T6uyrmA8ClNUEzeXcgijrJ0vbitDvCxnWMNSfWwQwrBdeZFN9afRYiCl67Q
 7ashm8LHhmazPQPwxjYIuPa8/JatYPTtMR3Pgo5HHxtQ11AzsacdoKbSwZKtBt3Kdi
 VdVGFrI8M9YRgL14Zmuz4hWam5Pjr/REsUjpgfmTVE1sKxYBTzIRDYnSMtADstL28D
 rxHnYq/dVoJ4oFcNJDZVyQzCam1kMI/UWnsVDRHhZQe2Vu0Px+23FVxDsxmdm9yZZ6
 siQcNVPsCpIBQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Casey Connolly <casey.connolly@linaro.org>, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, Mattijs
 Korpershoek <mkorpershoek@kernel.org>, Casey Connolly
 <casey.connolly@linaro.org>, Kaustabh Chakraborty
 <kauschluss@disroot.org>, Jonas Karlman <jonas@kwiboo.se>, Sam Protsenko
 <semen.protsenko@linaro.org>, Balaji Selvanathan
 <balaji.selvanathan@oss.qualcomm.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>
Subject: Re: [PATCH 2/3] usb: dwc3-generic: support Qualcomm flattened DT
In-Reply-To: <20260114-casey-usb-role-switch-v1-2-fb7a626466b9@linaro.org>
References: <20260114-casey-usb-role-switch-v1-0-fb7a626466b9@linaro.org>
 <20260114-casey-usb-role-switch-v1-2-fb7a626466b9@linaro.org>
Date: Thu, 15 Jan 2026 10:21:44 +0100
Message-ID: <873447fcyf.fsf@kernel.org>
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

Hi Casey,

Thank you for the patch.

On Wed, Jan 14, 2026 at 15:13, Casey Connolly <casey.connolly@linaro.org> wrote:

> Qualcomm devicetrees are moving away from having a glue node with dwc3
> as a subnode and now may just have a single flattened node.

In the commit message, could you provide a link to an example dt who has
this single flattened node?

>
> Rockchip already have a glue_get_ctrl_dev op which returns the node for
> the glue device itself, commonise this and reuse it for the new Qualcomm
> node.
>
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>  drivers/usb/dwc3/dwc3-generic.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
> index 02c02b1d80e4..7044696ced0c 100644
> --- a/drivers/usb/dwc3/dwc3-generic.c
> +++ b/drivers/usb/dwc3/dwc3-generic.c
> @@ -6,8 +6,10 @@
>   *
>   * Based on dwc3-omap.c.
>   */
>  
> +#define LOG_DEBUG
> +

Debug leftover? Please drop for v2.

>  #include <dm.h>
>  #include <reset.h>
>  #include <asm/gpio.h>
>  #include <dm/device_compat.h>
> @@ -488,23 +490,29 @@ static void dwc3_qcom_glue_configure(struct udevice *dev, int index,
>  	if (mode != USB_DR_MODE_HOST)
>  		dwc3_qcom_vbus_override_enable(qscratch_base, true);
>  }
>  
> -struct dwc3_glue_ops qcom_ops = {
> -	.glue_configure = dwc3_qcom_glue_configure,
> -};
> -
> -static int dwc3_rk_glue_get_ctrl_dev(struct udevice *dev, ofnode *node)
> +/* In cases where there is no dwc3 node and it's flattened into the glue node */
> +static int dwc3_flat_dt_get_ctrl_dev(struct udevice *dev, ofnode *node)
>  {
>  	*node = dev_ofnode(dev);
>  	if (!ofnode_valid(*node))
>  		return -EINVAL;
>  
>  	return 0;
>  }
>  
> +struct dwc3_glue_ops qcom_ops = {
> +	.glue_configure = dwc3_qcom_glue_configure,
> +};
> +
> +struct dwc3_glue_ops qcom_flat_dt_ops = {
> +	.glue_configure = dwc3_qcom_glue_configure,
> +	.glue_get_ctrl_dev = dwc3_flat_dt_get_ctrl_dev,
> +};
> +
>  struct dwc3_glue_ops rk_ops = {
> -	.glue_get_ctrl_dev = dwc3_rk_glue_get_ctrl_dev,
> +	.glue_get_ctrl_dev = dwc3_flat_dt_get_ctrl_dev,
>  };
>  
>  static int dwc3_glue_bind_common(struct udevice *parent, ofnode node)
>  {
> @@ -711,8 +719,9 @@ static const struct udevice_id dwc3_glue_ids[] = {
>  	{ .compatible = "rockchip,rk3568-dwc3", .data = (ulong)&rk_ops },
>  	{ .compatible = "rockchip,rk3576-dwc3", .data = (ulong)&rk_ops },
>  	{ .compatible = "rockchip,rk3588-dwc3", .data = (ulong)&rk_ops },
>  	{ .compatible = "qcom,dwc3", .data = (ulong)&qcom_ops },
> +	{ .compatible = "qcom,snps-dwc3", .data = (ulong)&qcom_flat_dt_ops },
>  	{ .compatible = "fsl,imx8mp-dwc3", .data = (ulong)&imx8mp_ops },
>  	{ .compatible = "fsl,imx8mq-dwc3" },
>  	{ .compatible = "intel,tangier-dwc3" },
>  	{ .compatible = "samsung,exynos7870-dwusb3" },
>
> -- 
> 2.51.0
