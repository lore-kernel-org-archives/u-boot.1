Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EF7606A31F
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=p66JzgaO;
	dkim=pass (2048-bit key, unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=etsPaAN5
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D33BB6060B;
	Wed, 28 Oct 2026 14:17:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ol1tdmGr7JSi; Wed, 28 Oct 2026 14:17:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C1B31605EB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793197039;
	b=oCbE1dIOTOp8mBEaweWNIcScvwi70ajcG3g9/55jozqTtbbl4rareQ/YMJ6JXGAhqQP8
	 +YhKnzq9Yvbb4JPA3qlDZuZw9Fbrb9uJd6ax2dtoXM7sH9zKYkUxeEdN19gPZDQK48UCj
	 P0Ce5Am5VhIYFeoe5RjQhDdzbAIn3skV+o35rL2tmzk2WP8j7n7ehobeswBFCxpaFYGnY
	 /EgBjMMWQ20nPFkIiWWUH/GeOQ84fDsF5tJf5e6J3ot01FgY61OCfMDvYwUDLHuYSmlP/
	 8gnoL791P2devhe+TPbju+Tfr6y356lNh3mEh6UALxFIHAFKFCGv2Z/AVkeesPtQxWA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793197039;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=qNvbJiOksVVi3k1IONB0asNbg2eUtda9xcr6TNiFwtc=;
	b=WW/UNZ6YWmQ80R8n8xsoMyw7sh+1eXuyufy+mZdhODcbPMUR2HUdUaalO9cwXP3BVic9
	 +H34TtMQuOy5OZDdG7Ny2gZAmag4gTnOq0vKYUHjA3teH73ZQKC1hRcrF+Qrywwx8ZlF/
	 Aq64lNg8+8dNM60Sk4dzLEjbNOwn5bJayQYagPsHvStvcCbH2C4P3u+c8PyxHErbKlYCx
	 fI4zkcqz/Z1CrYqgJFYeOUr7eKP2cUsE2SD3C2sgQwU3TqQ5+xWb02GUNdw+2CFPa6N0x
	 xoZ3/M1oh8BU/S/innvrBSLPlCQ0Z7oC9Zyzd8BCMCCOd0+RdLBa9cUwE58pcW2Xp/w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793197039;
	bh=qNvbJiOksVVi3k1IONB0asNbg2eUtda9xcr6TNiFwtc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p66JzgaO3pL0DOo1UCJKWY6BvKd0E+0MjlLsVuN0a4GHQS1a0pAIIQ6LnFYz2qWYb
	 CAyhi98na71QMIuEB+P+zdJhk3zDmY9fwcCPX4xQVC4j0WDGcBNYIwEhH6ZO27+3Hz
	 wdTWLqINYX4n1qWm9oWOwE/KymETKAm3FKuOhnbIT7ATYvBFJAT4J6PoooldhpVdZD
	 u3nVB9ZS6ybKFF3gb8DqXM+qXxQba30/acS1j/URDCjkyJpr6WhBSmgEvwaJvR43XW
	 7QmeePSr09cgsOi0CuiVLD7uzET/6Y5HW7yShsGVRPE1e4Otm+cd8WFRciYjUWkjTF
	 PeGC3rXmxto3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C1B31605EB;
	Wed, 28 Oct 2026 14:17:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9CE924D1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:17:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 82BB140557
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:17:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fgSx2g_n-UU2 for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:17:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BA6FA40550
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:1600:19:7ff8::42ae"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793197037;
 b=R3kdVSQZdtoCDwnPABi0R3iWEkPSNKdlDTesyPAeKcqkksB8iXiubnTsLnofEBJeRyVc
 +gz/K9fQ8AdXe5Fj4ybcwaaHfXI5GqBjipHDn3gQve1kQagNUueQopPrefOWAka5CtbyX
 DmB7rtaPx0ZEH400YZHpmFPKf3P6fXc+/j0FldTRUMntX0d+VAKJGoEIh6bm6xgZRSqml
 wWxsL1Qe9JlRuMxw2gFjrsWjOx3UiMt2Uls8AP51zY+cpar3EX3nAsrFpeGzrHGdkrWLW
 qsueWvlQFLTdXSBYnrNw2A6q3Va31AeGAf2YY4ZUopSj8QhqDuQfAjTg3e8FvJREloQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793197037;
 h=Received-SPF:Received:DKIM-Signature:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-Infomaniak-Routing;
 bh=qNvbJiOksVVi3k1IONB0asNbg2eUtda9xcr6TNiFwtc=;
 b=IeAVSwkp7Nl/VEWijLlCpYp00ypflIgN/a6fZd9B+ZwJnDjFWJ/X40iqNHpK97iZOfnQ
 vy4/p6eMSGwXASP8GwQMw1rdnndbNQVBlCDJtQmNFj9BgCqBGdJug6eGyX5mUVb+ma3R/
 6z/NOKK/GIPa4n6iFCnEiFB09UO3xMc3eXsGnrwUmBN5XqQwzAx/LETscZoFVv9TQpFeb
 vVvpYqoEQEsdKkEtQtKPZL7aEc7ziMOZlfHUGYncxfewoivzkK2ugQUM3yinurtlovK9/
 yUUn2uTIGgcJCaogliTHqJmfl71+6aPk5Vr+zX7hSvnn1dbP9FYOBMHVZujfEgBUbqg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=0leil.net;
 dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=etsPaAN5; 
 arc=none smtp.remote-ip="2001:1600:19:7ff8::42ae"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:7ff8::42ae; helo=smtp-42ae.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=etsPaAN5
Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch
 [IPv6:2001:1600:19:7ff8::42ae])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BA6FA40550
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:17:15 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jF8ZJ4fB9z1XF5;
 Wed, 28 Oct 2026 15:17:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1793197032;
 bh=qNvbJiOksVVi3k1IONB0asNbg2eUtda9xcr6TNiFwtc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=etsPaAN5p+hTByaqz8QWTIXiSJqU6ImERxEyOVv6K5eqbHIHTan5s47v831G5YtV5
 detwJdBefJ7FF5LtL5SsqAddcIaZQSgFcjJtAlEYur1/wciWbyCBpDrdnQ4S5Rdbz4
 +V9OL800Zz826f119mp1i5JgUesScwbuigp7Qzo2BXnCaqbFxNhzeZOZtM2d4Sq79+
 iZwJ8jApd0n5IhSSbNL9U7my7BUY9lEOwa6fDUHlKpYkAJaijYA0nxq7B91lLeuHED
 v7kpB5Vv1ouHFWpOSGsOPGdQQdMJgPTGc3+COy0VN89YYNCaha/nkfZ+nqEO/Ct8NY
 BUArhsRVFOdWw==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jF8ZH2cG5zJVj; Wed, 28 Oct 2026 15:17:11 +0100 (CET)
