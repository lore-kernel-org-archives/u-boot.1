Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55514C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 04:26:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20F1387700;
	Wed,  8 Nov 2023 05:26:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GctaW3VK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00E70874E9; Wed,  8 Nov 2023 05:26:38 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA6F78763E
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 05:26:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-5a8ee23f043so76208067b3.3
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 20:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699417595; x=1700022395; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MfAgvYcvYCJumlJvFFnp4q+qSXX5CP771xI/CzTf9Cc=;
 b=GctaW3VK0VClvxda2vTcHO/4WYBqXkDXvyShRPKIbhIMjn0+FkPA7fBM9xz4KhZKbZ
 jRsdnllR44JtOaKI5fiaIkpjXMavhXonUHBopS1qWxrPWRwi+FJgeAAsZIZc7gcqlicc
 d7RQADINLZuKZBSJXQm3vxyDudqoQSifizoFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699417595; x=1700022395;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MfAgvYcvYCJumlJvFFnp4q+qSXX5CP771xI/CzTf9Cc=;
 b=gsYPkW4DMegomaMzLAk7otyKujBQ2mh8Qk/dgP2ZZnOo6EVavZ6zhdpt3shsBcpmf9
 ZSy5UAw1yOzwKl2ym/HDT2Ldil0l16d9tWIGOUk1A9PcsQR+pnh3BHKRMx6j5W7Z0oCI
 Vo6A7w+29FoDGw9CIiejQjdT/5ksf8aAnYW4HsHVbW4zF0lvOzUaN/xCo9zd7GG71WO8
 sE7+hjsuUB9+kHRbjX57iGt8B1WGtGw1TcAp/gVg50ElFY6h3BX6Vb5FcKjD4e1wdHlf
 cnWqYA2dUqfoj1RS0+yx8UzV4efE54XahPJHYIyxUjrCdjBFDfJWMDebqHjfQPVBsAGR
 xShA==
X-Gm-Message-State: AOJu0YxofgelO1tT0xRTFfCBpcBqn0DisPojSsDg+pTF7fm8ZajTYBAK
 t+3CYoDaO3D4wypm793Qs30MZbt+q8CgfxI753j5aRPRuNiTQV8b+mE=
X-Google-Smtp-Source: AGHT+IFvIay7NBQu7uIXEf7BiIQApQXmQ7CkqhfnbhRV3/KoWMUmPGx0+EONqDaqCuOrd6LXa8FSHXI3d69USopr8YQ=
X-Received: by 2002:a25:2187:0:b0:d9a:3992:192d with SMTP id
 h129-20020a252187000000b00d9a3992192dmr646878ybh.16.1699417595506; Tue, 07
 Nov 2023 20:26:35 -0800 (PST)
MIME-Version: 1.0
References: <20231107190601.17151-1-semen.protsenko@linaro.org>
 <20231107190601.17151-3-semen.protsenko@linaro.org>
In-Reply-To: <20231107190601.17151-3-semen.protsenko@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 7 Nov 2023 21:23:48 -0700
Message-ID: <CAPnjgZ2ae9UPanroXZLeNaB6bGN9hBczZcZSEEv=5t6Uz9WWQw@mail.gmail.com>
Subject: Re: [PATCH 2/4] serial: s5p: Use livetree API to get "id" property
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Mark Kettenis <kettenis@openbsd.org>,
 u-boot@lists.denx.de
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

Hi Sam,

On Tue, 7 Nov 2023 at 12:06, Sam Protsenko <semen.protsenko@linaro.org> wrote:
>
> Use dev_read_u8_default() instead of fdtdec_get_int() to read the "id"
> property from device tree, as suggested in [1]. dev_* API is already
> used in this driver, so there is no reason to stick to fdtdec_* API.
> This also fixes checkpatch warning:
>
>     WARNING: Use the livetree API (dev_read_...)
>
> [1] doc/develop/driver-model/livetree.rst
>
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  drivers/serial/serial_s5p.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/serial/serial_s5p.c b/drivers/serial/serial_s5p.c
> index 177215535676..c57bdd059ea6 100644
> --- a/drivers/serial/serial_s5p.c
> +++ b/drivers/serial/serial_s5p.c
> @@ -20,8 +20,6 @@
>  #include <serial.h>
>  #include <clk.h>
>
> -DECLARE_GLOBAL_DATA_PTR;
> -
>  enum {
>         PORT_S5P = 0,
>         PORT_S5L
> @@ -220,8 +218,7 @@ static int s5p_serial_of_to_plat(struct udevice *dev)
>
>         plat->reg = (struct s5p_uart *)addr;
>         plat->reg_width = dev_read_u32_default(dev, "reg-io-width", 1);
> -       plat->port_id = fdtdec_get_int(gd->fdt_blob, dev_of_offset(dev),
> -                                       "id", dev_seq(dev));
> +       plat->port_id = dev_read_u8_default(dev, "id", dev_seq(dev));
>
>         if (port_type == PORT_S5L) {
>                 plat->rx_fifo_count_shift = S5L_RX_FIFO_COUNT_SHIFT;
> --
> 2.39.2
>

Really this property should not be needed anymore. Can you figure out
how to drop it?

Regards,
Simon
