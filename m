Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E456CC4451B
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 02:58:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE22F83E76;
	Mon, 20 Jul 2026 04:58:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="BDrKl1GR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44DC184118; Mon, 20 Jul 2026 04:58:20 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5983782991
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 04:58:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4h3QF426skzMlDF;
 Mon, 20 Jul 2026 04:58:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1784516296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mPbcC5TNHgEEWxkIA7MyHNpOS6rHb48/OScObTsUUa0=;
 b=BDrKl1GR/sbIlAR3jSfJKZV2/2RmTedOkNa3IUojMCBw8aCP1GYXuZCzhgVyZ/X98BuIu7
 vsQXCWDmj6LuheW6r0pKzvYrzI05E4nn4yIrR+fFbmu+x40YpuHuQ81S5yNzvQoNMekHvm
 OxHfJXHh4bbQ0Tkq25W2mft8dP0CZTB57e5CxdmvLiwWdb29GaoCfSY7rRst0B8BH7T2mx
 5kbSET+sCSnvlFInNXoVKBhUQ/GioqEc3fqaG7lriQaLhHfiihRAmyvvEEBpzaTfA6yTGE
 IesNx7B6yXloHbWEg1sGNXhy46j/CyAO77p6f0q+qJpe3NibyJWK76wPhbMPJA==
Message-ID: <1c0aa375-b274-4171-801d-4ee7b857e61e@mailbox.org>
Date: Sat, 18 Jul 2026 22:20:33 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2] usb: mtu3: support the current devicetree binding
To: Carlo Caione <ccaione@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.denx.de
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 David Lechner <dlechner@baylibre.com>, Julien Stephan
 <jstephan@baylibre.com>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>
References: <20260718-ccaione-upstream-mtu3-spl-gadget-v2-1-7f69ca462559@baylibre.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260718-ccaione-upstream-mtu3-spl-gadget-v2-1-7f69ca462559@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: e3b152384823227b743
X-MBO-RS-META: n9zboy6tqbk89jadio1nr1qgrj83xak9
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

On 7/18/26 12:08 PM, Carlo Caione wrote:

[...]

> +++ b/drivers/usb/mtu3/mtu3_plat.c
> @@ -11,6 +11,11 @@
>   #include "mtu3.h"
>   #include "mtu3_dr.h"
>   
> +struct mtu3_glue_plat {
> +	struct udevice *child;
> +	bool legacy_binding;
> +};
> +
>   void ssusb_set_force_mode(struct ssusb_mtk *ssusb,
>   			  enum mtu3_dr_force_mode mode)
>   {
> @@ -135,7 +140,9 @@ static void ssusb_ip_sw_reset(struct ssusb_mtk *ssusb)
>   
>   static int get_ssusb_rscs(struct udevice *dev, struct ssusb_mtk *ssusb)
>   {
> -	struct udevice *child;
> +	struct mtu3_glue_plat *plat = dev_get_plat(dev);
> +	struct udevice *child = plat->child;
> +	fdt_addr_t mac_addr;
>   	int ret;
>   
>   	ret = device_get_supply_regulator(dev, "vusb33-supply",
> @@ -160,13 +167,17 @@ static int get_ssusb_rscs(struct udevice *dev, struct ssusb_mtk *ssusb)
>   		return -ENODEV;
>   	}
>   
> -	ret = device_find_first_child(dev, &child);
> -	if (ret || !child) {
> -		dev_err(dev, "failed to get child %d!\n", ret);
> -		return ret;
> +	mac_addr = devfdt_get_addr_name(child, "mac");

Use device_*()/ofnode_*() DT accessors please, not the raw 
fdt_*()/devfdt_*() ones.

> +	if (mac_addr == FDT_ADDR_T_NONE) {
> +		dev_err(dev, "error mapping memory for mac\n");
> +		return -ENODEV;
>   	}
>   
> -	ssusb->mac_base = devfdt_remap_addr_name(child, "mac");
> +	/* Current bindings describe the device block, not the whole MAC. */
> +	if (!plat->legacy_binding)
> +		mac_addr -= SSUSB_DEV_BASE;
> +
> +	ssusb->mac_base = map_physmem(mac_addr, 0, MAP_NOCACHE);
>   	if (!ssusb->mac_base) {
>   		dev_err(dev, "error mapping memory for mac\n");
>   		return -ENODEV;
> @@ -310,16 +321,24 @@ U_BOOT_DRIVER(mtu3_host) = {
>   
>   static int mtu3_glue_bind(struct udevice *parent)
>   {
> -	struct udevice *dev;
> +	struct mtu3_glue_plat *plat = dev_get_plat(parent);
>   	enum usb_dr_mode dr_mode;
>   	const char *driver;
>   	const char *name;
>   	ofnode node;
>   	int ret;
>   
> -	node = ofnode_by_compatible(dev_ofnode(parent), "mediatek,ssusb");
> +	node = ofnode_null();
> +	ofnode_for_each_subnode(node, dev_ofnode(parent)) {
> +		if (ofnode_device_is_compatible(node, "mediatek,ssusb"))
> +			break;
> +	}
> +
> +	plat->legacy_binding = ofnode_valid(node);
> +
> +	/* Current bindings keep the gadget resources on the parent node. */
>   	if (!ofnode_valid(node))
> -		return -ENODEV;
> +		node = dev_ofnode(parent);
>   
>   	name = ofnode_get_name(node);
>   	dr_mode = usb_get_dr_mode(node);
> @@ -349,7 +368,8 @@ static int mtu3_glue_bind(struct udevice *parent)
>   	dev_dbg(parent, "%s: node name: %s, driver %s, dr_mode %d\n",
>   		__func__, name, driver, dr_mode);
>   
> -	ret = device_bind_driver_to_node(parent, driver, name, node, &dev);
> +	ret = device_bind_driver_to_node(parent, driver, name, node,
> +					 &plat->child);
>   	if (ret)
>   		dev_err(parent, "%s: not able to bind usb device mode\n",
>   			__func__);
> @@ -369,5 +389,6 @@ U_BOOT_DRIVER(mtu3) = {
>   	.bind = mtu3_glue_bind,
>   	.probe = mtu3_probe,
>   	.remove = mtu3_remove,
> +	.plat_auto	= sizeof(struct mtu3_glue_plat),
>   	.priv_auto	= sizeof(struct ssusb_mtk),

Can you extend struct ssusb_mtk with a new field instead of adding plat 
data ?
