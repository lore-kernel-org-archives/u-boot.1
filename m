Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7AA7C369C2
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 18:47:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A7DE80FA8;
	Tue, 22 Apr 2025 20:47:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="MostSkJI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B80D810E8; Tue, 22 Apr 2025 20:47:36 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B736380F9C
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 20:47:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=e320=XJ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1745347652;
 bh=1rspNmWskx5rw5+dzxYkC/THxr7cbB42zFlxA3WWY4o=;
 b=MostSkJIc/miOhZYjfdUBP2QWNY/WGQWwIkwpLNlYq/GCd5XjX/n3mXgMfjaJbRU8f/LVCVKn
 t94Z3SNno7vl5KZMAOU1MD0m5VSF8mjhXOKyDDFWc0ZlqlpFx8xHnNQ4MmE3iGpVPt/VXODqxFg
 gzzdXg8VvLSTPJ2t/yU+MfCrs6mb+VCMy8Ny8SR5AyfFxFFXrOmRMaQE537rv3OygUAEzszCtwu
 qed4ioVgwmcr3NFkZemRhSjIz5HE5M06TC0+fWi+YwXSeK+n9Q8HsXqB1Cp7zobpTeC7fV0wfAA
 RmJCXLMA7rGNvQPEDdMIpdF5xI7wV6hY/scqOyD2+AYA==
X-Forward-Email-ID: 6807e44078c55c57581d1457
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.0.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <1717bca9-02e4-4225-914c-33daa314bfbb@kwiboo.se>
Date: Tue, 22 Apr 2025 20:47:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Pull request: u-boot-rockchip-20250422
To: Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de
References: <20250422162945.26797-1-kever.yang@rock-chips.com>
 <35fcf81a-34d3-41b1-8e73-3243654b4e17@kwiboo.se>
 <20250422175253.GA5495@bill-the-cat>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250422175253.GA5495@bill-the-cat>
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

On 2025-04-22 19:52, Tom Rini wrote:
> On Tue, Apr 22, 2025 at 07:34:04PM +0200, Jonas Karlman wrote:
>> Hi Kever,
>>
>> This is missing "[v2,25/30] rng: rockchip: Add support for rkrng variant"
>> from the RK3528 series, should apply after you picked up the rng patches.
>>
>> https://patchwork.ozlabs.org/project/uboot/patch/20250407224743.2423921-26-jonas@kwiboo.se/
>>
>> Also please drop "rockchip: avoid rebuilding most binaries for
>> u-boot-rockchip-spi.bin" and pick up "[v6,0/7] rockchip: binman: Use a
>> template for FIT and other improvements" in its place.
>> Or should I rebase this series and include an indirect revert (all
>> changes in that patch is replaced with use of a fit template).
>>
>> https://patchwork.ozlabs.org/project/uboot/cover/20250413195949.432730-1-jonas@kwiboo.se/
> 
> Unless it's really hard on Kever's side, I would prefer a new clean PR
> (and follow up PR). Thanks!

I can see that most of my objection and discussion regarding that patch
was on v1 and not the picked up v2. Guess I missed the entire v2 of that
series and just continued to reply on the v1 thread instead, my bad ;-)

https://patchwork.ozlabs.org/project/uboot/patch/20250211-has_rom-u-boot-rockchip-spi-bin-v1-3-0d77f95b6239@cherry.de/

I am fine with whatever the patch is dropped or if I need to send a
rebased series that is merged, the end result will be that the changes
in the patch will be fully undone and instead replaced with use of a
template.

Regards,
Jonas

