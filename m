Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87B84D7494E
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 23:54:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBBA9891DB;
	Wed, 30 Oct 2024 00:53:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="m4I1hc22";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D47CD891D4; Wed, 30 Oct 2024 00:53:36 +0100 (CET)
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com
 [IPv6:2607:f8b0:4864:20::a30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D74E3891EA
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 00:53:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-vk1-xa30.google.com with SMTP id
 71dfb90a1353d-50da1fceeacso1848447e0c.1
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 16:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730246013; x=1730850813; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gulPnbZOtsS8/yEGd0y53YRMC4K4mevpf2lJzj+kCRM=;
 b=m4I1hc22wiq65zrCjNi+myTUMFIHat2BaxI6L7m1j22XfzHi1QdZu18Bff7QghLoMN
 ZMcGy4gC0Q6dXdXwRycxYS61QCJtNAi8S0Z9m48Ie7gE32SdjMg2MCtrotkK+NrP/8N+
 gA49Uo8If2N0VbHeWa/G4VUdOew+/Holcv07M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730246013; x=1730850813;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gulPnbZOtsS8/yEGd0y53YRMC4K4mevpf2lJzj+kCRM=;
 b=AYSyyW1o/S2A/ddV5791XQKsU+sRwDZKJGyS+NRZol3m4+kMjPEDpfvWnufbH2v+mm
 SLVKmxP0wKdyrylp6PMbZDMShPVlAbKxRU7sMQZ8EwNiF0eBf4oq87MUOrMXHtqEzxsL
 mJ5zp3AHV+31DVHHw0/a230CWRaq/FnoasU1Wr+BlltDMBLsNUxQKS2uZbrwWGpTd7Sp
 A6K4KlPc+slAhUJ8+yEO8WfKNpFtT2F9m/SKIdf7ko4FW/rO0PMityUdetHJcZg5Uqsb
 btD+ve6WOk1jTPgiHz8kTxkIxVmbOHAuxOgMDbvMyOf9rSk13LgqqqF303k6ac+ZCXu3
 +vXg==
X-Gm-Message-State: AOJu0YyQFBz0E14CtOG1nrhy76RU7K5fk8zniEhF9j2UKdfschXnhzmg
 loLWVdxgzSeYNuZVEkUqxZ1v3AZUT27jCwELlNk5AB6sJN1eCP84lKf7xOGutZEKOnK2uSqOUz/
 0tys=
X-Google-Smtp-Source: AGHT+IFzun2z17O9d/rWxNgEO5eFYWPGy7xtxk5Y6UduDpPVoyWf0ktPoTbSyGOraEeS3nTLg9TOXA==
X-Received: by 2002:a05:6122:468e:b0:50c:f0c9:d995 with SMTP id
 71dfb90a1353d-51015057da1mr11580962e0c.7.1730246012637; 
 Tue, 29 Oct 2024 16:53:32 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b18d32c981sm465011185a.98.2024.10.29.16.53.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 16:53:32 -0700 (PDT)
Date: Tue, 29 Oct 2024 17:53:29 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v7 08/11] test: Try to shut down the lab console gracefully
Message-ID: <20241029235329.GH2558755@bill-the-cat>
References: <20241010015145.1977999-1-sjg@chromium.org>
 <20241010015145.1977999-9-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KC4EibFDmYfXbeGa"
Content-Disposition: inline
In-Reply-To: <20241010015145.1977999-9-sjg@chromium.org>
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


--KC4EibFDmYfXbeGa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 09, 2024 at 07:51:42PM -0600, Simon Glass wrote:

> Send the Labgrid quit characters to ask it to exit gracefully. This
> typically allows it to power off the board being used. Only do this when
> labgrid is being used (detected with an env var).
>=20
> If that doesn't work, try the less graceful approach.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

I forget why we need this, and not just have the release hook power off
the board, as part of releasing it.

--=20
Tom

--KC4EibFDmYfXbeGa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmchdXkACgkQFHw5/5Y0
tyzclwv/RBEnlqYkkFTRK1pL+SNRjaNWpgDHGX5186OWffQ8bImHFSJwWOdm95Hn
VW2KmYH8UnHuJ6MCWaxuea6tPrX8VLYuOL2p7dwie/9Sp/Ouw40l6xQq0Hxw1U1w
dq8R4iIIMzW4aATL/qgVoY/JwK11iO6DpGxN2FseUlGYYsDAPcB92OnjF7ZkG4U8
B8rdZVMucYe9st/9tKvwoOpQhRFZFkvnn2h9Fu/AgsHMsFEv9hAxv11b8We2T9dn
GFzvp2mnh18MEJaBSZbKCN6PD3q6fEwQopTgTOc7ruUbhYHRnUChHdtbYa5c8S/v
gJYabz5QixgQbqtk6vdvDoe0oh7VXAYDhAdknQB/i0zOq1nVcxXwKEHL2xmVhE8A
EfEqevGo4AZIDqLPgFg3UO+C2WwbyuGnSBQs/yYvDBfyNyYDgpvvWWwIXs+oyiw7
W00bZceCYeFHadhW7bOaWvkEW+uYK7IjLanlhZJ41fSn+NfJpR/SQ1F8dU6QPKhs
ts1Prb8T
=ErUK
-----END PGP SIGNATURE-----

--KC4EibFDmYfXbeGa--
