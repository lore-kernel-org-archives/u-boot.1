Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75563C83F04
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 23:54:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E201586B03;
	Sat, 26 Aug 2023 01:53:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SWZunjWW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71E2586B29; Sat, 26 Aug 2023 01:53:45 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7BB186AE7
 for <u-boot@lists.denx.de>; Sat, 26 Aug 2023 01:53:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2bceca8a41aso21018191fa.0
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 16:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693007622; x=1693612422;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pdeUjVZw8QeunQx5kQAekvwMtRV073KYcTuKEb76tFU=;
 b=SWZunjWWSJMKXeD6zMKNEFNapwDNGy9YIGApvIE9CjqNaIBsmcmA8jFH1EbVKj0t5c
 0EV55jMKn1A9Gya2mvzNLEpcKwvrQR9cziljZytMXemN1+CBqyksYNUFLKB4J/Ht6W63
 LYOGx3szcmBX0ucBFj5Y7rxRqUejDDOrFHCks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693007622; x=1693612422;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pdeUjVZw8QeunQx5kQAekvwMtRV073KYcTuKEb76tFU=;
 b=a6MBbXFqRhn28Qho6YAc6Ib27IrPloWMT1C9kgjbN99nrM681q6si7Ui+VlmTdoEQr
 CI3rOWftT+LKp94wUkM/tTbd+wfDbEuplIXl+07ty5MRbXzB/vyQxc+CeP60rl6DWHU/
 nFcU9QGG6wIT+aFwM8UDO2xaxeSOYjVKJEhOgDhzKo651DujaHWA/6aVZtZdg/igJ2A6
 LOUTCwuSs2GSFjxIN9RLbhnfMI2GKKH0SHHiH0/0jYacwFpcV4uHohrbAreWRbE1l0zQ
 5tuc0cbeVJ0MoblpjqbVDXSgZy0eCaFikF5Zg5jAnWLwgW3QkjNSFmBGzXR+qd8mFtEt
 riCA==
X-Gm-Message-State: AOJu0YxUHcYQVHFpvGNwcy+QzpYEFOGliuViezpDytAqetj9/iO7HAMS
 QybftKXTCR7+HwPCrWlmEZJBGVOmbfrqsvn1D2s2FA==
X-Google-Smtp-Source: AGHT+IFRoA6j+wlDOB+SIvTN2sFbCWr3nrdJyPDjFtsN15mZThiVlyQwuDU6PPMY0g24u9jC1PRZes4KX2F8WJzsH4c=
X-Received: by 2002:a05:6512:2512:b0:4fe:af1:c3ae with SMTP id
 be18-20020a056512251200b004fe0af1c3aemr15522463lfb.15.1693007621837; Fri, 25
 Aug 2023 16:53:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230825013930.1753078-1-sjg@chromium.org>
 <CAJaLiFzS+oHkRuGCNDGj=xA4ooNvYrV38qYED+ipA2M_O_uJuA@mail.gmail.com>
In-Reply-To: <CAJaLiFzS+oHkRuGCNDGj=xA4ooNvYrV38qYED+ipA2M_O_uJuA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 25 Aug 2023 17:53:28 -0600
Message-ID: <CAPnjgZ0kpMBatC475FmMF2sai_waMFK_Sf3mWxeSoLB_qYdXNA@mail.gmail.com>
Subject: Re: [PATCH] bootstd: Drop some TODOs
To: Tony Dinh <mibodhi@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
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

On Fri, 25 Aug 2023 at 14:17, Tony Dinh <mibodhi@gmail.com> wrote:
>
> Hi Simon,
>
> On Thu, Aug 24, 2023 at 6:48=E2=80=AFPM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > The existing TODOs are done, so remove them. Add another that came up
> > today.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  doc/develop/bootstd.rst | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/doc/develop/bootstd.rst b/doc/develop/bootstd.rst
> > index ec3136535783..3e566e994d6c 100644
> > --- a/doc/develop/bootstd.rst
> > +++ b/doc/develop/bootstd.rst
> > @@ -752,9 +752,7 @@ To do
> >
> >  Some things that need to be done to completely replace the distro-boot=
 scripts:
> >
> > -- add bootdev drivers for dhcp, sata, scsi, ide, virtio
>
> Good to see SATA finally in bootdev driver! I'm testing bootstd on a
> couple boards, and have been waiting for SATA bootdev. Any idea, if I
> should wait for it to be merged to the next branch, or is there an
> easy way to do it with one of your patches (I can test it on the
> latest master branch or next branch).

I believe it went in in the last release - see drivers/scsi/scsi_bootdev.c

If you need something else for SATA, PLMK.

Regards,
Simon


>
> Thanks,
> Tony
>
> > -- PXE boot for EFI
> > -- support for loading U-Boot scripts
> > +- implement extensions (devicetree overlays with add-on boards)
> >
> >  Other ideas:
> >
> > --
> > 2.42.0.rc1.204.g551eb34607-goog
> >
