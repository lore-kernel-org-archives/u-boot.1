Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04251C3600B
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 17:41:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EC2381EBB;
	Mon, 31 Mar 2025 19:41:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sbT2OaP3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68E5C81F0B; Mon, 31 Mar 2025 19:41:51 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34FB481E6C
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 19:41:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-72b7a53ceb6so2530051a34.0
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 10:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743442908; x=1744047708; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DyybYXQfGOJyTji+0kjHB1srVW49TtjINfqfV1NOD7s=;
 b=sbT2OaP3wiGJBZAWWRr6PZDuDD8NNCIGEP61o7e4LLnb09JrmUv66XZ+VWmRt3TXaG
 aj7ZWNyMilnww1SavdLmwhQerXsyVcAlkr8ViaQ9WRI/7nVjBROSjyfpIrJhAdT2r3lZ
 1i4djB/kj24WCrbqje/HfFiJEXWCMwvwEx8/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743442908; x=1744047708;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DyybYXQfGOJyTji+0kjHB1srVW49TtjINfqfV1NOD7s=;
 b=TRQIgIE0IVDJWiFvlEwoBJj4EQoflMqKP+vUrkPrd6vqns9sB8x2uAvax/51uXChua
 FS5CIFz9frBbo6Sx2Oc/Y4qs+mwaeALiHtO9QtQ0ZanMbD4OyB6xadK81o70RJvXh+S4
 TFs6Xqd6hU83DMdvVsoWrEnVuiRxhDiVImnAx5PTeeNxJ2nhqKp9csbDjkkt78eDlmoc
 2fkbecuI6jCQcWfqUgrLDtEhA+eLkfHNeED7eLFwRrEBWE2OdFAc67eqO3pCq4PzO44z
 4ASFfKN7UDdPUD1V0m5A2/8wgSYrK/u6Yb93ti4qdo4Gb5ov9yCyC1BRhmkTb0DNTSLK
 1CMw==
X-Gm-Message-State: AOJu0YwaQH758ZxzHksq1z4Mgrb6fn6izVo+/TBfbFgy32HEFJOM7R0r
 02xaJc6fJr7gVJHrkphhxASdHSYUn+N0PL0iL6odiIMcXyR50Q/IHeo+yY+pxMl7kk3g4nU6qOk
 n
X-Gm-Gg: ASbGncsFGP1hMOkQLhHzuRG3F1kG+HsapXcPpKAyYF/hdk6RDkO/jq/dcMLA1g0xhaG
 lRln+zABc5nyGgZq+P5LyqJqZfIYuBP6TeEiLCpbToG84YyuALLMJfof5qy4663Lj87rQ90lNJT
 u6rYmM7KJ+XyJNVVbow00yDkM9Dtz1TDsT6mCWkPpQ9GRNfLJE5abtxlS5nVCi5adBC5gT579T5
 3Bdt/xKW7T4+Vnvyeh6sAW2FzWcOnJZXVjZ1pYEhZDO8V1MVVGLTgT3GNoZ3uEtwcW2ENI+mSoA
 3yH/mxx8tU9UAeIY7Hfj9I9dnVREVkPigd9my9EQ4FwHFnNd0BhFyb5S1CmcS071Zo8Ffnmv7iQ
 h0wnxjg==
X-Google-Smtp-Source: AGHT+IF4qQ3T5yrx5J7jsEldS9VRCqLgsk8K4gtr4I5ohtXsj4/bKGF+VCezXqM6oCFhghylDBdq4Q==
X-Received: by 2002:a05:6830:380e:b0:72b:9422:aec with SMTP id
 46e09a7af769-72c634ad964mr6639221a34.8.1743442907920; 
 Mon, 31 Mar 2025 10:41:47 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72c580b5401sm1543124a34.18.2025.03.31.10.41.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 10:41:47 -0700 (PDT)
Date: Mon, 31 Mar 2025 11:41:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maximilian Brune <maximilian.brune@9elements.com>
Subject: Re: [PATCH 06/17] bootstd: Try all bootmeths on the final partition
Message-ID: <20250331174144.GI93000@bill-the-cat>
References: <20250319143820.2385092-1-sjg@chromium.org>
 <20250319143820.2385092-7-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LaUNp7E1/FkdbXK8"
Content-Disposition: inline
In-Reply-To: <20250319143820.2385092-7-sjg@chromium.org>
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


--LaUNp7E1/FkdbXK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 03:38:00PM +0100, Simon Glass wrote:

> At present when one bootmeth fails on the final partition, the next
> bootmeth is not tried. Adjust the logic to go to the next bootmeth,
> which is the more natural behaviour.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  boot/bootflow.c | 34 ++++++++++++++++------------------
>  1 file changed, 16 insertions(+), 18 deletions(-)

Behavior change should include documentation change.

--=20
Tom

--LaUNp7E1/FkdbXK8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfq09gACgkQFHw5/5Y0
tyzq6gv/bE/Bs8O+QrJsrJ4/79Gbi/rdYz1OWrSKtqSlrgzQM3LOwQc6YDrUcmU5
DEdZQi9zzEZUZa2fYr9dadKOmBnPbXgVOwNAMKl8+wk6w5xREykXg0JbdCZm7NE7
CyRftzmmfNMLkBnnV70mV0CKgrqT1YAsab7HEcX4QipaC7oAwdWx5mCb0gjFKQlR
NdVC7zZ3iNQrgy+ehiqNumYx1OJHzJAy+7ia3xbnYhQmPD71c3s+43RzyMqwjV3p
Xd7ban18m/6rJuP/JdurQDd+fLlOJfjde+UVOifRnwcyx+YPquFpDuA6WkAsaDOz
qCXelKUebUzTLhfo25tzhFGsimT9acr9OWxxFcQQm+REewq+aLvXCufgyzueZmaQ
tgBoj3CvJGu0vOyaCIPTk943fA5nE5BgX/HUa4qwKiTg2rgmSOzTld33DY5HRjmM
g3qu3C8dlfbVN5RciPQGS9TLkROEx2ps2BjQ7W5WrqPrc0YHLZECsjbCwZnYVxVi
LZ6GHyRX
=d8+9
-----END PGP SIGNATURE-----

--LaUNp7E1/FkdbXK8--
