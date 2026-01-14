Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9305D37E39
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 14:48:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4201C82C7F;
	Wed, 14 Jan 2026 15:48:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EkFdemmb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0DA8830E4; Wed, 14 Jan 2026 15:48:00 +0100 (CET)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B52868063E
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 15:47:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-4040996405eso478915fac.2
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 06:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768402077; x=1769006877; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=U3tlEjlvLfgIgbBkJ3TU7S0oGR43rw4Cw/SC9TW7C/M=;
 b=EkFdemmbI/thrp3kYXi+P2q9oMLSf/vYNsHetfGuwhDBFKJQMJIidrgO/SGYjwZjC6
 LJGMJtlsK49Aw0aeU6NA3bVqrvbjJaIRxmtAEzoydg5MhcMhc9ljEy5WBTTvjE+tcMOf
 yBMHigEcogIZeVvFY6CUHVWGW98rwCPAA5vGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768402077; x=1769006877;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U3tlEjlvLfgIgbBkJ3TU7S0oGR43rw4Cw/SC9TW7C/M=;
 b=geOoe1l6U4dnnd3olbd48VKvojuGNnrQz4AOIJ8CsA0gwPXSpQcrOMcOWKLZ7Qkuze
 wtN4VCIt5pE6J5z8m1Mq5kBOi0uaprMW5L4GhRoMb+Wco8Jstb+8fQ+FloY2rM2yrbZc
 XJ0+aOXbO7r1oDW1a7+IEEfG4WWPksZA4y9locJ64SHLKvy2yXm3N2VF39PkqieBA5vg
 LzMq0rwaDfEepCJcTYOuZ+GU+I+ZQkjrC6GE4D/3gk9tZJMxO73DbXYy37Tom1WC4pzc
 bnhl80CgjFCbdfKhU+nvr991zW5YAvuaencoCTmQB8S8HEupJYuZqAdGlid0CT/nFu2L
 U2TA==
X-Gm-Message-State: AOJu0Ywd39jiM9PWkQrEVP7HwBmnD8HEvjN1FZlGvEEAzEFIHf5DFUlr
 rv0Cp0eBn9YId8sFSjbpHjnBhCr/NSuXwp57P2LzdFscEd7ClyxxpI/78nNXZZlb3fo=
X-Gm-Gg: AY/fxX6phyydd8Tvmcuej5WqmfFl++CIpgDFBFvwoRwNBIl9JPhCEtSnXQkWKxd9ZtY
 jf5fbYx6Mo1iT0rLggTfS0CFNMUydEvpq44ZlLxjBo4VBewcVx65I4eprwMf9828DnVTnadjz+l
 1RiP1TF1sbkVLXi6tzluYxTNMB/PNH/kJ8nyrXzTeKYGQK1ZhOJEGQrdHSqkG0HG49VG/h89snv
 NWbqsc9GxEHxKD9q2CGGJjF3KZEbiWWcbUhZ3d9sn6AzFSeGurSzWpqVHnON5iBiHNx7cQjAl2g
 aSqNhpWQen0Yo8WqFMnrFlYn0vT+cdCylj3ymgx4dL5TpM+Zy83LZrR1eC6MZRKQLl0dpP6ukTY
 5NsFIqzQmYrpC1P8UE4qozyCtGRjejeGTKDcQ3OUSU68Aa6Uj2f9XlH1KooZpAZPBuo7Zo0eGR7
 UAr2DP81GRltFJLSIiN+U7w9wZ23VkebPHjCN8KymreZPmosBChdPsF3HKIwUQSMkDtU/6dgBY3
 40YgyHDJqXruEwX6oUokX7uqVg0GseOrtvQ4Qo=
X-Received: by 2002:a4a:c910:0:b0:65f:6aa6:fc4b with SMTP id
 006d021491bc7-66100638a25mr1564844eaf.19.1768402077384; 
 Wed, 14 Jan 2026 06:47:57 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ffa50ecb58sm16465643fac.18.2026.01.14.06.47.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 06:47:56 -0800 (PST)
Date: Wed, 14 Jan 2026 08:47:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Francois Berder <fberder@outlook.fr>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: Re: [PATCH] bootstd: android: Add missing free in
 android_read_bootflow
Message-ID: <20260114144754.GB3416603@bill-the-cat>
References: <BESP194MB28052734FD0361EA602F6360DA8FA@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+lF+BogIol+m7dLd"
Content-Disposition: inline
In-Reply-To: <BESP194MB28052734FD0361EA602F6360DA8FA@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
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


--+lF+BogIol+m7dLd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 10:14:55AM +0100, Francois Berder wrote:

> If strdup call fails, one needs to free priv variable.
>=20
> Signed-off-by: Francois Berder <fberder@outlook.fr>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--+lF+BogIol+m7dLd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaWeslgAKCRAr4qD1Cr/k
CpEgAP4jdh8lZ+OH/kv1ythh/HahDe4UGDBPr4jLEIvrhCQNFAD7BoKz4u6Lv9Gz
zHAQi2dtPP9w2j3+plsNqJUDJOKUWAY=
=FEUx
-----END PGP SIGNATURE-----

--+lF+BogIol+m7dLd--
