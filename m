Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2542C2BB3F
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 22:38:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B82F87206;
	Wed, 15 Nov 2023 23:37:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="D7bB1GzB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 029DA8747E; Wed, 15 Nov 2023 23:37:39 +0100 (CET)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09061869F7
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 23:37:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-777745f1541so7807385a.0
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 14:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700087856; x=1700692656; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LqEHpVRR5ymLVx8VNeZpZdEtAXL51C1YqYG17/4dM20=;
 b=D7bB1GzBWXqsPuGF3+/s1Db3BB8DK6vCmg50JJqjdHvuigMVIY0t9SoEyHBMnUf7HZ
 hT2NXJmYd4rouPYJ1uz1Oe9xMQ7bmJxXXWWCPd1L5kJkbbsaNuLJowMmNSWDmDC66Z1Z
 qbgwQyiNwKRmMbBkC2/B2rjnC5TQ820ucW7xc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700087856; x=1700692656;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LqEHpVRR5ymLVx8VNeZpZdEtAXL51C1YqYG17/4dM20=;
 b=RhJG00UmcqgJ+maKfRKLxOJqAlkhCR8lLix2iBfCZYScbjCaBfA67MSZy7wPj9dLly
 LkeA3nuXj/NPDsE1Pn1EUUtUZ0w2Aibqm1Fz5Ms7rhLnQYDyf8do8m85PObsuaCwf4sa
 yfzcLaE3AQj5i0Dr53nrVQLM0sUQxad7FlSjdCpaio2739rdM8MPSNCdFOmtUss0V0D+
 Tmb27hCc00FkUASSqpXUlQ6Y7Uig+kVZay/Z/og1CCdMRz6OVvXM6rIRUOXDBwmT6QVa
 jG1/L/PQUFHrMU9yB536oRzJ8f4x7grJOhwL+4OxSZc/jSRCCpbt7lecOiyWFZg7Lvck
 gsQA==
X-Gm-Message-State: AOJu0Yy2ZPEzqzY24LFCoQhJylHET5yC6KVW1fcjmcuvqW6ILgdTZPme
 1hhlQpaFaPP/48/PXDkaAdkwpfEv5kLFAMCPIGebRg==
X-Google-Smtp-Source: AGHT+IE3A0et8l1PXLCe30fLUhPzAFsxZGo2QMyuvTK5jdC6Ok//YVNdetges7n41qB+Tm/rh/tk+w==
X-Received: by 2002:a05:620a:d8b:b0:778:af06:640e with SMTP id
 q11-20020a05620a0d8b00b00778af06640emr9013484qkl.16.1700087855849; 
 Wed, 15 Nov 2023 14:37:35 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6602-bbee-fb68-4a56.res6.spectrum.com.
 [2603:6081:7b00:6400:6602:bbee:fb68:4a56])
 by smtp.gmail.com with ESMTPSA id
 rf2-20020a05620a8e8200b00763b94432ebsm3820644qkn.18.2023.11.15.14.37.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 14:37:35 -0800 (PST)
Date: Wed, 15 Nov 2023 17:37:33 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>, Sean Anderson <sean.anderson@seco.com>
Subject: Re: [PATCH 21/29] bootm: Reduce arguments to boot_get_fdt()
Message-ID: <20231115223733.GA6601@bill-the-cat>
References: <20231112000923.73568-1-sjg@chromium.org>
 <20231112000923.73568-22-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="on92qcic9l6OlZ8q"
Content-Disposition: inline
In-Reply-To: <20231112000923.73568-22-sjg@chromium.org>
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


--on92qcic9l6OlZ8q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 11, 2023 at 05:09:06PM -0700, Simon Glass wrote:

> This function only uses one argument from bootm (argv[2]) so pass it in
> directly.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--on92qcic9l6OlZ8q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVVSC0ACgkQFHw5/5Y0
tyy6uAwAmM/9gPSQWu/XniodPNp+x1jrNJ1M63P+447n3ySeupnKR/CNIT+hpmD+
pmvPVoEWV0bdp2E6qN5UrwvjMKoelHoH+Mv+dQZEc3TMn3O/8j2Tc/TQ7UwoOMi2
jt7tikzMy+IR+nAcTBAZ0hUU6ESmrhMkkZ8PBdImI5gx4cNGOlFWEfI6F+yjkgqx
2JRkH1LyGFYf2Xhma3rN9TPG8IThkHmfW7mQgkBpFCflBNfCWIT9klUDsnuHHclG
fAjUUNjfmSgFgCj4mYpA8s7UQL4+h2fceMrgcee0dY52ZmS239Yq7l1UtYXpmE1q
p384eHWNPBLg2D35UMgpnK+Yc3VCaOdC/op/S3oPf7pNWmQMf8FKK/gS66nVDDX2
1IMRHN2qSFAQGClwA+fihbTGXWSKdh9KiTmHy2apiIlm8ayktIE40zkYXhyyCv1F
VNmXwCA3kDMEI5OR5LSfnZHFu1MbA/paZEL55g420ZMJYlJ00JfwOmyS+BkcJoLf
peLYgCNF
=9DYj
-----END PGP SIGNATURE-----

--on92qcic9l6OlZ8q--
