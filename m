Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 409D3C369C2
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 13:02:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B52C282012;
	Fri, 25 Apr 2025 15:02:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E5BF820E1; Fri, 25 Apr 2025 15:02:12 +0200 (CEST)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23DFE81E14
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 15:02:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.35] (unknown [98.97.61.227])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id E5BBFB4C1604;
 Fri, 25 Apr 2025 15:02:08 +0200 (CEST)
Message-ID: <849a10bd-deac-4735-9c6c-61a284045aa0@freeshell.de>
Date: Fri, 25 Apr 2025 06:02:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] u-boot-riscv/master
From: E Shattow <e@freeshell.de>
To: Leo Liang <ycliang@andestech.com>, trini@konsulko.com
Cc: u-boot@lists.denx.de, rick@andestech.com
References: <aAte-nS8ZhO_Odw1@swlinux02>
 <c42c99d0-6ce1-452a-8d2f-fe8885214cb0@freeshell.de>
Content-Language: en-US
In-Reply-To: <c42c99d0-6ce1-452a-8d2f-fe8885214cb0@freeshell.de>
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

Oops! actually, was merge conflict, I see...

On 4/25/25 05:57, E Shattow wrote:
> Hi Leo,
> 
> On 4/25/25 03:07, Leo Liang wrote:
>> Hi Tom,
>>
>> The following changes since commit 10f48365112b164bee6564033ab682747efcb483:
>>
>>   Merge patch series "Add PCIe support for TI AM64 SoC" (2025-04-24 10:46:17 -0600)
>>
>> are available in the Git repository at:
>>
>>   https://source.denx.de/u-boot/custodians/u-boot-riscv.git 
>>
>> for you to fetch changes up to 5ac699efe94f24df561d33e420d3c73f5fb797e8:
>>
>>   board: starfive: visionfive2: Order board detection logic to match config (2025-04-25 17:04:09 +0800)
>>
>> CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot-riscv/-/pipelines/25940
>> ----------------------------------------------------------------
>> - riscv: lib: Simplify FDT retrieving process
>> - board: k1: pinctrl: Add pinctrl support for bananapi-f3
>> - binman: riscv: Fix binman_sym functionality
>> - board: starfive: visionfive2: Reorder board detection logic
>> - board: starfive: Add DeepComputing FML13V01 support
>> ----------------------------------------------------------------
>> E Shattow (2):
>>       doc: board: starfive: visionfive2: add missing format command to Flashing
>>       board: starfive: visionfive2: Order board detection logic to match config
>>
>> Heinrich Schuchardt (9):
>>       configs: qemu-riscv raise CONFIG_NR_DRAM_BANKS
>>       configs: add jh7110-deepcomputing-fml13v01 to VF2 defconfig
>>       riscv: dts: jh7110: add DeepComputing FML13V01 device-tree
>>       board: starfive: DeepComputing FML13V01 fdt selection
>>       board: starfive: spl: support DeepComputing FML13V01
>>       doc: add DeepComputing FML13V01 documentation
>>       doc: starfive: use consistent formatting
>>       doc: starfive: use jh7110_common.rst
>>       doc: jh7110: describe debug UART
>>
>> Huan Zhou (2):
>>       riscv: dts: k1: add pinctrl property in dts.
>>       config: Enable pinctrl in bananapi-f3
>>
>> Minda Chen (1):
>>       MAINTAINERS: visionfive2: Add match N: starfive pattern
>>
>> Yao Zi (7):
>>       riscv: lib: Add a default implementation of board_fdt_blob_setup
>>       board: qemu: riscv: Remove duplicated board_fdt_blob_setup
>>       board: starfive: Remove duplicated board_fdt_blob_setup
>>       board: sifive: Remove dead board_fdt_blob_setup
>>       riscv: dts: binman.dtsi: Switch to u-boot-nodtb entry for proper U-Boot
>>       riscv: dts: starfive: Prevent binman from relocating symbols in SPL
>>       riscv: Provide __image_copy_{start_end} symbols in linkerscript
>>
>>  arch/riscv/cpu/u-boot-spl.lds                      |   2 +
>>  arch/riscv/cpu/u-boot.lds                          |   3 +
>>  arch/riscv/dts/binman.dtsi                         |   2 +-
>>  .../dts/jh7110-deepcomputing-fml13v01-u-boot.dtsi  |   7 ++
>>  arch/riscv/dts/k1-bananapi-f3.dts                  |   3 +
>>  arch/riscv/dts/k1-pinctrl.dtsi                     |  19 ++++
>>  arch/riscv/dts/k1.dtsi                             |   8 +-
>>  arch/riscv/dts/starfive-visionfive2-binman.dtsi    |   1 +
>>  arch/riscv/lib/Makefile                            |   1 +
>>  arch/riscv/lib/board.c                             |  19 ++++
>>  board/emulation/qemu-riscv/qemu-riscv.c            |   8 --
>>  board/sifive/unleashed/unleashed.c                 |  11 ---
>>  board/sifive/unmatched/unmatched.c                 |  10 --
>>  board/starfive/visionfive2/MAINTAINERS             |   2 +-
>>  board/starfive/visionfive2/spl.c                   |  43 +++++----
>>  board/starfive/visionfive2/starfive_visionfive2.c  |  16 +---
>>  configs/bananapi-f3_defconfig                      |   2 +
>>  configs/qemu-riscv32_defconfig                     |   1 -
>>  configs/qemu-riscv32_smode_defconfig               |   1 -
>>  configs/qemu-riscv32_spl_defconfig                 |   1 -
>>  configs/qemu-riscv64_defconfig                     |   1 -
>>  configs/qemu-riscv64_smode_defconfig               |   1 -
>>  configs/qemu-riscv64_spl_defconfig                 |   1 -
>>  configs/starfive_visionfive2_defconfig             |   2 +-
>>  doc/board/starfive/deepcomputing_fml13v01.rst      |  80 ++++++++++++++++
>>  doc/board/starfive/index.rst                       |   1 +
>>  doc/board/starfive/jh7110_common.rst               | 103 +++++++++++++++++++++
>>  doc/board/starfive/milk-v_mars.rst                 |  18 +---
>>  doc/board/starfive/pine64_star64.rst               |  26 +-----
>>  doc/board/starfive/visionfive2.rst                 |  48 ++--------
>>  30 files changed, 292 insertions(+), 149 deletions(-)
>>  create mode 100644 arch/riscv/dts/jh7110-deepcomputing-fml13v01-u-boot.dtsi
>>  create mode 100644 arch/riscv/dts/k1-pinctrl.dtsi
>>  create mode 100644 arch/riscv/lib/board.c
>>  create mode 100644 doc/board/starfive/deepcomputing_fml13v01.rst
>>  create mode 100644 doc/board/starfive/jh7110_common.rst
>>
>>
>> Best regards,
>> Leo
> 
> Looks to me like merging "Order board detection logic to match config"
> series preserves the string pointer math that I deleted with the series.
> The intent of the series is for the logic to match the literals in
> configs/starfive_visionfive2_defconfig:CONFIG_OF_LIST and not be
> obfuscated by this string pointer math. Searching (grep ...) entries
> from the list should lead to the code, which is hidden if we have that
> bit that strips the prefix. Sorry if that adds a few bytes of
> "starfive/" for each target added to SPL code size but the merge as-is
> does not reflect all of what I wanted, FYI
> 
> Thanks,
> 
> -E

I can send another version ? -E
