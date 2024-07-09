Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3194FC2BD09
	for <u-boot@archiver.kernel.org>; Tue,  9 Jul 2024 05:28:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D84688403;
	Tue,  9 Jul 2024 07:28:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZuqvQo0U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF20588405; Tue,  9 Jul 2024 07:28:23 +0200 (CEST)
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com
 [IPv6:2607:f8b0:4864:20::92d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5E3D87B84
 for <u-boot@lists.denx.de>; Tue,  9 Jul 2024 07:28:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-81015861ca6so1153523241.1
 for <u-boot@lists.denx.de>; Mon, 08 Jul 2024 22:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720502900; x=1721107700; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=94WmoPm2BLA3ahNE0dmTB2N1RTTt/AU7g0VfG7OjEZ0=;
 b=ZuqvQo0Ut2v9SRgnlVjaxH+BPkyQ9bDSZKulpN05sNgFQ/X3ndWWsjn41XNprKfOj4
 C1LQGxBFQ9MgwCx8QqF6gTLarySBw1jZ4p6YuU4e7Syvz8o80omONukbxBx8Nhlm7LfM
 qQTsa2qyJGqlcXwIyvBRNsog+8ISApE/g0GdozF4THlURvSdJVBzzB7vTJTqEKuJOwC3
 zuuKZNZXOqsBTU3kUwREaCBz6EgCfk+wX7yoPDGPWQAF0OXtV9Jau9VA9K4e26r5D6+2
 Fd7c/HBOEfJKXgo573jyTZMTg6sj+nkjyk5UXzRolCb4yxPNVGqN3L8FVrMAkWOZLd4/
 Trkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720502900; x=1721107700;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=94WmoPm2BLA3ahNE0dmTB2N1RTTt/AU7g0VfG7OjEZ0=;
 b=IBRD0DWDdyJc2Ibhr+tW2/xwQrreNndRqeQv3sMmYG3v8ahGN97SpbcGNl3ZesTCpQ
 bB7dn6TJJurrkl3y8SPp78Fda80crlqep02FO3lMxBvaHskE1l2X9VgnaQXiFBJBkjpW
 5yOPyzkN6wELNr11yskiYNxAcLlvnbC58lMNdNqfUb7KCr51PKUuri87uvqKVw9ofu4u
 IMTrEMSwW4oLOuAqUjJuD6urkZdLbXvJOE/bdDVE+a3eqG8eLWT5RjceZ6sjibdk59eW
 3qVW5Yq2niAxrOCoiIEcdS1qHS+FnHHMq+5AJU1YucscLAQ8xhr1qKlw8s4h9yUNvgp8
 41jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHUYc/CPMfe4aTwEj5GYJOEoG8QlbXAoaj7EwH8G62+1/Ni4HxilO1BDQAJpp4B/kZJSaMVi/5X5gepJO+UioYnFisjQ==
X-Gm-Message-State: AOJu0Yz6wwZlbb41MAr5+ORA/dETfTj16IfeDeIssfAFap8ywXaZn5jP
 b+SMdewxv+/iBMr3Al9HPIY45P3fQMk2ZiMAK9EfMknsGZ46AFtvrOAmqE2yydL+xTvWXmp/M8J
 ngmxQQu/FJcEZxqkQF41kSKtL2BlSlxlPF8SGwQ==
X-Google-Smtp-Source: AGHT+IEayM0qWnI+46qlpI3E4el7gsxf2xzjcyvyHkP40IA1u+ltRWOGkFLZhV6HZLJCTsf0dWfrISb6mFfSrbCv0Ec=
X-Received: by 2002:a05:6102:1624:b0:48f:eb5f:84d8 with SMTP id
 ada2fe7eead31-4903220af5fmr1714007137.27.1720502900487; Mon, 08 Jul 2024
 22:28:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240617-b4-qcom-rpmh-v1-0-bd2336923e0a@linaro.org>
 <20240617-b4-qcom-rpmh-v1-2-bd2336923e0a@linaro.org>
 <CAFA6WYM9hPFpb9F=nYSe-UkFbGMuUuJBiBfMiUzrSowSxvOUNQ@mail.gmail.com>
 <b18f0af5-c066-467f-81f6-11ce8a181ae3@linaro.org>
In-Reply-To: <b18f0af5-c066-467f-81f6-11ce8a181ae3@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 9 Jul 2024 10:58:09 +0530
Message-ID: <CAFA6WYP0ZWLpnT9__HCOi6NsED5M2Z4Z=Ffy_Oj=P=JXi5wYTw@mail.gmail.com>
Subject: Re: [PATCH 2/3] soc: qcom: rpmh and cmd-db drivers
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
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

Hi Caleb,

On Mon, 8 Jul 2024 at 16:13, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Hi Sumit,
>
> Sorry for the late response.
>
> In general, I'd rather keep this port closer to the Linux original, so
> that future cherry-picking of new features and fixes is easier. This is
> quite standard practice in U-Boot (and why the compatibility macro's are
> included in the first place).
>
> Otherwise, we end up with our own quite different implementation, with
> the higher maintenance burden that comes with it.
>
> This port doesn't do a perfect job at keeping close to upstream, but
> still I don't think we should stray further without a good justification.
>

As per your cover letter:

Quote:
   "These drivers were originally taken from Linux, however they have been
    heavily modified and simplified for U-Boot. Since the original Linux
    drivers contained heavy optimisations related to multithreading and
    asynchronous probing, as well as support for idle and suspend states
    which we don't need to deal with here."

This made me think the driver is nowhere close to Linux driver
functionality wise. Also, the commit message doesn't say which Linux
commit this driver is influenced from. I am not really sure if
cherry-picking will be straight forward. IMHO, if we are heavily
modifying a driver port for U-Boot then it should be done properly as
per U-Boot needs. A middle ground approach which you have taken is
only going to lead to confusion and rather negatively impact
maintenance.

-Sumit

> Kind regards,
>
> >> +EXPORT_SYMBOL(cmd_db_read_addr);
> >
> > Export symbols aren't required in U-Boot here and other instances in this patch.
>
> ...
>
> >> +       /*
> >> +        * Wait until we read back the same value.  Use a counter rather than
> >> +        * ktime for timeout since this may be called after timekeeping stops.
> >> +        */
> >> +       for (i = 0; i < USEC_PER_SEC; i++) {
> >> +               if (readl(addr) == data)
> >> +                       return;
> >> +               udelay(1);
> >> +       }
> >
> > Can we rather use readx_poll_sleep_timeout() here instead?
>
> ...
> >> +       for (i = 0; i < 5 * USEC_PER_SEC; i++) {
> >> +               if (readl(tcs_reg_addr(drv, reg, tcs_id)) & BIT(tcs_id))
> >> +                       break;
> >> +               udelay(1);
> >> +       }
> >
> > Can we rather use readx_poll_sleep_timeout() here instead?
>
> ...
>
> >> +
> >> +       spin_lock_irqsave(&drv->lock, flags);
> >
> > Locks aren't needed in U-Boot, can be dropped here and other places.
> >
>
> ...
>
> >> +
> >> +       spin_lock_init(&drv->lock);
> >> +       init_waitqueue_head(&drv->tcs_wait);
> >
> > Similarly waitqueue should be dropped too.
> >
> > -Sumit
>
> --
> // Caleb (they/them)
