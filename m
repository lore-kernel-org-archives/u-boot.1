Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C558AF8D762
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 18:35:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 036508420C;
	Thu, 16 Apr 2026 20:35:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="L1cHVdkM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB64B841C8; Thu, 16 Apr 2026 20:35:24 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 207468420C
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 20:35:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b9910707d82so1070762566b.1
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 11:35:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776364521; cv=none;
 d=google.com; s=arc-20240605;
 b=cljFuQ1FyZ/ispn282HyVdkc/kdKFMPmY6ymW1DGKvIS7ADGi6eZ/44o7CcgpaSUMQ
 RxxInW76GGgIoHsOBbzSV+F0isJws6g1krg+6RCFHdAtm2qqEJuLiMuwzSlwAnaI+CUa
 iRwIao9iB7oZpISr6iUWMyB6idDE8nxgex9AyWd1rnmgsGFmEjVm2s5DvoIK6CTXn3vC
 cIGKzwKlaSYKtFj6vwR6Q7vjQMK0j3noA3FQCcJPWOcVGqf76kPD2xOjLSFmTcUMWkYG
 bMfG3wjUH15mQWfAMMZevEYs3fJARIi1JVr7ZkmDI848Jnti8RJB9K4c7+pxCDSl0noi
 uD2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=BLs/3t//s/o1QvegT3iOI2cmtflUDw2FYx16xTWqb0U=;
 fh=1L6vZ7sPlbPu6y+g3mNCPeF2C6+dBJkeSiSHnCxwzC0=;
 b=NwNHwo4VoUbb7opyNIh20xA1tljuSNv8nxIzGNnMZ2d1q3H7c4jXJ19hLz7sA7DmR7
 HnIbdpsRaBRaw7mBet3BYmCNI5nPeMayH3znJBQ/QVMiXTOyCA1lpkV8qNa6rbpTHu+V
 vxBBNaMSewUrQ2U1VDRBWnAJqFiAWs3M5FB45IUoHUZ6y8V9a7LmJWl82kvrN12Xk50e
 hyfLHl2Tw/5UY7Oc7juuIpHk+r/3QnswwO1BlT/IMCLx4qnweeTAWdmVkvS0FJZhQFb/
 gzZIjOzs2AAaX1mQyH2rgyCJ1h3MTeefgPOrXFRAC9pmzf8xwAOpK3XeTJv2NedBHbP2
 iM9Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776364521; x=1776969321; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BLs/3t//s/o1QvegT3iOI2cmtflUDw2FYx16xTWqb0U=;
 b=L1cHVdkMslL50i3AKj480kurT3xoLRiTQoPsiy7/9LAu6t7rqtynbMqmCY7ZPG3gk5
 +RuxtzkcaO+l4uFNyE1NekoXPh1dlbKI+94Z7EVyFWhHr+n0ggIb1PoauCARczTLKt99
 gfu3T3LIGeJ4FG1iJmPwU+LIseCcVr8ExaALE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776364521; x=1776969321;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BLs/3t//s/o1QvegT3iOI2cmtflUDw2FYx16xTWqb0U=;
 b=Vv6fxf0zj4+dPatnP1aOFkQTgdRh7L5y4MlebK2LZvLYKiUKsCffA4wJqZ71d5EiI+
 q95wsuXlriHEg7YdzuBsXKp7WTE2Ybv54SkX3oHs7fC/gFYcysBHhrrFbCnhl/Caoh6l
 4sz8Pz7x4wmkvKN502S27IhLVVKEe9873jbfnToaVdcymHMUaOy0XMl2AlBztlMmD5F2
 KaqNh+alvpI+Ze0bEcm7GkYIKUVp9uYwl+q/6YjAVtxl+sz8KTq1gOYwfAOe7Y2a+lYv
 8kAEmNLy49OTRZPIF7MYwLIKMUWHl5RBhKAMr1k/GQqynllN3+aUYCNj/yfhoZUIcSaQ
 zcCQ==
X-Gm-Message-State: AOJu0YzyKLe9Fcya/2KYZ75QN09sNSISyEWDnVCTcJWyn4Ib8T7cR98s
 ONfbcOgaCpdEAriKhuBn5j6KkLoK1Ci9/lzvBxeM179OUtkoMOeDDFk1+1tBqO2RiwnsUHziZao
 q9pmWnpXUFwgIMRJuNjB4Vi06IXe110whnrcdIFiJ
X-Gm-Gg: AeBDievxZAP3U1RvvVsSl+wSrhcnVqzOZQVkSKi3nf/ydp+Hp42JEXO+EQHBNm3HPti
 73GgeVtfiTDAVwYrzopyS7/ESc2in7Lk8uXb9Xpw/RajA8NNEKSOdNJLJkmmsYXGwnHRFDrMnvG
 Ke2hb+E+Y5zxMeUJ+ZnkNpn5/ak3OQWZulmXjTU1UMlMv7JfUfu8XP2XqJPo6RQ8FnVAgfnrIJ9
 qCmtkGn5piRYw5jcKeF0svgNY6Mmbg+zE58aZfCaEUEL/sF/lQBnV3pUlCKEBGknwSXYlyVV8RH
 poYRPyCqeK/4Zdm8VW27
X-Received: by 2002:a17:906:5191:10b0:b9d:ffb1:17aa with SMTP id
 a640c23a62f3a-ba3dbbb5f29mr26043066b.24.1776364521477; Thu, 16 Apr 2026
 11:35:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260416-ui-cosmetics-v4-0-b843ba661b3f@postmarketos.org>
 <20260416-ui-cosmetics-v4-4-b843ba661b3f@postmarketos.org>
In-Reply-To: <20260416-ui-cosmetics-v4-4-b843ba661b3f@postmarketos.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 17 Apr 2026 06:35:08 +1200
X-Gm-Features: AQROBzBBi1jU3dHzVeCF9LkbcwmDlC6guU9CJb53Tl8tbT3aFs_R9Hrfo-hZyeo
Message-ID: <CAFLszTjbt1Nb5b30B3_8cH2ce_G4Q-4F3Omd9Z7xPJDJg634tA@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] doc: usage: autoboot: update content
To: funderscore@postmarketos.org
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Anshul Dalal <anshuld@ti.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Martin Schwan <m.schwan@phytec.de>, 
 David Zang <davidzangcs@gmail.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>
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

Hi Ferass,

On 2026-04-16T14:57:40, Ferass El Hafidi <funderscore@postmarketos.org> wrote:
> doc: usage: autoboot: update content
>
> The autoboot documentation is quite outdated. While converting to rST
> for being publicly accessible in the docs website, document all basic
> autoboot options in there instead of referring to the README (which
> no longer mentions any autoboot configuration option), and don't instruct
> defining CONFIG_AUTOBOOT_PROMPT with a C #define (as CONFIG_ options may
> only be defined in Kconfig).
>
> Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
>
> doc/usage/autoboot.rst | 31 ++++++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 11 deletions(-)

> diff --git a/doc/usage/autoboot.rst b/doc/usage/autoboot.rst
> @@ -84,8 +94,7 @@ CONFIG_AUTOBOOT_PROMPT
>      also includes, sepearated by commas exactly like in a printf

The typo sepearated is still here - please can you fix it in this
patch or patch 3.

Regards,
Simon
