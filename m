Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B58E7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 08:03:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A74F180192;
	Thu, 12 Dec 2024 09:03:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="c8NKpIWI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7201E80196; Thu, 12 Dec 2024 09:03:43 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA8FC800B5
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 09:03:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eballetb@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733990619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RtH1Eklwbv6hm3v28j5umRMScYXuXs9eWFydjsLoMGc=;
 b=c8NKpIWIsA5gscMua7RxlYXtDNPdGlryQrGWfoes3LmLxEWg+ynvWYnyjIFEIIBWN0OE5c
 OO+5EVukbx33pFtk+m6ss5SQwHjJVrj3jjzNiTHqJlaufkW/uBJUet8wnVlV/Xd5nkS6pJ
 vvI3mxxAOVTmI+DphqhrELsDAlwFspk=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-EpDJdSJMMsaYtLZoABm8jg-1; Thu, 12 Dec 2024 03:03:37 -0500
X-MC-Unique: EpDJdSJMMsaYtLZoABm8jg-1
X-Mimecast-MFC-AGG-ID: EpDJdSJMMsaYtLZoABm8jg
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-3eb61bb0a4cso2154b6e.3
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 00:03:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733990617; x=1734595417;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RtH1Eklwbv6hm3v28j5umRMScYXuXs9eWFydjsLoMGc=;
 b=dsmgsIGPJQsFs4BYcheA2x5PNAywYktpRYH8NdVwXDYYiBDy27OUd9SSSp+vg/gb0V
 VBcYcR5U9y3zdy4nPg7WWe13Sd9/F+JqbnDlhKhbAURDjYmaDbI7/y7qXvjdusHX1IoE
 dJ0c8fOMepWOX9jRwLhQLKkC+qUtIt2DjKQt0yEtnZdYHB2bLuS2hXtNHXpGgJFuj4nF
 UE0LVjiJ7RnANCKjebquKER7xSq4nX+5i01QxEK4m/wf2g7Erz8hbXABxQ16ONxDHXPu
 JuZkitpEw78sDzQKJHmZLUTy4IiQPOe0FqYDfTKGC3PptFzgQdkdU/x/CWtX27OvCpI1
 XikQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyuDWUzLVKMX2q1mcV/cFfxI0Xw/FpmJKoagwG0pJ3+qb34ul7C4bArsocRMfb3Lk2lpSqL3A=@lists.denx.de
X-Gm-Message-State: AOJu0YxSx+4xbTilrozgyVytvmvWa+QMGKmMaruxi4V5TfgOlVf/0vy1
 /xdUQUR7OMoHzvmdsIIMdSZrDdnOStobEA5liJ61/xV51cL18j/getOIDgv5yvvBvT+fnNIdpSj
 3flZ3ZYi1TIhnPI8++/flKowbgdYaSd6tSRVbdGFGzbZQGX4Ix2GSTy/Bh05QhDE+Oh+S4ZDlra
 CDRhd9JdBDqNgowMsNWm2gW/Z0mg==
X-Gm-Gg: ASbGncsXIwd6Z+cKeItGrRvPINEeR1UBA3KoC5wv96OKkGRk0JCrieyhrEVkscogDWO
 EJIYc8svy7QhzqyukRaqNE2b3bxnrBKzP7EFF
X-Received: by 2002:a05:6808:4495:b0:3ea:4802:2b7a with SMTP id
 5614622812f47-3eb85b422aamr1511006b6e.3.1733990617001; 
 Thu, 12 Dec 2024 00:03:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQSu9fyPZxf0OZQHJkS8pM76HvsCxcJGpx5NVhGMXe9PlRGVQLlSrW7Ux+p1FbJs19v9mFNe8wHVaJyNI/Vww=
X-Received: by 2002:a05:6808:4495:b0:3ea:4802:2b7a with SMTP id
 5614622812f47-3eb85b422aamr1510997b6e.3.1733990616699; Thu, 12 Dec 2024
 00:03:36 -0800 (PST)
