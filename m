Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F204BC3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 12:29:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D35388651;
	Mon, 29 Jul 2024 14:29:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RYu9Gmp7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B12F7887B9; Mon, 29 Jul 2024 14:29:43 +0200 (CEST)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65F27885F5
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 14:29:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-70eaf5874ddso2227134b3a.3
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 05:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722256180; x=1722860980; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0jRrCwwS7yfhX4ncKkApBf9voXtYFnNGA4/PaV8Y9zM=;
 b=RYu9Gmp73+6wLvrkQDWwH/kpzhrolJ99tRHhf9BLkJf7R0YPmZIQ5IRpgsG5iS3AF2
 5b0JlzC5DFgmBa92IChgtxV8hrIrYTGj0h1qT5mE/YPbjoJ0uSbM8muNxBh8Ae5M8L6G
 1PxCN8T+BveJgV4O0Sl46PtJrdqF+kS9sZPWbPksWc4s07Vq0Sc3jDbLPjIZ5CVkTgVp
 e8AjAsN4dpzTLT+MiLvteWr00EKRYeQtJpXUczwynTsuOjxTrWrc2SFHM7dDFBRPymEM
 H+jjCmtscfXdO56yadUNCQ9SHvqOIQbwZC4qpJu75fK4rGgTxmTHprZxp40BvPr0oJMS
 2Mlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722256180; x=1722860980;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0jRrCwwS7yfhX4ncKkApBf9voXtYFnNGA4/PaV8Y9zM=;
 b=qXChhXENBsKHbMAQX/Ou3UtcouisRgHyLw5i2kLOWNEVJJgxiASXlE+wI4aTxmsojZ
 0L1VfyGVkmhexhEdZxlDe28/t9gGyhBbK3g3pKb/6HUA4RozF7lmqWLdQOaUc5D3du5T
 5S6BKyZ+ZALw9gsXKBNBWhRVQq00mT0nPkjA3VL4jfHbf1vgulMnrRCYgElnAdW2C9IZ
 4Z1JUYwX83XUXheQ6v+66U4BU3pX2sA7y5bIAzGVan5Ewa6RBsxoRokvVPARbrvPXNo/
 grUvr/7nu452doDjh3sD0CBKlmGEoY6cHap4Hz9Hy3hbtSYrFsp1gr4Hv7nwFcIHxozu
 TE0w==
X-Gm-Message-State: AOJu0YyL9CvcUbJXsUiB2MaksRp8ooqh30hetF7F5Ai131iPRggBZVl5
 nxnJBGATdTQw3HUl13zJ9ypfsml9ySN01hOOfWajjT6YMTbsJZXIOmNXWJ3ZOruxJ4gY1oBAQje
 ezd+S+R3TC6AAGo8iikz6k1/yYPSVnhTbbjZ9aQ==
X-Google-Smtp-Source: AGHT+IG40NZSP0uYuftV8KwKv3KKRiecAsitu/DSL6WCsVZ7cL+FfDGcs8uW3Zs+3uDwFIvwN56OPPatvU5V3LJNqo8=
X-Received: by 2002:a05:6a20:a11f:b0:1c2:94ad:1c67 with SMTP id
 adf61e73a8af0-1c4a1307462mr6082685637.30.1722256179637; Mon, 29 Jul 2024
 05:29:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1721910373.git.jerome.forissier@linaro.org>
 <4dee5a89157f3dd0e0a8d17ab6ff42292bb7ce79.1721910373.git.jerome.forissier@linaro.org>
In-Reply-To: <4dee5a89157f3dd0e0a8d17ab6ff42292bb7ce79.1721910373.git.jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 29 Jul 2024 15:29:03 +0300
Message-ID: <CAC_iWjLpwGzyNqqgs0YVZpR4=Vncnd7V_DVDcONX9OweyrDWGg@mail.gmail.com>
Subject: Re: [PATCH v5 18/20] net-lwip: add TFTP_BLOCKSIZE
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Javier Tia <javier.tia@linaro.org>, 
 Raymond Mao <raymond.mao@linaro.org>, Maxim Uvarov <muvarov@gmail.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Baruch Siach <baruch@tkos.co.il>
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

Hi Jerome,

On Thu, 25 Jul 2024 at 15:59, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Add support for setting the TFTP block size. The default value (1468)
> is fine for Ethernet and allows a better throughput than the TFTP
> default (512), if the server supports the blksize option of course.
>
> I tested this change with qemu_arm64_lwip_defconfig. The throughput is
> now 875 KiB/s vs. 313 KiB/s before. That is still a low number, but I
> think we can't expect more without implementing the windowsize option.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  net/Kconfig     | 20 ++++++++++----------
>  net/lwip/tftp.c |  2 ++
>  2 files changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/net/Kconfig b/net/Kconfig
> index 952690d677d..7e5406bb923 100644
> --- a/net/Kconfig
> +++ b/net/Kconfig
> @@ -69,16 +69,6 @@ config SYS_FAULT_ECHO_LINK_DOWN
>           this option is active, then CONFIG_SYS_FAULT_MII_ADDR also needs to
>           be configured.
>
> -config TFTP_BLOCKSIZE
> -       int "TFTP block size"
> -       default 1468
> -       help
> -         Default TFTP block size.
> -         The MTU is typically 1500 for ethernet, so a TFTP block of
> -         1468 (MTU minus eth.hdrs) provides a good throughput with
> -         almost-MTU block sizes.
> -         You can also activate CONFIG_IP_DEFRAG to set a larger block.
> -

Why do you have to move the config option?

Cheers
/Ilias
>  config TFTP_PORT
>         bool "Set TFTP UDP source/destination ports via the environment"
>         help
> @@ -263,4 +253,14 @@ config SYS_RX_ETH_BUFFER
>           since all buffers can be full shortly after enabling the interface on
>           high Ethernet traffic.
>
> +config TFTP_BLOCKSIZE
> +       int "TFTP block size"
> +       default 1468
> +       help
> +         Default TFTP block size.
> +         The MTU is typically 1500 for ethernet, so a TFTP block of
> +         1468 (MTU minus eth.hdrs) provides a good throughput with
> +         almost-MTU block sizes.
> +         You can also activate CONFIG_IP_DEFRAG to set a larger block.
> +
>  endif   # if NET || NET_LWIP
> diff --git a/net/lwip/tftp.c b/net/lwip/tftp.c
> index 78de0bd0dba..1fe948c84ec 100644
> --- a/net/lwip/tftp.c
> +++ b/net/lwip/tftp.c
> @@ -136,6 +136,8 @@ static int tftp_loop(struct udevice *udev, ulong addr, char *fname,
>         if (!(err == ERR_OK || err == ERR_USE))
>                 log_err("tftp_init_client err: %d\n", err);
>
> +       tftp_client_set_blksize(CONFIG_TFTP_BLOCKSIZE);
> +
>         ctx.start_time = get_timer(0);
>         err = tftp_get(&ctx, &srvip, srvport, fname, TFTP_MODE_OCTET);
>         /* might return different errors, like routing problems */
> --
> 2.40.1
>
