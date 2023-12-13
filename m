Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA112C4167B
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 22:23:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07AAD878D7;
	Wed, 13 Dec 2023 23:22:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HblYtgP/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78FD1878BA; Wed, 13 Dec 2023 23:22:39 +0100 (CET)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 621E7878C8
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 23:22:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-50bffb64178so8853812e87.2
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 14:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702506154; x=1703110954; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bJxANkKDXj/vRGYZJqNndzM3DfkpKfhY4NqXlA/3fdM=;
 b=HblYtgP/ja1zSFVcEawp/3KZKBCk/3EA9hCP99nzr4Evj6+NmhjS217fI8nrzABojK
 hIwgJ3K3GBvlmSGCmoAyyKtWnFL3LsUaKgTb+0J6iRY55+Lj3Way2ejfNqEr4KTfQb46
 pja+tBIQUXchuBP6POdVQWXY263ESdXKbmwvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702506154; x=1703110954;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bJxANkKDXj/vRGYZJqNndzM3DfkpKfhY4NqXlA/3fdM=;
 b=Vokki/drNJTNxXmMRWjXDdXyh8cIy7fsY73aN97skFnk7W35UejlCjFoPX2f2VlFxz
 5ojcF/J1XVo61vC7Pg/NUC1sKyO16A4OQXhreQ3it1/XrCtE5y22mi90P1dZuP40tUBV
 BkUE86HG7bSwkngBKn8IvXpXWSl+BwGZzkruWFFRN4gdO7uhZ+NN1RJokZ4zP73cdeaB
 2AVHIiAnlbtiYAKtGYtE/Q5pDFe9J43zC1F8XOEsDs3gzpMzTvFBtWQH89QoOjipSSkF
 TLRhyRr8BCEFlr75Mz9aqCElzeDGHovEu2+brpzSVacdy6Wed51sQFxHG7XkwvtiRIy4
 QuHw==
X-Gm-Message-State: AOJu0YzTbMEc7adgy4q6C8UujC+NXL3WlZ8CNsGxEIc87u1TjjYwjeVh
 8h7ua1Zv/epRcRyAhDP7jv/xIh60M1FUuozbYJQfrg==
X-Google-Smtp-Source: AGHT+IEvGSDkhrPXWF8PKoMHiiiHM0V1q/VM7d49jUFEvqhD9tKNdl1mCUIS+x9iYBRLVGg0wL0tcrxL39E6hCSc1OM=
X-Received: by 2002:ac2:4119:0:b0:50b:fe11:bf7c with SMTP id
 b25-20020ac24119000000b0050bfe11bf7cmr3495969lfi.18.1702506154390; Wed, 13
 Dec 2023 14:22:34 -0800 (PST)
MIME-Version: 1.0
References: <20231202153400.537050-1-sjg@chromium.org>
 <20231202153400.537050-2-sjg@chromium.org>
 <20231209154839.GG2513409@bill-the-cat>
 <CAPnjgZ0TxjEf-CvN_jC-c_7yVMb473YAjy-GH=Zrj6wwb4fqFA@mail.gmail.com>
 <20231213204250.GJ2513409@bill-the-cat>
 <CAPnjgZ0qK5J=Q3xPK6K5BhXi2jpSYBchSR8n7mHEi15ekLn1Hg@mail.gmail.com>
 <20231213205948.GL2513409@bill-the-cat>
In-Reply-To: <20231213205948.GL2513409@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 13 Dec 2023 15:22:22 -0700
Message-ID: <CAPnjgZ2Q67peHhjq2KFVYJSknkJ23pj5FSg-ODJvoSPwNu7u=A@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] cyclic: Add a symbol for SPL
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Anatolij Gustschin <agust@denx.de>, Bin Meng <bmeng@tinylab.org>,
 Devarsh Thakkar <devarsht@ti.com>, 
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Harald Seiler <hws@denx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Nikhil M Jain <n-jain1@ti.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sean Anderson <sean.anderson@seco.com>, 
 Stefan Roese <sr@denx.de>, Troy Kisky <troykiskyboundary@gmail.com>
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

