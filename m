Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FCACC52D7C
	for <u-boot@archiver.kernel.org>; Sun, 18 Aug 2024 05:01:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51F578831F;
	Sun, 18 Aug 2024 07:01:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NyIfkC01";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F9EA882F0; Sun, 18 Aug 2024 07:01:43 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEFA58831F
 for <u-boot@lists.denx.de>; Sun, 18 Aug 2024 07:01:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5becdf7d36aso2025605a12.1
 for <u-boot@lists.denx.de>; Sat, 17 Aug 2024 22:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723957300; x=1724562100; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GDc3SXTORro8FTxV+NxFx07kr0oTxbHL++s/0pCaQiE=;
 b=NyIfkC01idI0kwUhdhpCHBYvq9CZaJ9WWtOu5IKNoodNay3ynwyyZ9OVrk0iDzDVSC
 0rRASjcRyH5FLQPp2eNgm9WYzxS8zWF1B7E7XJ4PDO3RgnRA2Zcrniqr6tWa+PZ4FuDd
 0X1/Pj2Dew6Z1v032AofhM3HOmqJx8eMOYCOyLy5ksFPm8BrRCqKl39pVJ1TaVg3TyMv
 +I96b93Ond3AfeNlYye2BdZGa/OCmIfQe0pAdcbH925kU3VtRRtAu7wdIKeOdKglg6cJ
 MzIdvZyN3NJ1nQG5GtB5UpLUiX/iSOPkoqpXUkgZHXSrPUhTCwYdr0ihE+KOi+IjUcCz
 hG2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723957300; x=1724562100;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GDc3SXTORro8FTxV+NxFx07kr0oTxbHL++s/0pCaQiE=;
 b=fMGaJGa34jJVn+Cg1T+iSu3dgcwnFzE7Hm3h9eK9NUUA4WWEaHOdV8tBNKr3rITTq1
 zNvr2n+rIDeaABlsX2q9nzjiPGYorEPPTJiI5eO54Z4A5hW3FCLOSt46mpB4913lpG1K
 9qhJ9qqmv6uc9ioTkHFtqBHDo4iNkaQnqP6AVFgn5V+HRY7NmPfcYanq7ZfcVmVm5Gxr
 dRBfRjnkGJ+Ec+YCLNEdLzmDTnxZ9tQf1caPnO7wTVSutBhya1oJADH+V8tJxX49fAn/
 upLPlhpgcEFApk/kaGpBwVP7PfympLWoVEtnzKeYaqvBLVlKYEUlaNxU1N/SUig75prP
 ZbhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6KLsWS6eC237snlQ/ByzvRENDdKeGnyWOubE3yDOSvIHxbqHhW5K4y5aI30VoAWJ30wgd6jLLkhFvvsIsF6skWrYc7Q==
X-Gm-Message-State: AOJu0YykXFV3/JZTHSjkI1Mhs4RceTCS7E7J0nVaEecyFxV2rSw9fKAb
 KEKjs6QOmA0Rs3VSRfFI4/ph1Ah4Ekln4sPWEdQse7KQcIBSyXgscydUMVprT8miTglzMtwFu5g
 viXhD6VQCHaQ85tEM1Rvi4vMBAJ8=
X-Google-Smtp-Source: AGHT+IGFY7uVl5vDAK6gCQUL2dNAKnCwVVF0QwKQjhyWXGjUqCOdzZlY39zvcRVP1cYqH2NRTAFLZymQMd3gOPo2lsw=
X-Received: by 2002:a05:6402:11d1:b0:5be:bcdf:410e with SMTP id
 4fb4d7f45d1cf-5beca527e16mr4781261a12.13.1723957299925; Sat, 17 Aug 2024
 22:01:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240814071037.34446-1-heinrich.schuchardt@canonical.com>
 <CAFLszTj29ZXtVSmyA-pDp61UuvvMEVks5barSYjNRqUH+mgSpQ@mail.gmail.com>
 <4b7a4178-1224-44fa-8998-800721728211@canonical.com>
 <CAFLszTj7S=DpXa_xLcpqYpPZHSmqzzsL0GHtGKuZkB_Qi1hQ=w@mail.gmail.com>
In-Reply-To: <CAFLszTj7S=DpXa_xLcpqYpPZHSmqzzsL0GHtGKuZkB_Qi1hQ=w@mail.gmail.com>
From: Tony Dinh <mibodhi@gmail.com>
Date: Sun, 18 Aug 2024 12:01:28 +0700
Message-ID: <CAJaLiFxcHVfLANeGY-UDwELB-1_Dismu7MV8dZJh8J+bXyY8Vg@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] ata: sata_rescan must scan for block devices
To: Simon Glass <sjg@chromium.org>
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

Hi Simon,

On Fri, Aug 16, 2024 at 3:32=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Heinrich,
>
> On Wed, 14 Aug 2024 at 06:53, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
> >
> > On 14.08.24 14:40, Simon Glass wrote:
> > > On Wed, 14 Aug 2024 at 01:10, Heinrich Schuchardt
> > > <heinrich.schuchardt@canonical.com> wrote:
> > >>
> > >> A system may have multiple SATA controller. Removing the controller =
with
> > >> the lowest sequence number before probing all SATA controllers makes=
 no
> > >> sense.
> > >>
> > >> In sata_rescan we remove all block devices which are children of SAT=
A
> > >> controllers. We also have to remove the bootdev devices as they will=
 be
