Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE1BC2BD09
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 15:49:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A593883BA;
	Mon, 24 Jun 2024 17:49:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TTg8dg0D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01F068831F; Mon, 24 Jun 2024 17:49:08 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8636F87E30
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 17:49:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-5bb041514c1so2380394eaf.0
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 08:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1719244144; x=1719848944; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vnu69fp4bE4X7K9Cr6o/7L2YGWykdWtykYRQCoX0GSI=;
 b=TTg8dg0DseGSGYUREXh5R0rI+zHbXnp7odpeXmt1MP41m0Pbi47jxpvG5IDVEq8lcf
 tkUfRf1z8PBDIqlKydgXqursJUgrsHXuj4K3/ureQ93CcATP/hGaKGL7KACqu0ct0vGt
 5SLW2nN6NlsxM5PbDpK3oOyr2fUiRQNHm7wBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719244144; x=1719848944;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vnu69fp4bE4X7K9Cr6o/7L2YGWykdWtykYRQCoX0GSI=;
 b=P0anyy53ZK8wei1BCABQdkUGC39vOR0OsbrK6TUD3yjLz+Tp/hRojyXoTk1THaTduT
 tS90HhYE6cWTJkIZqTBNz6ppMOTIrQkNevpDDunyHQqRNjpeWL1F1PNRn2FdQ4MkMJCz
 pH7+KIInBRRxZlFCaAyR7QbZm3EbmaC9IEu2j2xfV/N7ykXXVDDu8ovx189/4l9gLf9P
 /7TYTN4ZQ6suPKPSbuQv8Ecgmt8O1QleCG6LnJLytFy5Sd3jPfWXqsd56bef+U9fIXgb
 IA2qX/x5rMHVedkQA7Dzv6NfXKUH/BiRv8sbEzujPi1teoIDq1canijshETxPuNA5wHC
 eSvg==
X-Gm-Message-State: AOJu0YwfrTVJTZLMIcbn/Gh3MvjfapC1D28JYBCwfysDN+eUlv8/cT44
 /gQNuyLQvYcOFglrCcme+YWucAezCD6F9YJhEE0RQi4SPGl7v9viEoSq2W81Ztk=
X-Google-Smtp-Source: AGHT+IEqEMGPqKC1XZG3vEJf0AWUA6pmQtDmEwE09BESGDsNO8pInDqCYevGl+nIJNQuM0LXovT8Kw==
X-Received: by 2002:a4a:350b:0:b0:5bb:1ae0:17f0 with SMTP id
 006d021491bc7-5c1eed3ef45mr4733901eaf.6.1719244144148; 
 Mon, 24 Jun 2024 08:49:04 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-197-45.totalplay.net.
 [187.190.197.45]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5c1d55cdeecsm1369678eaf.18.2024.06.24.08.49.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 08:49:03 -0700 (PDT)
Date: Mon, 24 Jun 2024 09:49:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Pull request doc-2024-07-rc5-2
Message-ID: <20240624154901.GA38804@bill-the-cat>
References: <35bcd226-5ab9-490f-8a7c-e190aea647dc@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eVvaim3DcIi7wKrc"
Content-Disposition: inline
In-Reply-To: <35bcd226-5ab9-490f-8a7c-e190aea647dc@gmx.de>
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


--eVvaim3DcIi7wKrc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 22, 2024 at 06:46:15PM +0200, Heinrich Schuchardt wrote:

> Dear Tom,
>=20
> The following changes since commit fe2ce09a0753634543c32cafe85eb87a625f76=
ca:
>=20
>   Merge branch 'master' of
> https://source.denx.de/u-boot/custodians/u-boot-watchdog (2024-06-18
> 08:34:56 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/doc-2024-07-rc5-2
>=20
> for you to fetch changes up to 271ca9ef8a37b8668b9858638175ac2da5c152df:
>=20
>   doc: board: ti: Add capsule documentation for TI K3 devices
> (2024-06-22 17:04:19 +0200)
>=20
> Gitlab CI showed no issues:
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/21289
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--eVvaim3DcIi7wKrc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZ5lWoACgkQFHw5/5Y0
tyzRYQv/ehC+t5FdVgxxukAb1NgbizXoCa6fF5bcFsT/mIKPDUYxvthbOsvMWROd
DI1GuxcQVMmZ9BoSk2SV49s4ZWRe5Cya6ffEqP2p7N1Sij3sl+v6enDu7n91uihK
J/y2AHWfRlXtw43OYQA1F6sBAWgKWTDYsxKpNPqb6ezUhD7JhvVjx6ShbFGN0trj
FTF8oylRbEIhxj21xtp5YZUDcg21f24iFQLPXHhFkSy/Jk1JY34D63RsAOYmQqMl
xi/mT34Dpa5TUQT4rM9P+UQTWdC2jzVI8R4vl4X+YLZ96U0OuiLDOnOuXFaHmeSQ
0oNd1rVV4ks1jE0Y0OLEiFxT6zIiRm3kikkEEdKeRF7dGSQBeSDRNc9yIVXaS9Eu
A9sbW8vbz+jrzzrSz/gxMKULWShNcESs5373pzSrwDmitIoFnGnh0AT1qF5xM5r1
UPLrhZjuPRpdzntQcINHYeCpNxAXlSKqW7pnZFt5J/GXjFYClUFg4it3YTsIfdJG
8DWJiSdD
=gJpB
-----END PGP SIGNATURE-----

--eVvaim3DcIi7wKrc--
