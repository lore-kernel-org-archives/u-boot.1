Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF85C47DD3
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 16:11:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C666787D50;
	Fri, 19 Jan 2024 17:09:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QTrtxtMO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C24BD87D5C; Fri, 19 Jan 2024 17:09:26 +0100 (CET)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B363C87D51
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 17:09:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-3606f3f2f37so5311155ab.0
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 08:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705680563; x=1706285363; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JmRIe037xH0sYdsiKhwUbNkuCpyeLaXi0vr2sbXXQNQ=;
 b=QTrtxtMOuvXRTY6p7CHznfKETbGFwiX2DiuvOuf6DOV7i+a24WGBMRbXOYphG02EfH
 pyfeSgboGXFoRnGjzM8VMBQWGMGwpzF9S3/svVMVh3u+NCdOAYRD99D86rHAS1DmaOBD
 8hvAxWIlOmfrFXBjqDugKP5fiKIYiIGhGfPug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705680563; x=1706285363;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JmRIe037xH0sYdsiKhwUbNkuCpyeLaXi0vr2sbXXQNQ=;
 b=ReDJGcUwC0iTuvs01AoVuwuhSBGYGxItGmbsoHGQ0XPOafegeFipLAF72p1FRTTZOz
 +CjVT4DoFBG+uF4LVBLT3zBvxI4NGj7vrDv9EVcFgv/EqBGvpk2dxGSogFteGInKOJIn
 WPqlKs1hIhaEtxzMLkUpXtcbz9Xfq+NmnW4OW/J89/fcxcCkJDTNx2NqyJDTTVYh+nMF
 PdH756vcYWDqT4/u9AlbVSuc3GyCQAMWxDKiOSNAQUiVTUhZokfvVzBCH9uP1vcvP6As
 n8P4eu//Qx0EbkO4Kz6DL9gQdqucnTFWn56s6k/NZQG+R2lkzyibz4Z9XjEZolqg+TVX
 SLUg==
X-Gm-Message-State: AOJu0YyG8AjyDHQNM9nOVe7LIqsQ5iz5tMconysX3ZbVO69F2cKkQjiP
 BEJ+g01Z0+TtToqErUywPMSsEpR0j7mtpCmu/BrK6H/BWNbs4ui4ZbfS8+TsZiY=
X-Google-Smtp-Source: AGHT+IGxumf0uQ59NVs3mqXLYpoPJRSiP3muoF/83NP6Wgph2Sk5Igz5y5pnAopjFM0m1tr/6GHv6w==
X-Received: by 2002:a05:6e02:811:b0:361:8ea2:3d3e with SMTP id
 u17-20020a056e02081100b003618ea23d3emr47265ilm.42.1705680563422; 
 Fri, 19 Jan 2024 08:09:23 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 g83-20020a815256000000b005ff9b0ab578sm616611ywb.117.2024.01.19.08.09.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 08:09:23 -0800 (PST)
Date: Fri, 19 Jan 2024 11:09:21 -0500
From: Tom Rini <trini@konsulko.com>
To: Love Kumar <love.kumar@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, git@xilinx.com
Subject: Re: [PATCH] test/py: bootstage: Add test for bootstage command
Message-ID: <20240119160921.GZ12635@bill-the-cat>
References: <9cded17d99c96ea34004783662e6bd366dca9852.1704791383.git.love.kumar@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2w6/ViFIDlNXskJ6"
Content-Disposition: inline
In-Reply-To: <9cded17d99c96ea34004783662e6bd366dca9852.1704791383.git.love.kumar@amd.com>
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


--2w6/ViFIDlNXskJ6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 09, 2024 at 02:39:57PM +0530, Love Kumar wrote:

> Add test cases for bootstage command to print the bootstage report, to
> stash the data into memory and to unstash the data from memory.
>=20
> Signed-off-by: Love Kumar <love.kumar@amd.com>

Applied to u-boot/master, thanks!

--=20
Tom

--2w6/ViFIDlNXskJ6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWqnrEACgkQFHw5/5Y0
tyyTHwv+KNvCFOADjYhFMY4hCzqKzIk6idfUCLs6kAojMV3r2j2CmKTLdOAIQSPY
6JmFFBGM2Osr6KeIEWdBrS/03hdkPQwy4WT+Rd+LkEbrLADadf2IDG76iauOEifj
6FQPr+ZexJCBHOQs0CKFajYLEvDqbgTqg1Fjyf9cHutctOHCkxZV2i/G4+Ld0sOH
xNElyz8YE8CLCcaF4yhciaS9aAkkg7rACNhoitzMC9v15Ggkov8ItgLY3HRTrKn7
KlI97ktwy64OlQmhkDxqM9+IQ7Cxrqvi6yX9ttpp8F25Tw2blHM4i/ip/1Qe2/yf
8skkNAHTqX64NZyekvCgb4W7G8cNoJrP1X46HCwLRbJ8YMpKTVsXcEslNzvFlDnr
SlFTCftur+TCHcKnuPt5zLlrTkPRb76zw3tNScQMvJviNHLbMngGooXnYkXzJJwB
tpssZwD1jiXcLbnvdaaqbxxzLD88Bo39GY6OIEsMHD/JZ6JdICt9y49a6oJyKLUc
x0CHs1VK
=GQ6u
-----END PGP SIGNATURE-----

--2w6/ViFIDlNXskJ6--
