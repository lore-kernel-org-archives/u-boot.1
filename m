Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61869CD5BC8
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 14:03:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B81F684866;
	Tue, 26 May 2026 16:03:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Wvx+m8fD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2194A8486D; Tue, 26 May 2026 16:03:22 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEAF284702
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 16:03:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7dcd689829eso8788868a34.3
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 07:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779804198; x=1780408998; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=p++aG5nu5Z29Y7My9VvX/8JZ3yPYQ0jshRYVR6g+WHo=;
 b=Wvx+m8fDD2qlLb6BkB6GbybZKyxsqmU4QgjQnXknKBmr9rRyPdLYBtBzzI8d3lEVFb
 FulH7xVcXqyYGC5U22STOpD13zbh+GrvGypv0JXV6bREJ9foJvGP1BuyRfVylqDykTRk
 CgX6EGQIlTPb5R796U5SZNbL8AgcbUfwdjLy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779804198; x=1780408998;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p++aG5nu5Z29Y7My9VvX/8JZ3yPYQ0jshRYVR6g+WHo=;
 b=Ne+4qYU8/hLpi46GrRB55XXo7cnsxh1DKaMumc/yFVy3jZERTzJotGv83PS1OvhOWP
 HgA8JRXYkN8iLpiboFPbILqQa6JEkt/tybSnwI2FjcB1HVMdLy15p3LMaPp4QtEN5BEN
 A+PK6Jyaf+f9cQIIvHvW2NbQQFd+sgnazeJ0JPF1P7+bmyfuQEsbSIEujmAoUkTRqNXq
 RcjJ4XWaXSKy9qA6kB5ZkVVAN0zm2AIvfsctIm/6566n9/GvP63VMLtb1ErZ3tp6BOTx
 nwRkOF4dWNYSSy50YDX1jYmYPpca5cWAWK7wO9IXm8I7UOZnl0fUC36eUQkjwsn7BAsY
 Z44A==
X-Gm-Message-State: AOJu0Yxr3pky5f0VhyaeLLSckF+TlDRrtebitDChMxfL+72+/C5uvpUF
 /NKGQUmoif4iK5U9J2e9Ib1VqVZi2vW/XMGI9iLqTh36xixnaItshor2HlLpcJ7j4dk=
X-Gm-Gg: Acq92OGoHHhlJ4O4ITXjVnvxvVZAEebdstfp456OrS9ltbdJnYuuxe7REG0QylJxavL
 y3DJ9hp60Xks7CbJKWF8vliZxrLfWyK+qe4EEzZv7RU1FfpHRAlBIlIOO11JYZAbYU4n0fRPTKw
 Q5DG3McfPNPYZIWV+YLuZEXA1p4UDXS5qf2f+HSjjcaehriB+PJMEpXZwDwJxDm4aqzPD0LflMd
 2rv4+tDjkfUA5n3c7bgcTUwPtjo8aC/9eSFnVW8p9cumRdxx0DqzH4LVBcg8vbt+C9wQYORnLyl
 IXXqYyZflb/qNVrlVJcxsdk7cYfFGyShJqMGR+jgh/DsYrP4poJoAz7NmAo1a5aXqlmKpNRyGjS
 uHZb70bIOUbcXqwkxq4MnotHqT5H63/+SQoewwDf8CnYhznLefXyzYaH2JKHeCURzrSiRsDymnL
 A6OZaJzqhjCHvZRvWOY1Q7N75oBycS//muvl7wevHzC3C7g3fuX/QeooenWbPGFcJFb+n9UdL7A
 sI=
X-Received: by 2002:a05:6820:290d:b0:69d:900f:4263 with SMTP id
 006d021491bc7-69d900f427emr8302127eaf.16.1779804198071; 
 Tue, 26 May 2026 07:03:18 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69d83709124sm6535671eaf.5.2026.05.26.07.03.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:03:16 -0700 (PDT)
Date: Tue, 26 May 2026 08:03:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 0/1] armv8: reduce core errata dispatch work
Message-ID: <20260526140313.GR1858239@bill-the-cat>
References: <20260524123822.7244-1-josh2@disroot.org>
 <c67720e2-bb73-43ab-9d75-851ef1f4afaf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Ga12fJ5eaDN4nGwv"
Content-Disposition: inline
In-Reply-To: <c67720e2-bb73-43ab-9d75-851ef1f4afaf@kernel.org>
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


--Ga12fJ5eaDN4nGwv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 08:01:16AM +0200, Krzysztof Kozlowski wrote:
> On 24/05/2026 14:38, Josh Law wrote:
> > Hey folks,
> >=20
> > apply_core_errata() runs during early ARMv8 CPU entry, before
> > lowlevel_init(). Today it still checks the Cortex-A53 and Cortex-A57
> > paths even when the build has no matching core erratum enabled.
> >=20
> > This patch leaves that dispatch code out unless one of the supported
> > errata is enabled. For the A57 errata case, it reads MIDR_EL1 once and
> > reuses the extracted CPU part number.
> >=20
> > The erratum register writes stay behind the same CPU checks as before.
> > For qemu_arm64_defconfig, where none of these errata are enabled,
> > apply_core_errata() goes from 15 dispatch instructions to a single ret.
> > For ls2080aqds_qspi_defconfig, which keeps the A57 path, the dispatch
> > side goes from 33 instructions to 26. A KVM microbench of the same
> > dispatch sequences showed 1.30x for the no errata case and 1.09x for
> > the A57 miss case.
> >=20
> > Josh Law (1):
> >   armv8: reduce core errata dispatch work
>=20
> That's another identity from Josh Law, since all previous got NAKed, and
> 100% AI generated code without review and without tests (I don't believe
> what was claimed above).
>=20
> I recommend ignoring and here is some background:
>=20
> https://lore.kernel.org/all/cbd0aafa-bd45-4f4d-a2dd-440473657dba@lucifer.=
local/

Well crap. Thanks for the link! I've moved all of the submissions to
Deferred in patchwork.

--=20
Tom

--Ga12fJ5eaDN4nGwv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCahWoHQAKCRAr4qD1Cr/k
CqoIAQCKQN7W5U5mdy3WP9yybiCkCPLb/M6qIVb8Bmja4wuUnAD+MP5Ybj2zGEqp
xris1+hOco/3FKkTVX4iHvGBQH3+cAo=
=Ef5j
-----END PGP SIGNATURE-----

--Ga12fJ5eaDN4nGwv--
