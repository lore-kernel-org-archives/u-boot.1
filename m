Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 566CDD10BEC
	for <u-boot@archiver.kernel.org>; Sat, 26 Oct 2024 09:10:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 796D088F4A;
	Sat, 26 Oct 2024 11:10:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5609388F68; Sat, 26 Oct 2024 11:10:07 +0200 (CEST)
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
 by phobos.denx.de (Postfix) with ESMTP id 721BA88F4A
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 11:10:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=macro@orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
 id 1EA8492009C; Sat, 26 Oct 2024 11:10:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by angie.orcam.me.uk (Postfix) with ESMTP id 19EA392009B;
 Sat, 26 Oct 2024 10:10:05 +0100 (BST)
Date: Sat, 26 Oct 2024 10:10:05 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Tom Rini <trini@konsulko.com>
cc: u-boot@lists.denx.de
Subject: Re: [PATCH] Kconfig: Remove TARGET_TRICORDER references
In-Reply-To: <20241026040747.1657322-1-trini@konsulko.com>
Message-ID: <alpine.DEB.2.21.2410261009270.40463@angie.orcam.me.uk>
References: <20241026040747.1657322-1-trini@konsulko.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Fri, 25 Oct 2024, Tom Rini wrote:

> diff --git a/boot/Kconfig b/boot/Kconfig
> index b9287c606856..ba77130449a3 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -234,7 +234,7 @@ config SPL_LOAD_FIT_ADDRESS
>  	hex "load address of fit image"
>  	depends on SPL_LOAD_FIT
>  	default 0x44000000 if ARCH_IMX8M
> -	default 0x0
> +	default SYS_LOAD_ADDR

 This seems unrelated, are you sure?

  Maciej
