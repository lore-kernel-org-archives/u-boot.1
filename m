Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE5A3CA0FE4
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 01:12:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 234B78619A;
	Fri,  1 Sep 2023 03:12:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XSf+s6mh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8BAE86725; Fri,  1 Sep 2023 03:12:21 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B33B80750
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 03:12:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-52bd9ddb741so1948740a12.0
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 18:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693530733; x=1694135533; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uIvDMW8iPFZbv40r+dZ3ghuuGMw1toWQ7nnw3aheX9U=;
 b=XSf+s6mhwV7sNRF+8u7Z32I7GrjF7Ui72uKKhlor41pXjm9NO8r3iWiiGDdTSLR6zi
 RR8rUHAUMbkG10IciOgDNnrBTkyHmtOi2JXdZ4/1KNheARFMA2ftzBtZWPuS9tlF6Xbm
 j+Nt6AX+Q7zgh3bIC3hvIUy3k49WbO7uSAGmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693530733; x=1694135533;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uIvDMW8iPFZbv40r+dZ3ghuuGMw1toWQ7nnw3aheX9U=;
 b=HUZDYIjMqFjgvrsDE0M0njyW/93GUVR8Qyd1v3KnKh6vS94vtO6ci1dbJ9McmOxPs+
 vZhDM4olddipi8JzeQSVz6sLX3/hWRFAe5iBMUaGB8UqYD013dHeSzG/X94GL+sdbzf3
 z2rNzE2ZKi9rEKY/3nekwD+YcWSExzW/KFsaZTwPZrnVj+Jh2FLHkcB1NfbhbASrniHZ
 JhesA20NUdiwkYK3SWzwUQt0xlgVVRlnt5H6c0uVZMF7KU+EmbgpHwgKPF6QhTY5uDRd
 1wkbsy5hydH560sSZf+NcsTXvIAJtt7JIXaNe99TmOHpIZ7dds7r+LSXAQrtqmkGc9Rh
 Opaw==
X-Gm-Message-State: AOJu0YwsW64QUXX5WPC/+fBt7YOH3wR645hrpLuOseF0uU7dIVQXd2Ir
 lxEc1IFXuqd4Z0A5PAB2oo/dLukN+E5JtiEj7ex96A==
X-Google-Smtp-Source: AGHT+IFV5QjJo+ft1Y4Q38+ZfYCGivoBhxt2+vYpzajRXBpX3Efzw/s2oHJ8Qbf8EY4vIcVTJY2MiHJYlwETdSkfTRg=
X-Received: by 2002:a05:6402:b30:b0:523:4057:fa6e with SMTP id
 bo16-20020a0564020b3000b005234057fa6emr662418edb.42.1693530733343; Thu, 31
 Aug 2023 18:12:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230822203446.4111742-1-sjg@chromium.org>
 <ZOXKTrC_dzN_hUkY@FVFF77S0Q05N>
 <CAMj1kXEHpRjk_YKOm4czCnnpjqgahj2jV8MMfGLx7b1RdnBnVw@mail.gmail.com>
 <CAPnjgZ1S8G=7eCBF9PcDk4H5sk3AcxSSWXO575jK8SjA9dR8qw@mail.gmail.com>
 <CAMj1kXH83_TB4S0PL3jswxjCP+907YpgS7FRuVTO3G62s7nn5w@mail.gmail.com>
 <CAPnjgZ2kkUt1eOWX8K+EsbjcQZPefNvj5DSaFb9QrvRg0t2h7w@mail.gmail.com>
 <CAMj1kXGe84uaJ9j9ic0V4HC43p7QBoKQ5ssTYd5DMBGtZ3++Jw@mail.gmail.com>
 <CAPnjgZ3L-jGxoXNHnsXY0MXU=jTAN66KNAxSLHPVeHinHMjzkQ@mail.gmail.com>
 <CAMj1kXGw6DGK=gVF3bMH5dp=LL89V9n1V1LMGKDn0CZWGHh8qg@mail.gmail.com>
 <CAPnjgZ1fjee3rf91onPbuLpgqTHe3dZgz0WBSzoiKAabO+ETkQ@mail.gmail.com>
 <CAMj1kXFvLGeXXmyK1wSXLk5yq42f2G3GvBGoN40JF=y4bvCo=Q@mail.gmail.com>
 <CAPnjgZ25VqPCBSZ69fyb+G93=hzS-gX6zVa0J3vYyY49p0CZmw@mail.gmail.com>
 <CAMj1kXGzPHFpjr4-Q5Vwe3TSZWdAumWVL7iYJR76VGQbZUSsEA@mail.gmail.com>
In-Reply-To: <CAMj1kXGzPHFpjr4-Q5Vwe3TSZWdAumWVL7iYJR76VGQbZUSsEA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 31 Aug 2023 19:12:02 -0600
Message-ID: <CAPnjgZ29DP_fwwV2bJiSP3zgpL2Q=CYHG1qjOiHyL4FUi895BA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] schemas: Add a schema for memory map
To: Ard Biesheuvel <ardb@kernel.org>
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

