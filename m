Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BBD6C54E6A
	for <u-boot@archiver.kernel.org>; Mon, 18 Mar 2024 16:18:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C90D187F63;
	Mon, 18 Mar 2024 17:18:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="FOBeqZ5P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7969787E89; Mon, 18 Mar 2024 17:18:18 +0100 (CET)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C2B6875E9
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 17:18:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ideasonboard.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=laurent.pinchart@ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi
 [81.175.209.231])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5FBE6B1;
 Mon, 18 Mar 2024 17:17:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1710778669;
 bh=HChWHMyh7COZ6+2SL6GzYefW5qFIwF4vCdZShnOD1L0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FOBeqZ5P8JnstjFvYqnSCtLND7cI35p/0cC7on6Oo9NTC33zDfgNuFqKJep5mEPHS
 Xm6n2sogjfJS9M4Nrnbe1iaXYzIOpuIVXmbETN1SrU/dMay4oadj+iM4erJc4wgbvS
 /tOhJMPRhowqzRqb8Dj8xTaww/Bpqat9Ie52/kI4=
Date: Mon, 18 Mar 2024 18:18:13 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2 2/4] boot: fdt: Clean up env_get_bootm_size()
Message-ID: <20240318161813.GF13682@pendragon.ideasonboard.com>
References: <20240318150200.8178-1-marek.vasut+renesas@mailbox.org>
 <20240318150200.8178-2-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240318150200.8178-2-marek.vasut+renesas@mailbox.org>
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

On Mon, Mar 18, 2024 at 04:00:45PM +0100, Marek Vasut wrote:
> Clean up tmp variable use and type cast in env_get_bootm_size().
> No functional change.

The code change looks fine, but you may want to expand the commit
message to explain why this patch improves the code.

> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> ---
> V2: - New patch
> ---
>  boot/image-board.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/boot/image-board.c b/boot/image-board.c
> index 3263497a1d5..e3d63745299 100644
> --- a/boot/image-board.c
> +++ b/boot/image-board.c
> @@ -129,10 +129,8 @@ phys_size_t env_get_bootm_size(void)
>  	phys_addr_t start;
>  	char *s = env_get("bootm_size");
>  
> -	if (s) {
> -		tmp = (phys_size_t)simple_strtoull(s, NULL, 16);
> -		return tmp;
> -	}
> +	if (s)
> +		return simple_strtoull(s, NULL, 16);
>  
>  	start = gd->ram_base;
>  	size = gd->ram_size;
> @@ -142,7 +140,7 @@ phys_size_t env_get_bootm_size(void)
>  
>  	s = env_get("bootm_low");
>  	if (s)
> -		tmp = (phys_size_t)simple_strtoull(s, NULL, 16);
> +		tmp = simple_strtoull(s, NULL, 16);
>  	else
>  		tmp = start;
>  

Maybe you could even drop the tmp variable completely by writing this

	if (s)
		size -= simple_strtoull(s, NULL, 16) - start;

	return size;

I've never liked variables named tmp :-)

-- 
Regards,

Laurent Pinchart
