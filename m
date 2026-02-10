Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 058CEEB26EC
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 17:02:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E8B183A47;
	Tue, 10 Feb 2026 18:02:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cfb69rXU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7554783D7D; Tue, 10 Feb 2026 18:02:12 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5405483D5D
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 18:02:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7d1916d1e24so871587a34.3
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 09:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770742929; x=1771347729; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=X2iP3gYCn73jr25l43jeiqVq6mf6X0Ki4+FTu7GjPos=;
 b=cfb69rXUj9Y+mDyM0pvLWWQzlQWr8vOjTpPHCrZgsGMU0sCZmQ3eBpXlDKEqN9STJY
 axDTGQJhKFfvV+zxgfkP3om2RQ+Vei27oZpcqG4hYwNQREs1TT5s/pBoe0hawRoHHvuH
 4Yojd2a9UZEqz2zzCuc2kBfztJMLHv8FYIgHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770742929; x=1771347729;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X2iP3gYCn73jr25l43jeiqVq6mf6X0Ki4+FTu7GjPos=;
 b=ayIrqY9XNuSYrZvvX3aht5nLgcKtU3EMoawkp/U46yC6np3JvqxUjlccUqGNZS9f0a
 RtTnvEtN+lTd4aux37bfU6ykzU2k/fh3LXhcl1HLp4fgSSGIWBtgDsyOJmvHiH4NuQQ6
 qpaJ1aIPXMnDb6c9j51oewyufLKhGqHQsHaO9JBUUkzSPRS8hnh+q2a3gvA0tvsWjc/N
 fyPbz5lWC1DbLDpmu/6gd0bapVB5YhL+Jn4ph0C4KE5NXTnOjbRUn6TnJsJGk1lsbhAW
 9zAvapReVUPyCVTQVG+COp3QknCUsglwQ4pIncgrKw55DTH+2Ii3SEvmBWMiqplbMixY
 d3RQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdw0KwSi1oZNwnEUnA0EWYrAbswUIKlrGpXzeNhS5Xyz+EENooj6HTC2wd3InHJiY7TwhjPJM=@lists.denx.de
X-Gm-Message-State: AOJu0YybAUKyvSC5Y1AlxUjB7gD+otuFfMkWJ93QRKlCcCPmb2I7ontk
 Iz9CVZJDl1YkeXeubacMMeq1hY7w2mBWJwimQRf5WioTbhHLQUStLVH2UgiyL9/lCsc=
X-Gm-Gg: AZuq6aIMM/IDmBxEDzJjwQQAkogHpeAOfHIgSCIL/50w6cAU9uadO6Nfq5BwYsuoEHb
 y5vvdxVF83AMpgSAQpkjqf4aM7Hi/ROC5Ed7ghtsvXIPio5oevvmYY/nKCkphRDo2BcI2i2OEET
 +nbFMxmqEydq+yfv4bMbGlISbNkytqRt2/b1gELHVREgnj5Dn/jr79xmKiRU6IzmT+BrN3DvUkZ
 yu1ZOHuCQ5pdGezcZpbab4GPvTkROPOrSWckoK162FT8qGWH7YkwMI1GWNR8wxwF0pvRdrX6aRU
 gnQhBwkwZnuZ4zjhpm0JAQa2a7tRqXTTabz/8diL4pgpbhssgBlPLnOnWzhlhWxIOT3n9YVXO7S
 CzvKHdbIUDZ1k6OtJUwiOF3YbuPugOvErCCNMZBYBkj8/PTTGEm/ZLQ/dR5gWe4ofRCSto3elXa
 VY3JuR8hPFI1hpIrL+G/LbxJpsVsMYQAkX4AdBPlDnDqcbXECIVPNgKL9lgeDAY8OTod3IdIRQf
 F8O1k8CtOhd1u14BHSLhWsuByfiAaX21OqkaQoRYn9aEktdMRA=
X-Received: by 2002:a05:6830:82e1:b0:7c7:6479:38ce with SMTP id
 46e09a7af769-7d464485aa9mr10342029a34.18.1770742928722; 
 Tue, 10 Feb 2026 09:02:08 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d464796ffasm9483587a34.20.2026.02.10.09.02.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 09:02:07 -0800 (PST)
Date: Tue, 10 Feb 2026 11:02:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Eric Schikschneit <eric.schikschneit@novatechautomation.com>
Cc: Simon Glass <sjg@chromium.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "bmeng.cn@gmail.com" <bmeng.cn@gmail.com>
Subject: Re: [PATCH 1/2] Fix x86 baytrail boot flow.
Message-ID: <20260210170205.GA2715950@bill-the-cat>
References: <20250714210249.4139916-1-eric.schikschneit@novatechautomation.com>
 <20260203180159.GP2603314@bill-the-cat>
 <CAFLszTi3dFNi0e4C3mSJAMJyh_+Ev1+NmhTtyAXXnHG0MK9e_Q@mail.gmail.com>
 <SJ2PR07MB971124EAFA0B19D31E83D3E18162A@SJ2PR07MB9711.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nxOjOOmML0eK5lsi"
Content-Disposition: inline
In-Reply-To: <SJ2PR07MB971124EAFA0B19D31E83D3E18162A@SJ2PR07MB9711.namprd07.prod.outlook.com>
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


--nxOjOOmML0eK5lsi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 10, 2026 at 02:01:58PM +0000, Eric Schikschneit wrote:
> Hello Simon, Tom,
>=20
> I am getting back to this and will try to answer your questions the best =
I can. It has been quite some time since I was deep into this code.
>=20
> 1. Tom -=20
> > Doing it this way will break other architectures. Can we just call the
> > function needed inside of x86 assembly?
> I suppose we could do something like that. What do you suggest? A new .S =
assembly file?

If it can't logically be put in an existing one, yes. Or can we just
call the new C function from somewhere in the existing assembly chain?

--=20
Tom

--nxOjOOmML0eK5lsi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaYtkiAAKCRAr4qD1Cr/k
CtLqAPoClRud8UQ/SUD0XJfGmL8osLpzFYvNOshWnuw4ncgQxQD/dTb1l6OR3Smh
ecYOQ6trnoVVYb+xt9xMzAdGztuOJAI=
=Xn0G
-----END PGP SIGNATURE-----

--nxOjOOmML0eK5lsi--
