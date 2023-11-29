Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 942CFC4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 16:58:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D206A87753;
	Wed, 29 Nov 2023 17:58:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="To82aVyY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56EA887747; Wed, 29 Nov 2023 17:57:59 +0100 (CET)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52E6587638
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 17:57:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-5cce3010367so67233027b3.0
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 08:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1701277076; x=1701881876; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Sk+kWh7ActTa4tQNKlHSKXYbeuGG4AEBIhaGULT4wTk=;
 b=To82aVyYJzZX3dwaZHgbgp9R5Zn10fFT5g4VFlPuFA8oeCQiqC23i9KJgpPwDlkWVF
 fHmLmzAXyzS042ULAnmuzX64p8XtEDesYzURygtEsktr3KLhhbmZq8VV+obJAODCX6DY
 9P+LCa1szlMK6wHch00ECV51wrjJbrOsE+eI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701277076; x=1701881876;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sk+kWh7ActTa4tQNKlHSKXYbeuGG4AEBIhaGULT4wTk=;
 b=C7BZD1zq048daZI/0ymN3d6WWrHo21cX6xnln9dFQx8PGDgUxSyvgQXGV9Ng8F+qND
 sZnwYuqE8KkEEmLtm5lVRKISmRyn+D27ukh9rUitLgj2ckooErEclGBnWJ/G4cdhBgLM
 qhlawn0590tGhY6PG9yb/usO/BS5nZqqKIBpGKxpI4jebUYp4YIpOEmEXff/Rs/2faUR
 9LqulhUGXEDo2K7SdLTqbh8oF89Zno9qcBjDDqwR6NwS/yetmlKbD6WjB2Q5RroLjdsO
 Rb5F3tfaEBdH6q0krLcZOHY8Wdk6AwdgFGGv+UhWRbfLlw7dp8ANmoh8c6X1PqbSDKJL
 +gog==
X-Gm-Message-State: AOJu0Yx1zrRlbY/xCyO8ctoUUX4bPlxg8kZr8aJWM8YgF/QW+YKe6RjL
 XTDM4sCmylEyBwHJcbePGa9oNQ==
X-Google-Smtp-Source: AGHT+IFDKzSWkOTJdwR4bvw2HFEmG/XOtt46tPjTYX7AKm1fC0/qiusWLxsz/fM15y+HYSKUuL8lyw==
X-Received: by 2002:a05:690c:2e8a:b0:5cf:1b40:5d53 with SMTP id
 eu10-20020a05690c2e8a00b005cf1b405d53mr12864231ywb.29.1701277076081; 
 Wed, 29 Nov 2023 08:57:56 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-9fa4-b7c8-6a9a-173e.res6.spectrum.com.
 [2603:6081:7b00:6400:9fa4:b7c8:6a9a:173e])
 by smtp.gmail.com with ESMTPSA id
 s9-20020a819f09000000b005d13fc3fa6bsm1307817ywn.89.2023.11.29.08.57.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Nov 2023 08:57:55 -0800 (PST)
Date: Wed, 29 Nov 2023 11:57:53 -0500
From: Tom Rini <trini@konsulko.com>
To: Francois Berder <fberder@outlook.fr>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] lib/slre: Fix memory leak if regex compilation fails
Message-ID: <20231129165753.GK2513409@bill-the-cat>
References: <PAWP194MB205547087E126BAE0D2EB0DDDAACA@PAWP194MB2055.EURP194.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="u6kw3S31DX5cU7pJ"
Content-Disposition: inline
In-Reply-To: <PAWP194MB205547087E126BAE0D2EB0DDDAACA@PAWP194MB2055.EURP194.PROD.OUTLOOK.COM>
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


--u6kw3S31DX5cU7pJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 12, 2023 at 08:16:50PM +0100, Francois Berder wrote:

> Signed-off-by: Francois Berder <fberder@outlook.fr>

Applied to u-boot/next, thanks!

--=20
Tom

--u6kw3S31DX5cU7pJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVnbZEACgkQFHw5/5Y0
tyzvnwwAjvNwA+uzA6kAbsv1sBtLU8RGJ2FZ8linIb2hivo7jeZ7+Lr+BaIM4zXn
JHc+j5OTaunG/RRnGuQP2nGJ5BQwevm6MyL295ClJ1cU5rgZ2dKViLGmg/ATYGCF
zdz+u/pNcGsp9jO/bnuq/fE+u3GsP1OZ93EHJHJYG/sBZu9j6w+xnoPy8OOY0hTf
Dxd7Db7mJ9qIo0gn14g6fy0IfzM/JdtDnXzsmrEEiRFZETD6wipSEDK2a1nUVnA5
+hRHXkeAfWUObWTG/wr5yflB9N2nneUiJNnhfAsNLlR9uNQqUZ2tixoPHw1g/8fV
+k3cauls7TAKRa3W6CVXLKezxqzuE95dZituNv55j0zvAGKldUGNQoPBmwx/qm0A
2llzu1jT6iPXmk3gr/+sb/LczxNbpKvwszCZ3jqxFPxfYJzUMQefsjBEVqu/u5U2
qKu2q/HBKXRPT1J0FBNItv8JrpZdUQpY9MScvwFZELLepxiCDpwLJORhEhvoN1ld
deY7gisS
=UzZr
-----END PGP SIGNATURE-----

--u6kw3S31DX5cU7pJ--
