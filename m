Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D908E95A82
	for <u-boot@archiver.kernel.org>; Sun,  8 Oct 2023 08:03:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFED2866AA;
	Sun,  8 Oct 2023 10:03:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="ERjbFpWS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4324F86579; Sun,  8 Oct 2023 10:03:51 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BFBB86579
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 10:03:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=6fed=FW=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: References: Cc:
 To: Subject: From: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1696752221;
 bh=neeP7I5dEii2hPStLUXrUr+j36pFIVXGul2SFJDryDI=;
 b=ERjbFpWS9KGEEzBsqK2en03XqyRxFwpp8u3Z2S6e/Iw3hWbVyCG6uw4aE6NyQFwiTxhIDz2qZ
 wsn2VTVcKiacZzx8D6Jv2kxiUf8qtYaqvvOx/Bnyj4GKXSMUiiV/O8u2UAemR4i3ObrlertC0MV
 2RPKq4alxDaETTAhzHIIDRLmP8A1KATXQq4Gi2wLDY5bgttDcMeQjKbMg0SSD3fACymWnXopRHm
 vywJOZK/h8qoEuJ9Jg2D/2M2z1r+j4dPDmtp7CdQhGw6zMXdXqLcVMC3B4JANLM8zpjPE75WbWG
 QUikz5lCFLhb0Gx0GSvZBptndRQTbVerWmG/Q2FNISxw==
Message-ID: <2df66bb7-7b3c-c885-adf8-d4fa2948c45b@kwiboo.se>
Date: Sun, 8 Oct 2023 10:03:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
From: Jonas Karlman <jonas@kwiboo.se>
Subject: Re: Pull request: u-boot-rockchip-20231007
To: Kever Yang <kever.yang@rock-chips.com>, trini@konsulko.com
Cc: u-boot@lists.denx.de
References: <20231007102658.568693-1-kever.yang@rock-chips.com>
 <0df00e4a-3fc3-a72f-8b1a-76b73d109e25@kwiboo.se>
 <6d685aaf-ac11-ff44-c3a6-204dab33b3d5@rock-chips.com>
Content-Language: en-US
In-Reply-To: <6d685aaf-ac11-ff44-c3a6-204dab33b3d5@rock-chips.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6522625dd9b9768cac6f6e89
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

On 2023-10-08 03:13, Kever Yang wrote:
> Hi Jonas,
> 
> On 2023/10/7 18:37, Jonas Karlman wrote:
>> Hi Kever,
>>
>> Looks like the following patch is missing:
>>
>> [v2,7/7] rockchip: rk3568-radxa-e25: Enable pcie3x1 node
>> https://patchwork.ozlabs.org/patch/1816145/
> 
> This patch set does not show in sorted order in the patchwork system.
> 
> I use the last patch(which is 6/7) to apply this series, but 
> unfortunately 7/7 is missing.
> 
> How do you send this patch set? All other patch sets looks OK in system.

I think there was an issue with the mail-server at the time, as a result
mails got delayed and patches ended up in a strange order.

Patchwork list them in wrong/strange order, trying to download the
series as a mbox seem to sort the patches in proper patch order.

> 
> I can pick this patch up later when merge other patches for next PR.

Great, I will re-send the missing patch after this PR has been merged.

Regards,
Jonas

