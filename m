Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12E33C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 12:38:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EEE981951;
	Fri, 28 Mar 2025 13:38:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pfNCtwLQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A660981DED; Fri, 28 Mar 2025 13:38:01 +0100 (CET)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AE898070C
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 13:37:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e53c9035003so1889449276.2
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 05:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743165478; x=1743770278; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xVmcRaai8Oh03VtDZ9eaSRvjEzSKJDmam9un3+aCpak=;
 b=pfNCtwLQDYnUpbbudJEcn/wp0hJOF+C54Q8Sxq3f3Tr6rhXFDALUlq+nn+qqha5Yv7
 KrT/FBdMCZEvW9s/zqsUHWMZqnRzGgLtKjgXPWKqWBYjhJBpWSlJLyvdc3Noub93Vo7j
 AUWjtcZpHmSig7LVIHLFs77/1ZRA4GaemNWedVZ9PRcOI+E8al0tOPo01X2inxwv/buw
 Dc2Qe1bzHlDvagG6XW1OLVV3yGOPmYc3iDxq14oJ29PFK5YNKe2AK8tyPAC+ilHHty9Y
 4gHZfj2Gc0XZfp/luLCU8r3N+PduJUk8ma3QywJsUOJk89pVki/uive0zahaqrKVWS4T
 hREw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743165478; x=1743770278;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xVmcRaai8Oh03VtDZ9eaSRvjEzSKJDmam9un3+aCpak=;
 b=KScclisefLf3nsJI/6zh055kuWEiYtOcUG+eFi0LXmon7ra/TtsMLYctV0so1ld0YU
 NvR6U2oboVo+epNmCJHLSKxdgfCsGKnFGifVF14X8yBYfht4DyyA5jRWNN01ZQKob8wx
 5tcHDBDxCzUyytb2aTmnNPrmTQun9xswRgE653vo5HHkvoaLstIbXKt1QDVyKXFCzaSD
 o21TCyM3UibJwrD6BTPxBCLCp8lKQozwTCf0jZOF1pqr5IdfqKiNxlOaGMZ/A6AIWH/w
 r2gJ+yhZXxyCBLSPXjEQsC9aOBh1ssqVLT0KbRRFiYDVHN4XnCzAHkZbQRWlhF+kqBmL
 pKdA==
X-Gm-Message-State: AOJu0YxrpF5MutmD5i3kKO5M4DwEE6tW2aevc8jdQMGy6VJrphwllzHC
 bJ63D20pgyGFGF+TRdc3pQLjJNmw2Ib8m9KE02QpmlGDxFtPdZzrgrvknzM7SDonqeAVUYju6+/
 NbGYsBnAV2lBtklZSvzb4XKQA8e0hlCV9H27SMQ==
X-Gm-Gg: ASbGncsiQtfLsUhDiSwWsJV77/0tgqPllWe52MtTs3c36zpKXYSO7vS03zZIK+0LB/i
 Y93cPH2UOYW/YpNXt5LPOvgDL2zsRNZRFSb/JtXiE38dbBaw6bFigBxy2Op3CY9IERxXbwtLYkQ
 eT2df2bWtlfgImWo6CXmUvvDdT
X-Google-Smtp-Source: AGHT+IG0kEtuvPM52+5BoGTVIbAkN1/dYXEq7zzeOcFsynhy69VkOrKblsRor0rCiZ17gwIU5qb318KXkGkvRC0wL/w=
X-Received: by 2002:a05:6902:4a03:b0:e6b:769f:556b with SMTP id
 3f1490d57ef6-e6b769f5aa6mr1905113276.35.1743165478219; Fri, 28 Mar 2025
 05:37:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250318132347.646703-1-adriano.cordova@canonical.com>
 <20250318132347.646703-4-adriano.cordova@canonical.com>
In-Reply-To: <20250318132347.646703-4-adriano.cordova@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 28 Mar 2025 14:37:22 +0200
X-Gm-Features: AQ5f1JqxPQhkGcBZqw6RGjVe2NCVSzGl8Wwl2jiQmKVKKtOrigqCH3-dc5raRko
Message-ID: <CAC_iWjLpvf1zkeLm9MGC=LkPX3=99Kncx9deR2Q+SuRF2CFR4w@mail.gmail.com>
Subject: Re: [PATCH 3/3] bootm: add support for initrd in do_bootm_efi
To: Adriano Cordova <adrianox@gmail.com>
Cc: u-boot@lists.denx.de, xypron.glpk@gmx.de, sjg@chromium.org, 
 trini@konsulko.com, Adriano Cordova <adriano.cordova@canonical.com>
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

On Tue, 18 Mar 2025 at 15:23, Adriano Cordova <adrianox@gmail.com> wrote:
>
> Pass a pointer to a memory mapped initrd and its size to
> efi_binary_run. The EFI stack will register an EFI_LOAD_FILE2_PROTOCOL
> for the next boot stage to access this initrd.
>
> Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
> ---
>  boot/bootm_os.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/boot/bootm_os.c b/boot/bootm_os.c
> index f403f352be1..35a32f8c912 100644
> --- a/boot/bootm_os.c
> +++ b/boot/bootm_os.c
> @@ -508,7 +508,8 @@ static int do_bootm_efi(int flag, struct bootm_info *bmi)
>         ret = efi_binary_run(image_buf, images->os.image_len,
>                              images->ft_len
>                              ? images->ft_addr : EFI_FDT_USE_INTERNAL,
> -                                NULL, 0);
> +                                (void *)images->initrd_start,
> +                                (size_t)(images->initrd_end - images->initrd_start));
>
>         return ret;
>  }
> --
> 2.48.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
