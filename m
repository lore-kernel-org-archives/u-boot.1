Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC135F483E6
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 19:20:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 421AE84206;
	Mon, 23 Mar 2026 20:20:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=freeshell.de header.i=@freeshell.de header.b="V26UYKhe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BFF18420C; Mon, 23 Mar 2026 20:20:25 +0100 (CET)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9270D841C8
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 20:20:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1774293607;
 bh=hBWdPOrD6OKL/Ne75L1IRUrtOECyXeg/jAZ2LHoRvJg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=V26UYKhefa/pgJC4GLQaeXLRZQNDGLadcVbKLhpgrrdg1yWOzuW93uUayrYVYax7z
 JY2dt9QMZ52DapCpDKlWHbwUPc4iq6ozVa0Psxct3acgSuUpJJsMXDiAXE4cyUJspx
 P6aNR+CBlAtQNnGkWiJralw+k/646qVyeFAK1mjti8+qd3Kx2VXv+xKJa6j5QNhAa0
 ta92CamUXoAL+ypg+zUFdk9GxOr4hACJf9w405WaNfFQ+FREi7GAg8SyMJ6pf81XB7
 y73NaQbazMhe1mvrBKuIsqb8A9QeCjjPo1ut5A9cCYqqmXSyFD19TYAdlojjWa2tzI
 olVvKS8EN9yYA==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 3B31DB220430;
 Mon, 23 Mar 2026 20:20:06 +0100 (CET)
Message-ID: <bb87214b-8b1a-428c-a339-2e632ebc2b15@freeshell.de>
Date: Mon, 23 Mar 2026 12:20:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] u-boot-riscv/next
To: trini@konsulko.com
Cc: u-boot@lists.denx.de, Leo Yu-Chi Liang <ycliang@andestech.com>,
 rick@andestech.com, hal.feng@starfivetech.com, jamie.gibbons@microchip.com
References: <20260317060146.3983817-1-ycliang@andestech.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20260317060146.3983817-1-ycliang@andestech.com>
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

Hi Tom,

There are some Fixes tags for master in this pull request applied to
next and not yet applied to master, noted inline below.

On 3/16/26 23:01, Leo Yu-Chi Liang wrote:
> Hi Tom,
> 
> The following changes since commit 841856ed9675b26ec517fdd00b5cc0aef8db508e:
> 
>   Merge patch series "Add PCIe Boot support for TI J784S4 SoC" (2026-03-16 08:24:18 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-riscv.git next
> 
> for you to fetch changes up to b51e59c8b34c780e28728bc0cb58783855c7ffbf:
> 
>   riscv: Add support for BeagleV-Fire (2026-03-17 11:39:18 +0800)
> 
> CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot-riscv/-/pipelines/29548
> ----------------------------------------------------------------
> - board: starfive: Add Xunlong OrangePi RV
> - board: starfive: Add VisionFive 2 Lite
> - board: beagle: Add BeagleV-Fire
> ----------------------------------------------------------------
> E Shattow (5):
>       board: starfive: visionfive2: Add Orange Pi RV selection by product_id
>       configs: starfive: Add Orange Pi RV to visionfive2
>       doc: board: starfive: Add Xunlong OrangePi RV

>       doc: board: starfive: jh7110 common give build output dir by env not arg

commit 24662f698f5ad6f444e6dc437c0b5a932726a6ef
Fixes: 8304f3226700 ("doc: board: starfive: update jh7110 common
description")

>       doc: board: starfive: jh7110 common update OPENSBI build env reference

commit 1edeb52086c6e160d93d86386505e6cc6ce1457c
Fixes: 8304f3226700 ("doc: board: starfive: update jh7110 common
description")

> 
> Hal Feng (7):
>       eeprom: starfive: Simplify get_ddr_size_from_eeprom()

commit 6015c98be50f2fc571c294d2f2b0768212fb7e99
Fixes: aea1bd95b61e ("eeprom: starfive: Enable ID EEPROM configuration")

>       eeprom: starfive: Correct get_pcb_revision_from_eeprom()

commit 78253aeeecdfea4c71779905ff2b400fa7400b1c
Fixes: aea1bd95b61e ("eeprom: starfive: Enable ID EEPROM configuration")

>       eeprom: starfive: Support eeprom data format v3
>       pcie: starfive: Add a optional power gpio support
>       configs: visionfive2: Add VisionFive 2 Lite DT to OF_LIST
>       board: starfive: spl: Support VisionFive 2 Lite
>       board: starfive: visionfive2: Add VisionFive 2 Lite fdt selection
> 
> Jamie Gibbons (1):
>       riscv: Add support for BeagleV-Fire
> 
>  arch/riscv/Kconfig                                 |   4 +
>  arch/riscv/cpu/jh7110/spl.c                        |   2 +-
>  arch/riscv/include/asm/arch-jh7110/eeprom.h        |  13 ++-
>  board/beagle/beaglev_fire/Kconfig                  |  43 ++++++++
>  board/beagle/beaglev_fire/MAINTAINERS              |   7 ++
>  board/beagle/beaglev_fire/Makefile                 |   6 ++
>  board/beagle/beaglev_fire/beaglev_fire.c           | 117 +++++++++++++++++++++
>  board/starfive/visionfive2/spl.c                   |   6 ++
>  board/starfive/visionfive2/starfive_visionfive2.c  |   4 +
>  .../starfive/visionfive2/visionfive2-i2c-eeprom.c  |  64 ++++++-----
>  configs/beaglev_fire_defconfig                     |  29 +++++
>  configs/starfive_visionfive2_defconfig             |   2 +-
>  doc/board/starfive/index.rst                       |   1 +
>  doc/board/starfive/jh7110_common.rst               |  11 +-
>  doc/board/starfive/orangepi_rv.rst                 |  35 ++++++
>  drivers/pci/pcie_starfive_jh7110.c                 |   8 ++
>  include/configs/beaglev_fire.h                     |  57 ++++++++++
>  17 files changed, 375 insertions(+), 34 deletions(-)
>  create mode 100644 board/beagle/beaglev_fire/Kconfig
>  create mode 100644 board/beagle/beaglev_fire/MAINTAINERS
>  create mode 100644 board/beagle/beaglev_fire/Makefile
>  create mode 100644 board/beagle/beaglev_fire/beaglev_fire.c
>  create mode 100644 configs/beaglev_fire_defconfig
>  create mode 100644 doc/board/starfive/orangepi_rv.rst
>  create mode 100644 include/configs/beaglev_fire.h
> 
>  Best regards,
>  Leo

I note that there may be other authors' contributions applied to next
with Fixes tags for master that are not part of this pull request, not
highlighted in my reply here.

Thanks,

-E
