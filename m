Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFCB2C02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 21:31:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D53FA8082D;
	Wed,  5 Feb 2025 22:31:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UnfqfWbn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0724E807C0; Wed,  5 Feb 2025 18:22:27 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EB9380104
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 18:22:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-21f1d4111d4so1253305ad.0
 for <u-boot@lists.denx.de>; Wed, 05 Feb 2025 09:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738776143; x=1739380943; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ofIAIaxr0UC0k8xr2iLXKJXpoDYeCow3oXddW1RlP08=;
 b=UnfqfWbnOUtG3m0tdCGU6znCPOJ/SHn3UY2I6xEQEvnXQbMxsUq6gxI06AeoIwVEEx
 Rmq/Sm3y13zYHnnUwel5aMNiFnugs8/x/dzacvnuNB/rbjOm01d6OaxdX7y1itKs/sMW
 pDTRHi19j6A0E4Ca7MawdwgI5fq3VDWxTgmZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738776143; x=1739380943;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ofIAIaxr0UC0k8xr2iLXKJXpoDYeCow3oXddW1RlP08=;
 b=i/FPrUenw2DzEKuxeLCiZYDv5ya8SOEUYgJBQmreMTYH3719CL0a4HraN+RWNCB3Kw
 8G+FvdEk5DQ4xRrbcQ48koSMUhPZLCN4BgrEfuWy1QFR9+TeRMHAeFI07vyjtcmLcq6/
 rjx8NiLXEF5z2MO49HUltMu91S0rMa7P+6UaqnfTYS0NogmuNrwmZbe1FfAgX+LdxdOc
 5CTXngvJVMvtqQqK3hqe7JiOh8Mgv3OKfrkQTV3n0Q10qABpHG0LNaKbho9KZA4mMf73
 S12BfEeK97Nfodaeec4nSz0XcJpOEuGLwfKDqwJLEZ+Xni5yR3CSaByjpIS+PTv4UtOW
 pjJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjRr+loTm5mMmRGSRmsYc9UANGHHc42KwFnMdHspJEkM0BVqo/wt6yFSSPlnOS1s1yzWxTs68=@lists.denx.de
X-Gm-Message-State: AOJu0YzQKGWwMOrd3EMZYXMHVUCe6n9cxKgF/za4CXQ4gIomjBzGdyuo
 mw8RobEopSvvc0nBju2BhoPlr4kR5MUp8G0Hu0IVrCy0XM4cgvx60Qf02mk8Xjk=
X-Gm-Gg: ASbGncspn4ZyIKbbzY6J7LMGBKUIW+SAqB5GoC9YGlA/842Gy0m1gCxMtdo+3MlUCid
 XCu0tm4scef+rl9TAes4LytkJHSuHQ5TKzIIso+z1M1tVIp6jBgHcK1Et/jCLXJi6UDupkOWNMN
 YBso/7tQ0JOv5H0n3IO9MVWlILj64fqNtYYzDAMsSkg+VetwQZVFWQPgvyr4u7MPahKpc3QrqqK
 QXhlJ1f8B/kEMJnlfEfAjEGWMp81r7MV8AyN0HlHFgMbY+D5B3OXH7u5vwntk3A/jRPEPg5wZ/R
 ixFgrrV2H0nGtwk=
X-Google-Smtp-Source: AGHT+IExNK5q5Nv9T9laUQ8Ue54EZf5eq2LDBTSVRvkSnLcN2CHz6kR6uDIuWx8ViLU7iT4tV0ln4A==
X-Received: by 2002:a17:902:cf12:b0:21f:134f:22ad with SMTP id
 d9443c01a7336-21f17eba99cmr66251925ad.38.1738776143104; 
 Wed, 05 Feb 2025 09:22:23 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f29b0d36fsm4834245ad.132.2025.02.05.09.22.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 09:22:21 -0800 (PST)
Date: Wed, 5 Feb 2025 11:22:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: xypron.glpk@gmx.de, Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Marek Vasut <marex@denx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sam Protsenko <semen.protsenko@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Peng Fan <peng.fan@nxp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, Andre Przywara <andre.przywara@arm.com>,
 Peter Hoyes <Peter.Hoyes@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, Sam Day <me@samcday.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Stefan Roese <sr@denx.de>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Alex Shumsky <alexthreed@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Joshua Watt <jpewhacker@gmail.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Jonas Jelonek <jelonek.jonas@gmail.com>,
 uboot-snps-arc@synopsys.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [PATCH v1 2/6] doc: update meminfo with arch specific information
Message-ID: <20250205172215.GX1233568@bill-the-cat>
References: <20250205071714.635518-1-ilias.apalodimas@linaro.org>
 <20250205071714.635518-3-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NaVyxgBi9i/VLuuW"
Content-Disposition: inline
In-Reply-To: <20250205071714.635518-3-ilias.apalodimas@linaro.org>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Wed, 05 Feb 2025 22:31:05 +0100
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


--NaVyxgBi9i/VLuuW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 05, 2025 at 09:16:46AM +0200, Ilias Apalodimas wrote:

> Since we added support in meminfo to dump live page tables, describe
> the only working architecture for now (aarch64) and add links to public
> documentation for further reading.
>=20
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Generally looks good, a small change however please:

[snip]
> @@ -26,8 +27,9 @@ The layout of memory is set up before relocation, withi=
n the init sequence in
>  ending with the stack. This results in the maximum possible amount of me=
mory
>  being left free for image-loading.
> =20
> -The meminfo command writes the DRAM size, then the rest of its outputs i=
n 5
> -columns:
> +The meminfo command writes the DRAM size. If the architecture supports it
> +(currently only aarch64) dumps the page table entries and then the rest =
of
> +its outputs in 5 columns:

How about:
If the architecture also supports it, page table entries will be shown
next. Finally the rest of the outputs are printed in 5 columns:

This will make sure that when the next architecture adds support the
documentation doesn't need to be updated here (and the temptation to
list every arch that does this will be resisted). Thanks!

--=20
Tom

--NaVyxgBi9i/VLuuW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmejnjwACgkQFHw5/5Y0
tyysBgv+KOgXMTJFc8ObEcGOyiX38SfjBxu4SUgE5e3jrCH9K19BxEwh5Lsp8lhG
jMVioYUVkOurCjKIUwAEKoIfzwgZ9Vzd7pZkAJnReUgpPs+/+Lqo0PKsLVlaC1xc
4jwZPy4PBF+xKpLehr3A7XJhxwrVdMCbCCxOsxrAagso6b3UoeyBgz19drEX8HEQ
ROtUMy0fEmSbdgNupyy0LYg2Bf+iQML6/vcZZpATDUvaNE+qTE5hsQCtFb10xetY
ywtWYjQxhdvus/VKkXeGMXkbSzqWDjkbFy7cc4hATWW3QFxnFijrBYcqqAm5JbgC
6ILo7WTrXS8KL8xQawR0XLtQ24nImOQlpisuqed2PCQWUiCOTdCj4L7thFPpj0KY
Onxnb8ys4vUuRoNM41Krc2guLwtOVbMz2B4EAqQUMBvh2WQuO7Uvm0i5v0NRn+B7
cD6Tiwt1DpdpKHQOE0w9uZs7PX7uR6rBZJWxAVZyw6gVrjsM87Fy8FMvnr7+LaSe
iu3Md6sr
=I9dE
-----END PGP SIGNATURE-----

--NaVyxgBi9i/VLuuW--
