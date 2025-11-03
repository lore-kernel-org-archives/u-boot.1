Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 693DBCCFA06
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 15:17:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7156836D1;
	Mon,  3 Nov 2025 16:17:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="q1B9xt9a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 367C7838AE; Mon,  3 Nov 2025 16:17:22 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C45D80050
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 16:17:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7c52db2e41fso3427011a34.1
 for <u-boot@lists.denx.de>; Mon, 03 Nov 2025 07:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762183039; x=1762787839; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6ku1TNU7DUbiZ9il4oKBPOLaOg0iLSReWTIk/lcnygo=;
 b=q1B9xt9a6HZefxbD47FWX9Meop8TpA8PPI2XOCeGYkheUnrukB1ntoQLejTEOSFIN7
 gEWk/4E4dwuL4MhQVI9WYdiIgoHUn6bkBd12x4GwmWfF4d9iJuOpbep7lN80buIskZg6
 bRU/a0uDdlQF09mV4tRljofsWrYssc4fAWEEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762183039; x=1762787839;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6ku1TNU7DUbiZ9il4oKBPOLaOg0iLSReWTIk/lcnygo=;
 b=K/oTraNXev1ZdRD+hb+3HMUARxUrIiz/fURWPvaS30c0mZhcjLGm1GwIng+P9NrDm7
 81JAJ+g4jN3sGBw0vXHrCqkIErTv/2IN3wLgNyT0f1la0PrdE+otdE5LJ78mhu4b+TNx
 oz2eLdxP/8/h3OVthhA4ep6GgcQVAsXt1fJ4KJ4SkTVD1hS17gU9LHPfl1P4dof2ug0w
 4GqHC6m3LXanqEBo3SKVL5UV5hRcjzvoh1vBGf3vY9TnupMIW1mcXYaTWzwYjFN142z+
 Kk77BxEXyfvnYDPbpvT3tmawvLRY7HjC/4OewJczGSPFw9kiCyFQrsmn5iMl0qA07xhe
 RTVA==
X-Gm-Message-State: AOJu0YyIZMJ/LayEol56O8eZzE9uLSmp9jDUO/iBuuYp92Tb1EfqNYeA
 990DNC6pEzoifLZvMmObpwkfw2ux00ocUpMErRahZPu309aldicsQWEfyWbIcdJ8ioE=
X-Gm-Gg: ASbGncveSFUEhyZWSK0buiPBlXtNlDEiuG7uGaa1+ewZkPxDwtHK9HnB2+4fLgkYNRQ
 4KcM7VIPIi40XrNHtGynd/+pzOTqm+B1oouCieDe8s3OpPWNS6ugMzmyDb02WsBjRQI4UqzUKoo
 BkVnQwQ+adFbqtjbOOMUFELgT0EIK2vzH0f6T6zCRUl1vl5FQySoqJjFYigFk5mhzYD2TGmiktL
 ZLZKGJRw1QTe4cggpfWs2ho7ymEjEoku/BCXYFvyD4GBYk3MeaunseJxppMUehder2G6979RK76
 6lt1eVPVOqB4xCsQEFvV3LoFA4ek+Akk1fSOTw+sIrwU+QyzmfPlN4jWI35O2+3fPgDpXOI/IcQ
 eDdfQmRhWV0SDQuDVssiwpbRv61caxLag911Ar7TkvgK5LrJhFIxwvcOvYDfUjx/ObFEOan06Dd
 6S5uXhXgtN7AKsbCDDXUzfjqLJK7qzObD3J9+S8xVEZ4vpgx1HlQ==
X-Google-Smtp-Source: AGHT+IGHNUFzKWgVgYSUZ4ofIo7nNF7+nBE510jupdkKy9rH/Kat5YH60g2VOQhraSgkeaCe/LjENA==
X-Received: by 2002:a05:6808:301e:b0:44f:8f02:d5e7 with SMTP id
 5614622812f47-44f952854e6mr5004252b6e.13.1762183038581; 
 Mon, 03 Nov 2025 07:17:18 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-44fd849533fsm124438b6e.3.2025.11.03.07.17.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 07:17:17 -0800 (PST)
Date: Mon, 3 Nov 2025 09:17:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20251103151715.GM6688@bill-the-cat>
References: <20251011180636.GM298503@bill-the-cat>
 <ef6da754-8217-42ac-bde4-8752cbd3090d@iopsys.eu>
 <20251012190713.GB6113@bill-the-cat>
 <d0e51598-8786-4f4b-a62d-7c981bf186a2@iopsys.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LrxQ+Ubkc0RsIKuZ"
Content-Disposition: inline
In-Reply-To: <d0e51598-8786-4f4b-a62d-7c981bf186a2@iopsys.eu>
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


--LrxQ+Ubkc0RsIKuZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 01, 2025 at 09:32:35AM +0300, Mikhail Kshevetskiy wrote:
p
> Hello Tom,
>=20
> I just sent a fix for the issue in the my "coverity and 64-bit division
> fixes" series.
> If it's needed I can split the series and send patches separately.

Thanks, that series looks fine to me.

--=20
Tom

--LrxQ+Ubkc0RsIKuZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQjHdAAKCRAr4qD1Cr/k
CtT/AQDfrnA/MNEvr8WScdaIplKP8xrEMfacCwhnfqn+AEnOOQD/cNTqSrysMicn
XR1eXjdGu4/IB+LoYhQCcQ6oNOPq1Ac=
=hPIr
-----END PGP SIGNATURE-----

--LrxQ+Ubkc0RsIKuZ--
