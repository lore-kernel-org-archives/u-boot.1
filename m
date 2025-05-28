Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E36AC3ABB2
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 16:54:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D74D83A1B;
	Wed, 28 May 2025 18:54:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="snhCvK1T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF677832A4; Wed, 28 May 2025 16:25:29 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 269688328D
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 16:25:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-735a8be4ea9so85538a34.0
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 07:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748442326; x=1749047126; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rSYy3JOnjlvPanwi3lqHexOXKUTQ/Go2whW10qTiO9w=;
 b=snhCvK1T43nhS4UWQYtQmUeqAhYn4xc1PVa2XO5N3ujVq6oOP5ypF2z3T6TA+vtC1L
 ZZFU/n61rznYDVDGtHQrT7ugxn2y9ppONXDx0wGgcbEV/MQ3rOWmxhSWTaD2u7A3//kK
 LZbsQg5F4z3E28Jxjp7cHqPWRl1ed5kNrZNOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748442326; x=1749047126;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rSYy3JOnjlvPanwi3lqHexOXKUTQ/Go2whW10qTiO9w=;
 b=D6SSS9xCoUMrRQDyCPqrswGqEwACnyibGey9wwDjgd+sNiOwQWzd1xCBzXz+kS0FUK
 bhm6XSe5LGNjBZze/FiKyO+Rj/TRTXucOemaGc+tke7stR+/YtMRWIB92eDZEzBbNd00
 7HwkorYYSeOswVXuRIDWBgw7KG3SxSnOCN64T9JUbzPqNthUIiISm7QGuVST8FtB/8Ti
 PVGDEn80ivU7UMISMntTqHQMuADZjCMeiEOz0zOIF0VlY5BNFAe3Bnm5B+e04BPKQ4sv
 0Hkt1tkYMG89PWz6f6w7m3eskYEH/qVXEa2Ly1pYuAjgcMnQbVDXqv7F8eFdV9SksS31
 cbRw==
X-Gm-Message-State: AOJu0YwoIfEX6BacEUMCf9tWaWTY19SlAiU14tM3Eue5hgl6BQWwK0z7
 Oj7n58V/QOhwq6RnX4tooaZVZanOmBno67wjNos+JrjyjbigOjYXvXyYVnNaDRFZVlw=
X-Gm-Gg: ASbGncvE5wlF4ZujW4145U9esg3OCy/kR6n75fefFUYZ9eqh01G3IIaU7zpyRo7O7Vt
 3yG1hQiaFBMqkJOCS0z7ZpRQ60o0oGlx2L7ScPHvLG+HVqbmGtZEfrvNIfW6Wz+mI+412ZPi+NA
 /9nO/NRNi3Qr7bbECKa4Hf2fPDTxuErqHYYepWAzleKKJbSn5saJ+jiZZCc2ki4o3h51BEOrq+1
 wF7Mulik7JXviqL8iSzViac5lAB0WJFJ21crEPCsJt7VgdLnH0JrBVlwp3VGHimrupaajEwSsI+
 uZeG62vOjwXFEUTz+p5dEgzWRWQxeiJRUMCAOezE+UGkiD5y9ViWxEhSlmop6WWMkTAh+UGs7hC
 eZ/vpYKX1h5wg
X-Google-Smtp-Source: AGHT+IHDmfyr/dRl+RQ3e60qohzQTRuBJtZ5OdJuNCC/AzPGkx9rlKpPCM5q7edkEcqz8yKJ5BNiVA==
X-Received: by 2002:a05:6808:6905:b0:3f8:eee4:7140 with SMTP id
 5614622812f47-40646802306mr9903336b6e.22.1748442325796; 
 Wed, 28 May 2025 07:25:25 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60bd9c35479sm194134eaf.24.2025.05.28.07.25.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 07:25:24 -0700 (PDT)
