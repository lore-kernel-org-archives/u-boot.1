Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5950BC2BB3F
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 00:47:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE1238751C;
	Sun, 19 Nov 2023 01:45:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DrI+0cmB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28D40870E3; Sun, 19 Nov 2023 01:44:18 +0100 (CET)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AE8D874BA
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 01:43:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-da41acaea52so3073035276.3
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 16:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700354638; x=1700959438; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JNcHyFcDe31ciAtZ4OGBH8RgC6ZeirHWcTuefvMocvs=;
 b=DrI+0cmBA9tmZH21LOd0x2aDAr9JMqfMmG39DhWOo7DdLodkkwzUA74fwVFI3pI1t+
 77GINbyT1RwRkTXLH5ZY8CetyanB43j4BWcgmoHdZx0CXW3GE5hh1oW4vS8YspPHekKE
 TqcAk01AKBgY8ZNajhUT8DB9I+qVmJqVibNbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700354638; x=1700959438;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JNcHyFcDe31ciAtZ4OGBH8RgC6ZeirHWcTuefvMocvs=;
 b=UwIO1cz8bLc+F4nRAR6Yz54TKrCIjgqrAo6iPHC7IjiOFsWkfzt/l6noH/hPDDUmZ0
 BDCi/+UBmKLmXxfabQP2NBO9BG0sQBXmMPbUUSV7Z59bXMiMi97ct0ClSgP/OiSPnn2b
 6AD3ecXXYiOjFtsxDpYizy8F4xD731lvXpSTodFgum9Aja9jgLTH/lm8juxFmIdEhNXB
 K9GR6UZvZzsqsyDBmXBqTlewSQLXOIWJ5nN0kzhLEfdvpKkzl7V6WkBo6sInGDqPP8AG
 1r1C+DiBJ/tYp5qXBLBz+iojmXxj7sRM4L+YIBmlRqzro3ekZClNi6tXwMrCZWObjNha
 +N8w==
X-Gm-Message-State: AOJu0YyOZ2cc0lwJxOlwUkTAF++GtsvrEt6BX/zxkCVVudthPzaoIFSX
 9/Qpr8fHy9VwqmzcwhOCuNK/Vg1FpQFBFEpitXeEyw==
X-Google-Smtp-Source: AGHT+IFlcwryl4ltfKCptI6jJq6Tw3YqhylE2/LHTt4qJ4E0s+yYjenSwcWWH4r52D0C1gx0CE716KbxM8NbVcnjdo8=
X-Received: by 2002:a25:e30f:0:b0:da0:84b2:5e3e with SMTP id
 z15-20020a25e30f000000b00da084b25e3emr3201007ybd.21.1700354637901; Sat, 18
 Nov 2023 16:43:57 -0800 (PST)
MIME-Version: 1.0
References: <20231116092928.21633-1-heinrich.schuchardt@canonical.com>
 <CAPnjgZ27mmK9BYE=rbGKGe9=xvZdG9reU659n-0D_wRfNemX5Q@mail.gmail.com>
 <3dd07df2-a261-47e6-9627-34e4529584c4@canonical.com>
 <CAPnjgZ2kFYiQuwzw5GP8OJteKhhGVRqdnNtAGY5v-C+3c-KZ+A@mail.gmail.com>
 <189ebb7f-5b25-475e-b180-8b8d8c21b55f@canonical.com>
In-Reply-To: <189ebb7f-5b25-475e-b180-8b8d8c21b55f@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 18 Nov 2023 17:43:11 -0700
Message-ID: <CAPnjgZ1P91W_05L9aK5-vrEp-tuJO==whWx+p7z20wm9k=YakA@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: create memory reservations in ACPI case
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
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

Hi Heinrich,

On Sat, 18 Nov 2023 at 16:06, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 11/18/23 18:58, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On Sat, 18 Nov 2023 at 10:34, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >> On 11/18/23 18:10, Simon Glass wrote:
> >>> Hi Heinrich,
> >>>
> >>> On Thu, 16 Nov 2023 at 02:29, Heinrich Schuchardt
> >>> <heinrich.schuchardt@canonical.com> wrote:
> >>>>
> >>>> ACPI tables cannot convey memory reservations for least ARM and RISC-V.
> >>>> x86 uses the BIOS E820 table for this purpose. We cannot simply ignore the
> >>>> device-tree when booting via ACPI.
> >>>
> >>> Why is that? I had thought that we had to use one or the other. Isn't
> >>> the devicetree irrelevant when booting with ACPI, so we can just drop
> >>> it?
> >>
> >> Linux Documentation/arch/arm64/acpi_object_usage.rst, line 718f
> >> describes the mechanism to convey memory information as follows:
> >>
> >> "For arm64, we will only support UEFI for booting with ACPI, hence the
> >> UEFI GetMemoryMap() boot service is the only mechanism that will be used."
> >>
> >> With the patch we tell the UEFI sub-system which memory areas are
> >> reserved (e.g. for TF-A on ARM or for OpenSBI on RISC-V). This
> >> information is inferred from the device-tree. The operating system will
> >> collect this information by calling GetMemoryMap() immediately before
> >> ExitBootServices().
> >>
> >> Without the patch Linux on RISC-V using ACPI crashed when illegally
> >> accessing the memory reserved for OpenSBI.
> >
> > OK thank you, I misunderstood it.
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> >
> > Perhaps someone could convert efi_carve_out_dt_rsv() to use the ofnode API?
>
> Is there any ofnode API to retrieve reservations as easily as with
> fdt_get_mem_rsv(), fdt_num_mem_rsv()?

Not yet :-)

>
> boot/image-fdt.c, boot/fdt_region.c, boot/fdt_support.c, cmd/fdt.c all
> use the libfdt API directly.

Yes, but it is starting to change. Ultimately we will likely use
livetree for fixups due to efficiency.

Regards,
Simon
