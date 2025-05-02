Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57ADDC369DC
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 02:31:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA69B8059D;
	Fri,  2 May 2025 04:31:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nathaniel.land
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nathaniel.land header.i=@nathaniel.land header.b="t5CAuNof";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 837C08070C; Fri,  2 May 2025 04:31:15 +0200 (CEST)
Received: from goldencat.email (host212.sub-63-47-114.myvzw.com
 [63.47.114.212])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95522803CC
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 04:31:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nathaniel.land
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=i@nathaniel.land
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nathaniel.land;
 s=dkim; t=1746153067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vR6GzqBRgeiGFJTfBOLYLCw6g8lfiDs8R2MPolyOT38=;
 b=t5CAuNofSkMYnTpv8I76pr8+4vITi0YrElt2pFvswN/Duc1/uGJHlpIgmFQ68Y2qcc9OPX
 Su+w3lCv7p5a1dxe9gcknbGnquY3Nvz2/sWnq4PGLiJ0kgolmRXjwu2ajxcs8fypf1o/hv
 2WRBpp2MLOi10n2gzB2pn8/RHbtsLZRt3wvglWeKq/9bxe0koI29gCCqvkHOjSJSmihkiO
 3tR4ZW6KBI5SJuDMlPiqY6BjeiULiL7o/ykNQRMiN4hhCcFdlMYpmiocTzg+ciDMo8RMVL
 JtNWuN2OPuNNC4hLY54QOadyXT3kPBBXHCfsiPIyT0bC78/wge/X9DzktF/ZKA==
Authentication-Results: goldencat.email;
 auth=pass smtp.mailfrom=i@nathaniel.land
Date: Thu, 01 May 2025 21:31:06 -0500
From: Nathaniel Hourt <i@nathaniel.land>
To: Yao Zi <ziyao@disroot.org>
Cc: UBML <u-boot@lists.denx.de>
Subject: Re: Build for RISC-V with LLVM
In-Reply-To: <aBQkbNrT-u6FPm_D@pie.lan>
References: <aAx9bjXivAAuth-y@pie>
 <EF1C62F4-2780-4DD4-B0FE-355AA66A10C4@getmailspring.com>
 <aA2z6ImdniJZm7fq@pie.lan> <cd30d0ef07796710523ac5d55bb67d0e@nathaniel.land>
 <aBQkbNrT-u6FPm_D@pie.lan>
Message-ID: <534beda9eb77a786945ce647aebf7fa7@nathaniel.land>
X-Sender: i@nathaniel.land
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: /
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

