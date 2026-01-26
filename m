Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48445D1950C
	for <u-boot@archiver.kernel.org>; Mon, 26 Jan 2026 17:24:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AB2F83BD2;
	Mon, 26 Jan 2026 18:24:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DPubtuzX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0D0283BF1; Mon, 26 Jan 2026 18:24:52 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92F2783B27
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 18:24:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7d148dd3421so1661913a34.0
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 09:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769448289; x=1770053089; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6CODl+T2Gr5y6d8t9FMl5Vxf1GXtGkuRXIpr0MFUT+Q=;
 b=DPubtuzXQhfow8pmaIog7QHhm2hp+9NkTfYShE0SJNDjW0ivvrS/AvIfH6Gt2QIhSl
 a+DZGhLPphPTYYBRCtonp/ACk2gEbpjxMgNO4S/2v2MzgGpi+vW/U1bAbY1mDtKmR6zI
 lXIKtjyUP/8H+c0xlPV+AKDpv8qVbXr20UwxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769448289; x=1770053089;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6CODl+T2Gr5y6d8t9FMl5Vxf1GXtGkuRXIpr0MFUT+Q=;
 b=qj6YxD+oEhZE+khj8SeO3H72s1NBKTrXiaW35tCxKnpuz1BmXTVy9HRlVNaJxKoEfv
 /xi1bfVmsON7bqvIv9xl4eXAVXI+0h2ttduZiKD8FOlMwzDxHmxyFk/xunfPId8tuYte
 ek956sskQRV6U/hDFT2mLf1/FtzO9U7LN3kteLlD0uDx+tyijwvfFl0zi81ooBZqxRtQ
 bNPg1i1TntG/jzxiJ0UfMSI3m7h7KvIowIvIGBaINgbuRPu4hLetoIKyXKFHyutaiFU6
 Uw1XHZ7GB0pAHMWoMA0M5onA46XwQw9TyOgL0JAp4m6C25RAmaS9jBEUEKrVzJ1cN91e
 vHeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvwnPOQO+IllKeKgISe+aqNTzBwRt20clVcbMAwCYX4k42N85p9VcloVwtxn0ntRSku4KhPA0=@lists.denx.de
X-Gm-Message-State: AOJu0Yyvj4ls/N14o/t8QG1Achb9fQzGZdb20yY8xJ5LGUxQgqC8dXOj
 AeqnxeMjZzhxaC0OcyRpkRULYT25MGzeENmXcRae0dW3m/E8aYWFb/LQw2p6Vg5+VdE=
X-Gm-Gg: AZuq6aLgEYCZWAngH8Ftyog+lwPgrPSBXkzm5220+ICzlAPj9m94YQseQVIGzI31vbR
 GOKyO+67bgr8weveIQGX+x3FhHkxViT0xcAnUmYl7EalVipHI8UWPTBarAP+Op/LLGIms4dUMRg
 2ICkE+YFB0Kks9HTNgRD7n0HFMe2RYI2AX+0evWW2Joe9L4MLnTgEpJlKvs4ByEvNypQ/u2iBth
 B67awjOan0eh1jPHNeeADvQrlTxHP0P23gFdJkCFD2y8Bnn57JnH+n0tuZ3pR4NPQKyxRoqjhEB
 J79llZAS2CbV/7JafwH/FgXm0Q2ldFWxzfyc7YJsISo/YIZsB0Qc2TQLSrpWx1vMyd3wRmR4Wea
 V2CVvGxzXTogMVmqVYh6qTIYwcQPJUxEysybO3uF80rR7yAft0V8EzTSHlBI+UiMbQbr0hyymFz
 g0B49L5Flk4vfcWNsQ5FXrNR5PvmdcgetmcEP4+DjvmjjqgQuqEGgi/iQjyBSLVNwAXwJURBtcx
 YTnZjuMV3kJMlEgklVjHUiI/j3OjZeQm1Tw9CxcLkXbN8A33A==
X-Received: by 2002:a05:6830:700c:b0:7cb:125d:2a43 with SMTP id
 46e09a7af769-7d17026b4a9mr2454858a34.28.1769448284249; 
 Mon, 26 Jan 2026 09:24:44 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d15b3e2f4csm8303728a34.30.2026.01.26.09.24.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 09:24:43 -0800 (PST)
Date: Mon, 26 Jan 2026 11:24:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: marek.vasut@mailbox.org, u-boot@lists.denx.de, sjg@chromium.org,
 ilias.apalodimas@linaro.org, Fabio Estevam <festevam@nabladev.com>
Subject: Re: [PATCH] arm: spl: Fix DTB offset after binman symbol table
Message-ID: <20260126172441.GV3416603@bill-the-cat>
References: <20260123161907.392211-1-festevam@gmail.com>
 <20260123201202.GO3416603@bill-the-cat>
 <CAOMZO5DVFO=A6g1CWOrRbqy4VNgL+VcUw0Q5pgELXm30puGz4w@mail.gmail.com>
 <20260126162756.GU3416603@bill-the-cat>
 <CAOMZO5BJDzeJg6cah4hG2G-gwgi4AA6T7WKqnpspr4_26gUrdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ECIOJsPGzih0UTtO"
Content-Disposition: inline
In-Reply-To: <CAOMZO5BJDzeJg6cah4hG2G-gwgi4AA6T7WKqnpspr4_26gUrdw@mail.gmail.com>
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


--ECIOJsPGzih0UTtO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2026 at 02:17:14PM -0300, Fabio Estevam wrote:
> Hi Tom,
>=20
> On Mon, Jan 26, 2026 at 1:27=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
>=20
> > After talking more with Ilias, we're going to handle this in two-steps.
> > Step one gets more platforms booting today. It's *slightly* different
> > than what I posted here, however it's binary identical (I just checked
> > and got the same checksum as this patch produces, build-testing
> > sonoff-ihost-rv1126). So I'll add your tags to the commit.
>=20
> Sounds good.
>=20
> When you send the formal patch, I'll test it again on RV1103 to be on
> the safe side.

That's good. I'm back to thinking that what we've been doing and having
you test so far is still a work-around because it's really that when we
overlay the BSS, we used to always have a size 0 .rel.dyn, and now
sometimes it's 0 and sometimes it's 4 (as Ilias noted), and the changes
I've proposed, in limited testing, mean it's been size 0, but I don't
know that's a guaranty.

--=20
Tom

--ECIOJsPGzih0UTtO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaXejVgAKCRAr4qD1Cr/k
CjyVAPsEDO5uLCPJ8yCPykblKCZVT5XFbZyowm402xo3A+8xFwEAkYO/MS4qYBMX
h90ud+nOd7RzXz4GzSkRt1R3O921MwU=
=sgY5
-----END PGP SIGNATURE-----

--ECIOJsPGzih0UTtO--
