Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F3D3C3DA7F
	for <u-boot@archiver.kernel.org>; Mon,  5 Aug 2024 09:02:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E60587C7E;
	Mon,  5 Aug 2024 11:02:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="F6LH0NJz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7191387C7E; Mon,  5 Aug 2024 11:02:17 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAF6D8708B
 for <u-boot@lists.denx.de>; Mon,  5 Aug 2024 11:02:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=32c7=PE=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1722848531;
 bh=V/CPS7IxTty7rXhRw7ya/og3zLPoae30cBNdlsgLriQ=;
 b=F6LH0NJzUEkjhk3tuZ6OhfyL04euKXpNhSJ8aHXiYcA4774u7IFVC9W7bRk35D45FaifqFXlB
 WeTuQIlIit6KqtJa+n+nu9Fzlz5xsfj4EkNgmGrSBQnKQ2xzvR3ddB2KSK97xeVbezJHLmzed36
 d3GXUlMeyJk2OshgofbYhLYjY/q8j9TiSKjlLKWhSSly8vZzPQ8h18I+8E7r2r49rOgeSCDG1z5
 onUBYT8be9LbId8VKS4lm58StBSSe5+9xZ5nLEkgr0Qw7YE3C9WcwWaX3/WV1Hq+ysiafysqBHN
 IpfeAJ19tacIAR12B6fXkkr//0I5DuNCbpN9OIFiyRwQ==
Message-ID: <5e9cd0ac-bc0b-4c82-aa3e-93339d43b1f1@kwiboo.se>
Date: Mon, 5 Aug 2024 11:02:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: ns16550: Try get serial clock rate from DT before
 CLK
To: Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240804150955.3521296-1-jonas@kwiboo.se>
 <b96a6544-05a9-46a0-8be0-379835a9c175@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <b96a6544-05a9-46a0-8be0-379835a9c175@cherry.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66b0951178a90fe6dad1e11b
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

Hi Quentin,

On 2024-08-05 09:19, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 8/4/24 5:09 PM, Jonas Karlman wrote:
>> Initializing a clock driver to read a known static clock rate can take
>> some time at U-Boot proper pre-reloc phase.
>>
>> Change to first try and read clock rate from DT to speed up boot time,
>> fall back to getting the clock rate from clock driver.
>>
>> This help reduce boot time by around:
>> - ~35ms on a Radxa ROCK Pi 4 (RK3399)
>> - ~15ms on a Radxa ZERO 3W (RK3566)
>> Time that is wasted getting a static rate known at compile time.
>>
> 
> I guess this also makes some board perform worse as well, the ones 
> without a clock-frequency set?

I do not expect that this change will add anything to existing boot
time, however in some circumstances it may reduce the boot time.

Before this change the rate was retrieved using first successful of:

1. clk_get_rate()
2. clock-frequency prop from DT
3. CFG_SYS_NS16550_CLK

This patch swap 1. and 2. so driver first will try to use any rate that
may have been defined in DT, thus possible skip a probe of the clock.

Boot time is only saved/reduced if the serial driver was the only device
that needed something from clock device in current phase.

As long as the DT contain correct rate in clock-frequency prop or no
such prop this patch is not expected to change anything.

Regards,
Jonas

> 
> The change seems sound to me, therefore
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> 
> Thanks!
> Quentin

