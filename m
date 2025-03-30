Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2900BC28B20
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 10:25:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24A288129B;
	Sun, 30 Mar 2025 12:25:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZtVpgIiJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DFFE8144A; Sun, 30 Mar 2025 12:25:22 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 331DC80FF7
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 12:25:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5e61d91a087so5739262a12.0
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 03:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743330319; x=1743935119; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sHwhFPgdbsGQ3grQojNno+NAT7+ds2TJ9BRdRnnmwzY=;
 b=ZtVpgIiJQOtkZVmhoxiUwH25+W4VU9FWDVbIaqYQZLp+/oxdf++EZUbtaGo48vB20d
 F3nzLTrQYlza2cy4h1/TGBWTCBMYJz/R4f5ub6CG7hId6YfC43tPwWFYhXYIMsV8BrNj
 GUKq2+Rc/+Q8M2d4z5mS654nhe5ekIxEepdby+Ny1b1VBelc8OMtevVQuQS3EBjl0kaV
 UKzCkIpU7iNr6QtEkglJM0JR88Rl6XaQX2YB5H3oNXvvtkB0DJvvvWoYFth1SXA8dUG+
 5NusYKJq2v7uXa1PPNqx12bZ9wanLwZhk9BFNUOl9StRPYzSwIJSB9wvUAAhix3mSQXt
 AI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743330319; x=1743935119;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sHwhFPgdbsGQ3grQojNno+NAT7+ds2TJ9BRdRnnmwzY=;
 b=X+Nivg/wDx9F/0/kPQKKg1Wu1rOyM/Z3iTaoatt+sAPmbKtAENzTG9hB/LBvJkVD7E
 F5PA1M5w1f/N2EGGlVcmU2F4zx0f+5iiiMwRXAJrg0m0Q2BAV0uoYcstaTKKRll+F6n7
 NtKrCj70gwaTjK8NWg7Qxqq6xZTSG0Hxap2sVZ0ssKDlaRM9LqK/yotXZwLAh0EmaSAX
 tenIggcD/xJAywJhfBi1MLqr5z7BnOKAUTLV2oMQxTXwuwUXxNYbDHtuPSO6fggHFaiq
 UNv9WomJRUmxkl98UhO7C97av8QqErI/uwG6yVllhu3QZuqn+8U6tVW4Cbp9HZMRJ62R
 mwlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtt9+K64SuGjbTjDvFudIkiv20sIMxfJhjlXjC5I3qpEx3dmOiWI4UDrId/pm1Id+RJjTQnLw=@lists.denx.de
X-Gm-Message-State: AOJu0Yx4LnaWQy5Z0nPMzR+EzNT/KYfsTAk/Ar6/hG511LT7RlJTXOIb
 Q1BnMV5pAdwKnUItc9mxY83V/YHt2tlicYuW8jDtkr2Ay41XmF5XKKnk3Xa8f2a2QB9mJzyvQR4
 KL+urslFvjoNE6dC8nBY2JLnm09w=
X-Gm-Gg: ASbGncsDyeEW3+AIZlR/9Tc73WUEEdxrgXF69qP5n6D3dN9iC1pL+/1mLq84kkqDoYr
 8PT+wW3gZZd95FqIbe2awnot6+5th48rqz0fSZszAjQLujhJG/1A7shlmPRsh4gKhG0/rljsDL5
 Ydeqzhw3D3r1i2LUVkjlDRbF/S0dsR7eZviDjH6Xnxjz5lcBlKrI+lISPZIss=
X-Google-Smtp-Source: AGHT+IE3gh9hvkcworDVKDpMzk1VB0gi59/MY14aUxGkJroCyLB8b1AMlNuIEZnyQyuXkmBkzny0qwXQSgvdQosn8Hg=
X-Received: by 2002:a05:6402:401e:b0:5ee:486:bf12 with SMTP id
 4fb4d7f45d1cf-5ee0486c853mr4594505a12.33.1743330319322; Sun, 30 Mar 2025
 03:25:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250330093600.10871-1-clamor95@gmail.com>
 <20250330093600.10871-3-clamor95@gmail.com>
