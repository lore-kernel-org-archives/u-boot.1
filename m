Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC13AD2594B
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 07:19:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15F5883F53;
	Tue, 27 Jan 2026 08:18:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FUEBgF47";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2177383F70; Tue, 27 Jan 2026 08:18:58 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C453183F3F
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 08:18:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id AE38360121;
 Tue, 27 Jan 2026 07:18:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61F59C116C6;
 Tue, 27 Jan 2026 07:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769498334;
 bh=/nno2WFJ2hd/SoPYnvEyGu79+GRwB9PV2b+fOVe8juE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FUEBgF47zmFT5ezTtOEgyZJRTda5h3IQjPf+mfm1smHiyF2KArkzfiX+R5tf32AYb
 XHNyZ3V8Fhn2kUbKlFzCg4aEU0U7AKjK8X7ApdtDqjalnKbdEF58S8GLU51CYNzKxa
 UOmRt+IXWEZvVqPmenmid+kDaiGtiLAzv7bYryeOuVhhctcdKn+DEBZkTVvUDRMe8j
 6Mv1ptNUCWr22ExOv2+kUEUFCJ6cOyNODjNhx8QRRAPb8E6/sY7QfIxsq/Y2ZEjntW
 72gQZDS+R2Zj2SGXtJHUhQ2OdO5BDD9etRSBk5Evj7TtOAntTw99jgEJN6wmFpVYNn
 GiKzS5lVODYRA==
Date: Tue, 27 Jan 2026 12:48:43 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: trini@konsulko.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, lukma@denx.de,
 aswin.murugan@oss.qualcomm.com, rui.silva@linaro.org,
 david.wronek@mainlining.org, ilias.apalodimas@linaro.org,
 luca.weiss@fairphone.com, jorge.ramirez@oss.qualcomm.com,
 stephan.gerhold@linaro.org, quic_varada@quicinc.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH v1 2/3] arm: snapdragon: Remove QCS615 MMC node disable
 fixup
Message-ID: <aXhm01e0EgM7HyKz@sumit-xelite>
References: <20260126155938.2717540-1-balaji.selvanathan@oss.qualcomm.com>
 <20260126155938.2717540-3-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126155938.2717540-3-balaji.selvanathan@oss.qualcomm.com>
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

On Mon, Jan 26, 2026 at 09:29:37PM +0530, Balaji Selvanathan wrote:
> Remove the QCS615-specific device tree fixup that was disabling the
> MMC node at /soc@0/mmc@7c4000. This fixup is no longer needed as the
> MMC/SDCC functionality should now be properly supported through the
> clock infrastructure and device tree configuration.
> 
> This patch is based on the changes in the upstream submission:
> https://lore.kernel.org/u-boot/20260113115404.1448759-4-aswin.murugan@oss.qualcomm.com/

Rather drop this patch entirely since fixing eMMC as you did as part of
patch #1 is the right thing to do for upstream. The series you
referenced can be adjusted accordingly.

-Sumit

> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>  arch/arm/mach-snapdragon/of_fixup.c | 14 --------------
>  1 file changed, 14 deletions(-)
> 
> diff --git a/arch/arm/mach-snapdragon/of_fixup.c b/arch/arm/mach-snapdragon/of_fixup.c
> index 9b6e1847489..216cc816d95 100644
> --- a/arch/arm/mach-snapdragon/of_fixup.c
> +++ b/arch/arm/mach-snapdragon/of_fixup.c
> @@ -194,20 +194,6 @@ EVENT_SPY_FULL(EVT_OF_LIVE_BUILT, qcom_of_fixup_nodes);
>  static void soc_specific_fixups(struct fdt_header *fdt)
>  {
>  	int ret;
> -
> -	/* QCS615-specific fixup: Disable MMC node */
> -	if (fdt_node_check_compatible(fdt, 0, "qcom,qcs615") == 0) {
> -		int path_offset;
> -		char prop_val[] = "disabled";
> -
> -		path_offset = fdt_path_offset(fdt, "/soc@0/mmc@7c4000");
> -		if (path_offset >= 0) {
> -			ret = fixup_dt_node(fdt, path_offset, "status",
> -					    (void *)prop_val, SET_PROP_STRING);
> -			if (ret)
> -				log_err("Failed to disable MMC node for QCS615: %d\n", ret);
> -		}
> -	}
>  }
>  
>  int ft_board_setup(void __maybe_unused *blob, struct bd_info __maybe_unused *bd)
> -- 
> 2.34.1
> 
