Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FB7606A31C
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 08:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wSN0l3Nw;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=lBfLK7Xe
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7BEAE40B36;
	Sat, 31 Oct 2026 08:43:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KP16B7Ipd0KA; Sat, 31 Oct 2026 08:43:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 74CA740B0F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793436217;
	b=sYF6Q4YZgyytSeoPWNWfhNFAZqWHmjLvEF5LTRW/hEKqN9Ef5/IJU4C9IeTK4BLN9yt9
	 h+ESgFb85EPQlasEAhtU1wy0IgljVe3xot9z2oRop6NEjAK6LWr2VjGYx75EB/xSBId83
	 yzKGyyZ510mEHsCyq5hSwg4eaUvTo1bVkR7ybIL8b/roFmJO9ICM5jRFtr4HZWDwS4xq4
	 Dllb776w6Xc8C3ZcAD0nhsrWdaCAURndH0t/qn0zoS8weFka2rLlY8KRUuvX7vcqXJGLt
	 SunAM4pzwiv1lrZqSH1gctX40zWgsAHgT8PhC4VcCqsX5qBKXB9mtNcqM8wnA8cBQIQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793436217;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=ArjruHeveNbVFJnqO379eSRo5vuFR26GLbkuRKZ2c/M=;
	b=GNYUt/6H+Oa09WB4IdMyKMxbCDyTb+6Lk09QB14gdppfe5QzkqH2VAS2JAAQ1QqmuIkr
	 URQCmhEX0LuWZKPoD7TV9j5TyVayBEQRLfH+SMrrcCSG3E4cOo5BTskgWgnEretM4YwFM
	 xfrdz9zHIgblMnGi+WfXXxjfNImOGtY/VgVDI52o8vFezMh0mqFw4NKxoUOdekYQfZpkN
	 ZQ0IWrgim3VYZDUx6uuLAVdkJPexeEtqr3rpqjTkOI81XnR7gHqP0jfAUOmTv0riZ/vsh
	 JOUTgy/QmsXgWnpeZLXHDkVVqb6JgWd1FOf/+jXoxC7sG3g5zChTvGjf2w6VyjNGPyw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793436217;
	bh=ArjruHeveNbVFJnqO379eSRo5vuFR26GLbkuRKZ2c/M=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wSN0l3NwDhVbabvmrcDCszrqB2s1wSIQRRR7UrDWKjJYmyWqodkDOyWrrc3Xb7MvS
	 VvndtASGVxfew3eMn+asCcsItRZuVz5pmmIs/s/oqqAls2lZABV6agC7dW5DZ+Wxvx
	 nbyNzI+KsL5U5YG32gzX17MoZ5j2up5tnz8e/Qb1Apue4RG1zZ+hPeIImVKUptCMRk
	 jEA71HYJDcTv6vs+WRtY540QpUPVSLPZtZSUILy2ktxEgmOXYW3rPcuOvcSpNRUw9w
	 4uIcu4fZsxUBBbtJXl/H5RICp9fgdAsxhIdhaWMhlieP2yMxLWhU+CkHoQFrrFx5Sc
	 2evBoem+3kIMQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 74CA740B0F;
	Sat, 31 Oct 2026 08:43:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A62B0380
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:43:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8896E606A9
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:43:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mU35T5VyWQqo for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 08:43:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9B53D60AE5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::102f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793436214;
 b=QdKjohZnHGtU4qeh3CXck/gYnk4+enZ6PXa+CpuZbcWr5jIOK/CqHpNwnaS7/o7zoObM
 pcmt+oGFVVeGYeJVkg/ofdFdjV3BSzmqjAT8HZq8Egh9Zbtu4XSLbiBjyXCB7oO/94ZW/
 035KtvycVZAarkuzWS/TXVC3BPvSeK5qegGSid+uVjfmH68SqkmyXRN9oo1Rvgnq6FeNb
 zY77RcrslaXGMIgmF+v7Zg0uc2qPIFTXXEe/q24yCln6+qBjmXcsxDkLzVLeTGJJM6gDd
 VSVfQSsOW1Xi4i9bDx2JWwkDNSMD5dXDOQ9w3h5kMj2grKpPTnz9xnwKoAScfTvgX6w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793436214;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=ArjruHeveNbVFJnqO379eSRo5vuFR26GLbkuRKZ2c/M=;
 b=aFZZcxLkbnOvhiwZmuI2we9v0E+Kj3bJ1SiskVq8TJ6vFI1FmemHF6h04uxVDNKrhZjZ
 ZgbVoXOVmHsBk/iEYHfu1leCjUKnlcZqWvJS+sUCbSoJV2PfcZzDgf4iaxlwW2huR5XFf
 5w1iaSZGqvxoK4Traks1GHc+EpoBNq5/Vlq+quAEwuumvTyMJEyB/XtuqNZ8Yu6BytKny
 olok5HD1QGref6F0YytdIx92+Wt6/Pt+NR7zu2XDkm2pyIiut6J5ppWB3Dr6hz8z4I6/S
 9EXyyQBU/Agy2SDxJwbAAio9FUZwWyaU9H/NOyi+iT3giFZyczLb+BzZuh7QFvvzVVg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=lBfLK7Xe; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::102f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=lBfLK7Xe
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9B53D60AE5
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:43:34 +0000 (UTC)
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-3ae1d0caaedso680447a91.2
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 01:43:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793436213; cv=none;
 d=google.com; s=arc-20260327;
 b=shwcQgdlUT9w11MEotVEWTOAVlSfRFcQ8r6CDFOcXLGsMl+V9OGyMBb44b434KG0So
 axT0R570SzIwEyxOwRlcfEd7qIRTcR/PRyr6Klo+h+pSh0TQeSSHZCflIkXQ8gH4R5wD
 BFvaA1n5cW0U1URKtlTmlOobaguJ1pmqKFeSpknTkXfdgWYvAi+ZeudPNEKiZrJth6QU
 caTsp7MOSJMAfJPmycRYwqHg43Q5RaEc22NjUCBsDLTP3ndltTK9LKBRYA10colsWHnY
 nSi98spEiFPLBdE1Wh5w6rBMcebXqh+VGnEPf4jtb2P9w2zAOAVE2if4K+Nkek5LKA+I
 mIxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=ArjruHeveNbVFJnqO379eSRo5vuFR26GLbkuRKZ2c/M=;
 fh=2pjFINk/YJdN1O8+BmxUqT0f8Pzz062q1LMXvlrjUv0=;
 b=PuKJmk+e8UAFHd7zlYVSw54o/TlQvFPToWIgJVAjka0oNypb4/7TVOvZwrpmxysi+D
 VAXWGV89h2u3VLM000DaZikFLCahs74Rmy40l8xYajBSiXyjy3XohoCnrZYjFtfapK5c
 hfPZbJGM/tUyWn2qgJYar8UGMkylw84rZZKL1V1CAufZoV3o3x5ELReNiChD4k5NSDiv
 zb6pkpQeUGE160cgs9SZuVsjTs7w/vMsD9eWus2AGT/Zl4xNMxnbsplFoSK+hVgNTMdw
 dkq0PiTt7TI8DF0VnZCwQL1ZPNuVZULpxFA5G71nR5VbaILKNKCuGTEKRTZMad7phu9B
 naEw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793436213; x=1794041013;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ArjruHeveNbVFJnqO379eSRo5vuFR26GLbkuRKZ2c/M=;
 b=lBfLK7XesWhtb9xVRXMB1VLBGBIUhqcmZ6uC+C1JxspxDINj6c4zKrrqBLBI9f6FpF
 Ba89tIxLuKNekIbkN0pZsiRPl4lXZZ4R/uwV2lfVG1uIhSZAdIyVHfd8bQftwVQTEtV4
 ntI7cTxgIm5SSKoluhE05LsQfrjZ/XnYZ1qrk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793436213; x=1794041013;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ArjruHeveNbVFJnqO379eSRo5vuFR26GLbkuRKZ2c/M=;
 b=0tzbSjD6OnoDOkcYdsMV7wak5ToQ8yePrPZPFvAc48r+6D0rtdPgfZDi/epz3Z1CUX
 SnPlQKPfbTjf1HjkOr38hLZzf8CQOLir8a6NL1HdWbPBq1/xcMYouzwl9pA0+ZQIa6IK
 tb6wic916dM1kQEh89vqcbQEI3upHtYYjcfobBEYZ+bgqN6FpmyjQepWrv8hGMklqYWj
 7rxCEXhmf1pWOXzPzQsw87owcPyPuldZlAgMxUDHIs2KPZZRGWxEmYy2o9RL852Myw8M
 DL10aBR8cNbtP+l1Rl6kVWsuYDseg4MbnPQ/zByMENx2hFqCmcmggxnI8dynUWmNdm42
 aW1Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzWh4GnVfEu3t8llNYl4hMlSmBh3mXzgzThbV520iidGs86vJkbGvzQUSXqpVA8vBSIZXEe/pU=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIlaDAMuzvZg+bTX01XzfJq9a19E/nON6eoEDFxuSC8zNegekZj
 x/sKa0vvPUVq/MD5HaV1BErcbya3uvPPDFWCnz08FL8n9TAm7OuK54ZXvjBWZk7LhXDo+R7By+J
 7nhZJ8zOEuJPakZTpy6pVGaBEw5qfy5xXjxK74nD3
