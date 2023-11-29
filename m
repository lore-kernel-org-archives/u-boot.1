Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 637EFC4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 16:58:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF1188768B;
	Wed, 29 Nov 2023 17:57:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="alfe2uxa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE1F587691; Wed, 29 Nov 2023 17:57:49 +0100 (CET)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4A9086516
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 17:57:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-db49aa82c89so4384138276.1
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 08:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1701277066; x=1701881866; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dkskbS2ezaPjEETBtP+X6EULNu/5Xk5hGG1RPZqLbB0=;
 b=alfe2uxajC4G/nZXliEx7nK6dhMNeYnuFZtM5/FAD0lRftnQVcyA35Xsa+sUHeWfPO
 WgBlGNXPbCuKzWsKaTOJKYhf1TmKT9SJBEP//7iV6/lEckKz/prW6+mSsix7jbnwo9YJ
 xP2qQhaVgcoJoAZ/DA/KZBb0pcbwsQQWCZqtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701277066; x=1701881866;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dkskbS2ezaPjEETBtP+X6EULNu/5Xk5hGG1RPZqLbB0=;
 b=tjtUgGVm/jJKxct61NQpt0e78INkjQ/Ep7rB3QcTo98AiW98srs0c7T09mvMuzzw1G
 lXjChozFWXf3jT//6rrSp6ZZTFuwJs6+lPSkkuEQKuJ6u9QBRYaGD+JLmxBdd/V15Lqz
 0fOO1HcPYBppGy6I20ibiisY7V+yDBoZTDlO+72FgkuzTYzYerHUL/l+MyWMQ0cb+igo
 EDV/um/YNJgrSA4BUlvIUHE9CGUdk/SWW+cywwCBz4SgQhzLJeAM5MX4mxkz5i1FyO1D
 R1NmxxXvtLNdfKg+FQYyS+fwEyErfDrANtc7UHv9SJ0dT2ESDui5zyS7f9iiTTu4BB8R
 LVwQ==
X-Gm-Message-State: AOJu0YzkIvCBSlb0RXe3R1hu9o1qk0nRwFMDge5/O0gnSv+yYqXzzZV+
 w2xLyKnwkiKymleTwLSQu0pMZw==
X-Google-Smtp-Source: AGHT+IH1yqyKmcQxKysPjxen8KXu4MQNyr9wMg+BQSFO1Xkpvj8s8G2dlflGWn1HiXzeTq1dkYBnhA==
X-Received: by 2002:a25:2044:0:b0:db3:fac6:fae7 with SMTP id
 g65-20020a252044000000b00db3fac6fae7mr17415253ybg.31.1701277066481; 
 Wed, 29 Nov 2023 08:57:46 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-9fa4-b7c8-6a9a-173e.res6.spectrum.com.
 [2603:6081:7b00:6400:9fa4:b7c8:6a9a:173e])
 by smtp.gmail.com with ESMTPSA id
 g4-20020a258a04000000b00db408d9513esm4177271ybl.15.2023.11.29.08.57.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Nov 2023 08:57:46 -0800 (PST)
Date: Wed, 29 Nov 2023 11:57:44 -0500
From: Tom Rini <trini@konsulko.com>
To: Andrew Davis <afd@ti.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 3/3] ARM: keystone2: Remove unneeded inclusions of common.h
Message-ID: <20231129165744.GI2513409@bill-the-cat>
References: <20231117223829.346652-1-afd@ti.com>
 <20231117223829.346652-3-afd@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="l4z4Jz44cJBQVgnJ"
Content-Disposition: inline
In-Reply-To: <20231117223829.346652-3-afd@ti.com>
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


--l4z4Jz44cJBQVgnJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2023 at 04:38:29PM -0600, Andrew Davis wrote:

> Signed-off-by: Andrew Davis <afd@ti.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/next, thanks!

--=20
Tom

--l4z4Jz44cJBQVgnJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVnbYgACgkQFHw5/5Y0
tyzkYAv+Lsmz94wpAbFGEMYFzF7saN2DuGfxncpt1ovsdK805Yzo40J32AwdL8N0
Hdw0AR/hd7UsItbwKgXkfWthvaO+fgfFhZqTLm6lmmg16IZzJW/LWYjE3/UMwqSM
qrchjbq8JpCTYpL9iBnaozTKzP+I/yvL3HlVbCPP5zpMGOSrNLVIQd1L3X8qGWF0
bk3xYMGtpt5QdhxiTU7jSM1DI59VSQ1fdRy9h3VJQ+JcfKOpjhIPZE+3XQggX81L
FzQzyrBTFOGlhr1pTeekvJIjvzJeSdsXrIOSv4rUE2ruxoPWxtqZtbb93s88tgjh
1QAafGAhUem2CwsbsmbVlDqVauCoRwhm5Xoy1vfZMyWuc822cZd9GQTHMEGSaySi
ab6qv859ItxlXWrw9fEcqYHQvC2DUZ8rpwhRF99B59EgdZHDD/8ZcYmpmcwVapLt
lPeU+oK9tSqCdd3D9TJb64fgjr/7l36p7F1A5nbsFrAxfC7/8cnxH3VYgDvMfJwt
lf2PIilH
=wdTP
-----END PGP SIGNATURE-----

--l4z4Jz44cJBQVgnJ--
