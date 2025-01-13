Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2513E7719F
	for <u-boot@archiver.kernel.org>; Mon, 13 Jan 2025 13:22:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D405B801CF;
	Mon, 13 Jan 2025 14:22:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2Fh6kEOT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4820F805DA; Mon, 13 Jan 2025 14:22:36 +0100 (CET)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDEF580141
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 14:22:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nbelin@baylibre.com
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2ee50ffcf14so7995471a91.0
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 05:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736774552; x=1737379352;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pbkY4yT3h1mrq4ckVXLbbb4nK2TnvkP5C9ZSwOcT2g8=;
 b=2Fh6kEOToNvMQKnecrEm+CbrFEgYz2lfv5fUgo9POS5N1dhqHrIyuuvfh8ikJrHLJR
 f+OLje3kTQG8lPYru1qGfFFlBxVP+oTBaMZNo+Ch6aQ/S2En+gZBTU0mL6HRNjUVEeWu
 nM0bfuSEMZCH6fLk67cnu3gsETAajD7+WJsojGzOLT9UlNFDZR7kV6SHCIUHdUAaMaw5
 3cRPb36mohtj9GVRRuyEcUIh4ovEfZOQt6tIWwy+Wi+lmMPFjzAdTQ58dmKbhqHwvqKV
 Wa8YYWAcTZmHnAKWwGhvu2szZ1YXXfejNJj53dk7J1UQvv+1XSLZcqdMZQEKcgR33RsV
 GpTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736774552; x=1737379352;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pbkY4yT3h1mrq4ckVXLbbb4nK2TnvkP5C9ZSwOcT2g8=;
 b=nfnBgnw/hsh6ZdKrF1VhcheFYZEpLmnF8FSzDI+42+SFWsYMRZXoarjl1pgY5JOZ2j
 40H4qPmF6Ke7bbnfem06kO26rOwznQspPmhyBqD8WbSStFQDttfz2vVMjyuRLuszNKGs
 nY7fxs3101WVuH63Buie1yJMA5zjfbiGCxOp9DRljV1zYhor3uLHIKBjtIhbHv/tF2pK
 iPEAe3cWzSB1hJakwJG8c2QkTgBrbTWkjyiq9xjvNOuBoD+O3MGiTt8W6qeHlVRTlRdz
 riTe90D+hpcGHySC9FBrMmeqn7xMid8bHJlpBUo8ULPjlgW3wa6EvQFiTt3OKwk7Fjcn
 FHKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnwNKnBhBHsDO8Eiazj1dBCUr8S5fRwSy1fDZVEf2Wuzy57xfON4Iq7ccTRr9y0CPt02nd0qo=@lists.denx.de
X-Gm-Message-State: AOJu0YyUedMalmFyRXMSrFe3elVuolE6k4Yce/M2cFMuvNv4dAKqnyJD
 TNlve/VIu/Zov4LbuW0vXws4kFBpA8e/GjaXi+51MEX7vt1S4HWyQBPlw9LD+/5xQmjUwGqAztg
 5YbwwymIK6WWfvRqE+cC4MR2v3nVbUWGSyBtdBA==
X-Gm-Gg: ASbGnct1ehHlK8OT7+Poo7nV+RehZqWXRBdNrCpYyF2eh64IV42B97D+h434LiN8BHW
 YqZTXqiBeR22sTp+LQNaTreIVV/q9wkM4XwtNZyoBSAv78D6nyiA1hznye38SSoo8llJHmw==
X-Google-Smtp-Source: AGHT+IGL0YvT582G0A78TkNV/JShehtM5CFPN8fSw74zt4cRKnxnMFlpdmAG6h8co/zMbkxhp9/+FDcsNR/EJDUnD7c=
X-Received: by 2002:a17:90b:2c8d:b0:2ee:5a82:433a with SMTP id
 98e67ed59e1d1-2f5583add61mr23732353a91.17.1736774552268; Mon, 13 Jan 2025
 05:22:32 -0800 (PST)
MIME-Version: 1.0
References: <20250113-kcmdline-extra-fix-v1-1-03cc9c039159@baylibre.com>
In-Reply-To: <20250113-kcmdline-extra-fix-v1-1-03cc9c039159@baylibre.com>
From: Nicolas Belin <nbelin@baylibre.com>
Date: Mon, 13 Jan 2025 14:22:20 +0100
X-Gm-Features: AbW1kvZ86psEKU9tEN_XTEiljMifwVvKxi4QZ_uyLLOPKJWw9ZwdSvSw5FKFjRw
Message-ID: <CAJZgTGHySRkLrCBEPah5Tn7QgeZ7_pzeYx+_0sUFxYt_OK9BVQ@mail.gmail.com>
Subject: Re: [PATCH] boot: android: Check kcmdline's for NULL in
 android_image_get_kernel()
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, Guillaume La Roque <glaroque@baylibre.com>, 
 Aaron Kling <webgeek1234@gmail.com>, Julien Masson <jmasson@baylibre.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Le lun. 13 janv. 2025 =C3=A0 10:11, Mattijs Korpershoek
<mkorpershoek@baylibre.com> a =C3=A9crit :
>
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
> index 60a422dfb74a6c683b3cf9d2b19b3ad1dbd0d151..fa4e14ca4698e1dea105388dd=
2ea590024cafa58 100644
> --- a/boot/image-android.c
> +++ b/boot/image-android.c
> @@ -337,12 +337,12 @@ int android_image_get_kernel(const void *hdr,
>         if (bootargs)
>                 len +=3D strlen(bootargs);
>
> -       if (*img_data.kcmdline) {
> +       if (img_data.kcmdline && *img_data.kcmdline) {
>                 printf("Kernel command line: %s\n", img_data.kcmdline);
>                 len +=3D strlen(img_data.kcmdline) + (len ? 1 : 0); /* +1=
 for extra space */
>         }
>
> -       if (*img_data.kcmdline_extra) {
> +       if (img_data.kcmdline_extra && *img_data.kcmdline_extra) {
>                 printf("Kernel extra command line: %s\n", img_data.kcmdli=
ne_extra);
>                 len +=3D strlen(img_data.kcmdline_extra) + (len ? 1 : 0);=
 /* +1 for extra space */
>         }
> @@ -357,13 +357,13 @@ int android_image_get_kernel(const void *hdr,
>         if (bootargs)
>                 strcpy(newbootargs, bootargs);
>
> -       if (*img_data.kcmdline) {
> +       if (img_data.kcmdline && *img_data.kcmdline) {
>                 if (*newbootargs) /* If there is something in newbootargs=
, a space is needed */
>                         strcat(newbootargs, " ");
>                 strcat(newbootargs, img_data.kcmdline);
>         }
>
> -       if (*img_data.kcmdline_extra) {
> +       if (img_data.kcmdline_extra && *img_data.kcmdline_extra) {
>                 if (*newbootargs) /* If there is something in newbootargs=
, a space is needed */
>                         strcat(newbootargs, " ");
>                 strcat(newbootargs, img_data.kcmdline_extra);
>
> ---
> base-commit: bc157bb6667ed97e33be8ce8436c28baa275b295
> change-id: 20250113-kcmdline-extra-fix-509331e4d7f3
>
> Best regards,
> --
> Mattijs Korpershoek <mkorpershoek@baylibre.com>
>

Reviewed-by: Nicolas Belin <nbelin@baylibre.com>
