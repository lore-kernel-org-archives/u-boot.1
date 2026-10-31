Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1357606A31F
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 08:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RGO/JdUG;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=GGvSHMIS
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9DBF460A7E;
	Sat, 31 Oct 2026 08:43:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F3G6eKe22y4t; Sat, 31 Oct 2026 08:43:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C84E06079D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793436188;
	b=NxVrXyxUAlv/1QKqrI3J9iZ7AbV91xsR2l4I57jwkYRSqGMrZrouu5F/g6j9MgZ/wNnt
	 wwYz2C1anFUJVCFsqQukccTSISQQuPIYxtfoY6BAsv1zTL0rPHMwuq7mE7SjzC4/LBoO8
	 l9LjoSASWEstT3z9MNL7n8A5Q3VDHOQroTjn/1ZciPBdXl8wG1G51efopsVSTe5NB8R3r
	 S91z3MFoeeUuYq/kfvJas2QefDRjGE4dNHPzWuqRKzqyUd3lsZEH5GF42qF8Ddf+r4dU7
	 1ZS4gZ3hule6qVrs7TYpTHOxuuH4SSNjJEZO094MBUfQNjeKFDe1n5KpB8gyydkcr9w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793436188;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=fiOFNVByes58E5i6UjY2Cqd/RRqxSZxtQNBWP+5VGzI=;
	b=Kz5qVBc0bokkNUEx6aT1s74xTtpZnvxNj1i4u/ff+ibnvTGX+Pv8Fqr4dGIx8ujf84Hl
	 sE7CEHOdo9XT8GNUHOKod59iN85bY9i0+lopTcIEZRizkae0UFCEFtlQFmYHWIhqqVmA4
	 M33ojgJRNHzSrqbndefyy7o354yqimhjitBcxX5ZST/tu5WdXp2TO5bTXKoQS7dUraa1g
	 9Dv/yBN5RK/A+lTeAZepQp+7AqWNM2+T0qN4JlAGfj5XHJUYNyyC682fgg7mjdMwIbyiB
	 5pt9ohhp5MJ9fxgBzzM/HwLtDMJ4ek3UniwIAterAeQAaso3ltG7DHOO43+C5SAdo6Q==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793436187;
	bh=fiOFNVByes58E5i6UjY2Cqd/RRqxSZxtQNBWP+5VGzI=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RGO/JdUGtoeNb7N12D2LGZheDiFnRPq95fSLgaibql5Uc4BIjeoIRb/ef8H/CtmFu
	 1tvBg8ggkX8X0zJPMrQF/0TFbuBzMJ+q2TCXMwYQUVdcVzgO1uZVAOkvMxi2KuP85J
	 chxD00t9OfgRCkD6XllUWCWz1P+u8z/4P+3I1dnnhuJrLLQ9GMUB7VQn0XdQOyyI1r
	 21AQGk0txkRgdY5+8U6CHEv49fFMKP6DSfFSKYuwZHC4JD0iJrlXT+oRpZCSm0ThQk
	 rYQK+ZceTmfKF6DdAPB553OXVz711/+RZ90ZTsmt6dFNhQCbhPGXZOSDm4e8sAoafD
	 03yyxRljmZZTw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C84E06079D;
	Sat, 31 Oct 2026 08:43:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id ED7874BC
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:43:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EB0E7400B4
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:43:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g8bognOZRBfl for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 08:43:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 409E440057
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::102b"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793436185;
 b=A5R1rrPKm/HLHoLxHq5ZnKkmh0LqS9peW9S0e7RpVS710iwj/FgBS1tgDTDm8x2AqhdQ
 5eC7g5hHeSPHUmfuo03MMDRGSzGPwys2he4KUogki7IUNWyu40IrwMFzAkYvLL0PadfT6
 BgmTWFcdD1MfNh85B3oe4ykYzi/UZiyuMbc+stxiz97T+Cn7Mwbu5lWuKx6RltyjgJSCW
 jqjlKsDAnjhpHcjfjsGOzQ3YzhyehQOiM788lTHef+zSV1qiCrYJowpVTOfQUzp2Vtc65
 FB9fy0wj2pPWOiEua27boCgYRxmKCL2kbUoBt162iZFoEdceYs88nxFjHLlRn6z1NIw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793436185;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=fiOFNVByes58E5i6UjY2Cqd/RRqxSZxtQNBWP+5VGzI=;
 b=AMVb/vexexgjvaQ/b7Z/7qrUufEpauGIeTrEt1K0P6qtL5rvfZdygrpCx1pMF074zN9R
 5gOrDs/XnkGtuIkia7hA1c1MAoeNNM7VJElylnDZDEJ0PU7FMu2rsoh8OFhGZ3GTe3/vq
 4vvyiiz2xPvYvLy3ohOc41MVui3HJeXqozilEp2QeUkws+OV2JzNRl5X1xQIXT05IYXE8
 zrdFNb58c2gTnaO2brsuUqkMr2TIOwfZhe9KOXO286TNKxy45AL0R+VDxEtl6wWISi4z4
 +P0lCluDGDDfVmHwyq6bgLSRCwgYC/UNKw8n1efE80CcPtJ386QKZRk64KhFbQRsCqA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=GGvSHMIS; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::102b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=GGvSHMIS
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 409E440057
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:43:04 +0000 (UTC)
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-3ae486f8a27so937892a91.0
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 01:43:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793436184; cv=none;
 d=google.com; s=arc-20260327;
 b=bOzaG2z8jgqe4voZ0xvOsh7+JmpXD8Br0YF1OI6qUH3WN2qRzaCrS0a90wGiT8yvxq
 RDT9QAbaI8VynHQOFzKRCJQxu2VYgmOCqo9hS7zHH55KjlzPCoZt5vYcIMxmAf7QwSQR
 Jz53LBfF7NRjvsTXK4eO5xMxR9yjyNGZzbypyX/vW9RZUZWbgvgOVlUwMY8QwKxGdgoA
 z8xAUD84EyUSmfR8YjRqqwV67QA+jDNJXTX3QKKjmaA1jEuWw3r+TJSplOuCou/LTx7l
 6vMs7l41uO2sJWWoKULW+1ZwGCCVhcvkYARvJomHH8szqM4xenvm6JW75PjpmDPKrA/v
 5S0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=fiOFNVByes58E5i6UjY2Cqd/RRqxSZxtQNBWP+5VGzI=;
 fh=gtHcjGdZNYbl+u3A8Ow71/zjdXTwgJ7oVS+NwTju7Sc=;
 b=i/w6DLhtW4Gp4qEWp8A7DWxVRQHNHT+x/kD+04eCiCMWijBvomXj7dRTVoKH/4tImz
 RYLGGPe5iMBvcyvNojftd8nbnrPMpbsL/lmHCvJSky/3DWuaoaIkJtM1BpicNPCVth5H
 6u5mMl+9Qpo9K9y9y1nkhbpA5Fo1g1B3E1CYQi/lcsL3iJCknMFh4b/z1ZwPU2gcVF/y
 4hNUEh5MmvQy5Liig5A70AdENvNsA7JLJJ6mD5BwdXaoj40m+5kTTxE1IpvdGoJuIihK
 uPAmLlnn9zzH3DLMMa6/ShQO+8loGJ+RGgZyvA3YmQGK8akhd3z0l8Ct93IC0WyClmUb
 aBfg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793436184; x=1794040984;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=fiOFNVByes58E5i6UjY2Cqd/RRqxSZxtQNBWP+5VGzI=;
 b=GGvSHMISTD3R4Xailzkp8w/z7pF2YxLgsezEQvQSn4X9ZfqWVzUMtHN7sZmLnUYtkm
 IRTN7131hupXPGNX67s4TYw1v6x0nr9xVo3Cy070vfw+aXEwnnsl8r2qoAxpury7JZOM
 KJUib0fqfE5JB9gNmSL9MQ5ale/6MgXRFLhJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793436184; x=1794040984;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fiOFNVByes58E5i6UjY2Cqd/RRqxSZxtQNBWP+5VGzI=;
 b=n4x6FxTNxf4ZuqgYpEtEdgNwFIqj/dIsf4vAGgL8SsU1ShT8oh0NDAXrAAsobEWcuB
 yLY9sVfHw37EPsyGnn6SsAiW11edxPWdGBUrxIzaj+7dd5ROhr77ww4A41bYTtJndPPd
 lkY3dCJpVDyb0MVooxfm6eZnKCpMmeZN0BHvTt7CXAmIMIy9GyGYX3N1f4eRi7JBEb3n
 ilpH6VdgHiZoqEzys46RcABBLYjw2jPGw8v16Z0NHc3OqYT2LC8RjZXDk3oD/LO0XvK/
 1KVutH/fr9/YqXK2HO8JGyy0rEn/osWqLz22s6sqENsy5jMxUoEoMk6kuIsjtzNj0sGT
 sntg==
