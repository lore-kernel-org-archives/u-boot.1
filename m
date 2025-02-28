Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E9B9C19776
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 13:27:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 095FC80FF2;
	Fri, 28 Feb 2025 14:27:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Vm09imwQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2230810ED; Fri, 28 Feb 2025 14:27:03 +0100 (CET)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 549A4800B6
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 14:27:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e60ad903382so1007163276.0
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 05:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740749220; x=1741354020; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zZrqFipEl2jt90ocdRxvT679gVraV1WTe0WQHNG5UUc=;
 b=Vm09imwQpRgurMxlVDHeEjj4ePjQmoXZKKiavkMBnZ09Dxt/p5DFeKuAbqAgkkjD+6
 fjgbpJGwEVnMYaSpFeydCFQiwePz6DL7bWt73tijtygqs/OzOjT23YWnAQeDC7WwHcOF
 wPQSY4nliUfL4Wp0MftG2XkhViyiL7NdNnsz7P2uyKnGsa7hZoV1RAfm4+/p2/KW0LOU
 nzQp/k6CAuhkQGbpF78mXGE4C1lNkEkxYlBHhtplX+IzWFt8Ws5XbJUxqeOcRG9GHWh9
 mTPq7uQg4GyRV1vznoCkvDwJJioQOG1OvmKO35h0ZnsRalguGIL6BCTRJEwrkILUphGg
 xzFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740749220; x=1741354020;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zZrqFipEl2jt90ocdRxvT679gVraV1WTe0WQHNG5UUc=;
 b=JWayg0lX6dYDPqlumpVerPeFK2IV0/ETrrAxC4te7NUbihh+ORH8wOQOA6bQ9nJiTd
 uN9wvBSxAhi0QluCFzutkOc2TWEwnQSh8exDLqfsXEGGECMCMazF0Ny/MzHHqd1ROXLd
 f04oLqqzQk+Qf7kTbB2zY2WjPubRL2b+wL20wy1tJxTs0SeyHa6ML5Kfi62e1HvQHcua
 qgc6BlgtlBKS1yIXu8+7+ORjLR/5SumedziDpqh0m9PPmDoE9T2YadDg27w4nhQuMjjA
 3bdk3E1jZkhIMPc1NQT57KHQlZpajduZ9PSQVTJ8clSGv5QIuC3ZnBLaYyMrCDie7iOK
 sM5A==
X-Gm-Message-State: AOJu0Yz611EvFPvt/DVgt97Qcst6hoCBbgz8ODonFWesMAMgSn3Xrng7
 ma+yl1nchZ1BMkvBthbNOvx+1kpQQGlHfMeSCvqPgQg5h+CJ/YzXRD0uCTYf33/P2Tj60vo61xU
 qt9EHNMuKj45PDICOZxDT/0UB/yLSjYmRFg8XQw==
X-Gm-Gg: ASbGncu2kETSY/KWi6Z1EBlaOPMHVJ9EAQ2V4U6VptiYQ67mAGrVA4BYb0KX+4wPCck
 mTPfFiIqgf5VIDrLsz8B2eRd0pRtOTPFu96K86OpgwIsMzs2lVVO1REPF+T/VVX9WuTZY9J7ElX
 pODVsW8cx1A0x9mo/4l52NyWrzRdfkpYiYWkmkhpk=
X-Google-Smtp-Source: AGHT+IHsy9D5SMS+gkTgV+YzFxFdaNS60qzUnBXIg6/JXWj6av8bEfFwvQNLeS8prm4/hzvn1+cdirvPCD8/TjM53Ow=
X-Received: by 2002:a05:6902:842:b0:e5d:d6b8:231d with SMTP id
 3f1490d57ef6-e60b2f5f5damr3459857276.46.1740749220065; Fri, 28 Feb 2025
 05:27:00 -0800 (PST)
MIME-Version: 1.0
References: <cover.1740499185.git.jerome.forissier@linaro.org>
 <17ec7e3f553fa8c36c19d2cbf4cc0e6d03c7e443.1740499185.git.jerome.forissier@linaro.org>
