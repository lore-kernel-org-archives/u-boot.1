Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E2CAC36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 16:33:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1F2581703;
	Tue,  1 Apr 2025 18:33:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hP36BK7j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 064AC8171B; Tue,  1 Apr 2025 18:33:11 +0200 (CEST)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B01F801BE
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 18:33:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e589c258663so5311666276.1
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 09:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743525187; x=1744129987; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=I3gMn0REYoT2Hxi2a8DGjG1B45b4JkZSrRrU4eEkC9k=;
 b=hP36BK7jekqaDipXS8re8fiYfDZlW1H+PQqNeKCNyAIapjlgOOGE0Bv5iG4mZ3cRJ2
 J/zU9Hjx6/30zv7scMNhUCpelmk28dBPspcvUpfZseGX/WDjl523/eY3FYcq363tY3D/
 vlHq1m4fPBEiJ7glw+BFLVGCIjqOgekMQHmtChuo5CsDqHb0A74kIeQ14M2abtjQtiND
 rq09PN3SRAeT1XO+HcoW9T2oV8yISSM2YQxTuEXzQSjKg3ouDL47MHQzcEiqELZbAGpN
 kO/P/H8fFBB3wuoNclF78fifDEe2053grDN6EzzH+4xGzy/Oo5pmbwizWsK5YGab8qMD
 2Cnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743525187; x=1744129987;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I3gMn0REYoT2Hxi2a8DGjG1B45b4JkZSrRrU4eEkC9k=;
 b=pKtX/pq5hMR5LRLyKADT0jTCQrDIR0EdomKuPJWlJqbPECD40vmRjgGj3KMmwZmgmk
 RIvYEGWW+JjJLkww086sUZOVmTbfFFnHCPtERf4aPtk+c+CwI2j6Sfs3Qbe5kq4qka3X
 w3q600rjVWAc4ed+Jr/8qLBkv/fbPfOpjQyv2GC4cw1vjFn1mPqvB05FHgaLRZhrL00I
 cYHYa9+58FaUzPj6A4go741rGj58qfLZnaXuatQ9hTtq7txQY+sQOZD2Z3pGZx5BiYbi
 c3pr8zOheNbRUtK3F450MA80Bgd+nCGIbzvf5GQYJX9SIzF+xeInHolD2i8KeGa5YFId
 Ydpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaj4q8MgJwmq5AlSlquDykP55Zidh5y27bxw/Dw0vV/XF3K14cTZbfm/oSIHrSZ9sZA4AWY2w=@lists.denx.de
X-Gm-Message-State: AOJu0Yzsrhbc3fGph68+2LVlmK4sQn9hsWyoB8XBFfnmUTfUZN62Jz89
 W/JPUpibcNuwI90hdiZKC+qUaNyNO1SLGtxUqF9DLvcQ4rQeey0AeYfEN5SCUybOlZxDUGBv5gV
 WsU1Qu8Q1bDufkqgJ+sa40o0aBw03j/rGeeXg3A==
X-Gm-Gg: ASbGncu9h4lWpQMICpaMR5bKoOmzaaFgSucYb4UIlfDvRnzswuBQSEwyB1djbKjws/w
 IVcIntw1agMREIZW5kAH9wBLX5mnyp779kSKldkSQnKy7f059iaZ7IKpE112KkyRPpUqEfQjZF2
 A/gUJCtBAUWcHefvYnABau+Ove
X-Google-Smtp-Source: AGHT+IE/6H11k5TlqWhAIQ+GRAbl2GgZk+E/4K1NVVgwLTYoXzoPUIaMsHJcvyMjdxux4ZtAHq+4zc3NPKeU19KBtcE=
X-Received: by 2002:a05:6902:4812:b0:e6d:deb9:637a with SMTP id
 3f1490d57ef6-e6ddeb966e8mr3271268276.17.1743525187134; Tue, 01 Apr 2025
 09:33:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250314215525.579655-1-jerome.forissier@linaro.org>
 <84e047e7-f90e-4435-8f3d-132d970749ac@linaro.org>
 <CAFLszThN_0aRhtTRmEGmjyiekz1XtzZdH1qq0oLSyYcO5yKobA@mail.gmail.com>
