Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32315C10DAA
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 16:57:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8172586D4C;
	Wed, 29 Nov 2023 17:57:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NCj6yC5z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F41BA8761F; Wed, 29 Nov 2023 17:57:35 +0100 (CET)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBF5186D4C
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 17:57:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-5cc7966e731so59699407b3.0
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 08:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1701277052; x=1701881852; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ORMLxa8UQB1LV+ZI0WcCZHT3VkV/kWRWeOQZDNX7iE0=;
 b=NCj6yC5zw38Chp/R7s+OwLonBoP13wMJ4iRfmZpOhaeboLOlQlk9MRaOm9ZoDQCxmX
 5e+9qaEp/Ujlj5yekQASLDgExYIIOh+KpiQtt+hTx8j+ujzMzGpl3tzMdSzIuTjmc82u
 D94SVMSN6IQzUMEm0mfbl68CulDS3s1efm6+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701277052; x=1701881852;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ORMLxa8UQB1LV+ZI0WcCZHT3VkV/kWRWeOQZDNX7iE0=;
 b=iLP68MfKgvf/Q/eQrNgVt9/b62G7TH1O8bwNfGC/+50TmpXNCKP34wJUIqZH4a8wDZ
 86swaYYbMY1HmkEqkfKuMiq0vY6egwPHGOGEF5XRKPA2ufg8t40m/Uu/yGDJlEajCltv
 U7QmjBCTxBlPnfcsjv74YajPwDOBcqN5Zo0AW9nNDtk3gZhFRiB73rwsk83Xf4FLIAM5
 BxTNyJ1fWGJ59Jfi++l03my3r+N8WHrTlTsYkQZLaMNn07u5GBm7FP1ARpVAtN1RhOrm
 K8LmQ6lrxYwVMx0qrhQJ17HtpwZFh4UMjFsnJHF2h/mkStWVf+xez3+tnotv+YSeT/Jc
 ahAw==
X-Gm-Message-State: AOJu0Yxy1IGWSjDWB62oiPaiV+VmaLAwUJnWqyt3nu0LKfZjjnT0cgjF
 HAz4b4Er+Iv/cE+3sEHyYeEZHA==
X-Google-Smtp-Source: AGHT+IHUUnNq8hnmE0l+2llHmXDlhf3XQoxZ6BgTTYSiq3OY6r6cJJWX9QbY8pbCJqdKfEZoVZAoyw==
X-Received: by 2002:a05:690c:3485:b0:5ce:cd8:ee1 with SMTP id
 fo5-20020a05690c348500b005ce0cd80ee1mr17063042ywb.7.1701277052372; 
 Wed, 29 Nov 2023 08:57:32 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-9fa4-b7c8-6a9a-173e.res6.spectrum.com.
 [2603:6081:7b00:6400:9fa4:b7c8:6a9a:173e])
 by smtp.gmail.com with ESMTPSA id
 n192-20020a0dcbc9000000b005c862c66ffasm4663423ywd.16.2023.11.29.08.57.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Nov 2023 08:57:30 -0800 (PST)
Date: Wed, 29 Nov 2023 11:57:28 -0500
From: Tom Rini <trini@konsulko.com>
To: Love Kumar <love.kumar@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, git@xilinx.com,
 rfried.dev@gmail.com, v.v.mitrofanov@yadro.com,
 seanedmond@microsoft.com, emohandesi@linux.microsoft.com
Subject: Re: [UBOOT PATCH v3] test/py: net: Add a TFTP put test
Message-ID: <20231129165728.GF2513409@bill-the-cat>
References: <9410fb15f6a4bb50ef4c5934fbb2dbf22fbe51c4.1699427321.git.love.kumar@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LAu1AAA45NkVOqNw"
Content-Disposition: inline
In-Reply-To: <9410fb15f6a4bb50ef4c5934fbb2dbf22fbe51c4.1699427321.git.love.kumar@amd.com>
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


--LAu1AAA45NkVOqNw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 08, 2023 at 12:40:31PM +0530, Love Kumar wrote:

> Execute tftpput command for uploading files to a server and validate its
> size & CRC32.
>=20
> Signed-off-by: Love Kumar <love.kumar@amd.com>
> Reviewed-by: Tom Rini <trini@konsulko.com>

Applied to u-boot/next, thanks!

--=20
Tom

--LAu1AAA45NkVOqNw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVnbXIACgkQFHw5/5Y0
tywvdwv/QCRckHxEukxxfRHniGWCCIHrf9KLVawke/JrSAERx6ObGmQ40xoBveMp
s0iM4otP2IUCdumedcpRQglmKAExBlItI7znTO7ICuYUeFX+ScVr44iOaQnjpo9v
+uwzY+G5FpUQ2FaUGc3zOJc8/HjFEGyvT2BERGBjcCTqvYfJosYP5Yp/pezj0FFn
GIyhkioEbGTf4aX88vFdvfbbix20vgdUL8Ccv90NvTqYlExSfk5gH/w+ms+HEJ5H
70bOrKTtUBgAGT88Mmky0LpMwMiE0wSXxgnbhqHq9KgfrWscqDjIhWBiwNXahDy5
LPjVmb+gTtJLAczhLTW1XTE0TLENxYmItpU3kDC0ENqsDfoilUnC77mlk6iKdoct
6d3yRdg1LzZHiOpnQD2KY3B88eJB6u5Y7R+CRs1JksymY2GzofWfqinAyIEThTra
KW++0L5Pyi7ppUT1NTm9P7TE2TuL2Bx0ZeZD6rmhFN8VYyZ+HCjLEfyPumlQuCAE
aHIbs3qo
=41Xk
-----END PGP SIGNATURE-----

--LAu1AAA45NkVOqNw--
