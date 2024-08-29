Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F2B2C83F26
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 14:06:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3008788C60;
	Thu, 29 Aug 2024 16:05:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FiEoHa+L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14A5F88C4A; Thu, 29 Aug 2024 16:05:31 +0200 (CEST)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3B4088C30
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 16:05:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-70b2421471aso367970a12.0
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 07:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724940327; x=1725545127; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Fg2UNmcPmAr0ss5WNz9sHM/ynqi03dkGJurVXhJmtwM=;
 b=FiEoHa+L4IKeDC/+/w7Zg5XNGtV0xnmGy9tBTnLB37xD0KWNRlqsvZH7ST0u+tlWZc
 aChOTnVi983tkA7i0+M7sxTX2yqGgROINWU2wR1RAwy/e1+y0fyjXiBQNYoVzBEgFCNp
 u6eDzzsXZRpsOTegYPlDoiGI2ge2FD0EQ3aMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724940327; x=1725545127;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Fg2UNmcPmAr0ss5WNz9sHM/ynqi03dkGJurVXhJmtwM=;
 b=hH34PTWVQBNLZsnaP+ylc/CYGqp/9DCWSQw/DmaiK4K67RWAY777cOYny+AMRsrjWT
 vpCsFWyvfsnoB1YO+NYfF+dSh1kq9RkfKJvJS13qjrDQV2M0rS9LnLsOYiM3AEOeojwD
 itdhoE2qTqxutE1ly10wK2V0awBGTkF2SaAj9NHedYksmPlRfP7xDs+a/9c7ao1BIY2L
 hzSUemm8W25cEMnPnr+CM8hstqH90q91ckuGuUTD1lyHC0nt1anu5c4QFs09pwumhDBd
 k7NU9lp5JJiS/dfRbG+7YYRo/V5RCvd0uovavHDz1raeo2PzVbHSyS6oaT5oHVW0YWoV
 4+rA==
X-Gm-Message-State: AOJu0Yz+NvhBrTxqY/y66e0WMcSndd8WTJ7j8zU6oHBcarSIuG9/YjgQ
 mwGNSyx3HigqAqrpgHHdEJraoVDDW0Ow+MwdD3BCUHCEbxZFljmrYiMYQZ8WeuAXgHhZ+h8Xsu/
 10MeE4yORRjyr2aq4Hch//J1ELfz5whQzW0Px
X-Google-Smtp-Source: AGHT+IG4Bazyu+UegCCCOp+ZHIsayg9zqJs5wuRUnCsXgwuHtz/moTnqjR1QcdQoz00Xnn8AHAU93p4P2xO5fYL9btw=
X-Received: by 2002:a05:6a00:2d1f:b0:70a:f65e:b13d with SMTP id
 d2e1a72fcca58-715dfcc9264mr3466474b3a.27.1724940327282; Thu, 29 Aug 2024
 07:05:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240825122617.3708982-1-dario.binacchi@amarulasolutions.com>
 <20240825122617.3708982-2-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20240825122617.3708982-2-dario.binacchi@amarulasolutions.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 29 Aug 2024 08:05:00 -0600
Message-ID: <CAFLszTgN=GWbrJAmtBrb95i2ovAhfE1BPco5p3whnL-oCAhbKw@mail.gmail.com>
Subject: Re: [PATCH 2/2] cmd: booti: adjust the print format
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: u-boot@lists.denx.de, linux-amarula@amarulasolutions.com, 
 Eddie James <eajames@linux.ibm.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>
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

Hi Dario,

On Sun, 25 Aug 2024 at 06:26, Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:
>
> All three addresses printed are in hexadecimal format, but only the
> first two have the "0x" prefix. The patch aligns the format of the
> "end" address with the other two by adding the "0x" prefix.
>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
>
> ---
>
>  cmd/booti.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/cmd/booti.c b/cmd/booti.c
> index 62b19e834366..ea811244a0a9 100644
> --- a/cmd/booti.c
> +++ b/cmd/booti.c
> @@ -78,7 +78,7 @@ static int booti_start(struct bootm_info *bmi)
>
>         /* Handle BOOTM_STATE_LOADOS */
>         if (relocated_addr != ld) {
> -               printf("Moving Image from 0x%lx to 0x%lx, end=%lx\n", ld,
> +               printf("Moving Image from 0x%lx to 0x%lx, end=0x%lx\n", ld,
>                        relocated_addr, relocated_addr + image_size);
>                 memmove((void *)relocated_addr, (void *)ld, image_size);
>         }
> --
> 2.43.0
>

I really don't like this...numbers are hex in U-Boot and this just
adds confusion.

Regards,
Simon
