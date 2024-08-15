Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD0CC3DA7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 20:33:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2B3088C01;
	Thu, 15 Aug 2024 22:33:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lmE20a/6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3338888B63; Thu, 15 Aug 2024 22:33:11 +0200 (CEST)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E84888BF9
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 22:33:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-71275436546so1138123b3a.1
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 13:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723753984; x=1724358784; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=O/ctHgR9omNfE3+5CBSNvjOODrD7zfYuJhz659bq+tk=;
 b=lmE20a/665+AEuAA4r/4Q54KbnxGv7Qyc+Grty6CMcsSucoSy8x4h6PLkVwMNnvBGL
 kZJrAU2OnX3aHdasnxMAp/QgpKbQjxoB+8i+zsFCeRdJUS/K/L//x2NSTkZ9Kc6e5aJ/
 GLZpOzNYlCtRr6OpCP3yFuRypsW0pGsmICmy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723753984; x=1724358784;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O/ctHgR9omNfE3+5CBSNvjOODrD7zfYuJhz659bq+tk=;
 b=uLmr+wJ4ERW6v536vJRX7TGudswfFUgjqNTi5RpHao+nJGwZfuu8Y4Ou1OnNbIylL7
 Vj8Q5RMjvunHX7Mkv6KIQP1IuzQckTQiMXrOn2yImICQO9l43XZbgj93GgKAhGRoBCWk
 qaK3p+kA+ak8hYoJFNCL5igOQTfg4oswYqZnNT9yVOjIBxa9cHCMNYyT51gxJfVrfhTF
 Zjamk90L6bVkH0xEestRPoc8pv0S0QHEc3ilQcFQVHIbFDSFff8bqCws+pWGOk8DW79m
 XZKH5HobOWR6Rukd7DrT5ggFImeiip4yOU36f2rUlprioJN7WPgCXzXkPoR0ScpHX53y
 TmRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU96VSA5scxTro5PS4kFfobtqkJ2OxbAYBcP6oQUh0xBJnaCYl5+r3vlWnnf4r0r1XzXTGDyoBd8pdikz7kDxvXbhWjRg==
X-Gm-Message-State: AOJu0YxgAWd/lGGid+hXvvWHVjkZowmj/S1nT/Z2mhjNl/qZtvaMzJDQ
 zKIMyy6casv587ySOf42e26YMtkuDLOMNJchnUwOCmdF8J2NpBWEY+6nm+J8E7iwnAZOVO/ji4W
 QOTm1djG15fcBvNaYVbpo3kYX/ffxBj7nnyxD
X-Google-Smtp-Source: AGHT+IEYBQK3xsImYjcpRS3u0fiHYKCJHNf7WCYw6y3RZ7wLXJlzOGVMAILaNrIdA98SGsi/BfaoX34oNa1QtoxP00M=
X-Received: by 2002:a05:6a21:78d:b0:1c4:9cec:ea0a with SMTP id
 adf61e73a8af0-1c905025efbmr1118672637.37.1723753984343; Thu, 15 Aug 2024
 13:33:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240521104834.11295-1-marex@denx.de>
 <CAOMZO5DsyuCu+fjpa8GjB6mbp9b5n=YOGxtjgMkdSstGFmEUuA@mail.gmail.com>
 <CAFLszTiwqcPe98gwbt1oVnWYJ0yFQ6rTpdcrB2kw=YRH-9=JJA@mail.gmail.com>
 <CAFLszTg8UHv7WbYKMii_8_6m3m3TR0BCAaEVNWnQJb2otQRScw@mail.gmail.com>
 <d46433c5-f4a6-418a-bc23-1ae5ce6ba63a@denx.de>
 <CAFLszTi9wozfMHVwM-tg5bJGSwSOpreR=D3jardm8z=N621bng@mail.gmail.com>
 <01cf8243-3476-41a8-9d56-bdd2817a4569@denx.de>
 <CAFLszTheX=pbcZZR6dnjgvpg_KzvPUKRk3nC8UeFc-868G9tUA@mail.gmail.com>
 <CAFLszTjyU4L+Lo4bUf3onKAn_G8aPbeknM9COnTG_Ff9xe9dvQ@mail.gmail.com>
