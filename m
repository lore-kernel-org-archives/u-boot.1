Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 352AFC47DB3
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 17:38:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4956286BFA;
	Thu, 18 Jan 2024 18:38:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZrL5iEeh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 552BA86DC3; Thu, 18 Jan 2024 18:38:08 +0100 (CET)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3334F8644E
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 18:38:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-429c00bf0efso50019771cf.1
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 09:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705599485; x=1706204285; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=b3ABhRO4pJqtJ+FjVbsBi3Fbep0yanB+53L2NjJ0BeQ=;
 b=ZrL5iEehJVYPvqzTu5jYdBZkny97Thq2uxozNzdDLx8NXTcnXPpYdNoDnxReQeQop3
 Lr3wwepT6x5GwBFx4kw+eTA6TbbJpOHfbkdvjLfD50Z+r2Z/7yQvtSRIkTSE/0NXnnJk
 Y6e9ZMwN/jBPM2Lzpw/yxinLR3Z9Y9DT6ub44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705599485; x=1706204285;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b3ABhRO4pJqtJ+FjVbsBi3Fbep0yanB+53L2NjJ0BeQ=;
 b=aHC1ycPPPycVAa6NzdFbEDk9cWX2o3ffB0G1tdV8X77KPj3/QWfv5npkFk6+/nWwXJ
 Yh1XaTpuFLAZ3S1NkEBqkAX4byGrSAnL+62GPU1SOI9Nk4svpm1f7eQzhk4p7rsjPUa8
 Ev9GbHFr89Vdfi0L/qJ4/EnHwXvy2fVCVmT/1WfLH7z3BcnBK1jwWqhh7Dv+3ydVZbj5
 YVDmkNMlBrRhL1SyLBX3Vilf5O+NCYqpa651KQGG944awNJwCHZOxc8CETqQRT0BdvhH
 BqjHzLMlMvO4eQKR7mg18Nhcl8BqnbbxJQN8UV94xKTLOGGDvu7vraWkAhdOGPQdrvyl
 8U5A==
X-Gm-Message-State: AOJu0YyVBq3J/TDJrVMH2ZxK2yiQUv5kqVAj1zRkWQr7V1jgba6HU4Tr
 iN7G+EsZD9+8/qENq0rvlI45LRNbFs/AUrqWrsl+YvkuyfmIdy5pJoaYXoWay8s=
X-Google-Smtp-Source: AGHT+IFqLSDenKCg3hkbufHXm8iEmFltqXImgZFrnWbfZZJSF2ThLd9YBKOenpN8KdenaMRORaNNgg==
X-Received: by 2002:ac8:5946:0:b0:42a:1590:6a5d with SMTP id
 6-20020ac85946000000b0042a15906a5dmr1241495qtz.39.1705599484919; 
 Thu, 18 Jan 2024 09:38:04 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 hh12-20020a05622a618c00b00427fd4e1710sm6899561qtb.0.2024.01.18.09.38.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 09:38:04 -0800 (PST)
Date: Thu, 18 Jan 2024 12:38:02 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] boot: boot_flow_iter_set() called with uninitialized
 methods_flag
Message-ID: <20240118173802.GA2695740@bill-the-cat>
References: <20240107085607.63103-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="p+DsyD2xi7wzGR1R"
Content-Disposition: inline
In-Reply-To: <20240107085607.63103-1-heinrich.schuchardt@canonical.com>
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


--p+DsyD2xi7wzGR1R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 07, 2024 at 09:56:07AM +0100, Heinrich Schuchardt wrote:

> Some code paths do not initialize methods_flag before using it.
> Initialize it to 0 in the definition line.
>=20
> Addresses-Coverity-ID: ("467057 Uninitialized scalar variable")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  boot/bootflow.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/boot/bootflow.c b/boot/bootflow.c
> index 05484fd5b1..4b32d74fe1 100644
> --- a/boot/bootflow.c
> +++ b/boot/bootflow.c
> @@ -241,7 +241,7 @@ static int iter_incr(struct bootflow_iter *iter)
>  	if (iter->flags & BOOTFLOWIF_SINGLE_DEV) {
>  		ret =3D -ENOENT;
>  	} else {
> -		int method_flags;
> +		int method_flags =3D 0;
> =20
>  		ret =3D 0;
>  		dev =3D iter->dev;
> @@ -260,7 +260,6 @@ static int iter_incr(struct bootflow_iter *iter)
>  		} else if (IS_ENABLED(CONFIG_BOOTSTD_FULL) &&
>  			   iter->flags & BOOTFLOWIF_SINGLE_MEDIA) {
>  			log_debug("next in single\n");
> -			method_flags =3D 0;
>  			do {
>  				/*
>  				 * Move to the next bootdev child of this media
> @@ -302,7 +301,6 @@ static int iter_incr(struct bootflow_iter *iter)
>  				}
>  			} else {
>  				ret =3D bootdev_next_prio(iter, &dev);
> -				method_flags =3D 0;
>  			}
>  		}
>  		log_debug("ret=3D%d, dev=3D%p %s\n", ret, dev,

So this leads to test failure:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D FAILURES =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
___________________________ test_ut[ut_bootstd_bootdev_test_order] ________=
____________________
test/py/tests/test_ut.py:510: in test_ut
    assert output.endswith('Failures: 0')
E   AssertionError: assert False
E    +  where False =3D <built-in method endswith of str object at 0x563a7d=
ff6e80>('Failures: 0')
E    +    where <built-in method endswith of str object at 0x563a7dff6e80> =
=3D 'Test: bootdev_test_order: bootdev.c\r\r\nstarting USB...\r\r\nBus usb@=
1: scanning bus usb@1 for devices... 5 USB Devi...rder(): 5 =3D=3D iter.num=
_devs: Expected 0x5 (5), got 0x4 (4)\r\r\nTest bootdev_test_order failed 2 =
times\r\r\nFailures: 2'.endswith
------------------------------------ Captured stdout call -----------------=
--------------------
=3D> ut bootstd bootdev_test_order
Test: bootdev_test_order: bootdev.c
starting USB...
Bus usb@1: scanning bus usb@1 for devices... 5 USB Device(s) found
       scanning usb for storage devices... 27 Storage Device(s) found
test/boot/bootdev.c:228, bootdev_test_order(): 5 =3D=3D iter.num_devs: Expe=
cted 0x5 (5), got 0x4 (4)
Test: bootdev_test_order: bootdev.c (flat tree)
starting USB...
Bus usb@1: scanning bus usb@1 for devices... 5 USB Device(s) found
       scanning usb for storage devices... 30 Storage Device(s) found
test/boot/bootdev.c:228, bootdev_test_order(): 5 =3D=3D iter.num_devs: Expe=
cted 0x5 (5), got 0x4 (4)
Test bootdev_test_order failed 2 times
Failures: 2
=3D>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D short test summary info =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
FAILED test/py/tests/test_ut.py::test_ut[ut_bootstd_bootdev_test_order] - A=
ssertionError: as...
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! stopping after 1 failures !!!!!!!!!!!!!!=
!!!!!!!!!!!!!!!!!!!!
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D 1 failed, 123 passed=
, 89 skipped, 21 deselected in 25.70s =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

Which is in turn test/boot/bootdev.c::bootdev_test_order() and looking
at that code, I don't really understand why we expect 5 to be the
expected value, nor why it becomes 4 now.

--=20
Tom

--p+DsyD2xi7wzGR1R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWpYfcACgkQFHw5/5Y0
tyx/xgv/cQe0zAbxlqQ59JMnEZFtHPkNAQoj9Rk5Hulz8r9PirdxWK6SHJDaD+hm
AX5Vjfz25tFQ2hkH1joC+vpW2ojmfmL/Lqm17Wobhta2t634ITcB08WK1IkGhiB4
ZNfFVjcsk8gkyxyU9nWF/P9GCge/HXM6ETxKY0Iw2G7xTdeAnRPXu0mA1KiHnWTG
vzHPV6dFgwsse59LRSZ0xDrZaZTvrzC6VJ7syr3V7WjClGZDCm8UZXS2hCwSMxeP
FuMdHmNYcFEu96dNH232jxs1pJ1ZhSyaikSopG27kg4WUUII09hr98NssHPqeIjE
KSPfq0TqAFUM008ET/vnfVuk7cxEu1v2JxFMvgCxvh0HTuPg3w+I79uuM1hwJiQN
SDFtMv1R1CR8DqjgHMVdziG/Fv/FCXQXXFf8FOUA8yR6WDBaXMJTXHKlEXUz6iUx
e61LZzCjLPjwQhvXSlP11Di06vVW86ClcrxzT70Qu0TKjS3MRQCYUucXj1KS1JH9
2PCFX1Oi
=/EMg
-----END PGP SIGNATURE-----

--p+DsyD2xi7wzGR1R--
