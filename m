Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05BDCC4707B
	for <u-boot@archiver.kernel.org>; Sun, 14 Jan 2024 21:58:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F14D7879CC;
	Sun, 14 Jan 2024 22:58:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="XWQO7ZEh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE72E879CE; Sun, 14 Jan 2024 22:58:00 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F20A98783F
 for <u-boot@lists.denx.de>; Sun, 14 Jan 2024 22:57:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1705269460; x=1705874260; i=xypron.glpk@gmx.de;
 bh=I7EEG1FyhGY5JWmraYgLVPqPFe9ilyeqB00aqOMANiI=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=XWQO7ZEhWTvlxWAT9E6nLMpCGbHmv6fJy3HY7JESMqZP3153gBOwAp4VvYHB6Rs9
 rfj3GUcsP/lOFwNp9dXhgYa2jIldNhlcO+q3Dop7HWfDhcttSQeJ1vw847U/pwi84
 CIHRndQmnjzQ1srvMWibcnaJdJHfuf/2dvEfmDXz9YpNnHes1q5jPHxUnlnoEBlnq
 lUUY8xLaMGXEorx/kVpZtcYcshntTLguvlYR6jjx5iCfNI0X5MWwAV+ZMBGkWgmR4
 WTC5AJW1JE+kcKLvY91HTmljB75wasyO0MQ2p0veqA/jEU8KIPHC+I8WT9nCQk+65
 DZHwSI37xQTJb/pXjw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1McpNo-1qqcwo37dC-00ZuzK; Sun, 14
 Jan 2024 22:57:40 +0100
Message-ID: <96f389a2-0f59-402a-8381-25ee1ee66ce2@gmx.de>
Date: Sun, 14 Jan 2024 22:57:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] riscv: sophgo: milkv_duo: initial support added
Content-Language: en-US, de-DE
To: Kongyang Liu <seashell11234455@gmail.com>
Cc: Bin Meng <bmeng@tinylab.org>, Leo <ycliang@andestech.com>,
 Michal Simek <michal.simek@amd.com>, Randolph <randolph@andestech.com>,
 Rick Chen <rick@andestech.com>, Samuel Holland <samuel@sholland.org>,
 Shengyu Qu <wiagn233@outlook.com>,
 Yu Chien Peter Lin <peterlin@andestech.com>, u-boot@lists.denx.de
References: <20240114180741.2114-1-seashell11234455@gmail.com>
 <20240114180741.2114-2-seashell11234455@gmail.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240114180741.2114-2-seashell11234455@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nK1DftZnOUfHphjHo/l9NrbDiCXo+qD50tvhMUBlb1SH3xnrSsA
 mfA5+2GYkPVHOVYSsoZPhj875+aPVDMmciIZQFknUeDRO69jRa2reQRvZXVq1xA1ikrf/1y
 pC5rAljy0D7vfuaXNbVDAxV8CG4fnLkKBeweSt2UZ0uz0/H4Vr2DSwewgZAhrI9k0JebZ6m
 p9Cs1MGcLJB90Wz9Anzxw==
UI-OutboundReport: notjunk:1;M01:P0:qH2tp9w7iQc=;nc2r6gtrIpVsUt7qonL2BfK2+6q
 xD6VwcNc+N6s3YdDnZ3zNYXgScU9rtN5kuld1mam6JPaJXS5oSxkoon7J75iGnreUPx/dDImS
 t/EbGqBX+yLEUEKHKfofDEtEnFPTWiEpjtgKVDAelyMCp6lspOPX8K8fEVJSbiLtOu8ZinOvB
 j7D9BITt9tITDGDoqyHRareVx5RqKsPXs42RpVOqXQaC9GMihvQYMc8hywS/60k8hpxkgw66D
 osT9uYuuu7ArLP0Q3sT0yIEK2RtH1k1wS8ohWP7k7o/fMwAjcOysAda8XN+3NQSdeaYbgD49l
 0k6wMkn9CyJz+vHKk2/nlaAv1AYeNqNE45zGjKHPZ75BuASNwug2RrelTJVU3Sdfm8QHtMNY7
 frQmolLEJmaPPlqSU1rKl2TWfNwfmGcSFAJFkEoqV5jTfuPpnjxdejquP85WX3nLWdu84hgwM
 J8rpJfsVi0d2Wcw2tG9eQ43U2N9jSgtBJnRCTYmO9Fvue3whB8ONRYLQ4nxL3Dh7CykRGEqPU
 J/NT7R2jHy9kOw8mSQXENDEsDWImY1PTOEfTmkziKOJlPmuBkYMj65Xaa7Xs+weWgVyNa9cFK
 FlKDeaojiml9EzipcOZV3Z1ld1fUeOfNi5OYq4O0hxaNZwgnaV5FN70Gy41k01KWoWaCVNmzb
 xwxdd2A368E5BVm9y3eBHcETL6GPbVF4qlN3zFNnTTRy5yFyc2PGL0RR7GSOcOFRdyfDaj9HY
 wELQx2lLTp04x8Hc+264gIxEXIb+NOZT5fuKMYzKRgorwchjGR8a/gNieJHgCNLDeV8ry5nI+
 Ce0KoUM+Q9t3Gwqcae2pT8jOKjVonZcuLP34IjA8m8L8QFsrr7SwvmLQNcMUWBeX9dAySG0bg
 6++DEMN6sjsgm9BUjL6vdFfWtyszQtlDi5HgsGEIgNTQFaXMNc4EeYDZKZaHq0r5qSl2LTJKY
 TwKG3sqCADQnWsSgBugFNUJucOk=
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

