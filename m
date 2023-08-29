Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25B80C71153
	for <u-boot@archiver.kernel.org>; Tue, 29 Aug 2023 19:19:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF9518652F;
	Tue, 29 Aug 2023 21:18:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BDUtrjdz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2FB18652B; Tue, 29 Aug 2023 21:18:36 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13FB58056D
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 21:18:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-52683b68c2fso6296672a12.0
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 12:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693336712; x=1693941512; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XY6m0jrM1EIVxXZKsdM96lBHZBbK4+oaifCRdomyQwM=;
 b=BDUtrjdz6fKIDmyd6TCx+neeKYYYNbT6SxhtsZz440sN0miEnineNyyk9DVRbTbpfi
 K9ePA12SfUtHr7kRZ6Msa9FWS/9WtrdyzKuDozREvmGjKLPDKe9/7xB7IgiIlTWd7kED
 7ST+OJ541hSiwhbAZSLRfygKvQBwD1+eK7V5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693336712; x=1693941512;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XY6m0jrM1EIVxXZKsdM96lBHZBbK4+oaifCRdomyQwM=;
 b=SNqVwqt6A/n3WxG3M6fkMhvOqG3r3iS5YGY4KCoL0qYU6Ra+oNfA/3lAitm+O3LGYN
 gAaSLBxdkzrW6YfP46aXqR8AqdYih+DPtRnOahMUsmsqv8+MHa/b9Jo8+K+YVWI4FMCp
 AuGCOhf+XPikc6qMKbDd5d+ryerPWtFZYVg21sJRWzIz732QVBHzjUvgcj+aPhTKSOuo
 o4CfzWsu1oBTFJei/ntcf4UMWJ6zFLmytNN/vYDEEegliM0lCgZIiktRhGzkyhdxy5Qu
 gK4iJVH+9LgQ/8SdO8C67qqgg8xYruOR+5/4JH+qWZj6pi7vSBI7f0byro1KB5hMCDrJ
 cDHg==
X-Gm-Message-State: AOJu0YwkhWU3cv78XORbBy1fk7gYndDTBDidsvwe92DqAb7fzfW6cZm5
 EkqEK5KkfiqasoyL96lBlwdfD8jGJ81LwFhHAHmSww==
X-Google-Smtp-Source: AGHT+IFI+6hIzTjgJuzAa1zO1wGKWDxOAL24PqezgVa4g1DgJpvIb/BqU2ngDxgfIuxCB7U7LzNQnl5VC1qyua0ZTCk=
X-Received: by 2002:aa7:d898:0:b0:522:b929:9f01 with SMTP id
 u24-20020aa7d898000000b00522b9299f01mr195406edq.9.1693336712271; Tue, 29 Aug
 2023 12:18:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230822203446.4111742-1-sjg@chromium.org>
 <ZOXKTrC_dzN_hUkY@FVFF77S0Q05N>
 <CAMj1kXEHpRjk_YKOm4czCnnpjqgahj2jV8MMfGLx7b1RdnBnVw@mail.gmail.com>
 <CAPnjgZ1S8G=7eCBF9PcDk4H5sk3AcxSSWXO575jK8SjA9dR8qw@mail.gmail.com>
 <CAMj1kXH83_TB4S0PL3jswxjCP+907YpgS7FRuVTO3G62s7nn5w@mail.gmail.com>
In-Reply-To: <CAMj1kXH83_TB4S0PL3jswxjCP+907YpgS7FRuVTO3G62s7nn5w@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 29 Aug 2023 13:17:48 -0600
Message-ID: <CAPnjgZ2kkUt1eOWX8K+EsbjcQZPefNvj5DSaFb9QrvRg0t2h7w@mail.gmail.com>
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

On Thu, 24 Aug 2023 at 03:10, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Wed, 23 Aug 2023 at 22:04, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi,
> >
> > On Wed, 23 Aug 2023 at 08:24, Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Wed, 23 Aug 2023 at 10:59, Mark Rutland <mark.rutland@arm.com> wrote:
> > > >
> > > > On Tue, Aug 22, 2023 at 02:34:42PM -0600, Simon Glass wrote:
> > > > > The Devicetree specification skips over handling of a logical view of
> > > > > the memory map, pointing users to the UEFI specification.
> > > > >
> > > > > It is common to split firmware into 'Platform Init', which does the
> > > > > initial hardware setup and a "Payload" which selects the OS to be booted.
> > > > > Thus an handover interface is required between these two pieces.
> > > > >
> > > > > Where UEFI boot-time services are not available, but UEFI firmware is
> > > > > present on either side of this interface, information about memory usage
> > > > > and attributes must be presented to the "Payload" in some form.
> > >
> > > Not quite.
> > >
> > > This seems to be intended for consumption by Linux booting in ACPI
> > > mode, but not via UEFI, right?
> >
> > Actually, this is for consumption by firmware. The goal is to allow
> > edk2 to boot into U-Boot and vice versa, i.e. provide some
> > interoperability between firmware projects. I will use the "Platform
> > Init" and "Payload" terminology here too.
> >
>
> OK. It was the cc to linux-acpi@ and the authors of the
> ACPI/SMBIOS-without-UEFI patches that threw me off here.
>
> If we are talking about an internal interface for firmware components,
> I'd be inclined to treat this as an implementation detail, as long as
> the OS is not expected to consume these DT nodes.
>
> However, I struggle to see the point of framing this information as a
> 'UEFI memory map'. Neither EDK2 nor u-boot consume this information
> natively, and there is already prior art in both projects to consume
> nodes following the existing bindings for device_type=memory and the
> /reserved-memory node. UEFI runtime memory is generally useless
> without UEFI runtime services, and UEFI boot services memory is just
> free memory.
>
> There is also an overlap with the handover between secure and
> non-secure firmware on arm64, which is also DT based, and communicates
> available memory as well as RAM regions that are reserved for firmware
> use.
>
> In summary, I don't see why a non-UEFI payload would care about UEFI
> semantics for pre-existing memory reservations, or vice versa. Note
> that EDK2 will manage its own memory map, and expose it via UEFI boot
> services and not via DT.

