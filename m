Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D86C54E60
	for <u-boot@archiver.kernel.org>; Sun, 17 Mar 2024 11:29:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E56D387D87;
	Sun, 17 Mar 2024 12:29:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="nvzh+6jK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3329487DD5; Sun, 17 Mar 2024 12:29:08 +0100 (CET)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B8018786A
 for <u-boot@lists.denx.de>; Sun, 17 Mar 2024 12:29:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ideasonboard.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=laurent.pinchart@ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi
 [81.175.209.231])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9A44FD01;
 Sun, 17 Mar 2024 12:28:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1710674920;
 bh=zN4zAfvctklxVTPNfVwk0mw/Lzo3d9zrA7FiLSVOeM4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nvzh+6jK0k5Z8KLt7yrnVBISxn8cWyMQbFIzZFRiwRXMvovPUSnO0aGy6tjIudXZU
 Uwft1YqmuIlZ5gjOqSJs9WQ+ZVfSkBtknCyEvUv6v+wOaRg3qHKJwCiD9X5BV4eaZu
 Mw1q65KU3mtN+Gv5CLF6PS6emGZN6OdiaT58/GaA=
Date: Sun, 17 Mar 2024 13:29:03 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 3/3] boot: fdt: Move usable variable below updated comment
Message-ID: <20240317112903.GG9082@pendragon.ideasonboard.com>
References: <20240317061730.654893-1-marek.vasut+renesas@mailbox.org>
 <20240317061730.654893-3-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240317061730.654893-3-marek.vasut+renesas@mailbox.org>
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

On Sun, Mar 17, 2024 at 07:16:31AM +0100, Marek Vasut wrote:
> Move the variable below comment which explains what the variable means.
> Update the comment. No functional change.
> 
> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
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
> index c37442c9130..16cd15e7e44 100644
> --- a/boot/image-fdt.c
> +++ b/boot/image-fdt.c
> @@ -218,12 +218,12 @@ int boot_relocate_fdt(struct lmb *lmb, char **of_flat_tree, ulong *of_size)
>  			if (start + size < low)
>  				continue;
>  
> -			usable = min(start + size, low + mapsize);
> -
>  			/*
>  			 * At least part of this DRAM bank is usable, try
> -			 * using it for LMB allocation.
> +			 * using the the DRAM bank up to $usable address

s/the the/the/

Is it a u-boot convention to write $variable to refer to a variable in
comments ?

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +			 * limit for LMB allocation.
>  			 */
> +			usable = min(start + size, low + mapsize);
>  			addr = lmb_alloc_base(lmb, of_len, 0x1000, usable);
>  			of_start = map_sysmem(addr, of_len);
>  			/* Allocation succeeded, use this block. */

-- 
Regards,

Laurent Pinchart
