Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26928D3C90B
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 11:50:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E0D5890BC;
	Sat, 19 Oct 2024 13:50:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RsfeJMRW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D530E88B23; Sat, 19 Oct 2024 13:50:49 +0200 (CEST)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C60E889034
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 13:50:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7b15495f04dso181230185a.0
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 04:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729338647; x=1729943447; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=J9SFKFU5WrBOrUk7qRffqjcpzfyiKxthi1Jrf//hVWk=;
 b=RsfeJMRWHUuYdZhF+oT3jMkmNRrkFR5VEAMdVNVoH4oc+fWqTDZJpP4t/FowGIxy8Y
 w48kjDHRjhKGOWA0V0L3kProkIFoZZC5qGgfsDzt7fcWcQL9ZhJRps6zFYSYeAvcSsgQ
 YIk4UR3ddpU+UvkAYWnCZpckeqHnVlb9vatEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729338647; x=1729943447;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J9SFKFU5WrBOrUk7qRffqjcpzfyiKxthi1Jrf//hVWk=;
 b=ntyxRytFc7rY3bMx8Rj1FuaWlUIcKgjeJhim1SnEoTZk2w+a5SPG0mibBzLnfroykx
 nh+sE/KcXY1A6UKa4A9RlOQP60s1ks2fXb9O65xy8JOH+R7Lir/++1Q1Z0fRjx1Jt4GR
 MnJUeNlDbu9QGpo5c6G6OcvUTmDablzDdRbYiDrJnDE1Zuf1WK0G53SV+BEdTHu7jcZK
 3xu2VPD1tVvAL7yI+k8/REIMS15uGknGigDUevCvK4uxFd6oWrwumS8mdvpo4bzINJde
 3BTPUV9KQYDM74h5HRpRvzaMghT3lEWCo41vJW4V4j4qThZrmGXyOFpIxu2qeJpq/CJH
 x6aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5eBfmJFjHhJyd8nGbFvpydb4KdBuvXqcUwLrL6aAzNah1+y7mBn3AVxb730zq/RCQ4xMX+Ic=@lists.denx.de
X-Gm-Message-State: AOJu0YxLkUcYOFmDBnFEBlSPl7iKPMt6JiKgYxnVmDk5NwLgX2gB7Cy6
 znccmgU1bYmCKUP+tSJqYRSfkHnZM03/lncyLbXECLdhOy2MZLHjYTMVu8kVYgwGPqe5xHNifsQ
 phCssaFdoNto735YFnISsC8Jqqu0UndEtNUmo
X-Google-Smtp-Source: AGHT+IHDJ4IEzt/SpGzvTErP/o2SRwwtLjVFbCrg4h0CgsRC/nwQr+/EPXcPvyQua+49fBxxKnJkmLI60LS5nHr0Qfk=
X-Received: by 2002:a05:6214:5f0c:b0:6cb:e6fa:4960 with SMTP id
 6a1803df08f44-6cde115b0dfmr75531476d6.0.1729338646744; Sat, 19 Oct 2024
 04:50:46 -0700 (PDT)
MIME-Version: 1.0
References: <20241018142235.715571-1-ilias.apalodimas@linaro.org>
 <20241018142235.715571-6-ilias.apalodimas@linaro.org>
In-Reply-To: <20241018142235.715571-6-ilias.apalodimas@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 19 Oct 2024 05:50:36 -0600
Message-ID: <CAFLszTgrV00E1F=PgYBS7jHM3hae7UROg0mDbQcbHV34HW8QvQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] configs: Enable htts for wget on qemu arm64
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: jerome.forissier@linaro.org, raymond.mao@linaro.org, xypron.glpk@gmx.de, 
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Wei Ming Chen <jj251510319013@gmail.com>, 
 Jonathan Humphreys <j-humphreys@ti.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Javier Tia <javier.tia@linaro.org>,
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

On Fri, 18 Oct 2024 at 08:23, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> QEMU already has an lwip variant of a defconfig. That defconfig
> is also configured with mbedTLS by default. So let's enable the
> remaining config options to enable wget for https:// as well
> and test that codepath in the CI
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  configs/qemu_arm64_lwip_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>


> diff --git a/configs/qemu_arm64_lwip_defconfig b/configs/qemu_arm64_lwip_defconfig
> index d3d8ef16e668..754c770c33fc 100644
> --- a/configs/qemu_arm64_lwip_defconfig
> +++ b/configs/qemu_arm64_lwip_defconfig
> @@ -7,3 +7,4 @@ CONFIG_NET_LWIP=y
>  CONFIG_CMD_DNS=y
>  CONFIG_CMD_WGET=y
>  CONFIG_EFI_HTTP_BOOT=y
> +CONFIG_WGET_HTTPS=y
> --
> 2.45.2
>
