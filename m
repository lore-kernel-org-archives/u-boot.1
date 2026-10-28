Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D53606A31D
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 08:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=JZD8fCuB;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=H1Sh6RvQ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9DA7C605EC;
	Wed, 28 Oct 2026 08:25:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RhwaG8VjiF2V; Wed, 28 Oct 2026 08:25:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DB64E60658
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793175930;
	b=PKB2BmQ4AJbnbFY6dBhEwVRZk6gB6fdqQflGSXNM2sF/9v/n0kiqHREK5+7HIb1cgsvA
	 gNlQl3zzPOEq+J6DrswWh9QTaBLT6StOCQpQddxjXFOHS0FA+ZEUnmmaIw5xNP/OK0IJt
	 YsRxOToLDIhCKROoMR+ALmlVppHWCg9RqmjTQDgbGHlb4emN6Bb4K4SuurMuzqPcRpdVe
	 G5EYjJZ//zSK4udh8FDxMrTSrJqpZuIdzA6s/E4+2/FC8tHf3n0PFe/SwBmuzbpoWhfej
	 9MLXyUSnutTPfjesksUVqu/Pf6sVfyE28PiBuvNvJ+K/62jrarpfAKsmxdWP3/UcaMw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793175930;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=6tVctHs+eFHldXFc33CfnmCOUifnLil6dJMR4FJ/cxM=;
	b=hM1nYe3IpQZWNGcO8AE13A8tSEhTC1ForOTNVlzmRLssxntNbbkIB+Z4DjCLpjNDyY5H
	 3H2wMJgVJF6Q7TddWn0LIt+dJiz3XB8kpEjnSZx0sB+kXX+G3YYcoiYThV9mOByTPKzlJ
	 +FTkduqakexjAA/ZiIR5vrF879auumcjP/kWof8QxIAN8cMNma+F00XpextLZ9R1H0qo/
	 pG1cWmfuoPUxSWY9G6+0zR96zvLy6OpB64LjxnePLMVEOndcr1jv1su+IJj/R+8+2/3LG
	 yhTZuXL/jBWl2MW2QSW/6bhDi5HJ2VEygtP7fWQX6HuSp/15OqS4+gN9ZJC8/5NoJwA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=H1Sh6RvQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793175930;
	bh=6tVctHs+eFHldXFc33CfnmCOUifnLil6dJMR4FJ/cxM=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JZD8fCuBoZYTeTr4r8UL83RNu6nRo9wsw64RL2yfObA0UaXbBo9XO07pP+UJ2jTS9
	 lpxPIempqjOeLQnx8Ezt+fYnnte7v5VjG6cFYBriwsyACshSArU2zCjXO92OYhmCc5
	 pOM6fdYGlbA+fdSYr+rMuaOfHFSnVVK7sxTMiYWWvfB3hHCgCk/p56gBQxyF1fT6pI
	 T80GmexCK75lsG9MF7BBlm1OwjdE8UA8EqmcvGLffoUgc+Yck/96NU4K7kiPckF/w5
	 waMROlbn7dVHfLplcd6JROBh5YrKFGFJ8sK/8j3+wUqrnvMc4p9I4dH1JFvNLLouVY
	 QmP82WUU9Zdvg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DB64E60658;
	Wed, 28 Oct 2026 08:25:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 97EB8529
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 08:25:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 89F4260658
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 08:25:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lIDAe9QvoVl3 for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 08:25:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8E5A2605EC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::534"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793175928;
 b=KtYaQnK4Sl+jwcRpNJNrUwqiHT/A9/CKzb3veo+rf62e8bEzRb6AL2EKMk1ywaljCFv/
 chK5q8qYkQHka0sLHYcw/2KJhGjVUf/g6IhYroISNB9ghCifUStYf/9qG8N64J/nqcmvo
 ABLkxymUEGmVXBBnzOy5SeFV9jmmksl2eGRF2XiT7Z7J7OagYJPJKPWDFTLPo2ZQPyO+L
 QxiGcxvv1IcNCTJCMrjakMPMBiQObGlXt4tXXqx2jAzTDfNCT+B6FRu7gyO8Q7SsSr6kO
 JritFcrWOnu88CDpdH9eYV8hbXwEhXgYi8w7pzJYkE6EfFGr1C3MUbYrRkT0I4/liUg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793175928;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=6tVctHs+eFHldXFc33CfnmCOUifnLil6dJMR4FJ/cxM=;
 b=GiHqAv0tKo0nvNfpXPdhtIyMyZ5xmmqbc6GWmcSnmnA6uXNO0pkQ4y0PsaP3G7dHxGp7
 JBHY9qfZoDBW72J9wVT1mfolTyVRgnPRGtNCJ4bLmfsjvWXH4Xi+ttRdcgfwvMxLOAeHE
 n7C0bO2tk7CkvlhwuzdeMpRzAx6/WFbYZzzN4TSOZD1T8PeNoHXqtMn2rFuARoxafWqY7
 Gc6Hob3SBuuPV7ZbrolbQeZQqwcRXBvZcT68QMVXn9GEQD7S5JXvjlblXmhXU/bG74RVp
 Q62wqw4wY++xX/EcLaSXv973FlY239Sz4RFZABaT5uyoSEDMLF+G2qGS+JyHIvVIHSw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=H1Sh6RvQ; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::534"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=H1Sh6RvQ
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8E5A2605EC
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 08:25:26 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6b488586facso900908a12.2
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 01:25:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793175924; cv=none;
 d=google.com; s=arc-20260327;
 b=piu2nRYj3wdJtODhulSuo8xiJEdwcPLjpZ0CSd1rlfYy9MXe7Sriwn7Cqg8jDftsrk
 mqhqlRXsAdEn+waIASuohmBrLqDD+lOxkGYIf/H5uCs7NmMgHYse3FyqUlGcok3DSx7Y
 48Ox7tK1uaj/OsnAe8v8hPQQx/1qwuxhTA5ARb1C/0UtPayof8yYArk9b/Ag5CVpaTet
 Dvp4KAMDdvx9aT6eRiN1q0/QOvin7r+a4UswKqrotzfzgT/oVsL47L+581aWOUHSnMdv
 Ed8wDPoNjYMTwXheaMpnEKMLvYSdxVyZ32XVUN/3vV6iiA4RlfL1IZZ3b7I9XW8QGitF
 PsNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=6tVctHs+eFHldXFc33CfnmCOUifnLil6dJMR4FJ/cxM=;
 fh=0QbRzSjl54kO/C+9V7bDpUTeJBr/1j/wUoyROXd/afA=;
 b=ZqoOOyRd16GbiKxnQm4g5Yaz3YnOfP4CUXEDZJ6Ov1zHmQTABA2yuk6yh9NFCdXRFG
 VqZ7QAMtI4drN8qemqjKAWqSyEHVh6ZkRjG7YAfje2oeKmLd1JByu4Bw2RiCeeEjl7U8
 JGAqYcv+Fd7eGVWIak0wG4F9o9YwJwYs8P5eds2e+BikNh8MpSuwNkUeiI1EBb9OpzO/
 kc/Uaupak4/f4gYVPf5ZHXwu58SdKmkVE21hmv3VRWUWel+1pkAM9vhLAAvlC405vhSQ
 BJ6b6PZIHskHEwqmU3s5Ed6IgY6L8pKsciEX9xXz0cU1xL7h76w/hhQIQwqyqAngodYQ
 s8lw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793175924; x=1793780724;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6tVctHs+eFHldXFc33CfnmCOUifnLil6dJMR4FJ/cxM=;
 b=H1Sh6RvQmcl6AxbDDBOnwikLDIuK3UFwzV1M1xLDyw/pMMwkNKA98DNOPysQqM8hMr
 tV//T9Tg7cx+LHvO3rcFMkTupnI+0NLal3pHFrj7bSKlRD2NyZGMOqutQxFduPMPv3bp
 rjDSOjdvo2UTZrN1iK1w2NDj2OgyTPTMUy/Jo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793175924; x=1793780724;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=6tVctHs+eFHldXFc33CfnmCOUifnLil6dJMR4FJ/cxM=;
 b=U2vVrWFqecZ1OXKATMsn5UDQPNnsOZWtT4YgUv2C0P9dP5Pm1riAbJ04OL+zvNiQwV
 VeyUEXvGxwGtWFR8+Pn7Oui9IQelJwAd7L2LI0QlpHU/q6fgU5z46xCZmphohlQAFbwi
 cVQsTV5Bva5fAGCiNHi3Y+OKJ0CnYkpOooHiM9xPLa0vfpRtD4s/CLagVzeHAZNHItWr
 vOMOyNfuHUPWNqSwdwlyHipDqir7eUg2rfZku3pk2HjmT7W52evt8xyCul54K8gc90Pg
 a8qnMoV39aLbTr4ZivjI8/UKo7jSrYRpnz+2HiXGvehEx/mJ1jhRifj4f5OkRwCdLOVf
 A9SA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy4Dlat3L79qdSEk3KiusdTDtbBP94pAuqeSe68DYEH9Tx20wSCtwl6BjNOc9G0zz/8mmnS6x0=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJs+EVNqmw5Ho/5LOk/XTAfgkQnTfl6mvUQCw4BaSb+QrFrn1d7
 VcYF1P4GQq71MioZhZD/gs1XHLAnvXbXUkL65PmxS7FGX6nBPkl/TQanKy3ZGLjNFG/wBadFzS0
 lqIZJOPJ+Y1v5odegRPPQXrIKuMSq6XlY4F1r0GDv
