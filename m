Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CD91D3DEA9
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 18:41:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D20C88B8F;
	Fri, 18 Oct 2024 20:41:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="A1D+GsP6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4295188C7B; Fri, 18 Oct 2024 20:41:17 +0200 (CEST)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5848889EF
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 20:41:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-4609d8874b1so15811441cf.3
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 11:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729276874; x=1729881674; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=emrAO7bZQyuoWYv3xkXDolRVoSgLINImpuFxOcA3SBI=;
 b=A1D+GsP64S5jqzEGYq9vYGC/mGMzRrsjrbSCKtiPpQ76FX9YylEJAme8aR1jgSfWKk
 m0b8MnRciT/PI2z+f8EZvj5Idu5ZIBn0L/YPFaeF/bMm8blXVDkh3yxMwzaT9Ln7e4I5
 ODWQeu/lub9knYWKIV8+0HIB3r5uJybK1n0kI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729276874; x=1729881674;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=emrAO7bZQyuoWYv3xkXDolRVoSgLINImpuFxOcA3SBI=;
 b=oqQwqLAPHKvMDTOXaSbkg212qGOWZs8IiKDPQtv2R6XSaboEmcm9IgXXmUklV0wNTg
 jfhnQXZFyI+j2nw74NsX677f/XQW0vJwOVWfffQvQ9Se3LuqK6WpdcjZlgBzdtXoKVwF
 +1f1u7NQ/RBHQTLEvnXSQpoGIRffTfl7Bia2l1D+F1xYj3Ee+bm5BHs0Ia2komaQriLn
 +4ZhEkOXK2f2AjhNiybhPk0VfznL1QB3pu+mWinVAGbehfoirieOwJVFNu0vnaAZKVpx
 3ETksx3oEUXLHNWbnx6TB7NfOKftwYRTxXfCKpN5ljTfRl09gtmoaPRi+bguirIhiubS
 ioxg==
X-Gm-Message-State: AOJu0YxDABo/1XBqYsc8NVnKkaq3Ng/dedrVuiEKYcDcKftpkqA0mne7
 n9SyeIluEqC2Ly6aK14LWFEhOFCiGzTklFgISAIStmn/wN4SXR5CaQmTWyPV7Y4=
X-Google-Smtp-Source: AGHT+IGYvTt7yeaRql3YJJ6i5YRN1GZ/Ov8PBoGgzSQO+QK3k0gJfmzbJ8dW9C3WnhFMINBAAHTb2g==
X-Received: by 2002:a05:622a:349:b0:45d:920e:ce86 with SMTP id
 d75a77b69052e-460aeb95fb2mr38769451cf.0.1729276873578; 
 Fri, 18 Oct 2024 11:41:13 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-460aea45271sm9541191cf.65.2024.10.18.11.41.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 11:41:12 -0700 (PDT)
Date: Fri, 18 Oct 2024 12:41:08 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Shantur Rathore <i@shantur.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>
Subject: Re: [PATCH 0/6] efi: Start to chip away at the EFI workaround
Message-ID: <20241018184108.GI4959@bill-the-cat>
References: <20241018145157.3918429-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yVGwUvgDmhkb/gXP"
Content-Disposition: inline
In-Reply-To: <20241018145157.3918429-1-sjg@chromium.org>
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


--yVGwUvgDmhkb/gXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 08:51:51AM -0600, Simon Glass wrote:

> At present there is a function, efi_set_bootdev(), which is used in
> various places to tell the EFI loader which device a file came from.
>=20
> With bootstd, this information is available in the bootflow.
>=20
> This little series provides a way for bootstd to provide the bootflow to
> the EFI loader, so that it is able to select the correct paths.
>=20
> For now only the EFI bootmeth is updated.

I think this takes things in the wrong direction. I'm going to link to
my post in another series now:
https://lore.kernel.org/u-boot/20241017232413.724808-1-sjg@chromium.org/T/#=
m6efe7c7fc4d453d18a4cf4331240454754d186e5
as I think we need to deal with this problem at a more common point
which will allow us to handle other enhancements as well, without
requiring changes in every possible path we could load something in, to
capture this information.

--=20
Tom

--yVGwUvgDmhkb/gXP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcSq8QACgkQFHw5/5Y0
tyxGcwwAkSjwftLSJtofAcYU/mWjEdjQQxt0AilII9VxLfX8Xq4eLJkNR/Hy+Ag3
HuEF8PCVUzf5KGQyms3OtUIcUcvBkrxktktQtA9F4RntEMh9g6+N1OnlJrh+Y7vC
xLSkPzlu5wMe+ZNadKr/vtjtkSEqQf5QPHI/zT6Ia43ARcWQ6PI1JWFJfJErIR19
4Nv8Z7VEH8gwvs8L26Ieaxn6gaX/v3ghxcSc6jqhhZQrUZ3wmoahBOprTyIBCsQj
SssNczzzd31/aA/7Z6oJDveggc7rGSDEitWnINP/nYf3dS3hpShI0vDJGsVelmMv
Wu/HQNgRnkeSap/orIChRUyUMynrHFFIQfb+t9I95MivalkOn5YpZPdxh1mxy5D0
0S7IiUCFasDnd4H9Rt37/Ngb/lioONnuz3DqNpmBrqlrgbYJqr19qsiUe/Ln+Hgw
wQxYrhedZ2/1UqYK7CgsepCEOxboVSN+fTqibeYYh5m2YQvKaEv3aDHjh1gBVIHD
Q7S1uI4q
=gCG9
-----END PGP SIGNATURE-----

--yVGwUvgDmhkb/gXP--
