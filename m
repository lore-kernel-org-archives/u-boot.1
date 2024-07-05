Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB1CC3271E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 22:18:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67E3F88630;
	Sat,  6 Jul 2024 00:17:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aNP6JFSm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 784B4882FA; Sat,  6 Jul 2024 00:17:58 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8722488630
 for <u-boot@lists.denx.de>; Sat,  6 Jul 2024 00:17:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-57d05e0017aso2545524a12.1
 for <u-boot@lists.denx.de>; Fri, 05 Jul 2024 15:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720217876; x=1720822676; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9povWACGyMSMIiNBfWuft8TKytX2u1oRobedp+0bp5A=;
 b=aNP6JFSmor8jb95AbvMXCae/0LXs1Oj3lEsl+iOugjIzrt3KCAisnGdGWcsKUyToTQ
 BlOBLvxNmu3ihRrLvGuN3n0nivDcKVartcOYpP6bX+LLJjr2o+N5vTI5QLyVq9nTbkj4
 Laa6ArCr8fzAKhq9Y818enBjj4wD3TFOVrBrv90Dhitldng46eUijVIBJhmEqefCTYqD
 /Xd6L5CuDPFpUrQTDnKMm2Pfg5H8Ts9cnynkvgF9pS+7hxVNcM7oy+stMhRHFL/wjzfq
 hpmRmkq2vsJ5MD3VgKWeejG9oUuc+FUHQYG4GSxU1p6W82DjXFzhcmgXStRKP+7Gyk2v
 XDJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720217876; x=1720822676;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9povWACGyMSMIiNBfWuft8TKytX2u1oRobedp+0bp5A=;
 b=OtadPAhGa6BQ1lt5bCgjRzmwBt2lWCxJB5nCT4IxnwIvnHO8zolPzVnhodF3xrG9HD
 9R9HLjwFYIVk2MqOnOyp4qNX7DQ3SCNxHLjcPwPCo6xNTsJU7xaAcXpas+yMY/aKmRyh
 wd+LGhSbEGQZXd/tD8ONFYOYKAy+dHx9Pglbj7ChJM10shdsiJmzauxkFhFJk61ekAfT
 NS8EYVuf79TLzFMPH83pUUnZg75DwuCrRWj3vP9u+vgJnke0FFPij3MgAJ2Mvfp0n+J6
 Z6gqwXojwywUJrwNN+WGZ496OfSbeiCUUdtQTQRi8CmWMh++v9X8YNgugWUTOrgtbRAF
 WJ+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBfSHncJLY0NiQm+6xHojh5igNs69XMToLbzITyu2+BS04P6a8eiHYIBToZNZ+k/hnyXYrR/E0MDgNTtsAZu2HVnw8ug==
X-Gm-Message-State: AOJu0Yy3mxUdzaUeP9c/gJnL1n0MI/+nfAyY+fZXUy4OI1wxK7pUlbBf
 e39e7Lkgq5z/qfFKwHGRlgy58DJN5toOald1Ft4CexKtjCYGvgrS/FHyNPmHOeKuWLT7RQ3HMgH
 NuZQSOIU416AkaoiZkbyxMa6meLw=
X-Google-Smtp-Source: AGHT+IGnw/fyHDnbkzEQTyoQA2qmIhpLpZBi5Ok6a6CmCMB8P9/mJbSUOqgwQchNdhoKsiw0VfkXxYOJuu7hFKY9X4E=
X-Received: by 2002:a05:6402:5255:b0:58c:7c2f:5c0b with SMTP id
 4fb4d7f45d1cf-58e5b4ae20dmr3305563a12.25.1720217875697; Fri, 05 Jul 2024
 15:17:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240705150431.2274662-1-mikhail.kshevetskiy@iopsys.eu>
 <CALeDE9OrLw4h_iZKb=1BFHUJKPLrPFirVwEb67ynh7dFNJV0Sg@mail.gmail.com>
 <f0b0749c-e6e7-47b5-8cc5-82d19115f97d@genexis.eu>
In-Reply-To: <f0b0749c-e6e7-47b5-8cc5-82d19115f97d@genexis.eu>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Fri, 5 Jul 2024 23:17:44 +0100
Message-ID: <CALeDE9OuHst9TA9YonRtzZ8krMDSf9FUS3sdOR6w=FiSbNrR=g@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] net: tcp: improve tcp support
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>, Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, 
 Marek Vasut <marex@denx.de>, Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
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

On Fri, 5 Jul 2024 at 22:16, Mikhail Kshevetskiy
<mikhail.kshevetskiy@genexis.eu> wrote:
>
>
> On 05.07.2024 20:56, Peter Robinson wrote:
> > Hi Mikhail,
> >
> >> This series of patches greatly improve TCP support.
> > Where's the changelog of what changed from v1?
>
> no changes, just remove some patches and add a cover letter

So there were changes then :-)

>
> >
> >> The benefits:
> >>  * a lot of bug was fixed
> >>  * tcp cliens becomes smaller/simpler
> >>  * fix data uploading (now it's possible to transmit a huge
> >>    array of data from the board to external server)
> >>  * data downloading/uploading with netcat over tcp was added
> >>
> >> Mikhail Kshevetskiy (9):
> >>   net/tcp: fix TCP options processing
> >>   net/tcp: fix selective acknowledge
> >>   net/tcp: put connection specific data into a tcp_stream structure
> >>   net/tcp: add connection info to tcp_stream structure
> >>   net/tcp: rename ack_edge and seq_init to more common rcv_nxt and irs
> >>   net/tcp: improve tcp framework, use better state machine
> >>   net/tcp: simplify tcp header filling code
> >>   net/tcp: define a fallback value for rcv_wnd size
> >>   net/netcat: add netcat over tcp support
> >>
> >>  cmd/Kconfig          |    7 +
> >>  cmd/net.c            |   34 +-
> >>  include/net.h        |    7 +-
> >>  include/net/netcat.h |   20 +
> >>  include/net/tcp.h    |  227 +++++++-
> >>  include/net/wget.h   |    8 -
> >>  net/Makefile         |    1 +
> >>  net/fastboot_tcp.c   |  190 +++----
> >>  net/net.c            |   30 +-
> >>  net/netcat.c         |  159 ++++++
> >>  net/tcp.c            | 1253 +++++++++++++++++++++++++++++-------------
> >>  net/wget.c           |  479 +++++-----------
> >>  12 files changed, 1538 insertions(+), 877 deletions(-)
> >>  create mode 100644 include/net/netcat.h
> >>  create mode 100644 net/netcat.c
> >>
> >> --
> >> 2.39.2
> >>
