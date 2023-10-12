Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BCDDCDB47E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 21:47:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F00386E42;
	Thu, 12 Oct 2023 23:05:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oD4+pxqY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CD8986D17; Thu, 12 Oct 2023 23:05:13 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E5FE86D41
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 23:04:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-5a4c073cc06so22061087b3.1
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 14:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697144628; x=1697749428; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QKJGxuO4xD1SPTXv9RqNWNY7oS8kmXzDYRE4X+aleCI=;
 b=oD4+pxqY3cEDr34CM/Soa/3NYlf1DWnWnjaIIReP48fmrU2XRH0oTpp1n9fLNTPWiu
 YUssrT+ZNl4WJuN9/qZs2IOkhtXJjLVFRrIBb4pmh/9Xj7ftPLxVE9u+xWVX5RBHzBj/
 u7xs+kjaUcwUqjpeJLXfSJ6fUrIxUuGzZ2IhQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697144628; x=1697749428;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QKJGxuO4xD1SPTXv9RqNWNY7oS8kmXzDYRE4X+aleCI=;
 b=gQC8vfDr4TIphRw6GZRoXu4xjyS9T5egHR/oSpMO2+LgRpAmdfrS6wFRFF8aZllhya
 EgxwF3lcPpxAi0WXUpXjoaogWYRyMFr7mNPCQOxBPctuUJkAVgSR8kGDcxHCzuHeCNu/
 aOuA88KhrlQlTQS0Oh+XHH3qhqw8jaVVJesE7CRqp5rXsub9BrdhQMP/8ZaxKvmPll6D
 6bdqWbukY8A9UOodxQ76JYABTy1fenK2smFHma9MSCXlf+pQjQ39n/qYV1FcdrNJmdkz
 RbhEQxueGkxT4H4X6f+Oc0CNFSorYIu7uPkRj7jVliGp083Qj99DXAQLZ2Q09Twq4SBq
 IEsg==
X-Gm-Message-State: AOJu0YyCJtXcuokc57vx2zRvQETq1weFquzoBSkASMFnV5jViyPLrf0y
 AMxmJ/WwJAaZhOTLPJFx7x+62A==
X-Google-Smtp-Source: AGHT+IH/EYEPJvcEAiBpEzq3LMkhxjspv4QWptCmbsjDAW0UIwSG4DFhMnR7f7vgwPr8zo/bJ0A55Q==
X-Received: by 2002:a0d:cc42:0:b0:5a7:cb5f:ee0a with SMTP id
 o63-20020a0dcc42000000b005a7cb5fee0amr5265451ywd.17.1697144628153; 
 Thu, 12 Oct 2023 14:03:48 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5647-4a14-f04e-8d8d.res6.spectrum.com.
 [2603:6081:7b00:6400:5647:4a14:f04e:8d8d])
 by smtp.gmail.com with ESMTPSA id
 n123-20020a0de481000000b0059935151fa1sm213802ywe.126.2023.10.12.14.03.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Oct 2023 14:03:47 -0700 (PDT)
Date: Thu, 12 Oct 2023 17:03:45 -0400
From: Tom Rini <trini@konsulko.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: nm@ti.com, vigneshr@ti.com, m-chawdhry@ti.com, sjg@chromium.org,
 jonas@kwiboo.se, srk@ti.com, afd@ti.com, bb@ti.com, praneeth@ti.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/2] board: ti: am62x: am62x.env: Fix boot_targets
Message-ID: <20231012210345.GW3119521@bill-the-cat>
References: <20231005130642.21402-1-rogerq@kernel.org>
 <20231005130642.21402-2-rogerq@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zYr8V8CucKv+4y4a"
Content-Disposition: inline
In-Reply-To: <20231005130642.21402-2-rogerq@kernel.org>
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


--zYr8V8CucKv+4y4a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 05, 2023 at 04:06:41PM +0300, Roger Quadros wrote:

> ti_mmc is not a valid boot_target for standard boot flow so
> remove it. Prefer mmc1 (sd-card) over mmc0 (emmc).
>=20
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> Reviewed-by: Nishanth Menon <nm@ti.com>

Applied to u-boot/master, thanks!

--=20
Tom

--zYr8V8CucKv+4y4a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUoXzEACgkQFHw5/5Y0
tyy3wwv+JZ8tbQiugoXkOr/DN/3Hjkb2f5cQQIFoDNry39dJOuJ1Rb4Xr7oXnsS9
AoPzIbE/5t7q5x6O4duSsVoCttLngQsC5PnEscWnpqzgTjzWXYHQtiFdnRYvJfLE
09iW51DstQY7cC8rcwlp5yw4sHaZ7ZOLhGpCZPcR0PUlNa7tof1deWWP7p8ZJ0OP
ZyCANqna5+s9wCcvRC7QdwTG17zEY0qTRauhraR12sAgfDpHtGfnuZJJ/PMy8ntK
mcQoaqt6AWIrPGW6AhOLz5T58hSxLCMThaVi2cIreSS0dsantpLuM12YY1tv/eht
FTJMpPz/APVaqx7UBQW/JBjd5ghQKtSDHYXzF5M6rcUFoWYO9WD4NtfRrv5RQvIb
rFjfA3dd0rBhXsYaL7G3rXZ2bhn5d733gTKA8sQ2yg6bwO10lbaOrc38TTNPOScL
hVKX09qrxvU19+bd3L5k/7j9sJcDSRWn8PhGBPuX8Go/TcD1XNgNZFg1woAkQNfT
QNKvzqZR
=+xzk
-----END PGP SIGNATURE-----

--zYr8V8CucKv+4y4a--
