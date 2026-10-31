Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B124D606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 14:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=z79lWX/x;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=R6oF+uw/
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8C1C140AE1;
	Sat, 31 Oct 2026 14:12:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mgiMSRzjIKui; Sat, 31 Oct 2026 14:12:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AD97C40AEB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793455946;
	b=Lr0u9/bfu8mLi/qk6ZSSJs3gGIYy2A/XLq5TdRBv2LPkmridID0jelDovR9Jb4AVQUb+
	 gxMPGaHJrXEtSHxmhtmSN1ATWGIM/S3iXyPRYGB5V0lbKDdhAQO+0ebO7QvsFE3J9nAyO
	 sp7KY1iH2BrP21REosoKStSxUbvsVWpWYhyIBuPwxnrBoLi/fOVJhfvdjuXI7whRmMA8J
	 o2DuuInf/p3lmmRathiTD0pK5w/2kcHFxEpc7HuH/TsIIKcYv7PUhsb3Gf4+zeJb2OfIn
	 gWtJPrS8chSzMPnBS/qe6EEjSS8CvQQp4v+Y3Jw0Mik0Zj74dtAO9okXTn7v7H4RXZg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793455946;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=gXiLYw5XTFTl2hkVauZsCzMPeNLfG87t8nqFx0Snvg4=;
	b=H2CalTiGsSIZ4tBRh4+4WEA6NOLibo3LhBIwKpQ1K+T9tETh3/zc2g55krMKCJ5N5824
	 5QPQRbAbs/jT5O5WMkj0QN9nSSX/76yZX9fugO8/FIOYwBB6m82qP7AcUgp+q1AMLlrvi
	 EyY3SzOHI5z+RuUPA0AK2wdprTQQkhqGolKy/SibVlKEGytUg5Ie7HhktlPdBj9URcz20
	 7SdfzpWa4TYEb4q6HIl6DsbjXL2YVS7pCWenfe/BJF1oIfvOR2bDPf1wVONe4ZuWR4Jpu
	 2mmoWa0zUJNyl2CzU1gmpi0gLJ4UeZt/6JtmieiXx3ex2+KwqB/mODgP/T13S4GutXg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793455946;
	bh=gXiLYw5XTFTl2hkVauZsCzMPeNLfG87t8nqFx0Snvg4=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=z79lWX/xZ1hEA5hU/v8kc/AGlK4+iavv5ySKFFYVQvMLhXuzpb1sWTQtCOnVOgxX/
	 KDvztujU1IW1QD2IcaG28x2GGYCFiKwewLS/TfUrsxKYk+avYgocOKrqXgvvwT3KPc
	 otTwli+qIn6UjsdCurwJvKVXLirNHkYM0ts6tVKN1eMOyca2RTkV6p1/auR817e8ae
	 lJRx8t+UszFa0w0lTYkRvMdLiUiyI0vtvd1Uv44kHaDDG4FI65hA8Yc2+g+SqXuQ9e
	 XT5kT197tVc+HZZek7IOPiBJB4lTufKnM5zoYhvFuPXtVxsH/+V626guTitZiHbxny
	 fbgY2ftAUPKrg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AD97C40AEB;
	Sat, 31 Oct 2026 14:12:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5DB791DE
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 14:12:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1150080F1D
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 14:12:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3yvIQ1bmYuWf for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 14:12:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3C232810A8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1033"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793455944;
 b=BNl+h9ZMVTtWvpEqrxQ6efb2ENY2Jn7rHae11UruH8aGb6HMkDqSKXaEa0EjhR0nEPLY
 hAtnyUFjjzjaQMEk8N6i3JxtpRPrkCTHodA/jOKMhN44O8lbreRUVml8fhtKWQCOq7aG8
 5yqL1lOiBIekzAk5yw5X/2I3V2g68I4goOIT/23NoQsFGB4LRCLpN1PS35ebbDixO3758
 NEyYmsNCK0Bco4xkaJkML5r7UQKdSAFAZNcRILbQirG9G85TcmlPcU+NFZWpeNzIJU0RR
 8/VAAo1WwcIzILwBR0gNv4jRcAITzyr/6zkPfBs/6PvvGvZYCHA1YQ8WHAYThf4vJ4g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793455944;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=gXiLYw5XTFTl2hkVauZsCzMPeNLfG87t8nqFx0Snvg4=;
 b=jdnJLhybYCNhCpWh+QlI9+afHR0LTbIz0KrQtnecH7lKSnQCAuBnT9ljfaecwtOE0fgv
 tUNU3Hct4uqTXsOL72zJZucUSb3FBxlF+jFbeh+sm13vFZgEXXZ4LDBN17qm46Gq5NwfQ
 HNIhAN0x1P4pCVaBgVGFyCYz1ZaPeaxLmiI7LnPf5eJq5GfDP/AaCnjZ5uF39ziOw9HUs
 g5JN7+/VT3cbsfoTY2nBzPstEk8bPM3rrmaaIrez24PGASMQaA1FPTs6jfBvrsm6y9SG2
 xQs7fZviipLZFt8TXGn+TdItVMJ+aI0FhkakwX3lPgVS7r9xvlWwOPwkyyVthEq94rQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b="R6oF+uw/"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1033"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=R6oF+uw/
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3C232810A8
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 14:12:23 +0000 (UTC)
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-3ae1d0caaedso741783a91.2
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 07:12:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793455943; cv=none;
 d=google.com; s=arc-20260327;
 b=q5TKwW4X9ZqFV8H/wK7bsIMJ3z9TzswTSEMBa6L+8gbFG9bBJ5+bYmyBPzxbzvQN+e
 jw9+ZbkNhcZwkBsbvvsihVp93oFwDnBr3r8j9SbvGv8ylg426J0mgVHTNYb129UZ0QcZ
 KuJE16EsQnA80jRpOQHuhCtXqCN0hXhAKj5gREIwT0imzkHKapN2SDIxJOp9XLuLTjWy
 rxe5wXdxb31p1oE/dM3WOPw5MxOq3bgVc9byJF2ra8aL8IOe/pVg5dZOXZ9X1aMtdhWS
 fEnCUfwzsLQVw7RDDZcs4ov2LJmyNHTvVgvkCj0a/e733TTegKBdJO6FSfnGGAGQP2hG
 a2DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=gXiLYw5XTFTl2hkVauZsCzMPeNLfG87t8nqFx0Snvg4=;
 fh=XXKk4iRAMsSvYqlTSnM6V0hzlPKJVUv/9VaOgnEIjRw=;
 b=TKhBls+DHKycbTYVW+VL8fgAm1iQa6QUdxjqEnJK3s6l+NIZF4itkIXireEQtPMBbg
 tbOPEWZ32zI3xDULxitpOhpEXKDCEAs1iHgyU+cSWu10ZZflO/CFOLLqZceyGl3ZTgcu
 NDEw6MxLQFCq7kZYPzYEqgY0xVyqDIzWit+Co3OJ0E+kKejfadmQeBvAkfcFr7kKfc+x
 +UgPzk+FtXIuCXkXWgg2EVgFRWCL72OTU3gwA+ClBuGi874slSxGq8HyiCuIe53Mo9hY
 BtirP5gEgLY1VMPjvLqEyfE/MXJeZ8OhhTZtdkLVbAJB4h/qa3hXsPkOfBCY5T0wk8wf
 Ha1A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793455943; x=1794060743;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gXiLYw5XTFTl2hkVauZsCzMPeNLfG87t8nqFx0Snvg4=;
 b=R6oF+uw/oKeJvk3ZYs8NSJcA4FdX4Yad1JNjOhBIlPEQ+ZPhK6Vk4EB927kZhe/Kdz
 H3Jb4B37Wj7+ljzZ2Ul3N0YcSvoR0JLjbgnS/IqcD09g7BBP85myw0VhXTUDLZiT/sOp
 hw0UfjE1z8nn1jFvIEJo/LIhm0KSak5MVQHxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793455943; x=1794060743;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gXiLYw5XTFTl2hkVauZsCzMPeNLfG87t8nqFx0Snvg4=;
 b=oocc40QRrR5SE8bol+Ktr5ahO+O8nfmHZ5VVxsyayvLE08Hwnlgrqrewa3swiLkuoU
 6ILSaOhAYRQE9gJgDguGEIQMy3xeNpBmEXsTBhwnHvEPg73HInBzdEy/DqvUgNlp0zGx
 eJEYAXbuimZCThSAqegkbNrFjTZurx1G2GQJHEnQe0IlmePYoNRm4IXbNcyEeIpa1v0X
 b0d8tbG7OCb60vF99VrqGy+GlBBpebJ2fi39CMpe2Q46BkDdZCTpLy/dAnaSOYFy3IoT
 OCILDe6hyr9tnMDdrgWdYmvgAfGxBPuxnJjjzARrVza5ySNnqdEtI3ULSlmcQ0NA11Xv
 yaLg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzpjDzeETmU2aardnzNopgCH5ZwV/JDHnttgba5wMcL4KA0S8dhwwo189AL66l3ONYPPXP5MOM=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJhVq1eGsVZ1DDsrZTDiW6GcFHx5WFmvl5e+cbY69UfmQjLFnuh
 BxSOEPcnRmHDHTPa73DyWjattz7oFi8HO/6mVmqE+t8GIGwVj4ld7EXzu1sMGMGUbJNZoCTI1eH
 BzV0P6IUcvQydQlOg09omcPldJ5NANt/KxovXNLY6
