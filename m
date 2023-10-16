Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A7CCDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 21:56:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 749AC868C0;
	Mon, 16 Oct 2023 23:55:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mP1zmL0w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A300586BB3; Mon, 16 Oct 2023 23:55:00 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEDB385423
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 23:54:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-9b1ebc80d0aso789523566b.0
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 14:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697493298; x=1698098098; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=k3hN5Xjt+IfYP8zsxCP72ubYri3Xc/VQERrpWTDDUso=;
 b=mP1zmL0wWKv5yDvdymRqmEcZszqHr4TYjGZw1UDw4SgJqthIHV3x/YqxW2enaEinNa
 gkjFj0MgaOEe7+2QsgIC1SGbq4+rF1RlATOTNS9G0tUNEAWMO3TqhmNzCgHFHhpTqeB/
 Kl0qZFtdn1PTrV2L2x6pVxkqKRTXYSFeU8G50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697493298; x=1698098098;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k3hN5Xjt+IfYP8zsxCP72ubYri3Xc/VQERrpWTDDUso=;
 b=F+ddtVF2ELn0672IZ0QXEtMx4OnOAsDCHJhEQh5opWsRjqhv1Wo4tSv6oD2eRd1L6P
 R0Cj4NL2Nc3lZOg9zsoxwMzHn4gxJgGtcE9wBjInSvRkY8/tfsedw8ZYWV+3AxXnVp4Z
 ug8x4pWsA01DW+4cnrexTX9n/QWX7CV8RzAckbswp3AHMuxX1ctjs3CI70Sl8ETvSLz0
 eQ0GhpEyRLzswm+kwIJzCVNrlnLIAqA/S4/kjeE0haSzLh9w+zpeyk/d7xDpe2xm8ZVH
 IoLEYlpgwNM6KEuxkvp8TBAxAm5xl7e4f0z8cGMhDJrkvHZx0uPGkgfifiQPfpBEJYfM
 BcWw==
X-Gm-Message-State: AOJu0YwuN5Wjvt9uU5aVEYJ6cdgtYqhEGz7OCzTPFoey56xaSfcuV2qY
 Nz7l+un0K8l7qtw41z3Td+hh8nyiAeD2A8lfUGrkxSo9Xl9pELNyOrE=
X-Google-Smtp-Source: AGHT+IEuDUQDTjTihWES9i5a2RrcX4u1LNeAHRnP4n0yA1jrPREVPzz7uRUem3hJNGWXuvkrpan/mnSqv7fjYs1JVp0=
X-Received: by 2002:a17:906:ef08:b0:9ba:65e:7529 with SMTP id
 f8-20020a170906ef0800b009ba065e7529mr239505ejs.68.1697493297937; Mon, 16 Oct
 2023 14:54:57 -0700 (PDT)
MIME-Version: 1.0
References: <8c0f5bb6-0110-b7b5-3c40-2d8d98a94dfa@gmail.com>
 <fd206328-2ffa-c174-179c-85f6428e5d9f@gmail.com>
In-Reply-To: <fd206328-2ffa-c174-179c-85f6428e5d9f@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 16 Oct 2023 15:54:45 -0600
Message-ID: <CAPnjgZ2bs2ZE87W71h_4V91M3gyCtCV7vbHVnGwGE+Hmt2LfuQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/8] rockchip: block: blk-uclass: disable bounce buffer
 support for rkmtd
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

On Sun, 15 Oct 2023 at 16:33, Johan Jonker <jbx6244@gmail.com> wrote:
>
> Disable bounce buffer support for rkmtd.
>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
> ---
>
> Changed V3:
>   New patch
> ---
>  drivers/block/blk-uclass.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/block/blk-uclass.c b/drivers/block/blk-uclass.c
> index 30ad5bbb0024..ac1b43d757d8 100644
> --- a/drivers/block/blk-uclass.c
> +++ b/drivers/block/blk-uclass.c
> @@ -415,7 +415,7 @@ struct blk_bounce_buffer {
>
>  static int blk_buffer_aligned(struct bounce_buffer *state)
>  {
> -#if IS_ENABLED(CONFIG_BOUNCE_BUFFER)
> +#if IS_ENABLED(CONFIG_BOUNCE_BUFFER) && !IS_ENABLED(CONFIG_RKMTD)

We should not have arch-specific code in a generic file. Can you make
BOUNCE_BUFFER depend on !RKMTD ?

>         struct blk_bounce_buffer *bbstate =
>                 container_of(state, struct blk_bounce_buffer, state);
>         struct udevice *dev = bbstate->dev;
> @@ -441,7 +441,7 @@ long blk_read(struct udevice *dev, lbaint_t start, lbaint_t blkcnt, void *buf)
>                           start, blkcnt, desc->blksz, buf))
>                 return blkcnt;
>
> -       if (IS_ENABLED(CONFIG_BOUNCE_BUFFER)) {
> +       if (IS_ENABLED(CONFIG_BOUNCE_BUFFER) && !IS_ENABLED(CONFIG_RKMTD)) {
>                 struct blk_bounce_buffer bbstate = { .dev = dev };
>                 int ret;
>
> @@ -478,7 +478,7 @@ long blk_write(struct udevice *dev, lbaint_t start, lbaint_t blkcnt,
>
>         blkcache_invalidate(desc->uclass_id, desc->devnum);
>
> -       if (IS_ENABLED(CONFIG_BOUNCE_BUFFER)) {
> +       if (IS_ENABLED(CONFIG_BOUNCE_BUFFER) && !IS_ENABLED(CONFIG_RKMTD)) {
>                 struct blk_bounce_buffer bbstate = { .dev = dev };
>                 int ret;
>
> --
> 2.39.2
>

Regards,
Simon
