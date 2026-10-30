Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECC7606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 16:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=o5goa87r;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=aHMm6nIU
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E1303811FA;
	Fri, 30 Oct 2026 16:40:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0eOtSveuMg9J; Fri, 30 Oct 2026 16:40:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D9EDE811EA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793378400;
	b=ONhfOyI/Q+eWyusWEgAHkMU3lAV9AZS87Io4qSeGIJ1wy+UaAlUrJDVO15hkAaouFbKJ
	 hXVW+DQKPe26S1ry8oSrDANWtiSJlCIoYlXJP2nwYh08YmOhxvgridU7SPb6tQRAEE6FO
	 b9yWSjAPYLMnTam4Uo1LL/VFg4AGzPv6H1bbWiIk/1UaWsIs3s/1IGPd3ZiHrzkYQTVNq
	 ySMI5+pxzfjmeug06riH2Zwhs3o+YPTReAaMb5wCLyM7ZqsBoya6kBsACXgsEqY1xG8nb
	 vgkk6cOIZdF5Vtje5FF1cjrhij2Sb9Se55G3iZBZ+muQrmSdzt3LufUQViSrLsY6QPQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793378400;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=srSB02+R2Idwy1IJNMEslFmrm2kDdgNjtGtrvy5O5JA=;
	b=pJDLz4Spj4J45DHL9jhdNctlUDMZzEvj3SZivy1MlFCtj7QmsZea65n3jKOlbD7N9i/D
	 SSpoErJ+V/z5jjS5a9BWJ0CsnuskblaBg4kHpXe+uBE+Pu7EEe2T6N3+TZ1m1PUDUJhei
	 ViYoSOEMk9BrvJy5tBg06pbXnKk9YxNLWpew+cFgytajp839zuyz2YbUrqnrnTy2TlwtI
	 yCeFFnq7SqpXjCwJrAQaf1OEvyaXWGDnUi24Wi2DkLdY0EDMbMCnohF3orhCkfcFVgFkq
	 5HQk+E1dYfHhiOgJSLfmcGEwQQsg19oxP5W6nIqIxWCkplWEVZ0yM/0Yvf8hEoQ57bA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793378400;
	bh=srSB02+R2Idwy1IJNMEslFmrm2kDdgNjtGtrvy5O5JA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o5goa87r6E3J5UX9e8RhO79ry/HkUMHkmhvTEgKiC/YNtwRV8l4vgVEn2C09Wb2Z2
	 dmffd2KaICaPk9o0RlPuOpzWRjVawnGy3XCyFAXEjXM3ep4ZpUjJ1U1cjv8gQi7oKU
	 23yjpqLY2h1LxAAcl7A+9LmYntbv/Av104t1cpHQgxQJUf63tsBFSrS0RwFe6X55vo
	 EnkyGewOXXb6KGqEvWdOR+nuJsE6I+0xQl6kL8KG0i6YF/e8xhniUkv6egXZYObIRw
	 aYbyrDaGmgjB51kjNC7MHqfliEJZf88IrbFYcTOME0VNH3Tad7Hihm/hhfjTmf4Mz+
	 lFRgtu8b8BjBg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D9EDE811EA;
	Fri, 30 Oct 2026 16:39:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 891A3529
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 16:39:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6E80040D5B
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 16:39:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WiQmhSXj8uyV for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 16:39:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 750C040D4B
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::4"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793378397;
 b=YwhS3QPEpFCuG5Lr56sChBL5uHj4cHQ0lbCVB04ZDPMBgtnUEMa/COWdi4pELJioas8P
 4A1YBF0CcfgM8Fw4ROk/SkzckYIW3OJwCISe08wGWGFK2+1HHLFmUWBZ44XAcR0C+KDYd
 Qfx04J8WGXWhGXX90W47eiLYZZYHrdHRR3pn7OPhIdH4Bpz5iEPDfJGKzYslpxUIuwNcU
 caxOfN2Qf+uXw9qF3oWAyl0agwXYqb9mszr/evB2vBe+KiEeqg6lJrFVxkPkLPzvpEy7c
 67Lnj0f2LS3WEwOxJGvxi4E174yTwFeKdgATaAbb8NJ/lL5/MfPNQquvsoyqx6W5gRw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793378397;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=srSB02+R2Idwy1IJNMEslFmrm2kDdgNjtGtrvy5O5JA=;
 b=OI+ZBrMeh2AO4qpuR1KnGLuKqIPWLodJW1MJ5+DgzvHgAEW0NaDBXAUY5CCc0Fj/o/r8
 HeLwXJMcMpM8un6FbxCjyt1WHEgK12VEITmYEm0HuRJ7rsML4yhKqxkslyZdXnkyFqdR3
 55+Du4HXaOjyhMOWxbr8UclhbVO8Yv5XGdE2C8zUtUyUeqpYVJWZGn1a54ixXgWYP7FqR
 XYL4CBJF9L9OwPAiVrM/uBt5CETLIGoeDEutCfqZouMdEaUErM/4IfIJjC1qc2tv57Av5
 QFMbYjCgUg7W55W6lB+ISxSGtaZbVLyY7JWgkjug+OjStOcUvRdhiS2PpA0D0gNvlNw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=aHMm6nIU; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::4"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::4;
 helo=mail-oo2-x04.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=aHMm6nIU
