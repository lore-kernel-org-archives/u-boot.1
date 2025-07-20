Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F9B8C83F1A
	for <u-boot@archiver.kernel.org>; Sun, 20 Jul 2025 20:19:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7490E82F8F;
	Sun, 20 Jul 2025 22:19:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="dMKI6kpy";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ih1YCnKs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29EB483010; Sun, 20 Jul 2025 22:19:48 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17D1382DA1
 for <u-boot@lists.denx.de>; Sun, 20 Jul 2025 22:19:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4blZdD25jCz9tBf;
 Sun, 20 Jul 2025 22:19:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1753042784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dg9pWTp97+mJ93FPc0Axxl6SZl8qA5LM0NudAcfP4mE=;
 b=dMKI6kpy1pW9VVFOZ9kvLCNmGAXKkbct+xJtx4KRfnX3OvSnbg5tzdObf1byRYgwVWuQ9y
 UnsyLZ5jfFoew6H+yTz4BQt3140nDbvdNst9CtvBKOTUiNLTSOjIqYeFZQ+N7B4d8nltjz
 8pTsqNWNIzEA6XykrAcGxqBB1umhj+bl5ygqbJX4+Hyh5CcT7R/X/ptHwP3IKIENPrQBO5
 e4Ju0KxwE4hX2rCrmlNs2X7v57c45oW7SAlwEjuJRTiq+edJ5ENSb1j9KZNEdgj/zQ6FAL
 7lVDtPdRIjN2r58lgIrR2V4traJuyMz9uR+vid0JmQTctBuC3PuUGNNWPqg/bA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=ih1YCnKs;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <08af1da8-dd2d-4b34-9fe8-f8de18a82149@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1753042781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dg9pWTp97+mJ93FPc0Axxl6SZl8qA5LM0NudAcfP4mE=;
 b=ih1YCnKstNlYmz135pKQO3WY62Ft7jrhvAXGuWnrFjD5D/G3lqX+GJWGfekx3k8mM/eC4y
 K3p5kUjLbqL82OuFRseNmtrGjecTQQufWZEOPqI9C1nUMtgulHx9dwY7dLxxxf8wa1P8ra
 piROuCz6FF5Ki3tVPWBJj5gHFPPm3KO98rqH3WyLzY0IbSkmWiQRhWNBgNbWyBdayLF7Lu
 4rrDa/ckYDlynOd+TATYtNcsAYWjRE6SZZAPjcVt2Iz7zyPY8AyYAwOzMwsbZ/I8w+4jOJ
 AZTUJ9A3xUCU4Dj2pOCMtEEyLClZ5RGSivmFEHePYE1mVjHkoJOq2HalbZsFBg==
Date: Sun, 20 Jul 2025 22:19:39 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3 7/9] net: sh_eth: Adjust RZ/A1, add RZ/A2 support
To: Magnus Damm <magnus.damm@gmail.com>
Cc: u-boot@lists.denx.de, marek.vasut+renesas@mailbox.org,
 Chris.Brandt@renesas.com, geert+renesas@glider.be
References: <175180131601.86839.3544906856404059041.sendpatchset@1.0.0.127.in-addr.arpa>
 <175180136965.86839.10195243856147148306.sendpatchset@1.0.0.127.in-addr.arpa>
 <0e525790-79f7-4653-808d-137c1e55ed09@mailbox.org>
 <CANqRtoQUCmwfYF80KqoBSSYbhzJmR0488R6+zJFxBTyGYXLcwg@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CANqRtoQUCmwfYF80KqoBSSYbhzJmR0488R6+zJFxBTyGYXLcwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 9zwird7x13pmu3x1izqk7rp1wyh3hxms
X-MBO-RS-ID: 60d503971fdf12ef202
X-Rspamd-Queue-Id: 4blZdD25jCz9tBf
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

On 7/7/25 7:03 PM, Magnus Damm wrote:

Hello Magnus,

I'm sorry for the late reply.

