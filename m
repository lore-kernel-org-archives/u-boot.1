Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E248ECE7A81
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 13:12:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 803CA86C45;
	Mon, 25 Sep 2023 15:11:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mjWvS08y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9838986C35; Mon, 25 Sep 2023 15:11:21 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB22186B3A
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 15:11:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-503056c8195so10542700e87.1
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 06:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695647479; x=1696252279; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=juuArm+UoaQ+DwdgM+ZUBI5VJ2O1cof9EQwV79x4K0U=;
 b=mjWvS08yneyX6ve9AjejE1LCfX/vT6Efw82981q30vo7n8CvC5qp6XTptM2N8/30oA
 1o1l+QyF9Br1YMqZeE6cY+hTCi2XJBa9XVuO4HI6V9WJwCwKl2TOv74IqEneVnk+uFWj
 rwg89TWDfyKeVrEem4/yvXNNck6qEjA+rgfQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695647479; x=1696252279;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=juuArm+UoaQ+DwdgM+ZUBI5VJ2O1cof9EQwV79x4K0U=;
 b=wqkXvlJ85A8wStA4TR2jaNUHrllqW1RGKZRA/FPkFuQin7p4jY/a+GNXx+hsMdGw7b
 sYel9r64S2DDbOUhVc2wMCZbE/cBn2rR6MTmrIDshYeriKFqUZcjBFEb3RLGnw5rP0qY
 /PQlpqWtfQuneClk1Vkcyn3ZtLJHM4jyJVSN1PmYSu8bpw4aJx8G/h6AXqaeZm/jp1lW
 ze0b/LIYOaMn3DKGZVlkiBWFiPvq/00fdT6e2TuJCU9ufateUlq9HmuD+ayyDml2axKK
 Ysnkfl2X6+IoJVtkUCWonsIZzYa776nIop0i/vavzka+rk6nx8qP83FTH9+WgGhE+DSh
 GDRA==
X-Gm-Message-State: AOJu0YyNBXwJIEgtucDd2qumkbhqKMu2JcaSMllqJolxDCa3b6eyrrYE
 J3oEa4doT7oFQ6lE2cp7k15LbYfO9SohAqjcri+QYg==
X-Google-Smtp-Source: AGHT+IFZeCokwFrTbjlYmxgafEuyT95ewqWpt/uvtTY/NAtOM2sJ1vw2bIWkZbvjl5wfdqZd/ErggkUH7bQjHFEMNTM=
X-Received: by 2002:a05:6512:3d9e:b0:504:3424:215c with SMTP id
 k30-20020a0565123d9e00b005043424215cmr7119613lfv.51.1695647478812; Mon, 25
 Sep 2023 06:11:18 -0700 (PDT)
MIME-Version: 1.0
References: <MAZP287MB05034A33FFAAD17F2A43522EE4FDA@MAZP287MB0503.INDP287.PROD.OUTLOOK.COM>
In-Reply-To: <MAZP287MB05034A33FFAAD17F2A43522EE4FDA@MAZP287MB0503.INDP287.PROD.OUTLOOK.COM>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 25 Sep 2023 07:10:37 -0600
Message-ID: <CAPnjgZ33Wa-ExT-uzU1UBhZrtb0T9u6MOSf2MAJf=rMKgzRFkw@mail.gmail.com>
Subject: Re: [PATCH v2] arm: rpi: remove boot_targets for default standard boot
To: Date Huang <tjjh89017@hotmail.com>
Cc: Matthias Brugger <mbrugger@suse.com>, Peter Robinson <pbrobinson@gmail.com>,
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

On Sat, 23 Sept 2023 at 20:59, Date Huang <tjjh89017@hotmail.com> wrote:
>
> Raspberry pi supports standard boot without boot_targets
>
> Signed-off-by: Date Huang <tjjh89017@hotmail.com>
> ---
>  board/raspberrypi/rpi/rpi.env | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>


>
> diff --git a/board/raspberrypi/rpi/rpi.env b/board/raspberrypi/rpi/rpi.env
> index 30228285ed..8fb8d5d5f7 100644
> --- a/board/raspberrypi/rpi/rpi.env
> +++ b/board/raspberrypi/rpi/rpi.env
> @@ -73,5 +73,3 @@ scriptaddr=0x02400000
>  pxefile_addr_r=0x02500000
>  fdt_addr_r=0x02600000
>  ramdisk_addr_r=0x02700000
> -
> -boot_targets=mmc usb pxe dhcp
> --
> 2.34.1
>
