Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D7A7D1D88D
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 16:20:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E1A087F7D;
	Tue, 15 Oct 2024 18:20:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nWTc9Jec";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DAB88862E; Tue, 15 Oct 2024 18:20:16 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46E5E87DC7
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 18:20:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5c957d8bce2so2857864a12.2
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 09:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729009214; x=1729614014; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=F3NLQ6OHE0gyPfxN3eNh0iRWkA9kSFxO4R02VLdU1nE=;
 b=nWTc9Jec/E3kqnb/EKtWvot72/kjO7MdWgiJViD8GN2MIZoKiNE1yx2uAppIXHDBbI
 +H3HORe0fmvAQR1zfaNSTbLJ7JYlrUrtATeHCOzSOVDS8wN12esqQKgmz9NClojJ9RO5
 L8BJ8I0v3HJOVlJPZWog3V+hKC2vx8XD6BHz9NQrmylsMNnt2uFPCuM/IytFuVDcwZUU
 7Oi0UDjqdR8MhnFAe64peF1tdP0NsIU2/atYWVkPMr0oO8Dd3aYEP5PFRNNhhUxvFm0w
 TMmogiDUF50sWyFJYqDZR0Syq4sug1EqD62ted9rFc5CoOcyZxtNKfZhy6T1KO4MQ7NO
 UkMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729009214; x=1729614014;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F3NLQ6OHE0gyPfxN3eNh0iRWkA9kSFxO4R02VLdU1nE=;
 b=mBDx3SjRPHTsB/Emk3REARXx7jYYguZnqduqWMXo9MN7y56yDPwJN9YrvWtWEVjY4V
 HIrpcYQ0Qt0CXm3XkaBHrfzbvhvoLRhCySM3DIEe5Yz06623Z3F3iAUxSN4yozGN8GZa
 6kqvIRHjCb8ZlprRNW3/vkxcKj1wQ8xqi5QE97ofMhLgdDb9gEHVazv2w9UMrdYm6+H3
 wv0Vpf/Uf2yu21GfH/vIbFNTjpe3HhRbJCNEAwA92nFxPbypOhbZX+/oEFGkFPUKPYNi
 HDTJskIipgwg5XNoK0r5SYfQMVhuQWjLNZ4SysaXtXgt/uu3zO6v82UkmXPd8a3MiFS5
 RcGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0sz7e0maohS+2dcUUeMh3XPEwloGQG84piHZDWkocmA76ENz+chZ5NXU1HMAUYA0qXrfmxPA=@lists.denx.de
X-Gm-Message-State: AOJu0Ywmy+pPfaE0WV5f494fu+ynP8OLANNKiXP40vwfT5mE2SYmhln1
 mjZlwpC6BsrMEvRZ58WDEQhgLgILBo0cXll8ZYDT7D6o5R0O5izJXQsLBmYqW1OcbWNjk6Y4IV+
 MjFySZau8yd+mqpkIxU62by3DlylOOA==
X-Google-Smtp-Source: AGHT+IGaRTRiUxGjpxj0+ZO/ePAZaB5uJF/lxemahQ19MAJFZnp+/ePS1vOpg2ssoN+6f3HVhIlaPcrJu5d+ALmqkGY=
X-Received: by 2002:a05:6402:51cd:b0:5c9:492c:f7fa with SMTP id
 4fb4d7f45d1cf-5c95ac09939mr16697242a12.1.1729009213422; Tue, 15 Oct 2024
 09:20:13 -0700 (PDT)
MIME-Version: 1.0
References: <20241014131152.267405-1-patrick.rudolph@9elements.com>
 <CALeDE9NkB1kNdnEbsXLyzfQ53PNvV2unnzeMcTgpTKtySh=XcA@mail.gmail.com>
 <CAFLszTg94CCWi=K8ViX=Oxqq1bmW2VuQ-eOqdD9QYEj5U=GLBQ@mail.gmail.com>
 <CALeDE9P-80UYBd=y3FhA+Gnv+5Mz51p5SMRO+0MTGvvx4V_+Zw@mail.gmail.com>
 <CAFLszTh+CeC8MUEM6a2gsCDEVPeN1QuKU_mPUMCR+vFkZSo4hQ@mail.gmail.com>
