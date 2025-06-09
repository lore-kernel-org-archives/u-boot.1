Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6AC0C5B552
	for <u-boot@archiver.kernel.org>; Mon,  9 Jun 2025 15:35:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6926582998;
	Mon,  9 Jun 2025 17:35:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZEXvfQfk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D87582AA7; Mon,  9 Jun 2025 17:35:02 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20BE5826AA
 for <u-boot@lists.denx.de>; Mon,  9 Jun 2025 17:35:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6fabb948e5aso48049426d6.1
 for <u-boot@lists.denx.de>; Mon, 09 Jun 2025 08:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749483299; x=1750088099; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sI8vEyuguaAWWFYe7qaI35HLjzkWnd0lnON6Uj/BmAo=;
 b=ZEXvfQfkB9CFx9+aDr/hxR5qi9u16uYO8Wa2BlZ5JwgrhpCm3DLusVLEwhzBp6whFT
 UxQaXYnOE7GpMDTEpBp/3Lk134yiJCPKYDfefzAoMqrVKH6bshbFvhpBgSVkD7XSpdNT
 aEyBj06RHqRSDcMDB7mHvhDhXi+pWbpY5b31Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749483299; x=1750088099;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sI8vEyuguaAWWFYe7qaI35HLjzkWnd0lnON6Uj/BmAo=;
 b=WA9cMr6Nb4t5YpOSaDHT/YziZkyDGrcbQsVVn5VotBZMU64fvtjfjpieFnuRZyo7E1
 bg1wXfeifwLHHZ41Kr0L9430OK/kvOOYEbUedjvvOLs57MJ4BJCnuGAddruMm976xGCw
 RyE2o6rtNg1TgQ8m5ZI8oBIdfNhZ7G49vzD59hv61Un1lWvF8I1TQZlYMW4mAW6wAYXv
 UEgq3rPDiLtoED5eJELZvoRVbO9A+lT6kRyksT8SLAQcyCWhV8aPP6Zyizqs9m6aEnr/
 JRWcZRFGx3ZRZtwBGPfU+pZvKGvUXZmDeG7hw675T178YdMhCBm4OuRzGDlkF5fCkQ/r
 onPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVL7ohKQjCRQaiY3WHvkrhuhhjFJvQL4IOJM+lAgfZKSm4W/f9GuKLmef6Mv0BGfnwrv42F2i4=@lists.denx.de
X-Gm-Message-State: AOJu0YxLSKlPdGBahZSMTnZKQwADdfHuIURR8/7qaAUSsC3Fz0dQif6V
 N1xps8c9/EZv+TKSraxJvKvtdLZ0eRncNHA3gO/5MafYX6lzTXqxPPBsQxgS9MN+ZYPj+sIOWV4
 2/zCodxg=
X-Gm-Gg: ASbGncs/NDwovwWibHagaQ0qzrfRpmnuwewDzIvsDW224Y0gqpH8mf5DA7pN4k3CRh8
 O/NarhFXv9Jdy4sgjFqbH3ZJWg8rkSyPZmtPzjtLn7yMjOw7YjZkGe/oEskPZ5FbCBTOz9WvKWY
 iYHAwqDhlVCFws+z+MHBmYQ9oxXms1/FlXYas+X9LbSu7PexGgnAgUYMSPHI4QibEyXkO0tTvD8
 2A4xIPH39u/GXtJgAJogZdi/zcyWsRwUhMjk0or5O6XIBULzYXUdiEjbh7yqrBzKdl6IKVJ6Zrt
 qMsvLMaOko/25N25yVMxcr2tczOL3uJNYchp95ZAuLFIT/pJ5Ku2DCOvGd3WYl5mb9hK81O8QPj
 lx/PRqD7PT0qL1w6odAiQV9U=
X-Google-Smtp-Source: AGHT+IFPAQY01Us/PM8UrpQnVC0OkLNQ1c4aRZ+5dFakTiSEF3oT98uvuhxzFH9U9jNYIHJTdJRfHg==
X-Received: by 2002:a05:6830:6405:b0:735:afba:ba99 with SMTP id
 46e09a7af769-73888d9df38mr9220648a34.4.1749483287122; 
 Mon, 09 Jun 2025 08:34:47 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73889f5a7a9sm1618551a34.27.2025.06.09.08.34.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 08:34:45 -0700 (PDT)
Date: Mon, 9 Jun 2025 09:34:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Parth Pancholi <parth.pancholi@toradex.com>,
 Vitor Soares <vitor.soares@toradex.com>,
 Sean Edmond <seanedmond@microsoft.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Bryan Brattlof <bb@ti.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 2/3] cmd: remove duplicate DHCPv6 Kconfig definitions
Message-ID: <20250609153443.GP1382132@bill-the-cat>
References: <20250608074228.12407-1-heinrich.schuchardt@canonical.com>
 <20250608074228.12407-3-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BGiAaE8T/5zTm0qC"
Content-Disposition: inline
In-Reply-To: <20250608074228.12407-3-heinrich.schuchardt@canonical.com>
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


--BGiAaE8T/5zTm0qC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

:n Sun, Jun 08, 2025 at 09:42:27AM +0200, Heinrich Schuchardt wrote:

> Remove duplicate definition of
>=20
> * DHCP6_PXE_CLIENTARCH
> * DHCP6_PXE_DHCP_OPTION
> * DHCP6_ENTERPRISE_ID
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Fixes: da24eb553279 ("Merge patch series "BOOTP/DHCPv4 enhancements"")
Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--BGiAaE8T/5zTm0qC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhG/w8ACgkQFHw5/5Y0
tyzgNgv9ER6h/+AqJn4ZN/BBLXpcPC6uGsqLKcpUa0Gr1qtO8a0WnXpDpMg+1P8R
gDhdUXGJLvmqQ6FfTbEf9b7PyvU4WRPQ6RCk81C7576jC3UwBExtzvIE8tLIL3CR
x4rWen/9hEVN442pq286GA7jSPorIoTyqAXgvVjnutSkmtQPQR8QQCPVcYoQgoKG
nWVVnU7aAr67XA7VwbHQHy7Toh7/PF09a+agKi7jwnHKWiaYXr5MZutiCycO1xEV
/rmzLQoummjWf9i5l84Na2h397Kjs0WjGhUa4pp21yCYVgK9I91B2YU7MP8F9Vmd
I6hk5NKTRMnnIXt4F4to1oJLBqL3HcEkmfcJmAtG6EW1gJEAUJ1ObKZSlynHm9Wt
KceNYYTXzMXME1Sye42xJIOryzdpdCcDEbWnKkvKw+uz1R6Ivwln21dFhGJQsXwE
4WD1n/S5VV4qjDkvC06wGSA/zviuIrfrop0huz8gLUuXIy/WuPzeSUXZerht7Hws
21U9zJxQ
=h+YY
-----END PGP SIGNATURE-----

--BGiAaE8T/5zTm0qC--
