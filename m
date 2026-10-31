Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91586606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 08:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UWsZjjD+;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=dHxrQvKP
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6790360AED;
	Sat, 31 Oct 2026 08:53:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VmODL0_JDxLA; Sat, 31 Oct 2026 08:53:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9ECF760895
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793436810;
	b=Qg8jb9KKybYAYBnh78xwhK4PLjL7n6X1RL7nKcFoCu9dSSDkcF0BTa4EH4vw6dQ03FO2
	 bN3NAFUFLEYNYsAlLxReywg5yFQ7tkafJgAa7/xzHxaq4M/LkoAXChU/rTdM7GiSeDtLa
	 DqdCOFlc0vCY7wrpTSvdlLBlLt3BN6LMFZzZ5EN234zNctsEO1CDYT+irStfr60rFajh9
	 3eduggw92cy/6kE1YGQX65p8Mr2e03jVOh4zZCjF24E7Ne+AKguiSue4f2t/la/dW6II3
	 lX32cZIRQhEqfLJWTX86U7ifxpkrr/7teVixzDDyYCmTqLy1k/9qpWNCBQvqoT3oc0A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793436810;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=8bvve5PhKs/aydpw7xckdhUFPEYR2daeZB128OaHUxM=;
	b=XPf0EqowdsxHuqM0ITdWHeie4Ie3Wj8wE/JDUbeyDF1W+Q73kiZhxs1qZouNC5wUru2t
	 nGS/ZLrMMuDQzvZ/hx4QwlJb8/CLgCWzRc6XeWlYpL7+xJ47aGUF4J0I+MGNQA1Erfkiu
	 do0bAR4X0jmOG5uBC9+pjYoFwcFCFpmG4RsgkqWCfmbD0B1xBxroAaiobYQHYwyeIKw4w
	 9FF4WAoD3YbQLYGViwz94c7rFddUT1s1k8tVtBhLLypSLn8+Ui7HGDRNq7/mY5a1rMra/
	 G6E9oqQjvLnWCr33yXfAwUhO1UykeTRemMXxncm7LUqPtB54XH4ZvfwrlXsslhqB7rw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793436810;
	bh=8bvve5PhKs/aydpw7xckdhUFPEYR2daeZB128OaHUxM=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UWsZjjD+bw6JF+YdVvvHm8fUSrfZpdJiniqWJOiaPAU4Ka+YboP+qgGC0dmY2kqOt
	 bxoKenO7eNp+1a+T8fCkF/GPOfGt0sFlnyTRUt5hQ7GstPLXdBRJ7/8EFSpV/ydqM0
	 m8ZOZ4uQbHy0DUrXrdKbGFELOAZK32FxX5D2WqKWU28uy9chvz2RgsYIsJXyEhraMQ
	 xc1J66H4QGPgVrZEGN9kQ8RQ7HykPLElmNdCdE8dTmJxtmRd0WxrJJZ8KdMFq+Hip5
	 OR2+LqvStscKjINxwsBnw/rshVzPNSmR5h16cZxy7SZbB54vyVVDGExa/zoI4ljzB1
	 IZENY+sTdeHxg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9ECF760895;
	Sat, 31 Oct 2026 08:53:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1F7824BC
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:53:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0565B400B4
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:53:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G_F2rfx8F2QU for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 08:53:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6322A40057
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::633"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793436804;
 b=hb91upd7X7cBBRmBcypirBe08dO9aFjnFaeYKYYXilaerVCzzdEPKCXlM3I/I/5XJCiZ
 hVZC/Z813upMrWnXvQTDdJ50YaipC4OL2XLa8CeS2qWChpZ9TtjmbCChEHzhUxlyZo3Vm
 GWFnW29eL7b5ee7NNy2FJHD40H5ld4uEp+Cep3uKe1H8SDBi6VAbWN9d5a1/2El/V2RXc
 EV+mk12lVdcawEostroH4U8Qv9Gztz0Jza1/2d9fyQxXraaBA1RofDOeviH7p4qv5GFYI
 6CTdqkRuL+0R71EC4UlFQWulXOLdhlZ7PzNsdsKtORg0Z0XoBUaSV4t3Y5qTk36k4Kw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793436804;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=8bvve5PhKs/aydpw7xckdhUFPEYR2daeZB128OaHUxM=;
 b=teHugZIuPTbMtNFVXw9z1jzg+isyHHpeXGQm6s0CdaFcDJBy4t9CamYq09Lmjiehaxq2
 KnJGDodLgu+eajfKIyLjfdLRx8jLJLZkVurbJgQfFFWAfqVU5/QhGn6onOkglwwJyTzxB
 HICs3PVFQAQ4sndIUooSaDHXtKq3MElzBKuRLhjLjn3qs1i99HSKJuEA6i/Cg0Z2Sx0eI
 efbvPGN9PWkM3Zg7+iYJrjFShNHt4luqlRP8mqZJj05QdxO83s2xlqh5sQwTr8DP4hY4D
 QDLAjThY0rs9Irj0UGeXbHK5JhRdVeo78+6enDRrmAgZLfqwuc4b0SbAzfJmN9+qKRg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=dHxrQvKP; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::633"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=dHxrQvKP
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6322A40057
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:53:23 +0000 (UTC)
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2e812e2b31bso9001875ad.3
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 01:53:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793436803; cv=none;
 d=google.com; s=arc-20260327;
 b=K/4FId/d5VQQLESRkpXmYx5TdGrAU+QPY5Gn24uK5112IZ66F7Pjse2yw5+j+G9CmE
 SjuYBJnytyy51endx6J6fwJTKRbh0BBA39vfI1EK8F2om5Osk1ZKvWWd/NgUhuYPRYoy
 hO5+VohUvZajgIKXzK+6dbKdr6aUlRW0/pcpT8N96dkFcdpiY9mWGGaIPzQEr712bOBt
 PHgWrGkl3P2IABxo2kwq9nVkq/ZoovPbJttioZ3oJUvhl9HDS/0bGJjs4IrfnwfAAQcv
 ifn8ge8O1+F73K6mlrD4jgP234w1nz9p/znZTUAYQRIsdhUrD7tCNXO8TucPENthJbpm
 R9JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=8bvve5PhKs/aydpw7xckdhUFPEYR2daeZB128OaHUxM=;
 fh=14V5QZ2qJWOmkUpIay8f5wLH4+hU5ubxJ+YNB0Krams=;
 b=MPk34HZZbcAs4szX0eQ8kSt1nfczjnA51AbdwnkVrvWrtI8OGphX9u1SZ7nE1SiX6w
 mshGNttEilSGfpyvuUub6nH0fVpXwJOUg7lRsCOpXu+/kZgnb2LWfR7B+ch+AfwhFdDr
 0ihJ/q+y7+vNiKJS5UMMdrWtfvkBH1E7z6H3h1wP1DWr/cEZrNeYlXkH9KVyFPkSRKg1
 YXyvJjdWRzDEzoeVf0pVGU1zhwYQCJ1N1gtuun6r1UNBGILp+GJZzVQ54g2HZgPrhAjE
 SP+yKDDfpu639QZHNb8I68itY+S7dimBNSU69Zcxmji6Neu6Yn8DCdXfRYA9mMfhu9BA
 RA9A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793436803; x=1794041603;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8bvve5PhKs/aydpw7xckdhUFPEYR2daeZB128OaHUxM=;
 b=dHxrQvKP9KTLbLbjTrxiNrTDfionamSOS0RJEJcGOjost7zdWXScDJhkNaigH6CR6o
 S46K6cr2yilnuxpG9LeNMOt9QsYTvLzC8heIve5pGGOqlF/w8JL5vo6QCWSPzH87RMmx
 E9yESH4yY10/q46v20sdiG0MhvfcwlvLnAGxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793436803; x=1794041603;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=8bvve5PhKs/aydpw7xckdhUFPEYR2daeZB128OaHUxM=;
 b=B6Ku5j42YmwhFrnN3M9EVerIIM5RcMu0HIKgbxaq+/I7zUvvithqYbcHWNp5Lb7/CH
 o8TpwpF/VZ83j9LA8dbJVlr0mBG99hhXE2su/96dt1wt9V/V3ksZsHzLPTtXSISGPp/e
 F6kWrx8mvEPCFdl+yiu4V+MqwY+o0uMgtDqzfJaDk51Yr1PR/BzF2lb3gYY5hXS0KFbV
 JQheegz/t2rdVYWQZUgV8YSEfdeEmhFiWLNAFZetaDDGQKyir7ajfbdALtnAuunZTezU
 A6PBeQ6JUY9pWBNcwl186VEQVA9K+sONJfDZUvxX1PdcL+6iMKO4wrgYVQ+vCbBJs41j
 LQ5w==
