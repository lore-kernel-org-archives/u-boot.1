Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E78E8C021A3
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 15:52:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 632F1807B1;
	Mon, 10 Feb 2025 16:52:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="h0bnlBEg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9285B809A4; Mon, 10 Feb 2025 16:52:43 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A1B580548
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 16:52:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-6f277a1ecfdso31973647b3.2
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 07:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739202760; x=1739807560; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=slfku6kEyMlcGJr53oZfSMgSVPFGG2WauVtg3xrJZ5k=;
 b=h0bnlBEglXJ7Nv3c+sTO14LqkDb6kj2LIp2NTBVu4DhCtS6C+Z0qB5d1iX7fiwsd/q
 XDLZgDll/a2OG0IdLSonpWu3EJnIDAJFrs8a5YEL95uuJsVcpR31uDcyt+e3aFqxQ7Q6
 Aizu2Hm8efGSYGHm/Al+zpxPe+Fbn4tNGYAjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739202760; x=1739807560;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=slfku6kEyMlcGJr53oZfSMgSVPFGG2WauVtg3xrJZ5k=;
 b=e0+O+IZKP4q//FyFf/CNyDmw4n9aCOarmr8ohB66Dhmf/6cHFcXzKNblTJQupCmmuI
 nQtFHBO5alKrUcCsDE0RxLJETlcNQv4qwrwMjC6F5fRTb7VAA9wHQIEZsvq3YjI7vr66
 kUUa10gkcITyEnQZmrcziEGSIRdALH8KrIaFwreO6aa6K5OWeu7xw0ZddDzvJ3cQCJ8c
 ZaxMUhj64OpzCgfYdMKgAKfKLdX96koJNbpECe00QPm7Fe1g3JeDN3Yd/+7rZ4GK2wcd
 T2wfxvAH70x4xJfdvwtIonZDP2HKI43Ssiy+clrvRbH+on3gsLDmGLli7eo48NWcwhEY
 KSVA==
X-Gm-Message-State: AOJu0Yy5vikY2jFBuSYTN6k8b98vdEc2sxLP6O2K+f7s9pySfKhhgZ5V
 O4simA8NQehZjkvcFN7o3mKnwvsQB+8wBHoH/WqQ7TJivW2X/eNES/miFYvfd60=
X-Gm-Gg: ASbGncvrLmUmAKSk3pfWFHwdDPYA8D/rwQNMTZr48dc+XJqkjp+wddhxHWFB7QEP/eF
 ljwbnQ8Ia0mnpp5a6WdcMpv3SfSWWbtp18Z9EHH+DazgGkmh3vJiyz1LQVCNymeRr5uxUls8GD/
 qku+tPI8MjuBM/uW398AaVbDVKH9U3gZ9qxDCW7T6JI9UOQYMcAX0FdY3fCY8UIJFOf/M0wLHd/
 wrjaUjPFC77vz+a2I1Ig6dZpYyEMcBRnmzs336IG0NkzzQSBHaCBA277F4LPSdg+qbb0P6VUTai
 kyUplaI8Jmvbnvk=
X-Google-Smtp-Source: AGHT+IEga86iutXYrQopbJh9tOradwbGcIy14CpspcXD2aE5Zk9A0SibBhED5QbmXlQXUa/MNZANsw==
X-Received: by 2002:a05:690c:6810:b0:6ef:5fee:1ca3 with SMTP id
 00721157ae682-6f9b28744e6mr123059507b3.10.1739202759848; 
 Mon, 10 Feb 2025 07:52:39 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6f99fd55c92sm17130137b3.55.2025.02.10.07.52.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 07:52:39 -0800 (PST)
Date: Mon, 10 Feb 2025 09:52:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Minkyu Kang <mk7.kang@samsung.com>
Cc: u-boot@lists.denx.de
Subject: Re: Please pull u-boot-samsung master
Message-ID: <20250210155237.GJ1233568@bill-the-cat>
References: <CGME20250210043511epcas1p33ed93b581644b1a1a14a8710afeaaf97@epcas1p3.samsung.com>
 <00bb01db7b75$2be04630$83a0d290$@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9AozWLheJvp5qkFB"
Content-Disposition: inline
In-Reply-To: <00bb01db7b75$2be04630$83a0d290$@samsung.com>
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


--9AozWLheJvp5qkFB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 01:35:11PM +0900, Minkyu Kang wrote:

> Dear Tom,
>=20
> The following changes since commit 97c125e6bb441a8062bdd28e82f17b1da12244=
16:
>=20
>   Gitlab: Add results.xml to the list of artifacts as well. (2025-02-04
> 11:57:36 -0600)
>=20
> are available in the Git repository at:
>=20
>   git@source.denx.de:u-boot/custodians/u-boot-samsung.git master

Please note that if change your .git/config to something like:
        url =3D https://source.denx.de/u-boot/custodians/u-boot-samsung.git
        pushurl =3D git@source.denx.de:u-boot/custodians/u-boot-samsung.git

for this remote I can then use "b4 pr" to apply these.

> for you to fetch changes up to 16218681a5407c1973b3009f21b010a1c09b212e:
>=20
>   board: samsung: e850-96: Provide bootstd default env (2025-02-05 19:15:=
12
> +0900)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--9AozWLheJvp5qkFB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeqIMUACgkQFHw5/5Y0
tyzFEgv+OPo36xQGwoVmnwzp6QQ5fOFhcpBcVMptTUi6hJnoCS5Nu+0FyfJPKk0a
av4ZbIcVY2Nj/p8bHt+WfD1Py2SXt6dnsU7kxL0lxqTJMPzEAolV8vkjGLJCbKj5
lNExEFWFXobja3NAyono+ZUpSagTF/UIFR/0nlv+scIHkzJvFfzFhRI+dsF5yizp
I6ZdqR5dQNAA1b7CBObIJb2/77PGzVbeJaGHBZ/EeItq4OtlgKfI2NzQjV/H35MA
q7Ql4+SCX7ssss/IbAT2FbbvDeTdkavMj8QWeRfg0gOncDnSvDfOdT6EQorC5/tl
w/CKqcqcCTsMQtLSqE9ipqcp7u1TewBVgfAnxOAzYcRx4RowkorrfGTfiKKXQUdi
0Lk6nQ+iW9qJUIsVWa2Xp/ekV82BxEBqKGZrt1IN1Rf6PFF4oDjf2dyLBKncfJFX
49zg1u3QEYYKcWLeK8ESq2uk0og66h1l+PEgsYHd0L9xhNmQoy7Hc4NI/t2DN7SC
CU37G0md
=X/9G
-----END PGP SIGNATURE-----

--9AozWLheJvp5qkFB--