X-Gm-Gg: AYBFou0JN4i+2qxi3DMQR/jrvPUWZ0UciXJDvdCuz2rFSuOIGsAOhECWxIXdGgN6wv/
 m9p+Ts1C9bgM8+a++7tL46wZ5/ONBOTN/gTMFJlU9ZDxVseAwQcHDGPV93RzQo8iOprgUr/fauZ
 zIWeQoepCXwL+9MI+zz/vR3UlMmhEJIBgKj/4/5nrBT27fPLurjfg2V1fw8O0/gJ71SFVJ42BGZ
 w6cSJiCHLQzqghXVgCVq2zwZH1kfa7/lsC0inieidgvV8te10IIF9WOcuMKS7tl52EtnvQfyiil
 rS/7GW3JQZq/XNDlq/lMJyq0W1BHq8G/w1vPBTvtw6UZIqarr2Tz00htvnDvehCHQzUtoBy5i3B
 It6VRrJYeSiJSRU6L16ANZ0J/MFxwlsz6egu5a/ASTq7/aYk8Alda122RoxBsgcU+4kfggdTb
X-Received: by 2002:a17:90a:f6d4:b0:3ac:b197:1a37 with SMTP id
 98e67ed59e1d1-3ae895362cfmr3376436a91.3.1793455942954; Sat, 31 Oct 2026
 07:12:22 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 07:12:14 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 10:10:40 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261029201348.730274-4-ekovsky@redhat.com>
