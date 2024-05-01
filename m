Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4A56C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 20:25:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AD83885A2;
	Wed,  1 May 2024 22:25:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CJyjwqlK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49A46885C8; Wed,  1 May 2024 22:25:28 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6090788592
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 22:25:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-56e6a1edecfso10712658a12.1
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 13:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714595126; x=1715199926; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Icl68SWXNX01GM2c1L6i7bh8o/yawCz19C4wMFwU+Dw=;
 b=CJyjwqlKHriJ0CmSNsbO8/mCRRdQRN+P0r/wenNEE55mvzJPl483JXtD5sVwuNkwxk
 czhBTElJioVVHxUDdi/xD0FpQZTkRLbG0EJGTn7EZzXLvFyHl5duIqcCuCrufU4BOk6p
 IPBWKJUeDFSroAlgFYjR1nexe+UTwbUP1LZ3tmf/GFx2xA/iDLXWdjd5VcAYshr6XytW
 JpiwmABUl/9l/30BxBb7UYQSZiFEbc3kipo7p+YhWdhmrTxT0WwpptByUewKhbQvcU2O
 IOcV99+1i4OsubfIzz53P3BjvOSH/KbQJdUQmZSB4zA3fAQOH+AqT29lC/KxJ8xpLMwk
 4jSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714595126; x=1715199926;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Icl68SWXNX01GM2c1L6i7bh8o/yawCz19C4wMFwU+Dw=;
 b=KpVvSBPbUse8seNQSbOHE0emebwRdlIHPBrt0eh7wVjtMG25KGPViLj39LzjcJxKAV
 X5fyOODuYl1eu5vUkS2l8bIZx11CVRB3UY8RCifK54hqugkCxGXzNdtusgbFwD2mQD2H
 JKBECGMwjF16tNZJvI0i7lvJYdZXmK7r8Vn4aGEcTI1ilNSfK9VuQEdRXI1qHsTI5KID
 hgnbegVar6mqxCWrTMH2P9XAMgKbkdu5ghhfqnzkNChNdsNs+9gtM7yzSLNt4q8wH95w
 49SgyYBWEtecB7IF648DvKSLtB+Wz1ALAO/pkDhvRN/7UVhPDQ22HKwe49B31JgIpNpw
 b4VQ==
X-Gm-Message-State: AOJu0YyIKYxGgmZmJmhLj0k5EN7o8EcfVGZQvfsYzfpJ3UFoaTCQqHGT
 f+vgp7WcoSyVc8wZSkiKVivhf4gNPVy4RmywjouIDQ99s+2rHhH/i7GDmDvnEaSO9r4rtZk/VLk
 4qhsZGA0V13N2uKqnFPhBHWapHWqUhZ95
X-Google-Smtp-Source: AGHT+IEqQc2JQ6h5w/+OZO4jci8FOW3KaIQyysX1gTCkQElMbLWtpdrBFpaQPFWTgNw8mo9yXkLNh/trLYbEdlFi/5U=
X-Received: by 2002:a50:bac4:0:b0:56d:faa2:789b with SMTP id
 x62-20020a50bac4000000b0056dfaa2789bmr2125056ede.40.1714595125855; Wed, 01
 May 2024 13:25:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240501024316.1767971-1-trini@konsulko.com>
 <20240501024316.1767971-39-trini@konsulko.com>
In-Reply-To: <20240501024316.1767971-39-trini@konsulko.com>
From: Tony Dinh <mibodhi@gmail.com>
Date: Wed, 1 May 2024 13:25:00 -0700
Message-ID: <CAJaLiFx7QjT0jqJ+kZOY5OOsUOHhyJNoigsJS1qCA_Z57wxmEQ@mail.gmail.com>
Subject: Re: [PATCH 039/149] board: cloudengines: Remove <common.h> and add
 needed includes
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Dave Purdy <david.c.purdy@gmail.com>
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

On Tue, Apr 30, 2024 at 7:44=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> Remove <common.h> from this board vendor directory and when needed
> add missing include files directly.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Dave Purdy <david.c.purdy@gmail.com>
> Cc: Tony Dinh <mibodhi@gmail.com>

Reviewed-by: Tony Dinh <mibodhi@gmail.com>

> ---
>  board/cloudengines/pogo_e02/pogo_e02.c | 1 -
>  board/cloudengines/pogo_v4/pogo_v4.c   | 1 -
>  2 files changed, 2 deletions(-)
>
> diff --git a/board/cloudengines/pogo_e02/pogo_e02.c b/board/cloudengines/=
pogo_e02/pogo_e02.c
> index 59e1218b411a..48eee67129fa 100644
> --- a/board/cloudengines/pogo_e02/pogo_e02.c
> +++ b/board/cloudengines/pogo_e02/pogo_e02.c
> @@ -10,7 +10,6 @@
>   * Written-by: Prafulla Wadaskar <prafulla@marvell.com>
>   */
>
> -#include <common.h>
>  #include <init.h>
>  #include <log.h>
>  #include <netdev.h>
> diff --git a/board/cloudengines/pogo_v4/pogo_v4.c b/board/cloudengines/po=
go_v4/pogo_v4.c
> index 61ce0d59c77e..c8ad563f721d 100644
> --- a/board/cloudengines/pogo_v4/pogo_v4.c
> +++ b/board/cloudengines/pogo_v4/pogo_v4.c
> @@ -11,7 +11,6 @@
>   * Written-by: Prafulla Wadaskar <prafulla@marvell.com>
>   */
>
> -#include <common.h>
>  #include <netdev.h>
>  #include <asm/arch/cpu.h>
>  #include <asm/arch/soc.h>
> --
> 2.34.1
>
