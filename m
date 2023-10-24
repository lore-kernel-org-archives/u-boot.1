Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AF2DC00A8F
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 18:07:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC21486BA4;
	Tue, 24 Oct 2023 20:07:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="b5FrEEgQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BA88803AC; Tue, 24 Oct 2023 20:07:48 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 610FB864E8
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 20:07:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3b3f6dd612cso2669880b6e.3
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 11:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698170861; x=1698775661; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sX17dLhDOWz5dtI5IJJMsXl9DMK7DaB+nzh4PbzZpLw=;
 b=b5FrEEgQvQs53D8nImfPMq0pUs+4KSU6266hZour0QZqLpbzC9l2U1FuyCd1x9Um47
 7uPMjP+quRDac2W/bH8Ydr0T1ivw0aoblQKFA7g1Y02S/HW1OlCrLhrmg98QA2TvRRCt
 pq7ydB0vcCD//4OopMdPV+1z7tt2BIF/hFjeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698170861; x=1698775661;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sX17dLhDOWz5dtI5IJJMsXl9DMK7DaB+nzh4PbzZpLw=;
 b=kDqeVYTBH8nmKB2wI/Ass32TzPLGYnKfUZZ9ZdcpSNUWuBQ5Bf3M7zzcrMr5dvfJPD
 AaVQ410qM+xl0zafnocasPRtYi6T/knasF/3yohP4d74kYXr3fikZt9ODBIS0JUuXBhu
 bXsNp1EA578MrqcjHZnEHYRTGrGN0fDT00N9uRI1z0Jz+4n9LQ5/CamHVx1Jx1mVsZAa
 VAwwEa/86ZN20F5ndDB75io68EKZ9m0QcPIdoSLWN+C/Yn4hS5lt7ayjlgD4PRC2huvD
 Rw+g90h3D+rjNZ25u54kPh9SokWfs+0Ij6pyN++x4ZLrCRtHtCIgLETwmKKX4JrkRbAb
 xFtQ==
X-Gm-Message-State: AOJu0YzwEeIaZ1CQ50Z9gpSNncl0o//1ZSZL68rNxFS+hyQsodi09te/
 cBqmHatgrru+7b1eMbgOdGfHhQ==
X-Google-Smtp-Source: AGHT+IHauozY+hFp1eVBsaY6KMEBmne3lFNdlOKWjMPM52i82zRf8WLDOrBFVKrSBQ+we1B4IGOfmA==
X-Received: by 2002:a05:6808:2105:b0:3af:8050:369f with SMTP id
 r5-20020a056808210500b003af8050369fmr16519115oiw.6.1698170860925; 
 Tue, 24 Oct 2023 11:07:40 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-89e7-8c52-372d-17ee.res6.spectrum.com.
 [2603:6081:7b00:6400:89e7:8c52:372d:17ee])
 by smtp.gmail.com with ESMTPSA id
 k142-20020a252494000000b00d9cb47932a0sm3739241ybk.25.2023.10.24.11.07.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 11:07:40 -0700 (PDT)
Date: Tue, 24 Oct 2023 14:07:38 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: Re: [v4.1 2/2] CI, pytest: Add a test for sandbox without LTO
Message-ID: <20231024180738.GF496310@bill-the-cat>
References: <20231019150105.714407-24-trini@konsulko.com>
 <20231020215302.3511807-1-trini@konsulko.com>
 <20231020215302.3511807-2-trini@konsulko.com>
 <CAPnjgZ2jgfJ4GXR+2qt5Qi=MOc=kubLrMLgYBGuO_trinUHnag@mail.gmail.com>
 <20231021183438.GB53397@bill-the-cat>
 <CAPnjgZ2bKVTwEKcjeawootxXr-+iEmiowtctA52-=v07p+xBUQ@mail.gmail.com>
 <20231023133728.GH496310@bill-the-cat>
 <CAPnjgZ06w+uaSZr6PWo6NFoWfxiNuu-bar4e3zn+bVL-4wPvUQ@mail.gmail.com>
 <20231023172757.GV496310@bill-the-cat>
 <CAPnjgZ3G8T3ZjRNMdu=Jr_1OgijgQXNARQwAMQUFNy7ng4_zqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Q+teTZHlJQWajsDW"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ3G8T3ZjRNMdu=Jr_1OgijgQXNARQwAMQUFNy7ng4_zqw@mail.gmail.com>
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


--Q+teTZHlJQWajsDW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 11:02:06AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 23 Oct 2023 at 10:28, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Oct 23, 2023 at 10:13:52AM -0700, Simon Glass wrote:
> >
> > [snip]
> > > BTW buildman supports -L which disabled LTO using the NO_LTO=3D1 opti=
on
> >
> > I worry about putting sandbox-specific flags in buildman.  Outside of
> > sandbox, targets that enable LTO require LTO, just like any other CONFIG
> > option.
>=20
> Some problems with LTO and why I don't normally develop with it enabled:
>=20
> - build time
> - code moves around all over the place so it is hard to compare size grow=
th
>=20
> At least for my IDE flow, I use -L in most cases. Yes there are some
> boards which won't fit without LTO, but I don't see them much.
>=20
> So this is mostly a dev convenience / productivity tool.

Yes, it does take longer to link.  And yes, a more complex optimization
does make some size tracking harder to understand (since growth or
shrinkage allows for different optimizations to be made around it). But
everything in configs/ that enables LTO needs LTO.

--=20
Tom

--Q+teTZHlJQWajsDW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU4B+oACgkQFHw5/5Y0
tyyJ7Qv/QSURCZpBmEXQf+rBj+W4L9GjOeaHuKVOt36V7PhbDnDvPwi3dJR+ZPha
kWqeYlDuuq4Thlpsqxmz8j27IfFA7YVvMQik9obMrT7OdeY4hTc6/BhB3cZNUTzG
8SQVl8+LxuI12bXKb3zlKWsCGoa+GE1MeW3NNKqvtLC6DhuVXKbrJNg4+3gnH2pb
EeosuPD5aYqKSnKcHHPxSBngE67jIcNtRmRlcN4ADRSxvKmuMoOkKdvOfTQSPfhy
ooxNiQ2jLNtLzfe6n57WJptBhkXbqmYW1HvIL4AGA312xGi98KwsOIaVeDFIjccm
eWqsQNLBV0N9nCMoikv8FnhcaS78LUljCLmFjNlVRzUPl39kIOAoCthW7/ddPhOZ
AWqhVAJhteItmsm+xRxFnrzpeY2GNAJYLkTfJ3n1rGAerTeQkV/b4S5s5cjTWJQS
cmljniWSYIRXVhyjJTAJrarhEoO74IHHS1YZtUdoHhV1gK3sTMKvBUm2iT0KDy2/
wnXcJt9+
=EUwv
-----END PGP SIGNATURE-----

--Q+teTZHlJQWajsDW--