> 
>>
>> On 2025-04-22 18:29, Kever Yang wrote:
>>> Hi Tom,
>>>
>>> Please pull the updates for rockchip platform:
>>> - New SoC support: RK3528, RK3576
>>> - New Board support: rk3528 Radxa E20C, rk3576 Firefly ROC-RK3576-PC;
>>> - Add generic board for rk3288 and rk3399;
>>
>> Commits for the generic boards are also missing ;-)
>>
>> Regards,
>> Jonas
>>
>>> - rng driver binding update;
>>> - misc updates on board level or header files;
>>>
>>>
>>> CI:
>>> https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/pipelines/25886
>>>
>>> Thanks,
>>> - Kever
>>>
>>>
>>> The following changes since commit 185fdf5e94731df05748b1c576effb52ff7a3ec5:
>>>
>>>   fs/squashfs: avoid illegal free() in sqfs_opendir() (2025-04-21 11:08:03 -0600)
>>>
>>> are available in the Git repository at:
>>>
>>>   https://source.denx.de/u-boot/custodians/u-boot-rockchip.git tags/u-boot-rockchip-20250422
>>>
>>> for you to fetch changes up to 30ac31ab1f167f55bb1206e3ec95048b6fc88371:
>>>
>>>   rng: rockchip_rng: Update compatible for RK3588 (2025-04-22 23:31:02 +0800)
>>>
>>> ----------------------------------------------------------------
>>> Chukun Pan (2):
>>>       arm64: dts: rockchip: Add rk3528 QoS register node
>>>       arm64: dts: rockchip: enable SCMI clk for RK3528 SoC
>>>
>>> Elaine Zhang (2):
>>>       clk: rockchip: Add rk3576 clk support
>>>       reset: rockchip: implement rk3576 lookup table
>>>
>>> Heiko Stuebner (10):
>>>       rockchip: sdram: honor CFG_SYS_SDRAM_BASE when defining ram regions
>>>       ram: rockchip: Add rk3576 ddr driver support
>>>       rockchip: otp: Add support for RK3576
>>>       mmc: rockchip_sdhci: Add support for RK3576
>>>       mmc: rockchip_dw_mmc: Add support for rk3576
>>>       net: dwc_eth_qos_rockchip: Add support for RK3576
>>>       arm64: dts: rockchip: add rk3576 otp node
>>>       dt-bindings: arm: rockchip: Add Firefly ROC-RK3576-PC binding
>>>       arm64: dts: rockchip: Add devicetree for the ROC-RK3576-PC
>>>       rockchip: rk3576: Add support for ROC-RK3576-PC board
>>>
>>> Jonas Karlman (42):
>>>       rockchip: rk3308: Drop unused rk_board_init()
>>>       rockchip: Move imply TPL_ROCKCHIP_COMMON_BOARD under SoC Kconfig symbol
>>>       rockchip: Make ROCKCHIP_COMMON_STACK_ADDR depend on TPL
>>>       rockchip: Improve ARMv7 support for ROCKCHIP_COMMON_STACK_ADDR
>>>       rockchip: Move imply ROCKCHIP_COMMON_STACK_ADDR under SoC Kconfig symbol
>>>       rockchip: Move imply ROCKCHIP_EXTERNAL_TPL under SoC Kconfig symbol
>>>       rockchip: Add RK3576 support for ROCKCHIP_COMMON_STACK_ADDR
>>>       rockchip: rk3588: Use hptimer reg names in rockchip_stimer_init
>>>       rockchip: Remove partitions env variable for RK356x
>>>       rockchip: Remove partitions env variable for RK3588
>>>       rockchip: Ensure device settings is defined before rk3568_common.h
>>>       rockchip: Ensure device settings is defined before rk3588_common.h
>>>       rockchip: Use rk3568_common.h by default for RK356x boards
>>>       rockchip: Use rk3588_common.h by default for RK3588 boards
>>>       rockchip: rk3568: Drop BOARD_LATE_INIT from target config
>>>       rockchip: rk3588: Drop BOARD_LATE_INIT from target config
>>>       rockchip: Enable meminfo and rng commands for Generic RK3566/RK3568
>>>       rockchip: Enable meminfo and rng commands for Generic RK3588
>>>       arm64: dts: rockchip: Add pinctrl and gpio nodes for RK3528
>>>       arm64: dts: rockchip: Add SARADC node for RK3528
>>>       arm64: dts: rockchip: Add SDHCI controller for RK3528
>>>       arm64: dts: rockchip: Add uart0 pinctrl to Radxa E20C
>>>       arm64: dts: rockchip: Add leds node to Radxa E20C
>>>       arm64: dts: rockchip: Add user button to Radxa E20C
>>>       arm64: dts: rockchip: Add maskrom button to Radxa E20C
>>>       arm64: dts: rockchip: Enable onboard eMMC on Radxa E20C
>>>       ram: rockchip: Add basic support for RK3528
>>>       arm: dts: rockchip: Add rk3528-u-boot.dtsi
>>>       arch: arm: rockchip: Add initial support for RK3528
>>>       mmc: rockchip_sdhci: Extend variant configuration
>>>       mmc: rockchip_sdhci: Add initial support for RK3528
>>>       mmc: rockchip_sdhci: Gate clock for glitch free phase switching
>>>       rockchip: otp: Add support for RK3528
>>>       adc: rockchip-saradc: Add support for RK3528
>>>       phy: rockchip-inno-usb2: Add support for clkout_ctl_phy
>>>       phy: rockchip-inno-usb2: Add support for RK3528
>>>       net: dwc_eth_qos_rockchip: Add support for RK3528
>>>       board: rockchip: Add minimal generic RK3528 board
>>>       board: rockchip: Add Radxa E20C
>>>       rng: rockchip_rng: Add compatible for RK3568
>>>       rockchip: rk356x: Remove rng node from u-boot.dtsi
>>>       rng: rockchip_rng: Update compatible for RK3588
>>>
>>> Joseph Chen (1):
>>>       clk: rockchip: Add support for RK3528
>>>
>>> Nicolas Frattaroli (1):
>>>       arm64: dts: rockchip: Add rng node to RK3588
>>>
>>> Quentin Schulz (7):
>>>       rockchip: theobroma-systems: use HAVE_VENDOR_COMMON_LIB to simplify Makefile
>>>       rockchip: px30: enable RNG for all boards
>>>       rockchip: px30: add fdtoverlay_addr_r default value to support FDTO
>>>       rockchip: ringneck-px30: enable DT overlay support
>>>       rockchip: rk3399: do not generate u-boot.rom anymore
>>>       rockchip: rk3288: do not generate u-boot.rom anymore
>>>       rockchip: avoid rebuilding most binaries for u-boot-rockchip-spi.bin
>>>
>>> Steven Liu (2):
>>>       pinctrl: rockchip: Add support for RK3528
>>>       pinctrl: rockchip: support rk3576 pinctrl
>>>
>>> Xuhui Lin (2):
>>>       rockchip: mkimage: Add rk3576 support
>>>       arm: rockchip: Add RK3576 arch core support
>>>
>>> Yao Zi (3):
>>>       dt-bindings: clock: Document clock and reset unit of RK3528
>>>       arm64: dts: rockchip: Add clock generators for RK3528 SoC
>>>       arm64: dts: rockchip: Add UART clocks for RK3528 SoC
>>>
>>> Yifeng Zhao (1):
>>>       rockchip: mkimage: Add support for RK3528
>>
>> [snip]
>>
> 

