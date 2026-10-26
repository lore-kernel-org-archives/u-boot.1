Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2341606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 16:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=f0Fb7/sB;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=MLVtIF9i
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B37F640704;
	Mon, 26 Oct 2026 16:14:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GDYy08pBGvBQ; Mon, 26 Oct 2026 16:14:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C6F49406C3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793031267;
	b=c9lsM9ZSR1QSBg/771zLQxi1H/S2y0Q8Y6BDT5N6/o2Rzgei9xI+EVwEVjNhRUO9Yu1a
	 XZUPwFNfboPx1eBbSeyEXd1/l4zvIYe4zi7AvrKDxq4oCyS2rPBFVFcpXfThMp4iENA4X
	 3oFSyIIxeycpewf3WRg7PnSBriPNPZRk+CL8d4ryy3Z6/jlTqFvXKnagS8lEMa7+woXNH
	 a/FQZ/5n7186sg+BdqxFYsa3tq7UVDAlVag15LL42mEfmGB2HzbwmvjlRWepotWhiUfRR
	 G8pYjEkv7IdCnuhnRHoJPXBUWJkDAc6xnXjSDBYLA4bi+hA5DSIIDELmUnBQzbaljjQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793031267;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=4X3fD1Xy0MJq6Ei5gSk/Nqw74Qto6BIOFY0jwMNCSmI=;
	b=kTlBEbszDj1mS5Py2/JDo3QpxjPkA/MV9baW6crIuZID1NFFCatesPYonFN43gBSvi8z
	 qE6BrKXs1gCCuuaQ6tlECsG4O6bIru40EFjkxzF9KhIP7nhlHKM6znT+vD1uVfaAuFZNP
	 KbQElM5npDb8m17EwOnO3RH8b/AxI4WZ1obKgaxO/TYZS+z1mYJkakazM9kVk7488sIP6
	 a78eNQCnuPM8QgwQOGfNo/qqICgu48SPQIYFQ/ddusxZWOWut4ydSUeufhcNiigp5nJ7B
	 W/KBKmluNA5NGt1xIE8lvUAG034NR70dOo8vEWX5I+QbGcbCUBBXKFRy34I/M10DY4w==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=MLVtIF9i;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793031266;
	bh=4X3fD1Xy0MJq6Ei5gSk/Nqw74Qto6BIOFY0jwMNCSmI=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=f0Fb7/sB+DUvCbhIMa1+sX/Mi81kJ0SozNyp8K6PUZOyNvlnBBaxS2m5A38iwsn8U
	 FwftfYn5MbeS+V4/FcibYCH1T18qOiujFQcZKlfIyYUoGRIT0iu9xu9W6vx3ofaLH9
	 WE8JgWsICANNBd3Dt6GwwPzAUzHpB5aSGFXl8rIEH5WS2emaDJX3HPBnlZAJ1Ntk3Z
	 npH9iaf3iFg6CSIST1tIE3p8q6zC/53F66bGZskcY/bGA/LCHu3Z+PixplhaWNOzAU
	 bDGMQPc+CEzNoq8TesLEVJBRAW4944N/BY68myaqHKUq89lrq8QBiV6MLc54XBp/eU
	 txp70COc5/d8Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C6F49406C3;
	Mon, 26 Oct 2026 16:14:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A8D9D2F5
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:14:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8E44E406D7
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:14:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nKPkX0o7zssq for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 16:14:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 93C63405A6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::102b"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793031264;
 b=NAVUIc+XHTz/luf/YyBulBxJRDMe41WMFFUfK0rBr+VwQMKGQBJCJgT9/lTWthhVGu8Z
 dtQZmSBUdiZaULTGxZws+fSGvBXYpRUcASPfAbawgKb55x22EYdEK1EXFx5PUZSl/Ckfq
 OfMaGSKTQIo77Yi8mnNaOXL2y34r30t++3tRPj4APJIkCOKBmyDt3TRSpbZPpAZ4KTAwJ
 ptvXboc2dkNleMEfykoSlcnCF2S/nWCA0yzBsvavc+Qg2w1SG5ca6foxTr/CTeUMpx8ct
 rcjQJ3elH0HRWGlxy3+8kRBusyzZI0Z/ayBg+dQZ9/VQAFVcrv28Qz9+1RlB+/YxNKQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793031264;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=4X3fD1Xy0MJq6Ei5gSk/Nqw74Qto6BIOFY0jwMNCSmI=;
 b=Fk14MVe8eBlMvxGI5AcJtrO5w25RIPJzi0NJ2hfdG1c3ITYuUleQtgcfdcYO/DW71a7B
 bnar55Pf5nW8ptpdt4XFCPGX/9BO3HwdnfjMvcnkfVH2bCW4XQXG8WBH5CLQQ/01mpf7r
 XYPdaa1ZPQEh3YXBnkFSbBVVtXKzknvTrv95ULvvx98sMyPuQJT7eA/2n8IBQcYUi/BnT
 yMdgxz1lpUC050eGZH4kcyleoBA6V+Qg5jOi3mbUPfNWC42B3Osn+5NlAEh1zej4A8WAn
 kj04TgRVyFU2NoW1gPfUHhJR/yfzWadtBlsIm1Cwyhe65xQRfkaYvIpNOBr4aQrwWLg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=MLVtIF9i; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::102b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=MLVtIF9i
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 93C63405A6
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:14:22 +0000 (UTC)
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-3ace1f3897cso1666992a91.0
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:14:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793031262; cv=none;
 d=google.com; s=arc-20260327;
 b=mrQL+g0gWrT/vDJWNSgKvUhD65JTPUcpC8WEQBJRZBe10aCreZypcsNtYSM1D7ziyC
 w6Uo5eXRYuREca64HT+fv3h0kp971ETLRS+1zWjS91IBpI0mCzA90UIt5yZ8cXk929It
 YzbeQNvV5fzTQYbO6x9mewxRZe/B9Ce2zI6R+KfL4y/aTapZILYhSK+G2jpUxL6bJggT
 hMfBA5qRUsaf9tx/Lyd7lEyVQmQ+GaKE6ZUVS9pWsiIIEE59PJA+XeEB+C5xljxtKE3K
 6ESypoLwy1DS34hg1JlbCmbBvO+9WBsOQ/ClbpBA5lrJK20wrNl81mcz6S46aHIvuly1
 wVrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=4X3fD1Xy0MJq6Ei5gSk/Nqw74Qto6BIOFY0jwMNCSmI=;
 fh=w9Ta6e6IxL2RIAn+g0BgirO0Um8SelF/7OsBxsfUm8A=;
 b=Dnb8Q47eqqkzCf+taGBAfM3EQAYN+I1oDO/8POqAvx3Vk0dP3gzgNHPtvJ1ekATS5I
 Hh7akT2BUyhG1iOCznJ/+s1fyLiLMzN6w/h2mhbaEVetSIWS+/duvBg30maUIYYdURXm
 ZcxGkfYLYxYKuYec7a0h4QErkydKW6fF+LUsLuV1l3yx3qFw8oiNfgSxAtOE0szoYglx
 KPpDefNWucIUIqFNy5MGRUmaR3OhZbkJLf5NcDDWbZbon5l3Ao3Ah7MMH8LPlnRn+WbC
 JmVI0EhlxZ/lY8qLupfr16kqS2mAa2VqFTdVg1fXy8fQAzBHgjH6pcCXAmdCoHwLj5ZA
 0AHw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793031262; x=1793636062;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4X3fD1Xy0MJq6Ei5gSk/Nqw74Qto6BIOFY0jwMNCSmI=;
 b=MLVtIF9ijPsqgs09mc4cwJJ+9dwl2r706EX2DrAKfKRKX0bIbLVpkWwAGHWQk5RcEn
 R49jto0ofkUvq+pNdmGp/eBR1cOWRZMQfCunGygPd6gTaUbYQ9hCbxQE38SQbpPFWwWj
 dlVctmKjAev9TzilGIElyeKi4PZHZlp/UMO7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793031262; x=1793636062;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=4X3fD1Xy0MJq6Ei5gSk/Nqw74Qto6BIOFY0jwMNCSmI=;
 b=s7OkB4r4SWbalVi6noWJCEd+MT0q1u6wmueanmRVgkzShehzydiUAYDOPoW5Ji+gFr
 PwMihTlyXqf+1LHl7sM/BJ3zV5/g6obQcDNDH3t7VPCOpuYq3yzsXzwyJTF1+7d++KQD
 AbOYckMxbAg/mSOc1D7J3SHa2+MNGZ2MrOxGyQZH3t8RF7RIHdexckYpXqwJVMdla5AP
 1VGZNM5/05bHeHuHNeRxvaHFLhMEWXqqHGXcP6XST5KBfipWcnjwIzh7/u/dFnIeAaNS
 tnogs1y7Ui1y9XFfixh3aNGroDkzOj7GssD4Yip1dtDKakvfneiOIcu1/sCd2hXW/vM4
 XI1A==