In-Reply-To: <CAFLszTjyU4L+Lo4bUf3onKAn_G8aPbeknM9COnTG_Ff9xe9dvQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 15 Aug 2024 21:32:53 +0100
Message-ID: <CAFLszTjeSM2t6QGc5qLOZsuNnZCt2uPPunLYbb8YuRGARGBXQg@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] binman: Add nxp_imx8mcst etype for i.MX8M
 flash.bin signing
To: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <festevam@gmail.com>, u-boot@lists.denx.de,
 anton.gres@ifm.com, ch@denx.de, Tim Harvey <tharvey@gateworks.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Adam Ford <aford173@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Angus Ainslie <angus@akkea.ca>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Stefan Eichenberger <stefan.eichenberger@toradex.com>,
 Stefano Babic <sbabic@denx.de>, 
 Tom Rini <trini@konsulko.com>, kernel@puri.sm, u-boot@dh-electronics.com
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

Hi Marek,

On Fri, 26 Jul 2024 at 08:54, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Marek,
>
> On Tue, 9 Jul 2024 at 03:24, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Marek,
> >
> > On Sun, 7 Jul 2024 at 01:55, Marek Vasut <marex@denx.de> wrote:
> > >
> > > On 6/27/24 10:19 AM, Simon Glass wrote:
> > > > Hi Marek,
> > >
> > > Hi,
> > >
> > > >>>>>> Add new binman etype which allows signing both the SPL and fitImage sections
> > > >>>>>> of i.MX8M flash.bin using CST. There are multiple DT properties which govern
> > > >>>>>> the signing process, nxp,loader-address is the only mandatory one which sets
> > > >>>>>> the SPL signature start address without the imx8mimage header, this should be
> > > >>>>>> SPL text base. The key material can be configured using optional DT properties
> > > >>>>>> nxp,srk-table, nxp,csf-crt, nxp,img-crt, all of which default the key material
> > > >>>>>> names generated by CST tool scripts. The nxp,unlock property can be used to
> > > >>>>>> unlock CAAM access in SPL section.
> > > >>>>>>
> > > >>>>>> Reviewed-by: Tim Harvey <tharvey@gateworks.com>
> > > >>>>>> Signed-off-by: Marek Vasut <marex@denx.de>
> > > >>>>>
> > > >>>>> Applied the series, thanks.
> > > >>>>
> > > >>>> This lacks tests - can you please add sufficient tests in ftest.py to
> > > >>>> get the cover coverage back to 100%? Please try 'binman test -T' to
> > > >>>> see this.
> > > >>>
> > > >>> Any thoughts on this, please? At present -master is broken for one
> > > >>> file and -next has three problems.
> > > >>
> > > >> It is in the pipeline.
> > > >>
> > > >> What exactly is the error you observe ?
> > > >>
> > > >> When I run binman test -T , I get a lot of output, but no error reports?
> > > >
> > > > Sorry I somehow missed this email.
> > > >
> > > > The tests are in ftest.py - there are lots of examples, e.g.
> > > > testXilinxBootgenSigning() - commit d8a2d3b29
> > >
> > > This seems to be testing some out-of-tree tool , not binman ?
> >
> > It is testing the etype, which needs the tool to be present, yes, You
> > can use 'binman tool -f' to fetch tools if you want to try that one.
>
> We have gone past RC1, so I'm just checking how this is going?

Are you going to be able to get this test in soon?


>
>
> >
> > >
> > > > Basically you need to create a test .dts file that uses your entry
> > > > type, then use it in the test code. You can check error handling as
> > > > well, e.g. by having an invalid dts too if needed.
> > > >
> > > > If you run 'binman test -T' you will see the code-coverage problem.
> > > > You may need to fetch tools with 'binman tool -f missing' to get all
> > > > the tools*:
> > > >
> > > > Coverage error: 96%, but should be 100%
> > > > ValueError: Test coverage failure
> > > >
> > > > It is normally much easier to add an etype using a test than to test
> > > > it by using it 'for real', since you don't need to worry about the
> > > > U-Boot integration.
> > >
> > > Huh ...

Regards,
Simon
