Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16381C61D97
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 20:51:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F33008768F;
	Wed, 22 Nov 2023 21:50:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="s6A0W3yn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BFC487690; Wed, 22 Nov 2023 21:50:16 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72D648768E
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 21:50:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-5cb8440a23cso1879587b3.3
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 12:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700686213; x=1701291013; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ISm5klL5mS3eJ5DMQ4AvKTqOYCyeYNH0wmvI2ucf7gQ=;
 b=s6A0W3yn4PQIXxxvLmyo2v45CbjLzXIUc0lSGjyqawKHdQNxkmBkeSy9RrnvgBLXqI
 zOJheIbvKOp8/wldEKVZU+RCTswJpoDTzQCTlMb1VQa5AGPYY7YxlLBzYTFCiKynkrqO
 8pUp9MVs1t6Ep8yT4bSHLpqxixXBQVbpoM7xk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700686213; x=1701291013;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ISm5klL5mS3eJ5DMQ4AvKTqOYCyeYNH0wmvI2ucf7gQ=;
 b=Mifj6O4zdKNLC+GRzFpPJYtViC8p428ULea7LK5Jh325kvZmBqpYKXwbPIOikXpI73
 fU2IpE8Ajb60fUJteFMpQdh3/qwxS+57un0eFFMsHCnvTUyqP+ibO9jsT/0cus95dj5H
 B1BSs9aGw3A89cm7gbIbgmecDVaTgHz2LrjVUW43wb/yhF0yyBZzX2QMix/627n1fSw8
 rqA8Z3rVI0mUeSG8hKoxL+qvkHB4I3y8ikZofwIZILE4DUgQZfquiSWJOBcBhz3da9hs
 haNkVKisyewFjQAruej9DIUUBi4s833UlkW9eK2p5pFZCnmHeId2/X69qgEfJp4O5Ww/
 D/tw==
X-Gm-Message-State: AOJu0Yw5SVgAGP/i7LSqjrS7dXsnQOYml+6WakoXri05pkL56U6W+RzT
 UViCeOnHFsY+oTyN6utk1xmrsA==
X-Google-Smtp-Source: AGHT+IHn/ZseQzKboA7BgNmD+4okREaJ/EQmzXVKtwIyCedNpPHXc6xExl/APVTVwRWSkmz9/qRX0g==
X-Received: by 2002:a81:4a03:0:b0:5ca:11d3:4adb with SMTP id
 x3-20020a814a03000000b005ca11d34adbmr3611978ywa.38.1700686213219; 
 Wed, 22 Nov 2023 12:50:13 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-999e-39fe-b112-e0fa.res6.spectrum.com.
 [2603:6081:7b00:6400:999e:39fe:b112:e0fa])
 by smtp.gmail.com with ESMTPSA id
 u2-20020a0dd202000000b00576c727498dsm87889ywd.92.2023.11.22.12.50.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Nov 2023 12:50:12 -0800 (PST)
Date: Wed, 22 Nov 2023 15:50:10 -0500
From: Tom Rini <trini@konsulko.com>
To: Nishanth Menon <nm@ti.com>
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Bryan Brattlof <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Jai Luthra <j-luthra@ti.com>,
 u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sjoerd Simons <sjoerd@collabora.com>,
 Robert Nelson <robertcnelson@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Dhruva Gole <d-gole@ti.com>
Subject: Re: [PATCH V2 1/4] arm: dts: k3-am625*: Sync with kernel v6.7-rc1
Message-ID: <20231122205010.GL2513409@bill-the-cat>
References: <20231115032857.3071474-1-nm@ti.com>
 <20231115032857.3071474-2-nm@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="h5HDTCdS0Xh0fzDS"
Content-Disposition: inline
In-Reply-To: <20231115032857.3071474-2-nm@ti.com>
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


--h5HDTCdS0Xh0fzDS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2023 at 09:28:54PM -0600, Nishanth Menon wrote:

> Sync with kernel v6.7-rc1 and sync up the u-boot dts files accordingly.
>=20
> Tested-by: Dhruva Gole <d-gole@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>

For the series, applied to u-boot/next, thanks!

--=20
Tom

--h5HDTCdS0Xh0fzDS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVeaYIACgkQFHw5/5Y0
tyxC7wv/V2acUJZ3hCgr4FFwtCC0UN73UlaAB9pJmvO6QN+oyhISJ/OcJvHTKzt7
52lnHOQrAPz0+xu2xTHjJcm/XYRopotfHnrO0iNUpHoKkGv466FxXHGpHiZgxN34
CaAd+Qss/WJm9y7v9haLeRTT2wDxSyWqR3hCzSbQzS76bvnnLjOv6hFj4+/6j7c7
xnOXwtBkjt3Q3KVml2utYhtvqeWXMyCMvQfDeaPoDKLBjV/jtyvoyd78wccbxEBe
mKNQDhCyIu/BHVOOlNDrj9QqJuQWO+81e0uetkdUsw3L3sAeAJ3Xt8QInEZOuWIm
3AQ5tlzXe9Zyp1dQw0QnHmWSHQmclAc1RJ5bMrJaDgXIlZxCCGFGxAmuwxZtNA2q
7PRp0bX4h0lYV1voqdBE41m3pCifgAuJMHyhf7Z2TOuQ7his3q/vLq1ZXMs6g0iF
IgCz93PHx6JaaDG6n6fR2wjC+FkufGlxMFDBDWFKRSbf3y5vDVfOa1SxO1CqThhR
r5Y+zsBL
=OavR
-----END PGP SIGNATURE-----

--h5HDTCdS0Xh0fzDS--
