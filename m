Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC63CD5BA6
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 12:56:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F5F484659;
	Tue, 19 May 2026 14:56:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Mn9X0e/T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17F6C8469F; Tue, 19 May 2026 07:24:20 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A540684659
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 07:24:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-67b8d9c26bbso7262143a12.2
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 22:24:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779168257; cv=none;
 d=google.com; s=arc-20240605;
 b=Qp4CMJHQQZO6LS8D2Yn9qGwUU1AeruIv4uzwZUMP5fQKqJnG702r8h83UrizthzJt+
 ykdduZ0GGFf+nSyoqg3jI87HHF2ykGxdedhWl14YQNvANY5hOqeSWoSXld6koIPSk3Zw
 54JYkDIY5GxFZQlMS/fqOHNIoFeOkXt1SUOvZMJMfmsijxkaYPzjqsIropGsMcIRzQIN
 ae8tQo0k/JMh3fKJ3RS5kInCg9ZiA0H2nrVCtMYd5SjuRP8blolrTxOaor7LuaGRNz3U
 9+Km0sVQQB9m6pwA3hcvQ4klGAmyTKxCXOTyUelfKCqKaFDPc1CZ5xvjMfxLp2ZNyfGQ
 /pJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3ZgmYUSTqb+FmYVrMcszkmkzo3RU5ozyB2oaA+ID+aI=;
 fh=YlLXlBwBvqSj/crsRDf8PQLk196Fjal1S7Cexp9n3Vs=;
 b=IhU69KkJ9OpAnNm9jftcA2Al/Uh9DZFwxEVWypzgz+ZLXmGHw9pC9MtVbJHRMB0+PL
 K1pNHzlS9CBD5ogun00OEnIUBZRsxWIuJg6oares88e/gOhk9dz6B40yYqR7E8J3SmDt
 36tr5hCxXvDwhuXWY//ojY6CwI9hN7bQqMYs3wdrlllbtZPcvhA3PKcpYNpDlpV+Qo3v
 SmFZK2ljq/qBGboCdWs9WZzotG81aBZoQuzkuEjFJ81vv6NT8SbXy+eQCs/r0HbZZtK5
 /Kkr9nqVtR0YPB+Qnt340k+KK6X4cjkm2a9AaHpoRI4HDDFDQ7zWqZdkXtv+PnEfk+1B
 WpPg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779168257; x=1779773057; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3ZgmYUSTqb+FmYVrMcszkmkzo3RU5ozyB2oaA+ID+aI=;
 b=Mn9X0e/TfPf/LOpLQsWTXAwUXuPYJLo3OYBxoOIFjqONHwQR5qUPF54i641tvV1IJa
 3dWK9ML7YOVdGFXAcnVqU2ZS7cs16MtcxtDut2ujSDPM2OHstKMMNFS7k6r1s0QS50bB
 zpGCBIIqHYICHrJvsimM70CiutI8WhIxniHMareXu294QW/yJulEPX6fyBxfoDSbcHhs
 /w/U7Isz/Vx1hPCorsQRaPprbHKZPtDsLzfuXxcXF+b0UYj4S80YJSL3X7mGp6r6l6ZV
 LICi+I4DzqNd88i/Wio0EIPrWWxEcKhd1CkPOirs7FDbWK1fnDyLQm29UPR2Ch4Brdvf
 wMtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779168257; x=1779773057;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3ZgmYUSTqb+FmYVrMcszkmkzo3RU5ozyB2oaA+ID+aI=;
 b=kqOtTrNCaPSsyFc1eNJEuq9fG1M7n0rTwoeDZpkKNGvkJr0zfS3ou6vmx+tRwG8Dba
 OdP12HauMUg0f2qAlK7tiqWlJBXOW/O5iEytuLRjle2+xbwLTP1Fnu5p8PsaIuMhHRTB
 qZFeUm1376q1T0c3CgMlSldNG1JIR9blE7m/iulunaMjW4VtvX2zVY6hWQgUeW0YstUY
 osSQyZJhzWGcAKA3F0MiHE6t1XRXnDqdy0QF3bUu+DXmYkviAG3hqjWvlPNKrR207bvh
 yPbFPPwZOkcvSdGXVwg54chMWMr7yEACYAjTNKAOEQCFGeOGFneUPe9kwSRwq6I1f9e8
 9SDA==
X-Gm-Message-State: AOJu0Yx/JF1bbuXaTtjWkEyxMgyxf8KvLZGJB1Kt5JScbPFzaiJ/m/jA
 bLFqZ+bFx68iQ1HdjtMiy0H2hdOZ57mxqZrN82O+3j0CwwAK2rD89wCUG7xlVOiszyforHmc+IY
 UNtGzLlyIQ78qZgMPqUSOmnfWe78NlUI=
