Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFFBBE7C6FA
	for <u-boot@archiver.kernel.org>; Sun,  1 Feb 2026 01:12:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 290B783B5E;
	Sun,  1 Feb 2026 02:12:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="aAv6EqU0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96D1783B85; Sun,  1 Feb 2026 02:12:40 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EF1883B55
 for <u-boot@lists.denx.de>; Sun,  1 Feb 2026 02:12:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=19be=AF=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1769908357;
 bh=A5DQJxQet4Z7hAj/0pbRPFma5IUoEvlKIe1bTRhPYBE=;
 b=aAv6EqU04Tx6WGv8DH+YEzZ7UbKBtuCqajXfxQPV+qXNuADfoBusRMqv45uf2FjSLjAxGm/7X
 SoDZslYTL2/AGqV088F47HpvB9NAYvU75ti8OImtTByRmsmM1+r72AzIc+T3fFvIq0nML9rvtI2
 mBOTQovwNh8m+rO7mlKXWsRiVglKej2K6yqziH7U/ZgG+qe3AFuhAZVfuJvYbYdNCjK7KY5YpTR
 04V/IUbmgUBWPimgSIdIj9gslJJO75VrpXZg0NiLnPpt4UIxcgz9t+uD2wuIOQroTPPrhtkMvQz
 ixdCVyAfBZxJkol2XpbEVbQISqsn0sJwL11fVVn0Wt2g==
X-Forward-Email-ID: 697ea87e8af2baab38e546a2
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.5.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <9ddc1e46-6573-4952-8abf-b84617964d38@kwiboo.se>
Date: Sun, 1 Feb 2026 02:12:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] ARM: Add RV1103 Omega4 board support
To: Fabio Estevam <festevam@gmail.com>, Fabio Estevam <festevam@nabladev.com>
Cc: kever.yang@rock-chips.com, trini@konsulko.com, u-boot@lists.denx.de
References: <20260201004456.763107-1-festevam@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20260201004456.763107-1-festevam@gmail.com>
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

Hi Fabio,

On 2/1/2026 1:44 AM, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@nabladev.com>
> 
> Hi,
> 
> This patch series adds support for the Onion RV1103 Omega4 board to U-Boot.
> It covers SPL, SPI NAND boot, and the minimal board devicetree required to
> boot the board.

This series seem to handle the RV1103B variant and not the RV1106/RV1103
variant, please name parts as rv1103b to match vendor U-Boot or is the
rv1106/rv1103 and rv1103b fully compatible?

> Upstreaming the RV1103 devicetree in Linux is ongoing, but to avoid blocking
> U-Boot support, this series introduces board-specific devicetrees for now.
> Once the Linux RV1103 devicetrees are upstreamed, the OF_UPSTREAM mechanism
> can be enabled.

For the Rockchip platform we typically expect e.g. dt-bindings headers
for core parts to be upstreamed to Linux and picked from dts/upstream
for new SoC support.

Please at least send out clk and pinctrl dt-bindings and drivers for
Linux before a v2 of this series :-)

Regards,
Jonas

