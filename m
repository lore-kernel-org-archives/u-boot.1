Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08047CD3427
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 20:37:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D0488482F;
	Mon,  4 May 2026 22:37:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="raMz/SFg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A18B8482F; Mon,  4 May 2026 22:37:12 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD22F8394E
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 22:37:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7dcdd23fcdfso2495643a34.3
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 13:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777927028; x=1778531828; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ij2nH5sRnnJAiLp4zx0uyV20QxcOT0CiK2XvljfSTa0=;
 b=raMz/SFgxPyXL6Q/7mfbYX/mY/qH3AowGAJkbFb5I6MHCZb86OOloGdeINVZLYMfU2
 x7Bxyue6RrGuCeouLZcJVIjM1QwR7zMnhRBsOOsmSLhjcq6gSpi4FGhqP5/6LhdGhKb5
 3ZK9xTPvE0CxY3ksEvRmkpNx3E5O9yAzn53uY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777927028; x=1778531828;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ij2nH5sRnnJAiLp4zx0uyV20QxcOT0CiK2XvljfSTa0=;
 b=UmSQdYUA8kDlM0kEVptBgwPoiEqeaXNekDg/mCjpgvDjbKN+jcOMu9jlzhlvJOBJED
 P9K24aR9Zo+EqcbjVKyof1qdhit4Myk6tSQFR/a0+KaJe/yidNlUZU7L+Xy8SQx4YeAV
 LVUa4O66kHMwoRelflttCKP1EYZe6skzbX7jX32BNQi2boRNly3EOTQ75DRb0GQo8jEe
 VR6KYPsM3nsZDrCluCXKEg1RD7odDQQf3kY/bgX+sgadpQNX24VE4fcgmS8+d0kXgsPi
 KcPHDVy/FfgLbDT2aEZuv3pZ4oZIRF0Yomw+IYikYeLMzBj3escmkG/psLwn8KOSgi0H
 SiZg==
X-Gm-Message-State: AOJu0YyfU1a2+kEOsBiSmykH3s469ypyQQg2qf6elKd+rxJQppYWWpfd
 VTNfScIMT8ULVchkFTF6GRle2glwBUzSYIaNeNC8OJyUd06hlQ89sBDHpEJyQIhPfWc=
X-Gm-Gg: AeBDievU71c410zSwi2ktPSv+HIs5VU79rpNuvvtEu4+IpZMRGvUeixX9NpSGmnbCat
 +qeVvd5QYgLu2BfYsP9p8qxfaSZUjGF9Nv/UeiWQfBuKnyBLhyWF1MQ6gAmDS+1HfBFfX6ey9xS
 ZFL/DAThoajp/MxkjRVeXGMrT+NFoZRPgJQaxcioFhdpG4a7P9dNNUUfP3IHAle5S3n64aPkT/h
 sPaJZ+BYK2Nf16RLh59fR2YpJZxmGBVFwcX0yacbzOW1yVNno8HchUlUZFS4sIESTmi8hE8EHh6
 cgp613FRQLLkq9y6IZ2zyrWlbTDr+nU2cEM+CXVvDPPxyTKs4VhzesuhKPbIqFT8xvB3u/oG/II
 /y1w3q8wVgIzfJl6E1Ry4aN9ghKGU/bfNqZdLOhSeBf0TB6MvE034BYBkGvFAnCP3h6E9vlBhWw
 P6z8pkKT5CKuAiuFcKGA5xXCPnD9HPhJ/DZA2P9c4ZefAKfC9jHRRgxwJ/6HuJk2qo7aEOR8C0f
 H2YI80FDCiB+zyVojA03CvGaP6Z3zc/Tw5EiiVZcI7oEfM4rYWl9oVJ+qpJSw==
X-Received: by 2002:a05:6830:6f89:b0:7d7:da05:f2d2 with SMTP id
 46e09a7af769-7e17d054d91mr279320a34.16.1777927028626; 
 Mon, 04 May 2026 13:37:08 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7deca826dbesm8724221a34.12.2026.05.04.13.37.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 13:37:07 -0700 (PDT)
Date: Mon, 4 May 2026 14:37:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymondmaoca@gmail.com>
Cc: u-boot@lists.denx.de, Raymond Mao <raymond.mao@riscstar.com>,
 Simon Glass <sjg@chromium.org>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Michal Simek <michal.simek@amd.com>, Pranav Sanwal <pranav.sanwal@amd.com>,
 Casey Connolly <casey.connolly@linaro.org>
Subject: Re: [PATCH] lib: fdtdec: validate bloblist FDT before consuming
 libfdt size
Message-ID: <20260504203705.GA2985870@bill-the-cat>
References: <20260501222801.1596650-1-raymondmaoca@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/dlwuwb2CH5axlGv"
Content-Disposition: inline
In-Reply-To: <20260501222801.1596650-1-raymondmaoca@gmail.com>
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


--/dlwuwb2CH5axlGv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 01, 2026 at 06:28:00PM -0400, Raymond Mao wrote:

> From: Raymond Mao <raymond.mao@riscstar.com>
>=20
> Coverity Scan defects are observed in fdtdec_apply_bloblist_dtos(),
> since the live FDT taken from the bloblist is passed to libfdt helpers
> which consume header size/offset fields:
> - fdt_open_into()
> - fdt_pack()
> - bloblist_resize(..., fdt_totalsize(...))
>=20
> Add a small helper to validate the FDT header and confirm that the
> advertised totalsize fits within the currently allocated bloblist
> record. Use the sanitized size before calling fdt_open_into(), again
> after overlays are applied before calling fdt_pack(), and once more
> after packing before shrinking the bloblist record.
>=20
> This keeps the existing flow unchanged while making the size consumers
> operate on validated FDT metadata.
>=20
> Fixes: b70cbbfbf94f ("fdtdec: apply DT overlays from bloblist")
> Addresses-Coverity-ID: CID 645837: (TAINTED_SCALAR)
> Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>

Now that I've applied Michal's fix for the other CID, can you please
rebase this on top of master? Thanks.

--=20
Tom

--/dlwuwb2CH5axlGv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCafkDbgAKCRAr4qD1Cr/k
CporAP9XuBq3XNs13ZWGVDUV/w1EEQaFDvyecyM4/0UZz9LOWAEA+ZkOdpphux2l
1kczxHhveMz0AXsrMgU4jY/NZQ68uwA=
=ahZL
-----END PGP SIGNATURE-----

--/dlwuwb2CH5axlGv--
