Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A70EB26E9
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 17:02:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEAEC83DCB;
	Tue, 10 Feb 2026 18:02:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ihdcv8M7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE1BB8388D; Tue, 10 Feb 2026 18:02:21 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9399483D9C
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 18:02:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7d45d37f8e4so612682a34.0
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 09:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770742938; x=1771347738; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NIJL4MKD2ZXY4lDsZAmWXUnOWAM9trvQ2FyswyhlE18=;
 b=ihdcv8M7Y+ltU/8j4KLFF6bpWXpZyuBrx0nD5fgtwvxfX5iG0Tt92wbcJsLZ9O9IEz
 q6+ym9B5Cltl2rNB0F5NFMYZbWaDWMUFP5+aG95nbGadXM3UBOrrmsyJAUcafM9JjtSg
 nOeBc+BqlAP+qkVQ9UVWoNuCYdziJn4OVP3yk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770742938; x=1771347738;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NIJL4MKD2ZXY4lDsZAmWXUnOWAM9trvQ2FyswyhlE18=;
 b=iGdaBDx68GtV9NghYQ6uHRRF6MXvA5Eu0k2qat+WJWvCs3337h/br1V7MI2gqu7tKo
 XlncD1LmgN0YaNlJUYXjjjagJNTNAe7E++Ho/Z3PcyAqjzPzQCw/TijDQkJC+a57x176
 e5O9yLGngMu3zbOeBbwjSa30/82izg4UB8iGSyGeDdvf7YycC7MHWX1PDss8AUIZa23X
 WmmFTaks/eQgtSTaxznWPr7izWFLCSfXm5Pa9aHDA2QEWGhvV8CmmB+bMbVewWWSN8jp
 5FhSBYU+zM+NSrjd82s/Y6f8dToNkML89SLMZvENWJJnj9OxdAhlDwajQC+r8v+xtzgV
 6VyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIliQRcGaU2a0UbY2XGnvne/vv6zyjSz4HKd7SMjbISDhew0i3W/L2vdbhM1CqQttco7i0irY=@lists.denx.de
X-Gm-Message-State: AOJu0Yy9mwNzctQzad/hWIvfDYF9a1AVAQpMuqLBXtxfJBgG0XgIy9y3
 c4FVOb73XcNLY6dEo61Chx3gLgrDbCBig9G0Ro3N6vOuMPIxAHZIVWVtEVC/JjQweRLO5ifOX/f
 3xJxhEo4=
X-Gm-Gg: AZuq6aLmXafIp7xgkhC+gQEcdjISDXK12Prw+cJ2TUVEpSL6yyDz752wRWylSG/omfq
 E4BKzKS+pMXamth3nvxfUzLN47IeqaXXlt9RkKxL34wwtI32yyzcjLF67kMo27I1HuoDOg3495Z
 p0IGYtPZOQXGX7OEG+6f9ctQdXRM8UZ3ePZuC/riW8FhmCViRef8kw7ZFHTaMTThkm4DRkH07U2
 GTaum9LI/f16ZJovRxE9cmvmwKCcx5rlIbm6WgggsBhVJUCsJzbTwMkQeUSmvcstRBH4Pcn6sfk
 3xl2KpKyW3UeD74MAylDoPxq83bO/TGCWHxveMr4x4zJQbKq0XfKV3zmvuyRY9wllzqBX9opvZY
 FSCXSKPqxWiCEMFoYrhQ+IfjSG5CzKQiTioTti8Nsc3SM+GBvn785HoSOpVTxM2bEIsna5iyQe5
 EQje766DseAloTOwKLNd5t5LgwshhRYm2bqWt3XOCxRcc0UNEaFFMr7Ma6H+4k+dL3SNkWlwAQP
 Q+LyHzAbbpBZaDcqLdisEhz9MTNYjb6ZCiGjfrYmqfgHnub/2k=
X-Received: by 2002:a05:6830:3891:b0:7d1:90ae:bc16 with SMTP id
 46e09a7af769-7d4643eeeabmr12868248a34.8.1770742937488; 
 Tue, 10 Feb 2026 09:02:17 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4647aae35sm9756040a34.29.2026.02.10.09.02.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 09:02:16 -0800 (PST)
Date: Tue, 10 Feb 2026 11:02:14 -0600
From: Tom Rini <trini@konsulko.com>
To: Eric Schikschneit <eric.schikschneit@novatechautomation.com>
Cc: Simon Glass <sjg@chromium.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "bmeng.cn@gmail.com" <bmeng.cn@gmail.com>
Subject: Re: [PATCH 2/2] Fix x86 baytrail boot flow, UPD/VPD Updates
Message-ID: <20260210170214.GB2715950@bill-the-cat>
References: <20250714210249.4139916-1-eric.schikschneit@novatechautomation.com>
 <20250714210249.4139916-2-eric.schikschneit@novatechautomation.com>
 <20260203181444.GQ2603314@bill-the-cat>
 <CAFLszTgLx_TtEO-8qq_9uojLd7PgFdUuhs5_6kYqL7GuzFt7ow@mail.gmail.com>
 <SJ2PR07MB97113A17DC42B9E4E87E95EB8162A@SJ2PR07MB9711.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LrNhurBTUKAFYIRJ"
Content-Disposition: inline
In-Reply-To: <SJ2PR07MB97113A17DC42B9E4E87E95EB8162A@SJ2PR07MB9711.namprd07.prod.outlook.com>
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


--LrNhurBTUKAFYIRJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 10, 2026 at 02:38:51PM +0000, Eric Schikschneit wrote:
> Hello Simon, Tom,
>=20
> 1. Tom -
> > And we should spell out that device tree can't set these any more in the
> > commit message, along with spelling out why we can't do that anymore
> > safely (why can't we?). Thanks.
> I would be happy to move the code comment into the commit message:
>  /* NOTE: This breaks u-boot ability to set board options via    *
>   * device tree, but guarantees specific known values..          *
>   * you wouldnt use an uninitialized variable would you??        */
> These settings could be set by device tree, but every fdtdec* function mu=
st
> set a valid value. If a user has something set differently than called ou=
t in the
> FSP_MR5 Integration Guide the board stability will be compromised. Many of
> these settings are co-dependant so we would need much more robust error
> checking. This task would not be trivial. By using the specific values ca=
lled out
> by the Integration guide we allow users to begin from a documented known
> good configuration. Maybe we could set all the values, and then check the
> device tree to see if the user specified a different value? If the device=
 tree does
> not call out a specific setting we would not want to just set it to zero =
for example
> as this can cause undefined behavior.

That would make a good commit message, thanks.

--=20
Tom

--LrNhurBTUKAFYIRJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaYtklgAKCRAr4qD1Cr/k
CoWaAQD0WsREJ8IdlykO5qjhi9kzATjfLdCpL2rjTZZ14hUGBgD/cqPpiaVeNE4P
Uj5xBetepKUINjio0XmkaSljMlk8OQk=
=b88m
-----END PGP SIGNATURE-----

--LrNhurBTUKAFYIRJ--
