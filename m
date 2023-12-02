Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC69EC4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 18:27:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B0128773E;
	Sat,  2 Dec 2023 19:27:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="F7S1KxQ4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58D5887706; Sat,  2 Dec 2023 19:27:19 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 470818770C
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 19:27:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-5d7346442d4so5225197b3.2
 for <u-boot@lists.denx.de>; Sat, 02 Dec 2023 10:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701541634; x=1702146434; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Y1TmYEUC0jDFAmIU5wcqn+uanHo7hCMFS48o7KYJf4Q=;
 b=F7S1KxQ4SvUmI0nAhpZ0+b1NUgo2YkRIbKO5dgip27uAACJnheSQYlzMM2UmoNCe4e
 uAvC1djNQbJzIkZ0i3rDTCDEj3xew3TfeCq/mycsW2HXZQPCP8rPhBdUYyUu2BqeCEof
 Y8Vqu/gcNh8Yzujm1NWG65LDQsoxQv6v8P3zk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701541634; x=1702146434;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y1TmYEUC0jDFAmIU5wcqn+uanHo7hCMFS48o7KYJf4Q=;
 b=JBtYY5PEwEQK3wj1c3YRH8I4FxvLw0Lcfx4BcOtKIBRBQk3iuVl5TeyII2VQeh79xW
 EbX8wFyLIKLrcTMgJ8GTnQnhNrKFCSjaoF0ddOWQMFjW3H6SaGGiNGW5GSHa4P+yRZw7
 3h2nqvK2NTFdovqdZgdBKdm7GrnmIlVsIIIWmhCIeIYqeerV+EOUII5xxXjIbz6rHlFB
 E7qv0L3Z/emb9+oTlT2fOYrSuTjtZB+E8EkRKW8o6WaaiINYNW+vPUjAkKPtUbmRTs1N
 MPxO33RSxMaEWgg9BD5GiY/SiOOWOfI0A7dpVMvjByxk9DXIj7KLsW9jFf8RRIpqN2Mk
 K2Og==
X-Gm-Message-State: AOJu0Yxg1B890blp/wXf1SGj9jEFKMfz/zJvM81M66M4x/T6AU7VeVdr
 hWIzF3LPeNY1mpIoTD90x5gFcFXzPl4u7tQ2gIziTA==
X-Google-Smtp-Source: AGHT+IGZ11YUh9S8bAIBx7K3BvAeoe5XizKK4rEJGDD5YM6B92o1vi0FMHTrP64weYSn9qSpTTAZDG88koaQsGiRuKw=
X-Received: by 2002:a0d:dbd0:0:b0:5d4:2c63:a2c3 with SMTP id
 d199-20020a0ddbd0000000b005d42c63a2c3mr1035281ywe.15.1701541633589; Sat, 02
 Dec 2023 10:27:13 -0800 (PST)
MIME-Version: 1.0
References: <20231125162705.1383401-1-devarsht@ti.com>
 <20231125162705.1383401-6-devarsht@ti.com>
In-Reply-To: <20231125162705.1383401-6-devarsht@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 2 Dec 2023 11:26:38 -0700
Message-ID: <CAPnjgZ1LxPY4kbwaiz448xP6WoUohB3sL_+j3A4n-f6Uz2-79A@mail.gmail.com>
Subject: Re: [PATCH v4 5/8] video: Skip framebuffer reservation if already
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

On Sat, 25 Nov 2023 at 09:27, Devarsh Thakkar <devarsht@ti.com> wrote:
>
> Skip framebufer reservation if it was already reserved from previous
> stage and whose information was passed using a bloblist.
>
> Return error in case framebuffer information received from bloblist is
> invalid i.e NULL or empty.
>
> While at it, improve the debug message to make it more clear that
> address in discussion is of framebuffer and not bloblist and also match
> it with printing scheme followed in video_reserve function.
>
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> ---
> V2:
> - Add debug prints
> - Fix commenting style
> V3:
> - Fix commenting style
> V4:
> - Remove extra checks on gd for video data in video_reserve
> - Add check and return error if video handoff provided info is invalid
> - Improve debug message
> - Remove Reviewed-by due to additional changes per review comments
> ---
>  common/board_f.c             |  8 ++++++--
>  drivers/video/video-uclass.c | 10 ++++++++--
>  2 files changed, 14 insertions(+), 4 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

with nit below

>
> diff --git a/common/board_f.c b/common/board_f.c
> index acf802c9cb..442b8349d0 100644
> --- a/common/board_f.c
> +++ b/common/board_f.c
> @@ -407,11 +407,15 @@ static int reserve_video_from_videoblob(void)
>  {
>         if (IS_ENABLED(CONFIG_SPL_VIDEO_HANDOFF) && spl_phase() > PHASE_SPL) {

This is board_f.c so the SPL phase will always be PHASE_BOARD_F so can
you please drop that second condition? It will confuse people.

>                 struct video_handoff *ho;
> +               int ret = 0;
>
>                 ho = bloblist_find(BLOBLISTT_U_BOOT_VIDEO, sizeof(*ho));
>                 if (!ho)
> -                       return log_msg_ret("blf", -ENOENT);
> -               video_reserve_from_bloblist(ho);
> +                       return log_msg_ret("Missing video bloblist", -ENOENT);
> +
> +               ret = video_reserve_from_bloblist(ho);
> +               if (ret)
> +                       return log_msg_ret("Invalid Video handoff info", ret);
>
>                 /* Sanity check fb from blob is before current relocaddr */
>                 if (likely(gd->relocaddr > (unsigned long)ho->fb))

[..]

Regards,
Simon
