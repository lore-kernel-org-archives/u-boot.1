Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A26E2CCD185
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 11:16:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0548844DE;
	Thu,  9 Oct 2025 13:16:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NhgiR05V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC6B6844E4; Thu,  9 Oct 2025 13:16:16 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4520844D2
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 13:16:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-62ec5f750f7so1511355a12.3
 for <u-boot@lists.denx.de>; Thu, 09 Oct 2025 04:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1760008573; x=1760613373; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xos7FjiksSdbKASu6QUQ+f6xEUa6mi2nPZXcI/m5sO0=;
 b=NhgiR05VDE0n/2hSmw0/GcYOQLbhpg1Wi5S9ubjO3+sCDFu4oqokJ44JLigPNtt99Z
 Bdr+LT42Q7RRO2aazAK+Z4JoDoVpvMBtbQr4KSX7Whey3QaT8VY6R/d2KiCxOHjY+pCK
 CYB6I85db+xE430E2ppt2/IdP19O2L2Zjq1O4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760008573; x=1760613373;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xos7FjiksSdbKASu6QUQ+f6xEUa6mi2nPZXcI/m5sO0=;
 b=lvoF0wyBMDTfQAg6ZBTrgCJZFPSL4pJWSwOlbRMbYm4bpYdoKlrhzxof+2dMnCOjYt
 cPuyNX9G/1TdMogdQrn98NeomTxTGGsHH2fiHHq8MvUHJdVBA+FgV9e+ZPkNoiZlLOIF
 Lue2YNa4PurhyJ8VwpXskwImMJI7R011WPIT/5J3eDF82gSiidIqlWN9YQC36r+pms1/
 FVrI9HS+kyl4/zeWKHvpxNkLbdtjcrHIf7BYk1nXYSMzNRQ0B/g9MKA4PyQI3UpiXMPO
 SgGIOvGFYKuoZzrlnQ6hRzW0zVoGlIgg+ozB+ZrbpdeW5C0A1ktbFkLx9Zjh9P/FxuGB
 C9GA==
X-Gm-Message-State: AOJu0YwGY/3cq55ySgVVvU5cq3od7UfD6OXJhEKU6vEysUGzi8TL0ivP
 6zIRcYJR9y+oCJqEn7dsLan6t96oEd5pOB9VKn4BP0qV3hAzSJRRNEpOiCUgDDPv4wWgbD66W8b
 h6qmmL9GG7t7Zz1Izng8/izpMv8E9kFMQieqbRc7X
X-Gm-Gg: ASbGnctRgivMvZOXj8nK1cVKuuoBSdaF2wikGlfVZqEt9Vl7VOEuh/tyil/uJxCDVXy
 u7FPY0LKBatcB/uglQjlJdC1i9WtNZf4RXwPoLp9Z/7LZp41iJrOVvZIdNlKAtJ8syYZjDPcTY+
 UJYcfL0RBWv/2xhbDgow2vRUklKXC/sAllyyEjo4eizOXjE7M52RN79Lwx+cgRAX8sE0msjU4io
 foGfZra4xUmD1jkjGi8CTSaCU+LHFGzWKd3jRTVtA==
X-Google-Smtp-Source: AGHT+IHRDwZezYwYZ9b8l8/BICvOQUzPb/y2wsW7XFXqtr3xBLd9WbPNSItvEiBJzDiA+WRc5M5FcVXvI0yqP7bCJgU=
X-Received: by 2002:a05:6402:518a:b0:628:7716:357c with SMTP id
 4fb4d7f45d1cf-639d5c4fe6fmr6086034a12.25.1760008573226; Thu, 09 Oct 2025
 04:16:13 -0700 (PDT)
MIME-Version: 1.0
References: <20251008-topic-interconnect-next-v2-0-c46e94dd328e@linaro.org>
 <20251008-topic-interconnect-next-v2-1-c46e94dd328e@linaro.org>
 <CAFLszTi3cNihLKOvJhrm1GLYdxQKvkv-66Fdr6m90+vvdUtMMg@mail.gmail.com>
 <d0e157af-c5e7-45ee-9f8f-6b9a523d5505@linaro.org>
In-Reply-To: <d0e157af-c5e7-45ee-9f8f-6b9a523d5505@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 9 Oct 2025 05:16:00 -0600
X-Gm-Features: AS18NWCrwwBGY-T1DhJPHpvn-vgMGiyUnmWDZe_EmY5shZrTzBApxLLIyVhbWOk
Message-ID: <CAFLszTgemVk0tSMpBiMfgnh4LGaVKnOpGWa0N8WwE2Spf+ZUWA@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] Introduce the Interconnect Subsystem
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Sumit Garg <sumit.garg@kernel.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, 
 Mario Six <mario.six@gdsys.cc>, u-boot-qcom@groups.io
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

Hi Neil,

