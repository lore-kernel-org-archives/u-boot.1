Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43996C8303C
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 09:58:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57B6B801BE;
	Fri, 11 Jul 2025 11:58:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="VHOu7a8/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93BED803DF; Fri, 11 Jul 2025 11:58:22 +0200 (CEST)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BD7D800D7
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 11:58:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-3121aed2435so1909037a91.2
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 02:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1752227899; x=1752832699;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=w+LjffYADvneMCL+g7PByK34P6U1DIIgJ63V7uEL97w=;
 b=VHOu7a8/LP5l5fj/mptSXDWMJIRTtGQYKvcLOOrvsTW1e/r5VxhNVgt15O2itn44WZ
 czMWXfGVDJmLSn+6WAtF/VOfp5dLiIngzt2ch4Wb0+cmDRYB+DFKajzZOG9ApuF8hhUl
 quT7bD76XCf9lX7Ck460oB8wz+5jEcN2Pxf7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752227899; x=1752832699;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w+LjffYADvneMCL+g7PByK34P6U1DIIgJ63V7uEL97w=;
 b=mV++x5CxKZcAYnZm5migAmdbjKnTDUDynIE8FlrbNzzWqFZu0m0MaH0BuI8/ZZEHTE
 1QgCg9Vzz8lE/uTiirWzT3pctPwwBW0Uw5+Nlyy8DKOnZw8xzglrYP5zmQ2svQWk5KDP
 4E8NqPKJFZ7fSOy9QuEY2hrjNAHq0g6rAfCRg30bjMDExtVU1QgtWU27/yloeMQ/1l+r
 t+rbJQtgWBJWW1McRaSG+LZdb+V2Lo5zPvUzMXcw8t/zEG9dB09GEixHYa9rAC1W9uG6
 4GYsOoz+ID0itJlx1vd+w9nblUSH/pxFPEqbMhaGGgsUuV5o7fN+jQS99sdnNGabSa92
 NJeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCULboqBHxfjD2ozdsmGz1UThXOpqM7ubrbXa05mZOHPpz8Jpwrrzd+V/vURhiNTCAialgr7unk=@lists.denx.de
X-Gm-Message-State: AOJu0Yx+WzVUDU5JZaYkNkWMspc7WEDuiaMzPUDAkVdGGBPyxBMsMF8R
 ZsHz31WdQiCqHrpo+Gj3G1ENixfgEpc3RmvRX+kdur67d+UVkIFtRrsim+n5DqWEm6NH31Sy9v+
 DaTTVVc0VkSmsDz3rqVEX2M9KNErMfXTrTrpw3FHh6K8hl3AHCGx/QEc=
X-Gm-Gg: ASbGncvIS95qQsWZU1YYvgIvPjWBRCq8MXs+GIfB4/hFrO49ND3455wMMvzGZ+1Vz9o
 4k7cQbl61A/lRS/17uAOUwsLcdJgOR4qkP4MNlgkU2dmDId8MJOivAVmhPfydEs2yZXSoPWDi+M
 ffXPqU2DKrVEBmMEzZ55W+eTNCClj+lxVYRSEoWpqj3eW2NgxzFdauhnOpQLUXuqCbv/bWHbXmU
 kp2Jg==
X-Google-Smtp-Source: AGHT+IHZZlLpKFNGLQ+JxhmTbj6Uj8VJWIQgC/w8qJr6VUbkxamC49m67w3t++Gzb3OPwD99VIzAdB+TACX9BTtL+Cg=
X-Received: by 2002:a17:90b:5645:b0:313:1e60:584d with SMTP id
 98e67ed59e1d1-31c4ca84addmr4070429a91.11.1752227898647; Fri, 11 Jul 2025
 02:58:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250710171135.669838-1-jm@ti.com>
 <DB94N4OKVW9D.28H05SO50F2D4@ti.com>
In-Reply-To: <DB94N4OKVW9D.28H05SO50F2D4@ti.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Fri, 11 Jul 2025 11:58:08 +0200
X-Gm-Features: Ac12FXytZH-3OTxZgTtOOSU2vZtYT26Qf1CX2QknwmUs0WyxZ7d2VedksgI9B9I
Message-ID: <CAOf5uwnTAwd0Aj8QzzJGtwvWXAfc+rNaAtcrYyUMt2BRHrJ0pQ@mail.gmail.com>
Subject: Re: [PATCH] mach-k3: am62*: am62*_init: Prohibit boot from UDA w/
 eMMC boot
To: Anshul Dalal <anshuld@ti.com>
Cc: Judith Mendez <jm@ti.com>, Tom Rini <trini@konsulko.com>,
 Bryan Brattlof <bb@ti.com>, 
 Andrew Davis <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 U-Boot-Denx <u-boot@lists.denx.de>
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

Hi

Could be html for my mobile. Some comments inline.

Il ven 11 lug 2025, 11:44 Anshul Dalal <anshuld@ti.com> ha scritto:

> On Thu Jul 10, 2025 at 10:41 PM IST, Judith Mendez wrote:
> > This removes support from booting from UDA when in eMMC boot.
> >
> > When user selects eMMC boot [0], that is, boot from eMMC boot0 or
> > boot1 HW partitions, we should not boot from eMMC UDA. The current
> > logic confuses the end user and mixes two different boot modes.
> >
>
> This is correct, we should not be changing the eMMC boot mode based on
> what U-Boot config is enabled.
>
> The end user can always use MMCSD as the backup boot mode if they want
> a fallback.
>
> > The logic was added for AM62A/AM62P with commit: 3b7893145e36, but
> > this is not a clean solution and fix will come later for falcon boot.
> >
> > Logic was also added for AM62X with commit: 664593464634, but this
> > logic is incorrect according to TRM [0] under Primary Boot Mode Selection
> > for 'eMMC Boot'.
> >
> > Fixes: 3b7893145e36 ("mach-k3: add eMMC FS boot support for am62[ap]")
> > Fixes: 664593464634 ("arm: mach-k3: am625: Relax emmc boot condition")
> > Signed-off-by: Judith Mendez <jm@ti.com>
>
> Reviewed-by: Anshul Dalal <anshuld@ti.com>
>

First of all this is not a fix. A fix when you have something that is not
working . Then the commit was having a reason the boot0 and boot1 can have
limited size that does not allow to have all the TI ecosystem on boot
partition and then you must use the the rest of emmc. Booting from this
scenario is totally fine

Michael

>
>
> Thanks for the fix,
> Anshul
>
