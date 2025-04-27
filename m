Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34B81C369AB
	for <u-boot@archiver.kernel.org>; Sun, 27 Apr 2025 04:35:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19C88810EB;
	Sun, 27 Apr 2025 06:35:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="RywT4PNK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0003281F45; Sun, 27 Apr 2025 06:35:06 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 474DA80FDE
 for <u-boot@lists.denx.de>; Sun, 27 Apr 2025 06:35:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id E14DD25E92;
 Sun, 27 Apr 2025 06:35:03 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p64AufWVxyg1; Sun, 27 Apr 2025 06:35:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1745728503; bh=fse1dgB10IvCywsgtxqAs1TRPoXuQBVBSSDAJwB8XOs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=RywT4PNKmACLUyJNSf8DOss3XZgYLyCv5i6qwRA5mw7OBc6B3gnBgwfy77IrFyN2L
 7vk2rn8+s8XMX3WJCBlQhoWcDW3vwmzVbLt51jBZ/lUlJfndThw64J49EfhchwyRlH
 qdkOdjn5KJaZRctr/bSr7dMi/5buT2VDxPFXmB846Ln4Gmk5+4873KloO9mK4Vzh87
 o/x+XP/4DsgzqcGITw/V5aXT4rFeENbgCvsW1iThpKPhUsui2AWpKKTMAx5II4++cM
 7+jm92DtVA1HtsI0Uk+XMwdf+8vGSqER9wn+mbfyN3xAKLkKAt5rD0KblbfDs1//6I
 p10K3i+S2RGzw==
Date: Sun, 27 Apr 2025 04:34:48 +0000
From: Yao Zi <ziyao@disroot.org>
To: Nathaniel <I@nathaniel.land>
Cc: UBML <u-boot@lists.denx.de>
Subject: Re: Build for RISC-V with LLVM
Message-ID: <aA2z6ImdniJZm7fq@pie.lan>
References: <aAx9bjXivAAuth-y@pie>
 <EF1C62F4-2780-4DD4-B0FE-355AA66A10C4@getmailspring.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <EF1C62F4-2780-4DD4-B0FE-355AA66A10C4@getmailspring.com>
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

On Sat, Apr 26, 2025 at 06:25:50PM -0500, Nathaniel wrote:
> On Apr 26 2025, at 1:30 am, Yao Zi <ziyao@disroot.org> wrote:
> > On Fri, Apr 25, 2025 at 12:43:08PM -0500, Nathaniel Hourt wrote:
> > > Hi, all
> > >
> > > I am trying to build u-boot and SPL for my Mars board (riscv, variant of the
> > > starfive visionfive2) following the board-specific docs [1], using
> > > LLVM/clang as my toolchain with the HOSTCC and CC make options mentioned in
> > > [2]. I'm building from a RISC-V native chroot using qemu-binfmt so I am not
> > > using the cross-compile options; thus my make invocation looks like `make
> > > HOSTCC=clang CC=clang` (for OpenSBI, I just pass 'LLVM=1'). Note that the
> > > chroot I'm building from does not contain gcc/binutils at all; LLVM is the
> > > only toolchain present.
> > >
> > > The build usually succeeds, so I try to pass the SPL to the MaskROM over
> > > UART (using the u-boot-spl.bin.normal.out image) and it just hangs. No
> > > output, no response, and I have to reset the board. If I pass a working SPL
> >
> > Have you tried to apply this patch[1]? U-Boot support for JH7110 is
> > broken at least in v2025.04 release afaik.
> >
> > Best regards,
> > Yao Zi
> >
> > [1]: https://lore.kernel.org/all/20250330162421.238483-1-heinrich.schuchardt@canonical.com/
> > > I downloaded, it logs some output then accepts a main u-boot payload over
> > > UART, so if I send the main u-boot payload I built (u-boot.itb), I get a
> > > "Load address misaligned" error as in [3].
> > >
> > > I attempted to configure my SPL to log to UART by turning on various logging
> > > options in `menuconfig`, including the options recently mentioned by
> > > Heinrich Schuchardt in [4], but I have been unsuccessful in getting any
> > > output from the SPL I built.
> > >
> > > So I am looking for guidance. Is building with LLVM/clang (for riscv)
> > > supported? I don't know what to try next.
> > >
> > > Thanks
> > > —
> > > Nathaniel
> > >
> > >
> > > [1]
> > > https://docs.u-boot.org/en/latest/board/starfive/milk-v_mars.html#milk-v-mars
> > > [2] https://docs.u-boot.org/en/latest/build/clang.html
> > > [3] https://pastebin.com/xwEcqEpz
> > > [4] https://lists.denx.de/pipermail/u-boot/2025-April/586264.html
> >
> 
> I just tried the patch, and also pulled latest master, which has that patch by now, but it didn't change the SPL's behavior.
> I have heard that I need to be using v2025.01; however, that fails to build for me:
> LD lib/efi_loader/boothart_efi.so
> ld: error: section type mismatch for .dynamic
> >>> <internal>:(.dynamic): SHT_DYNAMIC
> >>> output section .text: SHT_PROGBITS
> make[2]: *** [scripts/Makefile.lib:539: lib/efi_loader/boothart_efi.so] Error 1
> make[1]: *** [scripts/Makefile.build:398: lib/efi_loader] Error 2
> make: *** [Makefile:1915: lib] Error 2

