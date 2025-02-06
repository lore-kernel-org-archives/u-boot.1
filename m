Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 605D0C02194
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 23:17:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7204780F06;
	Fri,  7 Feb 2025 00:17:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oxlFR/uu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 711DC80F18; Fri,  7 Feb 2025 00:17:18 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C890801DE
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 00:17:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-219f8263ae0so30361245ad.0
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 15:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738883833; x=1739488633; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RLV92nwHXm9Cu8Jyf9P4fQ26kzhIahjqT0KHxAF9J2w=;
 b=oxlFR/uu589jfFwe25YM/KL7bGbB+4cZ7HmkOFg8ojSIv6JZEvCq0T45ZQt5XKB9js
 yjDb6Vmm55vh4Bk/Kf49sYbdnHrUmIUzkY0QVybqmZ/DQZGkfRRQEHNOCTjTGA135WSu
 iQ/Yp+HZYflEXSrx8THUH33o/UlrpM0r+73hU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738883833; x=1739488633;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RLV92nwHXm9Cu8Jyf9P4fQ26kzhIahjqT0KHxAF9J2w=;
 b=wHbFj852PDi7r3tLJMFz1vHKWmquraBKO9vsjd8MiJxarNQN6qygxNlpMP+ZZCu1q+
 jgdD0EGCnWX9Sk+nLFklWdDIqopok+8tHee9BZT2YDe1SjhYHDJeQhSN3AQ0QsIzJpX9
 2oKsCII4c/JnYiAgnP5yj5rPuCodJyInmt+qQPBNWXdHqAim6/zgo9MNvhyjnox7P5Y6
 Ef7QJZEm2STDf5U4hCmEyOgLhYkF7Stmtod1xewszELZDliovfZ6KiSfpb5VBh6ZfOUn
 0LqqlJsZgwS/xFwv1jyAqf380lTexW82SvOqLdS+9EqYFA7+2Kpp0HN6OK3X07Gh4fth
 aosA==
X-Gm-Message-State: AOJu0Yw19xeD1BEaHkvUUeV1xiKAd5Wo2IUzL36RkdtN2blJwyCUAZ6G
 q73hZ3AgxNkCKlV8VdjxQw3gI2UtIuJPZg32Ofn72CZjlL6L1isviIb9SoE912c=
X-Gm-Gg: ASbGncvpORaaoRPVdv24RQwlwmSR6rvQkBMk/hFzAueBqMn35ivLEvAbYAp6lPuQvnI
 Wh6Tfw7Qr+TLhf6mSMOk0UKvtR6ARaE2u5NYa9Y+LQ/Rq11HnDj8SkdU17Ys0P9OO5o7ccSIjBI
 zVbEy2Rwd16wrEPwtUmigyPDB9Mb9WxEsR6RoRxyyNnIXi38hIKk++4WjVTI3C7/BYYoVxycCru
 p/OwXpA0EYa9uPMC3Ht/YRsPspiwAhd4RtmKWVQqd3osvP4bN23ZG7cfY8ZoafXEl7XNPgBuXI4
 fbAY84BS6kR2dOQ=
X-Google-Smtp-Source: AGHT+IEOatgi4tvbMHDGzu5HWInIZ9PNyqXLJ2AZE4E7eaUj0iP0WpruPap+IbWa+R8TxyBrkqzuPg==
X-Received: by 2002:a05:6a21:6e41:b0:1e1:a932:4a3f with SMTP id
 adf61e73a8af0-1ee03a23908mr1936905637.3.1738883833555; 
 Thu, 06 Feb 2025 15:17:13 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ad51af6a8a4sm1872596a12.51.2025.02.06.15.17.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 15:17:12 -0800 (PST)
Date: Thu, 6 Feb 2025 17:17:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 2/2] CI: Use different git-directories for concurrent
 runners
Message-ID: <20250206231710.GO1233568@bill-the-cat>
References: <20250206223858.64672-1-sjg@chromium.org>
 <20250206223858.64672-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sDmTgQEwHu3ReGlV"
Content-Disposition: inline
In-Reply-To: <20250206223858.64672-2-sjg@chromium.org>
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


--sDmTgQEwHu3ReGlV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 06, 2025 at 03:38:56PM -0700, Simon Glass wrote:

> When running multiple runners on the same machine, each git repo should
> be in its own place to avoid them interfering with either other.
>=20
> Link to docs:
>=20
> https://docs.gitlab.com/ee/ci/runners/configure_runners.html#custom-build=
-directories
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--sDmTgQEwHu3ReGlV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmelQvYACgkQFHw5/5Y0
tyx5BQv/RRNSy+j0ZepMrssynryzPqrFjtbVmg4tKa8Nhx8sqXsg8nX+1CTECmXf
xQzURaNuO5IS6KT70Uhz0IbeVxGkfWAtuTckXrydiXPP3wIUGsesLNDtLW0jcrja
X0AOl5dywuKnevKYuPc5cu24MKoiTFlzCDoDTfZBAqu6xClQoy5Fb0tizpdHXyi1
BO7hC3+zbkfVFmhjBXbqMEML/XFHr/VUtTFbdZptu5KVOLA4AcrIDXVNa0x48w81
99yoehwAQ+MtLud9LFxMXVe7a2J4Rb5jJFR2nm9KjYyLaR2/IB/IF8OWQ9IJJ8y4
OLjWTyVQBIKxuukmNm7ReBzZOkQ5llzHhOLlNOy6ZESTSSnTBg+cJd7IeBRjGkGe
x46eKnSe2hbXrMjFIoxRC0MtC606GighbV8O3Af79ErB2ioSs0r189GrdkZQe+3R
TWXohZx+TQwKN7WROQvCstPSYHLhiZq1SihI8XIduKaPNWf+iwSzDRuBjTlX6OFs
BQk3G1nd
=8PFP
-----END PGP SIGNATURE-----

--sDmTgQEwHu3ReGlV--
