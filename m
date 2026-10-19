Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFFB606A319
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 21:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0vUrQHzl;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=e8pjRIhz
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E0BB760756;
	Mon, 19 Oct 2026 21:03:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hyhoyOY6DlFe; Mon, 19 Oct 2026 21:03:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 01CFB60747
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792443792;
	b=ib7CavQXgHd51LnlOWdrzFuUB4u5v3Q1cOUsKLcGY0wv/YUjw+HYqWoI77BD41WniC5R
	 h01ee2ixOPnvKv0CW6bYDXc2dQzYNH6aGePZl/rYG1nF6LNudtC7/jcXq2Zj/Ltn/9jmw
	 Ul5sm9pw6qwODS9GqYRqhru0+81Ia/jH2+GvebyG4F+e6zuuX/aLwQrr3YHXz+LTPWxaC
	 JhvKZ36Ms8JvksHMd0o7Bp0o8IMb6t/IeAlMv9cIaDlGVGNuapiZJdmbyG+ZNFVJJ1c/u
	 7JGHEDfFyrgoplhMP/bvcRrmEHjdscx/3bDslYc7iDeTNKM0DXD8QzZh8yRdwD9Mejw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792443792;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=I0sn6c9ojo6jd6UkBk6atKIcJqwDTnrlItsYSAYmdC0=;
	b=jalPFUl+XZzoedaqNAORHnrRQ/jpD7hdx/yE4dXfSCboeEAkONnKZoGvH6ENLddg3XU+
	 wuAiFIdAZHbO5wsIpsV3wxjhSueF92qI2gHqmzAqqJtiejmt/yGr+lAVM4KBiHDm9GzLg
	 x170c+P8ERMSuDixtZApVCV1ncKIyhMEVQpo1Zno3n0xxWS3WWL/gdJ5ZIY0o/6vDUpZl
	 3SxiLYiDflHbqxuQBAvEm7wZFuA3pZ239em/J9RjN8+fTrztrRRqdIOwOha2f12Sm5WPO
	 hd94pnohg/mGC0QFBbmGZOomkbUZZrcnZAf2EmoRx0NbjAtmLczvnOi22yNQ8ayU9sA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792443792;
	bh=I0sn6c9ojo6jd6UkBk6atKIcJqwDTnrlItsYSAYmdC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0vUrQHzlm7ZT5M2dEeE+LGEjykJBHfIjoASErzr2FA26Iu0wNDbhHAUlL7MpPBrzs
	 HVTKoy6mVdpnYqzxdvpv4pDrcrRLLLK2JCYpdM22okoKZYS4L711TvQcmthiL5zcZX
	 v3CriY3SJu6dZIsO3d4V5eEWQyJkyhgipvL0yvjmxPMezHGmbe4MsQHQr0gNjq4+T6
	 0u21bZPpOxgSogQ8IoU7qAZpacfmWczF7NQDLuUAOzdGNBeFB8JQp6MzgAqDXl6i66
	 ddRduh34JOPpChaK7vuGDvurl4Ztu70Z2G7aS7jeDDJ+0tlHrG7el8BBiOeqJJkzoU
	 91N+NGf/LQhWQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 01CFB60747;
	Mon, 19 Oct 2026 21:03:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id EEAB81AB
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 21:03:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EC40C4009D
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 21:03:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xNEaGxx8aAWN for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 21:03:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0733E4008C
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::7"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792443790;
 b=kTOmpGGLOrMBinsUvkWtqCil7/1g3aS7wOHzwonzKW+rs6tIRjdFqI9oNNGI1ALgtDXE
 Q1/lHIERg5iO9amP9ycKpQik6kXoFFcgKh6HmJlMoG2zwDFRmvslGMw/UmUVhmiBuBPWd
 ImSZMvu7cAyjVhUJnoCUIk3Xp4HuNenVWi6kEsfJTTYY4tGk9/nQKbnUo87JVW+o1eMpx
 uiiehwau9g7xUMDp0XuOe6ajURGGGzO6nF2553g1iWSrlkBJmWUP7RnccKTip51L3W4Ym
 79r58mXw15ZLhvf8y7shkJu/yn+RTavsCZroZViUFPMjbWNpgaSu9W4Tzg9865Klk3g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792443790;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=I0sn6c9ojo6jd6UkBk6atKIcJqwDTnrlItsYSAYmdC0=;
 b=S/65Ys4zDTuw9/zGg/GElu92TR1J854qEbTKXxbLAHq6Rdl0f1f0xWa0+hkGx2MFe92C
 LvgwAvUpIZFjr6eEbOM3QcZ6bxShj1LtlLCSBE/4ANXT7f1vUJ+e5wppyBpe0utN1986v
 1+mTcoel8a4Z4BKhQCIixXvSjSi04JKaQltaiadX2JoQFzYWebxKIEOzeoR1mf/MSwR9/
 /cBP8e2nud97CYRDhzwvI+muaXVyHNPxMaqhVYFhjAt+qngnktnHZxr3cvaZRga6x1L2F
 E6C4o7qELXiCynHJT1w+Z6QC2Wv0a+wVdh22AWLTmJR/+KDpKnMrxPNFQc2DA4BZWzg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=e8pjRIhz; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::7"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::7;
 helo=mail-oi2-x07.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=e8pjRIhz
Received: from mail-oi2-x07.google.com (mail-oi2-x07.google.com
 [IPv6:2607:f8b0:4864:32::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0733E4008C
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 21:03:09 +0000 (UTC)
Received: by mail-oi2-x07.google.com with SMTP id
 5614622812f47-4f47feb5a15so298493b6e.1
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 14:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792443788; x=1793048588;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=I0sn6c9ojo6jd6UkBk6atKIcJqwDTnrlItsYSAYmdC0=;
 b=e8pjRIhzzvnBLD09fOQqXJcm00g7psEsr/KK3zGE+NuhM1g/86bqnkb9+lb9bkO6CU
 JAHjp/G0Jf2ArTl+CtQY/wUR75PWsh1dW2s+9BTq3TgU2ZX6h4D4p6IJmVJ16JyLTu/q
 8nh22JKdgRzQEIF1HIaG8AG/pm0BBUQxrxdn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792443788; x=1793048588;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=I0sn6c9ojo6jd6UkBk6atKIcJqwDTnrlItsYSAYmdC0=;
 b=1F2B9RV3e6HiGudwXLX8DGbkgTs1TXMLrXxmwtZFBok580pW3GWxwImerz3mK9/6YJ
 K7zZ9+i4WsR1RNR9s4ed2ABRWBoAyV3m9bFQ+7O17Vg50gxCCoAoeH6JxBWexHjU7kTb
 Y2y98GXkSqt8KX9WB5axdZbBnZ3HXW2znyr6x2jVxi1qLgEfkDvTrH2VWNM9YqTqsy8N
 dXhkwDD6KGgbceP6FutZLxBPrPPdKp1aF1gbO4LVvi43d9u+Wkr0GH1ztSFdf1NRkhZd
 mJezqcAs2lzschhfg5cELcY8q9rZREnPJhOuX5d9RIKbIayEpFz8EVPERxCOxL/E4I/R
 9JTw==
X-Gm-Message-State: AFq9FYJhmzBO+X31CcfQF64prUMJWfVytgXhHc914P8nnjejwZTT1VRl
 HSresdZcEhnqJ2+yI+duIRtFk3SbgGeQ3a6SnR6zgsA49VDBRlOSrqDcppTFc1U9rUc=
X-Gm-Gg: AYBFou0/m2nrCtzooxAvP0KZKh0kUMcSH3BbfDYl0Smj1SEFuFPrdmi4WqugYXX0RLI
 TNi29IcBLTvP+HxfiVClKgq0d4f635CfYxWTVUOSJybZaEK1rh8G4S+vsYs/xb5rtaaTx2sVwzL
 pH5ZAO4wdGYTb53zjXELGaOiTqSrogFexPV11WRmHGjvRCf1V3mUYBOaKOpLj13XCoiJrGY3KMA
 TtTy2pOAqW3QiWgtaGOTiP1kCcOnLy3JMCnphzJo+Vr/40tEGjxqUgL60GaHbWoG4CQvfwZuKg9
 UleQN+dnPOHpFMy1Egn80IbhMayjf/CXbdCpWhDcUUxrJVjqvc121EEI6JEcAvfpzf/cOjBJwSA
 OSU0O/d6OhuUj1R0MbHSePmzPW8d/yifnmOaV+s34HmL352eLZSXtrZe5BAmDv+6VfeyIEx7W7I
 07rfV6GiYEpFaeXDixtRXnA/UksclFLBNe+brSWeeY0zq3OG4xxr04XU85FCRBTYRM9R76hkwDD
 HiyiSHnbANetgkVn4oGOmQLzHpjxVJQiwQYs0LfLmuf/gHIkZVBxmfe2ABQwzAcJRm2s/gkM1lV
 npnoa5tB33PGQgaEaxmcxj+Ipgctbw==
X-Received: by 2002:a05:6808:4fe7:b0:510:3f21:164f with SMTP id
 5614622812f47-53ccf4e8655mr9105361b6e.31.1792443788136; 
 Mon, 19 Oct 2026 14:03:08 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-54c764d128csm718295b6e.2.2026.10.19.14.03.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 14:03:06 -0700 (PDT)
Date: Mon, 19 Oct 2026 15:03:04 -0600
From: Tom Rini <trini@konsulko.com>
To: Xiaoyi Suo <18102059357@163.com>
Cc: u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v3 0/5] lib: make the clearing stores in lib/ real
Message-ID: <20261019210304.GA770052@bill-the-cat>
References: <20261004152715.1574-1-18102059357@163.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eZFv5930WSjH2dLX"
Content-Disposition: inline
In-Reply-To: <20261004152715.1574-1-18102059357@163.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--eZFv5930WSjH2dLX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 04, 2026 at 11:27:09PM +0800, Xiaoyi Suo wrote:

> A few places in lib/ clear a buffer with memset() just before the buffer
> goes away. The store is dead by then, so the compiler drops it and
> whatever was there stays on the stack.
>=20
> Patch 1 imports memzero_explicit() from Linux, where it is a static inline
> in include/linux/string.h, and links to the upstream commit it comes from,
> so a later fix there can be picked up. Patches 2 to 5 use it, one function
> each.
>=20
> For sha1_hmac() the caller is the TPM 1.2 code, where the buffer holds a
> TPM key's usage auth. Getting it back needs something that reads the
> stack afterwards, so what this fixes is how long the secret lives, not a
> way to read it from outside.
>=20
> Tested with GCC 13.3.0 against main (211de43): each file compiled on its
> own with -fdump-tree-dse-details; the dead store pass removes the clears
> in all four files before the series and none of them after it. checkpatch
> is clean on the five patches.
>=20
> Changes in v3:
> - the import is its own patch and links to the upstream Linux commit
> - one patch per function instead of grouping them together
>=20
> Changes in v2:
> - use the Linux version of memzero_explicit(), a static inline in
>   include/linux/string.h, instead of adding a function to lib/string.c
> - shorter commit messages, function names instead of line numbers
>=20
> Xiaoyi Suo (5):
>   lib: add memzero_explicit() from Linux
>   lib: sha1: use memzero_explicit() for the HMAC key schedule
>   lib: sha256: use memzero_explicit() for the HMAC key schedule
>   lib: mbedtls: sha1: use memzero_explicit() for the HMAC key schedule
>   lib: sm3: use memzero_explicit() for the message schedule
>=20
>  include/linux/string.h | 21 +++++++++++++++++++++
>  lib/mbedtls/sha1.c     |  8 ++++----
>  lib/sha1.c             |  8 ++++----
>  lib/sha256.c           | 10 +++++-----
>  lib/sm3.c              |  4 ++--
>  5 files changed, 36 insertions(+), 15 deletions(-)

Please put this through CI, there are a large number of build failure
(qcom_qcs6490_rubikpi3 is but one example).
https://docs.u-boot-project.org/en/latest/develop/ci_testing.html

--=20
Tom

--eZFv5930WSjH2dLX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCataFgQAKCRAr4qD1Cr/k
Ch2xAQC3rG5DYB3d4alwkh0c9g2nmIX7kOQm6h7dI4xwzt/towD/Y0AshVMo1iyG
NA2T6aVMowr+7SwQRXqOXM1wcibgAwo=
=2d3b
-----END PGP SIGNATURE-----

--eZFv5930WSjH2dLX--