On 2025-05-01 20:48, Yao Zi wrote:
> On Thu, May 01, 2025 at 03:54:34PM -0500, Nathaniel Hourt wrote:
>> On 2025-04-26 23:34, Yao Zi wrote:
>> > On Sat, Apr 26, 2025 at 06:25:50PM -0500, Nathaniel wrote:
>> > > On Apr 26 2025, at 1:30 am, Yao Zi <ziyao@disroot.org> wrote:
>> > > > On Fri, Apr 25, 2025 at 12:43:08PM -0500, Nathaniel Hourt wrote:
>> > > > > Hi, all
>> > > > >
>> > > > > I am trying to build u-boot and SPL for my Mars board (riscv, variant of the
>> > > > > starfive visionfive2) following the board-specific docs [1], using
>> > > > > LLVM/clang as my toolchain with the HOSTCC and CC make options mentioned in
>> > > > > [2]. I'm building from a RISC-V native chroot using qemu-binfmt so I am not
>> > > > > using the cross-compile options; thus my make invocation looks like `make
>> > > > > HOSTCC=clang CC=clang` (for OpenSBI, I just pass 'LLVM=1'). Note that the
>> > > > > chroot I'm building from does not contain gcc/binutils at all; LLVM is the
>> > > > > only toolchain present.
>> > > > >
>> > > > > The build usually succeeds, so I try to pass the SPL to the MaskROM over
>> > > > > UART (using the u-boot-spl.bin.normal.out image) and it just hangs. No
>> > > > > output, no response, and I have to reset the board. If I pass a working SPL
>> > > >
>> > > > Have you tried to apply this patch[1]? U-Boot support for JH7110 is
>> > > > broken at least in v2025.04 release afaik.
>> > > >
>> > > > Best regards,
>> > > > Yao Zi
>> > > >
>> > > > [1]: https://lore.kernel.org/all/20250330162421.238483-1-heinrich.schuchardt@canonical.com/
>> > > > > I downloaded, it logs some output then accepts a main u-boot payload over
>> > > > > UART, so if I send the main u-boot payload I built (u-boot.itb), I get a
>> > > > > "Load address misaligned" error as in [3].
>> > > > >
>> > > > > I attempted to configure my SPL to log to UART by turning on various logging
>> > > > > options in `menuconfig`, including the options recently mentioned by
>> > > > > Heinrich Schuchardt in [4], but I have been unsuccessful in getting any
>> > > > > output from the SPL I built.
>> > > > >
>> > > > > So I am looking for guidance. Is building with LLVM/clang (for riscv)
>> > > > > supported? I don't know what to try next.
>> > > > >
>> > > > > Thanks
>> > > > > —
>> > > > > Nathaniel
>> > > > >
>> > > > >
>> > > > > [1]
>> > > > > https://docs.u-boot.org/en/latest/board/starfive/milk-v_mars.html#milk-v-mars
>> > > > > [2] https://docs.u-boot.org/en/latest/build/clang.html
>> > > > > [3] https://pastebin.com/xwEcqEpz
>> > > > > [4] https://lists.denx.de/pipermail/u-boot/2025-April/586264.html
>> > > >
>> > >
>> > > I just tried the patch, and also pulled latest master, which has
>> > > that patch by now, but it didn't change the SPL's behavior.
>> > > I have heard that I need to be using v2025.01; however, that fails
>> > > to build for me:
>> > > LD lib/efi_loader/boothart_efi.so
>> > > ld: error: section type mismatch for .dynamic
>> > > >>> <internal>:(.dynamic): SHT_DYNAMIC
>> > > >>> output section .text: SHT_PROGBITS
>> > > make[2]: *** [scripts/Makefile.lib:539:
>> > > lib/efi_loader/boothart_efi.so] Error 1
>> > > make[1]: *** [scripts/Makefile.build:398: lib/efi_loader] Error 2
>> > > make: *** [Makefile:1915: lib] Error 2
>> >
>> > I guess this series[1] (merged between v2025.01 and v2025.04) plays a
>> > role here.
>> >
>> > > I don't understand that error; I'm guessing it's ELF wizardry thus
>> > > far beyond my ken.
>> > > So master builds but doesn't run (at all? there's no output) and
>> > > going off of [1], wouldn't we expect there to be some output from
>> > > the SPL when it doesn't work for the known reasons?
>> > > v2025.01 doesn't build with my LLVM toolchain, and I'm wondering
>> > > whether I'm getting actually sane images even when master builds
>> > > successfully. I have no idea how to verify that... Does anyone know
>> > > how to analyze the SPL image output, or even what format it's in? Or
>> > > alternatively, is there a hello world SPL I can build just to test
>> > > whether I can produce working binaries at all?
>> > > Or am I barking up the wrong tree altogether? Ideas welcome. =)
>> >
>> > I could verify starfive_visionfive2 images built by Clang are broken on
>> > current master branch: seems there's something wrong with Clang when
>> > generating default configuration. Have you seen errors like
>> >
>> > 	generated_defconfig:33:warning: unexpected data:  #
>> > CONFIG_OF_BOARD_FIXUP is not set
>> > 	generated_defconfig:34:warning: unexpected data:  #
>> > CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
>> > 	generated_defconfig:54:warning: unexpected data:  #
>> > CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
>> > 	generated_defconfig:75:warning: unexpected data:  # CONFIG_CMD_BIND is
>> > not set
>> > 	generated_defconfig:132:warning: unexpected data:  # CONFIG_RAM_SIFIVE
>> > is not set
>> > 	generated_defconfig:150:warning: unexpected data:  #
>> > CONFIG_USB_CDNS3_TI is not set
>> > 	generated_defconfig:153:warning: unexpected data:  # CONFIG_WATCHDOG is
>> > not set
>> > 	generated_defconfig:154:warning: unexpected data:  #
>> > CONFIG_WATCHDOG_AUTOSTART is not set
>> >
>> > when applying the default configuration? Seems Clang adds some extra
>> > indentation in the preprocessor's output comparing to GCC, which Kconfig
>> > doesn't allow. This breaks the configuration, making SPL unable to find
>> > an appropriate space for stack to use.
>> >
>> > With this problem fixed with a dirty patch, I've successfully booted
>> > into U-Boot console with binutils LD. There're still some nasty "out of
>> > memory" errors from EFI subsystem like
>> >
>> > 	U-Boot 2025.04-01423-g8c9218d0e86c-dirty (Apr 27 2025 - 03:55:20 +0000)
>> >
>> > 	CPU:   sifive,u74-mc
>> > 	Model: StarFive VisionFive 2 v1.3B
>> > 	DRAM:  8 GiB
>> > 	Core:  159 devices, 29 uclasses, devicetree: board
>> > 	WDT:   Not starting watchdog@13070000
>> > 	out of memory
>> > 	ERROR: Out of memory
>> > 	MMC:   mmc@16010000: 0, mmc@16020000: 1
>> > 	Loading Environment from SPIFlash... SF: Detected gd25lq128 with page
>> > size 256 Bytes, erase size 4 KiB, total 16 MiB
>> > 	*** Warning - bad CRC, using default environment
>> >
>> > and images built by LLD are still broken. I'll send a fixing series
>> > after figuring all of these issues out.
>> >
>> > For now you could try the dirty fix and see whether console shows up,
>> >
>> > diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
>> > index 079add4d5da..ba30652f01a 100644
>> > --- a/scripts/kconfig/Makefile
>> > +++ b/scripts/kconfig/Makefile
>> > @@ -94,6 +94,7 @@ endif
>> >
>> >  %_defconfig: $(obj)/conf
>> >         $(Q)$(CPP) -nostdinc -P -I $(srctree) -undef -x
>> > assembler-with-cpp $(srctree)/arch/$(SRCARCH)/configs/$@ -o
>> > generated_defconfig
>> > +       $(Q)sed -i -e 's/^[[:space:]]//' generated_defconfig
>> >         $(Q)$< $(silent) --defconfig=generated_defconfig $(Kconfig)
>> >
>> >  # Added for U-Boot (backward compatibility)
>> >
>> > (the diff format is likely to be broken as it's copied from output of
>> > git diff output, thus cannot be applied directly)
>> >
>> > > —
>> > > Nathaniel
>> > >
>> > > [1] https://lore.kernel.org/all/20250330162421.238483-1-heinrich.schuchardt@canonical.com/
>> >
>> > Best regards,
>> > Yao Zi
>> >
>> > [1]: https://lore.kernel.org/u-boot/174364559512.1379294.15546160892706099529.b4-ty@konsulko.com/
>> 
>> I don't recall ever seeing the config warnings, and my config has no 
>> lines
>> with leading spaces. I've gone ahead and patched my local clang to 
>> eliminate
>> the leading space issue anyways, since that seems the appropriate 
>> place to
>> resolve the issue.
>> 
>> I've also applied your second patch [1] to eliminate the gd issue, and 
>> I
>> have Heinrich Schuchardt's pllclk patch as well.
>> 
>> I do not get any console this way — unfortunately there is still no 
>> output
>> from the SPL, but that is likely due to my use of LLD.
>> 
>> Do you have any further information on the issue of linking with LLD? 
>> Is
>> anything more known about this problem yet?
> 
> Sadly no, without any serial output it's hard to work on the problem 
> and
> I haven't searched through the mailing list for similar reports.
> Additionally, I don't have enough time to dig further on the issue...
> sorry about it.
> 
> I could revisit the linking problem sometime later if it's still there.
> May you give ld.bfd a try for now?
> 
>> [1] https://lists.denx.de/pipermail/u-boot/2025-April/588038.html
>> 
>> —
>> Nathaniel
> 
> Thanks,
> Yao Zi

Oh, it's certainly an option. =)

But it'll be more fun to dig in and see if I can get lucky enough to 
figure out why LLD isn't doing the job correctly. I suppose I'll start 
by trying to figure out from the make system how the SPL image is 
derived and begin analyzing it or the build assets from which it is 
derived to determine what might be going wrong.

Advice and pointers are always welcome!

—
Nathaniel
