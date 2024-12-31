Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 138FFE7718B
	for <u-boot@archiver.kernel.org>; Tue, 31 Dec 2024 20:32:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31B0B8021A;
	Tue, 31 Dec 2024 21:32:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="DbwqU1CX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 905738021D; Tue, 31 Dec 2024 21:32:08 +0100 (CET)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B202A80196
 for <u-boot@lists.denx.de>; Tue, 31 Dec 2024 21:32:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-e53aa843a24so11154284276.0
 for <u-boot@lists.denx.de>; Tue, 31 Dec 2024 12:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1735677123; x=1736281923; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n2IbwbV28nxPRjgzsdqR07sSXJTjWDJwjawT5leHfXk=;
 b=DbwqU1CXSUHrV3Ir1zStQ3m+0NYqGewSsM4nYQH0qb+dYOW2TPR/wJB9ZrdOls8COg
 IPkd5QJz6VNAHLo5mevExmtS8obktaPeLOC0W+YamE7j8Ko+rApDQKKl9AQBGO/Ki3Dm
 fVtKP+m10AWEyvZyFaKieUDc5twmv1RdWDxwxIUS/REw4MViq/a7lUTxlleabI9Wpz9K
 Q8ePyyu6Dik6oaF96vNV9fIiPehzcscC5BzlOYlv9BbW7MX+cVPcJHzDl5QPX9SCAcMs
 cAm0ACAd3MirEYC4m+IjLDOUT5lfPZua4kNXOXRjnk2e9AVc7x3AGNHNvdt46+rJYau5
 U/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735677123; x=1736281923;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n2IbwbV28nxPRjgzsdqR07sSXJTjWDJwjawT5leHfXk=;
 b=aSDJoVqDKKWPhlvD0+lR/Qbcp/UlYivSKliMQ9kFyFm+brXg0dpmFpzwN2tHz0RJMt
 5pjPO26rZtrB4vDPdbfotDHAIuyzIpR9osL59kfYSEbg5RsBWTwDTUg54moH9qb8MSCO
 A1c4taUDkRY5Ah0yxkZHWOqPmHW097xuqikG9Tj8mwt2eGqMq8cZDOyg4h7jHGEiRsnz
 nwGPpRxZtXnxIxfh6aMMQ8boUIbzsfFq2f8XH9ezir6UNwa89rjGGxHwifzZuEuMoM0y
 d5l/vQBa8YPV1TRIbWfW8Rsm6HWUVIZi9mgkNiFQznTyxYeNqgV6PMNAGRIPVSzeWqIg
 KxMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHOhaWg86YPLvNvtJVKDUVAGxdRXrl+jpaE0pAzpR7Ks/Uz2jMwNLtSNby1coBvOMeMbC2Io8=@lists.denx.de
X-Gm-Message-State: AOJu0Yyx34/YMIo7dAQonPHf0NimMbWI+vlZbHaYIW6csqkGblhlHLiq
 V7yRStZMqQwErG+/3oRLJk93kSKPoDrtS0Tb/aNKwZQqXPskt9m/dHCXgwapiZWRSu6TQKraHyg
 58ohXxqVuhOS+DP00SS58F19Ici4gA3JDuSP8mw==
X-Gm-Gg: ASbGnctlkidhITcQFBpAjouRFRjEoEF1IO/dznjuJ6fEgP2Oo4vQPTo5zxzCG7xX2DA
 knYqWSjYqM845Gpo12PmWvCBqmV52FCu7SSTrOQ==
X-Google-Smtp-Source: AGHT+IH/gEhsgxztsOni1edb8C+l4fYgTP3RC/vGJix+slOwp+cktq1nF91Qe1RT1RcM4JNeN21WaTIvA1mocoM82xg=
X-Received: by 2002:a05:690c:c14:b0:6e5:adf8:b0a8 with SMTP id
 00721157ae682-6f3f7e1cecfmr284670657b3.6.1735677123215; Tue, 31 Dec 2024
 12:32:03 -0800 (PST)
MIME-Version: 1.0
References: <20241220-imx95-v1-0-ba81dfd8e369@oss.nxp.com>
 <20241220-imx95-v1-16-ba81dfd8e369@oss.nxp.com>
 <CAJ+vNU16T8Chsdy0+tHy7tCcfKfVGVFUr9baTCH7U4X9v6dFRg@mail.gmail.com>
 <PAXPR04MB964402195A6BCEFE58D850BEE20A2@PAXPR04MB9644.eurprd04.prod.outlook.com>
In-Reply-To: <PAXPR04MB964402195A6BCEFE58D850BEE20A2@PAXPR04MB9644.eurprd04.prod.outlook.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Tue, 31 Dec 2024 12:31:52 -0800
Message-ID: <CAJ+vNU16TYwegj3GkP+mLMj_cYUWgn3hkbsQF0wmS6Yb2VLn2w@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v2 16/17] imx95_evk: add i.MX95 19x19 EVK board
 basic support
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>,
 Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "marex@denx.de" <marex@denx.de>,
 Alice Guo <alice.guo@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Dec 30, 2024 at 6:34=E2=80=AFPM Alice Guo (OSS) <alice.guo@oss.nxp.=
com> wrote:
>
> > =E4=B8=BB=E9=A2=98: [EXT] Re: [PATCH v2 16/17] imx95_evk: add i.MX95 19=
x19 EVK board
> > basic support
> > >
> > I gave this series a go on top of 5cfbf8c364 origin/next on an EVK I ha=
ve here
> > and I saw no u-boot proper output after the ATF.
> >
> > Here is what I saw on UART2:
> > U-Boot SPL 2025.01-rc5-00393-g9b292f7d347f (Dec 27 2024 - 16:12:20 -080=
0)
> > DDRMIX is powered UP Normal Boot Trying to boot from MMC2 Primary set
> > selected Load image from MMC/SD 0xdec00
> > NOTICE:  BL31: v2.10.0  (release):lf-6.6.52-2.2.0
> > NOTICE:  BL31: Built : 16:06:15, Dec 27 2024
> >
> > U-Boot SPL 2025.01-rc5-00393-g9b292f7d347f (Dec 27 2024 - 16:12:20 -080=
0)
> > DDRMIX is powered UP Normal Boot Trying to boot from MMC2 Primary set
> > selected Load image from MMC/SD 0xdec00
> > NOTICE:  BL31: v2.10.0  (release):lf-6.6.52-2.2.0
> > NOTICE:  BL31: Built : 16:06:15, Dec 27 2024 ^^^ nothing after this
> >
> > Any thoughts on what is wrong here?
> >
> > Best Regards,
> >
> > Tim
>
> Hi Tim,
>
> I tried it on my MX95 and it works well, so I not sure what causes this i=
ssue on your EVK.
>

Hi Alice,

