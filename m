Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61AFFCD4F3D
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 22:44:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DBAF8486B;
	Sat, 23 May 2026 00:44:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Kape0A0w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D47B78489F; Sat, 23 May 2026 00:44:52 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7D2E84659
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 00:44:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7de4be15125so7879454a34.0
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 15:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779489889; x=1780094689; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Nq55D2/7B/z6ZMZdPgeNUtoTIcQFpu4Cz6d5m/VPDGM=;
 b=Kape0A0w6uzSkGURGTdn+mEj2yAwgrBY3xYvBT/1q6dKep7zx1AAGUvZy9h4FVaJmu
 XDrhkWmoZvS6sq24HTRHeNBrykRfOslMsVbkNTak/m56P7nWlMdwXQ9/JasMtBBQOaH5
 UDyeedRC8/6AEp0eT06Pb2WWu8M76d4Eircmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779489889; x=1780094689;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nq55D2/7B/z6ZMZdPgeNUtoTIcQFpu4Cz6d5m/VPDGM=;
 b=jjliUmK1RNlz6xhWZvp13hqGqTdmb9wg5RyabYB19XKM9cOzCH9JTwoYlGTTLEp8ZN
 UNv8qyapms1hW6kdbbtWkRAhoI2bubLpOkdnJQdzxgk4fsmh2vMq7pvxgdwsI5554Dku
 ODFpP7iU63Yu8lrWVo+AzXeDDIA15GxfB4d6kV8qsAnUVNiKaN/nBY5LGHPIYUSvivA6
 Miuvx3Zc2Ca4rA95uToP3y4G8f8s6hvo8MrSa0ruVN8rZEKcfXZyGPz+WJ/O9y48Rihv
 /t1Zs5OOyr9Pu0jjuzbrHrOOh0M6VXe/llYxGiKM3DaKOKiyA/l7gyglNxPwBfP9dA6u
 exEA==
X-Gm-Message-State: AOJu0YyJh51yWggQS94Ccu41vEosZO/VDG5V62QAsHIAmXPt65DBhajC
 ZO5XigZaD90oeYcvAaowBgshXnpoNki2xgQF0N6r4x+gOUDkz83joq4VWYp9Vtqb0FU=
X-Gm-Gg: Acq92OFppbjzJy6tJ4Q/+4oxK5Mz8eO3X6Nbvq/u7B4feRQci01szgQdJ63Cg/k5/FS
 ai+gt/qiklc0lh2k/1LIq4gu8bL9cy9dB3PUTdgnUONL1iP9eTpqBvgs0vJUtVtP56NIsMNm9mN
 jZ+2v/8k2UGYCNVZAVY7hmWfg1cde5P2ebLo6Zt3vw9z49PVTTL3YXxfMxsW4MXDXmQYJksmWBu
 FlTzVzwapKs/s2Fw/F06yDb0M1oy7CB9f+E4Gf7K6TK25j6gsuG6G4z363nQjTaIobxGPDqQY99
 F0dhSXK61bjkbfqCbWXux01isvLwdUaNevvI8M0c4PS3QFleNP7bUXcAx/es3lvmplo2mbQ3gbx
 y/mDP3TEnRLzHGZgWh2SV8Z9oHStgxyq56VxUUmFudLjxb9+IjGzkLSj5p8jEH9G9uo7/41lkp5
 pdGEj4q4ITQFP+ztuFlC1hyUWwRTGtdV4zf//SJSLz5jq3RypcfO9nI6SG7nPoJNVQJZAGogbSJ
 IybWNQXpVl6WQRecA87crp5Mf3UzCPK0XCIhG1GsfRuGw==
X-Received: by 2002:a05:6830:3691:b0:7e1:f7e9:327e with SMTP id
 46e09a7af769-7e5fef19076mr3604502a34.22.1779489889443; 
 Fri, 22 May 2026 15:44:49 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e60666ae5fsm1970926a34.24.2026.05.22.15.44.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 15:44:48 -0700 (PDT)
Date: Fri, 22 May 2026 16:44:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Subject: Re: [RFC PATCH 4/9] linker_lists.h: add ll_*_name() helper macros
Message-ID: <20260522224446.GB1858239@bill-the-cat>
References: <20260522212756.3169222-1-ravi@prevas.dk>
 <20260522212756.3169222-5-ravi@prevas.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nfVQOdoha0KvmgCb"
Content-Disposition: inline
In-Reply-To: <20260522212756.3169222-5-ravi@prevas.dk>
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


--nfVQOdoha0KvmgCb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 11:27:51PM +0200, Rasmus Villemoes wrote:

> Instead of open-coding the same section and symbol naming scheme over
> and over, add helper macros that take the list name (and, for entries,
> the name of the entry/entries) and construct a suitable string
> literal.
>=20
> This will be particularly important when the followup patches add even
> more uses of those names.
>=20
> No functional change.
>=20
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--nfVQOdoha0KvmgCb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCahDcWwAKCRAr4qD1Cr/k
CnlBAP94fkw33hAelIFQ1Iy1zRuFVA8HNyeOBQMQ9upz7elK2wD+MCjDLBqlZZfi
Ym6a3hr5FwU2T8YcHBcqb87MbtFzKgc=
=c4G6
-----END PGP SIGNATURE-----

--nfVQOdoha0KvmgCb--