References: <20261029201348.730274-1-ekovsky@redhat.com>
 <20261029201348.730274-4-ekovsky@redhat.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 07:12:14 -0700
X-Gm-Features: AclHuK8AL1b8-qr0LLXEEh2LVRC7upUC3WFHF4ghwaDkDTniviyicrnoXJka0gY
Message-ID: <CAFLszTj_VWJB+v3168+qqZNzOncYdLUdb6waRP_k776kqa0M+g@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] rsa: load a pkcs11 token key through OSSL_STORE in
 the provider path
To: ekovsky@redhat.com
Cc: Tom Rini <trini@konsulko.com>, Tobias Olausson <tobias@eub.se>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, Simon Glass <sjg@chromium.org>, 
 Jan Stancek <jstancek@redhat.com>, Enric Balletbo i Serra <eballetb@redhat.com>,
 a.fatoum@pengutronix.de, 
 mark.kettenis@xs4all.nl, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Johannes Schneider <johannes.schneider@leica-geosystems.com>,
 u-boot@lists.u-boot-project.org, 
 Quentin Schulz <quentin.schulz@cherry.de>, Bastian <bst@pengutronix.de>, 
 Rasmus Villemoes <ravi@prevas.dk>, Jaipaul Cheernam <jaipaul.cheernam@est.tech>
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

Hi Johannes,

On 2026-10-29T20:13:40+11:00, Eddie Kovsky <ekovsky@redhat.com> wrote:
> rsa: load a pkcs11 token key through OSSL_STORE in the provider path
>
> The OpenSSL Provider API support routes FIT signing-key loading through
> OSSL_STORE on OpenSSL >= 3 (USE_PKCS11_PROVIDER), but only for key files:
> rsa_pem_get_priv_key() fopen()s the path before OSSL_STORE_open(), so a pkcs11:
> token URI fails with -ENOENT. The legacy engine path that handled tokens is
> compiled out on OpenSSL >= 3, so FIT signing with a token key silently produces
> an unsigned FIT (a configuration signature node with no value or
> hashed-strings).

