Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E838D3C538
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:15:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 360AB89128;
	Fri, 18 Oct 2024 01:12:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jj1uzlCB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F343890F4; Fri, 18 Oct 2024 01:11:58 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E767789130
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:11:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6cbd57cc35bso21216806d6.1
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729206713; x=1729811513; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dK80skieZj5l6KzUVv+OmxHLAJvkB6aA+TyPhZRmjSU=;
 b=jj1uzlCBhmpH4xvrwFYiiwwvtotkvaxI42wfh9ImZtgvL6T2OX31oryI3kvbkZThuX
 8RBb5ORVNxei7PeQj+rfQHwxOhNTZkMFQBnlVjTGodJ6kF8iuK7XSKn2lovg50pBdWrd
 Jk6ySIDRdYvASQeWPF76sqJEoxwIsVPJtglDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729206713; x=1729811513;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dK80skieZj5l6KzUVv+OmxHLAJvkB6aA+TyPhZRmjSU=;
 b=NJxmBIrLcW7/PuqGDoPCZcrQFvc2Ucg8MM9FSzyof1U9vidpyFHRSDxeto96Tq2gWz
 rQ7Nu6+aADQtxh9ceSrH1SweLkuqYudqKl6OhKkqP01H3NW5UDpoKJATmYLSbVRXah5+
 I6ESR1qXLqhgvmZFRJC4CzgNjTOyNzuf1isyf03h7hhMPaRk0vTy2Q28t1W7PXv2PRPd
 vShVl7IT9+lFjA/oYoUVYcJmBYoKIz+d5aX5Ai5h5wu2I01zuxM7HZoRuND9hR2SjA8U
 Msdh9Dk1gVcqmXc4C2pLTRUVlUhG687kXwXokr+Am3RL82GON5kt7L9B6SCXH//S0lTU
 QjZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoC9gXbdhahE4sd2AQuFRv8HZbFL53IaaG2Tu5aYpkliDyu/Dz/g4bYXfvekRBjjOH6leU3ck=@lists.denx.de
X-Gm-Message-State: AOJu0Yz72AcKM7mYirQ65+F+Hi1ZvP156cFES2DG7RkBXpiU/WOROWus
 Whz5LjDWa4Yze19thZALT5jAGJVetEBZlXOP75G0xiKkxVKditRJe49XsJk97Blod41sq1gMR8G
 ez6ahpxucPm357aehzP8L6RLsesM6V41uYDo8
X-Google-Smtp-Source: AGHT+IEO1M9Jh42lIYhzmu5na8ZuAB6AYDEDr4U2MBlF00gg1RaCm7MKBUK3K9hD5YMx+iOhvpOrq/3SMftYAnJxfNA=
X-Received: by 2002:a05:6214:5781:b0:6cc:44b:105a with SMTP id
 6a1803df08f44-6cde1b5d08dmr6091036d6.20.1729206712798; Thu, 17 Oct 2024
 16:11:52 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Oct 2024 16:11:52 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <87frp6g2ks.fsf@baylibre.com>
References: <87frp6g2ks.fsf@baylibre.com>
 <20240930185139.2185983-1-sjg@chromium.org>
 <20240930185139.2185983-3-sjg@chromium.org>
Date: Thu, 17 Oct 2024 16:11:52 -0700
X-Google-Sender-Auth: XpXI7E1Li5mESkmdZARu2a-oS90
Message-ID: <CAFLszTg0PireMoyj71BVTGZeBdaqvisoY5oahmesaQY3YhdHBA@mail.gmail.com>
Subject: Re: [PATCH 3/3] binman: Add a tutorial on resolving test-coverage bugs
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, Brian Ruley <brian.ruley@gehealthcare.com>, 
 Marek Vasut <marex@denx.de>, Simon Glass <sjg@chromium.org>,
 Alexander Dahl <ada@thorsis.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Joao Marcos Costa <jmcosta944@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Peng Fan <peng.fan@nxp.com>, Philippe Reynes <philippe.reynes@softathome.com>, 
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Sumit Garg <sumit.garg@linaro.org>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Simon,

Thank you for the patch.

It's really great to have this documented.
I found a couple of small typos, hope that helps.

On lun., sept. 30, 2024 at 12:51, Simon Glass <sjg@chromium.org> wrote:

> Provide a short description of how tests work, why they are so critical
> and how to resolve gaps in Binman's test coverage.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>  MAINTAINERS                  |   1 +
>  doc/develop/binman_tests.rst | 734 +++++++++++++++++++++++++++++++++++
>  doc/develop/index.rst        |   1 +
>  tools/binman/binman.rst      |   5 +
>  4 files changed, 741 insertions(+)
>  create mode 100644 doc/develop/binman_tests.rst
>
Applied to u-boot-dm, thanks!
