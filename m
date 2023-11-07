Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79864C4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 23:32:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EACD187658;
	Wed,  8 Nov 2023 00:32:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ocW0XHxn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00C4A87658; Wed,  8 Nov 2023 00:32:37 +0100 (CET)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 981C2875FC
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 00:32:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-66d264e67d8so39472456d6.1
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 15:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699399953; x=1700004753; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9liMJacgSTuDA1+ZLqM1SyO1kDu/OfQEWhU13JkxhKc=;
 b=ocW0XHxnNN86CYln6c/uHm69YSIl7pEEWtMPGitPMq9YXDegtBkVwWzyH2rbHDwMjz
 Rs27vt2OUl2aOmF4QiBh5ZW/0nUf8/wHp/AlRQ4un5ub1UILJSMbJkmrY2xENpE1Wd83
 i7hFoudLNG8mxwlXdN1jtZTXj2kXvOV2JTiTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699399953; x=1700004753;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9liMJacgSTuDA1+ZLqM1SyO1kDu/OfQEWhU13JkxhKc=;
 b=NG1VooV1VvHAu/UFE7YkDZKSB6iHYIeDW0WXRDdhVM318VlHkcDsWHvDfGknBoj2mt
 wqsUJJyeLoipaAm2qJ8tH9rvhlsXOYYoFVgz7R4rULw+BIYGaik67sfsAYFc1S61SXKU
 VDnkUBaf10eBQ7i2CCDnn4ZWWDo1q87iHE1QkalpTRWiWjMuj6usZwCnMvVbnfojhFZB
 GkabFEyrf1XJo2+atGAwItt7Rkj9pry7NVsaBdlL15YTZZ2n11K+H18Mp7OBI7U/NjRU
 yEJoJa/25qGWSlzfoarauM0gSewIX3Eqi73/Fneg2WA6V8SMYcggwHIZtPilyHr7jq+Y
 BL8A==
X-Gm-Message-State: AOJu0Yx6OVlneJcA4/Kcx4rCf+4W4gBGpwnRMReRPH35GJhpvcJKXn7Q
 SSxYqW+JG4u6YqUc20TSuWPfsw==
X-Google-Smtp-Source: AGHT+IFn4FyWdhwB778gi/mPHJmbhJbrnIyOtk0Z70jWp1pTXqICCy+ZSnBheqhAsC8FNQjxscIP7g==
X-Received: by 2002:a05:6214:1cc7:b0:66d:b8bf:d9e8 with SMTP id
 g7-20020a0562141cc700b0066db8bfd9e8mr269640qvd.4.1699399953391; 
 Tue, 07 Nov 2023 15:32:33 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5409-8f3c-5603-0314.res6.spectrum.com.
 [2603:6081:7b00:6400:5409:8f3c:5603:314])
 by smtp.gmail.com with ESMTPSA id
 e6-20020ad44426000000b0065afcf19e23sm409260qvt.62.2023.11.07.15.32.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 15:32:32 -0800 (PST)
Date: Tue, 7 Nov 2023 18:32:31 -0500
From: Tom Rini <trini@konsulko.com>
To: Bryan Brattlof <bb@ti.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, Andrew Davis <afd@ti.com>,
 UBoot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 2/3] configs: am62ax: setup the 32k RTC crystal
Message-ID: <20231107233231.GY6601@bill-the-cat>
References: <20231107232139.2839534-5-bb@ti.com>
 <20231107232139.2839534-7-bb@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qfUeHpyr0LzyJ+lW"
Content-Disposition: inline
In-Reply-To: <20231107232139.2839534-7-bb@ti.com>
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


--qfUeHpyr0LzyJ+lW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2023 at 05:21:42PM -0600, Bryan Brattlof wrote:

> The am62ax utilizes the same 32k crystal for a more accurate RTC clock
> source. Enable the configuration to set this up for Linux.
>=20
> Signed-off-by: Bryan Brattlof <bb@ti.com>
> ---
>  board/ti/am62ax/evm.c            | 5 +++++
>  configs/am62ax_evm_a53_defconfig | 1 +
>  2 files changed, 6 insertions(+)
>=20
> diff --git a/board/ti/am62ax/evm.c b/board/ti/am62ax/evm.c
> index f2dd3b4192ee0..6e031784766c4 100644
> --- a/board/ti/am62ax/evm.c
> +++ b/board/ti/am62ax/evm.c
> @@ -14,8 +14,13 @@
>  #include <fdt_support.h>
>  #include <spl.h>
> =20
> +#include "../common/rtc.c"

Oh goodness, no, we don't include a C file without very good reason.
Build that object based on whatever the right symbol name is (based on
my feedback in 1/3) and find some appropriate header for the function
prototype to be in as well. And this applies to 3/3 as well.

--=20
Tom

--qfUeHpyr0LzyJ+lW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVKyQ8ACgkQFHw5/5Y0
tyztzAv/T/6v/s+2ZfFd79mQzoxR8LVn14kTAHCE4CORaspGD+I5p3s7vC9pJhrY
Iju+bCRP098LE3mUiNOK9F4DLSfIcoJxSm1ADRXN22nhQVZmnmm7jmf8ZxHv0P3G
mjgEdu4HZtjBP5TOC58wXZepKNQGAwcqng0+yR5PAGXifOqmj+id+z8sNB1nDwpb
1cUP9X338X9ryW7ijc70YF32GT1LCla2swLrUTTrM2UAvlD5+1YVrMCis4FP1L/+
n3W82/LGggunNtz53Srqb4A5Vpddu7AHOwd5kuAZzc3x5loaK2eM3E0+iOq8zpsa
Cp4m9BqORMElWGdu85FQakA+0/pp0ExG5OSsdEqpbjsUe7qJIcSZAW+w8S+ZFGBn
TAeTMlTQNMNiKZo/67BnxsixeYb2EfrtK542MMBw0PP6DFzh7jPvPNQ7uK5Z4KTf
HWfDrbUztCEFY1MPpHJbnOmKEGvA6I8rA+Ji2ua8mWp8jlywYyT4LW4ZuTPkTs3j
799Xlokw
=D7vX
-----END PGP SIGNATURE-----

--qfUeHpyr0LzyJ+lW--