X-Gm-Gg: AYBFou2ON9Glyy5tGYVuM5JJ8/SaBsc8EO5UiW2ZP/XSV0foxZtodqTCGJ3NOFaxiEg
 fFFHWTi50ylhhLj9ZFoMdMKDMnLL1FE7YVJWZNW2v4drbWOVzEEqIS7rgQEOesjRzoUG4PKJGfb
 HxDI4FupuWuhDwo9VIX4zh9AbsKyIeUPetQP1IwTx+jx2MJ9G7sQdRAGiK3lpMl1xKCofyxZ4Rp
 kxDWsZY8jFuIcFQ2MFCla2MeHUeKO7cDRN4mMQRu8yfYxCaQrSWxy25rWLqRulpCCpwzRceJXif
 aotqyppdIGCJA/J0gDwHm5xcYMKFewlp65lgPelnhpUNVGJrzBour9pqfYlI4fP5DgTI2bO/nHV
 3/JWc7KbQ50wOvhQYvPAqnA7e/9JvGHiNcH2dFF0OoHCjQ9T92a3oiCGRbA==
X-Received: by 2002:a05:6402:5194:b0:6b3:c089:5806 with SMTP id
 4fb4d7f45d1cf-6b49cb4f1e5mr1048032a12.4.1793175924226; Wed, 28 Oct 2026
 01:25:24 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 01:25:23 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 03:25:10 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <93e4e89a-6c3c-4a3b-aa90-bd9090a6daaf@arm.com>
