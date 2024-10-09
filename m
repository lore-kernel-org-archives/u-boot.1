Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A328CF042E
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 01:57:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8461890F8;
	Wed,  9 Oct 2024 03:56:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SBos96qH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7171C890FC; Wed,  9 Oct 2024 03:56:05 +0200 (CEST)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5408389101
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 03:56:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-71e10ae746aso1332724b3a.2
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 18:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728438962; x=1729043762; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SQRyaewDvKu7u8D+b7PVQNv5F9xaGa88bQ8Xdqbik7U=;
 b=SBos96qHpOr+Qx50UGk63qV+rK7UUhxq/lyqzVNtLgXj0vAZfpDCPpPiO0iip8O1AL
 Cx7bY8hA3iKG4X77tvN7DNWwBQU3fjOrOK80OwzE795Pm3Zp7DqksSWdaUEKvpYOR8JZ
 1FgUkZDsi6h0Dqb+v3QmE0y76nzustJBwZkRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728438962; x=1729043762;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SQRyaewDvKu7u8D+b7PVQNv5F9xaGa88bQ8Xdqbik7U=;
 b=JMYC246NS0j8dAx3ON+Fm0+AfGCwebXpSHXNSn0X//nQr6tms35nFJK4QQPOl6Ms7A
 RXgeWsZQjIoP8J7vnEiK4nyqUIuzBU1I7IfC2CtfLU+jOB2H8pfVw4Vm8x4q8UOOLckd
 t1XPMYilE6cN9fPeBfOo3Po4V/GWS4sTCFfkXr+Q55shxT6Pz384jW8k+jTAvPV3JPIR
 Yh2vraA1b2w6rA1rfeAPkpljOJq56QnGtX5WdSHOV1YEh8oywuIh7C4VBrBUE7yL7SiP
 Uke8LQNQN5uFKqBdnGHjcuK7JKbWpbKfpUXR1iZOLbbQOzIyf5ZBCEGnyVbj1EYjUeQr
 mAvQ==
X-Gm-Message-State: AOJu0YycZ/TAhxE3TLAyHSUdvC+UAzDyGXTWEVFmt2RDWU/pZYo6lBMl
 JRrUBMRjyIeRgcuOJyyNr/leU3HBgmoBW30ZhAmJdoJ+Rs/I02LtOvfhNv1nbpIW552uJWZ8+AV
 w0o9Bu3vDlJA79Fzh8lXA+8CIBV9sCKGaCeDD
X-Google-Smtp-Source: AGHT+IHX72sf36/nXFJJwKdmGf4XsBOhXGKkOB4UCzvxg7VIBuUauOy/Q5x18AIT5FdnvZ9r6OMKiZAYvLQLk+qt9F8=
X-Received: by 2002:a05:6a00:3392:b0:71e:1498:9ed8 with SMTP id
 d2e1a72fcca58-71e1db74dc6mr1375432b3a.7.1728438961796; Tue, 08 Oct 2024
 18:56:01 -0700 (PDT)
MIME-Version: 1.0
References: <20241003212802.3810-1-ravi@prevas.dk>
 <20241003212802.3810-11-ravi@prevas.dk>
In-Reply-To: <20241003212802.3810-11-ravi@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 8 Oct 2024 19:55:32 -0600
Message-ID: <CAFLszTjP0ZE=vwW0PadkX4UGWgVi-doTNdDDNgJvN9A3eVUpCQ@mail.gmail.com>
Subject: Re: [PATCH 10/13] i2c: rzg2l: include u-boot/schedule.h
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>
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

On Thu, 3 Oct 2024 at 15:29, Rasmus Villemoes <ravi@prevas.dk> wrote:
>
> This TU currently relies on getting a declaration of schedule()
> through some nested include. Include the proper header directly.
>
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
> ---
>  drivers/i2c/rz_riic.c | 1 +
>  1 file changed, 1 insertion(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

> diff --git a/drivers/i2c/rz_riic.c b/drivers/i2c/rz_riic.c
> index 5f3f8d1b24b..f292c824362 100644
> --- a/drivers/i2c/rz_riic.c
> +++ b/drivers/i2c/rz_riic.c
> @@ -14,6 +14,7 @@
>  #include <linux/bitops.h>
>  #include <linux/delay.h>
>  #include <reset.h>
> +#include <u-boot/schedule.h>
>  #include <wait_bit.h>

dodgy header-order here, although it predates this patch.




>
>  #define RIIC_ICCR1     0x00
> --
> 2.46.2
>
