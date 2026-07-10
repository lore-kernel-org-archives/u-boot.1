Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4607C44506
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 13:51:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FE8D84AFF;
	Fri, 10 Jul 2026 15:51:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pR+TZX1w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4669D84B01; Fri, 10 Jul 2026 15:51:34 +0200 (CEST)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30AD484AA1
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 15:51:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-6a1888969ddso575162eaf.3
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 06:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783691491; x=1784296291; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=99NvPRZmc2RPS8fh+T3uf/atju1EOMW5CxXWrv0XElE=;
 b=pR+TZX1wDkfQ3cDq7WGkIBwNr1e3olxLeljkJBtCglbgBtlJ+hxQVOV8v150MepZJC
 uX/+sty96VOJHpl6tjV0PSuNsMrHjZ38v6CSvgLZx92bTOq0zUZY1YKOcKxtlK14ET5v
 XElWZau3w/kE0qxubPgoO33lB5wWP3+zsFIgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783691491; x=1784296291;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=99NvPRZmc2RPS8fh+T3uf/atju1EOMW5CxXWrv0XElE=;
 b=Q77xd1osAjwjv9ja3+V1tBXHltubaYwlbemfo3KvPtzJdIPEEWkajBFreqNFJyyHnk
 1aifyfgZEctEjiTvuoAuRhXKbaitGcOeUvSHHUWXdqfUGRkh782ePyf6v+Rv3YHCtcvo
 XbBCRkndBnJ4ly7gbbihX+jB+PQlaKhCNjw3n0ky14HpfRyJtLkL1g0TwjvVdj482d4t
 r+bwe8NDm4HnHtoDOYr1mGKGjLeB/p8g4Ldn1Q/w+6WZqNDLzQMaxiVAXFiJX2oM5dt8
 KRPXzmPbn913BK7Pin+agNLbqERSTiZaB3orJlsSM96UrINmXux74d/wsCF5qQCz6O4c
 brKw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9oGKegcYqpprgw9O2BnIaPNnhB21IrgBPkTnpGW5YYOYnMYmJOA7k/Cvz2ijlKf7kJvau6BWU=@lists.denx.de
X-Gm-Message-State: AOJu0Yx/u+Aq/bLHZUsO1ceefiTxSjIJMEMDl0y0Y03O8CpI1M4Gl5Rk
 SzU0oq9wQTD3g7hZbX8L7uBVjFcHt0enVhrAMHajWHn4Og9q3HGw4hkZlGquYgqbpbM=
X-Gm-Gg: AfdE7ckq1rTbHsT5+4VKqK4fNlWwqNPlXIFN37gTY7ZE5zd2yrYODHXQlfy22iPk8C6
 8iv90SKIekQ90tk1tg5S9KkqTo0qlKTH8DBLxVUoYJ88XCsF4HGTGZuKjUjki447avNFJpTDyPr
 oyKTJI0/t3umG1zbQkVYDbSEs9qG4WEtvyAhnw52Ksj53ix4V7eVwzJuhCgUJJIHfoCRi9F7gyp
 6Yk/I49Hv7NBQRrNR0YKaHvOSP6JTwzK3PU1ejbNwtfY5pqCTLBuEK1LruIjoTAqYQqrO7REgkk
 a2SbHSVIekYZvI/YB2Cs/z/uaCmpIlpVeos54gxXzUtIi+wqJeesTNR9PU3NyvXxYQ9NyshNT5c
 ktzI/RfOuk0Q9Jg0Bxxm3olEDQRskG0kWkR5lwcNaGOQmQ7gQDTi5BxJcZqgCsIU7B/Une+sEM9
 KokFH8dkXHrBewnwHPABLV98jes7Ven8nifJL1Em41TWNmEuXTRf9IENsYu9P/R8ddhFl8DDFLd
 CtYVmu+E1tDZfsTgO9VPXx/ysUcyDJvlGkKVPgoRgJWbRMB
X-Received: by 2002:a05:6820:f00e:b0:6a3:98e9:c97a with SMTP id
 006d021491bc7-6a398e9cb2dmr21795eaf.72.1783691490864; 
 Fri, 10 Jul 2026 06:51:30 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a36a5eee0fsm6614532eaf.5.2026.07.10.06.51.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 06:51:30 -0700 (PDT)
Date: Fri, 10 Jul 2026 07:51:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 11/11] spl: Use CONFIG_IS_ENABLED() for LIBCOMMON_SUPPORT
 checks
Message-ID: <20260710135127.GJ749385@bill-the-cat>
References: <20260708220540.3368825-1-jonas@kwiboo.se>
 <20260708220540.3368825-12-jonas@kwiboo.se>
 <20260709015313.GV749385@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3h8QBai3V8PVHxTz"
Content-Disposition: inline
In-Reply-To: <20260709015313.GV749385@bill-the-cat>
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


--3h8QBai3V8PVHxTz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 08, 2026 at 07:53:13PM -0600, Tom Rini wrote:
> On Wed, Jul 08, 2026 at 10:05:37PM +0000, Jonas Karlman wrote:
>=20
> > Use CONFIG_IS_ENABLED(LIBCOMMON_SUPPORT) instead of directly checking
> > CONFIG_SPL_LIBCOMMON_SUPPORT when guarding printf/log calls to depend on
> > correct xPL_LIBCOMMON_SUPPORT symbol. Also change to use IS_ENABLED()
> > for the XPL_BUILD symbol checks for consistency.
> >=20
> > Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>=20
> Reviewed-by: Tom Rini <trini@konsulko.com>

So, this isn't size-neutral:
   aarch64: (for 1/1 boards) all +77.0 rodata +57.0 text +20.0
            ax3005_scm3005 : all +77 rodata +57 text +20
               u-boot: add: 0/0, grow: 2/0 bytes: 41/0 (41)
                 function                                   old     new   d=
elta
                 static.__func__                            285     306    =
 +21
                 fit_find_config_node                       240     260    =
 +20

(and a number of other boards). But I think it's a bug fix of
unintentional behavior today. So I'm just noting this here for the
record.

--=20
Tom

--3h8QBai3V8PVHxTz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCalD43wAKCRAr4qD1Cr/k
Cl5xAQCVifXEUgVJADXwMEr0QOFjSywG69dFm4nazrGUriC4FgD+PWFLBAvzG8Wc
SN28HjjO4hBC/8t/I+ZnrmUK0TGIqwo=
=bmdW
-----END PGP SIGNATURE-----

--3h8QBai3V8PVHxTz--
