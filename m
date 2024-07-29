Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14FE8C3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 15:26:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FE78885EE;
	Mon, 29 Jul 2024 17:26:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XnediBKI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B4FB88804; Mon, 29 Jul 2024 17:26:11 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 755668855C
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 17:26:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6b797234b09so26660696d6.0
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 08:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722266768; x=1722871568; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5G3h4Iik8OlUjcUxKxzedWtos+uffe3LBF7YOThAmHQ=;
 b=XnediBKImDxVZI8xUIZeyhsSdmpIXlkQEQguw9RJgz9+Hv/Blc6N4Kh2z+2KoGIieE
 yZJBvqkeNu34Yj7GzSTsAP3Cc9QvJiO2vgD1HlyLNEOTO0RmEA5/fy/gSjbAiF8IRmQE
 aMJfd2TraVx+5I6c6TXDgWYdVKainGG2QwTpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722266768; x=1722871568;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5G3h4Iik8OlUjcUxKxzedWtos+uffe3LBF7YOThAmHQ=;
 b=K+fuds6BLs+mARk8cJy0u1dXMOm1mMn6DLno1MqMR+rAsIJ5MWkyjhe1+ln4OiheiO
 //fVmA3OhBqQKQPFMtxQ+rqaraxrJ9ojSmSFkccK2d2ZCuqnNAudlsALhQVF0lyyjNey
 dLkGNXnjbKjHyzZw81gB9BDUPd+iSpSf87jfRcC8HeR/ke3Ob5GEsh8G0RP2i84mbvfG
 D3UB+wVHdiAk/m1Z1DSTfxTRyqTglRIWj2BhzKyCd27p4bJ/DWAw+8LuWlGQBhyUoXyE
 ZDzEPWbYetVBex1MqQ8UQ52vBzYB5cS68z8J5ytJvK8YU1Rcpt/G3T8Mq6eKeRBd8pw0
 1+5A==
X-Gm-Message-State: AOJu0Yx4AnV3D38TWC0QK7mOeQa6Lj3K5gdeAR1M0pTT/60L5rzhW4ky
 Mq7sxEcdA7HxMQKGB5fwvzA+p/PU2WAms6oPtb57UQDyJmYIrz15g3fKHBm27U3i3eo3Lf/P2Xh
 +88q/9e3QxB77bC5NHCVWw/jxxzu9CqrZNSHxryjjvCbNcMA=
X-Google-Smtp-Source: AGHT+IH2FFit5YOZvqPeeYEWDPHWLTsLmNb/6/mORnKu0cWl/Nx+TNKtL40K6ALfbCL9ztMELmu0aa7T5OQFYzPTd4I=
X-Received: by 2002:a05:6214:2386:b0:6af:7b2e:1868 with SMTP id
 6a1803df08f44-6bb56360f93mr151010476d6.18.1722266768260; Mon, 29 Jul 2024
 08:26:08 -0700 (PDT)
MIME-Version: 1.0
References: <0b24ac9c0f40ba2410529ee6e0ffd603c9453cff.1718275638.git.chris@arachsys.com>
In-Reply-To: <0b24ac9c0f40ba2410529ee6e0ffd603c9453cff.1718275638.git.chris@arachsys.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 29 Jul 2024 09:25:57 -0600
Message-ID: <CAFLszTiwfVg7o+Rhf10U2exgUA-vJ4V_A-2L75ZLpwJ8sW=9Kw@mail.gmail.com>
Subject: Re: [PATCH RFC] gpio: Fix probing of gpio-hogs
To: Chris Webb <chris@arachsys.com>
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

Hi Chris,

On Thu, 13 Jun 2024 at 04:59, Chris Webb <chris@arachsys.com> wrote:
>
> 48b3ecbe replumbed the gpio-hog probing to use DM_FLAG_PROBE_AFTER_BIND.
>
> Unfortunately gpio_post_bind is called after the non-preloc recursive
> dm_probe_devices completes, so setting this flag does not have the intended
> effect and the gpio-hogs never get probed. With instrumentation:
>
>   [...]
>   CPU:   MediaTek MT7981
>   Model: GL.iNet GL-X3000
>   DRAM:  512 MiB
>   <mtk_pinctrl_mt7981_bind called>
>   <dm_probe_devices called: root root_driver root_driver [+] [ ]>
>   <dm_probe_devices called: clk fixed_clock gpt_dummy20m [ ] [ ]>
>   [...]
>   <dm_probe_devices called: led gpio_led signal-4 [ ] [ ]>
>   Core:  34 devices, 14 uclasses, devicetree: separate
>   MMC:   <gpio_post_bind called>
>   mmc@11230000: 0
>   [...]
>
> Probe them directly in gpio_post_bind instead.

We cannot probe devices when they are bound since it breaks the
ordering of driver model.

From your trace it looks like everything is happening after
relocation. I can't quite see what is actually going wrong. But if you
look at dm_init_and_scan(), it does the probe at the end, immediately
after all devices have been bound. So it should do what you want.

Is the GPIO device not being bound? There is something strange here.

>
> Signed-off-by: Chris Webb <chris@arachsys.com>
> ---
>  drivers/gpio/gpio-uclass.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-uclass.c b/drivers/gpio/gpio-uclass.c
> index 4234cd91..1c6e1715 100644
> --- a/drivers/gpio/gpio-uclass.c
> +++ b/drivers/gpio/gpio-uclass.c
> @@ -1539,7 +1539,9 @@ static int gpio_post_bind(struct udevice *dev)
>                                  * since hogs can be essential to the hardware
>                                  * system.
>                                  */
> -                               dev_or_flags(child, DM_FLAG_PROBE_AFTER_BIND);
> +                               ret = device_probe(child);
> +                               if (ret)
> +                                       return ret;
>                         }
>                 }
>         }

Regards,
Simon
