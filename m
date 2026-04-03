Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B934CC6B1D
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 01:02:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51BE183CF5;
	Fri,  3 Apr 2026 03:02:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Pa+lkD9j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BB9784056; Fri,  3 Apr 2026 03:02:48 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 182318382A
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 03:02:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-66bf6aa4858so2593944a12.2
 for <u-boot@lists.denx.de>; Thu, 02 Apr 2026 18:02:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775178165; cv=none;
 d=google.com; s=arc-20240605;
 b=GgthEtmdgbnTkMrYOYFq0GVKFoZEwj/LoZJO+PKdG2/6XpAe8rihIrKceJa8VPSCFg
 eEsP+dxma+/86Hj4QXIEY1FU4KpaG+EQ2MUU4U6ZUrD7A76BAqm/QWGffGfORKkgienk
 h8DunWqMSo58fW58yVxshU9ZpANpSvecFuBR3z48gQceH+kAESP23fX5G18ioixTLNlc
 Bbj6x9crGtLUZUD7CpWZel08pQg9BFeqa+XtQfAm2MMrq5wcyJv4TZ6yxDRulOcfNjDu
 dutjmanpBvkZ6LqPYelG80n3MHEspxLpKS7iDDQ3tjm9aulKf2hquIShfwK47U0iSVLU
 Z8eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZxZKbDj52oebJ1QAhAl1syCQ8CdjgslZPgndOb+jPYQ=;
 fh=EL/ZcCxhgAoI8dWULsj35ljp6uPAmjOcn4NyTSqMyGI=;
 b=RXihn1+PQAqiKl8Y+XKIQIoEVzLGIzDCzjEjDiIli7AncTX9yuJ4TsrOSfiPorSEpr
 M5C/cq/IagF7P7E09ch/7u7aVziXZy7aG+5TSMo6MkdNePI7jlIpt95AwKVyYMNeo9td
 Wz3byEawA96i9p6bUjOe+gtnVZ015CdJ5TNUJT4phO3MSxjsBOdXGZtxS+cbJxTY6Rfw
 AUGjaFmwA/eUuZSoXBy4Di4bntr6w/T9zId/1+u2gCdzGDpOYI+tQr8qTZJH7u/jgRmN
 d3IjjPCtn50ha8Ot8vTTQWfBRnSL5yemBr814INf5k+H4c22ROmk9cwif4/sRozbIgXh
 9LcA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775178165; x=1775782965; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZxZKbDj52oebJ1QAhAl1syCQ8CdjgslZPgndOb+jPYQ=;
 b=Pa+lkD9j8mISwzWe25LeDRCPZqv4kDGckIfE9sFRma1Amt6kfaSpVNWwWjAGsohy6L
 qwS5D2QIsL7KVj4LkFmAXZbm0xG837PQuX9KLguN9VqNkis5MiyCWFJnwLMRoD4L2SOt
 vcWpPD/+pwi8cM1SIKkWtkXonmQC7SZbRl67U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775178165; x=1775782965;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZxZKbDj52oebJ1QAhAl1syCQ8CdjgslZPgndOb+jPYQ=;
 b=GJABYtNzIorl/3VDimKjBqSAWpgahoG2PBolaE8uhnG1b+WrUR/bg+++3N8p+67A2G
 Jrc926dvog+4mYwNU89Qy5Kt1vdEVhiRk6/nIcS2pI1LIiCUu49qShNYidUt1U8hVT0N
 TYUnzgm3rc4g7zMjHgUQQe9Lnx43xNVr2NryBgAJ+S41i3T+pFlrYWjZlN+Fz87RRvGD
 87j6lq3ZdOsnrrlHOCsNyudYcRcCZclF9cfkpMERid/5bzjiDRpMzOC96sgMIBpJxn2B
 VtFTuKTS1YXGwJJsVQw/s3XdoEt591tu2cKIzGiZEGQdq4Q+rHtIBk5XK8TCF5Zz1srf
 EB7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWESMej7g4sm9WrHUJsSM2wY9AI8KVAAMxjzhJkdjAQqixX/45ULTMaBuJjTeEF4e/LSgzhu7s=@lists.denx.de
X-Gm-Message-State: AOJu0YwAxlDCXpTrd5f/EeAFvmwu5cszx0H3bz7tFTRj/4eBROaiTHjK
 DXTVSZmad4dthIReX8yVJd3GJuKtXXQNpF3radxgrZ+z3h3rQnHsbLj87sIVgN4UQsILynikil7
 FeOVTr2wiViALVO/zFwl9g7AiVsjH+KcaIoLtlBZR
X-Gm-Gg: AeBDieujZQ/Ryhgn4OMonjDSlsh28uBmdQMqvdkgNAS4HjO56rnIY4ipozHC9ZUqAGP
 eHLr/bk5HWW0QS7XY7BOwdeU5C1J6bcnjztSZyoRKIhy4ZYKTIzSNugvty9VaHNjvyc6kLOOtft
 k6plL9ZZCTbO7Y8OZTwve3QIlzpYVWZaVV0DkRfy9JIlZgu+9s9vPQHBxATxhaKFT7Uc8zlLWrZ
 kLMB6XR7rhVjB2hD/XdTj+qpUM1gi45z6Tu+IfJS0XKUNduNyFAcIHNknHbYqS0rNsfP6qAgmFq
 vfclgA==
X-Received: by 2002:a17:907:9614:b0:b9c:34f8:b969 with SMTP id
 a640c23a62f3a-b9c67b3b2aemr45139066b.49.1775178165328; Thu, 02 Apr 2026
 18:02:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260402192431.2421155-1-yan.wang@softathome.com>
 <20260402192431.2421155-2-yan.wang@softathome.com>
In-Reply-To: <20260402192431.2421155-2-yan.wang@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Apr 2026 19:02:31 -0600
X-Gm-Features: AQROBzDdIA1dnh1LejCGSM_klEkGNzQDmimtheNJnlanFa0YKOPSXDzPHC-NGaw
Message-ID: <CAFLszTiVj4tFBqPp52Du0-sbO1T+YqBzX5tVYs3WcUXEQ5yVOg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] binman: Generate preload header and sign data only
 once
To: yan.wang@softathome.com
Cc: trini+nodisclaimer@konsulko.com, sjg+nodisclaimer@chromium.org, 
 alpernebiyasak+nodisclaimer@gmail.com, 
 philippe.reynes+nodisclaimer@softathome.com, 
 paul.henrys_ext+nodisclaimer@softathome.com, 
 u-boot+nodisclaimer@lists.denx.de, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, u-boot@lists.denx.de
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

On 2026-04-02T19:24:29, yan wang <yan.wang@softathome.com> wrote:
> binman: Generate preload header and sign data only once
>
> To optimize preload generation, generate the header and signatures only
> after all data has been collected. This avoids signing the data multiple
> times.
>
> Since header_size is known upfront (from __init__), set the preload
> header size in ObtainContents() to avoid an extra packing pass when
> ProcessContentsUpdate() detects the size changed from 0 to header_size.
>
> This reduces unnecessary repacking and signing operations.
>
> Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
>
> tools/binman/etype/pre_load.py | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
