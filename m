Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2054D339A1
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 17:02:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3413B89100;
	Mon, 28 Oct 2024 18:02:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="n/lFcAzy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3DB189100; Mon, 28 Oct 2024 18:02:55 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D88089098
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 18:02:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5c9362c26d8so9893514a12.1
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 10:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730134973; x=1730739773; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oLbVqB0BM0SGVnwcUqDXlQagWGOvjoywz1gUvWxTuLo=;
 b=n/lFcAzyxds+AsPL6Sp8ML0qrbOAGH4ogk6S3PjBzt85Ciycm1AXE98sa4YZVkx3nJ
 jZq42UkLRLJClmrGKBN3aUJ2nwKD982Qgd9mi4NINXX9n+MpvwZhfqA+CK6Raw6mytM/
 /VohEj+jDDU6MCfiQ3hhqJAOlkfTA0RpBiGRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730134973; x=1730739773;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oLbVqB0BM0SGVnwcUqDXlQagWGOvjoywz1gUvWxTuLo=;
 b=YTy5OX/rqTxesWjNcJZ4gxmfWrCGLPedvaUO5I4YRKgtBNYbfFaVXIp/vSruCdVWBI
 SpP6DeWnhx+kMmExYGHhthJGc1SURN7jQFWIPyZOq+xHQ5oReErJNWHbZitG21PhYN5N
 xlbSG3TfU0foDaUFA2/0zIern64Y6tXV4WZJlCHeY3OdKsUv4y0+6RA5EFXn0f7xbuK1
 fDyukBjznmWEIbUGE+mAXzgB7mmU2w3b3NmhWBkDfr3xMvb0nXRGa7AcBobhNPuFJ5f8
 ZhIMm8dcUiUlzSsrZcbBwtalEFH5mi0BSwkJqwo87t5QNniIE04P/LMoTqq9vDRKIqpK
 NCyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVENc3FXqCZbbp8H24FPD5lqWXoMlNvhtS7PbqHrBrLwAnGwDOZjOLJqCpujJ3kKThNr6O6uwQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yy2CnYa5IAeAMrUN1KOhfqzs/ljT9p1lX2VrCf/P9cwOrddtaUB
 0qk1DXawpHv+Gvuj9v2D2fx+nqSuvlKtSkgJojiG800wNLrmvBF2iaIbiQPkJ0AGTkKB132oh3c
 +OGFGKty1CILzWRyDkDlPlbtopApQbGzKMMO8
X-Google-Smtp-Source: AGHT+IFSmjiUiLzXNZn2flJxLd7BfRzPPubWI6LxWw7ZtcPi59vSC/658u1kBO7TPWfA1s/LHMvjc+6/gZfmJL/pHaM=
X-Received: by 2002:a17:907:9808:b0:a99:f777:c6ef with SMTP id
 a640c23a62f3a-a9e2273e2f5mr26767366b.3.1730134972731; Mon, 28 Oct 2024
 10:02:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1729577070.git.jan.kiszka@siemens.com>
 <9e440edc2a6bdcb7d768d277dd6afb02ab941ecd.1729577070.git.jan.kiszka@siemens.com>
 <20241025010854.GX4959@bill-the-cat>
 <ff2c2611-e650-40cb-86aa-275a930fcf87@siemens.com>
In-Reply-To: <ff2c2611-e650-40cb-86aa-275a930fcf87@siemens.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Oct 2024 18:02:41 +0100
Message-ID: <CAFLszTg==a87SJaMiceGv4c8eHW0-oY8unmwatBNyJnBH6=3BA@mail.gmail.com>
Subject: Re: [PATCH v2 11/13] smbios: Fill UUID from sysinfo when available
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Bryan Brattlof <bb@ti.com>, Nishanth Menon <nm@ti.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Jan,

On Mon, 28 Oct 2024 at 07:12, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 25.10.24 03:08, Tom Rini wrote:
> > On Tue, Oct 22, 2024 at 08:04:28AM +0200, Jan Kiszka wrote:
> >
> >> From: Jan Kiszka <jan.kiszka@siemens.com>
> >>
> >> Allow for the sysinfo drivers to provide a system UUID to SMBIOS. Will
> >> be first used by the IOT2050 boards.
> >>
> >> Based on original patch by Li Hua Qian.
> >>
> >> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> >> Reviewed-by: Simon Glass <sjg@chromium.org>
> >> ---
> >>  include/sysinfo.h | 1 +
> >>  lib/smbios.c      | 4 ++++
> >>  2 files changed, 5 insertions(+)
> >>
> >> diff --git a/include/sysinfo.h b/include/sysinfo.h
> >> index 8a77ef44856..1c5008b5f23 100644
> >> --- a/include/sysinfo.h
> >> +++ b/include/sysinfo.h
> >> @@ -49,6 +49,7 @@ enum sysinfo_id {
> >>      SYSINFO_ID_SMBIOS_SYSTEM_SERIAL,
> >>      SYSINFO_ID_SMBIOS_SYSTEM_SKU,
> >>      SYSINFO_ID_SMBIOS_SYSTEM_FAMILY,
> >> +    SYSINFO_ID_SMBIOS_SYSTEM_UUID,
> >>      SYSINFO_ID_SMBIOS_BASEBOARD_MANUFACTURER,
> >>      SYSINFO_ID_SMBIOS_BASEBOARD_PRODUCT,
> >>      SYSINFO_ID_SMBIOS_BASEBOARD_VERSION,
> >> diff --git a/lib/smbios.c b/lib/smbios.c
> >> index 7c24ea129eb..1441fa4cde6 100644
> >> --- a/lib/smbios.c
> >> +++ b/lib/smbios.c
> >> @@ -387,6 +387,7 @@ static int smbios_write_type1(ulong *current, int
handle,
> >>      struct smbios_type1 *t;
> >>      int len = sizeof(struct smbios_type1);
> >>      char *serial_str = env_get("serial#");
> >> +    char uuid[sizeof(t->uuid)];
> >>
> >>      t = map_sysmem(*current, len);
> >>      memset(t, 0, sizeof(struct smbios_type1));
> >> @@ -409,6 +410,9 @@ static int smbios_write_type1(ulong *current, int
handle,
> >>
SYSINFO_ID_SMBIOS_SYSTEM_SERIAL,
> >>                                                    NULL);
> >>      }
> >> +    if (!sysinfo_get_str(ctx->dev, SYSINFO_ID_SMBIOS_SYSTEM_UUID,
> >> +                         sizeof(uuid), uuid))
> >> +            strncpy((char *)t->uuid, uuid, sizeof(t->uuid));
> >>      t->wakeup_type = SMBIOS_WAKEUP_TYPE_UNKNOWN;
> >>      t->sku_number = smbios_add_prop_si(ctx, "sku",
> >>                                         SYSINFO_ID_SMBIOS_SYSTEM_SKU,
NULL);
> >
> > This commit leads to sandbox (and sandbox with clang) failing a ton of
> > tests:
> > https://source.denx.de/u-boot/u-boot/-/jobs/929474
> >
> > Without this commit in the series, iot2050 fails to build.
> >
>
> Strange on first sight - we will look into this. As this patch and the
> following 2 are only adding a feature, maybe you could already merge the
> first 10 patches? Would make v3 shorter for us.

I marked the first 10 patches as 'under review'. I'm not sure who is
picking them up, probably Tom.

Regards,
Simon