Message-ID: <42cd0d81-9f1a-4e2a-b906-0ba3a2c11004@0leil.net>
Date: Wed, 28 Oct 2026 15:17:10 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] rng: rockchip_rng: Enable clocks when reading data
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
References: <20261004211349.62883-1-jonas@kwiboo.se>
 <20261004211349.62883-3-jonas@kwiboo.se>
 <71957510-7b09-4d52-a45a-76cba3d8675e@0leil.net>
 <1f744efc-0c74-4669-b02b-7619eed61402@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <1f744efc-0c74-4669-b02b-7619eed61402@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jonas,

On 10/16/26 11:03 PM, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 10/16/2026 1:11 PM, Quentin Schulz wrote:
>> Hi Jonas,
>>
>> On 10/4/26 11:13 PM, Jonas Karlman wrote:
>>> The vendor TF-A blobs for RK3562 leave the TRNG and RK RNG clocks gated
>>> when returning to U-Boot proper.
>>>
>>> Try to enable clocks while reading or otherwise accessing TRNG/RKRNG
>>> regs to ensure random data can successfully be read on affected SoCs.
>>>
>>> This is not expected to have any impact on SoCs using a clock driver
>>> with unimplemented enable/disable ops.
>>>
>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>> ---
>> [...]
>>> @@ -306,6 +308,10 @@ static int rockchip_rng_read(struct udevice *dev, void *data, size_t len)
>>>    	if (!pdata->soc_data || !pdata->soc_data->rk_rng_read)
>>>    		return -EINVAL;
>>>    
>>> +	ret = clk_enable_bulk(&pdata->clks);
>>> +	if (ret && ret != -ENOENT)
>>
>> Because I was confused that clk_enable_bulk() could return -ENOENT,
>> maybe add a comment stating this is to catch clock drivers that
>> implement a .enable() callback and return -ENOENT for unsupported
>> clocks? RK3399 and PX30 seem to be the only one doing that on Rockchip.
>> Same comment for rockchip_rng_probe().
> 
> Correct, this is because existing .enable() ops may return -ENOENT for
> unsupported clocks, for pending SoC support in my rk3562 branch the
> clock drivers instead may return -ENOSYS for unsupported clocks.
> 
> I could possible add a patch that changes existing clock drivers to
> instead return -ENOSYS, then this check would be unnecessary. I will
> otherwise add a small comment here for a v2.
> 

We probably should document the expected negative values for specific 
errors so drivers know what to actually report instead of just picking 
one. This is something we should fix at the clock subsystem level.

