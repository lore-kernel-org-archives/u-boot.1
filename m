Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB525C52D7C
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 22:03:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 703AB88C39;
	Sat, 10 Aug 2024 00:02:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DoGNTN2t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8695488C39; Sat, 10 Aug 2024 00:02:56 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1960A8641A
 for <u-boot@lists.denx.de>; Sat, 10 Aug 2024 00:02:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3db145c8010so1666506b6e.3
 for <u-boot@lists.denx.de>; Fri, 09 Aug 2024 15:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723240973; x=1723845773; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uXv8tw8uIm5Mm2GQsrNCjq/1qEv0QnhScQ40sWBxg8s=;
 b=DoGNTN2tN0KFgn3Kngu96quRtdZZl5aj5mwpnsNomH91GPVsZxoSCt1GP8QA2eMo3S
 qeVwF0lrWoJPadaEMqMaBGrXF8KldYN27ixBbXaz1AmkeE4URRLO4dG96FAMKOvB+DzQ
 pPBk2+m0j5Gory44hyDyr1IkWhy0C88wxGkn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723240973; x=1723845773;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uXv8tw8uIm5Mm2GQsrNCjq/1qEv0QnhScQ40sWBxg8s=;
 b=JJR2CPRjxAO9RTIC/7EpQoxFG9AwvJIQu7TpicVTC5it9G+nVUPbupF5f2RbOpLSkG
 dH0L3sw0lznC1HhAW8j8lGlceAvUk77kh1zRBRY2QrqKWE2G9jBE0Mel0BmwtGEAUSIx
 20c8oKlsH8Pnt6LjcFmkEaHGQM7Lu8EPneIo4xdkwxCIuGRPBkSkRHnFWATMR4xCPnap
 zKcu7VAiL+ClF54JyQVcmppQXABF1kASf5IkkWjRCv/YMeGg40qDeQmRdm39aTK9vYuW
 Nrd/ICldH545wGfkRdvNyWQ6bDFFvhEvLmPXaqSogBwyr2GkszhjeY2kiVseBzw/XxuN
 Vj8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJ57CRTy7uB6+HNIoTGYuwv9n6uPAKEwh8LBcp5G6+r5f18ma6XCnEp11vxJA5jz8CF9paRttJVtr++rxJe2Cm546DuA==
X-Gm-Message-State: AOJu0Yzd8ZOzP2IOW+vharZ0j1gVmnAuCMqyeiqm6v8RTznAOzf+oaO4
 bHKidVxiSHOCBxWX8NJouN0nitsyii6aDvZob3wMzEq4D6WZ3Apja4Ylq1TKU2s=
X-Google-Smtp-Source: AGHT+IH7NmpBP670OZc2rv3XV8WO0f5rDAcBWRbOChVjB8guF1MWEnhvlFDeFInw+ZnW4ufR8VB3zQ==
X-Received: by 2002:a05:6870:148e:b0:260:faa1:4453 with SMTP id
 586e51a60fabf-26c62c42c27mr3837711fac.8.1723240972835; 
 Fri, 09 Aug 2024 15:02:52 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-236.totalplay.net.
 [187.191.8.236]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70c7b81db6fsm182189a34.25.2024.08.09.15.02.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Aug 2024 15:02:52 -0700 (PDT)
Date: Fri, 9 Aug 2024 16:02:50 -0600
From: Tom Rini <trini@konsulko.com>
To: Richard Weinberger <richard@sigma-star.at>
Cc: Richard Weinberger <richard@nod.at>, upstream@sigma-star.at,
 sjg@chromium.org, Jixiong.Hu@mediatek.com,
 marek.vasut+renesas@mailbox.org, patrick.delaunay@foss.st.com,
 ilias.apalodimas@linaro.org, seanga2@gmail.com,
 upstream+uboot@sigma-star.at, u-boot@lists.denx.de,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v2 1/3] ext4: Fix integer overflow in ext4fs_read_symlink()
