Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08DBED2B92E
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 14:13:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74F8489000;
	Tue,  5 Nov 2024 15:13:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i+J6E3Rk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A3A98900E; Tue,  5 Nov 2024 15:13:08 +0100 (CET)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B776488EDE
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 15:13:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2fb3da341c9so51688071fa.2
 for <u-boot@lists.denx.de>; Tue, 05 Nov 2024 06:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730815986; x=1731420786; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=t2rhwoD+2YIn3hExXcWviQ+I+1yGTnm28Q8a9h5ppbw=;
 b=i+J6E3RkGkX07blyGxsQNO3Vkk5MD8VRdOf7aRdqp6OcfgqCtQrMahWldtOduN/y49
 QNGhkRREDTlQT/wWV6CIQFXYo9nN+gDtsOJkUZY+7eOPZ2SM2d+q7Un6xRL1VposOoAR
 9j01PzBmaz7/+cRFI6w4OYXkIJ9PtPL1bmS4EooWWydbdWnBvv+p1gkPndUEaXpE5PjB
 Q2inR2T9u6AeZwLx+Wz21obgsA02Jhd+C74acjomXo76MTcIZQzt8FutNI5BB25P2hpU
 Xf9CmWZqV7yEs9EwCq8+29O6twp97x3U9KC771uKSCLQUComPSYxPH3dgnZXk1nRbeJf
 jVOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730815986; x=1731420786;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t2rhwoD+2YIn3hExXcWviQ+I+1yGTnm28Q8a9h5ppbw=;
 b=dV+npOFSDOv6CsYndN1d7HHr0asc8r6xIf4dm3IytzBP8V5Snvt4oep/NVoSOBnm6x
 xUY8lPFR+m1tWOsRQQBdo29LT42/2/I6aYxGWkNR3iKjPPqv3XSpS7/EBFfVnyvJnXyF
 uHAsyzaUsS/NCYYFiyOMuYBlNepY7qCGZwDWZTO1U4l4REdvjfnXDYZMAeZqTHPxbu98
 cnW007ayV34MbHGOtNv4SxZFUp0J4dKoJ8ey8UJmHckHssJyRWBMfiwooNvTyC2AstaT
 /Hm2T7x+vDPqXG84b93YlA6ztUj5o+6hJUF1lXLZaZiVWCB3fiFLRpPIfVKDis9o/75i
 L+3w==
X-Gm-Message-State: AOJu0Yy4kJYkdzZluDGR9g27rR5XBN4dvyFmpcs93ryH8pf8XvtN7oU1
 KEr6x8cv0t/2I/I1ZQ1dz5KDW/OZ/IaLP/Re3R8BcEaT0U/dhhdIbaIE2nO0AaEi3U1bqkfekKl
 H7bn8mChwkwBDZ19vAdaQwjH0NLc=
X-Google-Smtp-Source: AGHT+IGGsLDCHDC08ODmqFjUkBHoW/AObKen2Z4sOnv6Zpt4ptPiKNOlE2WVc3g1WsMMaR25wE3eb5lvvU1jDs8/Prw=
X-Received: by 2002:a05:651c:248:b0:2fb:2f7c:28e0 with SMTP id
 38308e7fff4ca-2fedb786393mr84281211fa.18.1730815985684; Tue, 05 Nov 2024
 06:13:05 -0800 (PST)
MIME-Version: 1.0
References: <20241103003322.626036-1-sjg@chromium.org>
 <20241103003322.626036-5-sjg@chromium.org>
In-Reply-To: <20241103003322.626036-5-sjg@chromium.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 5 Nov 2024 14:12:53 +0000
Message-ID: <CALeDE9O9sxCwf_scpbLQEtSxovN64jMWkfEVpUZviJFrXPbHTQ@mail.gmail.com>
Subject: Re: [PATCH v3 04/25] pinephone: Drop status-LED code and use LED
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Samuel Holland <samuel@sholland.org>
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

On Sun, 3 Nov 2024 at 00:42, Simon Glass <sjg@chromium.org> wrote:
>
> Drop the STATUS_LED options and enable LED and LED_BOOT instead, since
> this is the new way to access the LED functionality.

This still doesn't work!

> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> Changes in v3:
> - Combine removal and enable patches
>
> Changes in v2:
> - Add a patch to enable LED and LED_BOOT for these boards
>
>  configs/pinephone_defconfig | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/configs/pinephone_defconfig b/configs/pinephone_defconfig
> index 9d39204a439..272fce1c1a4 100644
> --- a/configs/pinephone_defconfig
> +++ b/configs/pinephone_defconfig
> @@ -11,8 +11,5 @@ CONFIG_MMC_SUNXI_SLOT_EXTRA=2
>  CONFIG_PINEPHONE_DT_SELECTION=y
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
>  CONFIG_OF_LIST="sun50i-a64-pinephone-1.1 sun50i-a64-pinephone-1.2"
> -CONFIG_LED_STATUS=y
> -CONFIG_LED_STATUS_GPIO=y
> -CONFIG_LED_STATUS0=y
> -CONFIG_LED_STATUS_BIT=114
> -CONFIG_LED_STATUS_STATE=2
> +CONFIG_LED=y
> +CONFIG_LED_BOOT=y
> --
> 2.43.0
>
