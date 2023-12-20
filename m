Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 982E7C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 04:15:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D007386E5E;
	Wed, 20 Dec 2023 05:15:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RIkpifPy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B129871B4; Wed, 20 Dec 2023 05:15:36 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0669F86E05
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 05:15:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a234dc0984fso377489666b.0
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 20:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703045733; x=1703650533; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vg5M29JBR2agTMgDzJRtRbRxUPpAUAMw9HjBl7WsCXw=;
 b=RIkpifPyVG0NfQaO31vifdCpkb/lyjQVNSEnGAg/YgY0nn55oVxF0186LFEr8rChWP
 UdfUia8xD2Tn9VsEOgwOPjmJ8ZDjk5kihBZi2vr77DQu6GllRoctV+DdMUFNhpjTmQPy
 svfT6pRjoav3WGVqXJu04jhQ5KJgYzu+KaWmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703045733; x=1703650533;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vg5M29JBR2agTMgDzJRtRbRxUPpAUAMw9HjBl7WsCXw=;
 b=bgexToVFR2ktDCX886Hw4kZc9dziMUrqvbhTZ9SwaHdF/yVWlNGRCfIVT9CS4wDYbs
 5nt6GET1D0MmpcNGlrMSldY59X+OEl8ds1csX4iKFa52VJX8Ab6A0P/wFzFvplmdTQU6
 eKRUmkZ6kbfR9cgzup2fSS92xINaCZqMei8PbEVLQfKlUhB6DdtttTroLWBhB0UiZySU
 D6XQwAmP3uJrQiQaOmgvdLhLIhxu+cd/Moh8QlhsHDmSkPUVQ5QibI4d0h0mZGkg29ER
 U3e4mcXcEXDMEmTuNZy141/A1jp8JuH26ISVR/yfstYVfGTkUA+A/ejMlkCkuYzdXYMH
 CdSw==
X-Gm-Message-State: AOJu0YyN+bwP18nxwnpm43+W/1fxARPhDQ8GDxFnAteOilNmo/9LN1QA
 GhWx+snJc512jWoWOE7znP53J9lt4KTYqJ4uQwFn6g==
X-Google-Smtp-Source: AGHT+IE+jQPyXWarXG/HTSHP1Vv+PyF5ALDtX1CRQg1DfZ+m5FMb4GO7WYl1TJ9J1wiRQbffCNo6yRFZxpaM2PfXxrI=
X-Received: by 2002:a17:906:2a86:b0:a02:609a:5c6c with SMTP id
 l6-20020a1709062a8600b00a02609a5c6cmr7863090eje.44.1703045733266; Tue, 19 Dec
 2023 20:15:33 -0800 (PST)
MIME-Version: 1.0
References: <CAPnjgZ1=JBEh49G654DfkYM-fcOEhwh=Xuu1scXTLsNkZk2SNQ@mail.gmail.com>
 <DEECD6D4-58C6-4032-BBF9-28A65B9096DD@gmx.de>
 <20231218224108.GN2513409@bill-the-cat>
 <3DAFAD12-98E4-46CC-B02E-E8EE40D57AC3@gmx.de>
 <20231218231640.GO2513409@bill-the-cat>
 <058AE676-FD71-4DEB-AEB3-0C805B74E8EE@gmx.de>
 <20231218233130.GP2513409@bill-the-cat>
 <688C13A3-9C5F-4A39-9F8F-54C2E8D08EE8@gmx.de>
 <20231219012600.GQ2513409@bill-the-cat>
 <E0572546-90AA-41C4-8433-EF02BB12E434@gmx.de>
 <20231219124553.GS2513409@bill-the-cat>
In-Reply-To: <20231219124553.GS2513409@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 19 Dec 2023 21:15:21 -0700
Message-ID: <CAPnjgZ1SUoRKEWaK6k1rrVN4t0WLD24GGeRj7uer3A0XA_MKoA@mail.gmail.com>
Subject: Re: Proposal: U-Boot memory management
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi,