On Wed, 13 Dec 2023 at 13:59, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Dec 13, 2023 at 01:51:00PM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Wed, 13 Dec 2023 at 13:42, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Dec 13, 2023 at 12:50:02PM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Sat, 9 Dec 2023 at 08:48, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Sat, Dec 02, 2023 at 08:33:48AM -0700, Simon Glass wrote:
> > > > >
> > > > > > The cyclic subsystem is currently enabled either in all build phases
> > > > > > or none. For tools this should not be enabled, but since lib/shc256.c
> > > > > > and other files include watchdog.h in the host build, we must make
> > > > > > sure that it is not enabled there.
> > > > >
> > > > > This part is what I see as the Wrong Direction. There's some code we
> > > > > really need to share with our user space tools, in order to not
> > > > > copy/paste the same code. In turn, this code must be as user-space
> > > > > friendly as possible. Maybe even we re-factor things a little more, if
> > > > > needed, so that we _just_ have the library functions in common files,
> > > > > and u-boot or user space only files have the make use of logic. I don't
> > > > > feel bad about tools/ needing:
> > > > > void sha256_csum_wd(const unsigned char *input, unsigned int ilen,
> > > > >                 unsigned char *output, unsigned int chunk_sz)
> > > > > {
> > > > >         sha256_context ctx;
> > > > >         sha256_starts(&ctx);
> > > > >         sha256_update(&ctx, input, ilen);
> > > > >         sha256_finish(&ctx, output);
> > > > > }
> > > > >
> > > > > (and so on for other algos) as a duplicate bit of code. Much less so
> > > > > than I do about adding <linux/kconfig.h> to a direct include list (since
> > > > > we should never be doing that) so that later on we can if
> > > > > (IS_ENABLED(..)) the existing code.
> > > >
> > > > Bear in mind that we have the CONFIG_TOOLS_... options entirely to
> > > > deal with the need for tools to enable features in common code. This
> > > > SHA thing is a very small part of the code, compared to common code in
> > > > boot/ for example.
> > > >
> > > > So is this really a win?
> > >
> > > I don't follow you here, sorry.
> >
> > I mean that we share a lot of code already, code which contains CONFIG
> > options. So does it matter avoiding adding one more?
>
> It's adding <linux/kconfig.h> to files, we must not do that. And we
> don't need to if we don't have <watchdog.h> (and that in turn,
> cyclic.h) included outside of USE_HOSTCC :)

$ git grep kconfig.h
.azure-pipelines.yml:                  :^include/linux/kconfig.h
:^tools/ && exit 1 || exit 0
.gitlab-ci.yml:        :^include/linux/kconfig.h :^tools/ && exit 1 || exit 0
Makefile:       -include $(srctree)/include/linux/kconfig.h
Makefile:                       -include linux/kconfig.h -include
include/config.h \
arch/arm/include/asm/arch-fsl-layerscape/config.h:#include <linux/kconfig.h>
arch/arm/mach-rockchip/tpl.c:#include <linux/kconfig.h>
arch/arm/mach-sunxi/dram_sun50i_h6.c:#include <linux/kconfig.h>
arch/arm/mach-sunxi/dram_sun50i_h616.c:#include <linux/kconfig.h>
arch/arm/mach-sunxi/dram_sunxi_dw.c:#include <linux/kconfig.h>
boot/image-fit.c:#include <linux/kconfig.h>
boot/image.c:#include <linux/kconfig.h>

These are the sorts of ones which are a real pain to remove.

common/hash.c:#include <linux/kconfig.h>
drivers/timer/dw-apb-timer.c:#include <linux/kconfig.h>
env/embedded.c:#include <linux/kconfig.h>
include/bootstage.h:#include <linux/kconfig.h>
include/configs/at91-sama5_common.h:#include <linux/kconfig.h>
include/configs/tqma6.h:#include <linux/kconfig.h>
include/env_internal.h:#include <linux/kconfig.h>
include/hash.h:#include <linux/kconfig.h>
include/image.h:#include <linux/kconfig.h>
include/u-boot/ecdsa.h:#include <linux/kconfig.h>
lib/rsa/rsa-verify.c:#include <linux/kconfig.h>
scripts/Makefile.autoconf:              -include
$(srctree)/include/linux/kconfig.h
scripts/Makefile.autoconf:      echo \#include \<linux/kconfig.h\>;
                         \
test/dm/scmi.c:#include <linux/kconfig.h>
test/lib/kconfig.c: * Test of linux/kconfig.h macros
test/lib/kconfig_spl.c: * Test of linux/kconfig.h macros for SPL
tools/binman/test/blob_syms.c:#include <linux/kconfig.h>
tools/binman/test/u_boot_binman_syms.c:#include <linux/kconfig.h>
tools/binman/test/u_boot_binman_syms_size.c:#include <linux/kconfig.h>
tools/env/fw_env_private.h:#include <linux/kconfig.h>
tools/envcrc.c:#include <linux/kconfig.h>
tools/mkeficapsule.c:#include <linux/kconfig.h>
tools/printinitialenv.c:#include <linux/kconfig.h>

I don't really mind what we do with sha, and it seems I am a bit too
rabid on the anti-#ifdef thing compared to others.

Regards,
Simon
