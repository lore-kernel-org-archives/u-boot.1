Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D618C677C4
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 06:39:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAD2A82B63;
	Wed, 11 Jun 2025 08:39:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1749623945;
	bh=hW+YsLOrXHfH5fm8vEuRdHnY3eIpdpYPE9KNgk/NzME=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k1rfGoGIjMALESlxU4tp27NENQYeaNZTTKCLI8b4duQc6aX6Vn0z7yKFgLMi5NGRB
	 sV8G1uoCmyhk9kbgnz/leSqKQFpgzC9ghIT2vqQwDf4GiDQBEF8OKJ2DoNmv9IVRTG
	 dtfUppFqnLpnlYJE3EsfIopxQ1Np6D30lSJkw18VLWZQ/2BE9AafwEHzu2uhb8uI5j
	 NzJUNzpDwPEUiL0yl1Tsy0zkEr9S1CAdVSEuXehJ0jm3z8jy9i+sjz/KRigYqE+gCx
	 gGuQgpNzRuX08NjBYLG9wwZ77erSnt4mLcR3U4tKqvCZTNEkWVOmKu8MllNniPzbns
	 ol4gB6SAz1mJw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E07882B7C; Wed, 11 Jun 2025 08:39:04 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [80.241.59.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1E1C82B20
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 08:39:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4bHGGF6Zg8z9scL;
 Wed, 11 Jun 2025 08:39:01 +0200 (CEST)
Message-ID: <6c01e259-6dd9-4c61-94d6-63320ada2e16@denx.de>
Date: Wed, 11 Jun 2025 08:38:57 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v4 1/2] clk: renesas: Handle CLK_TYPE_GEN4_MDSEL in
 gen3_clk_get_rate64()
To: smelamud@redhat.com, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de
References: <20250611-us-renesas-watchdog-v4-0-24f1da3e0dc9@redhat.com>
 <20250611-us-renesas-watchdog-v4-1-24f1da3e0dc9@redhat.com>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20250611-us-renesas-watchdog-v4-1-24f1da3e0dc9@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 11.06.25 02:25, Shmuel Leib Melamud via B4 Relay wrote:
> From: Shmuel Leib Melamud <smelamud@redhat.com>
> 
> Add support of CLK_TYPE_GEN4_MDSEL clock type to gen3_clk_get_rate64()
> function. In particular, this type of clock is used by Renesas R-Car
> Gen4 watchdog. It operates similarly to CLK_TYPE_GEN3_MDSEL clock.
> 
> Signed-off-by: Shmuel Leib Melamud <smelamud@redhat.com>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
>   drivers/clk/renesas/clk-rcar-gen3.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/renesas/clk-rcar-gen3.c b/drivers/clk/renesas/clk-rcar-gen3.c
> index 375cc4a4930873ad0d5509c19ad04a0ea5545aa0..5745acf4023c9114f6fa13b5e4baa306c5b57d33 100644
> --- a/drivers/clk/renesas/clk-rcar-gen3.c
> +++ b/drivers/clk/renesas/clk-rcar-gen3.c
> @@ -68,7 +68,7 @@ static int gen3_clk_get_parent(struct gen3_clk_priv *priv, struct clk *clk,
>   		if (ret)
>   			return ret;
>   
> -		if (core->type == CLK_TYPE_GEN3_MDSEL) {
> +		if (core->type == CLK_TYPE_GEN3_MDSEL || core->type == CLK_TYPE_GEN4_MDSEL) {
>   			shift = priv->cpg_mode & BIT(core->offset) ? 0 : 16;
>   			parent->dev = clk->dev;
>   			parent->id = core->parent >> shift;
> @@ -318,6 +318,8 @@ static u64 gen3_clk_get_rate64(struct clk *clk)
>   						"FIXED");
>   
>   	case CLK_TYPE_GEN3_MDSEL:
> +		fallthrough;
> +	case CLK_TYPE_GEN4_MDSEL:
>   		shift = priv->cpg_mode & BIT(core->offset) ? 0 : 16;
>   		div = (core->div >> shift) & 0xffff;
>   		rate = gen3_clk_get_rate64(&parent) / div;
> 

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de