> Fabio Estevam (7):
>   pinctrl: rockchip: Add support for RV1103
>   clk: rockchip: Add support for RV1103
>   tools: rkcommon: Add rv1103 support
>   rockchip: spl-boot-order: Add SPI NAND support
>   spl: Add SPI NAND support via MTD in SPL
>   ARM: dts: Add RV1103 Omega4 support
>   omega4-rv1103: Add initial support
> 
>  arch/arm/dts/rv1103-omega4-u-boot.dtsi        |   11 +
>  arch/arm/dts/rv1103-omega4.dts                |   40 +
>  arch/arm/dts/rv1103-u-boot.dtsi               |    4 +
>  arch/arm/dts/rv1103.dtsi                      |  267 +++++
>  .../include/asm/arch-rockchip/cru_rv1103.h    |  271 +++++
>  .../include/asm/arch-rockchip/grf_rv1103.h    |   31 +
>  arch/arm/include/asm/arch-rv1103/boot0.h      |   11 +
>  arch/arm/mach-rockchip/Kconfig                |   14 +
>  arch/arm/mach-rockchip/Makefile               |    1 +
>  arch/arm/mach-rockchip/rv1103/Kconfig         |   23 +
>  arch/arm/mach-rockchip/rv1103/Makefile        |   12 +
>  arch/arm/mach-rockchip/rv1103/boot0.h         |    5 +
>  arch/arm/mach-rockchip/rv1103/clk_rv1103.c    |   32 +
>  arch/arm/mach-rockchip/rv1103/rv1103.c        |  133 ++
>  arch/arm/mach-rockchip/rv1103/syscon_rv1103.c |   19 +
>  arch/arm/mach-rockchip/spl-boot-order.c       |   11 +-
>  board/onion/omega4_rv1103/Kconfig             |   12 +
>  board/onion/omega4_rv1103/MAINTAINERS         |    6 +
>  board/onion/omega4_rv1103/Makefile            |    7 +
>  board/onion/omega4_rv1103/omega4_rv1103.c     |   19 +
>  board/onion/omega4_rv1103/omega4_rv1103.env   |    5 +
>  common/spl/Kconfig                            |   10 +-
>  common/spl/Makefile                           |    1 +
>  common/spl/spl_spi_nand.c                     |   82 ++
>  configs/omega4-rv1103_defconfig               |   82 ++
>  doc/board/index.rst                           |    1 +
>  doc/board/onion/index.rst                     |    9 +
>  doc/board/onion/omega4-rv1103.rst             |   56 +
>  drivers/clk/rockchip/Makefile                 |    1 +
>  drivers/clk/rockchip/clk_rv1103.c             | 1068 +++++++++++++++++
>  drivers/mtd/Makefile                          |    1 +
>  drivers/mtd/nand/Makefile                     |   13 +-
>  drivers/pinctrl/Kconfig                       |   10 +
>  drivers/pinctrl/rockchip/Makefile             |    1 +
>  drivers/pinctrl/rockchip/pinctrl-rv1103.c     |  411 +++++++
>  include/configs/omega4_rv1103.h               |   11 +
>  include/configs/rv1103_common.h               |   14 +
>  include/dt-bindings/clock/rv1103-cru.h        |  489 ++++++++
>  tools/rkcommon.c                              |    1 +
>  39 files changed, 3191 insertions(+), 4 deletions(-)
>  create mode 100644 arch/arm/dts/rv1103-omega4-u-boot.dtsi
>  create mode 100644 arch/arm/dts/rv1103-omega4.dts
>  create mode 100644 arch/arm/dts/rv1103-u-boot.dtsi
>  create mode 100644 arch/arm/dts/rv1103.dtsi
>  create mode 100644 arch/arm/include/asm/arch-rockchip/cru_rv1103.h
>  create mode 100644 arch/arm/include/asm/arch-rockchip/grf_rv1103.h
>  create mode 100644 arch/arm/include/asm/arch-rv1103/boot0.h
>  create mode 100644 arch/arm/mach-rockchip/rv1103/Kconfig
>  create mode 100644 arch/arm/mach-rockchip/rv1103/Makefile
>  create mode 100644 arch/arm/mach-rockchip/rv1103/boot0.h
>  create mode 100644 arch/arm/mach-rockchip/rv1103/clk_rv1103.c
>  create mode 100644 arch/arm/mach-rockchip/rv1103/rv1103.c
>  create mode 100644 arch/arm/mach-rockchip/rv1103/syscon_rv1103.c
>  create mode 100644 board/onion/omega4_rv1103/Kconfig
>  create mode 100644 board/onion/omega4_rv1103/MAINTAINERS
>  create mode 100644 board/onion/omega4_rv1103/Makefile
>  create mode 100644 board/onion/omega4_rv1103/omega4_rv1103.c
>  create mode 100644 board/onion/omega4_rv1103/omega4_rv1103.env
>  create mode 100644 common/spl/spl_spi_nand.c
>  create mode 100644 configs/omega4-rv1103_defconfig
>  create mode 100644 doc/board/onion/index.rst
>  create mode 100644 doc/board/onion/omega4-rv1103.rst
>  create mode 100644 drivers/clk/rockchip/clk_rv1103.c
>  create mode 100644 drivers/pinctrl/rockchip/pinctrl-rv1103.c
>  create mode 100644 include/configs/omega4_rv1103.h
>  create mode 100644 include/configs/rv1103_common.h
>  create mode 100644 include/dt-bindings/clock/rv1103-cru.h
