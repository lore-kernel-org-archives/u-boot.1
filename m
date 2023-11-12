Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73397C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 20:09:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5195B874E8;
	Sun, 12 Nov 2023 21:04:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ym3G+5Wy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82536874ED; Sun, 12 Nov 2023 21:04:01 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B28FD87503
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 21:03:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-5a84204e7aeso43910517b3.0
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 12:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699819434; x=1700424234; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=f8pKP5VVf2/U7j8lg/6qnPjs6SUdE7/iZWmpgAh244c=;
 b=Ym3G+5Wy9/WVep41T++WSoteMBsjwISDRuNWAXI78MWESF37fcDe3kA73FGjyMLGsL
 591PelSGW3JfTlqfmuTcswsniTHfnwozIbzGSWJJqbngfvXV5vD+DUcI2Lid8s9kj8D0
 1Hbps0RuYqJMm6imI8PhyhsSV+0VwJ4YvclP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699819434; x=1700424234;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f8pKP5VVf2/U7j8lg/6qnPjs6SUdE7/iZWmpgAh244c=;
 b=crN2bs3ZRixZ5kjOYpk4QueSZF8hn5O9FRvEvIEA1rpvbI5SsLnJWeQE3uPKxHy/xs
 MQyRYw1FnGEtQcVHN/xv8QZsW94/EkMoRK2h9QAYf2lOraKAOAfO5/JS0DI0stRzFYqF
 4amjYKsAXFnjE90p+HV/ytQsXz00ndWKCUNvaiE3v9NG9VqBwBbLPqaWubkMWjXWeHvH
 rJyYBqklU1sF2ufFvJeCf7AT7rnp8GrZtVTTVxKBmdnaOehXqL0BmBWfkppK0imLriN8
 l8S7eraoB1x7qUwcM6xEXZjeJIi40C3jBe1BZNPvaKQwZ+HcVhkDnv2oBsBXUfuvQS1Y
 QjeQ==
X-Gm-Message-State: AOJu0YyytHMmHl7Zlt7eipLk/C4Dj/wSP71AenR4ihmaMrz7H3tk04xR
 ws+a9kT/rxDlV/9eHxPlPYFoUgziPrK8eUGEHO6UwA==
X-Google-Smtp-Source: AGHT+IGy0sGCOuEM4MfXG9ZurOoEdqOpolc4Q4wUaTYPaet1Ryz2FeyIOZuHvzIDhUXnjiH086GOTv784eKfRmwzeQ4=
X-Received: by 2002:a81:54d6:0:b0:577:189b:ad4 with SMTP id
 i205-20020a8154d6000000b00577189b0ad4mr5040500ywb.48.1699819434122; Sun, 12
 Nov 2023 12:03:54 -0800 (PST)
MIME-Version: 1.0
References: <20231110152944.647535-1-devarsht@ti.com>
 <20231110152944.647535-5-devarsht@ti.com>
In-Reply-To: <20231110152944.647535-5-devarsht@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 12 Nov 2023 13:01:20 -0700
Message-ID: <CAPnjgZ1a1JO2AZ1_h3nDK9=jeAhnx0=dCzTRdiXGeBob5RvaBw@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] video: Skip framebuffer reservation if already
 reserved
To: Devarsh Thakkar <devarsht@ti.com>
Cc: u-boot@lists.denx.de, agust@denx.de, trini@konsulko.com, 
 bmeng.cn@gmail.com, msuchanek@suse.de, rasmus.villemoes@prevas.dk, 
 yangshiji66@outlook.com, praneeth@ti.com, nm@ti.com, vigneshr@ti.com, 
 a-bhatia1@ti.com, j-luthra@ti.com, nsekhar@ti.com, n-jain1@ti.com
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

Hi Devarsh,

On Fri, 10 Nov 2023 at 08:29, Devarsh Thakkar <devarsht@ti.com> wrote:
>
> Skip framebufer reservation if it was already reserved
> from previous stage and whose information was passed
> using a bloblist.
>
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
> V2:
> - Add debug prints
> - Fix commenting style
> V3:
> - Fix commenting style
> ---
>  drivers/video/video-uclass.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/video/video-uclass.c b/drivers/video/video-uclass.c
> index f743ed74c8..f619b5ae56 100644
> --- a/drivers/video/video-uclass.c
> +++ b/drivers/video/video-uclass.c
> @@ -123,6 +123,19 @@ int video_reserve(ulong *addrp)
>         struct udevice *dev;
>         ulong size;
>
> +       if (IS_ENABLED(CONFIG_SPL_VIDEO_HANDOFF) && spl_phase() > PHASE_SPL) {
> +               /*
> +                * Skip allocation if already received a bloblist which
> +                * filled below fields
> +                */
> +               if (gd->fb_base && gd->video_top && gd->video_bottom) {

Can you drop that line? It should be an error to not have found the
handoff info.

> +                       debug("Found pre-reserved video memory from %lx to %lx\n",
> +                             gd->video_bottom, gd->video_top);
> +                       debug("Skipping video frame buffer allocation\n");
> +                       return 0;
> +               }
> +       }
> +
>         gd->video_top = *addrp;
>         for (uclass_find_first_device(UCLASS_VIDEO, &dev);
>              dev;
> --
> 2.34.1
>

Regards,
Simon
