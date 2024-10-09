Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EEEECF042D
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 01:53:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC87A89081;
	Wed,  9 Oct 2024 03:51:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Z7rv/Uao";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF3B589023; Wed,  9 Oct 2024 03:51:46 +0200 (CEST)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 500F489050
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 03:51:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-71e05198d1dso1893870b3a.1
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 18:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728438703; x=1729043503; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OXWfFjbzPgwqm1FuqU+9Eh/pEeJulmB3YIyARZPpnKc=;
 b=Z7rv/UaosVWygfu0h7SqBJGmRGa6YaAYeyo3XGEkEghPKkcql9qarTRkQLTt3/3nCi
 aqnKNSUUMRItmtYkFDP6f4mDV64W4ehlMs8HiXbqJB4470N4b1xCVVEb5ueiRUIXPfCf
 cA6K+wWQi8qhF4416HdK877a/dhFoyfdzLsQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728438703; x=1729043503;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OXWfFjbzPgwqm1FuqU+9Eh/pEeJulmB3YIyARZPpnKc=;
 b=TRJ9L1duT1km4rsjePM7gcUAtKVJYUjFvvnkBOmQ81wxT4zMqk676I+REHALjBbIvU
 7ceXxl1KoWkeMYVd8V0zqOh0oDSekqV1UOjJmqfP0wryJPyTQBjW8MWynAyiULNmhARk
 m1df9nLAXg998qGP/BzDQYtS6q6s3OPr8OQ3MHuEawtRYTvUAToaiK78zVh4QAlQUR8D
 yAbbA9sfcGnuf8mCvi4WMqIz/IewEnnw/Jp68770Onrb/jR+15vY3XjKhclAZFdKZJSG
 QC5zOAw/zukQ/THy+RBAwnhXeqyekiNuAyn8yfPmjkpXywzsaa1WoLr0x8/SgTWsGUMm
 zzRw==
X-Gm-Message-State: AOJu0YzBroDRgSFx/rhrhrtG8gMREfseZ7lfrHYdIqMoE6zQ6rhcgdMM
 MsssWipxbHKtgQ8t/l3plZzOjPHILCNQ6UYiZbmpliM3FfiWAUeTNGKOQoxXehPLDktgvASh8UI
 jJ/qtuATfsu46zpzPoMnssFsAnf1+9oYjlSIp
X-Google-Smtp-Source: AGHT+IFFrcX13OchH78kyRdc+hIRNoyI+7e+pScgTb6l+/9Q+T6LwaLK6Wqjt35UmYCvD9I+F744HJwZ04vNWi8LTbw=
X-Received: by 2002:a05:6a00:3d0d:b0:71d:ffef:c175 with SMTP id
 d2e1a72fcca58-71e1dbb562amr1366146b3a.20.1728438702740; Tue, 08 Oct 2024
 18:51:42 -0700 (PDT)
MIME-Version: 1.0
References: <20241003141029.920035-1-ravi@prevas.dk>
 <20241003141029.920035-3-ravi@prevas.dk>
In-Reply-To: <20241003141029.920035-3-ravi@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 8 Oct 2024 19:51:05 -0600
Message-ID: <CAFLszTjnwprJ9zaj1PAbfw34jJLFzqL+T=09SysJiDR3rrf7-A@mail.gmail.com>
Subject: Re: [PATCH 2/4] serial: do not overwrite not-consumed characters in
 rx buffer
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

On Thu, 3 Oct 2024 at 08:10, Rasmus Villemoes <ravi@prevas.dk> wrote:
>
> Before the previous patch, pasting a string of length x >
> CONFIG_SERIAL_RX_BUFFER_SIZE results in getting the
> last (x%CONFIG_SERIAL_RX_BUFFER_SIZE) characters from that string.
>
> With the previous patch, one instead gets the last
> CONFIG_SERIAL_RX_BUFFER_SIZE characters repeatedly until the ->rd_ptr
> catches up.
>
> Both behaviours are counter-intuitive, and happen because the code
> that checks for a character available from the hardware does not
> account for whether there is actually room in the software buffer to
> receive it. Fix that by adding such accounting. This also brings the
> software buffering more in line with how most hardware FIFOs
> behave (first received characters are kept, overflowing characters are
> dropped).
>
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
> ---
>  drivers/serial/serial-uclass.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>


>
> diff --git a/drivers/serial/serial-uclass.c b/drivers/serial/serial-uclass.c
> index 05fe9645bee..28d7a202afc 100644
> --- a/drivers/serial/serial-uclass.c
> +++ b/drivers/serial/serial-uclass.c
> @@ -328,10 +328,11 @@ static int __serial_tstc(struct udevice *dev)
>  static int _serial_tstc(struct udevice *dev)
>  {
>         struct serial_dev_priv *upriv = dev_get_uclass_priv(dev);
> -       uint wr;
> +       uint wr, avail;
>
> -       /* Read all available chars into the RX buffer */
> -       while (__serial_tstc(dev)) {
> +       /* Read all available chars into the RX buffer while there's room */
> +       avail = CONFIG_SERIAL_RX_BUFFER_SIZE - (upriv->wr_ptr - upriv->rd_ptr);
> +       while (avail-- && __serial_tstc(dev)) {
>                 wr = upriv->wr_ptr++ % CONFIG_SERIAL_RX_BUFFER_SIZE;
>                 upriv->buf[wr] = __serial_getc(dev);
>         }
> --
> 2.46.2
>
