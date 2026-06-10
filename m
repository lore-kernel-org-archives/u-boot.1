Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F1ECD8CB9
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 15:48:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B448E84928;
	Wed, 10 Jun 2026 17:48:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ACO+H3qX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C28484940; Wed, 10 Jun 2026 17:48:22 +0200 (CEST)
Received: from mail-yx1-xb134.google.com (mail-yx1-xb134.google.com
 [IPv6:2607:f8b0:4864:20::b134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D38C848DC
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 17:48:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-66061993121so6733355d50.0
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 08:48:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781106498; cv=none;
 d=google.com; s=arc-20240605;
 b=X8GRP/1ahcaL6p7lbXRYdQLl05G/ukvMNxVw6wj3oYDGiY5Im7kid2HflVURE58DD+
 Sk9+LlJgKBNFw0PfUCDCz3oALF9LKuyNstKoWpJEW+DV2r2GsCgtj8NqTlIqK9N/gHE/
 JMAUFcj2/GsiOj757MHISZ/8QBDl3Z0kxHvMl2dZEIp4Iqmgp0nMyaVA1ITkIFt1ppdT
 Fiubq0ju5jKRbC/fVEjoLsvwnb52pQ/Tw8i/YQOdfhXCeru67Y9hpuFrk7scEAgc3P/n
 4smlnfYmOYpT1+a94wpLSdShCMTuhT+w2oprBWNXa49dW+32jaP7DqqjM2lytfj8/7bq
 B30Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=MXAIOk9xREqqe4knGjBbwHZ4KfbDoWE3VbWO1GPCf9A=;
 fh=Yc2G2iU7jo4p6M1qPOPibqhK5yD8z2Bc+u/gsWyAUCk=;
 b=gBRVgn0KDBonjiVlc7J6aKU/3LsjPcXZk2TwtZMEcg5ChIYlNbVo16GGgbYlun3kXv
 5agqudeCZly5p2S4juXxi5LI1kOgZM16Lm7ZLwxgtGexphcu18NAJlX7ZDsLInHfpq2P
 iIpWGGUZZ1+BuvUI3ikbD2oRTS4ETVZA6LJRNOrLDqqR6epURGDXo9b3ORc+zONqlbGJ
 J9MGEPwWmNUxzE4N3dr812Z4Gy3zbezZU4Uk8aOIVL+2F2BoEWkUCfVvqc1QIqIDBGKZ
 vN5PEHaxhcaUVG+9JwZfHjAnGqnuVxxAL221DyhPAlzHXMtF94pTO8tmpisUPhy1zTK1
 AWng==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781106498; x=1781711298; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MXAIOk9xREqqe4knGjBbwHZ4KfbDoWE3VbWO1GPCf9A=;
 b=ACO+H3qXWLoqyJuXqDtLLQJtMdz3NUo3IIsWPQ6lnDxFKJKxjSHxxv2bPQx3mjsqJ6
 vA+n0OF7C32pVwwa8kggNtx75/9DqUPMs+JC2R3lLQVS+slvejHPWejUPrQEFby0YI10
 I8vc4a5fyLf1Eg7+EHvBQ6Mwkk4gvAE1wpvAvucnGejZiPuzrRiFpddUrWv5PWK79BFA
 hN73y8e0OaHYsEEHDXtSu1yS4Y5u852AJGfTYhFIYfNOLnSMzAgVK2Wrbs1qvxTU11pt
 rRg2TFYKTGJPTIHmATBc5rR/xiIeOY2IKAfkJKTWUlVORqwF5avQ29KffU3r7Pl2HXEM
 g49Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781106498; x=1781711298;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MXAIOk9xREqqe4knGjBbwHZ4KfbDoWE3VbWO1GPCf9A=;
 b=M4CdCxfml85WQGaPEGqk7kxRJPuEehTs6bbw75bhwjjNwdpHjewgsZ8DAVi/3mDJbb
 T6tSYwq59iPOqS1aPndnjQExF2GHWBJzDz+DSBdj7eG7ZeeExBXKu0eL/+dkNtr2Mzkk
 /tG4TAwY6HF2Ch9Haan7RS9KUFV2HdGqLNOtS9YMHo0MQ4HqWaRLPrtOQjYUzW3857wX
 iixJEvC64MFodiooCHrbxq3y48nZ/8SiJZQ7xnHsS3uS1SG+aO70taMWXbfazkVSMGUG
 s+fU9uCHc9zDc3tzy1FT2UPVPHn9Dol4BUEcIpY8afSgxK1YFhvRSgXm6mAFL4oPBXbs
 F1Yg==
X-Gm-Message-State: AOJu0YwkDJQPs+OaDspt7D7PZUtq7RcyJgnyusBwZ5p2A19kK83MUS6T
 O5enqiDzZE2sOmf+tSN81+BHMaw3KixeSKD+9o+J0eEJtk67KtLAvuzB5L9LcrW4VKl+kJHiSzW
 urOomI+Zj+LtXHrCu0bvcjbBE+XAP8vZYbwDXlEOWlw==
X-Gm-Gg: Acq92OFthgLE8xY4OLyRlZBrpxwWdFm2r1S1nw/BSOkxzy+NXQgwBUZcCkyqQeAonFX
 O1ZO4DDIbQUNOWwcHuwQYLi7tDkPT9iXLUqpm9VPV2SWLm5859GH4wq7XBHk+cKR+5gPMgcdn4W
 o4j6H+qADtCd0lcuc2O6ScseISKGH8i5oiCHa/5EPIB6MgAq3y0FIeLos9igUbtZaV/Gw8eKWj9
 gnartNrMJyZKtbtOsqzPXJCRbDpE1BA40qj83kJqAfwBeElujAkKwpksCQQe4gECEzU3vaMx9or
 s+qTzTgahCBpAF6OAsll0DT68S3h7OYzQFbr4k4UPi/aIDYKh0V6k3YILGzm3MQ7aiH+vMdjNK/
 HjE4vUnNkUPAn5UVXHi5HSGgjktOPO3vp3oqWt9KyvrqfVglZvJEucYQ6ppw0FqPrXTjEV8XHN4
 rTDufLMRg1Bpmx3MMEgxYsV/qeXpfkR6IKXQjJWhIJiprXiY3a0MyQe9Ve5MC2+cshQV7vJu+wb
 HK0h8wAhYJ4y/ry/su7ejp0wOXOZ1bI2ANgFnOlUB+yfWEdy3/U9llJEHrn46WDb+fReHQz9kYt
 MguFmiCo5kAKXC49mNXwNA9n4+tsYw5mX9V9IB3df6leF6IcvXA2jW9vvav4qtNZRa7T/kPVaCF
 AlW1IbJU3hiIqaC4UWg==
X-Received: by 2002:a05:690e:bc2:b0:65e:5110:a584 with SMTP id
 956f58d0204a3-6610779dfc7mr22349764d50.52.1781106498125; Wed, 10 Jun 2026
 08:48:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260609101039.584994-1-padmarao.begari@amd.com>
 <CAC_iWj+gfnGQyi6MHJaJ0zRLue8TD1_K9yVNQ898+eu5daBD2A@mail.gmail.com>
 <PH0PR12MB7470002892F5A593AC1D9ACFEC1A2@PH0PR12MB7470.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB7470002892F5A593AC1D9ACFEC1A2@PH0PR12MB7470.namprd12.prod.outlook.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 10 Jun 2026 18:47:41 +0300
X-Gm-Features: AVVi8Cd19_2cIYlo6Fk7EEGzQtI1eFjEQEbBiSOmKYJnqVEimsm27xdEXqyuxUU
Message-ID: <CAC_iWjLe-D+YHtPLHeAyMuct0SbF2hMwd=6=XUwMb14Kpgx=fQ@mail.gmail.com>
Subject: Re: [PATCH] rng: tpm_rng: start TPM before reading random numbers
To: "Begari, Padmarao" <Padmarao.Begari@amd.com>,
 Simon Glass <sjg@chromium.org>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "Simek,
 Michal" <michal.simek@amd.com>, 
 "git (AMD-Xilinx)" <git@amd.com>, Sughosh Ganu <sughosh.ganu@arm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
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

On Wed, 10 Jun 2026 at 18:03, Begari, Padmarao <Padmarao.Begari@amd.com> wr=
ote:
>
> AMD General
>
> Hi Ilias,
>
> > From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > Sent: Tuesday, June 9, 2026 4:06 PM
> > To: Begari, Padmarao <Padmarao.Begari@amd.com>
> > Cc: u-boot@lists.denx.de; Simek, Michal <michal.simek@amd.com>; git (AM=
D-
> > Xilinx) <git@amd.com>; Sughosh Ganu <sughosh.ganu@arm.com>; Heinrich
> > Schuchardt <xypron.glpk@gmx.de>; Tom Rini <trini@konsulko.com>
> > Subject: Re: [PATCH] rng: tpm_rng: start TPM before reading random numb=
ers
> >
> > Hi Padmarao
> >
> >
> > On Tue, 9 Jun 2026 at 13:10, Padmarao Begari <padmarao.begari@amd.com>
> > wrote:
> > >
> > > The tpm-rng driver calls tpm_get_random() without first ensuring the
> > > TPM device is opened and started. When systemd-boot or fdt_fixup_kasl=
r
> > > triggers an RNG read early in boot, the TPM2 device hasn't been
> > > initialized yet, causing the command to fail:
> >
> > Is systemd_boot called via EFI? If so the TPM should be up already.
>
> You're right, The EFI TCG2 protocol does start the TPM, but only when tcg=
2_platform_get_tpm2() returns a probed TPM2 device. That function iterates =
with for_each_tpm_device(), and the uclass iterator silently skips any devi=
ce whose probe fails, returning -ENODEV. So, a failed probe means EFI never=
 starts the TPM.

But if the TPM fails to start from there, why would it succeed when
called from a different subsystem?

>
> The failure (tpm-rng tpm-rng: dm_rng_read failed: -1) does not come from =
systemd-boot, it comes from U-Boot's own fdt_kaslrseed() call, which runs d=
uring bootefi/bootmgr setup before control is handed to the EFI app.
>
> > About fdt_fixup_kaslr(), why do you need this? We specifically clear th=
e kaslr-seed
> > when booting via EFI and EFI_RNG is installed, since the kernel ignores=
 it.
>
> Agree, referencing fdt_fixup_kaslr() in the commit message is a mistake, =
 I'll correct the commit message.

It's not only the commit message. I think initializing the TPM in
_read callback is the wrong place to fix it.  We need a probe callback
that will initialize the device, if we use it for it's RNG, even if we
have to initialize the entire TPM
(+ CC Simon)

Thanks
/Ilias

>
> Regards
> Padmarao
>
> >
> > Thanks
> > /Ilias
> > >
> > >   tpm-rng tpm-rng: dm_rng_read failed: -1
> > >
> > > Fix this by calling tpm_auto_start() on the parent TPM device before
> > > tpm_get_random(). This ensures the TPM is initialized before use.
> > >
> > > Fixes: e67ffb5aa5ab ("tpm: rng: Add driver model interface for TPM RN=
G
> > > device")
> > > Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
> > > ---
> > >  drivers/rng/tpm_rng.c | 10 +++++++++-
> > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/rng/tpm_rng.c b/drivers/rng/tpm_rng.c index
> > > 1a5e9e2e4b4..374e0ac1ff8 100644
> > > --- a/drivers/rng/tpm_rng.c
> > > +++ b/drivers/rng/tpm_rng.c
> > > @@ -4,12 +4,20 @@
> > >   */
> > >
> > >  #include <dm.h>
> > > +#include <log.h>
> > >  #include <rng.h>
> > >  #include <tpm_api.h>
> > >
> > >  static int rng_tpm_random_read(struct udevice *dev, void *data,
> > > size_t count)  {
> > > -       return tpm_get_random(dev_get_parent(dev), data, count);
> > > +       struct udevice *tpm_dev =3D dev_get_parent(dev);
> > > +       u32 rc;
> > > +
> > > +       rc =3D tpm_auto_start(tpm_dev);
> > > +       if (rc)
> > > +               return log_msg_ret("start", -EIO);
> > > +
> > > +       return tpm_get_random(tpm_dev, data, count);
> > >  }
> > >
> > >  static const struct dm_rng_ops tpm_rng_ops =3D {
> > > --
> > > 2.34.1
> > >