On Thu, 9 Oct 2025 at 02:18, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> Hi,
>
> On 10/9/25 02:25, Simon Glass wrote:
> > Hi Neil,
> >
> > On Wed, 8 Oct 2025 at 09:31, Neil Armstrong <neil.armstrong@linaro.org> wrote:
> >>
> >> Let's introduce the Interconnect subsystem based on the Linux framework
> >> which is used to vote for bandwidth across multiple SoC busses.
> >>
> >> Each bus endpoints are materialised as "nodes" which are linked together,
> >> and the DT will specify a pair of nodes to enable and set a bandwidth
> >> on the route between those endpoints.
> >>
> >> The hardware resources that provide those nodes and provides the way
> >> to vote for the bandwidth are called "providers".
> >>
> >> The Interconnect uclass code is heavily based on the Linux one, with
> >> some small differences:
> >> - nodes are allocated as udevices instead of Linux idr_alloc()
> >> - tag management is minimal, only normal xlate is supported
> >> - dynamic IDs is not implemented
> >> - getting nodes states at probe is not implemented
> >> - providers are probed on demand while the nodes links are traversed
> >> - nodes are populated on bind
> >>
> >> Fully tested with associated DM test suite.
> >>
> >> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> >> ---
> >>   drivers/Kconfig                            |   2 +
> >>   drivers/Makefile                           |   1 +
> >>   drivers/interconnect/Kconfig               |  10 +
> >>   drivers/interconnect/Makefile              |   6 +
> >>   drivers/interconnect/interconnect-uclass.c | 548 +++++++++++++++++++++++++++++
> >>   include/dm/uclass-id.h                     |   2 +
> >>   include/interconnect-uclass.h              |  74 ++++
> >>   include/interconnect.h                     |  81 +++++
> >>   8 files changed, 724 insertions(+)
> >
> > 'interconnect' is such a long and vague word :-)
>
> I didn't chose the name => https://docs.kernel.org/driver-api/interconnect.html
>
> I don't see why we should take a different name in U-Boot.
>
> But I can definitely use "Generic System Interconnect" in the documentation
> and commit messages if it's clearer.

Yes, we should use the same name. Docs can help.

>
> >
> > There seems to be a piece missing here. The uclass should have
> > operations, so that it makes sense for different drivers to implement
> > the methods. I see some there, but also a lot of direct calls from the
> > test to sandbox. I see quite a few functions which lack a struct
> > udevice * - I suspect I am missing something?
> >
> > We normally have a ..._get_ops() macro in the uclass header. Also we
> > normally have stub functions which get the ops and call the function.
> >
> > I see code to remove children, but driver model does this
> > automatically[1]. Same with bind(). If there is a bug in this, can you
> > give a few details, or ideally a test case?
>
> All of this is present and well thought, I went into multiple designs:
> - interconnect uclass provides ops -> interconnect_ops, icc_node doesn't
>    provide any ops since they are just internal objects
> - there's only a single direct call to the sandbox driver to get the
>    setting resulting of the aggregate() & set() op calls, this is purely for
>    validation of the calculations, the sandbox-interconnect-test only uses
>    the public inteconnect.h API

OK, I missed that.

> - For the lack of udevice, it's because I did use the same interconnect API which
>    return a "icc_path" private structure which contains a set of interconnect
>    nodes which forms path across the different providers.

We do a similar think with clk, although the function signature is
different in U-Boot from Linux.

I assume the caller would be a driver? If so, passing in a struct
icc_path * might be more efficient than using malloc() each time.

>
>    Setting a bandwidth on a node is meaningless, same for interconnect providers,
>    this is why we set a bandwidth on a set of nodes, which get aggregated with the
>    other path votes from other devices.
>
>    The key here is the "nodes" which are subdevices of interconnect providers
>    created at bind time, and gets referenced in icc_path objects.
>
>    I made sure we can't remove either interconnect devices or icc_node devices
>    if they are still referenced in an active icc_path.

OK

>    This is the reason of the device_remove() & device_unbind() calls in the test
>    to make sure we're not left with dangling pointers to non-existent icc_node
>    and providers devices.

The specific code is this:

+       device_foreach_child(pos, dev) {
+               debug("%s(pos=%s)\n", __func__, pos->name);
+               ret = device_remove(pos, DM_REMOVE_NORMAL);
+               if (ret)
+                       return ret;
+       }

This is in the pre_remove() method. But if you just remove that code,
doesn't driver model remove the children anyway?

>
> Note I won't re-invent a new API here, the api in interconnect.h is fine and
> works well, I made sure to use all U-Boot driver model offers to avoir allocating
> random objects myself, and keep the interconnect core functions strictly
> identical to the kernel, making it:
> - well integrated in DM (on-demand probe, nodes as DM devices)
> - resulting with the same results as in Linux
> - using the same API
> - easy to sync back from Linux
> - easy to port a driver from Linux

Yes that sounds good.

>
> >
> > Also, please can you add:
> >
> > - comments to the header file, at least
> > - something in doc/
> > - a command to list things / provide information
>
> Yep, I'll add those.

OK thanks.

>
> Thanks,
> Neil
>
> >
> > Great to see the automated tests!
> >
> > Regards,
> > Simon
> >
> > [1] https://docs.u-boot.org/en/latest/develop/driver-model/design.html#removal-stage
>

Regards,
Simon
