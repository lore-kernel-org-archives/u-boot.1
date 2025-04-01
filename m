Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 236FFC36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 15:42:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 953708171B;
	Tue,  1 Apr 2025 17:42:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="V4CvFrYD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7509281DE3; Tue,  1 Apr 2025 17:42:10 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07E8181703
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 17:42:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ac2af2f15d1so745605566b.1
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 08:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743522127; x=1744126927; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gIyN8UO7BSTq4gyM5wlDIze5NB85AH+cxCPOYvBAbq0=;
 b=V4CvFrYDLrfUAFIaRr6hfrnX0/lmkt2kCU4PuyxincrzTOM64JqGKabftqdMclqT4R
 0omAMidPerJuuyZA1Bkd9c/7rnRYjDcuJK0rxSpUy0eTtLmBU8RnyO8cdQYb5dTYYVCQ
 qJSr0uj9ttghvozfRYNYrzc/XLY8ho2PLjD1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743522127; x=1744126927;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gIyN8UO7BSTq4gyM5wlDIze5NB85AH+cxCPOYvBAbq0=;
 b=bnxM9VMycPA/YjXC6JOqqDqKapNFCm2TRrWVWRZgJNlTQ891rxZz3Y4QZcwv/ASyf/
 rJlrp6evLqSBXZ4LHIjqf1f6S5jyGTv6BiW+FxO5WO9U6/eq0v0aFCsSb9JwPsozbhMN
 VOxaLEAFpLnX4khfCfcnldT5MSS39PoDWQixZ7y31/p5cRWyiBkECctPyngdAKQRfu9l
 A3ZUrcs7VLUB//UiZs6+doY5fyPkiWa6/FsxqkSroymoT2ZelF783ctJ2ZzALTMZUjsW
 mH7roIVKvg+QOO4xFTk06qhQwhLpdBXAfV1qzCkunL/IbWG+3tN7mdud9AALnPTPxY/H
 gHyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW03aedAPeAkfP8VUBZh0JRBE1x93QPzpubeqkeE6ReqGL9d4cI8sLpVS7BMs2ZrBvs7s5TlIM=@lists.denx.de
X-Gm-Message-State: AOJu0YwpLSIP8wVu9uEbSHSDeEdsQd1QfTdJkpKBy2p4NByv1db9rdkQ
 frG3qT+yrbENT4XxqIgXNAaHUpiJWD/MjMkLJiHAosl2f5rTudshAY8T6nmqrt1CnC0jsM+0fd6
 BiNsoWRxUg3vDKn+2T7iHFwjK/DUnHhZA6i6j
X-Gm-Gg: ASbGncuCxNK7gkBxdyYHnDQ1Oq+cpbgh9NnKhKLu3fjL4nnsXU2ODnSusi/0nbUkAjo
 HjlIwkhCTzTPAYJk6MqpABidIwP9HUzdCsXiZHoTqu3Qb8dzMbCMZ29VB/QppM4Dn3zQ/e2Vt/s
 VXh3/oE3bRGONfcuCELTN7VS1eQgeV1p7OuWK9280=
X-Google-Smtp-Source: AGHT+IFN8665OFuSfUtsxhFShodIS2qshSmvpd/B2ZmZvQ1zuuImdt6XFJCmLiwSO9acsuW8FfgmBcD5H4MPjxl/V0s=
X-Received: by 2002:a17:907:7e96:b0:ac7:37da:cd46 with SMTP id
 a640c23a62f3a-ac738ba8055mr1150846066b.49.1743522127407; Tue, 01 Apr 2025
 08:42:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250314215525.579655-1-jerome.forissier@linaro.org>
 <84e047e7-f90e-4435-8f3d-132d970749ac@linaro.org>
In-Reply-To: <84e047e7-f90e-4435-8f3d-132d970749ac@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 2 Apr 2025 04:41:55 +1300
X-Gm-Features: AQ5f1Jr8r4tB22ZHYP6WpaVolqDLz5p15tfjGBjynjx5BDPluNHecyD9WY71Alw
Message-ID: <CAFLszThN_0aRhtTRmEGmjyiekz1XtzZdH1qq0oLSyYcO5yKobA@mail.gmail.com>
Subject: Re: [PATCH 00/12] lwIP sandbox tests
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
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

Hi Jerome,

On Tue, 1 Apr 2025 at 03:14, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Hi Simon,
>
> Any feedback on this series?
>
> https://patchwork.ozlabs.org/project/uboot/list/?series=448553

No, not from me, but thanks for doing it!

Regards,
SImon


>
> Thanks,
>
> --
> Jerome
>
> On 3/14/25 22:55, Jerome Forissier wrote:
> > This series enables most of the driver model tests for network features
> > with NET_LWIP (test/dm/eth.c and test/dm/dsa.c).
> > - Patches 1-5 fix a few bugs (device selection) and add missing features
> > (sandbox timer, restart support) to NET_LWIP
> > - Patch 6 decouples the sandbox ethernet driver from NET
> > - Patch 7 adds missing static IP addresses that NET_LWIP needs
> > - Patches 8 and 9 update the tests to use a common interface to send
> >   ICMP packets (do_ping(...) instead of net_loop(PING))
> > - Patch 10 enables DM_DSA and the associated tests with NET_LWIP
> > - Patch 11 adds a sandbox64 configuration with NET_LWIP=y
> > - Patch 12 adds that configuration to the CI
> >
> > Jerome Forissier (12):
> >   net: lwip: do_ping() should return CMD_RET_FAILURE when no device
> >   net: lwip: fix initialization sequence before a command
> >   net: lwip: provide net_start_again()
> >   net: lwip: add restart support to ping
> >   net: lwip: use timer_early_get_count() when CONFIG_SANDBOX_TIMER=y
> >   drivers: net: sandbox: add support for NET_LWIP
> >   sandbox: provide static IP addresses for eth{2,3,5,6,7}
> >   net: ping: make do_ping() available via <net.h>
> >   test: dm: eth, dsa: update tests for NET_LWIP
> >   net: lwip: allow DM_DSA=y when NET_LWIP=y
> >   configs: add sandbox64_lwip_defconfig
> >   CI: add sandbox64_lwip
> >
> >  .azure-pipelines.yml             |   2 +
> >  .gitlab-ci.yml                   |  11 ++
> >  board/sandbox/sandbox.env        |   5 +
> >  cmd/net.c                        |   3 +-
> >  configs/sandbox64_lwip_defconfig |   5 +
> >  drivers/net/Kconfig              |  14 +-
> >  drivers/net/Makefile             |   1 -
> >  drivers/net/sandbox-lwip.c       |  85 -----------
> >  drivers/net/sandbox.c            | 240 ++++++++++++++++++++-----------
> >  include/net-common.h             |  15 ++
> >  include/net-legacy.h             |   3 -
> >  include/net-lwip.h               |  10 +-
> >  net/Makefile                     |   2 +-
> >  net/lwip/dhcp.c                  |   3 +-
> >  net/lwip/dns.c                   |   3 +-
> >  net/lwip/net-lwip.c              |  86 +++++++++--
> >  net/lwip/ping.c                  |  13 +-
> >  net/lwip/tftp.c                  |   5 +-
> >  net/lwip/wget.c                  |   6 +-
> >  test/dm/Makefile                 |   2 -
> >  test/dm/dsa.c                    |   8 +-
> >  test/dm/eth.c                    |  77 +++++-----
> >  22 files changed, 351 insertions(+), 248 deletions(-)
> >  create mode 100644 configs/sandbox64_lwip_defconfig
> >  delete mode 100644 drivers/net/sandbox-lwip.c
> >
