Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E1EAC54E58
	for <u-boot@archiver.kernel.org>; Mon, 18 Mar 2024 16:20:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A155587572;
	Mon, 18 Mar 2024 17:20:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="aVI4dfOu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 422458752B; Mon, 18 Mar 2024 17:20:54 +0100 (CET)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B03A87E47
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 17:20:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ideasonboard.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=laurent.pinchart@ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi
 [81.175.209.231])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 99B6FB1;
 Mon, 18 Mar 2024 17:20:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1710778825;
 bh=/Eqo/fyt3b+h9e47X35vZ606nRzaIatYpYFtCsGxtCM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aVI4dfOuVzSmDUfAbnAn79zFNJgvH8XxfTQZPQO9J2uq1M88vFQWHdvycfxKS93YT
 yN5kOv7XvPJoTzIoyHcqqiSREXaJj3pcq3Emb7edCyZZT6RhjtJ2W9B7UF4ZU4G59o
 6iEizP37fBZWSTwq8R+ohEQqsGIeKiZSBd3l72rE=
Date: Mon, 18 Mar 2024 18:20:49 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2 3/4] boot: fdt: Drop lmb_alloc*() typecasts
Message-ID: <20240318162049.GG13682@pendragon.ideasonboard.com>
References: <20240318150200.8178-1-marek.vasut+renesas@mailbox.org>
 <20240318150200.8178-3-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240318150200.8178-3-marek.vasut+renesas@mailbox.org>
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

On Mon, Mar 18, 2024 at 04:00:46PM +0100, Marek Vasut wrote:
> The lmb_alloc_base() returns phys_addr_t , map_sysmem() accepts
> phys_addr_t as first parameter. Declare 'addr' as phys_addr_t and
> get rid of the casts.
> 
> Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> ---
> V2: - Replace $addr with 'addr' to somehow delimit the variable name
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
