Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A7FD4922B
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 16:27:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A13FA8958A;
	Tue, 19 Nov 2024 17:27:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="L3PNYlIk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62D3B8958C; Tue, 19 Nov 2024 17:27:38 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22AF089589
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 17:27:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-6eeb741c26eso4986847b3.0
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 08:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732033655; x=1732638455; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vcEXe/oPpxbL+3mMksQ3rHz4LrSn01pYwf87hX8REmI=;
 b=L3PNYlIkE+d09AtHfJXA5WhY3zfcG4jubBlnrq67GC65l/oFpHum3jhvFPYafwFqSw
 To05alumCPj3V1SPv0xueWHt94yF79zXZAwwUXSkatVXYkewnrKIp6SBQb+LhGiF6XtF
 yJQU7LSjkDWkURcj4IFPrA+GlXZe97Bc+E9hk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732033655; x=1732638455;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vcEXe/oPpxbL+3mMksQ3rHz4LrSn01pYwf87hX8REmI=;
 b=vxW1PVpX9HiJhGI0GDjGfDpRe/DeGRxxvoCiZ6aQvLBD2Maw8pLWZGKkE0NFhFLjTL
 bW4pqLBjTDr45YK2F6sDNpYwBI4xlfSHxWTcPu4HOHsn6hLJ+d01GkpBAh6KTTu1Lia1
 qsgrMsEodXwWSy1bfjyLKlMDdGYWsQZtzlDM03aQEFIvW9nvgpNl4bqukgNQ2qDVsoYC
 2Mcj89SCgFAqawAPdLyNbHoTmEMHcBOl0ENkd7+4mzs1HzRX/081Sdja3Qpe1V1B0haL
 IO7chfiqeMQz2HmYJqCDi9t8NNq7GAO6R9dzoP/WBL1g8qNbQaiGU6DNP8XzoBH3/xp+
 T5tQ==
X-Gm-Message-State: AOJu0YxWX2a/wU3G69KsyqmZND0l2NnMahfrSVn6I1Rvi/+BsOpVnHHs
 PSLKhee5iddnIon6IDdHIzKVLlIfMwEcbr6eMihmeBCYI1ZM53E5bOQzxd5dMrA=
X-Google-Smtp-Source: AGHT+IHVpZAauad9NWxUgUixkTZAwkpSJru+BILdIA5hdz5p2GrL9MAULM/H+t2PCmYer4IOqOXKaQ==
X-Received: by 2002:a05:690c:9a83:b0:6e3:37a7:8a98 with SMTP id
 00721157ae682-6ee55a5d623mr185511337b3.14.1732033654952; 
 Tue, 19 Nov 2024 08:27:34 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d40dc1f1bfsm49625476d6.49.2024.11.19.08.27.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 08:27:34 -0800 (PST)
Date: Tue, 19 Nov 2024 10:27:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ion Agorria <ion@agorria.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Julien Masson <jmasson@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ramon Fried <rfried.dev@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>
Subject: Re: [PATCH 00/39] pxe: Support read_all() for extlinux and PXE
Message-ID: <20241119162730.GX3600562@bill-the-cat>
References: <20241119131844.4078144-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OAsf8OLKDJ8G4Zze"
Content-Disposition: inline
In-Reply-To: <20241119131844.4078144-1-sjg@chromium.org>
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


--OAsf8OLKDJ8G4Zze
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 06:18:05AM -0700, Simon Glass wrote:

> This series implements read_all() so that it is possible to read all the
> files relating to a bootflow, make adjustments and then boot.
>=20
> Unfortunately quite a few things stand in the way, so this series
> finishes off several pending items: zboot without CONFIG_CMDLINE,
> required support in pxe_utils and the differing code in the extlinux and
> PXE bootmeths. There is very little new code, but quite a lot of
> refactoring.
>=20
> The bootm, booti and bootz commands have all been refactored previously,
> so that they can operate without needing CONFIG_CMDLINE to be enabled.
> At the, time, zboot was left alone, since it is x86-specific and a bit
> more trouble.
>=20
> This series adds a programatic API for zboot and uses the forthcoming
> bootstd 'image list' to collect information from an extlinux file. It is
> therefore possible to parse the file, load the resulting images and then
> examine/adjust the resulting bootflow, before booting.
>=20
> The addition of options to extlinux resulted in the PXE and extlinux
> bootmeth having slightly different features. This is tidied up in this
> series, with common functions for both. This allows the same features
> (loading images as a separate step) to be provided for PXE.

This doesn't apply cleanly to -next and doesn't say what other series it
depends on.

--=20
Tom

--OAsf8OLKDJ8G4Zze
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc8vGoACgkQFHw5/5Y0
tyxGewv/UWVx+eXHxQNhEhe5gA24/rw33N52cP5scP6XhVtecUij2OBNuKvkoUig
PESG0L0R8wmGM5p/uNxb2kq+unOqK+E8O/8BDnosyiPeenHNCpUnDwrD7juvZpsS
E67p5ku4IrDA0aKOifzNc/COQT0IoYat7bVcWb2/inmV2KKmNpDhmrQ7bIrWbe9/
LN5IShWg2ydmHv1PKW0pMQRO7aBj3ctqZ1iX5Pbp7rXoRHger2rgXjdBfdS9y2rA
kAOP4nMcmA8bCY46gVzA0z12EbH9A0iMp5JhoyMxAvKczE1F4ZUrWrmovtOMGbDu
FA/M656kiTqKtSWQnCJ50q6dBb/sTRH2wawt5vf3iQ1VvCZFpT7k5tDqDRwzixmz
MUsclpPXqIUZ/HuJKa9LZ49GREq7E+GGnGIeFXWbtqeUa/1wjSv+KDFZShaniU6i
rQR0mssQ1UUHzmWobUM0JowG0GYVXczLMvk7Q2f3C5mCycRGd73/mCUchDgXMaZ5
JSo3iO68
=sz6Z
-----END PGP SIGNATURE-----

--OAsf8OLKDJ8G4Zze--
