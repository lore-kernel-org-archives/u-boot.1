Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5580CD342F
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 18:45:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E589A84D1B;
	Fri,  8 May 2026 20:45:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EsO5Nc49";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 370E584D1E; Fri,  8 May 2026 20:45:31 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1087184D02
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 20:45:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-67179ed133dso2834961a12.2
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 11:45:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778265926; cv=none;
 d=google.com; s=arc-20240605;
 b=L2gYqyNq5DJSm6igtOZOEmRrR9B4QyMLjRPcKOdoi625LSxz5PuE4aAbHkOoArtbuc
 ToJZUFlJQpCyPyKhw1E/WvK9T5BcURbozdAyNzYlV8g8GPhLUxen4VAtlihZXRmdaYGc
 4nECzW9Cgqs9mOaDsmo7d5gmBds6bwfwCaJzXOn2SKI8A4Yq0Fpqol5qpblndjhjUHo/
 y2GeI2VXZcuzOjiGA34S+I49i+JWPYT14M4xKNrAIjD3wFaNw5AESw/vFVIoQ4YBvLaF
 IGt+7ZlkSkoV6Gbzh1bJkAfiJmYUrtrtBF6iflu+HjvxpuuCo1+eAXLrU0Re/buCd81X
 N6jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/op802ORv29ByQR7DWLJSrOMdJ8Ow0Oxe6WQ1gEnWr8=;
 fh=1i0gqMSCZMLhHD9NktEqBOQ05Hpdsq1K+WW621WZPNU=;
 b=P9Oa4c6OBlVI1SzjZJE+bF6B47lOI/CA6pk8aD2D4G3B/nqoTKGxjbbJsla1381Ti3
 MFmnS4vdG21DVgwVjsFkR10C9E31FqknRBTKLqm7fXzMz56KOGtcgFrqwYOWejHAB7pR
 9qNj+cXjmeKKwCGQeHAUBhulO2VK/To9t7aFtpAvshTtSvTfzvmMjf3ZxDRLa4KPtbbD
 ejIN+ehEw/zMH3FjgjQOP6XPziNnntinlSEWY0nC6Mx+xd3tjXE69kB3UyPeUBgNM6Qo
 4O5MRg8WKBeOSNKh4QGyaagM/VhWB1L0iQpk+BFUyjOcX6M060oIW9bt7QxjNXv7Ce0v
 Yg7Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778265926; x=1778870726; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/op802ORv29ByQR7DWLJSrOMdJ8Ow0Oxe6WQ1gEnWr8=;
 b=EsO5Nc49OjcKzqU2ARGefp35MvQ+rPfWg+FfsfR/rvqpSvXzUeXbryvzpNSf4cJ917
 CYV2aqcF8HtwoI00Qurt5DK0JG/qk5Ima8Ptx+E6MbjvPGg3O/yzAyYUcp4ad+puYDdy
 PJx0dnvWFHRwgM+8dOs2ZH9Q0+Kix0w/YCxY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778265926; x=1778870726;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/op802ORv29ByQR7DWLJSrOMdJ8Ow0Oxe6WQ1gEnWr8=;
 b=hiQEtPrjknYSlvs64HlWGRMspbvmTaTCMcUGi4PyCfqHLWAEMF+mpJ+yQy1pXFfKHN
 oMCkFJ8DCgtqK+EG7MpJMddIo+FDJwClDIS39fTZatIPip6aFtmSEaeysmfg1pHk/gxP
 GyRjtzUZ/cH9rTr3ByFwaJiLxX21ivvfZRR9DBYV5zydoUhbPPC+BjENbSBzyl7E1ffT
 TONiw9+9PMh0zVc69okG8J5IJiwop3+o4jV1lX4QsSW8cXyiacterLbdgkLmwqh1O+9p
 pvA0FWCDWVYo1nGfyGAbIQjQoOg7XAVcJCvYJxoeJgQ/bxioaFj8vebc2FHPchhcbL0X
 RmFw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8nPtTJyZ88+cdxGn5YaFCAYWCv+kJD35MH3blGaAVSae6aquIzRZcSPBuRrD0RB/5LMbM2o3U=@lists.denx.de
X-Gm-Message-State: AOJu0Yw2o6R7JU5MV+9n0DoahEwzYVv7QZ//gtug3XNWfLKAXu57tOWP
 ZrjQ95XAqToqCVSqxBkpKwKBJu4PxeGUTvysqC+Nt15ODWkdzS3jbGp1IQgnIA/RPpNr+4a6zw2
 VZ8VsCXHV4ZbanteO7DCJ98f+7gfP3KT7Vela0Btt
X-Gm-Gg: AeBDieuDa+DJ1TxLpSwKsq1X07wsqy7ruN06CB2Ms7dv74Hm3qPevCVGbUyXCAB7dvt
 82Pxo6erZ4SgIym0KVC1XxqbnG6eYCUTiJEEnRL1DHvLWhwEIngDuC/k7uWmP3gR/OV/aRQeptK
 tXBhjLNLktYXnvQ5E0tOYbslDt6G7YQXkx2Ptb5VfDaAzmgOPIA5Gpg6tBfc6px93NPNRbc0WnS
 8yeXyYgZQW1B0wA5tHuNoygEGnA90NBX1QpgZ+fxTVOjV7UIAC+G3topwIzshpG6omFag9R8Cjb
 6vkmkyAz5/t3dK+o
X-Received: by 2002:a17:907:3c8c:b0:bcb:2893:f703 with SMTP id
 a640c23a62f3a-bcb28a343b3mr190233766b.21.1778265925937; Fri, 08 May 2026
 11:45:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260504-extrawarn-sync-v1-0-b19301d1948a@cherry.de>
 <20260504180429.GJ1614990@bill-the-cat>
 <af74c5ed-a3a0-4f2d-a261-269e31882711@cherry.de>
 <20260505151007.GR1614990@bill-the-cat>
 <7250a64c-1942-4614-bef0-6f55a7becfd9@cherry.de>
 <20260508172339.GA1858239@bill-the-cat>
