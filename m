Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9957C3DA7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 20:32:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFEE688ABE;
	Thu, 15 Aug 2024 22:32:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MgFVDYnG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68D378657F; Thu, 15 Aug 2024 22:32:13 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4269888ABE
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 22:32:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6bf7ec5c837so76466d6.1
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 13:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723753922; x=1724358722; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Cncqj/+m931AWpxxVF4uyIjjUU8DbjlfJzf0gs+4EDA=;
 b=MgFVDYnGuFYtMCCCABfCETkXQd8gvPK9/sP7fn570nTFX+aiuXR9a4iGiu817CRzQ8
 qv32t3G3rttbJ5dz2ZHWnuAvmWIdWmjEKLoRdVOuTU3Tgw7B/5+bTiuxP9wpWLLC7Cm1
 1jwXEyJeXnEaMYyVaKuaQFrbeEaP6uKlc32mk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723753922; x=1724358722;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Cncqj/+m931AWpxxVF4uyIjjUU8DbjlfJzf0gs+4EDA=;
 b=gMgyWqOi8VrkGpNSN/PrmM3pS7naWxFgdjkUCI7dOXYCGNstpO9kvfBMURkCeJ76Ma
 y8YHewwSVri+yKn2RtjB5LXxrWPhhCwZINZomBaxVidB6w3OlnUH3DMrSbdEx1QSc36f
 n4uQy8naLKAyn4rdyA7HzTlTAtRuCcTqub4c1lkp/BRGlv4Sum0ZlX3/rqnfUOMF/KXo
 ohW42X1z7gz9JEyb3wq1oAOpTrC2q42L9aI5D9LAqEkn2ZW26xnVCEiJjdZ39c9EMLC6
 Gq1SFBa5638+RXyTRcdAbcpmRlu+RsiFAHg8oqq7prUb75BpyDq81RvbNb+1luzlkYgt
 HNeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8ugP4CIK+5l7JP0lJyFidpsNhPKGAWx+JIfW81annA64gbs6hgXwoEEcKFMJgoYKOXqryenmgeg4XsY8Vymbf53mDbw==
X-Gm-Message-State: AOJu0YzaYyDMmQlNoenhvZKDKB/t7dSLXlFjxOMA/HACh8GAjkWUAu0K
 xjXylRPwzp5wUaSmU12iVurlULV1enJ0Iso0s6MVDg2MprZ+kGFgTFhjscem3hn0084jgJA7Fux
 LJJUFTUxwPcuICWC3QQmd3KUpkAaWYC9q66FMkU7Z5z+rMFxm5A==
X-Google-Smtp-Source: AGHT+IGrg5nKp7sTR30fd7O2xqbe3nj/Xc4bUy6YA5ZN+2J4roNHC2JkhFpnj3TZytT3v1kxXrbnxWQUuBKkr+wx1Os=
X-Received: by 2002:a05:6214:5f08:b0:6bf:6f1a:f679 with SMTP id
 6a1803df08f44-6bf7ce60f2bmr9806876d6.44.1723753921909; Thu, 15 Aug 2024
 13:32:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240814071037.34446-1-heinrich.schuchardt@canonical.com>
 <CAFLszTj29ZXtVSmyA-pDp61UuvvMEVks5barSYjNRqUH+mgSpQ@mail.gmail.com>
 <4b7a4178-1224-44fa-8998-800721728211@canonical.com>
In-Reply-To: <4b7a4178-1224-44fa-8998-800721728211@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 15 Aug 2024 21:31:50 +0100
Message-ID: <CAFLszTj7S=DpXa_xLcpqYpPZHSmqzzsL0GHtGKuZkB_Qi1hQ=w@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] ata: sata_rescan must scan for block devices
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Tony Dinh <mibodhi@gmail.com>,
 Stefan Roese <sr@denx.de>, u-boot@lists.denx.de
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

