Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA7BCC4345F
	for <u-boot@archiver.kernel.org>; Sun, 14 Apr 2024 19:29:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC04788124;
	Sun, 14 Apr 2024 21:29:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ujOJ6i97";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9724988131; Sun, 14 Apr 2024 21:29:16 +0200 (CEST)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8C2A88125
 for <u-boot@lists.denx.de>; Sun, 14 Apr 2024 21:29:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ideasonboard.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=laurent.pinchart@ideasonboard.com
Received: from pendragon.ideasonboard.com
 (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4FBB6512;
 Sun, 14 Apr 2024 21:28:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1713122908;
 bh=HCwoylvPVYj+eW/MgoPbwz/e2K4gVkjCDv+x7G2rzZY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ujOJ6i97SquBYvgOVuYl9n/idB2+z+/2xUpY/E/mZwMvKyuVPlouFyN7rGrtityrq
 9DAcEJw65vEQu97VXW7YUSGC0Cq+kFTTeEQ/4gUZVyvOXCfKTd54cj1MEJr5u849Od
 j3uCY1fq5YhcYkx4DUrhMk+BpsQ39TiM1WcDeRlk=
Date: Sun, 14 Apr 2024 22:29:04 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] boot: fdt: Turn all addresses and sizes into u64
Message-ID: <20240414192904.GA7117@pendragon.ideasonboard.com>
References: <20240414183759.146925-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240414183759.146925-1-marex@denx.de>
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

On Sun, Apr 14, 2024 at 08:37:20PM +0200, Marek Vasut wrote:
> In case of systems where DRAM bank ends at the edge of 32bit boundary,
> start + size calculations would overflow. This happens on STM32MP15xx
> with 1 DRAM bank starting at 0xc0000000 and 1 GiB of DRAM. This is a
> usual 32bit system DRAM size overflow, fix it by doing all DRAM size
> and offset calculations using u64 types.

I'm not sure I like this much, as it removes a useful indication
regarding what the variables store. Wouldn't it be better if the code's
logic could be modified to avoid those overflows ?

> This also covers a case where
> a 32bit PAE system might be able to address up to 36bits of DRAM.

Shouldn't phys_addr_t be a 64-bit type on PAE systems ?

> Fixes: a4df06e41fa2 ("boot: fdt: Change type of env_get_bootm_low() to phys_addr_t")
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> ---
>  boot/image-fdt.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
> index 2b92bdaff16..f09716cba30 100644
> --- a/boot/image-fdt.c
> +++ b/boot/image-fdt.c
> @@ -158,13 +158,10 @@ void boot_fdt_add_mem_rsv_regions(struct lmb *lmb, void *fdt_blob)
>   */
>  int boot_relocate_fdt(struct lmb *lmb, char **of_flat_tree, ulong *of_size)
>  {
> +	u64	start, size, usable, addr, low, mapsize;
>  	void	*fdt_blob = *of_flat_tree;
>  	void	*of_start = NULL;
> -	phys_addr_t start, size, usable;
>  	char	*fdt_high;
> -	phys_addr_t addr;
> -	phys_addr_t low;
> -	phys_size_t mapsize;
>  	ulong	of_len = 0;
>  	int	bank;
>  	int	err;

-- 
Regards,

Laurent Pinchart
