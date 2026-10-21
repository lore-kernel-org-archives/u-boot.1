Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C69606A31B
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 13:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PuaUkwjW;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=MTmZUNJQ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 26C35607F6;
	Wed, 21 Oct 2026 13:14:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BUTfGIATw4CE; Wed, 21 Oct 2026 13:14:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5DC846082B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792588443;
	b=I6+rsorS/8EmdJ6NKFgRDY65GQ0ixV9UJ8WHb+r4SclsuSB3Z6bVsRQL+x/ljHVYz6lt
	 mA6n/E6OOizdef+U0CKabR6746mqeRTLxc7KSonMT7u6mQT9GFm+mr3Jez5ZUZAoV8QKQ
	 IML1DL2dM+Ky3sNIUphsGOjUPPxo0TRXpq1JQccVy0UNAZk+1ARP2W1dTBHR0rw/HbpMK
	 oyntlR+T9tSWVjp8Df19YzAFs9kDbe1pB57LDgEsAdijcPbEtZyo5f6cU3WIooCNkrhvh
	 9vosz6SNzSWLRcEGoBozpcuZdP8Auo0hgUHvh5P7j3tvKoMakejJbs0xYu7Tx9a41Iw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792588443;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=IQyP5k7uPStZyt3cEUj488XPhUAC+YRCCPFYjxOYtGI=;
	b=FAz8fToqm82AZPa7+wVGKZosgdFGUQiW3H9mv+WN91LhcnUoxkReRJncy/bnGNKYflOX
	 ITafwQOJRrqoxBP76shOX3oLJuZBzex8j9QKYFKtbzpLfvK6v8u0xXyI9y4QS35EuXzVG
	 Q8uEYGQbQFNiP33rtf9Kkk2R0o2EPQrCIHTpgoF8EBMkMbxge/7vVLK3B53NybOfuejA4
	 zBzvaK2ndxeCqLAFsvMBWL39TL2cR8LNHM4VwMz5GIN5zjeOHDdqVoLeROQapRtpaZrCM
	 JLQQwLYXrnkHRM+4W+4fJZL/NDoYOq9Z0m71G0huNs7kBgK2rkMKzHtE74aqioygZnw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792588443;
	bh=IQyP5k7uPStZyt3cEUj488XPhUAC+YRCCPFYjxOYtGI=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PuaUkwjWzh2+v7XRshWBjXIuBaGUtkAdOXP9xEImUNQ9tenR0SlrPsEaKgcJ4zgQB
	 E9WAJ+7qlLlE4JZJSVf4eWZ9Of9FaQT56muLZwlKnuCkfv6xkWUD8eWDfjMbAXrvAo
	 4CUw6OAgs4uvKbThikN+eUjTIUkg2ZwupCR1r0BGHhbPFgO3SKoR2cfQyAGPaiAhmZ
	 mqAjj1EKsyoTYAyz22Gm/0qQJhVAJzPyGPfjetk6+wjX8NLyWKC71iylSbhhpbVzOR
	 G6UgoJBUqYunedr0cXfk59WZe9sj1/RjVfoJy0Wl+/jbyhX3U9C2WNJWBvac16gqmu
	 PsO9oc4agVdrA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5DC846082B;
	Wed, 21 Oct 2026 13:14:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8B6E3930
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 13:14:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7DC8D4061A
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 13:14:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wv_MCPKy5hUh for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 13:14:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B628940629
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::633"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792588439;
 b=l8K71ZvgFEBJcy1VRvM4D6HtIIT57Muam2INdFyIgTdWCuB4KKULI5VJSXdt21zYbDZf
 Lsp3ZQpguqGl8S214/Gj8R8uric+0bgDGACwL+UVLV2IXXDdLeD8k5er3elfhnDvWdyjT
 94IROAv1q6LVXLfrR4ildyvp8wU5iKFXqCF4wO7+Oa+lG/clGyMn5hljB+oba5vtsRXkd
 5wT3n1+oQGI5pTqNqXpN25+VMQllDh/pcf3TjRFbv5zKlfKrxLzWyBNmiMSfIuuv9OEd3
 KoHfPS3eLsfutEyKSi0zgU6uBpuXaVnYJ+O5/gVp9nI51a8gZh9uN5FcFOomSFJenxw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792588439;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=IQyP5k7uPStZyt3cEUj488XPhUAC+YRCCPFYjxOYtGI=;
 b=npSLGW+pzsTuR9rY/1AwgTiAPLXJSsKbik+Uyc8Z88YnFCJ9EMAJ8WJrA5u+iEWcHFSx
 nj1Ktzrvz4NzR8dqdsPxJdXpjWHE6Gh7+hk1CxDG4vix5Tr1twslY4USphDjGEq3p13eD
 rx2hR9k649CKi4wg1f2uqrHVoCSPuwVoHEqprofj7JTS98jcLvd3DFEJfsUb2x0l3AbQx
 LXkOQxY33qD7g1C3lKbPI62KHihLDMHpEPbV9d7DqKNkFa4VXh8BFNx5DDv2uxrYBeDos
 NAvx57qxOkCkvI4rZmCIfwzv0Rz1j2bO4CrZrgs0nwpup0ZAPrbXPoMmZ0okytf5Lgw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=MTmZUNJQ; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::633"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=MTmZUNJQ
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B628940629
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 13:13:59 +0000 (UTC)
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2e8f2c3ad6bso4437615ad.1
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:13:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792588439; cv=none;
 d=google.com; s=arc-20260327;
 b=Kt9tyKByN3ZQtuHvf3/wqle2HEj9U/6KEqVae/JIiaGkEW1rYmdOujnmUYcZul6Sfs
 h9XVNAtoub42yiov1c4dxPZ1HsnrUgVgIRsncdzGwEg3bK6Z7PJ7TYX1t8bYGov79hkh
 ncHOVBx2XER8CzpMICgQ4VadV7kZ7ruQ/pjWs9Hx5HT+RZEvBm1oKab0TM4IrkqTtCcr
 tw8/ip+257bGbMmHgl6jQSs/pKXxSLGRcCLJjRV7Cgcvn7coblvWRowUIWUX3XTheyEy
 CcvplO00v4RWE8WFghDpWrpp0uGaT1lKF1f30F45Y5YgHnP/sFVAG+O8Bm7IGWYbqBbX
 XhYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=IQyP5k7uPStZyt3cEUj488XPhUAC+YRCCPFYjxOYtGI=;
 fh=lFEvJiD09eFkjC0zjxFrJW8v5KPieVD3ZcMao2sBQCU=;
 b=JIoU+inL9a8TRIg5w8csXUDkWpcwNiyJjSORYuMbz3Xnx4+AOWPv+ePwQMiwmFwviI
 SebNt0K00I+nN3L/PInPPwWvek0+6b4csYUF/jiQIphSyb54MsmpDge4DaBdafya7MrF
 otdXj7bYBVbhRmyt/MtCTrun9VTmGohaXTGH5rI1ejKvGtFmmNSX6SndkeRPHPcx5Sqq
 nld9adbNRbP43y5tGGnVtEfZqRRGHp/fnitj6Uf21YrrxkmKKj4Ik688uV1Wp0Umhj+N
 FicrnK12q7fwIBtHjkV9goyQ09/StxGk1rPG9JC0o3fhhyYzHF9NvRye52yJH4MnyTtI
 Otcw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792588439; x=1793193239;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=IQyP5k7uPStZyt3cEUj488XPhUAC+YRCCPFYjxOYtGI=;
 b=MTmZUNJQZSD7bkbdhhPq2uzojoPf//r4alftGaKRRGFLXzE7KBXt76ckokNskCTIQw
 J9h+xG2mzwT3peM/W4VXzGs5mUC+KvRfzofGYopz02QYa2joNYKG8AVFuqQVBVVsCgya
 zmRZ94EaVB8n+hiR2acGTA540CQWN1lfMtnSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792588439; x=1793193239;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=IQyP5k7uPStZyt3cEUj488XPhUAC+YRCCPFYjxOYtGI=;
 b=dI0LBAzQbuEubQ4jYKTI2dPWc9Pfz1okconbe735Vg6xMpPDYo/RCr0axlmHBB9qxQ
 HM/yJoWGYWygihmrp2kzA80Fc7CzJXDNW3S1GFKd5u2Rb2r8+Mex2R9oEt2fJb16F+4y
 4dxpsXfOo5LW1qQOx/j1aQlLCiNZdRDXQR8HWwx7pIwKeymnt2ZXitVzhmqxts93BupD
 oZnkUBdHcD0xcxe/JsShlhP8FxWZDy5jVTuFdVEuxc/wtjzbcyvUtd+HosKOURlisGux
 iXqlF9ZQ4n39EY2IEL5prgI1Jyi4gbcMRINl2OEYgMHsnPZroy5nz8u2LM5prhnNiMfe
 G/MA==
