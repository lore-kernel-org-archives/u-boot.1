Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9D2FC54E58
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 12:42:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1380288048;
	Wed, 20 Mar 2024 13:41:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kKe9ZGv3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C217188047; Wed, 20 Mar 2024 13:41:51 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FDA588065
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 13:41:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-60a0599f647so60867477b3.1
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 05:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1710938508; x=1711543308; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8GjgHJAj+TVKzjduL3VS8SEShVxan4onwyPyEdeQakM=;
 b=kKe9ZGv3dyRhF5bT1ppGaZ4k1W6fqmYv/xJgGocVaVVzdNU4s0iYSMzVIGTSdPpNo3
 ykqKRNr7xsuoS6K4qHV5RsfpNjKUm+UT/7TeKNyyeiHabfW2sG8Ti4Hho172VxopfS3U
 46t4YOUW/1t1oQVAWpLanc4A9jgddSor6uQiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710938508; x=1711543308;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8GjgHJAj+TVKzjduL3VS8SEShVxan4onwyPyEdeQakM=;
 b=n4xeJFX+FAF6JWEkXbT7Scn+DhZc0egqvCy1UnKeZjUD6edNyFrwHO96hE6Eov8cIz
 ZD8TJTzRW8D2RY+6DBa/kX3WZonJP9/LyczZ4xmGSiJo9IzVpOkFcO48hBCBnW22tMDS
 k7QS4G1whBJ51fCc0qZegLBmevNZ1Vpvy13EsCnvsGxj1XxvHpa01PebEqA4IaeXqYHR
 yTmUwJqU06StgzlxYSwiY8vvNyYO+gzYw/Auu0DGRGJr//e5w9n69NTSq4hCoCoCeQKN
 q5t1fzL8x+YyEn5dkGNaKNOdGUnBH4gVzUZ9ij+AEv/QGeLVeC8jbAyRDzukk1K0K2dq
 xSGw==
X-Gm-Message-State: AOJu0YxEZxt9mQ5QRfBpoNEWwWHCpF9ZKKdIk4Z2WJtwIxUykKT3pVZs
 mdXOQO0GiUgtcB+1hzwZi6k0w7/QUzHQYgo3ByxYuscixPzY/rJhAmFV8oFT4hk=
X-Google-Smtp-Source: AGHT+IGH8CwDBQAs3Rl16URxQBJyuI1/Bu71hBJfpkhIEkK+MGM+yormwjnVDxwPcgvrPh6iIMc5sA==
X-Received: by 2002:a0d:dcc1:0:b0:610:b98e:c17b with SMTP id
 f184-20020a0ddcc1000000b00610b98ec17bmr10470077ywe.3.1710938508131; 
 Wed, 20 Mar 2024 05:41:48 -0700 (PDT)
Received: from bill-the-cat (065-184-193-066.res.spectrum.com. [65.184.193.66])
 by smtp.gmail.com with ESMTPSA id
 em8-20020a05690c2b0800b0060a297c4c6dsm2746776ywb.8.2024.03.20.05.41.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 05:41:47 -0700 (PDT)
Date: Wed, 20 Mar 2024 08:41:45 -0400
From: Tom Rini <trini@konsulko.com>
To: Lukasz Wiecaszek <lukasz.wiecaszek@googlemail.com>
Cc: u-boot@lists.denx.de, fenghua@phytium.com.cn,
 Lukasz Wiecaszek <lukasz.wiecaszek@gmail.com>
Subject: Re: [PATCH] arm: Check FEAT_CCIDX when parsing ccsidr_el1 register
Message-ID: <20240320124145.GO3442575@bill-the-cat>
References: <20240310103003.2302-1-lukasz.wiecaszek@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RVh7enbWdACsxZCO"
Content-Disposition: inline
In-Reply-To: <20240310103003.2302-1-lukasz.wiecaszek@gmail.com>
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


--RVh7enbWdACsxZCO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 10, 2024 at 11:29:58AM +0100, Lukasz Wiecaszek wrote:

> Current Cache Size ID Register (ccsidr_el1) has two "flavors"
> depending on whether FEAT_CCIDX is implemented or not.
> When FEAT_CCIDX is implemented Associativity parameter
> is coded on bits [23:3] and NumSets parameter on bits [55:32].
> When FEAT_CCIDX is not implemented then Associativity parameter
> is coded on bits [12:3] and NumSets parameter on bits [27:13].
> Current U-Boot code does not check whether FEAT_CCIDX is implemented
> and always parses ccsidr_el1 as if FEAT_CCIDX was not implemented.
> This is of course wrong on systems where FEAT_CCIDX is implemented.
> This patch fixes that problems and tests whether FEAT_CCIDX
> is implemented or not and accordingly parses the ccsidr_el1 register.
>=20
> Signed-off-by: Lukasz Wiecaszek <lukasz.wiecaszek@gmail.com>

Applied to u-boot/next, thanks!

--=20
Tom

--RVh7enbWdACsxZCO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmX62YkACgkQFHw5/5Y0
tywtggwAlfwGU5yHbqy6PfNRNC2qd30akFb4UDt+MQtOcmpvLg4miiUKJlavH3vF
dMT/e7pgF46dRRx76c8naViYJDSfLZ2fQVFjcak4DSYZDCsmgq9haoSxCsJiSvaC
kzC+wp0ywtJfAssYkFA5kgIYFOJHK+uK8g4BRCwr/y6sJLJvELccUa1sku5KtN3Y
ia0grd4HpMFvUmQHQFhsaGDVQeIZyvUA64jwhSq4nZ2kNGGKhNKM5lDVEh1+hPUW
DFWJgQ6ELChe0qI0+5UGkdoRXX5RN348J1AgPx9Y8FoS8nGGt00qp8NfXgiKj8h+
mQ2Vj2+c7sLyKirtPRetL/ZjLmJUqfc39jFmm3gPSp/ab1XcjqH69a/EeGSQNulA
BSMXXjaUQvZGazL/SHg0++H5QjsK0tsuA9h3pd5AnFawlO4gvg4K/aaWCPTYyQee
iEE4gRPa5KvFrwAG4/6s3BEyy/cAyiXE7l1tFKVyU3VQIRxHLURNIS9mdZFbMOpk
4uxAw1k5
=cB3o
-----END PGP SIGNATURE-----

--RVh7enbWdACsxZCO--
