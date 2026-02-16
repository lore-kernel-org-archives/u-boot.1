Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A5CE81A36
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 15:29:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55F7B8063E;
	Mon, 16 Feb 2026 16:29:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jbkz6i8R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8357080FA1; Mon, 16 Feb 2026 16:29:13 +0100 (CET)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CE7A80086
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 16:29:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-404254ffe8aso2153711fac.0
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 07:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771255750; x=1771860550; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gqPIivORoJm55bA50trcAr38IDVqwXIQFMbDEg/HMmk=;
 b=jbkz6i8RUjud+vH2JLDocCvWWTeuep/7vN46NM27KZR4T6AXAKGfVQlNvJvKtGk3zx
 U71hgW79kuf8waJ+KrmVo2icdW0R+r/Fo54Ml9ckr/PDOrRNAJbi0EcuL69qzm9YjSWJ
 GHch14067Csaiway7olQQhZC90VjocdaP2oPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771255750; x=1771860550;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gqPIivORoJm55bA50trcAr38IDVqwXIQFMbDEg/HMmk=;
 b=H74XpyIECH/btUulh0rgS0bbeaB3fBn45w10WonwmfG71z84IDr884UFxxHt2VKtd9
 5JiX8SwzMoOdbsK2TjRDuWfZgtS/URktcV7A8bL917gSjEs5fRfmaBb3u6CfbS0nExLO
 vrv22dcQG4dIz30iThT1rIoUAJQIqWAAzMY+0hjoACgW98nUkcPsdEU4EjJ+5bTbQyui
 66b771tVWPhWhFnPmiNFvvRlWynWSXeNhNukz2zWe9IKXjsINsM2b0yotyLi49NE3ewV
 RQDozjZQFDNibTueejQiSZun06J/rXXeN3uWkOE7OiFYcrtXLwlZpGiFQK9o0kQB2FDT
 hB5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWk7u3gscwHQ460n7PSHkRPnqgn935Sb8SQEkr/v/MLv1e6lkyuZTyn4m7xARs1WfyR3xeTmjs=@lists.denx.de
X-Gm-Message-State: AOJu0Yyp7DeEGRPhzaTc1p9sTWCVpu3yj4SL4/gin3TILuVD8c+vC8o3
 hZqY6lgHBlI59WXWUGZKG/4UVGX8cFKtyP++IRQ/IY5i2w7d8gy4+NCmi3SpZTFj3oc=
X-Gm-Gg: AZuq6aKrrYAu3r48HV3qdtnu6c7WXJp8CeK4/QrYD/OkoB1Ri1SLRmG4i8kCV8JXGKP
 PFVtr0zuwXPlUvM+NoYRTkxDcpdyMM/QSACM8YGkbWCDqtwl223/7GagJ3/K1zu75iCRuMJjLHn
 y5jDliuQASqvOjPpDs5paPKZYl76CEFaNyFzI0EZiknLgTRrhCrS15zi5mQTamElFnzzEN6agIO
 x/vSSXRmt2ObtoIIFo4m0woBAgAdWtM2Ead7BwQHblPZyN2B4dwwloikrVzRrJ4PzqusEBN7nrt
 w/8vH6OLOLNExE1NWnuXwn6/d9nkLLC2EpBrllKSKSbYsKuFQ0g5mjQqLO61ICIB5+tx9ZhJgUt
 X/LOSolQ3Oj/Tv5KsSN/w4CJkuU6DOrg9UTXOvXWWph766Cv5wXxvQuj973jjI0kZZJOocvs6lv
 rvFUflVUfJI0boSr2MSaf9JYiNve/oHTk3UG8eQFwWnvZEsRZ8ygCH2OvPKhTEMIb5+JnGgqAag
 OD9WTUfIN+s/IJxBeOY4e58TtaOpvwIwvFZxe2cqVpUNIQqmI4=
X-Received: by 2002:a05:6870:440d:b0:40e:ea07:2215 with SMTP id
 586e51a60fabf-40f08779a45mr4978383fac.10.1771255749948; 
 Mon, 16 Feb 2026 07:29:09 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40eaef220cesm14524378fac.9.2026.02.16.07.29.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 07:29:08 -0800 (PST)
