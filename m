Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FCEDC3DA49
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 14:55:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 176CF8858C;
	Fri, 26 Jul 2024 16:55:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bj36LFqK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCADF88585; Fri, 26 Jul 2024 16:54:58 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 611CE8858C
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 16:54:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6b7a8cada97so3534816d6.3
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 07:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722005694; x=1722610494; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wriFYu3hV11MHZW8i/VcuIBiNUjLjFbsK2GGMPmeFic=;
 b=bj36LFqKkTZFQPorcDFlUfRvNzbJ6h+027l0F+R8uz10uAz5KvdlW3mGMh5rBZBB54
 BDFMfFytGF+sE6Y9pnq2VEhy6F8qAB2jdYhJbBcFJFZLEaGbWMnVuYmxKBvLSlRkNsEp
 vbmQFP6ptmcKV9Z/doQT+iZNLdDYlaF41dW2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722005694; x=1722610494;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wriFYu3hV11MHZW8i/VcuIBiNUjLjFbsK2GGMPmeFic=;
 b=Jgis4mbE4sQz8/UY4pd2wQXZTHUjmvbNrH7oThDsxTtDvK1vqeyZboS3Zosw2O0aJ6
 Q5owQ5/TjSOG/Mlg2SYRvKUPx7qX0uhDRvZ5j0MXPNgJ3VYElo8pht2u55vrdQ3dBpBI
 S2nUvsPze+N6wU2LILlk9/yAfAhk5sl8YOddNJFoaNb9hFa1wkkRfB0br8E9X5rJ10LW
 KZU0boQxHBI1qQuUUVKW6TNSuOzLN33YnI6ODH//EZKgZ4W7qt8JljzHNKgUzvNF6fEj
 6P/BGib1Y7kjJ34JWnbyYM9SROsYwvqTYTjsjRhy1fVfzaX5dyAO4/cgqDT+6Bvb6f1F
 XsFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaLjUCbWlEV3P5iUQs/TJ5IxoYTI0aMzsK0MTn9WsPPITNnf6cT9YnL6zu+RiVi8pzuJSDs2XDTB35eWSzGowN8aDHhg==
X-Gm-Message-State: AOJu0YwKnDp7o04unJecGY26YArBPHYieOKddVhiRF6RmeDh1C6+4T/a
 cQ222BHUQ4US1oEOiqkvlb+6NNItYu2IGju6oPO5YMJX6Lu3vS/y6LoFzzUMFXsOR2fcZI9hq0A
 2FVvt1ypLaX7lcQZO8X9Hh2sRoSEkf+AnuJU9
X-Google-Smtp-Source: AGHT+IE2Rh4urCMtt5rmBpgtEJQr8OshQH2Rng7lppmenA5gAbShYosj4BnMIwIfRXOVgoH2VpLVzgMCAyMuJ7GH4YY=
X-Received: by 2002:a05:6214:2b0d:b0:6b5:4aa9:9682 with SMTP id
 6a1803df08f44-6bb55af91fcmr155936d6.41.1722005694254; Fri, 26 Jul 2024
 07:54:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240521104834.11295-1-marex@denx.de>
 <CAOMZO5DsyuCu+fjpa8GjB6mbp9b5n=YOGxtjgMkdSstGFmEUuA@mail.gmail.com>
 <CAFLszTiwqcPe98gwbt1oVnWYJ0yFQ6rTpdcrB2kw=YRH-9=JJA@mail.gmail.com>
 <CAFLszTg8UHv7WbYKMii_8_6m3m3TR0BCAaEVNWnQJb2otQRScw@mail.gmail.com>
 <d46433c5-f4a6-418a-bc23-1ae5ce6ba63a@denx.de>
 <CAFLszTi9wozfMHVwM-tg5bJGSwSOpreR=D3jardm8z=N621bng@mail.gmail.com>
 <01cf8243-3476-41a8-9d56-bdd2817a4569@denx.de>
 <CAFLszTheX=pbcZZR6dnjgvpg_KzvPUKRk3nC8UeFc-868G9tUA@mail.gmail.com>
In-Reply-To: <CAFLszTheX=pbcZZR6dnjgvpg_KzvPUKRk3nC8UeFc-868G9tUA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 26 Jul 2024 08:54:43 -0600
Message-ID: <CAFLszTjyU4L+Lo4bUf3onKAn_G8aPbeknM9COnTG_Ff9xe9dvQ@mail.gmail.com>
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

On Tue, 9 Jul 2024 at 03:24, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Marek,
>
> On Sun, 7 Jul 2024 at 01:55, Marek Vasut <marex@denx.de> wrote:
> >
> > On 6/27/24 10:19 AM, Simon Glass wrote:
> > > Hi Marek,
> >
> > Hi,
> >
> > >>>>>> Add new binman etype which allows signing both the SPL and fitImage sections
> > >>>>>> of i.MX8M flash.bin using CST. There are multiple DT properties which govern
> > >>>>>> the signing process, nxp,loader-address is the only mandatory one which sets
> > >>>>>> the SPL signature start address without the imx8mimage header, this should be
> > >>>>>> SPL text base. The key material can be configured using optional DT properties
> > >>>>>> nxp,srk-table, nxp,csf-crt, nxp,img-crt, all of which default the key material
> > >>>>>> names generated by CST tool scripts. The nxp,unlock property can be used to
> > >>>>>> unlock CAAM access in SPL section.
> > >>>>>>
> > >>>>>> Reviewed-by: Tim Harvey <tharvey@gateworks.com>
> > >>>>>> Signed-off-by: Marek Vasut <marex@denx.de>
> > >>>>>
> > >>>>> Applied the series, thanks.
> > >>>>
> > >>>> This lacks tests - can you please add sufficient tests in ftest.py to
> > >>>> get the cover coverage back to 100%? Please try 'binman test -T' to
> > >>>> see this.
> > >>>
> > >>> Any thoughts on this, please? At present -master is broken for one
> > >>> file and -next has three problems.
> > >>
> > >> It is in the pipeline.
> > >>
> > >> What exactly is the error you observe ?
> > >>
> > >> When I run binman test -T , I get a lot of output, but no error reports?
> > >
> > > Sorry I somehow missed this email.
> > >
> > > The tests are in ftest.py - there are lots of examples, e.g.
> > > testXilinxBootgenSigning() - commit d8a2d3b29
> >
> > This seems to be testing some out-of-tree tool , not binman ?
>
> It is testing the etype, which needs the tool to be present, yes, You
> can use 'binman tool -f' to fetch tools if you want to try that one.

We have gone past RC1, so I'm just checking how this is going?


>
> >
> > > Basically you need to create a test .dts file that uses your entry
> > > type, then use it in the test code. You can check error handling as
> > > well, e.g. by having an invalid dts too if needed.
> > >
> > > If you run 'binman test -T' you will see the code-coverage problem.
> > > You may need to fetch tools with 'binman tool -f missing' to get all
> > > the tools*:
> > >
> > > Coverage error: 96%, but should be 100%
> > > ValueError: Test coverage failure
> > >
> > > It is normally much easier to add an etype using a test than to test
> > > it by using it 'for real', since you don't need to worry about the
> > > U-Boot integration.
> >
> > Huh ...

Regards,
Simon
