Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA8BAC02187
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 07:09:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86F768073D;
	Sat, 18 Jan 2025 08:09:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="nH4K2SsD";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="eMrhbvK1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9ECCA80758; Sat, 18 Jan 2025 08:09:48 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C6E78070C
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 08:09:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4YZnm961cBz9spF;
 Sat, 18 Jan 2025 08:09:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737184185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VS68rxd6terQZmhot82uvJ4YoBhYbpFo6bEdftC//C8=;
 b=nH4K2SsD+AdXJrmAWVDNrfc7KF+eFWki++zCQO0J5z/RVCFCE3ljYUYE+w76qeUa996Gmy
 Xs1g2l69S11tt/NFAGDc6NMY8tjwwzNKrgmM4ruGDbDfgafX8pprxXntL+buAfxxCFnIGZ
 NlZ3wyChtbhSPzMSkBFWHDAQXEApMjRPwI21ISRm1b6t4lOMrKyZze4mZ4wrEMUtQ0RM7k
 s6iLd/WqrrutbQAdQTOOyj9OIoICC/LIZFHcp2dcUTaiCvozNPrsBGKumAo6V5KAyyyC8A
 k29QgPxEhCSpr81BqaRp0uOXgpGLks+0dLAHpqL43i41zTLN+w1N2dXz/+y+fA==
Message-ID: <c9a4e41b-c79f-499b-bd3f-b963d0cb19d3@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737184183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VS68rxd6terQZmhot82uvJ4YoBhYbpFo6bEdftC//C8=;
 b=eMrhbvK1cu+4z6piyeuEz9B4Px5wTpS+3XDLXlI/cm5KkVgX5mZVzb3uceDKuqHSdWoiVW
 AhJV1hnRvKdgr8g4CbbGszfnrqI1FJNWph+gh9RZ5d77PQ01zd/9L4x4uXECcPZdy8Te33
 BLgqC+mF0+ylVIctrATTIkZTMItRGAec7lvP79pD8o5HWYT3q86kMMUVq6GtVdex3sFHCe
 fQORjY7ukKudGcXzXKc540rmx2D/llpLU/RKthfqVad+dTYL3rfb6dSPquk1XQYR4Dcb0o
 NyNsfcqxSt7zy6ujBtauWcwy0oKCY3vO9HwDqyGIR8j2RreZJyw977TCl7jFvA==
Date: Sat, 18 Jan 2025 07:59:28 +0100
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
 <9bd496f2-7765-4067-bbc6-36b355107af3@mailbox.org>
 <a7d6a116-704c-4d48-a018-ce1da4fedee5@bp.renesas.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <a7d6a116-704c-4d48-a018-ce1da4fedee5@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: b26e55a225a623ab6bc
X-MBO-RS-META: yn4y9335389sbbmzdnefow9miuexmsd8
X-Rspamd-Queue-Id: 4YZnm961cBz9spF
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