X-Gm-Gg: Acq92OGhuj94OQWACvgod1Ufc/uYKZ609cT1mkle140oSANdJj5EJ+o3ZKsD50IC0S6
 LJyet/FgHww5xV8jwxZNdhS8rUbPCPfiksq4ZOVSCajoidjnCAIPEatVTmw7Cn5beRRpvFLiOiA
 9wh56ttRp19fU9e4ufAwEO8/ifuIlNkNrO0dTGgofOrluFptXqIIBN3YPtdz2n61HDwKPvyN/v2
 hIZ8MTYMh6Z+q8OQy1jRRUgGfWhdzS0ZJ8e6on3/Hjo/tCJuW0AcgxTLYvBR+mgQVUEbtcwXHny
 wPB8Pg==
X-Received: by 2002:a05:6402:24ce:b0:671:121e:dd4a with SMTP id
 4fb4d7f45d1cf-683bc4b12a3mr8556347a12.5.1779168256682; Mon, 18 May 2026
 22:24:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260519-b4-k1-spl-bring-up-v4-0-3915a2a904c1@riscstar.com>
 <20260519-b4-k1-spl-bring-up-v4-1-3915a2a904c1@riscstar.com>
In-Reply-To: <20260519-b4-k1-spl-bring-up-v4-1-3915a2a904c1@riscstar.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Tue, 19 May 2026 10:53:58 +0530
X-Gm-Features: AVHnY4LSFUAQD-Xp7In6h9acDfA8n6rlemcSAeiZ1Tz-Y9uybw4smnE1yoUglHA
Message-ID: <CANAwSgTNtPsn66vpXRFuh0Qtjq62T5NyAp8XQM10DxbxPASc+A@mail.gmail.com>
Subject: Re: [PATCH v4 01/14] spacemit: k1: support multi-board infrastructure
To: Guodong Xu <guodong@riscstar.com>
Cc: u-boot@lists.denx.de, Kongyang Liu <seashell11234455@gmail.com>, 
 Yixun Lan <dlan@gentoo.org>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Michal Simek <michal.simek@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Yao Zi <me@ziyao.cc>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Peter Korsgaard <peter@korsgaard.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Raymond Mao <raymond.mao@riscstar.com>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Finley Xiao <finley.xiao@rock-chips.com>, Rick Chen <rick@andestech.com>, 
 Conor Dooley <conor.dooley@microchip.com>, u-boot-spacemit@groups.io, 
 Vincent Legoll <legoll@online.fr>, Huan Zhou <pericycle.cc@gmail.com>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>, 
 Randolph Sheng-Kai Lin <randolph@andestech.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Peng Fan <peng.fan@nxp.com>, Heiko Schocher <hs@nabladev.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Justin Swartz <justin.swartz@risingedge.co.za>, 
 Jaehoon Chung <jh80.chung@samsung.com>, David Lechner <dlechner@baylibre.com>, 
 Julien Masson <jmasson@baylibre.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
 Henrik Grimler <henrik@grimler.se>, Kory Maincent <kory.maincent@bootlin.com>, 
 Anshul Dalal <anshuld@ti.com>, Bo-Chen Chen <rex-bc.chen@mediatek.com>, 
 Justin Klaassen <justin@tidylabs.net>, Guodong Xu <guodong.xu@riscstar.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 19 May 2026 14:56:05 +0200
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

Hi Guodong,

Thanks,

On Tue, 19 May 2026 at 04:08, Guodong Xu <guodong@riscstar.com> wrote:
>
> From: Raymond Mao <raymond.mao@riscstar.com>
>
> Restructure K1 SoC support to handle multiple boards through a single
> configuration:
>
> 1. Rename bananapi-f3_defconfig to spacemit_k1_defconfig.
> 2. Move all K1 board files to board/spacemit/k1/.
> 3. Replace TARGET_BANANAPI_F3 with TARGET_SPACEMIT_K1 and rename the
>    board's <board>.h header to k1.h.
>
> Eliminates the need for board-specific defconfigs while maintaining
> hardware compatibility.
>
> Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
> Signed-off-by: Guodong Xu <guodong@riscstar.com>
>

