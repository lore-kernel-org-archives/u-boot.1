Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC6C6C54E67
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 04:21:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D04388063;
	Wed, 27 Mar 2024 05:21:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HqhXIQjm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B143387BD6; Wed, 27 Mar 2024 05:21:40 +0100 (CET)
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com
 [IPv6:2607:f8b0:4864:20::a29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D17D88063
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 05:21:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-4d8804a553dso1325306e0c.1
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 21:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711513296; x=1712118096; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+m7AvuaS3wTTiBkiG6SLllc281sTHhR3/qHndW/MBVw=;
 b=HqhXIQjm91mnkiVHyKRvVf4xNi2GhidcYl/jL4kalj0Ndde14cb19XLkslOJGzNTH0
 Sw12YnWZTFpuYkArDVYzQCQ3p665UjVggrMfdtgjaUA2Y7jJKOVnT2EnljGR0AG5iniI
 Ni7mkbhV/9ptUGk7eUJpkx4u/nIqPizqi3NJYlfnfg7XCa5yAWuzSZUO60Syjoef0RL8
 8oT6PrSmbYHJJbcyOT57Y1rfuse8M6Nk5BevjejDyxSAccu4DBkDJCMoL5u0qBva82Xo
 vgNythTsPU46n1dlAQ3MOmEDtV38d8G5tr1YuRY1wnGqX602/1GfJcsls138e1Q5H4Zo
 p/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711513296; x=1712118096;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+m7AvuaS3wTTiBkiG6SLllc281sTHhR3/qHndW/MBVw=;
 b=NUI4Y1btj+j15YhDbDNlX88FVtZZE3aseLqHgzYhVrQfZN3wqJdGF707nxEf8HUGWk
 VFfOpnzOeENvkCqNdJBd3YOqNvtycrs1j6CI0lThwWBmpvNs1bz+/OxS46iW8oEeKSds
 4yMiL3RxzOFjZfiKmQBY2eKyx2UnDNA3aMSA1xI0ZBD3rN48+863fElzLNC6EnjHiIlf
 XGhHazE9AiTL1RFzgIqCUnPElUkti4YWdJ7sEXED/AjsPCESm4PIS21CZp5tngbigrqq
 RjZRM9mfbbxCQJAdDXBpa95HQgmV1xaw2hZKXDX1x0mRBSBUEwZdo8B2fO62ec1WT7kB
 vyMg==
X-Gm-Message-State: AOJu0YyacBM9b+xsmHOU4Sx4r29p4ynB7KuXaPBBq3Q3yZEAP0PTeK+V
 0ZF1G+gkEG0r0BLlpKO9r4Z3YjApK7IpirWv0gFHD5r7u5LMt2A9vZkAFBPf7/58IxaLU3YGsbh
 uWgR7diIwwvfHTXtepJM79b6mtm3XfQGAOpiQMA==
X-Google-Smtp-Source: AGHT+IFfbE+BUR4m2NHqX3ccUHC7c+51ZuKAlQU2iINTpnb5xOd6M++Igi6N0YRrqknQxQ6PBXqAaMy5lj8cR2ozj0M=
X-Received: by 2002:a05:6102:32ce:b0:474:c9d0:8b2 with SMTP id
 o14-20020a05610232ce00b00474c9d008b2mr2179734vss.10.1711513296212; Tue, 26
 Mar 2024 21:21:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240322021747.14873-1-mibodhi@gmail.com>
In-Reply-To: <20240322021747.14873-1-mibodhi@gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 27 Mar 2024 09:51:24 +0530
Message-ID: <CAFA6WYMaHyqf1KOn05synhqAHr_oTKtqv-DHs4-07zgS+np0XQ@mail.gmail.com>
Subject: Re: [PATCH] arm: dts: kirkwood: Enable upstream DT on Kirkwood boards
To: Tony Dinh <mibodhi@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Stefan Roese <sr@denx.de>,
 Michael Walle <michael@walle.cc>, Tom Rini <trini@konsulko.com>,
 Chris Packham <chris.packham@alliedtelesis.co.nz>, 
 Dave Purdy <david.c.purdy@gmail.com>, Evgeni Dobrev <evgeni@studio-punkt.com>, 
 Luka Perkov <luka@openwrt.org>, Siddarth Gore <gores@marvell.com>, 
 Simon Guinot <simon.guinot@sequanux.org>, 
 Stefan Herbrechtsmeier <stefan@herbrechtsmeier.net>, 
 This contributor prefers not to receive mails <noreply@example.com>,
 Walter Schweizer <swwa@users.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
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

Hi Tony,

On Fri, 22 Mar 2024 at 07:48, Tony Dinh <mibodhi@gmail.com> wrote:
>
> Enable OF_UPSTREAM to use upstream DT and add marvell/ prefix to the
> DEFAULT_DEVICE_TREE for Kirkwood boards. And so we can directly build
> DTBs from dts/upstream/src/arm/marvell, and including *-u-boot.dtsi
> files from arch/arm/dts/ directory.
>
> Background:
>
> Hi Stefan,
> Hi Michael,
>
> I did a survey and we currently have 28 Kirkwood boards. Using some
> commands and filters, here are the finding.
>
> git grep -li arch_kirkwood configs | xargs grep DEVICE_TREE | cut -d '"' -f2 | xargs -n1 sh -c 'diff -qs  arch/arm/dts/$1.dts dts/upstream/src/arm/marvell/$1.dts' sh | grep differ
>
> diff: dts/upstream/src/arm/marvell/kirkwood-atl-sbx81lifkw.dts: No such file or directory
> diff: dts/upstream/src/arm/marvell/kirkwood-atl-sbx81lifxcat.dts: No such file or directory
>
> Files arch/arm/dts/kirkwood-dockstar.dts and dts/upstream/src/arm/marvell/kirkwood-dockstar.dts differ
> Files arch/arm/dts/kirkwood-dreamplug.dts and dts/upstream/src/arm/marvell/kirkwood-dreamplug.dts differ
> Files arch/arm/dts/kirkwood-goflexnet.dts and dts/upstream/src/arm/marvell/kirkwood-goflexnet.dts differ
> Files arch/arm/dts/kirkwood-guruplug-server-plus.dts and dts/upstream/src/arm/marvell/kirkwood-guruplug-server-plus.dts differ
> Files arch/arm/dts/kirkwood-iconnect.dts and dts/upstream/src/arm/marvell/kirkwood-iconnect.dts differ
> Files arch/arm/dts/kirkwood-net2big.dts and dts/upstream/src/arm/marvell/kirkwood-net2big.dts differ
> Files arch/arm/dts/kirkwood-ns2max.dts and dts/upstream/src/arm/marvell/kirkwood-ns2max.dts differ
> Files arch/arm/dts/kirkwood-ns2mini.dts and dts/upstream/src/arm/marvell/kirkwood-ns2mini.dts differ
> Files arch/arm/dts/kirkwood-nsa310s.dts and dts/upstream/src/arm/marvell/kirkwood-nsa310s.dts differ
> Files arch/arm/dts/kirkwood-nsa325.dts and dts/upstream/src/arm/marvell/kirkwood-nsa325.dts differ
> Files arch/arm/dts/kirkwood-openrd-client.dts and dts/upstream/src/arm/marvell/kirkwood-openrd-client.dts differ
>
> diff -qrbu arch/arm/dts/ dts/upstream/src/arm/marvell/ | grep kirkwood | grep ".dtsi "
>
> Files arch/arm/dts/kirkwood-6192.dtsi and dts/upstream/src/arm/marvell/kirkwood-6192.dtsi differ
> Files arch/arm/dts/kirkwood-6281.dtsi and dts/upstream/src/arm/marvell/kirkwood-6281.dtsi differ
> Files arch/arm/dts/kirkwood-98dx4122.dtsi and dts/upstream/src/arm/marvell/kirkwood-98dx4122.dtsi differ
> Files arch/arm/dts/kirkwood-dnskw.dtsi and dts/upstream/src/arm/marvell/kirkwood-dnskw.dtsi differ
> Files arch/arm/dts/kirkwood.dtsi and dts/upstream/src/arm/marvell/kirkwood.dtsi differ
> Files arch/arm/dts/kirkwood-lsxl.dtsi and dts/upstream/src/arm/marvell/kirkwood-lsxl.dtsi differ
> Files arch/arm/dts/kirkwood-nsa3x0-common.dtsi and dts/upstream/src/arm/marvell/kirkwood-nsa3x0-common.dtsi differ
> Files arch/arm/dts/kirkwood-synology.dtsi and dts/upstream/src/arm/marvell/kirkwood-synology.dtsi differ
>
> And after reviewing these differences, the following are my observation.
>
> OF_LIST is not used in these Kirkwood boards.
>
> 1. Boards that have only u-boot DTS that should be opt-out for now with "#CONFIG_OF_UPSTREAM is not set"
>
> diff: dts/upstream/src/arm/marvell/kirkwood-atl-sbx81lifkw.dts: No such file or directory
> diff: dts/upstream/src/arm/marvell/kirkwood-atl-sbx81lifxcat.dts: No such file or directory
>
> 2. DTS and DTSI files that have only cosmetic, style, or binding changes (safe to take)
>
> Files arch/arm/dts/kirkwood-dockstar.dts and dts/upstream/src/arm/marvell/kirkwood-dockstar.dts differ
> Files arch/arm/dts/kirkwood-goflexnet.dts and dts/upstream/src/arm/marvell/kirkwood-goflexnet.dts differ
> Files arch/arm/dts/kirkwood-guruplug-server-plus.dts and dts/upstream/src/arm/marvell/kirkwood-guruplug-server-plus.dts differ
> Files arch/arm/dts/kirkwood-iconnect.dts and dts/upstream/src/arm/marvell/kirkwood-iconnect.dts differ
> Files arch/arm/dts/kirkwood-net2big.dts and dts/upstream/src/arm/marvell/kirkwood-net2big.dts differ
> Files arch/arm/dts/kirkwood-ns2max.dts and dts/upstream/src/arm/marvell/kirkwood-ns2max.dts differ
> Files arch/arm/dts/kirkwood-ns2mini.dts and dts/upstream/src/arm/marvell/kirkwood-ns2mini.dts differ
> Files arch/arm/dts/kirkwood-nsa325.dts and dts/upstream/src/arm/marvell/kirkwood-nsa325.dts differ
> Files arch/arm/dts/kirkwood-openrd-client.dts and dts/upstream/src/arm/marvell/kirkwood-openrd-client.dts differ
>
> Files arch/arm/dts/kirkwood-dnskw.dtsi and dts/upstream/src/arm/marvell/kirkwood-dnskw.dtsi differ
> Files arch/arm/dts/kirkwood.dtsi and dts/upstream/src/arm/marvell/kirkwood.dtsi differ
> Files arch/arm/dts/kirkwood-synology.dtsi and dts/upstream/src/arm/marvell/kirkwood-synology.dtsi differ
>
> 3. DTS files that are newer in upstream (safe to take with regression test)
>
> Files arch/arm/dts/kirkwood-nsa310s.dts and dts/upstream/src/arm/marvell/kirkwood-nsa310s.dts differ
>
> 4. DTSI files that have additional PCI-related bindings in upstream (safe to take with regression test)
>
> Files arch/arm/dts/kirkwood-6192.dtsi and dts/upstream/src/arm/marvell/kirkwood-6192.dtsi differ
> Files arch/arm/dts/kirkwood-6281.dtsi and dts/upstream/src/arm/marvell/kirkwood-6281.dtsi differ
> Files arch/arm/dts/kirkwood-98dx4122.dtsi and dts/upstream/src/arm/marvell/kirkwood-98dx4122.dtsi differ
>
> 5. DTSI files that will need new or modified -u-boot.dtsi
>
> Files arch/arm/dts/kirkwood-dreamplug.dts and dts/upstream/src/arm/marvell/kirkwood-dreamplug.dts differ
> Files arch/arm/dts/kirkwood-lsxl.dtsi and dts/upstream/src/arm/marvell/kirkwood-lsxl.dtsi differ
> Files arch/arm/dts/kirkwood-nsa3x0-common.dtsi and dts/upstream/src/arm/marvell/kirkwood-nsa3x0-common.dtsi differ
>
> So these u-boot.dtsi files need to be created/modified so we can use upstream DTS/DTSI:
>
>         modified:   arch/arm/dts/kirkwood-lschlv2-u-boot.dtsi
>         modified:   arch/arm/dts/kirkwood-lsxhl-u-boot.dtsi
>
>         new file:   arch/arm/dts/kirkwood-dreamplug-u-boot.dtsi
>         new file:   arch/arm/dts/kirkwood-nsa325-u-boot.dtsi
>
> I've regression tested this patch with the Zyxel NSA325 (Kirkwood 88F6282)
> and Zyxel NSA310S (Kirkwood 88F6281). The Zyxel NSA325 board has a
> USB 3.0 controller attached to the PCIe bus. And the Zyxel NSA310S
> has an extensive overhaul in bindings and styles in upstream DTS version.
>
> Signed-off-by: Tony Dinh <mibodhi@gmail.com>
> ---
>
>  arch/arm/dts/kirkwood-dreamplug-u-boot.dtsi | 7 +++++++
>  arch/arm/dts/kirkwood-lschlv2-u-boot.dtsi   | 6 ++++--
>  arch/arm/dts/kirkwood-lsxhl-u-boot.dtsi     | 6 ++++--
>  arch/arm/dts/kirkwood-nsa325-u-boot.dtsi    | 7 +++++++
>  arch/arm/mach-kirkwood/Kconfig              | 4 ++++
>  configs/SBx81LIFKW_defconfig                | 1 +
>  configs/SBx81LIFXCAT_defconfig              | 1 +
>  configs/d2net_v2_defconfig                  | 2 +-
>  configs/dns325_defconfig                    | 2 +-
>  configs/dockstar_defconfig                  | 2 +-
>  configs/dreamplug_defconfig                 | 2 +-
>  configs/ds109_defconfig                     | 2 +-
>  configs/goflexhome_defconfig                | 2 +-
>  configs/guruplug_defconfig                  | 2 +-
>  configs/ib62x0_defconfig                    | 2 +-
>  configs/iconnect_defconfig                  | 2 +-
>  configs/inetspace_v2_defconfig              | 2 +-
>  configs/lschlv2_defconfig                   | 2 +-
>  configs/lsxhl_defconfig                     | 2 +-
>  configs/nas220_defconfig                    | 2 +-
>  configs/net2big_v2_defconfig                | 2 +-
>  configs/netspace_lite_v2_defconfig          | 2 +-
>  configs/netspace_max_v2_defconfig           | 2 +-
>  configs/netspace_mini_v2_defconfig          | 2 +-
>  configs/netspace_v2_defconfig               | 2 +-
>  configs/nsa310s_defconfig                   | 2 +-
>  configs/nsa325_defconfig                    | 2 +-
>  configs/openrd_base_defconfig               | 2 +-
>  configs/openrd_client_defconfig             | 2 +-
>  configs/openrd_ultimate_defconfig           | 2 +-
>  configs/pogo_e02_defconfig                  | 2 +-
>  configs/pogo_v4_defconfig                   | 2 +-
>  configs/sheevaplug_defconfig                | 2 +-
>  33 files changed, 54 insertions(+), 30 deletions(-)
>  create mode 100644 arch/arm/dts/kirkwood-dreamplug-u-boot.dtsi
>  create mode 100644 arch/arm/dts/kirkwood-nsa325-u-boot.dtsi
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
> +       aliases {
> +               spi0 = &spi0;
> +       };
> +};
> diff --git a/arch/arm/dts/kirkwood-lschlv2-u-boot.dtsi b/arch/arm/dts/kirkwood-lschlv2-u-boot.dtsi
> index 7fc2d7d3b4..cf33ff822e 100644
> --- a/arch/arm/dts/kirkwood-lschlv2-u-boot.dtsi
> +++ b/arch/arm/dts/kirkwood-lschlv2-u-boot.dtsi
> @@ -1,7 +1,9 @@
>  // SPDX-License-Identifier: GPL-2.0+
>
> -&eth0 {
> -       status = "disabled";
> +/ {
> +       aliases {
> +               spi0 = &spi0;
> +       };
>  };
>
>  &hdd_power {
> diff --git a/arch/arm/dts/kirkwood-lsxhl-u-boot.dtsi b/arch/arm/dts/kirkwood-lsxhl-u-boot.dtsi
> index 7fc2d7d3b4..cf33ff822e 100644
> --- a/arch/arm/dts/kirkwood-lsxhl-u-boot.dtsi
> +++ b/arch/arm/dts/kirkwood-lsxhl-u-boot.dtsi
> @@ -1,7 +1,9 @@
>  // SPDX-License-Identifier: GPL-2.0+
>
> -&eth0 {
> -       status = "disabled";
> +/ {
> +       aliases {
> +               spi0 = &spi0;
> +       };
>  };
>
>  &hdd_power {
> diff --git a/arch/arm/dts/kirkwood-nsa325-u-boot.dtsi b/arch/arm/dts/kirkwood-nsa325-u-boot.dtsi
> new file mode 100644
> index 0000000000..dec27b2a87
> --- /dev/null
> +++ b/arch/arm/dts/kirkwood-nsa325-u-boot.dtsi
> @@ -0,0 +1,7 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +&nand {
> +       partition@0 {
> +               /delete-property/ read-only;
> +       };
> +};
> diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
> index c2fff84a68..39593c83d0 100644
> --- a/arch/arm/mach-kirkwood/Kconfig
> +++ b/arch/arm/mach-kirkwood/Kconfig
> @@ -28,6 +28,10 @@ config CUSTOM_SYS_INIT_SP_ADDR
>          depends on HAS_CUSTOM_SYS_INIT_SP_ADDR
>          default 0x5ff000
>
> +config OF_UPSTREAM
> +       bool "Use upstream DTS for Kirkwood boards"
> +       default y

You don't have to create a new config option here, just add "imply
OF_UPSTREAM" for the SoC which you want to switch, something like:

diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
index c2fff84a686..031d4e5ecd3 100644
--- a/arch/arm/mach-kirkwood/Kconfig
+++ b/arch/arm/mach-kirkwood/Kconfig
@@ -6,10 +6,12 @@ config FEROCEON_88FR131
 config KW88F6192
        bool
        select ARCH_VERY_EARLY_INIT
+       imply OF_UPSTREAM

 config KW88F6281
        bool
        select ARCH_VERY_EARLY_INIT
+       imply OF_UPSTREAM

 config SHEEVA_88SV131
        bool

-Sumit
