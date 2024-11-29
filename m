Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46777D6EC0D
	for <u-boot@archiver.kernel.org>; Fri, 29 Nov 2024 13:50:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF12C893EC;
	Fri, 29 Nov 2024 14:50:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="q5QJrls3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5106C89437; Fri, 29 Nov 2024 14:50:36 +0100 (CET)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14C2689338
 for <u-boot@lists.denx.de>; Fri, 29 Nov 2024 14:50:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6d8878ec049so4105406d6.3
 for <u-boot@lists.denx.de>; Fri, 29 Nov 2024 05:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732888233; x=1733493033; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=13o2NL0QxNPoEYdRxOJ2H7LoF+DcROABA+izXav9tMk=;
 b=q5QJrls3E00xpiC6uYcJ0gfVs3DdstYQC6dljujAhf4uZM/cYiH7NdlMmm3INstgAV
 iv83r7n6/g6rnVPgazmDuhFU9z5enFzfx/4OoOp5tIljp2oKSAlgixmXKbOThffczZ2S
 Wltx3qqjV4THc536QbWD++ullf/wONUwds4Yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732888233; x=1733493033;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=13o2NL0QxNPoEYdRxOJ2H7LoF+DcROABA+izXav9tMk=;
 b=KqZn7bg6SoMBD/YLDwoT3w2xvM2rbOk/WJRrzf/VXs6OxxDMy7G+X6jH3KEZ4P48/e
 CtWqFyAq8eogEUeIL3KHgFNl0YOHjzRC+qxcWvZJSgTtsl9KzC60p6bq1LyBJO1agDxs
 rqB6ChpOlxgQqk3KAznXE0BQFHzeCZJA5tYtKEhBlV6T+xWNJNB9TNldLrQM8/F0XCNW
 +ay8tl2JotAa+k3OM4L/nfaGVOf54mWxhe3rYVicmcXvAhOqeUb8JA5+UpdBhSC86flM
 MKiwgnR5HBF4oqQEOmR/jHwVeMio7lTlCsADYj1ufCLMV0+mOb791KGoG5znFUxUAs7Q
 m9JA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLncIySw4Y4bOgA5CQ8ydTV9RAo7nqARgBsRQ9NkY0bBH8wnvb0CKvBpfxbkMh1Qmit9YZORs=@lists.denx.de
X-Gm-Message-State: AOJu0YySb0FsZDa7a7YnVJKt7BvHYPS7DgzVXvICXhiQVwuD4v1SPfEK
 3ghATSqggaeXrwF2CaKjFHBgOyuzTKrFxbhQLU4y2ZJ1a0sjl8/bIkWC6aLuyhY=
X-Gm-Gg: ASbGncvaTHf4FxCt8bJoG6MLHuf466oG3dp5hs0MIVrZ8Sk5IiqaPSS8a3srARlI9Bb
 HOgWPqOuSXnt3T/nUWQQ9kJJULKQoeew0TJ0JnKopgmjF4xRLNxq13Ctqw8VizKVXIkkgaEekKX
 ooMCWYI3TIKSdMHvWTdTxdslDDSvC22qhhjHZ66VPPjS5eAmhKkFsbSCJT9Xi8wkIFw8u4qskJr
 8bCWDYHdUvgl3s4XdDGaQD8C9wnoGNQUV6zShrdXm1rxYlb/w==
X-Google-Smtp-Source: AGHT+IHYjMAEp6HxZAck6jn7RlNc6QiXMlbnlOEH1C/iGb85hamP0wiuV7NVSnbjRGrPYq9d/dU7Tw==
X-Received: by 2002:a05:6214:202d:b0:6d4:16c9:2495 with SMTP id
 6a1803df08f44-6d864cfda6amr171382126d6.6.1732888232855; 
 Fri, 29 Nov 2024 05:50:32 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8751f55f3sm16532116d6.78.2024.11.29.05.50.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Nov 2024 05:50:31 -0800 (PST)
