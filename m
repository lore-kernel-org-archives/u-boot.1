Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDDD606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 08:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PNfWrcvN;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=fnsFH99o
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0DAA760AEC;
	Sat, 31 Oct 2026 08:53:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ehxqbgcligvH; Sat, 31 Oct 2026 08:53:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5310460A7E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793436831;
	b=eTp9KGmtkTSRMUGTvOqNJ0ntw2t9HcxmSyjedNPetmim2uCo2sCz16bNcmMRRBANhVgZ
	 2kX2Vv0/ROHX6tyJtTjTQ0dJ68ehZFwP0P6SxSCrRR+WigCowBl4UTCWkpqoajPhYkqRK
	 bWXz49XKuzSbgcvM5lbc3jyDifNuXiSrPg/WMFIuVafjF3MqVXdyCHhCcXb3dm1SVmzfJ
	 8xSS3YOi6peooJzXwd7jrpRh0qXVqx6St7mPVovRsO9xAvH6tLFQk3BFcJWNvCx8rD8he
	 cOrB2SY8JniJFXTiGudQJYTx98gzHh5SD3G+U82H++lPLtByXSvoJbXM7SOMkwSl01Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793436831;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=NRYWvA/1YjTL12/ocyENRp8SSQqHAQUqSAzLvJfgmMk=;
	b=bkkUiB4aByXBPi8V5ywoPKjC0cS/xzjbpr3OttBp91SIfmn2JDYJs036VjyONyHEGJyv
	 K9InvukUy1HN/AtK7XttEhWm+IxNjQa3OcPFpAxt/lfks4+G/1cldoWJFZcnIW9yulYjN
	 Jj4z55+TENRThvwyXhSyhUYmHFAnSOQ8Y863NYYQQUHhgvG33TrTa6bNNsroAQJxHjEO5
	 HkbFbYnwxMQ2sBR+F9fciNx0Umz6JtyYv9DVMzNaoyzHNGTvNB/z2QktmUph3uaIfSV7K
	 hDiCbm8pJB9DSKhQQaRkjaX4c8J9V+ADHX07DGFGBNGVMs/5qrdy+EvyQgKr7Nl3I3w==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793436831;
	bh=NRYWvA/1YjTL12/ocyENRp8SSQqHAQUqSAzLvJfgmMk=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PNfWrcvNMQz+p9lcPJPUJ6I1i2CsF3m5La1Z/cD0LHyPpFE+/GogdQBg5Jf9Uxzyf
	 NuFIeipA4pZDg4aca6t3ux1dSFdGJn1UtugKuNHmAxLRriVuKYKKHr7S8+IkEL1HZo
	 A3nD2Hu6x2nBWsbwNt+I7t3RRIK0w/ckixYUVskc+wwsvJr2hTHCXQcIYSR6Vn0rFA
	 XZfn0EI28atn2Vtn+driKiDkiEXGhPoPQDolmZMIKHpU2NLRv/c5lfISH45i+5iitS
	 wNguXYGCzNR+AV0air1kVZbQb8vy4FlfMmcxYNuAsSCqEhGOOfdxNLRDhXNXKhl2Ak
	 AhIojHUV6PQDQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5310460A7E;
	Sat, 31 Oct 2026 08:53:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E865A156
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:53:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D9FFF400B4
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:53:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 26W11SJ6e3yi for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 08:53:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 395FB40057
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1033"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793436829;
 b=p3brPxaNLEVeVRQ/rIKBR/Uutm++nt6bm5MpDNDHypkXVIqVk3sb+BlR0TJQRMOTzR8f
 pyxFcrH1HJCkaIaNlj3imU4akI/NS8qwTCqy4HqPDmGhCZ6+wK5yTcDje1yuxjJBuqhXo
 E0nYtHoL+f9S2L9n1IUGw0kkQdrRi7AHLXdNzTQKGQMZ8WlFz1mZgUNsKoOybBg63LJS9
 ADtow/M7S/pWxglk6sTPli3nJ0xIoMK2VVltFmW50WQ4dcnQBcfMdjgPEn1d+5vIvp+t0
 kpNs/2ph7oLVSabl+cW1RXKHMgRdqJ0Xt5U0GcPESkwJOZk0mlgfMA7opFYT4zFRe7Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793436829;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=NRYWvA/1YjTL12/ocyENRp8SSQqHAQUqSAzLvJfgmMk=;
 b=CYfynUpItNRCrbzF9bCmuGm3ozcfGO/TjotDmjZlFrSJOfs7/fCPalkkZ3ybcXo0iclU
 TZDjAhFDujyRddeKK6FckNGSCcd/cNXhLHhuYlpBtVkK+BCmUln9rOjsBRFb0lgWczvHX
 U/gr6xSUbgW+JYD0UrTn4EKiUUFpfJO39lUjM8HJH6sbmGP3z/8aD/uSpyihuN3cXKFSg
 mstNavA3llOMlvgFXB90JPCB6A0YeeuxqArZxFpNYC04T1WRG4TATA3+i/WgvCZW2vwuD
 9AfFWBmonEILhmzIApUCndIGlFssO/belVEaxb5ox7UqYPPJeKXiTK5G8XUOHQVwkyg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=fnsFH99o; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1033"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=fnsFH99o
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 395FB40057
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:53:48 +0000 (UTC)
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-3ac78f4c10bso703383a91.1
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 01:53:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793436828; cv=none;
 d=google.com; s=arc-20260327;
 b=YaMRFOr+QF688nuVKp9akm8J69A0rQh8jGLFHV1HpCPBA2abWBSYLJ+QBsnblzps7u
 5xTOAfxkCXEsXL1o9c6nDgnf+Do/r6vuX3sB3XXdByZK/onNqEnRBNlME2i6oD//dA/q
 3f1OJHzcz5rFCX3Voa+rlc9kV/nh17sByhS1KaiWsVUUUyPFnLEMztP7wpLC8nOhuUm+
 kuC91u21QLoRUoPO2+QukxvwF65rJmKUWehw22Agj4dqcBXdHDzsEVDEQbTftKyY6fmV
 5HHfLI7csCo/Rp8rYHK0EWX437/CWA11qQgKYGbfZi1vXHuYNeHCico/Q4X5pWTwYVyA
 etjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=NRYWvA/1YjTL12/ocyENRp8SSQqHAQUqSAzLvJfgmMk=;
 fh=14V5QZ2qJWOmkUpIay8f5wLH4+hU5ubxJ+YNB0Krams=;
 b=REhZgjC5aL2J3HOxjk0gFKegC2Z9gjJVNKO6c2r0znD/w9Siy/CFdmyxI/+OUWP5Mk
 umZUDjXSmWrt66UHFQlgvXjIMSo4rKNvUYVMptSU47zMMZiINVo6NXhqPNPhFUirZ/Yt
 XAz5XxJVrTBSHEpShIJXrOKmgcFJmT/gACucyo53mw/oFDODJebhpaOyR5lTWwpvZjN9
 9gLgBdk0HJZiR4sqrL4oo9Fzb3sU2blDrPPZgaAaLjWOrcCCF+80tGJXh8qkYPQvmZJ3
 nEOv7LvLk2g48qS5NrPIQVoxNCMmasOEaHLndWEbtjOdLHVSMBq8VCtYWshuvW6iY7Ke
 UZdQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793436828; x=1794041628;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NRYWvA/1YjTL12/ocyENRp8SSQqHAQUqSAzLvJfgmMk=;
 b=fnsFH99o2aohuePASASz4es0BANNxK3GlH+Yv8svgXojvvouvDlqnF8J8J9F2lzYbi
 DPgYZofXac6cjPACwAM+2abYlsc33icuojW4iTXQ2pJRqk7vr7C8zw7lj1sGVi9+TPXD
 ihc+Tv8UNfbdYePvPkQYewZtKmsMR16g+M/R4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793436828; x=1794041628;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=NRYWvA/1YjTL12/ocyENRp8SSQqHAQUqSAzLvJfgmMk=;
 b=0e0Zd/yj6hCiEaZUBBIHhZMXOf+omkCMr+H6HLNt92z7KSf6PuUwX/gT9aKWMs/k8U
 fy6LGARq0Mfrlz5grIA+EfXp7M1c2VgKkL/S8b8UieoQfBE7wZTjUC8KyRQX+6iK5ys5
 9zIHdBCJHAPseV111nUiNPRWOTof7t25pkkrAcHzImRnQT4gb96UR1KHZAokmH5FY7Sj
 T5I+r98B5Ihe9+sReABxwUZR8xHD97hTkOfLV1vjdd8BoCfANYdfEo6Kf9eqWEbKv+11
 2eqhfZB5j4yz2HLc5lMuB/rNTrsaiyFkFMuuJwa4iG3lBBhf6DJmNcZsSFZkiSCTjRtY
 mZEg==
