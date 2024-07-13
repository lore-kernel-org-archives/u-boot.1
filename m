Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2894AC3DA45
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 15:19:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AD178891F;
	Sat, 13 Jul 2024 17:16:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GuApgcYo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D20F18885D; Sat, 13 Jul 2024 17:16:20 +0200 (CEST)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36E1888932
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 17:16:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2c961b5f215so2113758a91.0
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 08:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720883776; x=1721488576; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aPIqSnLy1i+0omUjby06MpkpQDbmBs6xBi5VFSfLAf8=;
 b=GuApgcYowad3h4YvHi8w7tr3vOBrLyMaj9j9Qx1ytIlQJ4umAkEDFXpr8bjfUWt1x4
 3R4vS7dFR5ifOtxpAIfWgeO+Jz86p+frolrZPGSQBhwnNCvTK5cwIyo34tycHyvr3MSc
 L7zlhO8GlS8/LmsX/i1i/ZLbk2uRlwrAyWu1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720883776; x=1721488576;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aPIqSnLy1i+0omUjby06MpkpQDbmBs6xBi5VFSfLAf8=;
 b=eAVlA29uOUZ4wRjkTcvxuQql1EkafQrvBdIJlso4nmS0kBNWmjmJwihzfbnVW/skTu
 irQgqAcpuWVnBHxzc7QWbUD62rviSGHZLQ88qgM3ch+j3pmKEkIGiiqtsy2Hjet2G2RC
 jKWAyzpuLmUlRbywgpDlqVQtqf30DdRwFn2MMJUafXavoAobCx/q4LCUmTPutFs9eDYw
 2bbB8l8vLg4dWyyx+XvKiqBZxQoKx3Uc1H4+94ffTq3JsZrHnmSNhnxJqOGPM/mO7gvO
 tzo78l6CfU0o+3/17u4IvLQvx5UDFFJb2I0LUAlmEDNwk90rbrja18uS3lYjIl6gjMG3
 HYNQ==
X-Gm-Message-State: AOJu0Yz94eQI8id7F4eFq8uP1dEsgXlU/4QxZrqYFOFyTjz5Y5LaDuLI
 Vo/fBWAoCtuZaU9Zx5NYunPapbj2CqExHj7eIPZDtOxZwRPaHf9b4enNebTYFKRixPqkRtOh+cq
 +TeMlW1iwJIBmtaKbqsVWaHhyCRIziebmxtAV
X-Google-Smtp-Source: AGHT+IHwQVBwrsfNtwZXWkr0d5VNnB2B9grbxVhuD/CcpBWShd8ZZCF5Rb0j82IRQKRdcgKKRoY75hRZPO8lpoU5ZsM=
X-Received: by 2002:a17:90a:a385:b0:2c9:9f06:bb2f with SMTP id
 98e67ed59e1d1-2ca35bdc2d5mr11229507a91.6.1720883775815; Sat, 13 Jul 2024
 08:16:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
 <20240704073544.670249-20-sughosh.ganu@linaro.org>
In-Reply-To: <20240704073544.670249-20-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 13 Jul 2024 16:15:58 +0100
Message-ID: <CAFLszTgMEnv2d4AnYidd5SUWjMMwx_ETo=ULtG6TFXvO=umqFg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 19/48] lmb: remove the lmb_init_and_reserve()
 function
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>, 
 Fabio Estevam <festevam@gmail.com>, Michal Simek <michal.simek@amd.com>
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

On Thu, 4 Jul 2024 at 08:37, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> With the changes to make the LMB reservations persistent, the common
> memory regions are being added during board init. Remove the
> now superfluous lmb_init_and_reserve() function.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V1:
> * Removed the replacement of lmb_init_and_reserve() with
>   lmb_add_memory(), as memory gets added during board init.
>
>  arch/arm/mach-apple/board.c          |  2 --
>  arch/arm/mach-snapdragon/board.c     |  2 --
>  arch/arm/mach-stm32mp/stm32mp1/cpu.c |  3 ---
>  cmd/bdinfo.c                         |  1 -
>  cmd/load.c                           |  2 --
>  fs/fs.c                              |  1 -
>  lib/lmb.c                            | 13 -------------
>  net/tftp.c                           |  2 --
>  net/wget.c                           |  2 --
>  test/cmd/bdinfo.c                    |  9 ---------
>  10 files changed, 37 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
