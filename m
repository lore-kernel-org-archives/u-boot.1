Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2024FC3DA49
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 23:34:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 737E188580;
	Fri, 26 Jul 2024 01:32:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mny1wvid";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73E948855B; Fri, 26 Jul 2024 01:32:53 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92B6D88453
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 01:32:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3d6301e7279so274575b6e.3
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 16:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721950365; x=1722555165; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MaX0nsbQzzbw5f1KOj4BqUeuOy8Qk7O3FdotxeYksX0=;
 b=mny1wvidaeA5/tYyLoBMwfXwzsVsA5lJ6Iq762oCEwUuKfxmCUwZjDu/AMMafdxMRF
 dTnbaNNzNUcVYF/7/SekiGlmVpNm0hb1HZ2uoXLqhRBNwfXL79iWGxhx8h9QmQnLUqE+
 5Eb60aH+8fsIkTgfRkBxN9D+yax8KXlJzKT5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721950365; x=1722555165;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MaX0nsbQzzbw5f1KOj4BqUeuOy8Qk7O3FdotxeYksX0=;
 b=qh7ysK/nAPHP/J4Sl0dHYnXqSgFmEpIZ2p9p91nz8vtWiEney2ejZrT4+O4KYj3e1Q
 e8pBVHt3ImChsFFnzPVWb11lNeuC8ic8mAUbfxaBwnZZLZ/z9XSgV+4vOYfWTQQyYjBv
 ko0N468GlAuC6IRt9QRQNLYj8ZA8J1mzgduiZOLItAQpbHUyUGF7uzZ2BS32LeMGBIzG
 C8z/3Hpnz9ZdRhVWgMHCePG3Wh2X3HRYRDdrwFMeC96ZIka305OKBYGtPKk1489EMred
 6rZM+lMpzIeHYF03oSbnESHjS2OkWm4TnTlflBYwbixd0v/5SgNQc9XgH19p1WH2lNXM
 L3Ig==
X-Gm-Message-State: AOJu0Yz5einU3zpfK3rMwZUWnkMCrtxZsmA9Gs7DW+7mnIs624Ws998H
 mNY5ER1VDkL1funyybJoP4jCAG3U6Uk0Fd4Ce9/SNXjc/yXzevvv8jtvuAc9S99asvFSWgB9l0g
 sGTfL1vZpRzzbcMW0as8dJEMxi8uRDxru1cp9
X-Google-Smtp-Source: AGHT+IHBZBdX/M9oAG984phzzg8iVUNK/FAmHpyG08RF7SvvJvYyLqGhvAPNiumkAA4cPuyYPjR8Sk4TQD9c0AQDm5U=
X-Received: by 2002:a05:6358:6486:b0:19f:5a42:d2bd with SMTP id
 e5c5f4694b2df-1acfb98751bmr375063155d.22.1721950365249; Thu, 25 Jul 2024
 16:32:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-28-sughosh.ganu@linaro.org>
In-Reply-To: <20240724060224.3071065-28-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 25 Jul 2024 17:32:34 -0600
Message-ID: <CAFLszTiKg2kw1HGcCqcyWgjMsXmSCGKAtOzKStduNEvUR=iZSg@mail.gmail.com>
Subject: Re: [PATCH 27/40] spl: sandbox: initialise the ram banksize in spl
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Michal Simek <michal.simek@amd.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>, 
 Max Filippov <jcmvbkbc@gmail.com>
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

Hi Sughosh,

On Wed, 24 Jul 2024 at 00:05, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> Initialise the ram bank information for sandbox in SPL. This is needed
> for initialising the LMB memory map as part of the platform init.

I don't understand what is going on here...you are moving code into a
function and should explain why.

>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since rfc: New patch
>
>  arch/sandbox/cpu/spl.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/arch/sandbox/cpu/spl.c b/arch/sandbox/cpu/spl.c
> index 9ad9da686c..22cd916685 100644
> --- a/arch/sandbox/cpu/spl.c
> +++ b/arch/sandbox/cpu/spl.c
> @@ -121,6 +121,15 @@ static int load_from_image(struct spl_image_info *spl_image,
>  }
>  SPL_LOAD_IMAGE_METHOD("sandbox_image", 7, BOOT_DEVICE_BOARD, load_from_image);
>
> +int dram_init_banksize(void)
> +{
> +       /* These are necessary so TFTP can use LMBs to check its load address */
> +       gd->bd->bi_dram[0].start = gd->ram_base;
> +       gd->bd->bi_dram[0].size = get_effective_memsize();
> +
> +       return 0;
> +}
> +
>  void spl_board_init(void)
>  {
>         struct sandbox_state *state = state_get_current();
> @@ -128,10 +137,6 @@ void spl_board_init(void)
>         if (!CONFIG_IS_ENABLED(UNIT_TEST))
>                 return;
>
> -       /* These are necessary so TFTP can use LMBs to check its load address */
> -       gd->bd->bi_dram[0].start = gd->ram_base;
> -       gd->bd->bi_dram[0].size = get_effective_memsize();
> -
>         if (state->run_unittests) {
>                 struct unit_test *tests = UNIT_TEST_ALL_START();
>                 const int count = UNIT_TEST_ALL_COUNT();
> --
> 2.34.1
>

Regards,
Simon
