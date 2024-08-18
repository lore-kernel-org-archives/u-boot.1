Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D273BC52D7C
	for <u-boot@archiver.kernel.org>; Sun, 18 Aug 2024 15:26:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89F5088906;
	Sun, 18 Aug 2024 17:25:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nw0G74ns";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E284E88906; Sun, 18 Aug 2024 17:25:53 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 946A588928
 for <u-boot@lists.denx.de>; Sun, 18 Aug 2024 17:25:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6bf7a2035d9so26194816d6.1
 for <u-boot@lists.denx.de>; Sun, 18 Aug 2024 08:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723994750; x=1724599550; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+PNrmUVhziT2+t5tY69AGt1VmQu2KRNAx6hWTcfV/XA=;
 b=nw0G74nsKD/fmIrtVWWBb2kmjQuPIcEwNgHtEPcOLaAfPinIozOpv0JuTpsrZ0AroJ
 x9AG1BXYHKEyhQWDkmarQUCc9/tevpqDcWw0w9HQ+Rj1zN0yxDa98ekRrB5RiOsEeACE
 Cbighxlucx1PGkTW/dhqGtY8+9PwYMN7p1DQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723994750; x=1724599550;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+PNrmUVhziT2+t5tY69AGt1VmQu2KRNAx6hWTcfV/XA=;
 b=brT3sdbwBMMlGHMQcShi1SM2rm+CQX9zU+yvV0bGQeMdOO/Vtsc7l+GHO7tckL9MAM
 KOjvaTgaSGvXGksAIWwCZAVPmcIhtYhoMPaA7/AcDpybMgWBp4jtbtZJKJOaU7VTZUuA
 tASN7g6mIHPLggR16oNpkFyNLNf1fpTnyoFP+30sGz+MzOwGYEMHN9MkrNDwaWpyoNmD
 yxwH/Tx70eWUM1AQGtvDWxkTnqUDAzrqGNngeIS+BqV2gHrQpGqxBiEgEPj+gOgut3Y0
 qngqhCIxCvaRXSyA6Ll8iriqkv7Rlvo/zG7gUdmG4d/RNOA0jpUrGAIgZ53GAClt36+Z
 9oXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfto5GMa0lGkZ4xoqZqUD+P4afXR6yZbQy+ZjrQX+QYpcfTtFVvSpSn3EieEPwkxujg+7VXj0=@lists.denx.de
X-Gm-Message-State: AOJu0YygbQZg+sO62fpBJ3S2x1gBbDYJnKYa0xz4NQClEE3u+m48OMHV
 ZJ0d8OQtzHTF9JZjd4i3xg+QVtBsSllshDQ7tPKG2uVHQJIpWrpb3ERfRI/eWwubTpUa9L7/OZS
 6s71k7um1mBPwKz5aFGNFha5BO9xbjvD7ZsIk
X-Google-Smtp-Source: AGHT+IFqIY8qCOMysFwtRD7nBS2dy9ffmrC3NqfMv5tJfdzlS2A/O62b2iGZKZpp2LpIuGOTkZLCM2ZzhGUK1eLhcQw=
X-Received: by 2002:a05:6214:d45:b0:6bd:6a90:6472 with SMTP id
 6a1803df08f44-6bf6dd08cb5mr212299066d6.1.1723994750461; Sun, 18 Aug 2024
 08:25:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240814071037.34446-1-heinrich.schuchardt@canonical.com>
 <CAFLszTj29ZXtVSmyA-pDp61UuvvMEVks5barSYjNRqUH+mgSpQ@mail.gmail.com>
 <4b7a4178-1224-44fa-8998-800721728211@canonical.com>
 <CAFLszTj7S=DpXa_xLcpqYpPZHSmqzzsL0GHtGKuZkB_Qi1hQ=w@mail.gmail.com>
 <CAJaLiFxcHVfLANeGY-UDwELB-1_Dismu7MV8dZJh8J+bXyY8Vg@mail.gmail.com>
