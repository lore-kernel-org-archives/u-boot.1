Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67065CCF9F8
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 15:52:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A217583D2E;
	Fri,  7 Nov 2025 16:52:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PNGD6nUS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 817D483D62; Fri,  7 Nov 2025 16:52:02 +0100 (CET)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BCB683D0C
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 16:51:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-656b0bd47b8so177329eaf.0
 for <u-boot@lists.denx.de>; Fri, 07 Nov 2025 07:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762530718; x=1763135518; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CWviUrMa903J95l/f+VuD7asq0psy/tdfYN4voQitc0=;
 b=PNGD6nUSSjZzJvhrx1R9i+NGajfO32hAZWH9C2ZU5tjnld5v6tPTurPQUkhyJoOKk3
 A0XFp11RghDPHXQvmmo64PBA0CmUkpVit+/RQo74H06LWX+1+3aI3ET7DZUqzMPr/RdS
 hcEUvyB5k3u+GqCwxrwYJcEqqDurbYcydSxrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762530718; x=1763135518;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CWviUrMa903J95l/f+VuD7asq0psy/tdfYN4voQitc0=;
 b=EbMWRqSHLANZpFJodZOksmH21ednAztJSo/6y51U4+6vlVUhzH9JXbeuDgmL9Xc3sJ
 WJBwd9xlrOlnDDozR/k52p68SbMP/wKKMc0H45gr06jpNE1d42UgHwqB2daVhiCPyrhV
 9Fz4+oyKmhYNTyi/ylsasYgWBjMYJAKhD4Hn3pzEvNfisYYJPhGSKl8tUqRQJQ71wsoT
 8feNa5fZKHuZvbjEp6LceNYy0RnFkoLb187Ys0hjpzY3jeBepfQC+W0FP+HhjATjOD3z
 PRifPvBHxjrN0ShGiZNPPsNZvlemZcncVI7i076FMezkWZEelqUjpsFuZj5xmkRaoX7H
 py8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrWuBmHLpeR1DDhOgeJspqqBpo//1jXRSLi4In8+GYQ5Tr+l+7nycC+DSg+xJB/R558dlz3Wo=@lists.denx.de
X-Gm-Message-State: AOJu0Yzuk8lS2UakytSMpCLOWUznmFwO82JLNN78sACS7ssTqmhEv33p
 x0IBAR6d/+v8MFyF5KhqNKjGb+LJctgLNiteASkJTE+U4st2BrY6qMr09evoWUh91GY=
X-Gm-Gg: ASbGnct6cEPiyFqu30jeto90Ue9gMkvsk3BXHjrVeUL3MTj++WnY/VmrP0zEv8OU2Lm
 GAiNLh7S7z+dq6/9DpGAj7mHhjKntFJUkw1mjbQRrhYS3cWxjS+/Qwty0g0aIg4m38qhVDrhlQl
 /vBGiUVo6JV6dSvs4mntRr3hkPk64tDIZ2d6KTF+G+GvVPlT2BXNWBiAHNS6nX+TO6F0UbJzKl8
 BZR0+G8TS7bDCsf16niQDouNS03jboj3JngEhPOxCBmAyAQOhpTpPiRxDjU+4r12/98tCrL/eHC
 9vpUwUqyCh4vbXZYbv0Cy/dEOz9fna3MUPsyEEezuUvBWPjejW3utmSiuOYYV6xGl2FscJGPoQt
 O0/aQJgQj0Xm8FA/TLDMLB6pHeRrgzTf5rGnxJBPd+q7Nkmau/8eNu6Vz0u0SE9CNkVXVWdO+L9
 7+l+tYzFRwv+mt1BwRHNbsg0jaoj2ATfKyQ4+g8wU=