Hi Ard,

On Thu, 31 Aug 2023 at 16:39, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Fri, 1 Sept 2023 at 00:17, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Ard,
> >
> > On Thu, 31 Aug 2023 at 15:48, Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Thu, 31 Aug 2023 at 21:03, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Ard,
> > > >
> > > > On Thu, 31 Aug 2023 at 06:28, Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > >
> > > > > On Wed, 30 Aug 2023 at 23:11, Simon Glass <sjg@chromium.org> wrote:
> > > > > >
> > > > > > Hi Ard,
> > > > > >
> > > > > > On Tue, 29 Aug 2023 at 15:32, Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > > > >
> > > > > > > On Tue, 29 Aug 2023 at 21:18, Simon Glass <sjg@chromium.org> wrote:
> > > > > > > >
> > > > > > > > Hi Ard,
> > > > > > > >
> > > > > > > > On Thu, 24 Aug 2023 at 03:10, Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > > ...
> > > > > > > > > In summary, I don't see why a non-UEFI payload would care about UEFI
> > > > > > > > > semantics for pre-existing memory reservations, or vice versa. Note
> > > > > > > > > that EDK2 will manage its own memory map, and expose it via UEFI boot
> > > > > > > > > services and not via DT.
> > > > > > > >
> > > > > > > > Bear in mind that one or both sides of this interface may be UEFI.
> > > > > > > > There is no boot-services link between the two parts that I have
> > > > > > > > outlined.
> > > > > > > >
> > > > > > >
> > > > > > > I don't understand what this means.
> > > > > > >
> > > > > > > UEFI specifies how one component invokes another, and it is not based
> > > > > > > on a DT binding. If the second component calls UEFI boot or runtime
> > > > > > > services, it should be invoked in this manner. If it doesn't, then it
> > > > > > > doesn't care about these memory reservations (and the OS will not be
> > > > > > > booted via UEFI either)
> > > > > > >
> > > > > > > So I feel I am missing something here. Perhaps a practical example
> > > > > > > would be helpful?
> > > > > >
> > > > > > Let's say we want to support these combinations:
> > > > > >
> > > > > > Platform Init -> Payload
> > > > > > --------------------------------
> > > > > > U-Boot -> Tianocore
> > > > > > coreboot -> U-Boot
> > > > > > Tianocore -> U-Boot
> > > > > > Tianocore -> Tianocore
> > > > > > U-Boot -> U-Boot
> > > > > >
> > > > > > Some of the above things have UEFI interfaces, some don't. But in the
> > > > > > case of Tianocore -> Tianocore we want things to work as if it were
> > > > > > Tianocore -> (its own handoff mechanism) Tiancore.
> > > > > >
> > > > >
> > > > > If Tianocore is the payload, it is either implemented as a EFI app, in
> > > > > which case it has access to EFI services, or it is not, in which case
> > > > > it doesn't care about UEFI semantics of the existing reserved regions,
> > > > > and it only needs to know which regions exist and which of those are
> > > > > reserved.
> > > > >
> > > > > And I think the same applies to all other rows in your table: either
> > > > > the existence of UEFI needs to be carried forward, which needs to be
> > > > > done via EFI services, or it doesn't, in which case the UEFI specific
> > > > > reservations can be dropped, and only reserved and available memory is
> > > > > relevant.
> > > > >
> > > > > > Some Platform Init may create runtime code which needs to accessible later.
> > > > > >
> > > > >
> > > > > But not UEFI runtime code, right? If the payload is not UEFI based,
> > > > > the OS would never be able to call that runtime code unless it is
> > > > > described in a different, non-UEFI way. This is fine, but it is not
> > > > > UEFI so we shouldn't call it UEFI runtime memory.
> > > > >
> > > > > > The way I think of it is that we need to generalise the memory map a
> > > > > > bit. Saying that you must use UEFI boot services to discover it is too
> > > > > > UEFI-specific.
> > > > > >
> > > > >
> > > > > What I am questioning is why a memory map with UEFI semantics is even
> > > > > relevant when those boot services do not exist.
> > > > >
> > > > > Could you be more specific about why a payload would have to be aware
> > > > > of the existence of UEFI boot/runtime service regions if it does not
> > > > > consume the UEFI interfaces of the platform init? And if the payload
> > > > > exposes UEFI services to the OS, why would it consume a memory map
> > > > > with UEFI semantics rather than a simple list of memblocks and memory
> > > > > reservations?
> > > >
> > > > It seems like you are thinking of the Payload as grub, or something
> > > > like that? This is not about grub. If there are EFI boot services to
> > > > be provided, they are provided by the Payload, not Platform Init. I am
> > > > not that familiar with Tianocore, but if you are, perhaps think of it
> > > > as splitting Tianocore into two pieces, one of which inits the silicon
> > > > and the other which provides the EFI boot services.
> > > >
> > > > Again, if you are familiar with Tianocore, it can be built either as a
> > > > monolithic whole, or as a coreboot Payload. The Payload part of the
> > > > code is (roughly) the same in each case. But the Platform Init is
> > > > different[1]
> > > >
> > >
> > > I co-maintain OVMF [including the ARM port that I created from
> > > scratch] as well as the ARM architecture support in Tianocore, along
> > > with a couple of platform ports for ARM boards, some of which could by
> > > now be characterized as 'historical' (AMD Seattle, Socionext SynQuacer
> > > and Raspberry Pi 3/4). So I think I have a pretty good handle on how
> > > Tianocore based firmware is put together.
> > >
> > > Tianocore as a payload will expose boot services to the OS, and will
> > > provide the OS with a memory map using the UEFI APIs. But you still
> > > haven't explained why the memory description this Tianocore inherits
> > > from the Platform Init would include any UEFI boot or runtime service
> > > regions, or any of the other memory regions with UEFI semantics.
> > > TIanocore just needs to know a) where memory lives b) which parts of
> > > it are already in use (as far as the memory map is concerned), and the
> > > existing bindings suffice for this purpose.
> > >
> > > In short, the memory regions with UEFI semantics are created by the
> > > boot phase that actually exposes UEFI to the OS, in which case the
> > > boot services can be used to obtain the memory map. If the consumer is
> > > not UEFI based, there is no reason to bother it with descriptions of
> > > memory regions that have no significance to it.
> >
> > But aren't you assuming that the Payload knows how to handle the
> > hardware and can implement the runtime services? What if (for example)
> > powering off the device is hardware-specific and only Platform Init
> > knows how?
> >
>
> If the payload relies on the platform init for anything, it can use
> whichever interface those components manage to agree on.
>
> If this interface is UEFI, the payload can use UEFI to obtain the memory map.