On Tue, 19 Dec 2023 at 05:46, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Dec 19, 2023 at 03:15:38AM +0100, Heinrich Schuchardt wrote:
> >
> >
> > Am 19. Dezember 2023 02:26:00 MEZ schrieb Tom Rini <trini@konsulko.com>=
:
> > >On Tue, Dec 19, 2023 at 01:01:51AM +0100, Heinrich Schuchardt wrote:
> > >>
> > >>
> > >> Am 19. Dezember 2023 00:31:30 MEZ schrieb Tom Rini <trini@konsulko.c=
om>:
> > >> >On Tue, Dec 19, 2023 at 12:29:19AM +0100, Heinrich Schuchardt wrote=
:
> > >> >>
> > >> >>
> > >> >> Am 19. Dezember 2023 00:16:40 MEZ schrieb Tom Rini <trini@konsulk=
o.com>:
> > >> >> >On Tue, Dec 19, 2023 at 12:08:31AM +0100, Heinrich Schuchardt wr=
ote:
> > >> >> >>
> > >> >> >>
> > >> >> >> Am 18. Dezember 2023 23:41:08 MEZ schrieb Tom Rini <trini@kons=
ulko.com>:
> > >> >> >> >On Mon, Dec 18, 2023 at 11:34:16PM +0100, Heinrich Schuchardt=
 wrote:
> > >> >> >> >
> > >> >> >> >[snip]
> > >> >> >> >> Or take:
> > >> >> >> >>
> > >> >> >> >> load host 0:1 $c kernel.efi
> > >> >> >> >> load host 0:1 $d initrd.img
> > >> >> >> >>
> > >> >> >> >> How could we ensure that initrd.img is not overwriting a pa=
rt of kernel.efi without memory allocation?
> > >> >> >> >
> > >> >> >> >Today, invalid checksum as part of some part of the kernel fa=
ils. But
> > >> >> >> >how do we do this tomorrow, are you suggesting that "load" pe=
rform
> > >> >> >> >malloc() in some predefined size? If $c is below $d and $c + =
kernel.efi
> > >> >> >> >is now above $d we can throw an error before trying to load, =
yes. But
> > >> >> >> >what about:
> > >> >> >> >load host 0:1 $d initrd.img
> > >> >> >> >load host 0:1 $c kernel.efi
> > >> >> >> >
> > >> >> >> >In that case (which is only marginally contrived, the more re=
al case is
> > >> >> >> >loading device tree in to unexpectedly large ramdisk because =
someone
> > >> >> >> >didn't understand the general advice on why device tree is lo=
wer than
> > >> >> >> >ramdisk address) I'm fine with an error that amounts to "you =
just
> > >> >> >> >corrupted another allocation" and then "fail, reset the board=
" or so.
> > >> >> >> >
> > >> >> >>
> > >> >> >> Our current malloc library cannot manage the complete memory. =
We need a library like lmb which should also cover the memory management th=
at we currently have in lib/efi/efi_memory.c. This must include a memory ty=
pe attribute for usage in the GetMemoryMap() service. A management on page =
level seems sufficient.
> > >> >> >>
> > >> >> >> The load command should permanently allocate memory in that lm=
b+ library.
> > >> >> >>
> > >> >> >> We need an unload command to free the memory if we want to reu=
se the memory or we might let the load comand free the memory if exactly th=
e same start address is reused.
> > >> >> >
> > >> >> >Our current way of loading things in to memory does not handle t=
he case
> > >> >> >I described, yes. How would what you're proposing handle it?
> > >> >>
> > >> >> If the load command has to allocate memory for the image and that=
 allocation is kept, any attempt to allocate overlapping memory would fail.
> > >> >
> > >> >So you're saying that the load command has to pre-allocate memory? =
Or as
> > >> >it goes? If the latter, in what size chunks? This starts to get at =
what
> > >> >Simon was talking about with respect to memory fragmentation. Which=
 to