> 
> 
> Thanks,
> 
> - Kever
> 
>>
>> from merged series:
>> [v2,0/7] rockchip: rk3568: Fix use of PCIe bifurcation
>>
>> Do you want me to send it as a new separate patch?
>>
>> Regards,
>> Jonas
>>
>> On 2023-10-07 12:26, Kever Yang wrote:
>>> Hi Tom,
>>>
>>> Please pull the updates for rockchip platform:
>>> - Add Board: rk3568 Bananapi R2Pro;
>>> - Update pcie bifurcation support;
>>> - dwc_eth_qos controller support for rk3568 and rk3588;
>>> - Compressed binary support for U-Boot on rockchip platform;
>>> - dts and config updates for different board and soc;
>>>
>>> CI:
>>> https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/pipelines/18047
>>>
>>> Thanks,
>>> - Kever
>>>
>>> The following changes since commit be2abe73df58a35da9e8d5afb13fccdf1b0faa8e:
>>>
>>>    Merge https://source.denx.de/u-boot/custodians/u-boot-riscv (2023-10-05 13:26:44 -0400)
>>>
>>> are available in the Git repository at:
>>>
>>>    https://source.denx.de/u-boot/custodians/u-boot-rockchip.git tags/u-boot-rockchip-20231007
>>>
>>> for you to fetch changes up to dd8d52c934e8858264f91e8e8e2d8c7d8b059dd7:
>>>
>>>    rockchip: rk356x-u-boot: Add bootph-all to i2c0_xfer pinctrl node (2023-10-07 16:52:48 +0800)
>>>
>>> ----------------------------------------------------------------
>>> FUKAUMI Naoki (5):
>>>        configs: rockchip: rock-pi-s: use default bootdelay (2s)
>>>        arm: dts: rockchip: sync DT for RK3588 series with Linux
>>>        arm: dts: rockchip: rock-5b: add support for PCIe3 and NVMe
>>>        configs: rockchip: rk3308: use CONFIG_DEFAULT_FDT_FILE
>>>        configs: rockchip: rk3308: enable CONFIG_OF_LIBFDT_OVERLAY
>>>
>>> Frank Wunderlich (1):
>>>        board: rockchip: Add Bananapi R2Pro Board
>>>
>>> Jonas Karlman (22):
>>>        pci: pcie_dw_rockchip: Configure number of lanes and link width speed
>>>        phy: rockchip: snps-pcie3: Refactor to use clk_bulk API
>>>        phy: rockchip: snps-pcie3: Refactor to use a phy_init ops
>>>        phy: rockchip: snps-pcie3: Add bifurcation support for RK3568
>>>        phy: rockchip: snps-pcie3: Add support for RK3588
>>>        phy: rockchip: naneng-combphy: Use signal from comb PHY on RK3588
>>>        rockchip: rk3568-nanopi-r5: Update defconfig for NanoPi R5C and R5S
>>>        rockchip: rk3568-nanopi-r5: Enable PCIe on NanoPi R5C and R5S
>>>        power: regulator: Only run autoset once for each regulator
>>>        rockchip: Port IO-domain driver for RK3568 from linux
>>>        rockchip: board: Add minimal generic RK3566/RK3568 board
>>>        net: dwc_eth_qos: Drop unused rx_pkt from eqos_priv
>>>        net: dwc_eth_qos: Return error code when start fails
>>>        net: dwc_eth_qos: Stop spam of RX packet not available message
>>>        net: dwc_eth_qos: Add glue driver for GMAC on Rockchip RK3568
>>>        net: dwc_eth_qos_rockchip: Add support for RK3588
>>>        configs: rockchip: Enable ethernet driver on RK356x boards
>>>        configs: rockchip: Enable ethernet driver on RK3588 boards
>>>        power: pmic: rk8xx: Use sysreset implementation of the poweroff command
>>>        rockchip: rk356x: Enable poweroff command
>>>        power: pmic: rk8xx: Fix power-on source check in SPL
>>>        rockchip: rk356x-u-boot: Add bootph-all to i2c0_xfer pinctrl node
>>>
>>> Joseph Chen (1):
>>>        regulator: rk8xx: Return correct voltage for buck converters
>>>
>>> Manoj Sai (4):
>>>        spl: fit: support for booting a GZIP-compressed U-boot binary
>>>        spl: fit: support for booting a LZMA-compressed U-boot binary
>>>        rockchip: Add support to generate GZIP compressed U-boot binary
>>>        rockchip: Add support to generate LZMA compressed U-boot binary
>>>
>>> Massimo Pegorer (3):
>>>        rockchip: Kconfig: Enable external TPL binary for rk3308
>>>        doc: rockchip: Update and improve info on rk3308, TPL and TF-A
>>>        configs: rockchip: add DOS_PARTITION to RK3308 boards defconfig
>>>
>>> shengfei Xu (1):
>>>        regulator: rk8xx: Return correct voltage for switchout converters
>>>
>>>   arch/arm/dts/Makefile                              |   1 +
>>>   arch/arm/dts/rk3568-bpi-r2-pro-u-boot.dtsi         |  19 +
>>>   arch/arm/dts/rk3568-bpi-r2-pro.dts                 | 852 +++++++++++++++++++++
>>>   arch/arm/dts/rk3568-generic-u-boot.dtsi            |  14 +
>>>   arch/arm/dts/rk3568-generic.dts                    |  38 +
>>>   arch/arm/dts/rk3568-nanopi-r5c-u-boot.dtsi         |   4 +
>>>   arch/arm/dts/rk3568-nanopi-r5c.dts                 |   2 +-
>>>   arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi         |  10 +-
>>>   arch/arm/dts/rk356x-u-boot.dtsi                    |   8 +
>>>   arch/arm/dts/rk3588-edgeble-neu6a-io-u-boot.dtsi   |   1 -
>>>   arch/arm/dts/rk3588-edgeble-neu6a.dtsi             |   1 -
>>>   arch/arm/dts/rk3588-edgeble-neu6b-io-u-boot.dtsi   |   6 -
>>>   arch/arm/dts/rk3588-edgeble-neu6b-io.dts           |  66 ++
>>>   arch/arm/dts/rk3588-edgeble-neu6b.dtsi             | 359 ++++++++-
>>>   arch/arm/dts/rk3588-evb1-v10.dts                   | 720 ++++++++++++++++-
>>>   arch/arm/dts/rk3588-rock-5b-u-boot.dtsi            | 142 ++--
>>>   arch/arm/dts/rk3588-rock-5b.dts                    | 448 ++++++++++-
>>>   arch/arm/dts/rk3588.dtsi                           | 215 ++++++
>>>   arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi           |  12 -
>>>   arch/arm/dts/rk3588s-rock-5a.dts                   | 665 +++++++++++++++-
>>>   arch/arm/dts/rk3588s-u-boot.dtsi                   | 162 ----
>>>   arch/arm/dts/rk3588s.dtsi                          | 367 +++++++++
>>>   arch/arm/dts/rockchip-u-boot.dtsi                  |  11 +
>>>   arch/arm/mach-rockchip/Kconfig                     |   3 +-
>>>   board/rockchip/evb_rk3568/MAINTAINERS              |  14 +
>>>   common/spl/spl_fit.c                               |  20 +-
>>>   configs/bpi-r2-pro-rk3568_defconfig                |  93 +++
>>>   configs/evb-rk3308_defconfig                       |   3 +-
>>>   configs/evb-rk3568_defconfig                       |   6 +-
>>>   configs/evb-rk3588_defconfig                       |   5 +-
>>>   configs/generic-rk3568_defconfig                   |  64 ++
>>>   configs/lubancat-2-rk3568_defconfig                |   3 +
>>>   configs/nanopi-r5c-rk3568_defconfig                |  18 +-
>>>   configs/nanopi-r5s-rk3568_defconfig                |  22 +-
>>>   configs/neu6a-io-rk3588_defconfig                  |   2 -
>>>   configs/neu6b-io-rk3588_defconfig                  |   2 -
>>>   configs/odroid-m1-rk3568_defconfig                 |   3 +
>>>   configs/quartz64-a-rk3566_defconfig                |   4 +
>>>   configs/quartz64-b-rk3566_defconfig                |   4 +
>>>   configs/radxa-cm3-io-rk3566_defconfig              |   6 +-
>>>   configs/roc-cc-rk3308_defconfig                    |   3 +-
>>>   configs/rock-3a-rk3568_defconfig                   |   6 +-
>>>   configs/rock-pi-s-rk3308_defconfig                 |   5 +-
>>>   configs/rock5a-rk3588s_defconfig                   |   5 +-
>>>   configs/rock5b-rk3588_defconfig                    |   4 +-
>>>   configs/soquartz-blade-rk3566_defconfig            |   3 +
>>>   configs/soquartz-cm4-rk3566_defconfig              |   3 +
>>>   configs/soquartz-model-a-rk3566_defconfig          |   4 +
>>>   doc/README.rockchip                                |  10 +-
>>>   doc/board/rockchip/rockchip.rst                    |  45 +-
>>>   drivers/misc/Kconfig                               |   9 +
>>>   drivers/misc/Makefile                              |   1 +
>>>   drivers/misc/rockchip-io-domain.c                  | 167 ++++
>>>   drivers/net/Kconfig                                |   8 +
>>>   drivers/net/Makefile                               |   1 +
>>>   drivers/net/dwc_eth_qos.c                          |  33 +-
>>>   drivers/net/dwc_eth_qos.h                          |   3 +-
>>>   drivers/net/dwc_eth_qos_rockchip.c                 | 531 +++++++++++++
>>>   drivers/pci/pcie_dw_rockchip.c                     |  58 +-
>>>   drivers/phy/rockchip/phy-rockchip-naneng-combphy.c |   6 +
>>>   drivers/phy/rockchip/phy-rockchip-snps-pcie3.c     | 230 ++++--
>>>   drivers/power/pmic/Kconfig                         |   1 +
>>>   drivers/power/pmic/rk8xx.c                         |  20 +-
>>>   drivers/power/regulator/regulator-uclass.c         |  18 +-
>>>   drivers/power/regulator/rk8xx.c                    |  95 ++-
>>>   include/configs/rk3308_common.h                    |   4 +-
>>>   include/dt-bindings/ata/ahci.h                     |  20 +
>>>   include/power/regulator.h                          |   1 +
>>>   include/spl.h                                      |  10 +
>>>   69 files changed, 5227 insertions(+), 472 deletions(-)
>>>   create mode 100644 arch/arm/dts/rk3568-bpi-r2-pro-u-boot.dtsi
>>>   create mode 100644 arch/arm/dts/rk3568-bpi-r2-pro.dts
>>>   create mode 100644 arch/arm/dts/rk3568-generic-u-boot.dtsi
>>>   create mode 100644 arch/arm/dts/rk3568-generic.dts
>>>   create mode 100644 configs/bpi-r2-pro-rk3568_defconfig
>>>   create mode 100644 configs/generic-rk3568_defconfig
>>>   create mode 100644 drivers/misc/rockchip-io-domain.c
>>>   create mode 100644 drivers/net/dwc_eth_qos_rockchip.c
>>>   create mode 100644 include/dt-bindings/ata/ahci.h


