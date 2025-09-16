Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6112CCAC59B
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 18:48:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66E0381E13;
	Tue, 16 Sep 2025 20:48:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="o27yxRpo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB9B98309A; Tue, 16 Sep 2025 20:48:50 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77118803CC
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 20:48:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-61ea79c1e91so2587544eaf.3
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 11:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758048527; x=1758653327; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DDE0oNyAm58H6cXWU/6zOLTEHFEJH3/mYQgYKXFmUT4=;
 b=o27yxRpoGc/y3enUmkNKCuarN3UTVBjwPOzBGsdKgiZ56oNahS3IJUdsnxVa51Pc37
 qwD0MZepoEMke07otp6C2GAn0JsfjvHaOGjEYJTBZwmlErLqygQy1GpNZR830eNMoTPZ
 7JJmUwIEGpm8DopYQQJB21X0zju71e34L+Lw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758048527; x=1758653327;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DDE0oNyAm58H6cXWU/6zOLTEHFEJH3/mYQgYKXFmUT4=;
 b=j7rvjz9/vGivKAGLsBC5l+lMkM43WvBpkRpKMIq8sUmYUBF+CUxlRhhlpDEX0iuTYx
 k7FvnpHx5q4CKtUOuBig1OnhEgFFfADkHhBL08Tsou0y1S8DnrKpsUnnVo9jIP96WnBQ
 7TeSn3YJUxpPu2b2n4d5teH/6+9W0uwNr0QtcXwztjB6JvMg+cjkMJAzTBLIXkYckJfV
 xoRdbgDJ2ahFaAkh/NGABXkBhSAXDpI94w1JiD2HzrJtmQI+1KkUYNlwSjdDSZ49pr0C
 6OVzDjoOKShoSPxwp2qzW+s/wTgcvJEzOMEfKeEAlEbHZBl5cnCq3I/NgeferKVg5YA0
 ZUkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaUUE9xXDKOP8+7Vb+dS+Tuw9bpqK2sKYwU80QWn+5rmz6nknTKTt/rDNycJCl8MYpv0Oeee4=@lists.denx.de
X-Gm-Message-State: AOJu0YxYFbMaAyaTvQ+G1xVnf8YHXZyL/5A8CEfFh4T1IzVe4BcDUvVq
 C0/zzoiIzExBKkxypMVKmASJhR60g2FRSDQsV+rnkgYweRvqpt9fA3TuLzoaIw0OjyY=
X-Gm-Gg: ASbGncv+Gfsnfq8y+t0ajYe+Qu6x+Ti8wkKb8vMqfbvzKkTGaPhUaKLH1KOvXCZkVPa
 V7PT+jmL2PScrS6VxaLEcjBguH256DdDKVkxyR8yrZiYElB6MtymZlMo/vhgk25HpMgNfO5miJl
 RvcGl8P/HlKQJdkVzgC1M34RlNwsO+ohhmHyDEc5J7iCpfj3G9dq4zMYKcUWhDr8ol8W0uSM4b5
 Kq2VDGrLNsYlbv+aYTdz8qiDChoH27i35U+ST2jgOKjQ0+wjgW2/0nU3neZVm4zMhftShDuVqCz
 oKsPRxL1xZUxF8p+LbC5KbkSNjZ2ch6PwM5AJMydP+L9SbtaGcGaAonAKsYmLqZg74K9MtEJGhZ
 VTTJzEv99CypbTMjEGXIa4O7D36GKf4GSi3kmp0ZAaQJYVz5pl27jlp5/
X-Google-Smtp-Source: AGHT+IEAOfGChgV2ZR4lGPZ6KXlglCcze84xG00Nl+Pp6gA4ti4kmzCTAPyMXBY+4JB6gl1sJjYUbA==
X-Received: by 2002:a05:6808:f8b:b0:438:2199:6874 with SMTP id
 5614622812f47-43b8daa967cmr8494578b6e.50.1758048527046; 
 Tue, 16 Sep 2025 11:48:47 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-32d33452e9fsm5043474fac.11.2025.09.16.11.48.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 11:48:46 -0700 (PDT)
Date: Tue, 16 Sep 2025 12:48:43 -0600
From: Tom Rini <trini@konsulko.com>
To: E Shattow <e@freeshell.de>
Cc: Vivian Wang <wangruikang@iscas.ac.cn>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.denx.de, Sughosh Ganu <sughosh.ganu@linaro.org>,
 "Auer, Lukas" <lukas.auer@aisec.fraunhofer.de>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH] riscv: qemu: Remove fdt_high default
Message-ID: <20250916184843.GF124814@bill-the-cat>
References: <20250915-qemu-riscv-remove-fdt-high-v1-1-661178447396@iscas.ac.cn>
 <20250915143227.GJ124814@bill-the-cat>
 <3caf66ce-f9f4-4072-9a31-3d67f392c37f@freeshell.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XN+rAcNura14xNbs"
Content-Disposition: inline
In-Reply-To: <3caf66ce-f9f4-4072-9a31-3d67f392c37f@freeshell.de>
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


--XN+rAcNura14xNbs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 05:25:23PM -0700, E Shattow wrote:
> Hi Tom,  Add CC: Heinrich
>=20
> On 9/15/25 07:32, Tom Rini wrote:
> > On Mon, Sep 15, 2025 at 07:45:49AM +0800, Vivian Wang wrote:
> >=20
> >> Setting fdt_high to all ones is discouraged and does not appear to be
> >> useful for RISC-V QEMU. Moreover, it causes a boot failure when the FDT
> >> generated internally by QEMU is used while booting. Remove it to allow
> >> U-Boot to pick a suitable address and relocate the FDT.
> >>
> >> Closes: https://lore.kernel.org/u-boot/8397369a-9b0b-4798-9c30-3a81165=
657d6@iscas.ac.cn
> >> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
> >=20
>=20
> > I'm very glad to see this finally and would like to see the rest of the
> > RISC-V platforms follow and do the same now.
> >=20
> > Reviewed-by: Tom Rini <trini@konsulko.com>
> >=20
>=20
> When you say you would like the rest of the RISC-V platforms (to) follow
> and do the same;  What do you mean?  Heinrich and I were trying to
> figure this out off of something you said on IRC awhile back. I was
> taking a guess it was the qemu config (and this patch makes sense to me
> so I think that's part of it), but what else? Is that a reference to
> sifive-unleashed config fragment, are there others?
>=20
> If you give us a detailed hint what we should be looking at it would go
> a long way and we can test / figure out the rest. Is initrd_high
> all-ones on your radar too?

The simple answer is that no platforms should ever set fdt_high=3D0xff...
nor initrd_high=3D0xff... by default. This tells U-Boot to never try and
relocate in memory these parts of the boot even when U-Boot knows that
they will overlap or are not correctly aligned. This in turn leads to
harder to debug failures at run time. Unfortunately RISC-V platforms
were introduced with these set and whatever checkpatch.pl check I had
missed them at the time (aside, most recently checkpatch.pl was missing
this in .env files, I fixed that today).

--=20
Tom

--XN+rAcNura14xNbs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaMmxCAAKCRAr4qD1Cr/k
Cs8uAQCfho84kYIFX64if6tbw//EYCTz2UFhMUppowU9TJzkDAD9ExpMv8Xy32TT
TtYUbwpOS4q76kJb1nROIm1zSgXQmQE=
=i3wz
-----END PGP SIGNATURE-----

--XN+rAcNura14xNbs--