I think you are still getting mixed up with grub. Platform Init does
not necessarily provide EFI boot services, even for Tianocore. It is
the Payload which provides those services. In other words, the second
half of Tianocore does not use EFI boot services to talk to the first
half.

>
> If this interface is not UEFI, the UEFI memory map is irrelevant, and
> existing DT bindings are available that can describe this information.

Can you please point me to those?

>
> > On another track, would it help if we just dropped all mention of
> > UEFI? The binding does not mention it.
> >
>
> Your binding has
>
> +      usage:
> +        $ref: /schemas/types.yaml#/definitions/string
> +        description: |
> +          Describes the usage of the memory region, e.g.:
> +
> +            "acpi-reclaim", "acpi-nvs", "bootcode", "bootdata", "bootdata",
> +            "runtime-code", "runtime-data".
> +
> +            See enum EFI_MEMORY_TYPE in "Unified Extensible Firmware Interface
> +            (UEFI) Specification" for all the types. For now there are not
> +            listed here.
>
> Every type listed is derived from a definition in the UEFI spec, which
> is specifically mentioned as the source.

Yes, but please see the v4 or v5 patch version, where that has
changed. I sent v4 two days ago. I am worried that you are still
responding to something that I revised in response to your original
comments?

>
> > On a third track, what if Platform Init wants to set aside some memory
> > for runtime code, e.g. in SRAM?
> >
>
> SRAM is not the best example here, as it is typically not described by
> DT using device_type=memory, and never treated as ordinary system RAM
> that needs to be reserved in order to prevent the OS or other boot
> stages from stepping on it. In UEFI, such a region would not appear in
> the UEFI memory map at all unless the OS needed to add it to the
> runtime memory map (i.e., when UEFI runtime service implementations
> themselves need to access such a region, similar to how the RTC or NOR
> flash may be described as MemoryMappedIo regions so that GetTime() or
> GetVariable() can access the underlying peripherals)

OK I stand corrected.

>
> But if the Platform Init wants to reserve some system RAM for runtime
> code (e.g., for its PSCI implementation on ARM), it can add it to the
> /reserved-memory node, where both the payload and the OS will be able
> to find it if needed.

OK good. So with my binding that would be 'runtime-code@...'. I am
still not sure what the problem is here.

>
> > I'm just not sure that Platform Init and Payload are as completely
> > independent as you seem to be suggesting. Once we get into the
> > Payload, the only things we know are what Platform Init told us.
> >
>
> They are not independent, and that is not at all what I am claiming.
>
> What I am objecting to is framing the platform init<->payload memory
> handover in terms of UEFI memory types, which may conflict with well
> established DT bindings that already serve the same purpose. The only
> difference between /reserved-memory and this binding seems to be the
> collection of UEFI memory types, which don't belong there in the first
> place.

OK, so please help me get this resolved.

Regards,
Simon
