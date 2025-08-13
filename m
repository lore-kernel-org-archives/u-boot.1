Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECBD2C87FCF
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 11:41:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D596834B6;
	Wed, 13 Aug 2025 13:41:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Xq5wS53/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC1C882D32; Wed, 13 Aug 2025 13:41:34 +0200 (CEST)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AEA4834B6
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 13:41:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-e904f863fb6so3712232276.1
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 04:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755085291; x=1755690091; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NYRwUM7odaayNQo5XmetninTADE06Wug4ytCZiA9YMw=;
 b=Xq5wS53/BxZz7ybFSO+3AITneZGD5YFEXipdHe6s8qly5CDEOWmMe+uy3wARSMkeTM
 aQUIM1+bbHV03jbLRiu900/Wc03jDs9aKzvkEu5ceX5lOBVVArpYEF7t1qV7dLbiMcBU
 gAxfp3d3RwF6fOHX3p04FybAAUPS5ixEbm6JN+Pn10o8ZCR7bo0imooE66Mp6ffvcdkD
 68kf7ouP8cz8wsIRsztH8AxredYljESGGwxPms0vyKkVcRtuhyPGPc6b9SXLQLp6tS4Q
 tzJhAm8BHgAyLrlOKHUXIt3N7lcolvipHpbEvLY4ddai9k+YNKb2/tT5cGHTOQkfFz8V
 GuAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755085291; x=1755690091;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NYRwUM7odaayNQo5XmetninTADE06Wug4ytCZiA9YMw=;
 b=puD8HFzByKxqbI60+nkTov9ih4rK3x0/SjbzCy/hRaVpr9tZ5xhH+P7kInEjDg0apL
 ILNfhu5SGGSkQMYIG/qdshYTEnxjUvRJKvygTfTjOU3Jk/RW1DtgiyLfMICHnOE6f72W
 7+jTJw/WhOP17+Cc/0qyul31D4oswqa3hyttdkYWFI7ZSBoU9BUf+LIuNCd6m/ieSVc5
 a2/mMrUMZbh/nVhOwiJW94x24JFZEUxe9dD86wTilh3VFMCOJyvxRwHedg9rpyao+ex3
 h276iM3zcWTFP1v2EAgo564AEnKBkgQJUY7ly/4TJ9A/9SSiIho0hM60B6L/1mxOjYti
 842Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYoa2aBxOuJvaji1P5y7U4GMlKh5jKWLMDIxgusqMjUrFOz7PGvLduppSlRJZu9PP410Tv35s=@lists.denx.de
X-Gm-Message-State: AOJu0YyeN6WScKIwpLrNDiN+w4eGdAWllhm+URFQ4YV5HvJZKG8+wzUp
 k904wHQtrtPG2jsNqpl2Po4cTxbd8Tb7mc2EsD9PKxmNsxSpQt/ezsjnkQHAi7SJg1Nm4pOzSof
 /3NRTQ8VV7M0/MbDikgrvqhhoPhZxMWItc/9b4MsOcQ==
X-Gm-Gg: ASbGncvpoqlzFFvW76EgErjY4QlIg4fLk5TWIc+jL3LW8Qo/8JQYgJDE/kgEdMKwor9
 3taryZbmQ2ybywpDxGNI3F5JTXK3LZwXQNHujyLoy1cVMMv+IELDgMxKFXvs2BArcOZUqRVzv8U
 RJb9hm2g0JsrN9aKOz/e3/8VNPoHOw/5FGNpBsfZFhZp82amPVOGejMEOxGUiKvaN1pdYjlEy66
 dMnViE=
X-Google-Smtp-Source: AGHT+IGM8o0xP9AqpOVT3kAMw55kzmlB/awJj9uYjP5TBwdoFFjvk6Xa4eIDokETPB9rCXAMhlbwKZw/LYJcv0jj2mY=
X-Received: by 2002:a05:690c:f14:b0:71b:8cc6:6d41 with SMTP id
 00721157ae682-71d4e456c4amr30734157b3.17.1755085290823; Wed, 13 Aug 2025
 04:41:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250813-tpm_tis_infineon-v1-1-c95434a98efd@linaro.org>
In-Reply-To: <20250813-tpm_tis_infineon-v1-1-c95434a98efd@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 13 Aug 2025 14:40:54 +0300
X-Gm-Features: Ac12FXwCNIov8m7AJs_DYcNDqZTZbajQMcw8_YLkT9O6eYnqQNbQlGRuKAUNGJo
Message-ID: <CAC_iWjKnZ=Uqthyhed-31s9aOGjA8-0FXVyQ-Za8s4sAiE3FqQ@mail.gmail.com>
Subject: Re: [PATCH] tpm: tis_infineon: Cannot test unsigned for being negative
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

On Wed, 13 Aug 2025 at 13:40, Andrew Goodbody
<andrew.goodbody@linaro.org> wrote:
>
> tpm_tis_i2c_get_burstcount returns a size_t but also returns -EBUSY if
> the TPM is surrently busy. As size_t is an unsigned type simply testing
> for < 0 will not work so change the test for being equal to -EBUSY which
> will work. Also remove the trivial comments.
>
> This issue was found by Smatch.
>
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>  drivers/tpm/tpm_tis_infineon.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/tpm/tpm_tis_infineon.c b/drivers/tpm/tpm_tis_infineon.c
> index e2f6238cbc7..180bcf4f938 100644
> --- a/drivers/tpm/tpm_tis_infineon.c
> +++ b/drivers/tpm/tpm_tis_infineon.c
> @@ -353,8 +353,7 @@ static int tpm_tis_i2c_recv_data(struct udevice *dev, u8 *buf, size_t count)
>         while (size < count) {
>                 burstcnt = tpm_tis_i2c_get_burstcount(dev);
>
> -               /* burstcount < 0 -> tpm is busy */
> -               if (burstcnt < 0)
> +               if (burstcnt == -EBUSY)
>                         return burstcnt;
>
>                 /* Limit received data to max left */
> @@ -449,8 +448,7 @@ static int tpm_tis_i2c_send(struct udevice *dev, const u8 *buf, size_t len)
>
>         burstcnt = tpm_tis_i2c_get_burstcount(dev);
>
> -       /* burstcount < 0 -> tpm is busy */
> -       if (burstcnt < 0)
> +       if (burstcnt == -EBUSY)
>                 return burstcnt;
>
>         while (count < len) {
>
> ---
> base-commit: 7807ed921314cd7af83fd88162d0b8c6fb20a9ca
> change-id: 20250813-tpm_tis_infineon-62014a7e6158
>
> Best regards,
> --
> Andrew Goodbody <andrew.goodbody@linaro.org>
>\

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
