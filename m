Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D4EBCF07B0
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 06:34:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1EE18911E;
	Thu, 10 Oct 2024 08:34:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="gfbsGIHX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE7DF8911E; Thu, 10 Oct 2024 08:34:50 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC122890CC
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 08:34:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5c896b9b3e1so671140a12.2
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 23:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1728542088; x=1729146888;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=95XZnqm5392QsWE43jbw9JWx1dHBepP3n+90hGkP0Vk=;
 b=gfbsGIHXtly8/yvG9LFKCrp91cVLHAdc4SSGHbPwgqfYwqMyS6ujhg6I7+tsZNwrD4
 TOQRRVAHZNT+UAWuuJbYZ10csjCuwiI+ZYqYaf5sLU6vfT39rAT48/e49uDNbJBgWOQm
 aJ9yzRlzX90PVvynFJDPPoGHZeBWXbVobjr2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728542088; x=1729146888;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=95XZnqm5392QsWE43jbw9JWx1dHBepP3n+90hGkP0Vk=;
 b=WuF+EQk+R19j2c9RumYt3/zFcYjuIiMy46ad1a8V90brlOu2OsUbcWq79nrozhqw6G
 GCvbQDyVBXYrQbqmhrM+gdHCsAH1jCCplBOmKQWFJBo5J2eTMrvXrIhv2QHWWcbpnE1l
 dwCxX9klGlB5fCEYyfUumgO4+UzCFulFQxbe35D8zDgqI9AWhRM9n/aqviwcEwGcKdLF
 zIZanDdOK4hQyU7gkANmuVwBwNrXK+5I04kLgvc3VTn7udub2F4lO5AAQNeetpp5wCdg
 m/kqysEhyt5GmTYcun4sQaVEDAmrhKOQevJM+PTkVrBaxo9ZmX3baIIV1cNcQr/OhzAB
 iwZA==
X-Gm-Message-State: AOJu0YyUDl9V+hUwdVlAbgpbpPx037t6cEra90GWoU9ydZ7YVxwRWaVM
 Qu8r4Hs6tOaQSYp+1dGaAeXzOa2hSzR1OG1U7WlLNVw9VTZYYOe3eBTJebhCRRW5ULf6HtYuuvF
 WMCavuJHzdEF4vt99C5AZtEvk3EFgAbmcHTYL+g==
X-Google-Smtp-Source: AGHT+IELgdLN9YaLz/ZgargUIaC2nPa45FJJA4t1CiyGCUFYUDshgpJinSJeYk1b6zOAXLtRsssAGyPtdcXm631UpJI=
X-Received: by 2002:a05:6402:3582:b0:5c9:3fe:c7b9 with SMTP id
 4fb4d7f45d1cf-5c91d4084c8mr3839323a12.0.1728542087993; Wed, 09 Oct 2024
 23:34:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1728539755.git.jan.kiszka@siemens.com>
 <f1a4ce2a80a6d49863717f5f4cb04fd48399b304.1728539755.git.jan.kiszka@siemens.com>
In-Reply-To: <f1a4ce2a80a6d49863717f5f4cb04fd48399b304.1728539755.git.jan.kiszka@siemens.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Thu, 10 Oct 2024 08:34:36 +0200
Message-ID: <CAOf5uwm+pKx8o3=AxGcQJY9SiPSDE_2hjRLQuzFgdSr4DdFLZQ@mail.gmail.com>
Subject: Re: [PATCH 01/11] board: siemens: iot2050: Fix mistake in list of
 writable env vars
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bryan Brattlof <bb@ti.com>,
 Nishanth Menon <nm@ti.com>
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

On Thu, Oct 10, 2024 at 7:56=E2=80=AFAM Jan Kiszka <jan.kiszka@siemens.com>=
 wrote:
>
> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> This prevented to set m2_manual_config - as evaluated by
> m2_connector_setup - under strict configurations for secure boot.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  include/configs/iot2050.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/configs/iot2050.h b/include/configs/iot2050.h
> index 94a9c767882..0f92e0d25dc 100644
> --- a/include/configs/iot2050.h
> +++ b/include/configs/iot2050.h
> @@ -39,7 +39,7 @@
>  #define CFG_ENV_FLAGS_LIST_STATIC                                      \
>         "board_uuid:sw,board_name:sw,board_serial:sw,board_a5e:sw,"     \
>         "mlfb:sw,fw_version:sw,seboot_version:sw,"                      \
> -       "m2_manuel_config:sw,"                                          \
> +       "m2_manual_config:sw,"                                          \
>         "eth1addr:mw,eth2addr:mw,watchdog_timeout_ms:dw,boot_targets:sw"
>  #endif
>
Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>

> --
> 2.43.0
>


--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
