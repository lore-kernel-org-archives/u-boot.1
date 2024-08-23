Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22658C52D7C
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 13:34:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D53B888D4;
	Fri, 23 Aug 2024 15:34:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AZjrCQV9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBDC5888D4; Fri, 23 Aug 2024 15:34:56 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B79BB879C1
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 15:34:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-70e00cb1ee7so1399611a34.1
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 06:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724420093; x=1725024893; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0MHg8BsiC6Ap9TK2o1AyEnAYaqxY1qvm6Ws8SBgzBFM=;
 b=AZjrCQV9yeF6+a80AVLCg7ZGT1IkoT/73zZKC8sSHwhtLLH7eg4E2Db1Pz9oBQUJvP
 7CjXdqwBS4+6GdzFAr3QG93iZXJwu3yjkQvytiv9AD1dhtrTPoH0XRQ/POIcpqJV0F8F
 C61fhIPd8Oxs3X5gatWCEjjDDw3N03mc4HnrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724420093; x=1725024893;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0MHg8BsiC6Ap9TK2o1AyEnAYaqxY1qvm6Ws8SBgzBFM=;
 b=BTMphLgzEsszH2xCcueh7kN8kMHiGGrjfzYBW3C0K7cKTodND8aJyghDAU2Wp3Lng0
 jFCyZFjEe5feDXS/fZ0Ko4B+4c+HfvqsxvhckavLvm9NlWxtDg6tV2Ug6/l/KP2E7nU2
 RJ+ILO2qabgccMAkHc8yLkpLdwlMzwQDbqS8NNrFl9nhkgn/325iGPc5wufMSkwDJDe9
 4BWKlcA2poli7G7FxVtSN63mx5t8lR6Ee9skhM4PFmbcVG/kiQWWUMz6iDWPNWdzR+P8
 G3EKpfbAQ1tp1Rv4mvBx6kW3i9FFCC9cXL9aZtv5XrkLEF6y1qlTecREmznOdgFDO62Z
 ubjQ==
X-Gm-Message-State: AOJu0Yxr0Ad47vroQYUffSMaJqyinKRx0bxzQvWcpL2rlSfAugHPUkxy
 P58y7mB3GBxxK7f7Bf9qYlozPe+8lBn8L8SyUEqAii4ZrFbTfF1Us856xsOZKQM=
X-Google-Smtp-Source: AGHT+IHMwZGkhEhVLyz6uiSkcbuLBhf2V2SW+7tXsApoYs4V7ovaNulQxq6uLBMLaJNPL0dRNJ8dnA==
X-Received: by 2002:a05:6830:6084:b0:704:4bb7:af8a with SMTP id
 46e09a7af769-70e0eb887a1mr2790284a34.20.1724420093367; 
 Fri, 23 Aug 2024 06:34:53 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-197-236.totalplay.net.
 [187.190.197.236]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70e03aa92aesm651341a34.29.2024.08.23.06.34.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 06:34:52 -0700 (PDT)
Date: Fri, 23 Aug 2024 07:34:50 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v2 26/35] global_data: Reduce size of early-malloc vars
Message-ID: <20240823133450.GA1627158@bill-the-cat>
References: <20240821161927.695717-1-sjg@chromium.org>
 <20240821161927.695717-27-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YEg5b71LmMESFMm8"
Content-Disposition: inline
In-Reply-To: <20240821161927.695717-27-sjg@chromium.org>
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


--YEg5b71LmMESFMm8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 10:19:18AM -0600, Simon Glass wrote:

> The early malloc region is normally quite small and is certainly less
> than 4GB, so use a 32-bit value for the limit and pointer. Update the
> comment for clarity while we are here.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> (no changes since v1)
>=20
>  arch/arm/lib/bdinfo.c             | 2 +-
>  common/board_r.c                  | 2 +-
>  common/malloc_simple.c            | 7 ++++---
>  common/spl/spl.c                  | 4 ++--
>  include/asm-generic/global_data.h | 6 +++---
>  5 files changed, 11 insertions(+), 10 deletions(-)

This breaks booting on am64x_evm_a53 which is an odd platform that does
SPL->SPL->U-Boot.

--=20
Tom

--YEg5b71LmMESFMm8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbIj/cACgkQFHw5/5Y0
tyxOCAv+ND90uEVp4yu3eCx/r/9SYmXugVyCI7OKImzQNWhEdwCtXERDY+Ih0kD5
0cNlqWN8zSqlKpg6EUX4BU7N2l1sdtjnW2dCyESg5PfuSyW/T8tYx51zDwq4RpvL
qHA6dCjgfuiP8XZYlPl3qeaRNcGIf9XIu+Sf5+YpL2e96H9et2HJ/pE8n9OMvNes
cPWzHUb/Ycs3A6FQF83CbZeDvEmVoxIsy5ZPgTEEeC0PGr6PQxVmdp3+i022ylhn
YVg11OM01U9VdNlIkM9sjTst40xZu/kqZ0rmjQED2UYPyVEuXgfmL4GWVAELhkbX
9AF7Ci7cVw35Z6Eph9ku65OIfCwyTVrOLeqUfJ0ncsrgWEFlZZvh1C/iY/p3riIl
yNy4PbIM/mE2aDe5aMOwQAdHmCs0VZLxZPQCVn379BFgl/x+8KGDKJ2vtey7urIV
Ps+VJCH/xx0w1H/1W/wnC6B5HIsIHkQu8zR4TrFWn0umUDEXA7vce6pd4I9+1YQJ
Qy3jwm2P
=aBBc
-----END PGP SIGNATURE-----

--YEg5b71LmMESFMm8--