>>> +++ work/drivers/net/sh_eth.c 2025-07-05 17:45:07.333754799 +0900
>>> @@ -144,10 +144,10 @@ static int sh_eth_reset(struct sh_eth_in
>>>    {
>>>    #if defined(SH_ETH_TYPE_GETHER) || defined(SH_ETH_TYPE_RZ)
>>>        int ret = 0, i;
>>> -
>>
>> Does something like this ...
>>
>> if (!device_is_compatible(dev, "..."))
>>
>> ... work instead of the ifdef ?
>>
>> If yes, it might be even improved into dedicated function:
>>
>> static bool device_is_rza2(struct udevice *dev)
>> {
>>     if (!IS_ENABLED(CONFIG_RZA2))
>>       return false;
>>     else
>>       return device_is_compatible(dev, "...");
>> }
>>
>> That should be compile-time checked and then optimized out, and in case
>> of non-RZA2, this should be optimized out entirely.
> 
> While I'm all for trying to clean up the code, unfortunately I don't
> think only adding compat string handling to RZ is going to help that
> much. My apologies for prodding with DT in the SCIF driver for RZA2
> only. The same thing applies there in my opinion. =) But we have to
> start somewhere, that's for sure.

I suspect cleaning up the sh_eth will be a larger undertaking, yes.

> By the way, did you see the #ifdeffery and the compile time constants
> in sh_eth.h? Also there seems to be a lot of overlap between
> TYPE_GETHER and TYPE_RZ.

I am aware of the ifdeffery, yes.

> My first take on cleaning up the sh_eth.c driver would probably be to
> dive deeper into the offset tables (such as sh_eth_offset_rz in
> sh_eth.h) and convert the code to during runtime use the offset table
> to determine if a register exists or not. That would take care of a
> bunch of TYPE_GETHER and TYPE_RZ differences and remove some #ifdefs
> from the code as long as the offset tables are correct (which they
> don't seem to be for RZ so those need to be validated as well). Then
> perhaps add some feature flag to handle corner cases like
> 'device_needs_polled_reset' to clean up sh_eth_reset().

The one thing you have to be careful about is to avoid increasing the 
code size too much. Use if (IS_ENABLED()) and such macros, which do 
compile the code, but then let gcc optimize it out. This retains code 
coverage, but shouldn't increase the code size.

> And during probe() or U-Boot equivalent then using the compat string
> detection mechanism to select appropriate offset table would make
> sense to me.
> 
> What do you think? This seems like incremental cleanups though, not
> neccessarily related to RZ. I am happy to clean it up though, if you
> think it would be helpful.

I am happy with incremental clean ups .

>>> +#if !defined(CONFIG_RZA2)
>>>        /* Start e-dmac transmitter and receiver */
>>>        sh_eth_write(port_info, EDSR_ENALL, EDSR);
>>> -
>>
>> [...]
>>
>>> @@ -722,8 +726,11 @@ static int sh_ether_probe(struct udevice
>>>                goto err_mdio_register;
>>>
>>>        priv->bus = mdiodev;
>>> -
>>> +#ifdef BASE_IO_ADDR
>>>        port_info->iobase = (void __iomem *)(uintptr_t)BASE_IO_ADDR;
>>> +#else
>>> +     port_info->iobase = (void __iomem *)pdata->iobase;
>>> +#endif
>>
>> Can the base address be pulled from DT?
> 
> Actually pdata->iobase comes from DT. Currently BASE_IO_ADDR is not
> set in sh_eth.h for RZ/A1 and RZ/A2. In such case the code above uses
> DT to get the device base address. Other processor variants still rely
> on the compile time constants.

Looking at sh_eth.h , it seems to me that every processor that is 
currently supported can already pull the address from DT (Gen2, RZ/A1, 
Gen3 V3H), the rest of the CPUs are not supported. Maybe the 
BASE_IO_ADDR can be dropped outright instead ?

> And good news, as I wrote in some cover
> email, this driver is with this patch known to work in multi-port
> configuration since RZ/A2 GR-Peach is using ch0 with MII and RZ/A2
> RZA2MBTC is using ch1 RMII. The configuration all comes from DT.

That is nice.
