Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2053C41535
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 18:32:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63A66876A7;
	Sat, 16 Dec 2023 19:32:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XAEv4UlL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0C3087669; Sat, 16 Dec 2023 19:32:41 +0100 (CET)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1A348773F
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 19:32:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-67f2a5d8a05so5439606d6.3
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 10:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702751557; x=1703356357; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8uAVgEhcaODQ9ILCFV6eWcQMXtcJHnkEkluhhU+d0TE=;
 b=XAEv4UlLkrlLBKmPAusVxsGrJftGvO0XB6bxVgKXktMx7WK0bRWX/WYYIwlgCtrrqZ
 Una6lcO4pfkaNEORi0DTm7ivh5FQonK3gnbUGdZ7ipAdsDOH9cKENuMBkVvB7uDbNtKP
 zcUGcX3DJDi0ENdKlQQop8GH9oQyPhFUx6/Z4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702751557; x=1703356357;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8uAVgEhcaODQ9ILCFV6eWcQMXtcJHnkEkluhhU+d0TE=;
 b=Q1P39+D2i3kLtdzBlVQRvotCJWymvi9QLeAZEEuo8Z3rs8zN6ih400v+io1+kyphq5
 eQSkfNORq2ivvzTTtWbNlesagJEV2vP4zu6oNlGhIhAC216eTWPRpDCbBtF0ASAiFbGc
 HbNpspAMmKSym7tnKFEmhSDwR/427gcxi78JePvKWd4+itr9hrujfIOKn15Qs/kZLwya
 POrTCQJdKLST25bdmvabTsYp7qctFUeoFZqEDav8YnnrGX7mZjXoEFlIV2SCQv8AoNea
 F66aiOOXENMqNw4biqPF1MZoKKNfJyVl9OC72PfwNMCFCeofmKpBVoXyhcWGftdBFCoo
 EvVw==
X-Gm-Message-State: AOJu0YxKAIVv1x6/t7Fdff8ziVfang0XgcPUnwLDS1hCo+CjfRu5BkDC
 CDDqk8we+zsWpXRYoEm+lPrNfQ==
X-Google-Smtp-Source: AGHT+IH75E3IBhgbliUbcWTDys/DDG+Lz6fJsEGfbF6Ez8m31523FnGd5tvcknygiBzi57u57e1tQw==
X-Received: by 2002:a05:6214:f0d:b0:67f:132c:6c1 with SMTP id
 gw13-20020a0562140f0d00b0067f132c06c1mr5477123qvb.40.1702751557575; 
 Sat, 16 Dec 2023 10:32:37 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-4efc-63ef-4955-a8ab.res6.spectrum.com.
 [2603:6081:7b00:6400:4efc:63ef:4955:a8ab])
 by smtp.gmail.com with ESMTPSA id
 c13-20020a056214004d00b0067a4f49a13csm7710159qvr.127.2023.12.16.10.32.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Dec 2023 10:32:37 -0800 (PST)
Date: Sat, 16 Dec 2023 13:32:35 -0500
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] get_maintainer.pl: Add --git to look up CCed in git
 history
Message-ID: <20231216183235.GX2513409@bill-the-cat>
References: <20231216180804.173374-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mhUQNpJld3PQfuaw"
Content-Disposition: inline
In-Reply-To: <20231216180804.173374-1-marek.vasut+renesas@mailbox.org>
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


--mhUQNpJld3PQfuaw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 16, 2023 at 07:07:52PM +0100, Marek Vasut wrote:

> Add the --git parameter, else recent contributors are left out of the CC =
list.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--mhUQNpJld3PQfuaw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV97UMACgkQFHw5/5Y0
tyx4gQv+JcYmWOJm9T9IOiN0fQszd59eNj8qNhuZS2qyXczEt+EBVb7w/8mKjCHo
cflDE32G/fnCLvGW6O45SNijpZT0rKBHeizh0mq48afibW2xnkzugKtm1s5+X0Yy
+0VdvLkHrRGvwfsGoX8RgkmExsTQY9BI4rE2iC7ECu4vlActz3K6mMkfE3spS0x9
+qm0qLnBiUE6NLytf2L6AHro0liRrhcJhTqGv28X66J5GUdmloixZ1dfYY1n2YJh
GBtV0TdTJQmAhC5WUZAx3uuXi/Yh+ePpm2smetArK7C3p0UE/2McPeBFExYnVSI0
05UgFvzuWI8wTqbMvalFTgkRn5UUAEd6f2iYJtolpygxSXZqKjiU5853TBz5pTO8
XeS4NziQ9FNca3Ium1PFviu5NG8s9qUDvczdcswZG5wRk07KrBireD9f01WzHagP
UBcHh7Hn1xX38hLT2QmYgx+6I5ykH9knHl6kqk2jvHFOLF330y1DlK9aM+zF49zm
JiXErMfn
=PmqW
-----END PGP SIGNATURE-----

--mhUQNpJld3PQfuaw--