I discovered what happened. The first make for uboot resulted in a
binman warning (which should be a failure but is not for some reason)
and results in an image that doesn't contain uboot proper:
WARNING './u-boot.bin' not found, resulting binary may be not-functional

Simon, do you know why this warning doesn't result in a make failure?

Doing a second make works, so I think there is likely a binman
dependency issue going on here. You can re-create the issue with a
distclean as shown here:

$ make distclean
  CLEAN   dts/./upstream/src/arm64
  CLEAN   dts
  CLEAN   lib/efi_loader
  CLEAN   tools
  CLEAN   tools/generated
  CLEAN   spl/arch spl/board spl/boot spl/cmd spl/common spl/disk
spl/drivers spl/dts spl/env spl/fs spl/lib spl/spl
spl/u-boot-spl spl/u-boot-spl.bin spl/u-boot-spl.cfgout
spl/u-boot-spl.dtb spl/u-boot-spl-dtb.bin spl/u-boot-spl.lds
spl/u-boot-spl.map spl/u-boot-spl-nodtb.bin spl/u-boot-spl.sym
  CLEAN   include/config.h u-boot u-boot.bin u-boot.cfg
u-boot-container.cfgout u-boot.dtb u-boot-dtb.bin u-boot-dtb.
img u-boot.dtb.out u-boot.elf u-boot-elf.lds u-boot-elf.o u-boot.img
u-boot.lds u-boot.map u-boot-nodtb.bin u-boot-sp
l.dtb.out u-boot.srec u-boot.sym System.map mkimage-out.spl.mkimage
mkimage.spl.mkimage imx-boot.map spl.map
  CLEAN   scripts/basic
  CLEAN   scripts/dtc/pylibfdt
  CLEAN   scripts/dtc
  CLEAN   scripts/kconfig
  CLEAN   include/config include/generated spl
  CLEAN   .config .config.old
$ make imx95_19x19_evk_defconfig
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/kconfig/conf.o
  YACC    scripts/kconfig/zconf.tab.c
  LEX     scripts/kconfig/zconf.lex.c
  HOSTCC  scripts/kconfig/zconf.tab.o
  HOSTLD  scripts/kconfig/conf
