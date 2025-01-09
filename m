Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1F29E77197
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 12:37:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 767F1800D0;
	Thu,  9 Jan 2025 13:37:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="A+lOikQA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9197F801F5; Thu,  9 Jan 2025 13:37:10 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D80458005B
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 13:37:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-aa67ac42819so133981066b.0
 for <u-boot@lists.denx.de>; Thu, 09 Jan 2025 04:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736426227; x=1737031027; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=D1gY6xY7HTzqFhca+7l+4FSpHoZ2sbuTse6WsZmWBHA=;
 b=A+lOikQA5Q0MYbVKqXpZMCdJACDUxA7Tl4ZI3AdSYSY1EIX9RlkVdnzPTjFDiC8tZx
 YaYD96HNgnaJF53pOoqw0lu8DXk9+ThECm3ThL4o64s6TzhRgj3LOlzXJrdd7GIiwTal
 tdhcZS1YYA80DNCmcDZ8ke8HPuE8PBIyy1StI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736426227; x=1737031027;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D1gY6xY7HTzqFhca+7l+4FSpHoZ2sbuTse6WsZmWBHA=;
 b=EyCi0Ba+Nn45/NEmR/5zX1ewKBce7bTbtKZQfeDKsvVRn+jjFPo1je5+ikJ/lTolik
 6GVmQKp/g2Zm1moygnBNzLzOkbs8OShwZHJlIM9pzkhOqYJkg+P2Jli5oxCdtTXUtDZX
 CYSHvVkxAulcEZobknaDfOink/jdcgzUE8wDaNa3sQd1SX09uUuNes75CtPvCl22+CNk
 aa1NPqyL2UaOXfHwGpPYLbtF3vczyrs5qiAhmg8EjHwlbhrqrrg6Owe3UBn1iHRXLLr0
 m0cTWPYPoFza+twiM0YgCSnZkifq2vGdLRXCjNh0CXIFqtg6N4F9uwzkdgXgLDoEjVre
 0ikA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZEui7rQdGB7O36TwXqBqWVtm6++ZN4KnIAzqTzibKqG6ZdS8yWqQft2jRAWWzCexJH5zDwm8=@lists.denx.de
X-Gm-Message-State: AOJu0YwViTPbXzkeTsMFJajPjlCB6ZLyf4XRfUFK5TFVYP1uwVfA8JaU
 EnJ3AwVQmxPpjdmG9XbmDRhrzbCZKYC/rJcCxUpoQqo3LTasD2k154kJJOnOSfr48uo5X1F0LyD
 RVmEsMYdvhL+rH8BeATQzZ9FWQqjEpjohgKJP
X-Gm-Gg: ASbGncue+J/aXbC3ZpmEsGst+lfj7TU6WmPADO87C2WicdmAMNMxr8o5D1BrIwLDoJt
 zwv+iorR5F8JkKk9cclaMVsRU4xp8K5jgqjq5feE=
X-Google-Smtp-Source: AGHT+IEVFERFw88aaupk6EUqKRMMid1oljowuXcca9pQL3DzPhXxVz4vA0JaQ7ARfmDL5xx1o7kdH9lIrRk3kBoelpg=
X-Received: by 2002:a17:907:1b03:b0:aa6:86d1:c3fe with SMTP id
 a640c23a62f3a-ab2ab6705b8mr638804466b.4.1736426227242; Thu, 09 Jan 2025
 04:37:07 -0800 (PST)
MIME-Version: 1.0
References: <20250108-get-dram-size-v1-1-4bae32ecf756@per1cycle.org>
 <20250108111105-GYA3276837@gentoo>
 <34F2FA88-E868-45C0-B73B-98BADEF49263@gmx.de>
 <2f6d95b7-da47-4a6c-a566-b73db825410b@stanley.mountain>
 <CAFLszTg4e8M01fScjjzhKvbG7AzgbTiZ3RgnzTvZN4-WZafPLA@mail.gmail.com>
 <a6c23382-4406-4306-b544-4117f631a32e@stanley.mountain>
In-Reply-To: <a6c23382-4406-4306-b544-4117f631a32e@stanley.mountain>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 9 Jan 2025 05:36:55 -0700
X-Gm-Features: AbW1kvZMD7xmwBHiuLEEabsMa4Ij7tG8-CRuo_CoNxVz3BxhWODxZPqhJ6yAUPI
Message-ID: <CAFLszTixBt3KwFaOeSVJgM_1zjxdYaatSouGAVGoLFQEEC=TSw@mail.gmail.com>
Subject: Re: [PATCH] riscv: spacemit: k1: probe dram size during boot phase.
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Yixun Lan <dlan@gentoo.org>,
 Huan Zhou <me@per1cycle.org>, 
 u-boot@lists.denx.de, Ben Dooks <ben.dooks@codethink.co.uk>, 
 Marcel Ziswiler <marcel@ziswiler.com>, Bin Meng <bmeng@tinylab.org>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 Kever Yang <kever.yang@rock-chips.com>, Leo <ycliang@andestech.com>, 
 Michal Simek <michal.simek@amd.com>, Nishanth Menon <nm@ti.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Randolph <randolph@andestech.com>, 
 Rick Chen <rick@andestech.com>, Samuel Holland <samuel@sholland.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Yu Chien Peter Lin <peterlin@andestech.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, Kongyang Liu <seashell11234455@gmail.com>, 
 Padmarao Begari <padmarao.begari@amd.com>
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

