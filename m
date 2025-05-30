Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88581C5AD49
	for <u-boot@archiver.kernel.org>; Fri, 30 May 2025 18:21:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10B6A833FC;
	Fri, 30 May 2025 20:20:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Pq+i7lB4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD0D4833FC; Fri, 30 May 2025 20:20:57 +0200 (CEST)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16696833AD
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 20:20:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-3114560d74aso2363072a91.0
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 11:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1748629253; x=1749234053;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gY3r3epKUNXxb7Uvo4LTPvuRCkz5+CIWSIntgAm9GBM=;
 b=Pq+i7lB4h/0ATpOxet5k1nOr4Fv+58o9kwWA5fxow8Vln70A2yv00Tno195TgiQMrt
 WYY5BJZXPi5bJ/VjjP8snGBkiVnmIMkHW+m7KRYL3M8ISzbqdasLbcPNU/yg7MlObMnY
 t5koim+flJm/K+jQCVfjtfBVDWqwwWq1Prc80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748629253; x=1749234053;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gY3r3epKUNXxb7Uvo4LTPvuRCkz5+CIWSIntgAm9GBM=;
 b=jcI3HoWACqIbZ1IySBpiJ33BE0Q2Yijqh0RphrXzE8mZrfKpBsE6xLICZBP0ciRy26
 Q+UVttq4zqFuIstYfbr+IFCZ27wovhLafmlX5HsZYAPwI85IsLe4lAI/roeYTqdAtS14
 hK13lH8KoloLlz3YYAxqU9gd7MvWf78tczL+OAMYN7Mn8ih0PLLkiejglMGK7UsBB00m
 fupxUILKX554/ulUWgZvThRulz1bX06986NPJsvAJXQ2znG+Gkuhkoie2MSAKA0BnbWH
 qvm8xH7HbX4txbEMhVh0jbLet5I7Cgoylbs1TWqlJeEWO3DPtCeFwPU34n5vq3PfK4J+
 kQKw==
X-Gm-Message-State: AOJu0YxNetPRlg5GRxIaY9H1YlY4W4GgpI6ikEHJIhqZP1VPkzZ6PqEk
 LpT0TXCG4DQ78yJLbFsiEPEPzn22gDqVLbqg7fOfflUREd0KrsC+X+Ota7+wyRL5k0PzjGXXqhU
 eYkKuZ75iR1JURUoYsxWOumf2Xafe6Y7FL2G9j9KuKA==
X-Gm-Gg: ASbGncsuk0xsxdfTuOPhP5S2FHQ53RPWEahZirDN/AIcd0dT8jbXZee+FKqkddxT9Ku
 xl5+5EK9UnnngDgX0xurjjqfMKCHLQSrAs/J6fjb5htZetEe7VKJEsWCf7qxT7ta2tYJA+LTEye
 TBbe9h9F1xGsj3I7mYuJgNtxQrfJ8tRTwQnP1t+K61gw==
X-Google-Smtp-Source: AGHT+IEjD5HHepJmhhbTXJlyEzOhU4pU3vs+nMgF7AaMT06KcxQVrnMqfJV6w8f+cv9/tVYnCOrLTcv8No+2wf0GMqk=
X-Received: by 2002:a17:90b:4c49:b0:312:1ae9:152b with SMTP id
 98e67ed59e1d1-3124186622fmr5455486a91.23.1748629252960; Fri, 30 May 2025
 11:20:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250529051024.42340-1-michael@amarulasolutions.com>
 <96e475655f574beea41b4f46353deffd@dh-electronics.com>
 <CAOf5uwk6-rRimCUC+xBYqi3Tr1vo0_4viw5vPUg-FAgq34MzUw@mail.gmail.com>
 <06019262ef084bdf8471f18b08b78240@dh-electronics.com>
In-Reply-To: <06019262ef084bdf8471f18b08b78240@dh-electronics.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Fri, 30 May 2025 20:20:39 +0200
X-Gm-Features: AX0GCFsnaqfF_pu8dFwS29EOs1jb9Ljg3_RxDm_QMP_IWUokKYLo-UcWkNaYIRo
Message-ID: <CAOf5uwmpau9YUQevx0+gKyLn4_Q0GhaWpXqBzBZ-eDm8zjweBw@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] clk: imx: add i.MX6UL clk driver
To: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: U-Boot-Denx <u-boot@lists.denx.de>, 
 linux-amarula <linux-amarula@amarulasolutions.com>, Peng Fan <peng.fan@nxp.com>,
 Adam Ford <aford173@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@nabladev.com>,
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi

Il ven 30 mag 2025, 20:14 Christoph Niedermaier <
cniedermaier@dh-electronics.com> ha scritto:

> Hello,
>
> From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
> Sent: Friday, May 30, 2025 5:12 PM
> Subject: Re: [PATCH v3 1/4] clk: imx: add i.MX6UL clk driver
>
> [...]
>
> >> I have only an imx6ull for testing. At the moment it looks good,
> although
> >> the Ethernet on my device is not yet working with this clock driver. I
> need
> >> to find out why it's not working and will probably do a follow up patch.
> >>
> >> With that changes above
> >> Reviewed-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> >>
> >
> > I will add you review and tested-by: during respin. For the ethernet I
> > can take a look
> > but I have not in my module
>
> Not necessary, with the imx6ulz this makes no sense. I'll have a look
> at it. I will use your patch v4 as the base for my adjustments.
>

I have another upstream on going so I should able to test. Anyway I hope
that this is the last respin.

Do you test the nand?

Michael

>
> Regards
> Christoph
>
