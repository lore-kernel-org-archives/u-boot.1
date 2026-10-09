Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA876CA601E
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 12:54:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6498A60680;
	Fri,  9 Oct 2026 12:54:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m_H3ezuOYvh7; Fri,  9 Oct 2026 12:54:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8B66960685
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791550484;
	b=XqGkhuE/XiLrkosDMP42RHIXueNF5Kvpd0O7ehQiUFXCgXcnTM5mhYofCOI9hIQVtwCt
	 HaL3WJzsdrYGNZHjwRjjLCa/Yq9sO34XyDqJnwhN9MLVxecEDTELUshwj/XPrM4WvtvtJ
	 VGj8HtHZyBKIxrgeCj4O+Hx9xiHmuXmLfSza0dBBlFko5z2GKLq2wGhmKmi4ytiIWcios
	 pRp6iwvE9N73e0Zh2ZeHpUtZ/p98ISeZgCox8DLIb78zt3V4OP67xoMqMBYNiOFUHQx5M
	 0OWBpEMGXmZEKmVAwaE6ehf3fiAkX6Vm08P3h+zCGzy7GwxUNUKvVCoXgkrdVWqj7TQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791550484;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-Forward-Email-ID:X-Forward-Email-Sender:
	 X-Forward-Email-Version:X-Forward-Email-Website:X-Complaints-To:
	 X-Report-Abuse:X-Report-Abuse-To:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=0kS5y6Url38sziUR5i0lX4ZTKkta2V5f36PTHKMwZ1c=;
	b=J+Olmk3JsQ7oeh6UMuOlZw8NB4elMTVJ+3pdhK6+dBoGEnluFJKzw8fbScRJecqDm8/1
	 GrbZJ3gMV7dVuOG+zQiZMZrXpCc7xMJzJztiUkNLnIQ5+43jqjkb/QQaooraDNaTHY+YB
	 S7RWOjVQoTEYsc9FpGLKv/jnQ0BsX1Gr+krt39uJJs7cEqTllz4XgwCBnsUZtKkUjGBuF
	 0lZJV+XuzkE1meoDXSZhmfuaQSc/C6mlcPct3phwvZPCcifh70DIdfic0/V+57aa2NjoE
	 Uu4I2Fngsh8ict6EGnTqC+O6Rp01UFoO4D+botTrv4nIYjd5W5W6c5HIa+nu3LiuZWQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791550484;
	bh=0kS5y6Url38sziUR5i0lX4ZTKkta2V5f36PTHKMwZ1c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YJjjs0f5o8RlI5imoIvDyBYqXKy3A7YOheCL8NW2FDTCaU/GfNKybrgou/DEnt+TJ
	 Lli9MGMfYf4o79FLmPkbXhFj4ducpyjUFmu9zcAaShrqjHpAiQfpUzd6AQqOoXD4zC
	 0iDrDuV5d3Dqp7E8ccZrHG9JuBRWgaTWxvhYVQ40JFgSAXXz1WdyEVm7wW1MlmS8pj
	 eF51FK6FXmiP00EIxkAXbeUyfYgtQ6rN313ca9braY4fN2LV0WatoPOChj/Saicddv
	 JWLpuE1+A6CGJLDNVox9awSv+c9eM2hFzo3Ckz47Zbwkzcv9PNHtD9Ez4c6spAI09r
	 W9+nqh2ow8oVw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8B66960685;
	Fri,  9 Oct 2026 12:54:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B23C01D2
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 12:54:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 986AB40849
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 12:54:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 29ejILHbaTqc for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 12:54:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DE51340827
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=149.28.215.223
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791550482;
 b=st2CWd9poEw/BxSbn07bDn6gDCN/2fvH+H5yonncHASUZzGPBEyUP4eEaSEAu8oCQVDE
 wC8B3v/h3sm9cLZofspC5IjZSKrQTHm70zeXR5Kotq9j9uuFjJdzDAxXt35AzWflLnbTn
 M2Nr3ELAI7rEj6rVRrVBfIMept2pOz5l8qtZWuLZFtgVTUu5MKzHb/tpVDKUEu4wQcBgC
 LlqzMTNaGQq/UtbNtGONba6J/m7hLwhCyW6fQjXLOSOmPEKC+FQ8r2UfVGb2NPPJkdvND
 o1RJKcYP9WQmt+S3EExFZ3hb+1YzoyDwKehiaK4ZpGIiULl1P5yi2xaK+OmapiRCZCw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791550482;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
 Cc:References:Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=0kS5y6Url38sziUR5i0lX4ZTKkta2V5f36PTHKMwZ1c=;
 b=TYcZyIqUVfyE+SFpGqY8xzJesskB/Ffk+HOlEeiaG9z88HA9+a73mBzbpWUyL5yMS7bC
 XBWVLYXnhbaBB2n6XxUTXJm2I/JayeVTQwuwHvMP4B/vNLe6lfaV2Mz5ATgzj9Wq22VbA
 1TMVpDudlMzmwe+HemZ6MZQUCLMPQO0GNJBC1swGd94jvxy1aswz0ZvEH/MMBExCUD60D
 CL4eU5DSxJnIHgrT4XheHDfqUUnXQNfNSXv5r3sU2avVI0BAt3uresG8idspqH338NW3M
 e0YXf4dedrNWJHCZlomS/GSplvHXRn0OL64rFkPlG14i+BdZw+aG4eQl+n0lYD2sBcg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=lvPDkvhf; 
 arc=none smtp.remote-ip=149.28.215.223
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=c672=ia=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=lvPDkvhf
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DE51340827
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 12:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1791550480;
 bh=0kS5y6Url38sziUR5i0lX4ZTKkta2V5f36PTHKMwZ1c=;
 b=lvPDkvhfQ7GYyPS7K33rSgc7JmgSHIfElruYytxwwEBov/3AHE1b6enoRLuBxSpwLzlBfx6yk
 QGtHR3kaVxjJp78ZI9NjiDQabA5N9SxrHO8hrjzoh6kFQzfQ6IdqMP396PXmXUlo6Wv9sHRzwtw
 AgOVqxxgJpsGSuncBq6z8xV27RBTpPRdoxkK9R0KaogAYhdLpUg4noBveVlh5e1BAah/RmDVPHz
 Cwgk5PAXomWdUiAxl3oQDj62tl8lHzL5RtXCUvLIHDKv/2z/EN0d1MCsHBnEjF91l11u+fQfx3y
 tlUzT4eEggUqjQ3QL5B9z6rIEZvdH9y/tylBiOQH7ymw==
