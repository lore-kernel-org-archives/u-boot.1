Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF9FE77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 14:23:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCCAB801E8;
	Tue,  7 Jan 2025 15:23:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="q2pSLU3a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1220C801FD; Tue,  7 Jan 2025 15:23:10 +0100 (CET)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D67308007D
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 15:23:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7b9bc648736so1267617185a.1
 for <u-boot@lists.denx.de>; Tue, 07 Jan 2025 06:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736259784; x=1736864584; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bdPCZaVTgoXhz41ngbJNpYxGT1Oe0bP6Hkv20xTllaU=;
 b=q2pSLU3aqRgFJclh3CkYVYe572fomHVyGk5EtrESHjesOwd8qvnod/kRy08mXpvZ29
 zBswdFE8rucDs7f5BarIMRM7o3OaFf6Ni7amBAJYT74Ev6gv1pvHYR2wZPVIy+aTsuMw
 G6lGOq8fu8+NypYWcQU/+BSZMWIljvFluX/nM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736259784; x=1736864584;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bdPCZaVTgoXhz41ngbJNpYxGT1Oe0bP6Hkv20xTllaU=;
 b=sf/OiaoqDWiEHzMFIGiUFoqV5+ZBiRUgCCsGJNlfkcyyCVGYD4sYN9wgLYqRSo9RfE
 6haxMrJNvqYa0Uyxeqh/DO1iv06KDich3tpyFNy6mSIaJ6N9FzUihG/loF66B5lWNyAi
 uvnkIOvc8/7FEE4cBUwd3WB8Ztw/wvsayiY8ELpASusMbmEFfKs3V3IpFoYFI4Nah1xk
 erXdLH/Jt/CifV0pko/SdCeDJdTT9jJ/j07ta4RZqhqS6A1aDkiGEsVK5Nv15erlYYNT
 NM2u3TJgKbjhTWY+mx62d39b/BBQSc8bEgz4MuVRrXl17IQo5U+Dn7EW88Z2JhH9CvPu
 QJVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkLtpSnTMYbHgQ+GVE9Voeinzmjz2zwj3Q/Gz52KT3772E7vF6OuMuvaUOfESdlnz0ZdLoz3k=@lists.denx.de
X-Gm-Message-State: AOJu0YylxF1XSwogCDjNxxM8hMG1DQLDMwcMM5NdhU3rmXdVyg9Ujnu9
 aGwHsuOXUahMI57YBQ44ZvahApYj3iVftRwrNSFxpe6DsRIt/j0yWyemUZQ0MZI=
X-Gm-Gg: ASbGncuN4h7SFqqWr1qY55MR0iETlLMnrSN1mHYDl/YOai7K+GC0LEkUJiWLQXkGXoE
 dnVSLFE3PNXitWGfVatH5zs+3czINNsth/r5pnfjSU7aiXwQnKgH0yaVl/8BzTNKoz2cypz649b
 TFgr62FY4Nnf+pAdu8bAl+a7XEawuDb/HMOL16GKpQYmquUYLVYhZ5Lzma6P5Pl+fr/ZjgBNaTq
 58cKTIijtTAn/tkRUukj6/Dlo5/MQx0c3ap+Ucmadxdk8+6mMZeopA=
X-Google-Smtp-Source: AGHT+IFFM614Fn1fmcgPg8X3Hse8E3Rui3iARmGOp5CuQTObj1g4yM7/wXEOoFamd8VpTo7nFfUvOw==
X-Received: by 2002:a05:620a:45a1:b0:7b6:cf60:3971 with SMTP id
 af79cd13be357-7b9ba79af3emr9330764885a.22.1736259784610; 
 Tue, 07 Jan 2025 06:23:04 -0800 (PST)
Received: from bill-the-cat ([187.144.0.100]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b9ac2e6587sm1593129485a.48.2025.01.07.06.23.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 06:23:03 -0800 (PST)
Date: Tue, 7 Jan 2025 08:22:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Chintan Vankar <c-vankar@ti.com>
Cc: AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Nishanth Menon <nm@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Hari Nagalla <hnagalla@ti.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Andreas Dannenberg <dannenberg@ti.com>, Simon Glass <sjg@chromium.org>,
 Jayesh Choudhary <j-choudhary@ti.com>,
 Aniket Limaye <a-limaye@ti.com>, Aradhya Bhatia <a-bhatia1@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Bryan Brattlof <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, srk@ti.com,
 s-vadapalli@ti.com, danishanwar@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH 01/13] net: tftp: Increase TFTP pkt string length to
 include null character
Message-ID: <20250107142258.GH3476@bill-the-cat>
References: <20250107093840.2211381-1-c-vankar@ti.com>
 <20250107093840.2211381-2-c-vankar@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2izjm1dDcHop7Ysu"
Content-Disposition: inline
In-Reply-To: <20250107093840.2211381-2-c-vankar@ti.com>
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


--2izjm1dDcHop7Ysu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 07, 2025 at 03:08:28PM +0530, Chintan Vankar wrote:

> 'sprintf()' function defined in 'tiny-printf.c' is returning length of the
> string excluding null character. Fix this by increasing TFTP pkt length by
> 1 to avoid TFTP error of request being not-null terminated while
> requesting length of packet.
>=20
> Signed-off-by: Chintan Vankar <c-vankar@ti.com>

Erm, if tiny-printf's sprintf doesn't work like lib/vsprintf.c's sprintf
in this regard, we should be fixing tiny-printf.

--=20
Tom

--2izjm1dDcHop7Ysu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmd9OL4ACgkQFHw5/5Y0
tyw92Qv8DZJaHVumZ8iFYxBN0ziq49DrQDf9a3TlrWLK8AMZuopI8qWs2oMisDEQ
fU05n1+IALY0qt0uNKjpFPLl8yxV1dEiRd97rExa1mLSRIXh8bZB1f3vbOe2EJpV
D1GtU715zzB23DCncO+bIQS+ZL3MgTHW5EJttaYwrHUNSsoh/bBb6AQFtEovViNy
CZNUz5DH8I4GSYWggvV/I3xQmp+7FEmz9WJP3YVP0jlzfOSSgf1Kl6b6WPM5IHQK
eqkHWDCCqdzRGVsWOWjq3UQaTFK3rvg443F4K3LbGptr3EwXaXy2XfwvnSfjDMel
y60Lso3Hf7f/rF4/rSz0yFDx3E7bFD322NP4WDcLUHPgGfLCCQoBtlLm/CRkVBUU
lusQO9jVpuedJxy7B8gVdwD+8Tz4M5CoSSeC3JSVVXgj1gyrwJqXDAKe+tdJd16a
Q6QLtK9NwoXM6dFJ08vUhQIrnXgl27KEbCf1S8M9HvbDNqLUvH676ffhxXg4mebJ
uSTV0LtB
=LDmO
-----END PGP SIGNATURE-----

--2izjm1dDcHop7Ysu--
