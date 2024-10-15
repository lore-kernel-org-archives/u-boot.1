Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8416ECFC27C
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 15:28:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A315488A47;
	Tue, 15 Oct 2024 17:28:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="n3w9R+lp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEDFC889B8; Tue, 15 Oct 2024 17:28:05 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BB9688BC2
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 17:28:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6cbcc2bd800so48434836d6.0
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 08:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729006082; x=1729610882; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=48/0LfUH2dbnydNBOE5L/+6aORYrJtN4e6yrC1RXyl0=;
 b=n3w9R+lp4pn6hknGTGCJzFfxziLOva8feHZoxUxNhogxd4hmO8KOD4WWbovum9852h
 /aUs1LjD3zt+62JnjHTRtfjQ3bhfCgmNDvO6xRnuHqv8+HoBM+UbOuqc4QkYCINXXtd8
 CpSWpoXbiL7cpIvtnWl9fCKBYQ3PgBAvDOWdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729006082; x=1729610882;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=48/0LfUH2dbnydNBOE5L/+6aORYrJtN4e6yrC1RXyl0=;
 b=sHYJhV+tTAEQyfiwZTcPlgPfUBmcVhGaGDTGlwCX5PR54xfeLhpYXkc4R7ouPX3O3d
 pnzW0/szwpbvWutmuAe7V39jRLqogofyJJW6/8Oal/IbudKVhmB6olnblW0zQ56OQunb
 AGyiRfe+yNRI9Cc/tGFMpkeJUIO85zavMTzvl/K1dR3AoLK+uESWT/rlIDXTTZbGD6ju
 VVYs1rZ1BoQEcxq2UNGQMd69+HcnO3ZgqAcQxenOt15cBw9Vtd5/IygUo/vVGL+qk/Ym
 yegBTwbsS55M4chQkOmBAUJN/0ua2Pf3H8rS3xSw7gxptL0kR/3Zc2BUsQw1C5V+9QUL
 d0ew==
X-Forwarded-Encrypted: i=1;
 AJvYcCUl32/e0eQTts3FwTW43TsUyhlWrtHfqX5Buwx05toLzgU+2MUzFi5HJFMJ/Xk3n+VYDQgJhwE=@lists.denx.de
X-Gm-Message-State: AOJu0YyueIU+zblTd7ypiJ3X6DXNogX/3nGh+s8D+PNneSLuZpB9+O5V
 /xYCAw1QmmkYVx1YyxUr0gfE6ZmzIcx4qN3r5PaKQEB0l/s+nQyhEQ8zTShQWcLG//1SwH+bwaj
 wiHGVABT8oDzNCTYktQa7slp3ndLDE+zNdw7M6vZIMsrjXY8=
X-Google-Smtp-Source: AGHT+IEw5brrX7CZG02/lXplQjxFhuMlp2kl1csFsihp7y08IR1M2ka7zyren+f1r/ywVC9AvDwb/pPLgmi2sKrHBsc=
X-Received: by 2002:a05:6214:2c12:b0:6c5:944f:ea5a with SMTP id
 6a1803df08f44-6cbefabadd8mr238647346d6.13.1729006082237; Tue, 15 Oct 2024
 08:28:02 -0700 (PDT)
MIME-Version: 1.0
References: <20241014131152.267405-1-patrick.rudolph@9elements.com>
 <CALeDE9NkB1kNdnEbsXLyzfQ53PNvV2unnzeMcTgpTKtySh=XcA@mail.gmail.com>
 <CAFLszTg94CCWi=K8ViX=Oxqq1bmW2VuQ-eOqdD9QYEj5U=GLBQ@mail.gmail.com>
 <CALeDE9P-80UYBd=y3FhA+Gnv+5Mz51p5SMRO+0MTGvvx4V_+Zw@mail.gmail.com>
In-Reply-To: <CALeDE9P-80UYBd=y3FhA+Gnv+5Mz51p5SMRO+0MTGvvx4V_+Zw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 15 Oct 2024 09:27:51 -0600
Message-ID: <CAFLszTh+CeC8MUEM6a2gsCDEVPeN1QuKU_mPUMCR+vFkZSo4hQ@mail.gmail.com>
Subject: Re: [PATCH v8 00/37] Implement ACPI on aarch64
To: Peter Robinson <pbrobinson@gmail.com>
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

Hi Peter,

On Tue, 15 Oct 2024 at 07:34, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> On Tue, 15 Oct 2024 at 14:10, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Peter,
> >
> > On Tue, 15 Oct 2024 at 04:28, Peter Robinson <pbrobinson@gmail.com> wrote:
> > >
> > > On Mon, 14 Oct 2024 at 14:12, Patrick Rudolph
> > > <patrick.rudolph@9elements.com> wrote:
> > > >
> > > > Based on the existing work done by Simon Glass this series adds
> > > > support for booting aarch64 devices using ACPI only.
> > > > As first target QEMU SBSA support is added, which relies on ACPI
> > > > only to boot an OS. As secondary target the Raspberry Pi4 was used,
> > > > which is broadly available and allows easy testing of the proposed
> > > > solution.
> > > >
> > > > The series is split into ACPI cleanups and code movements, adding
> > > > Arm specific ACPI tables and finally SoC and mainboard related
> > > > changes to boot a Linux on the QEMU SBSA and RPi4. Currently only the
> > > > mandatory ACPI tables are supported, allowing to boot into Linux
> > > > without errors.
> > > >
> > > > The QEMU SBSA support is feature complete and provides the same
> > > > functionality as the EDK2 implementation.
> > > >
> > > > The changes were tested on real hardware as well on QEMU v9.0:
> > > >
> > > > qemu-system-aarch64 -machine sbsa-ref -nographic -cpu cortex-a57 \
> > > >                     -pflash secure-world.rom \
> > > >                     -pflash unsecure-world.rom
> > > >
> > > > qemu-system-aarch64 -machine raspi4b -kernel u-boot.bin -cpu cortex-a72 \
> > > > -smp 4 -m 2G -drive file=raspbian.img,format=raw,index=0 \
> > > > -dtb bcm2711-rpi-4-b.dtb -nographic
> > > >
> > > > Tested against FWTS V24.03.00.
> > > >
> > > > Known issues:
> > > > - The QEMU rpi4 support is currently limited as it doesn't emulate PCI,
> > > >   USB or ethernet devices!
> > > > - The SMP bringup doesn't work on RPi4, but works in QEMU (Possibly
> > > >   cache related).
> > > > - PCI on RPI4 isn't working on real hardware since the pcie_brcmstb
> > >
> > > I believe the EDK2 version works by using the generic ACPI PCI driver,
> > > why wouldn't this use the same driver?
> > >
> > > Overall given RPi4 has massive limitations I think at the moment it
> > > should be dropped from the series so it doesn't block the
> > > generic/qemu/bsa support landing. I feel it will be a support problem
> > > with having such a reduced functionality device in mainline.
> >
> > Perhaps this could be handled in a follow-up? We are on v8 here.
>
> What exactly done in a follow up?

Anything to do with the real rpi. It is far better to have a starting point.

>
> > Who is going to support this?
>
> Support what?

You tell me? I didn't understand your question either.

>
> > >
> > > >   Linux kernel module doesn't support ACPI yet.
> > > >
> > > > Maximilian Brune (3):
> > > >   acpi: x86: Move SPCR and DBG2 into common code
> > > >   acpi: x86: Write FADT in common code
> > > >   serial: serial_pl01x: Implement .getinfo() for PL01
> > > >
> >
> > [..]
> >
> > Regards,
> > Simon

Regards,
Simon
