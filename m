Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B65C02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 13:21:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 729CC80F0A;
	Wed,  5 Feb 2025 14:15:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="X+cH9qoK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 819E680207; Wed,  5 Feb 2025 11:32:13 +0100 (CET)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6BBA80040
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 11:32:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-e53c9035003so5781412276.2
 for <u-boot@lists.denx.de>; Wed, 05 Feb 2025 02:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738751529; x=1739356329; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=a/JEHQRvOTu3Ali8aeuj3FRdD0RViJjpZlI2XGJ0Qhk=;
 b=X+cH9qoKaJkS8RJc0m4IyFkyHC0kIvfLu+v5xmc1OPNsuge+eICv+5fYtzFOS3ymiX
 HHDmH9MzlfeKOaQqgvd8VqU8n6DNo9zHmkIchtH34i+WPh4p1mb60B/SWHsYXW5ZZ+HE
 iNuyEA5N518BiIsvgajyHGVxOFFxxXVbhwFGBiBd5BhITGMygQnCSeYVXQ4NPOo7cfl3
 KmQNK+5rCouMPO6SyE/vWT9b8RLL1zsTGDeUytl7/b99a5zaBxxJCyov607NiMs5O8hI
 WSaHYe/ze2Zoa+QmX1iPAEk0rOwYann2Y/69PmUi+XC1KaQsaC5SG47PLbeChvu3AP7F
 jATQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738751529; x=1739356329;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a/JEHQRvOTu3Ali8aeuj3FRdD0RViJjpZlI2XGJ0Qhk=;
 b=pGVlBRX6QpzIq4yU4mwDijXLKfN6mdflykTj0jJNpWig5Wjciji0HNKcFqliR5nJOU
 czbs6N7Pc6ehdEKQPvhuSaaBB//cqWX0g5fHMP+iXqQ+Tf4xUbMrs34Ept0uupGz4Jyp
 HqnWkgpZH+PbRMsrwBUsp/3HOFso3aCZ5aEezcLA8jDpbbdNDItEl8MqC5XbBSfc3lnU
 JrO6WY0bf0YcuaaDDVRWIWQ5nyH+iKpmYUdq/iVc1HVaVIJC8s9JNmcgunKvPkJDwpB6
 LcoUfJ3Qae514ND0JgLQxitLTi975K1zywcxavuTrRiHKvwhH1qfJghkBSg+Wdelcf76
 curw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUF57Ymbg4QynBwk5QLA20MQ5OrblwRFTdciygD44I7IiIGq4T46pD1GNf8Fbbi4ArrhWvgV9k=@lists.denx.de
X-Gm-Message-State: AOJu0YxHRX5UtAiACloeRArgR9hXAMegTvqx4suPgKqYH4i+7Ygxl3wX
 MI5lzgotm0MuQsR/q/5clhqVL+NXDoavodzdC0h7I1eG5WIg36wnMcusbB/vrCkM4iy0a7RuX/l
 pznI+5mFC+jnIac60tGtRKtpFSVeK99VAdpaozA==
X-Gm-Gg: ASbGncsoKT7vGS/41B6syT4QtIzPBlevbwoo+YunyXRv8z5DW3JCToS1wfNf37kLhvz
 Lo47U9zALW9D5sV1sv7lVNM6nyX/zq5T4IyjOiJx6PE825XraJznbBIblWIEST3FNpnaW8eib
X-Google-Smtp-Source: AGHT+IG520p/CArxL11sP2JPeKdFsj3rVdW4W6oBD+sV/fnjXmae5++u0EBZTtboXH+d7bH5WTvh6KXBwQFwovVIT50=
X-Received: by 2002:a05:6902:2505:b0:e58:3741:2748 with SMTP id
 3f1490d57ef6-e5b259cf95amr1757296276.7.1738751529619; Wed, 05 Feb 2025
 02:32:09 -0800 (PST)
MIME-Version: 1.0
References: <20250205071714.635518-1-ilias.apalodimas@linaro.org>
 <20250205071714.635518-7-ilias.apalodimas@linaro.org>
 <ec13d51a-199e-4765-85e2-c74d4c2da8c5@linaro.org>
In-Reply-To: <ec13d51a-199e-4765-85e2-c74d4c2da8c5@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 5 Feb 2025 12:31:33 +0200
X-Gm-Features: AWEUYZm_iTctcy4RVInjAH2nsrg_6qUiILKq8Gw63B-5Qc10o8aKsO9cQDrItIU
Message-ID: <CAC_iWjL4WYhSYLDP_Jgw=MJP6a7D8SRhXH7+NCePfCHMJH+Stw@mail.gmail.com>
Subject: Re: [PATCH v1 6/6] arm64: Enable RW, RX and RO mappings for the
 relocated binary
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: xypron.glpk@gmx.de, trini@konsulko.com, 
 Alexey Brodkin <alexey.brodkin@synopsys.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Huan Wang <alison.wang@nxp.com>, Angelo Dureghello <angelo@kernel-space.org>, 
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, 
 Marek Vasut <marex@denx.de>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Max Filippov <jcmvbkbc@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>, 
 =?UTF-8?Q?Pierre=2DCl=C3=A9ment_Tosi?= <ptosi@google.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, 
 Andre Przywara <andre.przywara@arm.com>, Peter Hoyes <Peter.Hoyes@arm.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, Sam Day <me@samcday.com>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Stefan Roese <sr@denx.de>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Joshua Watt <jpewhacker@gmail.com>, 
 Alex Shumsky <alexthreed@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Christian Marangi <ansuelsmth@gmail.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Jonas Jelonek <jelonek.jonas@gmail.com>, uboot-snps-arc@synopsys.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 05 Feb 2025 14:15:26 +0100
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

