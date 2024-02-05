Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD27C4828D
	for <u-boot@archiver.kernel.org>; Mon,  5 Feb 2024 13:40:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5A6C86F8E;
	Mon,  5 Feb 2024 14:40:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="HEz3UkBo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83F03875E9; Mon,  5 Feb 2024 14:40:17 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F14D86F80
 for <u-boot@lists.denx.de>; Mon,  5 Feb 2024 14:40:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1707140413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+kmFt4ueFb0+xTivoh+TUNKobwkU0QWwIhpWBrYLEHo=;
 b=HEz3UkBotgCMXOajl33UWDIRneppD9LSzhUCExko/wM2Wy1Sqd6JJyGnpmkzgRWCTgGifV
 xNKUKB37cMGTN1edv9W7wxou9n9hLdiQslT54LLxUoq+guxO94SWolzolQzxFFllo38zVC
 PqJp6O6Vcedv3XV0YUTTy+c/MmrI2SLwHnesAxkW7nHQ5C2Enz4soQz7zhlCSJ3+mXaMvN
 hePUTcdjcIHYsxSQ8ofDAY67t+r9Eg7yR3/WSyaY3EEXyhFfzMbAn/kwblheG0em5n2EdW
 A5JjADHKDaXObWZ9CJpTgVssozOi23xdfzG3Q9l0aiZQxw3PO1lKjHJBBAumXA==
Date: Mon, 05 Feb 2024 14:40:11 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>, Kever Yang
 <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Nicolas Frattaroli
 <frattaroli.nicolas@gmail.com>, Tom Rini <trini@konsulko.com>, Jagan Teki
 <jagan@amarulasolutions.com>, Andy Yan <andyshrk@163.com>, Tianling Shen
 <cnsztl@gmail.com>, Akash Gajjar <gajjar04akash@gmail.com>, Eugen Hristev
 <eugen.hristev@collabora.com>, Joshua Riek <jjriek@verizon.net>, Weizhao
 Ouyang <o451686892@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/3] rockchip: rk35xx: Remove use of eMMC DDR52 mode
In-Reply-To: <b889d4e3-f507-4520-a02e-212f4ce9c7c7@kwiboo.se>
References: <20240204205312.2342868-1-jonas@kwiboo.se>
 <20240204205312.2342868-2-jonas@kwiboo.se>
 <3ec22d95-ee0d-4a0b-8c0e-90067ba0dc32@theobroma-systems.com>
 <b889d4e3-f507-4520-a02e-212f4ce9c7c7@kwiboo.se>
Message-ID: <66d3d8ad40cfce744e8b80c9ad0419eb@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

On 2024-02-05 14:24, Jonas Karlman wrote:
> On 2024-02-05 10:40, Quentin Schulz wrote:
>> On 2/4/24 21:53, Jonas Karlman wrote:
>>> Testing has shown that writing to eMMC using DDR52 mode does not seem 
>>> to
>>> work on RK356x and RK3588 boards.
>>> 
>>> A simple test of writing a single block to e.g. sector 0x4000 fails:
>>> 
>>>    # Rescan using DDR52 mode
>>>    => mmc rescan 4
>>> 
>>>    # Write a single block to sector 0x4000 fails with ERROR
>>>    => mmc write 20000000 4000 1
>>> 
>>> With the MMC_SPEED_MODE_SET Kconfig option enabled.
>>> 
>>> Fix this by removing the mmc-ddr-1_8v prop from sdhci nodes in 
>>> affected
>>> board u-boot.dtsi files.
>>> 
>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>> ---
>>> Changes in v2:
>>> - Update commit message
>>> 
>>> Link to v1: https://patchwork.ozlabs.org/patch/1891695/
>>> ---
>>>   arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi   | 1 -
>>>   arch/arm/dts/rk3566-quartz64-b-u-boot.dtsi   | 1 -
>>>   arch/arm/dts/rk3566-radxa-cm3-io-u-boot.dtsi | 1 -
>>>   arch/arm/dts/rk3566-soquartz-u-boot.dtsi     | 1 -
>>>   arch/arm/dts/rk3568-lubancat-2-u-boot.dtsi   | 1 -
>>>   arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi   | 1 -
>>>   arch/arm/dts/rk3568-odroid-m1-u-boot.dtsi    | 1 -
>>>   arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi    | 1 -
>>>   arch/arm/dts/rk3568-rock-3a-u-boot.dtsi      | 1 -
>>>   arch/arm/dts/rk3588-rock-5b-u-boot.dtsi      | 1 -
>>>   arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi   | 1 -
>>>   arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi     | 1 -
>>>   12 files changed, 12 deletions(-)
>>> 
>>> diff --git a/arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi 
>>> b/arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi
>>> index 11976fd3a6e0..930d660868bb 100644
>>> --- a/arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi
>>> +++ b/arch/arm/dts/rk3566-quartz64-a-u-boot.dtsi
>>> @@ -8,7 +8,6 @@
>>> 
>>>   &sdhci {
>>>   	cap-mmc-highspeed;
>> 
>> Shouldn't we also remove cap-mmc-highspeed?
>> 
>> I assume this is for MMC_HS? Which we discovered doesn't work 
>> reliably?
> 
> Writing in lower speeds on RK356x does work better then on RK3588,
> however HS200 still seem to be more reliable overall and give more 
> speed.
> 
> For RK3588 they could possible be removed, but since reading does work
> and similar issue also existed in the fallback MMC legacy mode, I did
> not see that cleanup as important, or maybe more correctly it did not
> cross my mind to also remove these props :-), the fully broken ddr52
> felt more important.
> 
>> 
>> Since it could be in a different patch if you wanted to, for the 
>> changes
>> in this patch:
> 
> Agree, a possible cleanup of cap-mmc-highspeed props could be done in a
> separate patch.
> 
> Alternatively any missing and appropriate modes currently in 
> u-boot.dtsi
> should be added to linux DT and they can then be synced back to U-Boot
> and any override/addition dropped from u-boot.dtsi files.

How about waiting until I fix the mode selection in the Linux kernel
drivers?  As I noted already, that's already on my TODO list, and
perhaps it would be good to test a bit again under Linux with those
fixes applied, before actually removing the buggy modes from the
kernel's RK356x and RK3588(s) SoC dtsi files.

I expect to continue my work on those kernel bugfixes in the next few
weeks.  I did some work already, but left it there, and now I'll pick
it up again.