#
# configuration written to .config
#
$ make && ls -l imx-boot-imx95.bin
scripts/kconfig/conf  --syncconfig Kconfig
  UPD     include/config.h
  CFG     u-boot.cfg
  GEN     include/autoconf.mk
  GEN     include/autoconf.mk.dep
  CFG     spl/u-boot.cfg
  GEN     spl/include/autoconf.mk
  UPD     include/config/uboot.release
  UPD     include/generated/version_autogenerated.h
  UPD     include/generated/timestamp_autogenerated.h
  UPD     include/generated/dt.h
  ENVC    include/generated/env.txt
  ENVP    include/generated/env.in
  ENVT    include/generated/environment.h
  CC      lib/asm-offsets.s
  UPD     include/generated/generic-asm-offsets.h
  CC      arch/arm/lib/asm-offsets.s
  UPD     include/generated/asm-offsets.h
  SHIPPED scripts/dtc/pylibfdt/libfdt.i
  PYMOD   rebuild
  HOSTCC  scripts/dtc/dtc.o
  HOSTCC  scripts/dtc/flattree.o
  HOSTCC  scripts/dtc/fstree.o
  HOSTCC  scripts/dtc/data.o
  HOSTCC  scripts/dtc/livetree.o
  HOSTCC  scripts/dtc/treesource.o
  HOSTCC  scripts/dtc/srcpos.o
  HOSTCC  scripts/dtc/checks.o
  HOSTCC  scripts/dtc/util.o
  LEX     scripts/dtc/dtc-lexer.lex.c
  YACC    scripts/dtc/dtc-parser.tab.h
  HOSTCC  scripts/dtc/dtc-lexer.lex.o
  YACC    scripts/dtc/dtc-parser.tab.c
  HOSTCC  scripts/dtc/dtc-parser.tab.o
  HOSTLD  scripts/dtc/dtc
  HOSTCC  tools/gen_eth_addr
  HOSTCC  tools/gen_ethaddr_crc.o
  WRAP    tools/generated/lib/crc8.c
  HOSTCC  tools/generated/lib/crc8.o
  HOSTLD  tools/gen_ethaddr_crc
  HOSTCC  tools/img2srec
  HOSTCC  tools/mkenvimage.o
  HOSTCC  tools/os_support.o
  WRAP    tools/generated/lib/crc32.c
  HOSTCC  tools/generated/lib/crc32.o
  HOSTLD  tools/mkenvimage
  HOSTCC  tools/aisimage.o
  HOSTCC  tools/atmelimage.o
  HOSTCC  tools/fit_common.o
  HOSTCC  tools/fit_image.o
  HOSTCC  tools/image-host.o
  WRAP    tools/generated/boot/image-fit.c
  HOSTCC  tools/generated/boot/image-fit.o
  HOSTCC  tools/image-sig-host.o
  WRAP    tools/generated/boot/image-fit-sig.c
  HOSTCC  tools/generated/boot/image-fit-sig.o
  WRAP    tools/generated/boot/image-cipher.c
  HOSTCC  tools/generated/boot/image-cipher.o
  WRAP    tools/generated/boot/fdt_region.c
  HOSTCC  tools/generated/boot/fdt_region.o
  WRAP    tools/generated/boot/bootm.c
  HOSTCC  tools/generated/boot/bootm.o
  HOSTCC  tools/default_image.o
  WRAP    tools/generated/lib/fdtdec_common.c
  HOSTCC  tools/generated/lib/fdtdec_common.o
  WRAP    tools/generated/lib/fdtdec.c
  HOSTCC  tools/generated/lib/fdtdec.o
  WRAP    tools/generated/boot/image.c
  HOSTCC  tools/generated/boot/image.o
  WRAP    tools/generated/boot/image-host.c
  HOSTCC  tools/generated/boot/image-host.o
  HOSTCC  tools/imagetool.o
  HOSTCC  tools/imximage.o
  HOSTCC  tools/imx8image.o
  HOSTCC  tools/imx8mimage.o
  HOSTCC  tools/kwbimage.o
  WRAP    tools/generated/lib/md5.c
  HOSTCC  tools/generated/lib/md5.o
  HOSTCC  tools/lpc32xximage.o
  HOSTCC  tools/mxsimage.o
  HOSTCC  tools/omapimage.o
  HOSTCC  tools/pblimage.o
  HOSTCC  tools/pbl_crc32.o
  HOSTCC  tools/renesas_spkgimage.o
  HOSTCC  tools/sfspl.o
  HOSTCC  tools/vybridimage.o
  HOSTCC  tools/stm32image.o
  WRAP    tools/generated/lib/rc4.c
  HOSTCC  tools/generated/lib/rc4.o
  HOSTCC  tools/rkcommon.o
  HOSTCC  tools/rkimage.o
  HOSTCC  tools/rksd.o
  HOSTCC  tools/rkspi.o
  HOSTCC  tools/socfpgaimage.o
  HOSTCC  tools/sunxi_egon.o
  WRAP    tools/generated/lib/crc16-ccitt.c
  HOSTCC  tools/generated/lib/crc16-ccitt.o
  WRAP    tools/generated/lib/hash-checksum.c
  HOSTCC  tools/generated/lib/hash-checksum.o
  WRAP    tools/generated/lib/sha1.c
  HOSTCC  tools/generated/lib/sha1.o
  WRAP    tools/generated/lib/sha256.c
  HOSTCC  tools/generated/lib/sha256.o
  WRAP    tools/generated/lib/sha512.c
  HOSTCC  tools/generated/lib/sha512.o
  WRAP    tools/generated/common/hash.c
  HOSTCC  tools/generated/common/hash.o
  HOSTCC  tools/ublimage.o
  HOSTCC  tools/zynqimage.o
  HOSTCC  tools/zynqmpimage.o
  HOSTCC  tools/zynqmpbif.o
  WRAP    tools/generated/lib/fdt-libcrypto.c
  HOSTCC  tools/generated/lib/fdt-libcrypto.o
  HOSTCC  tools/sunxi_toc0.o
  HOSTCC  tools/libfdt/fdt.o
  HOSTCC  tools/libfdt/fdt_ro.o
  HOSTCC  tools/libfdt/fdt_wip.o
  HOSTCC  tools/libfdt/fdt_sw.o
  HOSTCC  tools/libfdt/fdt_rw.o
  HOSTCC  tools/libfdt/fdt_strerror.o
  HOSTCC  tools/libfdt/fdt_empty_tree.o
  HOSTCC  tools/libfdt/fdt_addresses.o
  HOSTCC  tools/libfdt/fdt_overlay.o
  HOSTCC  tools/gpimage.o
  HOSTCC  tools/gpimage-common.o
  HOSTCC  tools/mtk_image.o
  HOSTCC  tools/mtk_nand_headers.o
  WRAP    tools/generated/lib/ecdsa/ecdsa-libcrypto.c
  HOSTCC  tools/generated/lib/ecdsa/ecdsa-libcrypto.o
  WRAP    tools/generated/lib/rsa/rsa-sign.c
  HOSTCC  tools/generated/lib/rsa/rsa-sign.o
  WRAP    tools/generated/lib/rsa/rsa-verify.c
  HOSTCC  tools/generated/lib/rsa/rsa-verify.o
  WRAP    tools/generated/lib/rsa/rsa-mod-exp.c
  HOSTCC  tools/generated/lib/rsa/rsa-mod-exp.o
  WRAP    tools/generated/lib/aes/aes-encrypt.c
  HOSTCC  tools/generated/lib/aes/aes-encrypt.o
  WRAP    tools/generated/lib/aes/aes-decrypt.c
  HOSTCC  tools/generated/lib/aes/aes-decrypt.o
  HOSTCC  tools/dumpimage.o
  HOSTLD  tools/dumpimage
  HOSTCC  tools/mkimage.o
  HOSTLD  tools/mkimage
  HOSTCC  tools/fit_info.o
  HOSTLD  tools/fit_info
  HOSTCC  tools/fit_check_sign.o
  HOSTLD  tools/fit_check_sign
  HOSTCC  tools/fdt_add_pubkey.o
  HOSTLD  tools/fdt_add_pubkey
  HOSTCC  tools/proftool.o
  WRAP    tools/generated/lib/abuf.c
  HOSTCC  tools/generated/lib/abuf.o
  HOSTLD  tools/proftool
  HOSTCC  tools/relocate-rela
  HOSTCC  tools/fdtgrep.o
  HOSTLD  tools/fdtgrep
  HOSTCC  tools/spl_size_limit
  WRAP    tools/generated/lib/uuid.c
  HOSTCC  tools/generated/lib/uuid.o
  HOSTCC  tools/mkeficapsule.o
  HOSTLD  tools/mkeficapsule
  AR      arch/arm/cpu/built-in.o
  CC      arch/arm/cpu/armv8/cpu.o
  CC      arch/arm/cpu/armv8/generic_timer.o
  CC      arch/arm/cpu/armv8/cache_v8.o
  AS      arch/arm/cpu/armv8/cache.o
  AS      arch/arm/cpu/armv8/exceptions.o
  CC      arch/arm/cpu/armv8/exception_level.o
  AS      arch/arm/cpu/armv8/tlb.o
  AS      arch/arm/cpu/armv8/transition.o
  CC      arch/arm/cpu/armv8/fwcall.o
  CC      arch/arm/cpu/armv8/cpu-dt.o
  AS      arch/arm/cpu/armv8/smccc-call.o
  AR      arch/arm/cpu/armv8/built-in.o
  AS      arch/arm/cpu/armv8/start.o
  AS      arch/arm/lib/crt0_64.o
  AS      arch/arm/lib/setjmp_aarch64.o
  AS      arch/arm/lib/relocate_64.o
  CC      arch/arm/lib/bootm-fdt.o
  CC      arch/arm/lib/bootm.o
  CC      arch/arm/lib/image.o
  CC      arch/arm/lib/bdinfo.o
  CC      arch/arm/lib/sections.o
  CC      arch/arm/lib/stack.o
  CC      arch/arm/lib/interrupts_64.o
  CC      arch/arm/lib/reset.o
  CC      arch/arm/lib/cache.o
  CC      arch/arm/lib/psci-dt.o
  AR      arch/arm/lib/built-in.o
  AR      arch/arm/lib/lib.a
  CC      arch/arm/mach-imx/imx9/scmi/soc.o
  CC      arch/arm/mach-imx/imx9/scmi/clock_scmi.o
  CC      arch/arm/mach-imx/imx9/scmi/clock.o
  AR      arch/arm/mach-imx/imx9/scmi/built-in.o
  AS      arch/arm/mach-imx/imx9/lowlevel_init.o
  CC      arch/arm/mach-imx/imx9/imx_bootaux.o
  AR      arch/arm/mach-imx/imx9/built-in.o
  CC      arch/arm/mach-imx/iomux-v3.o
  CC      arch/arm/mach-imx/fdt.o
  CC      arch/arm/mach-imx/misc.o
  AR      arch/arm/mach-imx/built-in.o
  CC      board/freescale/common/mmc.o
  AR      board/freescale/common/built-in.o
  CC      board/freescale/imx95_evk/imx95_evk.o
  AR      board/freescale/imx95_evk/built-in.o
  CC      boot/bootm.o
  CC      boot/bootm_os.o
  CC      boot/pxe_utils.o
  CC      boot/image.o
  CC      boot/image-board.o
  CC      boot/bootdev-uclass.o
  CC      boot/bootflow.o
  CC      boot/bootmeth-uclass.o
  CC      boot/bootstd-uclass.o
  CC      boot/bootmeth_extlinux.o
  CC      boot/bootmeth_efi.o
  CC      boot/bootmeth_efi_mgr.o
  CC      boot/fdt_support.o
  CC      boot/image-fdt.o
  AR      boot/built-in.o
  AR      cmd/arm/built-in.o
  CC      cmd/boot.o
  CC      cmd/bootm.o
  CC      cmd/help.o
  CC      cmd/panic.o
  CC      cmd/version.o
  CC      cmd/blk_common.o
  CC      cmd/bootflow.o
  CC      cmd/source.o
  CC      cmd/bdinfo.o
  CC      cmd/blkcache.o
  CC      cmd/bootefi.o
  CC      cmd/booti.o
  CC      cmd/cache.o
  CC      cmd/clk.o
  CC      cmd/console.o
  CC      cmd/date.o
  CC      cmd/dm.o
  CC      cmd/echo.o
  CC      cmd/efidebug.o
  CC      cmd/efi_common.o
  CC      cmd/eficonfig.o
  CC      cmd/elf.o
  CC      cmd/exit.o
  CC      cmd/ext4.o
  CC      cmd/ext2.o
  CC      cmd/fat.o
  CC      cmd/fdt.o
  CC      cmd/fs.o
  CC      cmd/fuse.o
  CC      cmd/gettime.o
  CC      cmd/gpio.o
  CC      cmd/i2c.o
  CC      cmd/hash.o
  CC      cmd/itest.o
  CC      cmd/load.o
  CC      cmd/mem.o
  CC      cmd/mii.o
  CC      cmd/mdio.o
  CC      cmd/sleep.o
  CC      cmd/mmc.o
  CC      cmd/legacy-mtd-utils.o
  CC      cmd/net.o
  CC      cmd/net-common.o
  CC      cmd/nvedit.o
  CC      cmd/nvedit_efi.o
  CC      cmd/part.o
  CC      cmd/pci.o
  CC      cmd/pinmux.o
  CC      cmd/rtc.o
  CC      cmd/sf.o
  CC      cmd/setexpr.o
  CC      cmd/time.o
  CC      cmd/timer.o
  CC      cmd/test.o
  CC      cmd/unlz4.o
  CC      cmd/unzip.o
  CC      cmd/lzmadec.o
  CC      cmd/ximg.o
  CC      cmd/dfu.o
  CC      cmd/gpt.o
  CC      cmd/regulator.o
  AR      cmd/built-in.o
  CC      common/init/board_init.o
  AR      common/init/built-in.o
  CC      common/main.o
  CC      common/memtop.o
  CC      common/exports.o
  CC      common/cli_getch.o
  CC      common/cli_simple.o
  CC      common/cli_readline.o
  CC      common/cli_hush.o
  CC      common/autoboot.o
  CC      common/version.o
  CC      common/board_f.o
  CC      common/board_r.o
  CC      common/board_info.o
  CC      common/miiphyutil.o
  CC      common/splash.o
  CC      common/menu.o
  CC      common/console.o
  CC      common/dlmalloc.o
  CC      common/malloc_simple.o
  CC      common/event.o
  CC      common/hash.o
  CC      common/memsize.o
  CC      common/stdio.o
  CC      common/cli.o
  CC      common/command.o
  CC      common/s_record.o
  CC      common/xyzModem.o
  AR      common/built-in.o
  CC      disk/part.o
  CC      disk/disk-uclass.o
  CC      disk/part_dos.o
  CC      disk/part_efi.o
  AR      disk/built-in.o
  AR      drivers/ata/built-in.o
  AR      drivers/axi/built-in.o
  CC      drivers/block/blk-uclass.o
  CC      drivers/block/blkcache.o
  AR      drivers/block/built-in.o
  AR      drivers/bus/built-in.o
  AR      drivers/cache/built-in.o
  AR      drivers/clk/adi/built-in.o
  AR      drivers/clk/analogbits/built-in.o
  CC      drivers/clk/imx/clk-gate2.o
  CC      drivers/clk/imx/clk-pllv3.o
  CC      drivers/clk/imx/clk-pfd.o
  AR      drivers/clk/imx/built-in.o
  AR      drivers/clk/tegra/built-in.o
  AR      drivers/clk/ti/built-in.o
  CC      drivers/clk/clk-uclass.o
  CC      drivers/clk/clk_fixed_rate.o
  CC      drivers/clk/clk_fixed_factor.o
  CC      drivers/clk/clk.o
  CC      drivers/clk/clk-divider.o
  CC      drivers/clk/clk-mux.o
  CC      drivers/clk/clk-gate.o
  CC      drivers/clk/clk-fixed-factor.o
  CC      drivers/clk/clk_scmi.o
  AR      drivers/clk/built-in.o
  CC      drivers/core/device.o
  CC      drivers/core/fdtaddr.o
  CC      drivers/core/lists.o
  CC      drivers/core/root.o
  CC      drivers/core/uclass.o
  CC      drivers/core/util.o
  CC      drivers/core/tag.o
  CC      drivers/core/device-remove.o
  CC      drivers/core/simple-bus.o
  CC      drivers/core/dump.o
  CC      drivers/core/regmap.o
  CC      drivers/core/syscon-uclass.o
  CC      drivers/core/of_extra.o
  CC      drivers/core/ofnode.o
  CC      drivers/core/read_extra.o
  AR      drivers/core/built-in.o
  AR      drivers/crypto/aspeed/built-in.o
  CC      drivers/crypto/fsl/sec.o
  AR      drivers/crypto/fsl/built-in.o
  AR      drivers/crypto/hash/built-in.o
  AR      drivers/crypto/nuvoton/built-in.o
  AR      drivers/crypto/rsa_mod_exp/built-in.o
  AR      drivers/crypto/built-in.o
  CC      drivers/dfu/dfu.o
  CC      drivers/dfu/dfu_mmc.o
  CC      drivers/dfu/dfu_ram.o
  AR      drivers/dfu/built-in.o
  CC      drivers/firmware/scmi/scmi_agent-uclass.o
  CC      drivers/firmware/scmi/base.o
  CC      drivers/firmware/scmi/smt.o
  CC      drivers/firmware/scmi/mailbox_agent.o
  CC      drivers/firmware/scmi/pwdom.o
  AR      drivers/firmware/scmi/built-in.o
  CC      drivers/firmware/firmware-uclass.o
  CC      drivers/firmware/psci.o
  AR      drivers/firmware/built-in.o
  CC      drivers/gpio/gpio-uclass.o
  CC      drivers/gpio/pca953x_gpio.o
  CC      drivers/gpio/imx_rgpio2p.o
  CC      drivers/gpio/adp5585_gpio.o
  AR      drivers/gpio/built-in.o
  CC      drivers/i2c/i2c-uclass.o
  CC      drivers/i2c/imx_lpi2c.o
  AR      drivers/i2c/built-in.o
  CC      drivers/input/key_matrix.o
  AR      drivers/input/built-in.o
  AR      drivers/iommu/built-in.o
  CC      drivers/mailbox/mailbox-uclass.o
  CC      drivers/mailbox/imx-mailbox.o
  AR      drivers/mailbox/built-in.o
  AR      drivers/memory/built-in.o
  AR      drivers/mfd/built-in.o
  CC      drivers/misc/imx_ele/ele_api.o
  CC      drivers/misc/imx_ele/ele_mu.o
  CC      drivers/misc/imx_ele/fuse.o
  AR      drivers/misc/imx_ele/built-in.o
  CC      drivers/misc/misc-uclass.o
  AR      drivers/misc/built-in.o
  CC      drivers/mmc/mmc.o
  CC      drivers/mmc/mmc-uclass.o
  CC      drivers/mmc/mmc_bootdev.o
  CC      drivers/mmc/mmc_write.o
  CC      drivers/mmc/mmc_boot.o
  CC      drivers/mmc/fsl_esdhc_imx.o
  AR      drivers/mmc/built-in.o
  AR      drivers/mtd/nand/built-in.o
  AR      drivers/mtd/onenand/built-in.o
  CC      drivers/mtd/spi/sf-uclass.o
  CC      drivers/mtd/spi/sf_probe.o
  CC      drivers/mtd/spi/spi-nor-ids.o
  CC      drivers/mtd/spi/spi-nor-core.o
  AR      drivers/mtd/spi/spi-nor.o
  AR      drivers/mtd/spi/built-in.o
  CC      drivers/mtd/mtdcore.o
  CC      drivers/mtd/mtd_uboot.o
  AR      drivers/mtd/mtd.o
  AR      drivers/mtd/built-in.o
  AR      drivers/net/mscc_eswitch/built-in.o
  CC      drivers/net/phy/phy.o
  CC      drivers/net/phy/generic_10g.o
  CC      drivers/net/phy/aquantia.o
  CC      drivers/net/phy/realtek.o
  AR      drivers/net/phy/built-in.o
  AR      drivers/net/qe/built-in.o
  AR      drivers/net/ti/built-in.o
  CC      drivers/net/fsl_enetc.o
  CC      drivers/net/fsl_enetc_mdio.o
  AR      drivers/net/built-in.o
  CC      drivers/pci/pci-uclass.o
  CC      drivers/pci/pci_auto.o
  CC      drivers/pci/pci_auto_common.o
  CC      drivers/pci/pci_common.o
  CC      drivers/pci/pcie_ecam_generic.o
  AR      drivers/pci/built-in.o
  AR      drivers/phy/allwinner/built-in.o
  AR      drivers/phy/cadence/built-in.o
  AR      drivers/phy/marvell/built-in.o
  AR      drivers/phy/qcom/built-in.o
  AR      drivers/phy/renesas/built-in.o
  AR      drivers/phy/rockchip/built-in.o
  AR      drivers/phy/socionext/built-in.o
  AR      drivers/phy/ti/built-in.o
  CC      drivers/phy/phy-uclass.o
  AR      drivers/phy/built-in.o
  AR      drivers/pinctrl/broadcom/built-in.o
  CC      drivers/pinctrl/nxp/pinctrl-imx.o
  CC      drivers/pinctrl/nxp/pinctrl-scmi.o
  AR      drivers/pinctrl/nxp/built-in.o
  CC      drivers/pinctrl/pinctrl-uclass.o
  CC      drivers/pinctrl/pinctrl-generic.o
  AR      drivers/pinctrl/built-in.o
  CC      drivers/power/domain/power-domain-uclass.o
  CC      drivers/power/domain/scmi-power-domain.o
  AR      drivers/power/domain/built-in.o
  AR      drivers/power/pmic/built-in.o
  CC      drivers/power/regulator/regulator-uclass.o
  CC      drivers/power/regulator/regulator_common.o
  CC      drivers/power/regulator/fixed.o
  CC      drivers/power/regulator/gpio-regulator.o
  AR      drivers/power/regulator/built-in.o
  AR      drivers/power/built-in.o
  AR      drivers/pwm/built-in.o
  AR      drivers/reset/built-in.o
  CC      drivers/rtc/rtc-uclass.o
  AR      drivers/rtc/built-in.o
  AR      drivers/scsi/built-in.o
  CC      drivers/serial/serial-uclass.o
  CC      drivers/serial/serial_lpuart.o
  AR      drivers/serial/built-in.o
  AR      drivers/smem/built-in.o
  AR      drivers/soc/built-in.o
  AR      drivers/sound/built-in.o
  CC      drivers/spi/spi-uclass.o
  CC      drivers/spi/spi-mem.o
  CC      drivers/spi/nxp_fspi.o
  AR      drivers/spi/built-in.o
  AR      drivers/spmi/built-in.o
  AR      drivers/thermal/built-in.o
  AR      drivers/ufs/built-in.o
  CC      drivers/watchdog/ulp_wdog.o
  AR      drivers/watchdog/built-in.o
  AR      drivers/built-in.o
  AR      drivers/usb/cdns3/built-in.o
  AR      drivers/usb/common/built-in.o
  AR      drivers/usb/dwc3/built-in.o
  AR      drivers/usb/emul/built-in.o
  AR      drivers/usb/eth/built-in.o
  AR      drivers/usb/host/built-in.o
  AR      drivers/usb/isp1760/built-in.o
  AR      drivers/usb/mtu3/built-in.o
  AR      drivers/usb/musb-new/built-in.o
  AR      drivers/usb/musb/built-in.o
  AR      drivers/usb/phy/built-in.o
  AR      drivers/usb/tcpm/built-in.o
  AR      drivers/usb/ulpi/built-in.o
  CC      env/common.o
  CC      env/env.o
  CC      env/attr.o
  CC      env/flags.o
  CC      env/callback.o
  CC      env/nowhere.o
  CC      env/mmc.o
  AR      env/built-in.o
  CC      fs/ext4/ext4fs.o
  CC      fs/ext4/ext4_common.o
  CC      fs/ext4/dev.o
  CC      fs/ext4/ext4_write.o
  CC      fs/ext4/ext4_journal.o
  AR      fs/ext4/built-in.o
  CC      fs/fat/fat_write.o
  AR      fs/fat/built-in.o
  CC      fs/fs.o
  CC      fs/fs_internal.o
  AR      fs/built-in.o
  CC      lib/bzip2/bzlib.o
  CC      lib/bzip2/bzlib_crctable.o
  CC      lib/bzip2/bzlib_decompress.o
  CC      lib/bzip2/bzlib_randtable.o
  CC      lib/bzip2/bzlib_huffman.o
  AR      lib/bzip2/built-in.o
  AR      lib/crypto/built-in.o
  CC      lib/efi_driver/efi_uclass.o
  CC      lib/efi_driver/efi_block_device.o
  AR      lib/efi_driver/built-in.o
  CC      lib/efi_loader/efi_bootmgr.o
  CC      lib/efi_loader/efi_bootbin.o
  CC      lib/efi_loader/efi_boottime.o
  CC      lib/efi_loader/efi_helper.o
  CC      lib/efi_loader/efi_console.o
  CC      lib/efi_loader/efi_device_path.o
  CC      lib/efi_loader/efi_device_path_to_text.o
  CC      lib/efi_loader/efi_device_path_utilities.o
  CC      lib/efi_loader/efi_dt_fixup.o
  CC      lib/efi_loader/efi_fdt.o
  CC      lib/efi_loader/efi_file.o
  CC      lib/efi_loader/efi_hii.o
  CC      lib/efi_loader/efi_image_loader.o
  CC      lib/efi_loader/efi_load_options.o
  CC      lib/efi_loader/efi_memory.o
  CC      lib/efi_loader/efi_root_node.o
  CC      lib/efi_loader/efi_runtime.o
  CC      lib/efi_loader/efi_setup.o
  CC      lib/efi_loader/efi_string.o
  CC      lib/efi_loader/efi_unicode_collation.o
  CC      lib/efi_loader/efi_var_common.o
  CC      lib/efi_loader/efi_var_mem.o
  CC      lib/efi_loader/efi_variable.o
  CC      lib/efi_loader/efi_var_file.o
  CC      lib/efi_loader/efi_watchdog.o
  CC      lib/efi_loader/efi_disk.o
  CC      lib/efi_loader/efi_net.o
  CC      lib/efi_loader/efi_smbios.o
  CC      lib/efi_loader/efi_load_initrd.o
  CC      lib/efi_loader/efi_conformance.o
  AR      lib/efi_loader/built-in.o
  CC      lib/efi_loader/helloworld.o
  AS      lib/efi_loader/efi_crt0.o
  CC      lib/efi_loader/efi_reloc.o
  CC      lib/efi_loader/efi_freestanding.o
  LD      lib/efi_loader/helloworld_efi.so
  OBJCOPY lib/efi_loader/helloworld.efi
  CC      lib/efi_loader/smbiosdump.o
  LD      lib/efi_loader/smbiosdump_efi.so
  OBJCOPY lib/efi_loader/smbiosdump.efi
  CC      lib/efi_loader/initrddump.o
  LD      lib/efi_loader/initrddump_efi.so
  OBJCOPY lib/efi_loader/initrddump.efi
  CC      lib/efi_loader/dtbdump.o
  LD      lib/efi_loader/dtbdump_efi.so
  OBJCOPY lib/efi_loader/dtbdump.efi
  CC      lib/efi_loader/testapp.o
  LD      lib/efi_loader/testapp_efi.so
  OBJCOPY lib/efi_loader/testapp.efi
  CC      lib/libfdt/fdt.o
  CC      lib/libfdt/fdt_ro.o
  CC      lib/libfdt/fdt_wip.o
  CC      lib/libfdt/fdt_strerror.o
  CC      lib/libfdt/fdt_sw.o
  CC      lib/libfdt/fdt_rw.o
  CC      lib/libfdt/fdt_empty_tree.o
  CC      lib/libfdt/fdt_addresses.o
  CC      lib/libfdt/fdt_overlay.o
  AR      lib/libfdt/built-in.o
  CC      lib/lzma/LzmaDec.o
  CC      lib/lzma/LzmaTools.o
  AR      lib/lzma/built-in.o
  CC      lib/lzo/lzo1x_decompress.o
  AR      lib/lzo/built-in.o
  CC      lib/zlib/zlib.o
  AR      lib/zlib/built-in.o
  CC      lib/binman.o
  CC      lib/charset.o
  CC      lib/crc8.o
  CC      lib/crc16.o
  CC      lib/crc16-ccitt.o
  CC      lib/smbios.o
  CC      lib/initcall.o
  CC      lib/ldiv.o
  CC      lib/net_utils.o
  CC      lib/rc4.o
  CC      lib/list_sort.o
  CC      lib/hash-checksum.o
  CC      lib/sha1.o
  CC      lib/gunzip.o
  CC      lib/lz4_wrapper.o
  CC      lib/fdtdec_common.o
  CC      lib/fdtdec.o
  CC      lib/qsort.o
  CC      lib/hashtable.o
  CC      lib/errno.o
  CC      lib/display_options.o
  CC      lib/crc32.o
  CC      lib/ctype.o
  CC      lib/div64.o
  CC      lib/hang.o
  CC      lib/linux_compat.o
  CC      lib/linux_string.o
  CC      lib/lmb.o
  CC      lib/membuff.o
  CC      lib/slre.o
  CC      lib/string.o
  CC      lib/tables_csum.o
  CC      lib/time.o
  CC      lib/hexdump.o
  CC      lib/uuid.o
  CC      lib/rand.o
  CC      lib/panic.o
  CC      lib/vsprintf.o
  CC      lib/strto.o
  CC      lib/abuf.o
  CC      lib/alist.o
  CC      lib/date.o
  CC      lib/rtc-lib.o
  CC      lib/elf.o
  AR      lib/built-in.o
  CC      net/arp.o
  CC      net/bootp.o
  CC      net/net.o
  CC      net/ping.o
  CC      net/sntp.o
  CC      net/tftp.o
  CC      net/udp.o
  CC      net/eth-uclass.o
  CC      net/eth_bootdev.o
  CC      net/mdio-uclass.o
  CC      net/eth_common.o
  CC      net/net-common.o
  AR      net/built-in.o
  LDS     u-boot.lds
  LD      u-boot
  DTC     dts/upstream/src/arm64/freescale/imx95-19x19-evk.dtb
  SHIPPED dts/dt.dtb
  CC      spl/./lib/asm-offsets.s
  UPD     spl/./include/generated/generic-asm-offsets.h
  CC      spl/./arch/arm/lib/asm-offsets.s
  UPD     spl/./include/generated/asm-offsets.h
  CC      spl/arch/arm/mach-imx/imx9/scmi/soc.o
  CC      spl/arch/arm/mach-imx/imx9/scmi/clock_scmi.o
  CC      spl/arch/arm/mach-imx/imx9/scmi/clock.o
  AR      spl/arch/arm/mach-imx/imx9/scmi/built-in.o
  AS      spl/arch/arm/mach-imx/imx9/lowlevel_init.o
  AR      spl/arch/arm/mach-imx/imx9/built-in.o
  CC      spl/arch/arm/mach-imx/iomux-v3.o
  CC      spl/arch/arm/mach-imx/misc.o
  CC      spl/arch/arm/mach-imx/spl.o
  CC      spl/arch/arm/mach-imx/image-container.o
  AR      spl/arch/arm/mach-imx/built-in.o
  CC      spl/arch/arm/cpu/armv8/cpu.o
  CC      spl/arch/arm/cpu/armv8/generic_timer.o
  CC      spl/arch/arm/cpu/armv8/cache_v8.o
  AS      spl/arch/arm/cpu/armv8/cache.o
  AS      spl/arch/arm/cpu/armv8/exceptions.o
  AS      spl/arch/arm/cpu/armv8/tlb.o
  AS      spl/arch/arm/cpu/armv8/transition.o
  CC      spl/arch/arm/cpu/armv8/fwcall.o
  CC      spl/arch/arm/cpu/armv8/cpu-dt.o
  AS      spl/arch/arm/cpu/armv8/smccc-call.o
  CC      spl/arch/arm/cpu/armv8/spl_data.o
  AR      spl/arch/arm/cpu/armv8/built-in.o
  AS      spl/arch/arm/cpu/armv8/start.o
  AR      spl/arch/arm/cpu/built-in.o
  AS      spl/arch/arm/lib/crt0_64.o
  AS      spl/arch/arm/lib/setjmp_aarch64.o
  CC      spl/arch/arm/lib/spl.o
  CC      spl/arch/arm/lib/image.o
  CC      spl/arch/arm/lib/bootm-fdt.o
  CC      spl/arch/arm/lib/bdinfo.o
  CC      spl/arch/arm/lib/sections.o
  CC      spl/arch/arm/lib/stack.o
  CC      spl/arch/arm/lib/interrupts_64.o
  CC      spl/arch/arm/lib/reset.o
  CC      spl/arch/arm/lib/cache.o
  CC      spl/arch/arm/lib/psci-dt.o
  AR      spl/arch/arm/lib/built-in.o
  AR      spl/arch/arm/lib/lib.a
  CC      spl/board/freescale/imx95_evk/imx95_evk.o
  CC      spl/board/freescale/imx95_evk/spl.o
  AR      spl/board/freescale/imx95_evk/built-in.o
  CC      spl/board/freescale/common/mmc.o
  AR      spl/board/freescale/common/built-in.o
  CC      spl/common/spl/spl.o
  CC      spl/common/spl/spl_legacy.o
  CC      spl/common/spl/spl_mmc.o
  CC      spl/common/spl/spl_imx_container.o
  AR      spl/common/spl/built-in.o
  CC      spl/common/init/board_init.o
  AR      spl/common/init/built-in.o
  CC      spl/boot/image.o
  CC      spl/boot/image-board.o
  CC      spl/boot/fdt_support.o
  CC      spl/boot/image-fdt.o
  AR      spl/boot/built-in.o
  CC      spl/common/console.o
  CC      spl/common/dlmalloc.o
  CC      spl/common/malloc_simple.o
  CC      spl/common/memsize.o
  CC      spl/common/stdio.o
  CC      spl/common/cli.o
  CC      spl/common/command.o
  CC      spl/common/s_record.o
  CC      spl/common/xyzModem.o
  AR      spl/common/built-in.o
  AR      spl/cmd/built-in.o
  AR      spl/env/built-in.o
  AR      spl/lib/crypto/built-in.o
  CC      spl/lib/libfdt/fdt.o
  CC      spl/lib/libfdt/fdt_ro.o
  CC      spl/lib/libfdt/fdt_wip.o
  CC      spl/lib/libfdt/fdt_strerror.o
  CC      spl/lib/libfdt/fdt_sw.o
  CC      spl/lib/libfdt/fdt_rw.o
  CC      spl/lib/libfdt/fdt_empty_tree.o
  CC      spl/lib/libfdt/fdt_addresses.o
  CC      spl/lib/libfdt/fdt_overlay.o
  AR      spl/lib/libfdt/built-in.o
  CC      spl/lib/hash-checksum.o
  CC      spl/lib/sha1.o
  CC      spl/lib/fdtdec_common.o
  CC      spl/lib/fdtdec.o
  CC      spl/lib/net_utils.o
  CC      spl/lib/qsort.o
  CC      spl/lib/hashtable.o
  CC      spl/lib/errno.o
  CC      spl/lib/display_options.o
  CC      spl/lib/crc32.o
  CC      spl/lib/ctype.o
  CC      spl/lib/div64.o
  CC      spl/lib/hang.o
  CC      spl/lib/linux_compat.o
  CC      spl/lib/linux_string.o
  CC      spl/lib/membuff.o
  CC      spl/lib/slre.o
  CC      spl/lib/string.o
  CC      spl/lib/tables_csum.o
  CC      spl/lib/time.o
  CC      spl/lib/hexdump.o
  CC      spl/lib/uuid.o
  CC      spl/lib/rand.o
  CC      spl/lib/panic.o
  CC      spl/lib/tiny-printf.o
  CC      spl/lib/strto.o
  CC      spl/lib/abuf.o
  CC      spl/lib/alist.o
  CC      spl/lib/date.o
  CC      spl/lib/rtc-lib.o
  CC      spl/lib/elf.o
  AR      spl/lib/built-in.o
  CC      spl/disk/part.o
  CC      spl/disk/disk-uclass.o
  CC      spl/disk/part_dos.o
  CC      spl/disk/part_efi.o
  AR      spl/disk/built-in.o
  CC      spl/drivers/block/blk-uclass.o
  AR      spl/drivers/block/built-in.o
  AR      spl/drivers/bus/built-in.o
  AR      spl/drivers/clk/adi/built-in.o
  AR      spl/drivers/clk/analogbits/built-in.o
  CC      spl/drivers/clk/imx/clk-gate2.o
  CC      spl/drivers/clk/imx/clk-pllv3.o
  CC      spl/drivers/clk/imx/clk-pfd.o
  AR      spl/drivers/clk/imx/built-in.o
  AR      spl/drivers/clk/tegra/built-in.o
  AR      spl/drivers/clk/ti/built-in.o
  CC      spl/drivers/clk/clk-uclass.o
  CC      spl/drivers/clk/clk_fixed_rate.o
  CC      spl/drivers/clk/clk_fixed_factor.o
  CC      spl/drivers/clk/clk.o
  CC      spl/drivers/clk/clk-divider.o
  CC      spl/drivers/clk/clk-mux.o
  CC      spl/drivers/clk/clk-gate.o
  CC      spl/drivers/clk/clk-fixed-factor.o
  CC      spl/drivers/clk/clk_scmi.o
  AR      spl/drivers/clk/built-in.o
  CC      spl/drivers/core/device.o
  CC      spl/drivers/core/fdtaddr.o
  CC      spl/drivers/core/lists.o
  CC      spl/drivers/core/root.o
  CC      spl/drivers/core/uclass.o
  CC      spl/drivers/core/util.o
  CC      spl/drivers/core/tag.o
  CC      spl/drivers/core/simple-bus.o
  CC      spl/drivers/core/dump.o
  CC      spl/drivers/core/of_extra.o
  CC      spl/drivers/core/ofnode.o
  CC      spl/drivers/core/read_extra.o
  AR      spl/drivers/core/built-in.o
  AR      spl/drivers/ddr/imx/imx9/../phy/built-in.o
  AR      spl/drivers/ddr/imx/imx9/built-in.o
  CC      spl/drivers/firmware/scmi/scmi_agent-uclass.o
  CC      spl/drivers/firmware/scmi/base.o
  CC      spl/drivers/firmware/scmi/smt.o
  CC      spl/drivers/firmware/scmi/mailbox_agent.o
  CC      spl/drivers/firmware/scmi/pwdom.o
  AR      spl/drivers/firmware/scmi/built-in.o
  CC      spl/drivers/firmware/firmware-uclass.o
  AR      spl/drivers/firmware/built-in.o
  CC      spl/drivers/gpio/gpio-uclass.o
  CC      spl/drivers/gpio/imx_rgpio2p.o
  CC      spl/drivers/gpio/adp5585_gpio.o
  AR      spl/drivers/gpio/built-in.o
  CC      spl/drivers/i2c/i2c-uclass.o
  CC      spl/drivers/i2c/imx_lpi2c.o
  AR      spl/drivers/i2c/built-in.o
  CC      spl/drivers/mailbox/mailbox-uclass.o
  CC      spl/drivers/mailbox/imx-mailbox.o
  AR      spl/drivers/mailbox/built-in.o
  CC      spl/drivers/misc/imx_ele/ele_api.o
  CC      spl/drivers/misc/imx_ele/ele_mu.o
  CC      spl/drivers/misc/imx_ele/fuse.o
  AR      spl/drivers/misc/imx_ele/built-in.o
  CC      spl/drivers/misc/misc-uclass.o
  AR      spl/drivers/misc/built-in.o
  CC      spl/drivers/mmc/mmc.o
  CC      spl/drivers/mmc/mmc-uclass.o
  CC      spl/drivers/mmc/mmc_boot.o
  CC      spl/drivers/mmc/fsl_esdhc_imx.o
  AR      spl/drivers/mmc/built-in.o
  AR      spl/drivers/mtd/built-in.o
  AR      spl/drivers/pinctrl/broadcom/built-in.o
  CC      spl/drivers/pinctrl/nxp/pinctrl-imx.o
  CC      spl/drivers/pinctrl/nxp/pinctrl-scmi.o
  AR      spl/drivers/pinctrl/nxp/built-in.o
  CC      spl/drivers/pinctrl/pinctrl-uclass.o
  CC      spl/drivers/pinctrl/pinctrl-generic.o
  AR      spl/drivers/pinctrl/built-in.o
  AR      spl/drivers/power/pmic/built-in.o
  CC      spl/drivers/power/regulator/regulator-uclass.o
  CC      spl/drivers/power/regulator/regulator_common.o
  CC      spl/drivers/power/regulator/fixed.o
  AR      spl/drivers/power/regulator/built-in.o
  AR      spl/drivers/power/built-in.o
  CC      spl/drivers/serial/serial-uclass.o
  CC      spl/drivers/serial/serial_lpuart.o
  AR      spl/drivers/serial/built-in.o
  AR      spl/drivers/soc/built-in.o
  CC      spl/drivers/watchdog/ulp_wdog.o
  CC      spl/drivers/watchdog/wdt-uclass.o
  AR      spl/drivers/watchdog/built-in.o
  AR      spl/drivers/built-in.o
  AR      spl/dts/built-in.o
  CC      spl/fs/fs_internal.o
  AR      spl/fs/built-in.o
  LDS     spl/u-boot-spl.lds
  LD      spl/u-boot-spl
  OBJCOPY spl/u-boot-spl-nodtb.bin
