Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ABE9D132CD
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 14:01:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95B2C88D45;
	Mon,  4 Nov 2024 15:01:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oqoeQYtm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14DA388D3A; Mon,  4 Nov 2024 15:01:29 +0100 (CET)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7941D88E7B
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 15:01:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-5ebc52deca0so2052582eaf.3
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 06:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730728884; x=1731333684; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hJOMbCgMsveBlnIr1S60bZKdudbSgnB0tK3qsIUMNX0=;
 b=oqoeQYtm3GfGB9/pdSA7nRybG1zbymmA0ZjqbwQhHM7kTBGl5Cdtk7ZGEwDmhrk7qD
 s3E9m+DUYqhDToaKQwaGAhHMILkzWukFyGZHgsUaivUVWwNZI4PZw0MDuhwzuGXxU5oq
 QejazfJgHKzv9sgQ/5XXqnrtyJG7AS0uuxL/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730728884; x=1731333684;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hJOMbCgMsveBlnIr1S60bZKdudbSgnB0tK3qsIUMNX0=;
 b=lNkGt6v3/sBIZUZD20IMbZDll0nTtMYkbYJ0fpKA2QbkAgCn8aENzRvkVWDoZ8sp6P
 gzcADPVP/LL+8NVarkB/yZ5/ZuVg1SxeXKcs3b5gVScWDo6RlzHW2IKMNh0jxIU9jRBK
 bacZdI4bYN5pbLoC+C9y3e6zbV1eguaarFRqAgYI0JZfojPh8opfiBhYsgBUeSmX5rnw
 apdE0N7g2wzMXH2wAAVIS2melbTHT2ZBMSQf6zSsWCtTmtupWfazuYbPjKk+Dse6MFdL
 8PnL6sE8Z9905j8T73WkaqWt5ONH6bKW9KpcA23PHo3Uzt0+i9Zn1UL/ergnCqzW/Klk
 WSVg==
X-Gm-Message-State: AOJu0YwJx4tKRliN/3n9Nv7vJ1IOrFT9WrTyzoArm0jSwIEf9FkYnuCR
 H/1lT4tcckUlzpuyCZA71usJRcCMjRKPFKcE8UeJBY10iX/wiAT+p6ShWxK7QGA=
X-Google-Smtp-Source: AGHT+IGrxM/LkKX/OUVu1tXgy+jRZiMX8qv22oVOg+NtQG3PAgZ490XCZ1I1s46lTLavAtAMVxpSxg==
X-Received: by 2002:a05:6358:9696:b0:1b5:a139:a24a with SMTP id
 e5c5f4694b2df-1c5f9a1501emr394541855d.18.1730728883983; 
 Mon, 04 Nov 2024 06:01:23 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d353f9f4fasm48773426d6.18.2024.11.04.06.01.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 06:01:23 -0800 (PST)
Date: Mon, 4 Nov 2024 08:01:20 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bryan Brattlof <bb@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Marek Vasut <marex@denx.de>, Masahiro Yamada <masahiroy@kernel.org>,
 Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCH] Makefile: Fake external blob with BINMAN_ALLOW_MISSING=1
Message-ID: <20241104140120.GQ3600562@bill-the-cat>
References: <20241104134424.845473-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qOxtzUkryeMKwxYD"
Content-Disposition: inline
In-Reply-To: <20241104134424.845473-1-sjg@chromium.org>
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


--qOxtzUkryeMKwxYD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 04, 2024 at 06:44:24AM -0700, Simon Glass wrote:
> This flag was lost by a previous change and has never been restored.
> Without it, binman cannot fully handle missing blobs which are
> themselves inputs to mkimage.
>=20
> Discussion on this at [1] indicated that this was necessary but the
> patch was not updated.
>=20
> Restore the flag so that all missing blobs are reported.
>=20
> [1] https://patchwork.ozlabs.org/project/uboot/patch/
>     20221206020336.315465-1-trini@konsulko.com/

Please reword this to use Link: and not line-break the link (thus
breaking the link), thanks.

--=20
Tom

--qOxtzUkryeMKwxYD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmco07AACgkQFHw5/5Y0
tywPIgwAnVMBF4+EDjOn2JzGmz7H2R+2oT+yDnUMhX1CctX0/CLI2RZD3Q1JYrzb
kbdJvpf8aHFL/7QucC1zD/RNfTXMhIcTN8kpngJ65Z27FswsE+QjMNFvkNrwMj/u
h6AyO8VvWEylnvRQ35C5kyeUkQO+X2FviKuTmOc6en21XGgY19SdCDstxtkF5FON
B07Fs3PSLJHgWJlw+iPXSlAuniijcuQq2/sKSv9uf7QqNedrlbeWEkFjv51NGyiQ
gfhJjbJhcvO9l0H7BJZfN+Xu0112L7pHTRBjqqk5d5T2rg0KOQ8YXKRsmlZkGFkd
fZ2Pan/xJLx3lzFKJ8I8iQ5ub7qIsxI4id387G0JPXCT6OjUNkI/x/2TDt6YxZJE
whQ4XO1K01odYSKAMiIqEc8vQL5J1PUG8B9sum9cSxMvpbCeCV+bcWpDTrXVw+8x
fodciU04iP12OCG7rk95PbUqqvSWU6G4zqPhVkN7r2yf5ApvehuiLUEtG2Itvkn/
maS/Q0xv
=JLQ8
-----END PGP SIGNATURE-----

--qOxtzUkryeMKwxYD--