I'm honestly confused by clk_enable and clk_enable_bulk having a 
different behavior for a clock that isn't supported by the clock driver 
(or if the driver doesn't have an .enable ops). clk_enable will return 
-ENOSYS on .enable ops being NULL, but clk_enable_bulk will happily eat 
the return code and return 0 if that's the case. clk_enable will return 
whatever the return code of the .enable ops is, even if it's -ENOSYS, 
but clk_enable_bulk will happily eat -ENOSYS and return 0. Same for the 
clk_disable, clk_disable_bulk.

But considering the above, yes, maybe returning ENOSYS in the Rockchip 
CRU drivers is the better option and I would not have much to say 
against the patch anymore (except that the clock subsystem seems really 
inconsistent and confusing, to me).

>> I'm also not entirely sure this is proper, shouldn't we rather implement
>> support for the clocks instead of just saying "it's fine, don't worry"?
>> I think only RK3399 would be impacted (as only RK3399 and PX30 clock
>> drivers implement an .enable, and PX30 DTS doesn't have clocks
>> specified), with missing support for HCLK_M_CRYPTO[01],
>> HCLK_S_CRYPTO[01], and SCLK_CRYPTO[01].
> 
> We typically do not need to have enable/disable support in Rockchip
> clock drivers, only for clocks that is disabled out of system reset, or
> as in the mentioned case, because TF-A on RK3562 disables these clocks
> before returning to U-Boot proper. Also we first should/need to have
> proper clk enable_count handling before we try to add new enable/disable
> ops for Rockchip clock drivers or we can very easily disable clocks that
> are needed by multiple devices.
> 

Yeah but this means we need to duplicate this work-around in all 
consumers of Rockchip CRU clocks, so they know how to handle enable for 
a clock that isn't supported by the driver. This doesn't scale.

>> While looking at it, I also saw that there are resets in the node, maybe
>> something we'll need to control in the future too?
> 
> Out of all RK SoCs I have been testing 'rng' command on, only the RK3562
> is having any kind of issue, and only because vendor TF-A blob
> explicitly disable the clocks used for crypto/rng block.
> 
> A different hack/workaround would be to ungate the affected clocks in
> RK3562 clock driver probe(), but that is something I rather avoid.
> 
>>
>>> +		return ret;
>>> +
>>>    	for (i = 0; i < len / RK_HW_RNG_MAX; i++, buf += RK_HW_RNG_MAX) {
>>>    		ret = pdata->soc_data->rk_rng_read(dev, buf, RK_HW_RNG_MAX);
>>>    		if (ret)
>>> @@ -317,6 +323,7 @@ static int rockchip_rng_read(struct udevice *dev, void *data, size_t len)
>>>    						   len % RK_HW_RNG_MAX);
>>>    
>>>    exit:
>>> +	clk_disable_bulk(&pdata->clks);
>>>    	return ret;
>>>    }
>>>    
>>> @@ -336,12 +343,22 @@ static int rockchip_rng_of_to_plat(struct udevice *dev)
>>>    static int rockchip_rng_probe(struct udevice *dev)
>>>    {
>>>    	struct rk_rng_plat *pdata = dev_get_priv(dev);
>>> -	int ret = 0;
>>> +	int ret;
>>> +
>>> +	ret = clk_get_bulk(dev, &pdata->clks);
>>> +	if (ret && ret != -ENOENT && ret != -ENOSYS)
>>
>> I think what you want is clk_bulk_get_optional() from the Linux kernel,
>> so please implement that in U-Boot. We have it for reset, clk (not for
>> bulk yet) and gpio, so this is the right way to go.
> 
> Hum, in U-Boot we have clk_get_bulk() and Linux have clk_bulk_get() with
> different set of parameters, so adding one more non-conformant clock
> function to U-Boot is not a can of worms I am willing to open ;-)
> 

Instead, we duplicate this logic across all drivers. See

drivers/phy/qcom/phy-qcom-usb-hs-28nm.c
drivers/phy/qcom/phy-qcom-usb-ss.c
drivers/reset/reset-uniphier.c
drivers/usb/dwc3/dwc3-generic.c
drivers/usb/host/dwc2.c
drivers/usb/host/ehci-msm.c
drivers/usb/host/xhci-dwc3.c
drivers/core/simple-pm-bus.c

for examples of optional clk_get_bulk() and

drivers/serial/ns16550.c
drivers/serial/serial_esp32.c
drivers/serial/serial_mt7620.c
drivers/serial/serial_omap.c

for examples of optional clk_get_by_index(). I don't find this to be a 
good idea. Especially as it makes reading the code quite difficult to 
follow.But since other drivers already do this, I cannot reasonably 
expect you to fix this now, so... fine :)

Please switch the existing .enable ops to return -ENOSYS on unsupported 
clocks for Rockchip drivers and update clk_enable_bulk() in the 
rockchip_rng driver to only check for a negative ret.

Cheers,
Quentin
