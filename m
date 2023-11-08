Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3675C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 04:27:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8F7387725;
	Wed,  8 Nov 2023 05:26:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hgT7QQ3N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E036D8772E; Wed,  8 Nov 2023 05:26:51 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D3D78771F
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 05:26:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-5a877e0f0d8so3601717b3.1
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 20:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699417608; x=1700022408; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZQn7oLGd665OtAxOGg5ZAsXKZ7btEJn3WwrPtLbqKEo=;
 b=hgT7QQ3NWG2S3VmIVjS8/PetOE6Cg6CVWNayrV03gQQHHBqeGVMDwoekZSKJ2s1UuX
 jcBhhUwD3Lex46qV9BPl23OsxFW37oKau81fEzPPptaRbUD7KCQ0mt8p/H4RA6zS3MoM
 tk25pd1Xwh9h4AwU1Ef9FvCuIGk7R6CgwbVlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699417608; x=1700022408;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZQn7oLGd665OtAxOGg5ZAsXKZ7btEJn3WwrPtLbqKEo=;
 b=kDDXedNpQjAQrFvdDsRZLkWg/I8JEjRiGz0ahw7eo3Q7bL+ISjCARr2gIqG1drIN6O
 H5BGeKWOFYnwR5KjNYNdiOTE369f7wTpHEO7yXJjL5u1T3VgXD4O++scPVWVea932a+b
 dmIlcaqc9KjSk4JG5XvrWahv/dAGESyJkdJDTIfTglzd0bEI6jQUtdFhQahxX/xTtVHd
 vMMGojtVPy2+GXVS8qGQx9trfOq1MEy3ssCJFefRcjRYW+I/rHDHaikX+T0n8g54T4Ri
 EaP2L2Tk7qTZDT479t1Wt+cXsB5KUEgnqApdpmmaG+7YkYMKe/UUDm5CctaxgDA6nDu3
 wBXQ==
X-Gm-Message-State: AOJu0Yz4y5rK+gNO6glIe7MORX4ngni3nP63ThsMbsIYV9a871yZo7uc
 jyOzitbPri6Nyzv2tJygy/vKlBHa62m632jRDz9+Hw==
X-Google-Smtp-Source: AGHT+IEnHCKzWTzEb83Xmws+hfNhlA4g9Em+CiEh64ooVra8MfjzWky+7759+TJHD0fqvtmwtWxm7HK0FY8JUmOZKas=
X-Received: by 2002:a81:4fd1:0:b0:589:e815:8d71 with SMTP id
 d200-20020a814fd1000000b00589e8158d71mr588214ywb.11.1699417608086; Tue, 07
 Nov 2023 20:26:48 -0800 (PST)
MIME-Version: 1.0
References: <20231106022603.3405551-1-seanga2@gmail.com>
 <20231106022603.3405551-24-seanga2@gmail.com>
In-Reply-To: <20231106022603.3405551-24-seanga2@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 7 Nov 2023 21:24:10 -0700
Message-ID: <CAPnjgZ0ywDLaHp9VCFR3NOpuqtSY=Y1pVqNxpBwFExWkLLtPjg@mail.gmail.com>
Subject: Re: [PATCH v6 23/25] spl: Convert spi to spl_load
To: Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <marek.behun@nic.cz>, 
 Marek Vasut <marex@denx.de>, Xavier Drudis Ferran <xdrudis@tinet.cat>,
 Stefan Roese <sr@denx.de>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Jagan Teki <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>
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

On Sun, 5 Nov 2023 at 19:26, Sean Anderson <seanga2@gmail.com> wrote:
>
> This converts the spi load method to use spl_load. The address used for
> LOAD_FIT_FULL may be different, but there are no in-tree users of that
> config. Since payload_offs is only used without OS_BOOT, we defer its
> initialization.
>
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
> Changes in v6:
> - Fix soft reset after loading from SPI
>
> Changes in v5:
> - Rework to load header in spl_load
>
>  common/spl/spl_spi.c      | 80 +++++++--------------------------------
>  include/spl_load.h        |  1 +
>  test/image/spl_load_spi.c |  1 +
>  3 files changed, 15 insertions(+), 67 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

I am just amazed at how many times this FIT code got copied...there is
something wrong with U-Boot's development model here.
