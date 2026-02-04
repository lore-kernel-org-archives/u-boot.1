Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87E36EA794A
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 23:48:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDBCC83015;
	Thu,  5 Feb 2026 00:48:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nwl.cc header.i=@nwl.cc header.b="Cq/rGQ95";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C90F5838FA; Thu,  5 Feb 2026 00:48:51 +0100 (CET)
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25BFA8063E
 for <u-boot@lists.denx.de>; Thu,  5 Feb 2026 00:48:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=phil@nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
 s=mail2022; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Qw0uqxlSkbt71b8jnpuU8kDp11Gk9kxL+xc2cGksesU=; b=Cq/rGQ95ZrPAk2AYvlSTz3V7OR
 aku1n+41Hzr9K7NjRaaXyhTKoCJOi+/f9lx6wYn2+g3OaaM30dnltPTU2ay6CXltHfCxhruq6yHBF
 bKBLHdi33hQYLlFMLDhu+15mOtVLK/cKE3vML4mrlf0cbf/mUW+2PXSBe12c91aVfWOY2rjPFEYm8
 6AxZOzUUDqS0e7iscLAeMYMZw7cQVkYL8G9Y4TuTAznEIVQgDyg+LqgKK4pFD9eLsuoZ0Cq3FuLG4
 XLrnjAWZiD9+Jhu98fqACrEWjz8XbZ+jelvQSE7TFuCqhWOg1Wmv0SNWtuOjTajUey0D0GCZJMPo0
 3hqS/aFA==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.98.2)
 (envelope-from <phil@nwl.cc>) id 1vnmbz-000000004OA-3IZ3;
 Thu, 05 Feb 2026 00:48:43 +0100
Date: Thu, 5 Feb 2026 00:48:43 +0100
From: Phil Sutter <phil@nwl.cc>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Beleswar Padhi <b-padhi@ti.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Adam Ford <aford173@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Eugen Hristev <eugen.hristev@linaro.org>,
 Fabio Estevam <festevam@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>, Joel Stanley <joel@jms.id.au>,
 Kever Yang <kever.yang@rock-chips.com>,
 Michal Simek <michal.simek@amd.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ryan Chen <ryan_chen@aspeedtech.com>, Stefano Babic <sbabic@nabladev.com>
Subject: Re: [PATCH 02/10] arm: Update linker scripts to ensure appended
 device tree is aligned
Message-ID: <aYPa2_YU04etfIv9@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Beleswar Padhi <b-padhi@ti.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Adam Ford <aford173@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Eugen Hristev <eugen.hristev@linaro.org>,
 Fabio Estevam <festevam@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Joel Stanley <joel@jms.id.au>,
 Kever Yang <kever.yang@rock-chips.com>,
 Michal Simek <michal.simek@amd.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Stefano Babic <sbabic@nabladev.com>
References: <aYO3HOmFFVAkjfKD@orbyte.nwl.cc>
 <20260204212010.GD2603314@bill-the-cat>
 <aYO5r8Na5-fRYHgA@orbyte.nwl.cc>
 <20260204213139.GE2603314@bill-the-cat>
 <aYO8vDPa522pttDV@orbyte.nwl.cc>
 <20260204215016.GF2603314@bill-the-cat>
 <aYPPkg0rQTQr0g2Y@orbyte.nwl.cc>
 <20260204230416.GG2603314@bill-the-cat>
 <aYPWcEcnrBOCLVxf@orbyte.nwl.cc>
 <20260204233550.GH2603314@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204233550.GH2603314@bill-the-cat>
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

