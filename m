Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2B3410F995A
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 16:26:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B29A884105;
	Wed,  8 Apr 2026 18:26:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Rw8zwh+9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0A0D84106; Wed,  8 Apr 2026 18:26:02 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 875DE83D8A
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 18:26:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-40974bf7781so983943fac.0
 for <u-boot@lists.denx.de>; Wed, 08 Apr 2026 09:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775665559; x=1776270359; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=X4DXvtDZSW3cU+gvT/CChcuebr60EfD4OlWyreJ/dr8=;
 b=Rw8zwh+9SrUWRVnDvQZoCgxB4+mjStq+67Rkb7BMt2hHkYjAID5rtILAwSU1Zi8yXP
 QkkdX/kyquQW4+dtOCnOaOnbHYedv8fOt2l2gqWVnn4emPnEJr5K1f3Mylzhu5BXUmKY
 t74qBg8z8s7tw0W/jL1PWtHaDxlVlMmc2kAeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775665559; x=1776270359;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X4DXvtDZSW3cU+gvT/CChcuebr60EfD4OlWyreJ/dr8=;
 b=S+XtbblR6w12s9oS5e5LGZWG9k0rLVvvB2bCxDf+M+RxAGa2sNt8xgqxN6IVwO8Ctf
 L1Any2mwqTl5FIgKoqwMBR0iwxNGR6vdQpnWaqYCFo1TTtCO/2MmP3xu3erirTcz1Xsj
 du01opZ7rZuVsXX6/MI6rVEeFhOMmgoCH9up5kfAJJhnNAI8xG/bMuf52A/uILfIJrOB
 ZzjUk46zcgbKvG+LB9p6/FU4wMrg+yhOJ7z04L6ZTXsD5n5AhmBP18LqHLdL41uC+ZMS
 nu5WaA1hzcV3cLjbHJxFoP4J5jPViDFWSJLlxr2zql9pFgTLqb4VgM1joHi4T1WHSAZu
 LmtQ==
X-Gm-Message-State: AOJu0YzkDPxnNLL2NKaNy6oXMn677DjsKLTFGED658axPmqOVjq4LZrs
 S81ocECE7RrbnW1YduepGPTFjBv5sFEK9XnYrJks5W2K9psulKN2bPkv9+XXDMmy4Vw=
X-Gm-Gg: AeBDiet6/ujJvKd4DEwNPd+xWGWHasV+fA6Ln7uah4ZYuBfW+U6vE4rVxLD5iPwcyuM
 wnTpcHIg0wop4sJW9OQPSB2xPSOUZpkndTGyzPXOu/F0HnbGJO8qUlhfxZN2Trro1bZafYAflbC
 yj1lvFBrsyEj7/zjUhKd0eIGXJ545XNwL7Xi4moZfh0SZhQJk3BHgJUWz/H+c/AX4TevN4r/pQE
 tWJrFRDwDjnCAQRQCCkT/CqtQ5J6yJcu04c9XZt8kKFr3r/PtX4HDlhTrtfh60Xr0oM5s3PRYm2
 eTyHBm9XytmP4Mn8cZFcTleZrVe76DyHgolDVNE2WQv89slRrjEtiBS4c0QJODBp5aycGtT7I+e
 SlkieKotbfyL0rZPSONsPSuqCMEvCFkPBYipBerFiC+pdBqvJhdtB32v2UynntpO9wuNqr11Bid
 O1rhZbv47FZaNfJX83a7EsObm2j31/b2fnZvHTYleOjfYrjdzaNOnOPqOXVk106spUfyngqpaSW
 1pLfzHsjVbH/Io1XO/USmpiMwdJCQPg4M/g5qeaM4G/1B7f
X-Received: by 2002:a05:6870:6986:b0:423:69cd:14d1 with SMTP id
 586e51a60fabf-423bd05fab7mr70045fac.21.1775665559230; 
 Wed, 08 Apr 2026 09:25:59 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-422eb25ad44sm15947920fac.12.2026.04.08.09.25.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 09:25:58 -0700 (PDT)
Date: Wed, 8 Apr 2026 10:25:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, James Hilliard <james.hilliard1@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Shiji Yang <yangshiji66@outlook.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>
Subject: Re: [PATCH 03/13] boot: Tidy up setting of the OS arch on host builds
Message-ID: <20260408162556.GF41863@bill-the-cat>
References: <20260325165431.1027591-1-sjg@chromium.org>
 <20260325165431.1027591-4-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yooyrMn4P6FngT1s"
Content-Disposition: inline
In-Reply-To: <20260325165431.1027591-4-sjg@chromium.org>
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


--yooyrMn4P6FngT1s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 10:54:12AM -0600, Simon Glass wrote:

> This field is not present in host builds. Create an inline function to
> handle this complexity, so we can drop the #ifdef in the C file.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

I'm not sure hiding details of what the host tools do vs our regular
run time do is improving overall readability / understandability.

--=20
Tom

--yooyrMn4P6FngT1s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCadaBlAAKCRAr4qD1Cr/k
ChSxAQCdE0QFblcUpuWoLOtwj51aX+6DlAnjdBUL2A/g6YqztAEAzhmOXoAdFYbr
uxuwhOenNS7wZGTdHYR1Zd7AhFKBBwc=
=QlE2
-----END PGP SIGNATURE-----

--yooyrMn4P6FngT1s--
