Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57B7DC369C2
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 10:35:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8578D81F45;
	Fri, 25 Apr 2025 12:35:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="NtBHwN3R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A76E781F4D; Fri, 25 Apr 2025 12:35:46 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E9BC81F0D
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 12:35:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id BB45925D17;
 Fri, 25 Apr 2025 12:35:43 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uKGMBI-rQw7r; Fri, 25 Apr 2025 12:35:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1745577342; bh=xTG2sj7iUJmCt+RppS6wQWrLR8t9C4AZMnfuPGVAGrI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=NtBHwN3RiwAhoFAguRwf10QEQz3vQ84FkSmXMwFUvkqAHYwGDeKjpvV4VBwuYpwSm
 tNYAdJndx2JEDJqkev3u2hf9CcGupAcYWms/TNSdGy2dYN0y89uOXXk9VXaIeGera2
 JuNJhbam4YVxD9H3dsxtGb9jY8IyIQDR72lu4NgnRPHm+6OJ9jrxBk1Tov7rH9Degz
 PP6rk31qIZI5gN5jmo5hZm94MVygQNVXqZ84MMLvDkuZYgflKepUeCJVzqejRsBlJZ
 y7bJSYSHNpgtaRtsJoCjpc2zte1UgpYiEZ7Z3kUQGF8TGW+iZIVXIrHF97nGyhH+XU
 Jia3k1zdaoomA==
Date: Fri, 25 Apr 2025 10:35:30 +0000
From: Yao Zi <ziyao@disroot.org>
To: Leo Liang <ycliang@andestech.com>, <trini@konsulko.com>
Cc: <u-boot@lists.denx.de>, <rick@andestech.com>
Subject: Re: [GIT PULL] u-boot-riscv/master
Message-ID: <aAtlctz9Gx6-Vzuv@pie.lan>
References: <aAte-nS8ZhO_Odw1@swlinux02>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAte-nS8ZhO_Odw1@swlinux02>
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

Hi Leo,

