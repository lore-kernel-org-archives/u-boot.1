Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A58ACCFA02
	for <u-boot@archiver.kernel.org>; Sun,  2 Nov 2025 19:54:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0C828392C;
	Sun,  2 Nov 2025 20:54:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dp3Jm4KN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1105483923; Sun,  2 Nov 2025 20:54:37 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0024F838FA
 for <u-boot@lists.denx.de>; Sun,  2 Nov 2025 20:54:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b4aed12cea3so697814866b.1
 for <u-boot@lists.denx.de>; Sun, 02 Nov 2025 11:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1762113274; x=1762718074; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DyB2UJiZs+kDRGX5zpfR6uyVVNcdcLbaN8IZGd/Grns=;
 b=dp3Jm4KNVF1bjYhsblEx1zK88EnBal14oxsTPmXiqJX0OD0FgwGFQxiO6f3NUh6niN
 08Bh3rtijj5Q2Vu/ETBFIZnc76hwj0+6DVbOnEh/1IXlZUn+JdlGNrG6iPmify25hfAx
 w04koVMmKcsTHbGmAGYHfB/yKuG+jve2/5Bz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762113274; x=1762718074;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DyB2UJiZs+kDRGX5zpfR6uyVVNcdcLbaN8IZGd/Grns=;
 b=QcoOH715Mo34FGpCT6lGA4IA0jdwBET+k0ZIvyOykDIF8YzQw0D5CuAHSkb8Erdy6C
 HZeLC2HxrT//ZGoT6kh9TQR9ksOoCVDTLMBWyrP7qffraRUA3daGIqBEVdxQjdJ8gWwn
 i1QVvW2Fh5Y906GMT4CQJUxbWD+eFd3QGmqWJJ2KU4w/6hsYv5gLCXqWhtHu0WEtc7E+
 Gy7t/HrGz8lV1YYqji9KmBFNrTjGENHmYSa5BkWH8gHVQ3Y4b3YjJqfUOYaT4cauFoV1
 qMvhW8CLopt9t9C0gAs3joK5vxMml4V7VKMvPSVSlUcOjU+XFF9KEOrRqnIMqQXGIDcW
 lB8Q==
X-Gm-Message-State: AOJu0YyYWzhQNmh/XyqpS29/VcsHJTlaAi9c3stCj57/jX4an5WWpYAF
 ogjVauG2e67MoO83wmOA5LJOGgJolewIsJANAPSgnQfQ1J0X4TEhXp5wu73sOcTYRCkslEjt1Ql
 3HGGWOX2911l7FLb/FLV+Wf9RbwFFkBIrITRxVgPm
X-Gm-Gg: ASbGncsZhXFQPzJatRG+q1o8Ke5witabUx9YzrEckr7jI6EDUsUplC2q5P11m/T8va/
 7h2vld4NCryfBMsRZ0rTbbAhbHNar2Zt7p8f7S/SC2j+Ze+kKhDB1WAxQnaIc2+J823J+BYrBZE
 iPLD6QJvP8ZztpiVKKSXH8k7z2Yg8Z1O8tH7EvCW7pkVYj7cvO6Hmj4KknO6nJPe2jU9Le/kLq8
 qDFtsL84TJxbJc6IZGcLE0k90HY1cLcdtqFUobDUVuuUUOwGJM/Gkubrs3zCLZZQzU1/sn+
X-Google-Smtp-Source: AGHT+IHFenZiTBzNjX0xys42Scw8/tUFkaW0aw5YRdNIWntO0z252pRYot3ORoE8nmxyrEf/UvpXC/OEG1Q2nAUbtFk=
X-Received: by 2002:a17:906:a24f:b0:b6d:6c8f:6af6 with SMTP id
 a640c23a62f3a-b7070139726mr869727766b.16.1762113274466; Sun, 02 Nov 2025
 11:54:34 -0800 (PST)
MIME-Version: 1.0
References: <20251031-binman-engine-v1-0-c13c1b5dac43@cherry.de>
 <20251031-binman-engine-v1-1-c13c1b5dac43@cherry.de>
