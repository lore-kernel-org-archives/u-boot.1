Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49DC7D4A61A
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 09:42:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C999783015;
	Fri, 16 Jan 2026 10:42:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FWWdVEpG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39435830E4; Fri, 16 Jan 2026 10:42:37 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 095F882BF2
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 10:42:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id DB93B60167;
 Fri, 16 Jan 2026 09:42:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2303C116C6;
 Fri, 16 Jan 2026 09:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768556553;
 bh=yX+xvotk0Sa10kfsnd86AOqt4LtDjchjwW85eId04vs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FWWdVEpG5V2SeHVQ7UraP4MzxH/bikIbncTgX/MCBhkBnyhvU8h0AKG47veLGb0fU
 y7Pr7C4e5NgXJ6rNNPRZCC7hOKXZ7jQZxEPp/R63xsqjAWhbjtLz6kI+zotyZKmb5N
 xNOfdA/CTT2EOilN0se4DaovtZ+iPZMM3BQUpzu9BddH77ktl9zjaJVgEOC/hMbOgQ
 W3RqFKEBgJAx8xHGDF2V4cBvuKAJEEMVEIMzRZgHUNiRo1eclnf1unzophydTErFIA
 fbfJn6VoLzbc/zXoPVBctduaxTuHhCyxGnzne2SEd3bADMM2m1Veg6JNxx3MgXerKJ
 /HD2vFNn2Bp/w==
Date: Fri, 16 Jan 2026 15:12:26 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Rui Miguel Silva <rui.silva@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot-qcom@groups.io,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] mach-snapdragon: of_fixup: support new flat dwc3 node
Message-ID: <aWoIAooBmP_cvjEr@sumit-xelite>
References: <20260114135739.1546815-1-casey.connolly@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114135739.1546815-1-casey.connolly@linaro.org>
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

On Wed, Jan 14, 2026 at 02:57:32PM +0100, Casey Connolly wrote:
> Qualcomm DTs are being updated to use a new format where the dwc3 glue
> node and controller are combined into a single DT node. Update the fixup
> code to handle this case.
> 
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>  arch/arm/mach-snapdragon/of_fixup.c | 40 +++++++++++++++++++++--------
>  1 file changed, 29 insertions(+), 11 deletions(-)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/arch/arm/mach-snapdragon/of_fixup.c b/arch/arm/mach-snapdragon/of_fixup.c
> index eec2c0c757e0..5b6076ea8e57 100644
> --- a/arch/arm/mach-snapdragon/of_fixup.c
> +++ b/arch/arm/mach-snapdragon/of_fixup.c
> @@ -31,31 +31,37 @@
>   * USB controllers. Rather than requiring source level DT changes, we fix up
>   * DT here. This improves compatibility with upstream DT and simplifies the
>   * porting process for new devices.
>   */
> -static int fixup_qcom_dwc3(struct device_node *root, struct device_node *glue_np)
> +static int fixup_qcom_dwc3(struct device_node *root, struct device_node *glue_np, bool flat)
>  {
>  	struct device_node *dwc3;
>  	int ret, len, hsphy_idx = 1;
>  	const __be32 *phandles;
>  	const char *second_phy_name;
>  
>  	debug("Fixing up %s\n", glue_np->name);
>  
> +	/* New DT flattens the glue and controller into a single node. */
> +	if (flat) {
> +		dwc3 = glue_np;
> +		debug("%s uses flat DT\n", glue_np->name);
> +	} else {
> +		/* Find the DWC3 node itself */
> +		dwc3 = of_find_compatible_node(glue_np, NULL, "snps,dwc3");
> +		if (!dwc3) {
> +			log_err("Failed to find dwc3 node\n");
> +			return -ENOENT;
> +		}
> +	}
> +
>  	/* Tell the glue driver to configure the wrapper for high-speed only operation */
>  	ret = of_write_prop(glue_np, "qcom,select-utmi-as-pipe-clk", 0, NULL);
>  	if (ret) {
>  		log_err("Failed to add property 'qcom,select-utmi-as-pipe-clk': %d\n", ret);
>  		return ret;
>  	}
>  
> -	/* Find the DWC3 node itself */
> -	dwc3 = of_find_compatible_node(glue_np, NULL, "snps,dwc3");
> -	if (!dwc3) {
> -		log_err("Failed to find dwc3 node\n");
> -		return -ENOENT;
> -	}
> -
>  	phandles = of_get_property(dwc3, "phys", &len);
>  	len /= sizeof(*phandles);
>  	if (len == 1) {
>  		log_debug("Only one phy, not a superspeed controller\n");
> @@ -103,15 +109,27 @@ static int fixup_qcom_dwc3(struct device_node *root, struct device_node *glue_np
>  }
>  
>  static void fixup_usb_nodes(struct device_node *root)
>  {
> -	struct device_node *glue_np = root;
> +	struct device_node *glue_np = root, *tmp;
>  	int ret;
> +	bool flat;
> +
> +	while (true) {
> +		flat = false;
> +		/* First check for the old DT format with glue node then the new flattened format */
> +		tmp = of_find_compatible_node(glue_np, NULL, "qcom,dwc3");
> +		if (!tmp) {
> +			tmp = of_find_compatible_node(glue_np, NULL, "qcom,snps-dwc3");
> +			flat = !!tmp;
> +		}
> +		if (!tmp)
> +			break;
> +		glue_np = tmp;
>  
> -	while ((glue_np = of_find_compatible_node(glue_np, NULL, "qcom,dwc3"))) {
>  		if (!of_device_is_available(glue_np))
>  			continue;
> -		ret = fixup_qcom_dwc3(root, glue_np);
> +		ret = fixup_qcom_dwc3(root, glue_np, flat);
>  		if (ret)
>  			log_warning("Failed to fixup node %s: %d\n", glue_np->name, ret);
>  	}
>  }
> -- 
> 2.51.0
> 
