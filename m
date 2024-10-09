Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ABBCCF042B
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 01:52:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 689AE8901A;
	Wed,  9 Oct 2024 03:51:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Rr36gsq6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54E2E88FD2; Wed,  9 Oct 2024 03:51:24 +0200 (CEST)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D232C88FD1
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 03:51:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-7c3e1081804so3118716a12.3
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 18:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728438679; x=1729043479; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7IWHDokjrLe87+OmJa/3dPHNvlACMIGL5GNAYzaqy8w=;
 b=Rr36gsq6PGoYdHw7tWU5dtmFf7EY3VOOw/Ub741TRu/S0Rk3KWMXBoL9UxkRq7kLOM
 8kvktnLNIN2XLDM4OaF7jCejyZG9X5DVWGEzwcUU6RioJrbJtOGT2HofT6mDp/ACSUvk
 neZhPkeT/D66JGwkW/ld4bAjGQxseCi3lfYZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728438679; x=1729043479;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7IWHDokjrLe87+OmJa/3dPHNvlACMIGL5GNAYzaqy8w=;
 b=rsFwnr5xnHKUmDMCu3uiggo87ZRYwY797A0iuk+pP5jzVCTyogrBm2/DX3XG2OvPSp
 JPikm3byXQEyJ9gZb45XH8mAhB6BYoyIm912dsAQ09ilOvUPJMWTz3YgUcMJLWj0ziZH
 QSGp6tV7wJClnqF2B8J+7hpjub+JAIMM9aERKp2k5fhgC6UnHF1+IMvGHtpFrha+fR6h
 2vyoc8JIWFk1kbVI4UiDWV0yu+ELIFT1I0y23YGgIAQNKvs8uffypHI/1nvPa6QZ5Iyr
 ECzoSyEAXltpmOVeLuymCAMw4QEDeUm4sfIeemmy6LTq29cClIISn1yvYl7Lg6Ouqop2
 puIg==
X-Gm-Message-State: AOJu0Yy8uERKE6mLDAOdN6TuIRFJvjkAHhLRV37y/T5Upyy1IMKmI6pe
 UHsqGDk6rnxy1MJ7XseLlOzO3COuSKyKZgCfYWglump89S9aSYEfIpPw6NdPaqGAaa/gjIfAD4V
 BSxwwqwQ9r6gAU97MetF3SICOGh4vXMedgH49Fz5Q8Buvo2Dobg==
X-Google-Smtp-Source: AGHT+IGhOtilvkxrMLT2VX9xgdvHqU/XXfTFx2JugcERv5J05LIR8dUoSKehkHEfNjeIilsG2oGMbghinzHrESVhUnk=
X-Received: by 2002:a05:6a20:c791:b0:1ce:d9a2:66ed with SMTP id
 adf61e73a8af0-1d8a3c4e29cmr1211266637.48.1728438679387; Tue, 08 Oct 2024
 18:51:19 -0700 (PDT)
MIME-Version: 1.0
References: <20241003141029.920035-1-ravi@prevas.dk>
 <20241003141029.920035-5-ravi@prevas.dk>
In-Reply-To: <20241003141029.920035-5-ravi@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 8 Oct 2024 19:51:03 -0600
Message-ID: <CAFLszTgDpHJuT+_u3oxPYkHUSE7RF2SQmD8BF0p67qiib3dbEA@mail.gmail.com>
Subject: Re: [PATCH 4/4] serial: embed the rx buffer in struct serial_dev_priv
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>
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

On Thu, 3 Oct 2024 at 08:11, Rasmus Villemoes <ravi@prevas.dk> wrote:
>
> The initialization of upriv->buf doesn't check for a NULL return. But
> there's actually no point in doing a separate, unconditional malloc()
> in post_probe; we can just make serial_dev_priv contain the rx buffer
> itself, and let the (larger) allocation be handled by the driver core
> when it allocates the ->per_device_auto. The total run-time memory
> used is mostly the same, we reduce the code size a little, and as a
> bonus, struct serial_dev_priv does not contain the unused members when
> !SERIAL_RX_BUFFER.
>
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
> ---
>  drivers/serial/serial-uclass.c | 5 -----
>  include/serial.h               | 4 +++-
>  2 files changed, 3 insertions(+), 6 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>


> diff --git a/drivers/serial/serial-uclass.c b/drivers/serial/serial-uclass.c
> index 484f0f7d3e8..d737e25223d 100644
> --- a/drivers/serial/serial-uclass.c
> +++ b/drivers/serial/serial-uclass.c
> @@ -588,11 +588,6 @@ static int serial_post_probe(struct udevice *dev)
>         sdev.getc = serial_stub_getc;
>         sdev.tstc = serial_stub_tstc;
>
> -#if CONFIG_IS_ENABLED(SERIAL_RX_BUFFER)
> -       /* Allocate the RX buffer */
> -       upriv->buf = malloc(CONFIG_SERIAL_RX_BUFFER_SIZE);
> -#endif
> -
>         stdio_register_dev(&sdev, &upriv->sdev);
>  #endif
>         return 0;
> diff --git a/include/serial.h b/include/serial.h
> index 14563239b7d..eabc49f820f 100644
> --- a/include/serial.h
> +++ b/include/serial.h
> @@ -298,9 +298,11 @@ struct dm_serial_ops {
>  struct serial_dev_priv {
>         struct stdio_dev *sdev;
>
> -       char *buf;
> +#if CONFIG_IS_ENABLED(SERIAL_RX_BUFFER)
> +       char buf[CONFIG_SERIAL_RX_BUFFER_SIZE];
>         uint rd_ptr;
>         uint wr_ptr;
> +#endif
>  };
>
>  /* Access the serial operations for a device */
> --
> 2.46.2
>
