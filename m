Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00409C3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 08:50:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82A0183AB4;
	Thu, 10 Apr 2025 10:50:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OGyRLlaL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7C3C83AB9; Thu, 10 Apr 2025 10:50:16 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91F8383A98
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 10:50:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 7586545084;
 Thu, 10 Apr 2025 08:50:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79EB0C4CEDD;
 Thu, 10 Apr 2025 08:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1744275013;
 bh=Le3LUpABgVZzg4UeudZcFbhqQHLi5EO80LAd+64gt8k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OGyRLlaLrdRLHd0bGqR7nsKyXs81r0HwGielPUpe2NsdK1Aw4Us5NJOxetUC8oGh6
 SeUP9MnqOOWOQg6zpCRiH4XKhefe7IFn+XZheKjrULK3HEM1CMwLUWRQ602TMRaze8
 2RFyt7xP48jkI+9PoHsLopESc/ZpegJz3OMDupklJpDxgdczjdMA54WsNTykjQ5m5c
 h/y24Myi7VnDt24aX8P0N6GTXDhK3f1RpxZsRWidTO76qxT8x1n4qiIjNOtm3qFCAx
 BC2tCJ77Oj9qDfhEqgvtQ/TiF3QHvZtUiyj29hJX3JYcsFxRPzQEbMmDA0p94gFM05
 sO1VrrT6kMFFA==
Date: Thu, 10 Apr 2025 14:20:07 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [PATCH 2/6] mach-snapdragon: use EVT_OF_LIVE_INIT to apply DT
 fixups
Message-ID: <Z_eGP_al3bd-BGKU@sumit-X1>
References: <20250409-livetree-fixup-v1-0-76dfea80b07f@linaro.org>
 <20250409-livetree-fixup-v1-2-76dfea80b07f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409-livetree-fixup-v1-2-76dfea80b07f@linaro.org>
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

On Wed, Apr 09, 2025 at 07:17:25PM +0200, Caleb Connolly wrote:
> This will now apply fixups prior to devices being bound, which makes it
> possible to enable/disable devices and adjust more properties that might
> be read before devices probe.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  arch/arm/mach-snapdragon/board.c     |  1 -
>  arch/arm/mach-snapdragon/of_fixup.c  |  7 ++++++-
>  arch/arm/mach-snapdragon/qcom-priv.h | 14 --------------
>  3 files changed, 6 insertions(+), 16 deletions(-)
> 

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> index deae4d323789eab75d5fe735159b4cd820c02c45..3ab75f0fce02ecffd476ebe2aa606b1a9024bbec 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -305,9 +305,8 @@ void __weak qcom_board_init(void)
>  
>  int board_init(void)
>  {
>  	show_psci_version();
> -	qcom_of_fixup_nodes();
>  	qcom_board_init();
>  	return 0;
>  }
>  
> diff --git a/arch/arm/mach-snapdragon/of_fixup.c b/arch/arm/mach-snapdragon/of_fixup.c
> index 1ea0c18c2f2789a8aa054cd95bb9e4308d6b3384..d4e24059212c552de7fa7555d2ab8a1ea4fc4cb2 100644
> --- a/arch/arm/mach-snapdragon/of_fixup.c
> +++ b/arch/arm/mach-snapdragon/of_fixup.c
> @@ -21,8 +21,9 @@
>  
>  #include <dt-bindings/input/linux-event-codes.h>
>  #include <dm/of_access.h>
>  #include <dm/of.h>
> +#include <event.h>
>  #include <fdt_support.h>
>  #include <linux/errno.h>
>  #include <stdlib.h>
>  #include <time.h>
> @@ -149,14 +150,18 @@ static void fixup_power_domains(void)
>  		func(__VA_ARGS__); \
>  		debug(#func " took %lluus\n", timer_get_us() - start); \
>  	} while (0)
>  
> -void qcom_of_fixup_nodes(void)
> +static int qcom_of_fixup_nodes(void)
>  {
>  	time_call(fixup_usb_nodes);
>  	time_call(fixup_power_domains);
> +
> +	return 0;
>  }
>  
> +EVENT_SPY_SIMPLE(EVT_OF_LIVE_INIT, qcom_of_fixup_nodes);
> +
>  int ft_board_setup(void *blob, struct bd_info __maybe_unused *bd)
>  {
>  	struct fdt_header *fdt = blob;
>  	int node;
> diff --git a/arch/arm/mach-snapdragon/qcom-priv.h b/arch/arm/mach-snapdragon/qcom-priv.h
> index 74d39197b89f4e769299b06214c26ee829ecdce0..4f398e2ba374f27811afd2ccf6e72037d0f9ee7f 100644
> --- a/arch/arm/mach-snapdragon/qcom-priv.h
> +++ b/arch/arm/mach-snapdragon/qcom-priv.h
> @@ -8,19 +8,5 @@ void qcom_configure_capsule_updates(void);
>  #else
>  void qcom_configure_capsule_updates(void) {}
>  #endif /* EFI_HAVE_CAPSULE_SUPPORT */
>  
> -#if CONFIG_IS_ENABLED(OF_LIVE)
> -/**
> - * qcom_of_fixup_nodes() - Fixup Qualcomm DT nodes
> - *
> - * Adjusts nodes in the live tree to improve compatibility with U-Boot.
> - */
> -void qcom_of_fixup_nodes(void);
> -#else
> -static inline void qcom_of_fixup_nodes(void)
> -{
> -	log_debug("Unable to dynamically fixup USB nodes, please enable CONFIG_OF_LIVE\n");
> -}
> -#endif /* OF_LIVE */
> -
>  #endif /* __QCOM_PRIV_H__ */
> 
> -- 
> 2.49.0
> 
