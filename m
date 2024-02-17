Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E3B6C48BC3
	for <u-boot@archiver.kernel.org>; Sat, 17 Feb 2024 20:09:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAC0A87E75;
	Sat, 17 Feb 2024 21:09:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vMVzCr9H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0E4187E79; Sat, 17 Feb 2024 21:09:39 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB00E87E74
 for <u-boot@lists.denx.de>; Sat, 17 Feb 2024 21:09:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dmitry.baryshkov@linaro.org
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-603fd31f5c2so35191277b3.0
 for <u-boot@lists.denx.de>; Sat, 17 Feb 2024 12:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708200563; x=1708805363; darn=lists.denx.de;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BPvZxG9rT6mW+LMynIYGHCBUn9vpMplT26PvR5g3g5g=;
 b=vMVzCr9HsFfRqnFIHuUnKi3Th5+MD18HppVdlDuWEjEdZRvUzoxEiSptFMzpvXlUm+
 fmsoE1BYPbi1jRRnmpc44wVAf4o6SXHWvqkNh2r6qc0QA79trJXbUMcrOSb8tfG4sTcE
 +80IrtuUxrJHqpnbbGTZyv36DIGN39+Nc8E+kCkDHmrLwskak44yU/f9ugUaBtMrxzP1
 CW4hSYEJ/cmm37lTHJ/Zy79XoNqdpacqUfL6LFb8M2MXqpJfFgY2ryu+67qVDMPaGbXT
 SPGwqeOFB1amehp2uNIvHC3lxwIMSLNczW4tFWKGuy/NYc+pTAuB3hgQCslYtBEyfdi6
 Bkww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708200563; x=1708805363;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BPvZxG9rT6mW+LMynIYGHCBUn9vpMplT26PvR5g3g5g=;
 b=iLEa1dvyF68upezzCtWcX+pn/qnDphByoVh9xIhu/dtqalDD6Z+nC+bizvEVNM8HxZ
 Kg/7c/iLdH0GK84Xlo2HZVz5Ezx3qaOKMbJ3WEJRH6GrUADC6kpx/PdYH82yzDmXuDiM
 7a/rm8opKdRISg5KwozXoTFfFfgTiS+e30IwsYquvLLHhWyyMY2OwEXrOrJgkHCpzy5O
 6uGH0AW2rp9R83nddpTo7fWMUOy8lBhJVTeJyYnDYhY4VSVAU9JpovOA4zKVsf+R0I44
 szmjODANzndPX7a4Gwz9Icg232PNKUznHf2dB2CGBFCzH+rNjN33HpFj4VvdVr7ipdVL
 r+zQ==
X-Gm-Message-State: AOJu0YwvUV8SjIWU2nbNj8GL4gExSVGjfpnRf4CvhWVA/OQIB1BqXLGd
 GEd2TBCwg0wJrBnEgqvwb7waIptMtX+nUX/mi9Q6ZKlw1vOfoqHTac0Y6TJUev7vx22h2tIP1f9
 uRwNcTfKTokQQk66Iq6e6hDUiqaz4zw/KidkN/gvzdclQShHK
X-Google-Smtp-Source: AGHT+IHbLS8OGNqXfmiSGDjS31nKgNYH99wrhB2vXswU14Usw8m4M56gtlY72NNmNS0M5tnscIq7Y6vYfZFFZ+KtCzU=
X-Received: by 2002:a0d:d514:0:b0:607:cc6a:e1e5 with SMTP id
 x20-20020a0dd514000000b00607cc6ae1e5mr6287727ywd.2.1708200563223; Sat, 17 Feb
 2024 12:09:23 -0800 (PST)
MIME-Version: 1.0
References: <20240212073708.4161197-1-dmitry.baryshkov@linaro.org>
In-Reply-To: <20240212073708.4161197-1-dmitry.baryshkov@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 17 Feb 2024 22:09:12 +0200
Message-ID: <CAA8EJppQQG0F+tR202ZLraG8x_CJ9ZH2jcm+ncs2eq=pX0D7Mw@mail.gmail.com>
Subject: Re: [PATCH] virtio: fix get_config / set_config for legacy VirtIO
 targets
To: u-boot@lists.denx.de, Bin Meng <bmeng.cn@gmail.com>,
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

On Mon, 12 Feb 2024 at 09:37, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> The functions virtio_pci_get_config() and virtio_pci_set_config() don't
> take the offset into account when reading the config space. For example
> this manifests when U-Boot tries to read the MAC address of the VirtIO
> networking device. It reads 6 equa bytes instead of the proper addess.
>
> Fix those functions by taking the offset in the config space into
> account.
>
> Fixes: 4135e10732a0 ("virtio: Add virtio over pci transport driver")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Gracious ping

> ---
>  drivers/virtio/virtio_pci_legacy.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
> index cf5dfb17a94d..aa89604ae84d 100644
> --- a/drivers/virtio/virtio_pci_legacy.c
> +++ b/drivers/virtio/virtio_pci_legacy.c
> @@ -107,7 +107,7 @@ static int virtio_pci_get_config(struct udevice *udev, unsigned int offset,
>         int i;
>
>         for (i = 0; i < len; i++)
> -               ptr[i] = ioread8(ioaddr + i);
> +               ptr[i] = ioread8(ioaddr + offset + i);
>
>         return 0;
>  }
> @@ -121,7 +121,7 @@ static int virtio_pci_set_config(struct udevice *udev, unsigned int offset,
>         int i;
>
>         for (i = 0; i < len; i++)
> -               iowrite8(ptr[i], ioaddr + i);
> +               iowrite8(ptr[i], ioaddr + offset + i);
>
>         return 0;
>  }
> --
> 2.39.2
>


-- 
With best wishes
Dmitry
