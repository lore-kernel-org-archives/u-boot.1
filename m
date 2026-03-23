Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B358CF483F7
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 20:20:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3188D84065;
	Mon, 23 Mar 2026 21:20:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZFby8nBH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C49D840AB; Mon, 23 Mar 2026 21:20:13 +0100 (CET)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79C8E83FA7
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 21:20:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-404254ffe8aso2949391fac.0
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 13:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774297209; x=1774902009; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wmUWbQwgDI/xz/v83ociz7E1S3q6xIeC6bUlxTYNiZ8=;
 b=ZFby8nBH+7795NoXqD4vDgBFTLaZXcXMsx9IuGTyLpcdjegc9qF6XOJsULOvkQDWsP
 aC4SKGmH1eLTktUaTGAVyt2+XYkPcZJd0aNbTUn7aclDp+LTi2gkdJPhv/73bfmw4/hD
 AmHSWv1/2oN7jQlEBFZTIzaCTUzbnzD8JO5II=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774297209; x=1774902009;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wmUWbQwgDI/xz/v83ociz7E1S3q6xIeC6bUlxTYNiZ8=;
 b=ax7xi3VtVrJHG511WOJkUnR6yfYjAb8P0KKYbWU8nahbPEItUOzo4r664/PCfCvRdu
 3TE0McURiGpLZESIFgezqDf5m+XerEf3yvzAzMsVzo1usUseABxyc8dR225lRGuPHYD9
 +KXiHNY09Z3bQQWrTneic1GMVj1UZ40oWvoou6n7NAvwDX8S01epBGVkHHd+J9GJo8io
 2ws9LTDy/oqegGAeF4bZdIN0tUwH1YPrKOCmsEpwZE9LYFUepNjRlc6HnzOw/xbtGEL/
 XNjGlttPlUWO47ysPkuqgnVJRKG9R0PpDG8/0hehO7ZQ0KmJePAND6nw9mEvLZDNWtO0
 VYYg==
X-Gm-Message-State: AOJu0YxE16jhfUXe6A/L//evwFr+nrKjkQIsiG8Y26nPtqdeGtnPR67I
 vQunBZt5XN/ojM8ps62U5NKJKgYd4IBs1bTRsxxCrC4+E9k0oEqUGtnYcoqNxMZZEYowvetX7vk
 a2P/RRDU=
X-Gm-Gg: ATEYQzzaFNkLCwN2zUZwPDAGn9l2FTylycbOcd0JgwBhqm1UOecb6862Ubx7quJOiSA
 etIzH1qL1lz7ThZr6c2dHslCblD8g6/avaJO3epzND+4ijWLSRcoPF+IoMmQ7001nK2cgqpVudl
 p6r6tqxx7AX1T8r0eSQtN2SMaoGhZltUJm6K9gSx7Jzjgi7sc07HVIKbvnjPQxG3QFQlWyMpeR4
 5PfWJeay2wu0JDy6N1AAEqashvLJIryo7SKQVkNMkCOzqOKXfI3tdLR1zXTabej+uJN3oJ2J1dP
 KI2Y4KX/KAUmaLB0xpAyPwnKRp7jbnL4pwvVKIctarYztQerN9ZkzgDXk/b4XO6xLWNwC90m5aK
 9/n4TMI0uHogJmxyv+S6G/YrRwSQqyePuMdGf7dO+MIOf4Kj/JzCKJdyjB6BI276fmOHl17rp43
 2tnDYm2E6hdhUf5QgqsDSXuir3KaAQXN7AcehQSFb3ZuQUnTR/VHJggGklo9ZK5NMe1jXqtG6Y6
 RylkCqvuvPSlgRfcchPNVu3q354z4SVGcW4f6WXMZfvlGHk
X-Received: by 2002:a05:6870:7d15:b0:3e8:9b72:5cda with SMTP id
 586e51a60fabf-41c875b66e9mr617219fac.11.1774297209156; 
 Mon, 23 Mar 2026 13:20:09 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41c14ddbcb3sm11224427fac.14.2026.03.23.13.20.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 13:20:08 -0700 (PDT)
Date: Mon, 23 Mar 2026 14:20:06 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: [ANN] U-Boot v2026.04-rc5 released
Message-ID: <20260323202006.GL502704@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yAaPUHOID4mUDQ8t"
Content-Disposition: inline
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


--yAaPUHOID4mUDQ8t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

So it's release day and I have tagged and pushed things out. We once
again have a small delta from the previous release. It's a handful of
fixes that are also pretty well defined. If there's any regressions
still open people know of, please speak up now so we can get them
resolved.

We're continuing with a community meeting following the release and the
calendar link is
https://calendar.google.com/calendar/event?action=3DTEMPLATE&tmeid=3DMHYzYz=
Q1dWh2bnRjcm80czVmcDczYmhsNThfMjAyNjAxMjdUMTUwMDAwWiA4OWJlN2I4MTMxMzZiZWMwN=
mE4M2RlNGRhNTk3NDVmMGFiZDExYzFiODM2MDYxYWUwNmMxYzdkYmNkMThkZjQxQGc&tmsrc=3D=
89be7b813136bec06a83de4da59745f0abd11c1b836061ae06c1c7dbcd18df41%40group.ca=
lendar.google.com&scp=3DALL
and once again this is the same time as the previous meeting. The
meeting details itself are:
https://meet.google.com/icv-nvmv-dbf
March 24th, 2025. 9am (GMT -06:00)

To join by phone:
https://tel.meet/icv-nvmv-dbf?pin=3D5493171900556

In terms of a rough changelog:
- Platform updates for NXP, Raspberry Pi, MediaTek

This is the final rc before the release on 06 April 2026.

Thanks all!

--=20
Tom

--yAaPUHOID4mUDQ8t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCacGgdgAKCRAr4qD1Cr/k
Ch3+AP4p908Omuhn+rogiKXCHFOfnvD5r70rnCtQyT6FvSMrOAD+JldNgqZviL8U
yhQ7VHSxUstjMz1MH3QrQeAoVU+P+Ac=
=G1Cv
-----END PGP SIGNATURE-----

--yAaPUHOID4mUDQ8t--
