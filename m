Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25FD1FCC9A4
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 01:13:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 979E583CF3;
	Tue, 10 Mar 2026 02:13:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Yp0fAMly";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3112383F2A; Tue, 10 Mar 2026 02:13:31 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EED983BC8
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 02:13:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=2964=BK=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1773105207;
 bh=a9qICn+dMmNE5kR7iaBrcR89UUTXtVlI7EyBYJ7p698=;
 b=Yp0fAMlyyEEZiX1DZ+mpeIKJfaI4QsnLLIPb/FmxKxu9Ni0SzVZmY/1YT7qPewG9WsmfNEFgy
 rJbMK3WTe186ecCkxKPGNL47QhUs3bKJJfRmPN1wUKh0OFhd97W/KncZ8cJPS2t1bSz6W4JOcLO
 QUhTbpoaauGpTjKK8ubyav/MYfl2T563bSJCIynVuKg3OQEuW0QEc6C5CDK1CkoBpTd+ovp8HKk
 TAH8XGRCK3XPBDVzGrtV5HmNgUpE7/xWi+o0rSoFcG5D1uU9c7HOJO6fb+Dq+vxQ1oAcEgcuU9H
 CJ8uwm4/apODpUeT4Jts/1aklYzailayaO5a6H+ZtF7w==
X-Forward-Email-ID: 69af7034839af201e7176e17
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.6.49
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <f3c04c40-704a-47b4-888f-1f9f014a4f68@kwiboo.se>
Date: Tue, 10 Mar 2026 02:13:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/12] rockchip: Add initial support for RK3506
To: Kever Yang <kever.yang@rock-chips.com>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Aaron Griffith <aargri@gmail.com>, u-boot@lists.denx.de
References: <20260310005326.606079-1-jonas@kwiboo.se>
 <31bef0c7-cbeb-42f6-8d68-42c44276df36@rock-chips.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <31bef0c7-cbeb-42f6-8d68-42c44276df36@rock-chips.com>
Content-Type: text/plain; charset=UTF-8
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

Hi Kever,

On 3/10/2026 2:03 AM, Kever Yang wrote:
> Hi Jonas,
> 
>      This patch set V2 has been landed, please send the fix/new patches 
> instead if needed.

Sure, I can re-work the changes into a fixup series instead. I was not
really expecting anything Rockchip related to land for 2026.04 so this
caught me by surprise and I tried to send an email about this pending
v3 earlier today [1].

[1] https://lore.kernel.org/u-boot/71e54f48-2827-4b16-9f16-cbfe97b6ec0d@kwiboo.se/

Regards,
Jonas