In-Reply-To: <17ec7e3f553fa8c36c19d2cbf4cc0e6d03c7e443.1740499185.git.jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 28 Feb 2025 15:26:22 +0200
X-Gm-Features: AQ5f1Jp3a4Dui6TSEZ0bIyvLSGhxtlL19UmMJsYSWWLpWvYTjYBLPh2UyGDZKJw
Message-ID: <CAC_iWjLJkbewQRHfoeAap5XDceMwkngJY-N5CiKpRzOCNkDn2Q@mail.gmail.com>
Subject: Re: [PATCH v2 10/14] test: lib: add uthread test
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Raymond Mao <raymond.mao@linaro.org>,
 Philippe Reynes <philippe.reynes@softathome.com>
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

On Tue, 25 Feb 2025 at 18:35, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Add a uhread framework test to the lib tests.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  test/lib/Makefile  |  1 +
>  test/lib/uthread.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 69 insertions(+)
>  create mode 100644 test/lib/uthread.c
>
> diff --git a/test/lib/Makefile b/test/lib/Makefile
> index bf04685dae1..c991dff1c63 100644
> --- a/test/lib/Makefile
> +++ b/test/lib/Makefile
> @@ -31,6 +31,7 @@ obj-$(CONFIG_CRC8) += test_crc8.o
>  obj-$(CONFIG_UT_LIB_CRYPT) += test_crypt.o
>  obj-$(CONFIG_UT_TIME) += time.o
>  obj-$(CONFIG_$(XPL_)UT_UNICODE) += unicode.o
> +obj-$(CONFIG_UTHREAD) += uthread.o
>  obj-$(CONFIG_LIB_UUID) += uuid.o
>  else
>  obj-$(CONFIG_SANDBOX) += kconfig_spl.o
> diff --git a/test/lib/uthread.c b/test/lib/uthread.c
> new file mode 100644
> index 00000000000..84c41d35875
> --- /dev/null
> +++ b/test/lib/uthread.c
> @@ -0,0 +1,68 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2025 Linaro Limited
> + *
> + * Unit test for uthread
> + */
> +
> +#include <stdbool.h>
> +#include <test/lib.h>
> +#include <test/ut.h>
> +#include <uthread.h>
> +
> +static int count;
> +
> +static void worker(void *arg)
> +{
> +       int loops = (int)(unsigned long)arg;
> +       int i;
> +
> +       for (i = 0; i < loops; i++) {
> +               count++;
> +               uthread_schedule();
> +       }
> +}
> +
> +static int lib_uthread(struct unit_test_state *uts)
> +{
> +       int i;
> +       int id1, id2;
> +
> +       count = 0;
> +       id1 = uthread_grp_new_id();
> +       ut_assert(id1 != 0);
> +       id2 = uthread_grp_new_id();
> +       ut_assert(id2 != 0);
> +       ut_assert(id1 != id2);
> +       ut_assertok(uthread_create(worker, (void *)5, 0, id1));
> +       ut_assertok(uthread_create(worker, (void *)10, 0, 0));
> +       /*
> +        * The first call is expected to schedule the first worker, which will
> +        * schedule the second one, which will schedule back to the main thread
> +        * (here). Therefore count should be 2.
> +        */
> +       ut_assert(uthread_schedule());
> +       ut_asserteq(2, count);
> +       ut_assert(!uthread_grp_done(id1));
> +       /* Four more calls should bring the count to 10 */
> +       for (i = 0; i < 4; i++) {
> +               ut_assert(!uthread_grp_done(id1));
> +               ut_assert(uthread_schedule());
> +       }
> +       ut_asserteq(10, count);
> +       /* This one allows the first worker to exit */
> +       ut_assert(uthread_schedule());
> +       /* At this point there should be no runnable thread in group 'id1' */
> +       ut_assert(uthread_grp_done(id1));
> +       /* Five more calls for the second worker to finish incrementing  */
> +       for (i = 0; i < 5; i++)
> +               ut_assert(uthread_schedule());
> +       ut_asserteq(15, count);
> +       /* Plus one call to let the second worker return from its entry point */
> +       ut_assert(uthread_schedule());
> +       /* Now both tasks should be done, schedule should return false */
> +       ut_assert(!uthread_schedule());
> +
> +       return 0;
> +}
> +LIB_TEST(lib_uthread, 0);
> --
> 2.43.0
>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
