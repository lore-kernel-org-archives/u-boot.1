Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 690C7C30658
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 15:51:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 821348871D;
	Tue,  2 Jul 2024 17:51:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PbDaemsS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65AE588748; Tue,  2 Jul 2024 17:51:47 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 534C887837
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 17:51:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6b598cd61ebso20868546d6.3
 for <u-boot@lists.denx.de>; Tue, 02 Jul 2024 08:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719935504; x=1720540304; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hVjXjgVH/swvRb6r1h7g8sX+3Yma8SysHRu/e+nNEm8=;
 b=PbDaemsSy5Cu+Um5zMJs+PLrfwE9Yj8DxiTv22Q+GgQBIPhEBZ4c3pdB1WZyiQWWeQ
 rVlIx54FhczfKPX1uzwJHQpmHGZ4X2grWcNpBrfq5EddSWkVmLq3XBpu5qibt0A4mBgU
 06/RiSjWfwjmQiJB8QVpeJ9B99/dWuoW9q25o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719935504; x=1720540304;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hVjXjgVH/swvRb6r1h7g8sX+3Yma8SysHRu/e+nNEm8=;
 b=JNtiIVTuwUUtuc8oHsIEM4SUf8CGKbD66jYu4xBl89zZ368cdgQP4/Tut1w/ua0BdY
 vULwgNvbSOqBxfOBMe9ra6PtSASIP8g+p5mS38+ETlNBIdX3WPjWha+RfsuPpU2Ug3BV
 CwtdoiGxwZ/dAjkBWZJ2u9OaExGrHDGm6oHyJpg9jJrjnGnGWEmVUKC2RRcGAmNgnWpi
 ghYEy+SE1w90hMx37UuC5tG3yILpYaSxH5zxsOrgTymlAr+9cgpq2nRJL8WFH5em7EJc
 aXVxzHe4swUN7ZydwWN9VjwjXo+RBHLRqo+EJij2y0SHWHv7j2AWLO1f/KRwi9ccCJTr
 U1Og==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiXzrIYPCLAgLrYM8dchl59nVMtgaTCDLAitEE7JOrd1oUQNMwEp6RLfzHaUcdESU3+kHPRfjzb1WX8DHPu6wR0aQi3Q==
X-Gm-Message-State: AOJu0Yy+bKmuzDXMib8pD8buwYtbMB/wN2vZtl60FKBRIywSoafwOQAb
 2kjXSGZuA18+r03Jan5sB50LMKVBxUAt7GRjhKveyQRKlaNUfobRzKORYMGjHahwi7cS3p/RhaL
 jcsPv3aWk9zJXpwW8bcJClaI5ZA7ihst+FB1Y
X-Google-Smtp-Source: AGHT+IGZ5HPOFazGcze77heILBahQGzfbDHW9GSM9Ghz/yz1Ah/5STcwDG7QsCtnoz4wJFgnUE5Mgli+rlXSLXl9Aj4=
X-Received: by 2002:a05:6214:cc3:b0:6b0:71c8:6baf with SMTP id
 6a1803df08f44-6b5b7084058mr103323826d6.12.1719935504285; Tue, 02 Jul 2024
 08:51:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240627113114.100083-1-mikhail.kshevetskiy@iopsys.eu>
 <CAFLszTiQubBhXf5585htt9tJUNDxkJKmM3r3Kg8r1Zmrk8Rf0A@mail.gmail.com>
 <fa0503e7-4f4e-457e-989b-c8c6115853dd@genexis.eu>
In-Reply-To: <fa0503e7-4f4e-457e-989b-c8c6115853dd@genexis.eu>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 2 Jul 2024 16:51:32 +0100
Message-ID: <CAFLszTihEQVMW==2V2Vq9GY_JffKWFgmarshmXSJFkCFyg4pXg@mail.gmail.com>
Subject: Re: [PATCH 1/2] led: Implement software led blinking
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Doug Zobel <douglas.zobel@climate.com>, 
 Marek Vasut <marex@denx.de>, Christian Gmeiner <christian.gmeiner@gmail.com>,
 u-boot@lists.denx.de, Michael Polyntsov <michael.polyntsov@iopsys.eu>
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

Hi Mikhail,

On Tue, 2 Jul 2024 at 12:54, Mikhail Kshevetskiy
<mikhail.kshevetskiy@genexis.eu> wrote:
>
>
> On 27.06.2024 22:05, Simon Glass wrote:
> > Hi Mikhail,
> >
> > On Thu, 27 Jun 2024 at 12:31, Mikhail Kshevetskiy
> > <mikhail.kshevetskiy@iopsys.eu> wrote:
> >> From: Michael Polyntsov <michael.polyntsov@iopsys.eu>
> >>
> >> If hardware (or driver) doesn't support leds blinking, it's
> >> now possible to use software implementation of blinking instead.
> >> This relies on cyclic functions.
> >>
> >> Signed-off-by: Michael Polyntsov <michael.polyntsov@iopsys.eu>
> >> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> >> ---
> >>  drivers/led/Kconfig      |   9 ++
> >>  drivers/led/led-uclass.c | 190 ++++++++++++++++++++++++++++++++++++++-
> >>  2 files changed, 195 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/led/Kconfig b/drivers/led/Kconfig
> >> index 9837960198d..4330f014239 100644
> >> --- a/drivers/led/Kconfig
> >> +++ b/drivers/led/Kconfig
> >> @@ -73,6 +73,15 @@ config LED_BLINK
> >>           This option enables support for this which adds slightly to the
> >>           code size.
> >>
> >> +config LED_SW_BLINK
> >> +       bool "Support software LED blinking"
> >> +       depends on LED_BLINK
> >> +       select CYCLIC
> >> +       help
> >> +         Turns on led blinking implemented in the software, useful when
> >> +         the hardware doesn't support led blinking. Does nothing if
> >> +         driver supports blinking.
> > Can you talk about the blinking p[eriod / API?
>
> Could you clarify what do you mean?

I mean can you explain in this help

[..]

Regards,
Simon