In-Reply-To: <CAFLszTh+CeC8MUEM6a2gsCDEVPeN1QuKU_mPUMCR+vFkZSo4hQ@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 15 Oct 2024 17:20:01 +0100
Message-ID: <CALeDE9M_zsVmkKqJ6nDt3viF0H4u1_Su-xzm13rC=8XEVfHdVQ@mail.gmail.com>
Subject: Re: [PATCH v8 00/37] Implement ACPI on aarch64
To: Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>, u-boot@lists.denx.de
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

On Tue, 15 Oct 2024 at 16:28, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Peter,
>
> On Tue, 15 Oct 2024 at 07:34, Peter Robinson <pbrobinson@gmail.com> wrote:
> >
> > On Tue, 15 Oct 2024 at 14:10, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Peter,
> > >
> > > On Tue, 15 Oct 2024 at 04:28, Peter Robinson <pbrobinson@gmail.com> wrote:
> > > >
> > > > On Mon, 14 Oct 2024 at 14:12, Patrick Rudolph
> > > > <patrick.rudolph@9elements.com> wrote:
> > > > >
> > > > > Based on the existing work done by Simon Glass this series adds
> > > > > support for booting aarch64 devices using ACPI only.
> > > > > As first target QEMU SBSA support is added, which relies on ACPI
> > > > > only to boot an OS. As secondary target the Raspberry Pi4 was used,
> > > > > which is broadly available and allows easy testing of the proposed
> > > > > solution.
> > > > >
> > > > > The series is split into ACPI cleanups and code movements, adding
> > > > > Arm specific ACPI tables and finally SoC and mainboard related
> > > > > changes to boot a Linux on the QEMU SBSA and RPi4. Currently only the
> > > > > mandatory ACPI tables are supported, allowing to boot into Linux
> > > > > without errors.
> > > > >
> > > > > The QEMU SBSA support is feature complete and provides the same
> > > > > functionality as the EDK2 implementation.
> > > > >
> > > > > The changes were tested on real hardware as well on QEMU v9.0:
> > > > >
> > > > > qemu-system-aarch64 -machine sbsa-ref -nographic -cpu cortex-a57 \
> > > > >                     -pflash secure-world.rom \
> > > > >                     -pflash unsecure-world.rom
> > > > >
> > > > > qemu-system-aarch64 -machine raspi4b -kernel u-boot.bin -cpu cortex-a72 \
> > > > > -smp 4 -m 2G -drive file=raspbian.img,format=raw,index=0 \
> > > > > -dtb bcm2711-rpi-4-b.dtb -nographic
> > > > >
> > > > > Tested against FWTS V24.03.00.
> > > > >
> > > > > Known issues:
> > > > > - The QEMU rpi4 support is currently limited as it doesn't emulate PCI,
> > > > >   USB or ethernet devices!
> > > > > - The SMP bringup doesn't work on RPi4, but works in QEMU (Possibly
> > > > >   cache related).
> > > > > - PCI on RPI4 isn't working on real hardware since the pcie_brcmstb
> > > >
> > > > I believe the EDK2 version works by using the generic ACPI PCI driver,
> > > > why wouldn't this use the same driver?
> > > >
> > > > Overall given RPi4 has massive limitations I think at the moment it
> > > > should be dropped from the series so it doesn't block the
> > > > generic/qemu/bsa support landing. I feel it will be a support problem
> > > > with having such a reduced functionality device in mainline.
> > >
> > > Perhaps this could be handled in a follow-up? We are on v8 here.
> >
> > What exactly done in a follow up?
>
> Anything to do with the real rpi. It is far better to have a starting point.

According to the docs above the SMP bring up doesn't work and nor does
the PCI support. Users won't have a great experience and complain.

> >
> > > Who is going to support this?
> >
> > Support what?
>
> You tell me? I didn't understand your question either.

From a RPi PoV I am sure there will be complaints, as the maintainer I
get emails all the time, I don't need any more.

> >
> > > >
> > > > >   Linux kernel module doesn't support ACPI yet.
> > > > >
> > > > > Maximilian Brune (3):
> > > > >   acpi: x86: Move SPCR and DBG2 into common code
> > > > >   acpi: x86: Write FADT in common code
> > > > >   serial: serial_pl01x: Implement .getinfo() for PL01
> > > > >
> > >
> > > [..]
> > >
> > > Regards,
> > > Simon
>
> Regards,
> Simon