In-Reply-To: <20250330093600.10871-3-clamor95@gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Sun, 30 Mar 2025 11:25:08 +0100
X-Gm-Features: AQ5f1Jo445GOGs8SKESd_uHEsVLo9egNlXWcafuUu809VAHMqp2gwJfbfuVsLL8
Message-ID: <CALeDE9NMaakSFwgrGFZjqOap2F=7VGG67Nj6u_MqGmeJZFHQpg@mail.gmail.com>
Subject: Re: [PATCH v1 2/5] video: rename tegra20 to tegra
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>, 
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 Alban Bedel <alban.bedel@avionic-design.de>, Anatolij Gustschin <agust@denx.de>,
 Thierry Reding <treding@nvidia.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

I started to look at and test your other display patch series in the last
week or so, one thing I noticed is you need to update the Kconfig
descriptions as well as this rename.

Has the other series been merged to next? You should also put a note about
dependencies etc.

Generally for this the rename makes sense so:
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>

Peter

On Sun, 30 Mar 2025 at 10:47, Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> Since this set of drivers suports four Tegra SoC generations, lets name it
> just 'tegra'.
>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/video/Kconfig                                  | 2 +-
>  drivers/video/Makefile                                 | 2 +-
>  drivers/video/{tegra20 => tegra}/Kconfig               | 0
>  drivers/video/{tegra20 => tegra}/Makefile              | 0
>  drivers/video/{tegra20 => tegra}/mipi-phy.c            | 0
>  drivers/video/{tegra20 => tegra}/mipi-phy.h            | 0
>  drivers/video/{tegra20 => tegra}/tegra-dc.c            | 0
>  drivers/video/{tegra20 => tegra}/tegra-dc.h            | 0
>  drivers/video/{tegra20 => tegra}/tegra-dsi.c           | 0
>  drivers/video/{tegra20 => tegra}/tegra-dsi.h           | 0
>  drivers/video/{tegra20 => tegra}/tegra-hdmi.c          | 0
>  drivers/video/{tegra20 => tegra}/tegra-hdmi.h          | 0
>  drivers/video/{tegra20 => tegra}/tegra-host1x.c        | 0
>  drivers/video/{tegra20 => tegra}/tegra-mipi.c          | 0
>  drivers/video/{tegra20 => tegra}/tegra-pwm-backlight.c | 0
>  15 files changed, 2 insertions(+), 2 deletions(-)
>  rename drivers/video/{tegra20 => tegra}/Kconfig (100%)
>  rename drivers/video/{tegra20 => tegra}/Makefile (100%)
>  rename drivers/video/{tegra20 => tegra}/mipi-phy.c (100%)
>  rename drivers/video/{tegra20 => tegra}/mipi-phy.h (100%)
>  rename drivers/video/{tegra20 => tegra}/tegra-dc.c (100%)
>  rename drivers/video/{tegra20 => tegra}/tegra-dc.h (100%)
>  rename drivers/video/{tegra20 => tegra}/tegra-dsi.c (100%)
>  rename drivers/video/{tegra20 => tegra}/tegra-dsi.h (100%)
>  rename drivers/video/{tegra20 => tegra}/tegra-hdmi.c (100%)
>  rename drivers/video/{tegra20 => tegra}/tegra-hdmi.h (100%)
>  rename drivers/video/{tegra20 => tegra}/tegra-host1x.c (100%)
>  rename drivers/video/{tegra20 => tegra}/tegra-mipi.c (100%)
>  rename drivers/video/{tegra20 => tegra}/tegra-pwm-backlight.c (100%)
>
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index df607303616..afcdb16c599 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -819,7 +819,7 @@ config VIDEO_TEGRA124
>
>  source "drivers/video/bridge/Kconfig"
>
> -source "drivers/video/tegra20/Kconfig"
> +source "drivers/video/tegra/Kconfig"
>
>  source "drivers/video/imx/Kconfig"
>
> diff --git a/drivers/video/Makefile b/drivers/video/Makefile
> index 6073bc5234a..f506f4ba050 100644
> --- a/drivers/video/Makefile
> +++ b/drivers/video/Makefile
> @@ -85,4 +85,4 @@ obj-$(CONFIG_VIDEO_ZYNQMP_DPSUB) += zynqmp/
>
>  obj-y += bridge/
>  obj-y += sunxi/
> -obj-y += tegra20/
> +obj-y += tegra/
> diff --git a/drivers/video/tegra20/Kconfig b/drivers/video/tegra/Kconfig
> similarity index 100%
> rename from drivers/video/tegra20/Kconfig
> rename to drivers/video/tegra/Kconfig
> diff --git a/drivers/video/tegra20/Makefile b/drivers/video/tegra/Makefile
> similarity index 100%
> rename from drivers/video/tegra20/Makefile
> rename to drivers/video/tegra/Makefile
> diff --git a/drivers/video/tegra20/mipi-phy.c
> b/drivers/video/tegra/mipi-phy.c
> similarity index 100%
> rename from drivers/video/tegra20/mipi-phy.c
> rename to drivers/video/tegra/mipi-phy.c
> diff --git a/drivers/video/tegra20/mipi-phy.h
> b/drivers/video/tegra/mipi-phy.h
> similarity index 100%
> rename from drivers/video/tegra20/mipi-phy.h
> rename to drivers/video/tegra/mipi-phy.h
> diff --git a/drivers/video/tegra20/tegra-dc.c
> b/drivers/video/tegra/tegra-dc.c
> similarity index 100%
> rename from drivers/video/tegra20/tegra-dc.c
> rename to drivers/video/tegra/tegra-dc.c
> diff --git a/drivers/video/tegra20/tegra-dc.h
> b/drivers/video/tegra/tegra-dc.h
> similarity index 100%
> rename from drivers/video/tegra20/tegra-dc.h
> rename to drivers/video/tegra/tegra-dc.h
> diff --git a/drivers/video/tegra20/tegra-dsi.c
> b/drivers/video/tegra/tegra-dsi.c
> similarity index 100%
> rename from drivers/video/tegra20/tegra-dsi.c
> rename to drivers/video/tegra/tegra-dsi.c
> diff --git a/drivers/video/tegra20/tegra-dsi.h
> b/drivers/video/tegra/tegra-dsi.h
> similarity index 100%
> rename from drivers/video/tegra20/tegra-dsi.h
> rename to drivers/video/tegra/tegra-dsi.h
> diff --git a/drivers/video/tegra20/tegra-hdmi.c
> b/drivers/video/tegra/tegra-hdmi.c
> similarity index 100%
> rename from drivers/video/tegra20/tegra-hdmi.c
> rename to drivers/video/tegra/tegra-hdmi.c
> diff --git a/drivers/video/tegra20/tegra-hdmi.h
> b/drivers/video/tegra/tegra-hdmi.h
> similarity index 100%
> rename from drivers/video/tegra20/tegra-hdmi.h
> rename to drivers/video/tegra/tegra-hdmi.h
> diff --git a/drivers/video/tegra20/tegra-host1x.c
> b/drivers/video/tegra/tegra-host1x.c
> similarity index 100%
> rename from drivers/video/tegra20/tegra-host1x.c
> rename to drivers/video/tegra/tegra-host1x.c
> diff --git a/drivers/video/tegra20/tegra-mipi.c
> b/drivers/video/tegra/tegra-mipi.c
> similarity index 100%
> rename from drivers/video/tegra20/tegra-mipi.c
> rename to drivers/video/tegra/tegra-mipi.c
> diff --git a/drivers/video/tegra20/tegra-pwm-backlight.c
> b/drivers/video/tegra/tegra-pwm-backlight.c
> similarity index 100%
> rename from drivers/video/tegra20/tegra-pwm-backlight.c
> rename to drivers/video/tegra/tegra-pwm-backlight.c
> --
> 2.43.0
>
>
