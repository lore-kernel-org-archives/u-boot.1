Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24683C3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 09:04:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9ABF483AED;
	Thu, 10 Apr 2025 11:04:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mLQ674sN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50B9283AFD; Thu, 10 Apr 2025 11:04:38 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 102E583AE9
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 11:04:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 7D51AA498B2;
 Thu, 10 Apr 2025 08:59:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1474BC4CEDD;
 Thu, 10 Apr 2025 09:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1744275874;
 bh=RIv9QeLk9/3Z7WT3rO6qSe+uesvj0KpIKz15BsRpXbw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mLQ674sN1CeMjaY0rqJG9QMSBQ99HEwwzKegiaaE99Uf1tjmpWPIICkzRBqH7csG1
 z7x5DFh1Ni61rrlp78o2M6sEgeZ/jJ3m9wQVeMxQqm0FU3+c7wzpL1ky2bA926BqSj
 RfLvl8vbPv8b1qoFOOnDTcdMzzd52YoMHA1jDeckOS2KoxT8/kLwEj5Wli5Eh5G1Kw
 Vg3YdY0gj6tdOPA3j4VtjKpEWuMjkkslre666EIKMWmXxZ67NdUS71hwNAaM8winIR
 u4vncuKwdCuwGToJH9JQTVW3F5Aof+K1bNtQm71noxqNyp1eYjSbnZD/QNI13fkb9L
 vP6RJs0YcBdMw==
Date: Thu, 10 Apr 2025 14:34:28 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [PATCH 5/6] mach-snapdragon: of_fixup: set dr_mode for RB1/2
 boards
Message-ID: <Z_eJnJqRZUJHCNC5@sumit-X1>
References: <20250409-livetree-fixup-v1-0-76dfea80b07f@linaro.org>
 <20250409-livetree-fixup-v1-5-76dfea80b07f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409-livetree-fixup-v1-5-76dfea80b07f@linaro.org>
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

On Wed, Apr 09, 2025 at 07:17:28PM +0200, Caleb Connolly wrote:
> The RB1 and RB2 have a single USB controller which is manually muxed
> between a type-c port and an internal USB hub via a DIP switch. OTG is
> supported in Linux, but the DWC3 driver in U-Boot can only handle a
> single mode, and defaults to peripheral mode.
> 
> We did hack around this on the RB2, but the RB1 got left out.
> 
> Now that we can fix up the live tree before devices are bound, drop the
> DTS hacks and do the fixup at runtime instead.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  arch/arm/dts/qrb4210-rb2-u-boot.dtsi |  6 ------
>  arch/arm/mach-snapdragon/of_fixup.c  | 28 ++++++++++++++--------------
>  2 files changed, 14 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/arm/dts/qrb4210-rb2-u-boot.dtsi b/arch/arm/dts/qrb4210-rb2-u-boot.dtsi
> deleted file mode 100644
> index 7d1375f38c44d7bd54c022fa3d390f666a35d6ee..0000000000000000000000000000000000000000
> --- a/arch/arm/dts/qrb4210-rb2-u-boot.dtsi
> +++ /dev/null
> @@ -1,6 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -
> -/* This is usually OTG but U-Boot doesn't support that properly */
> -&usb_dwc3 {
> -	dr_mode = "host";
> -};
> diff --git a/arch/arm/mach-snapdragon/of_fixup.c b/arch/arm/mach-snapdragon/of_fixup.c
> index b39036e8e0890fdf834a0dfe6966ef3dd365f3d2..62b329e2c90d7e0a374838968ab5707333edbf03 100644
> --- a/arch/arm/mach-snapdragon/of_fixup.c
> +++ b/arch/arm/mach-snapdragon/of_fixup.c
> @@ -98,8 +98,21 @@ static int fixup_qcom_dwc3(struct device_node *glue_np)
>  		log_err("Failed to set 'maximum-speed' property: %d\n", ret);
>  		return ret;
>  	}
>  
> +	/*
> +	 * The RB1/2 boards only have a single USB controller and it's muxed between the type-C port
> +	 * and a USB hub. Since we can't do OTG in U-Boot properly we prefer to put it into host mode.
> +	 */
> +	if (of_device_is_compatible(gd->of_root, "qcom,qrb4210-rb2", NULL, NULL) ||
> +	    of_device_is_compatible(gd->of_root, "qcom,qrb2210-rb1", NULL, NULL)) {
> +		ret = of_write_prop(dwc3, "dr_mode", sizeof("host"), "host");
> +		if (ret) {
> +			log_err("Failed to set 'dr_mode' property: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
>  	return 0;
>  }
>  
>  static void fixup_usb_nodes(void)
> @@ -162,21 +175,8 @@ static int qcom_of_fixup_nodes(void)
>  }
>  
>  EVENT_SPY_SIMPLE(EVT_OF_LIVE_INIT, qcom_of_fixup_nodes);
>  
> -int ft_board_setup(void *blob, struct bd_info __maybe_unused *bd)
> +int ft_board_setup(void __maybe_unused *blob, struct bd_info __maybe_unused *bd)
>  {
> -	struct fdt_header *fdt = blob;
> -	int node;
> -
> -	/* On RB1/2 we need to fix-up the dr_mode */
> -	if (!fdt_node_check_compatible(fdt, 0, "qcom,qrb4210-rb2") ||
> -	    !fdt_node_check_compatible(fdt, 0, "qcom,qrb2210-rb1")) {
> -		fdt_for_each_node_by_compatible(node, blob, 0, "snps,dwc3") {
> -			log_debug("%s: Setting 'dr_mode' to OTG\n", fdt_get_name(blob, node, NULL));
> -			fdt_setprop_string(fdt, node, "dr_mode", "otg");
> -			break;
> -		}
> -	}
> -
>  	return 0;
>  }

We should now be able to drop OF_BOARD_SETUP from qcom_defconfig and
this API.

With that:

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit
