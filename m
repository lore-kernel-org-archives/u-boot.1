Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394C4606A320
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 19:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=eh0UcwR8;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=pkQaWkS4
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D27D880C7E;
	Sat, 21 Nov 2026 19:58:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T9QL9i-rjap9; Sat, 21 Nov 2026 19:58:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1ADA680C6E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795291103;
	b=HnWrCgLpjAdzJtYLJLlLbBwunaddalHhCMyQKYle4+/lsLPcVhSiexlgRYcfQZEdHZmT
	 HmcZMS41SBxV8+g8ps0FSWqeiYT7OyUsA+VwYKKTL0qWhQvAYr2RHls2nT7eQPTd+i8nG
	 aQXZbN1a6hhkUzu9U35fe+Lu+ZhqCMjPvEqOCGzXgUWi8Y1MyhBkUcuIg4oFs3o9R6yGQ
	 M7hQ3FhmUhl/+bD3gVLQWCBfEVh1qu6ZfipmELOKe0Pi8J6eiytKXWFgWCqGHoOo72T5c
	 URoNpxDPxQGM4N0k8CkWMQ2uR/yr+hj9fNJhSvZImgnXzC+r7UvCvF9n6yxNHwEquMQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795291103;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=BqVskXQ8U+bH8sAwD8UGoToSxdCiGyakmEx7G+E1inE=;
	b=R0T5KV93zms+nx79QtkjNLfhcY1Ue4z0DzxU2YLoYsLxSwJ1pI2hne8w+ET8yqJu5H/E
	 75Mr0sABbZ/Zj8BR+c/utO+Z/UIrGcNmYA4hTQTiCpwVjBC4legkISu1nFrIqayXVzGCy
	 yl/bpFtr7Xq/juXkNrJmVSxKCbnZiiXlauWdYymZuAjfNfYwNhCyj/B2kqenvzaW9dC9C
	 jwjpqUMkqYSh71kcyWtHB1vQOFIPLlJEB3vLKe5/2HmE5ybjVI/K/xFPz2gZigkJsxzUm
	 I9zKtN/K6rofE4wEJ4xDrB4ZbqjxegOWrzwKoawdXC7o/U+zouzzvt4RoZ4gV10+Dzg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=pkQaWkS4;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795291103;
	bh=BqVskXQ8U+bH8sAwD8UGoToSxdCiGyakmEx7G+E1inE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eh0UcwR8Z6oIz/fuC/1mp46VAdlUumLgvurth4w/sV6u5k5LeKm6duApA9bEVbuAE
	 gJTIJoMoGxdy/zVGTCUL8rdB5uL/EEd76mWpjbiEZo9qDYoKBEUzdGA6F+La46Hofs
	 S93VngfAM7llnC+A1XazV2F4Fjc+Mi/5pUveNfE2kFjfdvciihgxs/+8Zn37yN7Dfd
	 e9RmloRJkajcL9bglC7tqhuLMWDbtII1YdK6k8BC26zH/GqPYBAOPp84wTrBrcnhiu
	 1mCZDS18vYV9kamV0UmlpcOoCkhaByNUf0nSOsjBu8ZH93de3yyncBKZcuqdY3TeIz
	 3lTZ/9FsdXqDA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1ADA680C6E;
	Sat, 21 Nov 2026 19:58:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7ECD715D
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 19:58:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6389C80C6E
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 19:58:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QCXOEz0ADHdl for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 19:58:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9D55E80C67
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::35"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::35; helo=mail-oa1-x35.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=pkQaWkS4
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9D55E80C67
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 19:58:20 +0000 (UTC)
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-4ad89c49e0dso677559fac.2
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 11:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795291099; x=1795895899;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BqVskXQ8U+bH8sAwD8UGoToSxdCiGyakmEx7G+E1inE=;
 b=pkQaWkS4z9Rqe1xI5Y2lc1CUnGFoQ9YbM1SRXs1zax2BK5Fg28+yJ6jCJ7gsw7BqIT
 KWG6IHdMysSnxkH6/rpWC6LaBQR66dxO3czbLs2X7zE9sgrX5FHrhGaLwrT21adAqC+x
 gXpGmbLSSxvDlSQo1XGT4wc15tY9lFcDYErK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795291099; x=1795895899;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BqVskXQ8U+bH8sAwD8UGoToSxdCiGyakmEx7G+E1inE=;
 b=C9HwpKo/6JNBLGCmACDghxkpodq14ueJe/+Z2HdYbasB3i8lxt3igUiZnBKaTTQJie
 iFDdvMnQZrZVlrMZ82gKSUjBnIIqNJaa4pbF+Cy43nw8U/XPC28cHsGcKxhm5iJmiwV2
 UbFFQulSCeBoKmSkQkMIJHssGmfRDYUpNoItXwYFi7m7S4+Rk32E0qpbZd29pBTjqWro
 1s0t2jqscBLnyKd6vxAo6sCt9Iq6ragWjYl9B2pyoJbG6drtWatcjmruHQ3DBhOWCw7o
 3k/1BDGDoH9+Jr88GHq8w+ORpupu0m1zs0Al5oey3iKGe/61N/1eyw3G/Bt/Pel1OmRo
 9O6g==
