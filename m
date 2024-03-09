Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63B16C54E49
	for <u-boot@archiver.kernel.org>; Sat,  9 Mar 2024 21:59:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5485987DC1;
	Sat,  9 Mar 2024 22:59:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PUOyQUsg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B5B987C82; Sat,  9 Mar 2024 22:59:06 +0100 (CET)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFFD487D5E
 for <u-boot@lists.denx.de>; Sat,  9 Mar 2024 22:59:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-42a9c21f9ecso14772071cf.0
 for <u-boot@lists.denx.de>; Sat, 09 Mar 2024 13:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1710021541; x=1710626341; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9cYhI7QzPMi1bED7RSfn14Oo1ed4QxgRx+pBgYry7AE=;
 b=PUOyQUsggxVz9beil+m86COAEw/UHTCoSdjtxTlOG14+l/gElX9E+7INOLmGFI9/pC
 ptf0/10mIgc74BdPjKuMHSS939Ugy0EZpsGRl3T40dXJmSLsOM71zQfHYBAKLKfmspq/
 YQDjrCkrrhrJo34CqZKGxoPmcPfSW1kDgN/IA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710021541; x=1710626341;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9cYhI7QzPMi1bED7RSfn14Oo1ed4QxgRx+pBgYry7AE=;
 b=u/sDMQpFJFfT/cwK/Yfbc1XAGyK7uhkvtbQkveoPxT3mrD+K1zkeHZNkAYjonOqp85
 28VU8ft7UhovvPM6p605DohxmLc1r0DLGfveotDd21fEAEjFYtPmnzC6JbtPQO6/d4P3
 N4KAKFocuhgKTrzucLsOPO9K7EoVMozWloI2/shb2bXZTJVGK5m3SwaBnG/vAM9s9PU/
 FicD5LOxh0IR0FDeQEeR2usSPwgo74xJ03SHVmSqmESAjd8sYMVQqwwrcIXzGaGbNeOD
 5uXtuiL5dhe90uAFRDFPviDB2PAw1Gd2PLLo/N13UvNu4LTHHs10uSBUYgclRM9oKaRk
 tayw==
X-Gm-Message-State: AOJu0Yxs3M0dm2rPiT3Qh15l2RGToopIRC4Ih6cq6xujZF4tRJQaBi/x
 AkVYr/1a0QdTOngwMPc3+ytd50wk/eSMDM85J55PTyQyNsATtAcGWIJO2m72Sws=
X-Google-Smtp-Source: AGHT+IGArg6au+8OoMeMEkpFjfyj0qTM0soJiZLTmsGwR/sFoeezVq9q81rv2WJXROoJ2Mje5sFFOg==
X-Received: by 2002:ac8:5a85:0:b0:42e:f003:a7c with SMTP id
 c5-20020ac85a85000000b0042ef0030a7cmr4119134qtc.58.1710021540874; 
 Sat, 09 Mar 2024 13:59:00 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1004.res6.spectrum.com.
 [2603:6081:7b00:7f::1004]) by smtp.gmail.com with ESMTPSA id
 i16-20020ac85e50000000b0042f00334f26sm1288541qtx.72.2024.03.09.13.58.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Mar 2024 13:59:00 -0800 (PST)
Date: Sat, 9 Mar 2024 16:58:58 -0500
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: Re: [PULL] u-boot-usb/master
Message-ID: <20240309215858.GU1523872@bill-the-cat>
References: <20240309160912.11194-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="B8C6F+5yXd6Ne36p"
Content-Disposition: inline
In-Reply-To: <20240309160912.11194-1-marex@denx.de>
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


--B8C6F+5yXd6Ne36p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 09, 2024 at 05:08:37PM +0100, Marek Vasut wrote:

> Singular quirk DT property rename. Fix for master branch.
>=20
> The following changes since commit eac52e4be4e234d563d6911737ee7ccdc0ada1=
f1:
>=20
>   Merge patch series "ARM: renesas: Rename R-Mobile to Renesas" (2024-03-=
02 14:30:25 -0500)
>=20
> are available in the Git repository at:
>=20
>   git://source.denx.de/u-boot-usb.git master
>=20
> for you to fetch changes up to 52378ba4963f5f4ab2786f3d0b4e929cd6cebe22:
>=20
>   usb: xhci-dwc3: Fix support for dis_enblslpm_quirk (2024-03-05 01:04:21=
 +0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--B8C6F+5yXd6Ne36p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXs258ACgkQFHw5/5Y0
tyxWoQv/ddOnBhe6VbkCYeft9aIlZkSkpeTYOwLok17+gnk/d7ytMF/EcOvqCuhs
dU2d/wzS0PdccW1RNo7gruTTdv6QURxS9dY5I1TpeQr5moz8nOg9nyPyTYes0wJa
ansbjtI3LgDddE9jPbnO4+8+SJZ8fXgzEMjtNrfICnD2vk/T5uTkcqK1nn0Y4bon
mwHWMyA19SgGaK/4Xz9Wns0VMzSf2DvXqXIbcdXWSqsRqXyfW1hKpuoo7vRfQ216
wR46XHw2lUwYO+UVidhPw+ehXRsSf7wwW3I3fysOiXePbdPGxhzRlqhyOpcfVYQB
FDD2eXv9tQcz0K74OXnhPnaeLnbeZOMLxxmu+i+7xBrISs0/+MvYjhH3kFMTfexx
yhf0BELwko/Ef2gIdsoiYGHDIWlm7LSoHqka6P4PBBkiLGr9v6bn1JaFj2Vpvm03
+4ZBKb4O7p6zfN4Z3khi9QWKDo4Z8XCteRJw21CSKTyFE9prYParBXNKkhaFMIy+
EeJcfUbt
=FrZ1
-----END PGP SIGNATURE-----

--B8C6F+5yXd6Ne36p--
