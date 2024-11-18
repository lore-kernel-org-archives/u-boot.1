Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6F3AD49205
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 09:50:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C5508906C;
	Mon, 18 Nov 2024 10:50:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BC6E89448; Mon, 18 Nov 2024 10:50:06 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8EFD8902E
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 10:49:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 4AI9ndRc096155
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Mon, 18 Nov 2024 17:49:39 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 17:49:40 +0800
Date: Mon, 18 Nov 2024 17:49:37 +0800
From: Leo Liang <ycliang@andestech.com>
To: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
CC: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, "Tom
 Rini" <trini@konsulko.com>, Rick Chen <rick@andestech.com>, Kongyang Liu
 <seashell11234455@gmail.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, =?utf-8?Q?Miqu=C3=A8l?= Raynal
 <miquel.raynal@bootlin.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 1/3] doc: add LicheeRV Nano and SG2002 SoC
Message-ID: <ZzsNsXI3qP1wSa_a@swlinux02>
References: <20241112-licheerv-nano-v1-0-bf75d1eb560e@bootlin.com>
 <20241112-licheerv-nano-v1-1-bf75d1eb560e@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241112-licheerv-nano-v1-1-bf75d1eb560e@bootlin.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 4AI9ndRc096155
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

Hi,

On Tue, Nov 12, 2024 at 03:57:36PM +0100, Thomas Bonnefille wrote:
> [EXTERNAL MAIL]
> 
> Provide a page describing the usage of U-Boot on the LicheeRV Nano and a
> description of the board.
> 
> Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
> ---
>  doc/board/sophgo/licheerv_nano.rst | 72 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 72 insertions(+)
> 
> diff --git a/doc/board/sophgo/licheerv_nano.rst b/doc/board/sophgo/licheerv_nano.rst
> new file mode 100644
> index 0000000000000000000000000000000000000000..70401e295c4a56845353c3a92ab4ec98678a1180
> --- /dev/null
> +++ b/doc/board/sophgo/licheerv_nano.rst
> @@ -0,0 +1,72 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +LicheeRV Nano
> +==========

The title underline is too short and will fail `make htmldocs`.

> +
> +SG2002 RISC-V SoC
> +------------------
> +The SG2002 is a high-performance, low-power 64-bit RISC-V/ARM SoC from Sophgo.
> +
> +Mainline support
> +----------------
> +The support for following drivers are already enabled:
> +1. ns16550 UART Driver.
> +2. Synopsys Designware MSHC Driver
> +
> +Building
> +~~~~~~~~
> +1. Add the RISC-V toolchain to your PATH.
> +2. Setup ARCH & cross compilation environment variable:
> +
> +.. code-block:: console
> +
> +   export CROSS_COMPILE=<riscv64 toolchain prefix>
> +   cd <U-Boot-dir>
> +   make licheerv_nano_defconfig

The name of the defconfig does not seem to match what you provide in [patch 3/3] ?

> +   make
> +
> +This will generate u-boot.bin
> +
> +Booting
> +~~~~~~~
> +Currently, we rely on vendor FSBL (First Stage Boot Loader) to initialize the
> +clock and load the u-boot image, then bootup from it.
> +
> +To run u-boot.bin on top of FSBL, follow these steps:
> +
> +1. Use mainline OpenSBI with a newer version than 1.5 to generate fw_dynamic.
> +
> +2. Generate a compatible u-boot.bin using U-Boot with the LicheeRV Nano default
> +   configuration.
> +
> +3. Use the vendor-provided tool [1] to create a unified fip.bin file containing
> +   FSBL, OpenSBI, and U-Boot.
> +   Note that you will have to use the file cv181x.bin as the FSBL.
> +
> +2. Place the generated fip.bin file into the FAT partition of the SD card.
> +
> +3. Insert the SD card into the board and power it on.
> +
> +The board will automatically execute the FSBL from the fip.bin file.
> +Subsequently, it will transition to OpenSBI, and finally, OpenSBI will invoke
> +U-Boot.
> +
> +[1]: https://github.com/sophgo/fiptool
> +
> +
> +Sample boot log from LicheeRV Nano board
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +.. code-block:: none
> +
> +   U-Boot 2024.10 (Oct 24 2024 - 15:00:20 +0200)licheerv_nano
> +
> +   DRAM:  256 MiB
> +   Core:  19 devices, 11 uclasses, devicetree: separate
> +   MMC:   mmc@4310000: 0
> +   Loading Environment from nowhere... OK
> +   In:    serial@4140000
> +   Out:   serial@4140000
> +   Err:   serial@4140000
> +   Net:   No ethernet found.
> +   Hit any key to stop autoboot:  0
> +   licheerv_nano#
> 
> --
> 2.47.0

Other than that,
LGTM.

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