X-Gm-Message-State: AFq9FYLRTql1uRREl6bTtGabTUaV/ty/NBjqfLWBeH+Qiom7fOl+RUJp
 eJDJKbXea6HTjgl/cp+Mktb7bLFP4KwGY446/cntMYCwTG9QzYqej6Go92oYf9vPWjDUcRdaPjc
 YqLfnUL23jRp2IFWvaoab00lcz9Rx7eyPSI82Kocn
X-Gm-Gg: AYBFou12YngPZNdlbjs3c9G8Gu+MqwQmAa8cePU262OQBPjKtoT7c82VOfkkbRhJhih
 01Ta3tNT71hRBW1EzmKXDvF2gO3wXetvpCfrL+TQIGW+H1gq4w3TKVTegy85LrUyzASojxVyITm
 /Qi+wh5nOo+S0c+XCTGygVQMnPsSVQBtnU8pwn1Hv0VBOvogAE7RGagltiCQ5xsUL5o1vzyrqna
 l4Br6ECaur1HckXLKH348yQgGVCAjRXKJUnFXtbXIdaiifWIC7vcGTDIeCqzR3Yx0Xcc+W15ptq
 lKMqdSmW8fGIYAPsorx7MiLNfCn09MA3at/c//S1ZgRkmDIhSTCcmMvow0JtLY1N0Hcragf3PkW
 or8GXcnhIGwAs9RDnKPOED+bdrm39EvzH+uo2w0uJZ7mTxiX0Edb8BalayNhUrO67LpSBgS91Mx
 HihMwPKZJVVVOJsLpU
