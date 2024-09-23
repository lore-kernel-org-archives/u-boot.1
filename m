Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AE76CF9C6F
	for <u-boot@archiver.kernel.org>; Mon, 23 Sep 2024 06:29:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66F0A87C69;
	Mon, 23 Sep 2024 08:29:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="drB+kwym";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A39F87C69; Mon, 23 Sep 2024 08:29:16 +0200 (CEST)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49F6788D13
 for <u-boot@lists.denx.de>; Mon, 23 Sep 2024 08:29:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-6ddce91cab2so34055867b3.0
 for <u-boot@lists.denx.de>; Sun, 22 Sep 2024 23:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1727072952; x=1727677752; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mIO+Ijue4D+UMSInpz0lPFACsi5v3b08qKid+jnOxEc=;
 b=drB+kwymJnhcvhKvEahKcVkxO7+pwPi3MdwFA3KrRLmUGEC+n2ALCj0gBnsX1xJjGj
 3eBAXPQ5kOSpi/BROhenEyZLFSBP5qjcQXXSlBogmTnmLvFYvq5HgvV+ATyEmEqjgfbf
 jl5UQd0iYG5uMzcJ4eI6O2P491PYS90vAqaaZ3yxSBqM0xuyOIo+4hQnd+UxtzouTAsI
 Bp4OmKefPzYw2JZqIupIqo/S9wGtWOYM5Cz0U7PmYSxBE/9n/E4nCHkmZ/M0dmUN8L52
 0JeJTlTGeKfwgo8sxotmHL2iigQJqzMKNxFaKY/GNtV4W3l7MU/+xlRox9TXV2nCUy7n
 GufQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727072952; x=1727677752;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mIO+Ijue4D+UMSInpz0lPFACsi5v3b08qKid+jnOxEc=;
 b=bJtvpQHZT0QZ4NjgstwdXAj7yFhofFF+YGDsllY1QFo/xK5lBUwWkOn7PBjswHeIzL
 9K0DHxIg7tR5T7Utnj+fNBmCWeei6WemugMKS+V4tey+EbKxKY1od9uvzVi0HE1PnvfO
 OIcgwtyXiPKFUUBio9bI+pP8V3RlbBf3zxH54YrzA9y7ks3PSEeoV3SIEhZAoIGPYwvY
 ciUhXEQJgNbSavxBsGtcuvF4NayxH3L5rXIZmpbsTbIbYnWKXK9hiQ7IccWBcB74B5Rt
 sRByRPhY/ND79Wcr+nDtITKN13YVzwuQTFRln9cWLzqjGPeIWjXM3GprcoDMIwnEVK6B
 0eew==
X-Gm-Message-State: AOJu0Yzbsb3Awm+UYH7u0aqVFz1rTel62+qBI58Ha87xxxK8jzZSPUES
 LcdZUbeVPUArmnydzHQ30o0gxuZzTVUe8+VBXrJ6EGEhyKwfT/E8lKdN5fAr/fbSY7RmFAnvJ4s
 4DSvhhU6sE1cdSRoxTdAtfztwv+Od4rwWNqcJ6w==
X-Google-Smtp-Source: AGHT+IEqwzgzClPzkJ02hMz1Gs40ujEFaqy3Mr1CQydcfl2HXaWeUOP872VYj/6hHdes7ubcRWRIAWm2xMgy2r3vw14=
X-Received: by 2002:a05:690c:660b:b0:6dd:cdb9:cf2a with SMTP id
 00721157ae682-6dff2710861mr75950627b3.1.1727072952132; Sun, 22 Sep 2024
 23:29:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
 <20240918152136.3395170-31-patrick.rudolph@9elements.com>
 <CAFLszTgQstN5GvJtMf0vXLzvBFxqZFmFRXRGprG-ZcSEAXy=+Q@mail.gmail.com>
In-Reply-To: <CAFLszTgQstN5GvJtMf0vXLzvBFxqZFmFRXRGprG-ZcSEAXy=+Q@mail.gmail.com>
From: Patrick Rudolph <patrick.rudolph@9elements.com>
Date: Mon, 23 Sep 2024 08:29:01 +0200
Message-ID: <CALNFmy02bwKJihwuKvpuJDP4hSRnDcMRuJXiMsUtHZwqLmYmvw@mail.gmail.com>
Subject: Re: [PATCH v4 30/35] arm: cpu: Add ACPI parking protocol support
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

Hi Simon,
On Thu, Sep 19, 2024 at 4:09=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> On Wed, 18 Sept 2024 at 17:23, Patrick Rudolph
> <patrick.rudolph@9elements.com> wrote:
> >
> > On Arm platforms that use ACPI they cannot rely on the "spin-table"
> > CPU bringup usually defined in the FDT. Thus implement the
> > 'ACPI Multi-processor Startup for ARM Platforms', also referred to as
> > 'ACPI parking protocol'.
> >
> > The ACPI parking protocol works similar to the spin-table mechanism, bu=
t
> > the specification also covers lots of shortcomings of the spin-table
> > implementations.
> >
> > Every CPU defined in the ACPI MADT table has it's own 4K page where the
> > spinloop code and the OS mailbox resides. When selected the U-Boot boar=
d
> > code must make sure that the secondary CPUs enter u-boot after relocati=
on
> > as well, so that they can enter the spinloop code residing in the ACPI
> > parking protocol pages.
> >
> > The OS will then write to the mailbox and generate an IPI to release th=
e
> > CPUs from the spinloop code.
> >
> > For now it's only implemented on ARMv8, but can easily be extended to
> > other platforms, like ARMv7.
> >
> > TEST: Boots all CPUs on qemu-system-aarch64 -machine raspi4b
> >
> > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > Cc: Simon Glass <sjg@chromium.org>
> > Cc: Tom Rini <trini@konsulko.com>
> > ---
> > Changelog v2:
> > - Use shorter function names
> > - Drop the use of atomics, they do not work on real hardware
> > - Rewrite code and verify on real hardware that CPUs are spinning
> >   inside their parking protocol spin-loop code
> > Changelog v4:
> > - Shorten names
> > - Fix coding style
> > - Drop extern from the headers
> > ---
> >  arch/arm/cpu/armv8/Makefile       |   1 +
> >  arch/arm/cpu/armv8/acpi_park_v8.S | 113 ++++++++++++++++++++++
> >  arch/arm/include/asm/acpi_table.h |  32 +++++++
> >  arch/arm/lib/acpi_table.c         | 149 ++++++++++++++++++++++++++++++
> >  include/acpi/acpi_table.h         |  10 ++
> >  include/bloblist.h                |   1 +
> >  lib/Kconfig                       |  16 ++++
> >  lib/acpi/acpi_table.c             |   4 +

There's something missing here...
Is it reviewed by you?
