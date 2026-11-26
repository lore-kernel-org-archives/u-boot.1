Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58848606A33F
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 12:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vXSW/Cih;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ru9161pY
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BEB9F40926;
	Thu, 26 Nov 2026 12:48:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BU1Vca9nX7DN; Thu, 26 Nov 2026 12:48:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 45AA94091B
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795697337;
	b=qgQleaoGj7At1gkX7l16AopSgYxoJgjBQ7SoWSkHn3P5h7Up2evRx4zaO+awZ5SgsX7F
	 +GMDy/BLTLrMzWbcMQIP3wFvKM+X59EA1iMOgpO/PwURPhbtL9B+1DFlRUsNchT3VgBls
	 siVrDE8F4l4ETqENEEoMr72YLbEr4lP4xihzrWZo5Yk7cYHKTppfvVugLAlsKHQlo8ths
	 eMKylxCG/R5+kxhWciM+X+OhH913KDuq2+QZY/zacjgUauAt/S3xZAUA273NdDdEwnFmB
	 3Yh6Jg2Zo8p7g3cd6wrZGvE0wuqwE8PkBXFKMJrKj5WWyvHohzPnvQ/hX7CaKl+GfIA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795697337;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=91nBtazU4LDkcclaYZTdbTva+lxuq/CHid0l9wYyf/8=;
	b=jskwfKr6uvr9VccD3S+5LfSxH+1q44f1GmBPLuulP5wRcGNHzHt7sV+k22JH8fBaRv9V
	 5vMlfxPPSrlX1LF2IY859O8mdCcmic0ER+rg2mG8KRgDPdziPTmPFE0vg0CdukJRw0qsx
	 9BHc+GpftWbCc0t5ETlKt2DIE55Gqxkl1KKpF7VvRXTwYk/CRAz5OVhpQPKTe9m44fO9x
	 WRU1cY0irgN5Tjw90VYK7SFSpLKEc+pLj9DryyCnF6xK913GiaCXrx2eXWNWvDoPvi4lx
	 UBDHgN8ZNhMbnOTKeEcZWew81H1ThKtkaQg1l2e4ngpC6bjtFJeoC533GAg/WVQN+2A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ru9161pY;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795697337;
	bh=91nBtazU4LDkcclaYZTdbTva+lxuq/CHid0l9wYyf/8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vXSW/CihdG9g8X+d6VVbSz82ynfpLmf/560PwbcngWaWiOEGEPnWHoDza106o9DgP
	 IjpXU6CqcxEi1z63KWNtjHue2O0pCmMUA1G9ucIg3gic2eWcYFjDwaY29eVoh+ufgP
	 cH+WyePXHfj/bNV2CpM5GsKX8SbaA5LHJXqU69Pz9E7ez09HvqYHkpHa2rKjVQcs77
	 Rt8Hfo32fb6iu6AJLOBZOmJmjg4Jpr6qtuTuNNvWvHOYaCkbSIrWusoWZgPn+gpWiz
	 VIse0GiVgHZVu8zyt5XQ0yYdmTM9DtTxANg8hHtCMDipyR4IF/vGKX+LtsvjK9PZDh
	 brBuCONC3gOXA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 45AA94091B;
	Thu, 26 Nov 2026 12:48:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D48B2325
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 12:48:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C601E4091B
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 12:48:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xRJcSl2D4ahh for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 12:48:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1969C40919
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::f2a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f2a; helo=mail-qv1-xf2a.google.com;
 envelope-from=pbrobinson@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=Ru9161pY
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1969C40919
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 12:48:53 +0000 (UTC)
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-921318b2eb8so86659446d6.1
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 04:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795697332; x=1796302132;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=91nBtazU4LDkcclaYZTdbTva+lxuq/CHid0l9wYyf/8=;
 b=Ru9161pYiuxlULsqQlRY052UcflBxkFzbKMFhpXOEtjzK0L55x/QApVOVcfnIpOk+t
 g2aSUdKGSgsRuElpyeZ4ZF/66bkK1t0j/RNc8PC74O2Bj8OBvSkuWLg2b7YpIP6IT15M
 jgFfTxeH3kBHi/tdyT/5fiGALWSFbPme9Dezv6YAn7QOtM9N6t1Qc7dRAYJ2Q0NLqiu4
 aqNi9o+nUJxPhzAy7H1vQ5Rnnxb0Lss4FadYRStEkENhF8FOANx5F48lD7AmQMbiq+SV
 31KKk29ANpVkeRbN4EmhDZX6eWOXmFK5GY8QX7g4n+EG1h1zCSW9WW0E+7GolTmlBWFQ
 Kwkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795697332; x=1796302132;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=91nBtazU4LDkcclaYZTdbTva+lxuq/CHid0l9wYyf/8=;
 b=gxa3dhDBvibCh0fHgRdEtJCWdMVxmIhDc7tQwX+26geMJuRM0srX8edwIX4ONftGp6
 ZFoBdBzwdp0PgRxAPVUi7/Z17dCbY4xGRgFF/y38BTa2W/6jRiMx2nFYHVG6W2h+M8bQ
 kTirVKOlBmkXV0TtUq799D3RUyO7fvHQnE00WshANcBn0xs+cSJMs8BVzE1DEWF8PI17
 ARmFLNuxsH8ubQCNVUUm+Jy5zxoAphyzaAojkX5zgyNitp8REoUrM0F81JHmihoCY2J2
 nwGoW/WpapjbSsfy8twkIn5ZYXAVndILiAJwmvlREeq75gGE3lEaIeJucXaLxR49yANA
 GUPw==
