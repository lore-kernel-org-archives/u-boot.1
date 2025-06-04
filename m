Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA21C5B555
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 08:39:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2079481FEE;
	Wed,  4 Jun 2025 10:39:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cUhkYGVy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0564B82B07; Wed,  4 Jun 2025 10:39:37 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84D7081E72
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 10:39:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B906E44EDF;
 Wed,  4 Jun 2025 08:39:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29221C4CEED;
 Wed,  4 Jun 2025 08:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1749026372;
 bh=G0gnWJy2YQETzA9i/45hJpNqJoVc+L4WIaj12Rbr1mM=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=cUhkYGVyqdZoyeGNLHwHQXsoi0+rp+ZwwAbSltftAn1d+5n4nUq85PHCDWDc4km2u
 +Dm5uuNJUsQ/vtlT1sUvojB6A4roHoe0/O7iCOwsM6meeDMhW1qT/LeXiARd0pfEiF
 iHPfSSQ9iEWwt9MjMzAWKIsnZnWtcelky+F6F5LRjtdYn+i1FjGKRQElp2aeK2Z7Xn
 u7Spt90lJE+3ZqVIFaGmQ6ViyEA9NP3dA6KAoGYMx4VcjE5DfLIHO+UYcdyn+XgQ6K
 zokvpMgMrKU/lAkQzTkCOulWUFTuv3hH8SnSPgldrozZ/kmbVFa57QpPyLUR3B5pEI
 OvfVjLypAtRQw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Shmuel Leib Melamud via B4 Relay
 <devnull+smelamud.redhat.com@kernel.org>, Nobuhiro Iwamatsu
 <iwamatsu@nigauri.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Tom
 Rini <trini@konsulko.com>, Stefan Roese <sr@denx.de>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de, Shmuel Leib Melamud <smelamud@redhat.com>
Subject: Re: [PATCH v3 1/2] renesas: Handle CLK_TYPE_GEN4_MDSEL in
 gen3_clk_get_rate64()
In-Reply-To: <20250603-us-renesas-watchdog-v3-1-af3a65afd03e@redhat.com>
References: <20250603-us-renesas-watchdog-v3-0-af3a65afd03e@redhat.com>
 <20250603-us-renesas-watchdog-v3-1-af3a65afd03e@redhat.com>
Date: Wed, 04 Jun 2025 10:39:29 +0200
Message-ID: <87frgfuchq.fsf@kernel.org>
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

Hi Shmuel,

Thank you for the patch.

On Tue, Jun 03, 2025 at 06:06, Shmuel Leib Melamud via B4 Relay <devnull+smelamud.redhat.com@kernel.org> wrote:

> From: Shmuel Leib Melamud <smelamud@redhat.com>
>
> Add support of CLK_TYPE_GEN4_MDSEL clock type to gen3_clk_get_rate64()
> function. In particular, this type of clock is used by Renesas R-Car
> Gen4 watchdog. It operates similarly to CLK_TYPE_GEN3_MDSEL clock.
>
> Signed-off-by: Shmuel Leib Melamud <smelamud@redhat.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

nitpick: for a future submission, consider looking at the commit title
for a particular file to have the same subject.

$ git log --oneline -- drivers/clk/renesas/clk-rcar-gen3.c

Shows that most titles start with "clk: renesas", not "renesas:"

> ---
>  drivers/clk/renesas/clk-rcar-gen3.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/renesas/clk-rcar-gen3.c b/drivers/clk/renesas/clk-rcar-gen3.c
> index 375cc4a4930873ad0d5509c19ad04a0ea5545aa0..5745acf4023c9114f6fa13b5e4baa306c5b57d33 100644
> --- a/drivers/clk/renesas/clk-rcar-gen3.c
> +++ b/drivers/clk/renesas/clk-rcar-gen3.c
> @@ -68,7 +68,7 @@ static int gen3_clk_get_parent(struct gen3_clk_priv *priv, struct clk *clk,
>  		if (ret)
>  			return ret;
>  
> -		if (core->type == CLK_TYPE_GEN3_MDSEL) {
> +		if (core->type == CLK_TYPE_GEN3_MDSEL || core->type == CLK_TYPE_GEN4_MDSEL) {
>  			shift = priv->cpg_mode & BIT(core->offset) ? 0 : 16;
>  			parent->dev = clk->dev;
>  			parent->id = core->parent >> shift;
> @@ -318,6 +318,8 @@ static u64 gen3_clk_get_rate64(struct clk *clk)
>  						"FIXED");
>  
>  	case CLK_TYPE_GEN3_MDSEL:
> +		fallthrough;
> +	case CLK_TYPE_GEN4_MDSEL:
>  		shift = priv->cpg_mode & BIT(core->offset) ? 0 : 16;
>  		div = (core->div >> shift) & 0xffff;
>  		rate = gen3_clk_get_rate64(&parent) / div;
>
> -- 
> 2.49.0
