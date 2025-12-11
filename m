Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B716ED41C36
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 14:01:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40B938389A;
	Thu, 11 Dec 2025 15:01:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ql0K3WeS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65CB7839E2; Thu, 11 Dec 2025 15:01:13 +0100 (CET)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E42238312A
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 15:01:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-44ffed84cccso28667b6e.0
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 06:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765461658; x=1766066458; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=T4dDDVCaoqF07sYWDkyOo+fDfifr7t/Mb/p0xdnE6zs=;
 b=Ql0K3WeSYOoPrZNd7WS9FFvh9Tms1c7dppN+rKKy4hexrrJD6tmuCldwD9yjTyhnWJ
 ByF9Udj1vPWwV+xe5yq2CNUqgPdPqk16nn1WRPeFfqjnuBW4TKA+/0XTsApYqqPyrDf0
 ywYxr9kad16knyq3lz4nNfdhdlvN18fzLHz6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765461658; x=1766066458;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T4dDDVCaoqF07sYWDkyOo+fDfifr7t/Mb/p0xdnE6zs=;
 b=mBD6MK7xZ+UmpQfgGhZdZiP581/WGXTzC6Z2mYa9JLQH3IZcnxWEgJLZ56LYKkCZ9O
 +lE335HrOYRq4H/J17mpRm4Ky7mcdo4Yof7Kgq8jQMV3k3WgWzjluh0IZVYQS5Ed5YHv
 vPij7qmGGlctnY5Vhiqhv6nimez/R4QTEI2EOwGdHCYCZHhDOI1o5b1c6KYWEkPGp2OF
 GBgmgMjVkFtoRdOp486HJp7RVUmfbHeI8gHEdMbLGsdcqU1yXjNpFqsRsldI+ugBkwS4
 zZVHRA0HnYqdXl97SL12xcaoj/1hw44QKQXrlVdBRwveVfjNurGVTi+XjH5WGk+Gh07n
 m+Aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOLFP4iPPr1N0/w2KL1QN9mFcY9eFkx5Pzf1WzdglaYXJUnVZO0SLwFnbdNxw77L1Ytm4iFOs=@lists.denx.de
X-Gm-Message-State: AOJu0YywueYNZuiDQ4NWnmhRDfYp1qB1bJXapw0Nq441IUPNsc9Lg2vz
 KIVDnCHzJXglnYdLYe9gBrqnOPOkWZjXz41imgDIup80wgXfWmntVmaHcaDf9jO8APA=
X-Gm-Gg: AY/fxX6tTy+XRXtkY0tLCqeKg8BLhn5hnOLwbYWDOqP6U6ZMRI0KwnfEj99Y4PuSw8f
 ud9HIyAKtcQmsd/ZR18HVegU1VM8nylfUbNmc52FaLZpd05GPzgqdjK68fm/n8IGEeJD5CerWQb
 GnMFtd5KVoT5euuLU49DtLSbb5wVb1q0miuQmjw4Oznc/e+1Vst2Wi9BcsITLLiVw3vNXt/byVc
 qrpIO8KKFnhm7d+/yU8DGUslp0xiGu5gN5rOIgoMtkZNNd8D/0CLCIvHwWl0BMd9f2C/cb8ez5e
 75ZUShfT2+qqV1rlrK3FsJ9Xxt4X7sANM0siw8lzb4K7xmSy/K0i/KClD5Q7BmW9p1Th+t9Q0Jp
 RIBOSveX83l4h1g96NWtpFApr/FPyNfe7oq4pZmcpHiAZGXpOTF/KmAzf8pJR2M7QJ8gDhuIdAA
 ZS1Zt8jCQ3N2hj0ABe97nNBcTJeCVZGnAGzzmJt26rOLhuAR0ykA==
X-Google-Smtp-Source: AGHT+IEvjWe6MlxhttWnnTgu3Lsznulfqr76X9gpIK5VbD2pSVcBwWJGhx5la1ffPzq9t2v/oI3M7g==
X-Received: by 2002:a05:6808:1583:b0:453:74c2:4c10 with SMTP id
 5614622812f47-455863b581fmr3108160b6e.23.1765461657496; 
 Thu, 11 Dec 2025 06:00:57 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f5d50f1ec2sm1798637fac.13.2025.12.11.06.00.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Dec 2025 06:00:56 -0800 (PST)
