Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C16B6CAC5B0
	for <u-boot@archiver.kernel.org>; Thu,  2 Oct 2025 20:15:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B5F083655;
	Thu,  2 Oct 2025 22:15:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pXnSqk4Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C7648365C; Thu,  2 Oct 2025 22:15:44 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49781833F6
 for <u-boot@lists.denx.de>; Thu,  2 Oct 2025 22:15:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-938de0df471so116907639f.2
 for <u-boot@lists.denx.de>; Thu, 02 Oct 2025 13:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759436141; x=1760040941; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ki0KUj3Biv1esMSYy9ipaWGl1FrC7cxuSuoqZFwev7A=;
 b=pXnSqk4QRbbvfVSIV8NtfPBiRGU/o/T/wOltgCdzS330PaavpZhuHaKCgsagw3xXFK
 9uFuRPHJceIy0zPumMBDilsx+qBwyx05TWqgRVz3MtW52ESqpkANs0ZCKC3piJSHvFqG
 6aH5AyIuuKH3jeDSavWvBXYp7Vpc0bFvJnGd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759436141; x=1760040941;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ki0KUj3Biv1esMSYy9ipaWGl1FrC7cxuSuoqZFwev7A=;
 b=cqZGMP2sdGQI70RGK8h/tvBtmJzwM/n9LXYYy7GKiNwgSF9KY+9JZGKl97wlLtzY86
 wev+KiS+Q5/rOZ4f2g8nZF0IH1XExdvvexkHAwipljWckJKN9XNGhy2AHwBkQRYjJQgG
 78ZvrjItyprj5/c3qh2Y/m+k61Z+MR0b3pFhNQKMZvp0i07p8NtXUmYD/UtPMb1Ed/ad
 aIcwvnQkEXQRasaxsmxD8Mh+G1lUdRLNNf8VlYidt32lrojlqYCKZpqO6+iYCItNymlR
 KTj7aRCHW8pK9elkN2ZRrf2bN4qnritACw9UZKn1nAMZr7AB12eaiNsltNNtiP4sEVKo
 RyOA==
X-Gm-Message-State: AOJu0YwWEW0G6+uZcTdwqC1JBCwwpqxuoeZ9ONVFmJHjRdI5J9zLyAYO
 ivYixAGPIqGpglhxDZF09Y2X8wA9cquCkW4q3lFtFk38tmumAM6VW1p/qWuvONxBkFw=
X-Gm-Gg: ASbGncs9yMY4ysR4x3742Jo2nb+pXw7FYhfUXLDrMTMIP6qQekJOBzQSL2GRbIsnCSN
 YgBH1DFcSYR44cS0XcKRUAhQhRLWKkUTlAqOvUw+uOlLw2tnm9qXeF27X7ndmcaFLlMItJ3SSyB
 Mw75ytfgWWNKxZahD5wvpPGnGBoYNfv8woSbK/x4oiH2rDxvwhT3Tn9YQuyWYcDq3xTgGgUqJ9E
 /BNCRnrpY+EgCItRkkxJ1FJeJP7+8Nyg03pHgHz9jx3lf5K1c5T2Fz9zFFld+NIrL21vdECd37b
 wf/wh+AyWsq7WYXagQ8pe819eq7HJ4wqeFZrZU/qi/iuZ+A86F8R0YXPU6C071+9Ioukglc1hiO
 NuSKcHdsNxmwv14LZRWJp7n+sxsX7pMWQhaAKLqC9Zc0sqoTitn8Xnkb7UU5JTI+EDEz0N7aR4K
 pPyOB4EcCOKQ==
X-Google-Smtp-Source: AGHT+IEQiicxxUcv3Lm4qGIYD2/YlMY6mY1LNGgCp3XnDYoWn0WyLbmJgWN8HPBH5LbcXHnc9+ZlSA==
X-Received: by 2002:a05:6e02:b28:b0:423:f9d1:e913 with SMTP id
 e9e14a558f8ab-42e7ad9abedmr8126785ab.31.1759436140959; 
 Thu, 02 Oct 2025 13:15:40 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-42d8b29512asm12737945ab.37.2025.10.02.13.15.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 13:15:40 -0700 (PDT)
Date: Thu, 2 Oct 2025 14:15:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: Re: [PATCH v2 05/17] boot: Move showing of bootflows out of the
 command
Message-ID: <20251002201537.GO6093@bill-the-cat>
References: <20251001212649.3263574-1-sjg@chromium.org>
 <20251001212649.3263574-6-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YJsyz1E74UBmR9XI"
Content-Disposition: inline
In-Reply-To: <20251001212649.3263574-6-sjg@chromium.org>
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


--YJsyz1E74UBmR9XI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 01, 2025 at 03:26:30PM -0600, Simon Glass wrote:

> It is helpful in tests to be able to show the bootflow that is being
> examined. Move show_bootflow() into boot/ and rename it.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> Changes in v2:
> - Add a log_err() for an invalid state
>=20
>  boot/bootflow.c    | 57 ++++++++++++++++++++++++++++++++++++++
>  cmd/bootflow.c     | 68 ++--------------------------------------------
>  include/bootflow.h |  9 ++++++
>  3 files changed, 69 insertions(+), 65 deletions(-)
[snip]
> +	case BOOTFLOWST_COUNT:
> +		log_err("Unexpected boot value of bootflow error %d",
> +			 bflow->state);

A small thing, checkpatch.pl catches that this isn't aligned with the '('
here as it should be.

A larger thing, and please correct me if I'm wrong, but on reading the
whole set of changes, this move + rename just means we're putting more
info in the test output, and nothing else?

--=20
Tom

--YJsyz1E74UBmR9XI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaN7daQAKCRAr4qD1Cr/k
CoW+AQDJn4r7u+mI0bGg/qf3lOp7pUzPSIhhuCTsW4/kMaeYcgD/Y1ecTsKAo934
ii5Ja95VJSKmkOXFnipWbELBQ3mBuwU=
=ZBnq
-----END PGP SIGNATURE-----

--YJsyz1E74UBmR9XI--
