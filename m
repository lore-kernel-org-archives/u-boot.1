Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 629C9C282EC
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 15:53:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7871810F4;
	Tue, 18 Mar 2025 16:53:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ppHcRBXG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C127581026; Tue, 18 Mar 2025 16:53:06 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C14E8198F
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 16:53:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-22438c356c8so102191305ad.1
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 08:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742313181; x=1742917981; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=B7oa5gNq/jZLPU6af3sO/gJvV8YzdOgeMfBBH+mAfRE=;
 b=ppHcRBXGzyYf8EGe504llAG+fnOmVwjsiiL5QOIwvHqsSdRMdL043K1KLg9KAsYaU+
 zaRDDPIy/qCLcTVJpu21fAmVw4EdM65VuVlqAuKOB1St1LmElGhvPiJDIjo9IO0RTTQW
 /CxlKBYhuxA7vSvSbAu9jb9ls3PH44K/xpiIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742313181; x=1742917981;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B7oa5gNq/jZLPU6af3sO/gJvV8YzdOgeMfBBH+mAfRE=;
 b=U/yi5YQWlJttUrQYEKWeI4UElOmUuDiUlA1kTryt1/2ijY64Bh7vDZuTTB29W3bs0x
 ml4N2kE3ngaQ4vlXuqZPpWEku3aRYxRmd+a+cSeC7tBfr23dAMYg7QPGoTaeKcCtMd+a
 02FPjZCnFg72eJ0dVqgW6tFF+0eBAu+RyhqSwMXlWOYF7lhL4RoyD8T3CMPBrvbuh8JD
 p4+bC7NLPsrUmOzMyf4vnF8Ct0R4U9FuxNT61VhpxwlFBIkzJrAUxd4jSxvc5y33h6ga
 b40x8ME9WVG2dNUjprvpZTYwSxPYim6otBX1++lyVDUvStXtMWyk8Kd6Qd3V2LEeXq7P
 ya/w==
X-Gm-Message-State: AOJu0YxX6S9ziR3A2CqyMNuLV/CtcqLDJQybGVSEvHITffFkaAklXsC7
 QftYb5alcqS2KyizO/6rKNc/Ge3/Ete+ySQ8Yn3Sjc/3gE5BHBKvoQMyEzK6cC4=
X-Gm-Gg: ASbGnctq7fMwXotwhhtfPk7jpiqbaggZ67ARgd0GxCdoEWuJVV2yXQoi+oSs5mF7ECw
 2qggoUxtfcIGMhQJgjWb522yqCvZZF6U8N6BFlZ0MEFVNcdC/ufOZ7mE3mcCAiPnt4HkIfMnvNN
 XOD+jcyQkRsCy2H3u8oP4j4pTFuqi6DJABX4aSfRB7t4TGBKbxWaJytOVMucTsM2Wpj+K22RIRq
 174vYqZIG+xZEHP6zsE6Zs9tsKGb1P95Yp/FqjTaLPKSzySsKoT1KFO/jHo5dz4ueZs7TS3I30T
 FPOhZ5KuaXktNnZQasYAgBK10cARFmWEsCbtb1UqshRBKw==
X-Google-Smtp-Source: AGHT+IGa/k6J4tfqfF3zbeuWKiHpyZSN+HnY8cJvMLF7yi25z1PA3yUU7h+TVHyJKP0kamK2tCB6zA==
X-Received: by 2002:a17:903:22c8:b0:220:faa2:c917 with SMTP id
 d9443c01a7336-225e0af8c73mr253458175ad.34.1742313180874; 
 Tue, 18 Mar 2025 08:53:00 -0700 (PDT)
Received: from bill-the-cat ([187.144.138.125])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c68aa62csm96621755ad.92.2025.03.18.08.52.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 08:53:00 -0700 (PDT)
Date: Tue, 18 Mar 2025 09:52:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>,
	Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, Julius Lehmann <lehmanju@devpi.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH v5 38/46] boot: Consider non-bootable partitions
Message-ID: <20250318155256.GA2640854@bill-the-cat>
References: <20250315142643.2600605-1-sjg@chromium.org>
 <20250315142643.2600605-39-sjg@chromium.org>
 <20250318140400.GX2640854@bill-the-cat>
 <CAFLszTgCZSydxeNoeVGrR9SF7-_9pZjU+NBGXVDgXG6WzYyCYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="svMT9tupSEWL2SI8"
Content-Disposition: inline
In-Reply-To: <CAFLszTgCZSydxeNoeVGrR9SF7-_9pZjU+NBGXVDgXG6WzYyCYA@mail.gmail.com>
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


--svMT9tupSEWL2SI8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 03:24:02PM +0000, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 18 Mar 2025 at 15:04, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sat, Mar 15, 2025 at 02:25:58PM +0000, Simon Glass wrote:
> >
> > > Any 'bootable' flag in a DOS partition causes boostd to only scan
> > > bootable partitions for that media. This can mean that extlinux.conf
> > > files on the root disk are missed.
> > >
> > > Put this logic behind a flag and update the documentation.
> > >
> > > For now, the flag is enabled, to preserve existing behaviour. Future
> > > work may provide a command (or some other mechanism) to control this.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> >
> > Isn't this backwards as the existing behavior (prior to bootstd) was to
> > scan and use these files, and so that's the behavior we need to preserve
> > by default.
>=20
> Not so far as I know, but I've already spent too much time trying to
> decode those scripts.
>=20
> If you look at scan_dev_for_boot_part, that is what I was trying to
> replicate with bootstd.

The feedback from the community call where this was brought up was that
it used to work and now didn't, I thought. Heinrich, I think you had one
of the cases here (something about RISC-V and multiple distros?) or am I
misremembering?

--=20
Tom

--svMT9tupSEWL2SI8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfZltUACgkQFHw5/5Y0
tyyxewv+LYJ+QgbKUqdjGzA3dMs6QXGmYEtliYlZq9iQexkN+X2auK0ptKQJBcmW
bwWdQ/qDhphFCFJiS1wdnb1zvHaO1L75dcZmxbQAHX8h6/E0Nhn8rPu7NEkDCwt5
15HmDonkOHWjqo1GALEgzTjn1nO6WSDFRZSwIXltj1ykOoWhkxQdxYdGDOWBRBUY
kzbQ200kMi7U5MFUCfHOOw+AxwasH16y2T2siFtyzpauNHhCL02P3yOFKttdBzv0
NUFW5ZZnDooBSbIdYpOYe+YMWS+FAIX6kobHON1ADP2I0KpMP05DhWMYnYQMD57H
RhT+lOoAZtxzaLpFqbKyCN2YUty6Fmxwidk5RKjYLhy+gQzTJ4lNnV4W5rJ7EyYs
Z9rQ/BRTFZOzkaGMkKCn1tBlBrvEVGHbXZag8ap9Y8QImO4ExcriyatdzfcUtXqN
pcUttTPLHCtJ3I0HNDy2BzWq7K8W+uX5gRAEQa+XNiyBKDk5XxuEsIBZ89jlgnMU
pJY49gz+
=TqGb
-----END PGP SIGNATURE-----

--svMT9tupSEWL2SI8--