X-Gm-Message-State: AFq9FYJetWxfmn34E8beQ4Y+QxgUJRNHJVxn9r1Vnlyn1cBkieM77nIV
 3PVGHLwrjANurtApvLYsY1xFQDAzbzF6W5rsbCQsds/ECugXRgYSTz3aseVHzvizmcQSsForbWT
 yy1CMxshouSj9I6+xIcU/keNKAWYueoO/YBX6iP0thaOk3QZPmtzYvg==
X-Gm-Gg: AYBFou3Qc0B+aZ47WQIZq5b4Pv8E5adpNE+6Qj8Pq/KW8DJZO0DmHFHHyTYeLrdflhU
 W3Ws4pwBhfhtotJ2PIGQw3Oc5J64iFPDl9wVJMKb3R20/t5JmjDLfe13REINgcUhnf0pedUcyyL
 oB0ioniw86/d9C6hqn8tF/sJE9AMqf84blxVHjypr+lTJ+9EZoLTTPVS5MeuuKtYkWEt9566IAN
 4JWsqJjv0avlJSZNUx5FqTidEwFuaA4IkKEg5mQalEEU0qT8SXpgmUsXL1qHO8EZVSIPRNwLjTH
 /73QFokcCAUsAQEdG8CW0yMPOhUa109oHNb5KguI2YIys9+hurjrBg53qr0uwdx5BXbGsRadLHV
 QYoixPE/vVkXc9i7V9wsnWx6aeOeftV6VPelakiHfJqWM7jOagkgD1YVA
