Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8A50D216A2
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 13:10:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 140778839A;
	Tue, 15 Oct 2024 15:10:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WROwR6Jl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E149088365; Tue, 15 Oct 2024 15:10:44 +0200 (CEST)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6B5D88009
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 15:10:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-4603ee602a0so42918711cf.2
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 06:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728997842; x=1729602642; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZMkMZUnmo3GMpSbLftqux+2JbHjnqd97xduE19vrKyg=;
 b=WROwR6JlEetjZAI/Asx+p98tnhxggdOVCvfb+ZsGBOdS73Qp5fTFsIiXU6Lo/Vkaxl
 7aQhhSKpVmPQQBif+FBfkuhcpr9BUkOjgC7rCSRTEiuSdVghrpUnNoL9aBVYYroymPBO
 lR4nc7n8K7PDGGEMzwMxv4Elmwtl+kFQpuLxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728997842; x=1729602642;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZMkMZUnmo3GMpSbLftqux+2JbHjnqd97xduE19vrKyg=;
 b=M+Ys/ZPQG4ZgE6TI/H2o6rchLSvNFry5jgtD/sEsyviMsHP6wrpgLwyEOv3F9bkrh8
 a6BfIjCKpElU49M3nuD0t6heKkvgfjTYlQKkQDfrpSfrI/d1IewFNO84Ll7QKlEdAFNV
 4XwxOFYD+qIJahmUFfAdHPc9Xx6xDTrBawI0L9xFl3h31zHHdnTI/UsGcaNynLblkmRq
 hkbrZdrzJl/TCy+g3glMTDNp5MIoFoXu4KRMtQ+XvJkEKBhPH5KnU3+WEZgMletxhd38
 cVxRtND6pwUNFoHBcn5XfKjm4AG0nfVgoTbseXzfpyyIgg1fo0PXOc5rnvIJ8SS/jUO4
 JMAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlzh6WjCOQlw33iNhGjovsajsjTszPmN+j3IoKx8Ndc62QTfQkrdpDYuFybrbNEwOehD94zGs=@lists.denx.de
X-Gm-Message-State: AOJu0YxJs85K2q6lDgbaJErysrvJeHb9omQCzX0ZqdBnKcDXGFyS/ZSl
 I06Wvjkn89ZtcJ1tdG0byhWFl4R6DA13aTixPfYwq0MbkAwSEF+Q6SGNDo6LaHFj7TfPfFQ4MqZ
 JWH3/RbA3NIe+qgOq9deJ4jo0R5gxM9QwGaEPophRT067xvE=
X-Google-Smtp-Source: AGHT+IEW8WUQ4gz2sTp7EPbg9Ck4Jvq30T6OXRHK4HMrplDHOEZNFn4+rEKcpIZcG8G9ScfLi69T8HKqGXN4R/vOWu4=
X-Received: by 2002:a05:6214:3101:b0:6cb:f9aa:9726 with SMTP id
 6a1803df08f44-6cbf9aaa248mr169037196d6.11.1728997841645; Tue, 15 Oct 2024
 06:10:41 -0700 (PDT)
MIME-Version: 1.0
References: <20241014131152.267405-1-patrick.rudolph@9elements.com>
 <CALeDE9NkB1kNdnEbsXLyzfQ53PNvV2unnzeMcTgpTKtySh=XcA@mail.gmail.com>
In-Reply-To: <CALeDE9NkB1kNdnEbsXLyzfQ53PNvV2unnzeMcTgpTKtySh=XcA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 15 Oct 2024 07:10:31 -0600
Message-ID: <CAFLszTg94CCWi=K8ViX=Oxqq1bmW2VuQ-eOqdD9QYEj5U=GLBQ@mail.gmail.com>
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

On Tue, 15 Oct 2024 at 04:28, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> On Mon, 14 Oct 2024 at 14:12, Patrick Rudolph
> <patrick.rudolph@9elements.com> wrote:
> >
> > Based on the existing work done by Simon Glass this series adds
> > support for booting aarch64 devices using ACPI only.
> > As first target QEMU SBSA support is added, which relies on ACPI
> > only to boot an OS. As secondary target the Raspberry Pi4 was used,
> > which is broadly available and allows easy testing of the proposed
> > solution.
> >
> > The series is split into ACPI cleanups and code movements, adding
> > Arm specific ACPI tables and finally SoC and mainboard related
> > changes to boot a Linux on the QEMU SBSA and RPi4. Currently only the
> > mandatory ACPI tables are supported, allowing to boot into Linux
> > without errors.
> >
> > The QEMU SBSA support is feature complete and provides the same
> > functionality as the EDK2 implementation.
> >
> > The changes were tested on real hardware as well on QEMU v9.0:
> >
> > qemu-system-aarch64 -machine sbsa-ref -nographic -cpu cortex-a57 \
> >                     -pflash secure-world.rom \
> >                     -pflash unsecure-world.rom
> >
> > qemu-system-aarch64 -machine raspi4b -kernel u-boot.bin -cpu cortex-a72 \
> > -smp 4 -m 2G -drive file=raspbian.img,format=raw,index=0 \
> > -dtb bcm2711-rpi-4-b.dtb -nographic
> >
> > Tested against FWTS V24.03.00.
> >
> > Known issues:
> > - The QEMU rpi4 support is currently limited as it doesn't emulate PCI,
> >   USB or ethernet devices!
> > - The SMP bringup doesn't work on RPi4, but works in QEMU (Possibly
> >   cache related).
> > - PCI on RPI4 isn't working on real hardware since the pcie_brcmstb
>
> I believe the EDK2 version works by using the generic ACPI PCI driver,
> why wouldn't this use the same driver?
>
> Overall given RPi4 has massive limitations I think at the moment it
> should be dropped from the series so it doesn't block the
> generic/qemu/bsa support landing. I feel it will be a support problem
> with having such a reduced functionality device in mainline.

Perhaps this could be handled in a follow-up? We are on v8 here.

Who is going to support this?

>
> >   Linux kernel module doesn't support ACPI yet.
> >
> > Maximilian Brune (3):
> >   acpi: x86: Move SPCR and DBG2 into common code
> >   acpi: x86: Write FADT in common code
> >   serial: serial_pl01x: Implement .getinfo() for PL01
> >

[..]

Regards,
Simon
