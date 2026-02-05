Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF68EA7959
	for <u-boot@archiver.kernel.org>; Thu,  5 Feb 2026 03:14:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3472D83015;
	Thu,  5 Feb 2026 04:14:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=freeshell.de header.i=@freeshell.de header.b="bYXWvpQg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CFB98341A; Thu,  5 Feb 2026 04:14:56 +0100 (CET)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A67CE8063E
 for <u-boot@lists.denx.de>; Thu,  5 Feb 2026 04:14:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1770261266;
 bh=lglDbpoZGW7Kalj+MvUXvLAA2M3MJixqQ98l6JZJ2+E=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=bYXWvpQgZca/6qY1Syv6UaYD9fP9NQVDAgFnjLst+uJXi0K6P/dh0/IVoyJqj9MjG
 qvyng69X8WHNFwZhAnn2nxf3qYhBkKwRJd5oR60KDECVnst7UDNgPTY1/SZaKu/cHz
 SR6nXNbLjgcc5guskBejA3qeRcs71p866oJ/AQrENL3JecBXIT5Sof/JW5fe8wOlRW
 EyfygoX4ORNbDnIZ9tld/Sv1Y+VMvvyFWgZcVIc/WHQe+nB0/78wkq0AdEN/xgS//3
 lj609qADYYkN9E0Y4F5o2iXbcNstfRcOpavBDNpkq6iwZ5rJEppmuJXX2/ol9784o0
 df+y6n733TcSg==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id E2C04B220123;
 Thu,  5 Feb 2026 04:14:22 +0100 (CET)
Message-ID: <cccfa42b-d1cd-4766-a045-3ba322607987@freeshell.de>
Date: Wed, 4 Feb 2026 19:14:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/24] clk: clk-composite: Resolve parent clock by name
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Marek Vasut <marex@denx.de>, Hal Feng <hal.feng@starfivetech.com>,
 Minda Chen <minda.chen@starfivetech.com>, Adam Ford <aford173@gmail.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@denx.de>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>, Peng Fan
 <peng.fan@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, uboot-imx@nxp.com, u-boot@lists.denx.de
References: <20250323160107.145749-1-marex@denx.de>
 <20250323160107.145749-15-marex@denx.de>
 <f6b85cb6-509c-46a8-984e-3881374ceb02@canonical.com>
 <9dbccbf2-39a7-48a0-9d2c-79de220c07f3@canonical.com>
 <CAFLszTh7-9a7F9h+knc1CMNvm8C=gXLZhLZ+W5eJDEZ_e5pc2A@mail.gmail.com>
 <cb4bdf54-35cd-4638-8ce0-3fa9c0b5260d@freeshell.de>
 <CAFLszTijQe-+sxxowGUahG=rtQMJ0RHHkcfagybiPJHxA=-azQ@mail.gmail.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <CAFLszTijQe-+sxxowGUahG=rtQMJ0RHHkcfagybiPJHxA=-azQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Simon,

