Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7D0FCE7A8B
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 00:35:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA73686BA1;
	Mon, 25 Sep 2023 02:35:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="noYkdvlH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C8CC86B9B; Mon, 25 Sep 2023 02:35:04 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5C5186BA6
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 02:35:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-405361bb94eso54133715e9.0
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 17:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695602102; x=1696206902; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CfaZvcar/0M6to64x5oPDrpouGvmfQTPCqDHMrzF2K8=;
 b=noYkdvlHuTPMGuxR2q/1WYfj5KZHP7BaPwAHfvcev1L3Ve3xmJjArMEQRvmr79U4ho
 kSxZXs/0MYMm+T9Pya1WiBQMjDio58Ohdnex67/95oIuRP4O3n5PjqzJjepiDI7G9nK/
 6++BiFdt97r2x/Po9oPEc5ip8eLO2ld+CtYcuwdJHGSVLoCeJJteZHX3GSaiIuWYJ41b
 q89EdzO/gBJv9YyZyseErQSRvsjRUno7Vh1r8k4tCu+FzEdN2WerQWSBf29AOdOml/F/
 8AVCmwyz1v3JEEpnU5bbsvyaJYkusXfAlafP2Hgh07Mcl/Hl5g/oqZYal/tDhy5z+XBC
 8KvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695602102; x=1696206902;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CfaZvcar/0M6to64x5oPDrpouGvmfQTPCqDHMrzF2K8=;
 b=BLyR+ojh+3eizUVwj6IbMaR2gc3/8DgStgYKCSRtu6SDNy3GQrYmOGIK1LRIoL0Mkn
 wXJm8erxSdCrRK6BrvoXoUW4TOp3kcRExQW1SD9lxYi6bswCTsZTdstZ/ASD/T7GlQbz
 RGKSV7edHUEuNTrFHKZ1eD4SJiLmAytCkAbeWOUm/gqjeGHPgoXhM/dp7BFxLuLJKbTS
 VHhiiH/fwnZYzJs4BfPiHs5P4lCYRZeG2Tp+/xC99Wwse8vrjGTY3xC/eUsL2GPLo82k
 cFedLZg5jwglbZPPCaLJ2lqawArpzI1kRGxmoFVthyQtFKSKMUHN2UCibR04KKnRF+UV
 chFg==
X-Gm-Message-State: AOJu0YzAqsqqhjTdtPNYj3LaYbvrvIQy5lTk74HwNpYtTLeLq0+hTwbT
 i3QdCcJXBtO6YBsFMv1UMKtf6EXR8OTFbC7rBa0=
X-Google-Smtp-Source: AGHT+IGEfVvdPPCKD8AWYTJR9KNpbbsw0hlmU8PK18Cl90g8hqNTKmJpzqrtlUq/pxmRvcuv9c/L3qrouqtkqUpn/+4=
X-Received: by 2002:a05:600c:6003:b0:405:82c0:d9f3 with SMTP id
 az3-20020a05600c600300b0040582c0d9f3mr2184266wmb.30.1695602101884; Sun, 24
 Sep 2023 17:35:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230906052242.21568-1-mibodhi@gmail.com>
 <CAPnjgZ29nYzhr32q1SyxQZNgaq344TmqH5v2z+exLgjL77M61w@mail.gmail.com>
In-Reply-To: <CAPnjgZ29nYzhr32q1SyxQZNgaq344TmqH5v2z+exLgjL77M61w@mail.gmail.com>
From: Tony Dinh <mibodhi@gmail.com>
Date: Sun, 24 Sep 2023 17:34:46 -0700
Message-ID: <CAJaLiFwh+13qPGRvjZ6S2hZqkU4LoP-nJXG1ptK_F6ewuFsugg@mail.gmail.com>
Subject: Re: [PATCH] arm: mvebu: sata_mv: Add bootstd hook to enable
 sata_bootdev
To: Simon Glass <sjg@chromium.org>
Cc: Stefan Roese <sr@denx.de>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Tom Rini <trini@konsulko.com>
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

On Sun, Sep 24, 2023 at 1:40=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Tony,
>
> On Tue, 5 Sept 2023 at 23:23, Tony Dinh <mibodhi@gmail.com> wrote:
> >
> > Add hook in sata_mv probe to enable bootstd bootdev.
> >
> > Note: bootdev_setup_for_sibling_blk() invocation is a noop if bootsd is
> > not enabled for ahci sata yet.
> >
> > Signed-off-by: Tony Dinh <mibodhi@gmail.com>
> > ---
> >
> >  drivers/ata/sata_mv.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
>
> But please see below
>
> > diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> > index 18c7a66db1..55a5365b5a 100644
> > --- a/drivers/ata/sata_mv.c
> > +++ b/drivers/ata/sata_mv.c
> > @@ -34,6 +34,7 @@
> >  #include <common.h>
> >  #include <ahci.h>
> >  #include <blk.h>
> > +#include <bootdev.h>
> >  #include <cpu_func.h>
> >  #include <dm.h>
> >  #include <log.h>
> > @@ -1104,6 +1105,12 @@ static int sata_mv_probe(struct udevice *dev)
> >                         /* TODO: undo create */
> >                         continue;
> >
> > +               ret =3D bootdev_setup_for_sibling_blk(blk, "sata_bootde=
v");
> > +               if (ret) {
> > +                       printf("%s: Failed to create bootdev\n", __func=
__);
> > +                       continue;
> > +               }
> > +
> >                 /* If we got here, the current SATA port was probed
> >                  * successfully, so set the probe status to successful.
> >                  */
> > @@ -1116,7 +1123,6 @@ static int sata_mv_probe(struct udevice *dev)
> >  static int sata_mv_scan(struct udevice *dev)
> >  {
> >         /* Nothing to do here */
> > -
>
> You should leave this - the style is to put a newline before the final
> return in a function.

Thanks,
Tony

>
> >         return 0;
> >  }
> >
> > --
> > 2.39.2
> >
>
> Regards,
> Simon