X-Gm-Message-State: AFq9FYJLLfrQiK2fx3mSwFLZS+ghdvzhgWJOXhkSp9Ml/TvYzjWkoccS
 DdVC+n/TiaQNtXIKI0yGITLnZYk6iCLiC2YVFaH5mbIOJsUqwtSG2XLEEPtdE3EJ4VM1sAO/cuv
 4iHEUhyPEmCxhySnykIH60D8ZeuuvowGZAkO1cZKM
X-Gm-Gg: AYBFou0DMEYjQka6N7RxkCPUOimc/IaYi4/8MzoDU2L5kZB7XpRuvL2JnfPCmfLewOg
 +9lJOqyqE8H9RZdz0z0BuBt/CTSA566Uxci/TvGLjUlWDlReoVqX4RVpjATacYsj4Z4v3KMG+eo
 fB1or6/y+8i166/IHoEIfWzWgWVrnjf+/v14e1IYJdsoSNWY456s16q33X7FlJDKj3td6DM4Zph
 3AdtnvFIqlzFnysguGkVNUV72fMBJI98HoIXNDgA+K5AbU8RysEf1G+vU+5PL0mAvh8NDj/pDuu
 mFglU4YGivUxLbLR4/BN+T7HWMIyA0te1x121JLHa19P7x6P2npd8hGlqH6BRabwWOW3cqNMNQQ
 ot69YYoY5SKidr0f0tp8VKe5zr6fTTlJXKdJl/ZJ6g4T2llUAWXupvRvBR/PzfsR5gCPcN6s=
