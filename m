Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FAB2CFB446
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 15:24:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB97C88D5D;
	Mon,  7 Oct 2024 17:23:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ItamfzAW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FA9088D5B; Mon,  7 Oct 2024 17:23:55 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08E6988D7F
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 17:23:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-710de2712eeso1511937a34.3
 for <u-boot@lists.denx.de>; Mon, 07 Oct 2024 08:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728314631; x=1728919431; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tKhm4VGJlDz3yTGoW/fB+4ZYw4qU2ZboFyhRGl3thhs=;
 b=ItamfzAWuWhyKxmXNDEgPrPUGjkXFMRbF5J4YDVg39raTJTJ6tfXn+lr2M0FzQcGs8
 N7LRdG15WjLWyVXNU3ho3VH1v3zwskSlGY6y7o5+NUFEpmEyA3/ZT/LprOceuaIBTars
 0VvifLOz/Nvq1jrEtPCD9OSOFibmP5hOpmZso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728314631; x=1728919431;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tKhm4VGJlDz3yTGoW/fB+4ZYw4qU2ZboFyhRGl3thhs=;
 b=hqK3LDW6vWeBFbO/gdEM+Lpd4J6pPjKn89MecK6BerZon1bi4JI2GKWCt8iKzaKcTK
 dR/ivc+E80WUJgEssxQL6C1c3ULwYK2TdQQ4HIq0mYP/LT1shnKhKhcdlYymH5XmUBPL
 K2sJFyhlS/p6AdFBrra05rAGwwgv0GBNd8EouNRX2R4T8hPMoCasoSbH3j9yfWz2F/gU
 kLnsl5ft7LVU60u4c3Nc/2QmE9fYjVCnpfHxaWF8ZcMFeVBsDW7BBrcKYAQUCUmG4jc2
 DCgnKhIFZ5QuNvq58rlL3GPOZS+KxEs7TgHYyucOGgI3Uzxtq8dZHfyArLeVMpZ7b2Vo
 THQg==
X-Gm-Message-State: AOJu0YxBqyQaw4Ur7ExYDBXxKMejj3liq80LNT/8qiYU3hJX/3+FB7t8
 1a6zLk2Cadae69NQOw39VnWTUnLD3+FhSYZuF62n0ywbctkT0i8IUnUhYnx+eXnriSbIfFEmFbE
 dO/OIP31qHK2uGlhTwXmUfa5p8jyZ2Qb49Rq2
X-Google-Smtp-Source: AGHT+IGpmVq6B50i9WewPXuTay2sGC/xfdL3R8xwHTwlXPaR0frFwWM57D8l427E3kQdMAXZHMCvtNuFqWFBEzHXiJI=
X-Received: by 2002:a05:6358:3119:b0:1be:acbe:5141 with SMTP id
 e5c5f4694b2df-1c2b7f9ae00mr164320955d.11.1728314630710; Mon, 07 Oct 2024
 08:23:50 -0700 (PDT)
MIME-Version: 1.0
References: <20241004001118.322531-1-marex@denx.de>
In-Reply-To: <20241004001118.322531-1-marex@denx.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 7 Oct 2024 09:23:40 -0600
Message-ID: <CAFLszTiMNeU__kzyRR-3qKPUUKaXEqaypf8YYQgxL83E-2gt3g@mail.gmail.com>
Subject: Re: [PATCH v2] dts: Deduplicate dtbs target
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@linaro.org>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Fabio Estevam <festevam@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jonas Karlman <jonas@kwiboo.se>, 
 Lothar Rubusch <l.rubusch@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Stefano Babic <sbabic@denx.de>, Tom Rini <trini@konsulko.com>,
 u-boot@dh-electronics.com
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

On Thu, 3 Oct 2024 at 18:11, Marek Vasut <marex@denx.de> wrote:
>
> The dtbs: target is almost identical in all architecture Makefiles.
> All architecture Makefiles include scripts/Makefile.dts . Deduplicate
> the dtbs: target into scripts/Makefile.dts . No functional change.
>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
> Cc: Caleb Connolly <caleb.connolly@linaro.org>
> Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Jonas Karlman <jonas@kwiboo.se>
> Cc: Lothar Rubusch <l.rubusch@gmail.com>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Stefano Babic <sbabic@denx.de>
> Cc: Sumit Garg <sumit.garg@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@dh-electronics.com
> Cc: u-boot@lists.denx.de
> ---
> V2: Add RB from Sumit
> NOTE: I am sending this separately
> ---
>  arch/arc/dts/Makefile            | 9 +--------
>  arch/arm/dts/Makefile            | 8 --------
>  arch/m68k/dts/Makefile           | 9 +--------
>  arch/microblaze/dts/Makefile     | 9 +--------
>  arch/mips/dts/Makefile           | 8 --------
>  arch/nios2/dts/Makefile          | 9 +--------
>  arch/powerpc/dts/Makefile        | 8 --------
>  arch/riscv/dts/Makefile          | 9 +--------
>  arch/sandbox/dts/Makefile        | 9 +--------
>  arch/sh/dts/Makefile             | 8 --------
>  arch/x86/dts/Makefile            | 8 --------
>  arch/xtensa/dts/Makefile         | 8 --------
>  dts/upstream/src/arm/Makefile    | 8 --------
>  dts/upstream/src/arm64/Makefile  | 8 --------
>  dts/upstream/src/xtensa/Makefile | 8 --------
>  scripts/Makefile.dts             | 8 ++++++++
>  16 files changed, 14 insertions(+), 120 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
