Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86C7AE7716D
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 16:25:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB6FA8944B;
	Thu,  5 Dec 2024 17:24:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="P2XJUxAi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45D5D8903C; Thu,  5 Dec 2024 17:24:58 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D606086DBD
 for <U-Boot@lists.denx.de>; Thu,  5 Dec 2024 17:24:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6d87e0082b8so7958756d6.2
 for <U-Boot@lists.denx.de>; Thu, 05 Dec 2024 08:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733415895; x=1734020695; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xa7tKDM5uG4JFG0OQIBiiTBzFPRCVoaI3uM51j0OHUc=;
 b=P2XJUxAi9mxm5IclCCHvxAswGWt4geLLtB9BLmQ+ePNc8/8Bslv3yfnvecxBWY2kYo
 dzv9X6axzaHflEZL6nVVev+GMI7UEumxz9/LN3dJ5nVf27JVy/YFYyApnS9JZ7vym536
 YFqXSTvd9HmR7Vh7Pr3r/DCsL9TB3BRaRQUzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733415895; x=1734020695;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xa7tKDM5uG4JFG0OQIBiiTBzFPRCVoaI3uM51j0OHUc=;
 b=tA4NFBywJBGMHFCsomj90bg1rLIm8k85qI8Q4Y7IjpgW9YePHTmiMpuNE7zG5tLE88
 Xv79f2MQXsyCeOxQrTHXJNLLefGX5haXfMlie62AwvVMdv+jgFVyL/73RCMGECkjCTVb
 oMaUByojgXzZNKQ1es6JBVpAIMF9LCutqyA3Wu5V0YTK53+9UGrkLh+pG92+0r0oppT0
 aY5YhJWOxSVYL4vWy52wq8AFNnib3ifivGJK/WGfaF5vb5uvvR07ivPkK5hEDJXPAgwN
 m0nUl8b3H/xOKa/0gTFxNXBbvZ3B/hXeUVkV8hx4xv+RjoiTa7whFFlqJP/z0vLT3uVR
 tggA==
X-Gm-Message-State: AOJu0Yx9I8B9SbdBAdme2a5tfl266dI8rwqAXCSa7+u9/Iy7/yXxxUfQ
 rvQCM+o+nhdU0zVmugBw0FWRchykm+qf0nKEXyO0p7CVnEylGF85m9ZvJ5n4L7s=
X-Gm-Gg: ASbGnctw69YsCZPw78HML+gWcPzuRuDrVWGApfjQYlKT6vjS0iyLDBAuLC070B9RR+Q
 r69BPSykK+/ytSbuuS81OwjDB27oR7FhxfRUkqB80oOVg/lROVCr3rm679+7JPccXNd2f7VDCwj
 fWPSaRg+eaW0Iw22oBwMVh5QKw9eIE9uhNBKgpbW1CFdDvzNSZb6AVw7X8r73ngYG4wazX5A5kI
 vZIQcdvrOKCTLKzd1gE9Y0wxfsjQSsBo9z6NPFxL/bjGIVUKQ==
X-Google-Smtp-Source: AGHT+IG6mDlRSQkSz8Nqu+yyUX5+8unyN8fJj23Sd5jwCiJVkRbvymVqwPbewvGKbEZl87GYZ58eBA==
X-Received: by 2002:ad4:5d65:0:b0:6d4:b1e:541b with SMTP id
 6a1803df08f44-6d8b739d682mr173230516d6.21.1733415894741; 
 Thu, 05 Dec 2024 08:24:54 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8da66eed9sm8013216d6.12.2024.12.05.08.24.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 08:24:54 -0800 (PST)
Date: Thu, 5 Dec 2024 10:24:51 -0600
From: Tom Rini <trini@konsulko.com>
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: U-Boot Mailing List <U-Boot@lists.denx.de>, patrice.chotard@foss.st.com
Subject: Re: [GIT PULL] Please pull u-boot-pmic master
Message-ID: <20241205162451.GN2457179@bill-the-cat>
References: <CGME20241205025813epcas1p48a97abeabb5fa0ca5ae22443963c9117@epcas1p4.samsung.com>
 <80755d2a-748b-455a-a910-82bde9dd9740@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="u9t97uRPeTZC56tr"
Content-Disposition: inline
In-Reply-To: <80755d2a-748b-455a-a910-82bde9dd9740@samsung.com>
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


--u9t97uRPeTZC56tr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 05, 2024 at 11:58:12AM +0900, Jaehoon Chung wrote:

> Dear Tom,
>=20
> Please pull u-boot-pmic master into u-boot master branch.
> If there is any problem, let me know, plz
>=20
> Best Regards,
> Jaehoon Chung
>=20
> CI: https://source.denx.de/u-boot/custodians/u-boot-pmic/-/pipelines/23718
>=20
> The following changes since commit f96e5133184aac377b54bd61f8abf78710f2ee=
56:
>=20
>   Merge branch 'master' of https://gitlab.denx.de/u-boot/custodians/u-boo=
t-samsung (2024-12-03 12:37:20 -0600)
>=20
> are available in the Git repository at:
>=20
>   git@source.denx.de:u-boot/custodians/u-boot-pmic.git master
>=20
> for you to fetch changes up to 74cd1af1124fbe3cd16c58bc3ad9ff1f9c6ecf3e:
>=20
>   power: regulator: replace dev_dbg() by dev_err() in regulator_post_bind=
() (2024-12-05 07:31:31 +0900)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--u9t97uRPeTZC56tr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdR09MACgkQFHw5/5Y0
tyydrwwAlpEpzlcVuue/A1p2wwh5yGw8MtA5G3u07q7dbxU6fP5mPWngzKHVfXSX
S7/+j/t48GRePXvp7NdEMqdz3/BWiK1UV6kRV+F+/xpSXDZJ5RabRQ422ms9HGag
PG20Ns967bA5DCyCcwLN8imexGZS+6n8Ecw1ld7DuCcSkRfhwRq1ep06RKd7DOw5
ag6zhxLoto+S03Lvu8eGiJrERGtCrWHvzk48DH2Cx8+d1Oicr3XAr8DjtysnTKLZ
xfjUkZLI7qncFIe2q6hXCudXELXGmragq1q1DHbTPdMqsQDzRmN4emfjY7WILt4c
PiGZNlgwkPZBP/5WWhHtdmpZ1erlWYaH9uDkrgkMCjDHl93DWIzNLuy9ZQ5H2rT5
nEOor0Jm1yMf7Q1QD94jZlCQID2BKfpmjX+90M3wQcOZHP+jl5jqd12uFYeWk5Es
KOf1LEaP0uPNwwBNBUBIjlElIovZByyzNaMuJ2K7RoW1VNxikJXaoe7Fkn++AzWb
8N/vpM0P
=tyVf
-----END PGP SIGNATURE-----

--u9t97uRPeTZC56tr--
