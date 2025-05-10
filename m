Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFF2DC3ABC3
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 11:26:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBE6582AB9;
	Sat, 10 May 2025 13:26:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="c+fJStPi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C5B0829E7; Sat, 10 May 2025 13:26:18 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E70E982B48
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 13:26:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ad1a87d93f7so489036766b.0
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 04:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746876374; x=1747481174; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=s4WFbbKRVPYz2+ayBUf5bsJFScd6XfrF4bz2gf3YAoM=;
 b=c+fJStPiaMMPqda7osCVzsl/CGQ1nhYg820XgwwHrIa5lbRtwCTTTYP4p+BM+Y61Ku
 gqqBWMWLK2GMgPVv+a9k8w79kcKRFgtPo1BQZ+VxTGNzjbtTJyAo+FKWi4jQO+ocB4GO
 PIxAiq6ebpatag0aZM1SwSyaYA6ihepqBlHZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746876374; x=1747481174;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s4WFbbKRVPYz2+ayBUf5bsJFScd6XfrF4bz2gf3YAoM=;
 b=T8M650FBpk0ScMSuYuC8SwR3vxKliMd3yGodhROChCqUXpmLmkNWLZLN3gfgZ/t+nx
 wapWYLqxKVS6zWu5QgSIFPc2cYgJPlA7qBF7OKjqhW2ozZqldZ3+GiV76Q60/WunReBT
 kXOfw3QwhpX9/3kBJduiaJoqijQBsbQzSbpRJ2jhFerlkjIj+F1xSjq4M7JpraR+rNJX
 6CcJF2KtQEtRrJ6P55pRlaaOyp9OoN8NjP5utIzgT2C9hw+DpgTkqzpQbItWIPzd8F1V
 vlSxxcirFV1p636alZRcCnaaUgaNRwjR3vw09uTiuNYOOWN0YCzkq3ludMTloQEfRgxQ
 srkA==
X-Gm-Message-State: AOJu0Yw/PE5w5O/ChWtXxS2gLRJ2WAwasNOZmktHiJ5CPW/qeAziHYL7
 STXyUzI3ONvdmmokkwI7IKANvJJLx77MAF4j6qekWg8jvyUCrAIuRsUzXd5b5/8mg6YT6lvaxSX
 2Zfx6NK948rYyidy/+31bkMEIf6SN51hrx40z035nzuyUpwq4gzO7m78TDQ==
X-Gm-Gg: ASbGncsfnRqdCq/Bi76NfW6CKTG13UWb/AbSfx4PE4eUm/bYr8MFbmj25a5bhdUpfQB
 ooXxQGx6J5eSh9nDgMQcnSsLR45i6eWgu/jwYTvqZbn9+JV3zYdFZlUuac+RJaZLuSbKq5ljpHy
 7KO+ormmMRWEzJno0UnZ7g4uipqbG+K2yDrQ==
X-Google-Smtp-Source: AGHT+IGrIfHfhhOUXZ6UuqyEvtpOjl0i0WxC/nPTyWdF5Xy8C4hl1d3L2/z9FZ6LMj4IcpmrRHDukoFSaIo7obazsD8=
X-Received: by 2002:a17:907:6a14:b0:ad2:16aa:cadf with SMTP id
 a640c23a62f3a-ad218f1ba67mr701189766b.22.1746876374396; Sat, 10 May 2025
 04:26:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250506141035.385756-1-ravi@prevas.dk>
In-Reply-To: <20250506141035.385756-1-ravi@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 10 May 2025 13:25:41 +0200
X-Gm-Features: AX0GCFtpxqnenl8djcaAAFjajs58_q-8uYE031cS-88khE3KtyAgtSPEZgA4CYg
Message-ID: <CAFLszTheniFQ04L2aJ1v77zv7ws0ASAXDZbABpamXx+PADMiXw@mail.gmail.com>
Subject: Re: [PATCH 00/11] regex patches
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Tue, 6 May 2025 at 16:15, Rasmus Villemoes <ravi@prevas.dk> wrote:
>
> This started as a rather simple patch, 1/11, adding the ability to
> more conveniently do regex matching in shell.
>
> But with that, it became very easy to see what the slre library can
> and especially what it cannot do, and that way I found both outright
> bugs and a "wow, doesn't it support that syntax" gotcha. I couldn't
> find any tests ('git grep slre -- test/' was empty), so I added a
> small test suite and tweaked slre.c.
>
> Rasmus Villemoes (11):
>   cmd: test: add support for =~ operator
>   slre: add myself as maintainer
>   test: slre: add tests for regex library
>   slre: drop wrong "anchored" optimization
>   test: slre: add more test cases
>   test: slre: add some (negative) character class tests
>   slre: refactor is_any_but()
>   slre: fix matching of escape sequence used inside character class
>   test: slre: add test cases for escape char in character class
>   slre: implement support for ranges in character classes
>   test: slre: add tests for character ranges
>
>  MAINTAINERS       |  7 +++++
>  cmd/test.c        | 19 ++++++++++++
>  include/slre.h    |  1 -
>  lib/slre.c        | 78 ++++++++++++++++++++++++++++++++---------------
>  test/lib/Makefile |  1 +
>  test/lib/slre.c   | 58 +++++++++++++++++++++++++++++++++++
>  6 files changed, 138 insertions(+), 26 deletions(-)
>  create mode 100644 test/lib/slre.c
>
> --
> 2.49.0
>

For the series:

Reviewed-by: Simon Glass <sjg@chromium.org>

Thank you for doing this.
