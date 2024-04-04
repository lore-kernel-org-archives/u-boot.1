Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24197CD1292
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 12:06:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CDC188411;
	Thu,  4 Apr 2024 14:06:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1712232377;
	bh=sDzkDoJB9KQHuiSP1mav/xbY0Y9MP5ihwzbpeTAlUJg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gBLmoe71jw8sP21yc3+/Fh09AVWOznsy/iAd6G/IYf9fviGHAC1ccShLocweC7cls
	 1N4vvBcOmumiXUsUMCXVVKmKr5ol1wrfFv+Gh6gasi1WRQva8AMj0bhGhUwIKUJyZC
	 K52g5V9tW0i6F591RKetZ36qn0oJHIm0HBYS4ywC+zCzIaOvieCFLqKC48jDAa9k/X
	 OhO+wy0OPrw4A9lNc2NMYTS/TVlrgtA7lg//qQzzaRTsR8HfKfakT2KvdkZhzbFdSR
	 9ZtB7lTWlEWWABSJHUgLGZFAAQKM6LaiWmWHpJH8Uz8k+kduZ7kM6J9Kyw+o7sc5WX
	 cV0IsfiELELeQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37BC188440; Thu,  4 Apr 2024 14:06:16 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [80.241.59.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A66D687842
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 14:06:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4V9L1b2GdKz9sSd;
 Thu,  4 Apr 2024 14:06:11 +0200 (CEST)
Message-ID: <349d7838-eaeb-48ea-af1b-4c44b662dfac@denx.de>
Date: Thu, 4 Apr 2024 14:06:09 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3] arm: dts: kirkwood: Enable upstream DT on Kirkwood
 boards
Content-Language: en-US
To: Tony Dinh <mibodhi@gmail.com>, U-Boot Mailing List
 <u-boot@lists.denx.de>, Michael Walle <michael@walle.cc>
Cc: Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 Chris Packham <chris.packham@alliedtelesis.co.nz>,
 Dave Purdy <david.c.purdy@gmail.com>, Evgeni Dobrev
 <evgeni@studio-punkt.com>, Luka Perkov <luka@openwrt.org>,
 Siddarth Gore <gores@marvell.com>, Simon Guinot <simon.guinot@sequanux.org>,
 Stefan Herbrechtsmeier <stefan@herbrechtsmeier.net>,
 Walter Schweizer <swwa@users.sourceforge.net>
References: <20240401220817.9905-1-mibodhi@gmail.com>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20240401220817.9905-1-mibodhi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4V9L1b2GdKz9sSd
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

On 4/2/24 00:08, Tony Dinh wrote:
> Enable OF_UPSTREAM to use upstream DT and add marvell/ prefix to the
> DEFAULT_DEVICE_TREE for Kirkwood boards. And so we can directly build
> DTBs from dts/upstream/src/arm/marvell, and including *-u-boot.dtsi
> files from arch/arm/dts/ directory.
> 
> Background:
> 
> The following 2 commands and filters were used in the analysis to determine
> which upstream DTS and DTSI files can be used as they are, or need to have
> modified/created *-u-boot.dtsi for u-boot specific implementation, and
> which board should be opt-out from OF_UPSTREAM.
> 
> "git grep -li arch_kirkwood configs | xargs grep DEVICE_TREE | cut -d '"' -f2 | xargs -n1 sh -c 'diff -qs  arch/arm/dts/$1.dts dts/upstream/src/arm/marvell/$1.dts' sh | grep differ"
> "diff -qrbu arch/arm/dts/ dts/upstream/src/arm/marvell/ | grep kirkwood | grep ".dtsi ""
> 
> More detailed information can be found at:
> https://lore.kernel.org/u-boot/20240328021825.17935-1-mibodhi@gmail.com/T/#u
> 
> I've regression tested this patch with the Zyxel NSA325 (Kirkwood 88F6282)
> and Zyxel NSA310S (Kirkwood 88F6281). The Zyxel NSA325 board has a
> USB 3.0 controller attached to the PCIe bus. And the Zyxel NSA310S
> has an extensive overhaul in bindings and styles in upstream DTS version.
> 
> Tested-by: Michael Walle <michael@walle.cc> # on lschv2
> Acked-by: Sumit Garg <sumit.garg@linaro.org>
> Reviewed-by: Stefan Roese <sr@denx.de>
> 
> Signed-off-by: Tony Dinh <mibodhi@gmail.com>

Applied to u-boot-marvell/master

