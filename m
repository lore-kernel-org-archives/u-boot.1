Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4970C27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 19:13:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 178C788667;
	Mon, 10 Jun 2024 21:13:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fOepqZ92";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E208A88684; Mon, 10 Jun 2024 21:13:33 +0200 (CEST)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77CF48865F
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 21:13:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2c306e87b1fso1225901a91.3
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 12:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718046810; x=1718651610; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uorWsNuWogzzRect0K+m0ILhh770iN30dDZduPn00MM=;
 b=fOepqZ92vqlLzec64xFfu1Kn0qokDGZ53lHeZ8N08aQ2FYJdN3jBafzB++DYQqVkma
 7fHDNxrSQRl4M9DBFVrGOmYIwp4iR+YuzyADFp9EkNw8CvwND4/1RLo8eqVKY7RgQpm3
 Qnf9ogQAeYjmOQAFXlLmjD34fG8tpnzh/Ghq6eKbOhkuvZ6O3valXeekeGgb3zzF9WYd
 h/XElS5zVRv2G86TtgtMvDZj+WPklDIQvUQssyurdx9jRhVFHitXADmcEinJ0bw2xyyp
 RRL6yOG/14V/ST/njICxSZzazE3ZtxIFbDt1TaVrQJ/PMFUaDP36aFh2zFGzg/WbM9+0
 3ilQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718046810; x=1718651610;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uorWsNuWogzzRect0K+m0ILhh770iN30dDZduPn00MM=;
 b=B5rmRXeVZ2oiMU9OhTT0l5ElPm9I7G035IuoIOg6LvllDBWqVUBSyQ9iXo3gza3HJ6
 BvH7nOWg7XqTnTD7UhOjBi/wq2RDF/fqJhMj4b2COBWjjiPhpvDVHxZdynCsSkEh6Et5
 jYda/Layob05AMXNav2tRSa2SLXVusSXGmGd/tu+BjA7jz0HsKu1dr2DOr2PQSFe4Imf
 z14qYg1ro1yFSv0usmuQSt3STh+HirsrwZFdyG1r+I7Z4JW5r0OH1VPnxcQjZagCLTMz
 ORS+Lh8u7dZDZyMtDqIqAXDmsJVm13QiSfI9fUeLbTcVqG8MV0gk5wuGsqoPi0/0IZzA
 Whdg==
X-Gm-Message-State: AOJu0Yw02EFEmfrjCnQ5vemgqeciF4phck50Shl3++toICf+LveECABa
 IQV/vpvs5qcqJfgbyge44i15OKw3YlxCyo499ZcZ2C2qoKoejlaHTrGlChbRi86T5oH9aHtd8PX
 au6WYMekGDej5h5qUMI6uaD5Wmxo18nCMEvlS1A==
X-Google-Smtp-Source: AGHT+IExUDd3jFT/boNuHJleaM7tVWka452DN3BKBuQfLjAvScfEMh2/eqSO8aWWdJfR7O4Qt1CCdkbwPaBbY4ZB/1U=
X-Received: by 2002:a17:90a:68c2:b0:2c2:cda5:717c with SMTP id
 98e67ed59e1d1-2c2cda57986mr7961726a91.31.1718046809827; Mon, 10 Jun 2024
 12:13:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240605032521.1142768-1-sjg@chromium.org>
 <20240605032521.1142768-6-sjg@chromium.org>
In-Reply-To: <20240605032521.1142768-6-sjg@chromium.org>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Mon, 10 Jun 2024 15:13:18 -0400
Message-ID: <CAEfUkUKABkoHWr8i5fLNxgLAcs_7AdVYJEJj_UJj_Oby0HmwNA@mail.gmail.com>
Subject: Re: [PATCH 5/9] fdt: Correct condition for bloblist existing
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerry Van Baren <vanbaren@cideas.com>, 
 Shiji Yang <yangshiji66@outlook.com>
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

Hi Simon,

On Tue, 4 Jun 2024 at 23:27, Simon Glass <sjg@chromium.org> wrote:

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
> +        * handled with an OF_BLOBLIST Kconfig, but that caused far too
> much
> +        * argument, so add a hack here, used e.g. by chromebook_coral
>
I am a bit confused by this comment - It means you will not use OF_BLOBLIST,
but actually you are using it below. Is it a typo?


> +        * The necessary test is whether the previous stage passed a
> bloblist,
> +        * not whether this one creates one.
> +        */
> +       if (CONFIG_IS_ENABLED(OF_BLOBLIST) &&
> +           (spl_prev_phase() != PHASE_TPL ||
> +            !IS_ENABLED(CONFIG_TPL_BLOBLIST))) {
>                 ret = bloblist_maybe_init();
>                 if (!ret) {
>                         gd->fdt_blob =
> bloblist_find(BLOBLISTT_CONTROL_FDT, 0);
> --
> 2.34.1
>
>
Regards,
Raymond
