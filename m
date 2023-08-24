Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BEBCC3DA6F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 15:14:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 462588669B;
	Thu, 24 Aug 2023 17:14:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NlKiO+V0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59D398671C; Thu, 24 Aug 2023 17:14:31 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FF44866D4
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 17:14:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-58fb8963617so56826887b3.3
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 08:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692890067; x=1693494867;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fkOfai68pvTo8SnwuJIyEO8LZnuZBjw2bmywTEbiHGo=;
 b=NlKiO+V0sz4CAOrsbg+hh78nCb7VUSwE7d4gno/BVb8BK91ABm3XYEnqTwTWeN42nw
 ALE2WG/gA5IpQh3GJFKSX18mvQCheH1vYGwLnfOMYOxFzMjeSjrrzU0KJLX1MEHTJ8nD
 HDNbpMbEaf/TepiRKI5hIKhr5ygyb5dtAid7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692890067; x=1693494867;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fkOfai68pvTo8SnwuJIyEO8LZnuZBjw2bmywTEbiHGo=;
 b=VWhB6Ocw2CWlbILozXL88t/jh/rPSgqlS/2E3/BE/tv67jgZQ6A6PnEtGJtYl99S0x
 9RzSRhCjwURMXZqa7TPBbJ+9E0aU/7zMANQ5tz+fuHc+tzWajLLjpwZQ73wFJSXWrUgl
 eCFGJGdmrd5qcWRBlxn2jgJXcWTKsDyw5sWV80IcQf56ysThD6R/DeobHN6NP2lanvPU
 pmY7ESow5fXZNKFz9Fc9HY3DC0zat6PDTxNmLy0V/vemEK62BbToauD2DVYxWFgLxcQx
 JjxGF9PfUK76tKQjcF43mBo+GYMIbtYynVke/x6Ik/UUGZNT1kle0eoqKT1/CAnsYwng
 VfOQ==
X-Gm-Message-State: AOJu0YwNmYRAc6CLI6VJ08MeX53iTuJfCYqmUuvxeEX8TxWimS7F1d0l
 dnqCvRKbzctDDZ/hoRHkJegHTpn7cVNERUOjPiJbGQ==
X-Google-Smtp-Source: AGHT+IFVR8Ve5UEkWBOmUbvi5Hs/wS7XwCTCzerR2Ptia/1ORHt6h8Z6LhrD1jaSZrdGF23G/QV52Q==
X-Received: by 2002:a0d:ccc2:0:b0:58c:f957:d1c4 with SMTP id
 o185-20020a0dccc2000000b0058cf957d1c4mr15201968ywd.36.1692890067457; 
 Thu, 24 Aug 2023 08:14:27 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-37ed-1199-bcc5-406f.res6.spectrum.com.
 [2603:6081:7b00:6400:37ed:1199:bcc5:406f])
 by smtp.gmail.com with ESMTPSA id
 l68-20020a0dc947000000b005772fc5912dsm3951056ywd.91.2023.08.24.08.14.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 08:14:27 -0700 (PDT)
Date: Thu, 24 Aug 2023 11:14:25 -0400
From: Tom Rini <trini@konsulko.com>
To: Nishanth Menon <nm@ti.com>
Cc: Neha Francis <n-francis@ti.com>, Simon Glass <sjg@google.com>,
 Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH V5 09/17] board: ti: am62x: am62x.env: Use default findfdt
Message-ID: <20230824151425.GV3953269@bill-the-cat>
References: <20230824031101.3460411-1-nm@ti.com>
 <20230824031101.3460411-10-nm@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NZUBI/sB92dNx/wb"
Content-Disposition: inline
In-Reply-To: <20230824031101.3460411-10-nm@ti.com>
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


--NZUBI/sB92dNx/wb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 10:10:53PM -0500, Nishanth Menon wrote:

> Use the default findfdt using CONFIG_DEFAULT_DEVICE_TREE
>=20
> Signed-off-by: Nishanth Menon <nm@ti.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--NZUBI/sB92dNx/wb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTnc9AACgkQFHw5/5Y0
tyx+wgv/YHeMIJb7zPj+exzKOwmHzewhef7zuXpcNcG55Mp1h0PIznCPyoYDKrrF
CexLYOYRFTDakMORViURcNvVY9DDVufvyZNjUyIClvh1K1S7ik9XnB8X6iXBaAOn
getT5QPLpZMB4x/tuLgzjWnvE+iNB45JN2erxQNhxdWo1Qt8v+JJlC12JydjVnoP
7MIXc0KmAerRhvJtNlecCO3VY0JWRytYe8TPgSPkN/7iTDfol7cVQI7pme31wOKP
CiQGA99mtLuRCP5OQT7r5IJfFjYHu1B7s72aLWk+99//C5+4Qv7To9AkHxiW48qA
k+MWUE7a3MlGg1lhrw938nfDlA7MCFYPrjyl4iqxGZkcypItrc8yuau7vdX0NqVM
olVe0q+VvAIKVMUKJg2y0uMww33im20Jhb3W38vaFlZf0G0fGQDr2zTM9IvqqZCn
g6FEnOXa+SIflPEFq04yLgwos/cJG3MadNvH8amP5Ps4/msqR6hJBMCAOH4k0Vrd
xuX02bJa
=nTO+
-----END PGP SIGNATURE-----

--NZUBI/sB92dNx/wb--
