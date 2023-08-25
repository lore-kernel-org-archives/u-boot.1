Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA423C3DA6F
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 18:08:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DDE286B33;
	Fri, 25 Aug 2023 20:06:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bZ0jehmY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8C6786B5C; Fri, 25 Aug 2023 20:06:30 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D06C986ACC
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 20:06:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-4ff8cf11b90so1861595e87.1
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 11:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692986787; x=1693591587;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=r7IEZYJt/+WQ++/Z7kQZFxiSLcV7Sx0IPtQN/cgz9MA=;
 b=bZ0jehmY/CKkBaxcZ0ti5PBk7SZkoHoE1q0O6TbAEZMLXf+2fu5ExTe4NWttwcmWKx
 ZyXmWHZsKFVQ34fPr2w3S7udL6oSYUxlU3wsiOVXYpjuXUZ/3+ArshRmN0U5BtwJKSrY
 aNKCAq0D+VDF3ygFhZzmMcvXTEUTjvdUyMl9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692986787; x=1693591587;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r7IEZYJt/+WQ++/Z7kQZFxiSLcV7Sx0IPtQN/cgz9MA=;
 b=S4RPkkclTM1Tnzj1qiWGxfAehg4qrRS/UMET5Cf3524cquFqvdM/ljtYAD9WCD2k8E
 Qi9vTjKgKuFmVaGm8RCeqWOHOx2b6WqZ/ZiMQoQ1/zvhs5muxJEC3Qz4nL/77XB9X5k0
 pjsYl7lRp/50Y+EBQ4A7sL0lqE5DmclYbdd+oc/lphqzWToOby6YAqCQ7WcmV9Dpi1Av
 PClEj5erlCZ/K5Gn/CppGNdwlxvQcDAdiH0E81bSuHfEfnqachdJs81mF7xaj59G0Zrq
 QowMVgHtgvfuodBz6fzCOXDMKwPY5gWWwoSb7d0XeOGV9BW2ji1DpqX7PffibuH4iYBi
 aodg==
X-Gm-Message-State: AOJu0YyYnUMXs1uyj21HTqZlufzBP+EZz2TItRyhOHD1hJpeX+jzIAh2
 RixuFLOhO3jaleOmjl5fDJGaTl4Snsmu6yuEiL9J/Q==
X-Google-Smtp-Source: AGHT+IGUyepU1ELPSc4WBO9uAKyWKuLNGmJwQmR+FDHYnLX6PNl8PRII3KQitjcuHx0/N7mdAx+LgJsKiDClBbGNo/E=
X-Received: by 2002:a19:381b:0:b0:4fb:9050:1d92 with SMTP id
 f27-20020a19381b000000b004fb90501d92mr12224412lfa.51.1692986786960; Fri, 25
 Aug 2023 11:06:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230825081014.341987-1-roman.azarenko@iopsys.eu>
In-Reply-To: <20230825081014.341987-1-roman.azarenko@iopsys.eu>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 25 Aug 2023 12:06:13 -0600
Message-ID: <CAPnjgZ0z2fi1b=+hVDVnz_DfA+ku=+1wP1n6ehxGNmtkO7CCHg@mail.gmail.com>
Subject: Re: [PATCH v2] tools: ensure zeroed padding in external FIT images
To: Roman Azarenko <roman.azarenko@iopsys.eu>
Cc: u-boot@lists.denx.de, Massimo Pegorer <massimo.pegorer@vimar.com>, 
 Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>
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

On Fri, 25 Aug 2023 at 02:10, Roman Azarenko <roman.azarenko@iopsys.eu> wrote:
>
> Padding the header of an external FIT image is achieved by truncating
> the existing temporary FIT file to match the required alignment before
> appending image data. Reusing an existing file this way means that the
> padding will likely contain a portion of the original data not
> overwritten by the new header.
>
> Zero out any data past the end of the new header, and stop at either
> the end of the desired padding, or the end of the old FIT file,
> whichever comes first.
>
> Fixes: 7946a814a319 ("Revert "mkimage: fit: Do not tail-pad fitImage with external data"")
> Signed-off-by: Roman Azarenko <roman.azarenko@iopsys.eu>
> ---
> v2:
>   - Use memset() on `fdt` instead of ftruncate() on `fd`, zero only
>     the part that will become padding in the new FIT file.
> v1: https://lists.denx.de/pipermail/u-boot/2023-August/528213.html
>
> I'm trying to be a bit smart here and only zero out the amount of
> padding that we actually need, but no more than the total length of the
> old FIT file (not to cross the boundary of the mmaped region).
>
> See v1 for info on how to reproduce the original issue.
> ---
>  tools/fit_image.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/tools/fit_image.c b/tools/fit_image.c
> index 9fe69ea0d9f8..d9da0ce8388f 100644
> --- a/tools/fit_image.c
> +++ b/tools/fit_image.c
> @@ -497,7 +497,7 @@ static int fit_extract_data(struct image_tool_params *params, const char *fname)
>  {
>         void *buf = NULL;
>         int buf_ptr;
> -       int fit_size, new_size;
> +       int fit_size, unpadded_size, new_size, pad_boundary;
>         int fd;
>         struct stat sbuf;
>         void *fdt;
> @@ -564,9 +564,13 @@ static int fit_extract_data(struct image_tool_params *params, const char *fname)
>         /* Pack the FDT and place the data after it */
>         fdt_pack(fdt);
>
> -       new_size = fdt_totalsize(fdt);
> -       new_size = ALIGN(new_size, align_size);
> +       unpadded_size = fdt_totalsize(fdt);
> +       new_size = ALIGN(unpadded_size, align_size);
>         fdt_set_totalsize(fdt, new_size);

I didn't know that was allowed...I thought it needed fdt_open_into() ?

> +       if (unpadded_size < fit_size) {
> +               pad_boundary = new_size < fit_size ? new_size : fit_size;
> +               memset(fdt + unpadded_size, 0, pad_boundary - unpadded_size);
> +       }
>         debug("Size reduced from %x to %x\n", fit_size, fdt_totalsize(fdt));
>         debug("External data size %x\n", buf_ptr);
>         munmap(fdt, sbuf.st_size);
> --
> 2.42.0
>

Reviewed-by: Simon Glass <sjg@chromium.org>
