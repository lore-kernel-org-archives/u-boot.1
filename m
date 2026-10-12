Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94EC6CA9ED1
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 16:59:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4DB42606DE;
	Mon, 12 Oct 2026 16:59:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UwPo2gc13WQF; Mon, 12 Oct 2026 16:59:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5A5E860600
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791824394;
	b=B8TluOdDkW+FARW72XzKq1Db4Yr78HhlNoOCNAO0MUvxrYhi1WJrH9bW2ybEnkJNAZbd
	 9gm7XiabfiRg93e5zG0zKFFqeXcHi2GxVEV5/33UzXU03B5QHRIjBxH6XCo9i7gg0I21Q
	 Ocq/DGygoYs3GDu5u7CIg4QnkTwaTOfYjhD/qwRfiCRTi/QCTeTKQDs5zv34CGjmh9d5x
	 cy23rpKNXD0XZwi3yGrRNNrrLktTb6ItrKw3Nc+MSC4slU/tMXKQjMytpdStSChOXM5bp
	 BFHiRLAbhVa2b880foBxSIcBl0xG/sRteOcjUz2/eGk5VRlMhFTzdtw7qBmuLpx/G+g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791824394;
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
	bh=RivGk72bb3eRnCQ/t0BoknEJ608PLPB5wB1DQ+F7inU=;
	b=MlYRuZX5yF+07R7s/xg10H4Ka7SA1alJiz762HwBVPw1/JWUIFix7nAMKOqFLOnIOoy1
	 umpssOQh9aca+U4Og8g9XXmfPmQ7fBuqxgWjWbRqmdt+h0zFWPpvkXLuIErSkKc4CGuhP
	 64svh4bhpq0p/aEvJZL5yPAP8aqDbfk3VvCWNGKiYe72gYkx9zWK/C9WkidXbb1p5d34n
	 mn79j8YLkOUcrpxb+TqURALpRvvctNUFjX6aCA2IcBsgN0FCLfaV1vGyFmQCC2y1q996d
	 +L5kd5k0caEUB/9poEzSg2zSu2h0emIFOmOXpecM7jgmj2NzFPv1oX6mU5z0v1v4iSA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=kwiboo.se;
	dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=amXhmBgO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791824394;
	bh=RivGk72bb3eRnCQ/t0BoknEJ608PLPB5wB1DQ+F7inU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LEQmu193tu9AgrRZJgwYr8165GbbwZ0ed0jSdD3j/y2Z+U907xhPQP89HhyKfpWTf
	 75AO37FHE6jkTDgy66L2drXg8BtZMobhG+6pSrCviFSTZpWUc1pllviFVbMX7NOBHq
	 ELwfAoFqFjjmHI1lLe5NqsdJgLR3HAeHkxxUlFg7KlViYuiAzdj5rlHUGEznyLUhD/
	 sLJKJKXlSWkjroPUUvBzguXZ1k9wqOBhexZ3mXCABGfMjPAtLokVRPNF1AM347nEBO
	 CsIgV14LtAL5HOjEFkTwXR5M4aYNWLbDg1OdT3wq3PFUkU2vIHGEPNtkDuNA5Brk4w
	 M9SzkDOnynFmQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5A5E860600;
	Mon, 12 Oct 2026 16:59:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6030C156
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 16:59:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 45CFF60600
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 16:59:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1wi6o8IWXevj for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 16:59:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2A779605D1
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=149.28.215.223
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791824391;
 b=o5iHBBg4WdAzsb1WlW7Kbiab7C/o7CGPKA9TBGY+z4I4Xe+9RaPq0A0cxffcUc0fpv5Q
 WJFtg5ev/+xwdOKHwlUy4yRkCw66iM4oJK/qG64pRCAXh8M6ppt06Kky7zrDeeZ4t0Uwe
 7ySnska6CAGcp2UxgKD51has2QSXv9n07UNvnqOzLwA9fm/u/uEi0x9Qj9zXCGWnC+AkD
 RSP5J6I7uGeCu2DaizA691lxH7TsPEteqQxdTNiJA+Nztj/JlupaHJKgnjXX4DXr/Rc1e
 HNAsqSMik+AH0wsB2EhQGeeyGeTXSfXnH8uWbPRgD9xoH6I7RzW+aRDOfE00buBmSJQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791824391;
 h=Received-SPF:DKIM-Signature:X-Forward-Email-ID:
 X-Forward-Email-Sender:X-Forward-Email-Version:
 X-Forward-Email-Website:X-Complaints-To:X-Report-Abuse:
 X-Report-Abuse-To:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
 Cc:References:Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=RivGk72bb3eRnCQ/t0BoknEJ608PLPB5wB1DQ+F7inU=;
 b=QRR8DKnb0b4mF47xl8Wr6D150IKFUCQCOGlXylQhBMYZoJmzJxLTXM9PjaIG7LxCTAfv
 4Q4voW486ZEEZxW8X6qkJEg3FSG9OYYb6W/YrA5p8vdVoxDKD+JLIq3GaTo7E4lVbyP5b
 V9ajYOfCbhDHkmNIOmHA0k2s+ov/gZNp1wen17EIqrzzEecaymCztcPAu4k+YUwX4N3IE
 aLRL7xWvPZ4WhKrO2Jnh6po81tA1Yl0yW8pb6u/jRhXlCp8hz8bZ71jGfu0+mpEzvE76/
 t0c3R9erTzrk2u26xTf9ikwR6srd6mY+PGP9Ho7uKAITLiFb7xlyJswWIjvJSfonn3w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kwiboo.se;
 dkim=pass header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=amXhmBgO; 
 arc=none smtp.remote-ip=149.28.215.223
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=149.28.215.223;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=d90e=id=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se
 header.a=rsa-sha256 header.s=fe-e1b5cab7be header.b=amXhmBgO
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2A779605D1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 16:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1791824389;
 bh=RivGk72bb3eRnCQ/t0BoknEJ608PLPB5wB1DQ+F7inU=;
 b=amXhmBgO0z4NzOxaRM/3kFEP9Xwp/bMUoKWHm/qu6lqj8mYEWN3MUV8ZTYA4JpGZLR6EqXSEf
 tbA6KB7rlxEhrG8l2aUHmuQ8Q/rTUcrxPsr74ZeNEu7xvk2uTexxBeroPH2TaVi6IJO//n+vluv
 qic/oLExz7t3/t9389bqeakJjuTfNyKDBON5VIVQCrc1/5F23LfTEW6m/EFXApIgL5bBjvDbRuF
 C1ZqwX3bQPxCgpAgBLztO0F4pt0tGuopkqOBmAnGWdafIec6Bfe+RhSxntSS0WKD4zXBaiFrvLi
 mqf4TE1gBnc5QShVknBELE2iWa0e0xySlaq1mGfXVgiw==
