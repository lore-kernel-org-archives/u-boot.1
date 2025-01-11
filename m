Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00CE2E7719C
	for <u-boot@archiver.kernel.org>; Sat, 11 Jan 2025 00:57:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 121DE801B0;
	Sat, 11 Jan 2025 01:57:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="orY5ZNse";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 590F0801CE; Sat, 11 Jan 2025 01:57:17 +0100 (CET)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2877A80050
 for <u-boot@lists.denx.de>; Sat, 11 Jan 2025 01:57:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-4679ea3b13bso20918211cf.1
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 16:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736557034; x=1737161834; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pUAOzUmXJ766JpAvfzXZ77yRZNU+clas67M3L+fKahQ=;
 b=orY5ZNsecJOMhnn88tfWDi8LdFI3QYmkDb8QAPf+zDMsArpz9nAbMhKVoU9yZ7g/kx
 DlxYZAVKkXVUEhS00hA3Rw2CqfJgd4XUOLNVRRKjo71+v/MqYv2YFvcgjUTceCM+GR3c
 bYjMFmZf1xiFZYcM6QPvb4UDS7cwYlMnKLq2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736557034; x=1737161834;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pUAOzUmXJ766JpAvfzXZ77yRZNU+clas67M3L+fKahQ=;
 b=ZyyruN1GEXN87SSBTtvFTFt50yIoIsjtKI0fSSg1LpdymXFWUiIvifRFaAsRUw6Dvw
 AgWu0vpFdl8ij9eeos7c6YpXJl2LuRLX4eO0e3Oy5rYwGI96JIAePSAVZ0LOVHegaLSE
 Xrus0tz//qbzaUSx8y09ZpvGKArmQ6SyeTrxm9fszK8fBVXZM3T0zY5Z4l34nHGQqrpo
 DNpizqW+XURJ3+mkj01tpPQAHxwN/Pic884kOrNnjEJxCS9fTgBSxy8oyMb3qr8myXcE
 0LPVjTNBleTE278tTsTVZg9tRGHSE7yZJL93FlrPednX2rmxG6Im07+Q8UHkMHtW3OS8
 cJSg==
X-Gm-Message-State: AOJu0Yzfp+VFj6ndcvsucAtbga78YRPW3LUEu9qZX1FC0t86LQQ0yTiy
 +GsqyVEQSNZ1p0KyQr6mgyCIRAn4hb2xamnvkvZvocAIsKFfJOJ6lMuG9RL7OmxfRj7Lbr+B4xe
 8
X-Gm-Gg: ASbGnctTRzKxQzokYvZBKdCQ4jKOLUprNMITI7z0fMGEFgyNRC7I/4myZZFgG1yk9BO
 wrFsIehGouGHqPfzVcXZf2m4jXQ8Us9I7gII1eZPUO+1po+/7xB8v/4krzetDlxpgll1zy/3oKI
 v0Sg4xVbjibdn2hqmf97kG+AbomgBAA1LbkXsMNa5D2zFjBtvJf62uvtnyf4G+dINhotrnI5SvD
 IHQnxa6nzRPtNdr1YUGsGw+h/jQSew6JeA81bcRN8ldqri0aQxQCGM=
X-Google-Smtp-Source: AGHT+IEnZT7pZvfTln7/v4Dbu2HwhRdfBB+bNzCotfdl6WmzU8PdmldsZcdYycYALOc9HezdUiwvfw==
X-Received: by 2002:ac8:5fd1:0:b0:466:8eb7:59c5 with SMTP id
 d75a77b69052e-46c7108c0e3mr217562551cf.34.1736557034019; 
 Fri, 10 Jan 2025 16:57:14 -0800 (PST)
Received: from bill-the-cat ([187.144.0.100]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46c8732fbe4sm15295491cf.24.2025.01.10.16.57.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 16:57:12 -0800 (PST)
Date: Fri, 10 Jan 2025 18:57:09 -0600
From: Tom Rini <trini@konsulko.com>
To: Stefan Roese <sr@denx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Please pull u-boot-watchdog/master
Message-ID: <20250111005709.GQ3476@bill-the-cat>
References: <2d78e7a4-1722-41b7-8b29-a722d27075cf@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="m9H5TAd0q+KhlqSo"
Content-Disposition: inline
In-Reply-To: <2d78e7a4-1722-41b7-8b29-a722d27075cf@denx.de>
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


--m9H5TAd0q+KhlqSo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 07, 2025 at 01:45:47PM +0100, Stefan Roese wrote:

> Hi Tom,
>=20
> please pull the following watchdog patches:
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--m9H5TAd0q+KhlqSo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeBwd4ACgkQFHw5/5Y0
tyxHMAwAunUuwXobLhgiDZFSeC2Zx0lQOYkHrq7E69mbiMsB417iWD2n/3U3ossO
mTgdASyYBdGmW4tAth4Ri6Sv94Bc0ZwR+HOR0/Nxo2bQwWehW4hinhuyJm1ENT40
potwdn+RtMYYBan2jrbYt51FDtsp/GaKRg6zkOH2o7E0n2jX0wxbidqbUSrlt5DN
XGR/mXCdBGSvdjfe7BTL9InZMOHNjSuLio24AI7DZ1KfPVHWU9VwkVeacf4+0sFG
nTIv33AVZOSOhpFxcZ/KXtHTe5v9y9p/WQAHBO9yGvAs39WvLcBcPrBwI2UrWJ6Q
gxO+nJ3B62ohoJuJzq0CThB3Q6OldgaP2/H81HNDqbgUnIO8f5LhnCZC+UW0v+UV
7U9rX8KPrJGGU1NOzJV7mfJ2FOFbhas28R6Bbfz3QG7GEXrItG3KuvvWWC68dkfA
HGxPeiXKBwHSnHUwFmWdUIqy7dGeXUbqlbI0+2q84Q5qd2bG/u7XJF+rmWKd4ozM
Wkyzu+NA
=P38a
-----END PGP SIGNATURE-----

--m9H5TAd0q+KhlqSo--
