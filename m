Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CFCCC4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 20:32:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 797D88755D;
	Sat,  9 Dec 2023 21:32:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="j4KBx075";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E06287632; Sat,  9 Dec 2023 21:32:52 +0100 (CET)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 021698717E
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 21:32:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-5d3d5b10197so26635827b3.2
 for <u-boot@lists.denx.de>; Sat, 09 Dec 2023 12:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702153968; x=1702758768; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ru1Zz63sTPk0Qb0cvQvvIfpRyE1flowxZm0oPa+sQoo=;
 b=j4KBx075ibHJk//ranGyKXUKd4oMuFOGrAfj+UyGLA4dKhj4VVzQ8CN8TuDlWsqIln
 JveDhDwdJRviWaPp5snpU5+AEJ3Rc7sm916eT8kzJnctAb5vtmpZSQg3JwQ2RJR3aJtR
 BULtmn5jLtGVkkONRbKu59FWCyyIaJsbB3jUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702153968; x=1702758768;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ru1Zz63sTPk0Qb0cvQvvIfpRyE1flowxZm0oPa+sQoo=;
 b=lIj+4k/7gTqjNImkwmWig7fH7ecPPmkXSubRuqNzHcJalCzkhIunxHPgrs2YytkE2Q
 NrEG/Rmyub2BnZ1Zh4Cqvs6Xezr/OhGnfoaRHU2noUQ4zYm0wesL+m+gB6EGpaeLQGru
 2+7bEBvNv0+vAM3SSiz2VT98gWughWrVCdBNH8Lkdke37HNw528w398zI6BvgW3Zlcn/
 aHZjSJI3mlJ29CtwjDj/Wszd10SDxgNoI9HFaHhlNEWCkCii/wHtkQBM8W6pW4D1NHcY
 hN04dolJ9bwY0FDr0fYTp0Qj1dXTfYogosHvoUc8MXeMR5BADUZbTdIXwWXRWWlW3ey/
 Kclw==
X-Gm-Message-State: AOJu0Yw0cRMxrfPGKKPvKvp2EBALMDm34rqPFMOf6nVrkeKBgAPHD76s
 cK4TOxfEwhMdKpsXEHEeCL866w==
X-Google-Smtp-Source: AGHT+IFaabaHTNddi65JoPmAcHxx7d3tWVhRomJtCB1o12OYHg1aAnK5QXmrEyx67D+WfaQBTikyVQ==
X-Received: by 2002:a81:83d0:0:b0:5d7:6ab7:3a22 with SMTP id
 t199-20020a8183d0000000b005d76ab73a22mr1373179ywf.10.1702153968644; 
 Sat, 09 Dec 2023 12:32:48 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-b2bd-da43-c83a-80e1.res6.spectrum.com.
 [2603:6081:7b00:6400:b2bd:da43:c83a:80e1])
 by smtp.gmail.com with ESMTPSA id
 i75-20020a816d4e000000b005d78504d649sm1710269ywc.46.2023.12.09.12.32.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Dec 2023 12:32:48 -0800 (PST)
Date: Sat, 9 Dec 2023 15:32:46 -0500
From: Tom Rini <trini@konsulko.com>
To: Soeren Moch <smoch@web.de>
Cc: Maxim Uvarov <maxim.uvarov@linaro.org>, u-boot@lists.denx.de,
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org, goldsimon@gmx.de
Subject: Re: [PATHv11 26/43] configs/tbs2910_defconfig inc limit
Message-ID: <20231209203246.GE2513409@bill-the-cat>
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
 <20231127125726.3735-27-maxim.uvarov@linaro.org>
 <20231127131129.GD2513409@bill-the-cat>
 <c7022ef3-ad0c-4f89-ad47-a0f7df2a24c6@web.de>
 <CAD8XO3aVLzpqV=MDVO2mJBP=sLzSieXhrV8GUPYPpu76mRKjeQ@mail.gmail.com>
 <CAD8XO3Y4_=8wDQcFNJW1MT1yiyDmbQxP3UCRWWWPZzuJkZp88g@mail.gmail.com>
 <1402b942-9ce9-4bc3-9fac-0eb438b23e77@web.de>
 <CAD8XO3bYyfDVnVQdcqDji39Y=i1Q2jdG-SQ6KUWsBPo0umoZnQ@mail.gmail.com>
 <b47859ca-36d3-4eee-88fb-f7859e69ff2d@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eoPvVUw6XQYhXAQG"
