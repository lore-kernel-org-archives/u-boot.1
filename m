Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1331DE784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:44:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 450DE874FC;
	Mon,  2 Oct 2023 03:23:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="vYiExaXY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 564CD8721E; Mon,  2 Oct 2023 03:23:19 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 590DC874D0
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:23:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-533d31a8523so18200028a12.1
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1696209792; x=1696814592; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3M7rPsXmFOtepWSLIeLjYI0OaorV2BhuIZ1yLHTpCdI=;
 b=vYiExaXYlvjwl3E7LThlhpz07MPUVL4HUtNZppSjy5ftDqRGnvPKR/g6U28xe4pYuV
 Pasi9R3h2j/eWOa0tHT1gqVp8Ai9ZNsMgdi1p2cEJn6bb5Xgw41eaR1cBarjxvmTc5Vl
 WLrgV6SstIAL6+hxramCYuMN3qSSBtTviSx8QIciI3uSoL46zG9elPFL+D+YfY0LbVq8
 lY7ESCE3bksHGoT6OTupibraWxDFY3RwbPjLwKCC0EEbKzy3afpSfVeCWOZn3EVTr7hj
 ZYuL5r6OMKq5adqgcsK1odwFW733Vh7oi33MNPO/rx3Xg+zN+vTSHZq+jJSo/o1wk2bw
 c5nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209792; x=1696814592;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3M7rPsXmFOtepWSLIeLjYI0OaorV2BhuIZ1yLHTpCdI=;
 b=d0V3newI0Q7Uabm9VWXMDQuHn6+YrN3GZ26CDO0+DOEHep9V07KAf2izWuS6P/Rb8F
 j2pd6COPzMsa0si5ki//6Hc7cV3kPZXX/3e8g67umotd5zutzyRKZelOezT462ObRTWw
 riXrcevIhu+yk2/VmPtLaerANyDXXi6vBPt0AacD/zSDKS9B+igkISvlLJ1v7+hT4mNe
 LoZ2qL9M3rOy8Pebl71w5JuEOnZ08L2OU9zYHBuAScmXNjxO2NpmVDlTiwA6XPJP6Lz3
 B+/dYakNjX509s7tfD0QJ0UQDMWghsSNktVYgLuhGl0m6UQ13VOwrBSWF8g8kpywywqw
 G1DQ==
X-Gm-Message-State: AOJu0YxCSDRtVxTg0UON1YqXROnv2NdqurssGMD78szHy6KHpCJO1Iyk
 oLvgG3i3lBBKaBkiEilRlx2MjyAbK5DiPYCFzAIezi8aRVgs7UmFhe4=
X-Google-Smtp-Source: AGHT+IHjc/Pt1PSNDE8PtaPlcVm7Rz6BrRDFQUC6m+oOIfQgTpxjFhuAwq++LzMWOinf80ozxT8Si3N4j4KLU/oRq5U=
X-Received: by 2002:a17:906:1350:b0:9ae:3d17:d5d0 with SMTP id
 x16-20020a170906135000b009ae3d17d5d0mr9017478ejb.31.1696209791730; Sun, 01
 Oct 2023 18:23:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230927115920.2471498-1-hugo.cornelis@essensium.com>
 <20230927115920.2471498-3-hugo.cornelis@essensium.com>
In-Reply-To: <20230927115920.2471498-3-hugo.cornelis@essensium.com>
From: Simon Glass <sjg@google.com>
Date: Sun, 1 Oct 2023 19:17:26 -0600
Message-ID: <CAPnjgZ2LRvCnvcRFQ-5z_nyBmJGe_s-BE_Wj01w9LHLmmHBNtg@mail.gmail.com>
Subject: Re: [PATCH 2/2] image-host: increase path length when setting up the
 cipher.
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

On Wed, 27 Sept 2023 at 06:24, Hugo Cornelis
<hugo.cornelis@essensium.com> wrote:
>
> ---
>  tools/image-host.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

but please add commit message (always)


>
> diff --git a/tools/image-host.c b/tools/image-host.c
> index 0c92a2ddeb..9afcc02192 100644
> --- a/tools/image-host.c
> +++ b/tools/image-host.c
> @@ -361,7 +361,7 @@ static int fit_image_setup_cipher(struct image_cipher_info *info,
>                                   int noffset)
>  {
>         char *algo_name;
> -       char filename[128];
> +       char filename[256];
>         int ret = -1;
>         int snprintf_return;
>
> --
> 2.34.1
>
