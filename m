Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E4AC2BD09
	for <u-boot@archiver.kernel.org>; Wed,  3 Jul 2024 19:15:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 666D788871;
	Wed,  3 Jul 2024 21:14:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eqJLXBn3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A43ED88871; Wed,  3 Jul 2024 21:14:57 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F7098886B
 for <u-boot@lists.denx.de>; Wed,  3 Jul 2024 21:14:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5c479e5f6faso406920eaf.3
 for <u-boot@lists.denx.de>; Wed, 03 Jul 2024 12:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720034093; x=1720638893; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zHcCTu4CFE4Ijf+4vCbphHiQX0TSfwXcTovzqc2HQAM=;
 b=eqJLXBn3bFSecDYy8WzeDG/yyosEWdkNBu1GhGZTmbO/Hln5RuQPzLeHQg3U2eYkfA
 r/wfS0oO9oUphxV+2rTaSByD0ky4jMLoDkoL1bo0fuAxXM1Nc6G/mub/D6GeCnyPSnGw
 1IcxzkSnie23iDk9Ipf3d7Uf1EFcsTULgt06U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720034093; x=1720638893;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zHcCTu4CFE4Ijf+4vCbphHiQX0TSfwXcTovzqc2HQAM=;
 b=kRmIH2IjGCrJonrKPI/ZexuE2OtWd/bXuUVxJIhKn0yM8KbCqWt+G2PC493QVFHttk
 KQL7q2e3i6Z3bgoa/Rbf6eUUFFuHlpGBA+A/DQUcxvy26uxUX1faJOjXSQqbPfRBB4Zi
 cJmwmpYoC69qMBLeaW7TVjhFoIx8GJbfl18XxJgmGf1qf49w5xZZIjl3Gvb81SS8qJ4o
 wkIyIRMlpKwwlPiTaUhW3WA+LdhQ43iQ+Yhbb2HHrtrtMMKgTBuxL/OfCqSf1PTjKeCR
 /pkjcikTpKEtC7LTpfySJp8494QhQ81rJg+3iSuj+PmfO/dwf8T5kRywE+w56mt97DK3
 A7IQ==
X-Gm-Message-State: AOJu0YwL1MsZyCf2nVs9TbOzS25SS0TgLbGOZE7iLJHbzJsj6R1S+xpc
 QL7QqYU9mHgfjG3pXM3jKaRj2rAfiSJpRa2bygtI4aK5h6vv3BI5j1kUO8xOKRU=
X-Google-Smtp-Source: AGHT+IEwlWXrf/Dph3csZQOl/YtetMkI1dyH5/O1VrKJXLnuqjA8Dygq4HeThsPpTULpHqOoccP+Kg==
X-Received: by 2002:a4a:b048:0:b0:5c4:e036:e383 with SMTP id
 006d021491bc7-5c4e036e5eamr1240632eaf.8.1720034093362; 
 Wed, 03 Jul 2024 12:14:53 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-45.totalplay.net.
 [189.203.97.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-701f7b20a0dsm2066351a34.55.2024.07.03.12.14.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 12:14:52 -0700 (PDT)
Date: Wed, 3 Jul 2024 13:14:50 -0600
From: Tom Rini <trini@konsulko.com>
To: Heiko Schocher <hs@denx.de>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 Martin Kurbanov <mmkurbanov@salutedevices.com>
Subject: Re: Please pull u-boot-ubi
Message-ID: <20240703191450.GE38804@bill-the-cat>
References: <2961fe0d-61b7-0c67-3bd3-d5f96cb7d918@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dbuIgML0kxORu9UU"
Content-Disposition: inline
In-Reply-To: <2961fe0d-61b7-0c67-3bd3-d5f96cb7d918@denx.de>
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


--dbuIgML0kxORu9UU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 03, 2024 at 11:12:52AM +0200, Heiko Schocher wrote:

> Hello Tom,
>=20
> please pull from u-boot-ubi.git master
>=20
> The following changes since commit 65fbdab27224ee3943a89496b21862db83c34d=
a2:
>=20
>   Merge branch 'next' (2024-07-01 15:00:56 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-ubi.git tags/ubifixes-f=
or-v2024-10-rc1
>=20
> for you to fetch changes up to 27b169f9d0bed978bea1d86ab8d584da6ada54d0:
>=20
>   cmd: ubi: check 'updating' before calling ubi_more_update_data() (2024-=
07-03 08:05:19 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--dbuIgML0kxORu9UU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaFoyoACgkQFHw5/5Y0
tyxiWwwArtkACo3um4YttP+i9bmBp/f7sT/ZFe6bGLkREyJB0S1J4ZTAveUO6wK9
xHruDCaC1O1V0P2qqJPFRxRILBIUBli8sRmQZ9rvoVJiAwo8iv5fxBWmRRJI6310
ddFOT5kCwElr9NdKqWYib0P3D7iZL4R2fi094eH/Y8LZrkh6huMmift4ov0YqQzE
ss/AR+B7QbWvkoxMaBZ7b0fTDyxOa2XwPQNI5u2KjTbJksPYZz1I4hu0/MggYyqM
97AuoJXijXpytbWLaQOiXjiI7ZG3nXM863V+hcu9gfGyrZHDmu/jKP0ZrZte6Rbu
DEBYbe+FfnxWxHc+u7dhJGs2U03atwk1xO+dfNuyrmH/yd1u1D+lv7SpZ7QO409X
3gcZ1ADUNvmjox4sOAH4DBazrx5dJt3ZjPBP2IakMq21cVNZz/8hGqzKVjaQ/Ft3
9mayvh8ZnfNWHGZRDjIZCMrNxeDHv4hUW6jQKNmbVINKLrjqDMavhGU4nX8cxHRA
RduJ2eZ5
=2nT/
-----END PGP SIGNATURE-----

--dbuIgML0kxORu9UU--