On Wed, Feb 04, 2026 at 05:35:50PM -0600, Tom Rini wrote:
> On Thu, Feb 05, 2026 at 12:29:52AM +0100, Phil Sutter wrote:
> > On Wed, Feb 04, 2026 at 05:04:16PM -0600, Tom Rini wrote:
> > > On Thu, Feb 05, 2026 at 12:00:34AM +0100, Phil Sutter wrote:
> > > > On Wed, Feb 04, 2026 at 03:50:16PM -0600, Tom Rini wrote:
> > > > > On Wed, Feb 04, 2026 at 10:40:12PM +0100, Phil Sutter wrote:
> > > > > > On Wed, Feb 04, 2026 at 03:31:39PM -0600, Tom Rini wrote:
> > > > > > > On Wed, Feb 04, 2026 at 10:27:11PM +0100, Phil Sutter wrote:
> > > > > > > > On Wed, Feb 04, 2026 at 03:20:10PM -0600, Tom Rini wrote:
> > > > > > > > > On Wed, Feb 04, 2026 at 10:16:12PM +0100, Phil Sutter wrote:
> > > > > > > > > > Hi,
> > > > > > > > > > 
> > > > > > > > > > On Thu, Jan 15, 2026 at 04:19:32PM -0600, Tom Rini wrote:
> > > > > > > > > > > With commit 0535e46d55d7 ("scripts/dtc: Update to upstream version
> > > > > > > > > > > v1.7.2-35-g52f07dcca47c") it is now a fatal error to U-Boot if our
> > > > > > > > > > > device tree is not 8-byte aligned. In commit f613a6e15ef7 ("ARM: OMAP2+:
> > > > > > > > > > > Pad SPL binary to 8-byte alignment before DTB") Beleswar Padhi explains
> > > > > > > > > > > that we must have ALIGN(x) statements inside of a section to ensure that
> > > > > > > > > > > padding is included and not simply that the linker address counter is
> > > > > > > > > > > incremented. To that end, this patch:
> > > > > > > > > > > - Expands some linker sections to be more readable when adding a second
> > > > > > > > > > >   statement to the section.
> > > > > > > > > > > - Aligns the final section before _end (for U-Boot) or
> > > > > > > > > > >   _image_binary_end or __bss_end (for xPL phases) by 8-bytes by adding
> > > > > > > > > > >   '. = ALIGN(8);' to the final section before the symbol.
> > > > > > > > > > > - Ensure that we do have alignment by adding an ASSERT so that when not
> > > > > > > > > > >   aligned we fail to link (and explain why).
> > > > > > > > > > > - Remove now-spurious  '. = ALIGN(x);' statements that were intended to
> > > > > > > > > > >   provide the above alignments.
> > > > > > > > > > > 
> > > > > > > > > > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > > > > > > > > 
> > > > > > > > > > For unclear reasons, this seems to break boot via xmodem protocol on my
> > > > > > > > > > Synology DS414. I found this commit via 'git bisect'. The symptom is:
> > > > > > > > > > 
> > > > > > > > > > | kwboot version 2026.04-rc1-00098-g6ad0cf8f83db
> > > > > > > > > > | Detected kwbimage v1 with SPI boot signature
> > > > > > > > > > | Patching image boot signature to UART
> > > > > > > > > > | Aligning image header to Xmodem block size
> > > > > > > > > > | Sending boot message. Please reboot the target...\
> > > > > > > > > > | Sending boot image header (67584 bytes)...
> > > > > > > > > > |   0 % [......................................................................]
> > > > > > > > > > |  13 % [......................................................................]
> > > > > > > > > > |  26 % [......................................................................]
> > > > > > > > > > |  39 % [......................................................................]
> > > > > > > > > > |  53 % [......................................................................]
> > > > > > > > > > |  66 % [......................................................................]
> > > > > > > > > > |  79 % [......................................................................]
> > > > > > > > > > |  92 % [......................................                                ]
> > > > > > > > > > | Done
> > > > > > > > > > | Missing DTB
> > > > > > > > > > | spl_init() failed: -2
> > > > > > > > > > | ### ERROR ### Please RESET the board ###
> > > > > > > > > > | 
> > > > > > > > > > | 
> > > > > > > > > > | xmodem: Connection timed out
> > > > > > > > > > 
> > > > > > > > > > Debug printf()s in fdtdec_prepare_fdt() show that fdt_check_header()
> > > > > > > > > > returns -FDT_ERR_BADMAGIC.
> > > > > > > > > > 
> > > > > > > > > > With HEAD at a8d982e1f1726 ("x86: cpu: Fix crash on FTRACE enabled
> > > > > > > > > > builds"), reverting arch/arm/cpu/u-boot-spl.lds like so:
> > > > > > > > > > 
> > > > > > > > > > | @@ -41,14 +41,21 @@ SECTIONS
> > > > > > > > > > |                 __binman_sym_start = .;
> > > > > > > > > > |                 KEEP(*(SORT(.binman_sym*)));
> > > > > > > > > > |                 __binman_sym_end = .;
> > > > > > > > > > | -               . = ALIGN(8);
> > > > > > > > > > |         }
> > > > > > > > > > |  
> > > > > > > > > > | +       . = ALIGN(4); /* critical! */
> > > > > > > > > > |         __image_copy_end = .;
> > > > > > > > > > | +       .rel.dyn : {
> > > > > > > > > > | +               __rel_dyn_start = .;
> > > > > > > > > > | +               *(.rel*)
> > > > > > > > > > | +               __rel_dyn_end = .;
> > > > > > > > > > | +       }
> > > > > > > > > > | +
> > > > > > > > > > | +       . = ALIGN(8);
> > > > > > > > > > |         _image_binary_end = .;
> > > > > > > > > > |         _end = .;
> > > > > > > > > > |  
> > > > > > > > > > | -       .bss : {
> > > > > > > > > > | +       .bss __rel_dyn_start (OVERLAY) : {
> > > > > > > > > > |                 __bss_start = .;
> > > > > > > > > > |                 *(.bss*)
> > > > > > > > > > |                  . = ALIGN(8);
> > > > > > > > > > 
> > > > > > > > > > The SPL image starts up again and continues loading the real uboot
> > > > > > > > > > image. Note that I have no idea what these changes actually do, so I
> > > > > > > > > > need instructions if I should dig further.
> > > > > > > > > 
> > > > > > > > > Does:
> > > > > > > > > https://patchwork.ozlabs.org/project/uboot/patch/20260130183635.2612933-1-trini@konsulko.com/
> > > > > > > > > fix it?
> > > > > > > > 
> > > > > > > > Sadly not, same result.
> > > > > > > 
> > > > > > > Ugh. What file, specifically, do you send via xmodem? And so that maybe
> > > > > > > I can more easily replicate the failure, are you using the kernel.org
> > > > > > > gcc-14.2.0 toolchain or something else?
> > > > > > 
> > > > > > I am building with a custom-built arm-openadk-linux-uclibceabi-gcc
> > > > > > version 14.3.0. Basically what I run is:
> > > > > > 
> > > > > > MYENV='ARCH=arm CROSS_COMPILE=~/git/openadk-ds414/toolchain_synology-ds414_uclibc-ng_softfp_eabi_arm/usr/bin/arm-openadk-linux-uclibceabi-'
> > > > > > 
> > > > > > make $MYENV clean && \
> > > > > > for f in $(ls u-boot*.kwb 2>/dev/null); do rm $f; done && \
> > > > > > make $MYENV ds414_defconfig && \
> > > > > > make $MYENV -j12 && \
> > > > > > ./tools/kwboot -a -t -p -b u-boot-*spl.kwb /dev/ttyUSB0
> > > > > > 
> > > > > > With current uboot, this should be u-boot-with-spl.kwb image.
> > > > > > 
> > > > > > With said patch reverted (or the above changes applied), I produce a
> > > > > > working u-boot-with-spl.kwb which loads and boots linux from flash. So
> > > > > > my toolchain is at least not totally broken. ;)
> > > > > 
> > > > > Right, so, for background, the following threads might shed some light
> > > > > on things:
> > > > > https://lore.kernel.org/u-boot/CAOMZO5DZNJ+=AP1spWCv7Ar6etf03H=DFVU=mXZcC7QFTGoh_Q@mail.gmail.com/
> > > > > https://lore.kernel.org/u-boot/20260123161907.392211-1-festevam@gmail.com/
> > > > > 
> > > > > And so to that end, can you please do:
> > > > > hexdump -Cv u-boot-with-spl.kwb | grep 'd0 0d fe ed'
> > > > > and let me know what that says? And the first line there should match,
> > > > > content-wise at least (but not quite file offset) spl/u-boot-spl. I was
> > > > > asking about your toolchain because with gcc-14.2.0 from kernel.org:
> > > > > $ hexdump -Cv /tmp/ds414/spl/u-boot-spl | grep 'd0 0d fe ed'
> > > > > 00002ed0  6f f0 12 00 70 47 00 bf  d0 0d fe ed 00 29 05 db  |o...pG.......)..|
> > > > > $ hexdump -Cv /tmp/ds414/u-boot-with-spl.kwb | grep 'd0 0d fe ed'
> > > > > 00001ed0  6f f0 12 00 70 47 00 bf  d0 0d fe ed 00 29 05 db  |o...pG.......)..|
> > > > 
> > > > This is with HEAD at a8d982e1f17 + your "spl: Ensure final section before BSS
> > > > is non-empty" applied:
> > > > 
> > > > % hexdump -Cv u-boot-with-spl.kwb | grep 'd0 0d fe ed' | head -n1
> > > > 00001ed0  6f f0 12 00 70 47 00 bf  d0 0d fe ed 00 29 05 db  |o...pG.......)..|
> > > > 
> > > > % hexdump -Cv spl/u-boot-spl | grep 'd0 0d fe ed'
> > > > 00002ed0  6f f0 12 00 70 47 00 bf  d0 0d fe ed 00 29 05 db  |o...pG.......)..|
> > > > 
> > > > > And while this should then *work* that's luck and not design. If you can
> > > > > confirm that instead 'd0 0d fe ed' is in the middle (and so 4 byte but
> > > > > not 8 byte aligned) it'll at least be the same symptom as before.
> > > > 
> > > > Hmm. My dumps indicate correct 8B alignment, right? Switching over to a branch
> > > > which has the problematic commit reverted and produced images work, I
> > > > get exactly the same output from hexdump on those files, BTW. Does that
> > > > mean we're on the wrong track and my problem is not wrong DTB alignment?
> > > 
> > > So, I'm not sure. The error message is what shows up quickly from trying
> > > to find the device tree, and not finding it. In debugging the other
> > > times, we did see mysterious shifts 4 bytes in either direction, but
> > > never 8 bytes. I think you might need to start throwing some debug
> > > prints around and seeing where the device tree *is* at run time in
> > > relation to where it's expected to be.
> > 
> > FDT_MAGIC sequence is found 12B before 'blob' as passed to
> > fdtdec_prepare_fdt(). I searched in a range of (-128;127), it was the
> > only offset which matched.
> 
> So, our mysterious 4 shift is now 12. If you undo the patch I asked you
> to test, is it now 4B before? I basically want to confirm that my newest
> patch just changes when we hit this problem and doesn't solve it, only
> changes the mystery shift. Oh, and can you please readelf -S the
> spl/u-boot-spl for both with my patch and current master AND the one you
> made work? Thanks again!

