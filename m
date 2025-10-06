Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 274F0CCA471
	for <u-boot@archiver.kernel.org>; Mon,  6 Oct 2025 07:41:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9500B8206E;
	Mon,  6 Oct 2025 09:41:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VTmLintB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2041982FC7; Mon,  6 Oct 2025 09:41:24 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C046F807B1
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 09:41:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 1A77445120;
 Mon,  6 Oct 2025 07:41:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F79FC4CEF5;
 Mon,  6 Oct 2025 07:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1759736480;
 bh=sjvwOwKmkcDffjcTas2K4AZWKZiNZDA3iLE4txaYADc=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=VTmLintBan1RfOOwUhTtFGdQwbEouxy9B7fvioV3Fy8k+MIYlDAOsFYa41wPJOWSG
 QZTtUq6VadV3l4pHnCObYlZwKvojn+Z2TebZ+rOHMI2i31OsTqsbrzVMoJ2auN6icJ
 LiuASDEXa72SizOiHWL5uw1gYhPUGUEzPqfa3nw3+Cd+g1LII2jQLsR7qF5Ju+nzPW
 l26wf68co6ySMoU3Ff12i1MWjSbgl2QMfDvRkQKEDsyNFjM08ssnfNIzhqqSb4RtzI
 tH/lUHTAXCM9mH3NnqShFaI9GJiyZxos/VrSLzYy4p4+7QviiNWSHSU5Q+ZLDMjKu/
 RE24DZ5k7Q6jQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, Marek Vasut
 <marek.vasut@mailbox.org>
Subject: Re: [PATCH] usb: gadget: spl: Add missing dependency for
 SPL_USB_GADGET
In-Reply-To: <20251003203922.1029989-1-trini@konsulko.com>
References: <20251003203922.1029989-1-trini@konsulko.com>
Date: Mon, 06 Oct 2025 09:41:17 +0200
Message-ID: <87ikgswk82.fsf@kernel.org>
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

On Fri, Oct 03, 2025 at 14:39, Tom Rini <trini@konsulko.com> wrote:

> It makes no sense to ask about nor enable SPL_USB_GADGET without
> SPL_FRAMEWORK being enabled. Attempting to do so leads to Kconfig noting
> dependency issues. Add the missing dependency.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
> Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Cc: Marek Vasut <marek.vasut@mailbox.org>
> ---
>  drivers/usb/gadget/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
> index 882f082c9cdb..056eff4d942e 100644
> --- a/drivers/usb/gadget/Kconfig
> +++ b/drivers/usb/gadget/Kconfig
> @@ -39,6 +39,7 @@ menuconfig USB_GADGET
>  
>  config SPL_USB_GADGET
>  	bool "USB Gadget Support in SPL"
> +	depends on SPL_FRAMEWORK
>  	help
>  	  Enable USB Gadget API which allows to enable USB device functions
>  	  in SPL.
> -- 
> 2.43.0