X-Forwarded-Encrypted: i=1;
 AL+hErEPKBHUstkKHOHgrikMhIMzS41P916P/MuUvvuX2ymrNgGpbDIoFAfoBt86cSM4+HAmssZOaK0=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/yw5kGUyUFngYH7OJllEUR7aFHTeOkLUS7vvj4clr0YFDQaYQ1
 pGv231rJzubPccL7lrYbGz0V7GotHigUixfyfEsREo/FDb2qDKxvZQ1f6HtlNF+ZwEsSPgGPa1s
 3Z70EyjU/HIbX3tQnEiZboceTaN/Cx+I=
X-Gm-Gg: AZFdTZe+xUMYEEN7Y+ATAcyKX+Ummr0fnFr/iHFCaFo/4zDtZk6ApAHIjSHJCEiiRSD
 0B40+6l+gzUfeAvkq/XP6tEJ0BfcOtORDJMB6X7tGHT2LnOe1X65Kd1VwCiywvr/N2Gow4CGDMF
 90AeSGMhLJHmwrGvMrFSBen4yOUYwQvV0knBXLwDIXrHr76/NnoFiN4+6ylANbz3BCfdM8ny3Bv
 objgsNempjWHLRVD9oz0eOWno/WMtzIo5zxVuKkf2OmaaRomBMXlX6KagFLL/YyLU1Bc4367986
 hfc8JHwLZ35cZZiE0pTKpQb20kctihf0BDSbWnoJjR5Jmz9K3Cmvhot2GTkYSjR1/fjrU3qt23t
 9wihywlJJxyBstzy6LWJWPS/hkF3rTL3P1I7FDhpTlrACsG2+0VFkFsRUY4Xcot/lcJSy7tZmEg
 qHbM3M1ONDq/CnjOByFTiLutUVPUqbvXvxRRmbv9616bzSJZ3SivmEO4I1k7+KEsn2h/Jz/a5K/
 g3Y21+qMvK/gHNOv0E3pY8oq1dsnnKX+08=
X-Received: by 2002:a05:6214:d84:b0:921:3446:7a2e with SMTP id
 6a1803df08f44-92134a39cabmr379443756d6.16.1795697332254; Thu, 26 Nov 2026
 04:48:52 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261125074122.1965495-1-ilias.apalodimas@linaro.org>
 <20261125074122.1965495-2-ilias.apalodimas@linaro.org>
 <3a263d76-c2fc-4e15-9f2c-7795bb27a6e0@cherry.de>
