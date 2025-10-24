Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA5EACCD1AB
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 10:58:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D1BD8334F;
	Fri, 24 Oct 2025 12:58:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D07F835B3; Fri, 24 Oct 2025 12:58:13 +0200 (CEST)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31C9E82E34
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 12:58:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.54] (unknown [98.97.26.255])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 0704DB2200E4;
 Fri, 24 Oct 2025 12:58:08 +0200 (CEST)
Message-ID: <ff0313ed-5d43-4603-aed4-6e41b2abed37@freeshell.de>
Date: Fri, 24 Oct 2025 03:58:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/9] riscv: dts: starfive: Add VisionFive 2 Lite board
 device tree
To: Hal Feng <hal.feng@starfivetech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Sumit Garg <sumit.garg@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
References: <20251024085932.83596-1-hal.feng@starfivetech.com>
 <20251024085932.83596-3-hal.feng@starfivetech.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20251024085932.83596-3-hal.feng@starfivetech.com>
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

Hi Hal, this is very good, I have some suggestion to improve more.

On 10/24/25 01:59, Hal Feng wrote:
> /****************************************************************/
> This patch picked from [1] is just for test and can be ignored.
> dts/upstream should be synced regularly with devicetree-rebasing.
> 
> [1] https://lore.kernel.org/all/20250821100930.71404-1-hal.feng@starfivetech.com/
> /****************************************************************/
> 
> VisionFive 2 Lite is a mini SBC based on the StarFive JH7110S SoC.
> 
> Board features:
> - JH7110S SoC
> - 2/4/8 GiB LPDDR4 DRAM
> - AXP15060 PMIC
> - 40 pin GPIO header
> - 1x USB 3.0 host port
> - 3x USB 2.0 host port
> - 1x M.2 M-Key (size: 2242)
> - 1x MicroSD slot (optional non-removable eMMC)
> - 1x QSPI Flash
> - 1x I2C EEPROM
> - 1x 1Gbps Ethernet port
> - SDIO-based Wi-Fi & UART-based Bluetooth
> - 1x HDMI port
> - 1x 2-lane DSI
> - 1x 2-lane CSI
> 
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  .../jh7110s-starfive-visionfive-2-lite.dts    | 159 ++++++++++++++++++
>  1 file changed, 159 insertions(+)
>  create mode 100644 dts/upstream/src/riscv/starfive/jh7110s-starfive-visionfive-2-lite.dts
> 
> diff --git a/dts/upstream/src/riscv/starfive/jh7110s-starfive-visionfive-2-lite.dts b/dts/upstream/src/riscv/starfive/jh7110s-starfive-visionfive-2-lite.dts
> new file mode 100644
> index 00000000000..30842b0cd1f
> --- /dev/null
> +++ b/dts/upstream/src/riscv/starfive/jh7110s-starfive-visionfive-2-lite.dts
> @@ -0,0 +1,159 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright (C) 2025 StarFive Technology Co., Ltd.
> + * Copyright (C) 2025 Hal Feng <hal.feng@starfivetech.com>
> + */
> +
> +/dts-v1/;
> +#include "jh7110-common.dtsi"
> +
> +/ {
> +	model = "StarFive VisionFive 2 Lite";
> +	compatible = "starfive,visionfive-2-lite", "starfive,jh7110s";
> +};
...

FYI as a follow-up to my earlier comments about modifying the dts
subtree I have now a working recommendation:

1). Return to using "RFC" subject prefix for the series while any
modification exists to dts subtree. The comment said about this is do
not post any "DO NOT MERGE" type patches that touch dts subtree, however...

2). Additions to CONFIG_OF_LIST will cause a build error if there is not
any corresponding file in the dts subtree. Use a workaround:

git mv
dts/upstream/src/riscv/starfive/jh7110s-starfive-visionfive-2-lite.dts
arch/riscv/dts/jh7110s-starfive-visionfive-2-lite-u-boot.dtsi
touch dts/upstream/src/riscv/starfive/jh7110s-starfive-visionfive-2-lite.dts
git add
dts/upstream/src/riscv/starfive/jh7110s-starfive-visionfive-2-lite.dts
arch/riscv/dts/jh7110s-starfive-visionfive-2-lite-u-boot.dtsi

Alternatively for your local development environment:

echo '#include
"/path/to/linux.git/arch/riscv/boot/dts/starfive/jh7110s-starfive-visionfive-2-lite-u-boot.dtsi"'
> arch/riscv/dts/jh7110s-starfive-visionfive-2-lite-u-boot.dtsi

This "-u-boot.dtsi" suffix file will get picked up by the build system
automatically when there is a corresponding file (empty file is okay) in
dts subtree. The empty file in dts subtree is a simple git file
operation with no actual content. It is not perfect as an answer but it
is better for the review now, and for anyone else reading this that may
want to do the same.

You can see this in the working example of RFC v1 series for Milk-V Mars
CM re-introduction:

https://lore.kernel.org/u-boot/20250925053233.1874027-1-e@freeshell.de/

and the follow-up as v2 series as this lands in devicetree-rebasing:

https://lore.kernel.org/u-boot/20251021231021.196336-1-e@freeshell.de/

I hope that is a good example to follow for v3, v4 of your series

3). If you follow RFC -> PATCH -> RFC the version does increment (RFC
v1, PATCH v2, RFC v3, ...)

Thanks,

-E