X-Gm-Message-State: AFq9FYKVx+wq6clSurcsjx6Pt/dgm37okivlJ1jXg5UnlzVCXCUl3dUL
 w7iF4Q7bN0CbL7jCWBgCk6KGfIJJ62KCnVGfBsjlCWy53ZLfBtCLRiwbywAWNWn6uOe35IkrqZ9
 +YHDea7GBVLt/2PtW9WgEG8O/h61J0hykKCseP5KL
X-Gm-Gg: AYBFou1ybUbiJQ6U9E7AFr8Zedm+VRCQH5kg5QlazdmXnNT2fmoLWKnL+9sR8DqdyA3
 y5LE0Sc+XTMHiwQzbZi3y7uCbyJ9Sc8QkrOUWRmHUwTZpWMzyzCmd9Z7mmSXGQkPOYV9U63iTe1
 UW2jun+wXkyfycd7sZ0GwmzYLbask1RC/U+AZbWsMZzI90lx7T0Rauc0QnEjCMaOKwaxEjncIaI
 24lKiY17PxScxLaht07PHqItpqDR5zKdGJ/XfqRlCWNcP7hcrOHgiZIVAa1S3NcEXWD1hbqtTE6
 zwkgKj+QP1ehFOhw4sLnyVmJqMyxYJ5BRsSrivxHhv/0oEGYePVxGX2z9CHyp5ktCfR2hW7HVAL
 H5aGnrOHjaJms2gjRnZ/3JS40I/SgIsYi6yk=