So as I understand it, this describes a regression from patch 1, so
token signing is broken from patch 1 until this patch. Please can you
fold this into patch 1, or put it before it, so the series stays
bisectable?

> Load a pkcs11: key URI in the provider path directly through OSSL_STORE and the
> pkcs11 provider: skip the fopen, append ";type=private" if absent. The PIN
> travels in the URI (pin-value=); MKIMAGE_SIGN_PIN is unaffected.

The patch also changes rsa_pem_get_pub_key() (used by -K), so please
mention the public-key side too.

'MKIMAGE_SIGN_PIN is unaffected' reads as if the variable still works.
With the provider, rsa_engine_init() is compiled out, so the variable
is ignored and the PIN has to go on the command line, where it shows
up in the process list and build logs. doc/usage/fit/signature.rst
still documents MKIMAGE_SIGN_PIN and the engine key-id rules. Please
can you update it to describe how this works with the provider?

>
> Load a pkcs11: key URI in the provider path directly through OSSL_STORE and the
> pkcs11 provider: skip the fopen, append ";type=private" if absent. The PIN
> travels in the URI (pin-value=); MKIMAGE_SIGN_PIN is unaffected.
>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Johannes Schneider <johannes.schneider@leica-geosystems.com>
> Co-developed-by: Eddie Kovsky <ekovsky@redhat.com>
> Signed-off-by: Eddie Kovsky <ekovsky@redhat.com>
>
>  lib/rsa/rsa-sign.c | 92 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 92 insertions(+)

> diff --git a/lib/rsa/rsa-sign.c b/lib/rsa/rsa-sign.c
> @@ -92,6 +92,52 @@ static int rsa_pem_get_pub_key(const char *keydir, const char *name, EVP_PKEY **
> +	if (keydir && !strncmp(keydir, "pkcs11:", 7)) {
> +		char uri[1200];
> +		OSSL_STORE_CTX *p11_store;
> +		EVP_PKEY *p11_key = NULL;
> +
> +		if (strstr(keydir, "type="))
> +			snprintf(uri, sizeof(uri), "%s", keydir);
> +		else
> +			snprintf(uri, sizeof(uri), "%s;type=public", keydir);

This ignores 'name' (the key-name-hint). When keydir has no 'object='
or 'id=', the engine path appends ';object=<key-name-hint>', as
signature.rst documents. With this patch, the documented usage (-k
pkcs11:token=... with key-name-hint set in the .its) loads the first
key OpenSSL finds on the token. On a token with several keys that is
likely the wrong one, and the image is signed with no error. Please
can you build the URI the same way as rsa_engine_get_pub_key() and
rsa_engine_get_priv_key() do?

It would also be worth handling a keydir without the 'pkcs11:' prefix
when -N pkcs11 is given. At present that case falls through to fopen()
and gets -ENOENT. image-host.c treats that as an allowed missing key,
which gives the same unsigned FIT that the commit message describes.

> diff --git a/lib/rsa/rsa-sign.c b/lib/rsa/rsa-sign.c
> @@ -237,6 +283,52 @@ static int rsa_pem_get_priv_key(const char *keydir, const char *name,
> +#ifdef USE_PKCS11_PROVIDER
> +	/*
> +	 * A pkcs11: token URI is not a file: load it via OSSL_STORE + the pkcs11
> +	 * provider instead of fopen (PIN in the URI, pin-value=).
> +	 */
> +	if (keydir && !strncmp(keydir, "pkcs11:", 7)) {
> +		char uri[1200];
> +		OSSL_STORE_CTX *p11_store;
> +		EVP_PKEY *p11_key = NULL;

This block is a copy of the public-key one, apart from 'type=' and the
OSSL_STORE_INFO type. Patch 1 also has an OSSL_STORE_open()/load loop
for files a few lines below. Please can you put this in a helper and
use it in all three places? That would also keep the provider-loading
order consistent: here 'default' is loaded before 'pkcs11', but patch
1 loads them the other way round.

Regards,
Simon
