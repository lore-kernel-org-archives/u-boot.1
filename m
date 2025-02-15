Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E48C021A0
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 17:24:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 663F480F5C;
	Sat, 15 Feb 2025 18:24:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jiJinDkn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7696480F4A; Sat, 15 Feb 2025 18:24:28 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63B9180F0B
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 18:24:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5dca468c5e4so5570626a12.1
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 09:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739640265; x=1740245065; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FDlWaq3mjh4FKVx6+utiLxp9DwMyvJAAGS0pe73INbc=;
 b=jiJinDkn+UzhCy8k0BvDuVTOZRdXPtzGSI4ABxjBnO3uz4gq2NTb7nqpzR2RUKyxpP
 9ksX8Q2I5k5/LiWI64Q92PjZpezjmuolYEzu88WPAE+f6oRLZL080P90mhfJnefv+xWZ
 n5InbzSk9yR3FlaTQ8PGQoPRXCiqEFAl1wZFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739640265; x=1740245065;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FDlWaq3mjh4FKVx6+utiLxp9DwMyvJAAGS0pe73INbc=;
 b=FxsFJr77Ib08vVoVI21EnyXym1MZakxhTQIs2dMMB17VJcXaZSLPJAd3kXesb4DPit
 Fz4gme32dyVmaR+nFIvSXqzW8PVz5FJX2SO1IThVAg+aHOg7iK0RNzOUrqMQTJUTDfSy
 lx53PgJluHZz8z4l0uD7lv7Mej/kyWQb9NIC8X4USnZKjgqks5vZl6B64XC2bt2mCAXx
 tltfWnWV6LrVfyD9bNq0e2fYRj+yE0IDdl+L6u12d3mhLiJA0J1gTfSeDXMzVxQMciKj
 XWiIMUWv3G8LL/0S72yQd9hraZj00UjKvHdyzO0qfavQfEJBtMYTiomhKsrT2pUZE3c3
 v8pw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeSUlr8Cto3nRvr42X4ZSEc44401snW3Bs0DF49R5Zjn7D3prQVayDBaHRbQtqE0kqPVrWuaI=@lists.denx.de
X-Gm-Message-State: AOJu0YzDmNItFlKZDByleCuP2V96plcg1mC8BuQEF0OkuD4XvMGU8ULg
 UmD6mWoBQG7JLQVbHu7Vob/qcHn8S32XDLIDUrtp33knNGTII7CZMTKHi96d9IPX6AD6QcAiz/J
 6VfBcj/dPekGhsf37rIiVa5GRdzU5ajYqSMGYgm11kUna1Hk=
X-Gm-Gg: ASbGncs7QL6vXsZ7HVzIlJ9oJaoOe4kQAyOKcwjuyGg6LdfH15aBoHAP5YZOwUjRCbP
 rccFgI5weJJTk+4c1EycvdDpVmphbZRooGrl8rTatiVPKSO1NS3f09oCUwRh66bdH13zEI8S49g
 ==
X-Google-Smtp-Source: AGHT+IF1MQIAyzxYK68loQ8r+rmCqk3HgUi2TyQvHVRMt/z8RQiv8teOu+30VpFTmT8qmXIv7e1Jax2qvK4RiUjD8vE=
X-Received: by 2002:a17:906:1db1:b0:ab7:bc17:b3ae with SMTP id
 a640c23a62f3a-abb70c47475mr288739566b.34.1739640265271; Sat, 15 Feb 2025
 09:24:25 -0800 (PST)
MIME-Version: 1.0
References: <20250215155155.152271-1-clamor95@gmail.com>
 <20250215155155.152271-2-clamor95@gmail.com>
In-Reply-To: <20250215155155.152271-2-clamor95@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 15 Feb 2025 10:24:13 -0700
X-Gm-Features: AWEUYZn-alyEfjCnwbtybkCQfLXXsotg-SayCbfQMj6dvgpI_zCweE3BwYvygfM
Message-ID: <CAFLszThi+2xLxrGk-a6=dU1OUmEDJvcCBUQ9sWTpiHw55vF7WA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] video: bridge-uclass: add get_display_timing ops
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>, 
 Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de
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

Hi Svyatoslav,

On Sat, 15 Feb 2025 at 08:52, Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>
> Add get_display_timing ops for internal bridges linked to
> panels that do not support EDID (MIPI-DSI panels for example)
> or have EDID not routed.
>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/video/bridge/video-bridge-uclass.c | 11 +++++++++++
>  include/video_bridge.h                     | 18 ++++++++++++++++++
>  2 files changed, 29 insertions(+)

This should have a test, e.g. in test/dm/video.c or similar.

>
> diff --git a/drivers/video/bridge/video-bridge-uclass.c b/drivers/video/bridge/video-bridge-uclass.c
> index 2084a2e03ee..1b8aa12b9e8 100644
> --- a/drivers/video/bridge/video-bridge-uclass.c
> +++ b/drivers/video/bridge/video-bridge-uclass.c
> @@ -33,6 +33,17 @@ int video_bridge_attach(struct udevice *dev)
>         return ops->attach(dev);
>  }
>
> +int video_bridge_get_display_timing(struct udevice *dev,
> +                                   struct display_timing *timings)
> +{
> +       struct video_bridge_ops *ops = video_bridge_get_ops(dev);
> +
> +       if (!ops->get_display_timing)
> +               return -ENOSYS;
> +
> +       return ops->get_display_timing(dev, timings);
> +}
> +
>  int video_bridge_check_attached(struct udevice *dev)
>  {
>         struct video_bridge_priv *uc_priv = dev_get_uclass_priv(dev);
> diff --git a/include/video_bridge.h b/include/video_bridge.h
> index 3b429eac578..3860bf2cfee 100644
> --- a/include/video_bridge.h
> +++ b/include/video_bridge.h
> @@ -53,6 +53,16 @@ struct video_bridge_ops {
>          */
>         int (*set_backlight)(struct udevice *dev, int percent);
>
> +       /**
> +        * get_display_timing() - Get display timings from bridge.
> +        *
> +        * @dev:        Bridge device containing the linked display timings
> +        * @tim:        Place to put timings
> +        * @return 0 if OK, -ve on error
> +        */
> +       int (*get_display_timing)(struct udevice *dev,
> +                                 struct display_timing *timing);
> +
>         /**
>          * read_edid() - Read information from EDID
>          *
> @@ -98,6 +108,14 @@ int video_bridge_set_active(struct udevice *dev, bool active);
>   */
>  int video_bridge_check_attached(struct udevice *dev);
>
> +/**
> + * video_bridge_get_display_timing() - Get display timings from bridge.
> + *
> + * @dev:       Bridge device containing the linked display timings
> + * Return: 0 if OK, -ve on error
> + */
> +int video_bridge_get_display_timing(struct udevice *dev,
> +                                   struct display_timing *timing);
>  /**
>   * video_bridge_read_edid() - Read information from EDID
>   *
> --
> 2.43.0
>

Regards,
Simon
