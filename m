Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64423C3ABA3
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 12:07:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCB3980BAD;
	Thu,  1 May 2025 14:07:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HXIqPPTS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9694E820E2; Thu,  1 May 2025 14:07:36 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2BAA82132
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 14:07:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ac3eb3fdd2eso157300166b.0
 for <u-boot@lists.denx.de>; Thu, 01 May 2025 05:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746101252; x=1746706052; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QjyuJJ9yWj3g15Y7bXjpdGJY00mQiCTVfs6jxo2FWhg=;
 b=HXIqPPTSAspBI1zu1dmx1gFsxasYfcP3oUw5APoDcKfSEfEEcJniST8eh7v4EcQpC8
 XQ8FNZd1CioVrE4OvZWakNQE1aiTpnQSSv3i1+hZC/Qibm5DI07qxNjQqRuBLe9uJ2cV
 omMAOiKIrqV7X2hLCuERDpqsG++NHQs+QL2u4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746101252; x=1746706052;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QjyuJJ9yWj3g15Y7bXjpdGJY00mQiCTVfs6jxo2FWhg=;
 b=MVAsS5QXimEZgJ7wIkFf2CQzn3mFekff1A/jsCtpkr782MLgzu/GbqRUrWKcelPRh7
 r62T4wLB1CZ8hjFIqnhPVQAvQTFujmvv2gfWhBf3HtbiVKK87upxQ89R9MU26deyNfC1
 VKCiWtXxalE0LsPfFmTmCNY88495C1+qu/3JrfP1W4b7HgHvam9Ud3sCVkleVjiCtFgg
 XMbBdF9bAvdYulEh3GHOZTjfF90s1r08SV3dbbFCXasQ7dw1wnJsKEqEGYl7k2Di0gNY
 nuASwzlDo3y+i1eBYBl3m+r7mJTNSsGXo8Z3OfYIHWpbZ8NlbF7wVBIPZup9t6ebgOHB
 +xfQ==
X-Gm-Message-State: AOJu0YxSsopY6lGV+wkkW0t0CgoJXjjc54xDG6Br4c/R8BXlByrzRivO
 Rpxd35y+qVgGvQBMsWiJ+3+gKmAWwZSMNM752XdGMMgFX5hk4ggznJ8BbZUHLyblJnkWMY61Y3V
 hAQbaHf2egj3LkrpQ6qy9LTx5QVL6TgGfuQmr
X-Gm-Gg: ASbGncuI+NSQAM+wZEf1oQkaQinz1TQ78fn4jFa0DKOg9PDdaf5a9qSWUO2g1Ui15FD
 C2zIZmMNJDld1fmtb9D31qLeGf84peOEWH8yV1AsnUp+jcT7T2T/hu9/0+jGBtfMMXgIlffhnm6
 mglXjlmwPpx/sN4cIC3Fzr9Uw=
X-Google-Smtp-Source: AGHT+IGxS/ciC9n/BQEcaQJSSBQesJAhEBfvoqkg4Dw2xL1tLh5+njxCy7Zusreb/FGRMwx3e4drbSTlI3Av9gow1gA=
X-Received: by 2002:a17:906:c10b:b0:ac2:dc00:b34d with SMTP id
 a640c23a62f3a-aceff560249mr199677066b.53.1746101252303; Thu, 01 May 2025
 05:07:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250501010456.3930701-1-sjg@chromium.org>
 <96025fbf-c636-4726-8534-d95e54ff1017@mailbox.org>
In-Reply-To: <96025fbf-c636-4726-8534-d95e54ff1017@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 1 May 2025 06:07:15 -0600
X-Gm-Features: ATxdqUGeFhJZECff-oWkmJsvXmrILMY_TA8_yuDeORPtAmV3SH_UXR1GcAQbFCE
Message-ID: <CAFLszTgFfcd01rdwH_TM74xwt_Uiy+DGba=6bF=-CH3GPRj+sQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/22] Deal with exfat versus byteorder
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Fabio Estevam <festevam@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

Hi Marek,

On Wed, 30 Apr 2025 at 20:02, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 5/1/25 3:04 AM, Simon Glass wrote:
> > Since exfat has its own byteorder functions we need to be careful about
> > including the normal U-Boot byteorder headers in code included by exfat.
>
> ...
>
> >    net: Use a forward declaration for cmd_tbl in net-common.h
> >    congatec: Include env.h to permit reading the environment
> >    dhelectronics: Include env.h to permit reading the environment
> >    imx8ulp_evk: Include env.h to permit reading the environment
> >    venice: Include env.h to permit reading the environment
> >    phytec: Include env.h to permit reading the environment
> >    ronetix: Include env.h to permit reading the environment
> >    toradex: Include env.h to permit reading the environment
> >    advantech: Include env.h in imx8qm_dmsse20_a1
> >    tegra: Include env.h to permit reading the environment
> >    synology: Include env.h to permit reading the environment
> >    amlogic: Include env.h to permit reading the environment
> >    freescale: Include env.h to permit reading the environment
> >    google: Include env.h to permit reading the environment
> >    liebherr: Include env.h to permit reading the environment
> >    technexion: Include env.h to permit reading the environment
> >    elf: Only use network environment-variables if net enabled
> >    net: Include byteorder in net6.h
> >    net: Include string.h in net-legacy.h
> >    net: Include env.h in pcap.c
> >    net: dc2114x: Include env.h to permit reading the environment
> >    net: Move env_get_ip() out of the header file
> >
> >   arch/arm/mach-tegra/dt-setup.c                |  1 +
> >   board/Synology/ds414/ds414.c                  |  1 +
> >   .../imx8qm_dmsse20_a1/imx8qm_dmsse20_a1.c     |  1 +
> >   board/amlogic/jethub-j100/jethub-j100.c       |  1 +
> >   board/congatec/cgtqmx8/cgtqmx8.c              |  3 +-
> >   board/dhelectronics/common/dh_common.c        |  1 +
> >   board/freescale/imx8ulp_evk/imx8ulp_evk.c     |  1 +
> >   board/freescale/mx7dsabresd/mx7dsabresd.c     |  1 +
> >   board/gateworks/venice/venice.c               |  1 +
> >   board/google/chameleonv3/board.c              |  2 +
> >   board/liebherr/xea/xea.c                      |  1 +
> >   .../common/phytec_som_detection_blocks.c      |  1 +
> >   board/ronetix/imx8mq-cm/imx8mq_cm.c           |  1 +
> >   board/technexion/pico-imx7d/pico-imx7d.c      |  1 +
> >   board/toradex/colibri_imx7/colibri_imx7.c     |  1 +
> >   board/toradex/verdin-imx8mm/verdin-imx8mm.c   |  2 +-
> >   cmd/elf.c                                     | 41 ++++++++++---------
> >   drivers/net/dc2114x.c                         |  1 +
> >   include/net-common.h                          |  9 ++--
> >   include/net-legacy.h                          |  1 +
> >   include/net6.h                                |  1 +
> >   net/net-common.c                              |  6 +++
> >   net/pcap.c                                    |  1 +
> >   23 files changed, 53 insertions(+), 27 deletions(-)
> There are no fs changes in this series , what does this series have to
> do with exfat ?

I found that in some situations, the exfat code includes
linux/byteorder.h instead of its own local byteorder, which is
implemented differently. This then causes build errors in the exfat
code. One way to trigger it is by adding '#include net.h' to
include/efi.h

Regards,
SImon