X-Received: by 2002:a17:90b:1845:b0:3ac:9d14:feb1 with SMTP id
 98e67ed59e1d1-3ae8976dcfcmr3475157a91.43.1793436828117; Sat, 31 Oct 2026
 01:53:48 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 01:53:44 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 02:46:49 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261028103102.414657-6-ayoub.zaki@embetrix.com>
References: <20261028103102.414657-1-ayoub.zaki@embetrix.com>
 <20261028103102.414657-6-ayoub.zaki@embetrix.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 01:53:44 -0700
X-Gm-Features: AclHuK9P5QTJl64iOg1ieecH9NfzsC1kHcgla4KJZZE7BmApaj6lYfpfvCbBgxw
Message-ID: <CAFLszTh2KzMKEhZqkDAtYNYNo80XYjT-Nytw6Gn6nD9kv3kYRA@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] doc: fit: Document private key filename fallbacks
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ayoub,

On 2026-10-28T10:31:01+11:00, Ayoub Zaki <ayoub.zaki@embetrix.com> wrote:
> doc: fit: Document private key filename fallbacks
>
> Document RSA and ECDSA private key filename preferences and fallback
> behavior in the FIT guide and mkimage manual.
>
> Signed-off-by: Ayoub Zaki <ayoub.zaki@embetrix.com>
>
>  doc/mkimage.1               | 5 +++++
>  doc/usage/fit/signature.rst | 7 ++++---
>  2 files changed, 9 insertions(+), 3 deletions(-)

> diff --git a/doc/usage/fit/signature.rst b/doc/usage/fit/signature.rst
> @@ -499,9 +499,10 @@ the path to a file containing the signing key.
> +FIT. The "key-name-hint" property is mandatory. mkimage first tries
> +``<keydir>/<key-name-hint>.key`` for RSA or
> +``<keydir>/<key-name-hint>.pem`` for ECDSA. If that file does not exist,
> +it tries the other extension. Either file must contain a PEM-encoded private key.

Your cover letter explains what happens when lookup fails, but the
docs don't. If neither file exists, mkimage skips that signature node
and still succeeds (fit_image_process_sig() treats -ENOENT as
success), while after patch 1 any other open error such as EACCES
makes it fail. People are often surprised to find an image unsigned,
so please can you add a sentence on this here, and perhaps in
mkimage.1 too.

The last line goes past 80 columns, so please rewrap the paragraph to
match the rest of the file.

Regards,
Simon
