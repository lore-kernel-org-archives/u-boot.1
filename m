Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93189C02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 13:19:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 131EE80714;
	Wed, 15 Jan 2025 14:19:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JbX6OJqf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C03680703; Wed, 15 Jan 2025 14:19:41 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62EE0806FB
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 14:19:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-aaee0b309adso1091083066b.3
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 05:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736947179; x=1737551979; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WZmxD4DQfT0uGotCd6Mblngf0y+91OJCRK5UmOMTbVw=;
 b=JbX6OJqf/0dShIjKPySIbShInYauCzWMkz0Nxc7+N06T+Y7QwsZtzvB1z2nqwn1Dr0
 DDELsmkk31RJYx7k1CzWUCNvoNOQMqlzb1TnzCuxquFN4g3/X/8PH7E0tSILBHwDvdqZ
 BEQOQ6wT0lhOS+06HiP47diidYDyscpA/9OcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736947179; x=1737551979;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WZmxD4DQfT0uGotCd6Mblngf0y+91OJCRK5UmOMTbVw=;
 b=WGgChcz0v9SLObvsdmFRYW+u68GvpSKo0/l9L5wPJ/f8rFaBDFe+D/vpN4oPq/zyNa
 zd+huedWTiatyxlSwSAh+9EkpI3/p8+mghTnnYGmQ57PcAq95cSFXxhpR0Ng7T92iR0S
 CaLI58/VubOfA7CYavvxL3H+8sbKBlaudcdFppyzIABgx6WJvyj/C48xvzuh+dcv4lIx
 jjGG+IYVnWBDHZ8OA3V7tj252xTsQpTk0g+g9971pHy0zI+xQMDkHcjfkt0I2Ivi85Ub
 VVtj+OEuJobp1N6rXaA7hsrCAfDVdr+z319cNx3y9DarMqxbuJsokGamOOJd0R39yW+c
 BXHQ==
X-Gm-Message-State: AOJu0YzurVLXyQL7j80wGasyjcPUtEPVWVME2v5hku9m/SDpzLpWtcet
 Q+VbLaE1At9cAXzKweMk3FyJgXr/eAsEgIsKs3rHlsYLkNGrmrlbz3ZK1Se5RQfebrYYm0aagEZ
 HZcwsh6Q3eYTTNUjz96m5iwZe9hgw8X8FbB08
X-Gm-Gg: ASbGncuVZexgEC4Ps2qI3/vdgNVTrPOWBNPJTKt+3a3r8TrKkGUUd7apBWmr0Nw75gw
 CEGdkKA/F8dGkqnp3Vu8KHBwBNEweqtxiC1I9Btk=
X-Google-Smtp-Source: AGHT+IHM8f3HdkKXmmOJ1hX5TcNK1qFadLbp4Sg94Ig18A1h1JONw0pN4xuPm8gx2lt5776/1VoMcqFj5v926p7S6nE=
X-Received: by 2002:a17:907:d1b:b0:aac:23f4:f971 with SMTP id
 a640c23a62f3a-ab2ab70a173mr3045980166b.33.1736947178832; Wed, 15 Jan 2025
 05:19:38 -0800 (PST)
MIME-Version: 1.0
References: <20241220040120.3245610-1-sjg@chromium.org>
 <20241220040120.3245610-4-sjg@chromium.org>
 <a1572755-9853-4941-ac0f-3a30bce768a3@cherry.de>
 <CAFLszTi0CToKb8zLC1tRXW0XabQTAEQeT3PUZbR9YRybr9R9DA@mail.gmail.com>
 <c2c5dee2-a8a7-4a1d-bd62-208c39db3b15@cherry.de>
In-Reply-To: <c2c5dee2-a8a7-4a1d-bd62-208c39db3b15@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 15 Jan 2025 06:19:26 -0700
X-Gm-Features: AbW1kvYmD6qkp3bx6ciYBdJO94Q25AjC7A-i_nbV17F_EBKIzrRSZTvdiaWj1fY
Message-ID: <CAFLszTjUgW0ffd-vh3VnHa5g7sKtoPbDGaDZ7JKtNCt=2n0r2g@mail.gmail.com>
Subject: Re: [PATCH 3/5] pxe_utils: Allow the FDT to be missing
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, Tom Rini <trini@konsulko.com>
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

Hi Quentin,

On Wed, 15 Jan 2025 at 04:59, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Simon,
>
> On 1/15/25 2:16 AM, Simon Glass wrote:
> > Hi Quentin,
> >
> > On Tue, 14 Jan 2025 at 08:13, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> >>
> >> Hi Simon,
> >>
> >> On 12/20/24 5:01 AM, Simon Glass wrote:
> >>> The devicetree file may not be provided, so avoid a failure in that
> >>> case.
> >>>
> >>
> >> Can you provide a bit more information on when/why this shouldn't be a
> >> failure? I assume likely x86? or Aarch64 with ACPI instead of OF?
> >
> > Yes, either of those, but also, even on platforms which use a
> > devicetree, some don't have it in the extlinux file. For example rpi
> > passes it through to U-Boot from its own closed-source firmware.
> >
>
> Ah yes, I had forgotten about platforms using one DTB and passing it
> through stages, I believe Qualcomm does this as well?
>
> Could you please add what you just said to the commit log so that we
> have an idea which scenario this intends to support (for future
> reference if this introduces a regression or we want to do refactoring
> in the future).

OK

>
> I'm wondering if this isn't going to allow booting FDT systems without
> an FDT at all, which really isn't great? Is there something we
> could/should do to prevent that from happening (or at least notify the
> user of such a scenario so it's easier to debug)?

It shouldn't make any difference to the current code. Passing a
bootflow just allows the information to be recorded. The logic of
whether to use the FDT is not changed by this patch.

>
> > Somewhat related: my opinion with extlinux (and EFI for that matter)
> > is that we should be using FIT.
> >
>
> FIT images are not really developer-friendly though :/ I've been asked
> to ditch FIT images to allow easy replacement of customer Device
> Trees/kernel images. Much easier to say "copy your file there, modify
> extlinux.conf to point at the new filepath for the FDT" rather than "so
> this is the ITS, change the path here, and there, don't forget to have
> those binaries in the current path, use mkimage, then copy this itb file
> there".

Yes we need to keep that flow working, of course.

Re FIT, well, we could write a tool. Would that help? If someone did
that, what would it look like?

I've been happy with FIT for a long time, but particularly recently
due to all the workarounds and gymnastics people are doing to make
single files work, e.g. figuring out which devicetree to use.

There is 'u-boot-menu' which works on the running system.

>
> In any case, I don't believe we could remove non-FIT support, so here we
> are :)

Regards,
SImon
