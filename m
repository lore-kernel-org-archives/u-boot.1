Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB6EC47DD9
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 16:00:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC06987A01;
	Mon, 22 Jan 2024 17:00:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mnQIe69a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E791877CC; Mon, 22 Jan 2024 17:00:48 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E50FA8777F
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 17:00:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5ffdf06e009so9556697b3.3
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 08:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705939244; x=1706544044; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kceeNe0wjQS3OuImVghLxBn7NcGjWTmVyi1p4a1/BH4=;
 b=mnQIe69aQ6gR08+cYUvuvFwOTNbXNPq5wq1PK+ok5i1B7xd3GNMOOOj1z6L6DegEhR
 o9JabBUM8u/AW1UDgTFBAk6pSZXpCK51iWjARpsJTxMqjsdJXSs5z1QbHx38ls2BDbBB
 usDmBMt7oiIfbgu6KHYGloWOZPcnPI4h+E6u0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705939244; x=1706544044;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kceeNe0wjQS3OuImVghLxBn7NcGjWTmVyi1p4a1/BH4=;
 b=acUerHhey3/GHf428zL93XeEb2XiiHUZyainU5lTi85Nmt1YcdGOFGdldnpnHazoUw
 k09f8HuzggT9Vy5/VS92CWxjMQ8Egsp8vz0DhnX2Ac46fWtxM+qEM75iAvLkhqcL7wIy
 7uCZoF36f2hjrYW56td2tmXU/0o5Xw386jentoAjaWij/bQxcZFLFkMVxtB0JNDj3/Q/
 e5b3g+ouMdQACEiEaUK4xYmNM9Sq7KXcqwuzFvuTTKqcYZnjgg0sP5Gl4uFEuKWC7z7l
 KIlRM0Rk8WptUyoBA7mhtMmsKBAgqxtkWglB4oWa23wrJefFFwSfxWTnbNDJnMjoEE2Y
 PR9g==
X-Gm-Message-State: AOJu0YzXshgFkeM5jUKtHUrZ+BL57Yc6ZNjOS6FrUsJaE3g1KI4Uy5oK
 ns7SKb3X49r7vzYn288YxOIz9ft+KIEEyZOi3jXo8eV6Ri5w8G1SxsHDApg+I4A=
X-Google-Smtp-Source: AGHT+IE4TeiPca/ylLZKOhlGVSYzfeZQh2SGLSbwyGuyuCAXi1/zolxh3AYr+V8UlcDwFJP5egNK3A==
X-Received: by 2002:a81:4fd5:0:b0:5ee:7299:e2cf with SMTP id
 d204-20020a814fd5000000b005ee7299e2cfmr1975934ywb.52.1705939244162; 
 Mon, 22 Jan 2024 08:00:44 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 s4-20020a0dd004000000b005fb0d1afc7csm9575321ywd.120.2024.01.22.08.00.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 08:00:43 -0800 (PST)
Date: Mon, 22 Jan 2024 11:00:42 -0500
From: Tom Rini <trini@konsulko.com>
To: Stefan Roese <stefan.roese@mailbox.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Please pull u-boot-marvell/master
Message-ID: <20240122160042.GM3652023@bill-the-cat>
References: <b3123d65-01a6-42c5-8a21-c5a039b281d5@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QSJM2MvOLm4/nMt/"
Content-Disposition: inline
In-Reply-To: <b3123d65-01a6-42c5-8a21-c5a039b281d5@mailbox.org>
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


--QSJM2MvOLm4/nMt/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 04:46:48PM +0100, Stefan Roese wrote:

> Hi Tom,
>=20
> please pull this next batch of Marvell related patches:
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--QSJM2MvOLm4/nMt/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWukSoACgkQFHw5/5Y0
tyx8ggv/Y1KA/4riC6Zce9PlKoCOMx4etSHKWJI/g1m1Y3taVE9ADiHKzdm2XK4L
1jQQPHDi/8hcFIgojJZO0P+YVxpFanu0MOXQ68JDDqPCgEH7w/oi15qANU1KZSn3
/UpybnoDS6ek4wG8tcoUgKrmhuDUjXK0hPNoRKerSUnQDNwkuLF84e3h/E0o7ka0
a+9alia2vUNBibUAOrvHbmSIP9wOgLzRorkYNrklSsBO3QkZrJ8EbWEsZslQO/OC
KhiQ1CMdbDhxau2WgoMvrJFQRsrDJy5Td8r76micemgF2bRlZNglLpedlXGQxoSf
IYunD4tsKd+UsZB8ZGMmoH7sACA+41YXgBauA0zP3gl5lHq7oR+ZUWuaURxdAMa0
S90ge2RmN0LF/8JhQvWUsiJdP7etlOmKJliq0QKstCzYam3J6kmd90YGNqAIv9Ws
BV9fSH8o9wrPLHwSlP3+ZuidiGDM312ofayIWRNOqgejlwoeP40JllABIoVb4ZSM
CnA4qUCZ
=ZFT3
-----END PGP SIGNATURE-----

--QSJM2MvOLm4/nMt/--