On 2/3/26 16:23, Simon Glass wrote:
> Hi E,
> 
> On Tue, 27 Jan 2026 at 17:36, E Shattow <e@freeshell.de> wrote:
>>
>> Hi Simon,
>>
>> On 1/26/26 18:55, Simon Glass wrote:
>>> Hi Heinrich,
>>>
>>> On Mon, 31 Mar 2025 at 05:14, Heinrich Schuchardt
>>> <heinrich.schuchardt@canonical.com> wrote:
>>>>
>>>> On 30.03.25 17:15, Heinrich Schuchardt wrote:
>>>>> On 23.03.25 16:58, Marek Vasut wrote:
>>>>>> Use clock-names property which is accessible via parent clock OF node
>>>>>> to look up the parent clock by name instead of depending on unreliable
>>>>>> global clock name to perform look up.
>>>>>>
>>>>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>>>>
>>>>> This patch breaks booting starfive_visionfive2_defconfig in the SPL stage.
>>>>>
>>>>> To dig a bit deeper I enabled the debug UART for SPL with these setting
>>>>> on origin/master (5e74863ad6613df):
>>>>>
>>>>> CONFIG_DEBUG_UART=y
>>>>> CONFIG_DEBUG_UART_NS16550=y
>>>>> CONFIG_DEBUG_UART_BASE=0x10000000
>>>>> CONFIG_DEBUG_UART_CLOCK=24000000
>>>>> CONFIG_SPL_DEBUG_UART_BASE=0x10000000
>>>>> CONFIG_DEBUG_UART_SHIFT=2
>>>>>
>>>>> clk_register: failed to get pll0_out device (parent of perh_root)
>>>>> clk_register: failed to get pll0_out device (parent of qspi_ref_src)
>>>>> clk_register: failed to get pll0_out device (parent of usb_125m)
>>>>> clk_register: failed to get pll0_out device (parent of gmac_src)
>>>>> clk_register: failed to get pll0_out device (parent of gmac1_gtxclk)
>>>>> clk_register: failed to get pll0_out device (parent of gmac0_gtxclk)
>>>>>
>>>>> Marek assumes that property bootph-pre-ram might be missing for some
>>>>> clocks in arch/riscv/dts/jh7110-u-boot.dtsi.
>>>>
>>>> This change suggested by Marek resolves the issue:
>>>>
>>>> diff --git a/arch/riscv/dts/jh7110-u-boot.dtsi
>>>> b/arch/riscv/dts/jh7110-u-boot.dtsi
>>>> index ce7d9e16961..4ed764393bb 100644
>>>> --- a/arch/riscv/dts/jh7110-u-boot.dtsi
>>>> +++ b/arch/riscv/dts/jh7110-u-boot.dtsi
>>>> @@ -113,3 +113,7 @@
>>>>   &sys_syscon {
>>>>          bootph-pre-ram;
>>>>   };
>>>> +
>>>> +&pllclk {
>>>> +       bootph-pre-ram;
>>>> +};
>>>
>>> I just hit this as well, thanks for the post.
>>>
>>> However, -master still does not boot for me on vf2:
>>>
>>> U-Boot SPL 2026.04-rc1 (Jan 26 2026 - 19:52:48 -0700)
>>> DDR version: dc2e84f0.
>>> Trying to boot from MMC2
>>> spl: partition error
>>> Error: -38
>>> SPL: Unsupported Boot Device!
>>> SPL: failed to boot from all boot devices
>>> ### ERROR ### Please RESET the board ###
>>>
>>> Regards,
>>> Simon
>>
>> Is this to be expected? ref:
>> https://docs.u-boot.org/en/latest/board/starfive/visionfive2.html#zero-stage-bootloader
>>
>> The JH-7110 has enough SRAM to contain the unfiltered devicetree if you
>> would like to experiment without filtering to reduce size for the SPL.
>>
>> Meanwhile though the uses of "sd card image" for U-Boot SPL to access
>> MMC are not anymore supported; transition to instead use the remaining
>> supported methods SPI Flash or UART Serial.
> 
> I'm not sure that I can make that work in my lab. I have a SPI-flash
> emulator for some boards, but it requires a special probe.
> 
> What is wrong with putting U-Boot on the SD card?

TL;DR recap the feature is retracted from newer official documentation,
new board designs do not have this capability, and apparent lack of
interest yet to press StarFive for GPL2.0+ compliance. The latter is
necessary else you're depending on "mystery" feature that was dropped
and is unsupported by the vendor for your testing fixture. I have ~100+
hours into the JH-7110 BootROM reverse-engineering effort that I'd like
to hand off for peer review.

> 
> Regards,
> Simon

Simon: You personally are one of the copyright holders I have identified
whose code is being ripped off by StarFive. Concurrently the
reverse-engineering of JH-7110 BootROM effort has a sizeable chunk ready
for peer-review but that is another topic;  there may or may not be
enough usable there but I think it'd be worth your time to review to
decide what you would like to do. Contact me off-list for discussion
about the r/e effort specifically.

-E
