Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8003C54798
	for <u-boot@archiver.kernel.org>; Sat,  2 Mar 2024 14:04:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1113687D16;
	Sat,  2 Mar 2024 15:04:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZHpQWXY2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47AD487D26; Sat,  2 Mar 2024 15:04:24 +0100 (CET)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B945875B9
 for <u-boot@lists.denx.de>; Sat,  2 Mar 2024 15:04:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-42eb3821a2dso24249781cf.1
 for <u-boot@lists.denx.de>; Sat, 02 Mar 2024 06:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709388260; x=1709993060; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ngg2ppW2bh6DI6a4mB2t08sxWcwwyrr3S4rV8cSMh+w=;
 b=ZHpQWXY217JymoZbietCH7t7KPh3QSM24LmZEllhglaRN4y9rjym38Rj8nvNPx7jQZ
 6JLcwGkQO5ELOogllPD5wM8qjtW3RVZDyXCP1bOxTXK+pJVOdOKyDP+fLCY5bLQUP457
 3suEbxSMPNj3q3//Ys8CaTKqj8wss3XciE8ic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709388260; x=1709993060;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ngg2ppW2bh6DI6a4mB2t08sxWcwwyrr3S4rV8cSMh+w=;
 b=mGtHBF4ck3xsvFRCHjYeo+By0Woy1WUPRuJuxBAA/gQ9NPhLvfhWtbzyOcVqPgFcTR
 VY9ZWecmNOOInjt6uAO+zzAvv9JdyQYaoZsLW6dADVTYklEwhuSkkCoJZKyriwcKcmo5
 a97MY7AwoS4DDtFfOSiZHwdG1CO/6oXNfFgVj/3Vyov/O3ChU7i/u1E+AjbYzKQqi+bA
 NJxyrb5C7fgrWbQNvkZvfruAIXCVHmlLR7ab95u69xfnug9n0IgGQHDdKtZvNzsFSoDn
 PO0K5Q/Tqf5BFvauSYkFF7yPYr9oyEhNAgruAAlEd3Hdm9Y5W/2XJ6BG69j9vFPbyGhG
 FIVA==
X-Gm-Message-State: AOJu0Yxi0j+7A+YyTGyFRR9y1npbzkcf4brnMaWJ3oRy9px//+m2VNSg
 532bzgt9IpHmDB22yGTQ/5G8p4fF9VpyMV227fD4/jDrXOC/J8mmH75CHnUbzkY=
X-Google-Smtp-Source: AGHT+IFa6l86TmUr10eTCSNxN2Y7AXu8HaL9Dufu/jiHaMzorjY4toyQhS/aYrogu2FT6kkkYj6ocQ==
X-Received: by 2002:ac8:580a:0:b0:42e:c1b7:81ec with SMTP id
 g10-20020ac8580a000000b0042ec1b781ecmr5548986qtg.10.1709388260098; 
 Sat, 02 Mar 2024 06:04:20 -0800 (PST)
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 d14-20020a05620a158e00b007874e64c879sm2573781qkk.116.2024.03.02.06.04.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Mar 2024 06:04:18 -0800 (PST)
Date: Sat, 2 Mar 2024 09:04:16 -0500
From: Tom Rini <trini@konsulko.com>
To: hanyuan <hanyuan-z@qq.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 1/2] cli: allow users to disable history if unused at all
Message-ID: <20240302140416.GA1523872@bill-the-cat>
References: <tencent_411A9B7DA959D26CCAFCE7961870C400E80A@qq.com>
 <20240301213702.GA1401112@bill-the-cat>
 <tencent_53D7126DB3F29FBEA48E430D60D298FA4B05@qq.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="n9cNm3xrd6MiHEwp"
Content-Disposition: inline
In-Reply-To: <tencent_53D7126DB3F29FBEA48E430D60D298FA4B05@qq.com>
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


--n9cNm3xrd6MiHEwp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 02, 2024 at 12:35:12PM +0800, hanyuan wrote:

> Hi Tom,
>=20
> Thanks for reviewing! I am not quite sure about the tests which
> you refer to. Is it the CI in the gitlab? I think this patch is simple
> and it doesn=E2=80=99t occur any errors during my work these days, thus I=
 tested
> it manually which didn=E2=80=99t throw any problems, and sent it. Could y=
ou
> please give me some hints about the broken tests? If it is a CI, could
> you please give me the link to the error information?

Yes, our pytests for sandbox failed, see
https://docs.u-boot.org/en/latest/develop/ci_testing.html and
https://docs.u-boot.org/en/latest/develop/tests_sandbox.html

--=20
Tom

--n9cNm3xrd6MiHEwp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXjMd4ACgkQFHw5/5Y0
tyzGlQv/U5yaBauf9WDtyYiliHLgywLsNQofbceogdGqSlvrHxwmSxMAB6nd7Pqk
gAl2uVKKqnFUQOURjHjQVYlqf24Xb2FyZmICmxkXx2xWomNSMd1zwf1Xssii+6Sk
ifp/aby/nzWBZ6fjUQwCgZg5ERSC33azFhg0/RJPMUFkbpVmcITh+Jk05zmUy4nT
JrGSZjL4ZD3FOqUr6/I4gFO1DeCyzzQakrL2Zl+X39w9jQ7FVLcsx8llmsYLA9xW
rzjfm2XJJsOJlDadQX9Wl30EkYln9jdUJRUVoHa2x+uLecZswhbdl9oHlJMIChZ9
ci8kYm0VLS+btyBugY6yJ2tnbJYkd+/hKwOE8wEOMMtVHW9ZOZvU5H2JhDRVtHDf
lpZHVG9Xh5xTn/8IU+t0ZKoeMbpdGxOuwMMG+yLuiUYzJx/f0z5/KD+2wA2yGA+J
rJXSFqRwwFKG6nqI2TYM1FCq+M7LwQSpsVID+eE9hDyI9bLmiGrdarj0ZkpfYjQa
MR6XEQw7
=DkZQ
-----END PGP SIGNATURE-----

--n9cNm3xrd6MiHEwp--
