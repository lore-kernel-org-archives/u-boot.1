Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE40FC4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 09:23:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D6DB88B29;
	Wed,  1 May 2024 11:23:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G8NUmmXd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2144888B27; Wed,  1 May 2024 11:23:42 +0200 (CEST)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C45888B33
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 11:23:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2ac9b225a91so5103779a91.2
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 02:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714555418; x=1715160218; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XwXdkc14sbsqvtgrbcLDUwjTmnyfRQhVMwVYII56GqM=;
 b=G8NUmmXdOuCxf8p9SIBzR8L4XQ/mN2VZBAh/Ua16NRl87zUXTO9WACT/kFxSe0WCCD
 Y2r7IM+Lvuiob/NPAyG4HwHBQ3GCZ4yvicHj9nBagfLbsloQitUdi5wyIoDMqEDHhf/G
 EiYXObihkw5a3+BJxtb1OyOpoz/T/Ccy87jHg52qXaEVSJeb7wUNwTheJ1aaXTMeJdoj
 bKyMS7cIZhPlhYjB2MbgdAfPZ4MKss/HY7vCa3X7rrGNgUX/L4rrNhg2DjzG+cPMoRIc
 5wy+tNHDmaFFAJneXypZqFWFCp8rndBHipME7GvsbDV5XJr60FRzhlAwzhKg+F7UaMe4
 A+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714555418; x=1715160218;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XwXdkc14sbsqvtgrbcLDUwjTmnyfRQhVMwVYII56GqM=;
 b=LoMMUwfAy1qxkpwAM8pzIoDtoWDPMkU4sVNQlkdaIs+1mp2abcLAy+GxMXBqYruDAZ
 pwar0jDEkizfUwYcGmyZQt0k7CbwQh01DE3kHAorjsKmT+fHkpzwFDmWUtqTyFFqp7+V
 i+EMI4ulZ1YbF5gfEtze2yrBtba1gOD4yvDMgN04SCv/cBy+yKzyqaZmGGG1yPuccNXH
 AMgPmbiHLns0EVy3jlalU9o4dnATYBOl6ri9eg6y4RktHr6fyrsRFyWULfS3U39jAkS2
 QyMt00Z1mUuHc/nXifjmW3aEN4kqSdKnfwwMV7Ony1RuRGwkEdquptOLqoHZ+nEGNugN
 s4sA==
X-Gm-Message-State: AOJu0YzzSPmpe9DeFNFUYILcg/eXkAm8ka77djak0YMKAngV8zylaNRX
 sZdyXoMTKfi/0CnNMYppd73HWB1ZmRAfw90AP4dEkHL2fMgEUS4ObWPiAGO+JB7Uoo6wHqwqIPn
 G4btxRpV7/Msljx2JdmyC3yQWTR4=
X-Google-Smtp-Source: AGHT+IEYXFJ4ahbX/4cI0nCOHI2GEGCZOJ+4UWTwhdvgOrOQ+ITSO1TdjepphgxMDUSGiXy62ZElb6+Irz5T05FwdlA=
X-Received: by 2002:a17:90a:b284:b0:2af:3c0e:f6b8 with SMTP id
 c4-20020a17090ab28400b002af3c0ef6b8mr1701238pjr.3.1714555417790; Wed, 01 May
 2024 02:23:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240501024316.1767971-1-trini@konsulko.com>
 <20240501024316.1767971-48-trini@konsulko.com>
In-Reply-To: <20240501024316.1767971-48-trini@konsulko.com>
From: Adam Ford <aford173@gmail.com>
Date: Wed, 1 May 2024 04:23:26 -0500
Message-ID: <CAHCN7xKEZpYkdnY+30noWZBVY0K7AD_RmELq2Hb4D=DMLkUG7A@mail.gmail.com>
Subject: Re: [PATCH 048/149] board: davinci: Remove <common.h> and add needed
 includes
To: Tom Rini <trini@konsulko.com>
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

On Tue, Apr 30, 2024 at 9:44=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> Remove <common.h> from this board vendor directory and when needed
> add missing include files directly.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>

Acked-by:  Adam Ford <aford173@gmail.com>

> ---
> Cc: Adam Ford <aford173@gmail.com>
> ---
>  board/davinci/da8xxevm/da850evm.c      | 2 +-
>  board/davinci/da8xxevm/omapl138_lcdk.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/board/davinci/da8xxevm/da850evm.c b/board/davinci/da8xxevm/d=
a850evm.c
> index 05053a87a5a9..0011c8285237 100644
> --- a/board/davinci/da8xxevm/da850evm.c
> +++ b/board/davinci/da8xxevm/da850evm.c
> @@ -8,7 +8,7 @@
>   * Copyright (C) 2007 Sergey Kubushyn <ksi@koi8.net>
>   */
>
> -#include <common.h>
> +#include <config.h>
>  #include <dm.h>
>  #include <env.h>
>  #include <i2c.h>
> diff --git a/board/davinci/da8xxevm/omapl138_lcdk.c b/board/davinci/da8xx=
evm/omapl138_lcdk.c
> index 9738e2bd9c77..607e05ad9ae4 100644
> --- a/board/davinci/da8xxevm/omapl138_lcdk.c
> +++ b/board/davinci/da8xxevm/omapl138_lcdk.c
> @@ -8,7 +8,7 @@
>   * Copyright (C) 2007 Sergey Kubushyn <ksi@koi8.net>
>   */
>
> -#include <common.h>
> +#include <config.h>
>  #include <env.h>
>  #include <i2c.h>
>  #include <init.h>
> --
> 2.34.1
>
