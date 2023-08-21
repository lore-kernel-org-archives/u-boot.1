Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0EFDEE49A5
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 22:11:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 907CF871F3;
	Tue, 22 Aug 2023 00:11:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Z0t+NIUq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65A64871F9; Tue, 22 Aug 2023 00:11:10 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC071871DF
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 00:11:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-51bece5d935so4722680a12.1
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 15:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692655865; x=1693260665;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5iUS5gWoT5Y9OscWOEVM0EzouN264ebQutT7riC1ZE8=;
 b=Z0t+NIUqxoPcZPcg65jWmEL2M+kQsBfPn7MM2HcBzUt/1Izc767VaySQIu4kgUil4Y
 vNywlPeeynTDOiCWwU59S39aGCaMIFp6foggXnAsExLx31RMXPjhXRvAB6V/xDja+XtY
 UGTwBQv7VDJdvCB9XBQS3Wgi+jU5bmf5V/BiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692655865; x=1693260665;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5iUS5gWoT5Y9OscWOEVM0EzouN264ebQutT7riC1ZE8=;
 b=ZrpzUaIZ/rNWvfHj2EbggQwHLdtcWcTeBDTif4S6rpFKBonTx6puwtYRar0+QG1IYi
 XPF78CNJNI62JjbQyhhUtsgaRR/adDHgsaKkafkVe6xTqLy7munbhTck7qNZi6gpdYnP
 9KKavNpPuaPszQe5ODz6JCgKXL2ybbwXmCke1j6RPYcGScJAnmM0lKDyGBYgiaTWWIpJ
 W7PcSw7OIdSqjgFWTeBO5IxVD0MR3lZ96g+LxMyOtkAjUxNsR/r3DQb+w9F6XdI24jqG
 QpugvK+iuyGozI7EN1Omi49FLtDGWQBwyr9MEFtUUcFj9eouPrR9+7gdQxTrPlD7Ksat
 2ikw==
X-Gm-Message-State: AOJu0YwRl28HKJ3YwnaE2Ti4hc1OErHQJUmM94wmXDLYdjDFgEDtzfFd
 bQBkA/v9VJWPqdaOENIt5HzsvR4aBQBO+85M6J+jyQ==
X-Google-Smtp-Source: AGHT+IHXOyeQcg0lgdFfiSz6DdEXWPYS/itebS/8XLb+hUmhgoE5d3g2nKVmmDhBR0LWUFLLtS5BXez/hSn0tYSkpoA=
X-Received: by 2002:aa7:df89:0:b0:523:1ce9:1f41 with SMTP id
 b9-20020aa7df89000000b005231ce91f41mr5694897edy.18.1692655865395; Mon, 21 Aug
 2023 15:11:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230821181339.4135800-1-alpernebiyasak@gmail.com>
 <20230821181339.4135800-3-alpernebiyasak@gmail.com>
In-Reply-To: <20230821181339.4135800-3-alpernebiyasak@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 21 Aug 2023 16:10:53 -0600
Message-ID: <CAPnjgZ1xJaxe5=iC++sv_R02jbLoBQ4K6vgoYm=LCZsBwTXNCw@mail.gmail.com>
Subject: Re: [PATCH 2/5] video: Allow deferring and retrying driver-specific
 video sync
To: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Anatolij Gustschin <agust@denx.de>
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

Hi Alper,

On Mon, 21 Aug 2023 at 12:13, Alper Nebi Yasak <alpernebiyasak@gmail.com> wrote:
>
> The sandbox SDL driver has some code in the video uclass to rate limit
> video syncs by postponing them, and forcing a sync nonetheless with a
> "force" argument.
>
> Add infrastructure for doing this through driver ops, where the driver
> can request to defer a sync with -EAGAIN, and the uclass can force it by
> calling the op again it until it does something.
>
> Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
> ---
> Alternatively, add "force" argument into the driver ops->video_sync().
> But I think it should go away instead. The problem is video_sync() being
> called irregularly and too frequently, maybe we can call it only from
> cyclic at the hardware refresh rate?

Yes I like that idea better. Calling it in a tight loop until it does
something seems wrong to me.

>
>  drivers/video/video-uclass.c | 2 ++
>  include/video.h              | 3 ++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/video/video-uclass.c b/drivers/video/video-uclass.c
> index 7cec6362570f..accf486509cb 100644
> --- a/drivers/video/video-uclass.c
> +++ b/drivers/video/video-uclass.c
> @@ -446,6 +446,8 @@ int video_sync(struct udevice *vid, bool force)
>
>         if (ops && ops->video_sync) {
>                 ret = ops->video_sync(vid);
> +               while (force && ret == -EAGAIN)
> +                       ret = ops->video_sync(vid);
>                 if (ret)
>                         return ret;
>         }
> diff --git a/include/video.h b/include/video.h
> index 42e57b44188d..5c4327d4e455 100644
> --- a/include/video.h
> +++ b/include/video.h
> @@ -137,7 +137,8 @@ struct video_priv {
>   *             displays needs synchronization when data in an FB is available.
>   *             For these devices implement video_sync hook to call a sync
>   *             function. vid is pointer to video device udevice. Function
> - *             should return 0 on success video_sync and error code otherwise
> + *             should return 0 on success video_sync, -EAGAIN if it was
> + *             deferred and should be tried again, and error code otherwise
>   */
>  struct video_ops {
>         int (*video_sync)(struct udevice *vid);
> --
> 2.40.1
>

Regards,
Simon
