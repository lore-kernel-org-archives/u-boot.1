Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C1FCCFA13
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 21:43:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A95E803C6;
	Thu, 30 Apr 2026 23:43:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ci792wvf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24F5E8063E; Thu, 30 Apr 2026 23:43:25 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B4A080086
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 23:43:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7de4e6c5a30so1185620a34.0
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 14:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777585402; x=1778190202; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vLPT0TzGlKGC9cKCvnEI0IeZQ/1p9PhDwzs1vrMZN+o=;
 b=ci792wvf9ZQyoAQVBidrpaklsJtKv0jfCCYf1F8la5md/q6jalVMOFskk1ZJGs63Dl
 Vwe09ByCL3V5EvCME1xma/c9ieBSJng3jbWvn0r0C0cpk/dCxVAvpnV/mH4/WioJK/QT
 NUOa0wG0anPXUUhVHpxGwUIfmApYnGU0+eKwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777585402; x=1778190202;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vLPT0TzGlKGC9cKCvnEI0IeZQ/1p9PhDwzs1vrMZN+o=;
 b=qzMxcV6sazbXutSu0UjfHrsVWHhu/m88c+ekQ+EChM8ApNOIemYCgJV+4ECazzvWPY
 9y0M3CwAt5DmOhN4ZTEhwK8caE1FVovcpmU5znKvZlnmrQx81TRY5vinDUI8R4lur06j
 tnoP+3qfGkpIm/LGY0W9tFIJvkGrPVo0eCI+8oN8oU/I2ul+Gj+VQDBly+Lo/A3YpJDK
 ROOZjZ+OgkTDj4kutkAQJ0JM3q4A1GHEsysRGJvYX74kVmYl56D5UYPm3qdMjgHqHv8f
 EDl29VwbaoW2xTWHpkhwqc53WRwH89X5tk+1/4+er/pH6RgF42JzqUPcRL8cEuonHj2G
 MMmg==
X-Gm-Message-State: AOJu0YxdqmqBYbqLOb1qNKvT85RHoi+J7v4A6HHfgopJQKDCxeMEm6uu
 8wbROcPVgGH6q9Zv35a6WRQxDW2ydNYiUm6WlB/Ml4KDR96i6B/CrSqFWnv3VrcxOjZkwi1ciHi
 1mMRqCjWKDpNi
X-Gm-Gg: AeBDieupZP/LGjCU2VzfDOa6O/+JkG/VVEBmHCwrFbHYuqhuQIRZeICN5ioSIUplxhF
 to7rHXKwlsgmjC0MBJwrpVQQpqwAdnibt36Jxwl5VU00CvHbx6jwiXaK1/VrOjP0Nrt19qF5sDI
 IxOMA2ZZ+L7SDp6LhKQIFCgmdhytnxthbYYLwMgzUZGxq9z0AQ677ZJBtbm0OY+oMojB6wiTO2j
 bhpLWbuwzmTCtEHVxglrXP6Ge8906xkr0U2kG5iUUXBxwEm1gjDnVpLClG001oSAOU2KnAI8p4g
 BnhEprytaRWR/U4ODTk0l8sbwy274GFKW0wCXHCY/tWtlO/bF25qrtc3DVJnyNFdfPJPGCMQSwY
 guZWBCS8cnpvCSE4BuCNz+dK1bFpHMZ5lcmVdtRaWb3nqREaszTaBrCL6d/IapwhAXIlzKBtmyK
 sraaufMC0gz4aDUpjgLynqdijdhYfbI370zg3Ku5juePcNTL5m9Nz8GheVmuxMZYLbZIpmMULaQ
 9+UAMTtKwWmxVIyIaCKOvJ3cJ9iW/hH4aTK6SV8KaWwnh0A89Yn47dwPHgjZQ==
X-Received: by 2002:a05:6830:6739:b0:7dd:f615:a84e with SMTP id
 46e09a7af769-7deba2a2c66mr2931088a34.18.1777585401782; 
 Thu, 30 Apr 2026 14:43:21 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7deca7a5e75sm748457a34.2.2026.04.30.14.43.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 14:43:21 -0700 (PDT)
Date: Thu, 30 Apr 2026 15:43:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Janne Grunau <j@jannau.net>
Cc: u-boot@lists.denx.de, Mark Kettenis <kettenis@openbsd.org>
Subject: Re: [PATCH 0/3] Switch Apple silicon boards to upstream device trees
Message-ID: <20260430214319.GD1614990@bill-the-cat>
References: <20260430-apple-dt-upstream-v1-0-dda66c16e0da@jannau.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="120nPYiBJToqt0un"
Content-Disposition: inline
In-Reply-To: <20260430-apple-dt-upstream-v1-0-dda66c16e0da@jannau.net>
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


--120nPYiBJToqt0un
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026 at 11:25:45PM +0200, Janne Grunau wrote:

> The Linux device trees for Apple silicon devices cover now most of the
> hardware as u-boot's internal device trees for M1 devices. Linux has in
> addition device trees M2 and M1 and M2 Pro/Max/Ultra devices which were
> never added in u-boot.
> The most common use case for u-boot on Apple silicon devices does not
> use DTBs from u-boot but passes runtime modified device trees from an
> earlier boot loader (m1n1).
> This change regresses support for the DWC3 based USB-C ports and the SPI
> based keyboard on M1 and M1 Pro/Max notebooks. The regression for the
> USB-C ports will be fixed when dts/upstream is synced to Linux v7.0.
> The dt-bindings and device tree nodes for the SPI keyboard has still to
> be submitted upstream.
> These regression are in my opinion acceptable due to the limited use of
> u-boot's DTBs for these targets.

Very nice. And note that as of v2026.07-rc1 we've re-synced with the
v7.0-dts tag.

--=20
Tom

--120nPYiBJToqt0un
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCafPM7wAKCRAr4qD1Cr/k
CuggAQDYkaIlWTBrPXe65hrlylNjRt1Rnyrg0QuqBK7zNaXWBwEAiOQ3c/8mS76S
oFe2QHD3dAvCYZ9+VahImfTwv69yNAY=
=94Vf
-----END PGP SIGNATURE-----

--120nPYiBJToqt0un--
