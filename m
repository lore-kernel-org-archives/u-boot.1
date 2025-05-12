Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37C32C3ABCD
	for <u-boot@archiver.kernel.org>; Mon, 12 May 2025 12:38:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66F6A826AA;
	Mon, 12 May 2025 14:38:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LvZWS5eQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC18682162; Mon, 12 May 2025 10:18:45 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8969F805D7
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 10:18:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sycamoremoon376@gmail.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5fcc96b6a64so3868611a12.0
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 01:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747037923; x=1747642723; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=l0tdQl2kjoQXm29BfNLAWPTNLQ0d/SZrR+WKnn86w18=;
 b=LvZWS5eQuTJ0Dkl7eUiwK2A06BMC1q6TCnyymrzfFQWsvAooAZspR7QZUVAzJVQGnx
 p9sMpogWJJWdOs3gFQcI2AIA0RowZIFlaaN/Decfly2RzmDqULAtAZU5PQdvojhGuoRz
 NKaNRw/zAor6CIbkv3IKg+p20N+XnJZTEHrfRCqtSXohMBa0RJjiPFBOYQALeQ0Uyasv
 D2smFLdJp9m1BekPH+Sm3AIFDWuHfU2AL46ciTZmIpyqkzH2e0Zoswew9rnNt5bqDUf2
 q5gyEZUd/ZfcXLiE7/pEu/AQtoasw+5TaMhm/rIR97e6VwCj6h92pP1/iY6oq7/r20dZ
 Wo9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747037923; x=1747642723;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l0tdQl2kjoQXm29BfNLAWPTNLQ0d/SZrR+WKnn86w18=;
 b=raEmS9ImLUUE7YbKyMl6MCF2pz0EBsDwmHMSMdyy1reKMgbmqXEQeMApZFIpv91qjj
 sIkoSiX2JAzL6Pn/2XqH0OKagFRwM96Tbub5LHYS+DepUpSkZOk1L5tSh0pa5dRcX2zs
 2VtQZrJRs69sRUyYDumWZ3UxCSK5rkwtjE+t2fQA3fTTaVdEYKchXzVO6uaZXjoZ2gQq
 rCOzXy2C+0rmTwTN+MezHjdviiUo48BX7toYm7i7mHZynpgJONNS1xZJvLHkz2o6nD3w
 SFshefCHoM9KBHOTgSkxEsteJbo3lCov6Z6CtJSehiI1h2WdNCFnffGhzggEqCUSAxTi
 6c7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxWECXe6xXdtG4TgJAiY8guAtoVbN1A+G5tyVQLaYCLUaNPW2ij/b3aaaGQcEHN9L+URrqcRo=@lists.denx.de
X-Gm-Message-State: AOJu0YzOYkC7G2THoAr5EXn/P+FY4m8UkvrvubQ2CNNW7io/zAZjs2AG
 UBjYHWT2y46SRZZm3fG5+CKHeakZlu6cdJOONipAdjpHDzXn8/z9Gje1Ool+yN+EWsxXTL609ZJ
 bfFXH39ivIY5H8IiFEEplGuPDfiB6sg0Q
X-Gm-Gg: ASbGnctNlOybd8tNKHQ9A074FcWkbTwlDH/f8u0ivOm7fpfG5FPy8wtNHoLqoRD5j9+
 9YcxCxwJh8R9qV/hk8dHzW6iGIK3ba5kuLobrEEDsgcQbAiK9g9XeqJN/YeJ+JfqwvLe2DuFLUJ
 NvE+9j+hXq7PPACizaXIVpbsirwoz5wjBo7Vw=
X-Google-Smtp-Source: AGHT+IEBWfGGVwn/UXVQktk2/f6rpuXf9yKVxyHzd6HdYZk3Jx1UQqJv1n6nWZkzkHg2PZDBUVCRvownrNrSR/p6QvE=
X-Received: by 2002:a05:6402:40cc:b0:5e6:17e6:9510 with SMTP id
 4fb4d7f45d1cf-5fca0730860mr9938349a12.6.1747037922193; Mon, 12 May 2025
 01:18:42 -0700 (PDT)
MIME-Version: 1.0
From: Zixian Zeng <sycamoremoon376@gmail.com>
Date: Mon, 12 May 2025 16:18:31 +0800
X-Gm-Features: AX0GCFuBTDNEUSlG1yyrMPOqFUEM0j8E0-lzXvPkRBTpme33N1uvPZ892ASUQr0
Message-ID: <CAKyUbwVJR4=J=Xnt=OSt8b=A6+U+QLH+jn8zEBZfjvA8BYax2Q@mail.gmail.com>
Subject: Re: [PATCH v1] arm: add call to cleanup_before_linux for go command
To: Tom Rini <trini@konsulko.com>
Cc: Bryan Brattlof <bb@ti.com>, "Raghavendra, Vignesh" <vigneshr@ti.com>,
 Anshul Dalal <anshuld@ti.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 12 May 2025 14:38:13 +0200
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