In-Reply-To: <3a263d76-c2fc-4e15-9f2c-7795bb27a6e0@cherry.de>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 26 Nov 2026 12:48:39 +0000
X-Gm-Features: Aa3M54rqFQNabDF5OrF-FE5eI9z4XPGQJdPxl-923UeVRzuIMJokLMK_fNVo3p0
Message-ID: <CALeDE9NaEmTqxPebzYWYcyT4sYq=s+PCet0mPKuRAUtKZG3CXQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: Add RELR relocs
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, trini@konsulko.com, 
 richard.henderson@linaro.org, casey.connolly@linaro.org, 
 u-boot@lists.u-boot-project.org
Content-Type: multipart/alternative; boundary="0000000000009cfde406612d5db6"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--0000000000009cfde406612d5db6
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Nov 2026 at 17:20, Quentin Schulz <quentin.schulz@cherry.de>
wrote:

> Hi Ilias,
>
> On 11/25/26 8:41 AM, Ilias Apalodimas wrote:
> > Linking U-Boot with -pie emits an R_AARCH64_RELATIVE entry for every
> > pointer that needs fixing up. Each Elf64_Rela entry is 24 bytes, so the
> > .rela.dyn section ends up being quite large.
> >
> > Modern toolchains support packing relative relocations in RELR format
> > via '-z pack-relative-relocs'. Instead of offset/info/addend tuples,
> > RELR stores a stream of 64-bit words. An even word is the link-time
> > address of a word to relocate and an odd word is a bitmap describing
> > which of the 63 words following the previous address need relocating.
> > The addend is the value already stored in the place.
> >
> > Compiling for QEMU with RELA vs RELR looks something like this:
> >
> > $~ readelf -SW u-boot  | grep relr
> > [ 9] .relr.dyn         RELR            000000000016f970 170970 000960
> 08   A  0   0  8
> > $~ readelf -SW u-boot.old  | grep rela
> > [ 7] .rela.dyn         RELA            0000000000115110 116110 0184f8
> 18   A  0   0  8
> >
> > which is ~98% decrease in the space reloc entries need.
> >
> > So let's add a Kconfig option and teach U-Boot RELR.
> > - pass '-z pack-relative-relocs' to the linker and add .relr.dyn
> >    in the linker script and the objcopy'ed binary. relr.dyn is still
> >    overlayed by .bss
> > - skip checkarmreloc, since we now expect R_AARCH64_RELATIVE entries
> >    to be packed in .rel*.dyn and older tools don't decode them
> >    properly
> > - process .relr.dyn in pie_fixup. It's worth noting that efi runtime
> >    relocs, due to how ld emits RELR, are now packed in .relr.dyn and
> >    efi_runtime_relocate() doesn't have to relocate anything.
> >    A sideeffect is that we can't support  SetVirtualAddressMap and
> ConvertPointer
> >    for EFI, but some architectures are already ommitting this call
> >    (e.g Linux on arm64, openBSD doesn't call it at all). [0]
> > - process .relr.dyn in relocate_code(). Note that the places are
> >    link-time addresses, so we still need the link-to-copy offset to find
> >    them, but the stored value has already been shifted to the run address
> >    by pie_fixup, so it needs to be adjusted by the run-to-copy offset
> >
> > [0] EFI runtime services relocate themselves when the OS calls
> > SetVirtualAddressMap, using the relocations between
> > __efi_runtime_rel_start and __efi_runtime_rel_stop. Those are collected
> > by the linker script from the .rela sections of the runtime code.
> > RELR packing, however, is done by the linker as a last step and all
> > relative relocations end up in a single .relr.dyn section for the entire
> > image. There's no way to emit an equivalent __efi_runtime_relr_start
> > marker for the runtime region, or emit RELA relocations for the EFI
> > runtime, so stop advertising SetVirtualAddressMap and ConvertPointer
> > in the EFI_RT_PROPERTIES_TABLE when RELR is enabled.
> >
>
> 6.4% size reduction for u-boot.itb with RELR enabled on
> tiger-rk3588_defconfig.
>
> $ aarch64-linux-gnu-ld --version
> GNU ld version 2.47.20260726
>
> from Fedora 45.
>
> I reached U-Boot proper CLI, which I have been told is sufficient to
> test this series, so:
>

I agree with enabling this by default, it should be opt out if there's
issues.

Looking at various default toolchains across distros (thanks Claude) Ubuntu
22.04 LTS has gcc11/binutils 2.38, RHEL 9 is gcc11/binutils 2.35.2, Debian
12 is gcc12.2/binutils 2.40

All have options for later versions so I think we should be fine to enable
by default and error if the toolchain isn't new enough. The reality is a
lot of users will be using old U-Boot if they're on ancient distros anyway.


> Tested-by: Quentin Schulz <quentin.schulz@cherry.de> # RK3588 Tiger
>
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> >   Kconfig                        | 14 +++++++++++++
> >   arch/arm/config.mk             | 10 +++++++--
> >   arch/arm/cpu/armv8/start.S     | 38 ++++++++++++++++++++++++++++++++++
> >   arch/arm/cpu/armv8/u-boot.lds  |  9 ++++++++
> >   arch/arm/lib/relocate_64.c     | 28 +++++++++++++++++++++++++
> >   include/asm-generic/sections.h |  3 +++
> >   lib/efi_loader/efi_runtime.c   |  9 +++++---
> >   7 files changed, 106 insertions(+), 5 deletions(-)
> >
> > diff --git a/Kconfig b/Kconfig
> > index c8cfbf5d5de2..ebe7b30d7b78 100644
> > --- a/Kconfig
> > +++ b/Kconfig
> > @@ -40,6 +40,20 @@ config COMPILE_TEST
> >         here. If you are a user/distributor, say N here to exclude
> useless
> >         drivers to be distributed.
> >
> > +config RELR
> > +     bool "Use RELR packed relative relocations"
> > +     depends on ARM64
> > +     help
> > +       RELR stores relative relocations as a stream of 64-bit words: an
> > +       even word is the link-time address of a word to relocate, and an
> > +       odd word is a bitmap covering the 63 words that follow the
> previous
> > +       address. This usually leads to ~95% compression of emitted
> relocation
> > +       entries.
> > +       Due to the placement of the .relr.dyn section and the way ld
> > +       creates it we cannot currently relocate EFI functions at runtime.
> > +       SetVirtualAddressMap and ConvertPointer for EFI are marked as
> > +       unsupported.
> > +
> >   config WERROR
> >       bool "Compile U-Boot with warnings as errors"
> >       default COMPILE_TEST
> > diff --git a/arch/arm/config.mk b/arch/arm/config.mk
> > index bce9a31e966b..ad73f728f7a2 100644
> > --- a/arch/arm/config.mk
> > +++ b/arch/arm/config.mk
> > @@ -111,6 +111,9 @@ endif
> >
> >   # needed for relocation
> >   LDFLAGS_u-boot += -pie
> > +ifeq ($(CONFIG_RELR),y)
> > +LDFLAGS_u-boot += -z pack-relative-relocs
> > +endif
> >
>
> suggestion: make this transparent to the user
>
> We've talked about this in private but wanted to put it in writing so
> it's available on the mailing list archive. I think it makes more sense
> to always enable the option (if it's safe!), if the linker supports it.
> According to
> https://rfc.archlinux.page/0023-pack-relative-relocs/#motivation, that
> is GNU ld 2.36 and LLVM 15. We can use the same mechanism as in the
> kernel, c.f. CC_HAS_UBSAN_BOUNDS_STRICT with def_bool
> $(cc-option,-fsanitize=bounds-strict).
>
> What I don't like about it is that if it's default off, nobody will turn
> it on. If it's on and we force the option like in this patch, then
> builds will fail on older toolchains. I bet most people don't know where
> to get a newer toolchain than the one they have from their distro, or
> how to install it so lots of headaches for people I guess. If we stay
> with this solution here, is there a way to tell the user how to fix it
> (either via a Make message, or at least a comment next to the places
> where we set the flag?)
>
> Cheers,
> Quentin
>

--0000000000009cfde406612d5db6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, 25 Nov =
2026 at 17:20, Quentin Schulz &lt;<a href=3D"mailto:quentin.schulz@cherry.d=
e">quentin.schulz@cherry.de</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">Hi Ilias,<br>
<br>
On 11/25/26 8:41 AM, Ilias Apalodimas wrote:<br>
&gt; Linking U-Boot with -pie emits an R_AARCH64_RELATIVE entry for every<b=
r>
&gt; pointer that needs fixing up. Each Elf64_Rela entry is 24 bytes, so th=
e<br>
&gt; .rela.dyn section ends up being quite large.<br>
&gt; <br>
&gt; Modern toolchains support packing relative relocations in RELR format<=
br>
&gt; via &#39;-z pack-relative-relocs&#39;. Instead of offset/info/addend t=
uples,<br>
&gt; RELR stores a stream of 64-bit words. An even word is the link-time<br=
>
&gt; address of a word to relocate and an odd word is a bitmap describing<b=
r>
&gt; which of the 63 words following the previous address need relocating.<=
br>
&gt; The addend is the value already stored in the place.<br>
&gt; <br>
&gt; Compiling for QEMU with RELA vs RELR looks something like this:<br>
&gt; <br>
&gt; $~ readelf -SW u-boot=C2=A0 | grep relr<br>
&gt; [ 9] .relr.dyn=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RELR=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 000000000016f970 170970 000960 08=C2=A0 =C2=A0A=C2=
=A0 0=C2=A0 =C2=A00=C2=A0 8<br>
&gt; $~ readelf -SW u-boot.old=C2=A0 | grep rela<br>
&gt; [ 7] .rela.dyn=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RELA=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 0000000000115110 116110 0184f8 18=C2=A0 =C2=A0A=C2=
=A0 0=C2=A0 =C2=A00=C2=A0 8<br>
&gt; <br>
&gt; which is ~98% decrease in the space reloc entries need.<br>
&gt; <br>
&gt; So let&#39;s add a Kconfig option and teach U-Boot RELR.<br>
&gt; - pass &#39;-z pack-relative-relocs&#39; to the linker and add .relr.d=
yn<br>
&gt;=C2=A0 =C2=A0 in the linker script and the objcopy&#39;ed binary. relr.=
dyn is still<br>
&gt;=C2=A0 =C2=A0 overlayed by .bss<br>
&gt; - skip checkarmreloc, since we now expect R_AARCH64_RELATIVE entries<b=
r>
&gt;=C2=A0 =C2=A0 to be packed in .rel*.dyn and older tools don&#39;t decod=
e them<br>
&gt;=C2=A0 =C2=A0 properly<br>
&gt; - process .relr.dyn in pie_fixup. It&#39;s worth noting that efi runti=
me<br>
&gt;=C2=A0 =C2=A0 relocs, due to how ld emits RELR, are now packed in .relr=
.dyn and<br>
&gt;=C2=A0 =C2=A0 efi_runtime_relocate() doesn&#39;t have to relocate anyth=
ing.<br>
&gt;=C2=A0 =C2=A0 A sideeffect is that we can&#39;t support=C2=A0 SetVirtua=
lAddressMap and ConvertPointer<br>
&gt;=C2=A0 =C2=A0 for EFI, but some architectures are already ommitting thi=
s call<br>
&gt;=C2=A0 =C2=A0 (e.g Linux on arm64, openBSD doesn&#39;t call it at all).=
 [0]<br>
&gt; - process .relr.dyn in relocate_code(). Note that the places are<br>
&gt;=C2=A0 =C2=A0 link-time addresses, so we still need the link-to-copy of=
fset to find<br>
&gt;=C2=A0 =C2=A0 them, but the stored value has already been shifted to th=
e run address<br>
&gt;=C2=A0 =C2=A0 by pie_fixup, so it needs to be adjusted by the run-to-co=
py offset<br>
&gt; <br>
&gt; [0] EFI runtime services relocate themselves when the OS calls<br>
&gt; SetVirtualAddressMap, using the relocations between<br>
&gt; __efi_runtime_rel_start and __efi_runtime_rel_stop. Those are collecte=
d<br>
&gt; by the linker script from the .rela sections of the runtime code.<br>
&gt; RELR packing, however, is done by the linker as a last step and all<br=
>
&gt; relative relocations end up in a single .relr.dyn section for the enti=
re<br>
&gt; image. There&#39;s no way to emit an equivalent __efi_runtime_relr_sta=
rt<br>
&gt; marker for the runtime region, or emit RELA relocations for the EFI<br=
>
&gt; runtime, so stop advertising SetVirtualAddressMap and ConvertPointer<b=
r>
&gt; in the EFI_RT_PROPERTIES_TABLE when RELR is enabled.<br>
&gt; <br>
<br>
6.4% size reduction for u-boot.itb with RELR enabled on <br>
tiger-rk3588_defconfig.<br>
<br>
$ aarch64-linux-gnu-ld --version<br>
GNU ld version 2.47.20260726<br>
<br>
from Fedora 45.<br>
<br>
I reached U-Boot proper CLI, which I have been told is sufficient to <br>
test this series, so:<br></blockquote><div><br></div><div>I agree with enab=
ling this by default, it should be opt out if there&#39;s issues.</div><div=
><br></div><div>Looking at various default toolchains across distros (thank=
s Claude)=C2=A0Ubuntu 22.04 LTS has gcc11/binutils 2.38, RHEL 9 is gcc11/bi=
nutils 2.35.2, Debian 12 is gcc12.2/binutils 2.40=C2=A0</div><div><br></div=
><div>All have options for later versions so I think we should be fine to e=
nable by default and error if the toolchain isn&#39;t new enough. The reali=
ty is a lot of users will be using old U-Boot if they&#39;re on ancient dis=
tros anyway.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
Tested-by: Quentin Schulz &lt;<a href=3D"mailto:quentin.schulz@cherry.de" t=
arget=3D"_blank">quentin.schulz@cherry.de</a>&gt; # RK3588 Tiger<br>
<br>
&gt; Signed-off-by: Ilias Apalodimas &lt;<a href=3D"mailto:ilias.apalodimas=
@linaro.org" target=3D"_blank">ilias.apalodimas@linaro.org</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 14 +++++++++++++<br>
&gt;=C2=A0 =C2=A0arch/arm/<a href=3D"http://config.mk" rel=3D"noreferrer" t=
arget=3D"_blank">config.mk</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 10 +++++++--<br>
&gt;=C2=A0 =C2=A0arch/arm/cpu/armv8/start.S=C2=A0 =C2=A0 =C2=A0| 38 +++++++=
+++++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0arch/arm/cpu/armv8/u-boot.lds=C2=A0 |=C2=A0 9 ++++++++<br>
&gt;=C2=A0 =C2=A0arch/arm/lib/relocate_64.c=C2=A0 =C2=A0 =C2=A0| 28 +++++++=
++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0include/asm-generic/sections.h |=C2=A0 3 +++<br>
&gt;=C2=A0 =C2=A0lib/efi_loader/efi_runtime.c=C2=A0 =C2=A0|=C2=A0 9 +++++--=
-<br>
&gt;=C2=A0 =C2=A07 files changed, 106 insertions(+), 5 deletions(-)<br>
&gt; <br>
&gt; diff --git a/Kconfig b/Kconfig<br>
&gt; index c8cfbf5d5de2..ebe7b30d7b78 100644<br>
&gt; --- a/Kconfig<br>
&gt; +++ b/Kconfig<br>
&gt; @@ -40,6 +40,20 @@ config COMPILE_TEST<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0here. If you are a user/distributor, =
say N here to exclude useless<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0drivers to be distributed.<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +config RELR<br>
&gt; +=C2=A0 =C2=A0 =C2=A0bool &quot;Use RELR packed relative relocations&q=
uot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0depends on ARM64<br>
&gt; +=C2=A0 =C2=A0 =C2=A0help<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0RELR stores relative relocations as a stre=
am of 64-bit words: an<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0even word is the link-time address of a wo=
rd to relocate, and an<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0odd word is a bitmap covering the 63 words=
 that follow the previous<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0address. This usually leads to ~95% compre=
ssion of emitted relocation<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0entries.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0Due to the placement of the .relr.dyn sect=
ion and the way ld<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0creates it we cannot currently relocate EF=
I functions at runtime.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0SetVirtualAddressMap and ConvertPointer fo=
r EFI are marked as<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0unsupported.<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0config WERROR<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool &quot;Compile U-Boot with warnings as e=
rrors&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0default COMPILE_TEST<br>
&gt; diff --git a/arch/arm/<a href=3D"http://config.mk" rel=3D"noreferrer" =
target=3D"_blank">config.mk</a> b/arch/arm/<a href=3D"http://config.mk" rel=
=3D"noreferrer" target=3D"_blank">config.mk</a><br>
&gt; index bce9a31e966b..ad73f728f7a2 100644<br>
&gt; --- a/arch/arm/<a href=3D"http://config.mk" rel=3D"noreferrer" target=
=3D"_blank">config.mk</a><br>
&gt; +++ b/arch/arm/<a href=3D"http://config.mk" rel=3D"noreferrer" target=
=3D"_blank">config.mk</a><br>
&gt; @@ -111,6 +111,9 @@ endif<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0# needed for relocation<br>
&gt;=C2=A0 =C2=A0LDFLAGS_u-boot +=3D -pie<br>
&gt; +ifeq ($(CONFIG_RELR),y)<br>
&gt; +LDFLAGS_u-boot +=3D -z pack-relative-relocs<br>
&gt; +endif<br>
&gt;=C2=A0 =C2=A0<br>
<br>
suggestion: make this transparent to the user<br>
<br>
We&#39;ve talked about this in private but wanted to put it in writing so <=
br>
it&#39;s available on the mailing list archive. I think it makes more sense=
 <br>
to always enable the option (if it&#39;s safe!), if the linker supports it.=
 <br>
According to <br>
<a href=3D"https://rfc.archlinux.page/0023-pack-relative-relocs/#motivation=
" rel=3D"noreferrer" target=3D"_blank">https://rfc.archlinux.page/0023-pack=
-relative-relocs/#motivation</a>, that <br>
is GNU ld 2.36 and LLVM 15. We can use the same mechanism as in the <br>
kernel, c.f. CC_HAS_UBSAN_BOUNDS_STRICT with def_bool <br>
$(cc-option,-fsanitize=3Dbounds-strict).<br>
<br>
What I don&#39;t like about it is that if it&#39;s default off, nobody will=
 turn <br>
it on. If it&#39;s on and we force the option like in this patch, then <br>
builds will fail on older toolchains. I bet most people don&#39;t know wher=
e <br>
to get a newer toolchain than the one they have from their distro, or <br>
how to install it so lots of headaches for people I guess. If we stay <br>
with this solution here, is there a way to tell the user how to fix it <br>
(either via a Make message, or at least a comment next to the places <br>
where we set the flag?)<br>
<br>
Cheers,<br>
Quentin<br>
</blockquote></div></div>

--0000000000009cfde406612d5db6--