X-Gm-Gg: AYBFou2l09BIdjCQ8QLfief6P9km3HLjhEHrzSQklAJMLZKPMUJQwMMv4/YiKkSKv6E
 nYwoq258DMMnagu2/bNgnTMfDblIUQ3uQ6sPtQXLrlWM8kQOyel3lXnPeemze9Ufxa0peiGtaVr
 E0jJqvUC+9buJ7hFMHM2zeOOqelgbeYEj+KU0zrUvpqIshrVfODpQ9XNYdtz91eiVNQx0akGqoR
 GJG1ZSCB+1XI2fq8RFuWgSCyI/4gANUOWXCNb+PKXchU59TZdepgd5/tFenAuZaTzvIy/SO7FgN
 rwpbjIAWngl40wy7sZXL6ols7RiHVzeEdJk6Uj00aGkfgApwxXwjfjvhzxTWqvKuhUuy+lzmN5/
 OdQIuGm87Kw1JgSEs2b6/T5941WaMlrmlcyBRRC9Gzfa4DW6Wko6juFizkdkJSBOGysooxvEgC0
 uZbXNzUiNMzSqqOWAb
X-Received: by 2002:a17:90b:4a4a:b0:3ac:8446:c1a5 with SMTP id
 98e67ed59e1d1-3ae897d313cmr3533382a91.48.1793436213429; Sat, 31 Oct 2026
 01:43:33 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 01:43:27 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 01:42:08 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261029050738.1107663-11-me@ziyao.cc>