Date: Wed, 28 May 2025 08:25:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 =?iso-8859-1?Q?Fran=E7ois?= Ozog <francois.ozog@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bill Mills <bill.mills@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 Alexander Graf <agraf@csgraf.de>,
 Boyan Karatotev <boyan.karatotev@arm.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Fabio Estevam <festevam@gmail.com>,
 Harrison Mutai <harrison.mutai@arm.com>, Jonas Karlman <jonas@kwiboo.se>,
 Liviu Dudau <liviu.dudau@foss.arm.com>, Liya Huang <1425075683@qq.com>,
 Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 Marek =?iso-8859-1?Q?Moj=EDk?= <marek.mojik@nic.cz>,
 Marek Vasut <marex@denx.de>, Matthias Brugger <mbrugger@suse.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Sean Anderson <seanga2@gmail.com>, Stefan Roese <sr@denx.de>,
 Stefano Babic <sbabic@nabladev.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>,
 Xu Zhang <423756212@qq.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 00/25] passage: Define a standard for firmware data flow
Message-ID: <20250528142521.GW100073@bill-the-cat>
References: <20250528123236.1138632-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="s6I0JLWs7/f7a4tv"
Content-Disposition: inline
In-Reply-To: <20250528123236.1138632-1-sjg@chromium.org>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Wed, 28 May 2025 18:54:00 +0200
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


--s6I0JLWs7/f7a4tv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 06:32:02AM -0600, Simon Glass wrote:
>=20
> This series adds a standard way of passing information between different
> firmware phases. This already exists in U-Boot at a very basic level, in
> the form of a bloblist containing an spl_handoff structure, but the intent
> here is to define something useful across projects.
>=20
> The need for this is growing as firmware fragments into multiple binaries
> each with its own purpose. Without any run-time connection, we must rely
> on build-time settings which are brittle and painful to keep in sync.
>=20
> This feature is named 'standard passage' since the name is more unique
> than many others that could be chosen, it is a passage in the sense that
> information is flowing from one place to another and it is standard,
> because that is what we want to create.
>=20
> The implementation is mostly a pointer to a bloblist in a register, with
> an extra register to point to a devicetree, for more complex data. This
> should cover all cases (small memory footprint as well as complex data
> flow) and be easy enough to implement on all architectures.
>=20
> The emphasis is on enabling open communcation between binaries, not
> enabling passage of secret, undocumented data, although this is possible
> in a private environment.
>=20
> To try this out:
>=20
> $ ./scripts/build-qemu -a arm -rsx
>=20
> This will build and run QEMU for arm64 and you should see the standdard
> passage working:
>=20
>    Core:  49 devices, 13 uclasses, devicetree: passage
>=20
> This series is available at u-boot-dm/pass-working
>=20
> Changes in v5:
> - Add RFC for test script

And this is why I question if you are working in good faith. I've
rejected this countless times. I'm still rejecting it. Stop including
it. Point at the version you could easily be maintaining in the contrib
repository where you have write access and no one will be telling you to
not do something. People would even review the patches since it would be
against mainline.

--=20
Tom

--s6I0JLWs7/f7a4tv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmg3HNEACgkQFHw5/5Y0
tyzpzQv/QAvNLQIMwMNIoNlySjMBTRKDsdEucnkSGWEE4bSazKS8NUXsereQpKSG
5oDQe6KQNIuQLEUF+fcBDnvy8gaDfW6iKtrXku3jqrLIMRpgTWsulHlEqSjJ+2HS
GcUpeKSDwftsVs3L+c1HN/qXGbT7v1oBuSUPc0PBTviJ1ITjBblokyGvx/u/UWFr
G4um65qj/NgEjGREV8SCuoV9hA/L5QLjXrSe/nzz3WKLcTKt/el0FF0b3SRIageT
Us3WJYIwPLo3RJeQT/7n9gdmZn0Xs63mWgJqd3yUqvP/pmb9e8z+rHC+HMC3c/Ez
RqrjDxzswBhDNjGjPW0eogtJWagzOCXptoFesV3iGOVFgOc56g1WaHeXeMM8Eejx
j9Sll7c1HNoCBj52lihpcpsgPMmVus3Xdk+ePyJWLtqXPi8h20/mXY7Aontkp83X
ZPrnovhA5VTKit9aqPnH9+XRSkqsUJcy96zS6z0ZoN2ow38GRiY8f+RzPwIKSPnx
/JbMx5FE
=gcjb
-----END PGP SIGNATURE-----

--s6I0JLWs7/f7a4tv--