Date: Thu, 11 Dec 2025 08:00:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Nishanth Menon <nm@ti.com>,
	Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 u-boot@lists.denx.de, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Marek Vasut <marex@denx.de>, Simon Glass <sjg@chromium.org>,
 Jonas Karlman <jonas@kwiboo.se>, Ye Li <ye.li@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH v2 0/3] clk: Return value calculated by ERR_PTR
Message-ID: <20251211140054.GO303283@bill-the-cat>
References: <20251121-clk_uclass_fix-v2-0-74f4ea10e194@linaro.org>
 <176503025989.2523567.16347058613411695182.b4-ty@konsulko.com>
 <20251208153226.moktyjv3irmjlg6q@lingo>
 <20251208153852.GP303283@bill-the-cat>
 <fd494719-1152-44c7-9de8-0e9a370c659b@linaro.org>
 <20251208163527.oq7vddgodao3legu@unguided>
 <20251211114226.jbggbrqlcfq7dbur@exterior>
 <20251211134716.GM303283@bill-the-cat>
 <20251211135109.akox2mxasbitmaeq@outskirts>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="awjl0h+oY0fj9/ab"
Content-Disposition: inline
In-Reply-To: <20251211135109.akox2mxasbitmaeq@outskirts>
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


--awjl0h+oY0fj9/ab
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2025 at 07:51:09AM -0600, Nishanth Menon wrote:
> On 07:47-20251211, Tom Rini wrote:
> > On Thu, Dec 11, 2025 at 05:42:26AM -0600, Nishanth Menon wrote:
> > > On 10:35-20251208, Nishanth Menon wrote:
> > > > On 15:52-20251208, Andrew Goodbody wrote:
> > >=20
> > > [..]
> > > > > > > Confirmed by reverting the commit. Looks like
> > > > > > > 9ed8fafbcde3425d8817ec5953edd428c7508153 revert is needed aga=
in?
> > > > > >=20
> > > > > > Interesting, OK. What Andrew did in commit
> > > > > > fe780310cfa8bf5a093894b5cd7fe85c6b02fd91 is more complex than b=
efore and
> > > > > > there's two stanzas there. Our lab is current being re-worked a=
gain
> > > > > > right now so I can't test on the K3 platforms I have, but can y=
ou please
> > > > > > see which of the two changes in clk-uclass.c is the one that br=
eaks
> > > > > > these platforms? Thanks!
> > > > > What is the breakage please? I did put this series through CI and=
 the only
> > > > > issues were due to lack of disk space, so not related to the patc=
hes.
> > > > >=20
> > > > > Andrew
> > > > >=20
> > > > Looks like A72 would'nt get started.. adding a bit of print to get =
an
> > > > idea:
> > > >=20
> > > > https://gist.github.com/nmenon/c0487b99cbd2308ccd11ffe510a780bb
> > > >=20
> > >=20
> > >=20
> > > Any suggestions to proceed?
> >=20
> > Can you please see which of the two changes to clk-uclass.c is the one
> > at fault, or if it's both? Thanks!
>=20
>=20
> The logs show the details
> https://gist.github.com/nmenon/c0487b99cbd2308ccd11ffe510a780bb#file-log-=
patch-L12
> (return ERR_PTR) triggers the flow in https://gist.github.com/nmenon/c048=
7b99cbd2308ccd11ffe510a780bb#file-log-patch-L19
> and fails
>=20
> This looks like the clock for A72 that needs to be set from R5 SPL to
> start up A72 - with the fail, A72 does'nt start up.

Thanks. Andrew, I think instead of return ERR_PTR(ret) we should just
drop the line there and keep just a debug print. Which also means that a
bunch of this code seems to be written oddly, given the required
behavior.

--=20
Tom

--awjl0h+oY0fj9/ab
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaTrOiwAKCRAr4qD1Cr/k
ClKqAP0dTZhossIt0eHU+yjr3GQzCS/ABb8tlab7NfKA15YawwD/dghZZPucS7zy
8VIa1Oaw7ZMPlRjldsmeZ5eKtvyG6A0=
=2mhR
-----END PGP SIGNATURE-----

--awjl0h+oY0fj9/ab--