Sorry for the mess, I did my FDT_MAGIC search with master branch, so not
with your patch applied. Readelf prints:

% readelf -S spl/u-boot-spl
There are 20 section headers, starting at offset 0x127d54:

Section Headers:
  [Nr] Name              Type            Addr     Off    Size   ES Flg Lk Inf Al
  [ 0]                   NULL            00000000 000000 000000 00      0   0  0
  [ 1] .text             PROGBITS        40004030 001030 009c1e 00  AX  0   0 16
  [ 2] .rodata           PROGBITS        4000dc50 00ac50 0016f9 00   A  0   0  4
  [ 3] .data             PROGBITS        4000f360 00c360 0042e0 00  WA  0   0 32
  [ 4] __u_boot_list     PROGBITS        40013640 010640 000594 00  WA  0   0  4
  [ 5] .binman_sym_table NOBITS          40013bd4 010bd4 000004 00  WA  0   0  1
  [ 6] .bss              NOBITS          40013be0 010bd4 000728 00  WA  0   0 32
  [ 7] .ARM.attributes   ARM_ATTRIBUTES  00000000 010bd4 000029 00      0   0  1
  [ 8] .comment          PROGBITS        00000000 010bfd 000012 01  MS  0   0  1
  [ 9] .debug_line       PROGBITS        00000000 010c0f 02844f 00      0   0  1
  [10] .debug_info       PROGBITS        00000000 03905e 076ced 00      0   0  1
  [11] .debug_abbrev     PROGBITS        00000000 0afd4b 00f697 00      0   0  1
  [12] .debug_aranges    PROGBITS        00000000 0bf3e8 002430 00      0   0  8
  [13] .debug_str        PROGBITS        00000000 0c1818 00d85c 01  MS  0   0  1
  [14] .debug_loc        PROGBITS        00000000 0cf074 044a87 00      0   0  1
  [15] .debug_ranges     PROGBITS        00000000 113b00 006578 00      0   0  8
  [16] .debug_frame      PROGBITS        00000000 11a078 0069c0 00      0   0  4
  [17] .symtab           SYMTAB          00000000 120a38 004d10 10     18 888  4
  [18] .strtab           STRTAB          00000000 125748 002539 00      0   0  1
  [19] .shstrtab         STRTAB          00000000 127c81 0000d3 00      0   0  1

