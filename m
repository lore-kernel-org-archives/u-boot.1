Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01514C61D85
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 02:17:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D652E875EC;
	Tue, 21 Nov 2023 03:17:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hBREzjRo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1D9C875E9; Tue, 21 Nov 2023 03:16:55 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6815D8641F
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 03:16:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-5cb76e7f7daso3495007b3.3
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 18:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700533008; x=1701137808; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=X/oryuKiLjLGzAHEBdm2ktl0k4IQqZPePWi+F17twfQ=;
 b=hBREzjRoXKjYfQPayGQWPtKXAGr/vEuVzlhQfECZrOVBv5L5xvlLlmCiuofccXkyfV
 DrvCIC7YxRIUQfrIULbxesEaFzyhk+gMyCACvDy4gzBov5PdsPadVeiN5+YuDZcbTJUT
 c5Bj3yzXMR6K9Q46UyUuHsUBMwnpX0259cOcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700533008; x=1701137808;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X/oryuKiLjLGzAHEBdm2ktl0k4IQqZPePWi+F17twfQ=;
 b=lOh0tvKH68ivBHudVuxZIl/CKC9JeWVK9M+THya78Ebs1UxfO51v67vgBqLHEw2fL/
 K4l5L23uc0McMgyvoWo8QwHvT2i/+Gm3g9sZv+6+iliZES4JvATTCgg/22INs2ZjHd+B
 GB8HMA9OebVjXc3VutTYthS7S6OVUy5iksrm1HqwJCqLt9wC8B1zXWGLSGzlq1netDbq
 qxksdRfGWkQeoQsd0OVzh22t5ve/TV0IdY+jmImtukKOCSA3tYK/DCXctNViIZgylZJJ
 ew/lXKL/7vff2DMzWyLn6kHE5nCH2u6azN/0rGHrN/c8UWuneb9SE/7hJnWi29xT5Ken
 AJZw==
X-Gm-Message-State: AOJu0YyEY2xJahxLaDlydJ3p65lWNSW9oO9WFz5RdXJrp/64BkcRgUiB
 8JOuo3G7tA7jPkuLNyadusaZae/P5XKE4OvA5i8AQw==
X-Google-Smtp-Source: AGHT+IGbfyTw0KRyYr43puFj+vgXKb9HyZjiGZIUjLPlRdAY2nNm/ZdTJgSWyQo/1ZTHf+tNYwrw0rar3iVyDOwlKP0=
X-Received: by 2002:a81:ad23:0:b0:5cb:6301:d4d0 with SMTP id
 l35-20020a81ad23000000b005cb6301d4d0mr1565041ywh.2.1700533008199; Mon, 20 Nov
 2023 18:16:48 -0800 (PST)
MIME-Version: 1.0
References: <20231117223829.346652-1-afd@ti.com>
 <20231117223829.346652-2-afd@ti.com>
 <20231117224044.GD170968@bill-the-cat>
 <5fc3cee0-5b79-4cd2-a153-94b25c37e5f8@ti.com>
 <20231120152649.GI2513409@bill-the-cat>
In-Reply-To: <20231120152649.GI2513409@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 20 Nov 2023 19:16:03 -0700
Message-ID: <CAPnjgZ0XLdpXxjGMr58i6gBU3KPw7qpKTu2jQp9jMLrSVG4dhw@mail.gmail.com>
Subject: Re: [PATCH 2/3] configs: keystone2: Do not include hardware.h
To: Tom Rini <trini@konsulko.com>
Cc: Andrew Davis <afd@ti.com>, u-boot@lists.denx.de
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

Hi Tom,

On Mon, 20 Nov 2023 at 08:26, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Nov 20, 2023 at 08:49:32AM -0600, Andrew Davis wrote:
> > On 11/17/23 4:40 PM, Tom Rini wrote:
> > > On Fri, Nov 17, 2023 at 04:38:28PM -0600, Andrew Davis wrote:
> > >
> > > > This is a hacky way to have this file included in all source files that
> > > > include common.h, instead just include from the files that need it.
> > > >
> > > > Signed-off-by: Andrew Davis <afd@ti.com>
> > > > ---
> > > >   drivers/memory/ti-aemif.c            | 1 +
> > > >   drivers/soc/ti/keystone_serdes.c     | 1 +
> > > >   include/configs/ti_armv7_keystone2.h | 1 -
> > > >   3 files changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/memory/ti-aemif.c b/drivers/memory/ti-aemif.c
> > > > index c4bc88c1510..41325eb0f94 100644
> > > > --- a/drivers/memory/ti-aemif.c
> > > > +++ b/drivers/memory/ti-aemif.c
> > > > @@ -7,6 +7,7 @@
> > > >    */
> > > >   #include <common.h>
> > > > +#include <asm/arch/hardware.h>
> > > >   #include <asm/ti-common/ti-aemif.h>
> > > >   #define AEMIF_WAITCYCLE_CONFIG          (KS2_AEMIF_CNTRL_BASE + 0x4)
> > > > diff --git a/drivers/soc/ti/keystone_serdes.c b/drivers/soc/ti/keystone_serdes.c
> > > > index 2ece1a8f647..0e1bf8ff39d 100644
> > > > --- a/drivers/soc/ti/keystone_serdes.c
> > > > +++ b/drivers/soc/ti/keystone_serdes.c
> > > > @@ -8,6 +8,7 @@
> > > >   #include <errno.h>
> > > >   #include <common.h>
> > > > +#include <asm/io.h>
> > > >   #include <asm/ti-common/keystone_serdes.h>
> > > >   #include <linux/bitops.h>
> > >
> > > Is there going to be a follow-up to remove common.h from these files
> > > then? Thanks.
> >
> > Yes I can take a look at that next.
> >
> > Wasn't there some automation around this? Dropping headers from common.h
> > one at a time until it disappears IIRC.
>
> Simon has posted a python tool he wrote that partially did this, but I
> wasn't quite happy with the results at the time. It might work out
> better now, or on top of the series I posted to remove it from include/

My tool inserts #includes based on the symbols referenced in a file.
For example, reference to strcpy() or memcmp() would result in the
script adding '#include <linux/string.h>' to the top of the file.

I still believe this is a reasonable approach. My original series to
handle this was posted at [1] over 3 years ago. It foundered in part
due to the number of files it touched, but I still believe the
principle of 'include what you use' makes sense in U-Boot.

Other problems are that in a few cases it results in some ugly code,
or misordering of includes

On the plus side, it gets us past this problem. We shouldn't make
perfect an enemy of good and I am disappointed that we are still
trying to get this over the line.

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/list/?series=193754&state=*
