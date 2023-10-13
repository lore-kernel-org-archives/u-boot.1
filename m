Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9744DCDB47E
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 16:58:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 179F686F18;
	Fri, 13 Oct 2023 18:58:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EHy707Ay";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A00DA86E37; Fri, 13 Oct 2023 18:58:12 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A4D586F12
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 18:58:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-9b29186e20aso355331766b.2
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 09:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697216284; x=1697821084; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XijGqFQPf5gDoJIaH1L5qYzr7jvhE3z7LUt+pJG1yyU=;
 b=EHy707AyKO2SI2F1g62y30MzPdCprWOrN/ZFoCzTKQ0aXkWp1lIbJ50mHKRWsBZ2dT
 QHM3MXyva9sRfNmM+jFjhI05viJd7TEFZZSDq7hk/T/FBKd8PsEv//uoW3GvQlcJMHeP
 t3LX+O6sIyauR/bKy2IHYb47Njw9ipv+GGIq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697216284; x=1697821084;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XijGqFQPf5gDoJIaH1L5qYzr7jvhE3z7LUt+pJG1yyU=;
 b=Bh+WjOu+JQBW8RQH6N+mdPYC1AiQhYMlsFK1EAc+tGRbF7VMh8Y/pyguxlhT7mrZT9
 1wC5dpIdQKBzvBC9YZx1BUi5ccGjq0uzsoTzrcCcs211GbYCgONFIxSgQJy7aZdi4u1F
 345xiSwNvPnn64rRpOeqY7BBh5l++hRW++RNmbVoZBbNMqoyKkIvQrOeVGO1E0mn9e8o
 PQHXPXzOAk3KpDqhFMj1GH31ApCuBqJCzMDax3W0RHWzXxdpWIrnCjx7U3N37w7q75L2
 v99RrAqK8398NFHhiNuEiGXHzdRcDtUN8KHheIQcR7dMW0ip+Fixvn204zV5VRuSEdUw
 5pVA==
X-Gm-Message-State: AOJu0YyLHrEDcFttHmRqwFRCle+RwJkvCu19xf7/FBbHYyPM1LRsLK8x
 yg5QxZXTVlmPucTbOwKluVk/Qbyn+gMRogLz3LhtN5mhpsYUEPzHAKI=
X-Google-Smtp-Source: AGHT+IEKK8N8lwEXtEa8O/JR+qHM4uHAFAm7Gnp4BaGpIXodx546ZUnPcjZkyXa6k1Icilio9BZSAwGMDrmzKYh8fWM=
X-Received: by 2002:a17:907:360b:b0:9bd:a73a:7a0d with SMTP id
 bk11-20020a170907360b00b009bda73a7a0dmr1784535ejc.13.1697216283841; Fri, 13
 Oct 2023 09:58:03 -0700 (PDT)
MIME-Version: 1.0
References: <9fffc997-fd13-eba2-3a73-a8e86816667c@gmail.com>
 <94255fe4-ee9d-2e31-1bfa-d6270ebcd104@gmail.com>
In-Reply-To: <94255fe4-ee9d-2e31-1bfa-d6270ebcd104@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 13 Oct 2023 09:57:40 -0700
Message-ID: <CAPnjgZ3ANGiRecirTy7P1Sp61xWevO2PkkOq46dhW8iGDhrQ9w@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] rockchip: dm: prepare rkmtd UCLASS
To: Johan Jonker <jbx6244@gmail.com>
Cc: kever.yang@rock-chips.com, philipp.tomsich@vrull.eu, 
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com, 
 u-boot@lists.denx.de
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

Hi Johan,

On Thu, 12 Oct 2023 at 13:51, Johan Jonker <jbx6244@gmail.com> wrote:
>
> Prepare a rkmtd UCLASS in use for writing Rockchip boot blocks
> in combination with existing userspace tools and rockusb command.
>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
> ---
>  disk/part.c                | 4 ++++
>  drivers/block/blk-uclass.c | 1 +
>  include/dm/uclass-id.h     | 1 +
>  3 files changed, 6 insertions(+)

Do you have a sandbox test for this somewhere?

>
> diff --git a/disk/part.c b/disk/part.c
> index 85244b09f359..36b88205eca7 100644
> --- a/disk/part.c
> +++ b/disk/part.c
> @@ -197,6 +197,7 @@ void dev_print(struct blk_desc *desc)
>         case UCLASS_PVBLOCK:
>         case UCLASS_HOST:
>         case UCLASS_BLKMAP:
> +       case UCLASS_RKMTD:
>                 printf ("Vendor: %s Rev: %s Prod: %s\n",
>                         desc->vendor,
>                         desc->revision,
> @@ -330,6 +331,9 @@ static void print_part_header(const char *type, struct blk_desc *desc)
>         case UCLASS_PVBLOCK:
>                 puts("PV BLOCK");
>                 break;
> +       case UCLASS_RKMTD:
> +               puts("RKMTD");
> +               break;
>         case UCLASS_VIRTIO:
>                 puts("VirtIO");
>                 break;
> diff --git a/drivers/block/blk-uclass.c b/drivers/block/blk-uclass.c
> index f126547cc7e6..30ad5bbb0024 100644
> --- a/drivers/block/blk-uclass.c
> +++ b/drivers/block/blk-uclass.c
> @@ -36,6 +36,7 @@ static struct {
>         { UCLASS_VIRTIO, "virtio" },
>         { UCLASS_PVBLOCK, "pvblock" },
>         { UCLASS_BLKMAP, "blkmap" },
> +       { UCLASS_RKMTD, "rkmtd" },
>  };
>
>  static enum uclass_id uclass_name_to_iftype(const char *uclass_idname)
> diff --git a/include/dm/uclass-id.h b/include/dm/uclass-id.h
> index 0432c95c9edc..2fc672df0a3a 100644
> --- a/include/dm/uclass-id.h
> +++ b/include/dm/uclass-id.h
> @@ -120,6 +120,7 @@ enum uclass_id {
>         UCLASS_REGULATOR,       /* Regulator device */
>         UCLASS_REMOTEPROC,      /* Remote Processor device */
>         UCLASS_RESET,           /* Reset controller device */
> +       UCLASS_RKMTD,           /* Rockchip MTD device */
>         UCLASS_RNG,             /* Random Number Generator */
>         UCLASS_RTC,             /* Real time clock device */
>         UCLASS_SCMI_AGENT,      /* Interface with an SCMI server */
> --
> 2.39.2
>

Regards,
Simon
