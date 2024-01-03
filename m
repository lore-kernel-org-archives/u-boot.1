Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 399CEC47073
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 17:01:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C0BC86A81;
	Wed,  3 Jan 2024 18:01:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dK64MMdS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83107877D9; Wed,  3 Jan 2024 18:01:46 +0100 (CET)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B10B186A81
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 18:01:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6d9b050e88cso2530796b3a.0
 for <u-boot@lists.denx.de>; Wed, 03 Jan 2024 09:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704301302; x=1704906102; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0pKdlSW7QSmCgKhNbeEDxT//Y2VIvni3ILKUhM8WmPE=;
 b=dK64MMdSEdMSDdJXuin4PtpMOoa7ACsXJmApU9MumcVx7ZNLUtapbVyonAoxjr8mkD
 oS8FrvQXpaBIT6BtSAUaSfCqzVmDz+1vP4wmweFiEiswSgF6fwnMMMkv03UEqVACq6UU
 006f92pPV2yVzOuIC9OefPTDsXwblC/He6SlzKO3WJscG/VxVsEXwwkcTT8X2Oc+gZDL
 WsRj1Y5KQ2dpp0BPfnaUD1ddBNKKSDxu6rIQMclT3sQvsulvtFQ/cTF5KGf7heAPeAyx
 1f1kM6M7AVq8hO//sTBds5LoPgRU0/xij5HG3jFEaGDBaLuhXdkj4fqEhzlFpXu10vve
 sztA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704301302; x=1704906102;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0pKdlSW7QSmCgKhNbeEDxT//Y2VIvni3ILKUhM8WmPE=;
 b=MXpNBefVzi647ajB32tdlzg7+U+w71TB4CQLOlTIpd5JagZyTrLmX1JFQQEMX9WwbU
 XlsWIPhnpeCZ+mqQ8aHHW/9cXTURKR6h0P5EOj5L6oo3fYz6JDk1+g8fSiZ+JPSTYWXE
 yoayGE+/gtVsU6V9YmVQMe16F9BLHSeNUvAo9XIdHr/cdAmogXcFuGfltCBB49vDcgd1
 B6+D8V61OA8mi422iCHmpyvE+6b0BmyTlTMF9b2AXF8G2GW0Zt0XBtWAS7omdow7DzOk
 fPgHRvEoqjMUox7oI/u7YHu20bFVqVeEabrzP/ohegQFXnKoaCdZwdbKYPuMTA9FTfNF
 kxUg==
X-Gm-Message-State: AOJu0Yyn2clDch3yir6iEEjHkNge37jDKphgObJkaJOzQ2m0U6NE2M7f
 zQziIVxmwtTTZMbyveyeQwfTjQ+4qkJ1QYF+94CXdr9q9fN0Gg==
X-Google-Smtp-Source: AGHT+IF/Zx3nJYRoQJo5Dj5VLXSMLvir3LX1Ihbm1jpICPVJxMz+p/zaLaIfTnUaK2aJj9xk5rV+FSzZrdvVAaMQCbs=
X-Received: by 2002:a05:6a00:2e9b:b0:6da:27f1:b8dd with SMTP id
 fd27-20020a056a002e9b00b006da27f1b8ddmr4805729pfb.0.1704301301964; Wed, 03
 Jan 2024 09:01:41 -0800 (PST)
MIME-Version: 1.0
References: <20240102221237.1007090-1-raymond.mao@linaro.org>
 <20240102221237.1007090-7-raymond.mao@linaro.org>
 <f7cb982f-66f2-47f1-aeb2-f3fa8e8b8912@amd.com>
In-Reply-To: <f7cb982f-66f2-47f1-aeb2-f3fa8e8b8912@amd.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Wed, 3 Jan 2024 12:01:31 -0500
Message-ID: <CAEfUkUL9viRAcWMyjd_=BVVru4hRPV7D9rHhggSBHEEX_D-zDQ@mail.gmail.com>
Subject: Re: [PATCH v4 6/9] arm: Get bloblist from boot arguments
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org, 
 jwerner@chromium.org, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Kevin Chen <kevin_chen@aspeedtech.com>, Sean Anderson <sean.anderson@seco.com>,
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>,
 Devarsh Thakkar <devarsht@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Shiji Yang <yangshiji66@outlook.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Baruch Siach <baruch@tkos.co.il>, Neil Armstrong <neil.armstrong@linaro.org>,
 Stefan Roese <sr@denx.de>
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

Hi Michal,

On Wed, 3 Jan 2024 at 05:46, Michal Simek <michal.simek@amd.com> wrote:

>
>
> On 1/2/24 23:12, Raymond Mao wrote:
> > Add arch custom function to get bloblist from boot arguments.
> > Check whether boot arguments aligns with the register conventions
> > defined in FW Handoff spec v0.9.
> > Add bloblist related options into qemu-arm default config.
> >
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > ---
> > Changes in v2
> > - Remove low level code for copying boot arguments.
> > - Refactor board_fdt_blob_setup() and remove direct access of
> gd->bloblist.
> > Changes in v3
> > - Optimize board_bloblist_from_boot_arg().
> > Changes in v4
> > - Move the function as an Arm-arch library instead of a board-specific
> one.
> >
> >   arch/arm/lib/xferlist.c      | 38 ++++++++++++++++++++++++++++++++++++
> >   configs/qemu_arm64_defconfig |  3 +++
> >   3 files changed, 45 insertions(+)
> >   create mode 100644 arch/arm/lib/xferlist.c
> >
> > diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
> > index b1bcd37466..0023c55d0d 100644
> > --- a/arch/arm/lib/Makefile
> > +++ b/arch/arm/lib/Makefile
> > @@ -85,6 +85,10 @@ obj-y      += psci-dt.o
> >
> >   obj-$(CONFIG_DEBUG_LL)      += debug.o
> >
> > +ifdef CONFIG_BLOBLIST
> > +obj-$(CONFIG_OF_BOARD)  += xferlist.o
> > +endif
> > +
> >   # For EABI conformant tool chains, provide eabi_compat()
> >   ifneq (,$(findstring -mabi=aapcs-linux,$(PLATFORM_CPPFLAGS)))
> >   extra-y     += eabi_compat.o
> > diff --git a/arch/arm/lib/xferlist.c b/arch/arm/lib/xferlist.c
> > new file mode 100644
> > index 0000000000..163d20c11c
> > --- /dev/null
> > +++ b/arch/arm/lib/xferlist.c
> > @@ -0,0 +1,38 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright (C) 2023 Linaro Limited
> > + * Author: Raymond Mao <raymond.mao@linaro.org>
> > + */
> > +#include <linux/types.h>
> > +#include <errno.h>
> > +#include <bloblist.h>
> > +
> > +/*
> > + * Boot parameters saved from start.S
> > + * saved_args[0]: FDT base address
> > + * saved_args[1]: Bloblist signature
> > + * saved_args[2]: must be 0
> > + * saved_args[3]: Bloblist base address
> > + */
> > +extern unsigned long saved_args[];
>
> you should put this to bloblist.h. I would say it should be the part of
> 4/9
> where you define saved_args for armv7.
>
> Not sure if I understand your point but this part is for Arm only (v7 and
v8) and should
not be in bloblist.h. It works following the spec from Arm. Other arches
should implement
their own way if they want to load the bloblist from the previous loader.

[...]

Thanks and regards,
Raymond
