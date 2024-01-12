Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3315EC4707C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 09:46:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72D3286E05;
	Fri, 12 Jan 2024 10:45:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ehDqIFjB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 867A38798D; Fri, 12 Jan 2024 10:45:56 +0100 (CET)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6E6C8798B
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 10:45:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-db4364ecd6aso4663440276.2
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 01:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1705052751; x=1705657551;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MMwa3WW7jBCjZsKTglfRFvWN6Mh/szRar0jI3Qw5s7c=;
 b=ehDqIFjBOQNGjDKILVUKwe1aydd/jNcxYDcpUILJPOyy0GtEccyXhAqlAb9XHQfShb
 0cHVxCx4idav96VkuqCC58yLolh66VlK9gAnPpZ70MHqM6HrkQ1WKai4Vv+tDpCvSzwJ
 DbjjzcVwYclbaI3hd73gmoyN0Vx9fO0oA2a9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705052751; x=1705657551;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MMwa3WW7jBCjZsKTglfRFvWN6Mh/szRar0jI3Qw5s7c=;
 b=qsCdwqG9JaYBAuvufmMtUVCdg+AmGBLFFeKm3seg5Vb5lcwLnsihpHxT8RtCx3pV53
 3wp137Z0yS4gOfc1dy+yqFbAN6SzQ3QhFiC+A6iLVFahKr/do+0miRoJTPt5KNfWU4Fg
 JWSrKXIg38lhLvCJGLlxoCbFlbGU4phhxRAMSRLFnWxs0A0ytKmjG0v9wxF4a33EOfxQ
 GsWp8nx3/Q97RIQlJR4P6/Sxd5xTvCPqHY+ckKuprXVsmhylqD7Vvf8bI4EfRVT/E/xN
 IyMre1Z0yPa6tJ5BzeJD7/3JgCNEggoliO5JuWbcRIStzMa6mt0VjmZLt2uaigFkSDSK
 nrlw==
X-Gm-Message-State: AOJu0Ywm8b570fa/WE8pc/nyuJlMqhYMvxdM1mzsFYEry2IspF4+EPRR
 /U/6U2+ZACYHQRC7z414VwuIOuEvlkXo5+NOUBMepCViGI0StA==
X-Google-Smtp-Source: AGHT+IG4gMU187FeeqUHkLvGjgcH4NKLqrf/vFYJe8XrC5HhzO8n6WC5Q6BHEwfwVuktPD6YA8ci3dBD+Jh+97H9psU=
X-Received: by 2002:a25:ae48:0:b0:dbd:ac49:223 with SMTP id
 g8-20020a25ae48000000b00dbdac490223mr323404ybe.90.1705052751340; Fri, 12 Jan
 2024 01:45:51 -0800 (PST)
MIME-Version: 1.0
References: <20240111131920.73691-1-rogerq@kernel.org>
 <20240111131920.73691-2-rogerq@kernel.org>
In-Reply-To: <20240111131920.73691-2-rogerq@kernel.org>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Fri, 12 Jan 2024 10:45:40 +0100
Message-ID: <CABGWkvpx+01O4VXAQ5NNGUMdDVcvfHG1G6Y=BfTWeAF7Cf2r6A@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] memory: ti-gpmc: Fix build
To: Roger Quadros <rogerq@kernel.org>
Cc: trini@konsulko.com, michael@amarulasolutions.com, vigneshr@ti.com, 
 nm@ti.com, praneeth@ti.com, afd@ti.com, srk@ti.com, u-boot@lists.denx.de
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

Hi Roger,

On Thu, Jan 11, 2024 at 2:19=E2=80=AFPM Roger Quadros <rogerq@kernel.org> w=
rote:
>
> sys_proto.h no longer exists for K3 platform so drop it.
> Include sizes.h to so SZ_16M is visible.
>
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>
> Notes:
>     v2: no change
>
>  drivers/memory/ti-gpmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/memory/ti-gpmc.c b/drivers/memory/ti-gpmc.c
> index 775e78c9a5..0b8674339e 100644
> --- a/drivers/memory/ti-gpmc.c
> +++ b/drivers/memory/ti-gpmc.c
> @@ -6,7 +6,6 @@
>   */
>
>  #include <asm/io.h>
> -#include <asm/arch/sys_proto.h>
>  #include <clk.h>
>  #include <common.h>
>  #include <dm.h>
> @@ -17,6 +16,7 @@
>  #include <linux/mtd/omap_gpmc.h>
>  #include <linux/ioport.h>
>  #include <linux/io.h>
> +#include <linux/sizes.h>
>  #include "ti-gpmc.h"
>

Reviewed-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

Thanks and regards,
Dario

>  enum gpmc_clk_domain {
> --
> 2.34.1
>


--

Dario Binacchi

Senior Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com