In-Reply-To: <20251031-binman-engine-v1-1-c13c1b5dac43@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 2 Nov 2025 20:53:53 +0100
X-Gm-Features: AWmQ_blVZkB9yv-xpY5RLAqum_MeiTJrWiqkDbTxANEhr8VheaOYC04keT0Exjo
Message-ID: <CAFLszTiT1O7jFeyKaquCdjuR-CoQJuuQiFz6SyZ4TnONRS1TjA@mail.gmail.com>
Subject: Re: [PATCH 1/3] fit: support signing with only an engine_id
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Aristo Chen <jj251510319013@gmail.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Shiji Yang <yangshiji66@outlook.com>, Anton Moryakov <ant.v.moryakov@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>,
 Bryan Brattlof <bb@ti.com>, Quentin Schulz <quentin.schulz@cherry.de>
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

Hi Quentin,

On Fri, 31 Oct 2025 at 16:23, Quentin Schulz <foss+uboot@0leil.net> wrote:
>
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> Currently, when one wants to use an OpenSSL engine to sign a FIT image,
> one needs to pass a keydir (via -k) to mkimage which will then be
> prepended to the value of the key-name-hint before being passed as
> key_id argument to the OpenSSL Engine API, or pass a keyfile (via -G) to
> mkimage.
>
> My OpenSSL engine only has "slots" which are not mapped like
> directories, so using keydir is not proper, though I could simply have
> -k '' I guess but this won't work currently with binman anyway.
>
> Additionally, passing a keyfile when using an engine doesn't make sense
> as the key is stored in the engine.
>
> Let simply allow FIT images be signed if both keydir and keyfile are
> missing but an engine is to be used.
>
> The keyname member is already filled by looking at key-name-hint
> property in the FIT and passed verbatim to the engine, which is exactly
> what is needed here.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  tools/fit_image.c  | 3 ++-
>  tools/image-host.c | 4 ++--
>  2 files changed, 4 insertions(+), 3 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

but it might be worth creating a static inline function in the header file
for the condition, since it is pretty long now.

> diff --git a/tools/fit_image.c b/tools/fit_image.c
> index 0306333141e..694bb927c7d 100644
> --- a/tools/fit_image.c
> +++ b/tools/fit_image.c
> @@ -26,7 +26,8 @@ static struct legacy_img_hdr header;
>
>  static int fit_estimate_hash_sig_size(struct image_tool_params *params,
const char *fname)
>  {
> -       bool signing = IMAGE_ENABLE_SIGN && (params->keydir ||
params->keyfile);
> +       bool signing = IMAGE_ENABLE_SIGN &&
> +               (params->keydir || params->keyfile || params->engine_id);
>         struct stat sbuf;
>         void *fdt;
>         int fd;
> diff --git a/tools/image-host.c b/tools/image-host.c
> index 21dd7f2d922..54df86316ae 100644
> --- a/tools/image-host.c
> +++ b/tools/image-host.c
> @@ -696,7 +696,7 @@ int fit_image_add_verification_data(const char
*keydir, const char *keyfile,
>                              strlen(FIT_HASH_NODENAME))) {
>                         ret = fit_image_process_hash(fit, image_name,
noffset,
>                                                 data, size);
> -               } else if (IMAGE_ENABLE_SIGN && (keydir || keyfile) &&
> +               } else if (IMAGE_ENABLE_SIGN && (keydir || keyfile ||
engine_id) &&
>                            !strncmp(node_name, FIT_SIG_NODENAME,
>                                 strlen(FIT_SIG_NODENAME))) {
>                         ret = fit_image_process_sig(keydir, keyfile,
keydest,
> @@ -1366,7 +1366,7 @@ int fit_add_verification_data(const char *keydir,
const char *keyfile,
>         }
>
>         /* If there are no keys, we can't sign configurations */
> -       if (!IMAGE_ENABLE_SIGN || !(keydir || keyfile))
> +       if (!IMAGE_ENABLE_SIGN || !(keydir || keyfile || engine_id))
>                 return 0;
>
>         /* Find configurations parent node offset */
>
> --
> 2.51.0
>

Regards,
Simon
