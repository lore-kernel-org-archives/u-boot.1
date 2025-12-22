Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F890E674B2
	for <u-boot@archiver.kernel.org>; Mon, 22 Dec 2025 13:32:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 543F483B99;
	Mon, 22 Dec 2025 14:32:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="d3QRIBzx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CAD683C28; Mon, 22 Dec 2025 14:32:54 +0100 (CET)
Received: from mail-yx1-xb12c.google.com (mail-yx1-xb12c.google.com
 [IPv6:2607:f8b0:4864:20::b12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F2AF83B95
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 14:32:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-641e942242cso3084067d50.1
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 05:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766410370; x=1767015170; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bVQFq2Ben8EWJGKJuNIDB2SI6i/yhLM1jISdSoPV158=;
 b=d3QRIBzxWQhFEfQ+SK+28CTOG4qiUZu+oIuBj7um6stusOBap/k7RuHK1otH1LFQzg
 TGN6iK7LTtKTl9n405UD6yevE4c3PtgIB5IlQK+WYoKr6dFq9yFzaeZK8p7Ugmujhypm
 6v2Mcw4LlFsSDXwn1XTMS20g08B8nwPhj1LDxUs++edYBNePJFSr4qXvhSorEKtgMQp9
 QM0wS8mPjo3knyKHZPv9jQpgTZPpdSVjUWnnPHA2yB2LFCHlSSlqXmIUDYaDhrLDdApw
 8Xdm+3Jy8qLQ2LT9718HZgWpgTrwmwqhJk0tslqtsqzNHKwK9+XwO2MKkrysK10hCr+P
 cpsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766410370; x=1767015170;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bVQFq2Ben8EWJGKJuNIDB2SI6i/yhLM1jISdSoPV158=;
 b=I7SQIwFWd+HhoncE6f3yrdsvFQfivu73Pv4XpCxY2gh2CgO5RXuDtvAa7CrFgy4f50
 zgPUOG8m1w0aP91SVAI6bl2CiwXiGiqbTmoKvQFBsUVjQbKQhNV/PMnXeZ+k9GiuEFgU
 McndfiD3u8/aYU4AhUa/mUFSjyyw7Bv1jmNgTHrAwaQXcbO3COVldF5eHMrfbk8+042e
 31Fbiu0GPKdZqOZgm3IHBctt8y9FIAt9Krwj/3SjforON9Fu/vxvtKWiupKy7FBdlJOO
 Bpxj2pxpI7lr6cWNTGYiCuxCbDNjazfvS7VDPxLDggylHffHEiZ6v72MCK/5jgOu/HZA
 pHLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU94duBUu49WH8j0xIsOCrfpuoiPodRZ3G/Q+HuzWeZY3Gl9QxcQjcRk1TBN7Un/9nEVPBOtCk=@lists.denx.de
X-Gm-Message-State: AOJu0YxMry9+iQGjL6fs2P64CktLt+qlsu5Uh8ZptaIz5TGFijLKy+cl
 BO/z9+kbIpLjGYBtSO+qg2IlY577JeocsYGpJS+pBMs0zKSl4HMuml1t+QEImlu1d1dXuqJG7vO
 g8zXBZPvKKaExLV2ckwQJZDriOpK+7d7mXxD84GK14fIndrvt/fXsj8nc4Q==
X-Gm-Gg: AY/fxX6mNZWxKwn6DEBoEOEUoUNHXj8WPHD8ZCJZdqdJrCFpafg5zJbJZOBPmvNdP7G
 2jDsAh9wvsiWLgfTG8u/DFhqbDX7XraFrRAVjL9eySEeYWopJKvltrjXfarXF2PAghkJIFWEB97
 DubrPkujIPIDiioP/suc4KqUklobrctGgFfH3L0efYNThaoXuYVu/eMu0n5L10bPGihtkdHXojW
 JCch9yc7Ufq/dzB8huVTbA3H8EMiC79rHDf7nY7Ha0qiaphiN7XwHpf+P6b4lE8vWf3u8a0yNMo
 AVcwAPlFjCfwcR9d5JjvUpLQt21Y0ojGT6uRLVx51MQjjxZwNAj/tGckYzBp+imuSPblzcE4ECx
 +3mRbV9GS1ca5DW/Nd3AhLuagV5DfBy0JFX6U1/kIWFGrpux16O/fmsl+NY5aCDz3+mjHDuvaQ4
 jgTtolFQXaCBo7eXa7Nh9ZRirFAPvEvoQg4eMvYvp9Dyk9RJVgDeZAVlbQsMAZb8orvA+fHRfXl
 rY+6h2+PQ5gRiTZa9KQ2RhIoD8DWkUKmj4HOL2TkPQeIaexl5VZHbcqoorjfc8I9PqYjh063EIZ
 3yK7wDo+L3sCbuih5Q4O6y851HPpzPve
X-Google-Smtp-Source: AGHT+IHONyroy84WKNzP7kTkD59NYw6qjyoEiLOS8md4ERnVLj7fWEA2nRkodguv7SINFqmlQcf2+tLLrXW0fzWging=
X-Received: by 2002:a05:690e:1502:b0:644:60d9:866b with SMTP id
 956f58d0204a3-6466a9265a2mr7495060d50.92.1766410369726; Mon, 22 Dec 2025
 05:32:49 -0800 (PST)
MIME-Version: 1.0
References: <20251219224326.195190-1-heinrich.schuchardt@canonical.com>
 <CAC_iWjL94aX+9dGfYsG6ut0MSXB97Ta_C20nkj1SEeQGiErSiQ@mail.gmail.com>
 <1626dd9c-30ca-4275-9688-b79a8110ba01@canonical.com>
In-Reply-To: <1626dd9c-30ca-4275-9688-b79a8110ba01@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 22 Dec 2025 15:32:13 +0200
X-Gm-Features: AQt7F2qndArtGkVWYSY2Q9AHqMz-fo-sdMzYDobuiDpEyV49_V0jAMPyAix8t60
Message-ID: <CAC_iWjLN_KdLtH46pbqCawJ0Fd5vAPAb3_xoiWP=TN3ee7cXxQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] test: The LMB test depends on CONFIG_LMB
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Mon, 22 Dec 2025 at 13:41, Heinrich Schuchardt <
heinrich.schuchardt@canonical.com> wrote:

> On 12/22/25 09:17, Ilias Apalodimas wrote:
> > Hi Heinrich,
> >
> > On Sat, 20 Dec 2025 at 00:43, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com
> > <mailto:heinrich.schuchardt@canonical.com>> wrote:
> >
> >     We cannot build the LMB test without the LMB library.
> >
> >
> > This was always building LMB. do we need to adjust any Kconfigs with
> > this change?
>
> We should be able to enable CONFIG_UNIT_TEST on any board.
>
> Many boards use CONFIG_LMB=y but not all, e.g.
> amd_versal2_mini_defconfig. Building this board with CONFIG_UNIT_TEST=y
> fails:
>
> aarch64-linux-gnu-ld:
> test/lib/lmb.c:411:(.text.test_noreserved+0x428):
> undefined reference to `lmb_free'
>
> With this patch on top there is no build issue.
>

Ok, please update the commit message when merging

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>
> Best regards
>
> Heinrich
>
> >
> >
> >     Signed-off-by: Heinrich Schuchardt
> >     <heinrich.schuchardt@canonical.com
> >     <mailto:heinrich.schuchardt@canonical.com>>
> >     ---
> >       test/lib/Makefile | 2 +-
> >       1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >     diff --git a/test/lib/Makefile b/test/lib/Makefile
> >     index 7c9dc180c8d..f25383a40e5 100644
> >     --- a/test/lib/Makefile
> >     +++ b/test/lib/Makefile
> >     @@ -16,7 +16,7 @@ obj-$(CONFIG_USE_PRIVATE_LIBGCC) += test_ctz.o
> >       endif
> >       obj-y += hexdump.o
> >       obj-$(CONFIG_SANDBOX) += kconfig.o
> >     -obj-y += lmb.o
> >     +obj-$(CONFIG_LMB) += lmb.o
> >       obj-$(CONFIG_HAVE_SETJMP) += longjmp.o
> >       obj-$(CONFIG_SANDBOX) += membuf.o
> >       obj-$(CONFIG_HAVE_INITJMP) += initjmp.o
> >     --
> >     2.51.0
> >
>
>
