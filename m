Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79039CAC58F
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 17:00:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BDCA88CB8;
	Tue, 17 Sep 2024 19:00:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JBsg23eu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A54388C6D; Tue, 17 Sep 2024 19:00:06 +0200 (CEST)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF2A988ADC
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 19:00:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-45816db2939so43100431cf.3
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 10:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1726592403; x=1727197203; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CkWsIjTPGNtVTcMJCr+YjxxdiEpT6GoDCa9VmXXEICc=;
 b=JBsg23eu2jXSGFhH8D92F2YRBX6fKQpe2HEiokc4k5/kfnkhofp0xnn/bt9udndsfN
 ou6bSwZjk5iqOM66D/FIMWvyoRmf2YowdpV1HTVWj/26pVgR/A8U7x25iZmQmAGhr78y
 WC3ZPjwgUSz5hcJLD624npexmNdCmQtoFY8tY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726592403; x=1727197203;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CkWsIjTPGNtVTcMJCr+YjxxdiEpT6GoDCa9VmXXEICc=;
 b=dCUopesU2mGmIzPbNyd4wJ1GsnwP3cZplfnyMfWInjmvJC53VozPxFIAej0w5IqFd3
 11i2HKC+OrwjLtAWOxn9CyMaT3IpRbFZSiBfH+Hcwr97I6DVmxR/6Hu8IGARMBax2mwI
 WUOWcxb9EUsQubASRvSfCsQkzqppEpIf3yxREQcO7FeCIdET/0SRew6fHic0OqFivSxk
 lANg3XeLTIi3Esf2N1om3MFPeECGUPZ9Q4NinVzOrNcTf0n2KfSZo21CfVPJBaZ+KKU/
 j4Fwo52HCqy1lahgUVB/0rt5+kf7yDRy2zvxW3ojEVDqmMWNIVccp9urBhDUlialAHz5
 ZJAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvOeijRMeOMTaxVKJCPtsSNQzLjW224r7gW3UOQFx4XAksnnrGjIw6n+eV1y4Kga+Qlqsipxg=@lists.denx.de
X-Gm-Message-State: AOJu0YzeZ3B4b+VtRTH6Htd6Ed2sU68d7xws9eFiM7nV4uQuVITRrRPV
 M4ihtohJcoaLOVwuf1sVYlI03EfWL9LxFKodYBzEZbyVKzfq8LZlf3ag8bE5tmQ=
X-Google-Smtp-Source: AGHT+IGa9JDR51tHK5D/PO4plhlAu7erX2OnO5LBDsl8tA5lVKjHdyb6N92bActJri085weXJmwbAw==
X-Received: by 2002:ac8:5792:0:b0:458:4a2a:402d with SMTP id
 d75a77b69052e-458603368bbmr312989111cf.25.1726592402539; 
 Tue, 17 Sep 2024 10:00:02 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-459aad04446sm40126201cf.66.2024.09.17.10.00.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2024 10:00:01 -0700 (PDT)
Date: Tue, 17 Sep 2024 10:59:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v5 10/14] efi_loader: Disable ANSI output for tests
Message-ID: <20240917165958.GM4252@bill-the-cat>
References: <20240902011825.746421-1-sjg@chromium.org>
 <20240902011825.746421-11-sjg@chromium.org>
 <d421b72a-eb0a-4aa8-be6e-3825c8b08da6@gmx.de>
 <CAFLszTjRSoWr0uncOdMY=6Oc4dnLP7gH2hj0BgDF67ukQEmmdw@mail.gmail.com>
 <20240916163319.GG4252@bill-the-cat>
 <CAFLszTgVi7nzE2AxBb_u73r+dSWny_geSpXmNKG8NR1SQWhXJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GXK01VJ/ym6Khe9o"
Content-Disposition: inline
In-Reply-To: <CAFLszTgVi7nzE2AxBb_u73r+dSWny_geSpXmNKG8NR1SQWhXJQ@mail.gmail.com>
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


--GXK01VJ/ym6Khe9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 17, 2024 at 05:54:36AM +0200, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 16 Sept 2024 at 18:33, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Sep 16, 2024 at 05:42:12PM +0200, Simon Glass wrote:
> > > Hi Heinrich,
> > >
> > > On Thu, 12 Sept 2024 at 08:58, Heinrich Schuchardt <xypron.glpk@gmx.d=
e> wrote:
> > > >
> > > > On 02.09.24 03:18, Simon Glass wrote:
> > > > > We don't want ANSI characters written in tests since it is a pain=
 to
> > > > > check the output with ut_assert_nextline() et al.
> > > > >
> > > > > Provide a way to tests to request that ANSI characters not be sen=
t.
> > > > >
> > > > > Add a proper function comment while we are here, to encourage oth=
ers.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > >
> > > >
> > > > This patch was already NAKed in the last version.
> > > >
> > > > Please, adjust the test framework if you need filtering.
> > >
> > > In what way should it be adjusted? I hope you are not suggesting that
> > > sandbox should try to filter out ANSI characters in its assertions?
> >
> > Well, perhaps the pytest framework should be filtering it out? And
> > again and to be clear, I can't reliably run these tests on _hardware_
> > because of the ANSI characters tripping things up, this is not a
> > "sandbox" problem.
>=20
> Honestly, this approach (creating a problem and then dealing with it
> downstream) is just not the way things should be.

I don't follow, sorry.

> As an alternative, I can send a patch to remove the code which blindly
> sends commands to a terminal which may or may not be there. That would
> be more correct than what we have today. We can then discuss how to
> add ANSI back, with due thought to its downstream impact.

I admit I only get as far as "Oh, selftest failed and look at all that
escape sequence and such in the log" which I take as pytest choked on
the output. Maybe we have different issues?

> It's not great that  this discussion is still happening on a v5 patch.
> There has been plenty of opportunity to provide an alternative option.
> I doubt any exists.

Well, it's _also_ true that people have been providing feedback earlier
in the series and requesting changes and I don't know if it's missed
because you were dropped from the list again or buried in your inbox or
what. But you repost and don't drop / change patches that there's not
yet agreement on.

--=20
Tom

--GXK01VJ/ym6Khe9o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbptY4ACgkQFHw5/5Y0
tyyFIAwAjU4moSpNl8TIbjNBXoTQBvlVpvhjpU8Yw0FtWsKDw/HHW+jb60NpeRJK
kTMpbEyKG3KKtm1R32OQhz9LAi6jt58JTmDBSITLF3aGzQb2LniFxcXy47BgYl3v
oKzWGSPLxa0hhD0nNRAnr6YiL5SzRUlbl09X8dwwKwNAsoGgzcz8CKdUdVRLZxaH
WZYdrvar3AevHsHWarI9nrDzpwggqTgvMKGIhuhAoqjb7FqM3Pyg8UfoAx4SbOxQ
+TFo9WWlLgbL3pvm1y/VDF618k23hFKWb1dPqooz+uJfpSLjMhsbqeSlHF19Udzi
1XLh7dyE9q6U3pm3S1e/RPfJh8f9Rv88oQtJpQ+Ssq476A5AswLf6SgSyfTf3kcC
Pn3r5h6VB7wP+tKsx5wfxYhqsVFv4U4S89h7ybm010QAjfK7b6l64/QSS6uEPM+f
5napwk7SYtgHDTkUpe/BbDxFw/ej5bahHnIcyAjGAc8iwZo+tgfUZvOsUVyNIVe8
C1T06Fnu
=LR7T
-----END PGP SIGNATURE-----

--GXK01VJ/ym6Khe9o--
