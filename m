Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D10ECA0FE1
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 12:01:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5EF488B55;
	Fri, 30 Aug 2024 14:01:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P6LqWe2I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1B8088BBF; Fri, 30 Aug 2024 14:01:38 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C12888A5B
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 14:01:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a866d3ae692so104737066b.0
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 05:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725019296; x=1725624096; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MAwAFUf8igE1ZQase+YB15z9w/z89CizY34jBygtC8M=;
 b=P6LqWe2I9aMzUx7Ykbu7EBqJ4Y4cz7/+7+f4dn6DUX4FCGvs/qan7vvKzCjDRurODr
 vKXy843RaDWxj2jh1mffsgciKhAIaaJfecd2TVPCPG1PzAnwInbropP4GcF/RHmtl7Cy
 CXlaOFQACeQA1rsKljNbwI2QhuNbbdoqGpNrn3qL8CYsuB8TyQtpE+8PGJFaBEdXJjOf
 hYJ9FjWH0lL7vwhDsBWkKCC3SILrGdpTDngGJY9xxTdQRX4n81RN5mFwtR9Tsm4W1weU
 kUpsW+0XhJ3yYPG0wcQiiJCWk2jdql6hmEQ+AFQ+4oBi9alVGLJQu22e2fBgJlDh+HYJ
 qudQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725019296; x=1725624096;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MAwAFUf8igE1ZQase+YB15z9w/z89CizY34jBygtC8M=;
 b=BPUbMkeHpvcUOWDyHQUEJqonebrgQB5bU6SvPvIuR2X+Y3I726S8cNMw9nWy9L8EQ2
 lMYpqfrnmIK/FkbM2Dj25ADdKpXFm/rPe8mkWq5WR0wSZymb4+a3XZZ13W3IS61wXHWi
 XWeqIYFHj+aO/oc6mQV/Lawg+kmZuoZKIBjYyLeRDpkm1KUrVPCkfuQhv4Y7ABIVmhPz
 nOwxywDp2spl9mfLaE3lEg4zMiJYrJ3lc4qUqa8+BIrpnnDgnzFkX7+DJwfsDO9D/zAW
 JTGsZwV2R8Q3tWIzwOK7FDnhRpBNab2rAokCBaXuneI9R7eMehBbGm0kcmNcVL0k3Pmq
 sxJA==
X-Gm-Message-State: AOJu0YwjnZivq/ylHA1XhbREF9kxnKldst/QqUF7fz39IKT963Ckqk6Y
 bP0yc7ywSMD40yLFmUbU1/x0JYVb4Q63j2gTo70Uv4E7qyjR63wSGCdPBj575I0q0ri6bB2bCuB
 ThnLo5Mis/B1oF3Iw5DHfDSIaHl8=
X-Google-Smtp-Source: AGHT+IE8RWjcXYFV4wDTl5T5odlO/OWpI2NbwQhFy1S54aXjCAI3BrsdMwyVAUbS201fCSe2OHedZZ43jb970tJ8oxM=
X-Received: by 2002:a05:6402:3506:b0:5c0:a8b4:3d92 with SMTP id
 4fb4d7f45d1cf-5c21ed8ba82mr6583127a12.27.1725019295108; Fri, 30 Aug 2024
 05:01:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1725012294.git.jerome.forissier@linaro.org>
 <2fc6c69a1aa28b578684642959906cfe000b2a0c.1725012294.git.jerome.forissier@linaro.org>
In-Reply-To: <2fc6c69a1aa28b578684642959906cfe000b2a0c.1725012294.git.jerome.forissier@linaro.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Fri, 30 Aug 2024 13:01:23 +0100
Message-ID: <CALeDE9PZw47C2XQeX5QFeicBSmm_GY+5UwvAUVLu+JJT6NFVSQ@mail.gmail.com>
Subject: Re: [PATCH v2 16/16] cmd: pxe: CMD_PXE implies CMD_TFTPBOOT
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Michal Simek <michal.simek@amd.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Anand Moon <linux.amoon@gmail.com>
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

On Fri, 30 Aug 2024 at 11:17, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> cmd/pxe.c (CMD_PXE) calls do_get_tftp() (CMD_TFTPBOOT) therefore add
> an "imply" to cmd/Kconfig.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
> ---
>  cmd/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 978f44eda4..be15a4d267 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -2091,6 +2091,7 @@ config CMD_ETHSW
>  config CMD_PXE
>         bool "pxe"
>         select PXE_UTILS
> +       imply CMD_TFTPBOOT
>         help
>           Boot image via network using PXE protocol
>
> --
> 2.40.1
>
