Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20895C282C6
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 18:17:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A07A680AE1;
	Fri, 28 Feb 2025 19:17:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="feuiEzuu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6A58810EB; Fri, 28 Feb 2025 19:17:25 +0100 (CET)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 907D1809A5
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 19:17:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e60aef2711fso1092887276.2
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 10:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740766642; x=1741371442; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3TSolBgOv6rqxmRhJEUTMtf1K9uFuFoST9JX3IT3lUE=;
 b=feuiEzuuN2p7hgeVOzL4aSCulzDTCtw7INLiGh0FbwSKdGlPrLJ+3nnz1qNKgl3doa
 wTZy759NYFBjqCqI59uNIHjK3vvtYqS+k/Nek3M+ADqYhu72OfEGH2aZcWfBBIGbbgic
 17a+t3BQFvTy/ofPP+JLPU25iddFbA+wkCT46WEAkYHxzROQbEqq3JeY8XJBRnVYjU3n
 v6ut7rvYh/60tB8TpImMps2MmCI2/0LfVmwCm/Wy8+Cxw30kqna+TdjebZ/Gb+fcVat4
 rKuicYFZ2bv0pvjplWI8PbRRnMH/b2C4+YR4/1khfbSG0ARgM0hFzU4roo4VIn8KSEAv
 yfew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740766642; x=1741371442;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3TSolBgOv6rqxmRhJEUTMtf1K9uFuFoST9JX3IT3lUE=;
 b=P+KVq4EBQPXwoBCzDz5pJ2owX6/NgksZOlAMopbI19bPaiUicSsAwJS14jxEDYsmXb
 QLnoi8g6XDfzeeYuT537wCsRvlMAsn/ALirRjeFauNHJedHLEWEqb02Ddb6GO5SnGJNR
 R6rqh/g3l4xSxso4lyUy+pOZNw2z/F1iqK5XiRuYsxbFFiqCqJ6ZUsRZ2vi+W0c3Qi6V
 j8v30sSTw4m5mGFBpgYq/EktASwihQ5zTd2nHGW8+HAIQfueSqfrqe4KOxgyloIXu4ZF
 RvSwfyGh24v7cCE0pKMDjrYppk22SFbtU+G7jSusw4iTlLj34BrulhfQUcaCj1kfAZx1
 aNiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7r7kVo6rxp5ocTLNu+WogaOF1UJcWuKX8WX7nGOckIY69DeC3BUD96H0/PTogK7AxtFom6ns=@lists.denx.de
X-Gm-Message-State: AOJu0Yz7PusBdUZoxBw5eyyqU/XIcw2L9pa14fnSihMYTyvSGgLSyC+a
 kKKj6zFMg9NjP4jMkHqojA2j60rTwU6aYIP6rAs6hABJGNTfddARVTNRI2aJjVArkAH2DA/Kmuj
 uN53vaT+Mz2wKP9vJZMRfQVbc4HP9XyHJVQyW5Q==
X-Gm-Gg: ASbGncvUQHVQWvElGRYYjS4ZTYXqn5WXiKzrdnU6iXXa9l1+ifVoq7a+sLfqWWb5P8T
 2Jcy5oKKSW/QIK7sebyp3WeO7NuA2APfYXQJQsu7PkcUQKYGu4/34/BzPNme7Ovds57uk4e82VW
 GYFlZFTg==
X-Google-Smtp-Source: AGHT+IFDZ64p1MU2yufA4DGwr665IjurXDnl8xWo1NJb7fuzeLIUFdSEPK3nafqFpsxixUB3joyQmpYvhB4m6E6HSjg=
X-Received: by 2002:a05:6902:e03:b0:e5a:e8e8:b1b6 with SMTP id
 3f1490d57ef6-e60b2e8ecc9mr4687303276.8.1740766642403; Fri, 28 Feb 2025
 10:17:22 -0800 (PST)