On 25/04/30 01:32PM, Tom Rini wrote:
> On Wed, Apr 30, 2025 at 02:26:04PM -0500, Bryan Brattlof wrote:
> > On April 30, 2025 thus sayeth Tom Rini:
> > > On Wed, Apr 30, 2025 at 10:56:27PM +0530, Raghavendra, Vignesh wrote:
> > > >
> > > >
> > > > On 4/30/2025 10:01 PM, Tom Rini wrote:
> > > > > On Wed, Apr 30, 2025 at 11:29:04AM -0500, Bryan Brattlof wrote:
> > > > >> On April 30, 2025 thus sayeth Anshul Dalal:
> > > > >>> As discussed here[1], the go command causes undefined behavior when used
> > > > >>> for running custom OSes since the icache might hold outdated data. OSes
> > > > >>> usually also expect the MMU to be disabled upon execution.
> > > > >>>
> > > > >>> Therefore this patch adds a call to cleanup_before_linux before we jump
> > > > >>> to the loaded program/os which disables both the caches and the MMU.
> > > > >>> This makes the go command's behavior consistent with riscv platforms.
> > > > >>>
> > > > >>
> > > > >> I know quite a few other OSes are beginning to use U-Boot (QNX,
> > > > >> GreenHills or all the other RTOSes) each with their own requirements
> > > > >> from the bootloader. I'm curious if we should make boot* a little more
> > > > >> generic rather than abuse the 'go' command.
> > > >
> > > > VXworks has its own:
> > > > https://docs.u-boot.org/en/stable/usage/os/vxworks.html
> > > >
> > > > I suppose QNX and others should ideally have their own cmds as needed.
> > >
> > > Well, what's the QNX output file format (options?) again?
> >
> > I've only ever seen outputs in compressed binary formats but I've been
> > told there are tools to produce an ELF for the simulators
> >
> > >
> > > > > Well, that's what bootelf is for :)
> > > > >
> > > >
> > > > And if its not an elf but some .bin file "go" cmd should be used in
> > > > conjunction with "cache" cmd here to flush/disable cache, I guess?
> > >
> > > Well, what exactly are we talking about? Is this an "in theory" or some
> > > project(s) which exist today?
> > >
> >
> > I noticed this thread mainly because of the number of RTOS people asking
> > me about low level stuff U-Boot and TF-A is doing. I haven't seen any
> > 'In-Production' type bugs but I wouldn't be surprised if U-Boot is being
> > used in their CI environments today.
>
> A number of RTOSes are already supported via "bootm". If they've stopped
> working (as we don't have tests in CI for them) I'd love patches to fix
> and at least instructions on how to make it fail somewhere, ideally
> QEMU.
>
> > > There's a whole lot of reasons for either a legacy header and bootm or a
> > > not-legacy FIT image. The "go" command is for the "U-Boot is a debugger"
> > > side of the world, not how you should kick off some OS/application in
> > > production. It is all of the "this is dangerous" idioms.
> > >
> > > > If so, we should probably update the docs for this cmd appropriately so
> > > > as to avoid end users overloading like what RISC-V did?
> > >
> > > Yes, we should clarify things as needed and unwind, most likely, what
> > > RISC-V is doing. But not blindly so as perhaps there's now, sigh, a
> > > production / in-the-wild case here and we're now in a sticky spot.
> >
> > I like the idea of boot${OS} flags if only to standardize the interface
> > of how each OS should boot. I worry about situation where custom
> > scripting is being used to boot in production rather than stdboot
>
> Right. And that's part of why in this day and age, regular uses should
> not be using "go". We've had and supported RTOSes via "bootm" for what
> amounts to forever. We've had "bootelf" for arbitrary things for ages
> too (and in turn, your custom app/RTOS/whatever using the normal bare
> metal ELF linker script, target, etc makes it easier on that side too).
> In more recent times, having a whatever project spit out an EFI binary
> instead is also possible and done sometimes.
>
It might be a novice question, sorry..

I'm using uboot on riscv, and noticed that the "bootelf" command just
jumps to the entry point of the ELF file.  What if I want to boot
multiple harts?

bootm command calls "smp_call_functions" to change global variables
`gd->arch.ipi` which restores function addr and arguments
and sends IPI to each hart, but "bootelf" does not.

It might not be a problem on other arches such as x86, if I recall
correctly, x86 can specify the function address when sending IPI.

Thanks for your time.
> --
> Tom

Best regards,
Zixian
