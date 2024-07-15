Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97B0EC3DA59
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 13:35:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A066388950;
	Mon, 15 Jul 2024 15:32:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Df8HAOp1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDA5D88927; Mon, 15 Jul 2024 15:31:56 +0200 (CEST)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6FBB888CF
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 15:31:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-79f1b569ab7so255339285a.3
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 06:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721050314; x=1721655114; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kusLbx5+1dCEiO6aYkzN7JncsCLDvIVD3LUj96c53h4=;
 b=Df8HAOp18Gpqwk5H0NwLA5Tbq/aMTqMz4Kgbi5eMFYJ6MxoBWEBmxRj4VRcideQ2Ts
 PPjGJrQngio7a4cOzSbHp2Ho9bgR04rGmJcWNyfuHgCQ501ixzXdBHnOyFrb1ZyPAQeR
 MbdE7D6ZVyXkALbTJx9II9jSpZf/EhFrv65VY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721050314; x=1721655114;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kusLbx5+1dCEiO6aYkzN7JncsCLDvIVD3LUj96c53h4=;
 b=Q3rYl8+n+v0GXfZ8refAAlZRR9VhYv/jF05zvL4d6AscyQOaBbfcZc/kaJorylmgf7
 p1JhKmHYBsydzvGOUVRdwNqohGp6ZEn3QPuPwt+mdVcY06jFKWnxdvtSJ7ZvdahuyH5d
 Xd+7CVl/685f78FqkrmrbrvhujP6e+IOfg0QJpVx7VOO1FE6MEN8mjOf1q2T+Mna7oMR
 fAzKRHEsGci7GCkAO8RmiMMRq7CjlW4zObq544g405QMFYJKAJj0RI1TrPyge8h64jDM
 GSC8x64BLHfIVBu8jI8jvZeRb03xxgSVCBOB9YEny+gdeMmjDvQ0HgKYmlWVdoQUW0RD
 /kWg==
X-Gm-Message-State: AOJu0YzNb9aRP+2lGUwjwW6PfwcthTAznYlhc3L0ocBrVeNgAf69DULv
 qSWS0L5GgzMQXiGJNbVCyGTBq+X9C6QQt8hyEjKG1TRJLis9eRE+1aA5yoqgdZ4zwLoQ/IAeJ93
 wYSnY+7zpq1I5mEEFaTB9QAZiOJrohYJT/PhL4pUtex5/e48=
X-Google-Smtp-Source: AGHT+IF8gWKgnujL3QmZdVHFY9AG81nzapdE/VB3/e9Lz9vl/UntSh1nNNMJrcQljMq6ENg+O1xS/Ob0Kcnuoq9HdQQ=
X-Received: by 2002:a05:6214:27c7:b0:6b5:8f79:7bc with SMTP id
 6a1803df08f44-6b61bc803d9mr207991506d6.1.1721050313810; Mon, 15 Jul 2024
 06:31:53 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 15 Jul 2024 06:31:53 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAFLszThQPiyH+3L07=aufMLocL3YGiHaL20LMCvmx=BV28+7NA@mail.gmail.com>
References: <CAFLszThQPiyH+3L07=aufMLocL3YGiHaL20LMCvmx=BV28+7NA@mail.gmail.com>
 <20240527200417.2108290-1-rasmus.villemoes@prevas.dk>
Date: Mon, 15 Jul 2024 06:31:53 -0700
X-Google-Sender-Auth: XRy36uULgSuixqahF_eXSGGi-Q0
Message-ID: <CAFLszThy6mjfxOc_OwJGU-4+=pikODsvV+AzFw1ozZTeFiZmeg@mail.gmail.com>
Subject: Re: [PATCH] global_data.h: drop write-only field dm_root_f
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
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

On Mon, 27 May 2024 at 14:04, Rasmus Villemoes
<rasmus.villemoes@prevas.dk> wrote:
>
> The dm_root_f field seems to be entirely write-only and hence
> redundant, unless 'git grep' fails to find some access generated via
> preprocessor token concatenation or similar.
>
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> ---
>  common/board_r.c                  | 3 +--
>  include/asm-generic/global_data.h | 4 ----
>  test/dm/core.c                    | 1 -
>  3 files changed, 1 insertion(+), 7 deletions(-)
>

It is used for accessing the pre-relocation devices in case that is
useful / possible. But it seems that we haven't had many use cases, so
I am OK with dropping this and adding it back later if needed.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon

Applied to u-boot-dm, thanks!
