Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E88AAD12D60
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 02:52:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DD598920C;
	Mon, 11 Nov 2024 03:52:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AU8MVdjT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A1AF89189; Mon, 11 Nov 2024 03:52:20 +0100 (CET)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 250DF88E61
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 03:52:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7b1434b00a2so329562085a.0
 for <u-boot@lists.denx.de>; Sun, 10 Nov 2024 18:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731293536; x=1731898336; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Jp2e/1wrFb63J3S0GlYgNUFGrMdLeQEWKGEFNhrbCl4=;
 b=AU8MVdjTJrwBQH+0WapOsT66tDOlbW+Md4lS4+tqrj7lSOOyrY3W6KCqRdEuiXWtcZ
 b3QkT6U876LbrU8XmN0ED59hmNX3DG4qTNjxcqUCxcTMj5wwSg73JIzudEGevYmeAKdz
 LyAjZQBt9gcEMJYTvHtQVsjDW/CA+onmI+134=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731293536; x=1731898336;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jp2e/1wrFb63J3S0GlYgNUFGrMdLeQEWKGEFNhrbCl4=;
 b=Av7+zmrLjiGwaP1pntxll7LzX80hDWUlxR2TRsUsaeokWlulS8bMNmD3DlWdAJ2BoW
 88yaKo4N2QYw3LzaIZlMvsfWfzBld4tHXkhFpdvyQmujjCTOavBawq7bQuSK+YyHrU4h
 fr8jr8HzLx/HhdZ1aqijDD/THApMbCPO1hqOP07H3u0/oIxwtdfpWwFmsngLQgjDYqiE
 b0JXITkyeIoh0KXps0z7FfXO5WoNJ23riLljDlc2hEfwdsK9ES8GJPmIk26OlFxpksuH
 AFz0qhJ9IYj/l4f8Idz0ZMRvmnl1LNzIvYpns4Zx8O5hoO9eCzE+T3jIHPioF70XMRsn
 JDvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8yNevUXELWmVlI5hyny55t6J0gQJ1XPBQKxB/T4ep7vdACK3/lpfMlRZ7NQQVTeJYy89SYZw=@lists.denx.de
X-Gm-Message-State: AOJu0YzerYJ5gkv7knSdKgps+dVCqHGttbi6mFIrtsYbgsAmDN82tMHR
 dKoNb4ewbLvHMNQmETp5ZFY6MNXbPY05XHFaUJADBelmGX+sVfqqWATrmaaQrv6lFxS7PbCZW/5
 BSYE=
X-Google-Smtp-Source: AGHT+IG7RAEgxZhStWX3oK7BcsTEK5bcdlq4dJloMsBRa5e6ontax2jSVslal9fircYmXGXKO1jWjQ==
X-Received: by 2002:a05:620a:170d:b0:7af:cf44:9292 with SMTP id
 af79cd13be357-7b331e8c6cfmr1470542085a.24.1731293535877; 
 Sun, 10 Nov 2024 18:52:15 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b32acb30d0sm445454385a.94.2024.11.10.18.52.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Nov 2024 18:52:14 -0800 (PST)
Date: Sun, 10 Nov 2024 20:52:11 -0600
From: Tom Rini <trini@konsulko.com>
To: j@jannau.net
Cc: Mark Kettenis <kettenis@openbsd.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 0/4] Fix IOVA allocation in Apple dart iommu after
 global LMB mem map changes
Message-ID: <20241111025211.GQ3600562@bill-the-cat>
References: <20241106-io_lmb_apple_dart_iommu-v2-0-0580f4bdb023@jannau.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7QDT0Pe0dDy9s/Nb"
Content-Disposition: inline
In-Reply-To: <20241106-io_lmb_apple_dart_iommu-v2-0-0580f4bdb023@jannau.net>
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


--7QDT0Pe0dDy9s/Nb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 06, 2024 at 10:10:08PM +0100, Janne Grunau via B4 Relay wrote:

> The changes in "Make LMB memory map global and persistent" [1] break
> mapping DMA memory in the USB xHCI driver when using the apple_dart
> iommu present on Apple silicon systems.
>=20
> The IOVA space used by the u-boot driver (low 4GB) and physical memory
> do not overlap. The physical memory on this systems starts depending on
> the SoC either at 0x10_0000_0000 or 0x100_0000_0000. It make no sense to
> manage these distinct regions in a single LMB map. In addition every
> device has its own iommu and IO address space so sharing a single memory
> map between all iommu instances is not necessary.
>=20
> To fix this issue restore the used subset (add, alloc and free) of the
> previous pointer based LMB interface with "io_" as prefix.
>=20
> To ensure that low level lmb functions do not use the global LMB
> variable reorder lib/lmb.c so that the variable is not visible.
>=20
> Tested with patches from my "Fix device removal order for Apple dart
> iommu" series [2] to fix a separate issue.
>=20
> The cosmetic commit has two checkpatch warnings in existing code which I
> ignored.
>=20
> [1] https://lore.kernel.org/u-boot/20240826115940.3233167-1-sughosh.ganu@=
linaro.org/
> [2] https://lore.kernel.org/u-boot/20241031-iommu_apple_dart_ordering-v1-=
0-8a6877946d6b@jannau.net/
>=20
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
> Changes in v2:
> - added io_lmb_teardown() and use it in dart's remove callback
> - removed leftover from copy-n-paste in io_lmb_setup() documentation
> - added Tom's Rb:
> - Link to v1: https://lore.kernel.org/r/20241101-io_lmb_apple_dart_iommu-=
v1-0-fe4b9a74d47c@jannau.net

Sorry for the late reply here, can you please rebase on top of current
master? A few other changes / clean-ups have gone in and I can't easily
rebase and confirm the changes right now. Thanks!

--=20
Tom

--7QDT0Pe0dDy9s/Nb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcxcVMACgkQFHw5/5Y0
tyz+RAv/RM6CSLx5RAAZ64fcO7TwJDTqXK9K3tVyf1IjZWwDog7vIK2hDOmEbD2k
OoITs2OPjEKXkSqv/YzoczmGqiRVVB/yptEjP/n78/TLU89Kf8N1Ew/mfbBFusT0
7yDp/+0EYv2nzgA5lWkdkkCkyiK/9b23CV3URs8IWJFKIK3KGffNfcq8g4ETobN6
KvfJLYW5AThdfAA6pS0oenSF01LB2LWrqSqWAsS5pywoqt9O05YBYPaZgosUY438
Fmkp/s7PT3PhUwTFaYYz18aKD1rK+TP8OR83pVHOIugcbdUhLqa7B2NTEIuoFs/6
feu1sYmtwgLNnZvz/Jeer8Ro5kz1h8bB/JN/pc5rIUqDFKXcjGalcWxJcy/LQbk+
mYH63OMqkeSvkTYrwoppe63Mb5PxTEopC7TY3gusdxQBF1gabJhyW9pzi6f+CmQv
gbYXQ3BTwo/IYjEfnwQuYBgq8lqpXYnfZq7y3SD4M7H7+unsX/pKpR4xGeuCwuYV
F+fxrYsI
=5GcO
-----END PGP SIGNATURE-----

--7QDT0Pe0dDy9s/Nb--
