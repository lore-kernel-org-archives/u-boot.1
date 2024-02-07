Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D22EDC4828F
	for <u-boot@archiver.kernel.org>; Wed,  7 Feb 2024 13:46:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1614878AA;
	Wed,  7 Feb 2024 14:46:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aN9gBvya";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9474871A7; Wed,  7 Feb 2024 14:46:09 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B71D287C8F
 for <u-boot@lists.denx.de>; Wed,  7 Feb 2024 14:46:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-60493e299b6so4465507b3.1
 for <u-boot@lists.denx.de>; Wed, 07 Feb 2024 05:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1707313565; x=1707918365; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EiaapCQMR/gFm/tF5pwDWKnGMeJEKfmWRcwl/i0FsNg=;
 b=aN9gBvyaijzhDFTw9zQJEgq2PgOLuq3Azk8iOBLjShBF7yWplBtYmXmCVu9XZlQN8n
 Qrexdm5mewvZX+Qyducrey3cwjplUlP4O+D9wE4eCfoSAyqPdu/+dyjxeIun/fJBYH7M
 l9zJMt5zom/Ia0+ZwCRZbwsRAw5zExx+tdxcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707313565; x=1707918365;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EiaapCQMR/gFm/tF5pwDWKnGMeJEKfmWRcwl/i0FsNg=;
 b=Sj+LF/nKWACAQKv+XIi2kU7p53EeA6DO0vu+MJWLbKJUBTg8s9Fv6m/OmV8CeKWmTV
 vnOZCIDTQnK0F696vCOnf7pbCv0iL/teI52gV3n02/rn1mgMhSKee6A/ArP3fJQdktOq
 CIwr5qQB8NjARgSuKWTNKzP5suR5BIVCiJAmtcrU36Woslzd+lXdMjldsDinxPaUV18e
 ADx78+ToaqaB15HRc+QdHXD9eIdsipD1wIFe06qm/DnLL1SV7YfyDOgS59wsDH9+u9l5
 ANi2w+NYdp77VkPpjNoohvHS1TMTYz0fLx81C9wIbPSQCIlXy/aKKj+r0kEcQTQZq+7c
 BSOg==
X-Gm-Message-State: AOJu0YyGm+8utpnhAn2ltBd7leEXmYUKvSbseaQ7B8dKlcV0oBgKcStO
 1cy4BKZPJC09J5ox2LT3hbq8PYodYBNjEmh5AFelYd5JV2TqonMWWADHnvwX3No=
X-Google-Smtp-Source: AGHT+IEFJ7gUj6XcNz9VIIBprcBOVXNXM2kX1+cX+R0pZ/9bi6/kb3RjwSBUJC/TtqAloZjsfjgksg==
X-Received: by 2002:a81:b3c7:0:b0:603:bc00:b469 with SMTP id
 r190-20020a81b3c7000000b00603bc00b469mr5755049ywh.11.1707313565425; 
 Wed, 07 Feb 2024 05:46:05 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVYdhGROm/NASkeLPnK32mTozYOSEu/K2apdOVaWnUr8IJIkMC9PrzOe67sZ8+JdIi60LHf/kIc5Bbc8jxMAUH17YOBC2zLIqaa50EeSxvfyx4rMLcd6UA3qLCvtjjd485EMQtvBps0vLKafzUjiwq6olXFSq/YSlu259glQcT21UZtZpKUglZOLuerHKhwT9idtH10KQ7gFIhdvQln3wcvhjM6ZGs4Tn9e8/v4DiLjuEvW
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 fu5-20020a05690c368500b005ff8aafbf65sm258253ywb.9.2024.02.07.05.46.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Feb 2024 05:46:05 -0800 (PST)
Date: Wed, 7 Feb 2024 08:46:02 -0500
From: Tom Rini <trini@konsulko.com>
To: Manorit Chawdhry <m-chawdhry@ti.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de,
 Neha Malcom Francis <n-francis@ti.com>,
 Keerthy J <j-keerthy@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Aniket Limaye <a-limaye@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 00/10] Add AVS support for J721S2
Message-ID: <20240207134602.GU1152441@bill-the-cat>
References: <20240206-b4-upstream-j721s2-avs-v1-0-b75043c59969@ti.com>
 <20240206134549.GP1152441@bill-the-cat>
 <20240207100551.p3uvhlz577jmi2ho@uda0497581>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iuYO/yIchQ5Ulzp1"
Content-Disposition: inline
In-Reply-To: <20240207100551.p3uvhlz577jmi2ho@uda0497581>
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


--iuYO/yIchQ5Ulzp1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 07, 2024 at 03:35:51PM +0530, Manorit Chawdhry wrote:
> Hi Tom,
>=20
> On 08:45-20240206, Tom Rini wrote:
> > On Tue, Feb 06, 2024 at 05:51:07PM +0530, Manorit Chawdhry wrote:
> >=20
> > > This series does the DT sync with Linux 6.8-rc1 as that has the pmic
> > > nodes required for AVS support and then adds AVS Support for J721S2.
> > >=20
> > > AVS Test for J721S2: https://gist.github.com/manorit2001/d7690ded6ef6=
85aa8ffa5b16746cc529
> > > Boot Test results: https://gist.github.com/manorit2001/6775d721b3df5a=
690497d94d012b93c4
> > >=20
> > > Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> > > ---
> > > Manorit Chawdhry (10):
> > >       arm: dts: k3-j721s2*: Sync with 6.8-rc1
> > >       arm: dts: k3-am68*: Sync with 6.8-rc1
> >=20
> > The starting point for this series should be to build on top of Sumit's
> > OF_UPSTREAM series.
> >=20
>=20
> I see that series is still under discussion and not yet merged ( hoping
> am on the correct thread [0]). Do I have to rebase my commits on top of
> that and try or do you think that series is gonna take time?
>=20
> [0]:  https://lore.kernel.org/u-boot/20240206130040.GO1152441@bill-the-ca=
t/=20

Yes, you need to rebase on top of that series, just like how the am62p
support was posted. Thanks.

--=20
Tom

--iuYO/yIchQ5Ulzp1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXDiZcACgkQFHw5/5Y0
tyxP8QwAjlw2e8Io/O1sQJXjajtnFt51lOI2SewT/0Au9SXMrCB26my50Oajeupp
JboWa+4DFaUAd65MnSgjiHbxJrv6U6lmG/MhzMrWho1RxeWvAw4HWSJZ/m0AMzLs
Npooc/elBsWgIdluXQ1FJ/zUmEQDOj5jtC6eqyeTOd1ZzeSRvz7bN2b9GQ8xDxsS
qaMbcHEpNxtR9nlUfnzbINzEfKa/nCMhdKAtsE4oXkasgkzgnxtFbr9QAwVytvkt
CHy4gNgzw+C9bIbkyoSlSAqNF7GZD+OqVH7Mz42czaVHZ1DbyjIcfBLwW63xXF5A
5V2lTyiDcaI7ddNesSZdRLJLPNMgYAwBsNYTctYxlVwAyvsp3jiawzRuIJp2RUxR
Hr+BQYEBEWA/Bj4zIHvL3j86+/u9QX9ygwk5ciMLiPdmK/HgPAzQnZYSBl8sySGz
OCxdu31JR2h8T5IFjZLYfHmDXHL4jaVeKxADhBdNnL0xSQjsWlXB3HDuXpdVk2sf
BZz+OrI/
=hkow
-----END PGP SIGNATURE-----

--iuYO/yIchQ5Ulzp1--