In-Reply-To: <CAJaLiFxcHVfLANeGY-UDwELB-1_Dismu7MV8dZJh8J+bXyY8Vg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 18 Aug 2024 16:25:38 +0100
Message-ID: <CAFLszTjFjjouq=TqE0445KtDuSx7aDvTwAsdUkJwUj35xGzYWA@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] ata: sata_rescan must scan for block devices
To: Tony Dinh <mibodhi@gmail.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>, 
 Stefan Roese <sr@denx.de>, u-boot@lists.denx.de
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

Hi Tony,

On Sun, 18 Aug 2024 at 06:01, Tony Dinh <mibodhi@gmail.com> wrote:
>
> Hi Simon,
>
> On Fri, Aug 16, 2024 at 3:32=E2=80=AFAM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Hi Heinrich,
> >
> > On Wed, 14 Aug 2024 at 06:53, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> > >
> > > On 14.08.24 14:40, Simon Glass wrote:
> > > > On Wed, 14 Aug 2024 at 01:10, Heinrich Schuchardt
> > > > <heinrich.schuchardt@canonical.com> wrote:
> > > >>
> > > >> A system may have multiple SATA controller. Removing the controlle=
r with
> > > >> the lowest sequence number before probing all SATA controllers mak=
es no
> > > >> sense.
> > > >>
> > > >> In sata_rescan we remove all block devices which are children of S=
ATA
> > > >> controllers. We also have to remove the bootdev devices as they wi=
ll be
> > > >> created when scanning for block devices.
> > > >>
> > > >> After probing all SATA controllers we must scan for block devices =
otherwise
> > > >> we end up without any SATA block device.
> > > >>
> > > >> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.=
com>
> > > >> ---
> > > >> v3:
> > > >>          continue unbinding and scanning if one device fails
> > > >>          write a message if scanning fails
> > > >>          add device name to error message
> > > >> v2:
> > > >>          Scanning for device on an unprobed SATA controller leads
> > > >>          to an illegal memory access.
> > > >>          Use uclass_foreach_dev_probe() instead of uclass_foreach_=
dev().
> > > >> ---
> > > >>   drivers/ata/sata.c | 48 +++++++++++++++++++++++++---------------=
------
> > > >>   1 file changed, 26 insertions(+), 22 deletions(-)
> > > >>
> > > >> diff --git a/drivers/ata/sata.c b/drivers/ata/sata.c
> > > >> index 84437d3d346..89cd516f3d6 100644
> > > >> --- a/drivers/ata/sata.c
> > > >> +++ b/drivers/ata/sata.c
> > > >> @@ -9,9 +9,12 @@
> > > >>    *             Dave Liu <daveliu@freescale.com>
> > > >>    */
> > > >>
> > > >> +#define LOG_CATEGORY UCLASS_AHCI
> > > >> +
> > > >>   #include <ahci.h>
> > > >>   #include <blk.h>
> > > >>   #include <dm.h>
> > > >> +#include <log.h>
> > > >>   #include <part.h>
> > > >>   #include <sata.h>
> > > >>   #include <dm/device-internal.h>
> > > >> @@ -49,38 +52,39 @@ int sata_scan(struct udevice *dev)
> > > >>
> > > >>   int sata_rescan(bool verbose)
> > > >>   {
> > > >> +       struct uclass *uc;
> > > >> +       struct udevice *dev; /* SATA controller */
> > > >>          int ret;
> > > >> -       struct udevice *dev;
> > > >>
> > > >>          if (verbose)
> > > >> -               printf("Removing devices on SATA bus...\n");
> > > >> -
> > > >> -       blk_unbind_all(UCLASS_AHCI);
> > > >> -
> > > >> -       ret =3D uclass_find_first_device(UCLASS_AHCI, &dev);
> > > >> -       if (ret || !dev) {
> > > >> -               printf("Cannot find SATA device (err=3D%d)\n", ret=
);
> > > >> -               return -ENOENT;
> > > >> -       }
> > > >> -
> > > >> -       ret =3D device_remove(dev, DM_REMOVE_NORMAL);
> > > >> -       if (ret) {
> > > >> -               printf("Cannot remove SATA device '%s' (err=3D%d)\=
n", dev->name, ret);
> > > >> -               return -ENOSYS;
> > > >> +               printf("scanning bus for devices...\n");
> > > >> +
> > > >> +       ret =3D uclass_get(UCLASS_AHCI, &uc);
> > > >> +       if (ret)
> > > >> +               return ret;
> > > >> +
> > > >> +       /* Remove all children of SATA devices (blk and bootdev) *=
/
> > > >> +       uclass_foreach_dev(dev, uc) {
> > > >> +               log_debug("unbind %s\n", dev->name);
> > > >> +               ret =3D device_chld_remove(dev, NULL, DM_REMOVE_NO=
RMAL);
> > > >> +               if (!ret)
> > > >> +                       ret =3D device_chld_unbind(dev, NULL);
> > > >> +               if (ret && verbose) {
> > > >> +                       log_err("Unbinding from %s failed (%dE)\n"=
,
> > > >> +                               dev->name, ret);
> > > >> +               }
> > > >>          }
> > > >
> > > > This code is in usb_stop() to, so please put it in a shared functio=
n.
> > > > How about uclass_unbind_children(enum uclass_id) ?
> > >
> > > git grep -A5 -n uclass_foreach_dev | grep device_chld_remove
> > >
> > > only finds
> > >
> > > drivers/scsi/scsi.c-571-
> > >                  ret =3D device_chld_remove(dev, NULL, DM_REMOVE_NORM=
AL);
> > >
> > > Where did you see matching USB code?
> >
> > It is in usb_stop() as I said above. See drivers/usb/host/usb-uclass.c
> >
> > There might be other similar code, but what SATA is doing here is
> > similar to what others do, or want to do.
>
> IMHO, in the current implementation, the abstraction level is just
> right for the SATA, SCSI, and USB uclasses. There is no need to
> commonize further. I would keep the (re)scanning logic separate for
> each type of these devices.

Yes I agree the scanning logic does its own thing...the question is
what to do about the unbinding logic. Anyway, if Heinrich doesn't see
any common code, I think it is fine. I'll add my review tag just in
case.

Reviewed-by: Simon Glass <sjg@chromium.org>

> >
> >
> > >
> > > scsi_scan() could also use a rewrite to avoid stopping at the first e=
rror.
> > >
> > > I guess sata_rescan() and scsi_scan() could be the same function taki=
ng
> > > a uclass ID as an argument?
> > >
> > > Best regards
> > >
> > > Heinrich
> > >
> > > >
> > > >>
> > > >>          if (verbose)
> > > >>                  printf("Rescanning SATA bus for devices...\n");
> > > >>
> > > >> -       ret =3D uclass_probe_all(UCLASS_AHCI);
> > > >> -
> > > >> -       if (ret =3D=3D -ENODEV) {
> > > >> -               if (verbose)
> > > >> -                       printf("No SATA block device found\n");
> > > >> -               return 0;
> > > >> +       uclass_foreach_dev_probe(UCLASS_AHCI, dev) {
> > > >> +               ret =3D sata_scan(dev);
> > > >> +               if (ret && verbose)
> > > >> +                       log_err("Scanning %s failed (%dE)\n", dev-=
>name, ret);
> > > >>          }
> > > >>
> > > >> -       return ret;
> > > >> +       return 0;
> > > >>   }
> > > >>
> > > >>   static unsigned long sata_bread(struct udevice *dev, lbaint_t st=
art,
> > > >> --
> > > >> 2.45.2
> > > >>
> > > >
> > > > If you have time, please add a test for ahci (dm/test/ahci)
> > > >
> > > > Regards,
> > > > Simon
> > >

Regards,
Simon