In-Reply-To: <20260508172339.GA1858239@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 8 May 2026 12:45:13 -0600
X-Gm-Features: AVHnY4Kid6vqTm4Wt1wkEY-bkf-jq8HCBpqqQj7cIoXhTq-aNZC4xr5-2wEVGRQ
Message-ID: <CAFLszThS9OUxTp6250nFJY5GDKvaHUoWxytLTfx65gzVvK+u0Q@mail.gmail.com>
Subject: Re: [PATCH RFC next 00/18] sync scripts/Makefile.extrawarn with 6.1, 
 enable WERROR for host tools
To: Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.denx.de, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 David Lechner <dlechner@baylibre.com>, 
 Jerome Forissier <jerome.forissier@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <simon.glass@canonical.com>, 
 Raymond Mao <raymondmaoca@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, Yao Zi <me@ziyao.cc>,
 Rasmus Villemoes <ravi@prevas.dk>
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

Hi Tom, Quentin,

On Fri, 8 May 2026 at 11:23, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, May 08, 2026 at 01:55:41PM +0200, Quentin Schulz wrote:
> > Hi Tom,
> >
> > On 5/5/26 5:10 PM, Tom Rini wrote:
> > > On Tue, May 05, 2026 at 01:58:26PM +0200, Quentin Schulz wrote:
> > > > Hi Tom,
> > > >
> > > > On 5/4/26 8:04 PM, Tom Rini wrote:
> > > > > On Mon, May 04, 2026 at 03:20:27PM +0200, Quentin Schulz wrote:
> > > > [...]
> > > > > > The first two patches are for fixing pytest calling make direct=
ly on a
> > > > > > "dirty" build directory as generated by buildman using the clan=
g-20
> > > > > > toolchain, but pytest does not set HOSTCC and CC to clang-20, r=
esulting
> > > > > > in clang flags being used with gcc).
> > > > > >
> > > > > > One can simply reproduce it (after backporting up to patch
> > > > > > "scripts/Makefile.extrawarn: sync with 6.1") by doing so in the
> > > > > > container:
> > > > > >
> > > > > > make HOSTCC=3Dclang-20 CC=3Dclang-20 O=3Dbuild/sandbox sandbox_=
defconfig
> > > > > > make HOSTCC=3Dclang-20 CC=3Dclang-20 O=3Dbuild/sandbox -j`nproc
> > > > > > make O=3Dbuild/sandbox u-boot-initial-env
> > > > > >
> > > > > > It'll print:
> > > > > > gcc: error: unrecognized command-line option '-mno-global-merge=
'
> > > > > > gcc: error: unrecognized command-line option '-Wformat-invalid-=
specifier'
> > > > > > gcc: error: unrecognized command-line option '-Qunused-argument=
s'
> > > > > >
> > > > > > This is essentially what's run within test_env_initial_env_file=
 in
> > > > > > test/py/tests/test_env.py.
> > > > > >
> > > > > > While I'm not unhappy with the patches to pytest, it feels to m=
e we may
> > > > > > be missing something else for the u-boot-initial-env make targe=
t to
> > > > > > update the kconfig symbol based on the toolchain being used whe=
n called.
> > > > >
> > > > > Is there some other target in the Makefile that should catch this=
 kind
> > > > > of change? It's not just that build target that needs to be remad=
e, it's
> > > > > everything, yes?
> > > > >
> > > >
> > > > For the reproducer, one actually needs to do
> > > >
> > > > diff --git a/Makefile b/Makefile
> > > > index bd33437fdfd..9079131f81e 100644
> > > > --- a/Makefile
> > > > +++ b/Makefile
> > > > @@ -1007,15 +1007,15 @@ KBUILD_CFLAGS +=3D $(call
> > > > cc-option,-Wno-format-nonliteral)
> > > >   KBUILD_CFLAGS +=3D $(call cc-disable-warning, address-of-packed-m=
ember)
> > > >
> > > >   ifdef CONFIG_CC_IS_CLANG
> > > > -KBUILD_CPPFLAGS +=3D $(call cc-option,-Qunused-arguments,)
> > > > -KBUILD_CFLAGS +=3D $(call cc-disable-warning, format-invalid-speci=
fier)
> > > > -KBUILD_CFLAGS +=3D $(call cc-disable-warning, gnu)
> > > > +KBUILD_CPPFLAGS +=3D -Qunused-arguments
> > > > +KBUILD_CFLAGS +=3D -Wno-format-invalid-specifier
> > > > +KBUILD_CFLAGS +=3D -Wno-gnu
> > > >   # Quiet clang warning: comparison of unsigned expression < 0 is a=
lways
> > > > false
> > > > -KBUILD_CFLAGS +=3D $(call cc-disable-warning, tautological-compare=
)
> > > > +KBUILD_CFLAGS +=3D -Wno-tautological-compare
> > > >   # CLANG uses a _MergedGlobals as optimization, but this breaks mo=
dpost, as
> > > > the
> > > >   # source of a reference will be _MergedGlobals and not on of the
> > > > whitelisted names.
> > > >   # See modpost pattern 2
> > > > -KBUILD_CFLAGS +=3D $(call cc-option, -mno-global-merge,)
> > > > +KBUILD_CFLAGS +=3D -mno-global-merge
> > > >   else
> > > >
> > > >   # These warnings generated too much noise in a regular build.
> > > >
> > > > Which is what's being done since kernel commit a1494304346a ("kbuil=
d: add
> > > > all Clang-specific flags unconditionally"). I actually had this in =
an
> > > > earlier version of this patch series and forgot I removed it.
> > > >
> > > > This seems to apply to envtools and tools-only as well, though make=
 prompts
> > > > me for the desired state of symbols that are now reachable, e.g.
> > > > ARM64_CRC32. And if I rerun the same command, then it works. It see=
ms like
> > > > the config from the previous run is used? I don't know if it's rela=
ted but
> > > > those two commands call make directly ($(Q)$(MAKE) $(build)=3D<path=
>). Do you
> > > > have something in mind maybe? Or some more commands to run?
> > >
> > > I think I partly misunderstood at first. It's not that we switch from
> > > one toolchain to another, it's that we can't (as easily) use gcc for =
the
> > > target and clang for host tools (and vice-versa) because of how flags
> > > are set now, yes? If so, how does this work in the kernel?
> > >
> >
> > I'm not sure what's happening so it's quite difficult to put into words=
.
> >
> > Apply the following to the master branch:
> >
> > diff --git a/Makefile b/Makefile
> > index 49d9740327e..9a2367f0a97 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -999,15 +999,15 @@ KBUILD_CFLAGS +=3D $(call
> > cc-option,-Wno-format-nonliteral)
> >  KBUILD_CFLAGS +=3D $(call cc-disable-warning, address-of-packed-member=
)
> >
> >  ifdef CONFIG_CC_IS_CLANG
> > -KBUILD_CPPFLAGS +=3D $(call cc-option,-Qunused-arguments,)
> > -KBUILD_CFLAGS +=3D $(call cc-disable-warning, format-invalid-specifier=
)
> > -KBUILD_CFLAGS +=3D $(call cc-disable-warning, gnu)
> > +KBUILD_CPPFLAGS +=3D -Qunused-arguments
> > +KBUILD_CFLAGS +=3D -Wno-format-invalid-specifier
> > +KBUILD_CFLAGS +=3D -Wno-gnu
> >  # Quiet clang warning: comparison of unsigned expression < 0 is always
> > false
> > -KBUILD_CFLAGS +=3D $(call cc-disable-warning, tautological-compare)
> > +KBUILD_CFLAGS +=3D -Wno-tautological-compare
> >  # CLANG uses a _MergedGlobals as optimization, but this breaks modpost=
, as
> > the
> >  # source of a reference will be _MergedGlobals and not on of the
> > whitelisted names.
> >  # See modpost pattern 2
> > -KBUILD_CFLAGS +=3D $(call cc-option, -mno-global-merge,)
> > +KBUILD_CFLAGS +=3D -mno-global-merge
> >  KBUILD_CFLAGS +=3D $(call cc-option, -fcatch-undefined-behavior)
> >  KBUILD_CFLAGS +=3D $(call cc-disable-warning, deprecated-non-prototype=
)
> >  else
> >
> >
> > What I do:
> >
> > make CROSS_COMPILE=3D"aarch64-linux-gnu-" O=3Dbuild/puma HOSTCC=3Dclang=
 CC=3Dclang
> > puma-rk3399_defconfig
> > make CROSS_COMPILE=3D"aarch64-linux-gnu-" O=3Dbuild/puma HOSTCC=3Dclang=
 CC=3Dclang
> > V=3D1
> > make CROSS_COMPILE=3D"aarch64-linux-gnu-" O=3Dbuild/puma V=3D1
> >
> > That is, I configure the defconfig with clang selected as toolchain,
> > (successfully) build U-Boot with clang, then rebuild switching to gcc.
> >
> > What happens is that the last make command prompts me for Kconfig symbo=
ls
> > that are now reachable and thus kconfig doesn't know what to do with th=
em.
> >
> > See the (NEW) entries below:
> >
> > scripts/kconfig/conf  --syncconfig Kconfig
> > *
> > * Restart config...
> > *
> > *
> > * ARM architecture
> > *
> > Enable support for CRC32 instruction (ARM64_CRC32) [Y/n/?] (NEW)
> >
> > Timer clock frequency (COUNTER_FREQUENCY) [24000000] 24000000
> > Generate position-independent pre-relocation code (POSITION_INDEPENDENT=
)
> > [N/y/?] n
> > Specify the early stack pointer relative to the .bss section
> > (INIT_SP_RELATIVE) [N/y/?] n
> > Emit virtualizable instructions (KVM_VIRT_INS) [N/y/?] n
> > ARM GICV2 driver (DRIVER_GICV2) [N/y/?] n
> > ARM GICV3 ITS (GIC_V3_ITS) [N/y/?] n
> > ARM GICV3 GIC600 SUPPORT (GICV3_SUPPORT_GIC600) [N/y/?] n
> > Do not enable icache (SYS_ICACHE_OFF) [N/y/?] n
> > Do not enable icache in SPL (SPL_SYS_ICACHE_OFF) [N/y/?] n
> > Do not enable dcache (SYS_DCACHE_OFF) [N/y/?] n
> > Do not enable dcache in SPL (SPL_SYS_DCACHE_OFF) [N/y/?] n
> > CP15 based cache enabling support (SYS_ARM_CACHE_CP15) [N/y/?] n
> > MMU-based Paged Memory Management Support (SYS_ARM_MMU) [N/y/?] n
> > Use the ARM v7 PMSA Compliant MPU (SYS_ARM_MPU) [N/y/?] n
> > Select the ARM data write cache policy
> > > 1. Write-back (WB) (SYS_ARM_CACHE_WRITEBACK)
> >   2. Write-through (WT) (SYS_ARM_CACHE_WRITETHROUGH)
> >   3. Write allocation (WA) (SYS_ARM_CACHE_WRITEALLOC)
> > choice[1-3?]: 1
> > Enable ARCH_CPU_INIT (ARCH_CPU_INIT) [N/y/?] n
> > ARM Generic Timer support (SYS_ARCH_TIMER) [Y/n/?] y
> > Support for ARM SMC Calling Convention (SMCCC) (ARM_SMCCC) [Y/?] y
> > ARM PL310 L2 cache controller (SYS_L2_PL310) [N/y/?] n
> > ARM PL310 L2 cache controller in SPL (SPL_SYS_L2_PL310) [N/y/?] n
> > L2cache off (SYS_L2CACHE_OFF) [N/y/?] n
> > prepare BOOT0 header (ENABLE_ARM_SOC_BOOT0_HOOK) [Y/?] y
> > Use an assembly optimized implementation of memcpy (USE_ARCH_MEMCPY) [N=
/y/?]
> > (NEW)
> >
> > Use an assembly optimized implementation of memcpy for SPL
> > (SPL_USE_ARCH_MEMCPY) [N/y/?] n
> > Use an assembly optimized implementation of memcpy for TPL
> > (TPL_USE_ARCH_MEMCPY) [N/y/?] n
> > Use an assembly optimized implementation of memset (USE_ARCH_MEMSET) [N=
/y/?]
> > (NEW)
> >
> > Use an assembly optimized implementation of memset for SPL
> > (SPL_USE_ARCH_MEMSET) [N/y/?] n
> > Use an assembly optimized implementation of memset for TPL
> > (TPL_USE_ARCH_MEMSET) [N/y/?] n
> > ARM64 system support AArch32 execution state (ARM64_SUPPORT_AARCH32) [Y=
/n/?]
> > y
> > Target select
> >   1. Airoha SoCs (ARCH_AIROHA)
> >   2. Atmel AT91 (ARCH_AT91)
> >   3. TI DaVinci (ARCH_DAVINCI)
> >   4. Hisilicon HiSTB SoCs (ARCH_HISTB)
> >   5. Marvell Kirkwood (ARCH_KIRKWOOD)
> >   6. Marvell MVEBU family (Armada XP/375/38x/3700/7K/8K) (ARCH_MVEBU)
> >   7. Broadcom BCM283X family (ARCH_BCM283X)
> >   8. Broadcom BCM7XXX family (ARCH_BCMSTB)
> >   9. Broadcom broadband chip family (ARCH_BCMBCA)
> >   10. Support vexpress_ca9x4 (TARGET_VEXPRESS_CA9X4)
> >   11. Support Broadcom Northstar (TARGET_BCMNS)
> >   12. Support Broadcom NS3 (TARGET_BCMNS3)
> >   13. Samsung EXYNOS (ARCH_EXYNOS)
> >   14. Samsung S5PC1XX (ARCH_S5PC1XX)
> >   15. Calxeda Highbank (ARCH_HIGHBANK)
> >   16. ARM Ltd. Integrator family (ARCH_INTEGRATOR)
> >   17. Qualcomm IPQ40xx SoCs (ARCH_IPQ40XX)
> >   18. TI Keystone (ARCH_KEYSTONE)
> >   19. Texas Instruments' K3 Architecture (ARCH_K3)
> >   20. TI OMAP2+ (ARCH_OMAP2PLUS)
> >   21. Amlogic Meson (ARCH_MESON)
> >   22. MediaTek SoCs (ARCH_MEDIATEK)
> >   23. Marvell MMP (ARCH_MMP)
> >   24. NXP LPC32xx platform (ARCH_LPC32XX)
> >   25. NXP i.MX8 platform (ARCH_IMX8)
> >   26. NXP i.MX8M platform (ARCH_IMX8M)
> >   27. NXP i.MX8ULP platform (ARCH_IMX8ULP)
> >   28. NXP i.MX9 platform (ARCH_IMX9)
> >   29. NXP i.MXRT platform (ARCH_IMXRT)
> >   30. NXP i.MX23 family (ARCH_MX23)
> >   31. NXP i.MX28 family (ARCH_MX28)
> >   32. NXP MX7ULP (ARCH_MX7ULP)
> >   33. Freescale MX7 (ARCH_MX7)
> >   34. Freescale MX6 (ARCH_MX6)
> >   35. Freescale MX5 (ARCH_MX5)
> >   36. Nexell S5P4418/S5P6818 SoC (ARCH_NEXELL)
> >   37. Support Nuvoton SoCs (ARCH_NPCM)
> >   38. Apple SoCs (ARCH_APPLE)
> >   39. Actions Semi OWL SoCs (ARCH_OWL)
> >   40. QEMU Virtual Platform (ARCH_QEMU)
> >   41. Renesas ARM SoCs (ARCH_RENESAS)
> >   42. Qualcomm Snapdragon SoCs (ARCH_SNAPDRAGON)
> >   43. Altera SOCFPGA family (ARCH_SOCFPGA)
> >   44. Support sunxi (Allwinner) SoCs (ARCH_SUNXI)
> >   45. ST-Ericsson U8500 Series (ARCH_U8500)
> >   46. Support Xilinx Versal Platform (ARCH_VERSAL)
> >   47. Support AMD Versal Gen 2 Platform (ARCH_VERSAL2)
> >   48. Support Xilinx Versal NET Platform (ARCH_VERSAL_NET)
> >   49. Freescale Vybrid (ARCH_VF610)
> >   50. Xilinx Zynq based platform (ARCH_ZYNQ)
> >   51. Xilinx ZynqMP R5 based platform (ARCH_ZYNQMP_R5)
> >   52. Xilinx ZynqMP based platform (ARCH_ZYNQMP)
> >   53. NVIDIA Tegra (ARCH_TEGRA)
> >   54. Support ARMv8 Arm Ltd. VExpress based boards and models
> > (ARCH_VEXPRESS64)
> >   55. Support Corstone1000 Platform (TARGET_CORSTONE1000)
> >   56. Support Total Compute Platform (TARGET_TOTAL_COMPUTE)
> >   57. Support ls2080a_emu (TARGET_LS2080A_EMU)
> >   58. Support ls1088aqds (TARGET_LS1088AQDS)
> >   59. Support ls2080aqds (TARGET_LS2080AQDS)
> >   60. Support ls2080ardb (TARGET_LS2080ARDB)
> >   61. Support ls2081ardb (TARGET_LS2081ARDB)
> >   62. Support lx2160ardb (TARGET_LX2160ARDB)
> >   63. Support lx2160aqds (TARGET_LX2160AQDS)
> >   64. Support lx2162aqds (TARGET_LX2162AQDS)
> >   65. Support HiKey 96boards Consumer Edition Platform (TARGET_HIKEY)
> >   66. Support HiKey960 96boards Consumer Edition Platform (TARGET_HIKEY=
960)
> >   67. Support Poplar 96boards Enterprise Edition Platform (TARGET_POPLA=
R)
> >   68. Support ls1012aqds (TARGET_LS1012AQDS)
> >   69. Support ls1012ardb (TARGET_LS1012ARDB)
> >   70. Support ls1012a2g5rdb (TARGET_LS1012A2G5RDB)
> >   71. Support ls1012afrwy (TARGET_LS1012AFRWY)
> >   72. Support ls1012afrdm (TARGET_LS1012AFRDM)
> >   73. Support ls1028aqds (TARGET_LS1028AQDS)
> >   74. Support ls1028ardb (TARGET_LS1028ARDB)
> >   75. Support ls1088ardb (TARGET_LS1088ARDB)
> >   76. Support ls1021aqds (TARGET_LS1021AQDS)
> >   77. Support ls1021atwr (TARGET_LS1021ATWR)
> >   78. Support Hitachi-Powergrids SELI8 service unit card
> > (TARGET_PG_WCOM_SELI8)
> >   79. Support Hitachi-Powergrids EXPU1 service unit card
> > (TARGET_PG_WCOM_EXPU1)
> >   80. Support ls1021atsn (TARGET_LS1021ATSN)
> >   81. Support ls1021aiot (TARGET_LS1021AIOT)
> >   82. Support ls1043aqds (TARGET_LS1043AQDS)
> >   83. Support ls1043ardb (TARGET_LS1043ARDB)
> >   84. Support ls1046aqds (TARGET_LS1046AQDS)
> >   85. Support ls1046ardb (TARGET_LS1046ARDB)
> >   86. Support ls1046afrwy (TARGET_LS1046AFRWY)
> >   87. Analog Devices SC5XX-processor family (ARCH_SC5XX)
> >   88. Support sl28 (TARGET_SL28)
> >   89. Support ten64 (TARGET_TEN64)
> >   90. Socionext UniPhier SoCs (ARCH_UNIPHIER)
> >   91. Socionext SynQuacer SoCs (ARCH_SYNQUACER)
> >   92. Support STMicroelectronics STM32 MCU with cortex M (ARCH_STM32)
> >   93. Support STMicroelectronics SoCs (ARCH_STI)
> >   94. Support STMicroelectronics STM32MP Socs with cortex A (ARCH_STM32=
MP)
> > > 95. Support Rockchip SoCs (ARCH_ROCKCHIP)
> >   96. Support OcteonTX SoCs (ARCH_OCTEONTX)
> >   97. Support OcteonTX2 SoCs (ARCH_OCTEONTX2)
> >   98. Support ThunderX 88xx (TARGET_THUNDERX_88XX)
> >   99. Support Aspeed SoCs (ARCH_ASPEED)
> >   100. Support Phytium Durian Platform (TARGET_DURIAN)
> >   101. Support Phytium Pomelo Platform (TARGET_POMELO)
> >   102. Support Phytium PE2201 Platform (TARGET_PE2201)
> >   103. Support Cortina Presidio ASIC Platform (TARGET_PRESIDIO_ASIC)
> >   104. Xen guest ARM64 (TARGET_XENGUEST_ARM64)
> >   105. Support HPE GXP SoCs (ARCH_GXP)
> > choice[1-105?]: 95
> > Support Rockchip PX30 (ROCKCHIP_PX30) [N/y/?] n
> > Support Rockchip RK3036 (ROCKCHIP_RK3036) [N/y/?] n
> > Support Rockchip RK3066 (ROCKCHIP_RK3066) [N/y/?] n
> > Support Rockchip RK3128 (ROCKCHIP_RK3128) [N/y/?] n
> > Support Rockchip RK3188 (ROCKCHIP_RK3188) [N/y/?] n
> > Support Rockchip RK3228/RK3229 (ROCKCHIP_RK322X) [N/y/?] n
> > Support Rockchip RK3288 (ROCKCHIP_RK3288) [N/y/?] n
> > Support Rockchip RK3308 (ROCKCHIP_RK3308) [N/y/?] n
> > Support Rockchip RK3328 (ROCKCHIP_RK3328) [N/y/?] n
> > Support Rockchip RK3368 (ROCKCHIP_RK3368) [N/y/?] n
> > Support Rockchip RK3399 (ROCKCHIP_RK3399) [Y/n/?] y
> > Support Rockchip RK3506 (ROCKCHIP_RK3506) [N/y/?] n
> > Support Rockchip RK3528 (ROCKCHIP_RK3528) [N/y/?] n
> > Support Rockchip RK3568 (ROCKCHIP_RK3568) [N/y/?] n
> > Support Rockchip RK3576 (ROCKCHIP_RK3576) [N/y/?] n
> > Support Rockchip RK3588 (ROCKCHIP_RK3588) [N/y/?] n
> > Support Rockchip RV1108 (ROCKCHIP_RV1108) [N/y/?] n
> > Support Rockchip RV1126 (ROCKCHIP_RV1126) [N/y/?] n
> > Route uart output to usb pins (ROCKCHIP_USB_UART) [N/y/?] n
> > SPL returns to bootrom (SPL_ROCKCHIP_BACK_TO_BROM) [N/y/?] n
> > TPL returns to bootrom (TPL_ROCKCHIP_BACK_TO_BROM) [Y/n/?] y
> > Rockchip common board file (ROCKCHIP_COMMON_BOARD) [Y/n/?] y
> > Rockchip SPL common board file (SPL_ROCKCHIP_COMMON_BOARD) [Y/n/?] y
> > Rockchip TPL common board file (TPL_ROCKCHIP_COMMON_BOARD) [Y/n/?] y
> > Use external TPL binary (ROCKCHIP_EXTERNAL_TPL) [N/y/?] n
> > Rockchip boot mode flag register address (ROCKCHIP_BOOT_MODE_REG) [0x0]=
 0x0
> > Disable device boot on power plug-in
> > (ROCKCHIP_RK8XX_DISABLE_BOOT_ON_POWERON) [N/y/?] n
> > Rockchip STIMER support (ROCKCHIP_STIMER) [Y/n/?] y
> > Size of IRAM reserved in SPL (ROCKCHIP_SPL_RESERVE_IRAM) [0x0] 0x0
> > SPL requires early-return (for RK3188-style BROM) to BROM
> > (SPL_ROCKCHIP_EARLYRETURN_TO_BROM) [N/y/?] n
> > Disable force_jtag feature (ROCKCHIP_DISABLE_FORCE_JTAG) [Y/n/?] y
> > TPL requires early-return (for RK3188-style BROM) to BROM
> > (TPL_ROCKCHIP_EARLYRETURN_TO_BROM) [N/y/?] n
> > Build a SPI image for rockchip (ROCKCHIP_SPI_IMAGE) [Y/n/?] y
> > Build a maskrom mode image for Rockchip (ROCKCHIP_MASKROM_IMAGE) [N/y/?=
] n
> > RK3399 board select
> >   1. Asus Flip C101PA Chromebook (RK3399) (TARGET_CHROMEBOOK_BOB)
> >   2. Samsung Chromebook Plus (RK3399) (TARGET_CHROMEBOOK_KEVIN)
> >   3. RK3399 evaluation board (TARGET_EVB_RK3399)
> >   4. Pinebook Pro (TARGET_PINEBOOK_PRO_RK3399)
> >   5. PinePhone Pro (TARGET_PINEPHONE_PRO_RK3399)
> > > 6. Theobroma Systems RK3399-Q7 (Puma) (TARGET_PUMA_RK3399)
> >   7. Vamrs Limited Rock960 board family (TARGET_ROCK960_RK3399)
> >   8. Radxa ROCK Pi 4 board (TARGET_ROCKPI4_RK3399)
> >   9. Pine64 Rockpro64 board (TARGET_ROCKPRO64_RK3399)
> >   10. Firefly ROC-RK3399-PC board (TARGET_ROC_PC_RK3399)
> > choice[1-10?]: 6
> > Theobroma Systems RK3399-Q7 DDR Option
> > > 1. DDR3-1333MHz (TARGET_PUMA_RK3399_RAM_DDR3_1333)
> >   2. DDR3-1600MHz (TARGET_PUMA_RK3399_RAM_DDR3_1600)
> >   3. DDR3-1866MHz (TARGET_PUMA_RK3399_RAM_DDR3_1866)
> > choice[1-3?]: 1
> > Force cache maintenance to be exclusively by VA (CMO_BY_VA_ONLY) [N/y/?=
] n
> > Fix broken ARMv8 generic timer (ARMV8_CNTFRQ_BROKEN) [N/y/?] n
> > Install crash dump exception vectors (ARMV8_SPL_EXCEPTION_VECTORS) [N/y=
/?] n
> > Enable multiple CPUs to enter into U-Boot (ARMV8_MULTIENTRY) [N/y/?] n
> > Enable data coherency with other cores in cluster (ARMV8_SET_SMPEN) [Y/=
n/?]
> > y
> > Enable switching to running in EL1 (ARMV8_SWITCH_TO_EL1) [N/y/?] n
> > Use PSCI for reset and shutdown (PSCI_RESET) [Y/n/?] y
> > Enable PSCI support (ARMV8_PSCI) [N/y/?] n
> > External aborts and SError interrupt exception are taken in EL3
> > (ARMV8_EA_EL3_FIRST) [N/y/?] n
> > Use the event stream for udelay (ARMV8_UDELAY_EVENT_STREAM) [N/y/?] n
> > *
> > * General setup
> > *
> > Compile also drivers which will not load (COMPILE_TEST) [N/y/?] n
> > Compile U-Boot with warnings as errors (WERROR) [N/y/?] n
> > Local version - append to U-Boot release (LOCALVERSION) []
> > Automatically append version information to the version string
> > (LOCALVERSION_AUTO) [Y/n/?] y
> > Optimization level
> > > 1. Optimize for size (CC_OPTIMIZE_FOR_SIZE)
> >   2. Optimize for speed (CC_OPTIMIZE_FOR_SPEED)
> >   3. Optimize for debugging (CC_OPTIMIZE_FOR_DEBUG)
> > choice[1-3?]: 1
> > Allow compiler to uninline functions marked 'inline' in full U-Boot
> > (OPTIMIZE_INLINING) [N/y/?] n
> > Allow compiler to uninline functions marked 'inline' in SPL
> > (SPL_OPTIMIZE_INLINING) [N/y/?] n
> > Allow compiler to uninline functions marked 'inline' in TPL
> > (TPL_OPTIMIZE_INLINING) [N/y/?] n
> > Enable Link Time Optimizations (LTO) [N/y/?] n
> > Select U-Boot be run as a bootloader for XEN Virtual Machine (XEN) [N/y=
/?] n
> > Add arch, board, vendor and soc variables to default environment
> > (ENV_VARS_UBOOT_CONFIG) [Y/?] y
> > Number of DRAM banks (NR_DRAM_BANKS) [1] 1
> > Enable kernel command line setup (SYS_BOOT_GET_CMDLINE) [N/y/?] n
> > Enable kernel board information setup (SYS_BOOT_GET_KBD) [N/y/?] n
> > Use a custom location for the initial stack pointer address
> > (HAS_CUSTOM_SYS_INIT_SP_ADDR) [Y/?] y
> >   Static location for the initial stack pointer (CUSTOM_SYS_INIT_SP_ADD=
R)
> > [0x03f00000] 0x03f00000
> > Enable malloc() pool before relocation (SYS_MALLOC_F) [Y/?] y
> >   Size of malloc() pool before relocation (SYS_MALLOC_F_LEN) [0x10000]
> > 0x10000
> > Define memory for Dynamic allocation (SYS_MALLOC_LEN) [0x2000000] 0x200=
0000
> > Enable malloc() pool in SPL (SPL_SYS_MALLOC_F) [Y/n/?] y
> >   Size of malloc() pool in SPL (SPL_SYS_MALLOC_F_LEN) [0x8000] 0x8000
> > Enable malloc() pool in TPL (TPL_SYS_MALLOC_F) [Y/n/?] y
> >   Size of malloc() pool in TPL (TPL_SYS_MALLOC_F_LEN) [0x4000] 0x4000
> > Inform valgrind about memory allocations (VALGRIND) [N/y/?] n
> > 64bit physical address support (PHYS_64BIT) [Y/?] y
> > 64bit fdt address support (FDT_64BIT) [Y/?] y
> > SPL image used in the combined SPL+U-Boot image (SPL_IMAGE)
> > [spl/u-boot-spl.bin] spl/u-boot-spl.bin
> > Recreate an ELF image from raw U-Boot binary (REMAKE_ELF) [N/y/?] n
> > Build target special images (BUILD_TARGET) []
> > Define a maximum size for the U-Boot image (HAS_BOARD_SIZE_LIMIT) [N/y/=
?] n
> > Use a custom location for the U-Boot linker script (SYS_CUSTOM_LDSCRIPT=
)
> > [N/y/?] n
> > Address in memory to use by default (SYS_LOAD_ADDR) [0x800800] 0x800800
> > Define max stack size that can be used by U-Boot (STACK_SIZE) [0x100000=
0]
> > 0x1000000
> > Exclude some memory from U-Boot / OS information (SYS_MEM_TOP_HIDE) [0x=
0]
> > 0x0
> > Maximum size in bytes reserved for U-Boot in memory (SYS_MONITOR_LEN) [=
0] 0
> > Support for multiprocessor (MP) [N/y/?] n
> > Text Base (TEXT_BASE) [0x00800000] 0x00800000
> > Use custom U-Boot Start (HAVE_SYS_UBOOT_START) [N/y/?] n
> > Determine CPU clock frequency at run-time (DYNAMIC_SYS_CLK_FREQ) [N/y/?=
] n
> > CPU clock frequency (SYS_CLK_FREQ) [0] 0
> > Enable U-Boot API (API) [N/y/?] (NEW)
> >
> > Then it continues with the build, but using the flags for clang while u=
sing
> > GCC, see:
> >
> > make -f /home/qschulz/work/upstream/u-boot/scripts/Makefile.autoconf ||=
 \
> >       { rm -f include/config/auto.conf; false; }
> > mkdir -p include/asm
> > if [ -d /home/qschulz/work/upstream/u-boot/arch/arm/mach-rk3399/include=
/mach
> > ]; then       \
> >       dest=3Darch/arm/mach-rk3399/include/mach;                 \
> > else                                                                  \
> >       dest=3Darch/arm/include/asm/arch-rk3399;  \
> > fi;                                                                   \
> > ln -fsn /home/qschulz/work/upstream/u-boot/$dest include/asm/arch
> > set -e; mkdir -p include/; trap "rm -f include/.config.h.tmp" EXIT; { (=
echo
> > "/* Automatically generated - do not edit */"; echo \#define CFG_BOARDD=
IR
> > board/theobroma-systems/puma_rk3399; echo \#include
> > \<configs/"puma_rk3399".h\> ; echo \#include \<asm/config.h\>; echo
> > \#include \<linux/kconfig.h\>; echo \#include \<config_fallbacks.h\>;);=
 } >
> > include/.config.h.tmp; if [ ! -r include/config.h ] || ! cmp -s
> > include/config.h include/.config.h.tmp; then : '  UPD include/config.h'=
; mv
> > -f include/.config.h.tmp include/config.h; fi
> >   aarch64-linux-gnu-gcc -E -Wall -Werror=3Dstrict-prototypes -Wno-trigr=
aphs
> > -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE
> > -Werror=3Dimplicit-function-declaration -Werror=3Dimplicit-int
> > -Wno-format-security -std=3Dgnu11  -ffreestanding -fno-builtin
> > -fno-delete-null-pointer-checks -Wno-frame-address -Wno-format-truncati=
on
> > -Wno-format-overflow -Wno-int-in-bool-context -Wno-address-of-packed-me=
mber
> > -Os -fno-stack-protector -fno-delete-null-pointer-checks
> > -Wno-zero-length-bounds -Wno-array-bounds -Wno-stringop-overflow
> > -Wno-maybe-uninitialized
> > -fmacro-prefix-map=3D/home/qschulz/work/upstream/u-boot/=3D -gdwarf-4
> > -fstack-usage -Wno-format-nonliteral -Wno-address-of-packed-member
> > -Wno-format-invalid-specifier -Wno-gnu -Wno-tautological-compare
> > -mno-global-merge -Wno-pointer-sign -D__KERNEL__ -D__UBOOT__
> > -Qunused-arguments -D__ARM__        -ffunction-sections -fdata-sections
> > -fno-common -ffixed-x18   -pipe -Iinclude
> > -I/home/qschulz/work/upstream/u-boot/include
> > -I/home/qschulz/work/upstream/u-boot/arch/arm/include -include
> > /home/qschulz/work/upstream/u-boot/include/linux/kconfig.h -nostdinc
> > -isystem /usr/lib/gcc/aarch64-linux-gnu/15/include  -DDO_DEPS_ONLY -dM
> > include/config.h > u-boot.cfg.tmp && { grep 'define CONFIG_' u-boot.cfg=
.tmp
> > | sed '/define CONFIG_IS_ENABLED(/d;/define CONFIG_IF_ENABLED_INT(/d;/d=
efine
> > CONFIG_VAL(/d;' > u-boot.cfg; rm u-boot.cfg.tmp; } || { rm u-boot.cfg.t=
mp;
> > false; }
> > aarch64-linux-gnu-gcc: error: unrecognized command-line option
> > =E2=80=98-mno-global-merge=E2=80=99; did you mean =E2=80=98-Wno-global-=
module=E2=80=99?
> > aarch64-linux-gnu-gcc: error: unrecognized command-line option
> > =E2=80=98-Qunused-arguments=E2=80=99
> > make[2]: ***
> > [/home/qschulz/work/upstream/u-boot/scripts/Makefile.autoconf:84:
> > u-boot.cfg] Error 1
> > make[1]: *** No rule to make target 'include/config/auto.conf', needed =
by
> > 'include/config/uboot.release'.  Stop.
> > make: *** [Makefile:189: __sub-make] Error 2
> >
> > If I do nothing but call
> > make CROSS_COMPILE=3D"aarch64-linux-gnu-" O=3Dbuild/puma V=3D1
> > again, it'll work just fine and compile with GCC flags with the GCC
> > toolchain (well, I don't get an error anymore, so I'm assumign that wha=
t's
> > happening :) ). So it seems to me that the symbols as used in Makefile
> > depend on the previous make command generating the .config and syncconf=
ig is
> > running "too late".
> >
> > Contrary to what I initially thought, it's not actually related to U-Bo=
ot
> > host tools.
> >
> > I'm not attempting to mix GCC and clang for host/target building, and I
> > don't know if this would work in any case. I don't know if this is some=
thing
> > we want to support anyway. As for what the Linux kernel does, they
> > document[1] LLVM/clang support by telling the user to essentially use L=
LVM=3D1
> > which they claim is an alias to:
> > CC=3Dclang LD=3Dld.lld AR=3Dllvm-ar NM=3Dllvm-nm STRIP=3Dllvm-strip \
> >   OBJCOPY=3Dllvm-objcopy OBJDUMP=3Dllvm-objdump READELF=3Dllvm-readelf =
\
> >   HOSTCC=3Dclang HOSTCXX=3Dclang++ HOSTAR=3Dllvm-ar HOSTLD=3Dld.lld
> >
> > They don't really hint at CC and HOSTCC being different as being an opt=
ion.
> > Maybe it works, maybe it doesn't?
> >
> > I did test in the Linux kernel whether they had the same issue but it
> > doesn't seem like it is the case.
> >
> > [1] https://www.kernel.org/doc/html/latest/kbuild/llvm.html
>
> Ah, thanks. I'm tempted to say this is something that'll just not work
> until we can also switch to following the kernel way of invoking clang?
> But maybe it's a problem missing dependencies somewhere (not leading to
> some cmd file being recreated in time), rather than more missing
> changes.

The root cause is likely a stale KBUILD_CFLAGS leaking into
Makefile.autoconf sub-make.

The U-Boot-specific recipe at Makefile:813 runs two steps when
'auto.conf' is stale:

1. 'make syncconfig' - regenerates 'auto.conf' (e.g. flips
CC_IS_CLANG=3Dy to CC_IS_GCC=3Dy after a toolchain change).
2. 'make -f scripts/Makefile.autoconf' - preprocesses
'include/config.h' to produce u-boot.cfg/autoconf.mk

KBUILD_CFLAGS and KBUILD_CPPFLAGS are exported by the parent (line
576) and consumed by scripts/Makefile.autoconf:45:

    c_flags :=3D $(KBUILD_CFLAGS) $(KBUILD_CPPFLAGS) ...

The parent computes those at parse time from the stale 'auto.conf', so
step 2's sub-make inherits clang-only flags ('-mno-global-merge',
'-Qunused-arguments', ...) and feeds them to gcc, fails. The recipe
deletes 'auto.conf' and aborts, so GNU make's makefile-restart never
runs. A second 'make' succeeds because 'auto.conf' is already fresh on
disk before parsing.

Linux doesn't hit this: its auto.conf rule only runs 'syncconfig' and
lets make re-exec. Basically Makefile.autoconf is a old bridge for the
include/configs -> Kconfig migration.

We should stop leaking parent parse-time CFLAGS into
'Makefile.autoconf'. That helper only does 'cpp -dM' on 'config.h' and
needs UBOOTINCLUDE, PLATFORM_CPPFLAGS, '-D__KERNEL__', etc. - not
warning/codegen flags. Either 'unexport KBUILD_CFLAGS KBUILD_CPPFLAGS'
for that sub-make, or reset them inside 'Makefile.autoconf' after
'include config.mk' and rebuild only the cpp pieces it actually needs.

This also explains Quentin's hunch about 'u-boot-initial-env': any
target that triggers the auto.conf recipe runs 'Makefile.autoconf'
with the parent's stale env, regardless of which target was asked for.

Something like this before the CC =3D in Makefile.autoconf:

# Discard KBUILD_CFLAGS/KBUILD_CPPFLAGS inherited from the parent make.
# They were computed at the parent's parse time from a possibly-stale
# auto.conf (e.g. before syncconfig detected a toolchain change), so
# CC_IS_CLANG-guarded flags can leak across a clang->gcc switch and
# break the cpp -dM below.  Warning/codegen flags do not affect cpp
# -dM output, so only the base preprocessor defines and CLANG_FLAGS
# (--target=3D, --gcc-toolchain=3D, ...) need to be preserved here.
KBUILD_CFLAGS   :=3D $(CLANG_FLAGS)
KBUILD_CPPFLAGS :=3D -D__KERNEL__ -D__UBOOT__ $(CLANG_FLAGS)

CLANG_FLAGS must stay otherwise cross-compile clang builds break:
without '--target=3Daarch64-linux-gnu' clang falls back to the host
triple and rejects arch-specific flags from PLATFORM_CPPFLAGS like
'-ffixed-x18' (arch/arm/config.mk).

Regards,
Simon
