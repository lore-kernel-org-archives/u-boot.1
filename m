Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CBB1E7717D
	for <u-boot@archiver.kernel.org>; Tue, 10 Dec 2024 02:05:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1BA88932E;
	Tue, 10 Dec 2024 03:05:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0C7489367; Tue, 10 Dec 2024 03:05:42 +0100 (CET)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 222E088E26
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 03:05:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dlan@gentoo.org
Date: Tue, 10 Dec 2024 10:04:41 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Huan Zhou <pericycle.cc@gmail.com>
Cc: u-boot@lists.denx.de, Ben Dooks <ben.dooks@codethink.co.uk>,
 Marcel Ziswiler <marcel@ziswiler.com>, Bin Meng <bmeng@tinylab.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jonas =?iso-8859-1?Q?Schw=F6bel?= <jonasschwoebel@yahoo.de>,
 Kever Yang <kever.yang@rock-chips.com>, Leo <ycliang@andestech.com>,
 Michal Simek <michal.simek@amd.com>, Nishanth Menon <nm@ti.com>,
 Padmarao Begari <padmarao.begari@microchip.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Randolph <randolph@andestech.com>, Rick Chen <rick@andestech.com>,
 Samuel Holland <samuel@sholland.org>, Sumit Garg <sumit.garg@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 Yu Chien Peter Lin <peterlin@andestech.com>,
 Kongyang Liu <seashell11234455@gmail.com>
Subject: Re: [PATCH v5 0/2] riscv: spacemit: add support for bananapi-f3
Message-ID: <20241210020441-GYA1904091@gentoo>
References: <20241209-pickup-bpif3-v5-0-92f801b7c6c1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209-pickup-bpif3-v5-0-92f801b7c6c1@gmail.com>
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

Hi Huan:

I have a few comments.. and will put some in separated patch

First, it's always your responsibility to collect the tags when
you sending out new version, as I see you missed Leo's review tag in v2
and Marcel's tested tag in v4

P.S: You can rely on maintainer to collect tags of the last version 
if no real changes but only tags added..

On 10:00 Mon 09 Dec     , Huan Zhou wrote:
> Banana Pi F3 board is a industrial grade RISC-V development board, it
> design with SpacemiT K1 8 core RISC-V chip, CPU integrates 2.0 TOPs AI
> computing power. 4G DDR and 16G eMMC onboard. 2x GbE Ethernet port, 4x USB
> 3.0 and PCIe for M.2 interface, support HDMI and Dual MIPI-CSI Camera.
> 
> This patch introduces fundamental support for the Banana Pi F3 board,
> encompassing UART, CPU, and PLIC support. This ensures that U-Boot can
> operate in serial console mode.
> 
> Changes in v5:
> - Formal the name from Bananapif3 -> Banana Pi BPI-F3
> - Trailing whitespace
> - New blank line at EOF in spacemit/index.rst
> - Link to v4: https://lore.kernel.org/r/20241129-pickup-bpif3-v4-0-e99fabf66e33@gmail.com
> 
> Changes in v4:
> - Change uart compatible in k1.dtsi in v3, cause related driver in not implemented in u-boot.
> - Update doc, show how to validate the patch.
> - Update maintainer, remove kongyang cause he lefted.
> - Link to v3: https://lore.kernel.org/r/20241114-pickup-bpif3-v3-0-98a45802ab79@gmail.com
> 
> Changes in v3:
> - Add base commit
> - Clear redifinition warning while building in UART_IIR_ID
> - Change underscore to dash in bananapi*f3
> - Update maintainer
> - link to v2 https://lore.kernel.org/u-boot/20240718043329.1500-1-seashell11234455@gmail.com/
> 
> Changes in v2:
> - Change license to GPL-2.0-or-later
> - Add memory node for dts
> - Add ft_board_setup function for kernel memory init
> - Use default prompt
> - links to v1 https://lore.kernel.org/u-boot/20240714150828.736-1-seashell11234455@gmail.com/
> 
> Signed-off-by: Huan Zhou <pericycle.cc@gmail.com>
> Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
> ---
> Kongyang Liu (2):
>       riscv: spacemit: bananapi_f3: initial support added
>       doc: spacemit: bananapi_f3: document Banana Pi F3 board
> 
>  arch/riscv/Kconfig                     |   5 +
>  arch/riscv/cpu/k1/Kconfig              |  18 ++
>  arch/riscv/cpu/k1/Makefile             |   6 +
>  arch/riscv/cpu/k1/cpu.c                |   9 +
>  arch/riscv/cpu/k1/dram.c               |  54 ++++
>  arch/riscv/dts/Makefile                |   1 +
>  arch/riscv/dts/k1-bananapi-f3.dts      |  25 ++
>  arch/riscv/dts/k1.dtsi                 | 459 +++++++++++++++++++++++++++++++++
>  board/spacemit/bananapi-f3/Kconfig     |  25 ++
>  board/spacemit/bananapi-f3/MAINTAINERS |   6 +
>  board/spacemit/bananapi-f3/Makefile    |   5 +
>  board/spacemit/bananapi-f3/board.c     |   9 +
>  configs/bananapi-f3_defconfig          |  20 ++
>  doc/board/index.rst                    |   1 +
>  doc/board/spacemit/bananapi-f3.rst     |  86 ++++++
>  doc/board/spacemit/index.rst           |   9 +
>  include/configs/bananapi-f3.h          |  13 +
>  17 files changed, 751 insertions(+)
> ---
> base-commit: 40c45a57974bdb09fffa31dde65ddf69e5de53eb
> change-id: 20241112-pickup-bpif3-245ab208b9a4
> 
> Best regards,
> -- 
> Huan Zhou <pericycle.cc@gmail.com>
> 

-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55
