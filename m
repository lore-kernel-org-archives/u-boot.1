Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B996CD98F2
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 13:24:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90792849A1;
	Thu, 18 Jun 2026 15:24:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fubIFHDt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C384849AA; Thu, 18 Jun 2026 15:24:21 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DF58847C3
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 15:24:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6956a8abe7aso1277524a12.2
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 06:24:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781789059; cv=none;
 d=google.com; s=arc-20240605;
 b=cLhFFIAtppJZcU914RYByAUn5qinCIsu1CDPDo8/38C4mnq8eiT1QV/g4vaoug+Wgq
 ZanNOuJzjOU4SUwiYNMOb4OX3CpDw6d4pLQpd2okosQkx7lHdYsnyE9pmR/367p/OcQN
 tNVcB8se8zwmHlrUdsClaI/T5rZiT28MYHxMRW5g9xaPPRFgpOHwCuctYynPJqjqq1vU
 acg435O8373jAmCo6XVvOxSX0jCg+7ZN/QbHQ2ljvyTgVTEv4r6yPGDXhYzB5ZoxZlW/
 Do+FU6HEBNI03RvVZcUIF8YGSLIpNyVAAF2seSpm38mbgd8OK8AQ435oXXmITM+t/KGv
 LwCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=SIf+RSxD+u9MoyAxm2IBgdc46jn6XsYgDL1CSYo/gZ4=;
 fh=DYMU3dRED0rmVKTDqXRHxrZw93vonVJHh6vC8tHyRiY=;
 b=WQRP4JqbxX8uvg1wzMV6X8/BhVT+fi7ZQw0bGj2ccd+jVdU+D/Dz4z8Jszt3GqN4L1
 EbvOCqgpkvUc+z2afmE9r33Ok4IJdpB1UFneXAMSoKJ/1/C5FDLATUmjx2yfnmCebQLy
 Gi0P62W4T2AOSCvPOVMFB13gr8K3FDItRdWlavr5K7YFpMwLmi3mQuxbPTY+siNnx/j/
 kdiMcm9/Lu4jB6w7Wlmo17PnpgU9BVnFSO/1yUQjvqMTtvfzHDA6jK+74Q3jWqnyuTuT
 aoQtFjZtHKWyZhWB4V0ZZLVMqV2lHCxfXvkXpSKDZw2N8QRs+Z6NBz+AAh8d//aZX3po
 WRRg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781789059; x=1782393859; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SIf+RSxD+u9MoyAxm2IBgdc46jn6XsYgDL1CSYo/gZ4=;
 b=fubIFHDt9VrRZvsAnAuGVhWq5glD1ahwgTB9opew2E275P32fj9D/Hju0OhTigKU9r
 9qXC5MQgGCCAnJvDumfjoB4Sm6oXcc0nfxsxleKWN2fCmjk7xKdB4tCF1ptkDNepOrVJ
 W3X+zYzPeVJZGytfh8cqVzbiWeJ55rRMkZD38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781789059; x=1782393859;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SIf+RSxD+u9MoyAxm2IBgdc46jn6XsYgDL1CSYo/gZ4=;
 b=oqGTNWTvK/P1vmLnJ8sqCzSfMu0DcoeNb6Gc0bHShq7LvuUPyJEiDFMUGP8HP98Nxq
 lpbmkQ6IxfP80PodJgQ3i1HMu6XKYzAE167lhu7GRshMuZmsQGkSiVa0aLMGu68KqkNT
 1u95C4TNldagGWITTTjuy5UZ5a0eX3SNn9+wbD8DeDqZO2hMZc/N0rB3ax87AUm50Yhf
 7aextXVL3N67cGfPeTjcvs1Ujz3Dqx81wy5HcDx3d4nfe/woQmI49cGeCWESM82MEvWb
 fms8ADq3yQGVylsLybxJpeTCejRoH3iPYivm3lDdAV+6bi4NfZioFTTnikRmSrF0q4+c
 WaxA==
X-Gm-Message-State: AOJu0YxLkwZRIpP/jcME0DXMvXvNPun5vwgBgC/pKSC44BHOged9oaHh
 1+Q/VgaRVheABufFyAWpJl5RVIv9fQkLqs2LzlZUrK0wV/rpHv7JL0TaE/xwow6OiBUd/xpdBXJ
 Oz97Bkz6LuFe0r+4nqlUdRYQh0IAiVTQ9IQzIsoIiz/fvQOv7aFwDkA==
