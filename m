Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA14CAC5B9
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 09:28:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8119183045;
	Tue, 30 Sep 2025 11:28:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AwkDqhCk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D27983071; Tue, 30 Sep 2025 11:28:44 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30F29828A2
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 11:28:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 03C8D627DB;
 Tue, 30 Sep 2025 09:28:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61885C4CEF0;
 Tue, 30 Sep 2025 09:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1759224520;
 bh=1kRP/pL1dTYgb62X4zPPvn4J0T327xepvIEKsOBTvaA=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=AwkDqhCkuMTU7NeCFY8vzJV43I4BCruPC1Rz0dblSv8ilDgUhJuFSvFavvgp3kiiK
 UejUNwoAnrpRF8wdG8UHC8JytUB2z4ONwB1OY3a8xTNFwnawfmJQLFmyiZmQU84UER
 YWzlFoGc37ZbJ3+0JTL+fUIcscDsdK0rtai1RwvPxs6T2IDA8Hrn2lW5+JPb4e34UX
 eTQ+Q0IfC6vvF9ShgLiPe0FWHtXTvQeCgqB+FL5vjq5e9uMxtwKlpuz7QPp8GhouXo
 YHcEa93gdpL7cRjWExIxgxgx+a2lPKNmFGt1O0+q5HKIyE6dcTHqPrTZYCRcM3SJ46
 d/+FEK/CijS0g==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>
Subject: Re: [PATCH v2 3/5] usb: gadget: Tighten the dependency for DWC2 OTG
 support
In-Reply-To: <20250926153034.3680674-3-trini@konsulko.com>
References: <20250926153034.3680674-1-trini@konsulko.com>
 <20250926153034.3680674-3-trini@konsulko.com>
Date: Tue, 30 Sep 2025 11:28:38 +0200
Message-ID: <87ldlwi915.fsf@kernel.org>
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

Hi Tom,

Thank you for the patch.

On Fri, Sep 26, 2025 at 09:30, Tom Rini <trini@konsulko.com> wrote:

> The DWC2 OTG driver depends on an ARM-specific header file to compile,
> so make it depend on ARM.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
> Changes in v2:
> - None
>
> Cc: Marek Vasut <marek.vasut@mailbox.org>
> ---
>  drivers/usb/gadget/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
> index 0121f9872ae6..9065e14768ad 100644
> --- a/drivers/usb/gadget/Kconfig
> +++ b/drivers/usb/gadget/Kconfig
> @@ -109,6 +109,7 @@ config USB_GADGET_AT91
>  
>  config USB_GADGET_DWC2_OTG
>  	bool "DesignWare USB2.0 HS OTG controller (gadget mode)"
> +	depends on ARM
>  	select USB_GADGET_DUALSPEED
>  	help
>  	  The Designware USB2.0 high-speed gadget controller
> -- 
> 2.43.0
