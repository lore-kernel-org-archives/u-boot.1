Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC27C0015E
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 16:59:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 603A3869E1;
	Tue, 15 Aug 2023 18:59:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cojeuZh1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34AF3869CA; Tue, 15 Aug 2023 18:59:26 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D07D869BB
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 18:59:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-589c7801d1cso44685167b3.0
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 09:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692118762; x=1692723562;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8lizqZnqps6o+NYC/xflSqNk8854mzf4imiTtMB4Sow=;
 b=cojeuZh1+D13Wbe2ihHARpytuUm1+e/3HcVdNCLxoy+JK+sZFtxoGDBL/CdUI18U+v
 I35GeEmcxj9KeN0SW0/sASIufkkSWipfxFYfQYwR+0LjBkS6/3iwCOvh5a2urTsDlKY8
 B8ak0ckOrn7BlbVT9JEyg0XAcUvlugZEZrpew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692118762; x=1692723562;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8lizqZnqps6o+NYC/xflSqNk8854mzf4imiTtMB4Sow=;
 b=JZlF3XKWwPDn3SA2JE5JqMV4jfoLt8fwFhnAmOYMAlhackqpb/MUelW+4nG/VpBtPq
 vVAmU1y9df4xM4RuiIC6PcSsGyDshk+DkL6jLRsafSu9QHs8pC4YYWR6lAwd8Rz6XjYI
 mKQTJ4SRHnyxMjB67/dc0JgI0xz96xRayFYGn4zG9l/ko2t33u0KrKMVo9arMxOPivJq
 579rGeL7PwKhdLF8ypCh/+BYDzlOLLLYCg8oQHyhRGcHlZ90Kg4aO4sKxBuVF8+U38QK
 agPlcmXv9q0dSYTB0qVCFaSg+HMcvlcPMnMiP9jU1nGBMZFLPgVk8d1jRNScZaaFa5hJ
 txzg==
X-Gm-Message-State: AOJu0YyniHcu6o8nw+zkf6gbxahOEHjaV6aqNBQ6Gn4YZ2/Ppg+47UFc
 Z2W228Sm0MuBnXZG/03/D063ToJ6sO5ezLGQtkGe0w==
X-Google-Smtp-Source: AGHT+IEJF3FY6J6iCrZm27bVyZp2hsj2nRSzQ2c/Qc867YXJ0yGtHyOuFJ2ns4G9vOvwAeyqvyH9KQ==
X-Received: by 2002:a0d:ca4d:0:b0:589:f8c7:244 with SMTP id
 m74-20020a0dca4d000000b00589f8c70244mr6320441ywd.33.1692118761823; 
 Tue, 15 Aug 2023 09:59:21 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-14d5-2a24-c47a-465f.res6.spectrum.com.
 [2603:6081:7b00:6400:14d5:2a24:c47a:465f])
 by smtp.gmail.com with ESMTPSA id
 d203-20020a0ddbd4000000b0057a560a9832sm3508359ywe.1.2023.08.15.09.59.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 09:59:21 -0700 (PDT)
Date: Tue, 15 Aug 2023 12:59:19 -0400
From: Tom Rini <trini@konsulko.com>
To: Heiko Schocher <hs@denx.de>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Dmitry Dunaev <dunaev@tecon.ru>
Subject: Re: Please pull u-boot-ubi
Message-ID: <20230815165919.GA3630934@bill-the-cat>
References: <f8f83f82-4515-c237-8748-c89fae24a60c@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="e3folhEF82TIMDxj"
Content-Disposition: inline
In-Reply-To: <f8f83f82-4515-c237-8748-c89fae24a60c@denx.de>
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


--e3folhEF82TIMDxj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 15, 2023 at 02:26:06PM +0200, Heiko Schocher wrote:

> Hello Tom,
>=20
> please pull from u-boot-ubi.git master
>=20
> The following changes since commit 832148f675e427060be074c276956962fa9b5c=
b6:
>=20
>   Merge tag 'u-boot-rockchip-20230814' of https://source.denx.de/u-boot/c=
ustodians/u-boot-rockchip
> (2023-08-14 09:11:09 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-ubi.git tags/ubi-update=
s-for-v2023.10-rc3
>=20
> for you to fetch changes up to 34031e9cce91de323ed711d7e8614c0d12fada1c:
>=20
>   cmd: ubi: Fix 'ubi list' command arguments parsing (2023-08-15 07:32:13=
 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--e3folhEF82TIMDxj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTbrucACgkQFHw5/5Y0
tyx1HAv+LfIr0K1okUKvbi9ZPSn0nEKiTyb4V7bPL2y5j5Shb8Z9TIyOXPtbqut1
+eMwRD29Z1TybwVwlbDyND/3u+Chvl0FcJEIhpa2OIllOn5r+RTETxZrJ5DGYE3o
Wr7wHUytfM94/iGiqXhDoH6Rd5J00jLwQv6oCQhbwL99R4dyz5tR1cHylZBBkIDo
PiNm7OnQ2NnFcJBlwOZf4HrPylBh1M2yfHQy8/es5bcSxxBTQVH8MlbKn9atTcf/
skP7HfqPk/vr5KpWboNQlu9k2v+GH4LJDSR2Jzk6ELYAiaui2c7FnWiI794Gw8Pb
w1xLJZnPwhD3IJ+TKkG5yZLcxwcvDXweh3RCJFN13U+bbWigDYPhj+pL/qyRgxbz
N6AbwEwTo6f70A9uojgPtP0RaU2EpWQr0Va817+M8Kb9CVG/Q4DCgrCVYk2bUyMX
QKt2W//JcxS+DogfJCl8LZr9uSRYYpBRF5eAu2lw93TL7nkawgcXReyNrVixMKAm
kr0Wt5qm
=qc2+
-----END PGP SIGNATURE-----

--e3folhEF82TIMDxj--