Received: from mail-oo2-x04.google.com (mail-oo2-x04.google.com
 [IPv6:2607:f8b0:4864:31::4])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 750C040D4B
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 16:39:56 +0000 (UTC)
Received: by mail-oo2-x04.google.com with SMTP id
 46e09a7af769-8458611046fso407676a34.0
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 09:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793378396; x=1793983196;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=srSB02+R2Idwy1IJNMEslFmrm2kDdgNjtGtrvy5O5JA=;
 b=aHMm6nIUB3OVspjhvWbswBj4IUzg2YeFQTWd08uPyg0Hvf19hYb6fvSVlUHsNEEcDm
 6SnpOc2LGolAXO+TSP0rwsy35kEF3AAd0I2hCeB74SitiwBOA4506WiUgH0rS79aNw9g
 il7KIQw4B6Zet9RQV5RvpiKROeNKn0cw6rL70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793378396; x=1793983196;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=srSB02+R2Idwy1IJNMEslFmrm2kDdgNjtGtrvy5O5JA=;
 b=bWOCLrhjDFUf4BKOe1p4aLyNfqzu6pDjRdNYmJ2EB+ZJtOFEH2Fwx4CUhqGu9hxmb6
 It1mKf+gLdoQdtrVYqisbJZa34lM3Pz+NDSoq6X0H1QS63mnXKKUKuMu2WV/PRfBO4Af
 xZgoZUH+OA6k4R3aNGRSofRjbtDYk9S2J3bgY0iN2x8GmWe2y+si1tkmdlvf6GLy2OYy
 2a8zo5Zqqlioj99TcPlNa3wgjNFZWfGduG5ikDaTzIkNp1egYbB68Cbu+NXHgoaEku+j
 XkH+i5Uy4YK53rPkm9BIVPae21k1gZgpC8xj0qy6M64DjRfROv78fw+ZO47rcFlHkVU2
 JSJA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzmEkyD+m+Mfq7fM8XJKcj7eBZiN6IqJobkTRDW0mNhc0AuMaYLDrkOpJKRNXTjmQtiLV0rEmc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKX6Jf8NojR6/zxtLqlWjRBBpKkKca0vKZ3fqf4Vwmtifllq2v2
 xlxo6bOqCgx4Vjd2uwE0UFZaX+SWNLRtUnEeYDpoeN6OZfdL22purBTL1lDI9L1N5hM=
X-Gm-Gg: AYBFou0SzJzv9TcWWoJP7zbgET5feE2Qa3vw1Glkmdct9BF3o2dTJVYfgyXCoLCnFi0
 Xq3dtEjx4edwyGIjbd9y59x9lNsTGRazmjJA+pEEL1Efv9K58JhwlOf/XSFZia7v3/EJjjGhatU
 HH8NxPgSnYCwrK/DICXd36XG+6I7d056COXGhfi37iqgWrsZROnqjMhmLDSyfuJQb/41wqZAiIE
 E6JVZPhD1lX9AM8Gjr5yDw7GhjBzh6K3t+lCuVFxzhvwPFeaAEMD8tM9yNcJfD3YnZK3Nn2UJHE
 CDtng5eqg0MSJvv7r8KD6/7lxUUOJdmPXibSdCYUsWkFDZ5yxL8LdSO1fqekJ6m5COY7zodjSRo
 LSHYW/pvZEHwhde0prfU775pTbOex7KmYsBE5H034W4Pe/cU7Uepe+JKdElqSgHY4yH1db+eeYi
 YNUxhIDRwHW3wDRYjTeXc0UylFI2io8TogJDV8VSrMeia7eZzIQNWIxVBYEsmcUAvoGV6jkjp4I
 wjPE/u3QYNt9R4+CgZ+gF+GRLd3skbBEN4FfH+XEHDqda9axVIWNMBiQAv4Bm3NqcCnajwpHC8X
 zpqOrUOJbblFyu197g9CiMNXvEPUxFWPS0Yne60rH9uZbXFbLfSGnLD8aLOcQ1Tyt/E6qQsNVhH
 Sn3QrWE0ngJG7tCnlTICvktl8bz+Zx0F2IiLH1kXaZNdORIh8yu6EEx7L3ir9sUaKERF+O/rXtf
 GAlPdaLC4OA87OsSzRqzfc6imB7B+V970=