X-Forwarded-Encrypted: i=1;
 AKwUvBybJ1B0Nrd4hSD2MiwRB2xusyupxrB1now8IiQQUDBagnWvz7LHwKEEjwDw5u9juj+PSXNFESI=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYK4nWq9dJqeJoDLTwrlLzcqGv5oBBq3eqVvuFcB73DCL4yQguFI
 gD4PbnNVaTGXANts0gqaL9qfjiN0jKMcchPkwDXAJS1gv4AcngqFNQTcshUrbH+I2dwtGU3CvNf
 F2V7HuDPbxbVzXHPR/wI7RrJwuwvxfSm+7/be8qm6
X-Gm-Gg: AYBFou1Q2aylLNZ8ZPEylb89uthQjf69jm00IpUn0SmhiORK9kCB8q4c3jY/3zP/S7C
 z0lPxk12OwX24iqVrLJBRad3eMDHINCQM7mw7ZM7wBn3MN5S4+iPR0dhi9umhH47doXjlb5nxJU
 O6WndwKOMTfSBxEdWjjZCpBJ+FE+OI7/3HDY5ketAQvhGFRTVcTk3cJkWLKhnRQ6z67btJsPLns
 JFdEbc7GV+EfA3g2jCHPSJZ3QF3L+9z9NCacxjVnx0mPB05fz5+xEkSYzXL5oafYwYKREbeV/DG
 +SnrPKh1gY+fk0x2b6bkDzXUcAGrw+nNvK3B5xSyDMB4rGzwXZ5Ard2E0R5/W5WansQhzO3zwbv
 bWsLaEENe7PF1t6kF65zzDXJj1wk4dEUjChetgCZ+SD3SBFVv0OQ5dF8jXkI8kIi/gfp+9Uw=