References: <93e4e89a-6c3c-4a3b-aa90-bd9090a6daaf@arm.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 28 Oct 2026 01:25:23 -0700
X-Gm-Features: AclHuK-q9vJlAx4EfTy1IkG3SP0YuZ-f-vVHRZdZR0XMcfMzvAU-I5L5Mg0EVwo
Message-ID: <CAFLszTiLcqE74HGeQN6-_zE7sPkboHwvu18c5f6WyZov-09w+A@mail.gmail.com>
Subject: Re: [PATCH] test: Add helpers to preserve console silence state
To: jerome.forissier@arm.com
Cc: Tom Rini <trini@konsulko.com>, 
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>, 
 James Hilliard <james.hilliard1@gmail.com>, nd <nd@arm.com>
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

Hi Jerome,

On 2026-10-27T16:02:12, Jerome Forissier <jerome.forissier@arm.com> wrote:
> test: Add helpers to preserve console silence state
>
> Some tests intentionally trigger diagnostics that the Python console
> parser treats as unexpected errors.
>
> Add helpers that silence these diagnostics while preserving the previous
> console state, allowing tests to hide expected errors without accessing
> global data directly.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@arm.com>
>
>  include/test/ut.h | 17 +++++++++++++++++
>  test/ut.c         | 15 +++++++++++++++
>  2 files changed, 32 insertions(+)

> diff --git a/include/test/ut.h b/include/test/ut.h
> @@ -549,6 +549,23 @@ long ut_check_delta(ulong last);
> +/**
> + * ut_silence_console_force() - Unconditionally silence the console
> + *
> + * This silences the console even when U-Boot is started with the sandbox -v
> + * option.
> + *
> + * Return: true if the console was already silent
> + */
> +bool ut_silence_console_force(void);

My understanding is that you need the 'force' variant because test/py
always starts sandbox with -v (see console_sandbox.py), so
ut_silence_console() never takes effect under pytest.

The downside is that it also hides the output when someone runs the
test by hand with -v to debug it, which is exactly when they want to
see it! Expected errors are normally handled on the Python side with
ubman.disable_check(), or the test avoids printing a line that matches
a bad pattern. If the C test must stay quiet, it would be worth
checking the expected output with console recording and
ut_assert_nextline(), since recording still works while the console is
silent.

If we really need this, it might be better to change the signature of
the existing ut_silence_console() and ut_unsilence_console() rather
than adding a second pair alongside them. What do you think?

Regards,
Simon
