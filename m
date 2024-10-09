Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42123CF042E
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 01:58:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6EDE89116;
	Wed,  9 Oct 2024 03:57:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KyriPOun";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7D0B890F7; Wed,  9 Oct 2024 03:57:02 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1C5E89118
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 03:57:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6cb3bbb9cf5so55570216d6.1
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 18:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728439020; x=1729043820; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5z40Jgb8BRVlkUOaZ2U7UYVGd5VO7LzCXYLlHsJei3A=;
 b=KyriPOunja3HX4g7UZu/Hv8v9AABEOoYqxvVJ0ig7JEy8BFLEi5SvXO9PsAp2WaBZ6
 iU4nb7kU3CENRp0I8pHd1lcxqCcJKGChGWDBgnKjTSb4e4bVvCI3WiidCijvZoc58tv5
 UIYdbgjAJ+ISH7pRtdoSjkrd7Jl1i6opC5fBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728439020; x=1729043820;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5z40Jgb8BRVlkUOaZ2U7UYVGd5VO7LzCXYLlHsJei3A=;
 b=DbG795o5g3jbRhQEBfyoh/8pO7OKXj+ZSwLOS1MwCbD1CF80s80xd83VYmU8xpKPGA
 g5rpAXn9rOe7+R07ZF0fswDYzKKHtMwYHdJ/EfyqoCDDwzWwjYtCEUMEHUZA121qRSMK
 gN5uffgitLdjaotiZPsM1M7k3PMulfchs8KJWgP9+s8++zLF7iYIiHFdsp+mONNl1eYK
 zDoL1SsrzLxlAgSgtekNrj+C2+qmfXceAYipyFQptCnP6kJENDoXJ++eev+Q5+EKGc5v
 RsgUdOTKrzwRZJpePA7sHdCoBq3YTiD2Zd/8u9ZsJOMAveC0BdUY2Y673eMPsyd5ZWfD
 Zsog==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYdMgJH2LyUfMCzd6fQqDMbtGBMwI+zFjhdL2VomNPXqsthJzJcYArxBS4GW/b3RM3k0YZozo=@lists.denx.de
X-Gm-Message-State: AOJu0YxwNqydsU8fraGbQxGqliXr2rbB8em4wvdXd0ZGGO1FznsTfJiA
 Jyyz/WqjMrj315TaNWTSi7pkHmEFtXyLUfDBOhNsaoJjbdw0EVHAoeOTbCB9mW1K6R5sI0Ln4Qq
 pVSb+FqTbKBMh2tAxKBBtnXklOdv6AU4FyJNr
X-Google-Smtp-Source: AGHT+IG2ERqvRVU4O4kM5KzsxQ2TzTzPu9ZIynDW6OMvoWTnLDLQh6wKT6tS+Pup43nCaxtqKW4kkbDh50HSjhs5oSg=
X-Received: by 2002:a05:6214:5b85:b0:6cb:a067:8598 with SMTP id
 6a1803df08f44-6cbc955e83bmr27015716d6.33.1728439019650; Tue, 08 Oct 2024
 18:56:59 -0700 (PDT)
MIME-Version: 1.0
References: <20241005191429.1927741-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20241005191429.1927741-1-andriy.shevchenko@linux.intel.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 8 Oct 2024 19:56:45 -0600
Message-ID: <CAFLszTg=iFAjzRouQ48ZoBc0GH4qFz4ZT_24QxwQvujGYGzokg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] cmd: irq: Move do_irqinfo() prototype to a header
 file
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sat, 5 Oct 2024 at 13:14, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Move do_irqinfo() prototype to a header file, otherwise compiler is not
> happy:
>
>   arch/x86/lib/interrupts.c:130:5: warning: no previous prototype for =E2=
=80=98do_irqinfo=E2=80=99 [-Wmissing-prototypes]
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  cmd/irq.c          | 3 ---
>  include/irq_func.h | 3 +++
>  2 files changed, 3 insertions(+), 3 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