On Wed, 14 Aug 2024 at 06:53, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 14.08.24 14:40, Simon Glass wrote:
> > On Wed, 14 Aug 2024 at 01:10, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >> A system may have multiple SATA controller. Removing the controller with
> >> the lowest sequence number before probing all SATA controllers makes no
> >> sense.
> >>
> >> In sata_rescan we remove all block devices which are children of SATA
> >> controllers. We also have to remove the bootdev devices as they will be
> >> created when scanning for block devices.
> >>
> >> After probing all SATA controllers we must scan for block devices otherwise
> >> we end up without any SATA block device.
> >>
> >> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >> ---
> >> v3:
> >>          continue unbinding and scanning if one device fails
> >>          write a message if scanning fails
> >>          add device name to error message
> >> v2:
> >>          Scanning for device on an unprobed SATA controller leads
> >>          to an illegal memory access.
> >>          Use uclass_foreach_dev_probe() instead of uclass_foreach_dev().
> >> ---
> >>   drivers/ata/sata.c | 48 +++++++++++++++++++++++++---------------------
> >>   1 file changed, 26 insertions(+), 22 deletions(-)
> >>
> >> diff --git a/drivers/ata/sata.c b/drivers/ata/sata.c
> >> index 84437d3d346..89cd516f3d6 100644
> >> --- a/drivers/ata/sata.c
> >> +++ b/drivers/ata/sata.c
> >> @@ -9,9 +9,12 @@
> >>    *             Dave Liu <daveliu@freescale.com>
> >>    */
> >>
> >> +#define LOG_CATEGORY UCLASS_AHCI
> >> +
> >>   #include <ahci.h>
> >>   #include <blk.h>
> >>   #include <dm.h>
> >> +#include <log.h>
> >>   #include <part.h>
> >>   #include <sata.h>
> >>   #include <dm/device-internal.h>
> >> @@ -49,38 +52,39 @@ int sata_scan(struct udevice *dev)
> >>
> >>   int sata_rescan(bool verbose)
> >>   {
> >> +       struct uclass *uc;
> >> +       struct udevice *dev; /* SATA controller */
> >>          int ret;
> >> -       struct udevice *dev;
> >>
> >>          if (verbose)
> >> -               printf("Removing devices on SATA bus...\n");
> >> -
> >> -       blk_unbind_all(UCLASS_AHCI);
> >> -
> >> -       ret = uclass_find_first_device(UCLASS_AHCI, &dev);
> >> -       if (ret || !dev) {
> >> -               printf("Cannot find SATA device (err=%d)\n", ret);
> >> -               return -ENOENT;
> >> -       }
> >> -
> >> -       ret = device_remove(dev, DM_REMOVE_NORMAL);
> >> -       if (ret) {
> >> -               printf("Cannot remove SATA device '%s' (err=%d)\n", dev->name, ret);
> >> -               return -ENOSYS;
> >> +               printf("scanning bus for devices...\n");
> >> +
> >> +       ret = uclass_get(UCLASS_AHCI, &uc);
> >> +       if (ret)
> >> +               return ret;
> >> +
> >> +       /* Remove all children of SATA devices (blk and bootdev) */
> >> +       uclass_foreach_dev(dev, uc) {
> >> +               log_debug("unbind %s\n", dev->name);
> >> +               ret = device_chld_remove(dev, NULL, DM_REMOVE_NORMAL);
> >> +               if (!ret)
> >> +                       ret = device_chld_unbind(dev, NULL);
> >> +               if (ret && verbose) {
> >> +                       log_err("Unbinding from %s failed (%dE)\n",
> >> +                               dev->name, ret);
> >> +               }
> >>          }
> >
> > This code is in usb_stop() to, so please put it in a shared function.
> > How about uclass_unbind_children(enum uclass_id) ?
>
> git grep -A5 -n uclass_foreach_dev | grep device_chld_remove
>
> only finds
>
> drivers/scsi/scsi.c-571-
>                  ret = device_chld_remove(dev, NULL, DM_REMOVE_NORMAL);
>
> Where did you see matching USB code?

It is in usb_stop() as I said above. See drivers/usb/host/usb-uclass.c

There might be other similar code, but what SATA is doing here is
similar to what others do, or want to do.

Regards,
Simon


>
> scsi_scan() could also use a rewrite to avoid stopping at the first error.
>
> I guess sata_rescan() and scsi_scan() could be the same function taking
> a uclass ID as an argument?
>
> Best regards
>
> Heinrich
>
> >
> >>
> >>          if (verbose)
> >>                  printf("Rescanning SATA bus for devices...\n");
> >>
> >> -       ret = uclass_probe_all(UCLASS_AHCI);
> >> -
> >> -       if (ret == -ENODEV) {
> >> -               if (verbose)
> >> -                       printf("No SATA block device found\n");
> >> -               return 0;
> >> +       uclass_foreach_dev_probe(UCLASS_AHCI, dev) {
> >> +               ret = sata_scan(dev);
> >> +               if (ret && verbose)
> >> +                       log_err("Scanning %s failed (%dE)\n", dev->name, ret);
> >>          }
> >>
> >> -       return ret;
> >> +       return 0;
> >>   }
> >>
> >>   static unsigned long sata_bread(struct udevice *dev, lbaint_t start,
> >> --
> >> 2.45.2
> >>
> >
> > If you have time, please add a test for ahci (dm/test/ahci)
> >
> > Regards,
> > Simon
>
