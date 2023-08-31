Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67B1AC83F33
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 12:28:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F6948657F;
	Thu, 31 Aug 2023 14:28:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Q1vNqyif";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE2FA8657F; Thu, 31 Aug 2023 14:28:51 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D592D86579
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 14:28:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ardb@kernel.org
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 2149462796
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 12:28:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A0F4C433C7
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 12:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1693484926;
 bh=Vyak1dTXZ6H1ELH2V6tR0Berxj+Mh0hnmpnrgiYOi4A=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Q1vNqyifUgY4lrK/jaUT18rHZBA7ZouBEtmNsHQrf/SAjjjQuQjLXKbwAsxSI9u/p
 666GulrypEJKTm7gSCZINhrAB2IQXEZTDf4ln8oQ367RsqpBnuzXgU0TQT1r2zYCed
 uUnPgTwPOra/Q6faCjIwmLori4K0rresH6Q6CbQIbrP1UfINp01kdKl0++ck5MQbRk
 BDfe1zXfiNC35th+hz6rypABL3mUyf8Bhvg+R/z4G0YUS17PYvP0iml8ae0pnNw9bD
 pdlkfQbsqCdmwFmN5iYRskkat7qDnWnIQo8Xu4rHa47FUghBSOEh4EA29OUE/pUeki
 bDclJWwmEk8jA==
Received: by mail-lf1-f49.google.com with SMTP id
 2adb3069b0e04-500760b296aso862406e87.0
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 05:28:46 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx67JO6RJaRINTWMhd8Y6WX9JzT7l5PVnuWM8B96wGI5nEMf1d+
 YqjT1mXTerH9/lEkB6Ojfqis5b6a9jb+5LORx+g=
X-Google-Smtp-Source: AGHT+IEt6ssTLnEZQPql8uv0e9cCMN2qYBu4GX0LcJsKO+irQC/odNOUf2HHFRys9I3941ggRp0B4CR23/MLwZcdE20=
X-Received: by 2002:a05:6512:ba9:b0:500:8676:aa7f with SMTP id
 b41-20020a0565120ba900b005008676aa7fmr819687lfv.23.1693484924436; Thu, 31 Aug
 2023 05:28:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230822203446.4111742-1-sjg@chromium.org>
 <ZOXKTrC_dzN_hUkY@FVFF77S0Q05N>
 <CAMj1kXEHpRjk_YKOm4czCnnpjqgahj2jV8MMfGLx7b1RdnBnVw@mail.gmail.com>
 <CAPnjgZ1S8G=7eCBF9PcDk4H5sk3AcxSSWXO575jK8SjA9dR8qw@mail.gmail.com>
 <CAMj1kXH83_TB4S0PL3jswxjCP+907YpgS7FRuVTO3G62s7nn5w@mail.gmail.com>
 <CAPnjgZ2kkUt1eOWX8K+EsbjcQZPefNvj5DSaFb9QrvRg0t2h7w@mail.gmail.com>
 <CAMj1kXGe84uaJ9j9ic0V4HC43p7QBoKQ5ssTYd5DMBGtZ3++Jw@mail.gmail.com>
 <CAPnjgZ3L-jGxoXNHnsXY0MXU=jTAN66KNAxSLHPVeHinHMjzkQ@mail.gmail.com>
In-Reply-To: <CAPnjgZ3L-jGxoXNHnsXY0MXU=jTAN66KNAxSLHPVeHinHMjzkQ@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 31 Aug 2023 14:28:33 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGw6DGK=gVF3bMH5dp=LL89V9n1V1LMGKDn0CZWGHh8qg@mail.gmail.com>
Message-ID: <CAMj1kXGw6DGK=gVF3bMH5dp=LL89V9n1V1LMGKDn0CZWGHh8qg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] schemas: Add a schema for memory map
To: Simon Glass <sjg@chromium.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, 
 Rob Herring <robh@kernel.org>, Chiu Chasel <chasel.chiu@intel.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>, Gua Guo <gua.guo@intel.com>,
 linux-acpi@vger.kernel.org, 
 lkml <linux-kernel@vger.kernel.org>, Yunhui Cui <cuiyunhui@bytedance.com>, 
 ron minnich <rminnich@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Lean Sheng Tan <sheng.tan@9elements.com>
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

On Wed, 30 Aug 2023 at 23:11, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ard,
>
> On Tue, 29 Aug 2023 at 15:32, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Tue, 29 Aug 2023 at 21:18, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Ard,
> > >
> > > On Thu, 24 Aug 2023 at 03:10, Ard Biesheuvel <ardb@kernel.org> wrote:
...
> > > > In summary, I don't see why a non-UEFI payload would care about UEFI
> > > > semantics for pre-existing memory reservations, or vice versa. Note
> > > > that EDK2 will manage its own memory map, and expose it via UEFI boot
> > > > services and not via DT.
> > >
> > > Bear in mind that one or both sides of this interface may be UEFI.
> > > There is no boot-services link between the two parts that I have
> > > outlined.
> > >
> >
> > I don't understand what this means.
> >
> > UEFI specifies how one component invokes another, and it is not based
> > on a DT binding. If the second component calls UEFI boot or runtime
> > services, it should be invoked in this manner. If it doesn't, then it
> > doesn't care about these memory reservations (and the OS will not be
> > booted via UEFI either)
> >
> > So I feel I am missing something here. Perhaps a practical example
> > would be helpful?
>
> Let's say we want to support these combinations:
>
> Platform Init -> Payload
> --------------------------------
> U-Boot -> Tianocore
> coreboot -> U-Boot
> Tianocore -> U-Boot
> Tianocore -> Tianocore
> U-Boot -> U-Boot
>
> Some of the above things have UEFI interfaces, some don't. But in the
> case of Tianocore -> Tianocore we want things to work as if it were
> Tianocore -> (its own handoff mechanism) Tiancore.
>

If Tianocore is the payload, it is either implemented as a EFI app, in
which case it has access to EFI services, or it is not, in which case
it doesn't care about UEFI semantics of the existing reserved regions,
and it only needs to know which regions exist and which of those are
reserved.

And I think the same applies to all other rows in your table: either
the existence of UEFI needs to be carried forward, which needs to be
done via EFI services, or it doesn't, in which case the UEFI specific
reservations can be dropped, and only reserved and available memory is
relevant.

> Some Platform Init may create runtime code which needs to accessible later.
>

But not UEFI runtime code, right? If the payload is not UEFI based,
the OS would never be able to call that runtime code unless it is
described in a different, non-UEFI way. This is fine, but it is not
UEFI so we shouldn't call it UEFI runtime memory.

> The way I think of it is that we need to generalise the memory map a
> bit. Saying that you must use UEFI boot services to discover it is too
> UEFI-specific.
>

What I am questioning is why a memory map with UEFI semantics is even
relevant when those boot services do not exist.

Could you be more specific about why a payload would have to be aware
of the existence of UEFI boot/runtime service regions if it does not
consume the UEFI interfaces of the platform init? And if the payload
exposes UEFI services to the OS, why would it consume a memory map
with UEFI semantics rather than a simple list of memblocks and memory
reservations?

Again, I am inclined to treat this as a firmware implementation
detail, and the OS must never consume this binding. But I am still
puzzled about what exact purpose it is expected to serve.
