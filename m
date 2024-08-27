Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6115EC5320E
	for <u-boot@archiver.kernel.org>; Tue, 27 Aug 2024 06:28:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D752888618;
	Tue, 27 Aug 2024 08:28:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DXwd35xc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E3E7888F0; Tue, 27 Aug 2024 08:28:25 +0200 (CEST)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08E7988618
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 08:28:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-202089e57d8so32570725ad.0
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 23:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724740101; x=1725344901; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zYdBVp+/VY3Z+qK/oYDv8LCiSdF6f7DuMuXakjJL9Ok=;
 b=DXwd35xcwBtyZBqcwe7nNsKCfebe9RtUR1F7XSj5a30+feydgdz+tHlpszoYDB5CVp
 XkK2LJNlILH4LGk0BD148iXvRmAktsm10ICQjyZwzbo7sNMnLmBoN+d8nxMFSDJRwhd/
 95LQUZcKA2KdsiMxnB8inND83xfwo7opL8ckSEsJ+/OUXqpSxJHydhD9bs5gVemokazZ
 J6dPS9yDgAQZ5K5cw1vY9p58VZy3KuAl3663JXo5427eEmg3h6m0iVd9buukedPJY4uL
 /yHhBGQrYlNhtMXTA52+h8OR9LKij50Lm+atGIPAoV/G6WNnj5yL/Yf7Hb0TsUkxHojz
 k34g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724740101; x=1725344901;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zYdBVp+/VY3Z+qK/oYDv8LCiSdF6f7DuMuXakjJL9Ok=;
 b=VIDgJKPSOqgMA1ikfzufTQKM2cZg3P44+T3S84Kyr+HA8kuROu40Nkyi2BNNQ9ElgO
 8Ui/q6OL5u0yI8BT7CoVCgVSGkxrkwwa0htdxE1vzdcE+UV8SIjie+wIYYX0GtCpsC52
 91MU405DpCBRhZGkEato2tQ/Rj0FUiEMz2N83jEnPbs4M7q+ev0w9J0u1J4lGZ53YmXW
 q4m3zdH+I3z1NQNZoYe7S7rVQSzuVafF3YkSAA8ikmB9d1akwzdFCBDqzIx9Tt/s31iS
 d8ryY3fGehp3y6ZEOYjt6dMrdaMxTBU+Cmc0qT0RRbra4mh5Xtt7uiAF/zDHmhWhS/EV
 pdYQ==
X-Gm-Message-State: AOJu0YyWpBTqWww+iIRdoYSR0jT5gS0l5Cu5OzoW4S33KKYMKeECTMwv
 PSmHFaKBo86eK2Dhwd1r4tc4KISjEzLPd5YEpXZ31gsRnB4YE0VdYQkfFtmvXJG0Ky3XfTkBcox
 EUwC8Amu6rht7AfTkrvXSF/DNUTfkAoFJ5uWrtQ==
X-Google-Smtp-Source: AGHT+IEGD8AxV8JJ5tVBO1lDDhdH+yJxFp9a8Gk0+B33/h8/qtf5Uy6znauEV/qBkPEWut/ADxjmA2h14bkbpJROn+g=
X-Received: by 2002:a17:902:f74e:b0:1fc:4acb:3670 with SMTP id
 d9443c01a7336-204ddcea966mr24658485ad.12.1724740101246; Mon, 26 Aug 2024
 23:28:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240826115940.3233167-1-sughosh.ganu@linaro.org>
 <20240826115940.3233167-16-sughosh.ganu@linaro.org>
In-Reply-To: <20240826115940.3233167-16-sughosh.ganu@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 27 Aug 2024 09:27:43 +0300
Message-ID: <CAC_iWjLbb_Nr0yEH-W=V8hGKXovdh5_4x9vqtmxZWtXFip=4eg@mail.gmail.com>
Subject: Re: [PATCH v4 15/27] lmb: init: initialise the lmb data structures
 during board init
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Michal Simek <michal.simek@amd.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>
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

On Mon, 26 Aug 2024 at 15:01, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> The memory map maintained by the LMB module is now persistent and
> global. This memory map is being maintained through the alloced list
> structure which can be extended at runtime -- there is one list for
> the available memory, and one for the used memory. Allocate and
> initialise these lists during the board init.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
> Changes since V3: None
>
>  common/board_r.c | 10 ++++++++++
>  common/spl/spl.c |  3 +++
>  2 files changed, 13 insertions(+)
>
> diff --git a/common/board_r.c b/common/board_r.c
> index f445803d7a..a60da39a29 100644
> --- a/common/board_r.c
> +++ b/common/board_r.c
> @@ -22,6 +22,7 @@
>  #include <hang.h>
>  #include <image.h>
>  #include <irq_func.h>
> +#include <lmb.h>
>  #include <log.h>
>  #include <net.h>
>  #include <asm/cache.h>
> @@ -510,6 +511,14 @@ int initr_mem(void)
>  }
>  #endif
>
> +static int initr_lmb(void)
> +{
> +       if (CONFIG_IS_ENABLED(LMB))
> +               return lmb_init();
> +       else
> +               return 0;
> +}
> +
>  static int dm_announce(void)
>  {
>         int device_count;
> @@ -612,6 +621,7 @@ static init_fnc_t init_sequence_r[] = {
>  #ifdef CONFIG_CLOCKS
>         set_cpu_clk_info, /* Setup clock information */
>  #endif
> +       initr_lmb,
>  #ifdef CONFIG_EFI_LOADER
>         efi_memory_init,
>  #endif
> diff --git a/common/spl/spl.c b/common/spl/spl.c
> index 7c6e322ffd..ad2dc6a908 100644
> --- a/common/spl/spl.c
> +++ b/common/spl/spl.c
> @@ -721,6 +721,9 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
>             IS_ENABLED(CONFIG_SPL_ATF))
>                 dram_init_banksize();
>
> +       if (IS_ENABLED(CONFIG_SPL_LMB))
> +               lmb_init();
> +
>         if (CONFIG_IS_ENABLED(PCI) && !(gd->flags & GD_FLG_DM_DEAD)) {
>                 ret = pci_init();
>                 if (ret)
> --
> 2.34.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
