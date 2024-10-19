Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC44D3C908
	for <u-boot@archiver.kernel.org>; Sun, 20 Oct 2024 00:21:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B7C2890D1;
	Sun, 20 Oct 2024 02:20:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XRDocjNh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4FD988EDA; Sat, 19 Oct 2024 18:31:26 +0200 (CEST)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C94288D9F
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 18:31:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-46040dadedfso26907461cf.1
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 09:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729355483; x=1729960283; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Q8mVC9H1ARUVlruqj7Kr1VlnE4ePNn0dxcsFQy0CVns=;
 b=XRDocjNhZlSn8+cT1cR0VWOB0kwa/KMk3wk1Kz4Lxs9ugcsAzxHI7Um5c6TDL8aRaF
 AIQ3YxDiH2xOZC+p3IxJFcw6ifeMtLDaw74oiB6moyeP5lrHwcAt1tZkh4droJYPVKI0
 tHEjVzH60bTnCKCj2QDvUwT2pZXr0elAihTr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729355483; x=1729960283;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q8mVC9H1ARUVlruqj7Kr1VlnE4ePNn0dxcsFQy0CVns=;
 b=UiPu/TZhn/WbAPdey81Up5TN6a0fe6Eh9p8UrvMM0llkWtc5GyzgFyx7eCoXW4sUWo
 +MG8rYWkllADgfeeFYkuNt5K2ru6doaBUlO/6jOx1DW53Uf1zg8Z3lRCqqkd3W7AbnPe
 sSO5SBDQ3DtSNhzkPXLRVPD/Ep21VNzYT/VuCQHRSkJakZ/n1RdyAn8ed3K2Lrp74keF
 lO3wCq+7vBDgaS8w7Xgfh5MOcZJk518Fgl5EGVjZxgWo14bk2H9sVt12z5VDhCf0y2XF
 4M/MSloiwtxfWfYjvWAWX/vZVJIek4QwI55VTSRWvZbBt25FS+VQ/T+brIWdY/pU/8o7
 vnXA==
X-Gm-Message-State: AOJu0YxMAMrACR4e1A0sLmEDqpq0acdlMCV+QW6/8IvltruWbE7s3ene
 nH3ADJmfyv6KkGuNQ2xoTw9X7m6Jwh35wf/wsabNrnuujvQ1yIojO0+OJjGH3aA=
X-Google-Smtp-Source: AGHT+IHlVvOIWjCEBElAW7OBq5yGxbEFxwyx/5HWHJJwjfe7YfP1dvDxSK2Vbci2AE8p9dgfnFzenA==
X-Received: by 2002:a05:622a:3d3:b0:45b:5cec:41ed with SMTP id
 d75a77b69052e-460aecc6b34mr102408221cf.5.1729355483386; 
 Sat, 19 Oct 2024 09:31:23 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-460ae9482e4sm20624951cf.3.2024.10.19.09.31.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2024 09:31:22 -0700 (PDT)
Date: Sat, 19 Oct 2024 10:31:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Dragan Simic <dsimic@manjaro.org>, Eddie James <eajames@linux.ibm.com>,
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ion Agorria <ion@agorria.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Julien Masson <jmasson@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Marek Vasut <marex@denx.de>, Mark Kettenis <kettenis@openbsd.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>, Nam Cao <namcao@linutronix.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Pavel Herrmann <morpheus.ibis@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sean Edmond <seanedmond@microsoft.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Shantur Rathore <i@shantur.com>, Stefan Roese <sr@denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
 Tim Harvey <tharvey@gateworks.com>,
 Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, Tony Dinh <mibodhi@gmail.com>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>
Subject: Re: [PATCH v2 00/31] bootstd: Support recording images
Message-ID: <20241019163116.GV4959@bill-the-cat>
References: <20241019152211.1014896-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CRWsaumHNXZ4CUtY"
Content-Disposition: inline
In-Reply-To: <20241019152211.1014896-1-sjg@chromium.org>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Sun, 20 Oct 2024 02:20:58 +0200
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


--CRWsaumHNXZ4CUtY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 19, 2024 at 09:21:40AM -0600, Simon Glass wrote:
> This series provides a way to keep track of the images used in bootstd,

> including the type of each image.
>=20
> At present this is sort-of handled by struct bootflow but in quite an
> ad-hoc way. The structure has become quite large and is hard to query.
> Future work will be able to reduce its size.
>=20
> Ultimately the 'bootflow info' command may change to also show images as
> a list, but that is left for later, as this series is already fairly
> long. So for now, just introduce the concept and adjust bootstd to use
> it, with a simple command to list the images.
>=20
> This series includes various alist enhancements, to make use of this new
> data structure a little easier.
>=20
> Changes in v2:
> - Add an image type extension in bootflow.h

I really wish you hadn't posted v2 so quickly because this isn't what I
want to see happen and I'm not convinced that this is the right path
yet.

--=20
Tom

--CRWsaumHNXZ4CUtY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcT3tQACgkQFHw5/5Y0
tyzAkwv/Zr3zfP2CHl6SpcmKF0ou9r1Gsxcx3LAM/sP/+KEDwvCkppEzlb1uHLjL
ddOO38FmfDNMDFAIoWuDT8G0Up8o5FOy1fWDuM4c7WRwTHSW+5xp/1U/2kEJc/jq
Y8sZGYrYmD2zIp3eNj5NoFxe/MTF0BPfxD08bDCJo/7o7Mi9SgBv8b9Xo6uewiPA
+hOTF6GG0VJQ4tF7mViQuAfaDMgD/K1G12kSyh8YAA58SPKneUdZ0aG9ttFo0Ks+
pS1r28fFPD0pHqfTlpfjC7oRiySzQSqRnAhEv30wVMyHulpWLGl6ROmELeb1yjUH
tuqAYdTYo9TEV2EZ68PjipznCbjxDHorCRvoAL7RRTg0MLfVs7Asu8/CU1mbR2iW
GfgQLqergsE3p5635UAFrIHjPM8buOlZAPtxhuCUgH9/7jt8z+Jr3skIxttnziX6
fTmLsgbdrNqcY4onbNKCaShXGImHGKkCbASwhHmfKw1N8vC8pEGq4P3nwVWnyZzr
RDyi5bc3
=JegD
-----END PGP SIGNATURE-----

--CRWsaumHNXZ4CUtY--
