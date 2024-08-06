Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34FDCC52D6F
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 21:52:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DDE588B36;
	Tue,  6 Aug 2024 23:51:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ltJfljQp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAF5288B36; Tue,  6 Aug 2024 23:51:27 +0200 (CEST)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EF7688B2B
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 23:51:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2cb4b7fef4aso857898a91.0
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 14:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722981080; x=1723585880; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/Wk4HQKwiV2eu4wd4taJbLsqQp1BgTMoyGXFky70j+8=;
 b=ltJfljQp2P019HK6NbcqBaWFPjbPOs6P7kW7XSlb3RsFz2hTJyGZ6kfF6K0759uudL
 1H75/isryLX0hGrqcIZ+W0Wha2QmqAn0AJcGI3FfSSP/aozD9q2jehpEIg9AkkiKI4Rk
 a3qt8188JIWcuHVWVc9U2ITRqwGyp5Wyvh9+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722981080; x=1723585880;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/Wk4HQKwiV2eu4wd4taJbLsqQp1BgTMoyGXFky70j+8=;
 b=AupWJ8xWN9MOegAHXlVfuMOlWYTB45Jn4SrdClvYq0Ph9L+RkAl9uWQNiBVLKtdCgn
 tG8xytFrpiv1E3bLAR4bpajMAmHxFyKol23yCRFbQTAopWSNaIil+iGAXrV/bQIv/YBS
 PwavndBIbMuh8VWKEOXeamwcz3AerzZerxeFIrdQ+OVb7JSIdxBVahFHIePV5bjO1cYO
 1HNw2wFdS/3Hfl0hPG5cgzNICHtVITUNfloB0G0TB4lKJ4YXfQ84CEU71EdtgordlaDn
 LDJxFVibVPo7BrYuaMkHr6UcI+ThmmtwcAgmACpseq7dLuLr1cIrcFmDLAZ5HTOmO8Df
 c03Q==
X-Gm-Message-State: AOJu0YztOq6k/HGgmHStR1RRg3MKtUilL7WsaSfSOCfpGMG1o64SI1Dz
 goyEvQEznHiKRpYlW1Qn0OUlRVXfRwxM2I1X1IliKHAD/+VxTROB4saM34LNgBNbaSgQN+Jnm+f
 98/GMwD79QJdu2BbddYQkeVcEnbnCE+Q7WF4u1BOXIWaVGus=
X-Google-Smtp-Source: AGHT+IHU74tKr8IHYjlVZ5IXk4kV/aRDTIVfXjOpNFgLt5z+1RR8W1igEQFVWLOzymlLFk187tjPT9YKPBN4R1Bdw5Y=
X-Received: by 2002:a17:90b:ed2:b0:2cd:2992:e8e5 with SMTP id
 98e67ed59e1d1-2cff952d38amr20260854a91.33.1722981080544; Tue, 06 Aug 2024
 14:51:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240802100846.16619-1-richard@nod.at>
 <20240802100846.16619-4-richard@nod.at>
In-Reply-To: <20240802100846.16619-4-richard@nod.at>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 6 Aug 2024 15:50:45 -0600
Message-ID: <CAFLszTiawOFJMuoNbbk=GRr3gymLz6aa6Ji9YdEcERTuRXHcBg@mail.gmail.com>
Subject: Re: [PATCH 4/4] dlmalloc: Make sure allocation size is within malloc
 area
To: Richard Weinberger <richard@nod.at>
Cc: u-boot@lists.denx.de, upstream+uboot@sigma-star.at, 
 marek.vasut+renesas@mailbox.org, eugeneuriev@gmail.com, trini@konsulko.com, 
 bmeng.cn@gmail.com
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

Hi Richard,

On Fri, 2 Aug 2024 at 04:08, Richard Weinberger <richard@nod.at> wrote:
>
> Since U-Boot does not support memory overcommit we can
> enforce that the allocation size is within the malloc area.
> This is a simple and efficient hardening measure to mitigate
> further integer overflows in dlmalloc.
>
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  common/dlmalloc.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/common/dlmalloc.c b/common/dlmalloc.c
> index c8d1da1cb1..d264fc031a 100644
> --- a/common/dlmalloc.c
> +++ b/common/dlmalloc.c
> @@ -1274,7 +1274,8 @@ Void_t* mALLOc_impl(bytes) size_t bytes;
>      return NULL;
>    }
>
> -  if ((long)bytes < 0) return NULL;
> +  if (bytes > CONFIG_SYS_MALLOC_LEN || (long)bytes < 0)
> +     return NULL;
>
>    nb = request2size(bytes);  /* padded request size; */
>
> @@ -1687,7 +1688,8 @@ Void_t* rEALLOc_impl(oldmem, bytes) Void_t* oldmem; size_t bytes;
>    }
>  #endif
>
> -  if ((long)bytes < 0) return NULL;
> +  if (bytes > CONFIG_SYS_MALLOC_LEN || (long)bytes < 0)
> +     return NULL;
>
>    /* realloc of null is supposed to be same as malloc */
>    if (oldmem == NULL) return mALLOc_impl(bytes);
> @@ -1907,7 +1909,8 @@ Void_t* mEMALIGn_impl(alignment, bytes) size_t alignment; size_t bytes;
>    mchunkptr remainder;        /* spare room at end to split off */
>    long      remainder_size;   /* its size */
>
> -  if ((long)bytes < 0) return NULL;
> +  if (bytes > CONFIG_SYS_MALLOC_LEN || (long)bytes < 0)
> +     return NULL;
>
>  #if CONFIG_IS_ENABLED(SYS_MALLOC_F)
>         if (!(gd->flags & GD_FLG_FULL_MALLOC_INIT)) {
> --
> 2.35.3
>

Reviewed-by: Simon Glass <sjg@chromium.org>

I wonder if we can get away without the memalign() one since it is
calling malloc() always? There is still the request2size() though.

Regards,
Simon
