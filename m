Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E5FA105F7B6
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 15:17:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B36A884370;
	Fri, 13 Mar 2026 16:17:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XFw0c6WQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAFB684370; Fri, 13 Mar 2026 16:17:18 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1D528436C
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 16:17:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7d74aa6bcdbso1716990a34.2
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 08:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773415035; x=1774019835; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=F6Z1Tgz9086dkrBkQI8UYX28hS/9IpEDboZTf74ZKeE=;
 b=XFw0c6WQbOzDvoTHcxD5oYDVFTPCS6kmMQD0zzToYxWgmioIwpu6NVqOiIwCybdZjq
 MvqktxVB7Sr9nyr7ot3mYgxlfdkikWK1gdfiF+HhOq/aNrBZXyHjzOdAb8AlWO0cyrhK
 oIxB7dSfj3De1EANgdJBykj7u1F/wDXn+QZ60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773415035; x=1774019835;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F6Z1Tgz9086dkrBkQI8UYX28hS/9IpEDboZTf74ZKeE=;
 b=rz6vPO59fy5mhNt3peMP/YxO6mHdxMM5PXN5NtoblSx/jjd4+ttX5u6899WKbzK7S6
 Y8Jue24Wj6mfnjv0Hcly138MTsVW9smvPFG2WlMYFbcKCPPo1Sq/IbwKL+KMqivA2zfs
 LG9x8rMUUGgB7u0V9DJ2pEtIie853b/K+9kxzMTuThtb3muuCPDD0AVOQI/CxuMxK7WH
 hpRG3mUvuXnn2xJHHTCS82w3pP/gaYwc40YBSjDr07aC9JX1Pnc0/oPvhxreCG07A4VL
 abz63uJt0F7iAF8zCWS1Lyls0z/wbDJ2nqGji8MxZcnQwX1K57Zxp3E3BeEskh62q4X1
 l7cg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXo1/scG2QfqxK98+lujO9CIWLXageNSQNW8ZOeBThd2kKMzvoP2esykh+U0WoIztC94baElzo=@lists.denx.de
X-Gm-Message-State: AOJu0YyMwl+v4H0ifSb5cjZd2t8zb0CLa/pH+fU1fQMnMv1SE9tGm2Hd
 p8gw/MOy+wL9lETdb5cAYc+8Bi0/UBV89leZOw3cRxTkvhhAynx1Z9FMjcLaPt2Y+fg=
X-Gm-Gg: ATEYQzwN2GTwgOvIjt84l/xwq1qf6MJdQFVX07uo9naAtL/U0RttaRJRXhP2JsGv473
 vs447RbzeJMucetGtxMwOAB4ZEP6hEOfwOZPoxasRZ3qoEXQYyWOvbfNnLs2zxjJSk3saNRC9LX
 4dVDmI41q8mSNW5vYAV1vPtoKMzMPEMbqXKLoRm6HsK7bqkW+40trdq/i42l8/4VuUP0jnq/SBB
 77Q+NVSwGpEZ7Li4xm1LdSW5k+4vmv+//fJWSx+qy8Xt4+aX9g9joM4PDa8K7Zs3yl0Lqj9R4YI
 nHMZtxSU7MkdPt6i+7Oop7NwSeMFBZFx8HYvvcLvWZYDe3ko7Ezr2bGguz91zYijM6odsBHP/2N
 ryCVuHprclVnnisVSevx+20R3SE5xr0PIA0gSF3kmJu/mXDK83plLFLdyJU0rDnoTVQ1wXnn6Et
 LgavkcDs3eF0OOZMXKyr7F0+SQ+0NBWVXpigZ6f2SdxoyH0xCoHpvK5kceVlXRJ0KalCRNl3Anh
 /HTHajFlYFVJUZ8CnvR6gQmHi8d7E+Klee3sJ5jJAWXBC3f
X-Received: by 2002:a05:6830:7309:b0:7d1:90d6:403 with SMTP id
 46e09a7af769-7d7824af451mr2370929a34.16.1773415034971; 
 Fri, 13 Mar 2026 08:17:14 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76ac8e5b4sm6712707a34.12.2026.03.13.08.17.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 08:17:14 -0700 (PDT)
Date: Fri, 13 Mar 2026 09:17:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Richard Genoud <richard.genoud@bootlin.com>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Joao Marcos Costa <joaomarcos.costa@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 7/7] MAINTAINERS: SQUASHFS: Add myself as co-maintainer
Message-ID: <20260313151712.GG502704@bill-the-cat>
References: <20260313104229.1555236-1-richard.genoud@bootlin.com>
 <20260313104229.1555236-8-richard.genoud@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0tzLJviAblm+wMrM"
Content-Disposition: inline
In-Reply-To: <20260313104229.1555236-8-richard.genoud@bootlin.com>
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


--0tzLJviAblm+wMrM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 11:42:29AM +0100, Richard Genoud wrote:

> I propose myself to maintain the squashfs files with Jo=E3o.
>=20
> Also, reorder patterns in alphabetical order.
>=20
> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--0tzLJviAblm+wMrM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCabQqeAAKCRAr4qD1Cr/k
ClV0AP9WRTPXexrsyBMotqHMKi694RwRotjPmafbQywOyfB3qQD+OLVsmrfPNBX7
8bzqUJd4wERXojEykdt/sUXJ1a7meAQ=
=XJN4
-----END PGP SIGNATURE-----

--0tzLJviAblm+wMrM--