X-Forward-Email-ID: 6acd11fc9395ed86e9c48e35
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.18.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <b20fed8c-4d7a-40bf-8e23-2c2440499f29@kwiboo.se>
Date: Mon, 12 Oct 2026 18:59:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] rockchip: Always init clocks in SPL build for
 RK35xx
To: Quentin Schulz <u-boot@0leil.net>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Lukasz Majewski <lukma@nabladev.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org
References: <20261012111552.1173161-1-jonas@kwiboo.se>
 <fdb4cc14-505c-4dfc-b6bb-4b13f7c84275@0leil.net>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <fdb4cc14-505c-4dfc-b6bb-4b13f7c84275@0leil.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 10/12/2026 6:11 PM, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 10/12/26 1:15 PM, Jonas Karlman wrote:
>> The RK35xx clock drivers typically initializes a few clocks when probed,
>> with some clocks only in SPL. However, the clock driver is only probed
>> on demand, so this initialization is fully skipped when no SPL consumer
>> requests a clock, e.g. when booting from RAM/USB.
>>
>> Prior to the commit c6bba31dbdd4 ("rockchip: spl-boot-order: Defer probe
>> of boot device") all boot devices where typically probed, with a side
>> effect that clock driver likely also where probed, prior to the SPL
>> boot_from_devices() call.
>>
>> This series flag RK35xx clock drivers to be probed after bind in SPL to
>> help ensure a deterministic probe and clock initialization behavior
>> prior to booting from devices.
>>
>> This should help restore old behavior, e.g. that SPLL is initialized on
>> RK3588 and CPU core rate is initialized on RK3576 when booting from
>> RAM/USB.
>>
>> The series may possible depend on the series "rockchip: Miscellaneous
>> RK35xx clock fixes" [1] for a clean apply.
>>
>> Changes in v2:
>> - Update cover letter and commit messages
>> - Collect r-b and t-b tags
>>
>> [1] https://patch.msgid.link/20261011222930.1085075-1-jonas@kwiboo.se/
>>
>> Jonas Karlman (4):
>>    clk: rockchip: rk3568: Always initialize clocks in SPL
>>    clk: rockchip: rk3588: Always initialize clocks in SPL
>>    clk: rockchip: rk3576: Always initialize clocks in SPL
>>    clk: rockchip: rk3528: Always initialize clocks in SPL
>>
> 
> The RK3506 clock driver is notably missing from this list of "RK35xx 
> clock drivers". I'm assuming this is because support for the RK3506 
> clock driver got merged after commit c6bba31dbdd4 ("rockchip: 
> spl-boot-order: Defer probe of boot device"), so it means if it's 
> broken, it just never worked in the first place and we should rather dig 
> into the problem instead of doing what we do for the other RK35xx SoCs, 
> was this your conclusion as well or did I just incorrectly extrapolate?

The RK3506 clock driver currently initialize a few clocks from bind()
in XPL :-S

So it is not affected, or rather it worked around the issue for USB/RAM
boot in a different way. Should probably have mentioned something about
the RK3506 situation in cover letter.

In my work-in-progress branch at [1] I have a "WIP: clk: rockchip:
rk3506: Rework early clock init" commit that re-work that clock init to
use similar probe-after-bind style. I likely just deferred rk3506 for a
future refactor series as it was already "working" and the diff to
change it was very different to the patches in this series.

[1] https://git.u-boot-project.org/u-boot/contributors/kwiboo/u-boot/-/commits/rk3562/drivers/clk/rockchip/clk_rk3506.c

Regards,
Jonas 

> 
> Cheers,
> Quentin

