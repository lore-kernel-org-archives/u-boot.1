Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A3AE77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 17:52:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB98B802EF;
	Thu, 19 Dec 2024 18:51:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="p8KnnBRy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D0738034E; Thu, 19 Dec 2024 18:51:32 +0100 (CET)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EC7E80383
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 18:51:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-467b74a1754so12595481cf.1
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 09:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734630687; x=1735235487; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yEp5LkqrhzSBAn697jCYqs7g9g6Y0I6ZmNT+npKl0UU=;
 b=p8KnnBRyS2fApRJtV1SXoobCb0kjkCX6XorgBSDwrpTPs6yCgg9PQCsIxR70S/vBaM
 BU3onwiHRe4H7nLrgDPjT4/nkAlLy8V/Gk60tCpA0Kmlr5IUg/Jp6APM/zW5EXNdPrN6
 2IvERjEy20KDJHpA4iA1/DSYM3M2dngFng0Gw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734630687; x=1735235487;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yEp5LkqrhzSBAn697jCYqs7g9g6Y0I6ZmNT+npKl0UU=;
 b=SPP6hhSIAFYKC8YkwBolbEy6Q5aCX/g20WXdo+ISfuIoztqPrV/IaBNcti9qNNuSOb
 d58pi5NlLeyM+IjWE12sghjGGaQlKegTLUh8pa4nXx2X+ZKVU93u/L2dLJxjBLR1CQas
 CYgMNErfpXVn0sCDU/AKzNY9/WyYsA2A7R9tGKDpcVFWdlDVVjTA9ezvO+Rz/Y7MoxgH
 qAn/AT3XubxtcO8A8uxlYHctpNTOG9jwnL5sTisr20p029LYKG7jyTZAMkw/E6PJakY3
 PjGi1qasne8UuzLniPLO/KFUss4ndntnc1l5ZUD3qYK5Z3shO5ceLzaLvCXeH5LGqDbZ
 mb4Q==
X-Gm-Message-State: AOJu0Yx10WpevnLEYtGu2am1LlCEvKQOijGoptgZTXgVCpmXs8i0y1eY
 Fjj4O8njflt8LS5Lm1TGgvWgHKQCn0ID1lN55S73spj4HBwmISMk3WIzWAb4G4fb+0+V26/PxMk
 n
X-Gm-Gg: ASbGncueh8YG31P9kE8WxqJv7jIUTwWfPEmXUu4qPWOvqZ9f64bCQW8pL9Xy0C7fILc
 knTDbd5SuVdEBPQT4eLDj/0S6XTa38ue2MQuM0GugGSkC4uB+zRwq1K60IxdAQl/iJYyHcB7Ox5
 D+NaXTiFnYQSfBf59SPsWVHfNGtnYdFoDdQUZuCdEzYLIgYFofNCc+Pf0dGWTPVbooC0dtVx0jq
 iOWSMfJHx8nuuA5nrjZmEcUo5a+QlEthvFTYQ1li47U7qz0Wf2ShH8f
X-Google-Smtp-Source: AGHT+IFNM3Rdrwak7ccgAYMK1xiDyeYhusD5OryCFgTLl3ntG/ivzQnEPPZhVUPmRNzjg+08emzDvQ==
X-Received: by 2002:a05:622a:1807:b0:467:8765:51bb with SMTP id
 d75a77b69052e-46a3a899065mr78436911cf.37.1734630687259; 
 Thu, 19 Dec 2024 09:51:27 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46a3e653874sm8329551cf.13.2024.12.19.09.51.26
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 09:51:26 -0800 (PST)
Date: Thu, 19 Dec 2024 11:51:24 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: Re: [PATCH] binman: Regenerate tools/binman/entries.rst
Message-ID: <20241219175124.GZ1505244@bill-the-cat>
References: <20241219162025.3637114-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tXtm8aCokJ4qQXAF"
Content-Disposition: inline
In-Reply-To: <20241219162025.3637114-1-trini@konsulko.com>
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


--tXtm8aCokJ4qQXAF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 10:20:25AM -0600, Tom Rini wrote:

> There have been a few changes to the areas that this file documents
> without having regenerated the file. Do so now.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>

Applied to u-boot/master, thanks!

--=20
Tom

--tXtm8aCokJ4qQXAF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdkXRwACgkQFHw5/5Y0
tyzqogwApND067Dt6Z8RFr6KUH8F5JYzzIEGQHts2YZ6pcr5aIahDGNxMR6MKuP4
hpqcKgJsFX9ewsZ9Nj/kVc/QDFGfxYglW3kSzHNZxVoyQ0Ljbf5r8z65DLxrd8tB
F1uatyTTkDrzo165KfM0dzMcZSgCdvWmWENqKu6uAadDz7YJXv+59HNiIzSY7/Bp
6PHkxiuSVw0crXx8MXdYe0V/1Lan3OYpLZh/0F6y8hnC9xZ8qZtFueBsajzeBsEP
/LmPP/+3OAaz7wgC6BuHiZQ6cE7i2MNeUIc6r6YPGxkvXK6QpT2tPdsS5bod5oty
6siM+WWxP/Ckcf/WsMbbX+mgTyy+zsWvxj9C3FSmJax82i17+VIEgA8XnyJ3R5AH
derm+5veqfSO04cKwNUFtQ/bdLbGOYxRkNtF/eL1fPZiZJpZr1KVYpzHOGVEAV5V
ceTw1mY1onGch+5yzDAH3oHW9C01eUCQdIfD76bYimkXyDEcNTmEvicxZoXm0EPn
bd+ZawK2
=Eoou
-----END PGP SIGNATURE-----

--tXtm8aCokJ4qQXAF--
