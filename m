Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C363EA794A
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 23:00:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30B9F83015;
	Thu,  5 Feb 2026 00:00:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nwl.cc header.i=@nwl.cc header.b="W49e28jK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A15F8341A; Thu,  5 Feb 2026 00:00:45 +0100 (CET)
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D37338063E
 for <u-boot@lists.denx.de>; Thu,  5 Feb 2026 00:00:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=phil@nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
 s=mail2022; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=g8v1L9do8i1StY7oOX++N1IaF1p0K6cvuoaNW8HRhMI=; b=W49e28jKDhJHKZBMH0Cq/DsLib
 KgKgvWxNr4c8OK1DbPpKGAYhhrsCbFooBhrk4w8XKh0bonrhpDfty9Hx7XtljjWNxZh1pKmdSgOWO
 OSoKrVRBcsubO0kEAdEYEzczW4YoKxQb9fIk3lLNizS+wweere4LAZ10gRsw+aYJMtx43Z/tfGBL/
 zU0nuVihmWTQPgCoBGSCUCVqRn4V+pve4GlPA5hcNbDSV+LoTiPfLmmfYSJf7pr0Kk5SjBOM+E3zD
 ZisTi7zCJmYz5kxtiMMs/u+TS6VTe5dwhs/IzSRaNzV4Gc6HfBFXtLo9sNiQ2ftwmSOkMxQe82kS3
 2//eFWKA==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.98.2)
 (envelope-from <phil@nwl.cc>) id 1vnlrP-000000003bL-3i37;
 Thu, 05 Feb 2026 00:00:36 +0100
Date: Thu, 5 Feb 2026 00:00:34 +0100
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
Message-ID: <aYPPkg0rQTQr0g2Y@orbyte.nwl.cc>
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
References: <20260115222828.3931345-1-trini@konsulko.com>
 <20260115222828.3931345-3-trini@konsulko.com>
 <aYO3HOmFFVAkjfKD@orbyte.nwl.cc>
 <20260204212010.GD2603314@bill-the-cat>
 <aYO5r8Na5-fRYHgA@orbyte.nwl.cc>
 <20260204213139.GE2603314@bill-the-cat>
 <aYO8vDPa522pttDV@orbyte.nwl.cc>
 <20260204215016.GF2603314@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204215016.GF2603314@bill-the-cat>
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

