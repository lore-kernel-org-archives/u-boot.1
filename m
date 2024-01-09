Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F526C4706C
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 20:35:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B53AF876D3;
	Tue,  9 Jan 2024 21:35:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kcbULiOJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1629B87729; Tue,  9 Jan 2024 21:35:28 +0100 (CET)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03A2086FBF
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 21:35:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-dbed4b84667so2665999276.0
 for <u-boot@lists.denx.de>; Tue, 09 Jan 2024 12:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1704832524; x=1705437324; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+cR1whVtuRdMnxegHwwP17bSkqyTGu3ZGFpeJQLFt9M=;
 b=kcbULiOJd6AVycPLSp+IjssC6R55FtvM+6WkiYHbOmC1Sfan2//dzK1EQBQ8sJJTz4
 IkuwnQuwVh4vqwynH2mbqebWoxjl5Mnaor3nn9/J7D+XTPZm0TEJhmTkLG/JuWEysg44
 IYmI7A5zt92FwQxDePAvm0q+h4DFMsQ7JORRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704832524; x=1705437324;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+cR1whVtuRdMnxegHwwP17bSkqyTGu3ZGFpeJQLFt9M=;
 b=LPCOQBFHcbf8AYTX7yJPhmHUcIGAwkUqJi0YREr3W5UGipOlzhCGQixT106Kf58CgR
 /vJUIvJwSjXSKdyLUDHQ2nUlj+s1gqMxixRqrWiVt3+GscdAi0YrW+xoGOIJqneAih1r
 EEO3aN76M8JCi3sgqNfDffGbx/M+K2tbgAZ9RbftXwZUG5yDYb1AeCuuYj6JpOgUhkcg
 ejZWljI5f/8vcZGzbqz8v9iBwqKGrRWQLCTaSm3blWu4AZgO+6mT22i0dmlYFZqz46jx
 3YePBnUPloZrBPh88O7bKbEfFsumWZO+t/OditBNhTyLladI68yVPAXBpk1IRHSc43vE
 VdYA==
X-Gm-Message-State: AOJu0YzFuNUNSfjyUTr2wRcoBKhneGN2f60ZozjFSI9Qr/Vyz1rquIQD
 phukKcacdJUb0vFk2T4NR4pWV/WJbor7pQ==
X-Google-Smtp-Source: AGHT+IECcaGk0Si3tKwzSqERPHmh8EtcvZ9nN6bl18CWm6dOYek4EY6luY+BWQ/kdR32h2qqEJC7SA==
X-Received: by 2002:a25:d0c4:0:b0:dbe:a10e:9ab with SMTP id
 h187-20020a25d0c4000000b00dbea10e09abmr3548457ybg.93.1704832524699; 
 Tue, 09 Jan 2024 12:35:24 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 c18-20020a05622a025200b00427ee66bec1sm1163697qtx.48.2024.01.09.12.35.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jan 2024 12:35:24 -0800 (PST)
Date: Tue, 9 Jan 2024 15:35:22 -0500
From: Tom Rini <trini@konsulko.com>
To: Nishanth Menon <nm@ti.com>
Cc: Roger Quadros <rogerq@kernel.org>, michael@amarulasolutions.com,
 dario.binacchi@amarulasolutions.com, afd@ti.com, vigneshr@ti.com,
 praneeth@ti.com, srk@ti.com, r-gunasekaran@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH 4/4] configs: am64x_evm_a53_defconfig: Enable NAND
Message-ID: <20240109203522.GZ1610741@bill-the-cat>
References: <20240109122605.51951-1-rogerq@kernel.org>
 <20240109122605.51951-5-rogerq@kernel.org>
 <20240109191627.jn2b4nsczlsynik2@carpenter>
 <20240109194807.GX1610741@bill-the-cat>
 <20240109200014.wda3anzu4gljeic6@glitch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iWD5E3R9MeJLuu1H"
Content-Disposition: inline
In-Reply-To: <20240109200014.wda3anzu4gljeic6@glitch>
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


--iWD5E3R9MeJLuu1H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 09, 2024 at 02:00:14PM -0600, Nishanth Menon wrote:
> On 14:48-20240109, Tom Rini wrote:
> [...]
> > > > --=20
> > > > 2.34.1
> > > >=20
> > >=20
> > > Why not a config fragment?
> >=20
> > To me, this makes sense to keep in the main config. It can be turned off
> > as needed, and at run time if it's not present, it's safe.
>=20
> Three reasons:
> * There is going to be duplication across multiple boards
> * It confuses the affair of trying to find the minimal configuration need=
ed
>   to boot the board.
> * SRAM is limited already - we have been playing all kind of dances
>   around this - NAND is a daughter card addon - while I am not trying to
>   diminish NAND support, we are in a constant struggle to keep SRAM
>   viable and adding additional boot modes to a single config, IMHO is
>   the wrong direction to go.

At the end of the day, I'll leave it to TI folks. I see that
drivers/mtd/Kconfig needs a whole lot of help as while I would have
hoped that turning off just CONFIG_MTD would undo most of the changes
here, it does not.

--=20
Tom

--iWD5E3R9MeJLuu1H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWdrgAACgkQFHw5/5Y0
tywYyAwArxHC90ROFex54tA/9wYi3+tfNrcIF6iuaRpoNfHYuwZF+Peyu1wLk3KU
B1j6X7wpoIHVuOyfYTcevP7mW3TNkK3+boX10nisSlAqKdlVye4od2aLq4VOQ6bw
tPVD12KHwc4vVL3FLHZPmD8Kcnae2R7JgtFeam4x4KyDc66iSg8LI7usDZG3+7mr
g1KpWgcsg25kzl+LtUDaC+0pcp4ehVmNkTyDEoM/ShmxFZPwdelTAlMtgbsyBGNn
2aMXwRnzK25IGkNikiwpb9v8mHpL1odjETlYn8yhddgbOc13SK72IG5LNMoXjiKF
ovUSouEKgbP4rdzLrbb3e7CWFfpRT2SC8JxpVnHciOkwKpNolrTGDpS6zqJ8n3zo
v0PJv1ljyG6wnvaRNwHQEteZ9lmIVYoc4d9Gfy/nQcuRdkR1zpGMgqUZV+wfaJcM
LSVYxkyBasgtKDh00oyfQboPWHU0S2rvNYX1TEOBF7GHJcp+hu4rWDP1RQ70ZMG6
PS3DrewO
=/7Ks
-----END PGP SIGNATURE-----

--iWD5E3R9MeJLuu1H--
