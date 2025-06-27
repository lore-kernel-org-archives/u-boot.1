Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E444BC7EE2A
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 19:10:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6ADFE82B6B;
	Fri, 27 Jun 2025 21:10:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QoSE15kY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8963082B6B; Fri, 27 Jun 2025 21:10:12 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E05F1806D8
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 21:10:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-40791b696a2so817398b6e.2
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 12:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751051406; x=1751656206; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zAw+Sxlwhfrc9aaJXa9bPn/g9jdWM22ekHkARPQJpdo=;
 b=QoSE15kY78w+W601RuvUa08gcsOIbTsvXrQQTSGqmcfCvr53N9quuIHBtyVw5a44mE
 41X05ZbrroO7NgtClA7LIJQnD17mvqNxUDZx9S1Cf78T+qTd3jr7JfgYpj99lHUKIZn4
 SskKQ4pv7k7ztyq/M0o3nDSf6Vu5MedMQn3RA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751051406; x=1751656206;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zAw+Sxlwhfrc9aaJXa9bPn/g9jdWM22ekHkARPQJpdo=;
 b=oo8ER1oGJdRGGclPNWBubxZKEEM1KN22c8B+sOH0PUKFOXaBMl8VTmFZYUfJAiA6bq
 P2yIPRbC5reAyOMQE/KzkMXjSiqis115SORLA/MrkZXAM3X49fItw7nLSPKGn6ha7KNd
 NslXXMhP5bKQPDOaZsMdojnHJVq9pIrkORfIhBgcr/4ZXIeqxpd3F82L8i/MFcuTFfAQ
 xk9fJh4KY4d9jPZEPD/FzW9DXtOpSR1jZSQMkTZXEdP3aCKQN8fCrL3DdTWpcoXBkzkW
 XClVS1XMNyCicLygEJYINV0tv1/SgCX9EAy07kqcB9qTk46Z6LcHklIeB5Zq72/hAJFy
 ffhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3WXe5ajfhUozL2xddFbrAuhjxTGjQ7DiJh4yuz3/Kx6o6LZqn5DFzZIKleLlRCXisH/PVc8Q=@lists.denx.de
X-Gm-Message-State: AOJu0Yxju41sX2ikZ/b85lAvjNdeQd9H6vrWfc80shHkJ3jDpv3G0Jm1
 JsP7dNLbNMtjRrEef+9GD9ibecXH3/F2wsQ6gfsQvSj9yc6DHtVMriSc5psRgX5Gj+8=
X-Gm-Gg: ASbGncvHdvCJEXZo+AV1bhNURJitkZg2n43MMrWE5/GSxlUcdVHuaxCXzxWGqyRC9WS
 lKgce22nKPnqReqtmDit0jm5Dj7/kSoB8pBsdMZbgA2H20HTFIPuEPJP+wfBc0l3gqP+g1A4qZE
 9POB0KH6pEso4jLtg+I5xF2cJ/AjJhYnhaGeXQhbzCyKiLsq1ZwyOiJ5VSp9uBx5R2uRU8D3OZD
 cpvpbuHT1QQlZ9YVfA8NCY9lQUoIMWJdQwVwtX9xhbzJMpRT8/F6QG24XNSx7CNrCutUXpvq0fL
 QfwCyVuIGLDRd/lDCowNhY6kigU4wgehQU8kXWFtAvkbWmtEkX7u0XdD32Ue9o+adAM7u4cjTP2
 N3GzkhPnuWC4aWX/i2Ap9tXA=
X-Google-Smtp-Source: AGHT+IHAjmj9/SN7tFYjG4LmPi4GG0yHRmv3nfkxzGgbCCH38hpIMk0Wk10WsRAHfnS8H9Y4mMya3Q==
X-Received: by 2002:a05:6808:1921:b0:40a:ba8b:ee61 with SMTP id
 5614622812f47-40b33c5d605mr3716171b6e.10.1751051406262; 
 Fri, 27 Jun 2025 12:10:06 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40b3243e189sm473330b6e.49.2025.06.27.12.10.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jun 2025 12:10:05 -0700 (PDT)
Date: Fri, 27 Jun 2025 13:10:02 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: Andrew Davis <afd@ti.com>, u-boot@lists.denx.de, vigneshr@ti.com,
 nm@ti.com, bb@ti.com, u-kumar1@ti.com, devarsht@ti.com,
 robertcnelson@gmail.com
Subject: Re: [PATCH v4 1/2] mach-k3: add runtime memory carveouts for MMU table
Message-ID: <20250627191002.GH4003484@bill-the-cat>
References: <20250618124210.1936140-1-anshuld@ti.com>
 <85f6fdb7-73ea-4617-b82a-fb14369315d1@ti.com>
 <20250627180912.GG4003484@bill-the-cat>
 <623b8617-09c1-4006-9a76-907182ff4387@ti.com>
 <DAXJVPUUZAW1.P62BXQ73VB7L@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wG6x4EVIHlP9bR53"
