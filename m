Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AB31C4707B
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 12:15:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77961879E5;
	Thu, 18 Jan 2024 13:15:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="B7UepuNb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C05D8798D; Thu, 18 Jan 2024 13:15:20 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86588879E5
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 13:15:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id CC6FC60DF6;
 Thu, 18 Jan 2024 12:15:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBC64C433F1;
 Thu, 18 Jan 2024 12:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1705580112;
 bh=X+IHkBoOOpbT5Lhs5+utanpDH3tGCADJxXWGYtJj+/M=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=B7UepuNb3wWMYTwN3QvJcfUe4cuHAEPhex44fn2/e78jE8QJEVh6liM8v4oFsUe+9
 ryXOX2eS6NyyzruCyrmqnA8TM6MOkF5UdPgMrPPMkzSp0MS+Gb7fBZlaAIpN+EbxWW
 e65WyoHopSSZGS2SzigFKAB91DBZhetv+CNtuxDQZ936C5ImNw4KpZbOM/7HODYztP
 Smc+nLup7of5vbOfyCVCKTlAayONK/E2QFd0Go3WqzUVrB5/aM1a+eTcSujAEtt45x
 6Ns+KOhBfbeBPhRQfd/ZXMHVrQoTjawKhf1ltNPJKs2KfVrh3GykW1uXoVp24n+el+
 Yo1bas0JVIcng==
Message-ID: <bd06e456-643f-4a49-a342-00a008045b41@kernel.org>
Date: Thu, 18 Jan 2024 14:15:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] net: ti: am65-cpsw-nuss: Remove incorrect RGMII_ID
 bit functionality
To: Ken Sloat <ken.s@variscite.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "mripard@kernel.org" <mripard@kernel.org>,
 "dannenberg@ti.com" <dannenberg@ti.com>, "sjg@chromium.org"
 <sjg@chromium.org>, "s-anna@ti.com" <s-anna@ti.com>, "nm@ti.co" <nm@ti.co>,
 "s-vadapalli@ti.com" <s-vadapalli@ti.com>,
 "rfried.dev@gmail.com" <rfried.dev@gmail.com>,
 "joe.hershberger@ni.com" <joe.hershberger@ni.com>
Cc: Nate Drude <Nate.D@variscite.com>, Eran Matityahu <eran.m@variscite.com>
References: <AS8PR08MB7991CFB38C65A76484AD971CEC732@AS8PR08MB7991.eurprd08.prod.outlook.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <AS8PR08MB7991CFB38C65A76484AD971CEC732@AS8PR08MB7991.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
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

Hi Ken,

On 16/01/2024 22:01, Ken Sloat wrote:
> The CPSW implementations on the AM6x platforms do not support the
> selectable RGMII TX clk delay functionality via the RGMII_ID_MODE bit as
> the earlier platforms did. According to various TI datasheets, reference
> manuals, hardware design guides and TI forum posts from TI, this bit is
> "not timed, tested, or characterized. RGMII_ID is enabled by default and
> the register bit reserved."
> 
> The driver implementation today however, will incorrectly set this bit
> whenever the interface mode is in RGMII_ID or RGMII_TXID.
> 
> To fix this, remove any statement setting this bit, and moreover, mask
> bits 31:4 as these are all reserved.
> 
> See:
> https://e2e.ti.com/support/processors-group/processors/f/processors-forum/1211306/am625-enet1_ctrl_rgmii_id-_mode
> https://www.ti.com/lit/pdf/spruiv7 (Rev. B Figure 14-1717> https://www.ti.com/lit/gpn/am625 (Rev. B Figure 7-31 Note A)
> https://www.ti.com/lit/an/sprad05b/sprad05b.pdf (Rev. B Section 7.4)
> 

Thanks for the patch. Some comments below.

> Signed-off-by: Ken Sloat <ken.s@variscite.com>
> ---
>  drivers/net/ti/am65-cpsw-nuss.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ti/am65-cpsw-nuss.c b/drivers/net/ti/am65-cpsw-nuss.c
> index 18a33c4c0e..51c432408f 100644
> --- a/drivers/net/ti/am65-cpsw-nuss.c
> +++ b/drivers/net/ti/am65-cpsw-nuss.c
> @@ -256,7 +256,6 @@ static int am65_cpsw_gmii_sel_k3(struct am65_cpsw_priv *priv,
>  {
>  	struct udevice *dev = priv->dev;
>  	u32 offset, reg, phandle;
> -	bool rgmii_id = false;
>  	fdt_addr_t gmii_sel;
>  	u32 mode = 0;
>  	ofnode node;
> @@ -296,7 +295,6 @@ static int am65_cpsw_gmii_sel_k3(struct am65_cpsw_priv *priv,
>  	case PHY_INTERFACE_MODE_RGMII_ID:
>  	case PHY_INTERFACE_MODE_RGMII_TXID:
>  		mode = AM65_GMII_SEL_MODE_RGMII;
> -		rgmii_id = true;
>  		break;
>  
>  	case PHY_INTERFACE_MODE_SGMII:
> @@ -313,15 +311,13 @@ static int am65_cpsw_gmii_sel_k3(struct am65_cpsw_priv *priv,
>  		break;
>  	};
>  
> -	if (rgmii_id)
> -		mode |= AM65_GMII_SEL_RGMII_IDMODE;
> -
> -	reg = mode;
> +	/* bits 31:4 are reserved */

Updated documentation is still wrong. Reserved bits should be Read only and should
always read 0. In updated TRM it doesn't show reserved bits as read-only and states
read value is 1.

Bit 4 is clearly read/write so it cannot be treated as reserved. But setting it
to 1 is not supported. 
If bootROM or some other software set it to 1 then it will remain 1 and we cannot
rely on it to be always 0. That's why it shouldn't be treated as reserved.

On AM65 bits 31:5 and 3:2 are reserved (read only 0).
Bit 4 is still r/w but setting 1 is not supported.

> +	reg = (GENMASK(31, 4) & reg) | mode;

As reserved bits will always read 0 this mask is not required.
What we do need to do is always clear bit 4.

So
	#define AM6X_GMII_SEL_MODE_SEL_MASK	GENMASK(2:0)

	/* RGMII_ID_MODE = 1 is not supported */
	reg &= ~AM65_GMII_SEL_RGMII_IDMODE;
	reg &= ~AM6X_GMII_SEL_MODE_SEL_MASK;
	reg |= mode;

Or simply this would have worked as we don't really set bit 4 in mode.

	reg = mode;


>  	dev_dbg(dev, "gmii_sel PHY mode: %u, new gmii_sel: %08x\n",
>  		phy_mode, reg);
>  	writel(reg, gmii_sel);
>  
> -	reg = readl(gmii_sel);
> +	reg = GENMASK(3, 0) & readl(gmii_sel);

should be GENMASK(2, 0);

but now we can use AM6X_GMII_SEL_MODE_SEL_MASK here instead.

>  	if (reg != mode) {
>  		dev_err(dev,
>  			"gmii_sel PHY mode NOT SET!: requested: %08x, gmii_sel: %08x\n",

-- 
cheers,
-roger