:~/mainline/u-boot/risc-v/u-boot-riscv$  b4 am
20260519-b4-k1-spl-bring-up-v4-0-3915a2a904c1@riscstar.com
Looking up https://lore.kernel.org/all/20260519-b4-k1-spl-bring-up-v4-0-3915a2a904c1@riscstar.com/
Grabbing thread from
lore.kernel.org/all/20260519-b4-k1-spl-bring-up-v4-0-3915a2a904c1@riscstar.com/t.mbox.gz
Analyzing 15 messages in the thread
Looking for additional code-review trailers on lore.kernel.org
Analyzing 51 code-review messages
Checking attestation on all messages, may take a moment...
---
  [PATCH v4 1/14] spacemit: k1: support multi-board infrastructure
  [PATCH v4 2/14] spacemit: k1: enable SPL with debug UART
  [PATCH v4 3/14] configs: k1: enable early timer support
  [PATCH v4 4/14] clk: spacemit: k1: prune SPL clock tree
  [PATCH v4 5/14] configs: k1: add default option for clock driver in SPL
  [PATCH v4 6/14] dts: k1: enable clocks in SPL
  [PATCH v4 7/14] board: k1: initialize clock and serial devices in SPL
  [PATCH v4 8/14] i2c: k1: add I2C driver support
  [PATCH v4 9/14] spacemit: k1: add TLV EEPROM support in SPL
  [PATCH v4 10/14] spacemit: k1: Add DDR firmware support to SPL
  [PATCH v4 11/14] power: pmic: add support for Spacemit P1 PMIC
  [PATCH v4 12/14] power: regulator: add support for Spacemit P1 SoC
  [PATCH v4 13/14] board: k1: enable pmic in spl
  [PATCH v4 14/14] doc: spacemit: add K1 SPL build and test guide
  ---
  NOTE: install dkimpy for DKIM signature verification
---
Total patches: 14
---
Cover: ./v4_20260519_guodong_riscv_spacemit_k1_add_spl_support.cover
 Link: https://patch.msgid.link/20260519-b4-k1-spl-bring-up-v4-0-3915a2a904c1@riscstar.com
 Base: base-commit 52ec53db8f18ed476f30de3799067652948eba28 not known, ignoring
       git am ./v4_20260519_guodong_riscv_spacemit_k1_add_spl_support.mbx
amoon@Dell-5430:~/mainline/u-boot/risc-v/u-boot-riscv$ git am
./v4_20260519_guodong_riscv_spacemit_k1_add_spl_support.mbx
Applying: spacemit: k1: support multi-board infrastructure
error: patch failed: configs/bananapi-f3_defconfig:6
error: configs/bananapi-f3_defconfig: patch does not apply
Patch failed at 0001 spacemit: k1: support multi-board infrastructure
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"
amoon@Dell-5430:~/mainline/u-boot/risc-v/u-boot-riscv$

I could not apply these changes to the U-Boot mainline
Could you rebase the series on the U-Boot master branch?

Thanks
-Anand

