Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42206EE0212
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 06:31:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A66588CCA;
	Wed, 11 Sep 2024 08:29:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="HL7pNQTI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26C5889161; Wed, 11 Sep 2024 08:29:26 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13925831A1
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 08:29:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-6d47d860fc4so46259227b3.3
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 23:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1726036163; x=1726640963; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J0YFCDL03HG0JshISijB9JDBoiHrpvTp3KdJbuZ5bJo=;
 b=HL7pNQTIxWki+5W+g5K6rHGHBiZDkVV1/Tm0ozFAWB70gOui4FvsDfj/yiupGrQe/h
 zOb7afRuaRJI96VE/PR/F2c8+OJxUhGj3kbdZ/B3J00v4EDX2eKR2zHyRaFYH3LHenGG
 rfAdUeY+EQSWr0YctHZCi7Wl1MSRpnuAESDOFEagJBbql6Ox2ts3Vib6d2jBofRvn37O
 14/vSAhNpbnBHuGHZG+GBYvuyFpjSXdiXpwPxx2ja8syJV9YZx9olLakDT0cLagiD25x
 HawdBlSp2cvOxpDrytgPjEzDUAoEK1O6f5szArc69LepKcYuCepk9AFI3SW6yhIIdOhf
 DWVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726036163; x=1726640963;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J0YFCDL03HG0JshISijB9JDBoiHrpvTp3KdJbuZ5bJo=;
 b=Sg3g8uKZQ2xPdjfbNDBbVq8eNRLRz91iy0qVzTE7RjdkCwBpGtmjIlsFJoUV+oDE01
 UcV4fIzyxcat2H6JDJDXKGckv5gvyiJQT95EkIA+rQnwJ1M9TnEjB9QY4xlmPp+8J7to
 i3b6xtp3R5aAysC9XaFf/i4kjmoUc3mWTModYXjv60qb9KXpT73i7JSvLaBr5ve3YMFh
 P0uQHlXUmyF4/6VB/Hf/+9RAffTo9vRLoSv3UpXU2i/VzhmQJyyNOIz3OuAqb3kcWw3x
 eBiJ1zbf9Zzdp+FpH/M2is86Qs1bR27SzG88a4zdIxGjDFS/HIYALOH2sH9FqhEOP9mQ
 EWzw==
X-Gm-Message-State: AOJu0YwAaQBX9mkLdIsVGB9FdlLHf4jqN/xP2yAhWwy285eKBqwMPE3q
 r9zyzG3WIK2ZIF1ZrurTCGJirbgtq5NzqGDqiYpfPQy3Hr37tKcZgjtkOeHQtCZCMl8QZiRutaK
 otbBrdCIMoWhwT5lkH3JmWuBhSfkoCenHR6bl5g==
X-Google-Smtp-Source: AGHT+IHHJHNo5BaqYVvPfNkqF0Ri8ZovKdu9Vc1XiS08ATLKORe7ARNt6cvQ3Rua70nxaajslAF87B54IAYFcAa0VHE=
X-Received: by 2002:a05:690c:39b:b0:6ac:ce34:9726 with SMTP id
 00721157ae682-6db4513b515mr177619057b3.18.1726036162864; Tue, 10 Sep 2024
 23:29:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240727071742.1735703-1-patrick.rudolph@9elements.com>
 <20240727071742.1735703-4-patrick.rudolph@9elements.com>
 <CAFLszThVGswtjS5+1T8Ot0G1LYa9p6XaZpLpX3c5vOhDAKHQqw@mail.gmail.com>
 <CALNFmy3zBpeZsofSbUuZmjkM2a5Ek=ySboGQ+ycxv8vjwRXC_Q@mail.gmail.com>
In-Reply-To: <CALNFmy3zBpeZsofSbUuZmjkM2a5Ek=ySboGQ+ycxv8vjwRXC_Q@mail.gmail.com>
From: Patrick Rudolph <patrick.rudolph@9elements.com>
Date: Wed, 11 Sep 2024 08:29:12 +0200
Message-ID: <CALNFmy2U1fg8GzR7NHmDH7L9qJLsG5XgnUoqVCqhywOFZshdng@mail.gmail.com>
Subject: Re: [PATCH 03/17] acpi: x86: Move MADT to common code
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, mbrugger@suse.com, pbrobinson@gmail.com, 
 trini@konsulko.com, bmeng.cn@gmail.com
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
On Mon, Sep 2, 2024 at 11:14=E2=80=AFAM Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> On Mon, Jul 29, 2024 at 5:28=E2=80=AFPM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Hi Patrick,
> >
> > On Sat, 27 Jul 2024 at 01:20, Patrick Rudolph
> > <patrick.rudolph@9elements.com> wrote:
> > >
> > > Write MADT in common code and let the SoC fill out the body by
> > > calling acpi_fill_madt() which must be implemented at SoC level.
> > >
> > > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > > Cc: Simon Glass <sjg@chromium.org>
> > > Cc: Bin Meng <bmeng.cn@gmail.com>
> > > ---
> > >  arch/sandbox/lib/Makefile         |  9 +++---
> > >  arch/sandbox/lib/acpi_table.c     |  7 +++++
> > >  arch/x86/cpu/intel_common/acpi.c  | 20 +++++++++-----
> > >  arch/x86/cpu/tangier/acpi.c       |  6 +++-
> > >  arch/x86/include/asm/acpi_table.h |  3 +-
> > >  arch/x86/lib/acpi_table.c         | 46 ++++++-----------------------=
--
> > >  include/acpi/acpi_table.h         | 11 ++++++++
> > >  lib/acpi/acpi_table.c             | 31 +++++++++++++++++++++
> > >  8 files changed, 81 insertions(+), 52 deletions(-)
> > >  create mode 100644 arch/sandbox/lib/acpi_table.c
> >
> > Same comment as previous patch.
> While it might be possible to write out GICC and LAPIC or X2APIC using
> a CPU driver,
> how would the other sub-tables integrate into the acpi_ops?
>
> On x86 you have ioapic and irq_overrides and on arm GICR and ITS sub-tabl=
es.
> Would I need to add "Interrupt controller" drivers for each platform,
> fill it with platform specific data
> and then fill out the MADT table using acpi_ops?
>
> While that seems nice to have, it would be quite a lot of work, since
> none of the interface
> or drivers exists at the moment.
> It even looks like not all platforms even use a CPU driver and even
> less use an interrupt controller
> driver...
>
I've implemented this in the latest patch series v3.
See commit "drivers/arm: Implement acpi_fill_madt" that implements the
driver model
fill_madt for arm and allows to use it on QEMU SBSA. Other platforms
are still using the
"old" approach until they have been ported to the driver model.

> >
> > Regards,
> > Simon
