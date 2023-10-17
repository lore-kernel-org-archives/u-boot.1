Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61768CDB474
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 13:32:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4024086F03;
	Tue, 17 Oct 2023 15:32:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LX6SSBNV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9506386F0D; Tue, 17 Oct 2023 15:32:39 +0200 (CEST)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17ACC86ECA
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 15:32:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5a7a80a96dbso57142217b3.0
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 06:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697549554; x=1698154354; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wSC6H/+t+nQhFnyc56tN7N+88DAFtOkwQDKcY2ZpGpU=;
 b=LX6SSBNVzIshddaw/4GvQG9pytr4umFjc8yrlgOqDD00IsGztlzTk8oGqttqtIIHe4
 UsPNiqPzypdgg6/PPPsJxdfBwRqr/+EJMjnyuD18HIceac6bOdim/4gJIma5QFYyc0kB
 kxU/tQ8SZ+BBrT7j/Xg01FtgZbit+VhSvMAzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697549554; x=1698154354;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wSC6H/+t+nQhFnyc56tN7N+88DAFtOkwQDKcY2ZpGpU=;
 b=fzmAcanKWnJK2W80dtb7xTyZWvu71xdMXxu1Ex7dvzUUgKLnhqKdfe1t9uFNhofQJv
 fJm5Ja98De2RMhgag4dZJOdW2SOa+cfaStECLnAt0d4r1TjBJCP8fxsv7yOJacOL4wVO
 BBoMkJB43FlLkT6eV7xDE6g4SvSXBSkbMBkRcEJqDgtUTF1NClEEFkj2RnYM5q9DGhMo
 VAZhxY0EaLhaL8p3r3+ynO73uIG1Qi6n2W+09N5+8dvcFbfong3RBNub0PQmpLCX2huI
 05wpCDTHH9GEa/5yNB2LfLz77U02cnkJhOCGmeSMtSHD0NfUx7ki+zETaA+3HoYksyxf
 EtCw==
X-Gm-Message-State: AOJu0Yw7QZRRfx9hjl8CIwKh+zR6kz5JWXJIILzp4KIInA0WIpAwvMlK
 KaIAD6tbmz5SgBv1qLnSITxVRg==
X-Google-Smtp-Source: AGHT+IEc/POMKe8szqyocgYqVDOPFvX4iVmbAVY6w7MTj1QiRFebfSbxA4gyQ48FUEj65l3u+LPnRw==
X-Received: by 2002:a81:9282:0:b0:5a7:ba3e:d1d1 with SMTP id
 j124-20020a819282000000b005a7ba3ed1d1mr1270718ywg.25.1697549553810; 
 Tue, 17 Oct 2023 06:32:33 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 t83-20020a0dea56000000b0059b547b167esm618762ywe.98.2023.10.17.06.32.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 06:32:33 -0700 (PDT)
Date: Tue, 17 Oct 2023 09:32:31 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 04/32] cmd: Add a few more dependencies on CMDLINE
Message-ID: <20231017133231.GT3119521@bill-the-cat>
References: <20231016222835.596572-1-sjg@chromium.org>
 <20231016222835.596572-5-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YMwsBkeensHYC3l1"
Content-Disposition: inline
In-Reply-To: <20231016222835.596572-5-sjg@chromium.org>
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


--YMwsBkeensHYC3l1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 04:27:55PM -0600, Simon Glass wrote:

> Add this to some more commands to avoid build errors with sandbox.
>=20
> Note that this is a temporary solution to expose more problems. A later
> patch puts these behind an 'if CMDLINE'
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

We're doing a bunch of churn here that I'd rather just get done at once,
make the current #27 which guards all commands with if CMDLINE happen
earlier in the series instead.

--=20
Tom

--YMwsBkeensHYC3l1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUujO8ACgkQFHw5/5Y0
tywVLgwAnv+LgFN7sz6alIk8rLtIy35ML7/Z0DsIfTpPDWyReymuJ5FnEEdULFlq
qZ0K+nXUUdeUYkSzN5YmUsGFJOeI8kXn1HXZ9ulz6abzarzzVAlynycq91LvVOol
fEKx+n3+bp6cw2bb3nOXgBIb/wmCvPdPE3boqj4LtutO6MKAQMRQ/9G43eyuDeOM
RxPJsWoYkAErRYnSqkxQs3OG9xnjmbY4nHVGvN0puAAacrAkFlsZ2sCHTWIXANWm
9hD6hh3SzTqk6w7By5lEmI3eHeP5kd2qShBwN8sHKe+7LlYwA5Ld+zhWG1BowMTu
qifQxRHD9tQkPvs6nRrry2ENbqJp4XHq4RTgzg/ktE9hOTaJssDfuhtsW+k2fraQ
lf4JoI3KRvnaWgNMwoXoBamVwxy/JSXVkh9tj4Ah+346zi+lLgbolLxQCsKv08+K
zm/vELZ6romnpUXsqsa6U4SC+l+QVpmiRIMkxK7bBDPLF8WJ43Cp9ho77+yyOVAQ
K1RaYzrZ
=ChW9
-----END PGP SIGNATURE-----

--YMwsBkeensHYC3l1--
