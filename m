Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4276E784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:44:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA87087507;
	Mon,  2 Oct 2023 03:23:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="FUHg9QTi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16F9F874C9; Mon,  2 Oct 2023 03:23:22 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58E07874CF
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:23:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-9a9cd066db5so2299666666b.0
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1696209789; x=1696814589; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SS3lReFET+aGmAGqc4LiT/SSS7WTFCZ440WVc6HZkMs=;
 b=FUHg9QTiJlWE2CHQMRVecBDKjX9+T4CoTF39ZNd165neWo84849sQMshU0O1aL/4p6
 TSVSPsyhU17ZBahe1FxT/CbdRZn5R+AkJXo0nOrX190vHSycRzB1S69G5Jg59HJdVRdO
 qkEH4qgKvefN8lRBIFK6qSj6FGO0A9XaPOWXTyMv7h3KKLNF4jHSKb+cWK3ti3U/KzrI
 giXb+NkWAWdSuW9q/secoJV1fmO5SlF2hczOgY8ZSclMH3LGOlDeb6tbDs+BIAfoM9Fq
 Mtmz+H7qaCsX0JxiNdhB5h0d7qWbxSMoL0mjtL6TNurYCJPJcW5awpw92dDuHSCeUPo+
 ZTSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209789; x=1696814589;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SS3lReFET+aGmAGqc4LiT/SSS7WTFCZ440WVc6HZkMs=;
 b=bFv/HX52K0DudtaD4edDv5r+fa/dcAwT3+udTD23oXU3f/XXEysJ+iqX5ARBSENFiA
 qxVMtWPjO4msWlOQoY0OfDlVBPk2DiDTo8RvfBFeXlgH1LgFkwg8MGPZqeoB3anPu5MC
 RhD0OQ60rmzrCD3qbhYGyrCeNAg3w6fREw60XkLUnVromRPYNw2vM/bhkBCneZA88RTF
 JDBqnuPApUga1ZObsRUzVJRF+ojPEGHSWehDR5IQE4py08P+R+OpBNK2wB99VHHtZy9S
 R6COx5rGNodEmnAwH3KbzdU59Kd3ulW0lq0DlkxzgWgQUtk/FNnRGadRBB+pOBAMrPuY
 xa6A==
X-Gm-Message-State: AOJu0YzV69vlUdoYRtIcTL88BHWzNs/URLMLEVZboDRt3SQmyahevP3i
 MDLNeAKR7L54qZUDDJAzMwsiyCJMJPkZKRLTZ3JLdUP3ENEvtPxhOvA=
X-Google-Smtp-Source: AGHT+IHInubeo2WBrJj6YYLzxJNYiB06atsnqF3mR9xzJ1JPTbrs/YmE5WX59U702jaOQqIChjC20rC41ZHeBw71roI=
X-Received: by 2002:a17:907:7886:b0:9ae:65a5:b6fa with SMTP id
 ku6-20020a170907788600b009ae65a5b6famr9681595ejc.32.1696209788741; Sun, 01
 Oct 2023 18:23:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230927115920.2471498-1-hugo.cornelis@essensium.com>
 <20230927115920.2471498-2-hugo.cornelis@essensium.com>
In-Reply-To: <20230927115920.2471498-2-hugo.cornelis@essensium.com>
From: Simon Glass <sjg@google.com>
Date: Sun, 1 Oct 2023 19:17:22 -0600
Message-ID: <CAPnjgZ1vRE6S38Sm7-5LghyGhwDd+63g5icMR7u7JTephXNE4w@mail.gmail.com>
Subject: Re: [PATCH 1/2] image-host: add a check of the return value of
 snprintf.
To: Hugo Cornelis <hugo.cornelis@essensium.com>
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

Hi Hugo,

On Wed, 27 Sept 2023 at 06:24, Hugo Cornelis
<hugo.cornelis@essensium.com> wrote:
>

Please add a commit message

> ---
>  tools/image-host.c | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/tools/image-host.c b/tools/image-host.c
> index a6b0a94420..0c92a2ddeb 100644
> --- a/tools/image-host.c
> +++ b/tools/image-host.c
> @@ -363,6 +363,7 @@ static int fit_image_setup_cipher(struct image_cipher_info *info,
>         char *algo_name;
>         char filename[128];
>         int ret = -1;
> +       int snprintf_return;
>
>         if (fit_image_cipher_get_algo(fit, noffset, &algo_name)) {
>                 printf("Can't get algo name for cipher in image '%s'\n",
> @@ -399,8 +400,20 @@ static int fit_image_setup_cipher(struct image_cipher_info *info,
>         }
>
>         /* Read the key in the file */
> -       snprintf(filename, sizeof(filename), "%s/%s%s",
> +       snprintf_return = snprintf(filename, sizeof(filename), "%s/%s%s",
>                  info->keydir, info->keyname, ".bin");
> +       if (snprintf_return >= sizeof(filename))
> +       {
> +               printf("Can't format the key filename when setting up the cipher: insufficient buffer space\n");
> +               ret = -1;
> +               goto out;
> +       }
> +       if (snprintf_return < 0)
> +       {
> +               printf("Can't format the key filename when setting up the cipher: snprintf error\n");
> +               ret = -1;
> +               goto out;
> +       }
>         info->key = malloc(info->cipher->key_len);
>         if (!info->key) {
>                 printf("Can't allocate memory for key\n");
> @@ -423,6 +436,18 @@ static int fit_image_setup_cipher(struct image_cipher_info *info,
>                 /* Read the IV in the file */
>                 snprintf(filename, sizeof(filename), "%s/%s%s",
>                          info->keydir, info->ivname, ".bin");
> +               if (snprintf_return >= sizeof(filename))
> +               {
> +                       printf("Can't format the IV filename when setting up the cipher: insufficient buffer space\n");
> +                       ret = -1;
> +                       goto out;
> +               }
> +               if (snprintf_return < 0)

Please check code style...the { should go at the end of the 'if' line.
You can run patman to do it for you.

> +               {
> +                       printf("Can't format the IV filename when setting up the cipher: snprintf error\n");
> +                       ret = -1;
> +                       goto out;
> +               }
>                 ret = fit_image_read_data(filename, (unsigned char *)info->iv,
>                                           info->cipher->iv_len);
>         } else {
> --
> 2.34.1
>

REgards,
Simon
