Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 977DBE77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 15:31:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 292BD8963B;
	Fri,  6 Dec 2024 16:31:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Zr5ZDzUX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3D7889642; Fri,  6 Dec 2024 16:31:50 +0100 (CET)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D12089613
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 16:31:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2ee51c5f000so1624659a91.0
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 07:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733499105; x=1734103905; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FWgDfJYQ4ZgxO4FfWo1bhFY05FLzHGRGqH7hvPnF9KI=;
 b=Zr5ZDzUX4WnXKuA6eExZu/2Jhvf9gKhez+aDGVhFeNjKPfL5I5/3p6wClBG8LOyivL
 q0YzbrEbR1aJcw1qhLs0ey8SW7IwnqvAbaCWNxSAe6m5uKLng43aFgO0qpNgTJftMWBG
 piZZRKfx/qjW6r+vszzAOWeIMGTvi2e1JLe1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733499105; x=1734103905;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FWgDfJYQ4ZgxO4FfWo1bhFY05FLzHGRGqH7hvPnF9KI=;
 b=cInveA9L6tiAKRoEMy66TwRUuclRu0b1CK2hN43/FdoWbKuRadEMDn9HzwF0gxZt5u
 QJynL8YtcbXamCpCA23tQjJA9wiwKtdqd6l/2pfI6PvwBTA+BhwrAORY42oRBLx81JW8
 d5ymvM3SnpzfAaTej75uGMayRnwZMA8VrfevrotlSukijIL4KaQFwQXNpz09D1xyPVpB
 /o8d+gXkQjpE7rMEwvSMx0dzu6a72wCg3uHrGhG03gD6L0DePl9TWdCvOtwEI+a120Xc
 0RLqvA7G4IcA4xsJBXyF1TGxL5LNcweaG5x7/rPItVfg49ystwlPDZwHzxdlqpOxfbS2
 rqtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZE2vRD4R3goVThJcMGnefPadm5Y2eAUGmwA+Fm4KMJa471mDcVBIeQMM/BGL6it8RHkeZYSc=@lists.denx.de
X-Gm-Message-State: AOJu0Yx9mMkXFBgddX/NYq24+DBYUW0zoYHgbtOPJ7SMntf6mYsVeh1Y
 PWq9Upk/JX5O5ZOp7T7XGZ9kXP878xhnF9N6mS64NKwHd7E9SkxCAdCtx8xe7KvqFcPpXaCALoF
 l9dO/nPwQNceFUPALwwmNfuGviDUEE0ACfNio
X-Gm-Gg: ASbGnct35eQ4VJSuONjDyD56W94+xGaEnzFDtqzJok6a5WpL9Xn8UrZ8goDqvrxwIzC
 uwbgEu7clBQ6ddv7wxG2WB/z4O+Mf53EG
X-Google-Smtp-Source: AGHT+IFRF5odmfVtdXHrD+VvN5UZRv4egP20TLzyxOlQPNkA1RLUW5YBZj/sPJIMc49Q1DOTHMpn9rn/N6Nmz8SjTQI=
X-Received: by 2002:a17:90b:544f:b0:2ea:4578:46d8 with SMTP id
 98e67ed59e1d1-2ef69e15501mr5717416a91.9.1733499104902; Fri, 06 Dec 2024
 07:31:44 -0800 (PST)
MIME-Version: 1.0
References: <20241202-sandbox_repair_of_embed-v1-0-05aff4b0ccf7@salutedevices.com>
 <20241202-sandbox_repair_of_embed-v1-3-05aff4b0ccf7@salutedevices.com>
In-Reply-To: <20241202-sandbox_repair_of_embed-v1-3-05aff4b0ccf7@salutedevices.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 6 Dec 2024 08:31:20 -0700
Message-ID: <CAFLszTjJHY6s2W0rTsOp2DJRQcF1ODOLQF90-fuHgjS-r_JvAA@mail.gmail.com>
Subject: Re: [PATCH 3/5] test: sandbox: fix link error with do_ut_bloblist if
 BLOBLIST=n
To: Evgeny Bachinin <EABachinin@salutedevices.com>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, Levi Yun <yeoreum.yun@arm.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>, kernel@salutedevices.com,
 evgen89bachinin@gmail.com, u-boot@lists.denx.de
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

On Mon, 2 Dec 2024 at 06:46, Evgeny Bachinin
<EABachinin@salutedevices.com> wrote:
>
> Having CONFIG_OF_EMBED=y && CONFIG_BLOBLIST=n leads to the link
> error:
> ```
> ld: /tmp/ccwtRVty.ltrans28.ltrans.o:(.data.rel+0x4b0): undefined \
>                                          reference to `do_ut_bloblist'
> ```
>
> Fixes: 6ea5df39e8d ("test: Only enable bloblist test when supported")
> Signed-off-by: Evgeny Bachinin <EABachinin@salutedevices.com>
> ---
>  test/cmd_ut.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>


>
> diff --git a/test/cmd_ut.c b/test/cmd_ut.c
> index 195b7ea50accde470a739771e058c1d664df3f0b..842c2c3e7f65eb9fe017fa1949eb2390be171487 100644
> --- a/test/cmd_ut.c
> +++ b/test/cmd_ut.c
> @@ -104,8 +104,10 @@ static struct cmd_tbl cmd_ut_sub[] = {
>                          "", ""),
>  #endif
>  #ifdef CONFIG_SANDBOX
> +#if CONFIG_IS_ENABLED(BLOBLIST)
>         U_BOOT_CMD_MKENT(bloblist, CONFIG_SYS_MAXARGS, 1, do_ut_bloblist,
>                          "", ""),
> +#endif
>         U_BOOT_CMD_MKENT(bootm, CONFIG_SYS_MAXARGS, 1, do_ut_bootm, "", ""),
>  #endif
>  #ifdef CONFIG_CMD_ADDRMAP
>
> --
> 2.34.1
>