X-Received: by 2002:a17:90b:1845:b0:3a5:133:ca5f with SMTP id
 98e67ed59e1d1-3ae89787ea2mr3257796a91.46.1793436803388; Sat, 31 Oct 2026
 01:53:23 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 01:53:19 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 03:46:44 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261028103102.414657-2-ayoub.zaki@embetrix.com>
References: <20261028103102.414657-1-ayoub.zaki@embetrix.com>
 <20261028103102.414657-2-ayoub.zaki@embetrix.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 01:53:19 -0700
X-Gm-Features: AclHuK9jngmd3KJQQQH80658F87URcTJmT-0nf_6CzNX1cinEZLA7Kj5HAeIscg
Message-ID: <CAFLszTh6ANhVsHs5iRH6Mx7WjEc8bv0ZZYQwaZFBdeFaLfVAag@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] lib: rsa/ecdsa: Preserve FIT signing key file-open
 errors
To: ayoub.zaki@embetrix.com
Cc: u-boot@lists.u-boot-project.org, sjg@chromium.org, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut@mailbox.org>
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
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-28T10:31:01+11:00, Ayoub Zaki <ayoub.zaki@embetrix.com> wrote:
> lib: rsa/ecdsa: Preserve FIT signing key file-open errors
>
> RSA and ECDSA report every key file-open failure as -ENOENT.
> fit_image_process_sig() and fit_config_process_sig() treat -ENOENT as
> a missing key and return success. An unreadable key can therefore leave
> an image unsigned even though mkimage succeeds.
>
> Return the actual errno so file-open errors make mkimage fail.
> Include the error description in the ECDSA diagnostic to match RSA.
>
> Signed-off-by: Ayoub Zaki <ayoub.zaki@embetrix.com>
>
>  lib/ecdsa/ecdsa-libcrypto.c | 7 +++++--
>  lib/rsa/rsa-sign.c          | 6 ++++--
>  2 files changed, 9 insertions(+), 4 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