I guess this series[1] (merged between v2025.01 and v2025.04) plays a
role here.

> I don't understand that error; I'm guessing it's ELF wizardry thus far beyond my ken.
> So master builds but doesn't run (at all? there's no output) and going off of [1], wouldn't we expect there to be some output from the SPL when it doesn't work for the known reasons?
> v2025.01 doesn't build with my LLVM toolchain, and I'm wondering whether I'm getting actually sane images even when master builds successfully. I have no idea how to verify that... Does anyone know how to analyze the SPL image output, or even what format it's in? Or alternatively, is there a hello world SPL I can build just to test whether I can produce working binaries at all?
> Or am I barking up the wrong tree altogether? Ideas welcome. =)

I could verify starfive_visionfive2 images built by Clang are broken on
current master branch: seems there's something wrong with Clang when
generating default configuration. Have you seen errors like

	generated_defconfig:33:warning: unexpected data:  # CONFIG_OF_BOARD_FIXUP is not set
	generated_defconfig:34:warning: unexpected data:  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
	generated_defconfig:54:warning: unexpected data:  # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
	generated_defconfig:75:warning: unexpected data:  # CONFIG_CMD_BIND is not set
	generated_defconfig:132:warning: unexpected data:  # CONFIG_RAM_SIFIVE is not set
	generated_defconfig:150:warning: unexpected data:  # CONFIG_USB_CDNS3_TI is not set
	generated_defconfig:153:warning: unexpected data:  # CONFIG_WATCHDOG is not set
	generated_defconfig:154:warning: unexpected data:  # CONFIG_WATCHDOG_AUTOSTART is not set

when applying the default configuration? Seems Clang adds some extra
indentation in the preprocessor's output comparing to GCC, which Kconfig
doesn't allow. This breaks the configuration, making SPL unable to find
an appropriate space for stack to use.

With this problem fixed with a dirty patch, I've successfully booted
into U-Boot console with binutils LD. There're still some nasty "out of
memory" errors from EFI subsystem like

	U-Boot 2025.04-01423-g8c9218d0e86c-dirty (Apr 27 2025 - 03:55:20 +0000)

	CPU:   sifive,u74-mc
	Model: StarFive VisionFive 2 v1.3B
	DRAM:  8 GiB
	Core:  159 devices, 29 uclasses, devicetree: board
	WDT:   Not starting watchdog@13070000
	out of memory
	ERROR: Out of memory
	MMC:   mmc@16010000: 0, mmc@16020000: 1
	Loading Environment from SPIFlash... SF: Detected gd25lq128 with page size 256 Bytes, erase size 4 KiB, total 16 MiB
	*** Warning - bad CRC, using default environment

and images built by LLD are still broken. I'll send a fixing series
after figuring all of these issues out.

For now you could try the dirty fix and see whether console shows up,

diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index 079add4d5da..ba30652f01a 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -94,6 +94,7 @@ endif

 %_defconfig: $(obj)/conf
        $(Q)$(CPP) -nostdinc -P -I $(srctree) -undef -x assembler-with-cpp $(srctree)/arch/$(SRCARCH)/configs/$@ -o generated_defconfig
+       $(Q)sed -i -e 's/^[[:space:]]//' generated_defconfig
        $(Q)$< $(silent) --defconfig=generated_defconfig $(Kconfig)

 # Added for U-Boot (backward compatibility)

(the diff format is likely to be broken as it's copied from output of
git diff output, thus cannot be applied directly)

> —
> Nathaniel
> 
> [1] https://lore.kernel.org/all/20250330162421.238483-1-heinrich.schuchardt@canonical.com/

Best regards,
Yao Zi

[1]: https://lore.kernel.org/u-boot/174364559512.1379294.15546160892706099529.b4-ty@konsulko.com/
