Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37E27C54E67
	for <u-boot@archiver.kernel.org>; Sun, 17 Mar 2024 11:26:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A925878AA;
	Sun, 17 Mar 2024 12:26:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="TsrkpRyr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06C6B8796B; Sun, 17 Mar 2024 12:26:52 +0100 (CET)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C77B08786A
 for <u-boot@lists.denx.de>; Sun, 17 Mar 2024 12:26:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ideasonboard.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=laurent.pinchart@ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi
 [81.175.209.231])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1CB8FD01;
 Sun, 17 Mar 2024 12:26:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1710674782;
 bh=wKDFDB0rPdripBXbTOEFn6ZgtLHBVryEp5Ab2b0koDk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TsrkpRyrsbssw0HatxKushLLEWuZxMr+ajrfVK46MU0LKK+qXU5yRHIJmKZVEUG+8
 KdR27zDC9UvrVJrIKLlYE6pt3z6BTpj/Jr9FISyRt5jdGEo0rUbjFGHoKeoM2XvASl
 10kYiyCRF605QGClLnArx8hYBgtApVyEB6uVhejc=
Date: Sun, 17 Mar 2024 13:26:45 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 2/3] boot: fdt: Drop lmb_alloc*() typecasts
Message-ID: <20240317112645.GF9082@pendragon.ideasonboard.com>
References: <20240317061730.654893-1-marek.vasut+renesas@mailbox.org>
 <20240317061730.654893-2-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240317061730.654893-2-marek.vasut+renesas@mailbox.org>
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

Hi Marek,

Thank you for the patch.

On Sun, Mar 17, 2024 at 07:16:30AM +0100, Marek Vasut wrote:
> The lmb_alloc_base() returns phys_addr_t , map_sysmem() accepts
> phys_addr_t as first parameter. Declare $addr as phys_addr_t and

s/$addr/addr/ ?

> get rid of the casts.
> 
> Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> ---
>  boot/image-fdt.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
> index c2571b22244..c37442c9130 100644
> --- a/boot/image-fdt.c
> +++ b/boot/image-fdt.c
> @@ -162,6 +162,7 @@ int boot_relocate_fdt(struct lmb *lmb, char **of_flat_tree, ulong *of_size)
>  	void	*of_start = NULL;
>  	phys_addr_t start, size, usable;
>  	char	*fdt_high;
> +	phys_addr_t addr;
>  	phys_addr_t low;
>  	phys_size_t mapsize;
>  	ulong	of_len = 0;
> @@ -186,7 +187,6 @@ int boot_relocate_fdt(struct lmb *lmb, char **of_flat_tree, ulong *of_size)
>  	fdt_high = env_get("fdt_high");
>  	if (fdt_high) {
>  		ulong desired_addr = hextoul(fdt_high, NULL);
> -		ulong addr;

I would keep addr declared here. With that,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  
>  		if (desired_addr == ~0UL) {
>  			/* All ones means use fdt in place */
> @@ -224,8 +224,8 @@ int boot_relocate_fdt(struct lmb *lmb, char **of_flat_tree, ulong *of_size)
>  			 * At least part of this DRAM bank is usable, try
>  			 * using it for LMB allocation.
>  			 */
> -			of_start = map_sysmem((ulong)lmb_alloc_base(lmb,
> -				    of_len, 0x1000, usable), of_len);
> +			addr = lmb_alloc_base(lmb, of_len, 0x1000, usable);
> +			of_start = map_sysmem(addr, of_len);
>  			/* Allocation succeeded, use this block. */
>  			if (of_start != NULL)
>  				break;

-- 
Regards,

Laurent Pinchart