Hi Jerome,

On Wed, 5 Feb 2025 at 11:57, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
>
>
> On 2/5/25 08:16, Ilias Apalodimas wrote:
> > Now that we have everything in place switch the page permissions for
> > .rodata, .text and .data just after we relocate everything in top of the
> > RAM.
> >
> > Unfortunately we can't enable this by default, since we have examples of
> > U-Boot crashing due to invalid access. This usually happens because code
> > defines const variables that it later writes. So hide it behind a Kconfig
> > option until we sort it out.
> >
> > It's worth noting that EFI runtime services are not covered by this
> > patch on purpose. Since the OS can call SetVirtualAddressMap which can
> > relocate runtime services, we need to set them to RX initially but remap
> > them as RWX right before ExitBootServices.
> >
> > Link: https://lore.kernel.org/u-boot/20250129-rockchip-pinctrl-const-v1-0-450ccdadfa7e@cherry.de/
> > Link: https://lore.kernel.org/u-boot/20250130133646.2177194-1-andre.przywara@arm.com/
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> >  common/Kconfig   | 13 +++++++++++++
> >  common/board_r.c | 20 ++++++++++++++++++++
> >  2 files changed, 33 insertions(+)
> >
> > diff --git a/common/Kconfig b/common/Kconfig
> > index 7685914fa6fd..dbae7e062b0a 100644
> > --- a/common/Kconfig
> > +++ b/common/Kconfig
> > @@ -914,6 +914,19 @@ config STACKPROTECTOR
> >         Enable stack smash detection through compiler's stack-protector
> >         canary logic
> >
> > +config MMU_PGPROT
> > +     bool "Enable RO, RW and RX mappings"
> > +     help
> > +       U-Boot maps all pages as RWX. If selected pages will
> > +       be marked as RO(.rodata), RX(.text), RW(.data) right after
>
> Space before (

Sure

>
> > +       we relocate. Since code sections needs to be page aligned
> > +       the final binary size will increase.
> > +       The mapping can be dumped using the 'meminfo' command.
>
> OK
>
> > +       We should make this default 'y' in the future, but currently
> > +       we have code defining const variables that are later written.
> > +       Enabling this will crash U-Boot if that code path runs, so keep
> > +       it off by default until we fix invalid accesses.
>
> Not sure this needs to be documented in the Kconfig help. Perhaps just
> keep a patch ready and send it early in the next release cycle for people
> to test and debug?

I'd like people to see it and try to debug when they see random
crashes. I think it's easier if we document that here until things are
fixed.
OTOH i don't really mind whatever people think it's best

>
> > +
> >  config SPL_STACKPROTECTOR
> >       bool "Stack Protector buffer overflow detection for SPL"
> >       depends on STACKPROTECTOR && SPL
> > diff --git a/common/board_r.c b/common/board_r.c
> > index 179259b00de8..c1e9aa46e3fa 100644
> > --- a/common/board_r.c
> > +++ b/common/board_r.c
> > @@ -170,7 +170,27 @@ static int initr_reloc_global_data(void)
> >       efi_save_gd();
> >
> >       efi_runtime_relocate(gd->relocaddr, NULL);
> > +
> >  #endif
> > +     /*
> > +      * We are done with all relocations change the permissions of the binary
> > +      * NOTE: __start_rodata etc are defined in arm64 linker scripts and
> > +      * sections.h. If you want to add support for your platform you need to
> > +      * add the symbols on your linker script, otherwise they will point to
> > +      * random addresses.
> > +      *
> > +      */
> > +     if (IS_ENABLED(CONFIG_MMU_PGPROT)) {
> > +             pgprot_set_attrs((phys_addr_t)(uintptr_t)(__start_rodata),
> > +                              (phys_addr_t)(uintptr_t)(__end_rodata - __start_rodata),
> > +                              MMU_ATTR_RO);
> > +             pgprot_set_attrs((phys_addr_t)(uintptr_t)(__start_data),
> > +                              (phys_addr_t)(uintptr_t)(__end_data - __start_data),
> > +                              MMU_ATTR_RW);
> > +             pgprot_set_attrs((phys_addr_t)(uintptr_t)(__text_start),
> > +                              (phys_addr_t)(uintptr_t)(__text_end - __text_start),
> > +                              MMU_ATTR_RX);
> > +     }
> >
> >       return 0;
> >  }
>
> Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>

Thanks!
/Ilias
>
> Thanks,
> --
> Jerome
