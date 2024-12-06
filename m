Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4185CE77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 19:50:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91B718913C;
	Fri,  6 Dec 2024 20:50:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="r6IzQrFD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B563089321; Fri,  6 Dec 2024 20:50:33 +0100 (CET)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9205B89100
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 20:50:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-7b66d55522dso283642785a.1
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 11:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733514630; x=1734119430; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=K++w1tu5XQo/jwEFPrGehtRUGjXFPrKXOB7taMx7vhI=;
 b=r6IzQrFDUUjICxdkWbX1hgOg4s4CQBBnl7lNShJlAjBJKtvsB5VEOKyieutuWfhA9U
 AmDe26ZfP5Z6GBvWVh10+UQ70wsjEhoTfFmcXfq62qIab0SUD6F4F6a5ipwfKbpTjCvb
 /wPfZm8CqkQ3Z3TTaeq4irmk3jc+iAZr4BUFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733514630; x=1734119430;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K++w1tu5XQo/jwEFPrGehtRUGjXFPrKXOB7taMx7vhI=;
 b=vyadytLqwNt4mTtuhTipatWqSfG4zS4DVvqaFr7820vaNgtsUjZkptZ5FVF7tQDU2+
 Fn8sdbDMJ8WpMKfbGziRfInU/XHDzIUkbKTs1U+2ENcK4U4l6dCt3k82qYuA9c9MEgMV
 nE0dTnxmR6qY63LsKIOU1xfYKh5DNYk4CxFsPnK0ykb+rygieboEjSaJG/jZgT5/0TTJ
 0VL7fYTkGxyfeBTTImY2lyC6hXU9YtQwujGezqhMEkorFLvHe3zC7qceakm24HSaURIb
 rDJRPAlztgIgZ/T1/9e1I/Ttp1oeU7IYRPAT9nqZ4gFpHDJdZjv8zgHpskT+GdaaopwW
 m10w==
X-Gm-Message-State: AOJu0YzEKBrpflL5YRbxckVxs9AybjaDCLXkIHvKOTdi/P8FULwNLoqu
 kQATVbwSUgBl9V2heujdE2P51AzGeKMD5LUv0o7N9UELvM4Pse44cgjo4oPhLnk=
X-Gm-Gg: ASbGnctr7i2f1xXSEqZhPyG0FgWskujCuTeFeVu2ADBPFb1yNV4At/Lbyx+LzKiyAbn
 h4Olkq+IfhzV/l3ITEuqgs8QKDXKBoCFrxfxcQUnAFf4o3jJ8TGUuSWbVwGEX2c+D6dq+ObIbSI
 9WnjioDjUHxmlgw0a1d5lFkrzUbq0U5X9rCL6FvK/32kh/rYbLBKUkRmqNe+0wJLg2GWsdT7Jt0
 JXYznnuOmq7SrYUl+wqMUk6cSjG8gamF/7N8ymiMM+VVqsPoA==
X-Google-Smtp-Source: AGHT+IGqE6HvVOk1V6OFzyNx4MMilxeEYHKnFU/Xwc7B3KeuFS8lGpjrAOc1nFTnfNbfV4Lx7T00JQ==
X-Received: by 2002:a05:620a:3950:b0:7b6:6756:eef5 with SMTP id
 af79cd13be357-7b6bcac26bamr739664485a.4.1733514630488; 
 Fri, 06 Dec 2024 11:50:30 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b6b5aaf6a2sm203801185a.124.2024.12.06.11.50.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 11:50:29 -0800 (PST)
Date: Fri, 6 Dec 2024 13:50:26 -0600
From: Tom Rini <trini@konsulko.com>
To: Adriano Cordova <adrianox@gmail.com>
Cc: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com,
 jerome.forissier@linaro.org, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: Re: [PATCH 0/2] efi_loader: efi_setup: Add efi_start_obj_list() and
 use it to set PXE IP address
Message-ID: <20241206195026.GZ2457179@bill-the-cat>
References: <20241206173033.2403998-1-adriano.cordova@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3E8IVVTqqALgWNSq"
Content-Disposition: inline
In-Reply-To: <20241206173033.2403998-1-adriano.cordova@canonical.com>
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


--3E8IVVTqqALgWNSq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 06, 2024 at 02:30:31PM -0300, Adriano Cordova wrote:

> The command bootefi calls efi_init_obj_list to do the efi set up
> before launching an .efi payload, but efi_init_obj_list is called
> only once. There are some initializations which depend on the
> environment and should be done each time a payload gets launched and
> not only once and can now be done in efi_start_obj_list(). A motivation
> for this change is the following order of events:
>=20
> 1. Launch an EFI application (e.g. bootefi hello)
> 2. Change the ip address
> 3. Launch another application which uses the pxe protocol
>=20
> As the EFI pxe protocol was initialized when the handles
> for efi net were created in 1., the ip was hardcoded there.
>=20
> In this example, another possibility would be to make a callback for ip
> address changes to go all the way up to efi_net.
>=20
> Adriano Cordova (2):
>   efi_loader: efi_setup: Add efi_start_obj_list() to efi_setup.c
>   efi_loader: efi_net: Add efi_net_start() to efi_net.c
>=20
>  include/efi_loader.h       |  1 +
>  lib/efi_loader/efi_net.c   | 31 ++++++++++++++++++++++++-------
>  lib/efi_loader/efi_setup.c | 24 +++++++++++++++++++++++-
>  3 files changed, 48 insertions(+), 8 deletions(-)

On top of the previous series that fixed my other issue:

Tested-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--3E8IVVTqqALgWNSq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdTVYIACgkQFHw5/5Y0
tyyXBAv/QxcCoCopS7fZwvRS7gsYM1ynl8llun70EzwmqlKeJ/7uB8Qpz6gICR3h
6O065DlX1q8s/nw0AqWu1/q4Js9mxIzu/yZ/4DkLM68pg2yK51PHDkAIGEJaxpqq
eaY8vP2D5V8fUM9Z/9yxSmQVBhv2OFhgHegMMQDcx5Zyg4wGOeOtNd4i+kETNcId
67Yz6VqYgRYg4kSpp5jUjToBm8cpo7pfSzFl6QSu6evFYXi47FOhI7BxYdPixPXX
K18lLIezYzi1nW67/LIoInG30BOzvjWfVr2m6IkN4nuORQ9buFAKapptlW0mvg0Q
gof+BtdFWGEqPVdC1i38iohywDR2HteB9SNx8NudNGI4DOwMaNZptMLHcoZ+Vyv+
d0Dw2xswa5/KyoIprXaXvEwChlayQC2S6BznvzZ7ZnvswxBU/BDeVeVb6kQuTiJC
LqGDohXevh0PPaxAo61nasHXUjeTv9ea0WVKQqQ5uexPyDAQ3kUIeq79/Cdkk6AU
bYmyV4Ls
=iBBL
-----END PGP SIGNATURE-----

--3E8IVVTqqALgWNSq--
