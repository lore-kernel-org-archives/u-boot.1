Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E518C3DA6E
	for <u-boot@archiver.kernel.org>; Sun, 31 Dec 2023 14:25:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B84787282;
	Sun, 31 Dec 2023 15:25:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AMd4CGVK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E46A874CC; Sun, 31 Dec 2023 15:25:22 +0100 (CET)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1736487084
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 15:25:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2cca8eb0509so69234051fa.3
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 06:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704032719; x=1704637519; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G2qE4AgfZZaLpAoj4D2pb5C9q4W8V5EgHInx4n6oJrA=;
 b=AMd4CGVK31MAZ0h0tKeTqnDAY0p9y6zfbg/ur3t3AUmKpvQikrbPPnVXjELpI44qjU
 HmH+7DhCLYcOnEuiTySvFj9JKb9/ohTj2cx/wU38rvW3K8WjCKFwBjaGDsRuwX1aQtv9
 V8HW1bFNm/3kMX+2IyGmFqtJBjod9ABuAd6QjBaN/Mxaq5QF1Zgw44oTiYoV+eEJqTDJ
 AN0Ve46grGnLvUpTwxd/SgHXxBzBw0u8jh2BGMEyoIEghrdlkMh8/TtdlC8q1YOuTSLn
 iGT3JgEPVDUBAAEy187JC45xWfFb6jVxSlFSDgTqm4LRMaIRJfuC/IpxMm8VTD/Dh4BH
 6QjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704032719; x=1704637519;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G2qE4AgfZZaLpAoj4D2pb5C9q4W8V5EgHInx4n6oJrA=;
 b=OmOt8AYOjPkyZBIKE7z0UfZ5vEucH3ruF5wnFYPDY+ByXFtX/isWnkCwpO55niWzkB
 W4HPGcmUdG5NXznnHs9yO7YBqr5kHk5tFFZQ3X2KxUERyEt2Wadq7qSUm2QOhpotR4Gz
 vvHxKTLWjPr5NN4AaiLlo6nI8X4AVRpWcGOHgM4RJVHq6LXZumxPCkbgaOgs83fE20fI
 hJ6DSr6xnrfW7Osb9o6LvXaQ+Dnnl/BAUYbiR4ZlqU85goIJdNj7bpnwx1i6NOb2nRNM
 /Kui0qy/YE4wOOgRl9WKaEVnCH4BFCyZlXefp+G7vcHvAL3XKceaIAVCUIK+eQNFZCiz
 ttGQ==
X-Gm-Message-State: AOJu0YxAye1H04Ey5rBtIPuDlB3w9r96RCyCQDbY33Jo4KAFouHS9yhz
 tWLWdk9/zC9KIC+RXIRmjwoTNqzR78xZUfvkbb6i/0FV
X-Google-Smtp-Source: AGHT+IGMAdaJXsMEUDQhKm2mMLRBPEWogwFaBlnbH2sQIBeuZKyzJN5WI04Q8mYpCBA2gaffK/Vcp6VurDGhk+d+YYs=
X-Received: by 2002:a05:6512:3e10:b0:50e:8097:d51d with SMTP id
 i16-20020a0565123e1000b0050e8097d51dmr4245719lfv.33.1704032719021; Sun, 31
 Dec 2023 06:25:19 -0800 (PST)
MIME-Version: 1.0
References: <20231017134951.26672-1-heinrich.schuchardt@canonical.com>
 <CAPnjgZ3fdWAUbZb7kbWfEZvFvuh79LmWpmbOdRhEk=qw2PTbcg@mail.gmail.com>
 <0c1abfbc-fd2a-4dd9-8447-53e5ee32ab85@canonical.com>
 <CAPnjgZ18Utd0V7kctaqD6aZqfmNy9Qogg8dw5WaHkAar9C+Dxw@mail.gmail.com>
 <750bac2f-3bcd-4ae1-b5ed-a82e8159846b@canonical.com>
 <CAPnjgZ3KZLTHUWnnQtBsiaeRRXgHjbqdkfw6cW+_+aXZ9zpogA@mail.gmail.com>
 <ea1ba7c2-7f9c-4702-a6da-efb728771e24@canonical.com>
 <20231020162410.GK3119521@bill-the-cat>
 <CAPnjgZ0zwQ+J-17YEhAtTtLhTcK7K9=nqNNqOdNmG5bY+rFrhg@mail.gmail.com>
 <7481371f-657d-46d6-b8e7-74da7a200ee9@canonical.com>
 <CAPnjgZ3_WSS+Z2xsRTvf-7ChPN42OVLgLf8ZvGv=2FVrNuHkhA@mail.gmail.com>
 <87h6mhqri9.fsf@bloch.sibelius.xs4all.nl>
In-Reply-To: <87h6mhqri9.fsf@bloch.sibelius.xs4all.nl>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Sun, 31 Dec 2023 14:25:07 +0000
Message-ID: <CALeDE9Of7r7yO5-KmiPjMktH49svt+CpbQhKPi1345mUHs-p8Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] efi_loader: expose the device-tree file name
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: Simon Glass <sjg@google.com>, heinrich.schuchardt@canonical.com, 
 ilias.apalodimas@linaro.org, u-boot@lists.denx.de, dianders@google.com, 
 trini@konsulko.com
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

On Mon, Oct 23, 2023 at 4:55=E2=80=AFPM Mark Kettenis <mark.kettenis@xs4all=
.nl> wrote:
>
> > From: Simon Glass <sjg@google.com>
> > Date: Mon, 23 Oct 2023 00:08:40 -0700
> >
> > > > fdt_node_check_compatible() does most of the work...then you need t=
o
> > > > check which FDT has the most specific match (i.e. latest in the str=
ing
> > > > list). That handles things like board revisions, variants, etc.
> > > >
> > > > My concern is about adding a feature when there is already a define=
d
> > > > spec and mechanism for this to work. What happens when we load the
> > > > file and the compatible is wrong?
> > > >
> > > > At best, I see the filename as a hint.
> > > >
> > > > [Perhaps this is the wrong time to ask, but why are kernels +DT not
> > > > shipped in FIT on ARM?]
> > >
> > > FIT is U-Boot specific. For Linux distributions it is easier to use a
> > > firmware agnostic method of booting.
> >
> > I'd like to suggest that distros use both. Then U-Boot can work as it
> > was designed and we can avoid these work-arounds.
> >
> > FIT is actually implemented in various other bootloaders. In fact
> > perhaps grub is the only one that doesn't? I can't think of any
> > others.
>
> Simon, please stop pushing this.  OpenBSD's bootloader does not
> support FIT and we have no interest in supporting it.  Our users
> expect to be able to just copy a new kernel in place and use it and
> our OS upgrade procedure depends on this as well.  And this is
> incompatble with FIT.  I've explained this about a dozen times to you
> now.

For reference Fedora and related ecosystems have no interest in
supporting FIT either, we have enough moving targets, we're not
supporting more, it's very much why we're focused on UEFI, it provides
one way, one kernel, for booting all various different devices we
actively support in main Fedora, it's very much the way the x86
ecosystem has gone as well as the aarch64 server ecosystem. Fedora has
no interest in using FIT in this context either.

Peter
