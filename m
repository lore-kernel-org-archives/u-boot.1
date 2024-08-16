Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77DE1C52D7C
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 01:35:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F7BA88AD4;
	Fri, 16 Aug 2024 03:34:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GZ+4THwu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48D8388AB9; Fri, 16 Aug 2024 03:34:57 +0200 (CEST)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C69788A54
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 03:34:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-7a264a24ea7so1209029a12.3
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 18:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723772087; x=1724376887; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pQlMfhNA3gVpYNu6sflOVvU81JLeIK84mvysgcU6eyM=;
 b=GZ+4THwustiM+zR27SUKPgCh2Z9Pn83oJCnIGmrTFRSBbGnOpaeQOVK3ETcmqci+NM
 gMOzxavZYMKmyEWiGYqakZa8qJkAWlge4fb0l4eG3qCNFvP1hKWTbGqbSqbBesqSRcJ6
 VYG1+3OXOtzHwc0h3VawF+QcUjHaEsARpnp+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723772087; x=1724376887;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pQlMfhNA3gVpYNu6sflOVvU81JLeIK84mvysgcU6eyM=;
 b=I3PmkJisU38kmwbDw2KE7Lp3tDQxZ8Qq0h2WeF+tu9aHCUJDq53n0k5u1gV2eLMDjr
 ZB6yt+cEmUALZSQC99iPlLqsxTNKJ11UC3WNKnnb8p6r9NiBeuSywo30Zqq5MeM3h5Xm
 HqYQAfTgmofd8Tg80ndns2K3oh+dnL925JXwQu77k5WcLLoKRsPhaHAxm+Kfn30XASub
 v7x3neLMu+Rj+nIRVq1N5mTXOrlgaeHB7iVpA/2seQ9iNMkOylFuFdy6ON/Uf4/ny5C9
 wmIE8UGdJtYBVeUoY/xPBuZ7iIMX5AEL3Y9Yd0kLfOoOHKr5hyuzD3ZGByDczHBxYuO6
 Ok8g==
X-Gm-Message-State: AOJu0YyRGpeiM5DZVA1D9mZcARRlfoTy0YkZl48XiPd+cJVybMw1rJdW
 DYVRMiJ9Ygn3u0Xt7ym2SwmUCootfQ/pXVai3avxq4E5qCmB8krqKrqBMvdPFF4D7omY4s8nNxH
 2gUWUdPNrER1/miTm4UQW6JE+CG5hXrDeqkbiOlIvaF7Pr3A=
X-Google-Smtp-Source: AGHT+IGZrZ2PeFHCoQVfl29WE9i+tIsjMpd81Ixc3t5xLFydf2+vEotSB4JgdBJ+1e4lrW/z1ciFbti3egn+ZKwPJrA=
X-Received: by 2002:a17:90a:ea07:b0:2d3:b976:e30e with SMTP id
 98e67ed59e1d1-2d3e00f091emr1689619a91.37.1723772086745; Thu, 15 Aug 2024
 18:34:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240816004819.635938-1-seanga2@gmail.com>
In-Reply-To: <20240816004819.635938-1-seanga2@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 15 Aug 2024 19:34:34 -0600
Message-ID: <CAFLszTj3gczLgH6bStA+ULUU5_AjYnC=nvv5zMMV4RC0dAQKXw@mail.gmail.com>
Subject: Re: [PATCH v2] sandbox: Fix pinmux warnings with non-test devicetrees
To: Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
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

Hi Sean,

On Thu, 15 Aug 2024 at 18:48, Sean Anderson <seanga2@gmail.com> wrote:
>
> The sandbox pinmux driver is used in the non-test devicetree as well as
> the test one. I didn't realize this when I modified the driver for
> tests, and so broke the regular use case (which only resulted in
> warnings). First, making the pinmux and the UART group available in all
> boot phases to avoid ENODEV errors. Then, convert the pin groups and
> functions to the new style, adding onewire group as well.
>
> Fixes: 7f0f1806e3a ("test: pinmux: Add test for pin muxing")
> Closes: https://source.denx.de/u-boot/u-boot/-/issues/2 Please enter the commit message for your changes. Lines starting

Something strange there ^

> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
>
> Changes in v2:
> - Only add the pinctrl node pre-relocation, as SPL/VPL try to run dtoc on all
>   nodes included in their device trees.
>
>  arch/sandbox/dts/sandbox.dtsi                | 14 ++++++++------
>  drivers/pinctrl/pinctrl-sandbox.c            |  4 +++-
>  include/dt-bindings/pinctrl/sandbox-pinmux.h |  1 +
>  3 files changed, 12 insertions(+), 7 deletions(-)

Regards,
Simon
