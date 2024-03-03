Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 771FFC48BF6
	for <u-boot@archiver.kernel.org>; Sun,  3 Mar 2024 21:26:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7019387EB3;
	Sun,  3 Mar 2024 22:26:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="bBeaOcHT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C16687EEA; Sun,  3 Mar 2024 22:26:50 +0100 (CET)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C918A87D5E
 for <u-boot@lists.denx.de>; Sun,  3 Mar 2024 22:26:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ideasonboard.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=laurent.pinchart@ideasonboard.com
Received: from pendragon.ideasonboard.com (89-27-53-110.bb.dnainternet.fi
 [89.27.53.110])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 53F029D5;
 Sun,  3 Mar 2024 22:26:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1709501190;
 bh=3oOp+W7sJpUDLi3obPFHcoRzrTMiszreNUbX3gx9csU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bBeaOcHTauVeVeBU1Bdl6T1NEt2+x83GXv4qJ3hsvGecPrOYX+ttv9v4SMlbYhEH0
 m1pAQrF6fHXa9fMFmmwTUJtNqse85mxSoPyzqpTtkH2tGJb/XhKWGkl30okhC9Ux1k
 Ca34T5aX3+e5uUqEY8ZNxlKJ0h9m9YxXGQoEdGeo=
Date: Sun, 3 Mar 2024 23:26:48 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Geert Uytterhoeven <geert@linux-m68k.org>,
 Hans Verkuil <hverkuil-cisco@xs4all.nl>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Wolfram Sang <wsa@kernel.org>
Subject: Re: [PATCH] fdt: Fix bootm_low handling
Message-ID: <20240303212648.GD11285@pendragon.ideasonboard.com>
References: <20240302225527.179601-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240302225527.179601-1-marek.vasut+renesas@mailbox.org>
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

On Sat, Mar 02, 2024 at 11:54:02PM +0100, Marek Vasut wrote:
> According to README CFG_SYS_BOOTMAPSZ section, in case both "bootm_low" and
> "bootm_size" variables are defined, "bootm_mapsize" variable is not defined
> and CFG_SYS_BOOTMAPSZ macro is not defined, all data for the Linux kernel
> must be between "bootm_low" and "bootm_low" + "bootm_size".
> 
> Currently, for systems with DRAM between 0x4000_0000..0x7fff_ffff and with
> e.g. bootm_low=0x60000000 and bootm_size=0x10000000, the code will attempt
> to reserve memory from 0x4000_0000..0x4fff_ffff, which is incorrect. This
> is because "bootm_low" is not taken into consideration correctly.
> 
> The last parameter of lmb_alloc_base() is the maximum physical address of
> the to be reserved LMB area. Currently this is the start of DRAM bank that
> is considered for LMB area reservation + min(DRAM bank size, bootm_size).
> In case bootm_low is set to non-zero, this maximum physical address has to
> be shifted upward, to min(DRAM bank start + size, bootm_low + bootm_size),
> otherwise the reserved memory may be below bootm_low address.
> 
> In case of multiple DRAM banks, the current change reserves top part of
> the first bank, and reserves the rest of memory in the follow up banks.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Niklas Söderlund <niklas.soderlund@ragnatech.se>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Wolfram Sang <wsa@kernel.org>
> ---
>  boot/image-fdt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
> index 75bdd55f326..5e4aa9de0d2 100644
> --- a/boot/image-fdt.c
> +++ b/boot/image-fdt.c
> @@ -217,14 +217,14 @@ int boot_relocate_fdt(struct lmb *lmb, char **of_flat_tree, ulong *of_size)
>  			if (start + size < low)
>  				continue;
>  
> -			usable = min(size, (u64)mapsize);
> +			usable = min(start + size, (u64)(low + mapsize));

low and mapsize are ulong, is there a risk this could overflow on 32-bit
platforms ?

I would rename usable to usable_end to make it clearer.

>  
>  			/*
>  			 * At least part of this DRAM bank is usable, try
>  			 * using it for LMB allocation.
>  			 */
>  			of_start = map_sysmem((ulong)lmb_alloc_base(lmb,
> -				    of_len, 0x1000, start + usable), of_len);
> +				    of_len, 0x1000, usable), of_len);
>  			/* Allocation succeeded, use this block. */
>  			if (of_start != NULL)
>  				break;

The code continue with

			/*
			 * Reduce the mapping size in the next bank
			 * by the size of attempt in current bank.
			 */
			mapsize -= usable - max(start, (u64)low);
			if (!mapsize)
				break;

which seems to be correct now, but interestingly was not before :-)

-- 
Regards,

Laurent Pinchart