X-Gm-Gg: AfdE7cm3vVj8IhB1wXzxdZ3A7PKci2apKEHm7W5duK7ThWD6rUsjNZzscrkSsEfgWC0
 jNCfdD4ToywMV5dXZJTGPORBwcDAcYcR/5fNI4tHNC4oLJmrfAPxZMvyUEdrJznURwNM0VsCPa7
 FTEa1ZAIjNo2VNSWfL1dxPQLBwdaI5u8+YLDNtchrmjEs69DlnTviyu3pFeWFH8t85AZHVw+Ia4
 yoe5/9B/0wA1U7wEtjyXiboF2mXsztRRnpUD+RzHE/I+DpPNeHlEZJx+GeooXMl8Gbgeicqi82W
 qxNHmD5+
X-Received: by 2002:a05:6402:42ce:b0:68a:f2ac:4675 with SMTP id
 4fb4d7f45d1cf-6954757fd22mr5064512a12.7.1781789058731; Thu, 18 Jun 2026
 06:24:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260616063606.825688-1-dmukhin@ford.com>
 <20260616063606.825688-4-dmukhin@ford.com>
In-Reply-To: <20260616063606.825688-4-dmukhin@ford.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 18 Jun 2026 14:24:04 +0100
X-Gm-Features: AVVi8Cf0eKUpTPvG-YPXYGf5rmUBe7SxeOoGcBUJdUkikmBIgVBmGziDOTKaEgk
Message-ID: <CAFLszTgV8341B9d3B=7Yf+QqUKbJpyDUJaLYMKoxUKSTc7+vyQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] test: bootdev: scan with a broken high-priority
 device
To: dmukhin@ford.com
Cc: u-boot@lists.denx.de, sjg@chromium.org, trini@konsulko.com
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

Hi Denis,

On 2026-06-16T06:36:03, None <dmukhin@ford.com> wrote:
> test: bootdev: scan with a broken high-priority device
>
> Add bootdev_hunt_fallthrough() test to verify that 'bootflow scan -l'
> falls back to a lower-priority bootdev when a higher-priority hunter
> fails.
>
> Introduce a simple 'sandbox-bootdev' device for the test. The new
> bootdev can be configured to produce an error at the hunting stage.
>
> Signed-off-by: Denis Mukhin <dmukhin@ford.com>
>
> drivers/block/Makefile          |  2 +-
>  drivers/block/host-uclass.c     | 18 ++++++++++++
>  drivers/block/sandbox-bootdev.c | 64 +++++++++++++++++++++++++++++++++++++++++
>  include/sandbox_host.h          | 17 +++++++++++
>  test/boot/bootflow.c            | 51 ++++++++++++++++++++++++++++++++
>  5 files changed, 151 insertions(+), 1 deletion(-)

> diff --git a/drivers/block/host-uclass.c b/drivers/block/host-uclass.c
> @@ -27,6 +27,7 @@ DECLARE_GLOBAL_DATA_PTR;
>  struct host_priv {
>       struct udevice *cur_dev;
> +     unsigned int flags;
>  };

This flags field is never read or written - the flags that matter are
in host_sb_plat::flags, where host_set_flags_by_label() writes them
and sandbox_bootdev_hunt() reads them. Please remove it.

> diff --git a/drivers/block/sandbox-bootdev.c b/drivers/block/sandbox-bootdev.c
> @@ -0,0 +1,64 @@
> +#define LOG_CATEGORY UCLASS_HOST
> +
> +#include <bootdev.h>
> +#include <dm.h>
> +#include <log.h>
> +#include <sandbox_host.h>
> +
> +static int sandbox_bootdev_bind(struct udevice *dev)

LOG_CATEGORY is defined but sandbox_bootdev_hunt() uses pr_debug() and
pr_err(). Please use the log_ family throughout so the category is
honoured.

> diff --git a/drivers/block/sandbox-bootdev.c b/drivers/block/sandbox-bootdev.c
> @@ -0,0 +1,64 @@
> +     uclass_id_foreach_dev(UCLASS_HOST, dev, uc) {
> +             struct host_sb_plat *plat = dev_get_plat(dev);
> +
> +             pr_debug("hunting %s\n", plat->label);
> +
> +             if (plat->flags & BLK_HOST_BROKEN) {
> +                     ret = -ETIME;
> +                     pr_err("cannot hunt sandbox device '%s': %d\n",
> +                            plat->label, ret);
> +                     return ret;
> +             }
> +
> +             return 0;
> +     }

The unconditional return 0 exits on the first HOST device found, so
any further devices are silently ignored. It works for the test since
only one device is created, but is misleading. Please use continue
after a non-broken device, or add a comment explaining the early
return.

Regards,
Simon
