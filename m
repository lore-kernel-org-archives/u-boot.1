Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C27AC36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 14:01:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37AFE82D0C;
	Mon,  7 Apr 2025 16:01:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HbJlby7f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1538A82EA3; Mon,  7 Apr 2025 16:01:38 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C76882CFD
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 16:01:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-60400013960so731379eaf.0
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 07:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744034494; x=1744639294; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tzvzf82hXpTL6i+1EDfeCt1XmQGX2IR6wSf7UcSzEYE=;
 b=HbJlby7f5enZZ4lkZ3bEdaFX61c4A0OsOkdO0NO+TaEwIMM9sAwqYD96Ku7UU3LU+C
 0ZHrlpRrHHVvR3yLfglqWALYpfmrcQlO3Lu8CX/JHdho3/TmVsTZYVnX4YaxiF/EJ9Tr
 a8QWoklvRPaGOVXwLx2jjXfnUikuwbhR8Gni8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744034494; x=1744639294;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tzvzf82hXpTL6i+1EDfeCt1XmQGX2IR6wSf7UcSzEYE=;
 b=b4sA5B0VitcpnfIfp6wMr0zyVyQl5JbW8N03YNsY+Nr22V59UQEiTSssvD7BpjOXBk
 r0EowXGYPcDcpgE1wCnuOVjXHFL4TepBB+seQgyi+i2cfJx94EKZzwdNUlfDle9OnLWC
 xG/UB5q9hIkFAOlD/tDgKhoXu2aKqTKqaOcCUoWNqRwMazWH1fAaNUM+SeZSUj8nasik
 Pi3Bs+0a4xt0ZMFR+F3sldeAgtiiwfW2ISpG8PEMHu3Zr/Xnnb4znH8KmJj8LPEaYOFK
 ffpefW2EAcsukqudGmh9R/UgaMmkdIZSrm6tRO1flrSUVo1zCI5renzbgtqbTPQJyDGj
 Mtag==
X-Gm-Message-State: AOJu0Yy04J7Jm9VCAtT8ohL9GINVjXjJmJtWgJ8o9cSmXnuXVElaAQcy
 dDyepKOhQQEA/76dKigiYI9QFvutIN0XSDHHx3XdpheBOou1y4DfehQVzmo21HOYOXGlcVDZbnY
 o
X-Gm-Gg: ASbGnctCfjGgc8nQ06PR5YCQR5b/MwinCYGHTWS16BnrXFkviFQsnyWY0CCHCUlJ1oS
 PbDCpnJ23PE98GURAh13aLGT7mRHexfolwfA6Bft9419pxkvKUPo8krUnznAljTX39CH4qqppqO
 ibpWjRUYvYqOXLk3+p+fXTZiOQEf+xIKOjZrqO4jDQN/vbnQ3mYaCr8E/jgQhGr/JBWeomIZBYj
 JF7kVaX43nAqxN0Fxhoce3Rz7GqqHVMimftg4nEiL3A9LrNr7Tn8K7mI7VoucYQ0lEpUuZ+dzcO
 o9VHLtDqRI0nw1Cp7IjLlJfvAtFHW9at3iNsGUBhmpM7K2F08p+jzcA6oqkJAjbHcSx54kMG+nk
 x6nahUWnpAKeWUGqj
X-Google-Smtp-Source: AGHT+IHhAzpgYqUbqEEen1o0apN3v+RvCBAuEYUr7/f9Q2f8HCk+ipJd64RwLz9ATWFEv8mUlRV4kA==
X-Received: by 2002:a05:6820:229a:b0:603:f29b:85bd with SMTP id
 006d021491bc7-604154d2048mr5130976eaf.0.1744034493834; 
 Mon, 07 Apr 2025 07:01:33 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6040c58fb56sm1814931eaf.26.2025.04.07.07.01.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 07:01:33 -0700 (PDT)
Date: Mon, 7 Apr 2025 08:01:31 -0600
From: Tom Rini <trini@konsulko.com>
To: Eugen Hristev <eugen.hristev@linaro.org>
Cc: open list <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>,
 joel@jms.id.au
Subject: Re: Gitlab runner timeout on evb-ast2600 ?
Message-ID: <20250407140131.GK5495@bill-the-cat>
References: <7a737a5e-c804-4d46-be33-28aed9c4a113@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ES2AyzqyWzOsUhGr"
Content-Disposition: inline
In-Reply-To: <7a737a5e-c804-4d46-be33-28aed9c4a113@linaro.org>
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


--ES2AyzqyWzOsUhGr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 07, 2025 at 04:55:16PM +0300, Eugen Hristev wrote:

> Hi everyone,
>=20
> I keep getting an error on running the CI loop on -next on my tree :
>=20
> https://source.denx.de/u-boot/custodians/u-boot-at91/-/jobs/1090517
>=20
> ! _pytest.outcomes.Exit: Lab timeout: Marking connection bad - no other
> tests will run !
>=20
> Any clue ? It's been like this for few days. It doesn't look like a
> faulty patch.

Try adding:
TEST_PY_EXTRA: "--capture=3Dtee-sys"

To the stanza for the board in .gitlab-ci.yml and see if there's more
details in the output. The failure means that QEMU didn't run or we
crashed on start or something I believe.

--=20
Tom

--ES2AyzqyWzOsUhGr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfz2rsACgkQFHw5/5Y0
tyzN4gv9HMvWb1XdwPw2uKVROlOV1ChgWM0C+DVx+5VWxXdSelMuy3PhRAbyJns2
lR9fXHQo/X+tcm9t7GDZ0Ln7nwfuQlnPSOZAV1oqMrvj5BuS0kC9+zNczcXJzsf/
SwSj0PbZgxIbFj7rCa4LnyNgEQcNkZogx1/9H0XuarU1p54jVnKB9dhoU6Qvnn8f
Mol7dsgHXO6BR2GHnLBPp4/6myfN+NfqBP5Ze0UX+XH/Bez6i8xdt2fbn7VNpcPQ
iAjW0NoXtGafhX/CPFNdi6U8RZtSWqK6xizJRk9nhr3MAUVzcaiyZ0muFniwDjTf
tJkCTZruXsSJ2OceJrdfx/ZxnuTYrhlkdVqYDYIDvj2rmk/v7/FwB+oOf0O+fK4P
//VysMeuVUx67iiICmcs9bkuv/EBoU2AWjttGL5iuUdTOJ5VaM/5XtFRcyEc/I5b
tQdwSklKPgqZ1nJv+ZrnHHv85Y+AuTUMGrXwWC0FxvmruV8wjBMlY3FgpCg5nLSq
EUR2HAE1
=Mfnc
-----END PGP SIGNATURE-----

--ES2AyzqyWzOsUhGr--