X-Gm-Message-State: APuU4Z85LZWyAhbIiG3xmBh5PHSZXYAydRBXocZnPuNgQHYOE2H59YTb
 x7PJwogDezMXqImnzUA4yhI48N469nAQi4GbTjIYZ9jLkPe7QCvAT21QpixN31wx/Ho=
X-Gm-Gg: AZFdTZfhr9XjehaMaP4ojS403T3xZKbQNDSjldxcQ783zpt1/lDSftw3fzc7sY3ftRa
 VP2kxuV91Ie/KlK/mNlsq59fZ1T+wH1zBF+F2J5F36bCfvhxblQ8237vDz49NZwuasZMkAwd56q
 zzH6JxY6SqVGV75+rS7uFxuji75oA99/+2kizlNR2WPqyJBKHtw07EKyi+yVUejiTIpQi2mw7YV
 G/QiMpmSLXsIeKjSr9ykeZxdsiXJ4schmuNszH+bA6LcZuK75EWuTDaGKzN4t+lnfBKJ5tbZFg/
 lvemUPYPIyTMXNuVCx6v+cRg/gQQZt8GZfY5M54TOR1fCgc512uWZ80vgsY7XVvyLQXevZpmS0y
 091ge3BkEolPewGghKM0V35MZJdtYyzEhmdEfteTdkAyIyXbj8myRQoQhHJcX0vdyW57jpBB8eR
 VvOCx71T8n5EaJDARjqpZFGpJahuXxnCSc6H3PXTe4rBICP2pr5PD334jaPGl0uUy3GwM20+Ehw
 EC6pu63d88shDN3I+O9+X1SLl9fvniMELI7RuW0rDf954b3AExcOxT07S3gNwup4PtQ34KWkvIs
 TfPj/3M5PopJvxY4stUOiKe5SBfv5TMSkOhU92uN2bak+UbHsQhXGNRYGY5njt8AmNQrDwMAmfU
 eOIFps3/km2mIlKoYzP2sjTFqexmjK9LO/caYgSjrKUHTf1jNL5YHpgtITf3j0SZ/r7uTKrihz8
 Hr+0tH00NniXsAfQLRGJg0HdERnlu/i7Wzfr81YV/BMbqtKC1nWPRr
X-Received: by 2002:a05:6870:c0cd:b0:4b3:fa20:cafe with SMTP id
 586e51a60fabf-4bc84d1d4d9mr6944724fac.48.1795291099594; 
 Sat, 21 Nov 2026 11:58:19 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4bc5b07d57csm6292033fac.1.2026.11.21.11.58.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 11:58:18 -0800 (PST)
Date: Sat, 21 Nov 2026 13:58:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] Makefile: Move PLATFORM_LIBS outside the the
 whole-archive region
Message-ID: <20261121195816.GI3176972@bill-the-cat>
References: <20261121092137.2797011-1-pbrobinson@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1nE63MpIPsfJNwZw"
Content-Disposition: inline
In-Reply-To: <20261121092137.2797011-1-pbrobinson@gmail.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--1nE63MpIPsfJNwZw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 21, 2026 at 09:21:33AM +0000, Peter Robinson wrote:

> The LTO link passes $(PLATFORM_LIBS) (-lgcc) inside the --whole-archive
> region, forcing every libgcc.a member to be linked. On AArch64 this pulls
> in members needing libc symbols U-Boot lacks (__getauxval, abort, stderr),
> so the link fails, e.g. on p3450-0000. Place $(PLATFORM_LIBS) after
> --no-whole-archive, as the non-LTO link already does.
>=20
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Makefile b/Makefile
> index 840d02aa6ca..4323d5ec701 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2103,8 +2103,8 @@ quiet_cmd_u-boot__ ?=3D LTO     $@
>  		-Wl,--whole-archive						\
>  			$(u-boot-main)						\
>  			$(u-boot-keep-syms-lto)					\
> -			$(PLATFORM_LIBS)					\
>  		-Wl,--no-whole-archive						\
> +		$(PLATFORM_LIBS)						\
>  		-Wl,-Map,u-boot.map;						\
>  		$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
>  else

Is this still an issue on the next branch after Josef Schlehofer's
series? I'm wondering if the --gc-sections change there fixes this too,
or not. Thanks.

--=20
Tom

--1nE63MpIPsfJNwZw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCawH30QAKCRAr4qD1Cr/k
CvnyAP9eYfJOuZkEf3j+JepySdSpaWDsuo9poZ672zdTgxMntgEAjHRMgj+GoeJd
47Je+i5mKAumHsS3+g2nvZBn9+TUOAQ=
=S1vd
-----END PGP SIGNATURE-----

--1nE63MpIPsfJNwZw--
