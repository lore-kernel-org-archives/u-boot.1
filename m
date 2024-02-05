Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B4FC48292
	for <u-boot@archiver.kernel.org>; Mon,  5 Feb 2024 17:01:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F177B8792D;
	Mon,  5 Feb 2024 18:01:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="qeto3Xfk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF6EB8792D; Mon,  5 Feb 2024 18:01:42 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D87887887
 for <u-boot@lists.denx.de>; Mon,  5 Feb 2024 18:01:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4887=JP=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1707152475;
 bh=yUtLR/aB8PD7QG+Lsv/2ur5S9VXODpsKlHhWKqdHLxg=;
 b=qeto3XfkqzpIc+/HDnqBrj06D9CJ4upTXl6ZH4cOEZ6oGbh4YW0iSjw0MiNTeJiMGWyqFQ4bI
 6N+HrOGDQCWFh734z/b6c9gEYkKBi2m8ldtTMHm2+8L56OogBFZTkHpuZObauVLsGSzT42gjR06
 SQAh7TK2+cAeM4Dgghdr0cNDOxVTkwVobIAxeh1jg93RE3EE7K9VBBfJE0YXbBlL34AcD+PEzzv
 SaGaiEPmt+ylSAOnv0usO3RDFYeTg5c+BKNTpfhn0ifh+01R6mftl5C5+iCME0ue1V+oPV5tIyu
 CpM0mP0kU8oLnFFPL53mYL46HrriHYYkoUy9tt8aiqvA==
Message-ID: <39a349b2-8ddc-4806-94fe-79355aa7d5f0@kwiboo.se>
Date: Mon, 5 Feb 2024 18:01:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] rockchip: rk35xx: Remove use of eMMC DDR52 mode
Content-Language: en-US
To: Dragan Simic <dsimic@manjaro.org>, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Nicolas Frattaroli
 <frattaroli.nicolas@gmail.com>, Tom Rini <trini@konsulko.com>, Jagan Teki
 <jagan@amarulasolutions.com>, Andy Yan <andyshrk@163.com>, Tianling Shen
 <cnsztl@gmail.com>, Akash Gajjar <gajjar04akash@gmail.com>, Eugen Hristev
 <eugen.hristev@collabora.com>, Joshua Riek <jjriek@verizon.net>, Weizhao
 Ouyang <o451686892@gmail.com>, u-boot@lists.denx.de
References: <20240204205312.2342868-1-jonas@kwiboo.se>
 <20240204205312.2342868-2-jonas@kwiboo.se>
 <3ec22d95-ee0d-4a0b-8c0e-90067ba0dc32@theobroma-systems.com>
 <b889d4e3-f507-4520-a02e-212f4ce9c7c7@kwiboo.se>
 <66d3d8ad40cfce744e8b80c9ad0419eb@manjaro.org>
 <be5b2bd5-f855-4585-b59d-c6d0c1df16d4@theobroma-systems.com>
 <e1c70a4b74cd4da978e98927dc08485f@manjaro.org>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <e1c70a4b74cd4da978e98927dc08485f@manjaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65c1145a6947a057f4bd4a65
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

