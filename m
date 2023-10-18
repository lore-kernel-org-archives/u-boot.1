Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE95CDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 03:33:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB42786F66;
	Wed, 18 Oct 2023 05:33:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UbF6dGYS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02BDF86F63; Wed, 18 Oct 2023 05:33:30 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EB1286F08
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 05:33:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-9c41e95efcbso435274566b.3
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 20:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697600008; x=1698204808; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gpYl+Q2nS3xhpgL9yWS3v+kot1vubuxQ3T/4JXy6TW8=;
 b=UbF6dGYSQgmjBGTGNduk8+fx9zTCfh/cxhPp+ksJqNeOKdOQUMKvmCbjF6+Nh7YzeT
 Y6xeq0ZxawDjg9O/5Y5PZZPhEEAnYEiiTYJ2jwx9K2S1rCTsLPlkyLZOgVZUgcBd0hYZ
 ZkjcQsfcupBeE1EqOAlySYiNQsOFY3wEKzWQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697600008; x=1698204808;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gpYl+Q2nS3xhpgL9yWS3v+kot1vubuxQ3T/4JXy6TW8=;
 b=BiCeyHOZJE68PHE/7z8DyOL9s98XPJ1chfUKbJJ4lbpVJzUHJVBps6YP/lpfN9P9X/
 DWHBxdxje1N1Msy2S9Ti1/E6cd1weA238ckZZm+dDK+rUBiMX+FGEZkzvw5W6fHg6o5T
 +3breeIufVVdXJDfg+bJAKBxbXZV0TDnl3Ioy2Z49atI97nLBzCNRePK7FeRU9+IfGlv
 u3t9GeccCAfnuIuHMcRNFuiu2W3fGciXtUhYK4hJNhT5yv9sAzHGtdY0acVB4mQGc4gu
 p1v8rIGzho48Yg4pcSJysJ3gAqr6FESvmgpcI/GSFNV6C/gKyH+w5uc/xURT98Nkwim7
 6NOg==
X-Gm-Message-State: AOJu0YwA4axAMjXYmGO9c872GcTz+kyiO6fsMxmlVjTgrh8qgynlg+FZ
 8CMqv3nd9KZ5R/AVmeTmYtEasM3RyVwS7gVadDK/tg==
X-Google-Smtp-Source: AGHT+IEBEJpLfmba5N5wsloVq5/evDBRO1sqWWjXtv1h3v1mH1EQq71DJ1Bchv0jq40Mq96ZUe5txysrjxlaI1kpA6c=
X-Received: by 2002:a17:907:36c1:b0:9c3:730e:6947 with SMTP id
 bj1-20020a17090736c100b009c3730e6947mr3091179ejc.41.1697600007522; Tue, 17
 Oct 2023 20:33:27 -0700 (PDT)
MIME-Version: 1.0
References: <20231017192517.13135-1-mps@arvanta.net>
In-Reply-To: <20231017192517.13135-1-mps@arvanta.net>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 17 Oct 2023 21:33:15 -0600
Message-ID: <CAPnjgZ2kcRm4EN1qfmJS0ZONLsXE66a5mCpyY7A=teBPVjcy_g@mail.gmail.com>
Subject: Re: [PATCH] cros_ec: spi: disable annoying key echo on console
To: mps@arvanta.net
Cc: u-boot@lists.denx.de
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

On Tue, 17 Oct 2023 at 13:25, Milan P. Stani=C4=87 <mps@arvanta.net> wrote:
>
> on Peach-pi console every key press is echoed with message
> 'cros_ec_command: Returned status 1'
>
> this is not proper fix, just hack to disable this message
> ---
>  drivers/misc/cros_ec_spi.c | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

I thought a similar patch went in ages ago but I now see it was in cros_ec_=
i2c.c

>
> diff --git a/drivers/misc/cros_ec_spi.c b/drivers/misc/cros_ec_spi.c
> index 001f0a85ca..7317f4b0f1 100644
> --- a/drivers/misc/cros_ec_spi.c
> +++ b/drivers/misc/cros_ec_spi.c
> @@ -151,7 +151,6 @@ int cros_ec_spi_command(struct udevice *udev, uint8_t=
 cmd, int cmd_version,
>
>         /* Response code is first byte of message */
>         if (p[0] !=3D EC_RES_SUCCESS) {
> -               printf("%s: Returned status %d\n", __func__, p[0]);

log_debug()  (without the __func__) would be better


>                 return -(int)(p[0]);
>         }
>
> --
> 2.42.0
>
