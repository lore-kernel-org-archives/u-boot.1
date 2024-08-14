Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA261C52D7B
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 14:12:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2F8A87C69;
	Wed, 14 Aug 2024 16:12:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eHdUStxv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40E518899D; Wed, 14 Aug 2024 16:12:43 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7E5387C69
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 16:12:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3db18102406so4478028b6e.1
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 07:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723644759; x=1724249559; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EWjCVEVik8jPKBPND9/GX1CTraajgfl3QYtemW3zhfc=;
 b=eHdUStxvXkZNmc4VhwLqyMyStmFdW6HeX0L4l2m/MQs8aY1B56KCuKPeE4yxd2PXlI
 rKzi5Hsh9IhR7OtLJbMJkuqX9WA3oxDObgeDobYnYP4AgvR07uglSQ2dtQkzabgB1cAS
 zhtpNZJWMo5f4AxD5kR858mEYmzkfj5XAwVP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723644759; x=1724249559;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EWjCVEVik8jPKBPND9/GX1CTraajgfl3QYtemW3zhfc=;
 b=QD9R0l2+HI2BSZLv2A0oy/kCnkQAOTl3bMxF0akVSzUe5WBnHuFCXevHo1Q8xpUxMN
 kXwECrzCQmQVHPjm67hPzDoMKKkDfnNYoYEQ26eC2nsUrOvFuCTyVyBdd6pHhEpFb0hc
 fa5nIOHanyoZVvWifbjux1JTN8JzkJwF9lpxArse/gUr16I9LEOdKYF2uvpRZsDP9GbI
 qTr5my8yprWonpaGCwUv6HqppgfyBTrJR29v+ywGtj9ZH+bpcTWavjahqjxHqPV1WgBX
 zE0HuIn2OqvIFHxbCcSiOlnwL2BB8KgHG/2rJxk8qBPRcykI/W4I9WU8BogTAqMark+H
 n3wg==
X-Gm-Message-State: AOJu0Yx6LnJ+a2APgEFAs47rsNrCbHX+ECrKnNlLP4A61h16Xo/TorLz
 Kjkyn2yk+ol4rpL848+LB8n1llQSKRwHe8h7KFfnoYtwFOkEKKB+7loAd7UK+WJgaSwXpvYkKSm
 T
X-Google-Smtp-Source: AGHT+IHZTghbAbeZgWoDpQbRunLRSOUH+aPUCmwc7w2A/9mLthZcfOu+cjvJECKxxLIa8pG5RF4soA==
X-Received: by 2002:a05:6808:1825:b0:3da:aae9:7182 with SMTP id
 5614622812f47-3dd298d9418mr3599672b6e.2.1723644759531; 
 Wed, 14 Aug 2024 07:12:39 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-236.totalplay.net.
 [189.203.97.236]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3dd06077b11sm2116680b6e.15.2024.08.14.07.12.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2024 07:12:39 -0700 (PDT)
Date: Wed, 14 Aug 2024 08:12:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Heiko Schocher <hs@denx.de>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Simon Glass <sjg@chromium.org>
Subject: Re: Please pull u-boot-i2c next
Message-ID: <20240814141236.GK1626301@bill-the-cat>
References: <87aad96a-93d9-2309-ec1c-fa372cb87b09@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CQBAs8CVNeMsEwbQ"
Content-Disposition: inline
In-Reply-To: <87aad96a-93d9-2309-ec1c-fa372cb87b09@denx.de>
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


--CQBAs8CVNeMsEwbQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 12:44:29PM +0200, Heiko Schocher wrote:

> Hello Tom,
>=20
> please pull from u-boot-i2c next
>=20
> The following changes since commit f4f845b859266790b97421f0740efce36bc9b8=
d2:
>=20
>   Merge patch series "Universal Payload initial series" (2024-08-09 16:03=
:21 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-i2c.git tags/i2c-dm-upd=
ates-for-v2024-10-next
>=20
> for you to fetch changes up to 710b9c89f2c2f19436f6c21d092af1a2b24a26a6:
>=20
>   i2c: Remove CFG_SYS_I2C_DIRECT_BUS (2024-08-13 06:23:15 +0200)
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--CQBAs8CVNeMsEwbQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAma8u04ACgkQFHw5/5Y0
tyxVIgv8DRG27cKdlr2bEEK91gbHCKB4RuWfiWdocvMXrJQ2YyKlHxFZIJWxOu1/
ta7cCyRQQK/67yyC8uRv5XzYjCjAmOqh5EdlkZwBa5NQNbmlW8NsQwpgMMmALecb
4TzPZF4qPobgLvUWw9PSxSSRRcTW0rWc2oRxF4vmi7BxXvapsZRabIRDLqOXq8VJ
JHlKcxoIIN7Id7xnuimSyuZlqLj3pe+GBOnN9Ss42QplOXtIL4oqd5z52LlYHrAu
r4alHcIa7CUXShRY+9nYWlvzGjmRbFLRWAloTrkPS2RO8s/h/ifmMUIYsrUV4/Um
msTF1sUhLwd8WzY9eS8BR2ur2NdSzYQ0Cc3ZI81924u4p13Umn2NDO2f1HaenlyK
FAOS3GakwVq6W7yoMukYfDwD/o5TtbktFCo+wBNj1PMebcjg3t5NerQId23Lvi83
/++mtNokMK/JbT70a2dFGU7sKFeAkfJDMFuDjgWcQUWH37AVj49gbcAmZjuXKZCw
VuALKD90
=w3TB
-----END PGP SIGNATURE-----

--CQBAs8CVNeMsEwbQ--