On 1/14/24 19:07, Kongyang Liu wrote:
> Add support for Sophgo's Milk-V Duo board, only minimal device tree and
> serial console are enabled, and it can boot via vendor first stage
> bootloader.
>
> Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>

The sequence of patches seems to be wrong.

We expect that after each single patch building succeeds. But the
device-tree is neither in this patch nor in a preceding patch. Please,
swap patch 1 and 2.

make[2]: *** No rule to make target
'arch/riscv/dts/cv1800b-milkv-duo.dtb', needed by 'dtbs'.


>
> ---
>
> Changes in v2:
> - Fold the defconfig patch to first patch
> - Remove unnecessary environment settings of consoledev and baudrate in
> config
>
>   arch/riscv/Kconfig                 |  4 ++++
>   board/sophgo/milkv_duo/Kconfig     | 28 ++++++++++++++++++++++++++++
>   board/sophgo/milkv_duo/MAINTAINERS |  6 ++++++
>   board/sophgo/milkv_duo/Makefile    |  5 +++++
>   board/sophgo/milkv_duo/board.c     |  9 +++++++++
>   configs/milkv_duo_defconfig        | 24 ++++++++++++++++++++++++
>   include/configs/milkv_duo.h        | 12 ++++++++++++
>   7 files changed, 88 insertions(+)
>   create mode 100644 board/sophgo/milkv_duo/Kconfig
>   create mode 100644 board/sophgo/milkv_duo/MAINTAINERS
>   create mode 100644 board/sophgo/milkv_duo/Makefile
>   create mode 100644 board/sophgo/milkv_duo/board.c
>   create mode 100644 configs/milkv_duo_defconfig
>   create mode 100644 include/configs/milkv_duo.h
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 6d0d812ddb..de99ce3a28 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -14,6 +14,9 @@ config TARGET_ANDES_AE350
>   config TARGET_MICROCHIP_ICICLE
>   	bool "Support Microchip PolarFire-SoC Icicle Board"
>
> +config TARGET_MILKV_DUO
> +	bool "Support Milk-v Duo Board"
> +
>   config TARGET_OPENPITON_RISCV64
>   	bool "Support RISC-V cores on OpenPiton SoC"
>
> @@ -80,6 +83,7 @@ source "board/openpiton/riscv64/Kconfig"
>   source "board/sifive/unleashed/Kconfig"
>   source "board/sifive/unmatched/Kconfig"
>   source "board/sipeed/maix/Kconfig"
> +source "board/sophgo/milkv_duo/Kconfig"
>   source "board/starfive/visionfive2/Kconfig"
>   source "board/thead/th1520_lpi4a/Kconfig"

error: patch failed: arch/riscv/Kconfig:80

Please, rebase.


