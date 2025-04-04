Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF986C36010
	for <u-boot@archiver.kernel.org>; Fri,  4 Apr 2025 06:12:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12FD8828BC;
	Fri,  4 Apr 2025 08:12:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PSfJuLbr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD706828D0; Fri,  4 Apr 2025 08:12:48 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 556628283E
 for <u-boot@lists.denx.de>; Fri,  4 Apr 2025 08:12:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id F32234404D;
 Fri,  4 Apr 2025 06:12:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35CF7C4CEDD;
 Fri,  4 Apr 2025 06:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1743747163;
 bh=m9utFx9gDH/AvARBpMXQBEJ3mfES4Cu7kaH3PAB6GF0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PSfJuLbrOEDqGAn9yLKSC1hiicvVw74L8xOLbeaABtD0pRmW/ftKMgfZwvbV267wL
 /FcKhTehKhhlVwP9ScOVNPYADhnN9e6fVuiZbiPDeyGLjiYz1eDEiA5kijHry4Zfo8
 yQiTVGmZ8BZxel8quRelPPayrWXxX4iF+qBTEx65C41YEl4lA3SHAvXPzvIfPyJ3c7
 Q1BYM868whbgwwtkxXkxQswcHh8sbfbrClwmMb0tf9/NlmXMuZCCr+auaADykfdKWV
 KArn/RCR+nT01qNI3e2SIIyj3P/hNDCZkvb9rEX4xcBy9u6SUV5EehbbHzZ1Lg/SZg
 3qQ8gBtAMK8AQ==
Date: Fri, 4 Apr 2025 11:42:37 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH] hmibsc_defconfig: disable DM_USB_GADGET
Message-ID: <Z-94VXb10MM_SV6e@sumit-X1>
References: <20250402142812.368168-1-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402142812.368168-1-caleb.connolly@linaro.org>
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

On Wed, Apr 02, 2025 at 04:28:03PM +0200, Caleb Connolly wrote:
> As with the db410c this breaks linking as it conflicts with the USB
> controller used by these platforms.
> 
> This fixes building after DM_USB_GADGET was enabled by default for
> mach-snapdragon.
> 
> Fixes: 7235dbedfce3 (mach-snapdragon: enable DM_USB_GADGET by default)
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  configs/hmibsc_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> diff --git a/configs/hmibsc_defconfig b/configs/hmibsc_defconfig
> index 88c9c70a6399..4550eba71ab2 100644
> --- a/configs/hmibsc_defconfig
> +++ b/configs/hmibsc_defconfig
> @@ -69,8 +69,9 @@ CONFIG_DM_PMIC=y
>  CONFIG_PMIC_QCOM=y
>  CONFIG_MSM_SERIAL=y
>  CONFIG_SPMI_MSM=y
>  CONFIG_USB=y
> +# CONFIG_DM_USB_GADGET is not set
>  CONFIG_USB_EHCI_HCD=y
>  CONFIG_USB_EHCI_MSM=y
>  CONFIG_USB_ULPI_VIEWPORT=y
>  CONFIG_USB_ULPI=y
> -- 
> 2.48.1
> 
