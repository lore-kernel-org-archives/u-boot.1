Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E260D16258
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 12:37:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C07388ED5;
	Mon, 14 Oct 2024 14:37:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bTfJ1D6f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C318A88EE3; Mon, 14 Oct 2024 14:37:40 +0200 (CEST)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D273C88B6D
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 14:37:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2fb59652cb9so1244391fa.3
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 05:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728909458; x=1729514258; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TRf5BNYHJ1dnLS2KgLg1wx+2hWiheUQIQ1s95RNwcdI=;
 b=bTfJ1D6fUrry3+xjVNGL3j9UDf7t7N3DYt2b8mDyCN9Ii1BXK/0ywbpm4qYnHDA7cP
 8BMIKgpzeSs+UNfCE/LIeBSX/0byWIEb67w7t+nJzve6BPVApm4M9ddgaySZjSI4aFWf
 w8nPDpv9xnVonaoqGbjFHBqAxCXsMXc5e8ULqg5SiFFvAk1hTgMNfMIBDFOXSBXf3z4w
 aJPyufz2K53Pi7aP+B67NYn5nYHLG4RaYREVuD/wz53HKqE0qT1Bm3dumBfoM0BEhy7t
 X758mrVdx4BPvtqbZF3kBtr4QnGq7tNC7UJcI/IBd2CAAjv70eSYpae9ZRUTzEDGR2KH
 Uung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728909458; x=1729514258;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TRf5BNYHJ1dnLS2KgLg1wx+2hWiheUQIQ1s95RNwcdI=;
 b=AFAXR04khuajb9IDreQ1WJxy9AQmY3H+KSYYC8QCBJ16RiKIWLuedcSwiqFx4JHDX9
 5fv++hDbbRihtKxo35Hz3pVmK0Bg1jaw0cbshDXvneRqjRICW/olJhV02nJXAcsEUdLO
 3YUwna3HFbR9Iidch1Ve13YZ3WvnmrMlfmL004anBDupX5Psl+RXtn9O4dKJT0Cuh7cK
 0sMDqJDKxSwBRJEiMGdeHvcSEjUtPg6guQMs8+xQ7MewiD4aP3c7DQpYlKKxItx2PBJZ
 MDHe+Q/DW2rtcPP288US2CM3e1WqZDzBVnaD1CW+sziKHDktUYFgvsTNDF8otuTqhH+s
 RF5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuziASFRF6zjYhVZy419/tiMuOLpyrM2I2AJBqtEsxKOq/vOsigGC7wIZdBcBWSBtGZfNtBOE=@lists.denx.de
X-Gm-Message-State: AOJu0YzC+r2cVaTw/Ullf9EO4lz2yFfgBj04YvM1K9TK8bqiOPmAYAFl
 TXasHpNwwnlVCJnTzxvw/19aZwkgNoc0594oTDlvgL1EExACRUanJKpGdUk9VY5cpJZof0tJEyR
 2j/71N/su2yEPLYDp/0KChFAwJM4=
X-Google-Smtp-Source: AGHT+IHKksk+3uigiKhbhN0zDvZRIvqYUpZIgz4U2wzp/0NNDqMDrky84jVnYMCinLikpy2ZHQfEruhTAxrLfSzg8O8=
X-Received: by 2002:a2e:b8c1:0:b0:2fa:d67a:adb8 with SMTP id
 38308e7fff4ca-2fb32740243mr47857921fa.8.1728909457645; Mon, 14 Oct 2024
 05:37:37 -0700 (PDT)
MIME-Version: 1.0
References: <20241011170914.1980541-1-pbrobinson@gmail.com>
 <CAFLszTh9ryJNetLVS6Bwe3D1WDhMwvNxd2c4_uJKUmXXK9LXWg@mail.gmail.com>
In-Reply-To: <CAFLszTh9ryJNetLVS6Bwe3D1WDhMwvNxd2c4_uJKUmXXK9LXWg@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 14 Oct 2024 13:37:26 +0100
Message-ID: <CALeDE9Mec9jiLyAAqhJLawy9Py1rmYySqb8TfXn0nowNgy0veg@mail.gmail.com>
Subject: Re: [PATCH v2] board: rpi: Pass CMA through from firmware DT
To: Simon Glass <sjg@chromium.org>
Cc: Matthias Brugger <mbrugger@suse.com>, u-boot@lists.denx.de
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

On Sun, 13 Oct 2024 at 20:34, Simon Glass <sjg@chromium.org> wrote:
>
> On Fri, 11 Oct 2024 at 11:09, Peter Robinson <pbrobinson@gmail.com> wrote:
> >
> > For a lot of usecases, such as display, camera, media
> > the Raspberry Pi needs a lot more CMA than distros
> > configure as default so we should pass this parameter
> > through so things work as expected. Fix a spelling
> > mistake while we're at it.
> >
> > Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> > ---
> >
> > v2: Update the cma string
> >
> >  board/raspberrypi/rpi/rpi.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
>
> > diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
> > index ab5ea85cf9f..dd5a318d239 100644
> > --- a/board/raspberrypi/rpi/rpi.c
> > +++ b/board/raspberrypi/rpi/rpi.c
> > @@ -540,12 +540,15 @@ void  update_fdt_from_fw(void *fdt, void *fw_fdt)
> >         if (fdt == fw_fdt)
> >                 return;
> >
> > -       /* The firmware provides a more precie model; so copy that */
> > +       /* The firmware provides a more precise model; so copy that */
> >         copy_property(fdt, fw_fdt, "/", "model");
> >
> >         /* memory reserve as suggested by the firmware */
> >         copy_property(fdt, fw_fdt, "/", "memreserve");
> >
> > +       /* copy the CMA memory setting from the firmware DT to linux */
> > +       copy_property(fdt, fw_fdt, "/reserved-memory/linux,cma", "size");
>
> Does this need / have nodes pointing to it from elsewhere in the tree?

Yes! It doesn't work without the /, I am planning on looking at this
some more but this fixes the issue at hand. Using the fdt cmd from the
command prompt needs it as well.

> > +
> >         /* Adjust dma-ranges for the SD card and PCI bus as they can depend on
> >          * the SoC revision
> >          */
> > --
> > 2.47.0
> >
>
> Regards,
> Simon