>
> diff --git a/board/sophgo/milkv_duo/Kconfig b/board/sophgo/milkv_duo/Kco=
nfig
> new file mode 100644
> index 0000000000..2a458f291c
> --- /dev/null
> +++ b/board/sophgo/milkv_duo/Kconfig
> @@ -0,0 +1,28 @@
> +if TARGET_MILKV_DUO
> +
> +config SYS_BOARD
> +	default "milkv_duo"
> +
> +config SYS_VENDOR
> +	default "sophgo"
> +
> +config SYS_CPU
> +	default "generic"
> +
> +config SYS_CONFIG_NAME
> +	default "milkv_duo"
> +
> +config TEXT_BASE
> +	default 0x80200000
> +
> +config ENV_SIZE
> +	default 0x20000
> +
> +config ENV_SECT_SIZE
> +	default 0x40000
> +
> +config BOARD_SPECIFIC_OPTIONS
> +	def_bool y
> +	select GENERIC_RISCV
> +
> +endif
> diff --git a/board/sophgo/milkv_duo/MAINTAINERS b/board/sophgo/milkv_duo=
/MAINTAINERS
> new file mode 100644
> index 0000000000..651a0592f7
> --- /dev/null
> +++ b/board/sophgo/milkv_duo/MAINTAINERS
> @@ -0,0 +1,6 @@
> +Milk-V Duo
> +M:	Kongyang Liu <seashell11234455@gmail.com>
> +S:	Maintained
> +F:	board/sophgo/milkv_duo/
> +F:	configs/milkv_duo_defconfig
> +F:	doc/board/sophgo/milkv_duo.rst
> diff --git a/board/sophgo/milkv_duo/Makefile b/board/sophgo/milkv_duo/Ma=
kefile
> new file mode 100644
> index 0000000000..a087013f5c
> --- /dev/null
> +++ b/board/sophgo/milkv_duo/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
> +
> +obj-y :=3D board.o
> diff --git a/board/sophgo/milkv_duo/board.c b/board/sophgo/milkv_duo/boa=
rd.c
> new file mode 100644
> index 0000000000..eaa47be173
> --- /dev/null
> +++ b/board/sophgo/milkv_duo/board.c
> @@ -0,0 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
> + */
> +
> +int board_init(void)
> +{
> +	return 0;
> +}
> diff --git a/configs/milkv_duo_defconfig b/configs/milkv_duo_defconfig
> new file mode 100644
> index 0000000000..c4782639ef
> --- /dev/null
> +++ b/configs/milkv_duo_defconfig
> @@ -0,0 +1,24 @@
> +CONFIG_RISCV=3Dy
> +CONFIG_SYS_MALLOC_LEN=3D0x820000
> +CONFIG_SYS_MALLOC_F_LEN=3D0x2000
> +CONFIG_NR_DRAM_BANKS=3D1
> +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x82300000
> +CONFIG_DEFAULT_DEVICE_TREE=3D"cv1800b-milkv-duo"
> +CONFIG_IDENT_STRING=3D"milkv_duo"
> +CONFIG_SYS_LOAD_ADDR=3D0x80080000
> +CONFIG_TARGET_MILKV_DUO=3Dy
> +CONFIG_ARCH_RV64I=3Dy
> +CONFIG_RISCV_SMODE=3Dy
> +CONFIG_FIT=3Dy
> +CONFIG_SUPPORT_RAW_INITRD=3Dy
> +CONFIG_HUSH_PARSER=3Dy
> +CONFIG_SYS_PROMPT=3D"milkv_duo# "
> +CONFIG_SYS_MAXARGS=3D64
> +CONFIG_SYS_CBSIZE=3D512
> +CONFIG_SYS_PBSIZE=3D544
> +CONFIG_SYS_BOOTM_LEN=3D0x4000000
> +CONFIG_ENV_OVERWRITE=3Dy
> +CONFIG_SYS_NS16550=3Dy
> +CONFIG_SYS_NS16550_MEM32=3Dy
> +# CONFIG_EFI_LOADER is not set

Is there a limitation on the size of the binary or why are you excluding
this option?

With the loady command you should be able to load an EFI binary via the
UART and then launch it. U-Boot comes with some EFI test applications
that you could run like smbiosdump.efi.

Best regards

Heinrich

> diff --git a/include/configs/milkv_duo.h b/include/configs/milkv_duo.h
> new file mode 100644
> index 0000000000..0b4109dc1f
> --- /dev/null
> +++ b/include/configs/milkv_duo.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
> + *
> + */
> +
> +#ifndef __CONFIG_H
> +#define __CONFIG_H
> +
> +#define CFG_SYS_SDRAM_BASE         0x80000000
> +
> +#endif /* __CONFIG_H */

