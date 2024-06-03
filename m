Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DAC4C25B75
	for <u-boot@archiver.kernel.org>; Mon,  3 Jun 2024 17:42:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAD0F88387;
	Mon,  3 Jun 2024 19:42:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FcMdZwym";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90BEC8835E; Mon,  3 Jun 2024 19:42:13 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A07B87EB4
 for <u-boot@lists.denx.de>; Mon,  3 Jun 2024 19:42:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-24ca03ad307so2578762fac.3
 for <u-boot@lists.denx.de>; Mon, 03 Jun 2024 10:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1717436530; x=1718041330; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ocAkeSHMUOYWtL7uLvtkAsa+wgVl0Os9mXFEwhDXi4Q=;
 b=FcMdZwym6OnVMJ6nLf/8I7jE4CeQf14QT/7/t8f2p0Bbi8HTjxhDBTMx1TCkrTXUhE
 lcl+UYAaX4GvwyI5VeZIO8cjtDAgzRrYQhrT/8P9R9CjYBnuUbJaHOWEU3Q6wHHBtFPg
 J3mENdvUktoNVD1TY7tuqhO0HIRUVedhRck4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717436530; x=1718041330;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ocAkeSHMUOYWtL7uLvtkAsa+wgVl0Os9mXFEwhDXi4Q=;
 b=ZTakcMPBDZaZ2mbnAUMdeEvHy8w5nNcOBHXdIwBZ4Te4sqLS7EO/tlLeYiRBJJY6mX
 roVYCowiCF7mswVZfjkN0zfGMWTnxIWGn057g6rB7hV3LLk0530rv0i5oH0DR7WbPcBe
 mxU6D6viHA/qwcDwfjEvRMIvGI8IrNcoJmdZ5YwUI7K5CRHnwwRQ40t535wzJ50dsvYK
 suFp9TsKVHSIfD5H4+FMmtd+VD+X7jVFPqJAhQeJCuica/4ePxIJgmbZR8auUFXph73G
 8edrtw3TIVWnQSgb5uy4yKEOUPwWg7vQ+JPiIWnyytBVe3KlRQel7ve82SRLp0H2vus/
 YQcQ==
X-Gm-Message-State: AOJu0YySLafVvauQ5JUlnsbWMoDD038h09mQeGEeaXNFQOlA5Sjj9eQf
 lqATUF4fwM5cTXs2ANEHgsuC49l70R4BA+5T9Qa9XhpR3CyVNY54ypB/tz8v2nn9laXFoUfBK6S
 x
X-Google-Smtp-Source: AGHT+IHq7D7gUB4MhtFaXdFkrjkOzVx/IwETfNfxtZXT/WjTweyiKi6frTbyxWLHQkqyQAyJLJpz2w==
X-Received: by 2002:a05:6870:568b:b0:24c:b820:6fe3 with SMTP id
 586e51a60fabf-2508ba25632mr12007639fac.22.1717436529699; 
 Mon, 03 Jun 2024 10:42:09 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25085023811sm2551214fac.32.2024.06.03.10.42.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 10:42:09 -0700 (PDT)
Date: Mon, 3 Jun 2024 11:42:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Leo Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, rick@andestech.com
Subject: Re: [GIT PULL] u-boot-riscv/master
Message-ID: <20240603174207.GB68077@bill-the-cat>
References: <Zlg_MycDVG7f4pqx@swlinux02>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vVXzI+LGcdWgq8ni"
Content-Disposition: inline
In-Reply-To: <Zlg_MycDVG7f4pqx@swlinux02>
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


--vVXzI+LGcdWgq8ni
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 04:56:49PM +0800, Leo Liang wrote:

> Hi Tom,
>=20
> The following changes since commit 46ff00bea5dd2dd247d5e2fdadbf5dcf8653cd=
9a:
>=20
>   Merge tag 'tpm-master-27052024' of https://source.denx.de/u-boot/custod=
ians/u-boot-tpm (2024-05-27 08:56:02 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-riscv.git=20
>=20
> for you to fetch changes up to 1d29c718b7ba09807f8060796d9c21772e3c1b52:
>=20
>   andes: Use UCCTLCOMMAND instead of MCCTLCOMMAND (2024-05-30 16:01:13 +0=
800)
>=20
> CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot=
-riscv/-/pipelines/20920

Applied to u-boot/master, thanks!

--=20
Tom

--vVXzI+LGcdWgq8ni
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZeAGUACgkQFHw5/5Y0
tyzKKwwAk5lGfNAiGJFGNQM+6HmeGxa59HYqsObz2Wmfj9TRmzhff/wWW7ew1SSk
sA7cMQxlCqbHXBTr104rEkWKTTOx8DlBLm26RQhVTVMrvWYiMmRzUagDCPsQ1W3u
xlblcpgHz21PgOtq2f0JG9KR+6cAabma7X10Fb8Z6zz1yONQRPo+cQCJPW41198t
W6g1RpdhIk65grB1AJPGysFDT3ksUjtHu0tktxi7CcP17OLvYBYJjEK3lpz8ARAJ
7vPBWf0X0z/JCtziaRFPhFglyN23LFIbndtmDKtY1nWgmprNJZHROXjyKAzzCRN7
Wuf0TBE2ak7BXRsgEFbBx+e91E7jYui+ZbKhNsinbs8Z0uZfqUJvzxUrJ/JRtDqo
zEcHmRxVwn7K7grjOBOvbclaqlGWr5rLQr3tNT33XgWjHwEd/YMTS5NR6QQ/sV+V
TlbMuTM35r9Aaz+3bz6wK8/YVSq0QA6Vy92txNVc0YjSUvx7JceA52qnheIceAG/
8Vj8Rzmn
=Vzjq
-----END PGP SIGNATURE-----

--vVXzI+LGcdWgq8ni--
