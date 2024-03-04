Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1603C5478C
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 15:26:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EED7F87FCD;
	Mon,  4 Mar 2024 16:26:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nejzbdpk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8253687FCD; Mon,  4 Mar 2024 16:26:39 +0100 (CET)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 818B687FD2
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 16:26:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6869233d472so23478636d6.2
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 07:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709565995; x=1710170795; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rQ//rl1JZKbRJLcDttg7xhAxnXjRK/NF0grCK2xAXK4=;
 b=nejzbdpknztKokMqWGs+BdHNu9hmglSxif4rh0eBo1jRNNgIBgnruMl/+F69VYQgSc
 XIzM1vvsFqYRya/zXMSVz5LrrEaNtfKY+thO+Q/rWjIhqSBZm56jPmBpu6Is5XH9Klct
 mNDqBAbQBom7qQ6AUvIaa8ILbute3b+EofD0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709565995; x=1710170795;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rQ//rl1JZKbRJLcDttg7xhAxnXjRK/NF0grCK2xAXK4=;
 b=kH/HXQ5QNB3TCvwe9l8+Jy5WTvuzqjjLdlbZefFY9cSrzu6K5Off5D5ZVXgCb9Zsov
 XsoJw76LYTorvU9lav/5h2+tfNxFCHz7X9ksss8WdSuaNwYyX7XwSQUKzQiTFEwHV7AH
 Bd2/VFZp/FXGNtedXvYX8w28nlAgqPkuCQjGzTeg6WgZiMt1RkYg5Aj7WnI5ioN9cKu6
 cn8RHy8EXDv+j3YwwI1KfPq67p3xsVRjseIN+B+UHzxAHJFXKKGIIJav9KuVqxxAJGqX
 o17iePCPV8LrctzcVkvuKCTILr7UfUvNFtqDE9WyREVPvi1jAVGJI+8Yy4JLkmpxVftA
 ctUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWlxOgJOl3WWSBgTzk6d2OsIxkM8WRbOGRkhycDchghmZiqMMNACF6uaUIpSxcZpBwuQNrzuSAIn6aYNCd9L2Na/SgAw==
X-Gm-Message-State: AOJu0YyAC34u+6mH+yknk2JOaiz0daQ6oNTBYgPeGdNL429Fd3BDMZbC
 Krlre9yskfln/QXLqWMma3vJgCoBWqZvZSm3p6jUl2M+AHfkseXPeW+RRw7MGJbYvNUTAJTC7uW
 c
X-Google-Smtp-Source: AGHT+IFcOBzf+i8V6Ahfuo2Tl13p3aUmjuD00T8ASmyx7NR3oClmYzELFL6APvM3zCWgF2XeKsjjtw==
X-Received: by 2002:a0c:f506:0:b0:690:7db7:77fb with SMTP id
 j6-20020a0cf506000000b006907db777fbmr1310335qvm.30.1709565995254; 
 Mon, 04 Mar 2024 07:26:35 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:7f::1002]) by smtp.gmail.com with ESMTPSA id
 a9-20020a0ce909000000b006907945e700sm911724qvo.12.2024.03.04.07.26.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 07:26:34 -0800 (PST)
Date: Mon, 4 Mar 2024 10:26:32 -0500
From: Tom Rini <trini@konsulko.com>
To: Ivan Mikhaylov <fr0st61te@gmail.com>
Cc: Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
 Joel Stanley <joel@jms.id.au>, u-boot@lists.denx.de,
 openbmc@lists.ozlabs.org
Subject: Re: [PATCH] pinctrl: aspeed: add pass-through pins and siopbi/siopbo
Message-ID: <20240304152632.GH1523872@bill-the-cat>
References: <20240120232813.32474-1-fr0st61te@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Zb5wIw7O+4YCHwhy"
Content-Disposition: inline
In-Reply-To: <20240120232813.32474-1-fr0st61te@gmail.com>
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


--Zb5wIw7O+4YCHwhy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 21, 2024 at 02:28:13AM +0300, Ivan Mikhaylov wrote:

> Add THRU0-3 and SIOPBI/SIOPBO pin groups/functions.
>=20
> Signed-off-by: Ivan Mikhaylov <fr0st61te@gmail.com>

Applied to u-boot/next, thanks!

--=20
Tom

--Zb5wIw7O+4YCHwhy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXl6CUACgkQFHw5/5Y0
tyzfewv/fttPTR41KkM/dFzF/+oqUGmSIgLJrqkg9jbZuanoW94jZg51bSWpP7Er
+QGpl9vg79Ow+GbfdR36Hp2TensfQEbXckVuK5kVpEfcye1qyOSlTeBaDpO2rsdp
Nc6nqTSb/wqoCl1B2E/rs+atEpwPcIznfhThZ6uus8EP5ESfElPlpVaua32I4X5V
NwU4IXSfEZ8W2NkHlqTDAMqTe4HqoCxNO1dUlah9t5wLv+wZx5cAqR0x7jyxkdOT
jFUrqoRZMeffnZU9KsrIcLH9agvgofRAw5xUUo6n997nKWLjp2OIVPCNC51C1c5A
3G8NeedUKRwXYdsPBVDWY2EW9oeKTKbWO2kQeTJ2JEt5D1F0Ba9LE6Fh1QBgDZut
0pb/FqJDGeizHIwwVX7eMoNOuFDQyHRcen78xB6xZCiamKbstja7u+fsNHK/bJsW
rqW+5IPQaj8vQmBXiRNegeDgDCgiuOOflCa/x6x5SHrqkVV0mz00cOrUQkYUPGVv
FMqezCaL
=/at4
-----END PGP SIGNATURE-----

--Zb5wIw7O+4YCHwhy--