Date: Mon, 16 Feb 2026 09:29:06 -0600
From: Tom Rini <trini@konsulko.com>
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: Simon Glass <sjg@chromium.org>, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 jerome@forissier.org, marek.vasut+renesas@mailbox.org,
 ilias.apalodimas@linaro.org, me@samcday.com,
 aswin.murugan@oss.qualcomm.com, clamor95@gmail.com,
 michal.simek@amd.com, u-boot@lists.denx.de, u-boot-qcom@groups.io,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH v6 2/5] drivers: sysreset: Add sysreset op that can take
 arguments
Message-ID: <20260216152906.GU2747538@bill-the-cat>
References: <20260121063920.1500293-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260121063920.1500293-3-varadarajan.narayanan@oss.qualcomm.com>
 <CAFLszThUMWgySrb4H2F5PE6XVsRK0Cc+PZ37f_3xZ12HEhM=3g@mail.gmail.com>
 <aXg8ge6z7EMWliSd@hu-varada-blr.qualcomm.com>
 <CAFLszTh-B=zQyBjwJ_OuVxAbpTpUaKB1e9zB8Nm6+wuJCK5OcQ@mail.gmail.com>
 <aY7x9EAueKZ9Xxmt@hu-varada-blr.qualcomm.com>
 <CAFLszTgWW0-3hXkUWVmiDgfT1yMZMkjX8zDsT8Qf846ZgaA2Xg@mail.gmail.com>
 <aZKrlhpNI/tpdWmG@hu-varada-blr.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EiUtGRphn2/IUe0X"
Content-Disposition: inline
In-Reply-To: <aZKrlhpNI/tpdWmG@hu-varada-blr.qualcomm.com>
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


--EiUtGRphn2/IUe0X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 16, 2026 at 11:01:02AM +0530, Varadarajan Narayanan wrote:
> On Fri, Feb 13, 2026 at 01:20:10PM -0700, Simon Glass wrote:
> [ . . . ]
>=20
> > > > > > I haven't been following this, but what sort of args are you pl=
anning to pass?
> > > > >
> > > > > As of now, an argument to indicate reboot to emergency download m=
ode.
> > > >
> > > > So how about adding a struct in sysreset.h where you can include a
> > > > flag word and create a single flag for your case? We should be able=
 to
> > > > handle reset without the cmdline being enabled.
> > > >
> > > > There are other cases where this would be useful, e.g. an EFI app
> > > > rebooting into setup boot.
> > >
> > > Previously, i.e. v5 [1] didn't have SYSRESET_CMD_RESET_ARGS config
> > > option. This was added to avoid bloat code size for platforms that wi=
ll
> > > not need this. Please see [2]
> >
> > Sure, but you are adding a new method, so you could make it take a new
> > struct instead of the string list, still behind your Kconfig option.
>=20
> Sure.
>=20
> You want 'request_arg' function pointer to take a structure instead of
> 'char * const argv[]'. Is this understanding correct?
>=20
> If yes, this string list is what was given in the command line. And is
> passed to the implementation specific handler.
>=20
> 	Command line -> do_reset -> sysreset_walk_arg -> *request_arg
>=20
> The implementation specific handler can interpret the argv[] as
> applicable to itself. Not sure how to convert/parse this to a struct
> that can be used by EFI app. Am I missing something. Please advice.

Varada, do you think this suggestion is taking things in a useful
direction? It's unclear to me at this point if what Simon suggested is
going to provide something meaningfully more clear / useful or not.
Thanks.

--=20
Tom

--EiUtGRphn2/IUe0X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZM3vwAKCRAr4qD1Cr/k
ChARAP98Z0W2PkFE2pcKWZTcUzpMB5HXaw4VYX33u9GDJ8Qv6AEAmt1Jfh9CNQS3
Ub+ZNcL1wLGCGiwCB90DuxTuqCY+zgQ=
=0D0O
-----END PGP SIGNATURE-----

--EiUtGRphn2/IUe0X--