On Fri, Apr 25, 2025 at 06:07:54PM +0800, Leo Liang wrote:
> Hi Tom,
> 
> The following changes since commit 10f48365112b164bee6564033ab682747efcb483:
> 
>   Merge patch series "Add PCIe support for TI AM64 SoC" (2025-04-24 10:46:17 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-riscv.git 
> 
> for you to fetch changes up to 5ac699efe94f24df561d33e420d3c73f5fb797e8:
> 
>   board: starfive: visionfive2: Order board detection logic to match config (2025-04-25 17:04:09 +0800)
> 
> CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot-riscv/-/pipelines/25940
> ----------------------------------------------------------------
> - riscv: lib: Simplify FDT retrieving process
> - board: k1: pinctrl: Add pinctrl support for bananapi-f3
> - binman: riscv: Fix binman_sym functionality
> - board: starfive: visionfive2: Reorder board detection logic
> - board: starfive: Add DeepComputing FML13V01 support
> ----------------------------------------------------------------
> E Shattow (2):
>       doc: board: starfive: visionfive2: add missing format command to Flashing
>       board: starfive: visionfive2: Order board detection logic to match config
> 
> Heinrich Schuchardt (9):
>       configs: qemu-riscv raise CONFIG_NR_DRAM_BANKS
>       configs: add jh7110-deepcomputing-fml13v01 to VF2 defconfig
>       riscv: dts: jh7110: add DeepComputing FML13V01 device-tree
>       board: starfive: DeepComputing FML13V01 fdt selection
>       board: starfive: spl: support DeepComputing FML13V01
>       doc: add DeepComputing FML13V01 documentation
>       doc: starfive: use consistent formatting
>       doc: starfive: use jh7110_common.rst
>       doc: jh7110: describe debug UART
> 
> Huan Zhou (2):
>       riscv: dts: k1: add pinctrl property in dts.
>       config: Enable pinctrl in bananapi-f3
> 
> Minda Chen (1):
>       MAINTAINERS: visionfive2: Add match N: starfive pattern
> 
> Yao Zi (7):
>       riscv: lib: Add a default implementation of board_fdt_blob_setup
>       board: qemu: riscv: Remove duplicated board_fdt_blob_setup
>       board: starfive: Remove duplicated board_fdt_blob_setup
>       board: sifive: Remove dead board_fdt_blob_setup
>       riscv: dts: binman.dtsi: Switch to u-boot-nodtb entry for proper U-Boot

There's still an unresolved comment for this patch[1], which doesn't
affect the functionality but makes the code cleaner. Should I send
v3 of the series? Or alternatvely I could clean the filename property
up with a separate patch, which may reduce your work. I'm fine with both
ways.

Best regards,
Yao Zi

[1]: https://lore.kernel.org/all/CAFLszTjiRKMLny_RcRB4sUV75c8_QLFkw4u_x6qfs3k1q=KsDg@mail.gmail.com/

>       riscv: dts: starfive: Prevent binman from relocating symbols in SPL
>       riscv: Provide __image_copy_{start_end} symbols in linkerscript
> 
>  arch/riscv/cpu/u-boot-spl.lds                      |   2 +
>  arch/riscv/cpu/u-boot.lds                          |   3 +
>  arch/riscv/dts/binman.dtsi                         |   2 +-
>  .../dts/jh7110-deepcomputing-fml13v01-u-boot.dtsi  |   7 ++
>  arch/riscv/dts/k1-bananapi-f3.dts                  |   3 +
>  arch/riscv/dts/k1-pinctrl.dtsi                     |  19 ++++
>  arch/riscv/dts/k1.dtsi                             |   8 +-
>  arch/riscv/dts/starfive-visionfive2-binman.dtsi    |   1 +
>  arch/riscv/lib/Makefile                            |   1 +
>  arch/riscv/lib/board.c                             |  19 ++++
>  board/emulation/qemu-riscv/qemu-riscv.c            |   8 --
>  board/sifive/unleashed/unleashed.c                 |  11 ---
>  board/sifive/unmatched/unmatched.c                 |  10 --
>  board/starfive/visionfive2/MAINTAINERS             |   2 +-
>  board/starfive/visionfive2/spl.c                   |  43 +++++----
>  board/starfive/visionfive2/starfive_visionfive2.c  |  16 +---
>  configs/bananapi-f3_defconfig                      |   2 +
>  configs/qemu-riscv32_defconfig                     |   1 -
>  configs/qemu-riscv32_smode_defconfig               |   1 -
>  configs/qemu-riscv32_spl_defconfig                 |   1 -
>  configs/qemu-riscv64_defconfig                     |   1 -
>  configs/qemu-riscv64_smode_defconfig               |   1 -
>  configs/qemu-riscv64_spl_defconfig                 |   1 -
>  configs/starfive_visionfive2_defconfig             |   2 +-
>  doc/board/starfive/deepcomputing_fml13v01.rst      |  80 ++++++++++++++++
>  doc/board/starfive/index.rst                       |   1 +
>  doc/board/starfive/jh7110_common.rst               | 103 +++++++++++++++++++++
>  doc/board/starfive/milk-v_mars.rst                 |  18 +---
>  doc/board/starfive/pine64_star64.rst               |  26 +-----
>  doc/board/starfive/visionfive2.rst                 |  48 ++--------
>  30 files changed, 292 insertions(+), 149 deletions(-)
>  create mode 100644 arch/riscv/dts/jh7110-deepcomputing-fml13v01-u-boot.dtsi
>  create mode 100644 arch/riscv/dts/k1-pinctrl.dtsi
>  create mode 100644 arch/riscv/lib/board.c
>  create mode 100644 doc/board/starfive/deepcomputing_fml13v01.rst
>  create mode 100644 doc/board/starfive/jh7110_common.rst
> 
> 
> Best regards,
> Leo
