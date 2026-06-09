Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C06B7CD8CB2
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 19:02:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEB2C84997;
	Tue,  9 Jun 2026 21:02:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="n8sd34e/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E02D484997; Tue,  9 Jun 2026 21:02:00 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91F3E84704
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 21:01:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-4863cd278d7so3704099b6e.1
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 12:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781031717; x=1781636517; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/mgtbXxAD+6UCyV+rbpqd7sPv0fpiKL8qso5KRzQHSI=;
 b=n8sd34e/Wp27yM7exUWUY6VQ4SBC9A2axq1A/XgbbCo5NPr8iibxweYDz3N/82ecak
 luRXenRHnkzMqWXiLT+QBZXc7NyP0KPTnOjH8ehaNLqWuyY2imd7dn8UbABPLXPPdg3B
 2r7hx9yitfBI2njICfe7gWF6HmoPWcJrg/+qQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781031717; x=1781636517;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/mgtbXxAD+6UCyV+rbpqd7sPv0fpiKL8qso5KRzQHSI=;
 b=rPVYv0fAfaDiwgD0FKaVQy9mCQLZXhBtcPV6Bi6ECE86piG5AV5AAcRXgc/00e7KCN
 134pLwDFXATWX1BqHJLat2QcMHawKdBPbhqH3wBf2kyb1Kw0d+2gU8kcEs2aRoTATFo7
 Ob7G+I706cWZAQdd9NPEOuJ9s5D70SnBf097wmiGzC7jmjr/1r9eiloHuhqaRJ91bL6O
 Oc3Qwgmn5sSXMLMkVGz+QiO19FVp+Ikqp4JwF7rRe1hwbxxonYzDrTw/o3amTwiH5iVN
 RK5+/C1jWX6pZH7Ir0eHnOLOsnL/iOParsRy4lE7mbbDZgdjrB/D60G3usHUIdnBQs0p
 yLUQ==
X-Gm-Message-State: AOJu0YyUrRnzKa1TDyG+yTCDqITKXB2kcmSJaxmCSy36B9VFPPwEXo0l
 /HfOzrlSyvG4PNkLmKQ8TGQo3ND66JOVRU5bFdzX+w8xsNRiQG6+MIG6kwZKIatQsG0=
X-Gm-Gg: Acq92OFb4qGJHAQvujL43ssYjDpe+wM2wBRzK3rBPFqdslaNm5KVwuF8Btvn8RCYPYq
 eK4L1DjHHrrNK/mmnVW1NAp2qxlYJ0m9SNaKSZAeavpWwBwNBQmKtRZCEOXDw8wOyYMMlJIrC2f
 /wcDPRhtF2Gs0/Y9UPfU1HEBBxvziSrv0ZWyeoYDJ4bBvQJagNRMqG9UYt3cu5X5QpyySJIvOPX
 v/hOWmi1gQyyHdvD8R9o485uuq5XRMiq4o2sZTaB8zHMF7Q2iTVxOUhNsnX9GUEVmq3DLST8fvt
 7t2FV1/8SxcyGHBMlvgI/nIAsoyWYxqRQoVlagSL6y/CWukisiNBUhKnmFicxfkwSh69Ne6+ohi
 +q5dJxSIdXwfDgp6IhfEFBiAd/BfLkEaEu6CpZF+xa6kD3kKrOzuJ7DYOJJaxMZa4Jx0SW0o3Qu
 m6ZAbyzmYWPgTdTWBzarscQrKKUbu+wpQiVf0NMInMuz/ZZ/c+4tdDvWXLkE/589LSble3PI2UH
 02EXcH/rUzMw6tUr3LSF/EkB6LVWHrf1s9g4BRTiDr3twMdC1LgzF9cAbiVovp+fO4I+14o
X-Received: by 2002:a05:6808:4f68:b0:486:3537:218b with SMTP id
 5614622812f47-4868dceec5emr14255011b6e.11.1781031717206; 
 Tue, 09 Jun 2026 12:01:57 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4865b6ec694sm16496529b6e.5.2026.06.09.12.01.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 12:01:56 -0700 (PDT)
Date: Tue, 9 Jun 2026 13:01:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Johan Jonker <jbx6244@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v1 6/8] Kconfig: arm: restyle
Message-ID: <20260609190154.GZ382693@bill-the-cat>
References: <d1270724-50eb-450d-8847-a3271ea27a2a@gmail.com>
 <763728a5-f789-4254-b7ad-67a8950f0522@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uASB5lmnUcH9/cF9"
Content-Disposition: inline
In-Reply-To: <763728a5-f789-4254-b7ad-67a8950f0522@gmail.com>
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


--uASB5lmnUcH9/cF9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 09, 2026 at 03:26:02AM +0200, Johan Jonker wrote:

> Restyle all Kconfigs for "arm":
> Menu entries   : no space left
> Menu attributes: 1 TAB
> Help text      : 1 TAB + 2 spaces
> Replace '---help---' by 'help'
>=20
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--uASB5lmnUcH9/cF9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaihjIQAKCRAr4qD1Cr/k
CmbzAQDbyy1gg2VMC0aErOFEgWdasJHcRtD+YY7n4I8GCzhE+QEAz9RKbFPYIWaZ
B8BRIkQR3Gy1p8UBUsGaicTKkLjqWg4=
=lF4e
-----END PGP SIGNATURE-----

--uASB5lmnUcH9/cF9--
