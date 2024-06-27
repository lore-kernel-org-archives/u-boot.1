Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 323E5C2BD09
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 08:19:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77956884F1;
	Thu, 27 Jun 2024 10:19:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VdnkBCD+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE184880A5; Thu, 27 Jun 2024 10:19:26 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9DC9884F1
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 10:19:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6b5834b3a94so8096546d6.2
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 01:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719476363; x=1720081163; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IoDGAxKQxg9afLvpiAfpulQimyfK3h9im+ypv6Kz85M=;
 b=VdnkBCD+Xd14suUZuCsqlszr2c4e2f436OgqgrOnzgL7AxHVSlBu7L76LqEIf0fjUt
 VEafh9A9I1V1/7Makj+E/Qa52Y6B8v7xbwogkHlWiLvtTiNmLnh5VMKEI+OOm6VHex9Y
 aOZPXO0LrUHAWqJvG7ZXfswdOYNLVlljIz+X8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719476363; x=1720081163;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IoDGAxKQxg9afLvpiAfpulQimyfK3h9im+ypv6Kz85M=;
 b=YOSOVNz7sDMsqQk2tcsSFi5DtQYsxLn17IwXu8qqis5jhwBUKOoSjxuFICksnEHzrY
 9uqSEwFzV9AB2+/wFCtBaI81XWRRyPtL6ks6M7HWp8cNNBoaVmDGylckneYRkKW8mG0w
 dyw4aYiDvdyS2Aj3xp97mU93P9bYp/KCo9iGmbpqSHTU3Do/9d4XyZ6dWPdx8kbX/Bk7
 oTuyvKAEtj7AyvNrzjGkKAo6lyOFGq7mk3d5PHVYmtlyl63HvvzJ8Sg9hfy9z502ySGV
 smyUxmvK2TLijaRbSFA1DrNdDi+xEgIb6Ue5ZvSRnqg5ezNqrsnLqfDXP05OxfukrPe1
 pJmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFOd4iXFO398NIx54BbPeq43HjTsyYAhFq8kcDmniBzxbAzGIeVca7JV5FcOhoUPLhm5W2sZmoa+y/Rk0pl3iKY3hbSw==
X-Gm-Message-State: AOJu0Ywjj0FkNR5zx98B3W4zMxkHdudMDfn4McYrcoe/dA3TWrgQLJkm
 YbZiGfRrJDVYRgjA0GcpFW0v1wjFFJ/23P7W+h1Bw9CPONRFjSc8oXO85IcBO6JTvHJ4Jc8r2qF
 D0/yefGRLF490ohwEUAyCjDL021RRrR4uLmwU
X-Google-Smtp-Source: AGHT+IEj8g1Pek8T2jZMMLR0QGYh1+g1BHCcAsQpk8UAPFN0txjQ213rdJZ9eW262AM9qJccC5MC99Snn+KZlLU0aIY=
X-Received: by 2002:a0c:cb08:0:b0:6b4:fbec:952f with SMTP id
 6a1803df08f44-6b53bcd3e9bmr139121166d6.25.1719476363701; Thu, 27 Jun 2024
 01:19:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240521104834.11295-1-marex@denx.de>
 <CAOMZO5DsyuCu+fjpa8GjB6mbp9b5n=YOGxtjgMkdSstGFmEUuA@mail.gmail.com>
 <CAFLszTiwqcPe98gwbt1oVnWYJ0yFQ6rTpdcrB2kw=YRH-9=JJA@mail.gmail.com>
 <CAFLszTg8UHv7WbYKMii_8_6m3m3TR0BCAaEVNWnQJb2otQRScw@mail.gmail.com>
 <d46433c5-f4a6-418a-bc23-1ae5ce6ba63a@denx.de>
In-Reply-To: <d46433c5-f4a6-418a-bc23-1ae5ce6ba63a@denx.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 27 Jun 2024 09:19:13 +0100
Message-ID: <CAFLszTi9wozfMHVwM-tg5bJGSwSOpreR=D3jardm8z=N621bng@mail.gmail.com>
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

Hi Marek,

On Tue, 18 Jun 2024 at 16:30, Marek Vasut <marex@denx.de> wrote:
>
> On 6/18/24 2:43 PM, Simon Glass wrote:
> > Hi again,
> >
> > On Tue, 11 Jun 2024 at 12:51, Simon Glass <sjg@chromium.org> wrote:
> >>
> >> Hi,
> >>
> >> On Fri, 24 May 2024 at 10:26, Fabio Estevam <festevam@gmail.com> wrote=
:
> >>>
> >>> On Tue, May 21, 2024 at 7:48=E2=80=AFAM Marek Vasut <marex@denx.de> w=
rote:
> >>>>
> >>>> Add new binman etype which allows signing both the SPL and fitImage =
sections
> >>>> of i.MX8M flash.bin using CST. There are multiple DT properties whic=
h govern
> >>>> the signing process, nxp,loader-address is the only mandatory one wh=
ich sets
> >>>> the SPL signature start address without the imx8mimage header, this =
should be
> >>>> SPL text base. The key material can be configured using optional DT =
properties
> >>>> nxp,srk-table, nxp,csf-crt, nxp,img-crt, all of which default the ke=
y material
> >>>> names generated by CST tool scripts. The nxp,unlock property can be =
used to
> >>>> unlock CAAM access in SPL section.
> >>>>
> >>>> Reviewed-by: Tim Harvey <tharvey@gateworks.com>
> >>>> Signed-off-by: Marek Vasut <marex@denx.de>
> >>>
> >>> Applied the series, thanks.
> >>
> >> This lacks tests - can you please add sufficient tests in ftest.py to
> >> get the cover coverage back to 100%? Please try 'binman test -T' to
> >> see this.
> >
> > Any thoughts on this, please? At present -master is broken for one
> > file and -next has three problems.
>
> It is in the pipeline.
>
> What exactly is the error you observe ?
>
> When I run binman test -T , I get a lot of output, but no error reports?

Sorry I somehow missed this email.

The tests are in ftest.py - there are lots of examples, e.g.
testXilinxBootgenSigning() - commit d8a2d3b29

Basically you need to create a test .dts file that uses your entry
type, then use it in the test code. You can check error handling as
well, e.g. by having an invalid dts too if needed.

If you run 'binman test -T' you will see the code-coverage problem.
You may need to fetch tools with 'binman tool -f missing' to get all
the tools*:

Coverage error: 96%, but should be 100%
ValueError: Test coverage failure

It is normally much easier to add an etype using a test than to test
it by using it 'for real', since you don't need to worry about the
U-Boot integration.

* There are some annoying things though, such as mkeficapsule being
old in the u-boot-tools package so not supporting the tests properly.
Also testTIBoardConfigLint needs 'pip install yamllint'

Regards,
Simon
