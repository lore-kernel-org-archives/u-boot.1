Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D817CD26D99
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 20:52:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA43B843D4;
	Fri,  9 Jan 2026 21:52:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GCJGlxlB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BC1E843DC; Fri,  9 Jan 2026 21:52:54 +0100 (CET)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F122843AD
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 21:52:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-65ec86c5e70so2710486eaf.3
 for <u-boot@lists.denx.de>; Fri, 09 Jan 2026 12:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767991971; x=1768596771; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3kaiHM6uGWkjjY1/mrxfjBASfnnjpTrNjzrgv/O47Us=;
 b=GCJGlxlBbCfkqDhdvItKoM2X2zwWCH3KK4alyYrc1WFcq4i1qyI4yjznfFUOspHxfv
 h8zYwa2TLpsPv7+Cp9ZAdgYAPr+Ll1oAvqvF75lSKgFdOoQA4C696iXNTeZuIZxkGRJd
 s04L8BWgsnZjitEjDoFjWAP3HGDJCBekYVOLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767991971; x=1768596771;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3kaiHM6uGWkjjY1/mrxfjBASfnnjpTrNjzrgv/O47Us=;
 b=ZQcUuz5hn7dNZ/Jx4IZVSDK8rXKQjwdNAaAiSQDPKPm7XZi66M7HETSczccTPYA/PE
 ikRPKPHLxUX65V7U76XgCaVNual7wqYpvXC1uoSzSAdGPXojWsGlJTA7UEEWJe8jet6U
 Hg0vIAZ2rTOgTh967ZIrPuw+6IoLs4loik6LM5rJhiNLxCv1fJvLvGWZQQCky+A7BxW6
 mlkL+Fsngj6pXiuAxZ3KBy5dpHQQT5XcvTs80egAWz8JgrfYg/lC3uV6xgfFYvPXTJ+m
 mgszdNOz8PGAyWfVR+wrb2B+udyuiVtxpFjIFrLr2bZjIFt19YZtW3oMt6JZB8hGMi6K
 FOLg==
X-Gm-Message-State: AOJu0YxkTcwmaShLHQwowbhiS/Q2XPdvc9LnBxourCbb/XATEhDdzvYh
 HtSpNQEJZBM+c4pASKYKmBLedtglljXtHzxOePpasmIgagWV4omJ7P0K/PIVjG+lpac=
X-Gm-Gg: AY/fxX64ZvHJIIPy6wm2uXpOXDknrk4LGSONaUyZWG43xnY39jDZFH+joc5xaAfqTYL
 h0yOYmZbAQeIQPLfdDZo9FPUCtjx2NUJZIEU+spM779I+G08AeKeQSjhOx4of+HPbzrMo09J2t+
 D9dNo0zJ7gy0shK/z0zDSCxqYzJ2WZOtmTaCEuIicmiK3xn6V2MlGdwTc02zMdCyJ7zAfhn/4lb
 TSJvNbs2GTl7j1r+czE8Qp9yrFoP5IK3u/SD+ElEdXNxCSYUkgMHiOhKUfe2U64DW8+mq14rf1s
 Gixm2XKnfNJJjtSQ9JVOt2vU7TUqTgqGz3oV+z/qLRh60crwgkmYScd/Gg5RH+LZXH6V3Nqy7yQ
 OqbylwQ1GjTps2z3H1Hi8bvuMZQ14yZDRlYC304iAO4AqZYv1j0BcZmoKnWqq/0jp6Qy8JMxNXE
 DNbV0LT+ukeA6GaDSXY21OZ7YM65LCWERu3N5bHVcARTa+GICYxlU6altZaxnRbw7CW0ut81d8+
 Zx+uxbOHvzdw62QG785JXKNLvUZ+B+fSkHMrKpvJIVeolzu4A==
X-Google-Smtp-Source: AGHT+IHVxDA7j5cPgtWiFOAUEdk5kihPxMIhenKNS2gqJoSvwg8GwkbbMqqUoszoHA5pJ4qZ4+WMuw==
X-Received: by 2002:a05:6820:200c:b0:65e:f0f9:aa5f with SMTP id
 006d021491bc7-65f5507b22cmr5485410eaf.68.1767991970713; 
 Fri, 09 Jan 2026 12:52:50 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65f48bbbc44sm4466585eaf.3.2026.01.09.12.52.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jan 2026 12:52:50 -0800 (PST)
Date: Fri, 9 Jan 2026 14:52:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Dmitrii Sharshakov <d3dx12.xx@gmail.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>
Subject: Re: [PATCH] elf: error out if pyelftools could not be found
Message-ID: <20260109205248.GL3416603@bill-the-cat>
References: <20260109-pyelftools-warning-v1-1-1a4965609b55@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ai+i1oBWYuOjAX0L"
Content-Disposition: inline
In-Reply-To: <20260109-pyelftools-warning-v1-1-1a4965609b55@gmail.com>
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


--ai+i1oBWYuOjAX0L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 09, 2026 at 09:26:04PM +0100, Dmitrii Sharshakov wrote:

> It is not possible to validate an ELF file without pyelftools, make the
> error more clear and informative to the user:
>=20
> > binman: Python: No module named 'elftools'
>=20
> rather than:
>=20
> > binman: name 'ELFError' is not defined
>=20
> Signed-off-by: Dmitrii Sharshakov <d3dx12.xx@gmail.com>
> ---
> Make the error more informative and indicative of environment issue and
> not a code one
> ---
>  tools/binman/elf.py | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/tools/binman/elf.py b/tools/binman/elf.py
> index 6ac960e0419..899c84ad36d 100644
> --- a/tools/binman/elf.py
> +++ b/tools/binman/elf.py
> @@ -570,6 +570,8 @@ def is_valid(data):
>      Returns:
>          bool: True if a valid Elf file, False if not
>      """
> +    if not ELF_TOOLS:
> +        raise ValueError("Python: No module named 'elftools'")
>      try:
>          DecodeElf(data, 0)
>          return True
>=20

In that this is the common way the file checks for elftools, this is
fine. But please re-word the commit message to be more akin to
commit 43176ed86d9f120efb3e86084d83a714bf076d29
Author: Lukas Funke <lukas.funke@weidmueller.com>
Date:   Tue Jul 18 13:53:09 2023 +0200

    binman: elf: Check for ELF_TOOLS availability and remove extra semicolon
   =20
    Check if elf tools are available when running DecodeElf(). Also
    remove superfuous semicolon at line ending.
   =20
    Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
    Reviewed-by: Simon Glass <sjg@chromium.org>
    Revert part of patch to make binman test pass
    Signed-off-by: Simon Glass <sjg@chromium.org>

Thanks.

--=20
Tom

--ai+i1oBWYuOjAX0L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaWFqnAAKCRAr4qD1Cr/k
CuDcAQCl2RXQQEWkKYaI7S4xouwLJBnuJcQ/XgfCdI6IuCalCgEA4VapRLoycCeX
bHbZsOhOyfPmiSdPub1+9ZhBK94Xogo=
=CAiw
-----END PGP SIGNATURE-----

--ai+i1oBWYuOjAX0L--
