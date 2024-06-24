Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A79C2BD09
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 19:30:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C9A4883C9;
	Mon, 24 Jun 2024 21:30:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hn8SQEx8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D255883B1; Mon, 24 Jun 2024 21:30:34 +0200 (CEST)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 915A5883C2
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 21:30:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-2598ae41389so2601642fac.3
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 12:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1719257430; x=1719862230; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nvryH3iMTHGm1IBx2qkNM63Tb7KZvbbmKp66zXshKG4=;
 b=hn8SQEx8QpQIRqT+LuY1+venoGv+dIZkQ5VIaD5W6y0/Bb97aNHYgIwF2Zq8JDP5dN
 h+ALoMsQvheK8ZXEW41lhpApQsjDVUtcYlRkyXc7HMSNn9p7em7QhYMI1Hj36/WRy/0G
 7OZ7X6T+BQDoWrGb1OF1NXDREfrg/uDmIjM0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719257430; x=1719862230;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nvryH3iMTHGm1IBx2qkNM63Tb7KZvbbmKp66zXshKG4=;
 b=T/jPYBz85uYddvfDT9pWeuDNDNJQAl1D/pADP3bIjSNQeEWPhTj4cD/BqDZqEsG7TV
 Z1YIJGuZ7j4JkVEs7oAUXhVIK3/B9CTUIWZ6ElwXehNhvoz4tfhWQBm44GVdKYX0gLBq
 chZ4U8OiEXK4s/s5Hp4OrOCT6hKc9oYs2KtM812E1gWbt5aLaKfy1TkcDmms5sI7dZCC
 xM175y7lSK93oThBZm8eYVsCe9tzVXhc1kFet0yXpxTR2Fz19+S41GWP8CKrorKSJj44
 3xDGaXS+FUYsJqUq5npwKG5xHThzjHmoXojFBTNbawyC4TFa15QrIskca+u0QVQ3ct/+
 tEng==
X-Gm-Message-State: AOJu0YzOUJXvugPoPx9kwib7CFdcKHWzQuxV7DRnXAyws8m+4dpgj61Y
 zfj6r7m5nahDIBh/sJ1myaJfW5jcXNb0PLzAiFvPJyrQIAtVEvPa4Dc4jVueKWU=
X-Google-Smtp-Source: AGHT+IHx6R5eJ8izw4K0B9UtQdNqIp9s1pktaBYn0Xmlso8Nl0w3Eh3hY9Q+MRosTFLUGvnXyvjNcQ==
X-Received: by 2002:a05:6870:7008:b0:24f:ee90:4556 with SMTP id
 586e51a60fabf-25d06910c6amr6554281fac.0.1719257430116; 
 Mon, 24 Jun 2024 12:30:30 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-197-45.totalplay.net.
 [187.190.197.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25cd4b832ebsm2048579fac.46.2024.06.24.12.30.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 12:30:29 -0700 (PDT)
Date: Mon, 24 Jun 2024 13:30:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, sjg@chromium.org, xypron.glpk@gmx.de
Subject: Re: Pull request for tpm-master-24062024
Message-ID: <20240624193027.GJ38804@bill-the-cat>
References: <20240624122956.5739-1-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KHMmmCeBdFkw+poX"
Content-Disposition: inline
In-Reply-To: <20240624122956.5739-1-ilias.apalodimas@linaro.org>
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


--KHMmmCeBdFkw+poX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 03:29:56PM +0300, Ilias Apalodimas wrote:

> Hi Tom,
>=20
> A few last minutes fixes for EFI, but this time via the TPM tree
>=20
> The following changes since commit fe2ce09a0753634543c32cafe85eb87a625f76=
ca:
>=20
>   Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boo=
t-watchdog (2024-06-18 08:34:56 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-tpm/ tags/tpm-master-24=
062024
>=20
> for you to fetch changes up to b73948c785d2bbccf0a76dec92cf50fe5b408c0e:
>=20
>   efi_loader: fix the return values on efi_tcg (2024-06-24 08:38:06 +0300)
>=20
> The CI is here https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipe=
lines/21309
> and showed no problems.
>=20
> I also tested measured booot looking at the EventLog pre/post patch. No c=
hanges
> apart from PCR0 which is expected to change
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--KHMmmCeBdFkw+poX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZ5yVMACgkQFHw5/5Y0
tyy85gv/UO3nVcWWkCQMAFdGOZ8d/qqhFnoVJxwO/+ZPZLgfI5Ho3RIQ9fpz66VW
NfN05NdoIlLIg/Kz8NMYNScGjhT9PR8wKgTSdCRbg5Nsx6W48xThEBEdwZSFp4nN
4AsTE3K1IfmvJq98M7ePI/+QcB+OC7aYERDuXosGKg3WPjsrMOhU+M2ZTMWp/L5U
Dm7RSaD4N7v+f2j8w/k+TJRuK7BpQkzGex9BXL1rnWFBqydtJvaXqC/mhXlQSCe5
b9STSPxSv6hsMlRLiY5R1Qp2an6jBlTVwGozukfbX5+A+0SpCGfAYsZUA8Yj3KHS
0UhdL5xHF1Uw+SkcXkqh7LgrBlDkepWJwnNH+WGSCkdRNleoJdm/WSEjVRzD4Tgz
VjySwQ/QPFwJlHOsNlEdMfBU4GGCNZ9hFShiJ9N9bLBT08Kz7IzJx7xvmsrNuxjH
qRhthfaftgnn2oxsvDoPZV95F46w4F1kaduAH6S16fG6uYNXOCpBVBfyiaIyzqIU
hEuwpMS3
=KQo8
-----END PGP SIGNATURE-----

--KHMmmCeBdFkw+poX--
