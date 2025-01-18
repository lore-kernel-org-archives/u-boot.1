Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C5DFC02185
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 07:09:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D600180762;
	Sat, 18 Jan 2025 08:09:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="sTvuR8hE";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="yUwXj++c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21F608070C; Sat, 18 Jan 2025 08:09:49 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15EB380755
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 08:09:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4YZnmB5MMMz9sbl;
 Sat, 18 Jan 2025 08:09:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737184186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4cUX2A/DAQrrMgR9WO6qxoSQMKduV3n+iWZgb1AcW8o=;
 b=sTvuR8hE4riHa2FGdMjRNAJzlbiEfjTzQM83ECmEaTUsjHZ+wSolH35vosig7FioMBpvSi
 bCY+aSaZUa7q040tAi9WaN4WaqWc0wG8iHNEIYgLsC3vUguN15SZv8e+paxd7Pf61hzaCb
 QrZAXRwQEwr/7TIR8jVCyq2ZyD5SY8z09ZahhgSy3HNOCWiyWxsH050HL5MBXfQLxcERWK
 J81ua5FIrSiD3X6Ab454Y1GQdqTW7aQSErjqGLrbDjFmOpvK9Db/kZk4+VuLZSkYBW7/Me
 5hdif+dPJ1L1DhnBeYavRb2jqFSHrp8+s333t+e0C5bkYpC8p1C9Ou8rgWe0KQ==
Message-ID: <645166a4-6ef0-45df-a19f-aa1174f14126@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737184184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4cUX2A/DAQrrMgR9WO6qxoSQMKduV3n+iWZgb1AcW8o=;
 b=yUwXj++c//iRBTgx1AxRzrToE4W6a27fj5S7JQubRewzTPJ4X739+RrrPpoq8juFPA8Ict
 /jgsWE95yi8ND1qGGjPEI5d8vb0Uzn0Wv0xorB9/Ek/GKjLX5KHYbkM4JjVljG6u3ojl9w
 /IDI1UC7K2jd1LbGlpNozhL7hnYc5IqTxlM8U5Z+W967DlE44jprmq7c8oMmr3cN21OryM
 l0VHEnn5O+eCETflkna839u4QuigqxEsxVxts2F+WCtdgqLc50tJn6tyfOqhNvmUFU32Aa
 Z1oiUL9saX5IhDHTpC5jKhvErCoAdi6j3q0OLWIB/O8tTYHTqYDyESnbTV0eVw==
Date: Sat, 18 Jan 2025 08:00:29 +0100
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
 <dfffeed9-af65-4739-b01a-361dfed24c10@bp.renesas.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <dfffeed9-af65-4739-b01a-361dfed24c10@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: isstx5m8c5kimgnriex9sk3xoebmedz3
X-MBO-RS-ID: b874f2ca5d63c111eac
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

On 12/5/24 8:12 PM, Paul Barker wrote:
> Hi Marek,
> 
> On 28/10/2024 09:50, Paul Barker wrote:
>> On 27/10/2024 16:25, Marek Vasut wrote:
>>> On 10/24/24 5:24 PM, Paul Barker wrote:
>>>>    int ravb_of_to_plat(struct udevice *dev)
>>>>    {
>>>>    	struct eth_pdata *pdata = dev_get_plat(dev);
>>>> -	const fdt32_t *cell;
>>>> +
>>>> +	if (bb_miiphy_index >= bb_miiphy_buses_num) {
>>>> +		dev_err(dev, "ravb driver supports only 1 or 2 devices!\n");
>>> Hmmmm, I really do not like this, can we make this dynamic ?
>>>
>>> Unless you want to take a look at this yourself, I can add it into my todo ?
>>
>> I think the real solution here would be to separate the bb_miiphy
>> operations from the bus instance, so we would have something like:
>>
>>      struct bb_miiphy_bus {
>>          struct bb_miiphy_ops *ops;
>>          void *priv;
>>      };
>>
>>      struct bb_miiphy_ops {
>>          int (*init)(struct bb_miiphy_bus *bus);
>>          int (*mdio_active)(struct bb_miiphy_bus *bus);
>>          int (*mdio_tristate)(struct bb_miiphy_bus *bus);
>>          int (*set_mdio)(struct bb_miiphy_bus *bus, int v);
>>          int (*get_mdio)(struct bb_miiphy_bus *bus, int *v);
>>          int (*set_mdc)(struct bb_miiphy_bus *bus, int v);
>>          int (*delay)(struct bb_miiphy_bus *bus);
>>      };
>>
>>      int bb_miiphy_bus_register(const char *name,
>>                                 struct bb_miiphy_ops *ops,
>> 			       void *priv);
>>
>> Where drivers will call `bb_miiphy_bus_register()` from the probe
>> function, it will create a `struct bb_miiphy_bus` instance and a
>> `struct mii_dev` instance then call `mdio_register()`. The driver can
>> then support an arbitrary number of MDIO busses from a single constant
>> `struct bb_miiphy_ops` instance.
>>
>> The bb_miiphy_getbus() function should be dropped from miiphy.c.
>> Instead, the priv pointer in the `struct mii_dev` instance can point to
>> the appropriate `struct bb_miiphy_bus` instance.
>>
>> It looks like all users of CONFIG_BITBANGMII also set
>> CONFIG_BITBANGMII_MULTI, and there don't seem to be any targets that
>> define the macros documented in README.bitbangMII (lines 15-22). So, we
>> can drop the non-BITBANGMII_MULTI code from miiphybb.c and simplify
>> things a lot.
>>
>> That's non-trivial but it's not a huge set of changes, maybe something
>> we could target for v2024.04?
> 
> We've got several of the other patches from this series merged now after
> v2 so I'm coming back to this one. I think we should take this patch
> as-is and then follow up with general improvements to the bb_miiphy
> support. Are you happy with that? If so I will re-send it along with a
> re-worked version of patch 11 from this series (net: ravb: Add RZ/G2L
> Support).
I apologize for the horrible delay.

I just posted the bb_miiphy patches so maybe we can do it properly right 
from the start ?
