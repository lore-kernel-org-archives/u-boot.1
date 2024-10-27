Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 124E2D13577
	for <u-boot@archiver.kernel.org>; Sun, 27 Oct 2024 17:40:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46C0788969;
	Sun, 27 Oct 2024 18:40:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HHIp324t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD4D4881FD; Sun, 27 Oct 2024 18:40:02 +0100 (CET)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D07A8839A
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 18:39:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-71e4e481692so2864819b3a.1
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 10:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730050794; x=1730655594; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=e44apFrqIWxYYyQG5imapurP9zSRM4bQ2V5Fm7aQR3A=;
 b=HHIp324t6AF0umw7IrjXsptInBQtL+XoNZbh3Z0zrFd69+ZzjVIj76bw1TKc0q3CxB
 d2juJ4eM+CqIi+0a8NX0PZJDdPQX7/uYdEMssm4KNN0YMJ/P3gIalKdUUHt5kdnSaCng
 dMjyocoolJ2x3Y2pB0gbWIAsemeCPdAPpOe3qa89b9inKtvnh3KVozkin6dhnnM+1BxN
 QOLELW4KKB4GIWVXXCvwr0jogl2oi3tXfb7nz7p/XptaYgqDaFr56fQYIU8JVOeyyKbt
 athpNMPx7ZmirlMhdYABzFPHgiXYpLeiZVy2/pOVyUQN5+KrVMbFw6cNdS5LrAVGbb2+
 hXYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730050794; x=1730655594;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e44apFrqIWxYYyQG5imapurP9zSRM4bQ2V5Fm7aQR3A=;
 b=JqjmYKx7FgrV/uOOsYdhs/Jv1vwEWSgTpRAE31p4CQjBVxgtIl5/juT+4250CANnLM
 TL5NIRmxtQqpq8BXI2GJFPNYxZYMrW7SoQqeCd2EnDvaTC+v8lgh5Ohck1UnKpF2qmpr
 QzSoHl5gdLWiTY0ks3rYOAI5+j7rIeAHojqlLqO+Swg/bmsw2gqepJgGNt7w4XvBsFlk
 C02lquQMKYOLsOMW9UTNS7Ipyg8rYfa2rE8aOTihRZC41f6DKU6gvbdY6Cb8MpWIgZvp
 XyjuVuYhLHSFigxBCdcLjcoDDRrSn0i6ZXsuoqpat12UCsDDEdGjiH6NTyw7qtvRbprZ
 M5jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpCWO1Pm98G+yQ+1t3Xyh90QfA/nPgfqdddy1oWkJnB1BlqT41F2ggaOz30V/0SViZOAmvjtQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyGopxWqLPqXG1qWO0RtUBauZSmali9weatyIHlj6wlq15NleXB
 b1q1DSnLir6WnvVa7F99aUyayi6+ldh6wMco4X2TaKySSnvACj2JUxYf9IlaQ7TxJY9lu7PsGLf
 v1dp7wSwCjvcbgsbRAQo21fPnzrllzaqQ7jzTJw==
X-Google-Smtp-Source: AGHT+IEd+3qw5eFAjndcvqDs7Md38JbEIXCKyVpl5a1fjHy91Y0KwgXcSlLWSOQCxg2Tpt/bQAIVQvpVTa/ni52zI8I=
X-Received: by 2002:a05:6a00:929d:b0:71e:4655:59ce with SMTP id
 d2e1a72fcca58-72062abacdcmr9819497b3a.0.1730050793731; Sun, 27 Oct 2024
 10:39:53 -0700 (PDT)
MIME-Version: 1.0
References: <20241026064048.370062-1-heinrich.schuchardt@canonical.com>
 <20241026064048.370062-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241026064048.370062-3-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sun, 27 Oct 2024 19:39:17 +0200
Message-ID: <CAC_iWj+r6+m+j9_wWi-VTKdoor7A5i7fRarcCXRrbz4RA=KxQg@mail.gmail.com>
Subject: Re: [PATCH 2/5] fs: ext4: free directory node in ext4fs_exists()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Richard Weinberger <richard@nod.at>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de
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

On Sat, 26 Oct 2024 at 09:41, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The directory retrieved in ext4fs_exists() should be freed to avoid a
> memory leak.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  fs/ext4/ext4fs.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ext4/ext4fs.c b/fs/ext4/ext4fs.c
> index 15587e92e3e..21714149ef5 100644
> --- a/fs/ext4/ext4fs.c
> +++ b/fs/ext4/ext4fs.c
> @@ -209,12 +209,17 @@ int ext4fs_exists(const char *filename)
>  {
>         struct ext2fs_node *dirnode = NULL;
>         int filetype;
> +       int ret;
>
>         if (!filename)
>                 return 0;
>
> -       return ext4fs_find_file1(filename, &ext4fs_root->diropen, &dirnode,
> -                                &filetype);
> +       ret = ext4fs_find_file1(filename, &ext4fs_root->diropen, &dirnode,
> +                               &filetype);
> +       if (dirnode)
> +               ext4fs_free_node(dirnode, &ext4fs_root->diropen);
> +
> +       return ret;
>  }
>
>  int ext4fs_size(const char *filename, loff_t *size)
> --
> 2.45.2
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
