Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9858D25932
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 04:36:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23FB883F70;
	Tue, 27 Jan 2026 05:36:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=freeshell.de header.i=@freeshell.de header.b="m/f3RGa+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 538F783F80; Tue, 27 Jan 2026 05:36:55 +0100 (CET)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE00483F6E
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 05:36:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1769488581;
 bh=SNtpjDZQxNJOvkXwUMTh7FgIy8YjzQmzJuP9xQeky+E=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=m/f3RGa+wrpTPn5ZIDa5s2QmWfnTuIaWU24MwnDQg73MAe++q7uEc65YyU3Mx4JxV
 L/+RllVUzgv4ORoncVJ86XL2OIXPRzLVsozEj9RcwdxYy3qCPUdaZwg1urCFYO2M9H
 mNizWcb461KU2Te7iaHXNpoWjdZvaQnZbSJIaxtOWehrqvJMZ+JcmOMqQT4fzsx46J
 Ejt1uuOYUfu8R37/PVkj4rS56kowifTWlsXsOtd2Q/HdivSgpvpQ919FV7yKidMiEJ
 eldPgKuLbqhdNhLztQLkQ/O5moGCbhUt2/ho+JgAvE6Ra0kjvyc64Vg49vpzB2D7XZ
 iHFbaWNxmgKSg==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 34F4EB220139;
 Tue, 27 Jan 2026 05:36:18 +0100 (CET)
Message-ID: <cb4bdf54-35cd-4638-8ce0-3fa9c0b5260d@freeshell.de>
Date: Mon, 26 Jan 2026 20:36:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/24] clk: clk-composite: Resolve parent clock by name
To: Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Marek Vasut <marex@denx.de>, Hal Feng <hal.feng@starfivetech.com>,
 Minda Chen <minda.chen@starfivetech.com>, Adam Ford <aford173@gmail.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@denx.de>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>, Peng Fan
 <peng.fan@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, uboot-imx@nxp.com, u-boot@lists.denx.de,
 E Shattow <e@freeshell.de>
References: <20250323160107.145749-1-marex@denx.de>
 <20250323160107.145749-15-marex@denx.de>
 <f6b85cb6-509c-46a8-984e-3881374ceb02@canonical.com>
 <9dbccbf2-39a7-48a0-9d2c-79de220c07f3@canonical.com>
 <CAFLszTh7-9a7F9h+knc1CMNvm8C=gXLZhLZ+W5eJDEZ_e5pc2A@mail.gmail.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <CAFLszTh7-9a7F9h+knc1CMNvm8C=gXLZhLZ+W5eJDEZ_e5pc2A@mail.gmail.com>
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

On 1/26/26 18:55, Simon Glass wrote:
> Hi Heinrich,
> 
> On Mon, 31 Mar 2025 at 05:14, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> On 30.03.25 17:15, Heinrich Schuchardt wrote:
>>> On 23.03.25 16:58, Marek Vasut wrote:
>>>> Use clock-names property which is accessible via parent clock OF node
>>>> to look up the parent clock by name instead of depending on unreliable
>>>> global clock name to perform look up.
>>>>
>>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>>
>>> This patch breaks booting starfive_visionfive2_defconfig in the SPL stage.
>>>
>>> To dig a bit deeper I enabled the debug UART for SPL with these setting
>>> on origin/master (5e74863ad6613df):
>>>
>>> CONFIG_DEBUG_UART=y
>>> CONFIG_DEBUG_UART_NS16550=y
>>> CONFIG_DEBUG_UART_BASE=0x10000000
>>> CONFIG_DEBUG_UART_CLOCK=24000000
>>> CONFIG_SPL_DEBUG_UART_BASE=0x10000000
>>> CONFIG_DEBUG_UART_SHIFT=2
>>>
>>> clk_register: failed to get pll0_out device (parent of perh_root)
>>> clk_register: failed to get pll0_out device (parent of qspi_ref_src)
>>> clk_register: failed to get pll0_out device (parent of usb_125m)
>>> clk_register: failed to get pll0_out device (parent of gmac_src)
>>> clk_register: failed to get pll0_out device (parent of gmac1_gtxclk)
>>> clk_register: failed to get pll0_out device (parent of gmac0_gtxclk)
>>>
>>> Marek assumes that property bootph-pre-ram might be missing for some
>>> clocks in arch/riscv/dts/jh7110-u-boot.dtsi.
>>
>> This change suggested by Marek resolves the issue:
>>
>> diff --git a/arch/riscv/dts/jh7110-u-boot.dtsi
>> b/arch/riscv/dts/jh7110-u-boot.dtsi
>> index ce7d9e16961..4ed764393bb 100644
>> --- a/arch/riscv/dts/jh7110-u-boot.dtsi
>> +++ b/arch/riscv/dts/jh7110-u-boot.dtsi
>> @@ -113,3 +113,7 @@
>>   &sys_syscon {
>>          bootph-pre-ram;
>>   };
>> +
>> +&pllclk {
>> +       bootph-pre-ram;
>> +};
> 
> I just hit this as well, thanks for the post.
> 
> However, -master still does not boot for me on vf2:
> 
> U-Boot SPL 2026.04-rc1 (Jan 26 2026 - 19:52:48 -0700)
> DDR version: dc2e84f0.
> Trying to boot from MMC2
> spl: partition error
> Error: -38
> SPL: Unsupported Boot Device!
> SPL: failed to boot from all boot devices
> ### ERROR ### Please RESET the board ###
> 
> Regards,
> Simon

Is this to be expected? ref:
https://docs.u-boot.org/en/latest/board/starfive/visionfive2.html#zero-stage-bootloader

The JH-7110 has enough SRAM to contain the unfiltered devicetree if you
would like to experiment without filtering to reduce size for the SPL.

Meanwhile though the uses of "sd card image" for U-Boot SPL to access
MMC are not anymore supported; transition to instead use the remaining
supported methods SPI Flash or UART Serial.

-E
