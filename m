Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C34C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 17:45:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBB2387ADA;
	Tue, 31 Oct 2023 18:45:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="M/PVlXD+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0E0387AB2; Tue, 31 Oct 2023 18:45:49 +0100 (CET)
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com
 [IPv6:2607:f8b0:4864:20::a2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF3BC87A5E
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 18:45:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-vk1-xa2b.google.com with SMTP id
 71dfb90a1353d-49618e09f16so2337481e0c.2
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 10:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698774346; x=1699379146; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3ATo+OrF3FxS1Sc1Msv5TSRIqEysix6Zt77yxKYvrn8=;
 b=M/PVlXD+1UKN+qOoit8YKSr6pgc7XwdyOHanAYnbGNe8mKnCTVPb67r4cWJwqp9Ou6
 H4EFFLdfKzwOAhwaasN2qVvtCQdnCnEa3cAnmJiy7BFJF6IXeh4Syw9YTQ9D8QrVLLUN
 MElLp5S3xnTHPh8PGmTZr3kg3i7YOiakusjjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698774346; x=1699379146;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3ATo+OrF3FxS1Sc1Msv5TSRIqEysix6Zt77yxKYvrn8=;
 b=NsnNctspHeBTjJli5sy9cggrmocKeSp000QPBITTzCSqUU9OHWZX0PMQtjObD/Ngvj
 727+Pj9mmAPeQLCuXgZcie5Zcj2dPnnCWtbjejMEYnavToAAUskbo+Siky5DMl+Tndye
 9DJrMhiPfdy1gnxtEwIhClf5HjkdCKxI+S5tL+J65AQq3Lo5DAf+YTEAtPioVroDC1UQ
 tj0ePRy46o/jg925RIcBzDAkNWjVkIvMYk75b6GEw3MXy5aRuLKVbkcbVGsSbk7Qe4t0
 rwMi6z5WV/hlsasuYYMB74/+Vq/SrKfzCbJMFNBk1qkhF/yvhn6DVRxf9kKwFn9mFk/e
 wKdQ==
X-Gm-Message-State: AOJu0YzZ54cKBdqJOX2Nw4CJBpHshograb30KC5pIY6Jol5Klwfwtaxv
 xjyM7rVDMW7Mt0YQSyLvyY8ekA==
X-Google-Smtp-Source: AGHT+IGfjenpxgHL9h1kSEYxCWCyVgjoUGd2Orfa4NxJqzQ2WGd63GRGhXWNTAEVKqm4m+GkEaKlGg==
X-Received: by 2002:a1f:72c1:0:b0:495:d846:ebc0 with SMTP id
 n184-20020a1f72c1000000b00495d846ebc0mr12187876vkc.16.1698774346434; 
 Tue, 31 Oct 2023 10:45:46 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 kh3-20020a056214514300b00655d711180dsm722088qvb.17.2023.10.31.10.45.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 10:45:46 -0700 (PDT)
Date: Tue, 31 Oct 2023 13:45:44 -0400
From: Tom Rini <trini@konsulko.com>
To: Jim Liu <jim.t90615@gmail.com>
Cc: JJLIU0@nuvoton.com, YSCHU@nuvoton.com, KWLIU@nuvoton.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH v4 2/4] configs: npcm: Support more uart baud rate
Message-ID: <20231031174544.GP496310@bill-the-cat>
References: <20231023070225.3142578-1-JJLIU0@nuvoton.com>
 <20231023070225.3142578-3-JJLIU0@nuvoton.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kf76XBDNAygjHfQx"
Content-Disposition: inline
In-Reply-To: <20231023070225.3142578-3-JJLIU0@nuvoton.com>
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


--kf76XBDNAygjHfQx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 03:02:23PM +0800, Jim Liu wrote:

> Add uart baud rate table to arbel(npcm8xx) and poleg(npcm7xx)
>=20
> Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
>=20
> Changes for v2:
>    - Add commit message
> Changes for v3:
>    - Modify CONFIG_SYS_BAUDRATE_TABLE
> Changes for v4:
>    - No change

Applied to u-boot/master, thanks!

--=20
Tom

--kf76XBDNAygjHfQx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVBPUgACgkQFHw5/5Y0
tywK1Av/V0gwM/zT8xHUVvkGswZ7kRqkhj2Zjacuggwxa/Cqr+jIcPi/P6K1CmMM
93Geb8U3PaXRIhe57ETnmSf6YdtlH3X2OcJEhi8hnEbCwf/tU0HZH/nuHf/0TyET
+QQG0lq2LjxxeHWqYZeINTi0c0dZFMqCMEhpHd/OWa6wiDDCpXLy49Tdi+SbTVjB
ruU9Pt9WF5ylK9/Q72QwuL3wN8Z9jpCb4aPzUL/Dimk9+RF3mVUjUmokuF6UxAn5
abxOy1EepPRZT2ItCpG1tupLkap4Kmjox4lVH5b0wCXfVJQ/X6nPqUc4tAZAktz1
sKpJbeYMD2bTiewSrmBkEHNKwKI8BcKMw7oQgi04zCbspWa57kbPJ9UhEcKzh1l0
dtBFQjURdrgDQVVakYsfY1VFGWHO5GtWD0sNnS/j2l5IDvOZ8VHrq7pvc/kalxiq
kutE++cP/pq8nwom1Px7vHuSVtCU3l22L+mnDPwUTN0A2fPcpxhOiAlWfXG0G4KX
VW8QcWCr
=PPP+
-----END PGP SIGNATURE-----

--kf76XBDNAygjHfQx--
