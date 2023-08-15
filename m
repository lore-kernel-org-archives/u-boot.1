Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04405C001E0
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 19:01:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 400368671F;
	Tue, 15 Aug 2023 21:01:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HmO4P0i3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF80386940; Tue, 15 Aug 2023 21:01:04 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2751E86384
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 21:01:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=massimo.pegorer@gmail.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3a7d4030621so3013171b6e.3
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 12:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692126060; x=1692730860;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=3YYQyu3GSuQKyn7BugXEt03xmnN4HV8Is7xdhb6hBg8=;
 b=HmO4P0i3+1cDrvKMOE//SEND9bBAeTJBpH4hw5sN1B5ZPiHoi3KLAMquD6nM6e2vge
 hMb+F8/gCATOYyXM5J94t82+/QtU0/tY4QTlWm1FjlAE3mLTPS+bbyQrjZF+70zmDYj5
 N418v+7nNkkuiM+rlzUujtiJWBXFxwdbcs8MF0omwjYtOmnHJNcq1bitkKZe+YJplVYz
 suxgLYoxDdPlMiNjIm8i8e8+nUUUM4F7tlSg8DWaAasL2XovVYjtEVKn8qzqLz5B8s6P
 MDWDYaWttXJ9MRCKvYm5ncNqDwteA/Jk4ymI3Qrv+DMB3tTO6k21gA+nFkZlr3RNi6+n
 FzxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692126060; x=1692730860;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3YYQyu3GSuQKyn7BugXEt03xmnN4HV8Is7xdhb6hBg8=;
 b=THytHhqcOxckYB0n6l5477RvBMFUryYebGQWFaq2ZR44x4qZhX7bg/3VBTzXkywG8M
 3InxNQgD0WP7tS161t5NWL6rGHmXa3y474MuV7uIrrvCwASj6Gsy+vIknci7neLaHKHm
 CbTWhyne9Y8+4hAY/jVvGObQkXYRFci547PUUBo9uUjdGIWOWWDjdlX92CN7ZNXihXpc
 dHF/VK8L4CDImiUnHMHMZs+EM3l6wefynoE21Dih9HftQPcc+wANB1apQb6xW9MVJHf4
 oTZsrsZUpcpB33Px8qFVxaN9OHxhc0qTELJn4o1h1C2UNdaSXWEzfxAGW9Xte8oBMXBc
 xjTQ==
X-Gm-Message-State: AOJu0Yz63H+P8fP/qmBxq5AdR0dlx8q0uDxUzhFbgBR7/81dYMc3JdEU
 P8Gfy3ink8RpM9LkALVlTnRGS6ofp62Pe+VvX6w=
X-Google-Smtp-Source: AGHT+IEwKubEKBV4QgP10na4JQBvCv8ALdUQsP7UzvTgdS90U5wzRDQEVQ3XzpBCp6tOAfNnBgUapcvLLZQgLFXmv/Q=
X-Received: by 2002:a05:6358:7253:b0:134:d030:e5da with SMTP id
 i19-20020a056358725300b00134d030e5damr4830852rwa.21.1692126060530; Tue, 15
 Aug 2023 12:01:00 -0700 (PDT)
MIME-Version: 1.0
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Tue, 15 Aug 2023 21:00:49 +0200
Message-ID: <CAC928HaEQhH2q57T36XtoetfLVSC84-DMBv2msu2PdbkazUBOQ@mail.gmail.com>
Subject: U-Boot logging
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, u-boot@lists.denx.de
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

Hi

I had a trip into U-Boot logging and I am quite confused. I read the
documentation at doc/develop/logging.rst and had a look at source code
in log.h log.c printk.h Kconfig and other files, but the picture is
still quite foggy and, let's say, 'complicated'.

The documentation does not mention at all CONFIG_LOGLEVEL, but pr_xxx
macros rely on its value (and then on log_xxx macros). While log_xxx
definitions, instead, depends on CONFIG_LOG and other CONFIG_LOG_XXX
values.

It is not clear when/if pr_xxx and/or log/log_xxx should be used. Is
any preferred and why? Is there a specific reason to keep both?

Neither the constrains and relations between Kconfig variables are
clear. CONFIG_LOGLEVEL and CONFIG_LOG are in different section
of menuconfig: Console and Logging. The semantic is also a little
bit different: for LOGLEVEL, values smaller than the console loglevel
will be compiled in; for LOG_MAX_LEVEL, instead, any value higher
than this will be ignored.

The doc states that 'If CONFIG_LOG is not set, then no logging will
be available'. But a few lines below 'If logging is disabled, the
default behaviour is to output any message at level LOGL_INFO and
below'. This sounds inconsistent to me.

I see a lot of To Do tasks listed in logging.rst, like converting
some other logging statements like debug() and error(). I wonder if
something can be improved, and in case how: I could commit some of
my spare time.

Thanks. Regards.

Massimo