> 
> 
> Thanks,
> - Kever
> On 2026/3/10 08:52, Jonas Karlman wrote:
>> This series add initial support for the Rockchip RK3506 SoC.
>>
>> Clk and pinctrl drivers have been imported from vendor U-Boot with
>> some adjustments and fixes.
>>
>> Upstream DT is currently not existing for RK3506, so this series does
>> not add support for any new boards, it only add initial arch support.
>>
>> Please see my U-Boot rk3506 branch at [1] for a few more commits that
>> add DTs and defconfig for e.g. Luckfox Lyra variants and ArmSoM Forge1.
>>
>> With this series, board DTs and defconfigs it should be possible to boot
>> into U-Boot proper (without OP-TEE) and still have support for MMC,
>> Ethernet, OTP, RNG, LEDs, buttons and USB gadget/host.
>>
>> Changes in v3:
>> - Add parentheses to mod checks to be consistent in clk driver
>> - Remove and add blank lines in pinctrl driver
>> - Remove unneeded rockchip_get_clk()
>> - Remove unneeded syscon_rk3506.c
>> - Add BOOTSOURCE_SPINOR mapping
>> - Update emmc/sdmmc comment
>> - Collect r-b tags
>>
>> Changes in v2:
>> - Use common handling of USB bootsource_id 0x81
>> - Re-sort the spl_infos list alphanumerically
>> - Drop use of struct rk3506_cru and of_to_plat() ops
>> - Define LOG_CATEGORY and use log_debug() in clk driver
>> - Extract rk3506_clk_init_xpl() from clk bind() ops
>> - Enable SPL_ARMV7_SET_CORTEX_SMPEN
>> - Fix mac1 and otg1 access to ddr memory
>> - Collect a-b and t-b tags (where applicable)
>>
>> [1] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commits/rk3506
>>
>> Finley Xiao (2):
>>    dt-bindings: clock: rockchip: Add RK3506 clock and reset unit
>>    clk: rockchip: Add support for RK3506
>>
>> Jonas Karlman (8):
>>    rockchip: spl: Add common handling of USB bootsource_id 0x81
>>    rockchip: mkimage: Re-sort the spl_infos list alphanumerically
>>    ram: rockchip: Add basic support for RK3506
>>    pinctrl: rockchip: Use syscon_regmap_lookup_by_phandle()
>>    rockchip: otp: Add support for RK3506
>>    phy: rockchip-inno-usb2: Add support for RK3506
>>    net: dwc_eth_qos_rockchip: Add support for RK3506
>>    arch: arm: rockchip: Add initial support for RK3506
>>
>> Xuhui Lin (1):
>>    rockchip: mkimage: Add support for RK3506
>>
>> Ye Zhang (1):
>>    pinctrl: rockchip: Add support for RK3506
>>
>>   arch/arm/include/asm/arch-rk3506/boot0.h      |    9 +
>>   arch/arm/include/asm/arch-rk3506/gpio.h       |    9 +
>>   arch/arm/include/asm/arch-rockchip/clock.h    |   10 +
>>   .../include/asm/arch-rockchip/cru_rk3506.h    |  181 +++
>>   arch/arm/mach-rockchip/Kconfig                |   44 +
>>   arch/arm/mach-rockchip/Makefile               |    1 +
>>   arch/arm/mach-rockchip/rk3506/Kconfig         |   15 +
>>   arch/arm/mach-rockchip/rk3506/Makefile        |    4 +
>>   arch/arm/mach-rockchip/rk3506/clk_rk3506.c    |    9 +
>>   arch/arm/mach-rockchip/rk3506/rk3506.c        |  126 ++
>>   arch/arm/mach-rockchip/rk3528/rk3528.c        |   15 -
>>   arch/arm/mach-rockchip/spl.c                  |   12 +-
>>   drivers/clk/rockchip/Makefile                 |    1 +
>>   drivers/clk/rockchip/clk_rk3506.c             | 1166 +++++++++++++++++
>>   drivers/misc/rockchip-otp.c                   |    4 +
>>   drivers/net/dwc_eth_qos.c                     |    4 +
>>   drivers/net/dwc_eth_qos_rockchip.c            |   86 ++
>>   drivers/phy/rockchip/phy-rockchip-inno-usb2.c |   20 +
>>   drivers/pinctrl/rockchip/Makefile             |    1 +
>>   drivers/pinctrl/rockchip/pinctrl-rk3506.c     |  462 +++++++
>>   .../pinctrl/rockchip/pinctrl-rockchip-core.c  |   46 +-
>>   drivers/pinctrl/rockchip/pinctrl-rockchip.h   |    1 +
>>   drivers/ram/rockchip/Makefile                 |    1 +
>>   drivers/ram/rockchip/sdram_rk3506.c           |   33 +
>>   drivers/reset/Makefile                        |    2 +-
>>   drivers/reset/rst-rk3506.c                    |  222 ++++
>>   drivers/usb/gadget/Kconfig                    |    1 +
>>   .../Bindings/clock/rockchip,rk3506-cru.yaml   |   55 +
>>   .../dt-bindings/clock/rockchip,rk3506-cru.h   |  285 ++++
>>   .../dt-bindings/reset/rockchip,rk3506-cru.h   |  211 +++
>>   include/configs/rk3506_common.h               |   38 +
>>   tools/rkcommon.c                              |    5 +-
>>   32 files changed, 3034 insertions(+), 45 deletions(-)
>>   create mode 100644 arch/arm/include/asm/arch-rk3506/boot0.h
>>   create mode 100644 arch/arm/include/asm/arch-rk3506/gpio.h
>>   create mode 100644 arch/arm/include/asm/arch-rockchip/cru_rk3506.h
>>   create mode 100644 arch/arm/mach-rockchip/rk3506/Kconfig
>>   create mode 100644 arch/arm/mach-rockchip/rk3506/Makefile
>>   create mode 100644 arch/arm/mach-rockchip/rk3506/clk_rk3506.c
>>   create mode 100644 arch/arm/mach-rockchip/rk3506/rk3506.c
>>   create mode 100644 drivers/clk/rockchip/clk_rk3506.c
>>   create mode 100644 drivers/pinctrl/rockchip/pinctrl-rk3506.c
>>   create mode 100644 drivers/ram/rockchip/sdram_rk3506.c
>>   create mode 100644 drivers/reset/rst-rk3506.c
>>   create mode 100644 dts/upstream/Bindings/clock/rockchip,rk3506-cru.yaml
>>   create mode 100644 dts/upstream/include/dt-bindings/clock/rockchip,rk3506-cru.h
>>   create mode 100644 dts/upstream/include/dt-bindings/reset/rockchip,rk3506-cru.h
>>   create mode 100644 include/configs/rk3506_common.h
>>