MIME-Version: 1.0
References: <cover.1740499185.git.jerome.forissier@linaro.org>
 <f9568a6c5140b99cbd5b48de21f4d5b12a76d92e.1740499185.git.jerome.forissier@linaro.org>
 <CAC_iWjLtTzCAqR_aq6Q1kBEn=E3oQoCDuvxWAnfrT6R=KCgSeQ@mail.gmail.com>
 <Z8HFRuCH8TQWC7Pw@pie>
In-Reply-To: <Z8HFRuCH8TQWC7Pw@pie>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 28 Feb 2025 20:16:45 +0200
X-Gm-Features: AQ5f1Jpay02SUhFNYCWdevWKMt3_p12_Ouy_U3yGGRSYw3rdSKeyxSn3uQH8kLA
Message-ID: <CAC_iWjLiKdyKyOBsKC-wXKp1tBxR4-nqrWseLARvcrN9PF4QOg@mail.gmail.com>
Subject: Re: [PATCH v2 08/14] lib: time: hook uthread_schedule() into udelay()
To: Yao Zi <ziyao@disroot.org>
Cc: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
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

Hi Yao

On Fri, 28 Feb 2025 at 16:16, Yao Zi <ziyao@disroot.org> wrote:
>
> On Fri, Feb 28, 2025 at 03:38:22PM +0200, Ilias Apalodimas wrote:
> > Hi Jerome,
> >
> > On Tue, 25 Feb 2025 at 18:35, Jerome Forissier
> > <jerome.forissier@linaro.org> wrote:
> > >
> > > Introduce a uthread scheduling loop into udelay() when CONFIG_UTHREAD
> > > is enabled. This means that any uthread calling into udelay() may yield
> > > to uthread and be scheduled again later.
> > >
> > > While not strictly necessary since uthread_schedule() is already called
> > > by schedule(),
> > > tests show that it is desirable to call it in a tight
> > > loop instead of calling __usleep(). It gives more opportunities for
> > > other threads to make progress and results in better performances.
> >
> > Some examples of timing gains would be nice.
> >
> > >
> > > Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> > > ---
> > >  lib/time.c | 10 +++++++++-
> > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/lib/time.c b/lib/time.c
> > > index d88edafb196..d1a1a66f301 100644
> > > --- a/lib/time.c
> > > +++ b/lib/time.c
> > > @@ -17,6 +17,7 @@
> > >  #include <asm/global_data.h>
> > >  #include <asm/io.h>
> > >  #include <linux/delay.h>
> > > +#include <uthread.h>
> > >
> > >  #ifndef CFG_WD_PERIOD
> > >  # define CFG_WD_PERIOD (10 * 1000 * 1000)      /* 10 seconds default */
> > > @@ -197,7 +198,14 @@ void udelay(unsigned long usec)
> > >         do {
> > >                 schedule();
> > >                 kv = usec > CFG_WD_PERIOD ? CFG_WD_PERIOD : usec;
> > > -               __udelay(kv);
> > > +               if (CONFIG_IS_ENABLED(UTHREAD)) {
> > > +                       ulong t0 = timer_get_us();
> > > +                       while (timer_get_us() < t0 + kv)

I think it's better to rewrite this as timer_get_us() - t0 < k.

> >
> > Do we make progress by constantly scheduling new tasks? Perhaps we
> > should at least leave the task running for some time?
>
> If I get the point, the UTHREAD is a cooperative framework, which means
> a task yields the control flow only when it considers nothing else could
> be done.

> And there's no preemption (at least in this revision). Thus I
> don't think it's a problem.

I was implying it would cause a problem, I was just wondering if we
could optimize it easily somehow. But i think it's fine as is

thanks
/Ilias


>
> > Thanks
> > /Ilias
>
> Best regards,
> Yao Zi
>
> > > +                               uthread_schedule();
> > > +               } else {
> > > +                       __udelay(kv);
> > > +               }
> > >                 usec -= kv;
> > >         } while(usec);
> > > +
> > >  }
> > > --
> > > 2.43.0
> > >
