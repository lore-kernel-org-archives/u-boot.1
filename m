Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0158C87FD3
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 19:21:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B40D38433B;
	Wed,  6 Aug 2025 21:21:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UYW5GKrH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E98384371; Wed,  6 Aug 2025 21:21:14 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F09C7842C7
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 21:21:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-879c737bc03so7543439f.0
 for <u-boot@lists.denx.de>; Wed, 06 Aug 2025 12:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754508067; x=1755112867; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wXA6WF4xxMyW4LQ9M2EhNDpkkqDOAt+2Ldy0auEctBA=;
 b=UYW5GKrH4JQunqJC7o2UCGm5DBY4nASc7DjJEfpuZIyctjaLU1gOL9kdyqifYD8lX3
 58VOTepC6XCFuRLIemjJfNsFEKCVPZGF40ee3K3/keSmR2aN+SnVt0uByIr/9YTNu6/+
 jdWKzSlaK8WXkIOTotz8jq8w/me1npI1+hCBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754508067; x=1755112867;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wXA6WF4xxMyW4LQ9M2EhNDpkkqDOAt+2Ldy0auEctBA=;
 b=TwZLQNj1DFhJRfTzCeWmKFBC3HO20m5xUc3HgKbXAWfplGy1XKRBNx5hZyM4gHalVH
 DNmWlOvdj8GR4MpDhrPDQ41ooBreGW0s1bEn0o2vP7K+ORlcOs3FIixqL27DPUNQF2//
 kCw5Vpyv8lXyflrCq95jX93QXewrZx/iyAuEzUT/ABj1RB30AO04VsSYnLXv3p2CGWbK
 7pE+oah+TgQcKM/1O0UabQbPAxy0Fathjx1bsS51/XdLgwQ1Cc2+KVFYkrMUl4uufvd+
 5nAA6WaStQcouhE6KlO6xG4/uD5A0PpbQBbwZAxgws9BwMPvLvysmpOQc5TL5BapERXG
 DG/A==
X-Gm-Message-State: AOJu0Ywhhp9/Ng2ZhFmfWPREqYind3PxAtrAnuC/6bdBXZ9Jduiy/Ajq
 +FLksPuT+TB+rmbUCAcH0A9UD9asY0+lh56ph1IiaGWG54Q5tamGxEqi/QBzf8ViswQ=
X-Gm-Gg: ASbGncvS7r3qpx/aMIcXaSjkYjRw0PuYE4pIvrZOsS7itW+irApphS7CteYI30F3pCM
 oKG3ZBQfFOLyXUbwdTM2ldKNfPUjNe6HNI73cKwLV2Ft+1uP6w7oUAjBvW4yfrYdfcT4YLBWn9J
 zAy4dUQyxJr1xk5LSuhbvkZDKaAVBC8oqw898WqwjSflfSR5hR4iXmek8zQ7PGnhetBLUEw2QT2
 hV+m7I0IF1A2mFyw741RRv6j40bBgZ2ZLP3aKvhv3d6phPir5kOGR9uaxOmr93d0uC7ELzUu9Bw
 uFvCqruP5DjYlw9UhbAunN6qbsTnXnRsN4AYDsOm6Zu+OymmWSWTI8MQPy44hzSGSBGNEVCBJSQ
 Y7p2eX+MMNdEu9Nc0YjtA2d4bEd+/2V+z6b7I9icXC2y3G7achPSvV/ky
X-Google-Smtp-Source: AGHT+IEZPSNMW/Ru8LAmW74+cP7PVHDuGrsi+/GrVkXPWTAotqk3/0M1qHDvT9QT+R7lsBGXX47Kjg==
X-Received: by 2002:a05:6602:26d5:b0:87c:5142:3950 with SMTP id
 ca18e2360f4ac-8819f2fbd1amr710678439f.5.1754508067441; 
 Wed, 06 Aug 2025 12:21:07 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-88176d6d8a6sm304828939f.12.2025.08.06.12.21.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 12:21:06 -0700 (PDT)
Date: Wed, 6 Aug 2025 13:21:03 -0600
From: Tom Rini <trini@konsulko.com>
To: rama <ramatrinanda@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: Request for Clarification Regarding CVE-2025-45512 Affecting
 U-Boot v1.1.3
Message-ID: <20250806192103.GT124814@bill-the-cat>
References: <CALvkNmjby-kU5Ee=ZmP0FAUxYeUkHKbeXYo=6b3_9oC7Loft6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LSOeitLVCIw2NKwI"
Content-Disposition: inline
In-Reply-To: <CALvkNmjby-kU5Ee=ZmP0FAUxYeUkHKbeXYo=6b3_9oC7Loft6w@mail.gmail.com>
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


--LSOeitLVCIw2NKwI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 06, 2025 at 07:35:40AM +0700, rama wrote:
> Dear DENX Team,
>=20
> I hope this message finds you well.
>=20
> I am writing to seek clarification regarding a recent CVE entry =E2=80=94
> **CVE-2025-45512** =E2=80=94 which claims a security issue in U-Boot vers=
ion
> v1.1.3, stating that it allows loading and executing arbitrary firmware
> images without verifying cryptographic signatures.
>=20
> As far as I understand, U-Boot (especially older versions like v1.1.3) do=
es
> not perform any image signature verification by design unless specifically
> configured to do so with FIT signatures or integrated into a secure boot
> chain.
>=20
> Given this, I would like to ask:
>=20
> 1. Is CVE-2025-45512 (https://www.cve.org/CVERecord?id=3DCVE-2025-45512) =
an
> officially acknowledged vulnerability by DENX or the U-Boot project?

No, it is not known or acknowledged and as far as I know was never
reported.

> 2. Do you consider the described behavior to be a vulnerability, or rather
> a default characteristic of early U-Boot versions?
> 3. Has this issue been addressed or mitigated in later U-Boot versions
> (e.g., with FIT signature and RSA verification support)?
> 4. Are there any recommended mitigations for users still using legacy
> versions like v1.1.3?
>=20
> Understanding your stance would greatly help clarify the scope and risk
> associated with this CVE.
>=20
> Thank you for your time and for your continued work on U-Boot.

U-Boot v1.1.3 was released in 2005. I feel like that in and of itself
should be enough of a "Don't do that for production".

--=20
Tom

--LSOeitLVCIw2NKwI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaJOrHAAKCRAr4qD1Cr/k
CryCAQDvgsT47N9zzGsOFbdLAy8N/QpQ5iDvyvOEuTZLwvkTmwEA30HU/nQ5qHO0
xzdVmQXaANEI4j2LZPoWcnhI+coNjwo=
=5Ngu
-----END PGP SIGNATURE-----

--LSOeitLVCIw2NKwI--
