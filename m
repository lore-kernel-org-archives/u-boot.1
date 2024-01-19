Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92789C47DD3
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 17:03:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF04C87D75;
	Fri, 19 Jan 2024 18:03:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="re4LimWG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DAFA87CC8; Fri, 19 Jan 2024 18:03:25 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74C5687D28
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 18:03:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-5ff7ec8772dso9161477b3.0
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 09:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705683800; x=1706288600; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dKfQq/ojULsfwQGN6WLy5mEom/mJF69S+0A5/RdAoXs=;
 b=re4LimWG/4WfkN3I470oleZYnWpZDtulNU/eKxZDYB2tlhjI3Eoua0mVmbQBdHkAIv
 igEjy9XREOW2S70wY1jY3nXQNRk+hunqlWRJ8CsVea1XTWpNUdBz2JcpmXlDg16n+vaJ
 p6zohQ9t26UMx831LSsGlcOAZZFcyiykYkh80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705683800; x=1706288600;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dKfQq/ojULsfwQGN6WLy5mEom/mJF69S+0A5/RdAoXs=;
 b=uBGGCs6Yyy3tvsc0QaOOWTlIqLlplcPqO2wmNbKVnPt5Hha822Mo1xwd6WXjjjAuct
 T3llrcz839R77YFK5Slrw2gpXgMpqoGRXJj5Ulowfn02IUx8EHInqqyF7JyWVRv0/VKj
 GeLn6AJTaPfUcKH18/N0pT4Dj5BuvGh5OyxsK5P8S6476MOgOJJeidt8WvL/pX/GQn6H
 jdbtpTtaELqPxo33rWBqnv/awL7gtn5F/LpNljVtuGCCy/YAJx2GN6v312NMWKNe8yhy
 mT++zWsEpoItkTIFvd03CLUM7CEkKHcK8eJmkOLD6FRaFfRPerwITFtFwp5aREbfYXbV
 mbBw==
X-Gm-Message-State: AOJu0YysRrSuVI3qweXn7Cgd6ri9dGQQ5rh4WDy5PJouUtTt7xcArne6
 ddnmxYE0ACTPuLZwba2Iipf4ha5oiKmkEOkPf/qJRs8OlEmrVwnzTQUYJ5Xbf9U=
X-Google-Smtp-Source: AGHT+IGdFDx7k+gfsp3PQ9rba6JvzzoprKMaAgtthVptwxy5iYxeM4h8CuRy3LTthJQZhGfcMLWAAA==
X-Received: by 2002:a0d:d44b:0:b0:5f0:618b:c292 with SMTP id
 w72-20020a0dd44b000000b005f0618bc292mr187669ywd.66.1705683800218; 
 Fri, 19 Jan 2024 09:03:20 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 x2-20020a817c02000000b005ffaa3ed258sm17154ywc.128.2024.01.19.09.03.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 09:03:19 -0800 (PST)
Date: Fri, 19 Jan 2024 12:03:17 -0500
From: Tom Rini <trini@konsulko.com>
To: max.oss.09@gmail.com
Cc: u-boot@lists.denx.de, Max Krummenacher <max.krummenacher@toradex.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Jonas Karlman <jonas@kwiboo.se>, Josua Mayer <josua@solid-run.com>,
 Kever Yang <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>, Nishanth Menon <nm@ti.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: Re: [PATCH] headers: don't depend on errno.h being available
Message-ID: <20240119170317.GM12635@bill-the-cat>
References: <20240118181106.4133924-1-max.oss.09@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lahyII0o65wlstQF"
Content-Disposition: inline
In-Reply-To: <20240118181106.4133924-1-max.oss.09@gmail.com>
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


--lahyII0o65wlstQF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 07:10:47PM +0100, max.oss.09@gmail.com wrote:

> From: Max Krummenacher <max.krummenacher@toradex.com>
>=20
> These headers follow the pattern:
>=20
> | #if CONFIG_IS_ENABLED(FANCY_FEATURE)
> |   void foo(void);
> | #else
> |   static inline void foo(void) { return -ENOSYS; }
> | #endif
>=20
> In the #else path ENOSYS is used, however linux/errno.h is not included.
> If errno.h has not been included already the compiler errors out even
> if the inline function is not referenced.
>=20
> Make those headers self contained.
>=20
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--lahyII0o65wlstQF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWqq1IACgkQFHw5/5Y0
tyw09gwAnuo1IHGeIJOWKOSV9KrpGtFyfAqBdLRo9D/r2QiwSeNCDM6T25e1G97s
sDWZGcIjZrPYUE+s0lnqiRhAuj/0zjYuEY56vI5M50Z6vPLyqCV8HH8fIJ9F2SuT
kC+eZqLtXaP9uN/hGPzjTQqBqU0zQmC+FwdqmumcegK9N3bbuaPooNDxTMpGvCsZ
ohd2IKQusCqYgWeeIRMBUVmWl+Kfjm9rIYmTz9Q5QV1F3a5spUjvGyWG5QDLIQc4
7zKyQPP0S1YYxZ7tKyAVP9RtWdhS/ax7fYA+2nPG/tAOT4MnZPnA0oK6huBqVxGL
xDxXyizg0iJuFyyeDOtPvCP9ihBMQGsT+DMYR1HnpepzxTuJmlgJSkUhj37/WdgL
ruwVCKginB1q4CXrla/9E8NttOmT2Ojjqr0ckqFYmYIIxzlDWd+7pVPAwuOEqMtI
VJk6BoM6UdME+opicUrlH91Lqsbz+0uQg7KU8t5QwZBxvLg0+YkQ1o/0ZvBEi4xJ
+M9LeRNS
=ILZq
-----END PGP SIGNATURE-----

--lahyII0o65wlstQF--
