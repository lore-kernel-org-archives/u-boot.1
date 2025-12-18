Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A338BD6D226
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 13:59:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C61EF83D07;
	Thu, 18 Dec 2025 14:59:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aoLr3/gE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1A6C83DEE; Thu, 18 Dec 2025 14:59:05 +0100 (CET)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2CEE8309A
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 14:58:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-65b3d3ac90fso203749eaf.1
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 05:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766066336; x=1766671136; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1aRHkdlYbGndCTz6Rk0xtRgaGoLRJm2pADeKwRXijuo=;
 b=aoLr3/gEsZ4XppKzPWlj4H819KeByghgqUMpw1FgiWD9KNGsyTrbu/d2G5i9oRa4n4
 J44QMr0ayx0D9TWwljAjgWq/QhPL7boOtKxYqBn8FeCbutu5B4H7PHXD16PCT1VcVTXo
 tVYB/LjSeKnl0zNydYy9UHikoqJTkUvSDkmT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766066336; x=1766671136;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1aRHkdlYbGndCTz6Rk0xtRgaGoLRJm2pADeKwRXijuo=;
 b=iGXJY6DvwCFurHrLm5vblQ3LQpleqPmG7VBkN7HQCONY4InuOlhmm/O6Pz3XYbvGVK
 CdbJcbDiLJPVH/USqufa5rJeaG4t48oO1JyBtMz/f1njbQuDEZgPI94N/U63lh3HZq7K
 YMkwTo89FvyGkOcx+4uvoX70Rj3GXwx1vCrDI3wsDJ2vKHF6xIDlDFsKJV5h3qgCfX3H
 BtyLHR7Z5fJg4LUD+MzdUXe6F0/JaaYXqACiescSHzy9/SZfeMPKKv59TH9qyJmcufwX
 h+3BMO8e6u6+6IvWe69l57Cphz+SQapbgxeDtLycXRI16dO3tpCBZPH9MFeUgMqZq7yk
 3RCA==
X-Gm-Message-State: AOJu0YzQY4rHXVVY9k/0/gZTcwKjhPB2/SH73InOHDvc2iG/y482h8ch
 6Wcmd1UHuKjZO5W/9V/nS1qiCo0d2wh5wWDX1irCer7CBTBzMxrMbsXFM2JkYDKNRMI=
X-Gm-Gg: AY/fxX5WcYgukUMIXIdE67X2YlHPXzGLEcw+z4GuNjmnHAadNLbMtF9tAywtP3H4M1o
 6t3yEN1i0jDF2YdZB+MAsHDTpIzITtAjYpADWfZ22vs/NB+9/4uUJdoWfU3/pACdOeOm+BMxpGG
 zL2ZoV2oD0hqJ9dr5oi37a08hLOuwUr53CjATchUdgsX30q7ucFxS9AabE0BX0Lo/NKchC6k1bF
 4sFFCA9FHNOBZ9OcaafaJwdR5F1h/22gUYIaGOoIqPmTzJiIye3mIYDcFMMPS8ABAfcEbn0+Fc6
 ErvuMHlcCwezwdq+GsjOLEmr1iZcQzP8xzNHR96YwqvTuFqbwYJGhakMJFlCxWPqQA6b04kVSSF
 aUPVWGb6j3rekPlgbbU1HtHR7oGVHbfhdTJAojKWOO2aW9wNvEwlcHfsH/6fqUIG9dhFsIM8Mis
 qNJLucyV3vj/xy36N0wjc0JEliGq+Ypg4s+URA+n+mKmX58F1ZyA==
X-Google-Smtp-Source: AGHT+IFmjs+hNLRnpWLuoOSXjUElZ6hrRrYJWt6U+Wv33lsPoxQstNzmai23s5q5m59u5RHJ0DizOA==
X-Received: by 2002:a05:6820:168b:b0:65d:b36:bdc2 with SMTP id
 006d021491bc7-65d0b36c30bmr165135eaf.36.1766066336344; 
 Thu, 18 Dec 2025 05:58:56 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3fa18024d96sm1669110fac.22.2025.12.18.05.58.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 05:58:55 -0800 (PST)
Date: Thu, 18 Dec 2025 07:58:53 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 3/3] env: Add single to redundant environment upgrade path
Message-ID: <20251218135853.GG303283@bill-the-cat>
References: <20251217201323.756419-1-marek.vasut+renesas@mailbox.org>
 <20251217201323.756419-3-marek.vasut+renesas@mailbox.org>
 <20251217205610.GF303283@bill-the-cat>
 <bdfbfcbc-74f3-4191-b4e9-b4de0e8cbd16@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KzCEyKzmGFLKBsAu"
Content-Disposition: inline
In-Reply-To: <bdfbfcbc-74f3-4191-b4e9-b4de0e8cbd16@mailbox.org>
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


--KzCEyKzmGFLKBsAu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 11:58:15PM +0100, Marek Vasut wrote:
> On 12/17/25 9:56 PM, Tom Rini wrote:
> > On Wed, Dec 17, 2025 at 09:12:33PM +0100, Marek Vasut wrote:
> >=20
> > > Add support for converting single-copy environment to redundant envir=
onment.
> > > In case CRC checks on both redundant environment copies fail, try one=
 more
> > > CRC check on the primary environment copy and treat it as single envi=
ronment.
> > > If that check does pass, rewrite the single-copy environment into red=
undant
> > > environment format, indicate the environment is valid, and import tha=
t as
> > > usual primary copy of redundant environment. Follow up 'env save' wil=
l then
> > > store two environment copies and the system will continue to operate =
as
> > > regular redundant environment system.
> > >=20
> > > Add test which validates this upgrade path. The test starts with spi.=
bin
> > > which is pre-populated as single-copy environment and then upgrades t=
hat
> > > environment to dual-copy environment.
> > >=20
> > > Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > > ---
> > > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > > Cc: Jerome Forissier <jerome.forissier@linaro.org>
> > > Cc: Simon Glass <sjg@chromium.org>
> > > Cc: Tom Rini <trini@konsulko.com>
> > > Cc: u-boot@lists.denx.de
> >=20
> > For merging, a cover letter makes things so much easier, please add one
> > for v2. And, I think this needs a Kconfig option. I'm sure you added
> > this because someone has a valid use case but it's going to grow too
> > many platforms where that feature isn't likely desired. Thanks.
> Do you actually observe growth ? Because this is calling existing functio=
ns,
> so the growth has to be in units of bytes tops.

A good question, I was assuming so but checking xilinx_versal_virt (a
platform with redundant env) shows yes, it does:
01: Merge patch series "fit: print conf node compatibles + use property str=
ing constants"
05: env: Add single to redundant environment upgrade path
   aarch64: (for 1/1 boards) all +96.0 text +96.0
            xilinx_versal_virt: all +96 text +96
               u-boot: add: 0/0, grow: 1/0 bytes: 84/0 (84)
                 function                                   old     new   d=
elta
                 env_check_redund                           316     400    =
 +84

--=20
Tom

--KzCEyKzmGFLKBsAu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaUQImgAKCRAr4qD1Cr/k
CkjCAP4rAuxZbphZmKnkqRvyiNItrw+mJz0OLu9+5iRsUij8mwD8CeXYzd95hfar
8zZ7A+ZBzL/RwT/lXF9EkbgE4RbJ/Qg=
=bKiF
-----END PGP SIGNATURE-----

--KzCEyKzmGFLKBsAu--