X-Received: by 2002:a17:90b:1fce:b0:3ab:2d17:51c5 with SMTP id
 98e67ed59e1d1-3ade9a35fb0mr6266413a91.6.1793031261696; Mon, 26 Oct 2026
 09:14:21 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 09:14:17 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 08:51:44 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1f06dcba8237a74da16903141924fb0f96b3b265.1793020986.git.hyyoxhk@163.com>
References: <cover.1793020986.git.hyyoxhk@163.com>
 <1f06dcba8237a74da16903141924fb0f96b3b265.1793020986.git.hyyoxhk@163.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 26 Oct 2026 09:14:17 -0700
X-Gm-Features: AclHuK-u54NYlalfeQ0SFiQzxQqPGIqomr-xviqzkABWn5gLS6KjUYfvHykLYTc
Message-ID: <CAFLszTgZaaYgMFeHdxNrXo8z07SpzJcrrB-ybPjmi2QpVCbwyQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] test: bootstd: Cover scripts in raw partitions on
 sandbox
To: hyyoxhk@163.com
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>
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
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi He,

On 2026-10-26T14:02:15, He Yong <hyyoxhk@163.com> wrote:
> test: bootstd: Cover scripts in raw partitions on sandbox
>
> Enable script_raw for sandbox and add a GPT disk with valid legacy and
> FIT scripts, as well as malformed and unsupported images. Bind the
> bootmeth inside the new C test so existing bootmeth lists and bootflow
> tests, including bootflow scan -G coverage, remain unchanged.
>
> Introduce test/py/img/ as a package for disk-image generators. Existing
> C-test image setup lives in test/py/tests/test_ut.py; keep the raw-script
> case definitions and image generation in the new module and call it
> from the existing test_ut_dm_init_bootstd() initialization.
>
> Allow fs_helper.setup_image() to accept an sfdisk partition specification
> and reuse it for the named GPT partitions. This avoids a dependency on
> sgdisk or a separate initialization test. Annotate each expected C error
> with its Python case name to keep the two lists in sync.

