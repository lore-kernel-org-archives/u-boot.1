Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32DE6C072A2
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 15:46:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A371A871CD;
	Wed, 15 Nov 2023 16:46:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="ks4ye4aA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B548887120; Wed, 15 Nov 2023 16:46:20 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 401B987197
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 16:46:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 1aa0901f-83ce-11ee-b94e-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 1aa0901f-83ce-11ee-b94e-005056992ed3;
 Wed, 15 Nov 2023 16:46:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=content-type:mime-version:subject:to:from:message-id:date;
 bh=0hJGkiWp+x9XMSguB/wq+6BHA0Kc6GCm8Z1xpqQsJPk=;
 b=ks4ye4aAXWr2OoW+kc9yt2k2xzI8KCJoQT1M6hW9yU2COiGgQmMpGNwxhkOjdpSIdjJWxZAEN34gh
 +05ASEdNALJE6t7F84ui8cyJitCmqCBpTAviky4tEqeT6bEpSTxqZ6nHLSAetErwjJodEkpEyvC4LB
 vBbygZugwW2OR75Xj6SUMCV+6PAfFia2aR3FD6ycMwTs0Z7os4ATdr7QVhxtTz2q0HjQ+idT3ZM1Su
 KlZhjF+stGYwjtoR4ZNdy22meaUmazeU/k1SXa4dHyq0AtffNtEo6eToWZOGIpLBZdcZBivGHkDYqk
 Jz1GU0uZ2zSFlCxhCUdQ948cf3ZgVMg==
X-KPN-MID: 33|QBiUD1mW5qbf3d1+7htie4j/haoypD3UFUBLrwZn0KpK2lka5M19+XJhOh5bHtt
 PzSU9tzEraAzm+zC0uI2ibZyzu8Rs5NeI5qLCHDYhLCA=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|ov923SMa+zkZv8TDYaNjjTGdDFlN5+puKGVZJTVN/cuEOCyAspjocK/DpqQs3G2
 0aovjgNlczhGwo7p57YOgVg==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 1c658107-83ce-11ee-ad2d-005056998788;
 Wed, 15 Nov 2023 16:46:16 +0100 (CET)
Date: Wed, 15 Nov 2023 16:46:15 +0100
Message-Id: <871qcr9fzs.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Simon Glass <sjg@chromium.org>
Cc: bmeng.cn@gmail.com, trini@konsulko.com, u-boot@lists.denx.de, agust@denx.de
In-Reply-To: <CAPnjgZ1FdLPG086Vnu4dxmdS2sXjUZfq6UETnT8ARdQ7tVFBJg@mail.gmail.com>
 (message from Simon Glass on Tue, 14 Nov 2023 17:48:25 -0700)
Subject: Re: [PATCH v4 09/12] x86: Enable SSE in 64-bit mode
References: <20231112200255.172351-1-sjg@chromium.org>
 <20231112200255.172351-5-sjg@chromium.org>
 <CAEUhbmVg0m6BJQ_k82Hiqc8AJW1ricfd8WhdKCzAVdj1OOm=Vg@mail.gmail.com>
 <CAPnjgZ1PDQ2Da-0ooZSayPQ=vRRuPgFpPaEAgHXdvAZnaTBKiQ@mail.gmail.com>
 <20231113225915.GL6601@bill-the-cat>
 <CAEUhbmV5hf=vbTzbhgs8i95X=0vpgvrd5z0Src7gML0Rw1HX8w@mail.gmail.com>
 <20231113235210.GM6601@bill-the-cat>
 <CAEUhbmWQwPzSSJb5Z5E3vTcx44SbqxeAt_bTsEKa0ETmi2Lk8A@mail.gmail.com>
 <20231114162228.GU6601@bill-the-cat>
 <CAEUhbmUOEB1UB-s_fu_WSWt2FCDfTEcSswWu6yAacUrG-fhB_g@mail.gmail.com>
 <CAPnjgZ1FdLPG086Vnu4dxmdS2sXjUZfq6UETnT8ARdQ7tVFBJg@mail.gmail.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
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