X-Received: by 2002:a05:6830:44a5:b0:822:ce5a:4ab with SMTP id
 46e09a7af769-85d3652cf15mr2189216a34.26.1793378395863; 
 Fri, 30 Oct 2026 09:39:55 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85d35528a41sm2424264a34.24.2026.10.30.09.39.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 09:39:55 -0700 (PDT)
Date: Fri, 30 Oct 2026 10:39:53 -0600
From: Tom Rini <trini@konsulko.com>
To: Maxin John <maxin.john@gmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>,
 Daniel Golle <daniel@makrotopia.org>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 1/2] configs: sandbox: Enable binop command
Message-ID: <20261030163953.GD3309461@bill-the-cat>
References: <20261029173443.1495866-1-maxin.john@gmail.com>
 <20261029173443.1495866-2-maxin.john@gmail.com>
 <980bde4c-b077-4291-9cf9-30fe59526ff9@gmx.de>
 <CAMhs6Yxa0wdzkE3py=Ns5j+D8-8_+Z-ngnuxRKcTvQ+0qDpt-Q@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="n0OmmBjWtWaFk1rv"
Content-Disposition: inline
In-Reply-To: <CAMhs6Yxa0wdzkE3py=Ns5j+D8-8_+Z-ngnuxRKcTvQ+0qDpt-Q@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--n0OmmBjWtWaFk1rv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 05:58:58PM +0200, Maxin John wrote:
> Hi Heinrich,
>=20
> On Fri, Oct 30, 2026 at 1:26=E2=80=AFAM Heinrich Schuchardt <xypron.glpk@=
gmx.de> wrote:
> >
> > On 10/29/26 18:34, Maxin B. John wrote:
> > > Turn on CMD_BINOP for sandbox and sandbox64 so the binop tests are
> > > built and run in CI on both 32-bit and 64-bit builds.
> > >
> > > Signed-off-by: Maxin B. John <maxin.john@gmail.com>
> >
> > Which tests? I could not find any depending on CONFIG_CMD_BINOP.
>=20
> This change is a follow-up to my recently submitted binop clean-up patch:
> https://lists.u-boot-project.org/pipermail/u-boot/2026-October/637804.html
>=20
> Following the review comments on that patch, I have also submitted tests =
to
> improve binop test coverage:
> https://lists.u-boot-project.org/pipermail/u-boot/2026-October/637974.html
>=20
> These tests depend on CONFIG_CMD_BINOP, which is why I enabled it in
> sandbox and sandbox64.
>=20
> > HTML documentation for the command does not exist.
> > The online documentation leaves the user clueless:
>=20
> Agreed. The documentation for binop is insufficient and could be improved.
>=20
> > Usage:
> > binop op count [*]src1 [*]src2 [[*]dest]
> >      - compute binary operation of data at/in src1 and
> >        src2 (either *memaddr, env var name or hex string)
> >        and store result in/at dest, where op is one of
> >        xor, or, and.
> >
> > What is count good for?
> > What should a variable contain?
> >
> > Can we simply eliminate the command? It is only used by a single board.
>=20
> I am not aware of any other users of this command apart from the
> gazerbeam board.
> Personally, I can work around its removal if that is what the
> maintainers decide.

Perhaps what's missing here is what your motivation is for this cleanup?

--=20
Tom

--n0OmmBjWtWaFk1rv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCauTIWQAKCRAr4qD1Cr/k
CipMAP4z9qeqpwOJTElmvOrhXc5NfDGB6e/JXLKy2cdNTMM4CwEAwP+WIrzqfO4Q
G7Tnl0HC+CvqKm3L0T/K5MZyN+dsWA8=
=pqyQ
-----END PGP SIGNATURE-----

--n0OmmBjWtWaFk1rv--