X-Received: by 2002:a17:90b:1845:b0:3ac:9d14:feb1 with SMTP id
 98e67ed59e1d1-3ae8976dcfcmr3466940a91.43.1793436184242; Sat, 31 Oct 2026
 01:43:04 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 01:43:00 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 03:46:18 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261029050738.1107663-2-me@ziyao.cc>
References: <20261029050738.1107663-1-me@ziyao.cc>
 <20261029050738.1107663-2-me@ziyao.cc>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 01:43:00 -0700
X-Gm-Features: AclHuK9YV3612OqzYWLflofidccjea0rd-t4JtrxRWuOPAF-T11BHw0jDct3x-8
Message-ID: <CAFLszTgW2=EfVtr_evcbWvanyr8GMQ1jWnUmpbsYXZWBbyM6dw@mail.gmail.com>
Subject: Re: [PATCH v6 01/20] lib: fdtdec: Handle multiple memory nodes
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

On 2026-10-29T05:07:18+11:00, Yao Zi <me@ziyao.cc> wrote:
> lib: fdtdec: Handle multiple memory nodes
>
> Current code only tries to fetch the first memory node found in
> fdt tree and determine memory banks from multiple reg properties.
>
> Specification allows multiple memory nodes in devicetree, rework
> fdtdec_setup_mem_size_base_lowest and fdtdec_setup_memory_banksize
> to iterate over all memory nodes.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Signed-off-by: Yao Zi <me@ziyao.cc>
>
>  include/asm-generic/global_data.h |   2 +-
>  lib/fdtdec.c                      | 127 ++++++++++++++++++++++----------------
>  2 files changed, 74 insertions(+), 55 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
