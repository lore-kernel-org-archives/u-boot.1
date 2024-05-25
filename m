Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A983FC25B78
	for <u-boot@archiver.kernel.org>; Sat, 25 May 2024 19:14:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE79188286;
	Sat, 25 May 2024 21:14:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sdAnpUX6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DED10882A3; Sat, 25 May 2024 21:14:50 +0200 (CEST)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3D1087E3F
 for <U-Boot@lists.denx.de>; Sat, 25 May 2024 21:14:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-681907af4e7so1503218a12.1
 for <U-Boot@lists.denx.de>; Sat, 25 May 2024 12:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716664487; x=1717269287; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SIxtJm59W5A4mHaa5/NFsw/nYi0ZH0zuAVoSIozfr7I=;
 b=sdAnpUX6Vj0ECS5s4DPV3XSGGzHN8xVEIlmUCkjIqeMm8QhPww95HM/HzLAbjdD82w
 mkyIQzNWBsup6BBTs2BcYFIqkRCUEpNDs5R0DCBpNU6LLcRGMEsaQAh331gTYHIrjcqq
 GFh+fCn3Kj+e41+wLOz5iKRRotsQ//oFkaReyvawrq0TPmqZ87WFAINi9RNAJl1Ai7ZD
 BOxyplWHqbpf+IPR7GmWNRTE9mkb1pLBL03JEKrnlu+k8nkrZEUzJ7gva3SGjWnNmlFL
 IjiVp2dl2d3HvftbQAtnK8NWoPmHGhpSTk4dsyO9EneYtXvOvzx929Bjl+2uswY2JhhV
 lWcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716664487; x=1717269287;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SIxtJm59W5A4mHaa5/NFsw/nYi0ZH0zuAVoSIozfr7I=;
 b=FUjMSHvx13qbB4g3dj3yuhtCWwqO9yPbbkF0y4AyZR+Dhx4VenxsqrZ4AZPn0aem1x
 Hh6S2vlOroyJ3XCgfKmFGP1oEdzmBfBezQSok6Tmh1SKe7ZVyoUCIOHk5VQB23pWcBEQ
 YP7D3QsK+VshBwGMg1AuDJ7Uqy9MNJgaWGaHKeX4KMQLB0DFVe11xUktcTh0A4NMZlG5
 b/44yt6k6YoMmvHyscvSSrfC5OowbCOzKJoUmbfUqcDpESEGA3PzibNPD0Gju5r5bhrm
 yxLQGN6DbkW+iKhhNJtkgc5JPGKM31CIHLmtoa4NUR/0wlyjkcDfsoBRWbSUS/SidZrr
 XdNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUV6zAi09sjjF6qaJsQx022Ija5usCqg7GQr+QzxIya1unPlKFRl8OtBGox3LZdJvegj2aQZ1R3Z0x3/O1pRZ6hkxSbCA==
X-Gm-Message-State: AOJu0YyxDhF69gpjxX2bi73srqap9mWrWvajVkVpk43HwMlya6choByf
 Rqh2ChGNz9qsKKAb2BBxp2eisTsGaHm44rHDeJfr0qFVv+PSl21PBy+u8aM5ikQMmg3pjtYE1eA
 J3hYpzItG2eoSYVYgpYpsf2QHPl1IS4d8FKBTcw==
X-Google-Smtp-Source: AGHT+IE/IUDJT6urzwMmbiQd/fSV26mqJUf4bFswooPVX+KQhYmS2F7FYqxwpwEjIymtxrF+59yp39xDaijbKiDwx9Q=
X-Received: by 2002:a17:903:1248:b0:1e4:4000:a576 with SMTP id
 d9443c01a7336-1f4498ecf8cmr57399185ad.43.1716664487084; Sat, 25 May 2024
 12:14:47 -0700 (PDT)
MIME-Version: 1.0
References: <DM4PR11MB5296B1B9F0CFC701A8B11284E3EE2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <DM4PR11MB52961423BCE12552857A12A8E3EA2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240521162543.GU2568172@bill-the-cat>
 <DM4PR11MB529670F5CFDA6B4EDA7B7206E3EA2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240521164659.GZ2568172@bill-the-cat>
 <DM4PR11MB529668DA50F05F26AAD229F0E3EA2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240521181534.GD2568172@bill-the-cat>
 <d5887c6d-fc80-4f89-be51-db9b8da3863f@app.fastmail.com>
In-Reply-To: <d5887c6d-fc80-4f89-be51-db9b8da3863f@app.fastmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sat, 25 May 2024 22:14:09 +0300
Message-ID: <CAC_iWjLbY6+FaUYQw2Zv5y5byCnXRHxfzvrFf1dMyJX+ANP9VQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] Added arm64 assembly for examples/api crt0
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Tom Rini <trini@konsulko.com>, "Brunham, Kalen" <kalen.brunham@intel.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 "U-Boot@lists.denx.de" <U-Boot@lists.denx.de>
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

Hi Jiaxun

On Sat, 25 May 2024 at 19:21, Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>
>
>
> =E5=9C=A82024=E5=B9=B45=E6=9C=8821=E6=97=A5=E4=BA=94=E6=9C=88 =E4=B8=8B=
=E5=8D=887:15=EF=BC=8CTom Rini=E5=86=99=E9=81=93=EF=BC=9A
> [...]
> >
> > We have long not done a great job with the U-Boot standalone API stuff,
> > and for a number of years at this point a lot of the use cases it was
> > used for could instead be filled by making an EFI application. There's =
a
> > well defined API there, there's lots of examples, and frankly for the
> > license related questions, makes a much nicer answer.
>
> Hi Tom + U-Boot EFI folks,
>
> Sorry for chime in here.
>
> AFAIK there are quite a lot of users of U-Boot API in MIPS world, mostly =
for
> Bare mental applications to perform chip diagnostic or programming stuff.
>
> But I'd agree that there is no benefit to maintain ABI stuff in upstream
> for long run.
>
> However, I think people still need an API-like interface for those simple
> applications, while many architectures are not supported by U-Boot EFI fo=
r
> now.
>
> Sadly, most architectures are not covered by UEFI spec, some of them are
> violating fundamental assumptions of UEFI spec, like no 1:1 PA VA mapping
> or simply being Big Endian.
>
> Do you think it's a good idea to port EFI support to as many architecture=
s
> as possible, and produce U-Boot supplements to UEFI spec to cover those
> details? I'm happy to look into it.

I personally think U-Boot is a nice alternative to EDK2 for smaller
devices (and doesn't have to rely on the PI spec as well).
The EFI spec does have some architecture specific wording for the
supported platforms, so I would guess adding more would be possible.
But I haven't checked the extent of changes that are going to be
needed.

In any case, I am happy to help

Cheers
/Ilias
>
> Thanks
>
> >
> > That there's some power users out there making use of standalone to do
> > useful things is news to me. Some of them speaking up and offering to
> > be visible in maintaining it would be good (there's Coverity issues and
> > lack of CI testing, which should be addressed).
> >
> > --
> > Tom
> >
> > =E9=99=84=E4=BB=B6:
> > * signature.asc
>
> --
> - Jiaxun
