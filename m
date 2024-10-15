Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53BCCD216A2
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 13:34:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3F82881A5;
	Tue, 15 Oct 2024 15:34:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HQzAXZUc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79B23881A5; Tue, 15 Oct 2024 15:34:43 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8378C8814D
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 15:34:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5c9634c9160so3265273a12.2
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 06:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728999281; x=1729604081; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IKcAy8n8diF0z5bEEZh/hGHSSyUUINkAmLAJ0RX4z7M=;
 b=HQzAXZUc+XS/Zqg1s6/IVW0pCPKAKjiidXkAdjVL24D1/ACYKmRmYIPfRMYvquKTNM
 AbVdt7opbEEVmdSWCU7fsJj7TLfEmi2bbK46BBSyieQEECoTnd0RXpaDTo8B4pEH5KHq
 r5MP9pNj0PKxbXLGJF0ph6uEjFc8JTnV79bDfV7OjjQ/EYL0i5Dbz3uQsImHyM+JZ3kb
 RLjjDCKzcICIaEjtnICoflUJG/XxRzhAwbqYPCkk8tx7FIAvJvsorb/lOdigddFg38aX
 Z/kqYnUmLcEXUYi3nqcbpE08bZhfKl/O7FMyJDPTcajLQK+YW4pEoW6Tyg2OVyZtzXQM
 qXrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728999281; x=1729604081;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IKcAy8n8diF0z5bEEZh/hGHSSyUUINkAmLAJ0RX4z7M=;
 b=SK08hbMkuf9t7RUV3MmrFdkPKhoXT59wPDYX4ou7KZS2gQahrDBPBBxXUDx57qS0Zs
 /zQX0PvRKZgVl7pE7GgR7FmEnEIPQbcZyNE6+D65fJeFVAs5hE4xEn+WwXVl3mm6qC4u
 YtTf5lXlL/ul7kbdQu7qMSKy33Zl9B5rQJJis2i4Tqd3zQXFzyc+6i6KlOUTVMZ8IQ1e
 FsCf3LXqIr6bDzciParqlD1FHXOB+d/5SNK+FRPDQ0eoExmIt9Gga+lig6gjKmMYK+UI
 i6jA72MT+TZ8+NSgissLx8eDb3MD/rUDVOUDUZoiulLP1M2iG2i7GFDmn1GWYDeZ2tb5
 q30A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpxUDKSxVPAJTzmJcbYdXni6lIiQSs2QRRpytplj6qkCbkqnhMgU25gM1sMBYpfR8kRyvcCRo=@lists.denx.de
X-Gm-Message-State: AOJu0YxFUcnA/be7Zjpm8UotBToeRXu30oERQRkD559QjCSRTwjlhpy6
 +PtVSnJFbWd1Ko5NjNpXQ2IDZhx8qwrb7w/eh+CPti4fEqJskeyC2NrAtLo2sijphiTDmQAaepx
 ztAurNoiZ2s0yX9ilDhVEGF/AZn+gag==
X-Google-Smtp-Source: AGHT+IGmJXnwYb5SjQCkx0enokI632skmw7ZdR9ceLjGwHIhhDPhV4ENRC+i8lMta5Ic1Lo5+zLWZZAxh7t7VSrJSQQ=
X-Received: by 2002:a05:6402:1e89:b0:5c9:625c:f82a with SMTP id
 4fb4d7f45d1cf-5c9950b98femr219671a12.1.1728999280669; Tue, 15 Oct 2024
 06:34:40 -0700 (PDT)
MIME-Version: 1.0
References: <20241014131152.267405-1-patrick.rudolph@9elements.com>
 <CALeDE9NkB1kNdnEbsXLyzfQ53PNvV2unnzeMcTgpTKtySh=XcA@mail.gmail.com>
 <CAFLszTg94CCWi=K8ViX=Oxqq1bmW2VuQ-eOqdD9QYEj5U=GLBQ@mail.gmail.com>
In-Reply-To: <CAFLszTg94CCWi=K8ViX=Oxqq1bmW2VuQ-eOqdD9QYEj5U=GLBQ@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 15 Oct 2024 14:34:29 +0100
Message-ID: <CALeDE9P-80UYBd=y3FhA+Gnv+5Mz51p5SMRO+0MTGvvx4V_+Zw@mail.gmail.com>
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

On Tue, 15 Oct 2024 at 14:10, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Peter,
>
> On Tue, 15 Oct 2024 at 04:28, Peter Robinson <pbrobinson@gmail.com> wrote:
> >
> > On Mon, 14 Oct 2024 at 14:12, Patrick Rudolph
> > <patrick.rudolph@9elements.com> wrote:
> > >
> > > Based on the existing work done by Simon Glass this series adds
> > > support for booting aarch64 devices using ACPI only.
> > > As first target QEMU SBSA support is added, which relies on ACPI
> > > only to boot an OS. As secondary target the Raspberry Pi4 was used,
> > > which is broadly available and allows easy testing of the proposed
> > > solution.
> > >
> > > The series is split into ACPI cleanups and code movements, adding
> > > Arm specific ACPI tables and finally SoC and mainboard related
> > > changes to boot a Linux on the QEMU SBSA and RPi4. Currently only the
> > > mandatory ACPI tables are supported, allowing to boot into Linux
> > > without errors.
> > >
> > > The QEMU SBSA support is feature complete and provides the same
> > > functionality as the EDK2 implementation.
> > >
> > > The changes were tested on real hardware as well on QEMU v9.0:
> > >
> > > qemu-system-aarch64 -machine sbsa-ref -nographic -cpu cortex-a57 \
> > >                     -pflash secure-world.rom \
> > >                     -pflash unsecure-world.rom
> > >
> > > qemu-system-aarch64 -machine raspi4b -kernel u-boot.bin -cpu cortex-a72 \
> > > -smp 4 -m 2G -drive file=raspbian.img,format=raw,index=0 \
> > > -dtb bcm2711-rpi-4-b.dtb -nographic
> > >
> > > Tested against FWTS V24.03.00.
> > >
> > > Known issues:
> > > - The QEMU rpi4 support is currently limited as it doesn't emulate PCI,
> > >   USB or ethernet devices!
> > > - The SMP bringup doesn't work on RPi4, but works in QEMU (Possibly
> > >   cache related).
> > > - PCI on RPI4 isn't working on real hardware since the pcie_brcmstb
> >
> > I believe the EDK2 version works by using the generic ACPI PCI driver,
> > why wouldn't this use the same driver?
> >
> > Overall given RPi4 has massive limitations I think at the moment it
> > should be dropped from the series so it doesn't block the
> > generic/qemu/bsa support landing. I feel it will be a support problem
> > with having such a reduced functionality device in mainline.
>
> Perhaps this could be handled in a follow-up? We are on v8 here.

What exactly done in a follow up?

> Who is going to support this?

Support what?

> >
> > >   Linux kernel module doesn't support ACPI yet.
> > >
> > > Maximilian Brune (3):
> > >   acpi: x86: Move SPCR and DBG2 into common code
> > >   acpi: x86: Write FADT in common code
> > >   serial: serial_pl01x: Implement .getinfo() for PL01
> > >
>
> [..]
>
> Regards,
> Simon
