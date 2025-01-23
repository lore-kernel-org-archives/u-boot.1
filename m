Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD9BC02182
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 15:55:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 508CA801B0;
	Thu, 23 Jan 2025 16:55:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rGYNVGGQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3112D80214; Thu, 23 Jan 2025 16:55:02 +0100 (CET)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD26380137
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 16:54:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e3983426f80so1710954276.1
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 07:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737647698; x=1738252498; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DFOBMk3zz32iIKWiSVmIg7GiKDD47DN9vQfeYSyVRsQ=;
 b=rGYNVGGQE5CXGZmox8OlV4hr+oQqVAh2xH/XTPZLKMJQQq8w+iMrl454fUXdBv7tj3
 Es2CS26HzxQAU5C11A/dcwhz5myKVUHCcEfTPDEE22/3KchIA9AZDAjJ6aFqFdPNFMCo
 VA283c09iCg4MA42djC31lJxQKBRrdDEM2SqkE2re/yoPPohAvZipqmuOvaGiCdjeqr3
 Dqes4p+Zd/jzsvWRa47HbuMiujDzPNVHzrLo+vMVGSDEbVdQOEyfoeV15UmhFig1AchP
 4nWR8dwxzHRmPGp4iBgE0Ref/ne2NzcEd0ZZT0FpXxuhe01sDZsUm9JgLcqDpOPOrdDX
 vJLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737647698; x=1738252498;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DFOBMk3zz32iIKWiSVmIg7GiKDD47DN9vQfeYSyVRsQ=;
 b=JUii2F3mEa1Y17bHjfJlZRss3M4e3JfFgpQ6+mtA86GUE7rkVQDU8EHrZZ8UR/FB55
 Uszo5T19b2iG5ZeAwJ3zwpyzBLtfkNm1+DyBPWKzfz5i8x+IcwTvcLOag6//xIARnXCs
 UwP7YawhkcdTfR5gkezyyveJEvy0RB0WIhtTOwC2RgnnOTnG3wSov4Ei0ZK69dhhe8t0
 lLN+Qq37Y27rToxkwKB/qjY5ogDQENcLxcS4eIiaDyiD3eCWH5khdZRs334g5alYihFh
 Pjh6yvb9kEMgrw7GfFLvBle3m3AAgwgt2oiZaXJ2MjWMHIiwBydwRqM3UdMyUSI6FKz/
 CnTw==
X-Gm-Message-State: AOJu0Yx8fk2TOaPhH6i1eiBXB8fnuUe/RnE4OeUSb5H8Rbe+kCfHMBOA
 OwjkjclbBD926DA9UKLAnYG0TPo2bV4DrZAcb2b69PcwuhhHVtYxYiyfInfiQWBmQFh4yKaFD2G
 zT6ByTK8fgtXTZoKyi4UzCjlpLNhFXht6nQWv5A==
X-Gm-Gg: ASbGnct8BmgUxtd8p7jzh4yOLX/dmPWCZaP/auOPCYHoTeinFH4E9JdNf3t7Mo7aUnn
 c2hoG/aTZobhFjczBXOsWdodi7KT/ubVfVL2Z/1kmDRqxEHSsthEfOfs/eFGpropbljiwkPoF
X-Google-Smtp-Source: AGHT+IGocvwbTc/ZN3seFhsOj3/ijS5titsyR3Upw+ff3fz/O+vh7IyeJtlpgj/h8UcLzRYD64PxvO/bsCBfScK9CNo=
X-Received: by 2002:a25:69cf:0:b0:e58:5cf:bc52 with SMTP id
 3f1490d57ef6-e5805cfbe89mr6168944276.9.1737647698608; Thu, 23 Jan 2025
 07:54:58 -0800 (PST)
MIME-Version: 1.0
References: <20250117163545.88627-1-raymond.mao@linaro.org>
 <20250117163545.88627-3-raymond.mao@linaro.org>
 <CAC_iWjJ0JO8sB4Q5Gc_5LBByaVmiz6D0sgWjFggqCd9xEX2RLg@mail.gmail.com>
 <CAEfUkUKOqF=yOjqxKszQwY3q_3JOq4jPpRWw0oy19gTheMbL9A@mail.gmail.com>
In-Reply-To: <CAEfUkUKOqF=yOjqxKszQwY3q_3JOq4jPpRWw0oy19gTheMbL9A@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 23 Jan 2025 17:54:22 +0200
X-Gm-Features: AbW1kvZmZ522M07-ZcZ_XYzDK1J9rBe4Jfy9fvg9IKZ2WpmpH853RZmvieLpKeA
Message-ID: <CAC_iWjKKjUgjf5kFmbS6dh717r0F5BNw+h05etgZR7hqdikZwQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] tpm: get tpm event log from bloblist
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Levi Yun <yeoreum.yun@arm.com>, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Eddie James <eajames@linux.ibm.com>, Tim Harvey <tharvey@gateworks.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>
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