> ---
> v4:
> - No change.
> ---
>  arch/riscv/Kconfig                                       | 8 ++++----
>  arch/riscv/cpu/k1/Kconfig                                | 4 ++++
>  board/spacemit/{bananapi-f3 => k1}/Kconfig               | 6 +++---
>  board/spacemit/{bananapi-f3 => k1}/MAINTAINERS           | 4 ++--
>  board/spacemit/{bananapi-f3 => k1}/Makefile              | 0
>  board/spacemit/{bananapi-f3 => k1}/board.c               | 0
>  configs/{bananapi-f3_defconfig => spacemit_k1_defconfig} | 2 +-
>  doc/board/spacemit/bananapi-f3.rst                       | 2 +-
>  include/configs/{bananapi-f3.h => k1.h}                  | 0
>  9 files changed, 15 insertions(+), 11 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index ad7589123c6..485067ed266 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -14,9 +14,6 @@ config TARGET_ANDES_AE350
>  config TARGET_ANDES_VOYAGER
>         bool "Support Andes Voyager Board"
>
> -config TARGET_BANANAPI_F3
> -       bool "Support BananaPi F3 Board"
> -
>  config TARGET_BEAGLEBOARD_BEAGLEVFIRE
>         bool "Support BeagleBoard BeagleV-Fire Board (based on Microchip MPFS)"
>
> @@ -50,6 +47,9 @@ config TARGET_SIPEED_MAIX
>         bool "Support Sipeed Maix Board"
>         select SYS_CACHE_SHIFT_6
>
> +config TARGET_SPACEMIT_K1
> +       bool "Support Spacemit K1 SoC"
> +
>  config TARGET_STARFIVE_VISIONFIVE2
>         bool "Support StarFive VisionFive2 Board"
>         select BOARD_LATE_INIT
> @@ -119,7 +119,7 @@ source "board/sifive/unmatched/Kconfig"
>  source "board/sipeed/maix/Kconfig"
>  source "board/sophgo/milkv_duo/Kconfig"
>  source "board/sophgo/licheerv_nano/Kconfig"
> -source "board/spacemit/bananapi-f3/Kconfig"
> +source "board/spacemit/k1/Kconfig"
>  source "board/starfive/visionfive2/Kconfig"
>  source "board/thead/th1520_lpi4a/Kconfig"
>  source "board/xilinx/mbv/Kconfig"
> diff --git a/arch/riscv/cpu/k1/Kconfig b/arch/riscv/cpu/k1/Kconfig
> index 14201df80f2..3701bf2b5da 100644
> --- a/arch/riscv/cpu/k1/Kconfig
> +++ b/arch/riscv/cpu/k1/Kconfig
> @@ -2,6 +2,8 @@
>  #
>  # Copyright (C) 2024, Kongyang Liu <seashell11234455@gmail.com>
>
> +if TARGET_SPACEMIT_K1
> +
>  config SPACEMIT_K1
>         bool
>         select BINMAN
> @@ -17,3 +19,5 @@ config SPACEMIT_K1
>         imply SPL_CPU
>         imply SPL_OPENSBI
>         imply SPL_LOAD_FIT
> +
> +endif
> diff --git a/board/spacemit/bananapi-f3/Kconfig b/board/spacemit/k1/Kconfig
> similarity index 79%
> rename from board/spacemit/bananapi-f3/Kconfig
> rename to board/spacemit/k1/Kconfig
> index f89fa9af2c7..1c615f89b64 100644
> --- a/board/spacemit/bananapi-f3/Kconfig
> +++ b/board/spacemit/k1/Kconfig
> @@ -1,7 +1,7 @@
> -if TARGET_BANANAPI_F3
> +if TARGET_SPACEMIT_K1
>
>  config SYS_BOARD
> -       default "bananapi-f3"
> +       default "k1"
>
>  config SYS_VENDOR
>         default "spacemit"
> @@ -10,7 +10,7 @@ config SYS_CPU
>         default "k1"
>
>  config SYS_CONFIG_NAME
> -       default "bananapi-f3"
> +       default "k1"
>
>  config TEXT_BASE
>         default 0x00200000
> diff --git a/board/spacemit/bananapi-f3/MAINTAINERS b/board/spacemit/k1/MAINTAINERS
> similarity index 61%
> rename from board/spacemit/bananapi-f3/MAINTAINERS
> rename to board/spacemit/k1/MAINTAINERS
> index 131bad03181..b256cbe7978 100644
> --- a/board/spacemit/bananapi-f3/MAINTAINERS
> +++ b/board/spacemit/k1/MAINTAINERS
> @@ -1,6 +1,6 @@
>  BananaPi F3
>  M:     Huan Zhou <pericycle.cc@@gmail.com>
>  S:     Maintained
> -F:     board/spacemit/bananapi-f3/
> -F:     configs/bananapi-f3_defconfig
> +F:     board/spacemit/k1/
> +F:     configs/spacemit_k1_defconfig
>  F:     doc/board/spacemit/bananapi-f3.rst
> diff --git a/board/spacemit/bananapi-f3/Makefile b/board/spacemit/k1/Makefile
> similarity index 100%
> rename from board/spacemit/bananapi-f3/Makefile
> rename to board/spacemit/k1/Makefile
> diff --git a/board/spacemit/bananapi-f3/board.c b/board/spacemit/k1/board.c
> similarity index 100%
> rename from board/spacemit/bananapi-f3/board.c
> rename to board/spacemit/k1/board.c
> diff --git a/configs/bananapi-f3_defconfig b/configs/spacemit_k1_defconfig
> similarity index 95%
> rename from configs/bananapi-f3_defconfig
> rename to configs/spacemit_k1_defconfig
> index adecbee10f2..fae561bbf8a 100644
> --- a/configs/bananapi-f3_defconfig
> +++ b/configs/spacemit_k1_defconfig
> @@ -6,7 +6,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x1000000
>  CONFIG_DEFAULT_DEVICE_TREE="spacemit/k1-bananapi-f3"
>  CONFIG_SYS_BOOTM_LEN=0xa000000
>  CONFIG_SYS_LOAD_ADDR=0x200000
> -CONFIG_TARGET_BANANAPI_F3=y
> +CONFIG_TARGET_SPACEMIT_K1=y
>  CONFIG_ARCH_RV64I=y
>  CONFIG_RISCV_SMODE=y
>  CONFIG_FIT=y
> diff --git a/doc/board/spacemit/bananapi-f3.rst b/doc/board/spacemit/bananapi-f3.rst
> index f2220950a3a..1ece2ce9d02 100644
> --- a/doc/board/spacemit/bananapi-f3.rst
> +++ b/doc/board/spacemit/bananapi-f3.rst
> @@ -29,7 +29,7 @@ built for SpacemiT K1 SoC as below:
>  .. code-block:: console
>
>     cd <U-Boot-dir>
> -   make bananapi-f3_defconfig
> +   make spacemit_k1_defconfig
>     make OPENSBI=<OpenSBI-dir>/build/platform/generic/firmware/fw_dynamic.bin
>
>  This will generate u-boot.itb
> diff --git a/include/configs/bananapi-f3.h b/include/configs/k1.h
> similarity index 100%
> rename from include/configs/bananapi-f3.h
> rename to include/configs/k1.h
>
> --
> 2.43.0
>
