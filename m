Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FFD3C0218B
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 13:29:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE83C801B0;
	Thu, 23 Jan 2025 14:29:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mZ0u9cb6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3866A80214; Thu, 23 Jan 2025 14:29:17 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04EAC80137
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 14:29:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jmasson@baylibre.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4361dc6322fso6193185e9.3
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 05:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1737638954; x=1738243754;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:in-reply-to:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=foQ7Rqw+ZxbX5s3o4D/xrEIo2DSque9oLzqDJod1RR4=;
 b=mZ0u9cb6vJ4COBUQl7tY34BorY/ZCuaojcjibb1WY4Ip6bmOCUwPERfFQdoi0ZP6j2
 WnHeWQe7RyJJH1FTh6I7imNiFYoGfR22+6Dyx22OENqU9IybMGjfShNqq7dWHoGchHQ+
 kcl0pPj2ZCAgQA7dzYUbYn8ewrNiWhAT7jRZbzYj/Ou9vDaZjUfQdsV+/kaSxrQUOc39
 v5OOwhvAVX+P1zEdjy5TEbNyqVjrfOIlLu6GGQTYmMQkqGoCurcjrznBp5QbSOQ31TPz
 DxdHy9mDE4Db0DnlmgcMjkdMo8AQV0y4YjTWEBWjDDPDHIj251NRTSN9HBZIzMpLrHNv
 rhXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737638954; x=1738243754;
 h=mime-version:message-id:date:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=foQ7Rqw+ZxbX5s3o4D/xrEIo2DSque9oLzqDJod1RR4=;
 b=DQ9MTrJshA1fPPq28OJOTDYNHu2PZHhO+9q732Weq6YBJhvDElvR7pqLo4U0PPvFT/
 oC2brWq7cNeam8AhF9POX9YxDd3WE60EwAMNm2xpENkjg/XkNQgmnApIi+jaG0/5ZScI
 Nim6yUbMFKeFB2wUqoK8aAtZAxRnHkORKhFb1r/DyzZQoBAplAVrep1rZzO1T4nr5n74
 5o4AavYMK3/puZkpR50WOybzJE2mmEcO9KtEHsOt4d/RrYjsYt7hhTirDcSXkG0PArUX
 RkkMtMukQ2VyPl0jcRjbQ+YY8gXdH6lPiG0U0bFC4t1FTF2aXpjV7Gduh/fIkUy0USrv
 oxGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9J1O6Ve5kZUDY4eB84Nua253V2mbLIJxeQzvCXcz7f0QBK0VJGKcd9bw1aOefuvxwQKYPQ2g=@lists.denx.de
X-Gm-Message-State: AOJu0YxFA8HQ6QwE7l02Bfmvosn9aRIVafWQhXAxHq3tANSiEWiSgj5K
 YBYY1m7E2+UZct0tfJTCL5yC+78jjrn3LTSfDR3ZhNULwdakGVHbWg1yRGWjRrM=
X-Gm-Gg: ASbGncvbYVjGsfChZsY/dYTNewwklEeARthn22hL5ZTdLN8oKq7+aHodY4YP1v91Z6z
 5YKhaKhcHXpvVnl/nCj69Wet8cPW3nx6AMvwb0LkH1b10OUYBU37IxjG+JrpkYRoemjUY6/CFia
 b7t3khlx/MqKM1Z/cFR/0uvV6+ntKjYC0jp4Pz2P4f5nXbF0e6f3vtilW4P5VG0eLY1Yd11d1/H
 dCZKpd1OR1q5WUV4DcTszXy2hSP1jP64e+Vmdy98AU19tDe7nnnobMCHZIbtBphOOQEikgYD2VD
 5jNGBD8UG6ctj23/Iv4iazkoTQwZzEZ14s19g2dCkekL
X-Google-Smtp-Source: AGHT+IEspn6kJffNZ1P+I+PR+GG3MeZOh4CiUYlDKKS4Y6EXBGbMrpaFcov0L0SIblkpGlpZAPH+ug==
X-Received: by 2002:a05:600c:4f93:b0:436:6160:5b81 with SMTP id
 5b1f17b1804b1-438913dbf79mr265068505e9.14.1737638953801; 
 Thu, 23 Jan 2025 05:29:13 -0800 (PST)
