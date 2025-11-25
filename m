Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E0ED0E6EC
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 14:14:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF4288408D;
	Tue, 25 Nov 2025 15:14:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="H6mAMBaa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C0EF84097; Tue, 25 Nov 2025 15:14:12 +0100 (CET)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF56D8404D
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 15:14:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-656b0bd47b8so997804eaf.0
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 06:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764080047; x=1764684847; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=I6ClzDEutxRK2SPAw9SIn8wbdZQNjN2YA+pJcr336rk=;
 b=H6mAMBaar2DkBAdfIBefTspO5/E+7Ab7H5krj2Zry8X46Bs5HwNod9QKwK9EJLtUfZ
 dWYCukkyAhMrdgXc/lpAiQRhup++qGNr1V1XWFB4oQCaY42eeqcd79DZJlJI6OAvGZI2
 5AfYA0CccrXBC182hnl/v/RT8s/dY9OWVOeWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764080047; x=1764684847;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I6ClzDEutxRK2SPAw9SIn8wbdZQNjN2YA+pJcr336rk=;
 b=vYZ4SWiCZ844KQiS7lrz3d2VSUwQJauyzU1CLkILVXgzracr3pE915Ovd5SP5xTiJr
 r/74CJ0nQG9TSc9BzJJ8kRmorIeHI+LhB/E0Jf/Ze0J7SjYBh1GBr05vaZOv1v8qkBo4
 IPlxXWhfJEdtv10NPtUQHLar/FqhnFy3RdcFhYkpE9zgLz+aT27vzUEA2dYO9bov6c1U
 J73B+5k120Cv1QNtZ9lj9qprUCEaaraFnRveIW79of/MAIUmxWWaA+I/NAKXbKuTbdg9
 MOfpLmuDOkoVEz01Guf8jYvd884OPhpa/Ul6RH5mz4radyyHBkiMAKfis5a+yF0Hq+5s
 nFuA==
X-Gm-Message-State: AOJu0Yx9ZyyjAoOyw6SP/dYZ0wMDsXncHS63C4AgCF14YJlTEZACJb9L
 LoYnQ++jjQYj2WgdQGMR332SiHAiphwF6xi07tHKBkdkRrHjcIT0yeaLWIoL6wKB6FE=
X-Gm-Gg: ASbGnctFC4EnUl/qAAr4TyMogUn6NT4mhVNzg5wyj5m+B4kFcHY4CQNZWalOK196SR+
 C78v3AmgxEFOErzYjfzqj85ocUPXeCzffgvZ8hgAyvBGYYjPHkPhq4f7nj8VwuB/slWtUEZpcll
 aAXpnuZQLkjFU9Wlf+sqXWFIbcyuLT3vd9jcIRvlyvupXzynYOAfQS4imEe+CJlfW/Ui5BFLroF
 rmUN70B4WEN1q/WD0E239D1cG62Pwv+cPcgYPaad5VdUqRtAZ2nNmDrJfNUdFV8JNhrl18YmEly
 IDPa5rzLwEY3Lrq6c2t07hMhcxq9dJZ6VIjf8oTg/Gnop+9NCiKuzQEtfJxh2xqAjO+sFaTjZYM
 qmT6TqJask2YNpkeUvXmzBGYVt2le6LlHBGkyOPn5iBcPFEDSUvwYCBestZn2w0sC2Ir/igmexH
 cos4V0W3rSPW+uWf8Ji+QdIUGBUQIELyDavFZCsj0sY+niu7Ewtw==
X-Google-Smtp-Source: AGHT+IETS2CfEavmTqBDWw8vcB2QyeG0mBJElSjQwUU1evgvnUNtFR+vWaV1G09XJ6BHDTet8JB+zQ==
X-Received: by 2002:a05:6830:1cc2:b0:7c7:6217:5c66 with SMTP id
 46e09a7af769-7c79906bb9fmr6788598a34.19.1764080046838; 
 Tue, 25 Nov 2025 06:14:06 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c78d346d84sm6318582a34.13.2025.11.25.06.14.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Nov 2025 06:14:06 -0800 (PST)
Date: Tue, 25 Nov 2025 08:14:04 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] fs/jffs2: Make depend on !64BIT
Message-ID: <20251125141404.GO2125796@bill-the-cat>
References: <20251112211942.1429056-1-trini@konsulko.com>
 <e4fcea1e-9374-4049-9453-560a2603cbf9@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HfQ3bf1t3bSQybDP"
Content-Disposition: inline
In-Reply-To: <e4fcea1e-9374-4049-9453-560a2603cbf9@gmx.de>
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


--HfQ3bf1t3bSQybDP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 01:18:05AM +0100, Heinrich Schuchardt wrote:

> On 11/12/25 22:19, Tom Rini wrote:
> > Building this code on 64bit platforms leads to warnings (and so errors
> > in CI). Rather than rework the code, as this is a deprecated filesystem,
> > don't try and disallow building on 64bit hosts.
> >=20
> > Signed-off-by: Tom Rini <trini@konsulko.com>
>=20
> Linux has support 64bit ARM boards using the JFFS2 file-system.
> The JFFS2 filesystem is actively maintained in Linux.
>=20
> Using uintptr_t could overcome the warnings.
> But it seems that map_sysmem() is needed.
>=20
> U-Boot seems to have a restriction that the flash memory must be mapped in
> the low 4 GiB.

Yes, JFFS2 itself is not limited to 64bit. However, it's rarely used
within U-Boot, and only on 32bit platforms. There's also known security
issues and previously when I've asked custodians of boards that use it
if they would be interested in fixing the issues, they instead removed
JFFS2 support.

--=20
Tom

--HfQ3bf1t3bSQybDP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaSW5qAAKCRAr4qD1Cr/k
CteKAP9lRGonLJSPySezLcZwPr0F1rYHDTY7OIAAOtmpLsvFpQD/TcOpVnUBK3d7
cZBUUlgy2JPRthZaoNu7DDE850anIAY=
=zXK3
-----END PGP SIGNATURE-----

--HfQ3bf1t3bSQybDP--