Next try with your patch applied on top of master:

FDT_MAGIC is found at offset -8. Readelf:

There are 19 section headers, starting at offset 0x127d34:

Section Headers:
  [Nr] Name              Type            Addr     Off    Size   ES Flg Lk Inf Al
  [ 0]                   NULL            00000000 000000 000000 00      0   0  0
  [ 1] .text             PROGBITS        40004030 001030 009c1e 00  AX  0   0 16
  [ 2] .rodata           PROGBITS        4000dc50 00ac50 0016f9 00   A  0   0  4
  [ 3] .data             PROGBITS        4000f360 00c360 0042e0 00  WA  0   0 32
  [ 4] __u_boot_list     PROGBITS        40013640 010640 000598 00  WA  0   0  4
  [ 5] .bss              NOBITS          40013be0 010bd8 000728 00  WA  0   0 32
  [ 6] .ARM.attributes   ARM_ATTRIBUTES  00000000 010bd8 000029 00      0   0  1
  [ 7] .comment          PROGBITS        00000000 010c01 000012 01  MS  0   0  1
  [ 8] .debug_line       PROGBITS        00000000 010c13 02844f 00      0   0  1
  [ 9] .debug_info       PROGBITS        00000000 039062 076ced 00      0   0  1
  [10] .debug_abbrev     PROGBITS        00000000 0afd4f 00f697 00      0   0  1
  [11] .debug_aranges    PROGBITS        00000000 0bf3e8 002430 00      0   0  8
  [12] .debug_str        PROGBITS        00000000 0c1818 00d85c 01  MS  0   0  1
  [13] .debug_loc        PROGBITS        00000000 0cf074 044a87 00      0   0  1
  [14] .debug_ranges     PROGBITS        00000000 113b00 006578 00      0   0  8
  [15] .debug_frame      PROGBITS        00000000 11a078 0069c0 00      0   0  4
  [16] .symtab           SYMTAB          00000000 120a38 004d00 10     17 887  4
  [17] .strtab           STRTAB          00000000 125738 002539 00      0   0  1
  [18] .shstrtab         STRTAB          00000000 127c71 0000c1 00      0   0  1

