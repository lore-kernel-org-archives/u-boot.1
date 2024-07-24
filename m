Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E5AFC3DA63
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 20:55:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0EA88899B;
	Wed, 24 Jul 2024 22:55:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RlXebdY1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECE45889AA; Wed, 24 Jul 2024 22:55:48 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4A0A8899A
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 22:55:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3dab349467dso147194b6e.1
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 13:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721854545; x=1722459345; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NJhiQSHA9Ty9tU/Rjw77ZxGwrRoSk+9EGDNcFENlkqM=;
 b=RlXebdY1f85fUXh3iFDZRYaNC76nwBBb2iTNdcod5LNqduVkmqhJnbODVjQGgj9h8q
 AuprHPJqzFsJmVr5oaWT2iW9R/jQ2rQ0DSaOXJTvtPwCZDqhpPt2VVLtyWFiLJWHqGEJ
 JNnYTFowCMEz5S4ozw+3y3cUQWr0a95RcM96I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721854545; x=1722459345;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NJhiQSHA9Ty9tU/Rjw77ZxGwrRoSk+9EGDNcFENlkqM=;
 b=rla4ssZ3CQe7RY2U+2d1PlcTsjfvOPag0JgK3AdP1tbMwJWZqiaiDjr3xO/cy0P9EB
 yLOQE4j2lqiAeCSbtpryTPyBO252HjGZUoj3AjadaVHJv/koAWeh416UT7ktRI79h2g6
 vhQeGpdpsmxVnDX6vVsPPOyD+H6+5s68NDERCEJjIeD4aTkofNXYjUX2WtrTGwUNTQ0H
 JsNEhhj+BKNsKsi+/w/g5bluKbA2uJOS92dLd63UtuuaRfi5Leaq1EoOgmzI5GnSHHE0
 fzoWwNx7uKVl4tZRChXzWtAqcA/ZPf11PvKe/1z4WJ1dUuT+Onhij7a6MRu+yvF3cYvW
 KbFg==
X-Gm-Message-State: AOJu0YzcR1ulbcO5LbHYp9dIvZae9GEoki5Rkr/nm6Gwa1Tfmf/BlNAF
 RR3bGCY36oNcgA0HSug13S/IbIAx2ZyxwqybcujkVU4X61WmV7RDNB4zdDuiEDL2UPp8fiYKvOl
 LMbQ=
X-Google-Smtp-Source: AGHT+IEjZC0rDwKX6AUd33fCIRLoOumVpjS9xgRH6vj2HEVSd9H7dr2YbyVEoy+aZV3A3a1rBjcs9w==
X-Received: by 2002:a05:6808:1a1d:b0:3d9:ad9d:622f with SMTP id
 5614622812f47-3db10ea87a7mr841998b6e.27.1721854545557; 
 Wed, 24 Jul 2024 13:55:45 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-45.totalplay.net.
 [187.190.202.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3db1357a39bsm10293b6e.55.2024.07.24.13.55.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 13:55:45 -0700 (PDT)
Date: Wed, 24 Jul 2024 14:55:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Michal Simek <michal.simek@amd.com>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>,
 Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH 28/40] lmb: config: make lmb config symbol def_bool
Message-ID: <20240724205541.GN989285@bill-the-cat>
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-29-sughosh.ganu@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DIP3WdR7jdMOwWf8"
Content-Disposition: inline
In-Reply-To: <20240724060224.3071065-29-sughosh.ganu@linaro.org>
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


--DIP3WdR7jdMOwWf8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 11:32:12AM +0530, Sughosh Ganu wrote:

> The LMB module provides allocation/reservation API's, primarily for
> loading images to memory. This is functionality which is used by all
> boards. Make the config symbol used for the main U-Boot image as
> def_bool and enable it by default.
>=20
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since rfc: New patch
>=20
>  lib/Kconfig | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

OK, I asked for this, but, some platforms had special enough uses where
they disabled it and so we get more growth here too, so, lets drop this
concept for now.

--=20
Tom

--DIP3WdR7jdMOwWf8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmahak0ACgkQFHw5/5Y0
tyx27wv5ATzAq1k1e+3lxPwRjp/dQX6bet+BEceYWOBB1Z3AVB5HseIcoB7GZTdC
iVUdeGubY+IIAmbctyuYQsbw5Jj0meKscNX2kv0YRMchQez6cCvelJUBGSJZ0mEY
EN+AROjwGSi8eGy5GKiT8AbPregcoyiO+kvZsH80ePd0OEbhPeIugWOpRUj+Rgtr
BrWDEpAkYULp+PdiNXAJNtNOz+NMtERTUQYFfhq1MidFH3YYLgw//14MVtgrRv6P
Z2yjxGkS6nzYP+WUZxizRa4qnMVADPWySgMwnKH8PrtJUzwyL/RAjt8cVrURPgji
Wf9CANXZcXGoNQZhYYol4d3IkZChxV6Jierw5VVfk6lC8KrdFqPY1mP6anaDx7+i
o0EM+Q6Tsg+237AqZ34FrSCRf1CKoTeU3kPZU4+fOjxbv05LJ5CcWgN3l8ubFlOb
YRT5NJDHNLLMxxqsrZS/qKXufeppIpo11jdRcexJ/D3TfLejLU4eQ2Dpu8+LUeUd
VW/dDmQ8
=HMDn
-----END PGP SIGNATURE-----

--DIP3WdR7jdMOwWf8--
