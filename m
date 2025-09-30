Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D23CAC5B9
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 09:30:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EACF83045;
	Tue, 30 Sep 2025 11:30:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WyL4Gmy/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6830C8341C; Tue, 30 Sep 2025 11:30:31 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BD4A828A2
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 11:30:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 5AF106036C;
 Tue, 30 Sep 2025 09:30:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A99C4CEF0;
 Tue, 30 Sep 2025 09:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1759224628;
 bh=nchPuXCxJFPwhJOUY7nCDgglUbJay8W2V5FlwjaHJ9A=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=WyL4Gmy/fK7W1BfhERfgUs21wmLoPEnGjqyy0c3lO2o/73B6Z1jemEFdZHZpyT1Yh
 vJc2bs738IIusUMJgTawqToVpUSG6GKpTDE2LlL2sz3LQuMeYPGauBrA+TkB3GZDA6
 bQWmLtRlwrcN0Frq9OvHf2+bHY5xqzkEpkR8UfsjKV2581WCCwFMgjAkt0Y944FBQh
 lZC9V/5rOP6jggVjxnOX1Cv/AvAeZsKiwyi7l+o5htPz864k4RSStt0zsQ05te6CQr
 6Mbf9fp+91my0CsuvjzCjqtGJjmXy9EFTbq2HsTG30/vJroAOo/B3NEtgs0RtA0UPv
 y+F+MmMYaftiQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>
Subject: Re: [PATCH v2 5/5] usb: gadget: Tighten CI_UDC dependencies
In-Reply-To: <20250926153034.3680674-5-trini@konsulko.com>
References: <20250926153034.3680674-1-trini@konsulko.com>
 <20250926153034.3680674-5-trini@konsulko.com>
Date: Tue, 30 Sep 2025 11:30:25 +0200
Message-ID: <87ikh0i8y6.fsf@kernel.org>
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

> This driver cannot build when DM_USB_GADGET is enabled as both options
> control building of files that use the same global namespace and
> functionality. In this case make CI_UDC depend on DM_USB_GADGET being
> disabled as non-DM support is the legacy choice.
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
> index 9065e14768ad..9f817967a08b 100644
> --- a/drivers/usb/gadget/Kconfig
> +++ b/drivers/usb/gadget/Kconfig
> @@ -152,6 +152,7 @@ config USB_GADGET_OS_DESCRIPTORS
>  
>  config CI_UDC
>  	bool "ChipIdea device controller"
> +	depends on !DM_USB_GADGET
>  	select USB_GADGET_DUALSPEED
>  	help
>  	  Say Y here to enable device controller functionality of the
> -- 
> 2.43.0