Hi Dan,

On Wed, 8 Jan 2025 at 10:18, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> On Wed, Jan 08, 2025 at 10:03:08AM -0700, Simon Glass wrote:
> > Hi Dan,
> >
> > On Wed, 8 Jan 2025 at 05:37, Dan Carpenter <dan.carpenter@linaro.org> wrote:
> > >
> > > On Wed, Jan 08, 2025 at 12:21:18PM +0100, Heinrich Schuchardt wrote:
> > > > Am 8. Januar 2025 12:11:05 MEZ schrieb Yixun Lan <dlan@gentoo.org>:
> > > > >Hi Huan:
> > > > >
> > > > >On 16:49 Wed 08 Jan     , Huan Zhou wrote:
> > > > >>
> > > > >>
> > > > >..
> > > > >> ---
> > > > >remove above "---"? otherwise following commit message will be
> > > > >dropped during patch application..
> > > > >
> > > > >> This patch introduce improvement for get dram size on bananapi BPI-F3,
> > > > >> retrieving the dram size dynamically.
> > > > >> Have tested on bananapi BPIF3 4G and jupiter 8G.
> > > > >>
> > > > >> Signed-off-by: Huan Zhou <me@per1cycle.org>
> > > > >> ---
> > > > >>  arch/riscv/cpu/k1/dram.c | 40 ++++++++++++++++++++++++++++++++++++++--
> > > > >>  1 file changed, 38 insertions(+), 2 deletions(-)
> > > > >>
> > > > >> diff --git a/arch/riscv/cpu/k1/dram.c b/arch/riscv/cpu/k1/dram.c
> > > > >> index c477c15cbfb19f0e3a0ee72985b602f5bda352d7..095217f2a4c053f7477d62c0776bcb51e623db47 100644
> > > > >> --- a/arch/riscv/cpu/k1/dram.c
> > > > >> +++ b/arch/riscv/cpu/k1/dram.c
> > > > >> @@ -4,17 +4,53 @@
> > > > >>   */
> > > > >>
> > > > >>  #include <asm/global_data.h>
> > > > >> +#include <asm/io.h>
> > > > >>  #include <config.h>
> > > > >> +#include <bitfield.h>
> > > > >>  #include <fdt_support.h>
> > > > >>  #include <linux/sizes.h>
> > > > >>
> > > > >> +#define DDR_BASE 0xC0000000
> > > > >>  DECLARE_GLOBAL_DATA_PTR;
> > > > >>
> > > > >> +static inline u32 map_format_size(u32 val)
> > > > >> +{
> > > > >> +  u32 tmp;
> > > > >> +
> > > > >> +  if (val & 0x1 == 0)
> > > > >please add brackets explicitly, something like
> > > > >     if ((val & 0x1) == 0)
> > > >
> > > > We tend to avoid == 0 in U-Boot
> > > >
> > > > if (val & BIT(0))
> > > >
> > >
> > > That's reversed.
> > >
> > >         if (!(val & BIT(0)) {
> > >
> > > I have really complicated rules about when to use ! vs == 0.
> > > https://staticthinking.wordpress.com/2024/02/20/when-to-use-0/
> >
> > I  mostly agree with that and it provides some motivation for the
> > conventions which have built up over the years in Linux/U-Boot/etc.
> >
> > If you want to send a patch:
> >
> > $ git grep 'if (ret != EFI_SUCCESS)' |wc
> >     864    4841   51380
> >
> > I think the only place I would differ is with strcmp(), where I've got
> > used to 0 meaning success, like in much other code.
> >
>
> Huh...  I've never thought about it as a success/fail thing.

I have evolved on that one.

>
> I feel like I've seens quite a few reversed strcmp() functions but it's
> hard to catch these sorts of bugs with static analysis because it
> totally depends on the context if you want the strings to be equal or
> not equal.  I can't imagine what a static checker rule would look like.

There's no substitute for tests and naming is hard. We could have a
streq() function which just returns 0 or 1, but it would presumably
have to return 1/true when equal, thus creating confusion with
strcmp(). Perhaps strcheckeq() would be a better name for a function
that returns '0' on success?

Regards,
Simon
