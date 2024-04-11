Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EF61C4345F
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 23:52:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 965F5881E7;
	Fri, 12 Apr 2024 01:52:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=flokli.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=flokli.de header.i=@flokli.de header.b="gJnCjgvB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94A2C881D6; Fri, 12 Apr 2024 01:52:41 +0200 (CEST)
Received: from mail.flokli.de (mail.flokli.de [116.203.226.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3209E881D6
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 01:52:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=flokli.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=flokli@flokli.de
Date: Fri, 12 Apr 2024 02:52:35 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flokli.de; s=mail;
 t=1712879557; bh=j+sGEEc02OSUnuZecJ0RNcWZ8wqZU4y5rTwPo/bs1vc=;
 h=Date:From:To:Cc:Subject;
 b=gJnCjgvBl4B4XyWPPd8ZF4nBOYcLgDRsTAQiFasqbNunPa55j0CeqLLuxpZQm2CHh
 ZQqFqdQNxX5atue+MVk6IP6BrkUlesi7fXXRFxj4PrI/+wxu67UU/NlijoILmyBbEQ
 6tQhzlmL93wQ1XgAEXcrrU3iiqYhxe7Qn+GypK0E=
From: Florian Klink <flokli@flokli.de>
To: Sam Edwards <cfsworks@gmail.com>
Cc: Joshua Riek <jjriek@verizon.net>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Jagan Teki <jagan@edgeble.ai>, Eugen Hristev <eugen.hristev@collabora.com>, 
 Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, John Clark <inindev@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Chris Morgan <macromorgan@hotmail.com>, 
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>,
 Johan Jonker <jbx6244@gmail.com>, 
 Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2] board: rockchip: Add the Turing RK1 SoM
Message-ID: <w3ylmzqfuvkdioxue67lfm7f6pr4kdtzrp2doj7hyvset35vii@6fva7xxc2bvj>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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

Hey Sam,

On 24-04-11 16:35:57, Sam Edwards wrote:
>On Thu, Apr 11, 2024 at 1:29 AM Florian Klink <flokli@flokli.de> wrote:
>>
>> On 23-12-14 18:46:47, Joshua Riek wrote:
>> >The Turing RK1 is a Rockchip RK3588 based SoM from Turing Machines.
>> >
>> >Specifications:
>> >
>> >    Rockchip RK3588 SoC
>> >    4x ARM Cortex-A76, 4x ARM Cortex-A55
>> >    8/16/32GB memory LPDDR4x
>> >    Mali G610MC4 GPU
>> >    32GB eMMC HS400
>> >    2x USB 2.0, 2x USB 3.0
>> >    2x MIPI CSI 4x lanes
>> >    1x MIPI-DSI DPHY 2x lanes
>> >    PCIe 2.0 x1, PCIe 3.0 x4
>> >    1x HDMI 2.1 output, 1x DP 1.4 output
>> >    Gigabit Ethernet
>> >    Size: 69.6mm x 45mm (260-pin SO-DIMM connector)
>> >
>> >Kernel commit:
>> >2806a69f3fef ("arm64: dts: rockchip: Add Turing RK1 SoM support")
>>
>> […]
>>
>> >diff --git a/configs/turing-rk1-rk3588_defconfig b/configs/turing-rk1-rk3588_defconfig
>> >new file mode 100644
>> >index 0000000000..289f2da775
>> >--- /dev/null
>> >+++ b/configs/turing-rk1-rk3588_defconfig
>> >@@ -0,0 +1,133 @@
>> >+CONFIG_ARM=y
>> >+CONFIG_SKIP_LOWLEVEL_INIT=y
>> >+CONFIG_SYS_HAS_NONCACHED_MEMORY=y
>> >+CONFIG_COUNTER_FREQUENCY=24000000
>> >+CONFIG_ARCH_ROCKCHIP=y
>> >+CONFIG_TEXT_BASE=0x00a00000
>> >+CONFIG_SPL_LIBCOMMON_SUPPORT=y
>> >+CONFIG_SPL_LIBGENERIC_SUPPORT=y
>> >+CONFIG_NR_DRAM_BANKS=2
>> >+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>> >+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc00000
>> >+CONFIG_SF_DEFAULT_SPEED=24000000
>> >+CONFIG_SF_DEFAULT_MODE=0x2000
>> >+CONFIG_DEFAULT_DEVICE_TREE="rk3588-turing-rk1"
>> >+CONFIG_ROCKCHIP_RK3588=y
>> >+CONFIG_SPL_ROCKCHIP_COMMON_BOARD=y
>> >+CONFIG_ROCKCHIP_SPI_IMAGE=y
>>
>
>Hi Florian,
>
>Thanks for getting in touch!
>
>> Does the RK1 have an SPI chip attached, and is is possible to flash
>> u-boot into SPI and boot from it?
>
>The answer you want is "no." Though the RK1 does have an unpopulated
>pad for SPI flash, actually installing one would be a pretty involved
>user modification, and those users almost certainly can/will build the
>SPI boot image themselves.
>
>> This has sparked some confusion on whether "u-boot-rockchip-spi.bin"
>> should be provided in a downstream build or not.
>
>Ah yeah the CONFIG_ROCKCHIP_SPI_IMAGE=y might not be a sensible
>default given that 99.9% of users don't need it. Is that config entry
>the main thing creating the confusion? I think it should be removed
>here in U-Boot if so.

Yes, it caused a "u-boot-rockchip-spi.bin" to be produced, and we were
wondering on whether it should be provided as a result of our build to
downstream users [1].

Removing it from the `defconfig` sounds like the best way to prevent
this confusion. If people solder on a SPI Flash manually, they probably
know how to re-add it to the uboot config ;-)

Could you send a patch for that?

>Note that the RK1 is a little different from most RK3588 boards in
>that UART9 at 115200 baud is the generally-accepted debug UART (due
>both to the popularity of pairing it with the Turing Pi 2
>clusterboard, and for pin-compatibility with most NVIDIA Jetson SoMs),
>and setting this very early in boot requires using Rockchip's
>"ddrbin_tool" to change the configuration embedded in the ddrbin/TPL
>image. If you're already supporting other targets that require ddrbin
>configuration changes, please add these for RK1:
>
>uart id=9
>uart iomux=0
>uart baudrate=115200
>
>...but if this would require going significantly out of your way,
>don't worry about it. IIUC this is only required to get TPL+SPL output
>routed correctly: the U-Boot monitor + kernel will still
>(re)initialize UART9 appropriately.

We currently simply use
`bin/rk3588_ddr_lp4_2112MHz_lp5_2400MHz_v1.16.bin`
from https://github.com/rockchip-linux/rkbin for all RK3588 targets as
`ROCKCHIP_TPL`.

There doesn't seem to be a RK1-specific blob in the repo, and so far
we're not invoking the closed-source x86_64-linux-only
`tools/ddrbin_tool` binary to produce an alternative version of the SPL
for other targets either.

So if it also works without doing that (maybe with a little bit less
debug serial output during early boot) we'd probably keep it like this
;-)

Thanks,
Florian

[1]: https://github.com/NixOS/nixpkgs/pull/302138#discussion_r1560349114
