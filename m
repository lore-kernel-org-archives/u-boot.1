Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F07E9EF06FB
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 00:40:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 076B28341A;
	Mon,  9 Feb 2026 01:40:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="iObFPzuY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1DAD83642; Mon,  9 Feb 2026 01:40:15 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98559805D7
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 01:40:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4f8Qp14TYvz9tnS;
 Mon,  9 Feb 2026 01:40:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1770597609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t686ltOdD9dkCsmpEZ+sbOI/LZRyk1kWc7TE+BGCaSc=;
 b=iObFPzuY5AVctKlfMaw+qH+QUhg1106maIxK/cenwROLQ6iZGEh5oVEuXu5kGaQGV81amk
 IlgrteRi13dIbnXvyvc7MVmI6oU7rxVXurwbke0Amin3TFV0YFiGXbnPUoHVQHeAwtqNTI
 wpB4/aN/cIVmRUV4k9MGCDrUWkz/XK6+a5xfjUMdBVf1XbCGZgtIo+UOgk+mijMKLVhK+S
 nrmlOtzF9TRxdbm582ulmIXP2hYnyxx+oAx0HwyJzGcoHKzI4kxipl2txblL208utiuBM5
 49zHuAm6DZs15JRDWltrUoO3EE1MkEW16HTfT8tVVZTSOYiA59REYeZY87mR6A==
Message-ID: <2bdf75c0-bbda-4180-9e27-74a87cd6fe2a@mailbox.org>
Date: Sun, 8 Feb 2026 21:41:04 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v5 1/2] usb: musb-new: Relative ctrl_mod address parsing
To: Markus Schneider-Pargmann <msp@baylibre.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>
References: <20260130-topic-musb-probing-v2026-01-v5-0-195b23c7948f@baylibre.com>
 <20260130-topic-musb-probing-v2026-01-v5-1-195b23c7948f@baylibre.com>
 <c0c59409-95e4-46a2-ab19-06bd150cdec0@mailbox.org>
 <DG9UYH3KEHMK.30RD25B27GEU9@baylibre.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <DG9UYH3KEHMK.30RD25B27GEU9@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: xzy17twi3jtah8ynmx1h1zmbm7asycg3
X-MBO-RS-ID: 83da9bfed6396c8f88b
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

On 2/8/26 9:20 PM, Markus Schneider-Pargmann wrote:
> On Sun Feb 1, 2026 at 7:18 PM CET, Marek Vasut wrote:
>> On 1/30/26 5:28 PM, Markus Schneider-Pargmann (TI.com) wrote:
>>> For the upstream DT the ctrl_mod node is using a relative register
>>> address which is not translated by the current code.
>>>
>>> Make address parsing understand relative addresses.
>>>
>>> Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
>>> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
>>> ---
>>>    drivers/usb/musb-new/ti-musb.c | 10 +++++-----
>>>    1 file changed, 5 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/usb/musb-new/ti-musb.c b/drivers/usb/musb-new/ti-musb.c
>>> index bcd31adba522fc55190fc43fd2dbd2dec93a2731..75dc2dc18748e33785c7312a24145544b659579d 100644
>>> --- a/drivers/usb/musb-new/ti-musb.c
>>> +++ b/drivers/usb/musb-new/ti-musb.c
>>> @@ -83,17 +83,17 @@ static int ti_musb_of_to_plat(struct udevice *dev)
>>>    	struct ti_musb_plat *plat = dev_get_plat(dev);
>>>    	const void *fdt = gd->fdt_blob;
>>>    	int node = dev_of_offset(dev);
>>> -	int phys;
>>> -	int ctrl_mod;
>>> +	ofnode phys_node;
>>> +	ofnode ctrl_mod_node;
>>>    	int usb_index;
>>>    	int ret;
>>>    	struct musb_hdrc_config *musb_config;
>>>    
>>>    	plat->base = devfdt_get_addr_index_ptr(dev, 1);
>>>    
>>> -	phys = fdtdec_lookup_phandle(fdt, node, "phys");
>>> -	ctrl_mod = fdtdec_lookup_phandle(fdt, phys, "ti,ctrl_mod");
>>> -	plat->ctrl_mod_base = (void *)fdtdec_get_addr(fdt, ctrl_mod, "reg");
>>> +	phys_node = ofnode_get_by_phandle(dev_read_u32_default(dev, "phys", 0));
>>> +	ctrl_mod_node = ofnode_get_by_phandle(ofnode_read_u32_default(phys_node, "ti,ctrl_mod", 0));
>>> +	plat->ctrl_mod_base = (void *)ofnode_get_addr(ctrl_mod_node);
>> Is the cast to void * necessary , and if yes, can it be removed ?
> 
> Yes it is necessary, ctrl_mod_base is a void pointer. It is used in
> clrsetbits_le32(). If I resolved that macro correctly that expects a
> pointer as well. Other drivers seem to use the void pointer as well.
OK