The fs_helper change affects every caller of setup_image(), since it
switches from printf | sfdisk to run(). Please can you put it in its
own patch, before this one?

>
> Signed-off-by: He Yong <hyyoxhk@163.com>
>
>  arch/sandbox/dts/test.dts  |  8 ++++
>  configs/sandbox_defconfig  |  1 +
>  test/boot/bootflow.c       | 81 ++++++++++++++++++++++++++++++++++++++
>  test/py/img/__init__.py    |  2 +
>  test/py/img/script_raw.py  | 98 ++++++++++++++++++++++++++++++++++++++++++++++
>  test/py/tests/fs_helper.py | 19 +++++----
>  test/py/tests/test_ut.py   |  3 ++
>  7 files changed, 205 insertions(+), 7 deletions(-)

> diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
> @@ -1948,4 +1949,84 @@ static int bootdev_hunt_fallthrough(struct unit_test_state *uts)
> +		0,		/* legacy */
> +		0,		/* fit */
> +		-EINVAL,	/* external */
> +		-EINVAL,	/* bad_crc */
> +		-E2BIG,		/* too_large */
> +		-ENOENT,	/* wrong_name */
> +		-ENOEXEC,	/* empty */
> +		-EINVAL,	/* bad_header */
> +		-E2BIG,		/* partition_size */
> +		-EINVAL,	/* bad_fit */

The raw bootmeth turns every image_locate_script() failure into
-EINVAL, so the external, bad_crc and bad_fit cases cannot tell which
check rejected the image. For example, if the external-data check in
patch 1 were dropped, the external case would still get -EINVAL from
somewhere else. Since the test already uses UTF_CONSOLE, it would be
worth checking the message for each case too, e.g. 'External FIT
script data is not supported' and 'Bad FIT image format'.

> diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
> @@ -1948,4 +1949,84 @@ static int bootdev_hunt_fallthrough(struct unit_test_state *uts)
> +		bootflow_free(&bflow);
> +	}
> +
> +	return 0;

Please can you check that the scan ends after the last partition (i.e.
bootflow_scan_next() returns -ENODEV)? Otherwise an unexpected extra
bootflow would go unnoticed.

> diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
> @@ -1948,4 +1949,84 @@ static int bootdev_hunt_fallthrough(struct unit_test_state *uts)
> +	ut_assertok(prep_mmc_bootdev(uts, "mmc12", false, &old_order));
> +	ut_assertok(bootstd_get_priv(&std));
> +	std->bootdev_order = order;

prep_mmc_bootdev() also binds the script bootmeth and sets its own
order {'mmc2', 'mmc1', 'mmc12'}, and you then override both straight
away. It would be clearer to bind mmc12 directly with lists_bind_fdt()
and set the order once, as bootflow_bls_prefix() and bootflow_rauc()
do.

> diff --git a/test/py/img/script_raw.py b/test/py/img/script_raw.py
> @@ -0,0 +1,98 @@
> +    if case == 'bad_crc':
> +        data[-1] ^= 1
> +    elif case == 'too_large':
> +        struct.pack_into('>I', data, 12, 2 * 1024 * 1024)
> +    elif case == 'empty':
> +        data = bytearray(512)
> +    if case == 'too_large':
> +        struct.pack_into('>I', data, 4, 0)
> +        struct.pack_into('>I', data, 4, zlib.crc32(data[:64]))
> +    return data

The corruption is split between script_image() and
setup_script_raw_image() for no obvious reason, and the header-CRC
fix-up is repeated in both. Please can you put all the per-case
changes in one place, with the CRC fix-up in a small helper? For
'empty' it would also be simpler to return early, before running
mkimage.

Regards,
Simon
