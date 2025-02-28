Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1B49C19776
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 14:16:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31B79810ED;
	Fri, 28 Feb 2025 15:16:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="ldRRFbmc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EEC7807D7; Fri, 28 Feb 2025 15:16:51 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CB8D810F4
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 15:16:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id AE3FE25C52;
 Fri, 28 Feb 2025 15:16:48 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dXXN6qw3k0-1; Fri, 28 Feb 2025 15:16:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1740752208; bh=W9gMO7HH0IXzu+KM7PLmyG2LhA2FqMrMWeY+LICUZU8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ldRRFbmcOFOWixpztU7XjliHBmnQLUrWLyjnivY+XLRNF/T4U6FmMcH3EdnlfXIZE
 ryT7whrzpF6Ga3ey9kaS9CoZhld6QWbj8HEiMo07U68K0+3A64lKGa6D3JTVgfLaLD
 LcDCh2H3P7nZLJmQGTJPGsbDMsMec+eJnQsOBMEIuV87htY8HAnAIQh8gtOwOwBSqZ
 jMEiGp1OnvkmRuZwRpaKNhZeA0hpS8hs1vCMTKEzHAQBsYQnLWH4eMYDD1CYV6mWIE
 71uQaNQxnEjkFx/deBMVh7MYzMW848ojYfmkaCK9WBpNGwT4R90OixSrjouGKYquvK
 t+Gt4LMKCZq4g==
Date: Fri, 28 Feb 2025 14:16:38 +0000
From: Yao Zi <ziyao@disroot.org>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v2 08/14] lib: time: hook uthread_schedule() into udelay()
Message-ID: <Z8HFRuCH8TQWC7Pw@pie>
References: <cover.1740499185.git.jerome.forissier@linaro.org>
 <f9568a6c5140b99cbd5b48de21f4d5b12a76d92e.1740499185.git.jerome.forissier@linaro.org>
 <CAC_iWjLtTzCAqR_aq6Q1kBEn=E3oQoCDuvxWAnfrT6R=KCgSeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC_iWjLtTzCAqR_aq6Q1kBEn=E3oQoCDuvxWAnfrT6R=KCgSeQ@mail.gmail.com>
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

On Fri, Feb 28, 2025 at 03:38:22PM +0200, Ilias Apalodimas wrote:
> Hi Jerome,
> 
> On Tue, 25 Feb 2025 at 18:35, Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
> >
> > Introduce a uthread scheduling loop into udelay() when CONFIG_UTHREAD
> > is enabled. This means that any uthread calling into udelay() may yield
> > to uthread and be scheduled again later.
> >
> > While not strictly necessary since uthread_schedule() is already called
> > by schedule(),
> > tests show that it is desirable to call it in a tight
> > loop instead of calling __usleep(). It gives more opportunities for
> > other threads to make progress and results in better performances.
> 
> Some examples of timing gains would be nice.
> 
> >
> > Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> > ---
> >  lib/time.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/lib/time.c b/lib/time.c
> > index d88edafb196..d1a1a66f301 100644
> > --- a/lib/time.c
> > +++ b/lib/time.c
> > @@ -17,6 +17,7 @@
> >  #include <asm/global_data.h>
> >  #include <asm/io.h>
> >  #include <linux/delay.h>
> > +#include <uthread.h>
> >
> >  #ifndef CFG_WD_PERIOD
> >  # define CFG_WD_PERIOD (10 * 1000 * 1000)      /* 10 seconds default */
> > @@ -197,7 +198,14 @@ void udelay(unsigned long usec)
> >         do {
> >                 schedule();
> >                 kv = usec > CFG_WD_PERIOD ? CFG_WD_PERIOD : usec;
> > -               __udelay(kv);
> > +               if (CONFIG_IS_ENABLED(UTHREAD)) {
> > +                       ulong t0 = timer_get_us();
> > +                       while (timer_get_us() < t0 + kv)
> 
> Do we make progress by constantly scheduling new tasks? Perhaps we
> should at least leave the task running for some time?

If I get the point, the UTHREAD is a cooperative framework, which means
a task yields the control flow only when it considers nothing else could
be done. And there's no preemption (at least in this revision). Thus I
don't think it's a problem.

> Thanks
> /Ilias

Best regards,
Yao Zi

> > +                               uthread_schedule();
> > +               } else {
> > +                       __udelay(kv);
> > +               }
> >                 usec -= kv;
> >         } while(usec);
> > +
> >  }
> > --
> > 2.43.0
> >