Finally, with problematic patches reverted:

FDT_MAGIC is found at offset 0 (obviously). Readelf:

There are 19 section headers, starting at offset 0x1284a0:

Section Headers:
  [Nr] Name              Type            Addr     Off    Size   ES Flg Lk Inf Al
  [ 0]                   NULL            00000000 000000 000000 00      0   0  0
  [ 1] .text             PROGBITS        40004030 001030 009c1e 00  AX  0   0 16
  [ 2] .rodata           PROGBITS        4000dc50 00ac50 0016f9 00   A  0   0  4
  [ 3] .data             PROGBITS        4000f360 00c360 0042e0 00  WA  0   0 32
  [ 4] __u_boot_list     PROGBITS        40013640 010640 000594 00  WA  0   0  4
  [ 5] .bss              PROGBITS        40013bd4 010bd4 000734 00   W  0   0  4
  [ 6] .ARM.attributes   ARM_ATTRIBUTES  00000000 011308 000029 00      0   0  1
  [ 7] .comment          PROGBITS        00000000 011331 000012 01  MS  0   0  1
  [ 8] .debug_line       PROGBITS        00000000 011343 02844f 00      0   0  1
  [ 9] .debug_info       PROGBITS        00000000 039792 076ced 00      0   0  1
  [10] .debug_abbrev     PROGBITS        00000000 0b047f 00f697 00      0   0  1
  [11] .debug_aranges    PROGBITS        00000000 0bfb18 002430 00      0   0  8
  [12] .debug_str        PROGBITS        00000000 0c1f48 00d85c 01  MS  0   0  1
  [13] .debug_loc        PROGBITS        00000000 0cf7a4 044a87 00      0   0  1
  [14] .debug_ranges     PROGBITS        00000000 114230 006578 00      0   0  8
  [15] .debug_frame      PROGBITS        00000000 11a7a8 0069c0 00      0   0  4
  [16] .symtab           SYMTAB          00000000 121168 004d20 10     17 887  4
  [17] .strtab           STRTAB          00000000 125e88 002557 00      0   0  1
  [18] .shstrtab         STRTAB          00000000 1283df 0000c1 00      0   0  1

HTH, Phil
