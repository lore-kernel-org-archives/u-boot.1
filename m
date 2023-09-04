Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68166C83F33
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 21:37:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79C1386824;
	Mon,  4 Sep 2023 23:37:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hIq8V7H7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97802868BB; Mon,  4 Sep 2023 23:37:42 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C33D86611
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 23:37:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-401da71b83cso18160685e9.2
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 14:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693863459; x=1694468259; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1O6VPdNkL3ARjmjcsJlnhawcgztxCNb+Xi6ft0SfQR8=;
 b=hIq8V7H7k274RJASSfmDOE/ibvxQ6sP4IMH34Maiqd8oL32egFD6DMBAIIoTyq8gko
 1Io43j3JdnAfUO4MTRzXbeWBxsu30BF4o8YIxhtfW427hi4VqQPpKyJd/0ulobFkDAIw
 9LaDOhydvXqGn56MGR0b2gq/893glUYtAj12v8jaMZAlBtEm9+U9MMl1IlWbRDOxGXEE
 HSsNpeV1Sof58FuoId3n+C6LCN+M6GLsgOMLdSF1ciecyCbaUCphfrETGTen/xxLIx0P
 jK8wLWDnEmveR9HtBOrCiR/fKGOAr0XxWgSyf0xKu9Dk6pZOWzM0AB7xJmXRPAF2yV2I
 Xrdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693863459; x=1694468259;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1O6VPdNkL3ARjmjcsJlnhawcgztxCNb+Xi6ft0SfQR8=;
 b=HjHnP/3PpYntcqHH//wL0iGVn5qYcnMKD0RriK78+QHSEKvzxq6P4P+/RbzZ6XrMxW
 sikylg5mrXdz4/uJ9VTbnSTdcQC50YYfOg08duFhofmEF7m903gLuhZWxHEJhYDukP30
 ZHJSOyp/SVy8CVzLt4IsIAV3K/UScwdG1ZPl07BsjaiV5Zfa04CuSGJhZSHHATQ5D4CD
 VAAHwUErn3thPXKdTNPvSQ8XjiSVWWL8Ri/0toFYaV1gcuPsUnjUMg2/bNh9J0d879Zr
 ECZRafiyvhELRIYGD1cfiQ2IfXdaplBkJJxWh/fSsSrSV8mIE4TfO3UOWPzE9gtEUzoc
 gMPQ==
X-Gm-Message-State: AOJu0Ywa5ASLrq3A5zr88LEl+PTmasjznggNL96tAgcav1rdr4/hGfxQ
 ya3XAsPXrkb9OvUKAUuz0gMtxtQLrNL1ToM2krY=
X-Google-Smtp-Source: AGHT+IHHwZzVmlEqaTQO90/7BwewOlo2qKM8Oq//0F09eTecd5vcooDGWWmeKPu86/DCb5awrKMS8Q9CvJchhyS5+d0=
X-Received: by 2002:adf:e9c5:0:b0:319:63f3:c0cb with SMTP id
 l5-20020adfe9c5000000b0031963f3c0cbmr7986871wrn.40.1693863459175; Mon, 04 Sep
 2023 14:37:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230825013930.1753078-1-sjg@chromium.org>
 <CAJaLiFzS+oHkRuGCNDGj=xA4ooNvYrV38qYED+ipA2M_O_uJuA@mail.gmail.com>
 <CAPnjgZ0kpMBatC475FmMF2sai_waMFK_Sf3mWxeSoLB_qYdXNA@mail.gmail.com>
 <CAJaLiFy1aMgOKyPM=aK-heVow91baY9U20Jo0cG0KaCCMJ4mCQ@mail.gmail.com>
In-Reply-To: <CAJaLiFy1aMgOKyPM=aK-heVow91baY9U20Jo0cG0KaCCMJ4mCQ@mail.gmail.com>
From: Tony Dinh <mibodhi@gmail.com>
Date: Mon, 4 Sep 2023 14:37:27 -0700
Message-ID: <CAJaLiFz+k3dzC730TMo-UZO5XM+7-1x7-4_j0ZTU2pn64gT4ZQ@mail.gmail.com>
Subject: Re: [PATCH] bootstd: Drop some TODOs
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>,
 Stefan Roese <sr@denx.de>
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

On Fri, Aug 25, 2023 at 5:51=E2=80=AFPM Tony Dinh <mibodhi@gmail.com> wrote=
:
>
> Hi Simon,
>
> On Fri, Aug 25, 2023 at 4:53=E2=80=AFPM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Hi Tony,
> >
> > On Fri, 25 Aug 2023 at 14:17, Tony Dinh <mibodhi@gmail.com> wrote:
> > >
> > > Hi Simon,
> > >
> > > On Thu, Aug 24, 2023 at 6:48=E2=80=AFPM Simon Glass <sjg@chromium.org=
> wrote:
> > > >
> > > > The existing TODOs are done, so remove them. Add another that came =
up
> > > > today.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > >  doc/develop/bootstd.rst | 4 +---
> > > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > > >
> > > > diff --git a/doc/develop/bootstd.rst b/doc/develop/bootstd.rst
> > > > index ec3136535783..3e566e994d6c 100644
> > > > --- a/doc/develop/bootstd.rst
> > > > +++ b/doc/develop/bootstd.rst
> > > > @@ -752,9 +752,7 @@ To do
> > > >
> > > >  Some things that need to be done to completely replace the distro-=
boot scripts:
> > > >
> > > > -- add bootdev drivers for dhcp, sata, scsi, ide, virtio
> > >
> > > Good to see SATA finally in bootdev driver! I'm testing bootstd on a
> > > couple boards, and have been waiting for SATA bootdev. Any idea, if I
> > > should wait for it to be merged to the next branch, or is there an
> > > easy way to do it with one of your patches (I can test it on the
> > > latest master branch or next branch).
> >
> > I believe it went in in the last release - see drivers/scsi/scsi_bootde=
v.c
> >
> > If you need something else for SATA, PLMK.
>
> I see. That's scsi_bootdev for the scsi driver. I think we also need
> sata_bootdev for drivers/ata/. For example, the Marvell Kirkwood SoC
> boards use sata_mv.

I took a close look in the drivers/ata/ directory. Most drivers are
using ahci scsi, so they are OK. But the following drivers are ahci
but not using scsi:
fsl_sata.c
sata_sil.c
sata_mv.c

That TODO item should remain and changed to:

-- add bootdev driver for sata

All the best,
Tony

>
> Thanks,
> Tony
>
> >
> > Regards,
> > Simon
> >
> >
> > >
> > > Thanks,
> > > Tony
> > >
> > > > -- PXE boot for EFI
> > > > -- support for loading U-Boot scripts
> > > > +- implement extensions (devicetree overlays with add-on boards)
> > > >
> > > >  Other ideas:
> > > >
> > > > --
> > > > 2.42.0.rc1.204.g551eb34607-goog
> > > >