Date: Fri, 29 Nov 2024 07:50:28 -0600
From: Tom Rini <trini@konsulko.com>
To: "Kumar, Udit" <u-kumar1@ti.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, vigneshr@ti.com, n-francis@ti.com,
 afd@ti.com, u-boot@lists.denx.de, nm@ti.com
Subject: Re: [PATCH] arm64: dts: ti: k3-j7200: Fix OSPI boot
Message-ID: <20241129135028.GJ3600562@bill-the-cat>
References: <20241119100720.1297067-1-u-kumar1@ti.com>
 <20241123024219.GU3600562@bill-the-cat>
 <CAFA6WYM9esX2VwGf91P9ics419OXq48zH_Taq_0xtHT19HmgUQ@mail.gmail.com>
 <20241129133618.GI3600562@bill-the-cat>
 <4711a378-b10c-4ff6-b2de-d9da7dfc03be@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Tja12Do18YKI+oGN"
Content-Disposition: inline
In-Reply-To: <4711a378-b10c-4ff6-b2de-d9da7dfc03be@ti.com>
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


--Tja12Do18YKI+oGN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2024 at 07:18:15PM +0530, Kumar, Udit wrote:
>=20
> On 11/29/2024 7:06 PM, Tom Rini wrote:
> > On Fri, Nov 29, 2024 at 12:33:04PM +0530, Sumit Garg wrote:
> > > Hi Tom,
> > >=20
> > > On Sat, 23 Nov 2024 at 08:12, Tom Rini <trini@konsulko.com> wrote:
> > > > On Tue, Nov 19, 2024 at 03:37:20PM +0530, Udit Kumar wrote:
> > > >=20
> > > > > OSPI boot is broken due to missing bootph property
> > > > > in pin mux of OSPI.
> > > > > So add bootph to fix OSPI boot.
> > > > >=20
> > > > > Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> > > > Applied to u-boot/master, thanks!
> > > >=20
> > > Please don't merge direct contributions to dts/upstream subtree. It
> > > should rather have been a change via *-u-boot.dtsi or a cherry pick
> > > from dts/upstream subtree. Otherwise, it is very likely it's going to
> > > cause conflicts.
> > I thought this was a cherry-pick, sorry.
>=20
>=20
> Sorry for confusion , it was not cherry-pick,
>=20
> Let me know, if i need to send patch to revert above commit.

I'll just do the revert and push it out with other changes.

--=20
Tom

--Tja12Do18YKI+oGN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdJxqAACgkQFHw5/5Y0
tyy2WQv/dA58evR+xgqjIHUkyYBiqOlWh241ZL8PGPvb1QNGyUAU7Y1ML5gQ+XGl
dTf91hLhkmdnmj2Q0tbUQIkrN7xTmzBUoar/BLQGKY1RLiNgYHS/aibd5Q/beK2A
um5G2B8cESyaukpaVhj7B7G86dd1uW92HjXqGtstfFn2dEJFrlH7Fd8B3Z0Zk6ar
7dV2PoKZonwRaPcns+BGd3nyowySI0Oxj2T3xfRxQaRLjsSNebPn+u6fgqR58FDW
kS9mGKwpaPwj9SF8kiLjwmbBijZ2ZU3EiaD56bRYF4u+21OTxeBzOa1bPvrpjZxe
nHmk2Jozq8TdGVF+kWD/g+6DeRBW+gTF7+ibCETZGlXuXEQ5V+1LogEFTGGblfkq
VCBIeyXEJ5BkVSIl9gGfB1QRhYQ4QFc8mJ1bJ+NAeQS0ZFEk/HQxdr4N1lOCr/vO
DGV9klqFSiSqZ4nwtVH8n+tJ7e+v8SwpOmTgiaaUgsqv1iDE2onBd0hoIMg9fRhP
yCSGbldQ
=iHOT
-----END PGP SIGNATURE-----

--Tja12Do18YKI+oGN--