X-Forward-Email-ID: 6ac8e40a9ca6acffe6216876
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.18.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <9634887a-544c-46f8-b842-5c59af782495@kwiboo.se>
Date: Fri, 9 Oct 2026 14:54:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] clk: rockchip: rk3576: Always init clocks in SPL build
To: Quentin Schulz <u-boot@0leil.net>, Alexey Charkov <alchark@flipper.net>
Cc: Kever Yang <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org
References: <20260804002643.2308515-1-jonas@kwiboo.se>
 <20260804002643.2308515-4-jonas@kwiboo.se>
 <CAKTNdwEtSCBWmMSh9DzSGZsrq0dtCA=kCXhBJC+p2b3GD176mw@mail.gmail.com>
 <d02d78ad-0116-4636-9b6b-4e3185f9edef@0leil.net>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <d02d78ad-0116-4636-9b6b-4e3185f9edef@0leil.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Quentin,

On 10/8/2026 5:03 PM, Quentin Schulz wrote:
> Hi Alexey, Jonas,
> 
> On 8/5/26 9:21 AM, Alexey Charkov wrote:
>> Hi Jonas,
>>
>> Thanks a lot for your work on this!
>>
>> On Tue, Aug 4, 2026 at 4:26 AM Jonas Karlman <jonas@kwiboo.se> wrote:
>>>
>>> The ore PLLs are only initialized in SPL on RK3576.
>>
>> /s/ore/core/ ?
>>
>>> Ensure clock driver is always probed after bind for SPL builds to
>>> initialize core PLLs and clocks in SPL phase on RK3576.
>>>
>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>> ---
>>>   drivers/clk/rockchip/clk_rk3576.c | 4 ++++
>>>   1 file changed, 4 insertions(+)
>>
>> Tested it with my 41MB Falcon Linux payload on a Flipper One (RK3576),
>> and it gives a very noticeable improvement in loading speed: time from
>> start of BL33 to initramfs goes down from ~20s to ~3s, which is quite
>> welcome :)
>>
> 
> OK but why this improvement? Which clock(s) is responsible for this 
> speed improvement? This sounds a bit like CPU OPPs without controlling 
> the regulator and it worries me, but maybe I'm wrong here?
> 
> Please help me understand what this actually fixes/helps with and how.

My understanding is that the CPU core clock (or other PLL) is running
very slow at default rate out of reset and this causes slow boot speeds.
Vendor U-Boot seem to also set CPU/PLL rates in very early boot phase.

Alexey likely have more details for the RK3576 specific case.

Regards,
Jonas

> 
> Cheers,
> Quentin