Content-Disposition: inline
In-Reply-To: <b47859ca-36d3-4eee-88fb-f7859e69ff2d@web.de>
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


--eoPvVUw6XQYhXAQG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2023 at 07:25:15PM +0100, Soeren Moch wrote:
>=20
>=20
> On 05.12.23 17:25, Maxim Uvarov wrote:
[snip]
> > The problem is that for many targets the limit is 1MB.
> For tbs2910 it is 383kBytes. And there was plenty of free space when I
> introduced mainline u-boot support. But yes, space got tighter over time.

And I do not want to say "minimum flash size for U-Boot is 1MB", either.
Nor 512kB. We're never going to be as tiny as we used to be, but I will
be unhappy if we can't keep something like tbs2910 and a limit of
almost-384kB functional and useful.

> > U-Boot in some minimal configuration is about 500kb. But U-boot with
> > EFI, USB, Eth drivers,=A0 MMC, RTC, and all the commands is 900+ kb and
> > very close to 1MB. Most of the new features are enabled by default.
> No. Tom does a very good job to ensure that there is no (not much)
> additional space required for unrelated boards that do not need new
> features.
> > I.e. they do not exist in _defconfig and appear in the resulting
> > .config automatically.=A0 I would say that for some small targets things
> > like EFI, Secure boot, TPM, Updates and many others are not needed.
> > But if new features will appear by default very soon we will see limits.
> New features will not be enabled for old space constrained boards. In
> your series you did not offer to keep the old implementation instead,
> this is different and the reason why we discuss image size constraints.

So here is where things get tricky. I _really_ don't want to have two
network stacks. And one of the remarks I believe you had made years ago
Soeren was along the lines of "why does my platform need this new
stuff?" to which I think this time, I have a good answer. Our homegrown
networking stack is fragile and difficult to maintain. lwIP is well
maintained and also open to feedback / improvements from U-Boot to make
it more configurable (so, trimmed down further in size). So I really do
want to replace our stack with something with better long term
maintenance and less bugs, while not growing things too much either.

And to that end, we aren't there just yet with lwIP merging in either.
We're getting better than earlier iterations. And we will have
old-or-new as at least a build time option for a few releases so it
might be the case that we allow the new stack to come in with a note
that it won't become the default stack until the final sets of size
issues / functional configurability is done.

--=20
Tom

--eoPvVUw6XQYhXAQG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV0zugACgkQFHw5/5Y0
tyzSIwv/RkJWGppaGegDZlatuG5rZfhcS6JNIvyU0DU7xkyP6coiiB4RTMpqZAvM
SR9MUvkSdXr8vBmfB012WVei4gJ5uf+8o8XvH2XbIRJEHC8TPfXvgoC73fysXWwA
yXTiyG1PvNl9nkK7HvQbrkUULsjkQrCbrEZnhF1TEf7et4Q5o283U6IKwDlgOIXD
RsmbdCyTlCcgCMOwC8rbaX1x2qTCU3vYGiwOFr1m9FJJ8jUiSxtzHKeCHuR3NcmD
wP5ba9PFj/dBeBCb5+kdHJMja+Wz9P8iLJ2sAATfEOiaIyvZ6SCyj8nPV1YCH3E/
Z6dirAoN7qwy0tFRhwub8NaJXLZ9s+51jVvpw3/V5crspyOWHEUnT4wihKMb/dHr
7RoivJ3/GHO/R9YKTiCxsQF18rbJNGgYBS9cfe0kdtIvDPFV+8JZtYYZL52eXSKT
aiAC6LLA1MUaURoAuH+Ix4fldN/6hgnFHlz1jbsQKyxPdFxqIFEhjlCJDQ/isk8n
0MQRwwB2
=J7p6
-----END PGP SIGNATURE-----

--eoPvVUw6XQYhXAQG--
