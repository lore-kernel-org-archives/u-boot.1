Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE720C41535
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 18:48:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D153D87C1B;
	Sat, 16 Dec 2023 19:48:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jhjXLVHI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17C2287B4D; Sat, 16 Dec 2023 19:48:20 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 129788745E
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 19:48:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-5e45405bda9so14329967b3.1
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 10:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702752497; x=1703357297; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/eE3hG7yntz1EAhYH6ibfMxdjp+VqSc1td0gN5Mjw7c=;
 b=jhjXLVHIz4mag+eZM/otWnJgOk+Ns0ykMqBjJheZTcbuvPcDUsxKR+e0coqa0rNrPf
 bFuSrnu+Z29OklnFmQo+IjJDRYj26qlK/iLRmIg/+eKnVqWrmEexjiMenDLDn6oH0say
 TSgPB6eOdEq5zaNs5tFxf6ojMKL0qJDCV/s2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702752497; x=1703357297;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/eE3hG7yntz1EAhYH6ibfMxdjp+VqSc1td0gN5Mjw7c=;
 b=RzCF38DdaprStnyizkexWBI3O/4523lHJSatryPwbdmGbclTdgecZVvtWGKgepNJSv
 dqKSgQhVNupqolimrlwCBh5q2hyKFWAd4BbMtOQd7al1DAbjfojilIGjT+/ujJXAWuyV
 RI6B3u8fx44Oj5BRgtTQ4mK8e8ZvKkkG4OkNKFfq386aFQBtGOvW+oZyqtRUdgvKTyGZ
 9LKBbwfHyyNPL0CZmGou6er3Phacvq/TmGve9PSJyU2PWtIGxM7iSy+lZ2VdYj2RHdtR
 oLwJmAklDRcDAwr4ODtXmKIiLJ4GFGog9D7hVppnzgEzNnl9GToh283jqxfbwwAbPgPh
 rAtQ==
X-Gm-Message-State: AOJu0YxyuWw/3u8RfARWpUeWsYwXhVX9xAsZ03B5OGRwgHGfclxVnRA1
 cQzRLpzN6H/I1b6pgW+9CdNjw41N6mG4yYSlXv+ey7RiWq0vH7SxaAw=
X-Google-Smtp-Source: AGHT+IGBIyyGXunzsJR6n91+DwnZY8UFJqaN0R56qK39wij898QBsZ9aE1bUIBBy0tPRXmaLTz2cTAwmV1t3/EZ2EHE=
X-Received: by 2002:a0d:c2c3:0:b0:5d7:1940:7d81 with SMTP id
 e186-20020a0dc2c3000000b005d719407d81mr10200193ywd.88.1702752496560; Sat, 16
 Dec 2023 10:48:16 -0800 (PST)
MIME-Version: 1.0
References: <20231216180842.173422-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20231216180842.173422-1-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 16 Dec 2023 11:46:55 -0700
Message-ID: <CAPnjgZ2rSEws8aabBt1svPm9wSkbsA4Tv9VGLmU4X=hH6SxBOA@mail.gmail.com>
Subject: Re: [PATCH] arm: Add OVERLAY command to BSS section
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
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

On Sat, 16 Dec 2023 at 11:08, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> Avoid allocating and loading the BSS section.
>
> $ aarch64-linux-gnu-objdump -Sh u-boot
>
> Before:
>   10 .bss_start    00000000  00000000000f21d8  00000000000f21d8  001021d8  2**0
>                    CONTENTS, ALLOC, LOAD, DATA
>   11 .bss          000068f8  00000000000f2200  00000000000f2200  001021d8  2**6
>                    ALLOC
>   12 .bss_end      00000000  00000000000f8af8  00000000000f8af8  00108af8  2**0
>                    CONTENTS, ALLOC, LOAD, DATA
>
> After:
>   10 .bss_start    00000000  00000000000f21d8  00000000000f21d8  001021d8  2**0
>                    CONTENTS
>   11 .bss          000068f8  00000000000f2200  00000000000f2200  00102200  2**6
>                    CONTENTS
>   12 .bss_end      00000000  00000000000f21d8  00000000000f21d8  00108af8  2**0
>                    CONTENTS

This one seems wrong to me. I would expect to see it after the end of .bss

>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> ---
>  arch/arm/cpu/armv8/u-boot.lds | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Regards,
Simon
