Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AAFEC2BD09
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 11:33:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D93688856B;
	Thu, 27 Jun 2024 13:33:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T+blMQSO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2A9A8859A; Thu, 27 Jun 2024 13:33:19 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E073287AD2
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 13:33:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3627ef1fc07so5635549f8f.3
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 04:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719487997; x=1720092797; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w9U3jNCgeHyjEfiWWxj6p5Yryvf7JQJ6vb6bZlNy9x0=;
 b=T+blMQSOQeuoqItBRUo13OQRzKWv/0wu9GZyOtAgm6crhcFLxT5pFWU1gik4/woz1o
 EOfUWEFTTKvBB979JF2kZxEPRhup7IEwq5dX6g/5z0Y9FH4G/3MFHNJ1LfFG+sW3NdBT
 9phTVq9pPIXAJZsF4f+LCCymq9C/NUrm2ivNVt0tthgwwurwcVdjiwmZWNccq+Aq3W6T
 vrLwk8teKofy3TbpWL3P70Od1abcIvlWcrVxesxiZhBvRU3hZLFY65f8Zr3SsemW06H3
 gNeHWm0Hege2kTkMsLqEpezR7NTNl7NpufeHOu8GhOQZiHUQopygcw1ArQ4sfyP1HK/N
 G+GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719487997; x=1720092797;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w9U3jNCgeHyjEfiWWxj6p5Yryvf7JQJ6vb6bZlNy9x0=;
 b=JPrNzkL0W2jknDiM+Vizc6Wnwpz9GvwAiaUN9d0SEsy795pEAaizOD0BtlV5CBl/Qe
 dKjY9fI3EbcU8Xz8pY9fUEXHeATAl2bVWtxgEwcYu/Aq61HWP1xPPB69qazBhfYDthcU
 UGHTMEyQAIxC72j2eZc3aU3o3064VnDmtcaEkoPC9jUs41RkNy3nwaAks+tdUWVJkqDA
 Cvt85qrVK/dQKzV4qV88U9uuLT1bMDCEBdxIHq3+J6V1QXSIHRNJkZZpHivm1Au0mj/j
 xQL1378XCwDMc2y8X7j9FU4zsUUfXeeAHDzkJR+toPNMuiAINQ5HG8v4bvmLO3wmwgc0
 s2LQ==
X-Gm-Message-State: AOJu0Yy0QZOoZgfhHE50jUIimxWEqz5UYqKhq95lI8zh6BlOxYwqXx75
 CJr3J0S0WF0+YGjtVBcz3CwQGEFUzdnCB5HUbabMfn17VBxOrnS7Sx+bREUCaMLjBbMrv8HW4DU
 iLZPHXJ3cXqB8UOolbQ1LkZGceAg=
X-Google-Smtp-Source: AGHT+IGZIwLt8tJsgOoahan6FvhbXoo8/6grkFTmyfdK5OtIUbqSxfQUwN+mBLxJMrYzvRzFfv3CU7mTTNvLWjjTS04=
X-Received: by 2002:adf:f4d2:0:b0:367:4154:c427 with SMTP id
 ffacd0b85a97d-3674154c48amr1312677f8f.8.1719487996582; Thu, 27 Jun 2024
 04:33:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240522142311.17351-1-seashell11234455@gmail.com>
 <20240522142311.17351-2-seashell11234455@gmail.com>
 <292e66c6-5665-4d0e-8510-5789a7853786@denx.de>
In-Reply-To: <292e66c6-5665-4d0e-8510-5789a7853786@denx.de>
From: Kongyang Liu <seashell11234455@gmail.com>
Date: Thu, 27 Jun 2024 19:33:04 +0800
Message-ID: <CAOKwTdqeppqngwX2PFx7vLtnbv=hbfkL3cmW3nwRNa9psnWtsA@mail.gmail.com>
Subject: Re: [PATCH 1/2] usb: dwc2: Extract USB DWC2 register definitions
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>,
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Simon Glass <sjg@chromium.org>,
 Teik Heng Chong <teik.heng.chong@intel.com>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Marek Vasut <marex@denx.de> =E4=BA=8E2024=E5=B9=B46=E6=9C=8823=E6=97=A5=E5=
=91=A8=E6=97=A5 07:49=E5=86=99=E9=81=93=EF=BC=9A
>
> On 5/22/24 4:22 PM, Kongyang Liu wrote:
>
> Hi,
>
> sorry for the late reply.
>
> > diff --git a/drivers/usb/common/dwc2_core.c b/drivers/usb/common/dwc2_c=
ore.c
> > new file mode 100644
> > index 0000000000..2fa11fd59d
> > --- /dev/null
> > +++ b/drivers/usb/common/dwc2_core.c
> > @@ -0,0 +1,53 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/errno.h>
> > +#include <linux/io.h>
> > +#include <wait_bit.h>
> > +
> > +#include "dwc2_core.h"
> > +
> > +void dwc2_flush_tx_fifo(struct dwc2_core_regs *regs, const int num)
> > +{
> > +     int ret;
> > +
> > +     log_debug("Flush Tx FIFO %d\n", num);
> > +
> > +     /* Wait for AHB master IDLE state */
> > +     ret =3D wait_for_bit_le32(&regs->global_regs.grstctl, GRSTCTL_AHB=
IDLE, true, 1000, false);
>
> Just a quick design point, would it be possible to split this patch into
> two, one which adds this .global_regs and changes the code accordingly,
> and another which does the code refactoring/move ? That would make it
> easier to review.

This patch only extracts the common parts of the host mode and gadget
mode, without any code refactoring. Could you please describe more clearly
how the patch should be split?

Best regards
Kongyang Liu