Thanks,
Stefan

> ---
> 
> Changes in v3:
> - Collect Reviewed/Tested/Acked-by tags.
> - Trim the commit description and point to lore.kernel.org for detailed information.
> - No change from the V2 patch.
> 
> Changes in v2:
> Remove unnecessary redefined OF_UPSTREAM and use "imply OF_UPSTREAM" for
> KW88F6281 and KW88F6192 SoCs.
> 
>   arch/arm/dts/kirkwood-dreamplug-u-boot.dtsi | 7 +++++++
>   arch/arm/dts/kirkwood-lschlv2-u-boot.dtsi   | 6 ++++--
>   arch/arm/dts/kirkwood-lsxhl-u-boot.dtsi     | 6 ++++--
>   arch/arm/dts/kirkwood-nsa325-u-boot.dtsi    | 7 +++++++
>   arch/arm/mach-kirkwood/Kconfig              | 2 ++
>   configs/SBx81LIFKW_defconfig                | 1 +
>   configs/SBx81LIFXCAT_defconfig              | 1 +
>   configs/d2net_v2_defconfig                  | 2 +-
>   configs/dns325_defconfig                    | 2 +-
>   configs/dockstar_defconfig                  | 2 +-
>   configs/dreamplug_defconfig                 | 2 +-
>   configs/ds109_defconfig                     | 2 +-
>   configs/goflexhome_defconfig                | 2 +-
>   configs/guruplug_defconfig                  | 2 +-
>   configs/ib62x0_defconfig                    | 2 +-
>   configs/iconnect_defconfig                  | 2 +-
>   configs/inetspace_v2_defconfig              | 2 +-
>   configs/lschlv2_defconfig                   | 2 +-
>   configs/lsxhl_defconfig                     | 2 +-
>   configs/nas220_defconfig                    | 2 +-
>   configs/net2big_v2_defconfig                | 2 +-
>   configs/netspace_lite_v2_defconfig          | 2 +-
>   configs/netspace_max_v2_defconfig           | 2 +-
>   configs/netspace_mini_v2_defconfig          | 2 +-
>   configs/netspace_v2_defconfig               | 2 +-
>   configs/nsa310s_defconfig                   | 2 +-
>   configs/nsa325_defconfig                    | 2 +-
>   configs/openrd_base_defconfig               | 2 +-
>   configs/openrd_client_defconfig             | 2 +-
>   configs/openrd_ultimate_defconfig           | 2 +-
>   configs/pogo_e02_defconfig                  | 2 +-
>   configs/pogo_v4_defconfig                   | 2 +-
>   configs/sheevaplug_defconfig                | 2 +-
>   33 files changed, 52 insertions(+), 30 deletions(-)
>   create mode 100644 arch/arm/dts/kirkwood-dreamplug-u-boot.dtsi
>   create mode 100644 arch/arm/dts/kirkwood-nsa325-u-boot.dtsi
> 
> diff --git a/arch/arm/dts/kirkwood-dreamplug-u-boot.dtsi b/arch/arm/dts/kirkwood-dreamplug-u-boot.dtsi
> new file mode 100644
> index 0000000000..59f19a211f
> --- /dev/null
> +++ b/arch/arm/dts/kirkwood-dreamplug-u-boot.dtsi
> @@ -0,0 +1,7 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +/ {
> +	aliases {
> +		spi0 = &spi0;
> +	};
> +};
> diff --git a/arch/arm/dts/kirkwood-lschlv2-u-boot.dtsi b/arch/arm/dts/kirkwood-lschlv2-u-boot.dtsi
> index 7fc2d7d3b4..cf33ff822e 100644
> --- a/arch/arm/dts/kirkwood-lschlv2-u-boot.dtsi
> +++ b/arch/arm/dts/kirkwood-lschlv2-u-boot.dtsi
> @@ -1,7 +1,9 @@
>   // SPDX-License-Identifier: GPL-2.0+
>   
> -&eth0 {
> -	status = "disabled";
> +/ {
> +	aliases {
> +		spi0 = &spi0;
> +	};
>   };
>   
>   &hdd_power {
> diff --git a/arch/arm/dts/kirkwood-lsxhl-u-boot.dtsi b/arch/arm/dts/kirkwood-lsxhl-u-boot.dtsi
> index 7fc2d7d3b4..cf33ff822e 100644
> --- a/arch/arm/dts/kirkwood-lsxhl-u-boot.dtsi
> +++ b/arch/arm/dts/kirkwood-lsxhl-u-boot.dtsi
> @@ -1,7 +1,9 @@
>   // SPDX-License-Identifier: GPL-2.0+
>   
> -&eth0 {
> -	status = "disabled";
> +/ {
> +	aliases {
> +		spi0 = &spi0;
> +	};
>   };
>   
>   &hdd_power {
> diff --git a/arch/arm/dts/kirkwood-nsa325-u-boot.dtsi b/arch/arm/dts/kirkwood-nsa325-u-boot.dtsi
> new file mode 100644
> index 0000000000..dec27b2a87
> --- /dev/null
> +++ b/arch/arm/dts/kirkwood-nsa325-u-boot.dtsi
> @@ -0,0 +1,7 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +&nand {
> +	partition@0 {
> +		/delete-property/ read-only;
> +	};
> +};
> diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
> index c2fff84a68..031d4e5ecd 100644
> --- a/arch/arm/mach-kirkwood/Kconfig
> +++ b/arch/arm/mach-kirkwood/Kconfig
> @@ -6,10 +6,12 @@ config FEROCEON_88FR131
>   config KW88F6192
>   	bool
>   	select ARCH_VERY_EARLY_INIT
> +	imply OF_UPSTREAM
>   
>   config KW88F6281
>   	bool
>   	select ARCH_VERY_EARLY_INIT
> +	imply OF_UPSTREAM
>   
>   config SHEEVA_88SV131
>   	bool
> diff --git a/configs/SBx81LIFKW_defconfig b/configs/SBx81LIFKW_defconfig
> index cc17a8b114..977daf9f09 100644
> --- a/configs/SBx81LIFKW_defconfig
> +++ b/configs/SBx81LIFKW_defconfig
> @@ -6,6 +6,7 @@ CONFIG_ARCH_KIRKWOOD=y
>   CONFIG_SYS_KWD_CONFIG="board/alliedtelesis/SBx81LIFKW/kwbimage.cfg"
>   CONFIG_TEXT_BASE=0x00600000
>   CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc8012000
> +# CONFIG_OF_UPSTREAM is not set
>   CONFIG_TARGET_SBx81LIFKW=y
>   CONFIG_ENV_SIZE=0x2000
>   CONFIG_ENV_OFFSET=0xC0000
> diff --git a/configs/SBx81LIFXCAT_defconfig b/configs/SBx81LIFXCAT_defconfig
> index 0612723298..9bc8614030 100644
> --- a/configs/SBx81LIFXCAT_defconfig
> +++ b/configs/SBx81LIFXCAT_defconfig
> @@ -6,6 +6,7 @@ CONFIG_ARCH_KIRKWOOD=y
>   CONFIG_SYS_KWD_CONFIG="board/alliedtelesis/SBx81LIFXCAT/kwbimage.cfg"
>   CONFIG_TEXT_BASE=0x00600000
>   CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc8012000
> +# CONFIG_OF_UPSTREAM is not set
>   CONFIG_TARGET_SBx81LIFXCAT=y
>   CONFIG_ENV_SIZE=0x2000
>   CONFIG_ENV_OFFSET=0xC0000
> diff --git a/configs/d2net_v2_defconfig b/configs/d2net_v2_defconfig
> index bb1bcb0aa3..69658a2ba7 100644
> --- a/configs/d2net_v2_defconfig
> +++ b/configs/d2net_v2_defconfig
> @@ -11,7 +11,7 @@ CONFIG_TARGET_NET2BIG_V2=y
>   CONFIG_ENV_SIZE=0x1000
>   CONFIG_ENV_OFFSET=0x70000
>   CONFIG_ENV_SECT_SIZE=0x10000
> -CONFIG_DEFAULT_DEVICE_TREE="kirkwood-d2net"
> +CONFIG_DEFAULT_DEVICE_TREE="marvell/kirkwood-d2net"
>   CONFIG_IDENT_STRING=" D2 v2"
>   CONFIG_SYS_LOAD_ADDR=0x800000
>   CONFIG_ENV_ADDR=0x70000
> diff --git a/configs/dns325_defconfig b/configs/dns325_defconfig
> index edfe92c5f3..b85f7cac8e 100644
> --- a/configs/dns325_defconfig
> +++ b/configs/dns325_defconfig
> @@ -10,7 +10,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc8012000
>   CONFIG_TARGET_DNS325=y
>   CONFIG_ENV_SIZE=0x20000
>   CONFIG_ENV_OFFSET=0xE0000
> -CONFIG_DEFAULT_DEVICE_TREE="kirkwood-dns325"
> +CONFIG_DEFAULT_DEVICE_TREE="marvell/kirkwood-dns325"
>   CONFIG_IDENT_STRING="\nD-Link DNS-325"
>   CONFIG_SYS_LOAD_ADDR=0x800000
>   # CONFIG_SYS_MALLOC_F is not set
> diff --git a/configs/dockstar_defconfig b/configs/dockstar_defconfig
> index 719fa3979e..7b5f19433a 100644
> --- a/configs/dockstar_defconfig
> +++ b/configs/dockstar_defconfig
> @@ -13,7 +13,7 @@ CONFIG_NR_DRAM_BANKS=2
>   CONFIG_TARGET_DOCKSTAR=y
>   CONFIG_ENV_SIZE=0x20000
>   CONFIG_ENV_OFFSET=0x80000
> -CONFIG_DEFAULT_DEVICE_TREE="kirkwood-dockstar"
> +CONFIG_DEFAULT_DEVICE_TREE="marvell/kirkwood-dockstar"
>   CONFIG_IDENT_STRING="\nSeagate FreeAgent DockStar"
>   CONFIG_SYS_LOAD_ADDR=0x800000
>   CONFIG_BOOTDELAY=3
> diff --git a/configs/dreamplug_defconfig b/configs/dreamplug_defconfig
> index 02a2635af8..8518eabcb2 100644
> --- a/configs/dreamplug_defconfig
> +++ b/configs/dreamplug_defconfig
> @@ -13,7 +13,7 @@ CONFIG_TARGET_DREAMPLUG=y
>   CONFIG_ENV_SIZE=0x1000
>   CONFIG_ENV_OFFSET=0x100000
>   CONFIG_ENV_SECT_SIZE=0x10000
> -CONFIG_DEFAULT_DEVICE_TREE="kirkwood-dreamplug"
> +CONFIG_DEFAULT_DEVICE_TREE="marvell/kirkwood-dreamplug"
>   CONFIG_IDENT_STRING="\nMarvell-DreamPlug"
>   CONFIG_SYS_LOAD_ADDR=0x800000
>   CONFIG_ENV_ADDR=0x100000
> diff --git a/configs/ds109_defconfig b/configs/ds109_defconfig
> index 304c098c99..ef805eca56 100644
> --- a/configs/ds109_defconfig
> +++ b/configs/ds109_defconfig
> @@ -14,7 +14,7 @@ CONFIG_TARGET_DS109=y
>   CONFIG_ENV_SIZE=0x10000
>   CONFIG_ENV_OFFSET=0x3D0000
>   CONFIG_ENV_SECT_SIZE=0x10000
> -CONFIG_DEFAULT_DEVICE_TREE="kirkwood-ds109"
> +CONFIG_DEFAULT_DEVICE_TREE="marvell/kirkwood-ds109"
>   CONFIG_SYS_LOAD_ADDR=0x800000
>   CONFIG_ENV_ADDR=0x3D0000
>   # CONFIG_SYS_MALLOC_F is not set
> diff --git a/configs/goflexhome_defconfig b/configs/goflexhome_defconfig
> index d577d5807b..53b2ce97e8 100644
> --- a/configs/goflexhome_defconfig
> +++ b/configs/goflexhome_defconfig
> @@ -13,7 +13,7 @@ CONFIG_NR_DRAM_BANKS=2
>   CONFIG_TARGET_GOFLEXHOME=y
>   CONFIG_ENV_SIZE=0x20000
>   CONFIG_ENV_OFFSET=0xC0000
> -CONFIG_DEFAULT_DEVICE_TREE="kirkwood-goflexnet"
> +CONFIG_DEFAULT_DEVICE_TREE="marvell/kirkwood-goflexnet"
>   CONFIG_IDENT_STRING="\nSeagate GoFlex Home"
>   CONFIG_SYS_LOAD_ADDR=0x800000
>   CONFIG_BOOTDELAY=3
> diff --git a/configs/guruplug_defconfig b/configs/guruplug_defconfig
> index 7cb649e29c..5371ee403b 100644
> --- a/configs/guruplug_defconfig
> +++ b/configs/guruplug_defconfig
> @@ -10,7 +10,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc8012000
>   CONFIG_TARGET_GURUPLUG=y
>   CONFIG_ENV_SIZE=0x20000
>   CONFIG_ENV_OFFSET=0xE0000
> -CONFIG_DEFAULT_DEVICE_TREE="kirkwood-guruplug-server-plus"
> +CONFIG_DEFAULT_DEVICE_TREE="marvell/kirkwood-guruplug-server-plus"
>   CONFIG_IDENT_STRING="\nMarvell-GuruPlug"
>   CONFIG_SYS_LOAD_ADDR=0x800000
>   # CONFIG_SYS_MALLOC_F is not set
> diff --git a/configs/ib62x0_defconfig b/configs/ib62x0_defconfig
> index 074384e387..32b0e1c395 100644
> --- a/configs/ib62x0_defconfig
> +++ b/configs/ib62x0_defconfig
> @@ -10,7 +10,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc8012000
>   CONFIG_TARGET_IB62X0=y
>   CONFIG_ENV_SIZE=0x20000
>   CONFIG_ENV_OFFSET=0xE0000
> -CONFIG_DEFAULT_DEVICE_TREE="kirkwood-ib62x0"
> +CONFIG_DEFAULT_DEVICE_TREE="marvell/kirkwood-ib62x0"
>   CONFIG_IDENT_STRING=" RaidSonic ICY BOX IB-NAS62x0"
>   CONFIG_SYS_LOAD_ADDR=0x800000
>   # CONFIG_SYS_MALLOC_F is not set
> diff --git a/configs/iconnect_defconfig b/configs/iconnect_defconfig
> index f7b74c4662..45ffbd92db 100644
> --- a/configs/iconnect_defconfig
> +++ b/configs/iconnect_defconfig
> @@ -13,7 +13,7 @@ CONFIG_NR_DRAM_BANKS=2
>   CONFIG_TARGET_ICONNECT=y
>   CONFIG_ENV_SIZE=0x20000
>   CONFIG_ENV_OFFSET=0x80000
> -CONFIG_DEFAULT_DEVICE_TREE="kirkwood-iconnect"
> +CONFIG_DEFAULT_DEVICE_TREE="marvell/kirkwood-iconnect"
>   CONFIG_IDENT_STRING=" Iomega iConnect"
>   CONFIG_SYS_LOAD_ADDR=0x800000
>   CONFIG_PCI=y
> diff --git a/configs/inetspace_v2_defconfig b/configs/inetspace_v2_defconfig
> index 2e8e3f3928..3fa7790d77 100644
> --- a/configs/inetspace_v2_defconfig
> +++ b/configs/inetspace_v2_defconfig
> @@ -11,7 +11,7 @@ CONFIG_TARGET_NETSPACE_V2=y
>   CONFIG_ENV_SIZE=0x1000
>   CONFIG_ENV_OFFSET=0x70000
>   CONFIG_ENV_SECT_SIZE=0x10000
> -CONFIG_DEFAULT_DEVICE_TREE="kirkwood-is2"
> +CONFIG_DEFAULT_DEVICE_TREE="marvell/kirkwood-is2"
>   CONFIG_IDENT_STRING=" IS v2"
>   CONFIG_SYS_LOAD_ADDR=0x800000
>   CONFIG_ENV_ADDR=0x70000
> diff --git a/configs/lschlv2_defconfig b/configs/lschlv2_defconfig
> index 99bdbc1483..ad060079a7 100644
> --- a/configs/lschlv2_defconfig
> +++ b/configs/lschlv2_defconfig
> @@ -15,7 +15,7 @@ CONFIG_ENV_SIZE=0x10000
>   CONFIG_ENV_OFFSET=0x70000
>   CONFIG_ENV_SECT_SIZE=0x10000
>   CONFIG_DM_GPIO=y
> -CONFIG_DEFAULT_DEVICE_TREE="kirkwood-lschlv2"
> +CONFIG_DEFAULT_DEVICE_TREE="marvell/kirkwood-lschlv2"
>   CONFIG_IDENT_STRING=" LS-CHLv2"
>   CONFIG_SYS_LOAD_ADDR=0x800000
>   CONFIG_HAS_BOARD_SIZE_LIMIT=y
> diff --git a/configs/lsxhl_defconfig b/configs/lsxhl_defconfig
> index bb0a5ddf50..b2d9f0c9d8 100644
> --- a/configs/lsxhl_defconfig
> +++ b/configs/lsxhl_defconfig
> @@ -16,7 +16,7 @@ CONFIG_ENV_SIZE=0x10000
>   CONFIG_ENV_OFFSET=0x70000
>   CONFIG_ENV_SECT_SIZE=0x10000
>   CONFIG_DM_GPIO=y
> -CONFIG_DEFAULT_DEVICE_TREE="kirkwood-lsxhl"
> +CONFIG_DEFAULT_DEVICE_TREE="marvell/kirkwood-lsxhl"
>   CONFIG_IDENT_STRING=" LS-XHL"
>   CONFIG_SYS_LOAD_ADDR=0x800000
>   CONFIG_HAS_BOARD_SIZE_LIMIT=y
> diff --git a/configs/nas220_defconfig b/configs/nas220_defconfig
> index f01b26f2df..4ea342a043 100644
> --- a/configs/nas220_defconfig
> +++ b/configs/nas220_defconfig
> @@ -10,7 +10,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc8012000
>   CONFIG_TARGET_NAS220=y
>   CONFIG_ENV_SIZE=0x10000
>   CONFIG_ENV_OFFSET=0xA0000
> -CONFIG_DEFAULT_DEVICE_TREE="kirkwood-blackarmor-nas220"
> +CONFIG_DEFAULT_DEVICE_TREE="marvell/kirkwood-blackarmor-nas220"
>   CONFIG_IDENT_STRING="\nNAS 220"
>   CONFIG_SYS_LOAD_ADDR=0x800000
>   # CONFIG_SYS_MALLOC_F is not set
> diff --git a/configs/net2big_v2_defconfig b/configs/net2big_v2_defconfig
> index dda627aac6..39cbc3384f 100644
> --- a/configs/net2big_v2_defconfig
> +++ b/configs/net2big_v2_defconfig
> @@ -12,7 +12,7 @@ CONFIG_NET2BIG_V2=y
>   CONFIG_ENV_SIZE=0x1000
>   CONFIG_ENV_OFFSET=0x70000
>   CONFIG_ENV_SECT_SIZE=0x10000
> -CONFIG_DEFAULT_DEVICE_TREE="kirkwood-net2big"
> +CONFIG_DEFAULT_DEVICE_TREE="marvell/kirkwood-net2big"
>   CONFIG_IDENT_STRING=" 2Big v2"
>   CONFIG_SYS_LOAD_ADDR=0x800000
>   CONFIG_ENV_ADDR=0x70000
> diff --git a/configs/netspace_lite_v2_defconfig b/configs/netspace_lite_v2_defconfig
> index 742e6205d8..cd416cb150 100644
> --- a/configs/netspace_lite_v2_defconfig
> +++ b/configs/netspace_lite_v2_defconfig
> @@ -12,7 +12,7 @@ CONFIG_NETSPACE_LITE_V2=y
>   CONFIG_ENV_SIZE=0x1000
>   CONFIG_ENV_OFFSET=0x70000
>   CONFIG_ENV_SECT_SIZE=0x10000
> -CONFIG_DEFAULT_DEVICE_TREE="kirkwood-ns2lite"
> +CONFIG_DEFAULT_DEVICE_TREE="marvell/kirkwood-ns2lite"
>   CONFIG_IDENT_STRING=" NS v2 Lite"
>   CONFIG_SYS_LOAD_ADDR=0x800000
>   CONFIG_ENV_ADDR=0x70000
> diff --git a/configs/netspace_max_v2_defconfig b/configs/netspace_max_v2_defconfig
> index 7779e6815e..6a3d9296ac 100644
> --- a/configs/netspace_max_v2_defconfig
> +++ b/configs/netspace_max_v2_defconfig
> @@ -12,7 +12,7 @@ CONFIG_NETSPACE_MAX_V2=y
>   CONFIG_ENV_SIZE=0x1000
>   CONFIG_ENV_OFFSET=0x70000
>   CONFIG_ENV_SECT_SIZE=0x10000
> -CONFIG_DEFAULT_DEVICE_TREE="kirkwood-ns2max"
> +CONFIG_DEFAULT_DEVICE_TREE="marvell/kirkwood-ns2max"
>   CONFIG_IDENT_STRING=" NS Max v2"
>   CONFIG_SYS_LOAD_ADDR=0x800000
>   CONFIG_ENV_ADDR=0x70000
> diff --git a/configs/netspace_mini_v2_defconfig b/configs/netspace_mini_v2_defconfig
> index 9e3614bb44..e25631b09f 100644
> --- a/configs/netspace_mini_v2_defconfig
> +++ b/configs/netspace_mini_v2_defconfig
> @@ -12,7 +12,7 @@ CONFIG_NETSPACE_MINI_V2=y
>   CONFIG_ENV_SIZE=0x1000
>   CONFIG_ENV_OFFSET=0x70000
>   CONFIG_ENV_SECT_SIZE=0x10000
> -CONFIG_DEFAULT_DEVICE_TREE="kirkwood-ns2mini"
> +CONFIG_DEFAULT_DEVICE_TREE="marvell/kirkwood-ns2mini"
>   CONFIG_IDENT_STRING=" NS v2 Mini"
>   CONFIG_SYS_LOAD_ADDR=0x800000
>   CONFIG_ENV_ADDR=0x70000
> diff --git a/configs/netspace_v2_defconfig b/configs/netspace_v2_defconfig
> index 1583a0adb3..b6ac2a8b19 100644
> --- a/configs/netspace_v2_defconfig
> +++ b/configs/netspace_v2_defconfig
> @@ -12,7 +12,7 @@ CONFIG_NETSPACE_V2=y
>   CONFIG_ENV_SIZE=0x1000
>   CONFIG_ENV_OFFSET=0x70000
>   CONFIG_ENV_SECT_SIZE=0x10000
> -CONFIG_DEFAULT_DEVICE_TREE="kirkwood-ns2"
> +CONFIG_DEFAULT_DEVICE_TREE="marvell/kirkwood-ns2"
>   CONFIG_IDENT_STRING=" NS v2"
>   CONFIG_SYS_LOAD_ADDR=0x800000
>   CONFIG_ENV_ADDR=0x70000
> diff --git a/configs/nsa310s_defconfig b/configs/nsa310s_defconfig
> index 89d8b18b16..e859a43ffa 100644
> --- a/configs/nsa310s_defconfig
> +++ b/configs/nsa310s_defconfig
> @@ -13,7 +13,7 @@ CONFIG_NR_DRAM_BANKS=2
>   CONFIG_TARGET_NSA310S=y
>   CONFIG_ENV_SIZE=0x20000
>   CONFIG_ENV_OFFSET=0xE0000
> -CONFIG_DEFAULT_DEVICE_TREE="kirkwood-nsa310s"
> +CONFIG_DEFAULT_DEVICE_TREE="marvell/kirkwood-nsa310s"
>   CONFIG_DEBUG_UART_BASE=0xf1012000
>   CONFIG_DEBUG_UART_CLOCK=166666667
>   CONFIG_IDENT_STRING="\nZyXEL NSA310S/320S 1/2-Bay Power Media Server"
> diff --git a/configs/nsa325_defconfig b/configs/nsa325_defconfig
> index 5da4a002b4..88a890002e 100644
> --- a/configs/nsa325_defconfig
> +++ b/configs/nsa325_defconfig
> @@ -13,7 +13,7 @@ CONFIG_NR_DRAM_BANKS=2
>   CONFIG_TARGET_NSA325=y
>   CONFIG_ENV_SIZE=0x20000
>   CONFIG_ENV_OFFSET=0xC0000
> -CONFIG_DEFAULT_DEVICE_TREE="kirkwood-nsa325"
> +CONFIG_DEFAULT_DEVICE_TREE="marvell/kirkwood-nsa325"
>   CONFIG_IDENT_STRING="\nZyXEL NSA325 2-Bay Power Media Server"
>   CONFIG_SYS_LOAD_ADDR=0x800000
>   CONFIG_PCI=y
> diff --git a/configs/openrd_base_defconfig b/configs/openrd_base_defconfig
> index 29a14e0927..057dd28dff 100644
> --- a/configs/openrd_base_defconfig
> +++ b/configs/openrd_base_defconfig
> @@ -11,7 +11,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc8012000
>   CONFIG_TARGET_OPENRD=y
>   CONFIG_ENV_SIZE=0x20000
>   CONFIG_ENV_OFFSET=0x80000
> -CONFIG_DEFAULT_DEVICE_TREE="kirkwood-openrd-base"
> +CONFIG_DEFAULT_DEVICE_TREE="marvell/kirkwood-openrd-base"
>   CONFIG_IDENT_STRING="\nOpenRD-Base"
>   CONFIG_SYS_LOAD_ADDR=0x800000
>   # CONFIG_SYS_MALLOC_F is not set
> diff --git a/configs/openrd_client_defconfig b/configs/openrd_client_defconfig
> index a95a435bdf..05e4292764 100644
> --- a/configs/openrd_client_defconfig
> +++ b/configs/openrd_client_defconfig
> @@ -12,7 +12,7 @@ CONFIG_TARGET_OPENRD=y
>   CONFIG_BOARD_IS_OPENRD_CLIENT=y
>   CONFIG_ENV_SIZE=0x20000
>   CONFIG_ENV_OFFSET=0x80000
> -CONFIG_DEFAULT_DEVICE_TREE="kirkwood-openrd-client"
> +CONFIG_DEFAULT_DEVICE_TREE="marvell/kirkwood-openrd-client"
>   CONFIG_IDENT_STRING="\nOpenRD-Client"
>   CONFIG_SYS_LOAD_ADDR=0x800000
>   # CONFIG_SYS_MALLOC_F is not set
> diff --git a/configs/openrd_ultimate_defconfig b/configs/openrd_ultimate_defconfig
> index e3f5294ff1..6e13c6eabd 100644
> --- a/configs/openrd_ultimate_defconfig
> +++ b/configs/openrd_ultimate_defconfig
> @@ -12,7 +12,7 @@ CONFIG_TARGET_OPENRD=y
>   CONFIG_BOARD_IS_OPENRD_ULTIMATE=y
>   CONFIG_ENV_SIZE=0x20000
>   CONFIG_ENV_OFFSET=0x80000
> -CONFIG_DEFAULT_DEVICE_TREE="kirkwood-openrd-ultimate"
> +CONFIG_DEFAULT_DEVICE_TREE="marvell/kirkwood-openrd-ultimate"
>   CONFIG_IDENT_STRING="\nOpenRD-Ultimate"
>   CONFIG_SYS_LOAD_ADDR=0x800000
>   # CONFIG_SYS_MALLOC_F is not set
> diff --git a/configs/pogo_e02_defconfig b/configs/pogo_e02_defconfig
> index e53ccf34c7..880cb20b22 100644
> --- a/configs/pogo_e02_defconfig
> +++ b/configs/pogo_e02_defconfig
> @@ -13,7 +13,7 @@ CONFIG_NR_DRAM_BANKS=2
>   CONFIG_TARGET_POGO_E02=y
>   CONFIG_ENV_SIZE=0x20000
>   CONFIG_ENV_OFFSET=0xC0000
> -CONFIG_DEFAULT_DEVICE_TREE="kirkwood-pogo_e02"
> +CONFIG_DEFAULT_DEVICE_TREE="marvell/kirkwood-pogo_e02"
>   CONFIG_IDENT_STRING="\nPogo E02"
>   CONFIG_SYS_LOAD_ADDR=0x800000
>   CONFIG_BOOTDELAY=3
> diff --git a/configs/pogo_v4_defconfig b/configs/pogo_v4_defconfig
> index 95e22b3fef..50046e83b7 100644
> --- a/configs/pogo_v4_defconfig
> +++ b/configs/pogo_v4_defconfig
> @@ -12,7 +12,7 @@ CONFIG_TEXT_BASE=0x600000
>   CONFIG_TARGET_POGO_V4=y
>   CONFIG_ENV_SIZE=0x20000
>   CONFIG_ENV_OFFSET=0xC0000
> -CONFIG_DEFAULT_DEVICE_TREE="kirkwood-pogoplug-series-4"
> +CONFIG_DEFAULT_DEVICE_TREE="marvell/kirkwood-pogoplug-series-4"
>   CONFIG_IDENT_STRING="\nPogoplug V4"
>   CONFIG_SYS_LOAD_ADDR=0x800000
>   CONFIG_PCI=y
> diff --git a/configs/sheevaplug_defconfig b/configs/sheevaplug_defconfig
> index 0af87dc4fb..b673b3f6da 100644
> --- a/configs/sheevaplug_defconfig
> +++ b/configs/sheevaplug_defconfig
> @@ -13,7 +13,7 @@ CONFIG_NR_DRAM_BANKS=2
>   CONFIG_TARGET_SHEEVAPLUG=y
>   CONFIG_ENV_SIZE=0x20000
>   CONFIG_ENV_OFFSET=0x80000
> -CONFIG_DEFAULT_DEVICE_TREE="kirkwood-sheevaplug"
> +CONFIG_DEFAULT_DEVICE_TREE="marvell/kirkwood-sheevaplug"
>   CONFIG_IDENT_STRING="\nMarvell-Sheevaplug"
>   CONFIG_SYS_LOAD_ADDR=0x800000
>   CONFIG_HAS_BOARD_SIZE_LIMIT=y

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
