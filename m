Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA65C61D85
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 23:08:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 837E8875E9;
	Wed, 22 Nov 2023 00:08:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aEDaPO5U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD51C86BFA; Wed, 22 Nov 2023 00:07:59 +0100 (CET)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BECEA875E9
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 00:07:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3b8339b0904so758547b6e.1
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 15:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700608076; x=1701212876; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1N/wd2t2zG0zqw7ZuqH4CSagE77x+/hN22eAXRR3rxU=;
 b=aEDaPO5Uo0fHPEKiCTOSRFtIahDb+8uZDiblOOrqc1TBGJUqjNoShi27YXgwDIM0jB
 +P5So/3ElLVNMEIdcB66Hjqfmy5Un6LrwwgPuCmgJeIZVWiaBIXo8ib6/lXRuBElfvvm
 hwGrdgNJPtaDKu9ehhD+ZTFsNzrHNhkDuhTfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700608076; x=1701212876;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1N/wd2t2zG0zqw7ZuqH4CSagE77x+/hN22eAXRR3rxU=;
 b=JeGoA1Aqa5PjlGKiHzkIb/ocl3xYq97BxInqXh2lcfMOvjlWoH9oGaB5pk0yqvbe+f
 GwjPkRaI7NUyYfIrTzhe4R9Yeb3Aie1TbOvaQN8gFSZ7a0sfiBJOb8W9f5WecsCd6rj1
 RJX1E+jbBHHH6GxnGbkDw4S9sCR33j10AXl5vfDRa3SiRBL4qyKhtf5YlBO/mMFgLgI4
 5SKvINMsPoeDaoa4fu3/5gVhgdR/qdgxD01X7ZTiVUbF4L7mSTVJmBZDnlAgVkJomMfI
 bTOOPbSQ2wISdnBElUW6EATFARUXsKhqYUUfU+qyj47vGq/BPn8dcRuc4W/a+nW5euHf
 Faqw==
X-Gm-Message-State: AOJu0Ywky+k1MkLq5VI7tfZ14Ij8nnl367Si/QsIFKRmJd/tcdpQXwEy
 1JwTDPOWNk9rcIUbemGzTejUvg==
X-Google-Smtp-Source: AGHT+IHVBL6BvHqFuAzB90qwcdfmZunn2a4wlFiN90nyHbwGZS/W8Af3lmgsWbKhUcSM3emwrGzWXw==
X-Received: by 2002:a05:6808:8e1:b0:3ac:b73a:757f with SMTP id
 d1-20020a05680808e100b003acb73a757fmr776192oic.39.1700608076357; 
 Tue, 21 Nov 2023 15:07:56 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-999e-39fe-b112-e0fa.res6.spectrum.com.
 [2603:6081:7b00:6400:999e:39fe:b112:e0fa])
 by smtp.gmail.com with ESMTPSA id
 i3-20020ac860c3000000b004198f67acbesm3924875qtm.63.2023.11.21.15.07.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 15:07:55 -0800 (PST)
Date: Tue, 21 Nov 2023 18:07:54 -0500
From: Tom Rini <trini@konsulko.com>
To: Love Kumar <love.kumar@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, git@xilinx.com,
 rfried.dev@gmail.com, v.v.mitrofanov@yadro.com,
 seanedmond@microsoft.com, emohandesi@linux.microsoft.com
Subject: Re: [UBOOT PATCH v4] test/py: net: Add dhcp abort test
Message-ID: <20231121230754.GQ2513409@bill-the-cat>
References: <dd44fc9bf39e0debc9d0bc78a5d9215bace26023.1700571693.git.love.kumar@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BSJ0xn/bAMYLmuGe"
Content-Disposition: inline
In-Reply-To: <dd44fc9bf39e0debc9d0bc78a5d9215bace26023.1700571693.git.love.kumar@amd.com>
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


--BSJ0xn/bAMYLmuGe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 06:32:47PM +0530, Love Kumar wrote:

> Abort the dhcp request in the middle by pressing ctrl + c on u-boot
> prompt and validate the abort status.
>=20
> Signed-off-by: Love Kumar <love.kumar@amd.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--BSJ0xn/bAMYLmuGe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVdOEkACgkQFHw5/5Y0
tyxlegv+Lx0bvr6fq9Fs7cJ+k+w7qekQQ1sSavTEItkt4UuLGwQCTHs7a6dlA7xS
H7Cmc9Qe3w9Q5upIlZeEJ+Js5//4BkWpmj2FY6VErb7ZfwCoG+gcr1LH/dyejpQP
7AcCai7yuETZXlmzCZ9Y+QEH4O9x0VhhMnEphPg8JpT/c9dkck6PCjchH+vDHKCY
bV8G3Jvml5L/2vE9fmhBbW0u0dCuVJ9TIX8faVZNrUGWvlTprqi7JnOsdlFZXLhp
PQMRYnPXumNur1juOCcs/z94F662jdSyICLzOlVAhBdA2OO3Ng98YBOby0JAka7k
lc2wrHtH2Q3kziQSHf9skB73OQePBYDdX3+U+BXZmYIYw2dDAOSIpix69+ioQK39
+tS5ixvU77nOsFPJX467nDqXqrpXU3s/V9cOpvJVrlwXenn/mCFAA8Go8UuFLJtm
7qfTmJak9Hmb7ljQNJGdDOJKWV6bxMUSj758zgPA7/zEn3Kdtwz9lv6mVW+X9s86
vAcjP2Jh
=E5P5
-----END PGP SIGNATURE-----

--BSJ0xn/bAMYLmuGe--