X-Received: by 2002:a17:90b:4b90:b0:3ac:c03a:38ad with SMTP id
 98e67ed59e1d1-3ad86c00fa4mr1973334a91.5.1792588438801; Wed, 21 Oct 2026
 06:13:58 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 06:13:53 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 11:42:15 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261012101054.2104707-3-lorenz@sigma-star.at>
References: <20261012101054.2104707-1-lorenz@sigma-star.at>
 <20261012101054.2104707-3-lorenz@sigma-star.at>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 21 Oct 2026 06:13:53 -0700
X-Gm-Features: AclHuK9S94oq6vaJuJ1m4rfGF_LxkQ53GPP0MM-hzZJ09R-XtYB91R-M22--fL0
Message-ID: <CAFLszTjpSs-oiS42gPb-NoRxPBtsZ7FXXLDu3PjfS0trLfnZpg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] binman: pre-load: Allow signing with an OpenSSL
 engine
To: lorenz@sigma-star.at
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, upstream+uboot@sigma-star.at
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
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-12T10:10:51, Lorenz Kofler <lorenz@sigma-star.at> wrote:
> binman: pre-load: Allow signing with an OpenSSL engine
>
> The pre-load entry type imports a private key from a file and signs with
> Cryptodome, so the key must be readable as a file. Keys held in an HSM
> or on a smart card cannot be used.
>
> Add an optional 'engine' property. When set, sign with openssl using
> that engine and interpret 'key-name' as the engine-specific key
> identifier, instead of reading a key from 'pre-load-key-path'.
>
> With an engine, binman never loads the key itself and so cannot check
> its size before signing. Check the length of the resulting RSA signature
> instead, which is the modulus size either way.
>
> Behavior is otherwise unchanged when 'engine' is absent.
>
> Signed-off-by: Lorenz Kofler <lorenz@sigma-star.at>
>
>  tools/binman/btool/openssl.py  | 28 +++++++++++++
>  tools/binman/etype/pre_load.py | 89 ++++++++++++++++++++++++++++++++++++------
>  2 files changed, 106 insertions(+), 11 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