Content-Disposition: inline
In-Reply-To: <DAXJVPUUZAW1.P62BXQ73VB7L@ti.com>
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


--wG6x4EVIHlP9bR53
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 28, 2025 at 12:38:19AM +0530, Anshul Dalal wrote:
> On Sat Jun 28, 2025 at 12:12 AM IST, Andrew Davis wrote:
> > On 6/27/25 1:09 PM, Tom Rini wrote:
> >> On Fri, Jun 27, 2025 at 01:06:50PM -0500, Andrew Davis wrote:
> >>> On 6/18/25 7:42 AM, Anshul Dalal wrote:
> >>>> In u-boot we only provide a single MMU table for all k3 platforms,
> >>>> this does not scale for devices with reserved memory outside the ran=
ge
> >>>> 0x9e780000 - 0xa0000000 or for devices with < 2GiB of memory (eg
> >>>> am62-SIP with 512MiB of RAM).
> >>>>
> >>>> To properly configure the MMU on various k3 platforms, the
> >>>> reserved-memory regions need to be queried at runtime from the
> >>>> device-tree and the MMU table should be updated accordingly.
> >>>>
> >>>> This patch adds the required fixups to the MMU table (during proper
> >>>> U-boot stage) by marking the reserved regions as non cacheable and
> >>>> keeping the remaining area as cacheable.
> >>>>
> >>>> For the A-core SPL, the 128MiB region starting from SPL_TEXT_BASE
> >>>> is marked as cacheable i.e 0x80080000 to 0x88080000.
> >>>>
> >>>> The 128MiB size is chosen to allow for future use cases such as falc=
on
> >>>> boot from the A-Core SPL which would require loading kernel image fr=
om
> >>>> the SPL stage. This change also ensures the reserved memory regions =
that
> >>>> all exist past 0x88080000 are non cacheable preventing speculative
> >>>> accesses to those addresses.
> >>>>
> >>>> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> >>>> ---
> >>>> Changes for v4:
> >>>>    - Add call to k3_mem_map_init for beagleplay
> >>>>    - Mark reserved regions as non-cacheable
> >>>
> >>> In v2 I said you cannot mark any regions as non-caching. How did this
> >>> sneak back in? If the reserved memory region is marked in DT as "no-m=
ap"
> >>> it must not be mapped at all. So NAK.
> >>=20
> >> Presumably at the top of your mailbox now that I just pushed it to
> >> -next.=20
> >
> > Yes, this bubbled up to my attention thanks to your applied to -next me=
ssage.
> >
> >> Should I revert, or expect a prompt follow-up to clean things up?
> >
> > If we get a quick cleanup patch that maps the reserved regions as cachi=
ng to
> > match previous behavior that would remove much of the reason for this p=
atch
> > in the first place. Removing mapping the reserved memory then we will b=
reak
> > remoteproc loading. Both have issues so reverting will probably be need=
ed
> >
>=20
> The idea of the patch was to carveout the optee and atf's reserved
> memory out of u-boot proper but I blindly mapped every reserved node as
> non-cacheable which was not the right approach. I can send a quick
> follow up fix but it would likely remove everything this patch added to
> begin with. So, I feel it's better to drop this altogether and I'll post
> a v5 later with the required changes.
>=20
> Aplogies for any inconvenience.

OK thanks, reverting shortly.

--=20
Tom

--wG6x4EVIHlP9bR53
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhe7IEACgkQFHw5/5Y0
tyyKSAv+MnjIc9fBbjOYdNhv790DKFuSAcjykcUKDwp2wPob8LXWlx7+eaoN6WKc
bfPPJg+bxg/xZGq2uUme8sTUuSItFa6a2MGMnTZv+Cv3sxAUe/tbc+UVgPi9M6K6
EPouL7OJtTAnPij8/owGIjrKH6MbkGSn4Te5lyQTV3d+jbZE7gM/FCbRCVtNNboR
OIj+hvGMs6/4XXS6G3n/4qKJxoHXBPz6XyMnebWVXn3xIjWU3wVyCzp6+76A8L97
VZdHcXUvB4u/8S/8v8cWdg0fO5YtGviZnNcPoT/DKVFNt1d457Xo21DctuHZoQi7
v6IB++snELqU470mZFtr5f20uaay5cgCxqzcNKYcWT7UUaGJR2uLRg6gr46QYwqx
YqZE4AbgLqYNYrrp6CuslDzpK3Q+NUKaMOPY+uxZCD8TqTLORKF6KgkQ7H7UofPa
OterJAKdt5Jio+dijTJPVrroxn4ZZ1krv5eJDPkNMRPJOotYZf6F+dZ1IhmI+dra
RnFzgNoX
=ozAz
-----END PGP SIGNATURE-----

--wG6x4EVIHlP9bR53--