In-Reply-To: <CAFLszThN_0aRhtTRmEGmjyiekz1XtzZdH1qq0oLSyYcO5yKobA@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 1 Apr 2025 19:32:31 +0300
X-Gm-Features: AQ5f1JoP2HhfWvIfksD6q4EvJyLzd0b5K09eLn-CngnJkjh8RG-PYjDo1P6Ey1Y
Message-ID: <CAC_iWjLHPLeX2DhnVqS3QtjhyPVd-Hkuqr0vF_dCXmBQApwvng@mail.gmail.com>
Subject: Re: [PATCH 00/12] lwIP sandbox tests
To: Simon Glass <sjg@chromium.org>
Cc: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
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

Hi Simon

On Tue, 1 Apr 2025 at 18:42, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Jerome,
>
> On Tue, 1 Apr 2025 at 03:14, Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
> >
> > Hi Simon,
> >
> > Any feedback on this series?
> >
> > https://patchwork.ozlabs.org/project/uboot/list/?series=448553
>
> No, not from me, but thanks for doing it!

Aren't you maintaining the sandbox drivers?

Thanks
/Ilias
>
> Regards,
> SImon
>
>
> >
> > Thanks,
> >
> > --
> > Jerome
> >
> > On 3/14/25 22:55, Jerome Forissier wrote:
> > > This series enables most of the driver model tests for network features
> > > with NET_LWIP (test/dm/eth.c and test/dm/dsa.c).
> > > - Patches 1-5 fix a few bugs (device selection) and add missing features
> > > (sandbox timer, restart support) to NET_LWIP
> > > - Patch 6 decouples the sandbox ethernet driver from NET
> > > - Patch 7 adds missing static IP addresses that NET_LWIP needs
> > > - Patches 8 and 9 update the tests to use a common interface to send
> > >   ICMP packets (do_ping(...) instead of net_loop(PING))
> > > - Patch 10 enables DM_DSA and the associated tests with NET_LWIP
> > > - Patch 11 adds a sandbox64 configuration with NET_LWIP=y
> > > - Patch 12 adds that configuration to the CI
> > >
> > > Jerome Forissier (12):
> > >   net: lwip: do_ping() should return CMD_RET_FAILURE when no device
> > >   net: lwip: fix initialization sequence before a command
> > >   net: lwip: provide net_start_again()
> > >   net: lwip: add restart support to ping
> > >   net: lwip: use timer_early_get_count() when CONFIG_SANDBOX_TIMER=y
> > >   drivers: net: sandbox: add support for NET_LWIP
> > >   sandbox: provide static IP addresses for eth{2,3,5,6,7}
> > >   net: ping: make do_ping() available via <net.h>
> > >   test: dm: eth, dsa: update tests for NET_LWIP
> > >   net: lwip: allow DM_DSA=y when NET_LWIP=y
> > >   configs: add sandbox64_lwip_defconfig
> > >   CI: add sandbox64_lwip
> > >
> > >  .azure-pipelines.yml             |   2 +
> > >  .gitlab-ci.yml                   |  11 ++
> > >  board/sandbox/sandbox.env        |   5 +
> > >  cmd/net.c                        |   3 +-
> > >  configs/sandbox64_lwip_defconfig |   5 +
> > >  drivers/net/Kconfig              |  14 +-
> > >  drivers/net/Makefile             |   1 -
> > >  drivers/net/sandbox-lwip.c       |  85 -----------
> > >  drivers/net/sandbox.c            | 240 ++++++++++++++++++++-----------
> > >  include/net-common.h             |  15 ++
> > >  include/net-legacy.h             |   3 -
> > >  include/net-lwip.h               |  10 +-
> > >  net/Makefile                     |   2 +-
> > >  net/lwip/dhcp.c                  |   3 +-
> > >  net/lwip/dns.c                   |   3 +-
> > >  net/lwip/net-lwip.c              |  86 +++++++++--
> > >  net/lwip/ping.c                  |  13 +-
> > >  net/lwip/tftp.c                  |   5 +-
> > >  net/lwip/wget.c                  |   6 +-
> > >  test/dm/Makefile                 |   2 -
> > >  test/dm/dsa.c                    |   8 +-
> > >  test/dm/eth.c                    |  77 +++++-----
> > >  22 files changed, 351 insertions(+), 248 deletions(-)
> > >  create mode 100644 configs/sandbox64_lwip_defconfig
> > >  delete mode 100644 drivers/net/sandbox-lwip.c
> > >
