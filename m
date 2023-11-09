Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09864C4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 01:16:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B380871FC;
	Thu,  9 Nov 2023 02:16:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="E53Ipkrd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8805C87113; Thu,  9 Nov 2023 02:16:04 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3178871CD
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 02:15:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5437269a661so2975898a12.0
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 17:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699492548; x=1700097348; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SNEbMFH9ihmtFhXMhpxtgf/QZNCoh90dXVLQSV6GPX4=;
 b=E53IpkrdlWtYnVYCaNzT2QpR6GutxSA0aerlTT/LWFW8tZP25ejN5kM+5IoPHY+NAY
 5f3/pEyK5m0vRy7o3tARjHC1pixUB/8NoqTpwNzZSrNAa+cdKzKC/RZNgmtOgPc5oV5s
 ZEEr55DHTD7SOwNlJpGCU+D3wQiYl66Mq4Qks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699492548; x=1700097348;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SNEbMFH9ihmtFhXMhpxtgf/QZNCoh90dXVLQSV6GPX4=;
 b=aGHf2QCtB7YIQgLFY/adiVgzQmiTBOzdsD7Hi7lw+oqZl2st9GgvlxoTjXNqclIX24
 xqmEb+abGQd1zZbp8DMM4eWUEmpmb5yH0L5Zr9wuy9D19oENZIJvPYhNemUGWgejih8S
 ntL86B3RbIyV9EPF8D0KKH0xA0AdCKa2A8SfN8e98u9fALxMBZC2bXblCThRTV8Bs0YT
 6SKZ8NJ2bs25+tT7rPv2/LWOLeC02bjcie4zgWUffArMZ1g9wjsiHvMVq0ihSI4ophji
 3wTSUsAq3FRd3LGtA86hsgdPWUsvihFQKgadPnYlMdP7WO1u50XjqsLItQK1z2S9nGvj
 UbOA==
X-Gm-Message-State: AOJu0YxYm8fjmM8KvoDY0FPVGnnywLuNaMxWcaPciwuQpYidISwyIMNj
 Goslz3dcgEJ8svBi0SRyOGhyDnMqVYQJ3ZOYWONrSw==
X-Google-Smtp-Source: AGHT+IEpFsH9jdvVwSa2GHVrbAoDjdukRvuMgPk8P2jK3B0sN/hctw+bBROVrZ6r6IKQ2X0pI74dwLA1eOHzq6rjDUI=
X-Received: by 2002:a05:6402:502:b0:545:50e9:828 with SMTP id
 m2-20020a056402050200b0054550e90828mr503243edv.13.1699492547772; Wed, 08 Nov
 2023 17:15:47 -0800 (PST)
MIME-Version: 1.0
References: <20231108164858.3497420-1-seanga2@gmail.com>
 <20231108164858.3497420-9-seanga2@gmail.com>
In-Reply-To: <20231108164858.3497420-9-seanga2@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 8 Nov 2023 18:15:30 -0700
Message-ID: <CAPnjgZ2D37cgM87H1qxa-0oV5zbK6aJ_vg1vGHGp_sdcg4Z+UQ@mail.gmail.com>
Subject: Re: [PATCH v7 08/26] spl: Refactor spl_load_info->read to use units
 of bytes
To: Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <marek.behun@nic.cz>, 
 Xavier Drudis Ferran <xdrudis@tinet.cat>, Marek Vasut <marex@denx.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Stefan Roese <sr@denx.de>,
 Fabio Estevam <festevam@gmail.com>, 
 Stefano Babic <sbabic@denx.de>, uboot-imx@nxp.com
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

On Wed, 8 Nov 2023 at 09:49, Sean Anderson <seanga2@gmail.com> wrote:
>
> Simplify things a bit for callers of spl_load_info->read by refactoring it
> to use units of bytes instead of bl_len. This generally simplifies the
> logic, as MMC is the only loader which actually works in sectors. It will
> also allow further refactoring to remove the special-case handling of
> filename.  spl_load_legacy_img already works in units of bytes (oops) so it
> doesn't need to be changed.
>
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
> Changes in v7:
> - Reword documentation for spl_load_info
>
> Changes in v6:
> - New
>
>  arch/arm/mach-imx/spl_imx_romapi.c | 16 +++-------
>  common/spl/spl_fit.c               | 51 +++++++++++++++---------------
>  common/spl/spl_imx_container.c     | 45 +++++++++++---------------
>  common/spl/spl_mmc.c               | 24 ++++++++------
>  common/spl/spl_nand.c              |  8 ++---
>  include/spl.h                      | 18 +++++++----
>  test/image/spl_load_os.c           | 13 ++++----
>  7 files changed, 82 insertions(+), 93 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
