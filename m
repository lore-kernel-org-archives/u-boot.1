Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 613D6C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 16:35:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EA398718F;
	Mon,  6 Nov 2023 17:33:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="U0wr3C44";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CA3F87176; Mon,  6 Nov 2023 17:33:50 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A62F87152
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 17:33:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6ce344fa7e4so2873069a34.0
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 08:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699288417; x=1699893217; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Wze6dPmd7fmYdR7+m+xrVtLW9OUCXEH/SieiCLREy9g=;
 b=U0wr3C44CJ7VDTCIVoykkWCjQfqz7OXGa6vkcVsCHTDSpgH+dk7tIpwxsg4N1Yv0Xh
 pEI98n7ijaAj6hpSNI+Z/cfwi1Qyl4WVHCX0BgV9AeeIUB2kicoWVwwfSzMPLzSOcwR/
 2ARQZ+RGM1vhbUOxOr1//ylC3CDCY9oBwY0Uk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699288417; x=1699893217;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wze6dPmd7fmYdR7+m+xrVtLW9OUCXEH/SieiCLREy9g=;
 b=Yv/MdQ8UVYfg9HKB5uGQpCoYzrEfN/b6aFjQXq07FfJjlEHeZgy63XKjJPwcCLsMby
 hTXbbUxXMK6Zp0Vr/F4/jU3rfPHUyueE0Exwo3QgmQqsprlG+XTSrqiTj2VO8enNyk//
 vZHL6IQYqxsgHF3pHGryVPptfW37WUi01IiyBRXp8vtCIbHpXCWPcTsF0vC3r7yL4Pnw
 0w6P/t527r76IHL8mOAp00PQVqgc9kILoDttAT7f5WUQUexjxBx1AlOSsUT/ReqKVgpA
 PxAp88rTq8DW/j7uY+9luyzrye3wtx/4ihxkwwNmPJKIalvLnEb70pIsWlw9aC1KxnIi
 4O3w==
X-Gm-Message-State: AOJu0YwUg3Fd1CdNJCDkAthl+K6u9qo2kPzBVOsGJDZjQeviXWXOzAmb
 s8NzajqulFxZa+vhZ9YPmpg8ww==
X-Google-Smtp-Source: AGHT+IGTd0dp39IdNq+qVMUgO5ZUm2woxRQCLyxrzq5E4toTSoynxSWmxrCNdOHLrLpx5NWQ1Pdbkg==
X-Received: by 2002:a05:6830:3144:b0:6b9:90db:f6ed with SMTP id
 c4-20020a056830314400b006b990dbf6edmr36474864ots.11.1699288417626; 
 Mon, 06 Nov 2023 08:33:37 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 b8-20020a05622a020800b00419c39dd28fsm3507495qtx.20.2023.11.06.08.33.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 08:33:37 -0800 (PST)
Date: Mon, 6 Nov 2023 11:33:35 -0500
From: Tom Rini <trini@konsulko.com>
To: Sean Anderson <seanga2@gmail.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] net: Add option for tracing packets
Message-ID: <20231106163335.GW496310@bill-the-cat>
References: <20231008015312.1988866-1-seanga2@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZOeixgP/6oH3+QkK"
Content-Disposition: inline
In-Reply-To: <20231008015312.1988866-1-seanga2@gmail.com>
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


--ZOeixgP/6oH3+QkK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 07, 2023 at 09:53:12PM -0400, Sean Anderson wrote:

> Add an option to trace all packets send/received. This can be helpful when
> debugging protocol issues, as the packets can then be imported into
> wireshark [1] and analyzed further.
>=20
> [1] https://www.wireshark.org/docs/wsug_html_chunked/ChIOImportSection.ht=
ml
>=20
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/master, thanks!

--=20
Tom

--ZOeixgP/6oH3+QkK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVJFV8ACgkQFHw5/5Y0
tyy7Ywv/Xd8zAa38voLN9JlJ8vxr0b87G1i2q6OGLBbXeD5yeQrutE657+EKlf84
9JnT9hVUNxkT4tdM4jKb5Gmna1I0n33z1k8qcNjADst/8I/PUUvauMfKYKQPzTh+
z8Qk6ryaQtM6XU55g6602nKnnI/eBFZBaiKoy2JH3uHEUVUVU25xjBxXgSi7L286
X04p0HuawyQp89UqrZ3Y2Fbk3Oc2QtxEykEs6phuz/gARW7FPXWGwO7LZkXYyy1P
LZDxdfyhywi+PoY/AVjRNr34xYpqCEeGTyvGcAL2VUXqCFHKE6Seb42xag/LdX4V
blbBL//eISrteqRpui6DVuPJ3/BHLNrv9o9w3W32FNNO4eb25AOkmBnizPVdEHwZ
fCkjGWJJR7sZi9S2Lnq2un1yd8M4dRcLxmL5cZcbiZHj6GudFOYQV7WpYlqM2xc1
XmefwtwkhQzqL3vv9rHvt1t0l7Ua3WCiLVOd5Z3k9qfmz1l1T8cjD49s3fHRv+kn
67tWjKMY
=gNo1
-----END PGP SIGNATURE-----

--ZOeixgP/6oH3+QkK--
