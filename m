Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2225C87FCC
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 15:53:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6733805D7;
	Wed, 30 Jul 2025 17:53:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="diflx5xs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDC108091A; Wed, 30 Jul 2025 17:53:04 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64FDA803CC
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 17:53:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7416d362e7aso1104354a34.1
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 08:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753890781; x=1754495581; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=07zY+wiuKBZ7RRGL0l8wQX8rVikMV0LsW0cEBBSTOgY=;
 b=diflx5xseElAA2I5qN2evXZHrap4YfxlbzAXuhXDKHOvdY+SbuDxIBJAPanl0EcKqo
 WA/zaYHc72yDRl5spQxsAzvsclEmkqJwdBbwsGk0FIL3YKdsOBBZevLr7jlXXB8Gd8th
 PH5Hm+IljLH5N+j0llyomN1geM9ZVsV5DG1lU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753890781; x=1754495581;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=07zY+wiuKBZ7RRGL0l8wQX8rVikMV0LsW0cEBBSTOgY=;
 b=Qqam6BJuRxsfIboVyMrYKlhMWS7sj0H7Xs6uwDuVcScJLzQdkxjR8iy4yIRF1WszAh
 tN09lTlisSEjZSsggmSo4NJ2aVWgL1WDFh6v91FvxlEZeU4gzwRH77/fspzJXHcHZweY
 C0BURX1xMjZfaOdFB6gouHfMEHaEUiOtPEn16rwom5Lf7ThKq642Hm5Y2Ktw3afxKjO0
 T0bs8uEF/rY798vUAUqYRtze4Js0rEDaKj4TXDLaplN1ZH9z2CMtSU7DTMiJ0Db3UDn3
 cWnq6uNi7+LzQ71Qq+vv+qepzWEPt/7jw80pEnnz3iRe5p5SFNy7qjngd29x+vJxuLl3
 zeRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSZ7i4480aYj6d6KHTrVkuFOQvCrLSmkCoJ/BX0aCeb2Xd3BgbXwezUdDE5xgTT8eS1m2vabI=@lists.denx.de
X-Gm-Message-State: AOJu0YxriDDxKCb5NsI+MR8UniPpOp7ed41CAY/DJRIPewe9Mmhm2bD1
 acQBSk5pdkcO9ldclDM1QSn4+xngeqCHvr6VtT8pTLRAoLQiNdhxuzGU5osWzC1cr/c=
X-Gm-Gg: ASbGncsD0mH+1apFNw0RulfDpQcwTUAjBOha0WlT8vkc+f/Snro9G+qnqgMqHQZiPvt
 2ySCBPtvUVQbUeX08zpCfupxGwuQouyi2lbw6EbDEboc/4Dt32EkqGQczVml4GsdIylf5vj3YpE
 HhdYaofrZiOC2Q/mesRCeJZ7JgVNAiaHKB4lB6Bkc7rRIJa/O4CKyHLo/F0bLT6FGv89nalSTxw
 1Kky9QR9p7JqXQXcpJo50E5srBeJ1GjtpLcFsQ5DmW+8X5c5ZNJA3UNqGlIrKka7z+vEIpGTW6P
 /IR/s0f1519G9XlKBKjEn02ziTg1P98UKZbwQbXBaTU/GMMMH2Z42MdAq3/UFsBY/yZiaoIpqJk
 RG7Dyzpe+i0U52Ekdp10spAS4MqMcChWv83c22/xj4krSxafwVsQomj0H
X-Google-Smtp-Source: AGHT+IEK021mmLQ7UtHtpx6dBplrovNsZcbY1JULC8tblgL7Y8v6LuqwCJbIv/DztN098rDNYZTUtQ==
X-Received: by 2002:a05:6830:6016:b0:73e:a0d2:e587 with SMTP id
 46e09a7af769-74177e42dcfmr3005800a34.27.1753890781051; 
 Wed, 30 Jul 2025 08:53:01 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-74147f4c128sm2073242a34.11.2025.07.30.08.52.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Jul 2025 08:53:00 -0700 (PDT)
Date: Wed, 30 Jul 2025 09:52:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Wadim Egorov <w.egorov@phytec.de>
Cc: Bryan Brattlof <bb@ti.com>, Garrett Giordano <ggiordano@phytec.com>,
 u-boot@lists.denx.de, Daniel Schultz <d.schultz@phytec.de>
Subject: Re: [PATCH 0/2] arm: dts: k3-am62a: remove GP security variant for
 AM62A
Message-ID: <20250730155258.GQ1807455@bill-the-cat>
References: <20250729-no-62a-gp-v1-0-1dbdb4469ad3@ti.com>
 <03e3be58-3c69-407d-8bf8-3f90e6b19e6c@phytec.de>
 <20250730142624.GO1807455@bill-the-cat>
 <9d812fd3-6bbd-40c4-9485-f1aca43804b9@phytec.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="X8NsqY0BA5mza9kK"
Content-Disposition: inline
In-Reply-To: <9d812fd3-6bbd-40c4-9485-f1aca43804b9@phytec.de>
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


--X8NsqY0BA5mza9kK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 06:34:42PM +0300, Wadim Egorov wrote:
>=20
>=20
> On 7/30/25 5:26 PM, Tom Rini wrote:
> > On Wed, Jul 30, 2025 at 04:12:48PM +0300, Wadim Egorov wrote:
> > >=20
> > >=20
> > > On 7/29/25 9:36 PM, Bryan Brattlof wrote:
> > > > Hello Everyone,
> > > >=20
> > > > The AM62Ax was created right when TI was shifting to their high sec=
urity
> > > > (HS-FS and HS-SE) processes. During this transition a small subset =
of
> > > > AM62A parts where configured to use the old "GP" security for inter=
nal
> > > > and for select groups of partners but never sold for the wider publ=
ic.
> > >=20
> > > I guess I will need to update my hardware to an HS-FS device :/
> >=20
> > Did these chips then get sold to the wider public? Or just distributed
> > within phytec? I'm wondering if we have another i.MX95 A0 type situation
> > or not
> > (https://lore.kernel.org/u-boot/PAXPR04MB96443299A51764EE05533DE0E224A@=
PAXPR04MB9644.eurprd04.prod.outlook.com/)
> >=20
>=20
> I am pretty sure I got a super early prototype for bringup. AFAIK there a=
re
> no other SoMs with this revision in the wild.

OK, I'll assume things will get worked out then, barring further "wait
no, this is in the wild!" reports.

--=20
Tom

--X8NsqY0BA5mza9kK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaIo/1gAKCRAr4qD1Cr/k
CsIXAQClN981Q6+pG7V8sIITK/o1vPyp6seVhE8rosXnhgYakQD/ToFq6hn59M9j
yrvoklQ2qLd4CKbAeysRgoYum2DtVgA=
=Lb+E
-----END PGP SIGNATURE-----

--X8NsqY0BA5mza9kK--
