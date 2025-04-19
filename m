Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C2CAC369BD
	for <u-boot@archiver.kernel.org>; Sat, 19 Apr 2025 09:14:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 807E981F4D;
	Sat, 19 Apr 2025 11:14:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=riseup.net header.i=@riseup.net header.b="GBiJHJMW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A356182A7B; Sat, 19 Apr 2025 11:14:16 +0200 (CEST)
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8597A80107
 for <u-boot@lists.denx.de>; Sat, 19 Apr 2025 11:14:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danct12@riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx1.riseup.net (Postfix) with ESMTPS id 4ZfmCX4gVtzDqbR;
 Sat, 19 Apr 2025 09:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1745054051; bh=6uv9FdQeXhdkcmAkduZVUtfFqRDNapE8vCAyvO2IH2o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GBiJHJMWXssYfpAJy4VRupDCFlta00NDsb0PH5kG9cFoUAYNjpcwhkZfV7NZJLGek
 4f7XYCsd0wjFXh3w9YM/vKsqIbSoiuMoBg/2SAMSWBSZI6bRSyEsCvBeHYvDVbzwYF
 qKp6GNWa1fQBzkoVgUTdBliMZOyULrfPQfwnwGuc=
X-Riseup-User-ID: 55B0CE3A98C43AAB379F177AEE53E7D7FB91EF794BB437CD97CFC794D874FD9B
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4ZfmCV0ssKzJmtR;
 Sat, 19 Apr 2025 09:13:57 +0000 (UTC)
Date: Sat, 19 Apr 2025 16:13:54 +0700
From: Dang Huynh <danct12@riseup.net>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] clk: Fix clk_set_parent() regression
Message-ID: <aANpUmJ7rssCtkCL@melt-pi5>
References: <20250419090718.2469756-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250419090718.2469756-1-jonas@kwiboo.se>
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

Hi Jonas,

Tested on PineTab 2 (RK3566) and this got rid of "Cannot enable parent"
errors.

Tested-by: Dang Huynh <danct12@riseup.net>

On Sat, Apr 19, 2025 at 09:07:16AM +0000, Jonas Karlman wrote:
> The commit ac30d90f3367 ("clk: Ensure the parent clocks are enabled
> while reparenting") add a call to clk_enable() for the parent clock.
> 
> For clock drivers that do not implement the enable() ops, like most
> Rockchip clock drivers, this now cause the set_parent() ops to never
> be called when CLK_CCF=n (default for Rockchip).
> 
> clk_enable() typically return -NOSYS when the enable() ops is not
> implemented by the clock driver, with CLK_CCF=y clk_enable() instead
> return 0 when the enable() ops is unimplemented.
> 
> Change to ignore -NOSYS from the newly introduced clk_enable() call to
> fix this regression and restore the old behavior of set_parent() ops
> being called regardless of if enable() ops is implemented or not.
> 
> Fixes: ac30d90f3367 ("clk: Ensure the parent clocks are enabled while reparenting")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  drivers/clk/clk-uclass.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
> index 4b3d812f9c65..93dd32ebe74d 100644
> --- a/drivers/clk/clk-uclass.c
> +++ b/drivers/clk/clk-uclass.c
> @@ -624,7 +624,7 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
>  		return -ENOSYS;
>  
>  	ret = clk_enable(parent);
> -	if (ret) {
> +	if (ret && ret != -ENOSYS) {
>  		printf("Cannot enable parent %s\n", parent->dev->name);
>  		return ret;
>  	}
> -- 
> 2.49.0
> 