> > >> >be clear is a problem we have today, we just let things overlap and=
 hope
> > >> >something later catches an incorrect checksum.
> > >> >
> > >>
> > >> I don't want to replace the malloc library which handles large numbe=
ts of allocations.
> > >
> > >I'm confused. The normal malloc library is not involved with current
> > >image loading, it's direct to memory (with some attempts at sanity
> > >checking by lmb).  Are you proposing a different allocator with
> > >malloc/free like behavior? If so, please outline how it will determine
> > >pool size, and how we'll use it to load thing to memory.
> >
> > All memory below the stack needs to be managed. Malloc uses a small mem=
ory area (a few MiB) above the stack.
>
> That's a rather huge change for how U-Boot works.
>
> > >> Closing the eyes when the user loads multiple files does not solve t=
he fragmentation problem.
> > >
> > >Yes. I'm only noting that today we just ignore the problem and sometim=
es
> > >catch it via checksums.
> > >
> > >> Fragmentation only happens if we have many concurrent allocations.  =
In EFI we are allocating top down. The number of concurrent allocations is =
low. Typically a few dozen at most. After terminating an application these =
should be freed again.
> > >
> > >OK, so are you saying that we would no longer be loading _to_ a locati=
on
> > >in memory and instead just be saying "load this thing" and picking whe=
re
> > >dynamically?
> >
> > Both preassigned and allocator assigned adresses are compatible with me=
mory management.
> >
> > Architectures and binaries have different requirements. On riscv64 you =
can load Linux kernel, initrd, fdt anywhere. We don't need predefined addre=
sses there. Other architectures have restrictions.
>
> Yes, 64 bit architecture tend to only have alignment requirements while
> 32bit architectures have both alignment requirements and some memory
> window requirement. Whatever we implement here needs to handle both
> cases.
>
> > >> When loading a file from a file system we know the filesize beforeha=
nd. So allocation is trivial.
> > >>
> > >> The loady command currently does not use the  offered size informati=
on but could do so.
> > >
> > >We should be using that information to make sure we don't overwrite
> > >U-Boot itself, but I don't recall how exactly we handle it today
> > >off-hand.
> >
> > If the user issues multiple load commands, he can overwrite previous fi=
les.
>
> Then it sounds like we lost one benefit of all of this overhead.
>
> > During boot command execution I guess the different allocations respect=
 each other.
> >
> > >
> > >> TFTP is problematic because it does not transfer the filesize. We wo=
uld probably try to allocate a large chunk of memory and then downsize the =
allocation after reading the whole file.
> > >
> > >Reading from non-filesystem flash also has this problem, but we at lea=
st
> > >specify the amount to read too. But yes, it gets back to what I was
> > >asking about on how you're proposing to handle network load cases.
> > >
> >
> > It depends on the protocol. Http conveys the size before the data. Tftp=
 does not.
> >
> > If you don't know the size, you must preallocate a big chunk, check tha=
t the download does not exceed it, and downsize the allocation afterwards. =
This is not a new problem but exists already with current lmb usage.
>
> Yes, and what I'm trying to find out is if what you're suggesting would
> do anything about it, since previous statements you made implied to me
> that we would prevent it.
>
> To me, at this point it sounds like what we need is more like persistent
> memory blocks and a hook that can be called in to for both "give me all
> known memory blocks" and "add this memory block to the list", so that
> EFI can do whatever it needs to do upon starting an application and then
> upon return to U-Boot. Both malloc/free allocations and "load this blob
> to memory from whatever" allocations would call the appropriate hook for
> tracking.

In my mind the solution to this entire problem is fairly minor changes
to how memory is allocated and only for EFI.

I tried to map out what that would look like and we have IMO got lost
in the weeds a bit.

I am not trying to solve the problem of the 'load' command doing an
allocation and throwing it away. To be that is WAI, at least until we
come up with another type of command. This is one of the reasons for
standard boot, allowing a more cohesive approach to booting.

I will think about this some more...

Regards,
Simon
