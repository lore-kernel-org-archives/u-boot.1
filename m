Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97705C36010
	for <u-boot@archiver.kernel.org>; Sat,  5 Apr 2025 03:28:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6D8F82991;
	Sat,  5 Apr 2025 05:28:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="KTkSNSVh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21809829C3; Sat,  5 Apr 2025 05:28:44 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6ECC828D0
 for <u-boot@lists.denx.de>; Sat,  5 Apr 2025 05:28:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 5D0522600B;
 Sat,  5 Apr 2025 05:28:41 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F7fWknhJeNsd; Sat,  5 Apr 2025 05:28:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1743823720; bh=sOHZI/irgDboqSdsmuJTeVB2YpkaVZESu1Why7wDVsY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=KTkSNSVhlIqpiD6HQYyl3xUxQTzqnrWTAqALG0fSiXEobFsghy5rKC2y4T86QPEDC
 XIZup24M/V07WnDSnDnPKu8AUjTHmcEJYpvUQ98f5RQWwXzo0xZzcJKpzfUL1eSYr0
 LpHVatMQIUQl9duQaHiO1uP2AlOfQGLYG0/SIHrkVEsxMwrHXyiMN7kYpdBl6qqhWM
 lxHO5EBChzPpgc8HZavJ88J4N1iURSio54aY05OrE3XXC6vYh7OSKQjfpUqbLFZyIl
 YKy4J2NQFGdQ883a3hhhrQOxSJ6zvpCwIKojJY5zCDOqP45jc/EtwcgJxrHgIUkzo+
 iToyujkkxHpmQ==
Date: Sat, 5 Apr 2025 03:28:15 +0000
From: Yao Zi <ziyao@disroot.org>
To: Mayuresh Chitale <mchitale@ventanamicro.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Maxim Moskalets <maximmosk4@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Julien Masson <jmasson@baylibre.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Paul HENRYS <paul.henrys_ext@softathome.com>
Subject: Re: [PATCH v2 1/3] riscv: image: Add new image type for RV64
Message-ID: <Z_CjTyXaVrpUOPnJ@pie.lan>
References: <20250404144859.112313-1-mchitale@ventanamicro.com>
 <20250404144859.112313-2-mchitale@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250404144859.112313-2-mchitale@ventanamicro.com>
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

On Fri, Apr 04, 2025 at 02:48:55PM +0000, Mayuresh Chitale wrote:
> Similar to ARM and X86, introduce a new image type which allows u-boot
> to distinguish between images built for 32-bit vs 64-bit Risc-V CPUs.
> 
> Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> Reviewed-by: Maxim Moskalets <maximmosk4@gmail.com>
> ---
>  boot/image.c    | 3 ++-
>  include/image.h | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/boot/image.c b/boot/image.c
> index 139c5bd035a..45299a7dc33 100644
> --- a/boot/image.c
> +++ b/boot/image.c
> @@ -92,7 +92,8 @@ static const table_entry_t uimage_arch[] = {
>  	{	IH_ARCH_ARC,		"arc",		"ARC",		},
>  	{	IH_ARCH_X86_64,		"x86_64",	"AMD x86_64",	},
>  	{	IH_ARCH_XTENSA,		"xtensa",	"Xtensa",	},
> -	{	IH_ARCH_RISCV,		"riscv",	"RISC-V",	},
> +	{	IH_ARCH_RISCV,		"riscv",	"RISC-V 32 Bit",},
> +	{	IH_ARCH_RISCV64,	"riscv64",	"RISC-V 64 Bit",},
>  	{	-1,			"",		"",		},
>  };
>  
> diff --git a/include/image.h b/include/image.h
> index 07912606f33..411bfcd0877 100644
> --- a/include/image.h
> +++ b/include/image.h
> @@ -138,7 +138,8 @@ enum {
>  	IH_ARCH_ARC,			/* Synopsys DesignWare ARC */
>  	IH_ARCH_X86_64,			/* AMD x86_64, Intel and Via */
>  	IH_ARCH_XTENSA,			/* Xtensa	*/
> -	IH_ARCH_RISCV,			/* RISC-V */
> +	IH_ARCH_RISCV,			/* RISC-V 32 bit*/

I'll consider IH_ARCH_RISCV32 a better idea, instead of implying 32bit
when no suffix attached. We (and the Linux kernel) mix 32-bit and 64-bit
variants of RISC-V together, thus it's hard to tell the exact bitwidth
of "IH_ARCH_RISCV" without inspecting the code around. To me, it sounds
more like "RISC-V, but no bitwidth specified".

It will be nice if we could avoid this kind of ambiguity.

> +	IH_ARCH_RISCV64,		/* RISC-V 64 bit*/
>  	IH_ARCH_COUNT,
>  };
> -- 
> 2.43.0
> 

Thanks,
Yao Zi
