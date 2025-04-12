Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90810C369AE
	for <u-boot@archiver.kernel.org>; Sat, 12 Apr 2025 15:51:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B21A382CB6;
	Sat, 12 Apr 2025 17:51:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cK8hXno+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D63782CD9; Sat, 12 Apr 2025 17:51:18 +0200 (CEST)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05A4582CA6
 for <u-boot@lists.denx.de>; Sat, 12 Apr 2025 17:51:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-60402c94319so1464269eaf.1
 for <u-boot@lists.denx.de>; Sat, 12 Apr 2025 08:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744473074; x=1745077874; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MGqQKpHSR3nQIuDlPpzntkwbA3qJGFTXnEcUsCxO0MY=;
 b=cK8hXno+eTRZ3NdTUrO9fJF/HTNtzhv1pcwgAr8L/3GT4WHTK2gUA7AL14tc+2T+h9
 1mXsl8nlOhfrVPT+3Ta0bDdStUVw6LGzZqQOIDZkP8BB6gg7BuECT7374MhMmoI2Ykd3
 zhgUBatWnBofcQJWf45VnCsyxMJUp3q2LOrIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744473074; x=1745077874;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MGqQKpHSR3nQIuDlPpzntkwbA3qJGFTXnEcUsCxO0MY=;
 b=NWKPiSyargjEvCZ/IY3wfKjsDDQsP03NO0bDEQzJFhaD8RAx0RAQ7ozZk6Y0s5/yc6
 RqNvDEhNQCPqqA8t1N/sOhWLOd+aLSdp/tI68QOzXscGvL6OU+ArwZ59mQ4PXv1Hkvjv
 UhbQs+BRhk10a8MAHW9iOK9IQX97vKQXAkR/DtBnakC1JpBs9kL1nFyZW2S6ihqlgAtU
 7ZXK9r/65FsxU+9MVGrCekO8V8J5Y6JBvbodIrstBsGPNKg5648Znr43I78g5VViIdRo
 e07BqHzImT38OJaeHJokZP9FLg+5E/rrQbKlYQ52ms9VrU5O0czC5LgkIkjtHVQCJLB/
 4zww==
X-Gm-Message-State: AOJu0YwNJkAWf5ivXOkM1i8dCv1jvsTSg1Cv+DYBMs90Ip5gCH4FMMlB
 C5KVpgVLhkOZ7TQKAJOq2AqulNn1gOv/PhzBoUpQ372/rBo5h1iNMLqRz1pXqdU=
X-Gm-Gg: ASbGncv9B21N8JOYfP5+/ymBF4mqm36PsQLa4r+ONEZGeVhz11tDM7/rx93wmiI1AZ8
 qgxjroJpcNc3hoZQtbId5jn1uFvtbNeNxwkg3rVyLrq6LjTNKTc6KU+n3Wzl/3VDFDVbhZbvKCq
 Szny+3PBJ9AJPVOdxNnGJlGT6vVCT/U9HU1qj+rJ/85pfEwE7QoB96jCBPyXvnEf6H/LOZCODFX
 O1ZWTuzXnPsmeCZxxzu3czTgxdnsiJkRUTgAhFrttrN2V5orh2x0o8+gsgKEsboNsQvGNzjovsZ
 Xacdmn8SmfW/6qFU/w4cyGyjGT3yXliq1SZha6ppyhG8lvnS6Zmio6o9tJ5Tl3NS+yk4ru6JSN2
 WqQ==
X-Google-Smtp-Source: AGHT+IFE0J+RtnwkB4gicJAB1RSn3I1KtY8BIiYIvZmG1/UKFjz7q3A7ITkK5y3hEgd6zl7mKpUYvA==
X-Received: by 2002:a05:6820:1b88:b0:5fc:e026:f073 with SMTP id
 006d021491bc7-6046f5bfc02mr3109203eaf.8.1744473074470; 
 Sat, 12 Apr 2025 08:51:14 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6045f522fffsm1337489eaf.10.2025.04.12.08.51.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Apr 2025 08:51:13 -0700 (PDT)
Date: Sat, 12 Apr 2025 09:51:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alexander Graf <agraf@csgraf.de>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Nikhil M Jain <n-jain1@ti.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH 00/13] video: Enhancements related to truetype and console
Message-ID: <20250412155110.GA5495@bill-the-cat>
References: <20250401172948.1236000-1-sjg@chromium.org>
 <20250401214113.GP5495@bill-the-cat>
 <CAFLszTjJuY9pQDerNuFcmkRuZbJU+EfPSBTrDyhjFMZg+usPnA@mail.gmail.com>
 <20250402150024.GU5495@bill-the-cat>
 <CAFLszTh-N2PSKPV_OHa63mEi1ar6Y9+p+A4UTfTbf329wOiN9w@mail.gmail.com>
 <20250402211100.GD5495@bill-the-cat>
 <CAFLszThRQi2o5g5S+=eciOS8+XC8TV9AyBpYf9LQKmH-2kkmvw@mail.gmail.com>
 <20250403002754.GH5495@bill-the-cat>
 <CAFLszTj2kJhu3-5wJuKbJ0F+0AAcDqEdt7npOT2L=GzcjP4Zew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="osFE4k1TsLV3OhEq"
