Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B90F8D774
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 19:37:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D86C8424E;
	Thu, 16 Apr 2026 21:37:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iq3UllmA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B45F8423F; Thu, 16 Apr 2026 21:37:49 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E6E980086
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 21:37:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-670f6ae9c7dso7547465a12.2
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 12:37:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776368265; cv=none;
 d=google.com; s=arc-20240605;
 b=iSw8z3t+b6cjNiA68WkkD4bp85fdCFn4lSDzrWFtPuy8xj12uDQiIN96jUCc9AM+IO
 YHF8//OD2sXjzI/NDsJB/7HuA3j2u6TSFnznnu3he9sCioAuz2YmNj2eJc4y6XiFuhvt
 Gq9rjX+76RGRl9EqGfMITh753UpxINFwoDs18UPimd8Di7MI4yR3sNPU4mMtxEzxYxuI
 zv0Jf3NFghqbdgftVP6ezjRSDbM3yzvVVhKA/lknUgd7sEKlEONqBVtBDY3QFp/DSkZv
 IEN+RHI7LvFkVTn/v+jXonScFJphnzNutM3/2xsRjeg59rnkYUYTAqAiGfnAUX/jk4c+
 VJMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=KCusjXqwxGaJR1kGOoKRMBiJATECyJfiqutZs8sN3Z8=;
 fh=C05J5MdtXRnaQ59kvJgyuZCfQ9EzdL8yDP3ZKWOYKQg=;
 b=e+7udBb1JnA4dAmEmt3hpJ78EK+4ZJ9q/bvVHjc+Ko2CQq2GiBPBmvnEfomSjtC9rv
 I8gKwvdhGUCmubPTsPVS5/uafYJE2SHU/6LEqEmwH/01LxtnD9Qo+C+z2/hy60ZQmhyx
 x9nG43JTgVW1oF/opWY+xhsjaJkYoDVcwQmF29V8K4VTqbNeRO5MdjH1uQsnHHP3Pg4T
 rJl/7Xsj5/klUqE66NkI6lvw12fG9Wg9iRmeoADz+Jo8YL3q0qjcIesuJJesocDayE6D
 pnyzxBb02xUazRF5q4J5+5rLOYMAHI18dh7gh491VPUyRbGobBKvpUQoaxJt2Py3NVJ8
 OykA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776368265; x=1776973065; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KCusjXqwxGaJR1kGOoKRMBiJATECyJfiqutZs8sN3Z8=;
 b=iq3UllmAPCFMy36CE4szckGk1ZoKpQaM4Mz/4SbdmelrmGMrci+/csNrAfPYHRMUum
 ZH8N2BteVOo0gMNQ4GiLJ3mbH+jwUQ7UmOw/7ecHPAgYPEfoQHizR/3ACOz22A3zrdMc
 yU//8Be1bL3HiH1AW+B685B9nSKsUQhBqiqa4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776368265; x=1776973065;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KCusjXqwxGaJR1kGOoKRMBiJATECyJfiqutZs8sN3Z8=;
 b=tSF8qqFmhIdfULBGK2mCFHz2KOuwXiaHJd3lxBA24qSg7EMVmpnOwCE8onU6LenKov
 lc4+kIro5A2niApmCxFQLxx1kRUzXChFIlnAvZJLDhut5CoU4akRE88b5yjNTJqgiOe4
 zoQ4CEdk8ErgeMiuit0dJvHa+af/i3ESGTfhPrQ/jYkWIrSxHXcMrwSHF3oNix1Ybfm1
 VQjxICetu8vZn+GeG1/8lSELUaO9q78Td3fKEqr5U7Td5YwQzdmm8D7s9yw0StTPpjDE
 fKy85K1Bpr4/6hCjEWeWVfHDpieTfLu8ZYvOdndpOciHAAjPmw4/r8owva38FRbpvocW
 acHQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8CdmG1rQUnqWJa4BuOdgHUYNZmFrZbs4UkDqEmx/5oJokEhBR2WNmJNBRIT5p+T9TfWPyRiEg=@lists.denx.de
X-Gm-Message-State: AOJu0YyXPVfJB7evnttWy2t3QhIEzAZfF+nYmn51VP5mbtG7oCX9fsoy
 cVsCYZFn0Y+miJ3jsXNReti0g85AAmNwuOpqv77K62oEpNmVF2tEEXNs4PC/OKotqBLDTRHsUb0
 KxM9rtqi0YvrpHMNmZ72RhdSHWl47G/jqGslfeVC8
X-Gm-Gg: AeBDievbva+KnZEXUCcJuw1VgVpabK3Bmpc0UnJVpd/SEsqGsS4+X0GV1GayNOqBFc3
 oBU8ZdnKXxrilODoPwpeygiXH5NsNDy6rlEWiEyqxqAGI364enQKTQPn0g+s+4eL8Q+/bxPZJfS
 DWD2W5YSp9ABcxywjhunVMGKTPC/zKX5jEvFwoaOA9pPZ2LRZVu8GPtygZRLS9pkkTbLf+3UPJT
 279Gx4eem0X9w7eRpdKmrLB7HlKJNFMWvmXEigQWKcYnoiDDaP/HJyTBAW0Rej5dlXeiZlZtFNo
 gmUGV5FQu/LjU7Zq9PGTPVvfT0P20S0=
X-Received: by 2002:a17:907:1c10:b0:b97:89b5:d7a0 with SMTP id
 a640c23a62f3a-ba3de3bb05dmr44276066b.48.1776368265364; Thu, 16 Apr 2026
 12:37:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1776302805.git.daniel@makrotopia.org>
 <8a5a44f1c0b0ede9e8a3f66e9cfad8807963e756.1776302806.git.daniel@makrotopia.org>
In-Reply-To: <8a5a44f1c0b0ede9e8a3f66e9cfad8807963e756.1776302806.git.daniel@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 17 Apr 2026 07:37:32 +1200
X-Gm-Features: AQROBzBUje01UWXCN094KNvIqI3X37m34bGz3JD5XXMmQ7hcZRmKDw_uUCW9UHU
Message-ID: <CAFLszTgi3pUX_mg724-kqC-7wR4MA2tHR9vatW9bOA5HqG6dEg@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] include: hexdump: make hex2bin() usable from host
 tools
To: daniel@makrotopia.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Kory Maincent <kory.maincent@bootlin.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Martin Schwan <m.schwan@phytec.de>,
 Anshul Dalal <anshuld@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Aristo Chen <jj251510319013@gmail.com>,
 Ludwig Nussel <ludwig.nussel@siemens.com>, 
 Benjamin ROBIN <dev@benjarobin.fr>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 James Hilliard <james.hilliard1@gmail.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 David Lechner <dlechner@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Shiji Yang <yangshiji66@outlook.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Francois Berder <fberder@outlook.fr>,
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

Hi Daniel,

On 2026-04-16T01:46:15, Daniel Golle <daniel@makrotopia.org> wrote:
> include: hexdump: make hex2bin() usable from host tools
>
> Make hexdump.h work in host-tool builds by using 'uint8_t' instead
> of 'u8', and including either user-space libc <ctype.h> for host-tools
> or <linux/ctype.h> when building U-Boot itself.
>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>
> include/hexdump.h | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

> diff --git a/include/hexdump.h b/include/hexdump.h
> @@ -7,7 +7,11 @@
> +#ifdef USE_HOSTCC
> +#include <ctype.h>
> +#else
>  #include <linux/ctype.h>
> +#endif

Reviewed-by: Simon Glass <sjg@chromium.org>
