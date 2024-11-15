Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38BFED65C7E
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 14:21:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8B02896C1;
	Fri, 15 Nov 2024 15:20:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="L4hcabMF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 460BA896B9; Fri, 15 Nov 2024 15:20:58 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6FD289348
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 15:20:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-53da353eb2eso3364602e87.3
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 06:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731680455; x=1732285255; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cPGakgMMNWuEAI3NRfrQfZzlvrEiY1Eqb4sfj+QggMg=;
 b=L4hcabMFmY8C/Ukh5/LqzOYZ9/uuM7SGD6IeNfnZD+ZeYWqemUxvZ2Lqfv9EOzugzn
 sd0n0j7xBB2MCJE57bLWS+wmyI87TryWHIxe54aamR+DPdOap/KDLKUGn1R6loB0n3Pz
 bhkoiHF0LLpHyOHlAzPNJkQwe/C0ZoOzfFyqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731680455; x=1732285255;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cPGakgMMNWuEAI3NRfrQfZzlvrEiY1Eqb4sfj+QggMg=;
 b=QsjTQvrXV05/2af0/SWecRJrVPOy5F+LNgopOavOfnfRR7NtBL1NfqyCy1FDJxXto7
 xjBIGyHo1xajSrXYnJSsY65Es+rcrMYJN69yGkJ/E1oF7eiHK+QgO0sWGg7+oDLZVt6C
 e710QA4Uj1gDYHPIWpaKYiHi2Z8z+vigRg6HN2AAEAQHJDkNOzsaZ41s0hJO/ePDwWyo
 6bt+gttm/yRGsemT6pUjCxlJdgFK8SMHBubaSP9v56XHbcJXybgSNw7z9PYAMuu9q7io
 9j2+SLbZgcLA2LUA0s32G4pwm63H9hv5MLZtFyhgWSCB9PnBJf9X0+N9RSU+sEBDZgCm
 76Xg==
X-Gm-Message-State: AOJu0Yy1h3S5PJiZRGF/OfP4Sw+eEfOWQqFUUt2pwDqyZTRsxvT4+THk
 F+O8jdbHXJ+EjaWn//OgRsyyvOvgu50cYMOYfM0uDHwA5DWmQCFzih5SmLbo1WngqOVeOJ26SWe
 YoUFUXUCdC8/BmnDcN+9kyikhH47PKpYlBsj5
X-Google-Smtp-Source: AGHT+IHDr5d22/upq+PTniOLAG8terg5SHOdqlQ/5ETBZZMhOMIIA3hcDeaPp6FY8hW2aIkmszUONk41CtuK3KAjSZ8=
X-Received: by 2002:a05:6512:2391:b0:53d:a6c8:fb95 with SMTP id
 2adb3069b0e04-53dab29efffmr2074319e87.19.1731680455092; Fri, 15 Nov 2024
 06:20:55 -0800 (PST)
MIME-Version: 1.0
References: <20241106153544.1277835-1-sjg@chromium.org>
 <87efb07d6eb10e7c7ad45e8bee741f485931f8de.camel@phytec.de>
In-Reply-To: <87efb07d6eb10e7c7ad45e8bee741f485931f8de.camel@phytec.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 Nov 2024 07:20:40 -0700
Message-ID: <CAFLszTiqjD3GYP_A--+KGVpyNs9gF=3APkrrwCcqoJo+-3DqEw@mail.gmail.com>
Subject: Re: [PATCH v2] Makefile: Fake external blob with
 BINMAN_ALLOW_MISSING=1
To: Yannic Moog <Y.Moog@phytec.de>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "bb@ti.com" <bb@ti.com>, 
 "trini@konsulko.com" <trini@konsulko.com>,
 "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>, 
 "leon@georgemail.eu" <leon@georgemail.eu>, "marex@denx.de" <marex@denx.de>, 
 "sumit.garg@linaro.org" <sumit.garg@linaro.org>,
 "masahiroy@kernel.org" <masahiroy@kernel.org>
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

Hi Yannic,

On Thu, 14 Nov 2024 at 00:51, Yannic Moog <Y.Moog@phytec.de> wrote:
>
> Hi Simon,
>
> On Wed, 2024-11-06 at 08:35 -0700, Simon Glass wrote:
> > This flag was lost by a previous change and has never been restored.
> > Without it, binman cannot fully handle missing blobs which are
> > themselves inputs to mkimage.
> >
> > Discussion on this at [1] indicated that this was necessary but the
> > patch was not updated.
> >
> > Restore the flag so that all missing blobs are reported.
> >
> > Link: https://patchwork.ozlabs.org/project/uboot/patch/20221206020336.315465-1-trini@konsulko.com/
>
> sorry I'm picking this up so late;
> As I am working on OP-TEE addition to imx8m boards [1], this patch got my interest.
> I applied the patch on top of my patchstack and tried to build (phycore-imx8mp) with missing tee.bin
> binary and got unexpected results:
>
>
> Image 'image' has faked external blobs and is non-functional: tee.bin
>
> Image 'image' is missing optional external blobs but is still functional: tee-os
>
> /binman/section/fit/images/tee/tee-os (tee.bin):
>    See the documentation for your board. You may need to build Open Portable
>    Trusted Execution Environment (OP-TEE) and build with TEE=/path/to/tee.bin
>
> Some images are invalid
>
>
> So build fails even though tee.bin is marked as optional.
> Did I miss another patch that must be used in conjunction with this one?
>
> Before this patch, I see the following output.
>
>
> Image 'image' is missing optional external blobs but is still functional: tee-os
>
> /binman/section/fit/images/tee/tee-os (tee.bin):
>    See the documentation for your board. You may need to build Open Portable
>    Trusted Execution Environment (OP-TEE) and build with TEE=/path/to/tee.bin
>
>
> With successful build.

The previous behaviour was a bug, at least that's what I concluded. It
was ignored sections within sections, in some cases.

Do you have tee in there twice? It seems strange to get this case.

If you can't figure it out, can you send patches or share a tree?

>
> Yannic
>
> [1] https://lore.kernel.org/u-boot/20241107-phytec_imx8m_optee-v2-0-bbc3747a60e8@phytec.de
>
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Fixes: 93685d0dcb9 ("Makefile: With BINMAN_ALLOW_MISSING=1 don't error")
> > ---
> >
> > Changes in v2:
> > - Use Link: and avoid a line break
> >
> >  Makefile | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 7275a02f24c..f92f46b3ab7 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1398,7 +1398,8 @@ cmd_binman = $(srctree)/tools/binman/binman $(if $(BINMAN_DEBUG),-D) \
> >                  --toolpath $(objtree)/tools \
> >               $(if $(BINMAN_VERBOSE),-v$(BINMAN_VERBOSE)) \
> >               build -u -d u-boot.dtb -O . -m \
> > -             --allow-missing $(if $(BINMAN_ALLOW_MISSING),--ignore-missing) \
> > +             --allow-missing --fake-ext-blobs \
> > +             $(if $(BINMAN_ALLOW_MISSING),--ignore-missing) \
> >               -I . -I $(srctree) -I $(srctree)/board/$(BOARDDIR) \
> >               $(foreach f,$(of_list_dirs),-I $(f)) -a of-list=$(of_list) \
> >               $(foreach f,$(BINMAN_INDIRS),-I $(f)) \
>

Regards,
Simon