MIME-Version: 1.0
References: <PA4PR03MB67848E8118A8AF7AC8AF3C1BFA592@PA4PR03MB6784.eurprd03.prod.outlook.com>
 <CAC_iWj+2rBgsfNCjmW_Z8s9Zwu2NjzQFLUNAzehOgBszSYmCrQ@mail.gmail.com>
 <ZzNkjdHYGXQy_kUa@mt.com>
 <CAC_iWjJEiNj+tCj64TXs5i+oqOMnEvevs1YrwPGQJ_XVkWsgsA@mail.gmail.com>
 <ZzNsZyVFuXAry8qT@mt.com>
 <CAC_iWj+hqrEPYqD2FvtL4Yh0GEfaREp+Y8bozHJLN+AkajSi_w@mail.gmail.com>
In-Reply-To: <CAC_iWj+hqrEPYqD2FvtL4Yh0GEfaREp+Y8bozHJLN+AkajSi_w@mail.gmail.com>
From: Enric Balletbo i Serra <eballetb@redhat.com>
Date: Thu, 12 Dec 2024 09:03:25 +0100
Message-ID: <CALE0LRu0x=nYKqJ2c9JwgFR2OZDed7FmdnGgTYogwbLdnJ91CQ@mail.gmail.com>
Subject: Re: EFI File renaming
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Traut Manuel LCPF-CH <Manuel.Traut@mt.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, 
 Venzin Daniel LCPF-CH <Daniel.Venzin@mt.com>,
 Gujan Armin LCPF-CH <Armin.Gujan@mt.com>, 
 Manuel Traut <manut@mecka.net>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Burak Gerz <burak@gerz.io>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XSUrd7gzUZQr8heS6xsBRXl9EX33zMQMTQDYpFe8tBw_1733990617
X-Mimecast-Originator: redhat.com
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

Hi,

Just to double check as I didn't find more after this thread. There
was any advance regarding this topic? I might also be interested in
help on this.

Thanks,
  Enric

On Tue, Nov 12, 2024 at 4:05=E2=80=AFPM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Tue, 12 Nov 2024 at 16:55, Traut Manuel LCPF-CH <Manuel.Traut@mt.com> =
wrote:
> >
> > > > > > systemd-boot counting logic requires [0] to be implemented.
> > > >
> > > > > > If not we plan to add the functionality in fs/fs.c and fs/fat -=
 correct?
> > > > >
> > > > > We don't have plans for it, but explaining any use cases you have=
 might help
> > > >
> > > > systemd-boot is able to do bootcounting by renaming the UKI image [=
0]
> > > > the code that triggers the not implemented code section is here [1]=
.
> > > >
> > > > With this it is possible to have watchdog based A/B switching on sy=
stems
> > > > without a writeable u-boot environment. And therefore it is a nice
> > > > method to implement measured boot.
> > >
> > > The A/B is ok, but I cant understand how that realted to measured
> > > boot. The TPM access, UKI infrastucture etc, will work fine without
> > > A/B
> >
> > Yes, TPM, UKI works fine right now :)
> >
> > systemd-boot is renaming the UKI before it starts it, by increasing
> > the bootcounter that is part of the filename. If the system is fully
> > booted the file gets renamed again to reset the bootcounter.
> >
> > If the bootcounter exceeds systemd-boot tries the next UKI.
> > The UKIs can be signed and are still valid after rename.
> >
> > I expect that changes to the u-boot env will change a PCR measurement.
>
> No env changes are not and IIRC it isnt necesarry. We measure what's
> described in the PC client spec. So the loaded image PCRs would
> change, but that's a user decision (which PCRS to use and seal
> secrets)
>
> > At least it should be like this, since it might alter the boot path?
> >
> > For trusted systems it would be nice to have a meaurement of the EFI
> > variables and beside that have no dynamic environment.
>
> We do measure EFI variables and Boot#### variables in PCR7
>
> >
> > Hope this explanation is understandable?
>
> Yes thanks
>
> /Ilias
> > Manuel
> >
> > > > [0] https://uapi-group.org/specifications/specs/boot_loader_specifi=
cation/#boot-counting
> > > > [1] https://github.com/systemd/systemd/blob/3304a029b847e87da51f7a8=
ad8c118111508e009/src/boot/boot.c#L1407
> > > >
> > > > > >
> > > > > > [0] https://elixir.bootlin.com/u-boot/v2025.01-rc1/source/lib/e=
fi_loader/efi_file.c#L971
>