Content-Disposition: inline
In-Reply-To: <CAFLszTj2kJhu3-5wJuKbJ0F+0AAcDqEdt7npOT2L=GzcjP4Zew@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--osFE4k1TsLV3OhEq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 04, 2025 at 06:57:34AM +1300, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 3 Apr 2025 at 13:27, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Apr 03, 2025 at 12:54:55PM +1300, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Thu, 3 Apr 2025 at 10:11, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Thu, Apr 03, 2025 at 08:19:03AM +1300, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Thu, 3 Apr 2025 at 04:00, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Wed, Apr 02, 2025 at 01:08:56PM +1300, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Wed, 2 Apr 2025 at 10:41, Tom Rini <trini@konsulko.com> wr=
ote:
> > > > > > > >
> > > > > > > > On Wed, Apr 02, 2025 at 06:29:31AM +1300, Simon Glass wrote:
> > > > > > > >
> > > > > > > > > This series includes some precursor patches needed for fo=
rthcoming expo
> > > > > > > > > enhancements.
> > > > > > > > >
> > > > > > > > > - truetype support for multiple lines
> > > > > > > > > - make white-on-black a runtime option
> > > > > > > > > - support drawing a rectangle
> > > > > > > > >
> > > > > > > > > This series was split out from schd2
> > > > > > > > [snip]
> > > > > > > > > base-commit: 3f76d803db9b500f43bc534465945a8d2836bb3e
> > > > > > > > > branch: schg
> > > > > > > >
> > > > > > > > I get as far as patch 4 before it doesn't apply to -next.
> > > > > > >
> > > > > > > Your tree is missing the video-damage series which adds some =
more
> > > > > > > tests. It is here if you want to pick it up:
> > > > > > >
> > > > > > > https://patchwork.ozlabs.org/project/uboot/list/?series=3D369=
663&state=3D*
> > > > > > >
> > > > > > > I can rebase and send a PR if you prefer.
> > > > > >
> > > > > > Reading the cover letter again, that doesn't seem ready to merg=
e either.
> > > > >
> > > > > It seems OK to me. What are your concerns?
> > > >
> > > > The cover letter read to me like it should be further reworked to
> > > > address some of the problems it still has / exposed. That's likely =
why I
> > > > marked it as Changes Requested a year and a half ago.
> > >
> > > Which bit of it? Are you talking about my conversation with Alex, or
> > > the actual cover letter?
> >
> > Yes, I'm talking about the lengthy discussion in the cover letter which
> > sounds to me as a summary of "changes requested".
>=20
> Perhaps we should talk about this on a call sometime. I was trying to
> understand why EFI has to sync the video after every character. I
> still think we could sync only when there is an EFI event, e.g. by
> hooking up cyclic, but in the end there wasn't really anything
> actionable for the series. Any such work would need some serious
> thought.
>=20
> So if you are waiting on me to do something so that series can go in,
> let me know.

I went and got a second opinion, and they agreed with you, it's "apply
and enhance" not "changes requested". So yes, if you can send me a PR
against master for the video damage series, I'll take it, thanks.

--=20
Tom

--osFE4k1TsLV3OhEq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmf6i+IACgkQFHw5/5Y0
tyy6ugv/RekhEvjCw+rkgueI28xBrKw+nkSJPMCKmgMXwrmx6MNVoL8j80bKZK+Y
adVxTo2hyqDsoS4IHhI6rFxhQp+Oa0s+alH4tsCN86ckhT8GIB478uFIqFQs0thu
D0iGOjOKtE8vuqaG1ghY9zLbZly+Oqf26ZUptDDdgK15aM1z6rdcNlj68duXM3nz
4JYQK7GrzJX2VMgpuS6K+kaTqwGgc1ksmebh9BAsH0gJsi8SUwKa6Y8BmU0713TJ
DJzuDDoGevA7ehr2eNkZnnLC+rQ8phrYOocoI5lXjtJ92koZzbn7cF4jw2mU1cdJ
3W3dnU6P5V24JG79baxgMHvkRFBMda9R5V7f4zHZ0SQDXiQv1HD4St1VNnUcB3LI
sz4kVUCt0V1QRIgw8gBWYdRYNwO4kd70n9gAXKLb9BUywR6HJmZp3psHf5Lx+LEa
e+jvjDu6hxe9XrX2wzUoEV/eVuAxPbv4ohWJGfdGwxN8jeBmQHlotADwyfzpnkhL
N/9VCWuf
=MJa3
-----END PGP SIGNATURE-----

--osFE4k1TsLV3OhEq--