mkdir -p spl/dts/
  FDTGREP spl/dts/dt-spl.dtb
  COPY    spl/u-boot-spl.dtb
  CAT     spl/u-boot-spl-dtb.bin
  COPY    spl/u-boot-spl.bin
  SYM     spl/u-boot-spl.sym
  CHECK    spl/u-boot-spl.cfgout
  CHECK    u-boot-container.cfgout
WARNING './u-boot.bin' not found, resulting binary may be not-functional
  OBJCOPY u-boot.srec
  OBJCOPY u-boot-nodtb.bin
  RELOC   u-boot-nodtb.bin
  CAT     u-boot-dtb.bin
  COPY    u-boot.bin
  SYM     u-boot.sym
  MKIMAGE u-boot.img
  COPY    u-boot.dtb
  MKIMAGE u-boot-dtb.img
  LDS     u-boot-elf.lds
  LD      u-boot.elf
  BINMAN  .binman_stamp
  OFCHK   .config
-rw-r--r-- 1 tharvey Tim Harvey 922624 Dec 31 11:08 imx-boot-imx95.bin
^^^ image too small... missing u-boot.bin

$ make && ls -l imx-boot-imx95.bin
  UPD     include/generated/timestamp_autogenerated.h
  CC      common/version.o
  AR      common/built-in.o
  LD      u-boot
  OBJCOPY u-boot.srec
  OBJCOPY u-boot-nodtb.bin
  RELOC   u-boot-nodtb.bin
  CAT     u-boot-dtb.bin
  COPY    u-boot.bin
  SYM     u-boot.sym
  CC      spl/common/spl/spl.o
  AR      spl/common/spl/built-in.o
  LD      spl/u-boot-spl
  OBJCOPY spl/u-boot-spl-nodtb.bin
  CAT     spl/u-boot-spl-dtb.bin
  COPY    spl/u-boot-spl.bin
  SYM     spl/u-boot-spl.sym
  MKIMAGE u-boot.img
  MKIMAGE u-boot-dtb.img
  LD      u-boot.elf
  CHECK    u-boot-container.cfgout
  BINMAN  .binman_stamp
  OFCHK   .config
-rw-r--r-- 1 tharvey Tim Harvey 1709056 Dec 31 11:10 imx-boot-imx95.bin
^^^ now we have a proper image

Best Regards,

Tim
