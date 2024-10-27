Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A396D1356D
	for <u-boot@archiver.kernel.org>; Sun, 27 Oct 2024 16:34:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7974D88FFB;
	Sun, 27 Oct 2024 17:32:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ww1Mpvjg";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="KNxrjFuj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 399728906D; Sun, 27 Oct 2024 17:32:24 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C501888EBA
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 17:32:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Xc29P4Bxqz9sn8;
 Sun, 27 Oct 2024 17:32:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1730046729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9qkhxHG6/FTb9SSSoXrH4fOAOWYHPO8QwNscJp3vzXY=;
 b=ww1MpvjgCK+U+jdhfE+0aTZ9kEYGqqP9KvYkNRnYvgGVfSYGzUTMLHWrs9ntL8KtCkv6mf
 PMyqcjJovYRb0M+rv9J/YajnqX98j64NCmVHa6/DloqCPXgNYbEeHyXU0rGskV+bFRz2gO
 mbwlZtKHS/3KGxU6OFIoKrd1qS8yPt1dlJbPgTaq36H95QJu1Yhdg/uqy68mTlKHccXeSl
 on0EcT55AXq7RlvBujs2d3mNgNf6Uf98zeGNBWi+tdSI1QX/8Xx4TR3KTWCyzzQnlvirz9
 53e5MyzLJFy4snd0PX2K4jZc9rkhhvCqP4oyqK75mXcUnYMR6qkWc8+YFyqT3A==
Message-ID: <9bd496f2-7765-4067-bbc6-36b355107af3@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1730046727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9qkhxHG6/FTb9SSSoXrH4fOAOWYHPO8QwNscJp3vzXY=;
 b=KNxrjFuj3CzE67d/zhyBdZHIqjevnnHmwjBA72J5tU9MhAOr9iYt/wB8bFS+BJM6OobK1y
 /4ZFXOJq6utgRF0sLBBWizX8Zsd1WMAAaYHPq8bu87zUS9480Z7uTOLk6tzP3hE9b/nh4W
 Kpvl/00CQbgaoVsmrpAytEtwYbEyR/yMcj1jWOgY/iqm8oGByZ+yg+ubT2aGG5P0pJr57c
 vMevob6eTvjwcXgP8aWRtKLcEOyyRfV334H6uOuAD4ShikmdGaS+vTSmA2Wrn+mn2A5poH
 +bpixj7N+Z3+IbepVZUHVTzQIkVkYQKh9dk0iHQ2f0sypAfe/YtvhuTlaFiH9w==
Date: Sun, 27 Oct 2024 17:25:26 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 09/14] net: ravb: Support up to two instances
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de
References: <20241024152448.102-1-paul.barker.ct@bp.renesas.com>
 <20241024152448.102-10-paul.barker.ct@bp.renesas.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20241024152448.102-10-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: qej1kxb4meqd99jj43j4ygucyd3a4ade
X-MBO-RS-ID: 65520cad5455587f506
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

On 10/24/24 5:24 PM, Paul Barker wrote:
> Several Renesas SoCs in the RZ/G2L family have two Ethernet interfaces.
> To support this second interface, we extend the bb_miiphy_buses[] array
> and keep track of the current bus index in ravb_of_to_plat().
> 
> Support for an arbitrary number of instances is not implemented - it is
> expected that bb_miiphy_buses will be replaced with a proper device
> model/uclass implementation before that is needed.
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> ---
>   drivers/net/ravb.c | 28 ++++++++++++++++++++++++----
>   1 file changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ravb.c b/drivers/net/ravb.c
> index f1401d2f6ed2..9b33ce929618 100644
> --- a/drivers/net/ravb.c
> +++ b/drivers/net/ravb.c
> @@ -11,6 +11,7 @@
>   #include <clk.h>
>   #include <cpu_func.h>
>   #include <dm.h>
> +#include <dm/device_compat.h>
>   #include <errno.h>
>   #include <log.h>
>   #include <miiphy.h>
> @@ -494,6 +495,7 @@ static int ravb_probe(struct udevice *dev)
>   {
>   	struct eth_pdata *pdata = dev_get_plat(dev);
>   	struct ravb_priv *eth = dev_get_priv(dev);
> +	struct bb_miiphy_bus *phybus;
>   	struct mii_dev *mdiodev;
>   	void __iomem *iobase;
>   	int ret;
> @@ -513,7 +515,8 @@ static int ravb_probe(struct udevice *dev)
>   
>   	mdiodev->read = bb_miiphy_read;
>   	mdiodev->write = bb_miiphy_write;
> -	bb_miiphy_buses[0].priv = eth;
> +	phybus = (struct bb_miiphy_bus *)pdata->priv_pdata;
> +	phybus->priv = eth;
>   	snprintf(mdiodev->name, sizeof(mdiodev->name), dev->name);
>   
>   	ret = mdio_register(mdiodev);
> @@ -625,7 +628,17 @@ int ravb_bb_delay(struct bb_miiphy_bus *bus)
>   
>   struct bb_miiphy_bus bb_miiphy_buses[] = {
>   	{
> -		.name		= "ravb",
> +		.name		= "ravb0",
> +		.init		= ravb_bb_init,
> +		.mdio_active	= ravb_bb_mdio_active,
> +		.mdio_tristate	= ravb_bb_mdio_tristate,
> +		.set_mdio	= ravb_bb_set_mdio,
> +		.get_mdio	= ravb_bb_get_mdio,
> +		.set_mdc	= ravb_bb_set_mdc,
> +		.delay		= ravb_bb_delay,
> +	},
> +	{
> +		.name		= "ravb1",
>   		.init		= ravb_bb_init,
>   		.mdio_active	= ravb_bb_mdio_active,
>   		.mdio_tristate	= ravb_bb_mdio_tristate,
> @@ -646,10 +659,16 @@ static const struct eth_ops ravb_ops = {
>   	.write_hwaddr		= ravb_write_hwaddr,
>   };
>   
> +static int bb_miiphy_index;
> +
>   int ravb_of_to_plat(struct udevice *dev)
>   {
>   	struct eth_pdata *pdata = dev_get_plat(dev);
> -	const fdt32_t *cell;
> +
> +	if (bb_miiphy_index >= bb_miiphy_buses_num) {
> +		dev_err(dev, "ravb driver supports only 1 or 2 devices!\n");
Hmmmm, I really do not like this, can we make this dynamic ?

Unless you want to take a look at this yourself, I can add it into my todo ?
