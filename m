Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A72B5C25B10
	for <u-boot@archiver.kernel.org>; Fri, 10 May 2024 20:01:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3134E87EAC;
	Fri, 10 May 2024 22:01:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="q4CmcWpQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4219F87FCC; Fri, 10 May 2024 22:01:57 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23CE587E74
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 22:01:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3c996526c69so1072804b6e.1
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 13:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715371314; x=1715976114; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0TzwZxKSlHomnlApuUKJw6ZF6VkMZH2RVSIFa9ZQYdw=;
 b=q4CmcWpQy8EG0r5lQD1+LW3bEGwkUwApTv7Fp2lLujm4UaG+Q7J+/THxJ4vDb3ZcYD
 9vJG5rY2wqKkbgIEkOkq7RKVs2es4MkXWvtvpyDOouKo8RJ202Lfjgg7vrojk/mVUJdS
 yqdJKPe98FlmaGpKmU/nujMwWcACSA5tWaaOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715371314; x=1715976114;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0TzwZxKSlHomnlApuUKJw6ZF6VkMZH2RVSIFa9ZQYdw=;
 b=tn5CjnBQR85mvmko92D9HtWAu+iOc6sNOYvWmxT3psxOr8CHfZSmj6vWlUzrGBafDd
 54ivKcG2Km73p1+ulBwQVLBuvCbAs7V/0qR7j92VMPPL8/sI8fWf6pZZpDXMbhxSUBNO
 MUDy7c9mqExjlD/neVBer3J7xkkxWdDILLnKkxprYTcEJ/VFdvSX002mxl4Sn4uPQ09u
 6VOhcGmIVEbdqvvQyT2EAs3lWUqYsnLr4NJszkzU+EdMiAW2FxGBaGByh5I1iF0OiYEG
 UlS6LLmo6TXk3vL8mOeSoWdSYsF783g+A5PEiPhGcgi0hVKkPtDwxnSMz9+CPJPCRNSc
 86fA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCv1KnF5K4vDROjdi44w/6yr82Qw9MiBtNU8ZYp+6EB6TTOKkq/gsoxpUEKJFoWpwfZ4zVDFRz1jw64gCMgW5vgPVv2A==
X-Gm-Message-State: AOJu0YwEhuNTNrUneEPLqYMLwt33ihlN44AF16tSOLKzepSSjOFqGUm8
 lWQnFJNzfPQ4moLjBpI1ZNGFeUHB0sDN29IN6KxJDIl6QiD40Rlm1lrecfVDEvA=
X-Google-Smtp-Source: AGHT+IEliver/xxE+XvcHXM1GxQQID35fGWpCaQlJf98jA1rxIQ4pi/Bzro4B4+F0N+WMtT/r0eO3Q==
X-Received: by 2002:a05:6808:16aa:b0:3c8:311c:ac60 with SMTP id
 5614622812f47-3c9970ccefcmr4446556b6e.46.1715371313879; 
 Fri, 10 May 2024 13:01:53 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a15f1d740fsm20066516d6.115.2024.05.10.13.01.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 May 2024 13:01:53 -0700 (PDT)
Date: Fri, 10 May 2024 14:01:50 -0600
From: Tom Rini <trini@konsulko.com>
To: Nishanth Menon <nm@ti.com>
Cc: Roger Quadros <rogerq@kernel.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Robert Nelson <robertcnelson@gmail.com>, Wadim Egorov <w.egorov@phytec.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Simon Glass <sjg@chromium.org>, srk@ti.com, s-vadapalli@ti.com,
 vigneshr@ti.com, r-gunasekaran@ti.com, danishanwar@ti.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH 0/3] arm: dts: am62-beagleplay: Fix Beagleplay Ethernet
Message-ID: <20240510200150.GZ2568172@bill-the-cat>
References: <20240425-for-2024-07-beagleplay-eth-v1-0-6c985de1c316@kernel.org>
 <9baa5ac5-8ce9-4aea-9a3d-ec1d68ea5505@kernel.org>
 <20240510130830.GT2568172@bill-the-cat>
 <08b22e06-f316-4ef6-bd42-a4600f1f8035@kernel.org>
 <20240510193325.GX2568172@bill-the-cat>
 <20240510195837.oebzog4czpn4wzxs@spearfish>
 <20240510200056.GY2568172@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qVlFJ93RM1Zj5nYe"
Content-Disposition: inline
In-Reply-To: <20240510200056.GY2568172@bill-the-cat>
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


--qVlFJ93RM1Zj5nYe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 02:00:56PM -0600, Tom Rini wrote:
> On Fri, May 10, 2024 at 02:58:37PM -0500, Nishanth Menon wrote:
> > On 13:33-20240510, Tom Rini wrote:
> > [...]
> > > >=20
> > > > [1] arm64: dts: ti: beagleplay: Fix Ethernet PHY RESET GPIOs
> > > >       commit: 0b1133ee36ecbf3b02f69cc4e8a169f1b6019e40
> > >=20
> > > Ah, since it's been merged to -next now, Nishanth, what do you want to
> > > do?
> >=20
> > No biggie.. it is on route to kernel master anyways, was planning on
> > OF_UPSTREAM migration for beagle once we settle 6.10-rc1 settles into
> > u-boot.
>=20
> OK, I'll just grab this iteration.

=2E.. needs a rebase anyhow, yes, please do, thanks.

--=20
Tom

--qVlFJ93RM1Zj5nYe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmY+fS4ACgkQFHw5/5Y0
tyyUCwv/U9V+7u5b6e4Hoc0IlvyYQ75iZR3OffjOuXrbfhkccMm71+SCRmDSMDMQ
9bTZYV327XQq35ITTj3VIhPpXUjlHu51WHuzRAGUjZ5Q5y/pinJ67gyR/6zCBqR2
5NW78x50rpZ+18R2nn+NeV6bVydvnKncDDY3kHe9360d4FQ13CNR3KcalcLeGjX0
Jkdc5T0MdmxL5stG6DTwl0tbLTV9W7Q+F9HrijISB65vsUKwgquAtSDYZM3JW8C7
kJhOPUMV+4lS8PddPKXr0zLrBVAwSnGYr79stzBMwKeQ0CV52kyayXCAxVt0CYAu
FkoRGQ9U8lEF2dVMBjjuHszBoaE088lO9jpxA5SCEuiyiWyFF8P7VyMrLLhfajrt
Ie4rcgRny8S8eVujY13PR9AohurgQq5/V8OS3pRZaQBoKWdYeyzxp4I4C+PEQ6NA
g9I7Aw3LQIqtXQHUMWb76hyAXy8vJuk647+hYILmMrLxh1UhRse7QPpgHzKsjmUl
ov1FJpxR
=EJiN
-----END PGP SIGNATURE-----

--qVlFJ93RM1Zj5nYe--
