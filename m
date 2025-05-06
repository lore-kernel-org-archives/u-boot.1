Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D49C3ABAC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 13:24:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8192B82982;
	Tue,  6 May 2025 15:24:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bO1kj4kE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC8D782A36; Tue,  6 May 2025 15:24:35 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 937CE82163
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 15:24:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5f6c3f7b0b0so11245003a12.0
 for <u-boot@lists.denx.de>; Tue, 06 May 2025 06:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746537871; x=1747142671; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g2QnUQxvzMoAA3q3+PVs6BV9txKCTyltox3SuY6rP1M=;
 b=bO1kj4kEUnx6ZvIK4NVQAf5OTg5js85X5omEC0KWpklrjSz6MUizE5E2GmJzrKOPoq
 kGTyFfIyXXtEJzyMBM75dOfqwdy+uhKnKFXIjsWFtFbPDmuJihzNQiZniVtvTgfwVuti
 jcESJLSa2kPTcYrCyvxi19FiCg4/AgyW9C3p4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746537871; x=1747142671;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g2QnUQxvzMoAA3q3+PVs6BV9txKCTyltox3SuY6rP1M=;
 b=Dwa+0RrWqivNRszZ9qZytbE/T3W/LFcc07bXD08CHjK3cOzgGxtzAYAEUV2FWABLa9
 Sn8dZHWaabPungWQ4oKfB1o7f5DB954nxOCJxJ14Mjwm7EcwlBizJZcym5XJEmIujLKz
 vQUVuPjQjeAwH8yeLe1rfUDo31+5q4zhvjrZhXjzxbm4QKcAXJygBq3AQaNqNiORR4wW
 ER4oUb2g5BXPySPbpV5+fioS2f0kZ5i6TAj+mTJmvljt2KAHgCfUzehhJRpKON3y7kYk
 nYzmJRUmjWLLdDAZVwKuNxNoG0KcR5jABIOmRwd79t5sg2VSPHCAu64Pjnq9i6fv4sFf
 ziSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlIgGzYqAys0Ipp9jntizPzsqCHqNfVY1iqu8GcmL0MVu7McK6LIV5v8b0VZwGa9u3ibrbaOU=@lists.denx.de
X-Gm-Message-State: AOJu0YzOIwdFHiddmXA7hrpSo9VyaJurG1OMnuI5VfJhAAIMfE0HvywI
 upwLW9VJfYfeei07ctPfSWiGuTrFQm/ofvaef/9Qhl7Lr/+O7FDgS5lZFnJY+2XqhSot2ku6vP5
 kxj8GA+5AHsAFzitwEVRzcs+ry8DpoJ53uMTv
X-Gm-Gg: ASbGncvfG2IvBySXvL3Ri+pLwCLJD3GUxBgA+niC/SQ/qV5WlYteFjs1a1hJPZ7/fvA
 L8Hr/ST9XtjmI4/YkcO1JBhEDh6lpc1KeBm2sGTk4O4dJ91d1VDMaB8UT22BHz0ynHAKlr49Ovq
 y4/JLZAiiyq+hHmQhCzArkubE=
X-Google-Smtp-Source: AGHT+IFtpPf9EGfD/91cuOgaU0CFQAHJpT+j11mz6MYJtmtjRlT3m9XjauZ/rYGcbQrh8AKYEB+CkPmZz7p6dRDRVog=
X-Received: by 2002:a05:6402:27d0:b0:5e5:bb58:d6bd with SMTP id
 4fb4d7f45d1cf-5fa7802f96fmr16434841a12.10.1746537871038; Tue, 06 May 2025
 06:24:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250502183826.859174-1-eric.schikschneit@novatechautomation.com>
 <CAFLszTiPKbz20+=Du4L7fq442dO2QUh+wV7qH3z5FZy0mNZNmg@mail.gmail.com>
 <20250505180916.GH5430@bill-the-cat>
 <SJ2PR07MB9711B7D339A7C25641310B018189A@SJ2PR07MB9711.namprd07.prod.outlook.com>