On 2024-02-05 14:51, Dragan Simic wrote:
> On 2024-02-05 14:45, Quentin Schulz wrote:
>> On 2/5/24 14:40, Dragan Simic wrote:
>>> On 2024-02-05 14:24, Jonas Karlman wrote:
>>>> On 2024-02-05 10:40, Quentin Schulz wrote:
>>>>> Shouldn't we also remove cap-mmc-highspeed?
>>>>>
>>>>> I assume this is for MMC_HS? Which we discovered doesn't work
>>>>> reliably?
>>>>
>>>> Writing in lower speeds on RK356x does work better then on RK3588,
>>>> however HS200 still seem to be more reliable overall and give more
>>>> speed.
>>>>
>>>> For RK3588 they could possible be removed, but since reading does 
>>>> work
>>>> and similar issue also existed in the fallback MMC legacy mode, I did
>>>> not see that cleanup as important, or maybe more correctly it did not
>>>> cross my mind to also remove these props :-), the fully broken ddr52
>>>> felt more important.
>>>>
>>>>> Since it could be in a different patch if you wanted to, for the
>>>>> changes in this patch:
>>>>
>>>> Agree, a possible cleanup of cap-mmc-highspeed props could be done in 
>>>> a
>>>> separate patch.
>>>>
>>>> Alternatively any missing and appropriate modes currently in
>>>> u-boot.dtsi
>>>> should be added to linux DT and they can then be synced back to 
>>>> U-Boot
>>>> and any override/addition dropped from u-boot.dtsi files.
>>>
>>> How about waiting until I fix the mode selection in the Linux kernel
>>> drivers?  As I noted already, that's already on my TODO list, and
>>> perhaps it would be good to test a bit again under Linux with those
>>> fixes applied, before actually removing the buggy modes from the
>>> kernel's RK356x and RK3588(s) SoC dtsi files.
>>
>> While I appreciate there's some work that can be done in the Linux
>> kernel for those low-speed modes, the properties in question are
>> removed only from U-Boot's DTS and your future patches for the kernel
>> wouldn't impact the bootloader anyway.
>>
>> The issue right now is that U-Boot is currently broken because of
>> those properties, which are only in U-Boot's DTS.
>>
>> Not sure exactly why we should waiting on Linux kernel patches for
>> merging work-arounds for U-Boot? What exactly are you suggesting we
>> wait for? What can improve the situation?
> 
> Ah, sorry for the confusion, let me clarify a bit...
> 
> I just replied to the Jonas's remark about the need to eventually
> have the same fixes and mode removals in the Linux kernel's SoC dtsi
> files.  In other words, all I wrote was about those changes, not
> about the changes on the U-Boot side.
> 
> Of course, there are no reasons for delaying these U-Boot fixes.

Short history about the added eMMC modes in u-boot.dtsi on RK35xx boards:

U-Boot defaults to not support HS200+ modes unless explicitly enabled in
Kconfig options and on top of that the driver require DT to have a
corresponding mode prop to make use of any mode faster than MMC legacy.

When I worked on eMMC fixes for RK3568 and support for RK3588 [1] I only
tested reading data using all modes.

Because reading data in all modes seem to work on the boards I tested on,
I eventually added the "missing" props to board u-boot.dtsi-files, so
that U-Boot could make use of faster modes. However, I opted to only
enable the HS200 Kconfig option on boards with embedded eMMC.

This has resulted in that most RK35xx boards now default to using the
fastest none HS200+ mode, i.e. DDR52 mode. They would also try to use a
faster mode as long as a HS200+ Kconfig option is enabled.

With the removal of mmc-ddr-1_8v prop in this series, at least the most
broken mode is avoided for all RK35xx boards. And with the HS200 Kconfig
option enabled by default, the required tuning in HS200+ mode should
automatically happen as long as eMMC module support HS200 mode. After
that writing in any supported lower speed seem to work OK.

In the case where HS200 is supported any read/write in lower speed seem
to work, so the modes provided by cap-mmc-highspeed prop is OK.

However, if HS200+ is not supported it does not really matter, first
write will fail in any remaining mode, the slowest legacy or the modes
provided by cap-mmc-highspeed prop.

Keeping the cap-mmc-highspeed prop at least make reading data faster
possible, and writing data is still semi-broken in any remaining mode.

In conclusion I suggest:

- We keep the cap-mmc-highspeed props in board u-boot.dtsi for now.

- The mmc mode props that has been added in board u-boot.dtsi and have
  been validated working with both U-Boot and linux should be added to
  board DT. e.g HS200+ props is missing in some board DT.

- When an updated board DT has been synced from linux, any override in
  board u-boot.dtsi should be dropped.

I am also fine with completely dropping cap-mmc-highspeed props now if
they cause issues not solved by the HS200 Kconfig option being enabled.

[1] https://patchwork.ozlabs.org/cover/1764606/

Regards,
Jonas