X-Google-Smtp-Source: AGHT+IGvBLaGwaZI6gj9Yq23WnXvk5MGzhizDXVX5pGv05PjYDS+OKrQFyp+8nU0uHJlxiuPKpDmLw==
X-Received: by 2002:a05:6808:4f2c:b0:44f:eb84:e9e0 with SMTP id
 5614622812f47-45015da02f5mr2243748b6e.27.1762530717845; 
 Fri, 07 Nov 2025 07:51:57 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-656c57d6767sm2376889eaf.15.2025.11.07.07.51.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 07:51:57 -0800 (PST)
Date: Fri, 7 Nov 2025 09:51:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 "Bajjuri, Praneeth" <praneeth@ti.com>, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 1/2] distro_bootcmd: Add support for customizable
 find_distro_rootpart
Message-ID: <20251107155154.GD6688@bill-the-cat>
References: <20251031-feature_distro_rootpart-v1-1-4e7c465708e8@bootlin.com>
 <CAFLszTicHdtY73+asYQ9NF_uEFg7BsSfN2cW+21FbQoxH9V_JA@mail.gmail.com>
 <20251103115225.381126f1@kmaincent-XPS-13-7390>
 <20251103171630.4df1efdd@kmaincent-XPS-13-7390>
 <20251103161905.GP6688@bill-the-cat>
 <20251104102916.3df33d55@kmaincent-XPS-13-7390>
 <20251104163816.GB6688@bill-the-cat>
 <20251106190001.0e5a4504@kmaincent-XPS-13-7390>
 <20251106182329.GY6688@bill-the-cat>
 <20251107100517.6c79a976@kmaincent-XPS-13-7390>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="t/668wUxH3+uAi+X"
Content-Disposition: inline
In-Reply-To: <20251107100517.6c79a976@kmaincent-XPS-13-7390>
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


--t/668wUxH3+uAi+X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 07, 2025 at 10:05:17AM +0100, Kory Maincent wrote:
> On Thu, 6 Nov 2025 12:23:29 -0600
> Tom Rini <trini@konsulko.com> wrote:
>=20
> > On Thu, Nov 06, 2025 at 07:00:01PM +0100, Kory Maincent wrote:
> > > On Tue, 4 Nov 2025 10:38:16 -0600
> > > Tom Rini <trini@konsulko.com> wrote:
> > >=20
> > > Other question: Is it possible to not add the environment to SPL imag=
e using
> > > the new text environment format. I have tried to update am335_evm boa=
rd to
> > > it but I got a SPL too big error.
> > > I have tried to add "#if !defined(XPL_BUILD)" but it is not working.
> > > It seems the same generated environment file is used for all images.
> > > I still haven't found were it is included in the build of the SPL ima=
ge.  =20
> >=20
> > It shouldn't change the environment size, but also environment is likely
> > being pulled in to SPL for network boot support which does require
> > environment. What do you mean by "same generated environment file is
> > used for all images" ? And are you building in separate object
> > directories for a given board or is it not being re-generated on config
> > changes? Or did I misunderstand? Thanks.
>=20
> Sorry if I was not clear.
> For the am335x_evm most of the environment is only in the main u-boot ima=
ge
> (i.e. not an xPL image).
> https://elixir.bootlin.com/u-boot/v2025.10/source/include/configs/am335x_=
evm.h#L78
>=20
> I would like to do the same but with the new text environment format. Is =
it
> possible? Something like: board/ti/am335x/am335x.env for main image
> and board/ti/am335x/spl_am335x.env for SPL image.
> If that is not the case could you point me where the change need to
> happen to help me on that. I didn't find yet where the text environment is
> pulled into the images.

Ah. It sounds like we need to add missing logic to generate the text
environment in each phase rather than once and use it in all phases?

--=20
Tom

--t/668wUxH3+uAi+X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQ4VkwAKCRAr4qD1Cr/k
Cgx8AP0Q+Xob8e61cdprrofw5hqpLBJVGQs+NkT1Yuyd358JsQD/ahD+SPCrGj4q
Gz9sSXMFziqeEmYpXMYBzvdOMX5biww=
=V4EQ
-----END PGP SIGNATURE-----

--t/668wUxH3+uAi+X--