Received: from localhost ([2a04:cec0:1900:d4b5:e910:e51a:5b57:1fb4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438b318a38bsm65167495e9.6.2025.01.23.05.29.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2025 05:29:13 -0800 (PST)
From: Julien Masson <jmasson@baylibre.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, Tom Rini
 <trini@konsulko.com>, Nicolas Belin <nbelin@baylibre.com>
Cc: Guillaume La Roque <glaroque@baylibre.com>, Aaron Kling
 <webgeek1234@gmail.com>, Julien Masson <jmasson@baylibre.com>,
 <u-boot@lists.denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: Re: [PATCH] boot: android: Check kcmdline's for NULL in
 android_image_get_kernel()
In-Reply-To: <20250113-kcmdline-extra-fix-v1-1-03cc9c039159@baylibre.com>
Date: Thu, 23 Jan 2025 14:29:12 +0100
Message-ID: <877c6ld5g7.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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


On Thu 23 Jan 2025 at 14:28, Mattijs Korpershoek <mkorpershoek@baylibre.com> wrote:

> From: Aaron Kling <webgeek1234@gmail.com>
> 
> kcmdline and kcmdline_extra strings can be NULL. In that case, we still
> read the content from 0x00000 and pass that to the kernel, which is
> completely wrong.
> 
> Fix android_image_get_kernel() to check for NULL before checking if
> they are empty strings.
> 
> Fixes: 53a0ddb6d3be ("boot: android: fix extra command line support")
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
> Thanks to Aaron for reporting this on the aosp-devs discord and for
> fixing this.
> ---
>  boot/image-android.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/boot/image-android.c b/boot/image-android.c
> index 60a422dfb74a6c683b3cf9d2b19b3ad1dbd0d151..fa4e14ca4698e1dea105388dd2ea590024cafa58 100644
> --- a/boot/image-android.c
> +++ b/boot/image-android.c
> @@ -337,12 +337,12 @@ int android_image_get_kernel(const void *hdr,
>  	if (bootargs)
>  		len += strlen(bootargs);
>  
> -	if (*img_data.kcmdline) {
> +	if (img_data.kcmdline && *img_data.kcmdline) {
>  		printf("Kernel command line: %s\n", img_data.kcmdline);
>  		len += strlen(img_data.kcmdline) + (len ? 1 : 0); /* +1 for extra space */
>  	}
>  
> -	if (*img_data.kcmdline_extra) {
> +	if (img_data.kcmdline_extra && *img_data.kcmdline_extra) {
>  		printf("Kernel extra command line: %s\n", img_data.kcmdline_extra);
>  		len += strlen(img_data.kcmdline_extra) + (len ? 1 : 0); /* +1 for extra space */
>  	}
> @@ -357,13 +357,13 @@ int android_image_get_kernel(const void *hdr,
>  	if (bootargs)
>  		strcpy(newbootargs, bootargs);
>  
> -	if (*img_data.kcmdline) {
> +	if (img_data.kcmdline && *img_data.kcmdline) {
>  		if (*newbootargs) /* If there is something in newbootargs, a space is needed */
>  			strcat(newbootargs, " ");
>  		strcat(newbootargs, img_data.kcmdline);
>  	}
>  
> -	if (*img_data.kcmdline_extra) {
> +	if (img_data.kcmdline_extra && *img_data.kcmdline_extra) {
>  		if (*newbootargs) /* If there is something in newbootargs, a space is needed */
>  			strcat(newbootargs, " ");
>  		strcat(newbootargs, img_data.kcmdline_extra);
> 
> ---
> base-commit: bc157bb6667ed97e33be8ce8436c28baa275b295
> change-id: 20250113-kcmdline-extra-fix-509331e4d7f3
> 
> Best regards,
> -- 
> Mattijs Korpershoek <mkorpershoek@baylibre.com>
> 

Reviewed-by: Julien Masson <jmasson@baylibre.com>