> From: Simon Glass <sjg@chromium.org>
> Date: Tue, 14 Nov 2023 17:48:25 -0700
> 
> Hi,
> 
> On Tue, 14 Nov 2023 at 17:44, Bin Meng <bmeng.cn@gmail.com> wrote:
> >
> > Hi Tom,
> >
> > On Wed, Nov 15, 2023 at 12:22 AM Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Tue, Nov 14, 2023 at 09:49:08AM +0800, Bin Meng wrote:
> > > > Hi Tom,
> > > >
> > > > On Tue, Nov 14, 2023 at 7:52 AM Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Tue, Nov 14, 2023 at 07:46:36AM +0800, Bin Meng wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Tue, Nov 14, 2023 at 6:59 AM Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Mon, Nov 13, 2023 at 03:28:13PM -0700, Simon Glass wrote:
> > > > > > > > Hi Bin,
> > > > > > > >
> > > > > > > > On Mon, 13 Nov 2023 at 15:08, Bin Meng <bmeng.cn@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > Hi Simon,
> > > > > > > > >
> > > > > > > > > On Mon, Nov 13, 2023 at 4:03 AM Simon Glass <sjg@chromium.org> wrote:
> > > > > > > > > >
> > > > > > > > > > This is needed to support Truetype fonts. In any case, the compiler
> > > > > > > > > > expects SSE to be available in 64-bit mode. Provide an option to enable
> > > > > > > > > > SSE so that hardware floating-point arithmetic works.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > Suggested-by: Bin Meng <bmeng.cn@gmail.com>
> > > > > > > > > > ---
> > > > > > > > > >
> > > > > > > > > > Changes in v4:
> > > > > > > > > > - Use a Kconfig option
> > > > > > > > > >
> > > > > > > > > >  arch/x86/Kconfig          |  8 ++++++++
> > > > > > > > > >  arch/x86/config.mk        |  4 ++++
> > > > > > > > > >  arch/x86/cpu/x86_64/cpu.c | 12 ++++++++++++
> > > > > > > > > >  drivers/video/Kconfig     |  1 +
> > > > > > > > > >  4 files changed, 25 insertions(+)
> > > > > > > > > >
> > > > > > > > > > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > > > > > > > > > index 99e59d94c606..6b532d712ee8 100644
> > > > > > > > > > --- a/arch/x86/Kconfig
> > > > > > > > > > +++ b/arch/x86/Kconfig
> > > > > > > > > > @@ -723,6 +723,14 @@ config ROM_TABLE_SIZE
> > > > > > > > > >         hex
> > > > > > > > > >         default 0x10000
> > > > > > > > > >
> > > > > > > > > > +config X86_HARDFP
> > > > > > > > > > +       bool "Support hardware floating point"
> > > > > > > > > > +       help
> > > > > > > > > > +         U-Boot generally does not make use of floating point. Where this is
> > > > > > > > > > +         needed, it can be enabled using this option. This adjusts the
> > > > > > > > > > +         start-up code for 64-bit mode and changes the compiler options for
> > > > > > > > > > +         64-bit to enable SSE.
> > > > > > > > >
> > > > > > > > > As discussed in another thread, this option should be made global to
> > > > > > > > > all architectures and by default no.
> > > > > > > > >
> > > > > > > > > > +
> > > > > > > > > >  config HAVE_ITSS
> > > > > > > > > >         bool "Enable ITSS"
> > > > > > > > > >         help
> > > > > > > > > > diff --git a/arch/x86/config.mk b/arch/x86/config.mk
> > > > > > > > > > index 26ec1af2f0b0..2e3a7119e798 100644
> > > > > > > > > > --- a/arch/x86/config.mk
> > > > > > > > > > +++ b/arch/x86/config.mk
> > > > > > > > > > @@ -27,9 +27,13 @@ ifeq ($(IS_32BIT),y)
> > > > > > > > > >  PLATFORM_CPPFLAGS += -march=i386 -m32
> > > > > > > > > >  else
> > > > > > > > > >  PLATFORM_CPPFLAGS += $(if $(CONFIG_SPL_BUILD),,-fpic) -fno-common -march=core2 -m64
> > > > > > > > > > +
> > > > > > > > > > +ifndef CONFIG_X86_HARDFP
> > > > > > > > > >  PLATFORM_CPPFLAGS += -mno-mmx -mno-sse
> > > > > > > > > >  endif
> > > > > > > > > >
> > > > > > > > > > +endif # IS_32BIT
> > > > > > > > > > +
> > > > > > > > > >  PLATFORM_RELFLAGS += -fdata-sections -ffunction-sections -fvisibility=hidden
> > > > > > > > > >
> > > > > > > > > >  KBUILD_LDFLAGS += -Bsymbolic -Bsymbolic-functions
> > > > > > > > > > diff --git a/arch/x86/cpu/x86_64/cpu.c b/arch/x86/cpu/x86_64/cpu.c
> > > > > > > > > > index 2647bff891f8..5ea746ecce4d 100644
> > > > > > > > > > --- a/arch/x86/cpu/x86_64/cpu.c
> > > > > > > > > > +++ b/arch/x86/cpu/x86_64/cpu.c
> > > > > > > > > > @@ -10,6 +10,7 @@
> > > > > > > > > >  #include <init.h>
> > > > > > > > > >  #include <asm/cpu.h>
> > > > > > > > > >  #include <asm/global_data.h>
> > > > > > > > > > +#include <asm/processor-flags.h>
> > > > > > > > > >
> > > > > > > > > >  DECLARE_GLOBAL_DATA_PTR;
> > > > > > > > > >
> > > > > > > > > > @@ -39,11 +40,22 @@ int x86_mp_init(void)
> > > > > > > > > >         return 0;
> > > > > > > > > >  }
> > > > > > > > > >
> > > > > > > > > > +/* enable SSE features for hardware floating point */
> > > > > > > > > > +static void setup_sse_features(void)
> > > > > > > > > > +{
> > > > > > > > > > +       asm ("mov %%cr4, %%rax\n" \
> > > > > > > > > > +       "or  %0, %%rax\n" \
> > > > > > > > > > +       "mov %%rax, %%cr4\n" \
> > > > > > > > > > +       : : "i" (X86_CR4_OSFXSR | X86_CR4_OSXMMEXCPT) : "eax");
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > > >  int x86_cpu_reinit_f(void)
> > > > > > > > > >  {
> > > > > > > > > >         /* set the vendor to Intel so that native_calibrate_tsc() works */
> > > > > > > > > >         gd->arch.x86_vendor = X86_VENDOR_INTEL;
> > > > > > > > > >         gd->arch.has_mtrr = true;
> > > > > > > > > > +       if (IS_ENABLED(CONFIG_X86_HARDFP))
> > > > > > > > > > +               setup_sse_features();
> > > > > > > > > >
> > > > > > > > > >         return 0;
> > > > > > > > > >  }
> > > > > > > > > > diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> > > > > > > > > > index 6f319ba0d544..39c82521be16 100644
> > > > > > > > > > --- a/drivers/video/Kconfig
> > > > > > > > > > +++ b/drivers/video/Kconfig
> > > > > > > > > > @@ -180,6 +180,7 @@ config CONSOLE_ROTATION
> > > > > > > > > >
> > > > > > > > > >  config CONSOLE_TRUETYPE
> > > > > > > > > >         bool "Support a console that uses TrueType fonts"
> > > > > > > > > > +       select X86_HARDFP if X86
> > > > > > > > >
> > > > > > > > > This should be "depends on HARDFP", indicating that the TrueType
> > > > > > > > > library is using hardware fp itself, and user has to explicitly turn
> > > > > > > > > the hardware fp Kconfig option on.
> > > > > > > >
> > > > > > > > So you mean 'depends on HARDFP if X86'  ? After all, this is only for
> > > > > > > > X86 - other archs can use softfp which is already enabled, as I
> > > > > > > > understand it.
> > > > > > > >
> > > > > > > > >
> > > > > > > > > "Select" does not work for architectures that does not have the
> > > > > > > > > "enabling hardware fp" logic in place.
> > > > > > > > >
> > > > > > > > > >         help
> > > > > > > > > >           TrueTrype fonts can provide outline-drawing capability rather than
> > > > > > > > > >           needing to provide a bitmap for each font and size that is needed.
> > > > > > > > > > --
> > > > > > > >
> > > > > > > > I still don't think we are on the same page here. I would prefer to
> > > > > > > > just enable the options without any option. I really don't want to get
> > > > > > > > into RISC-V stuff - that is a separate concern.
> > > > > > > >
> > > > > > > > From my POV it seems that x86 is special in that:
> > > > > > > > - it uses hardfp
> > > > > > > > - hardfp is always available in any CPU with 64-bit support (I think?)
> > > > > > >
> > > > > > > Maybe the issue even is that on x86 we're being too imprecise in our
> > > > > > > build rules (and also on RISC-V, another issue). Today on x86 this fails
> > > > > > > because we say -mno-mmx -mno-sse and not also -msoft-float. I can just
> > > > > > > turn that on, on all x86 targets today and things build. Would that not
> > > > > > > also fix the truetype issue?
> > > > > >
> > > > > > One can easily turn on compiler flags for x86 (and for RISC-V too) to
> > > > > > tell the compiler to generate floating point instructions if it sees
> > > > > > fit.
> > > > > >
> > > > > > However on x86 and RISC-V there are configurations needed to program
> > > > > > the CPU registers to turn on the hardware FP, otherwise an exception
> > > > > > will be generated.
> > > > >
> > > > > Right, which is why I'm saying why don't we just use -msoft-float
> > > > > instead, so that we don't have to worry about enabling features (and
> > > > > also additional registers on the stack yes?) ?
> > > >
> > > > Yes, we should be using -msoft-float for all architectures by default
> > > > if the compiler supports that on each arch. IIRC, the RISC-V back-end
> > > > didn't support that years ago but things may change recently.
> > >
> > > OK, so for this series, lets please just simplify the logic in
> > > arch/x86/config.mk (and do some boot testing too of course) to
> > > -msoft-float everyone, and then the fonts should also be working and we
> > > don't have to deal with some other details as well, yes? And having said
> > > that, just for sanity sake keep a stopwatch nearby and do some normal
> > > functional tests too, to make sure we don't suddenly speed-regress?
> >
> > To make fonts work with -msoft-float for everyone, we need U-Boot to
> > link with the compiler intrinsics library (e.g.: libgcc, or
> > compler-rt). As of today some architectures choose a private libgcc
> > implementation within U-Boot.
> 
> I thought I mentioned this but softfp did not work for me on x86 and
> my limited research suggests it is experimental / not used.
> 
> So look, I have a fairly trivial patch here. Perhaps we should just
> apply it and worry about RISC-V when needed?

Well, the thing I would worry about is handing over to the OS with
certain CR4 features enabled that the OS doesn't expect to be enabled.
I think your diff should disable those bits again before handing over
to the OS.  Or is that already done?
