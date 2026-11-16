Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D57606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 21:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=CT+1tE32;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=bThSKY5I
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B5F1F40766;
	Mon, 16 Nov 2026 21:56:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ipm-7SRbiZMT; Mon, 16 Nov 2026 21:56:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F2DD74075D
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794866211;
	b=sTSA8S4waZjErMybmP8eo0E3mXM++5N4vcAfkNfRTH1T67Ysa3Qwvp6V+RF46LuDl5DK
	 u9q7ncp5m1sjiI34/a+C4nJkMSjuOO8RT0p/izp3nsV107QXD0cmkSrgzEDM0hr+6taj6
	 bjQwEY+rD7zJoHfqgrjYFBVWZ5GfLpiFkInPncV2FeoCYD/xVx6yvdTUca77rqw45F9DT
	 Lz57Nvn0lHSwvr3Goi++vAA0Op6BTFFBvpc88uGXX56oOVgGK1px9gKC6XF9e8D/wFTmE
	 m5sDnST2/4+VqkIF3u75MNt9hi8B3lKWOxNT8oC/2IR42rD0fhkAPKuQSFaCXo2IsBA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794866211;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Subject:Message-ID:MIME-Version:
	 Content-Type:Content-Disposition:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=fj+LUP/P3ZRMBvMQBNSe81/wbiVm3nfcJoOnUiBczgc=;
	b=SoIKXblwhrITrVURgbqSVCVnX0rX330ZneC81HNN4GO/oxDG/J35cSSKFpFjdEI36hjq
	 NWb/AFkKGPpdDkCalCjWK2SMfnRlZAhpoFz9600djmZD3ML9ClWd5mXMqv89p0radlrgw
	 nXVYWGyxZwwa4Du9bv1s7V7ZELqr+WlMa6ellJuS6Ntc4CPCSu1IEvj7O89v6TvoXxa4m
	 yU2qoht+3ysh5Z0zF3sZKh+V01tmYPCNSaEga9NYsqTmI/lwMdoauC1gGojw5FesK8q64
	 sL0ZbhS6l5gN+jAeDZWQkfQ0k7ug4ToDiHCrIVh3EOM0rnekvzD9tkB1EdouuBHjL2g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794866211;
	bh=fj+LUP/P3ZRMBvMQBNSe81/wbiVm3nfcJoOnUiBczgc=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=CT+1tE32SrMdbwIgUMQemrhAK0+PRlyFjuTbegPMcnFsklThO9RK/jX2+cKd8TAQM
	 NEyx/DZruBJbwasNDlNKkvuQJfqcZWLbPJqK3m2Ep0sTU6HukxXGxYO+QzsH3kPfrS
	 0M3dLAbxFawlE+M79Yt7n+Br548K/HjcbWkUY60muTlhZlR4vxt10Z7ZiTkCUNeBnD
	 6zEsCqkruICo85f8PzDd26Wouey7nm1s2DULZzii+wa2hMTnlSYZwwZOm+sLuJGVDM
	 GP4lenepHy55rOIW+2x+sHmoCDhRC+yZDfBNZ6TUOGx6ARXdEVeIYnimpQouCjdt4P
	 8lAomhmK6phYA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F2DD74075D;
	Mon, 16 Nov 2026 21:56:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id F389770B
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 21:56:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D23348101A
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 21:56:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Jv9y4dbC-DNe for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 21:56:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1B7D780FAF
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c35"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c35; helo=mail-oo1-xc35.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=bThSKY5I
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1B7D780FAF
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 21:56:47 +0000 (UTC)
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-71ac9e15640so2013364eaf.3
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 13:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794866206; x=1795471006;
 darn=lists.u-boot-project.org; 
 h=content-disposition:content-type:mime-version:message-id:subject:to
 :from:date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fj+LUP/P3ZRMBvMQBNSe81/wbiVm3nfcJoOnUiBczgc=;
 b=bThSKY5I8ddfSxtKq2ZTF6zANIARR27h4zohk1t8FiwcHu027whYBswg7Stfg3dUGk
 juVBzqFkM36+ChIn0RTxi6dnWH+ebPvCPz0h+cxqid2Pvvb3eA7YGfTJWldHXVqiTOvL
 FJS/BACaVNDaWsDD9fafrcOPoGtiQXuBwiw5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794866206; x=1795471006;
 h=content-disposition:content-type:mime-version:message-id:subject:to
 :from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fj+LUP/P3ZRMBvMQBNSe81/wbiVm3nfcJoOnUiBczgc=;
 b=DXbIL9QZKFG+i/F39td0o0gwGGEdk+MTyZFpUHkPKZ/aMioaP/98gGCmhpfE6Favfk
 CkL7owOZrzuNJc7suvd57tt36oAQf0wtut5gIDo9w9za+7lU4XaRAkFGDs6HdTd95HFh
 JL/Hw6IT2qodvkcOkDwvsqDls+z2ixvATdJhP3sBMR9MTfNDr8vfNpxQBu211gKq+glr
 eWHYZtrXe8UyDXjPEvlYRdWbceE0pKQto8AAcbohnfi+dhpyx4iJPzRcqx+wcgMHrp18
 vyLItdfnaWGt10PUkAZm+zVyTgrON1sl+Y04N77saQrJv2SDl4lakud6WmIkKTs1rzma
 gYSQ==
X-Gm-Message-State: APuU4Z+jIrJU6rDd01cbvqiHVpgEl81IhrUXI8cbsGsDWScne3oSE4Hm
 vhKRvyqofxpNdU1SN4GN+Hm2/NQ3lhRVshxHXOf1G6mDINkUz0WwnYZOxWwy8a7F9qkdhptJX2j
 mC1WYcy2nUA==
X-Gm-Gg: AYBFou2WwrA5+vAR2FqLOznu/QwEQUeeP8w7bxYIUfwIqZscwLLyVE9cf210kMMWHVP
 qQa4nxV62aPJf+oUEcJmdGwezzoy4mE49C7OMoY2J4XGyZ7M1mrP/mHOeuzJ40F4zmpJXuP2OEH
 E30kgE9jsHUbpQK9NzJTgKTV+sDgew9vVm9nRF9AHM2t9xzCSzJLQrydaH2sfS8WJJMHKAqN4gC
 oYK7UbML2/5OlS/tuqr+/1erABrlkxhUNep1wWaesHMYnaGh8mu21GrSGfhKXabo5Cbkzdq5xll
 qAYRdHsjoXNVsnvdKF76mKXqSevbBDcIIi9vECMcq9IuH6UoDuBY345XEJthMyo06Dmj9j94kCr
 tJfhy4U+ryRDzwTiFO44cvLGb45UWWGif60Nb1lfduetiepeg5xKHI8d8WneuMALd4/VVGi3MOe
 h0XBVdZePYNoxbUj+OP/6esRxQF26DvFno+sk0mXzN7I/tKtKUkOWhGF4dirr7TG2hxegeC47Ce
 bH8ke+xmudVoDtNtHV9llPONXy0W+fdrd6CXt+4HCEnvn42VHMakOFabCrm8R5+Qx05uEwTy8FF
 cEJcBzCm60iH0XoVtspvvKRlolXgOmfH/NHKXWhUUphZPOz8KFQMPFO/7tf/pTwpRuT1mPXL7EU
 xHd2AgGOFOkjeu88uKBVZYpd23RxWbgXLCg9WKvwVwYC1Bz1d9eKQPV729IAjwt0G1ac2tW20TB
 M6tYPUhWqINNgWHipBt4BoDdUL+uU6fIw=
X-Received: by 2002:a05:6820:16ac:b0:71a:ee95:bfc3 with SMTP id
 006d021491bc7-71aee95c2f3mr3230993eaf.40.1794866206503; 
 Mon, 16 Nov 2026 13:56:46 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-862c67db8basm4035570a34.13.2026.11.16.13.56.45
 for <u-boot@lists.u-boot-project.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 13:56:45 -0800 (PST)
Date: Mon, 16 Nov 2026 15:56:44 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Subject: [sjg@chromium.org: Re: [PATCH] binman: Fix SPDX licence tag in
 lib/binman.c and include/binman.h]
Message-ID: <20261116215644.GM554944@bill-the-cat>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QSkbZsYhX0mESnf4"
Content-Disposition: inline
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--QSkbZsYhX0mESnf4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

----- Forwarded message from Simon Glass <sjg@chromium.org> -----

Date: Mon, 16 Nov 2026 09:29:33 -0700
=46rom: Simon Glass <sjg@chromium.org>
To: Dale Wilcox <wilcox101@gmail.com>
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com
Subject: Re: [PATCH] binman: Fix SPDX licence tag in lib/binman.c and inclu=
de/binman.h

On Mon, 16 Nov 2026 at 07:50, Dale Wilcox <wilcox101@gmail.com> wrote:
>
> Both files have carried "SPDX-License-Identifier: Intel" since they were
> added (between v2020.01 and v2020.04), although their headers say
> "Copyright 2019 Google LLC, Written by Simon Glass" and the rest of binman
> is GPL-2.0+. "Intel" is not an SPDX list identifier and has no text in
> Licenses/; it looks like a copy-paste slip. Simon agreed on the list that
> the tag is a mistake and offered to ack a fix, so use GPL-2.0+, matching
> the rest of binman.

With the signoff fix (it looks good below only because I am sending in
plain-text mode):

Reviewed-by: Simon Glass <sjg@chromium.org>

>
> This patch was prepared with an AI assistant (Claude).
>
> Signed-off-by: Dale Wilcox <wilcox101@gmail.com>
> ---
> include/binman.h | 2 +-
> lib/binman.c | 2 +-
> 2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/binman.h b/include/binman.h
> index 62a522ea..dd370f15 100644
> --- a/include/binman.h
> +++ b/include/binman.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: Intel */
> +/* SPDX-License-Identifier: GPL-2.0+ */
> /*
> * Access to binman information at runtime
> *
> diff --git a/lib/binman.c b/lib/binman.c
> index a594fe4c..589dfd5e 100644
> --- a/lib/binman.c
> +++ b/lib/binman.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: Intel
> +// SPDX-License-Identifier: GPL-2.0+
> /*
> * Access to binman information at runtime
> *
> --
> 2.43.0

----- End forwarded message -----

--=20
Tom

--QSkbZsYhX0mESnf4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCavt8GAAKCRAr4qD1Cr/k
Cn5dAP97vghPpEPM9d5S5WJNeqU7YYtJ0ajY/kfyLgbHJgLqpAEAhi94j0i9u7Uk
8GWjzmHOE6lSQzbD4q8StIGGUi1XDA4=
=PXiO
-----END PGP SIGNATURE-----

--QSkbZsYhX0mESnf4--
