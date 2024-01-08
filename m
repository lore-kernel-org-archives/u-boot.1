Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34660C3DA6E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 15:38:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4ED3887A77;
	Mon,  8 Jan 2024 16:38:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="R4O+VrYf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EAD387A99; Mon,  8 Jan 2024 16:38:22 +0100 (CET)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E19B87A77
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 16:38:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-67f9f6caabcso17976916d6.3
 for <u-boot@lists.denx.de>; Mon, 08 Jan 2024 07:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1704728299; x=1705333099; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rETT4xIj+XW7So/B7yqenwjhxLstHmDThpc4O4ERU2g=;
 b=R4O+VrYfGXXa0qpRBK8yZaLRQDXds6gGrrtrC/dpaBjfeWe3pBjj2PhsTvTCO5QKHu
 TKEnOk4ImuIDgubPe2jLl7RHu6/0zo2du1qp1/BzFg48NApCUIBv1j31XyhEoRfvqq2j
 2H2NA4oMY6xWTcrwvsjFB2L7vHVPxqDXApqWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704728299; x=1705333099;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rETT4xIj+XW7So/B7yqenwjhxLstHmDThpc4O4ERU2g=;
 b=bNkh3AkgjPAo97eh06oMwjG8cHVvTLReia9ZNhNkIGcSag9Al0U2BU7gIm0qxEwIF7
 jGpofSiX7PGLR+lvRVEqsdECVw356HvVrkrhXsBKJXKEK7VqOgVbZMatsKQqvzdzlT5o
 BH65I9ivNCkM3ambfMSwx2v2K/6Jo12KboE529SCKik1Oy/PtM1PnZ+nVlRjlFgCJB3i
 7GqsbeXofWiFUPB/NvBn9a7pwBMwl0W0Mszx1c2eh44JK9KjdoEvFJwaRF9i604S7MyI
 yvnTAlzLRwv2fGVQfadJnw+nnKUMrlUo1y5FXafg1LMs+1/oIEN1WGVSZzUi7+d1J+tS
 7vQw==
X-Gm-Message-State: AOJu0YwGT7eP43KvJnxnljzBX01cQ7IFDmpJVJrZU8WyITwKc1KbY8yV
 E5U3L6ShnXKphv9T/kkbkoWA7Yh75o0qLQ==
X-Google-Smtp-Source: AGHT+IFj+28l586c4zWDHUcQkCxCZeATlrlHLnNg8A9QpdKg4Vr2qxzJ+OrCkLNCNCtxZwqe6kzwww==
X-Received: by 2002:a05:6214:1311:b0:680:fe80:2f7a with SMTP id
 pn17-20020a056214131100b00680fe802f7amr4250287qvb.98.1704728299153; 
 Mon, 08 Jan 2024 07:38:19 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:3119::1005]) by smtp.gmail.com with ESMTPSA id
 ml10-20020a056214584a00b0068086c5fcb2sm46402qvb.143.2024.01.08.07.38.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jan 2024 07:38:18 -0800 (PST)
Date: Mon, 8 Jan 2024 10:38:16 -0500
From: Tom Rini <trini@konsulko.com>
To: Bin Meng <bmeng.cn@gmail.com>
Cc: Dragan Simic <dsimic@manjaro.org>, Anatolij Gustschin <agust@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 2/2] coreboot: Switch to a monospaced font
Message-ID: <20240108153816.GE1610741@bill-the-cat>
References: <20240108001455.35638-1-sjg@chromium.org>
 <20240108001455.35638-2-sjg@chromium.org>
 <874jfouq9e.fsf@bloch.sibelius.xs4all.nl>
 <6beec0824542ac0608a5dfad9b88d32a@manjaro.org>
 <CAEUhbmVc06RydZavZHAXS2oBZC=cRt0C801+dxYVYr9qZRvBVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="K9WHQJs5Palre6EC"
Content-Disposition: inline
In-Reply-To: <CAEUhbmVc06RydZavZHAXS2oBZC=cRt0C801+dxYVYr9qZRvBVA@mail.gmail.com>
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


--K9WHQJs5Palre6EC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 08, 2024 at 09:09:39PM +0800, Bin Meng wrote:
> + Tom and Anatolij,
>=20
> On Mon, Jan 8, 2024 at 5:33=E2=80=AFPM Dragan Simic <dsimic@manjaro.org> =
wrote:
> >
> > On 2024-01-08 10:29, Mark Kettenis wrote:
> > >> From: Simon Glass <sjg@chromium.org>
> > >> Date: Sun,  7 Jan 2024 17:14:55 -0700
> > >>
> > >> The default font is proportional, with different character widths.
> > >> Select a monospace font for coreboot so that the 'dm tree' output
> > >> lines
> > >> up correctly.
> > >>
> > >> Update the coreboot tests to match.
> > >
> > > To be honest, I think defaulting to a proportional font is wrong as a
> > > default for something like U-Boot.
> >
> > I agree, it makes very little sense to default to a proportional font.
> >
>=20
> So we should revert
>=20
> commit b093753471c1a30d680868a9f4d9f6db090bf0b7 ("video: Add a default
> TrueType font")

Well, I would "fixes" that commit and drop default y there and instead
make the monospace font the default and explain why the switch, rather
than revert.

--=20
Tom

--K9WHQJs5Palre6EC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWcFugACgkQFHw5/5Y0
tywqHQwAtzjQBwbkGCWSZYgA/MxOgACTuVMoiLid4Sghtsijc3ZktmsaxAxU7X7g
ZLrUhOFczt6wsYwgWyuyZ2LYDqzSE+p+PWUWGbUaME1nwDpWirH3r17tkZXNyaME
2EkTA6Df1CiYGNrGPSrIbbnXrKa/Htv/IYBTWOEPNNe+tzwd8x925iVntNDAJMN1
84h+qSbWy2fojAQ4ODpoqx9F5yeclyZ64QCRHXGr7oNivzUAHATBJo6NILsFj7p0
BKmI9mIgt+qPrcvtepQdRISGybahCpyodUgTUjdsmRoZhgjyQUb2znMfaWpP0HHm
mvF4fgt556CVzLm9UX2lIy9Ws9zhcWHUthB9Ch/bFxh3ttQ2cFgp0t5JMT6fyNvj
gR3JjjprYy0ILt1KxnhNWBepdBKa2/JDyz+5u1KLpX/sSewJUVVK7+Egy1MiGr1K
+C0ihGCtzFuzgLHMI9tM0FW/6Wcl9MtYO1tYscBQNNTDhjtaMsALV5Nyc3ZVktHR
CY6AtMYv
=Fl+G
-----END PGP SIGNATURE-----

--K9WHQJs5Palre6EC--
