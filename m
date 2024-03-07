Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A6AC54E49
	for <u-boot@archiver.kernel.org>; Thu,  7 Mar 2024 17:12:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6514287CFF;
	Thu,  7 Mar 2024 18:12:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UIBDSnpg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0E5087CFF; Thu,  7 Mar 2024 18:12:07 +0100 (CET)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D24EF87C83
 for <u-boot@lists.denx.de>; Thu,  7 Mar 2024 18:12:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-68fcedcf8aaso6467016d6.2
 for <u-boot@lists.denx.de>; Thu, 07 Mar 2024 09:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709831524; x=1710436324; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=peWO4MO4W6QfFRukrM5g8eG79Q9EWQKkVlud2bQEGZM=;
 b=UIBDSnpg9rtetp296KeFOuh05AnRtZbSf6QnSsnJGQgunv4QgE9XedJkzzbmbWvsou
 kq44ERA+2Mx7+P13kbBTWrie+CKO/v0IuY0T9jjrsD9ksmnnoXwZWFdDL6CGnXBVD1i4
 u6RW2wi1+gEpHwgv9niHluDx9Rk8UcqzxbcyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709831524; x=1710436324;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=peWO4MO4W6QfFRukrM5g8eG79Q9EWQKkVlud2bQEGZM=;
 b=Z2hHV6Y3tYpft3hZfi5S75rvvwJk9WCyikfWxUV2xAchOdXZB9xNwpkTVLV2yVjvu4
 hIPsyhSyciVsSgG20B/vboOLn9LAtgtYuTMpXVfQgFeH1WXjFf6Tar5BUvovw8ksw8Si
 SEZOQLPzDX7bZ3zVdEAZoM/M3DB4YbBHxHnsNw0PEEkuz+UJLbUYxUIah72GcIF0vW5k
 /lEiC+Ym163HVbA5IKJob/YmL9BemzCbEG6CigZYmrNGiWsd17imWufpvydIicxRmQnA
 qlUMTrDhDu4ofLXv8izg7m5lkNc7bzMd9Y/GupNeHuFem4nPsvPzoe+Zses5GdJ/SSQH
 5mew==
X-Gm-Message-State: AOJu0YyfQ/iMLs5xZ4EDgooP9qKhE8B2n69MjO/UBsrm7m3/LV/sfojv
 sC6qkE32sfIie6GBcBmVwYG/tVkeIHNJuqqOJk72uVSRfp7MviqabuxV8vK109A=
X-Google-Smtp-Source: AGHT+IEPOB5k0LMaV7n6HM/lO2qjJ4Ht/3zQwV8z1qCzpJHrwr+1U8Xto+hJ/ZzTvAVivbD3KuLz+w==
X-Received: by 2002:a05:6214:1847:b0:690:83f4:8344 with SMTP id
 d7-20020a056214184700b0069083f48344mr8545877qvy.46.1709831524614; 
 Thu, 07 Mar 2024 09:12:04 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:7f::1001]) by smtp.gmail.com with ESMTPSA id
 jh19-20020a0562141fd300b0068fef023e6esm8936313qvb.88.2024.03.07.09.12.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 09:12:04 -0800 (PST)
Date: Thu, 7 Mar 2024 12:12:01 -0500
From: Tom Rini <trini@konsulko.com>
To: Igor Opaniuk <igor.opaniuk@gmail.com>
Cc: u-boot@lists.denx.de, AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Bin Meng <bmeng@tinylab.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilya Lukin <4.shket@gmail.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Roger Knecht <rknecht@pm.me>, Sean Edmond <seanedmond@microsoft.com>,
 Sergei Antonov <saproj@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v2] cmd: md5sum: use hash_command
Message-ID: <20240307171201.GI1523872@bill-the-cat>
References: <20240302150548.574383-1-igor.opaniuk@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eeEnBIV9yhletRLb"
Content-Disposition: inline
In-Reply-To: <20240302150548.574383-1-igor.opaniuk@gmail.com>
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


--eeEnBIV9yhletRLb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 02, 2024 at 04:05:48PM +0100, Igor Opaniuk wrote:

> Drop old implementation and use hash_command() instead, as
> how it's currently done for crc32 and sha1sum cmds.
>=20
> Test:
> =3D> md5sum 0x60000000 0x200
> md5 for 60000000 ... 600001ff =3D=3D> e6bbbe95f5b41996f4a9b9af7bbd4050
>=20
> Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>

So, I think this patch shows there's a bit more cleanup to do around
crc32/crc16. Some platforms show:
   aarch64: (for 1/1 boards) all +1042.0 data +168.0 rodata +38.0 text +836=
=2E0
            hikey960       : all +1042 data +168 rodata +38 text +836
               u-boot: add: 10/0, grow: 1/-1 bytes: 988/-272 (716)
                 function                                   old     new   d=
elta
                 hash_command                               200     472    =
+272
                 hash_algo                                    -     168    =
+168
                 hash_lookup_algo                             -     116    =
+116
                 crc32_wd_buf                                 -      60    =
 +60
                 crc16_ccitt_wd_buf                           -      60    =
 +60
                 hash_finish_crc32                            -      56    =
 +56
                 hash_finish_crc16_ccitt                      -      56    =
 +56
                 hash_update_crc32                            -      52    =
 +52
                 hash_update_crc16_ccitt                      -      52    =
 +52
                 hash_init_crc32                              -      48    =
 +48
                 hash_init_crc16_ccitt                        -      48    =
 +48
                 do_md5sum                                  320      48    =
-272

And prior to this patch this platform had enabled CONFIG_HASH already.
That said, applied to u-boot/next, thanks!

--=20
Tom

--eeEnBIV9yhletRLb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXp9WEACgkQFHw5/5Y0
tyx6YAv/a8j1Lb5ORem664bDP8egJgQvqd3KXi0oHcL8lYWsZuEKNg3Ns/cKEDam
1thTr1eovpJ4YuxkKJngSzaWsi4OlInfPC9sSRqYvPYDv4PKmeO3odV/IyZxF8Nk
Nbpba7ZJlNU/l8fnOT3r6Oea2rb/Ico6OJfRJB8W/OE+S1mU/KlSlgNM6aagKGbq
3Y4vmNml50S8vqmFiBWjZTHlwLfAWzQKQKSESQEYnMLWJZaJ+E0zz7vIpKKkefyA
xNUtM8kVn56kCJV7v6R5CVRnv1Y6jKbrktPzmSLtJAzhkl52g3PdnBx5vEhvSmNA
FYEA6pxG/uHSYBC/1jFywCD1hxvvdlpJ2U8sC3sd9D6q1gRF5rUhO9lQjc5yGqjb
k9ZltJfaJmravn058aScM90bopwDt+pqYNnEK8Y9fTgZVIL3MLIf2kusJevoISed
fi6v0YmaZWPCb7SHiTaBP21YKcxjtaoq/W+NBqaV5Je/fxxFdaa01XLNH+nsJSHV
1PQFl3Ma
=CUn1
-----END PGP SIGNATURE-----

--eeEnBIV9yhletRLb--
