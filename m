Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82FBBC4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 02:48:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB39287698;
	Thu, 30 Nov 2023 03:46:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Leudqziq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 193138758F; Thu, 30 Nov 2023 03:46:29 +0100 (CET)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDBAC87671
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 03:46:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-db49aa82c89so408199276.1
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 18:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701312382; x=1701917182; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=J4vxWhM1z2DPATjnX9cfF6ymJFBOFC+vMgYRey/SEME=;
 b=LeudqziqoHTIwOGi2mSlBGk6LH9KrW1o0KOvCXieKDqQHx4qbuYQgN2aEHJv0ILqVk
 Q7GXDdo0GMJziBbqxQhTOHszpTtcFPCZAMeEjdoj43nWz9SgW5/1yL3PggHeI6yY1S46
 Dnt/qf3ypWhKEeZAnsFI11m25heLEp0w3bWOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701312382; x=1701917182;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J4vxWhM1z2DPATjnX9cfF6ymJFBOFC+vMgYRey/SEME=;
 b=vaKJDtfa4mnd6IValCIH9jEUgotMtDjwdUFbh8pXKeD57BKUfO86gKhN7k1Bb4tuMF
 JO72x4DSunWUmpL/u5Pvwwe9TX+2et0UvgHQiUKUexk7SU1/aT8VrwQiiW0juy4iBbom
 HYz0iFObs4t88p71q11LX1nbZR6RpJALUQIOzNJDsIDHYWil3AR5V80YON9F7iVVuMo9
 GsnMF728X9zTAGXUPRzemrYo0b714pgT6YHCggaOr/Gx7EyR59HeiQHqPSTR2u328N0T
 CR2OWi1U3ZnwC4dLwBJPO5gqOPFxM16wJnoM/aDMguig6mQiLsSegKWGlVtDBDkyOmB1
 w0kQ==
X-Gm-Message-State: AOJu0Ywo3TE/2fxUqE1yVMogi71pbumz96TlyuyINB50rqlrT2+Z2GwL
 UhMCnWQXdZCY3ACKJhGf1Kl3lS1zFVN8Wk8kBR4IDw==
X-Google-Smtp-Source: AGHT+IE2mXabI9103ArNgApjG7gmlSbHK3JrO+6/LCmqwldWMv5yT5p6qyQlAVwNnt1AIFx3/F4TB1aKCmqxG/+Lnb8=
X-Received: by 2002:a25:aa51:0:b0:db3:fbef:3e37 with SMTP id
 s75-20020a25aa51000000b00db3fbef3e37mr19227348ybi.8.1701312382254; Wed, 29
 Nov 2023 18:46:22 -0800 (PST)
MIME-Version: 1.0
References: <20211020123742.31098-1-andriy.shevchenko@linux.intel.com>
 <3a272671-7c96-4644-a4ee-05257c7efb30@canonical.com>
In-Reply-To: <3a272671-7c96-4644-a4ee-05257c7efb30@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Nov 2023 19:45:43 -0700
Message-ID: <CAPnjgZ3X9hC_n3pqgsDcAuoAfP6yEwQCG0h=PXq-oDj_cwpozQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] Makefile.lib: Always rebuild DSDT
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>, 
 u-boot@lists.denx.de
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

Hi,

On Wed, 29 Nov 2023 at 10:17, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 20.10.21 14:37, Andy Shevchenko wrote:
> > The dsdt.asl is usually combined out of several files that are included
> > in the main one. Whenever we change the content of any of such files,
> > build system is not able to recognize them. Hence the easiest way is to
> > force DSDT rebuild each time we run make.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> The build process that you describe is not in our documentation.
>
> By which defconfig is $(src)/dsdt.asl consumed? Where does it come from?
> Please, provide a reproducible example.
>
> Would you be able to provide a documentation patch explaining how to use
> a user provided dsdt.asl file?
>
> Best regards
>
> Heinrich
>
>
> > ---
> >   scripts/Makefile.lib | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> > index 07696e86bb54..8c3c893b398a 100644
> > --- a/scripts/Makefile.lib
> > +++ b/scripts/Makefile.lib
> > @@ -441,7 +441,7 @@ cmd_acpi_c_asl=         \
> >       iasl -p $@ -tc $(ASL_TMP) $(if $(KBUILD_VERBOSE:1=), >/dev/null) && \
> >       mv $(patsubst %.c,%.hex,$@) $@
> >
> > -$(obj)/dsdt.c:    $(src)/dsdt.asl
> > +$(obj)/dsdt.c:    $(src)/dsdt.asl FORCE
> >       $(call cmd,acpi_c_asl)
> >       $(Q)sed -i -e "s,dsdt_aml_code,AmlCode," $@
> >
>

I agree that this patch is better than having the bug. But yes the
docs could really use some notes here, for the person who does come
along and clean up the dependency bug.

Regards,
Simon