On 10/28/24 10:50 AM, Paul Barker wrote:
> On 27/10/2024 16:25, Marek Vasut wrote:
>> On 10/24/24 5:24 PM, Paul Barker wrote:
>>> Several Renesas SoCs in the RZ/G2L family have two Ethernet interfaces.
>>> To support this second interface, we extend the bb_miiphy_buses[] array
>>> and keep track of the current bus index in ravb_of_to_plat().
>>>
>>> Support for an arbitrary number of instances is not implemented - it is
>>> expected that bb_miiphy_buses will be replaced with a proper device
>>> model/uclass implementation before that is needed.
>>>
>>> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
>>> ---
>>>    drivers/net/ravb.c | 28 ++++++++++++++++++++++++----
>>>    1 file changed, 24 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/net/ravb.c b/drivers/net/ravb.c
>>> index f1401d2f6ed2..9b33ce929618 100644
>>> --- a/drivers/net/ravb.c
>>> +++ b/drivers/net/ravb.c
>>> @@ -11,6 +11,7 @@
>>>    #include <clk.h>
>>>    #include <cpu_func.h>
>>>    #include <dm.h>
>>> +#include <dm/device_compat.h>
>>>    #include <errno.h>
>>>    #include <log.h>
>>>    #include <miiphy.h>
>>> @@ -494,6 +495,7 @@ static int ravb_probe(struct udevice *dev)
>>>    {
>>>    	struct eth_pdata *pdata = dev_get_plat(dev);
>>>    	struct ravb_priv *eth = dev_get_priv(dev);
>>> +	struct bb_miiphy_bus *phybus;
>>>    	struct mii_dev *mdiodev;
>>>    	void __iomem *iobase;
>>>    	int ret;
>>> @@ -513,7 +515,8 @@ static int ravb_probe(struct udevice *dev)
>>>    
>>>    	mdiodev->read = bb_miiphy_read;
>>>    	mdiodev->write = bb_miiphy_write;
>>> -	bb_miiphy_buses[0].priv = eth;
>>> +	phybus = (struct bb_miiphy_bus *)pdata->priv_pdata;
>>> +	phybus->priv = eth;
>>>    	snprintf(mdiodev->name, sizeof(mdiodev->name), dev->name);
>>>    
>>>    	ret = mdio_register(mdiodev);
>>> @@ -625,7 +628,17 @@ int ravb_bb_delay(struct bb_miiphy_bus *bus)
>>>    
>>>    struct bb_miiphy_bus bb_miiphy_buses[] = {
>>>    	{
>>> -		.name		= "ravb",
>>> +		.name		= "ravb0",
>>> +		.init		= ravb_bb_init,
>>> +		.mdio_active	= ravb_bb_mdio_active,
>>> +		.mdio_tristate	= ravb_bb_mdio_tristate,
>>> +		.set_mdio	= ravb_bb_set_mdio,
>>> +		.get_mdio	= ravb_bb_get_mdio,
>>> +		.set_mdc	= ravb_bb_set_mdc,
>>> +		.delay		= ravb_bb_delay,
>>> +	},
>>> +	{
>>> +		.name		= "ravb1",
>>>    		.init		= ravb_bb_init,
>>>    		.mdio_active	= ravb_bb_mdio_active,
>>>    		.mdio_tristate	= ravb_bb_mdio_tristate,
>>> @@ -646,10 +659,16 @@ static const struct eth_ops ravb_ops = {
>>>    	.write_hwaddr		= ravb_write_hwaddr,
>>>    };
>>>    
>>> +static int bb_miiphy_index;
>>> +
>>>    int ravb_of_to_plat(struct udevice *dev)
>>>    {
>>>    	struct eth_pdata *pdata = dev_get_plat(dev);
>>> -	const fdt32_t *cell;
>>> +
>>> +	if (bb_miiphy_index >= bb_miiphy_buses_num) {
>>> +		dev_err(dev, "ravb driver supports only 1 or 2 devices!\n");
>> Hmmmm, I really do not like this, can we make this dynamic ?
>>
>> Unless you want to take a look at this yourself, I can add it into my todo ?
> 
> I think the real solution here would be to separate the bb_miiphy
> operations from the bus instance, so we would have something like:
> 
>      struct bb_miiphy_bus {
>          struct bb_miiphy_ops *ops;
>          void *priv;
>      };
> 
>      struct bb_miiphy_ops {
>          int (*init)(struct bb_miiphy_bus *bus);
>          int (*mdio_active)(struct bb_miiphy_bus *bus);
>          int (*mdio_tristate)(struct bb_miiphy_bus *bus);
>          int (*set_mdio)(struct bb_miiphy_bus *bus, int v);
>          int (*get_mdio)(struct bb_miiphy_bus *bus, int *v);
>          int (*set_mdc)(struct bb_miiphy_bus *bus, int v);
>          int (*delay)(struct bb_miiphy_bus *bus);
>      };
> 
>      int bb_miiphy_bus_register(const char *name,
>                                 struct bb_miiphy_ops *ops,
> 			       void *priv);
> 
> Where drivers will call `bb_miiphy_bus_register()` from the probe
> function, it will create a `struct bb_miiphy_bus` instance and a
> `struct mii_dev` instance then call `mdio_register()`. The driver can
> then support an arbitrary number of MDIO busses from a single constant
> `struct bb_miiphy_ops` instance.
> 
> The bb_miiphy_getbus() function should be dropped from miiphy.c.
> Instead, the priv pointer in the `struct mii_dev` instance can point to
> the appropriate `struct bb_miiphy_bus` instance.
> 
> It looks like all users of CONFIG_BITBANGMII also set
> CONFIG_BITBANGMII_MULTI, and there don't seem to be any targets that
> define the macros documented in README.bitbangMII (lines 15-22). So, we
> can drop the non-BITBANGMII_MULTI code from miiphybb.c and simplify
> things a lot.
> 
> That's non-trivial but it's not a huge set of changes, maybe something
> we could target for v2024.04?
Patches posted somewhat inline with what you suggested:

https://patchwork.ozlabs.org/project/uboot/patch/20250118061304.124807-1-marek.vasut+renesas@mailbox.org/
https://patchwork.ozlabs.org/project/uboot/patch/20250118061445.124932-1-marek.vasut+renesas@mailbox.org/
https://patchwork.ozlabs.org/project/uboot/patch/20250118061558.124963-1-marek.vasut+renesas@mailbox.org/
https://patchwork.ozlabs.org/project/uboot/patch/20250118061629.125005-1-marek.vasut+renesas@mailbox.org/
https://patchwork.ozlabs.org/project/uboot/patch/20250118063458.137258-1-marek.vasut+renesas@mailbox.org/
https://patchwork.ozlabs.org/project/uboot/patch/20250118065402.172253-1-marek.vasut+renesas@mailbox.org/