Message-ID: <20240809220250.GB1626301@bill-the-cat>
References: <20240809095430.3656-1-richard@nod.at>
 <04ba0220-864c-40cf-bdc4-73ae6137b704@gmx.de>
 <39167592.RpJgFE2GTS@somecomputer>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yumx3C/l3J1mVCP/"
Content-Disposition: inline
In-Reply-To: <39167592.RpJgFE2GTS@somecomputer>
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


--yumx3C/l3J1mVCP/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 09, 2024 at 06:29:34PM +0200, Richard Weinberger wrote:
> Heinrich,
>=20
> Am Freitag, 9. August 2024, 18:13:27 CEST schrieb 'Heinrich Schuchardt' v=
ia upstream:
> > Thank you for pointing at the problematic code.
> >=20
> > You are calling __builtin_add_overflow(int, int, size_t *).
> >=20
> > __builtin_add_overflow() is not defined in the C-standard.
> >=20
> > Is there any well defined behavior for this on systems where size_t has
> > more bits than int?
>=20
> https://gcc.gnu.org/onlinedocs/gcc/Integer-Overflow-Builtins.html says:
>=20
> Built-in Function: bool __builtin_add_overflow (type1 a, type2 b, type3 *=
res)
>=20
> These built-in functions promote the first two operands into infinite pre=
cision signed type and perform addition on those promoted operands.
> The result is then cast to the type the third pointer argument points to =
and stored there.
> If the stored result is equal to the infinite precision result, the built=
-in functions return false, otherwise they return true.
> As the addition is performed in infinite signed precision, these built-in=
 functions have fully defined behavior for all argument values.=20
>=20
> So, I don't really see a problem here.
>=20
> > I could imagine implementations just copying an int to the first 32 bits
> > of alloc_size and leaving the other bits untouched.
> >=20
> > Hopefully your C-compiler simply refuses to compile this code.
> >=20
> > I would prefer to stick to standard C:
> >=20
> > alloc_size =3D le32_to_cpu(diro->inode.size) + 1UL;
> > if (!alloc_size)
> > 	return NULL;
> >=20
> > Here an overflow can only occur on 32bit systems.
>=20
> In this specific case we could avoid the builtis, yes.
> But I prefer using __builtin_add_overflow() as it offers a generic
> and bullet prove mechanism to avoid these kind of bugs.
>=20
> It's not that they are something new and funky.
> Other projects use them since ages.

I'm fine with using this buildin, it's widely enough implemented, for
good reason.

--=20
Tom

--yumx3C/l3J1mVCP/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAma2kgoACgkQFHw5/5Y0
tyzB3gv8DG2g5TePuu3QcmYf03RpiB/5tnapbY1/+yXc0MzMSnUHG++o3x/7xuzg
Y97QJhVPZjHP95yQamq6S0v5NJFE4xEPsccP3C1FrKYdLW78P5zOyNdHpRCDtV4x
mFFin0lPYsZVgbjVst1gJjl8M2XdtRmNJa+TFde5jyvNvPxXV6Sj76k8cZ0oo36S
2Y7Mas3nlZOZrVy0NLalr7LP/Rv682ODFE5zgkZkYg8sHRycaGVmH3BQS5ccYZ21
UEgpNtTmP2MPHhd/S6kEBiYxtoPtGchVzUPDI6kiabeXGTKFD0n7H0bkT4LloOwA
avZrz3Ou+sXlMwv3zuatI67hRT+q4aBtdF35S6JMF3hHkHVCSHOyNk6zQZ9xsd1f
VqwruZjoCv2+OjxDXyuLzs3UyMr49UGUxWgtuIukJxcvfqIvA5ktnOPWiH0FpEjL
NpoOQmG7Fkip1sFxmMs5DdthIbZApKb1FewUNl6Ao7L00SnoDO1UR8KaSswvjpWK
Lv8wDt5y
=bTCJ
-----END PGP SIGNATURE-----

--yumx3C/l3J1mVCP/--
