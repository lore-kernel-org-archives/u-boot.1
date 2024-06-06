Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CBEAC25B75
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 15:05:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C55C88473;
	Thu,  6 Jun 2024 17:04:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZEuc4Qn1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C819687F64; Thu,  6 Jun 2024 17:04:35 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6E55883AA
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 17:04:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6ae84d0cd2eso5678516d6.0
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 08:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1717686272; x=1718291072; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LBYASjzwGCv4VjKppMmdh6yqYLVNvjIL5gAaKSGjRTM=;
 b=ZEuc4Qn12tzIVzDt4lhqywcOr4cXTnDrCd7YPJ+41eY8sbItHtPov256qBZVjq2QnW
 NognN5li0/8xF842lKAQqr9x/hi1xA8KYxVGYE7h2Du/ukeaKvMsTEbzf0wqDQFqQdmg
 5GA+9YLgZj5fFXLrv4SQY9J7Xze7M/hi3DALw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717686272; x=1718291072;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LBYASjzwGCv4VjKppMmdh6yqYLVNvjIL5gAaKSGjRTM=;
 b=Xkp7ckAYA4a66nHnO+MgLbl509YI+dOi8TA3UlwOsnBMsdjIltAXjdsNsLnVLBo+1J
 tM2ewiNJ++oWed5YZQAlNJdVqHBftHgKb/avtSaOmBEaVSzV6ZKspZVsRKoSPNtkCoH3
 mqq5TKMWQ3IC1HwYxlzvQexuuffHm4k/WTiVOrhKcrjAIFYv72afZxuRd/oFsXkUYnYo
 6JmujN+Eis82rRrEBlTOiiEpWi1m9fDADDQIuSCy3deqHc7v8wzR4CRGnojLOtc/Eqrm
 SPuyv53POgp3QNCxqzTWNL5I3/zw79MH3TjtXkY0QqElc1OTmMofGzQ5MuMSQuVGZ9lQ
 0Pyg==
X-Gm-Message-State: AOJu0YyML9wO/4wY2T9OZliBG3yLDsgEvo5V+ZtTCFvkbVIKFHFlajF2
 Ql2v5AGdUs4lzrDfvSJ6FBXcg/e65sNASVgDtOKU2gJRn0WrNn9yBsP1tBBkl3y75Z9unvxr10F
 Cud77qoY8hLcbMmPd0uJaNiqu2zgUX/NtM9sO
X-Google-Smtp-Source: AGHT+IHsIofrUQhQS6goUnXdjEqfPMKgoolef+VxU7OTIwTM7+cHt3+vhfrJW5+1gBFTq9wpOAhXpHCL6ai1UGG71bs=
X-Received: by 2002:a05:6214:3b89:b0:6af:c46f:be69 with SMTP id
 6a1803df08f44-6b020321218mr66401956d6.5.1717686272486; Thu, 06 Jun 2024
 08:04:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240605032521.1142768-1-sjg@chromium.org>
 <20240605032521.1142768-4-sjg@chromium.org>
 <bfe289ff-eb98-477f-bda5-ab8559166ec3@cherry.de>
In-Reply-To: <bfe289ff-eb98-477f-bda5-ab8559166ec3@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Jun 2024 09:04:20 -0600
Message-ID: <CAFLszTi6xr7QeaUafMgJDSb6jg9ip3A9MLsEK8HOS=DMnhyxfQ@mail.gmail.com>
Subject: Re: [PATCH 3/9] rockchip: veyron: Add logging for power init
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>, huang lin <hl@rock-chips.com>
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

HI Quentin,

On Wed, 5 Jun 2024 at 02:36, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Simon,
>
> On 6/5/24 5:25 AM, Simon Glass wrote:
> > Add better logging for power init so that CONFIG_LOG_ERROR_RETURN can
> > be enabled.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >   board/google/veyron/veyron.c | 27 ++++++++++++---------------
> >   1 file changed, 12 insertions(+), 15 deletions(-)
> >
> > diff --git a/board/google/veyron/veyron.c b/board/google/veyron/veyron.c
> > index 32dbcdc4d10..23fe8bf088c 100644
> > --- a/board/google/veyron/veyron.c
> > +++ b/board/google/veyron/veyron.c
> > @@ -29,44 +29,41 @@ static int veyron_init(void)
> >       int ret;
> >
> >       ret = regulator_get_by_platname("vdd_arm", &dev);
> > -     if (ret) {
> > -             debug("Cannot set regulator name\n");
> > -             return ret;
> > -     }
> > +     if (ret)
> > +             return log_msg_ret("vdd", ret);
> >
>
> Those log messages aren't for code in SPL as far as I could tell, is
> there any reason to make them that small/cryptic?

Oh yes, it happens early in U-Boot proper before any messages which is
probably what confused me.

Re size, they just need to support searching the code base. Long
strings mean that many boards fail to boot / hit their limits when
CONFIG_LOG_ERROR_RETURN is enabled. So I try to keep them to 3
characters.

>
> >       /* Slowly raise to max CPU voltage to prevent overshoot */
> >       ret = regulator_set_value(dev, 1200000);
> >       if (ret)
> > -             return ret;
> > +             return log_msg_ret("s12", ret);
> >       udelay(175); /* Must wait for voltage to stabilize, 2mV/us */
> >       ret = regulator_set_value(dev, 1400000);
> >       if (ret)
> > -             return ret;
> > +             return log_msg_ret("s14", ret);
> >       udelay(100); /* Must wait for voltage to stabilize, 2mV/us */
> >
> >       ret = rockchip_get_clk(&clk.dev);
> >       if (ret)
> > -             return ret;
> > +             return log_msg_ret("clk", ret);
> >       clk.id = PLL_APLL;
> >       ret = clk_set_rate(&clk, 1800000000);
> >       if (IS_ERR_VALUE(ret))
> > -             return ret;
> > +             return log_msg_ret("s18", ret);
> >
> >       ret = regulator_get_by_platname("vcc33_sd", &dev);
> >       if (ret) {
> >               debug("Cannot get regulator name\n");
> > -             return ret;
> > +             if (ret)
> > +                     return log_msg_ret("vcc", ret);
>
> I think you can just merge the debug and log_msg_ret here?

They are actually different. The debug message is how I actually found
this problem.

>
> Otherwise looking good to me,
>
> Cheers,
> Quentin

Regards,
Simon