Bear in mind that one or both sides of this interface may be UEFI.
There is no boot-services link between the two parts that I have
outlined.

>
> ...
> >
> > There is no intent to implement the UEFI spec, here. It is simply that
> > some payloads (EDK2) are used to having this information.
> >
> > Imagine splitting EDK2 into two parts, one of which does platform init
> > and the other which (the payload) boots the OS. The payload wants
> > information from Platform Init and it needs to be in a devicetree,
> > since that is what we have chosen for this interface. So to some
> > extent this is unrelated to whether you have EFI boot services. We
> > just need to be able to pass the information across the interface.
> > Note that the user can (without recompilation, etc.) replace the
> > second part with U-Boot (for example) and it must still work.
> >
>
> OK, so device tree makes sense for this. This is how I implemented the
> EDK2 port that targets QEMU/mach-virt - it consumes the DT to discover
> the UART, RTC,, memory, PCI host bridge, etc.
>
> But I don't see a use case for a UEFI memory map here.
>
>
> > >
> > > >
> > > > Today Linux does that by passing:
> > > >
> > > >   /chosen/linux,uefi-mmap-start
> > > >   /chosen/linux,uefi-mmap-size
> > > >   /chosen/linux,uefi-mmap-desc-size
> > > >   /chosen/linux,uefi-mmap-desc-ver
> > > >
> > > > ... or /chosen/xen,* variants of those.
> > > >
> > > > Can't we document / genericise that?
> >
> > That seems to me to be the fields from the EFI memory-map call, but
> > where is the actual content? I looked in the kernel but it seems to be
> > an internal interface (between the stub and the kernel)?
> >
> > > >
> > >
> > > Given the ACPI angle, promoting this to external ABI would introduce a
> > > DT dependency to ACPI boot. So we'll at least have to be very clear
> > > about which takes precedence, or maybe disregard everything except the
> > > /chosen node when doing ACPI boot?
> > >
> > > This also argues for not creating an ordinary binding for this (i.e.,
> > > describing it as part of the platform topology), but putting it under
> > > /chosen as a Linux-only boot tweak.
> > >
> > > > Pointing to that rather than re-encoding it in DT means that it stays in-sync
> > > > with the EFI spec and we won't back ourselves into a corner where we cannot
> > > > encode something due to a structural difference. I don't think it's a good idea
> > > > to try to re-encode it, or we're just setting ourselves up for futher pain.
> > > >
> > >
> > > What I would prefer is to formalize pseudo-EFI boot and define the
> > > bare required minimum (system table + memory map + config tables) in
> > > an arch-agnostic manner. That way, the only thing that needs to be
> > > passed via DT/boot_params/etc is the (pseudo-)EFI system table
> > > address, and everything else (SMBIOS, ACPI as well as the EFI memory
> > > map and even the initrd) can be passed via config tables as usual, all
> > > of which is already supported in (mostly) generic kernel code.
> > >
>
> <snip some lines>
>
> >
> > Here I believe you are talking about booting the kernel in EFI mode,
> > but that is not the intent of this patch. This is all about things
> > happening in firmware. Now, if the payload (second) part of the
> > firmware decides it wants to offer EFI boot services and boot the
> > kernel via the EFI stub, then it may very well pack this information
> > (with a few changes) into a system table and make it available to the
> > kernel stub. But by then this FDT binding is irrelevant, since it has
> > served its purpose (which, to reiterate, is to facilitate information
> > passage from platform init to 'payload').
> >
>
> Indeed. As long as this binding is never consumed by the OS, I don't
> have any objections to it - I just fail to see the point.

OK thanks.

The point is that Platform Init and the payload need to agree about
where certain things are in memory. It is true that this is coming
from an EFI context, but that is just an example. Platform Init
doesn't necessarily know whether its payload is EFI, but may set this
up for use by the payload, just in case.

Regards,
SImon
