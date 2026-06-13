Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28166CD98D8
	for <u-boot@archiver.kernel.org>; Sat, 13 Jun 2026 18:04:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17BF783FEC;
	Sat, 13 Jun 2026 20:04:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TYbudegM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F5588466E; Sat, 13 Jun 2026 20:04:07 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52377801A9
 for <u-boot@lists.denx.de>; Sat, 13 Jun 2026 20:04:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-486118ecd5dso1288435b6e.0
 for <u-boot@lists.denx.de>; Sat, 13 Jun 2026 11:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781373844; x=1781978644; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/qA3vIB3OaOJ6eyQrbuTYg3gbbRVrZkT9CDZOrPcfv0=;
 b=TYbudegM3c2C/h2MjlY12sr2roz97zx6lTeWGGcz3iiHVzqo7x7rr8sIjmLsmm0NaY
 pQuCQG8O5nbAdgTQQCROVcLwBKDMPbSWXlcF7PF6nWyKmtTcengowcP5IFTH0YKuohwz
 j/gW4NDnYkjoEJzEMBKp3q1Ioe0lYcegysdqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781373844; x=1781978644;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/qA3vIB3OaOJ6eyQrbuTYg3gbbRVrZkT9CDZOrPcfv0=;
 b=O8i5VuqlWhwDClex2o/qKZQ37siLjPt9sogWpXaoCLLyJBKiEXW/6ig9eUYi+7lvCE
 3rNGX3ibJ8xHiqIL2z4Ye8FmST+AqTUnJX8Ffg7C5DXZamPVFekTlXupIFrJkxoFviJA
 qXlyn8TuhsPghrJir/cRfOksdP4ib45Hs2sc5npn6HoXI/nmHJRxezyV6g35gm5TXaQj
 xgBUo+biqliO5EVLyPzICvIRUPdF6yPY/rKV8tqLubjJEaBIdn972HtNWPTngsKurF6w
 A+84oFizsgRPxf2gezbhPSALHVHep3gzEao5kWsH6kT1DAKJ8ltskDFKwmMIkd9LI/zn
 C5Mg==
X-Gm-Message-State: AOJu0YxSxVqbbcGF4WtA+WgnXFnjOYEXzlQbNokKvrzQBWfbjBKQaKGA
 aXPbJ+cxlg8au2UJ1UnnkPir+x/fmUI7Q0f1Qu/cp8qF9fK+W5UlVYqfv/ye2E75cXc=
X-Gm-Gg: Acq92OGvbI7hufJdQjdWfpipPpGs3dAf5RkVgJnpIbXS3OS0UAAr02T9pkfoA/NpNpU
 H7N4tup6BidXwxEuZheMelhSifdmjJ27r4AjMMr9zJk0SymA/qtuXuwa5+Qm50iNwCY1Nr16BLf
 zvaE6jb2N/2RVrFnokHzUg7ZtKNfYCNJXSXGh6m81zQvqNXiUvhRNtL50xW8OeiWg6Ce1kmxoyM
 YiGA/drYgF+nlDpPjGL20AqSJLF17Zr1r0eJE48l/TUa+gFE+hRa3bSX9RjVi0/1Hg9on9eFm7u
 cHKbrK0hDB68Ym6S9yY7u7IsZsRIu1NlDNMDSDwW3Y5Eah2hE4BbclBm+8mFpLiv9THClktxrq3
 3CABuXjrq000eFohJjwlmIF06TifvxvXvbCpBChugePqVFAEDUnoDWLWjeAZY0JZBpfLYsPniR4
 n/n3bYdZulfEz6kIjn2WJV8V3JcZnMGl0uxQcSYqAzmb7e8twTHf9yhDHF63scbRbxSoK7vUZ+X
 xXXuE9ibG98KcpQQBTeq8mTzFKvX/IuiRnJn0say8PoHxYeWFewNxGtaQ4=
X-Received: by 2002:a05:6808:1920:b0:46a:ccae:5517 with SMTP id
 5614622812f47-4872f4a078cmr5197942b6e.28.1781373843950; 
 Sat, 13 Jun 2026 11:04:03 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-245.totalplay.net.
 [189.203.97.245]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e7816b3f64sm4787436a34.15.2026.06.13.11.04.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Jun 2026 11:04:03 -0700 (PDT)
Date: Sat, 13 Jun 2026 12:04:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Anton Ivanov <anton@binarly.io>
Cc: u-boot@lists.denx.de, sjg@chromium.org, vr@binarly.io
Subject: Re: [PATCH v5] image-fit: Validate external data offset and size
Message-ID: <20260613180401.GT382693@bill-the-cat>
References: <20260602183052.65247-1-anton@binarly.io>
 <20260604103950.77778-1-anton@binarly.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dH4Ezr8urMPI7bw/"
Content-Disposition: inline
In-Reply-To: <20260604103950.77778-1-anton@binarly.io>
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


--dH4Ezr8urMPI7bw/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 04, 2026 at 11:39:50AM +0100, Anton Ivanov wrote:

> fit_image_get_data() uses the data-position, data-offset, and
> data-size FIT properties without bounds checking. A crafted FIT
> image can specify values that cause out-of-bounds read during
> signature verification of an untrusted FIT.
>=20
> Validate that the external data offset and size are non-negative,
> and that the data region fits within the FIT image bounds.
>=20
> Signed-off-by: Anton Ivanov <anton@binarly.io>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/next, thanks!

--=20
Tom

--dH4Ezr8urMPI7bw/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCai2biQAKCRAr4qD1Cr/k
CvpIAQDxziH95ZHlwHFvtnDBVCUonJ4JCTG+o+JCez3Q4UiKYAEAqQBXVnzBuqZg
tYqIgnxhfLOwTtbrEZ/9/IfLblZjww4=
=AQVk
-----END PGP SIGNATURE-----

--dH4Ezr8urMPI7bw/--