In-Reply-To: <SJ2PR07MB9711B7D339A7C25641310B018189A@SJ2PR07MB9711.namprd07.prod.outlook.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 6 May 2025 15:24:14 +0200
X-Gm-Features: ATxdqUFLjv2Wkt2xWjxMVzri8CN6IBw7ZJF2GPzE9sJssZ34Ngkf6bxJuk7537M
Message-ID: <CAFLszTgL6a_71VWh1aynzLUkA1RmF0jkmQnnaiqBGyMj1BmYTQ@mail.gmail.com>
Subject: Re: [PATCH] [RFC]: dtc: Add Kconfig option to pad device tree blob
To: Eric Schikschneit <eric.schikschneit@novatechautomation.com>
Cc: Tom Rini <trini@konsulko.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
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

Hi Eric,

On Tue, 6 May 2025 at 14:50, Eric Schikschneit
<eric.schikschneit@novatechautomation.com> wrote:
>
> Hello Tom,
>
> The link that Simon sent does not add padding at the end. I have tried th=
e approach with SYS_FDT_PAD first and my platform (imx6) still has issues w=
hen trying to modify the device tree from the board file. It still returns =
FDT_ERR_NOSPACE with that option. The commit I sent simply adds a Kconfig o=
ption to something we are already doing (passing the -p flag) on multiple p=
latforms behind the scenes to the device tree compiler. I have tested and p=
roven on my platform that this allows live modification of the device tree =
in the board file.

Is it possible that you have fdt_high environment variable set? That's
the only way I know of that boot_relocate_fdt() can be skipped.

Regards,
Simon


>
> Eric Schikschneit
>
> Senior Embedded Linux Engineer III
>
>
>
> NovaTech, LLC
>
> 13555 W. 107th Street | Lenexa, KS 66215
>
> O: 913.451.1880
>
>
>
> novatechautomation.com | NovaTechLinkedIn
>
> Receipt of this email implies compliance with our terms and conditions.=
=EF=BB=BF
>
>
>
> ________________________________
> From: Tom Rini
> Sent: Monday, May 5, 2025 1:09 PM
> To: Simon Glass; Eric Schikschneit
> Cc: u-boot@lists.denx.de
> Subject: Re: [PATCH] [RFC]: dtc: Add Kconfig option to pad device tree bl=
ob
>
> On Fri, May 02, 2025 at 08:10:33PM -0600, Simon Glass wrote:
> > Hi Eric,
> >
> > On Fri, 2 May 2025 at 14:06, Eric Schikschneit
> > <eric.schikschneit@novatechautomation.com> wrote:
> > >
> > > This will allow arch(s) that use device tree blobs to pad the end of =
the
> > > device tree so they can be modified by board files at run time. This =
will
> > > help prevent errors such as FDT_ERR_NOSPACE from occuring.
> > >
> > > Signed-off-by: Eric Schikschneit <eric.schikschneit@novatechautomatio=
n.com>
> > > ---
> > >  arch/Kconfig                 | 11 +++++++++++
> > >  arch/arc/dts/Makefile        |  6 +++++-
> > >  arch/arm/dts/Makefile        |  4 ++++
> > >  arch/m68k/dts/Makefile       |  6 +++++-
> > >  arch/microblaze/dts/Makefile |  6 +++++-
> > >  arch/nios2/dts/Makefile      |  6 +++++-
> > >  arch/powerpc/dts/Makefile    |  4 ++++
> > >  arch/riscv/dts/Makefile      |  6 +++++-
> > >  arch/sandbox/dts/Makefile    |  6 +++++-
> > >  arch/x86/dts/Makefile        |  8 +++++++-
> > >  10 files changed, 56 insertions(+), 7 deletions(-)
> > >
> >
> > This is not a board-specific feature. You could try this:
> >
> > https://patchwork.ozlabs.org/project/uboot/patch/20241206131113.2865416=
-3-sjg@chromium.org/
>
> Simon, can you please read your links before sending them to other
> people? There's several things wrong with that patch so suggesting
> someone else try it and see is not helpful.
>
> Eric, for your platform can you expand the value used by SYS_FDT_PAD or
> is that not updating things in the correct spot for your use case?
>
> --
> Tom
