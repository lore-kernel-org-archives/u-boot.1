Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC79E9A02C
	for <u-boot@archiver.kernel.org>; Wed, 18 Feb 2026 20:46:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 385C483AA9;
	Wed, 18 Feb 2026 21:46:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="a5MQT3BQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E45AF83AC5; Wed, 18 Feb 2026 21:46:28 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB57A83A47
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 21:46:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-45f0b597eb4so133914b6e.2
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 12:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771447584; x=1772052384; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=eVS0EDsVUPZpCWA03KRX4WiEr+0xR7yVQGO+Lp/MvkA=;
 b=a5MQT3BQX4ZLf2+GiDTehjZSCluHLXbLkfn014eJ1wP9h7MkBwVvfBDa1U2CHk6sgC
 h9voeHxGc6uEEyGMMAPhd5/CQ4cJ+bIWkO6+0KG/jwUFpR7LxoaRJQWBB4Kc8dwbah55
 sy8VDqpX/CZ96ptbjG8v1ljnoWvkf+dzQGJbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771447584; x=1772052384;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eVS0EDsVUPZpCWA03KRX4WiEr+0xR7yVQGO+Lp/MvkA=;
 b=w2JYtC8fGg8oHiJRRTCTRzqms4hCwO5kmEAHmNAEaE5iN19egOrRSs8V/eHIGNZSHu
 OScw0PxRzJ06uSXu0U+jILQ4X39fzo33NJsT+Hpjvr7MTvZW3YOtmk2B2thKfVunZrlu
 AaQZJ/9d/0mRbni2fkJj3GWb7cdGw1h/Sptfv7hfcQhbSDOm+W/mO1SZYQUvTERDBCBW
 1x8AuCwexZUylDPMH+OUETA/kS/XrVS4bCPRsQBlnoNJ9Rh7YVhxe9w0tcwgoVk0d878
 o2YynooDnIzMFO6nF291OGih626aE5FyyOCeI3/gyF6qG8bsvt59jkQVV3Ftc0Enbdb/
 8Y3w==
X-Gm-Message-State: AOJu0YwKr5d3hjtFG5hdkLKmsQNMsmr5Zea7aH5l1U3YJHJEIPMPr3Vg
 n95xiLIEcmd12j01S52s6Te3bHXjNmzkUR6xT9m06KzYflfBPvyRc9y+haAkyuGLZT2z72JPu8q
 zAxgDgiI=
X-Gm-Gg: AZuq6aKqhy6I+Spq6gfTNyatG805mVXsNZ+OM57BPtRMRZMArhIuVGvBn6SCmpVz6Ux
 afotcAnZv7YSw6xwEV/tXdWCF9Cl8u4rL81WBjwUYtMXvFGu/knjvjwgiGLZe4QAPz/ZTW4yYOI
 qwzK+OyEsPh/TaLoJ4NnImNFh5E0FWR40vld3eTUP7TIYmrGmdlLC1+GGdZlYTzuYNxmZ+EQb/1
 mhkOLaAWoJBcXVJpCvyZqrrx3fpmLSLPA7THEnzXZfl8Oa5ueY6jU1d62KRyKFBPsYReiiiORAJ
 ySd8UvQKDnKxRIhtZCoCdR/ryxPvWZFy60ldsNsUZu0kbievaCS7+pGW+CEG3JN/UTUYPW+UcS1
 kfwPU3RZA7coSBWBn5ELRu3iH3rr0xFYYWCV4QKKKT5LKdw0SPrDA+lx4RaMqdDYor5ac7TnKwS
 Ewm2b8EeRGoiVDp4D3dB/5MhFF1JylRULZKa9ZrCZyW17YOjwIBsmkLXpuk6rqEuMYY/cgrx2L1
 yBcH1HJrWu+e7wg6Nh0uI+DunlVKhsUkPoONoAFQPQsKtNZDg4FaPma8rtIpQ==
X-Received: by 2002:a05:6808:67c5:b0:450:d471:dce5 with SMTP id
 5614622812f47-46410b44d8dmr1740547b6e.6.1771447584458; 
 Wed, 18 Feb 2026 12:46:24 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-463b83bb884sm10344349b6e.11.2026.02.18.12.46.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 12:46:23 -0800 (PST)
Date: Wed, 18 Feb 2026 14:46:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Val Shkolnikov <val@nvsoft.net>
Cc: u-boot@lists.denx.de
Subject: Re: u-boot top makefile
Message-ID: <20260218204621.GH3233182@bill-the-cat>
References: <f2aa0ce9-432a-44f9-a00f-511ff2579bb8.ref@NVSoft.net>
 <f2aa0ce9-432a-44f9-a00f-511ff2579bb8@NVSoft.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WiMH4HoW3+Wcd9ar"
Content-Disposition: inline
In-Reply-To: <f2aa0ce9-432a-44f9-a00f-511ff2579bb8@NVSoft.net>
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


--WiMH4HoW3+Wcd9ar
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 18, 2026 at 02:43:59AM -0800, Val Shkolnikov wrote:

> Hello,
> I would like to modify the top Makefile target scripts_dtc recipe.
> Currently, it's a long shell command. I'd like to separate it into a scri=
pt
> in the scripts directory. The scripts of this length should not be coded
> directly in the makefile. In this particular case if $Q is unset (vebose
> mode), the whole recipe is echoed. Also echoed an "Error: " string coming
> from the scripts/dtc-version.sh called in the recipe. This confuses error
> detection tools used in our organization.

I think moving that out of the Makefile might hinder readability,
honestly. But it would be good to know what the Error you hit with
dtc-version.sh because that case should likely be handled better by our
usage in the Makefile.

--=20
Tom

--WiMH4HoW3+Wcd9ar
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZYlFgAKCRAr4qD1Cr/k
Cpo8AP9j21Bl5D5XwLA/4w3ccRfZR/sGDLdUfhUf0XNXneoU+gEAgelVXsvbML/m
QqIGLP4gNV15XxmLst2Os0f8LAcWpAQ=
=8Cxh
-----END PGP SIGNATURE-----

--WiMH4HoW3+Wcd9ar--
