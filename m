Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DAB2C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 11:34:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89BB981CFD;
	Fri, 28 Mar 2025 12:34:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mvb1VlVp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B6A9805C8; Fri, 28 Mar 2025 12:34:11 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BE8C81CFD
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 12:34:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-ac2bb7ca40bso396688966b.3
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 04:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743161649; x=1743766449; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jZ07rwXNeCeYrERBKjxsJ5PxAc+Ooa+IlZjdZtiFQfI=;
 b=mvb1VlVp47TQKzXf6juZwzBRHq65dew6kfyISejwO1I8itGkLdP6Vx9BNW1JXBiMXP
 Ir7MElx4ULj2AkBdq5mJ1pqaG8fJkgOQcE5cmrzzRBnRPhrWjaMfAaPnlZlkzbExzXss
 49sGcybfsrEfZ7qmVRN+5s3pxurnciUNV2LtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743161649; x=1743766449;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jZ07rwXNeCeYrERBKjxsJ5PxAc+Ooa+IlZjdZtiFQfI=;
 b=GjhQUm7y6VnaBDqOrOwPjj5VAoMIpCfZI9B8IAGFgjNsrCrvF7wk5f36CA5AMW9lDu
 YHRzUoLAMEwFBhUBI+QqqJCJOimbZvu7epadZKfWzSSVejU0/LqI581A+s8Eacdb4IUV
 kCzhVZobx2fmDpLKAhs5RZFqGKeRRKcY2d9uF6wUB73QPy9JTKk3md8ZmO6k4aemzHZ5
 tJ3Fs/bGrpkSTK58JCUSs/ttt6sOuG9j3kGAlIC9eBfTrihSXJw+T0MqHFpgY+RQsQb0
 CQue7FeIQzlzLQ1W1GF1DCfiYEeL8Q6M/vRssmT8V9DYfG7R8WFhto0CJxfVRVM5nFQS
 Zdew==
X-Gm-Message-State: AOJu0Yx4hIx9rtccg3hgr6RBO65iCOUiHY1Z10qn3Y0RQ6ywYf0nuEgV
 2kLzhR1+aucg3TYFZEdn1S5mIIWUTyKsxf4QFBSRnG4IJDbINvXO6dm1n6veKpC+uO3Q8kKC3ag
 u7jIP22dCJqF5y9z5LOxOo13c/dIWfGWKWnIc
X-Gm-Gg: ASbGncsjA/2pDxEDdZhqoo+nKu+vuC7cLkkhLh5fKtOgWDT5xEOp2mqUqCO8io6G/pR
 j/UKtuTUltAk3xNwXTch1ZEUPm9V7/jXjDBkp2xjrpwxf8r1n3aRpfBQ+6lKu2tcj/QHRjO5kwm
 png3WpRamMpl2Qq/GD+vtSPdVGyPM=
X-Google-Smtp-Source: AGHT+IGcSSZ8qMi6FqAgb7hvH7yie6gIOnFawhSIGuakA5uYTa901Eqr52+UBflKXD7pStMbyQf7lVMSi9ZGfROXzxw=
X-Received: by 2002:a17:907:7044:b0:ac7:18e3:1b16 with SMTP id
 a640c23a62f3a-ac718e31c2emr278236166b.20.1743161648827; Fri, 28 Mar 2025
 04:34:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250215032254.4121030-1-sjg@chromium.org>
 <20250215032254.4121030-15-sjg@chromium.org>
 <63f9cecc-4889-4fbf-b0ca-9db28c356a6c@linaro.org>
In-Reply-To: <63f9cecc-4889-4fbf-b0ca-9db28c356a6c@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 28 Mar 2025 05:33:55 -0600
X-Gm-Features: AQ5f1JpSbo-r2yGRmUaRxGQbg3dg_5K-PgifVOZuzchpYt3W1y0ntaNy4WLnazQ
Message-ID: <CAFLszTgTq3O5yRV==Fbp3x=oPsmj=j-9qtnx8uq9VhizayFHVQ@mail.gmail.com>
Subject: Re: [PATCH v4 14/29] efi: arm: Don't do the EL2 switch when running
 under EFI
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Albert Aribaud <albert.u.boot@aribaud.net>, Janne Grunau <j@jannau.net>,
 Tom Rini <trini@konsulko.com>
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

Hi Caleb,

On Thu, 27 Mar 2025 at 10:28, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
>
>
> On 2/15/25 04:22, Simon Glass wrote:
> > The previous bootloader has likely done this already, so avoid trying to
> > do it again. This fixes a crash in QEMU when booting from EDK2
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
>
> ll_boot_init is a pretty unintuitive name tbh. skip_lowlevel_init()
> might be clearer?

The ll_boot_init() name has been there for ages. I didn't use
lowlevel_init as that symbols is widely used in ARM and it would be
too confusion. Perhaps bare_metal() ?

>
> off-topic, but how is EBS called?

Assuming that Linux is booted as an EFI app, by Linux. Otherwise, the
app currently doesn't work properly.

>
> Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> > ---
> >
> > (no changes since v1)
> >
> >   arch/arm/lib/bootm.c | 7 +++++--
> >   1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/lib/bootm.c b/arch/arm/lib/bootm.c
> > index 974cbfe8400..688c2f3f29b 100644
> > --- a/arch/arm/lib/bootm.c
> > +++ b/arch/arm/lib/bootm.c
> > @@ -16,6 +16,7 @@
> >   #include <command.h>
> >   #include <cpu_func.h>
> >   #include <dm.h>
> > +#include <init.h>
> >   #include <log.h>
> >   #include <asm/global_data.h>
> >   #include <dm/root.h>
> > @@ -186,8 +187,10 @@ __weak void setup_board_tags(struct tag **in_params) {}
> >   #ifdef CONFIG_ARM64
> >   static void do_nonsec_virt_switch(void)
> >   {
> > -     smp_kick_all_cpus();
> > -     dcache_disable();       /* flush cache before swtiching to EL2 */
> > +     if (ll_boot_init()) {
> > +             smp_kick_all_cpus();
> > +             dcache_disable();       /* flush cache before swtiching to EL2 */
> > +     }
> >   }
> >   #endif
> >
>
> --
> Caleb (they/them)
>

Regards,
Simon
