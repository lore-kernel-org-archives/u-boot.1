Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B253EE7716A
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 01:29:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F18BE89251;
	Wed,  4 Dec 2024 02:29:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jE497lGR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 585B58911D; Wed,  4 Dec 2024 02:29:14 +0100 (CET)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2218B89427
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 02:29:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6d8878ec049so44663466d6.3
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 17:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733275751; x=1733880551; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+6v25m6VHgIrYNwOTDO7FmaI9ogjlytGYBRPmy0YO6w=;
 b=jE497lGRoonYnIZRgnLQ9e/EdZXnufvEYVgKUTXRZZgk7H8EEVL9V0gLvPV0wDAwo7
 MS3KarsQN/6ucOnfhGq/xzpXGGovhVKJYDLceoKryGgUgiemKXMPSEN/QNI9cGHwQ7t6
 CJT50vUQqX0lZqFrVe1bVD9wweoOlrE/VtdTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733275751; x=1733880551;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+6v25m6VHgIrYNwOTDO7FmaI9ogjlytGYBRPmy0YO6w=;
 b=VUFUwsolMBIpfaDRhhx1dGP2crNZVc2qIzgGmGm8H2jGEDzYNLWQBGWG21i7g4JWF3
 e7E2pswDyLfeaMj2lxCV1JIOIndFvIg5wUCoNPOQUDqPnkOpUWQu5WWVaTsqJubq814Z
 g48HWYw+i1cFKWfPkD7DQwaIKrwS0yYNG2TV35r2xN6TByMLt/YxNQwi2g2APkZKpqhX
 LAUDdmg1c629I4+1kAvEpYXzfhjMvRgHQecQLQQVig9kT2nuYnqpzExZ3tf1DHrCC6tq
 Pvrx3FfNQKN4Q+M3UOZdkPtuDz3fYWJyYj8HHMFvZyOLZPtH0Pkm08mruVSp/Hsoke8a
 fYSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgFN/qgdbGWJipZHRFVYgFaCqHEwTEly7bE8eeYXXyI+4Om7TBXpVTj90zc7ymPa29fCCpZHQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwBATw1RQgipegj3oUCW1Vsq9zFvSEwtKKSegbK7t9FD3SMAbYc
 gEQCOZOwgPxSlrxjh3sua7U8mtuzZJq53u87jSUZb8AGORHRsBN2f93r8XzfBlg=
X-Gm-Gg: ASbGncvmU6kE+fOoasM0IbT3b8YE5IlkFJzfDUnFZKIIR7UCrAKR/nhUdjX7iEh7sCj
 I12EdjS2rjwvAyuqeKZPgl+Zu9pS6g92hvmGdBDgiQ2OJZx3j1/BnE3UwpdxYZyVNH9U1hXY+0k
 wUXt99V0jmCFQr8/cLXAKdWfBvJHqFPxrZGlcrXWRKmZbEq6Wj6MGayc5diQiIxOvHqwiXBhfD3
 3psFrWFH17ScD/EW6okC5xICe69gTqwEFUogiEBUG7d0gOOWw==
X-Google-Smtp-Source: AGHT+IH+LSM+lalZCnJtNdxSEVi5ALZU88L4gaC5qJYYe0sv8IbedsCkoSR5AVz/yxbwN0x4cs7n0w==
X-Received: by 2002:ad4:4ba4:0:b0:6d8:ab7e:e554 with SMTP id
 6a1803df08f44-6d8b73eea83mr51635486d6.34.1733275750876; 
 Tue, 03 Dec 2024 17:29:10 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d887b7a98csm55883156d6.36.2024.12.03.17.29.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 17:29:10 -0800 (PST)
Date: Tue, 3 Dec 2024 19:29:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Applying patches to mainline (Was: Re: [PATCH v2 0/7] efi_loader:
 Add support for logging to a buffer)
Message-ID: <20241204012907.GD2457179@bill-the-cat>
References: <20241202001243.1283274-1-sjg@chromium.org>
 <D477BE0D-064D-46CE-B83B-C8B1E546575D@gmx.de>
 <20241202141558.GD2457179@bill-the-cat>
 <CAFLszTjxOE_037+kR0jgdax80sBombYo_k0YgiuVnP=KZCOvuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3U+c/K89DQCNOlM7"
Content-Disposition: inline
In-Reply-To: <CAFLszTjxOE_037+kR0jgdax80sBombYo_k0YgiuVnP=KZCOvuA@mail.gmail.com>
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


--3U+c/K89DQCNOlM7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 02, 2024 at 05:21:05PM -0700, Simon Glass wrote:

> From my side I'd like to change the conversation a little, to how to
> land code, rather than why we should bother. "Code needs to land"
> should be the motto. If someone has taken the time to create
> something, our bias should be towards getting it in, with sufficient
> changes to make it fit the project. There are cases where something is
> just a bad idea, or should be done another way, but for people working
> on major features or changes, biasing towards not landing the code is
> just going to make them go elsewhere.

This is the wrong approach I believe. The goal has always been and
continues to be to have reviewed (whenever possible, our developer
community is small) incremental change over time. Just because something
has been posted a number of times does not mean it's ready to be merged.

Your challenge today is that on patchwork you have over 150 patches
covering a wide variety of topics and of which many series have
technically-merited feedback that needs to be addressed in a technical
manner.

--=20
Tom

--3U+c/K89DQCNOlM7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdPsFsACgkQFHw5/5Y0
tyyExgv/RxfsjiZBgyt8DK3YFh59voSqNbBt4gfrLo40xoWb259qdKMaVwNZIo96
PsbNMOV6tGJ8aw9r6NyuAJC2hnPLCNXsnVCY8YxCdAzVcYtvrZGOx+tJf8/+Kzbd
9osYcMd+7vk3mMbcNEXpo6eUttCEx9+KKwAK1bo88ZF33uvDCHLhkCNqzwFTkbLh
teJDsP0ZbLL+mcXn52u1lRnQ3d+Nt5vW0KqvEJbqHsYKBI/y4400IbIbaur0DlpP
mrH8/QZUG6DAVvkX0mxKDQUwmpcheIkAkIbNrF/DMV29ZN/FDqERZZQhTI9wrdBQ
evhyo1Bj3Qg8Is4TbbAEygcH4u5qXCPcia+KDXuniedgI7MEdIrJmgCaRD2ajwNk
bD5ALxVJdGDmfuaiB9msNB7GBwLJXMYE+XHwQGvlBWUtjF1XO+hj+4WpcJjMqU9D
SlF8mG0n8rMyHnUH1mgNZKc6QDur/FzCHDE49CSIfVB8H4Bei8upbqgV9X4GhajU
Z7yekwTK
=0tPy
-----END PGP SIGNATURE-----

--3U+c/K89DQCNOlM7--
