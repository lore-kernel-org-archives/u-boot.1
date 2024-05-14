Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70922C04FFE
	for <u-boot@archiver.kernel.org>; Tue, 14 May 2024 10:28:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C33BB882C4;
	Tue, 14 May 2024 12:28:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01D0D882D5; Tue, 14 May 2024 12:28:00 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 0C2A9882C4
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 12:27:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D4F81007;
 Tue, 14 May 2024 03:28:22 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1876E3F762;
 Tue, 14 May 2024 03:27:55 -0700 (PDT)
Date: Tue, 14 May 2024 11:27:53 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Michael Walle <mwalle@kernel.org>
Cc: Jagan Teki <jagan@amarulasolutions.com>, Lukasz Majewski
 <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Tom Rini
 <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Samuel Holland <samuel@sholland.org>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 2/2] net: sun8i_emac: add support for the V3s
Message-ID: <20240514112753.0d30484d@donnerap.manchester.arm.com>
In-Reply-To: <20240513205609.1872861-3-mwalle@kernel.org>
References: <20240513205609.1872861-1-mwalle@kernel.org>
 <20240513205609.1872861-3-mwalle@kernel.org>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Mon, 13 May 2024 22:56:09 +0200
Michael Walle <mwalle@kernel.org> wrote:

Hi,

> Add the compatible string for the emac found on the V3s SoC. The SoC
> only supports the internal PHY. There are no (R)MII signals on any pins.
> 
> Signed-off-by: Michael Walle <mwalle@kernel.org>

Nice, that seems indeed all we need for that SoC.

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  drivers/net/sun8i_emac.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/net/sun8i_emac.c b/drivers/net/sun8i_emac.c
> index 8bff4fe9a9e..94bcd40acb8 100644
> --- a/drivers/net/sun8i_emac.c
> +++ b/drivers/net/sun8i_emac.c
> @@ -893,6 +893,11 @@ static const struct emac_variant emac_variant_r40 = {
>  	.syscon_offset		= 0x164,
>  };
>  
> +static const struct emac_variant emac_variant_v3s = {
> +	.syscon_offset		= 0x30,
> +	.soc_has_internal_phy	= true,
> +};
> +
>  static const struct emac_variant emac_variant_a64 = {
>  	.syscon_offset		= 0x30,
>  	.support_rmii		= true,
> @@ -910,6 +915,8 @@ static const struct udevice_id sun8i_emac_eth_ids[] = {
>  	  .data = (ulong)&emac_variant_h3 },
>  	{ .compatible = "allwinner,sun8i-r40-gmac",
>  	  .data = (ulong)&emac_variant_r40 },
> +	{ .compatible = "allwinner,sun8i-v3s-emac",
> +	  .data = (ulong)&emac_variant_v3s },
>  	{ .compatible = "allwinner,sun50i-a64-emac",
>  	  .data = (ulong)&emac_variant_a64 },
>  	{ .compatible = "allwinner,sun50i-h6-emac",