References: <20261029050738.1107663-1-me@ziyao.cc>
 <20261029050738.1107663-11-me@ziyao.cc>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 01:43:27 -0700
X-Gm-Features: AclHuK_pqnj9glL4L-JsQ8k7P4K43IgSSFMeXPRSEsCPDpR8loUtkDSoUTE_BRo
Message-ID: <CAFLszTgZyC1yDgCtH_VzCS0ZvEG3kw81fx_xns8L=6w7m9OEaw@mail.gmail.com>
Subject: Re: [PATCH v6 10/20] LoongArch: Boot Image bits
To: me@ziyao.cc
Cc: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jiaxun,

On 2026-10-29T05:07:18+11:00, Yao Zi <me@ziyao.cc> wrote:
> LoongArch: Boot Image bits
>
> Implement loading and booting functions for LoongArch
> standard kernel image as per spec.
>
> LoongArch kernel do expect us to fake a efi systemtable
> for passing fdt to kernel, we don't need to implement any
> EFI functions for kernel because it won't look into anything
> beside devicetree from that table if we tell kernel we are
> not efi compatible by setting a0 boot argument to zero.
>
> Link: https://docs.kernel.org/arch/loongarch/booting.html
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Signed-off-by: Yao Zi <me@ziyao.cc>
>
>  arch/loongarch/lib/Makefile |   2 +
>  arch/loongarch/lib/bootm.c  | 129 ++++++++++++++++++++++++++++++++++++++++++++
>  arch/loongarch/lib/image.c  |  77 ++++++++++++++++++++++++++
>  boot/Kconfig                |   1 +
>  cmd/Kconfig                 |   2 +-
>  5 files changed, 210 insertions(+), 1 deletion(-)

> diff --git a/arch/loongarch/lib/bootm.c b/arch/loongarch/lib/bootm.c
> @@ -0,0 +1,129 @@
> +	systab->hdr.crc32 = crc32(0, (const unsigned char *)systab,
> +				  systab->hdr.headersize);
> +
> +	cfgtab[0].guid = efi_guid_fdt;
> +	cfgtab[0].table = images->ft_addr;
> +
> +	gd->bd->bi_boot_params = (ulong)systab;

The CRC is still calculated before cfgtab[0] is filled in, so please
move it after that. Also please use map_to_sysmem(systab) for
bi_boot_params rather than a plain cast.

> diff --git a/arch/loongarch/lib/image.c b/arch/loongarch/lib/image.c
> @@ -0,0 +1,77 @@
> +	uint32_t	code0;			/* Executable code */
> +	uint32_t	code1;			/* Executable code */
> +	uint64_t	kernel_entry;		/* Kernel entry point */

Please can you use u32/u64 for these members?

In any case:
Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
