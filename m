Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06F90CCF9E5
	for <u-boot@archiver.kernel.org>; Sun, 26 Oct 2025 14:27:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4221A83771;
	Sun, 26 Oct 2025 15:27:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GVbNFB3D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA13383771; Sun, 26 Oct 2025 15:27:27 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA9A782E34
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 15:27:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-63e12a55270so5351729a12.1
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 07:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1761488845; x=1762093645; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UUp2vsJzsqICD6clq1op7qotiWBH4BSnI8O8Sol0xhY=;
 b=GVbNFB3DVjCu79LFiiOSJtnoibvRp57+cCE+iZOOTSfqiOCQPVFcw4VxrTIzzXMqeB
 9wrYKJEr8p8nneZ0TLeC4gNnU+hXPJ5E20jLKxn+T2QS00QR33686p1eZv0RT5CrYFC9
 xuvUBdC6muiGvn6+YgxDXHRZ1MhEeC2uhmASo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761488845; x=1762093645;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UUp2vsJzsqICD6clq1op7qotiWBH4BSnI8O8Sol0xhY=;
 b=XbnFJB4McJnPiyiCaL533pU8OI1WOv7hOtVrE22xeECZn1sBJv9JJ9LZL41VQJKeMs
 fnOK2Ae3FjqomLXPWFxGQ91IZsFtBsipEbfwm3gx8yS1GE52MIz0TD+Ko0CIuollp8UI
 sT+nUJtaV158UtFJ6DtCSjJr/dbP52qZhleBJVb5dw0wM45mmUG9eM8zjlkrJCbfgwve
 s1G9mL/SsZzj1Mw4Q+e7vSVPAZubc0qjGJ+TBMieFd3YEvPEpkACk6yo6IIzAnQSyad9
 xZCtNyTLSwDYNyL3DT18iqfL+ZTAP+QOw3WAsf32Xb2L6PyT5t7MLDgn0yA7jfFd2CZB
 jgBQ==
X-Gm-Message-State: AOJu0YyEaChPhFyBie7HiLiuXJGcAU4EkX6orNo+hd78HfUmDAT4j1kq
 /SXuyCi6GpNTxXAJTfxbudeYwWITtSoGbZakhpwIkVzTFU5V8FCdDeiO0OCh33ymaKuA0DYpnHP
 Bne79ZXms5pNcquEgez3dU2keZeCEhIh/jXVHPCl5EUeRi3LOfRqUJw==
X-Gm-Gg: ASbGnctyVJi103RStKdiTAkRzyuIT/0oZWRK+1ZvjfnTrTAtURTbEGjZi2OuW6i0ck5
 Y7to/66muyLp4sEauyr83fbfrP8UoLZPI7GYQnOx21izDZ0ZBsXgtrbE4Vek+ilzXeQczN4xb41
 qNQGivK2av80pJiDusvvZ8gQ/Rv6EUVs2g9D//SNXc1zTnEyRBzEELFaUzBOh5B4J1h8HIE3SvI
 R5Ijo0BlzAybzEyPp30jyJjHVBlJ/of9r+ZCZFthOW+oCLtXqsysRsXc5VA
X-Google-Smtp-Source: AGHT+IFz9rHFrjzRVsm1Fq0BVGmym42H779Zb0VrlD6aymiM25QReV200YFt0Jeq0CQdeRQFAd3TW24sv+vEFIruAp4=
X-Received: by 2002:a05:6402:40ce:b0:63b:ef0e:dfca with SMTP id
 4fb4d7f45d1cf-63c1f631889mr29737814a12.4.1761488845201; Sun, 26 Oct 2025
 07:27:25 -0700 (PDT)
MIME-Version: 1.0
References: <20251024151219.100970-1-wolfgang.wallner@br-automation.com>
 <20251024151219.100970-6-wolfgang.wallner@br-automation.com>
In-Reply-To: <20251024151219.100970-6-wolfgang.wallner@br-automation.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 26 Oct 2025 14:27:03 +0000
X-Gm-Features: AWmQ_bn4viS4wNqJJlnWv71_Lye1y2gKsvOlUkGx2tTx-kDtxxjkPoUlKPjrnJQ
Message-ID: <CAFLszTiRSOKSoogEqQz7rYaXeUu1bszBz-juApFnwvtMpDxfjw@mail.gmail.com>
Subject: Re: [PATCH 5/9] image: Fix typos in image.h
To: Wolfgang Wallner <wolfgang.wallner@br-automation.com>
Cc: u-boot@lists.denx.de, 
 Bernhard Messerklinger <bernhard.messerklinger@br-automation.com>, 
 Julien Masson <jmasson@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, Tom Rini <trini@konsulko.com>
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

Hi Wolfgang,

On Fri, 24 Oct 2025 at 16:12, Wolfgang Wallner
<wolfgang.wallner@br-automation.com> wrote:
>
> Fix some typos in include/image.h.
>
> Signed-off-by: Wolfgang Wallner <wolfgang.wallner@br-automation.com>
> ---
>
>  include/image.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

> diff --git a/include/image.h b/include/image.h
> index fc2f2487095..9a1c828416d 100644
> --- a/include/image.h
> +++ b/include/image.h
> @@ -654,10 +654,10 @@ int boot_get_fpga(struct bootm_headers *images);
>   * boot_get_ramdisk() is responsible for finding a valid ramdisk image.
>   * Currently supported are the following ramdisk sources:
>   *      - multicomponent kernel/ramdisk image,
> - *      - commandline provided address of decicated ramdisk image.
> + *      - commandline provided address of dedicated ramdisk image.

It would be better with a hyphen: commandline-provided

>   *
>   * returns:
> - *     0, if ramdisk image was found and valid, or skiped
> + *     0, if ramdisk image was found and valid, or skipped
>   *     rd_start and rd_end are set to ramdisk start/end addresses if
>   *     ramdisk image is found and valid
>   *
> @@ -739,7 +739,7 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
>   * @param bootstage_id ID of starting bootstage to use for progress updates.
>   *                     This will be added to the BOOTSTAGE_SUB values when
>   *                     calling bootstage_mark()
> - * @param load_op      Decribes what to do with the load address
> + * @param load_op      Describes what to do with the load address
>   * @param datap                Returns address of loaded image
>   * @param lenp         Returns length of loaded image
>   * Return: node offset of image, or -ve error code on error:
> @@ -812,7 +812,7 @@ int fit_get_node_from_config(struct bootm_headers *images,
>   * boot_get_fdt() is responsible for finding a valid flat device tree image.
>   * Currently supported are the following FDT sources:
>   *      - multicomponent kernel/ramdisk/FDT image,
> - *      - commandline provided address of decicated FDT image.
> + *      - commandline provided address of dedicated FDT image.
>   *
>   * Return:
>   *     0, if fdt image was found and valid, or skipped
> --
> 2.51.1
>

Regards,
Simon