On Thu, 23 Jan 2025 at 17:51, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Hi Ilias,
>
> On Thu, 23 Jan 2025 at 02:00, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
>>
>> Hi Raymond
>>
>> On Fri, 17 Jan 2025 at 18:36, Raymond Mao <raymond.mao@linaro.org> wrote:
>> >
>> > Get tpm event log from bloblist instead of FDT when bloblist is
>> > enabled and valid from previous boot stage.
>> >
>> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
>> > ---
>> > Changes in v2
>> > - Remove patch dependency.
>> > - Remove the fallback to FDT when BLOBLIST is selected.
>> > Changes in v3
>> > - Malloc an 8KB buffer when user eventlog buffer does not exist.
>> > Changes in v4
>> > - Replace the default eventlog size with TPM2_EVENT_LOG_SIZE.
>> > Changes in v5
>> > - Replace TPM2_EVENT_LOG_SIZE with CONFIG_TPM2_EVENT_LOG_SIZE.
>> > - Add an inline TODO comment.
>> > Changes in v6
>> > - Remove the malloc and keep the buffer pointed by "sml" for the fallback
>> >   as it is the right place for linux to discover the eventlog.
>> >
>> >  lib/tpm_tcg2.c | 58 +++++++++++++++++++++++++++++++++-----------------
>> >  1 file changed, 38 insertions(+), 20 deletions(-)
>> >
>> > diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
>> > index 4134d93a35..6425bf143a 100644
>> > --- a/lib/tpm_tcg2.c
>> > +++ b/lib/tpm_tcg2.c
>> > @@ -5,6 +5,7 @@
>> >
>> >  #include <dm.h>
>> >  #include <dm/of_access.h>
>> > +#include <malloc.h>
>>
>> This is probably a leftover from your V2
>>
>
> Yes, I will remove it.
>
>>
>> >  #include <tpm_api.h>
>> >  #include <tpm-common.h>
>> >  #include <tpm-v2.h>
>> > @@ -19,6 +20,7 @@
>> >  #include <linux/unaligned/generic.h>
>> >  #include <linux/unaligned/le_byteshift.h>
>> >  #include "tpm-utils.h"
>> > +#include <bloblist.h>
>> >
>> >  int tcg2_get_pcr_info(struct udevice *dev, u32 *supported_bank, u32 *active_bank,
>> >                       u32 *bank_num)
>> > @@ -672,21 +674,40 @@ void tcg2_measurement_term(struct udevice *dev, struct tcg2_event_log *elog,
>> >
>> >  __weak int tcg2_platform_get_log(struct udevice *dev, void **addr, u32 *size)
>> >  {
>> > -       const __be32 *addr_prop;
>> > -       const __be32 *size_prop;
>> > +       const __be32 *addr_prop = NULL;
>> > +       const __be32 *size_prop = NULL;
>> >         int asize;
>> >         int ssize;
>> > +       struct ofnode_phandle_args args;
>> > +       phys_addr_t a;
>> > +       fdt_size_t s;
>> >
>> >         *addr = NULL;
>> >         *size = 0;
>> >
>> > -       addr_prop = dev_read_prop(dev, "tpm_event_log_addr", &asize);
>> > -       if (!addr_prop)
>> > -               addr_prop = dev_read_prop(dev, "linux,sml-base", &asize);
>> > +       *addr = bloblist_get_blob(BLOBLISTT_TPM_EVLOG, size);
>> > +       if (*addr && *size)
>>
>> Don't we need map_physmem here as well?
>>
>
> I don't think so. Unlike the ones from dt, bloblist_get_blob() returns a virtual address.

It can if it runs on sandbox.


>
> Regards,
> Raymond
>
>>
>> Thanks
>> /Ilias
>> > +               return 0;
>> >
>> > -       size_prop = dev_read_prop(dev, "tpm_event_log_size", &ssize);
>> > -       if (!size_prop)
>> > +       /*
>> > +        * TODO:
>> > +        * Replace BLOBLIST with a new kconfig for handoff all components
>> > +        * (fdt, tpm event log, etc...) from previous boot stage via bloblist
>> > +        * mandatorily following Firmware Handoff spec.
>> > +        */
>> > +       if (!CONFIG_IS_ENABLED(BLOBLIST)) {
>> > +               addr_prop = dev_read_prop(dev, "tpm_event_log_addr", &asize);
>> > +               size_prop = dev_read_prop(dev, "tpm_event_log_size", &ssize);
>> > +       }
>> > +
>> > +       /*
>> > +        * If no eventlog was observed, a sml buffer is required for the kernel
>> > +        * to discover the eventlog.
>> > +        */
>> > +       if (!addr_prop || !size_prop) {
>> > +               addr_prop = dev_read_prop(dev, "linux,sml-base", &asize);
>> >                 size_prop = dev_read_prop(dev, "linux,sml-size", &ssize);
>> > +       }
>> >
>> >         if (addr_prop && size_prop) {
>> >                 u64 a = of_read_number(addr_prop, asize / sizeof(__be32));
>> > @@ -694,22 +715,19 @@ __weak int tcg2_platform_get_log(struct udevice *dev, void **addr, u32 *size)
>> >
>> >                 *addr = map_physmem(a, s, MAP_NOCACHE);
>> >                 *size = (u32)s;
>> > -       } else {
>> > -               struct ofnode_phandle_args args;
>> > -               phys_addr_t a;
>> > -               fdt_size_t s;
>> >
>> > -               if (dev_read_phandle_with_args(dev, "memory-region", NULL, 0,
>> > -                                              0, &args))
>> > -                       return -ENODEV;
>> > +               return 0;
>> > +       }
>> > +
>> > +       if (dev_read_phandle_with_args(dev, "memory-region", NULL, 0, 0, &args))
>> > +               return -ENODEV;
>> >
>> > -               a = ofnode_get_addr_size(args.node, "reg", &s);
>> > -               if (a == FDT_ADDR_T_NONE)
>> > -                       return -ENOMEM;
>> > +       a = ofnode_get_addr_size(args.node, "reg", &s);
>> > +       if (a == FDT_ADDR_T_NONE)
>> > +               return -ENOMEM;
>> >
>> > -               *addr = map_physmem(a, s, MAP_NOCACHE);
>> > -               *size = (u32)s;
>> > -       }
>> > +       *addr = map_physmem(a, s, MAP_NOCACHE);
>> > +       *size = (u32)s;
>> >
>> >         return 0;
>> >  }
>> > --
>> > 2.25.1
>> >