> > >> created when scanning for block devices.
> > >>
> > >> After probing all SATA controllers we must scan for block devices ot=
herwise
> > >> we end up without any SATA block device.
> > >>
> > >> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.co=
m>
> > >> ---
> > >> v3:
> > >>          continue unbinding and scanning if one device fails
> > >>          write a message if scanning fails
> > >>          add device name to error message
> > >> v2:
> > >>          Scanning for device on an unprobed SATA controller leads
> > >>          to an illegal memory access.
> > >>          Use uclass_foreach_dev_probe() instead of uclass_foreach_de=
v().
> > >> ---
> > >>   drivers/ata/sata.c | 48 +++++++++++++++++++++++++-----------------=
----
> > >>   1 file changed, 26 insertions(+), 22 deletions(-)
> > >>
> > >> diff --git a/drivers/ata/sata.c b/drivers/ata/sata.c
> > >> index 84437d3d346..89cd516f3d6 100644
> > >> --- a/drivers/ata/sata.c
> > >> +++ b/drivers/ata/sata.c
> > >> @@ -9,9 +9,12 @@
> > >>    *             Dave Liu <daveliu@freescale.com>
> > >>    */
> > >>
> > >> +#define LOG_CATEGORY UCLASS_AHCI
> > >> +
> > >>   #include <ahci.h>
> > >>   #include <blk.h>
> > >>   #include <dm.h>
> > >> +#include <log.h>
> > >>   #include <part.h>
> > >>   #include <sata.h>
> > >>   #include <dm/device-internal.h>
> > >> @@ -49,38 +52,39 @@ int sata_scan(struct udevice *dev)
> > >>
> > >>   int sata_rescan(bool verbose)
> > >>   {
> > >> +       struct uclass *uc;
> > >> +       struct udevice *dev; /* SATA controller */
> > >>          int ret;
> > >> -       struct udevice *dev;
> > >>
> > >>          if (verbose)
> > >> -               printf("Removing devices on SATA bus...\n");
> > >> -
> > >> -       blk_unbind_all(UCLASS_AHCI);
> > >> -
> > >> -       ret =3D uclass_find_first_device(UCLASS_AHCI, &dev);
> > >> -       if (ret || !dev) {
> > >> -               printf("Cannot find SATA device (err=3D%d)\n", ret);
> > >> -               return -ENOENT;
> > >> -       }
> > >> -
> > >> -       ret =3D device_remove(dev, DM_REMOVE_NORMAL);
> > >> -       if (ret) {
> > >> -               printf("Cannot remove SATA device '%s' (err=3D%d)\n"=
, dev->name, ret);
> > >> -               return -ENOSYS;
> > >> +               printf("scanning bus for devices...\n");
> > >> +
> > >> +       ret =3D uclass_get(UCLASS_AHCI, &uc);
> > >> +       if (ret)
> > >> +               return ret;
> > >> +
> > >> +       /* Remove all children of SATA devices (blk and bootdev) */
> > >> +       uclass_foreach_dev(dev, uc) {
> > >> +               log_debug("unbind %s\n", dev->name);
> > >> +               ret =3D device_chld_remove(dev, NULL, DM_REMOVE_NORM=
AL);
> > >> +               if (!ret)
> > >> +                       ret =3D device_chld_unbind(dev, NULL);
> > >> +               if (ret && verbose) {
> > >> +                       log_err("Unbinding from %s failed (%dE)\n",
> > >> +                               dev->name, ret);
> > >> +               }
> > >>          }
> > >
> > > This code is in usb_stop() to, so please put it in a shared function.
> > > How about uclass_unbind_children(enum uclass_id) ?
> >
> > git grep -A5 -n uclass_foreach_dev | grep device_chld_remove
> >
> > only finds
> >
> > drivers/scsi/scsi.c-571-
> >                  ret =3D device_chld_remove(dev, NULL, DM_REMOVE_NORMAL=
);
> >
> > Where did you see matching USB code?
>
> It is in usb_stop() as I said above. See drivers/usb/host/usb-uclass.c
>
> There might be other similar code, but what SATA is doing here is
> similar to what others do, or want to do.

IMHO, in the current implementation, the abstraction level is just
right for the SATA, SCSI, and USB uclasses. There is no need to
commonize further. I would keep the (re)scanning logic separate for
each type of these devices.

All the best,
Tony

>
> Regards,
> Simon
>
>
> >
> > scsi_scan() could also use a rewrite to avoid stopping at the first err=
or.
> >
> > I guess sata_rescan() and scsi_scan() could be the same function taking
> > a uclass ID as an argument?
> >
> > Best regards
> >
> > Heinrich
> >
> > >
> > >>
> > >>          if (verbose)
> > >>                  printf("Rescanning SATA bus for devices...\n");
> > >>
> > >> -       ret =3D uclass_probe_all(UCLASS_AHCI);
> > >> -
> > >> -       if (ret =3D=3D -ENODEV) {
> > >> -               if (verbose)
> > >> -                       printf("No SATA block device found\n");
> > >> -               return 0;
> > >> +       uclass_foreach_dev_probe(UCLASS_AHCI, dev) {
> > >> +               ret =3D sata_scan(dev);
> > >> +               if (ret && verbose)
> > >> +                       log_err("Scanning %s failed (%dE)\n", dev->n=
ame, ret);
> > >>          }
> > >>
> > >> -       return ret;
> > >> +       return 0;
> > >>   }
> > >>
> > >>   static unsigned long sata_bread(struct udevice *dev, lbaint_t star=
t,
> > >> --
> > >> 2.45.2
> > >>
> > >
> > > If you have time, please add a test for ahci (dm/test/ahci)
> > >
> > > Regards,
> > > Simon
> >