On Wed, Feb 04, 2026 at 03:50:16PM -0600, Tom Rini wrote:
> On Wed, Feb 04, 2026 at 10:40:12PM +0100, Phil Sutter wrote:
> > On Wed, Feb 04, 2026 at 03:31:39PM -0600, Tom Rini wrote:
> > > On Wed, Feb 04, 2026 at 10:27:11PM +0100, Phil Sutter wrote:
> > > > On Wed, Feb 04, 2026 at 03:20:10PM -0600, Tom Rini wrote:
> > > > > On Wed, Feb 04, 2026 at 10:16:12PM +0100, Phil Sutter wrote:
> > > > > > Hi,
> > > > > > 
> > > > > > On Thu, Jan 15, 2026 at 04:19:32PM -0600, Tom Rini wrote:
> > > > > > > With commit 0535e46d55d7 ("scripts/dtc: Update to upstream version
> > > > > > > v1.7.2-35-g52f07dcca47c") it is now a fatal error to U-Boot if our
> > > > > > > device tree is not 8-byte aligned. In commit f613a6e15ef7 ("ARM: OMAP2+:
> > > > > > > Pad SPL binary to 8-byte alignment before DTB") Beleswar Padhi explains
> > > > > > > that we must have ALIGN(x) statements inside of a section to ensure that
> > > > > > > padding is included and not simply that the linker address counter is
> > > > > > > incremented. To that end, this patch:
> > > > > > > - Expands some linker sections to be more readable when adding a second
> > > > > > >   statement to the section.
> > > > > > > - Aligns the final section before _end (for U-Boot) or
> > > > > > >   _image_binary_end or __bss_end (for xPL phases) by 8-bytes by adding
> > > > > > >   '. = ALIGN(8);' to the final section before the symbol.
> > > > > > > - Ensure that we do have alignment by adding an ASSERT so that when not
> > > > > > >   aligned we fail to link (and explain why).
> > > > > > > - Remove now-spurious  '. = ALIGN(x);' statements that were intended to
> > > > > > >   provide the above alignments.
> > > > > > > 
> > > > > > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > > > > 
> > > > > > For unclear reasons, this seems to break boot via xmodem protocol on my
> > > > > > Synology DS414. I found this commit via 'git bisect'. The symptom is:
> > > > > > 
> > > > > > | kwboot version 2026.04-rc1-00098-g6ad0cf8f83db
> > > > > > | Detected kwbimage v1 with SPI boot signature
> > > > > > | Patching image boot signature to UART
> > > > > > | Aligning image header to Xmodem block size
> > > > > > | Sending boot message. Please reboot the target...\
> > > > > > | Sending boot image header (67584 bytes)...
> > > > > > |   0 % [......................................................................]
> > > > > > |  13 % [......................................................................]
> > > > > > |  26 % [......................................................................]
> > > > > > |  39 % [......................................................................]
> > > > > > |  53 % [......................................................................]
> > > > > > |  66 % [......................................................................]
> > > > > > |  79 % [......................................................................]
> > > > > > |  92 % [......................................                                ]
> > > > > > | Done
> > > > > > | Missing DTB
> > > > > > | spl_init() failed: -2
> > > > > > | ### ERROR ### Please RESET the board ###
> > > > > > | 
> > > > > > | 
> > > > > > | xmodem: Connection timed out
> > > > > > 
> > > > > > Debug printf()s in fdtdec_prepare_fdt() show that fdt_check_header()
> > > > > > returns -FDT_ERR_BADMAGIC.
> > > > > > 
> > > > > > With HEAD at a8d982e1f1726 ("x86: cpu: Fix crash on FTRACE enabled
> > > > > > builds"), reverting arch/arm/cpu/u-boot-spl.lds like so:
> > > > > > 
> > > > > > | @@ -41,14 +41,21 @@ SECTIONS
> > > > > > |                 __binman_sym_start = .;
> > > > > > |                 KEEP(*(SORT(.binman_sym*)));
> > > > > > |                 __binman_sym_end = .;
> > > > > > | -               . = ALIGN(8);
> > > > > > |         }
> > > > > > |  
> > > > > > | +       . = ALIGN(4); /* critical! */
> > > > > > |         __image_copy_end = .;
> > > > > > | +       .rel.dyn : {
> > > > > > | +               __rel_dyn_start = .;
> > > > > > | +               *(.rel*)
> > > > > > | +               __rel_dyn_end = .;
> > > > > > | +       }
> > > > > > | +
> > > > > > | +       . = ALIGN(8);
> > > > > > |         _image_binary_end = .;
> > > > > > |         _end = .;
> > > > > > |  
> > > > > > | -       .bss : {
> > > > > > | +       .bss __rel_dyn_start (OVERLAY) : {
> > > > > > |                 __bss_start = .;
> > > > > > |                 *(.bss*)
> > > > > > |                  . = ALIGN(8);
> > > > > > 
> > > > > > The SPL image starts up again and continues loading the real uboot
> > > > > > image. Note that I have no idea what these changes actually do, so I
> > > > > > need instructions if I should dig further.
> > > > > 
> > > > > Does:
> > > > > https://patchwork.ozlabs.org/project/uboot/patch/20260130183635.2612933-1-trini@konsulko.com/
> > > > > fix it?
> > > > 
> > > > Sadly not, same result.
> > > 
> > > Ugh. What file, specifically, do you send via xmodem? And so that maybe
> > > I can more easily replicate the failure, are you using the kernel.org
> > > gcc-14.2.0 toolchain or something else?
> > 
> > I am building with a custom-built arm-openadk-linux-uclibceabi-gcc
> > version 14.3.0. Basically what I run is:
> > 
> > MYENV='ARCH=arm CROSS_COMPILE=~/git/openadk-ds414/toolchain_synology-ds414_uclibc-ng_softfp_eabi_arm/usr/bin/arm-openadk-linux-uclibceabi-'
> > 
> > make $MYENV clean && \
> > for f in $(ls u-boot*.kwb 2>/dev/null); do rm $f; done && \
> > make $MYENV ds414_defconfig && \
> > make $MYENV -j12 && \
> > ./tools/kwboot -a -t -p -b u-boot-*spl.kwb /dev/ttyUSB0
> > 
> > With current uboot, this should be u-boot-with-spl.kwb image.
> > 
> > With said patch reverted (or the above changes applied), I produce a
> > working u-boot-with-spl.kwb which loads and boots linux from flash. So
> > my toolchain is at least not totally broken. ;)
> 
> Right, so, for background, the following threads might shed some light
> on things:
> https://lore.kernel.org/u-boot/CAOMZO5DZNJ+=AP1spWCv7Ar6etf03H=DFVU=mXZcC7QFTGoh_Q@mail.gmail.com/
> https://lore.kernel.org/u-boot/20260123161907.392211-1-festevam@gmail.com/
> 
> And so to that end, can you please do:
> hexdump -Cv u-boot-with-spl.kwb | grep 'd0 0d fe ed'
> and let me know what that says? And the first line there should match,
> content-wise at least (but not quite file offset) spl/u-boot-spl. I was
> asking about your toolchain because with gcc-14.2.0 from kernel.org:
> $ hexdump -Cv /tmp/ds414/spl/u-boot-spl | grep 'd0 0d fe ed'
> 00002ed0  6f f0 12 00 70 47 00 bf  d0 0d fe ed 00 29 05 db  |o...pG.......)..|
> $ hexdump -Cv /tmp/ds414/u-boot-with-spl.kwb | grep 'd0 0d fe ed'
> 00001ed0  6f f0 12 00 70 47 00 bf  d0 0d fe ed 00 29 05 db  |o...pG.......)..|

This is with HEAD at a8d982e1f17 + your "spl: Ensure final section before BSS
is non-empty" applied:

% hexdump -Cv u-boot-with-spl.kwb | grep 'd0 0d fe ed' | head -n1
00001ed0  6f f0 12 00 70 47 00 bf  d0 0d fe ed 00 29 05 db  |o...pG.......)..|

% hexdump -Cv spl/u-boot-spl | grep 'd0 0d fe ed'
00002ed0  6f f0 12 00 70 47 00 bf  d0 0d fe ed 00 29 05 db  |o...pG.......)..|

> And while this should then *work* that's luck and not design. If you can
> confirm that instead 'd0 0d fe ed' is in the middle (and so 4 byte but
> not 8 byte aligned) it'll at least be the same symptom as before.

Hmm. My dumps indicate correct 8B alignment, right? Switching over to a branch
which has the problematic commit reverted and produced images work, I
get exactly the same output from hexdump on those files, BTW. Does that
mean we're on the wrong track and my problem is not wrong DTB alignment?

Cheers, Phil
