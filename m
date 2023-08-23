Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5076CEE49A0
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 14:42:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC141864CE;
	Wed, 23 Aug 2023 16:42:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VyrrVGEa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D2A5864CC; Wed, 23 Aug 2023 16:42:14 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F18CD864D2
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 16:42:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-5924093a9b2so23778907b3.2
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 07:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692801728; x=1693406528;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4joqseWqDEfQGtJj/05gkFsWZXSkilZcpDRjMypxVJ4=;
 b=VyrrVGEaLouXzlWL+cz3zlM4rBL5Y/QznQ4o7cyY2KFiuXBXOapOFutd7me6hxfu24
 QWiDvbM2IN6A2wfXt1ewdeARXaHpU7PYnomYvp0eMr9MVup8nz90Njop89l5Lpt1Yq4P
 oYlYFFg1q6/qnpd1FmItWPdKssUdxTEr/Qfv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692801728; x=1693406528;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4joqseWqDEfQGtJj/05gkFsWZXSkilZcpDRjMypxVJ4=;
 b=PD4h0TssS5QdeFbq7EEjnZG0DKvETIjPObHEohGAbYnJLDtCCGpRmWUh7wwoIz+xI8
 uqNVE3lOt21O7++YjHt/IHvm0oHIaI9+/o5syzXhijSCurop9d8QU8iRKa7q1saGKKgx
 ErZPKtuPBGiiM98Q5stejDyH+b6C0h/ypJVBM2vM+CfGeXqEWlHnMz8bMeN0+e7zqAbV
 Zlbo18Z7MyZr3jL8/RrJvu7p9RGXJh/+rrOzq6o952kQr6d5yMWNDeBhzfxNtMX0EFxv
 Y50R7SRZGQlqOwJyjkWy9ORi7esk+KguKHBJGJKnMnv2ZCZt6B+If4CS3T/mOtldjtKT
 ujkg==
X-Gm-Message-State: AOJu0Yx/f8Vv4HoUG+1wvK4lq472XVpYZzrMEb/TEWjL/UOeXS7Lp+sr
 nvtQ6zaRnDKzLnpBRI0OsW4wm//08Sutd+7NYAEYEw==
X-Google-Smtp-Source: AGHT+IGe7dwpZNXUOdIIMNskvRiCGMIJHssCfXzd4uRWTRR7bOJx6T+F500guPwczNpkkeZS8Q0YCA==
X-Received: by 2002:a81:920a:0:b0:58c:a87b:6e65 with SMTP id
 j10-20020a81920a000000b0058ca87b6e65mr15243280ywg.26.1692801727957; 
 Wed, 23 Aug 2023 07:42:07 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5ca1-6af2-305a-b62a.res6.spectrum.com.
 [2603:6081:7b00:6400:5ca1:6af2:305a:b62a])
 by smtp.gmail.com with ESMTPSA id
 h6-20020a816c06000000b005707f542f62sm3354592ywc.25.2023.08.23.07.42.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 07:42:07 -0700 (PDT)
Date: Wed, 23 Aug 2023 10:42:05 -0400
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glplk@gmx.de>,
 Joshua Watt <jpewhacker@gmail.com>,
 Michal Suchanek <msuchanek@suse.de>, Simon Glass <sjg@chromium.org>,
 Tobias Waldekranz <tobias@waldekranz.com>
Subject: Re: [PATCH 2/8] disk: Simplify disk_blk_read() using blk_read()
Message-ID: <20230823144205.GT3953269@bill-the-cat>
References: <20230813234648.591083-1-marek.vasut+renesas@mailbox.org>
 <20230813234648.591083-2-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9v8eU9WydGA9OdLj"
Content-Disposition: inline
In-Reply-To: <20230813234648.591083-2-marek.vasut+renesas@mailbox.org>
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


--9v8eU9WydGA9OdLj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 14, 2023 at 01:46:42AM +0200, Marek Vasut wrote:

> The disk_blk_read() can be simplified using blk_read(), the only
> things which needs to be handled are the read offset based on the
> partition properties, and the block device ops which are coming
> from the parent udevice, not the partition udevice.
>=20
> The later is currently not implemented correctly as far as I can
> tell, since the current code extracts block device descriptor from
> the parent udevice which is OK, but extracts block device operations
> from the partition udevice, which does not seem OK.
>=20
> Switching to the blk_read() fixes that too.
>=20
> The dev_get_blk() usage is simplified using UCLASS_PARTITION check.
>=20
> Add non-confusing documentation what this really does.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Applied to u-boot/next, thanks!

--=20
Tom

--9v8eU9WydGA9OdLj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTmGr0ACgkQFHw5/5Y0
tyzyRQv+LIW4jOxoqxaytdk8lxA5R9cQgOzzcTeaGEOFz/aspG7edyswwwc4A+lW
U0+HoBnUTCZFBMQ35O9iwS7WW++kZ+2R9p2tjoCcEdYwx3oVIw2Z75tf973ktX6O
PAL3WEYv5UMBZP1JqklThRvj7eM+Dsold57qRF2pTS6FQqVuzH+nBNMxvWQIgDsb
DaW/ATf28WYlzOEIUH/0Kn65XsAdFdGuXS/Mdj/7ZO7KcYLHK1p8eJeVu3NCozAV
QseAnKmQhvdhWBgNyILgoi+u7isWl0Cu+kWQYteK37dZsM70yPduRlKqg0BiGSaB
BiQQu0f0WMPEaaz1s+0yaRyc/76cYRW3fgYcHkzOntKO0or+syhzAgwJcQ2yZ5or
Lni1sES8q3nkDSQYJiHDFF9i1qcrW4kYTVM3VQmqVHEd7Tqn137szJrE1EveWXKH
MRV73LTz9uYjCLc64T+FM3m0scJ50o3Wl7yYhLbv8mkXKeJVLT7CgvA5ysNYA3CT
4lNz6Vwd
=E9BO
-----END PGP SIGNATURE-----

--9v8eU9WydGA9OdLj--
