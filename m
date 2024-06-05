Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6F33C25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 05:33:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 617DF882ED;
	Wed,  5 Jun 2024 07:33:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GX6lR1NL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A2B4882E0; Wed,  5 Jun 2024 07:33:06 +0200 (CEST)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC499879F3
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 07:33:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-6c3b5c5e32cso3633062a12.1
 for <u-boot@lists.denx.de>; Tue, 04 Jun 2024 22:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717565582; x=1718170382; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Dq+DkJ9riTO+/z6VK2YFie9h/xC1HSr9fu3BwcbiHuU=;
 b=GX6lR1NL6slgVBf9cM3ulQSYX33QvaXG2F5c421bdfHOAju653ZqjjJZ8aQ9ofWI8+
 sRHrM2vQ8EVbsMZ1XQXNTO8bCSn1UaqDqdBYAggjY6m5f2bnqc+VoCXb7y1hVCtTTFaR
 bewul1FadDQUtsqQulbPkt1eRPrcfkIRqA5B3h23aKxbDbTD91LOYRXdW9K+fCSWfhlQ
 SQQH82vEd9m/AIE7yVvBV3P1SuCRQDmjR8j3Zu218PqE3ymBiArP8wVlphsga54+k1en
 cRenRWHurFWfbBKDDOu+FK6wyPI07iCFGA4ajXweHj4BmyPHamJITt83LsWQbP7cLr2f
 /UkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717565582; x=1718170382;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Dq+DkJ9riTO+/z6VK2YFie9h/xC1HSr9fu3BwcbiHuU=;
 b=uzIw3NK6D5lEsO9VLvBJHb3LjmH7vLA9PXJ0g9yDGL3pVRitZv2TWxzFUeOc140Se/
 CL/NuRcDQcPLmnHdRgmH0wW95tCYVR/J/qwNjfzpS6+gwlIoFOs/L2hWn2rCaD+r2vPJ
 /oACZe+DDf0KwR6afjF76WDqdooKIBfBgXUqMP3L9oehoj/Px1E1+26mqw9xSLMeIEme
 KF9Xrqm8tIkBu4vmBHEVNMtG0FlhS5gcxt1nm0/rOI8pg5Lp01wg6GGcGXQeJuS2RaIv
 dqWg/qFBL86H4qJ0PA3abCi+YeA0GdIZL9Us7tDBqbt9iirMS3Ecd1pWWBxIaWipKwDn
 iwQA==
X-Gm-Message-State: AOJu0YyH+pZqC8W8dz2Ib6oN8ulGjPsReFOowwVyPpbI/7MBr6DEDPy4
 QE95UAzXsf+YTAz8cDV58ZFaHrFUkHaUC9lChKChH7cSX1zOqeeGk1DD3kBGYVeEMOiQzth1lai
 bYUEz0gKeF/VeknMgyiLoZsOsPEOzGkYrU1qTPw==
X-Google-Smtp-Source: AGHT+IFv6Vgf7SFFpf8/h9ST3T0W3LkkPcwTxu9fzVKNDIoGCxJrKys8+APNnOLTG9X7vV1qAxBUT1vq3VfYKiloRVo=
X-Received: by 2002:a17:90b:188f:b0:2c1:c648:14d2 with SMTP id
 98e67ed59e1d1-2c27db003cdmr1604473a91.1.1717565582357; Tue, 04 Jun 2024
 22:33:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240605032521.1142768-1-sjg@chromium.org>
 <20240605032521.1142768-6-sjg@chromium.org>
In-Reply-To: <20240605032521.1142768-6-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 5 Jun 2024 08:32:26 +0300
Message-ID: <CAC_iWjK6CKheBax2VxL4JydJqLzus9UF5hNMqMXtscqebxKuwQ@mail.gmail.com>
Subject: Re: [PATCH 5/9] fdt: Correct condition for bloblist existing
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Jerry Van Baren <vanbaren@cideas.com>, Shiji Yang <yangshiji66@outlook.com>
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

Hi Simon,

On Wed, 5 Jun 2024 at 06:26, Simon Glass <sjg@chromium.org> wrote:
>
> On some boards, the bloblist is created in SPL once SDRAM is ready. It
> cannot be accessed until that point, so is not available early in SPL.
>
> Add a condition to avoid a hang in this case.
>
> This fixes a hang in chromebook_coral
>
> Fixes: 70fe2385943 ("fdt: Allow the devicetree to come from a bloblist")
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>  lib/fdtdec.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> index b2c59ab3818..b141244e3b9 100644
> --- a/lib/fdtdec.c
> +++ b/lib/fdtdec.c
> @@ -1669,8 +1669,16 @@ int fdtdec_setup(void)
>  {
>         int ret = -ENOENT;
>
> -       /* If allowing a bloblist, check that first */
> -       if (CONFIG_IS_ENABLED(BLOBLIST)) {
> +       /*
> +        * If allowing a bloblist, check that first. This would be better
> +        * handled with an OF_BLOBLIST Kconfig, but that caused far too much
> +        * argument, so add a hack here, used e.g. by chromebook_coral
> +        * The necessary test is whether the previous stage passed a bloblist,
> +        * not whether this one creates one.
> +        */
> +       if (CONFIG_IS_ENABLED(OF_BLOBLIST) &&
> +           (spl_prev_phase() != PHASE_TPL ||
> +            !IS_ENABLED(CONFIG_TPL_BLOBLIST))) {

The same condition exists in common/bloblist.c.
Carve out a function --e.g

bool can can_enable_bloblist(void)
     return ....

instead of open coding that

Thanks
/Ilias
>                 ret = bloblist_maybe_init();
>                 if (!ret) {
>                         gd->fdt_blob = bloblist_find(BLOBLISTT_CONTROL_FDT, 0);
> --
> 2.34.1
>
