Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16093C61DB8
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 19:10:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A1ED81F0D;
	Fri,  6 Jun 2025 21:10:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FNkvNkid";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9F3382145; Fri,  6 Jun 2025 21:10:13 +0200 (CEST)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A14D3807B1
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 21:10:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-235e1d710d8so30655155ad.1
 for <u-boot@lists.denx.de>; Fri, 06 Jun 2025 12:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749237010; x=1749841810; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Uur+/kP3QDfVszZX7lK4bfiNL20jerJYFAMsNfNPbsk=;
 b=FNkvNkidpNQmQsUydzDDaZj7iPUV3/fUvY9nZalIkXlUAWpBm7pKzhsCfia6JZtyxF
 xHVKMfnPKGR1LH0EMh6SfnC2oc8SY+SSC+Qv+8h/GaoMD46Rfw4Czxp2lZPGMRbpuaHo
 ugtaLrLYhNjMcVKobn67nvsKp8OpvygVbq6Yk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749237010; x=1749841810;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uur+/kP3QDfVszZX7lK4bfiNL20jerJYFAMsNfNPbsk=;
 b=jt44hiBGHIgJAbXxLD96JGInUXu71qKVGcJR+pk0NXoLba9s+9J1+Odyl9wALdf0WW
 QVcIsdzJbPek2Z+DGV7mRjqUVTftSq7+Pr/2OfH3Rucy4hCzA7XLLZVIiWiMzfv4XfTb
 IzT8JQnYT2HbttIv0VOz+wNWyTTXKdqlngpLbnZGxSvR2sASuyhVkiQCZWM79toiwoyF
 ywtfv+6WLF0SzcfSjZUw/eDK/vuYhqMFxm+CR5HutY+QHmPIor8LylSoRDJbygWjzPTF
 bNB22C8CKRrcx7TbmEWfdRozrsYlxptKU1yxtjre6R8OSAanBgyLCkg9UkaRu43xfuL0
 qJQQ==
X-Gm-Message-State: AOJu0YwoTMynRnBfN+UDXUB6iXYf5ZgVc5oaqsXAZb52hEPf2mpH6m+E
 BM/ieOwXYmzSFD+3jzNbPmfxwue+nRc3uT7m63mDpOcx8ScVxuhlx4D8Dpcm1AL5hSNekr//vHH
 Eog3ChGs=
X-Gm-Gg: ASbGncsuLfUIyJ8z6Bw8n1CndXiZscPJKY5fdl0T7IKDhwU+66ofbWCa9N2rsbxnDEo
 NdgOytULqhUgrV3vWgylva1gVAjqqEitxwXVsWj3mtdu8dzPQZeNwTh0S3D3jH8T9EYKtVz3X7q
 jtBmgJ2Il+tIfzURRSu9zOrvSTqBTzKsog9ufd8vWYnaz7UNCLoWgMxOHaOokXd+2Ad+46KRiT0
 n7io6PQtPa+pVIeHlM4kIIdOKwaOAfcibMmfebwtW7dvy95reh9oFlCOYDvWZx0i7Z5L1BMG3S3
 85BE5EqYmmE/HH8TXodbOIiiN7LGoKU9GgcS2iiVYtY4wLyCnmhxivDuERWeZtdrDBdHtdaJg+J
 MOw9vGdde9FNBgbqbIRJMo5M=
X-Google-Smtp-Source: AGHT+IHmeiii8Ad5130jXhxUy5S6Mren3P5RefnUeDB/g1VvrPA8ic9RoSW354bId0yc/S7EGxb5Rw==
X-Received: by 2002:a05:6830:611a:b0:731:cac7:3636 with SMTP id
 46e09a7af769-73888dba3a7mr2765615a34.6.1749236999565; 
 Fri, 06 Jun 2025 12:09:59 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7388a050780sm410507a34.35.2025.06.06.12.09.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 12:09:58 -0700 (PDT)
Date: Fri, 6 Jun 2025 13:09:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, afd@ti.com, m-chawdhry@ti.com,
 n-francis@ti.com, b-liu@ti.com, nm@ti.com, bb@ti.com
Subject: Re: [PATCH v7 07/10] board: ti: add default dtb for am62 in falcon
 mode
Message-ID: <20250606190956.GA1382132@bill-the-cat>
References: <20250603142452.2707171-1-anshuld@ti.com>
 <20250603142452.2707171-8-anshuld@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/X+q0kMxprc0cK2C"
Content-Disposition: inline
In-Reply-To: <20250603142452.2707171-8-anshuld@ti.com>
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


--/X+q0kMxprc0cK2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 03, 2025 at 07:54:47PM +0530, Anshul Dalal wrote:

> The SPL_FS_LOAD_ARGS_NAME config is used for the arguments to the kernel
> (dtb in our case) in falcon boot.
>=20
> Setting it in board specific Kconfig allows us to reuse the same config
> fragment 'am62x_r5_falcon.config' for all 3 platforms for enabling
> falcon boot.
>=20
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
>  board/ti/am62ax/Kconfig | 3 +++
>  board/ti/am62px/Kconfig | 3 +++
>  board/ti/am62x/Kconfig  | 3 +++
>  3 files changed, 9 insertions(+)

Why can't whatever is using the fragment also set this? Is it because
you're only using this as part of say:
make am62ax_evm_r5_defconfig am62x_falcon.config
?

--=20
Tom

--/X+q0kMxprc0cK2C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhDPQQACgkQFHw5/5Y0
tyxfhwv+KFvvBd/aN4u7MsxBZUqV3yU0fnSbso1t0eN3yCXzEhzTOJHkPiNCNoon
WjY0wne6Y3kAmZG/OMnJWA7Du9shFMzKdscrDKu9zwhEuycM0Kb1B4oxbfYLQFyh
7ekWdXEPoLsKhuE0fMtTFngOMx+9y27OZblzNscTNwYDlKx4NsAvomW2N+By8qt5
/TrNNieMLrNHpsT8YxGlyh8h9v/704AsStL/55xLD2WGO9rqrBFS0CyIgLmh/MZ/
3S9OeixuiT+2e/Rsj4n/wlsxVjo4I9Qo7LRHQRd1eI3vYDtZLB+3+EikzgEOA77d
THQrq5wy1vL5020ewvaKN4r+MxCf49AVyIyNzINpDdtbRN+anUHMYyOHl22nJoeC
/eBiEhPBeCftadG+vJ7UYPfKivrp1TQOYPew9fjwlskukmiAz7RKo0qEz2P2t7Bx
Az7R6olZANcTz/hXEN4l3tJm98bGbFLEmOMBzxtYB/G70z+6l3htj747UsoinTNX
iAFwokHb
=Bd9y
-----END PGP SIGNATURE-----

--/X+q0kMxprc0cK2C--
