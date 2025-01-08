Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E36E77199
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 17:03:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D88180612;
	Wed,  8 Jan 2025 18:03:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NHNgow0V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EAB58006D; Wed,  8 Jan 2025 18:03:23 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C727C80609
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 18:03:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-aaf60d85238so12809566b.0
 for <u-boot@lists.denx.de>; Wed, 08 Jan 2025 09:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736355800; x=1736960600; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OJzCxFiX0ewai6fAeKslOINOB8mTcgZK1JLK2eM9hO0=;
 b=NHNgow0VxY04IkeoF0mo1zDcCO0UY6DFLU4A1TGjyaCFFqsihx6uc00bBeT5giVdUf
 jEY/bRLLyyuxwDhD4sIzzQa6oQEVPQ3RzNDEFrKfoTfRi3pEk10u5whlYAWcc/mdZJbK
 GsxySrN0gAy/7Wi3BsBGIg+FnZzP3mz7a2JbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736355800; x=1736960600;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OJzCxFiX0ewai6fAeKslOINOB8mTcgZK1JLK2eM9hO0=;
 b=hPyN5gUFbH+siH7iLjRC2E787qgbIe1u+QBM8NUprFQLn96E8PKle2/Khzf7SQuBAi
 l8M+MePp1mnzpFF17jvQeaDodZbM1lAr87DdVc7zfLP7t8nYoNRFsXgjUk+JAIS3wsuw
 LlSNuLARg46XgMzps+enhGZgZ8S0On+CmWvMAYNzjgX7Vh9NTsIncrqaWGbgbLiZur7Z
 W4V1NxndYMQtSb2ugcn5aBEIplkx2KXQMxAK83wqMeDJXCDVqmepBmvMLncwvFe8wqY/
 80shReTzVTnI+aaT9HBP6rNmplLDYbZ6O9HRYL9E5f6G8xv89kOlwdddiS2htDYoilIO
 AOYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjx9Xg5bWinbfFKg0sYR03WTRohQiFRWNggjYKHL6irilOrU4z99fTvL8yFZXetKRk0QZ2wQE=@lists.denx.de
X-Gm-Message-State: AOJu0Yzfl3vfWdypiFhoi2nGDG104rSmQLf2mWlvLOn4863VNx3jkgTF
 ghJp49kNNNmGJwXtgPR2qZ8kCkGCT9mSn3Lvbn1ruteQwhreJVllPmND3E6lK2vU6DzgngTqrf7
 cuWPOPbahGeXgmlauJMdGD9fD3dj9z1fNsAFvuTK+91F7TqM=
X-Gm-Gg: ASbGncuQZN21Ipn688ly/TPyAvcYfXcAjBPIcHzqHajkYvJcay/YVR32oWXijNIYuOT
 aOe4Iqi6u8kmklyucR0lGfp8/HRmDDRegft6XhzY=
X-Google-Smtp-Source: AGHT+IFUeQKTqf5eg0zLx2wEGnlPdOIWOv2aVvy7l7hXXpyuv+5iMOGbXB7dOwTtxnd8sNoeASxMgRQScrk1xIzAEa0=
X-Received: by 2002:a17:907:80c:b0:aab:daf9:972 with SMTP id
 a640c23a62f3a-ab2ab70c9afmr335225266b.28.1736355799941; Wed, 08 Jan 2025
 09:03:19 -0800 (PST)
MIME-Version: 1.0
References: <20250108-get-dram-size-v1-1-4bae32ecf756@per1cycle.org>
 <20250108111105-GYA3276837@gentoo>
 <34F2FA88-E868-45C0-B73B-98BADEF49263@gmx.de>
 <2f6d95b7-da47-4a6c-a566-b73db825410b@stanley.mountain>
In-Reply-To: <2f6d95b7-da47-4a6c-a566-b73db825410b@stanley.mountain>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 8 Jan 2025 10:03:08 -0700
X-Gm-Features: AbW1kvZG5qVMSw9omjnZkxeVZNi7fllsj8HSDxQdX8gmSK2vLpYv22hp-wLW0M8
Message-ID: <CAFLszTg4e8M01fScjjzhKvbG7AzgbTiZ3RgnzTvZN4-WZafPLA@mail.gmail.com>
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

On Wed, 8 Jan 2025 at 05:37, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> On Wed, Jan 08, 2025 at 12:21:18PM +0100, Heinrich Schuchardt wrote:
> > Am 8. Januar 2025 12:11:05 MEZ schrieb Yixun Lan <dlan@gentoo.org>:
> > >Hi Huan:
> > >
> > >On 16:49 Wed 08 Jan     , Huan Zhou wrote:
> > >>
> > >>
> > >..
> > >> ---
> > >remove above "---"? otherwise following commit message will be
> > >dropped during patch application..
> > >
> > >> This patch introduce improvement for get dram size on bananapi BPI-F3,
> > >> retrieving the dram size dynamically.
> > >> Have tested on bananapi BPIF3 4G and jupiter 8G.
> > >>
> > >> Signed-off-by: Huan Zhou <me@per1cycle.org>
> > >> ---
> > >>  arch/riscv/cpu/k1/dram.c | 40 ++++++++++++++++++++++++++++++++++++++--
> > >>  1 file changed, 38 insertions(+), 2 deletions(-)
> > >>
> > >> diff --git a/arch/riscv/cpu/k1/dram.c b/arch/riscv/cpu/k1/dram.c
> > >> index c477c15cbfb19f0e3a0ee72985b602f5bda352d7..095217f2a4c053f7477d62c0776bcb51e623db47 100644
> > >> --- a/arch/riscv/cpu/k1/dram.c
> > >> +++ b/arch/riscv/cpu/k1/dram.c
> > >> @@ -4,17 +4,53 @@
> > >>   */
> > >>
> > >>  #include <asm/global_data.h>
> > >> +#include <asm/io.h>
> > >>  #include <config.h>
> > >> +#include <bitfield.h>
> > >>  #include <fdt_support.h>
> > >>  #include <linux/sizes.h>
> > >>
> > >> +#define DDR_BASE 0xC0000000
> > >>  DECLARE_GLOBAL_DATA_PTR;
> > >>
> > >> +static inline u32 map_format_size(u32 val)
> > >> +{
> > >> +  u32 tmp;
> > >> +
> > >> +  if (val & 0x1 == 0)
> > >please add brackets explicitly, something like
> > >     if ((val & 0x1) == 0)
> >
> > We tend to avoid == 0 in U-Boot
> >
> > if (val & BIT(0))
> >
>
> That's reversed.
>
>         if (!(val & BIT(0)) {
>
> I have really complicated rules about when to use ! vs == 0.
> https://staticthinking.wordpress.com/2024/02/20/when-to-use-0/

I  mostly agree with that and it provides some motivation for the
conventions which have built up over the years in Linux/U-Boot/etc.

If you want to send a patch:

$ git grep 'if (ret != EFI_SUCCESS)' |wc
    864    4841   51380

I think the only place I would differ is with strcmp(), where I've got
used to 0 meaning success, like in much other code.

[..]

Regards,
SImon
