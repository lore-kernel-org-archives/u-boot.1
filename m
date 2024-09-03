Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3752DCD342F
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 07:40:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5D1B88C3A;
	Tue,  3 Sep 2024 09:40:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="be5Tj91Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C1A588C40; Tue,  3 Sep 2024 09:40:37 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CC6888C36
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 09:40:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-428e0d18666so42366725e9.3
 for <u-boot@lists.denx.de>; Tue, 03 Sep 2024 00:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725349235; x=1725954035;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=GC2d/KHrVdyswUWlxErQZST/E5L0Gc9a0T21vOPmYEo=;
 b=be5Tj91YCLOM9PmOYgw+a/1QXZz7Msbol+dYUwjkMC7/gH9VB2VXsaHb7Ga+0KJc9X
 yMKdsypboAQi/eFiSrvOi2U1hGWt1Yu9oiBw1FXd5wg49sKLcsL7PAmEU8b6GzaQXZGw
 1MJ4W3ZVNW8zOrFr72Hzj5/qL3I1nc+W11w3pDTwraREyq2HAR44kqtt+/hzXj/04xC3
 vzxbVq7ILpyyMV03N9/k6FSMw4gihkE4UtPke3Dvi0v9jdv3HDJBKdOL3xHrJI3TBLZk
 Q6gyQh6AUknIXAblfOVpUapqOtQuciv+wsxYEGEGU8o/CkP+1//1cez/rNONNyDxoUtP
 fs+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725349235; x=1725954035;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GC2d/KHrVdyswUWlxErQZST/E5L0Gc9a0T21vOPmYEo=;
 b=ZSJBYH0AmZejn0gHdRymi+2uj7PJLVf+b30WskWasQFl//vvXYYgcVfuZPrI7wYVce
 oiee6Yw1Zzq9RsLW6QCfgIt3y/QjBR7oD/6Dc6jECy+f/XU2/vv5Os8iRdOHWqN0oMDY
 UfhlcvWkI6mXQ8FV7ORtS01OF19flrOg9fKrsAdCMRDyA8WsqNGOUoaElgXAn21dhSn6
 53bVjXhJ6sP8eTok3TDC0HTTPuGyH35y5IbMow1M7NaDrRIAeHxHwidlFxWIqO3EUqHz
 N3qt1ta4PWveZjUmhFasQaaGlVSHWMTeB9M1lxkWnsctCkUbbcOLr4hvwPOaBhiKyF47
 Pcdw==
X-Gm-Message-State: AOJu0YwZuu9YfS/anyHaBgScquka3GPTEnCus9nVnrZZw6rfbQEcuz8H
 /VVX2TU+wf410NnPW9QYZneKgN7m2Ikjqjb4eP4GyaJCfS/W60W6OSw0g2624zY=
X-Google-Smtp-Source: AGHT+IFRHLJ3t0L09HWd9/LVMBoQn9Nhz9epDyPitp5YRJHMo6mm25sN//4SVCbqt7oF3RKPvGssIg==
X-Received: by 2002:a05:600c:997:b0:42b:ac3f:f5c with SMTP id
 5b1f17b1804b1-42bbb436de5mr78225265e9.26.1725349234146; 
 Tue, 03 Sep 2024 00:40:34 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6deb27fsm161025205e9.10.2024.09.03.00.40.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 00:40:33 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Guillaume La Roque <glaroque@baylibre.com>, Bryan Brattlof <bb@ti.com>,
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>,
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: u-boot@lists.denx.de, Vishal Mahaveer <vishalm@ti.com>, Guillaume La
 Roque <glaroque@baylibre.com>
Subject: Re: [PATCH 3/3] board: ti: am62px: Add android bootflow support
In-Reply-To: <20240902-sitaraupstream-v1-3-0c478c33c08b@baylibre.com>
References: <20240902-sitaraupstream-v1-0-0c478c33c08b@baylibre.com>
 <20240902-sitaraupstream-v1-3-0c478c33c08b@baylibre.com>
Date: Tue, 03 Sep 2024 09:40:31 +0200
Message-ID: <87y1496v80.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Guillaume,

Thank you for the patch.

On lun., sept. 02, 2024 at 18:31, Guillaume La Roque <glaroque@baylibre.com> wrote:

> From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>
> When CONFIG_BOOTMETH_ANDROID is set, enable Android boot flow support.
>
> To build for AM62Px for Android, we can re-use
> the am62x_a53_android.config fragment when building A53 bootloaders:
>
>   $ make am62px_evm_a53_defconfig
>   $ make am62x_a53_android.config
>   $ make
>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  board/ti/am62px/am62px.env | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/board/ti/am62px/am62px.env b/board/ti/am62px/am62px.env
> index f8b6aff2c2fd..7ef54079aa8d 100644
> --- a/board/ti/am62px/am62px.env
> +++ b/board/ti/am62px/am62px.env
> @@ -13,3 +13,8 @@ mmcdev=1
>  bootpart=1:2
>  bootdir=/boot
>  rd_spec=-
> +
> +#if CONFIG_BOOTMETH_ANDROID
> +#include <env/ti/android.env>
> +adtb_idx=3
> +#endif
> \ No newline at end of file
>
> -- 
> 2.34.1
