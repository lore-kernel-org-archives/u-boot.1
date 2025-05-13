Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB88CC3ABCC
	for <u-boot@archiver.kernel.org>; Tue, 13 May 2025 12:31:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C37682B54;
	Tue, 13 May 2025 14:28:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gMFRUpsJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01217800C1; Tue, 13 May 2025 13:26:13 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 530DB80AE0
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 13:26:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sycamoremoon376@gmail.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-40331f302f1so3739762b6e.2
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 04:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747135569; x=1747740369; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l0tdQl2kjoQXm29BfNLAWPTNLQ0d/SZrR+WKnn86w18=;
 b=gMFRUpsJTq4mFKrM1ThsW62uQPOgW2CvMnCSjltNo5dz+MQXWg1XZFylxlh10kaxeF
 EwMWIzUi4UF0z9Yfyv9iS17idPDDYfzs7J6zdLmBrPryxucWB7ysawfzmj9H23K1+h5j
 tuG3O0gct6Syh9mBukCxXwIGpIgrxyiE0tJOCEX08Pp8klLhCpW8Uihjq4klpr4C5eTW
 WvZp51mf4HHKozRWgpB7DAHkyac2zyYXhWw8EMRtWCCTJNvGenlVnF7vJRSJc8ZGhe6K
 pEqezb7YjE+U5Azz3CjCcexSkjIp7UHvAo2pZZHe/JEgiAiuD7g6+IjJWVDx4FJvS7mT
 f4Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747135569; x=1747740369;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l0tdQl2kjoQXm29BfNLAWPTNLQ0d/SZrR+WKnn86w18=;
 b=NYYNE1MhvUBhb4/RwAIORFDTBY9noWj4gXKnPAmd1RF5Cf9Ajo5//SGh4lMtgrjIUa
 bJQvNF7idPcgQG+uqXbo3pR+x5aBMAp920hRo2cccVN9buTd8VsuX9BOGMV9fJrFQur0
 Qq6vYaF3rUJ1Y1oFYRcSKzY0Il7Ka6lu5D/oZLUTf/z/t/KI3iJKUHVb+yVKRS69Ahu1
 NIxCvKckhwdsy4xqqyakOVcRdKB9hkbcs4msaLUciWN9IEser8QUYnL34bQGIO36QzTU
 d66FZn97tvDnz6/pUjn1w6bEE8lSXWKgvTjp6lw7qvn/Ci8evqn0h++na/og/RCrmxCR
 CA8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKtdm2R3QVRDBtGOawAnCoQ8hj+cq0zqmn1BSFH9zPGaWGmIX7aejtGjEPhJjJFohxg6j5AnM=@lists.denx.de
X-Gm-Message-State: AOJu0Ywyk53pLWS0bY3UBj4ajNAlk3Kn2dd1N/JMRQObW7gBzF4WTGnR
 5XwrwEU+QuEGxJc19IjaFQ1TJixWe17Mk8EfMk2Iluy28d+k7Xd012SoGrdtLoQ=
X-Gm-Gg: ASbGncuBMbpWG5E1/AG6qw2njN6dL9B6+DGClyXB9RtLie4yEx9DUmOUYcYRkcqWFWI
 C4KO5+WqIDciXZVswyH2p0vXceEpKRu/1Y2V1EifMvydBVyQSSd5QQAWM9i6Yt4u9YzSLu3S0zO
 vFmljSDRucM2g8HWfXEbsXRhTO7+4hHD3rn7HgFN4x8/0Xu8XYggBfqsqhaJMjvZ6IMO1GHiqnz
 GBimGuP+AORzV33iRf86jaBOt3MJwgAlaZc9q486Wn4NxDcl5KVqdt04FfWpqF1+o70E6NUnzt0
 2ZFkkGab+wfzms9GwhRUTU0ZAZfgxtIik1JsOOImDMrO6oXaezQ=
X-Google-Smtp-Source: AGHT+IGdnhXCWVi+6sOufq4BIhFKaAH9e3KbjmwRku9zLhIuT+bPc7nMIifXzaJva08hkDDVrVqxxQ==
X-Received: by 2002:a17:90b:1a8d:b0:2ee:c91a:acf7 with SMTP id
 98e67ed59e1d1-30c3ca0415emr24525501a91.4.1747135557693; 
 Tue, 13 May 2025 04:25:57 -0700 (PDT)
Received: from localhost ([2001:250:5800:1000::9fc8])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-30c39e7607bsm8263901a91.46.2025.05.13.04.25.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 May 2025 04:25:57 -0700 (PDT)
Date: Tue, 13 May 2025 19:25:53 +0800
From: Zixian Zeng <sycamoremoon376@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: Bryan Brattlof <bb@ti.com>, "Raghavendra, Vignesh" <vigneshr@ti.com>, 
 Anshul Dalal <anshuld@ti.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v1] arm: add call to cleanup_before_linux for go command
Message-ID: <jacjuejbprhinwzul6ktugk76a7hu7lm3mfeqelr3wizpyc5lj@toewgusd6z5r>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Tue, 13 May 2025 14:28:49 +0200
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
