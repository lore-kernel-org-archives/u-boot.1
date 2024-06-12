Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDDABC27C77
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 16:01:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 243178881C;
	Wed, 12 Jun 2024 18:00:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kmGNQOK+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE9528881C; Wed, 12 Jun 2024 18:00:54 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B59AB887ED
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 18:00:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6f8d0a1e500so5057064a34.3
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 09:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718208051; x=1718812851; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3+A8ntgkKsESuLqyCsmgI9YTV/VDL8DVPwWGt6x8KdU=;
 b=kmGNQOK+fQGnrIoXfzl3L+9+EPFVMnzBmVw3oxBgpREzACIWcqKekYq/uxwe9LZ2A3
 yK4BR9etzL+fAGFMRKhRvvsavdAPtZBb+GgTxQ6XA36Gw0A7bsMzSoILEdE/trx3/qrS
 Oc+T5s3JgmDsR9Ven5+59MBZ3DirJAqBumsbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718208051; x=1718812851;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3+A8ntgkKsESuLqyCsmgI9YTV/VDL8DVPwWGt6x8KdU=;
 b=wom+VtqiF5JxKu8Eo8eOwwxVXW7jjnXKMepounRmLEJdW0pGs7lgBMWcP4rdNWoCEV
 A32FM7FqE213EqSWqBpFPJi8nbqXdVP36FFjkmvtFiawEFvE0hvSlk0BE9x+uEL/cpXE
 gg5876m+STs9pbDmT8kljH8I8fHFZ4GTYk0r38rHUUUaUxk5FRtjzjCQdyLSRFbWe2yB
 195MW8Im5dUcwUFXX2V3piawMBMFA/pRMPaGLaM2T+FsfPKPoYzpBZJUtq+DIoWpSUw1
 vns4o0h+fwQM2K2Jt4q5HStf5uK5LE3AVK8irwhk8iUo6GoCiqyPaJl+idYX/tQaSUCt
 C9zQ==
X-Gm-Message-State: AOJu0YwAXvUU6v4gBtnH2nD7iGmSjciUoPSooyzbUFJQKUzX8Rm0v40a
 lpy/ui3D1l3WEQoOeDKu0xCtrWdM1vBn+hiqK2xIEj2Cb7UQ7Iq0m0xmn/odQqM=
X-Google-Smtp-Source: AGHT+IGSXQobE1uYRqbgnO1A2KYhiFFB4C25mA1mEmVLIm9MDydGgGq/F2AWukNWUrUEA2Bdt5cS9w==
X-Received: by 2002:a05:6870:8a0e:b0:254:a2bb:822c with SMTP id
 586e51a60fabf-25514f210acmr2340288fac.43.1718208051328; 
 Wed, 12 Jun 2024 09:00:51 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-254e77f12d4sm1164425fac.58.2024.06.12.09.00.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 09:00:50 -0700 (PDT)
Date: Wed, 12 Jun 2024 10:00:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Aaron Williams <awilliams@marvell.com>
Subject: Re: [PATCH 00/20] New CI image and fixes
Message-ID: <20240612160048.GR68077@bill-the-cat>
References: <20240611-docker-image-v1-0-51472eb70357@flygoat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RnZeDB35pr6aUQr4"
Content-Disposition: inline
In-Reply-To: <20240611-docker-image-v1-0-51472eb70357@flygoat.com>
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


--RnZeDB35pr6aUQr4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 10:03:59PM +0100, Jiaxun Yang wrote:

> Hi all,
>=20
> This series build a new CI image based on Ubuntu focal with LoongArch64
> support, fixed various python scripts for python 3.12, fixed various
> problems popped up when testing againt latest software.
>=20
> This change must be combined with test hook changes at [1].
>=20
> Last two commits are for demonstration purpose and not for commit
> into repo.
>=20
> CI runs passed at azure [2] and public gitlab.com runner [3].

Thanks for doing all of the python updates.

--=20
Tom

--RnZeDB35pr6aUQr4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZpxjAACgkQFHw5/5Y0
tyyZTAv+JWe+QoYOK1gycALqT9/ine2ncU8hE6aTrxMJqqmd3+qQuYgN1/L3IsbP
tHINVTGX3H3OogJRN+x74CCMHT/9YF8zvwzqEQekmkqH2FVzyX+r9Pj52srG5dX/
0k2tHlocEf+CUH2Pn6hcErjBN2uLCqmTga0/bk9Kv/Ml9/Y14G7VrprSC+5m6Cmp
NIkBHKRt+o80StEtTb2eM6NLhgjekm6Etm1KDsGzQbvG8Tvlp8lT2bzmFkzL6KEN
yqVC1pWhj8jjPFAuNWyqdoZf5IAgEakGTN+AoQOC4FSS232gRo1SaMyVYlptR+XA
xMCCVylRqC1mHrHipesH3OkcgpSF8Y6gFuJUC+FdkdF1EQvXhYy57wKRnWdPgm2L
6a645ghGW9PTKGt1L2JjdeU3XDrMWffKQNk3aU5+B6TS6OzA1foP/LeQGzfOsHX4
n1QxZAsvDdeo7N7JbUBVjkA1ri6OcSrB/bAzjSI8Fh79+Er4+xgIBH2zBsbkrsIQ
HhqzI2nh
=EYbQ
-----END PGP SIGNATURE-----

--RnZeDB35pr6aUQr4--
