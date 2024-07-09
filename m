Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A1CEC3DA41
	for <u-boot@archiver.kernel.org>; Tue,  9 Jul 2024 09:24:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E87E2885CC;
	Tue,  9 Jul 2024 11:24:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="e9dqqmuG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 242A287EEE; Tue,  9 Jul 2024 11:24:50 +0200 (CEST)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C81AE88599
 for <u-boot@lists.denx.de>; Tue,  9 Jul 2024 11:24:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-79f0e7faafcso174837985a.3
 for <u-boot@lists.denx.de>; Tue, 09 Jul 2024 02:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720517087; x=1721121887; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=w/1D6Rjtad6BXX1PjmUe65YcavMFOzTcheIzQeT7vjo=;
 b=e9dqqmuGxWpv2x79h2rTY/YW0LwVXp+EG7sbhHGMAlckrL1OWMOpxzzD5vew4feI5u
 yUP/mlCF1qwR5B/kzEyxhBNBYKSV3gPYxOMBLfAQ2AWzLVUIAuAyifBjAwtohUXZAoKj
 hY2YRRPMydARaHqPeTGKx1fngW0z4AzWgEEIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720517087; x=1721121887;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w/1D6Rjtad6BXX1PjmUe65YcavMFOzTcheIzQeT7vjo=;
 b=UGpH55cyiTtbICFm6Wv3B+9Mq4/1JZgp4QuQdw9ReUVRDHXla3y3GiSzB7qG5eQSy0
 eUq0LjtPL7diTJ/tCaaDaZHrUu9z/sLwdmWXVJv+pl8P6rKCHcOcDrB5PxZODedQ0UbF
 OoxzUp2ONH9mJmlPDna4fMFl+NbKOfz4cRCqZlpQwX8Qiek30ohcdQ9hvOw5asBs9A5/
 efL+viajM2amRbvMKnvvuxzvH+RSmr5wqeUMBebFlasIhOJPIiVNJUOBUZ3bbQYrlKs3
 dnM72dNClzzYzA1NuI3K8dSmxSMwic44tcjlinZ+L9DwMM5GZoL7v/b6fRyJ3LRgwgu4
 1dSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZ5RVWHm2a+as15puY1til4J6CgjoxXQsufQcrmWtCOWbH2DnjA8rkFdFhdKniSOzwrbivOy9A75HyDN00f9diRxQ7YQ==
X-Gm-Message-State: AOJu0YwBEPjv3ltGsu1lCUXQ1cd+zCccWfYMTQthdjLfmsWiaDkkP+aa
 RAf/PBNBZjyYNQrX4SnjuAyFBVpJw9TpQ7+/BlSzAx7mvhLW85wixLH3nSxmJbvP52XOcsUkrPn
 vroRyr3hQHEElz2FDORV5XicScI8iAG01mPVo
X-Google-Smtp-Source: AGHT+IHJruxFn0RtEsFTzeiKt7UABmD3yRfNqSRfchI1CFoxZwLdAKqP4aoLzWxb7JcwQpJCoKiOh/UX4lpU4XCGg/k=
X-Received: by 2002:a37:e10b:0:b0:796:842c:7808 with SMTP id
 af79cd13be357-79f199f5fa6mr180907485a.4.1720517086619; Tue, 09 Jul 2024
 02:24:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240521104834.11295-1-marex@denx.de>
 <CAOMZO5DsyuCu+fjpa8GjB6mbp9b5n=YOGxtjgMkdSstGFmEUuA@mail.gmail.com>
 <CAFLszTiwqcPe98gwbt1oVnWYJ0yFQ6rTpdcrB2kw=YRH-9=JJA@mail.gmail.com>
 <CAFLszTg8UHv7WbYKMii_8_6m3m3TR0BCAaEVNWnQJb2otQRScw@mail.gmail.com>
 <d46433c5-f4a6-418a-bc23-1ae5ce6ba63a@denx.de>
 <CAFLszTi9wozfMHVwM-tg5bJGSwSOpreR=D3jardm8z=N621bng@mail.gmail.com>
 <01cf8243-3476-41a8-9d56-bdd2817a4569@denx.de>
In-Reply-To: <01cf8243-3476-41a8-9d56-bdd2817a4569@denx.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 9 Jul 2024 10:24:35 +0100
Message-ID: <CAFLszTheX=pbcZZR6dnjgvpg_KzvPUKRk3nC8UeFc-868G9tUA@mail.gmail.com>
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

On Sun, 7 Jul 2024 at 01:55, Marek Vasut <marex@denx.de> wrote:
>
> On 6/27/24 10:19 AM, Simon Glass wrote:
> > Hi Marek,
>
> Hi,
>
> >>>>>> Add new binman etype which allows signing both the SPL and fitImage sections
> >>>>>> of i.MX8M flash.bin using CST. There are multiple DT properties which govern
> >>>>>> the signing process, nxp,loader-address is the only mandatory one which sets
> >>>>>> the SPL signature start address without the imx8mimage header, this should be
> >>>>>> SPL text base. The key material can be configured using optional DT properties
> >>>>>> nxp,srk-table, nxp,csf-crt, nxp,img-crt, all of which default the key material
> >>>>>> names generated by CST tool scripts. The nxp,unlock property can be used to
> >>>>>> unlock CAAM access in SPL section.
> >>>>>>
> >>>>>> Reviewed-by: Tim Harvey <tharvey@gateworks.com>
> >>>>>> Signed-off-by: Marek Vasut <marex@denx.de>
> >>>>>
> >>>>> Applied the series, thanks.
> >>>>
> >>>> This lacks tests - can you please add sufficient tests in ftest.py to
> >>>> get the cover coverage back to 100%? Please try 'binman test -T' to
> >>>> see this.
> >>>
> >>> Any thoughts on this, please? At present -master is broken for one
> >>> file and -next has three problems.
> >>
> >> It is in the pipeline.
> >>
> >> What exactly is the error you observe ?
> >>
> >> When I run binman test -T , I get a lot of output, but no error reports?
> >
> > Sorry I somehow missed this email.
> >
> > The tests are in ftest.py - there are lots of examples, e.g.
> > testXilinxBootgenSigning() - commit d8a2d3b29
>
> This seems to be testing some out-of-tree tool , not binman ?

It is testing the etype, which needs the tool to be present, yes, You
can use 'binman tool -f' to fetch tools if you want to try that one.

>
> > Basically you need to create a test .dts file that uses your entry
> > type, then use it in the test code. You can check error handling as
> > well, e.g. by having an invalid dts too if needed.
> >
> > If you run 'binman test -T' you will see the code-coverage problem.
> > You may need to fetch tools with 'binman tool -f missing' to get all
> > the tools*:
> >
> > Coverage error: 96%, but should be 100%
> > ValueError: Test coverage failure
> >
> > It is normally much easier to add an etype using a test than to test
> > it by using it 'for real', since you don't need to worry about the
> > U-Boot integration.
>
> Huh ...

Regards,
Simon
