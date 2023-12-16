Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1519C41535
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 18:49:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9E0787C42;
	Sat, 16 Dec 2023 19:48:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VjPXGqNh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 550D487C7D; Sat, 16 Dec 2023 19:48:38 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B6BF87C6C
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 19:48:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5e4ee907295so8413257b3.3
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 10:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702752514; x=1703357314; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GvqpfdItUy8sBwsMBHLJAVJYWkV8nVq1InLwjv0ADYI=;
 b=VjPXGqNh+j4LzwJ+JyfBsXqXK5vIdEhIBeGb1fK3ZMnqFeX6CN4/lu6gnxpNcptqrK
 kTxth+gctt+pskJIs7b6S+kmVblZzI0IAjOLqINVSbFusXscdD67YFbi3pDHqf2voEM2
 RR0CXvHGwXplvDNbDmkgq5QumToJ/yZK6yb4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702752514; x=1703357314;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GvqpfdItUy8sBwsMBHLJAVJYWkV8nVq1InLwjv0ADYI=;
 b=Y8HZThiMpmhOMePJuWfKoO/j3qwygGMypt4zZ/9tTeF5CoZ70O/g2SZzmg2FVttguj
 golLrueexDDp/N2V9lZ6CSw961XsLuzN3hGOWfdTOWLAHSBnC03bZp/J1KUT+10Evkm9
 /Mks/okRPZ5TDYrZqaMTevDxiajukgHpQ2HJqRGBoK4TaEi1hKpPdosy6du1itSyErzg
 cfQuNi3zGOQ9EKRXdSmdB9SUXQ2ArelHdtoFDDU2LuC8vMAI0kr6XZN2gWZlKL/Tk2ja
 Vd/1irbBDO6qd5Qi0438+/LoHZv9eB3t1jqG0yK6TLjqcJdler7h43SpeVRwQKJyTqvn
 04CQ==
X-Gm-Message-State: AOJu0YyRQbZqwXpzC2qSOlRUl+48SqB50H/19z6vzYC9zGV4SrDvJz+G
 uXn82qr8tydqqB6fZpRt2XJkAr0KXVtXn8w8FCp55wgwnYLzqq6xz1E=
X-Google-Smtp-Source: AGHT+IHKNQIkOs6Pdw4tC2STExRtpcuuG3UPPe3jCF80iMfusUiZNNxNVOUqeTHcSAfwdswO25GZuXgbJq6NV/oUP0k=
X-Received: by 2002:a81:5b85:0:b0:5de:96ec:6f35 with SMTP id
 p127-20020a815b85000000b005de96ec6f35mr11105537ywb.11.1702752514142; Sat, 16
 Dec 2023 10:48:34 -0800 (PST)
MIME-Version: 1.0
References: <20231214121654.3042335-1-trini@konsulko.com>
In-Reply-To: <20231214121654.3042335-1-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 16 Dec 2023 11:45:55 -0700
Message-ID: <CAPnjgZ0nWLPC=H7FpkFhjnFB0G4+nfhxfQNxKCKQg3RrUhCQVQ@mail.gmail.com>
Subject: Re: [PATCH] global: Restrict use of '#include <linux/kconfig.h>'
To: Tom Rini <trini@konsulko.com>
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

On Thu, 14 Dec 2023 at 05:16, Tom Rini <trini@konsulko.com> wrote:
>
> In general terms, we -include include/linux/kconfig.h and so normal
> U-Boot code does not need to also #include it. However, for code which
> is shared with userspace we may need to add it so that either our full
> config is available or so that macros such as CONFIG_IS_ENABLED() can be
> evaluated. In this case make sure that we guard these includes with a
> test for USE_HOSTCC so that it clear as to why we're doing this.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  arch/arm/include/asm/arch-fsl-layerscape/config.h | 1 -
>  arch/arm/mach-rockchip/tpl.c                      | 1 -
>  arch/arm/mach-sunxi/dram_sun50i_h6.c              | 1 -
>  arch/arm/mach-sunxi/dram_sun50i_h616.c            | 1 -
>  arch/arm/mach-sunxi/dram_sunxi_dw.c               | 1 -
>  boot/image-fit.c                                  | 2 +-
>  boot/image.c                                      | 2 +-
>  drivers/timer/dw-apb-timer.c                      | 1 -
>  env/embedded.c                                    | 2 ++
>  include/bootstage.h                               | 2 ++
>  include/configs/at91-sama5_common.h               | 2 --
>  include/configs/tqma6.h                           | 1 -
>  include/env_internal.h                            | 1 -
>  include/u-boot/ecdsa.h                            | 1 -
>  lib/rsa/rsa-verify.c                              | 2 +-
>  test/dm/scmi.c                                    | 1 -
>  tools/mkeficapsule.c                              | 1 -
>  17 files changed, 7 insertions(+), 16 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
