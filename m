Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 223E0C67861
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 00:43:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B74B87E95;
	Wed, 10 Apr 2024 02:43:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RcUxBQqq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A9E98809E; Wed, 10 Apr 2024 02:43:51 +0200 (CEST)
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com
 [IPv6:2607:f8b0:4864:20::e36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7909F879E2
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 02:43:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-vs1-xe36.google.com with SMTP id
 ada2fe7eead31-479c39b78dbso2518263137.2
 for <u-boot@lists.denx.de>; Tue, 09 Apr 2024 17:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712709827; x=1713314627; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3S9HgbxJxRjiMManRj10pXB6388UADeYD4010r4re2g=;
 b=RcUxBQqqPOFgBPr+4RXIBvaSGKNOZxiyL9gSTe3lIGAP85Lx9R1qzvUaXhovhzg+Xg
 awuhu1VXVXR6TOpXbcOungsp2uKwlybjzim87FiZ7emzhbD8x2BixFU4ccIqEoaPje8D
 3ZszDtYCJS2DhLAet2tRTFeFoRVlHkEE7mMp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712709827; x=1713314627;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3S9HgbxJxRjiMManRj10pXB6388UADeYD4010r4re2g=;
 b=clMqMKMoCyiKOojtBkc04UZUt9KvQl8BVWm0TnvZrSIzk1CJW2hmoD4W7lL8mPC5Nx
 kFuKoi+hbTD1dkBpe3i01tV4m9Yj5ne50/iRyRYMOSj6sLPiR93tXkyf1yewGL7ofNyt
 PCLz0uS4zQnyMWCY03WmazM4yVAxUtajMg46VWo9ScDm9LUFJRaZ5h7F6fNPRf4uQ3wR
 NGZ6Efs82lB9+Jp2nZ9Wiiyvrxd16UqCUKgh1Rtatut95kd6gqud6lOThUq0YuhbGoPN
 qsI+PJmiC7tduHFtfLRUQZcEN+UoK9jR9mSCDtf6qZv8naKgpzdW9CiH8CwkeIvl0me2
 MOKg==
X-Gm-Message-State: AOJu0Yx1NbUvpaBuW0LFl7KirCaIvUB9Loz2XPhPl/AXWPV1jYOHxoVa
 Hi4KQP1HlQIuej5VHcuZ//1uCO1Ghs1QPZcYJ6aIuE1EiSRzv0lUYR0tcmqbv7a6+9bP3UaXrEc
 yI5Nkyg==
X-Google-Smtp-Source: AGHT+IG2ELpxoqVL8l3iQIaWj34V6Glp4d7Q3i8pQhf8chYZS8CCGbAxQPn5xNNW/rldZ+8inBmT+w==
X-Received: by 2002:a05:6102:1501:b0:47a:6c2:f661 with SMTP id
 f1-20020a056102150100b0047a06c2f661mr1190130vsv.35.1712709827220; 
 Tue, 09 Apr 2024 17:43:47 -0700 (PDT)
Received: from bill-the-cat ([187.144.96.143])
 by smtp.gmail.com with ESMTPSA id
 p2-20020a0ccb82000000b006915ae114efsm4470270qvk.52.2024.04.09.17.43.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 17:43:46 -0700 (PDT)
Date: Tue, 9 Apr 2024 18:43:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Leo Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, rick@andestech.com
Subject: Re: [GIT PULL] u-boot-riscv/master
Message-ID: <20240410004309.GC2493117@bill-the-cat>
References: <ZhT7gPuUWx2sNkXJ@swlinux02>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="AR8A0riDFoSUJnTH"
Content-Disposition: inline
In-Reply-To: <ZhT7gPuUWx2sNkXJ@swlinux02>
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


--AR8A0riDFoSUJnTH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 09, 2024 at 04:25:36PM +0800, Leo Liang wrote:

> Hi Tom,
>=20
> The following changes since commit 069d07396e30aa9be396c1dd3fc158ac199e68=
43:
>=20
>   Merge tag 'efi-2024-07-rc1' of https://source.denx.de/u-boot/custodians=
/u-boot-efi (2024-04-08 14:33:59 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-riscv.git=20
>=20
> for you to fetch changes up to c1f78a4f632276bb4d77f8c79fe203709a9fa397:
>=20
>   doc: describe Milk-V Mars board (2024-04-09 11:30:37 +0800)
>=20
> CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot=
-riscv/-/pipelines/20256

Applied to u-boot/master, thanks!

--=20
Tom

--AR8A0riDFoSUJnTH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYV4L8ACgkQFHw5/5Y0
tywPhgwApOPMBIurnL/HPwjs2Lz8xmmI+crE63r7tBaRIU6v1Z3ESbZvw87pZOpV
p+2T6N7aaBWK3fZCluISixCn27gGzvZY3KLidN+Q/Y4YEwjOivwjBDpXY+zIgnkA
5YBx7MhX+aDJRVV+h6Qlm4lLg4xx5X+Y6xrhz0xcYOdutEauuiDQE801pn5qbRy9
0IJQhc2gWg+lzg1WsH0lhyGok7e12ehsuhMPdQAwHC/4qZvkOqav8hcekc3dHx3t
p9jOcIbwSdn7+c3mx8qutbYMM2waYIT2WyfBEGbKpQZT0V1mxbyh3yoavPrTHJOw
gTf74bs8lpRfdncMmAeyYpDr0FZOGYV/Rn6yC2CPQSg6aHczlxohK4WfjrxAimsy
xDrvSOWOFq0WIfOapFn226wGzW8mUpJ9CoLIEctZdPWFmeDHAQapSheXDrXTC5fH
GDwheu6nY6zeHH4rZ1EuW3tilQBt1O14sc1Oj5KBPU6Mfe892D8qfOHHkfKy6mRx
6pt08eTV
=fTr/
-----END PGP SIGNATURE-----

--AR8A0riDFoSUJnTH--
