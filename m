Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C3FEE57F6
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 01:01:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7BFC88DBA;
	Thu, 12 Sep 2024 02:59:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jCGOw4tY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0EFC88DB6; Thu, 12 Sep 2024 02:59:57 +0200 (CEST)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AC4288DAC
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 02:59:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7191901abd6so233572b3a.3
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 17:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726102793; x=1726707593; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ut+2dPCu9ZyIBszUd1tyrGb7acWF1rFZ6eGXT4blue0=;
 b=jCGOw4tYA3k8fmPzWjPWTvkZa7tvHl8zv4AffYG5VerodIRX5aIbdVvg2FQHiamj4S
 jdd1zdhiMdB+0vIMmCfXgAFBj1EJvmniUEu6sE0dhlyjpSy+1jIl5nxrJo7OTXSweeJf
 lclzr4Wp4THQnR0xXc79PcC6foy/NNZupphBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726102793; x=1726707593;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ut+2dPCu9ZyIBszUd1tyrGb7acWF1rFZ6eGXT4blue0=;
 b=JNDPnfPa5Mp+pe//TQvfdVYku+T+Arh1NyLeRUCrYzWWwAv7mpLP3Y4gsezHjEb5sP
 ZMErRlleA/vtXok8SUJk9kQmSnEkjRFnrXntam4zRlqNuJ9a6N6F7+YF7OcvyjUkXhQp
 dAhSs9gVenjcjL860EYsnNEzBTYOg+avQ/jmss1nO4Kmuv3QxIel7muzYGC/u8mvxjGs
 nDllbmU7LF2NKHzsb5zByft8OBacWUqAWJ367uiLiR4FGGNMqNv/eASJcL9vZQuIJANZ
 eSLY2gseajFTxf3atkPaNKHzGI/YsSsR3zJglhzXPluSysKYQ/F+3h4sn9zJyipcX/dh
 y5KA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyAx5jLf71hm9gtOsbMGfdR/2YOAPxCsYZ1QIuorXCllvrinpTllHiskE42RmL4muyK3oJzxE=@lists.denx.de
X-Gm-Message-State: AOJu0YyQHqNeCKEO4dVXFZpGfuSNkZ2eCykkhNMOjRSIEKsY6RMv7dJZ
 4vQBd8+O6fo+5CsYnCv6rhbxs6La1y+Ecwm+NBDwp1hcNd/hnqYSzFyKCJhpVJZ86gAeI+GmLce
 OncDHZtf5YpHrraBVjyJJQfR4g5OfCfVbwNtP
X-Google-Smtp-Source: AGHT+IGB6sdZ1kvxZWFOZ4k2XbxtB4EhbSxPK7/HIEfI53GGoaVSjO/xMvxF1XSjMB5kqEwleFmOIHcpFX/p+AdZa2w=
X-Received: by 2002:a05:6a00:228b:b0:718:da4e:5577 with SMTP id
 d2e1a72fcca58-71926091dc5mr1941788b3a.14.1726102793130; Wed, 11 Sep 2024
 17:59:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240910091200.101886-1-miquel.raynal@bootlin.com>
In-Reply-To: <20240910091200.101886-1-miquel.raynal@bootlin.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Sep 2024 18:59:39 -0600
Message-ID: <CAFLszTjRA3ZXLXitQigEAxx2peBGBTotEsa+y5U6PMY19SccAw@mail.gmail.com>
Subject: Re: [PATCH] video: Fix VNBYTES() macro comment
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, u-boot@lists.denx.de, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Ian Ray <ian.ray@gehealthcare.com>
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

On Tue, 10 Sept 2024 at 03:12, Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> The VNBYTES() macro has been updated to silence possible warnings
> regarding authorized (but unusual) uses of this macro, but the comment
> was kept unchanged. A year has passed so let's fix the comment now to
> avoid confusions.
>
> Fixes: cc05d352fbc ("video: Add parentheses around VNBYTES() macro")
> Suggested-by: Tom Rini <trini@konsulko.com>
> Link: https://lore.kernel.org/u-boot/20240906183432.GG3879073@bill-the-cat/
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  include/video.h | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>


>
> diff --git a/include/video.h b/include/video.h
> index 4d8df9baaad..59b56014874 100644
> --- a/include/video.h
> +++ b/include/video.h
> @@ -57,12 +57,8 @@ enum video_log2_bpp {
>         VIDEO_BPP32,
>  };
>
> -/*
> - * Convert enum video_log2_bpp to bytes and bits. Note we omit the outer
> - * brackets to allow multiplication by fractional pixels.
> - */
> +/* Convert enum video_log2_bpp to bytes and bits */
>  #define VNBYTES(bpix)  ((1 << (bpix)) / 8)
> -
>  #define VNBITS(bpix)   (1 << (bpix))
>
>  enum video_format {
> --
> 2.43.0
>
