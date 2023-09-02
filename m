Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A5FC71153
	for <u-boot@archiver.kernel.org>; Sat,  2 Sep 2023 13:49:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5599086703;
	Sat,  2 Sep 2023 15:49:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GM7tOZ7M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6510286741; Sat,  2 Sep 2023 15:49:15 +0200 (CEST)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0ECF8644F
 for <u-boot@lists.denx.de>; Sat,  2 Sep 2023 15:49:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-ccc462deca6so7691276.0
 for <u-boot@lists.denx.de>; Sat, 02 Sep 2023 06:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693662551; x=1694267351; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=H+knHQniirzrFimT3uYhZFKlJhZcqII7CCnhuszRh+w=;
 b=GM7tOZ7MGlIHjB245HtKmSdaRg+FJX5WMYbQpikMesu8+oCMPXgWgULl21D7NCqUSP
 eWwtUTNkWU21TPPGbq70PFZOaYyJ3HvuPimX0eiQuzJQQj9M/ma5Bn9xWo3LfB98lES8
 8t7plU8hHFWwj7/V+Nx4lMZZTj2nVvJ+U5ITI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693662551; x=1694267351;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H+knHQniirzrFimT3uYhZFKlJhZcqII7CCnhuszRh+w=;
 b=WVMGR71SX3jZMMVCqmb/X8rPS0JesPypQbg89gJXoCaKuN5o6Atvc3du8mHYXdZ4wa
 hCxAAroHa8E+GQUn6HnlfYH9E1q9leG7GjC4S4K9FTkfoXGehZuWoe5rGxAZFdTikhL0
 RpMV4Y6JMETw2mXASQM6JjgjF6+o8+40DSXeRxZ2uJtSKQsEplpGBYPEppK+zK4RXWNd
 XoBRoT5Acg4mhLkAdy/nRsH80v78hKVIWbOLMu5sinBazuWpz7S+4nBVPgIfrQrDXrGo
 mpnlVhKrupss3ccSEnMucB0AmK1ekLSkM3Uk+ULTckFoFCzEkuXgQepDZv6GNUSYv8kM
 WrIw==
X-Gm-Message-State: AOJu0YxLYRoIO7P4Cu9M1f69ffLKvRfSiimDZaotCCnXLs4tMTQvpi83
 iMCdYL7TNUA0t8W5vI2rhOUMIw==
X-Google-Smtp-Source: AGHT+IEK6AWQUOc39dUCsH6RFl7fdM/5lNcxFbtCT2oVBfp6ms6yS8Q1USucvElX83ZUD4jOHf8XAA==
X-Received: by 2002:a25:acd9:0:b0:d19:ea71:a96b with SMTP id
 x25-20020a25acd9000000b00d19ea71a96bmr5720644ybd.57.1693662551384; 
 Sat, 02 Sep 2023 06:49:11 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-9522-bc83-aa36-be61.res6.spectrum.com.
 [2603:6081:7b00:6400:9522:bc83:aa36:be61])
 by smtp.gmail.com with ESMTPSA id
 j136-20020a25d28e000000b00d7e339ada01sm1395182ybg.20.2023.09.02.06.49.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Sep 2023 06:49:10 -0700 (PDT)
Date: Sat, 2 Sep 2023 09:49:09 -0400
From: Tom Rini <trini@konsulko.com>
To: =?iso-8859-1?Q?Jo=E3o?= Marcos Costa <jmcosta944@gmail.com>
Cc: u-boot@lists.denx.de, sjg@chromium.org, antoningodard@pm.me,
 Y.Moog@phytec.de
Subject: Re: [PATCH v2 6/6] doc: add documentation for gen_compile_commands.py
Message-ID: <20230902134909.GX3101304@bill-the-cat>
References: <20230901200353.90290-1-jmcosta944@gmail.com>
 <20230901200353.90290-7-jmcosta944@gmail.com>
 <20230902131109.GW3101304@bill-the-cat>
 <CABfBAmDEwtTAHL8hxGXrsRNN1V9USPYNwi9nojb-HN-CQwDF1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2UaI5C6xvAEM27lO"
Content-Disposition: inline
In-Reply-To: <CABfBAmDEwtTAHL8hxGXrsRNN1V9USPYNwi9nojb-HN-CQwDF1Q@mail.gmail.com>
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


--2UaI5C6xvAEM27lO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 02, 2023 at 03:38:13PM +0200, Jo=E3o Marcos Costa wrote:
> Hello,
>=20
> Em s=E1b., 2 de set. de 2023 =E0s 15:11, Tom Rini <trini@konsulko.com> es=
creveu:
>=20
> >
> > This isn't included in one of the index files, which will be the first
> > error 'make htmldocs' throws, and I think I saw other syntax errors as
> > well in the file.  The docs themselves look fine, thanks.
> >
> > --
> > Tom
> >
>=20
> I'm not sure what's the most pertinent category in 'develop/index.rst'.
>=20
> Would 'general' be a good idea? I thought about putting it in the same
> category as checkpatch, but this isn't refactoring per se.

So, the main use case is to make integration with IDEs easier? Maybe put
it under doc/build/ or referenced from doc/build/tools.rst with a small
section like "Integration with IDEs" and a few words about how some IDEs
such as ... use Clangd LSP for ... and see :doc:... for more
information on how to generate these files.

--=20
Tom

--2UaI5C6xvAEM27lO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTzPU4ACgkQFHw5/5Y0
tyxKKgv+I4MAAtIAm04LCZ4wHdIbQI+61mi9WR1Vav1fpdKe+htzH2A6Pb9Gy6oc
epPKu1AxvbZImxRhVdmcObz9PSsLPCNN0tWhssfs+idJmH0X+tM+9uWnaeWESkeY
XsYJ8mjxGDeZOubVxOTXYVC6rC5w4s30p5QQBD9oZu7J3rzk0B8nDRiANEzKij+P
MOstbJWS4ox5rRky+RWeAz24iBH4Ril24B6oOAjSSTYjat65cFGc/BhFqu9Ld+eb
DdUdnIelV9PVCw73/VgpSNPz0C7kJaFGmpfXaZ5D2hnTvTRt9+UbLyM0ycaxEetL
m7Xvuw+OVCJPgS8PixDhQhDwoANbdbH9EfMbGJvcIUYaRol0kwBuE2pvH5x5wiys
IdAqscrnQHjloMlMBIBI/Z8PY1vdrMdnjBPMdsRd7fAzxxfxe/q/RsC14QwYLyR8
MBOdk1TtwQDhDpEG9QTFY/KdGUYx9uM5GYPTvtDVHv6B+08xJOq5fgnQAwwVHdUV
2evXLFFQ
=mkD6
-----END PGP SIGNATURE-----

--2UaI5C6xvAEM27lO--
