Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1DEEC02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 14:33:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45A3A80B98;
	Mon, 10 Feb 2025 15:33:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uIrM45Mo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4D55807B1; Mon, 10 Feb 2025 15:33:19 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5C0380BAA
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 15:33:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-6f77b9e0a34so32282847b3.2
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 06:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739197996; x=1739802796; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2QaS2WOyFLE0CEpuzN6UuBrSzIBoNSgaWBSj6pxt468=;
 b=uIrM45Mop32lcwGPjqzkngMxbcXnBIzoizXxRUgFj//53kmwKaMYcOwxRFgPuKV5bW
 3oDs+R7VMbkoQQD0PXdqS0Qt9G8t4z9ipncxMdJG83g4zQ51pEIJCLGzEh7Bg+2ZMfC5
 Zm9j8anQ9IvHlPvG4VPoKqKzifGcY8v0k0uDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739197996; x=1739802796;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2QaS2WOyFLE0CEpuzN6UuBrSzIBoNSgaWBSj6pxt468=;
 b=ZAP1WtVq1MvnsralxFymzNhZAzffEZqzePH4dX182qUwUizjqWQjfVrDwS6HjsyZYH
 DW3MSGcSeRseX7l6arkoiuOJhrI+Z1SimlCSWHSvHO63N0yraJOh6TuFu11dC3nNDxOA
 LuEvVDl0yyi9YZdtF5ykcrXFRH1kE3ZnXfyxSqnPOejuuTSKtyqvs3Ydb96pPFohecUk
 hYmQFpyRSRUjNsnFHODXcm69SA2eqHTwDU7mhTitaZFgY+VCOHfr6HIv11xVRGusAwGK
 X6WyxTCcYOIZzihvduYO1p8m4kb8pEuWG5NqablN7XuBrPbsmdwjmzkQ+Jjmq83J03rU
 HAIA==
X-Gm-Message-State: AOJu0YwaVPT1I/m/kkX/NuOHatcqEJ757aeaD8rPdlA//FH5afaaebzy
 wksND6NZ7wn48P2vDEabS1te00vu9GM35XN1X7/dIkGUpYz2z6iboJmANr6a8oI=
X-Gm-Gg: ASbGncuPUyQNzq4JKTrIrwg0UFPtX1WdM8W2rRMRkbubTZ0b1DUDLNeJU+4ZIbay8WN
 zhXGOqBieUln37J67Pg8f8TospnrsRNeXCpTC+wtbF5tAh2RSzMmXad/z+k5U4BwJM/p6Era2JB
 AwanvAFgYFkxEluAZr3XiqQsDbd7UIs6mxQxHSIpL2CaBXMokyUksYQHtrQFcArY35jZZMi1xq/
 gjCS5ctRCOZLj6Mv/TDr2GOe0bWT4offqk8xwpxVwL4a9aedT26mHPjjkmAUu4z6gzi7Ua7z4Ef
 zNywViPU8EAOKAY=
X-Google-Smtp-Source: AGHT+IGfB28CwIBgbY/zk8+5ry1gH0o8Ck4Qh2NP6jQ1Uh5eTkHR7TnNJAit10OkrCxy170ZV+Wv4A==
X-Received: by 2002:a05:690c:4c10:b0:6f7:55a2:4cf5 with SMTP id
 00721157ae682-6f9b2844626mr115074467b3.2.1739197995665; 
 Mon, 10 Feb 2025 06:33:15 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6f99ff6a903sm16666017b3.84.2025.02.10.06.33.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 06:33:15 -0800 (PST)
Date: Mon, 10 Feb 2025 08:33:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alex Shumsky <alexthreed@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Joshua Watt <jpewhacker@gmail.com>, Levi Yun <yeoreum.yun@arm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>, Stefan Roese <sr@denx.de>
Subject: Re: [PATCH v2 35/35] bloblist: Allow using a different bloblist
 address
Message-ID: <20250210143312.GB1233568@bill-the-cat>
References: <20250209211502.2299245-1-sjg@chromium.org>
 <20250209211502.2299245-36-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="g8cJVNlVNEmEs8nw"
Content-Disposition: inline
In-Reply-To: <20250209211502.2299245-36-sjg@chromium.org>
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


--g8cJVNlVNEmEs8nw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 09, 2025 at 02:14:56PM -0700, Simon Glass wrote:

> Where the bloblist is located in internal memory and TF-A's BL31 blob
> removes access to this memory, the best option seems to be to relocate
> the bloblist just before running TF-A.
>=20
> We can do the relocation in board-specific code, but need an option to
> pick up the correct address within U-Boot proper.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> Changes in v2:
> - Move the actual relocation code to a previous board-specific patch
>=20
>  common/Kconfig    | 20 ++++++++++++++++++++
>  common/bloblist.c | 15 ++++++++++++++-
>  2 files changed, 34 insertions(+), 1 deletion(-)

I'm going to NAK this whole concept. The whole nightmare thread about
these platforms comes from using a fixed address. We need to pass in a
bloblist or see that one is not passed to us, via register. And then use
that mechanism to pass the bloblist to the next phase. When we don't
have a bloblist passed to us, we allocate one, and not at a fixed
location.

--=20
Tom

--g8cJVNlVNEmEs8nw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeqDigACgkQFHw5/5Y0
tyxxagv/VvVyOZsExzqhQ8cdKbaMPGiispl/83F7iJrxCMRFu4dMK5OVhhYzcggs
4fi/7GNfoWGQwBeI654EGuNSvF9hmyVxjAjyR1zb6dt0/BIbvHAyUccO1l3u7bvS
pqfkmw7XRoAUke1IKGloRKa7UdiIA3JML/THbkeJDfz2Qck22b0MY7tM6+lbKErY
URI0X5jZZgPB1Au3tayu3+HLutlstU/56JGqtDnaexZEGcZNESuYg9V6KzUcQ8Nt
FoI2vXn5BeulNflvqQ7y0LTilUXs6erYS1uv3SklAsyRal9kAvuRlD4uT+w/TPLW
vxu71Hmkk2VjZMTVcT2IEPIvzgenzuMzswv/RImOqlLi7H4ClEV5Kn+Y2SlTs+bX
YqYuQuQ8yB9VYkY5cnK0DG8DU4VYDM2fDZ4K+xB9Qqe6bo3rCwxEdrDS0OzyJtXy
m8HrOISlYx423pj269YAQeK9Z0nDIV3IpEe1cZhA3zQQNd0423WZTjb5rwnC+ecL
7Dwk9VvB
=9fyh
-----END PGP SIGNATURE-----

--g8cJVNlVNEmEs8nw--
