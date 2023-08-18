Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 872F9C05052
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 03:10:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB53486C62;
	Fri, 18 Aug 2023 05:10:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Zg0FwvIf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E59B186BFF; Fri, 18 Aug 2023 05:10:29 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B08BE86C83
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 05:10:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5280ef23593so494960a12.3
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 20:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692328226; x=1692933026;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DWLko8YmmIuuB3KziHP4/+oODlkz3KjSCO6nmrTtlrU=;
 b=Zg0FwvIfkbD0bLTbIFmP6CPk0EY9iO6yUFlWP7n0HTTi71BoOaJJkh6pNKrHUerFEH
 FMDSHESHIHu6yX00xKpO+tAGO0wGi7SjqB/F9gGtMx3bEQeOUAya/tKzvmT6AaX/S17G
 ckLrN1ZTkzGyIfnYA9P9SpfoKza6S8xobFpj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692328226; x=1692933026;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DWLko8YmmIuuB3KziHP4/+oODlkz3KjSCO6nmrTtlrU=;
 b=HMqeEfRZPyjmaKLktGSfwbz6bu5DaIe5Yy3c+btC7LeTqbnt77/s+P/MK9LU/EFcOX
 lajh0pSOh3025jFL3sfY4r+ulUCgKj2TjCezn3yrsnfz2yFpLPmuvXrdEub2Q/2780pZ
 RB/Fd/STwIlrysbr+kKEeOggSOgspu/pPVXIJNJJBbFaEQULDy73mIHN8htYr88TFYwW
 3rEFT5yntgM0fLEX18+U1smOzE+yRFBHCHruS49cBOC130X3YOFzux6XSnO4WgcSomys
 GJdVUPBtBCuHNJ2xaxvZ7UCds8a8bZF97mCr+ktMVcJpPqrTjQThfn1dkGIdxZBsvrCo
 gb7A==
X-Gm-Message-State: AOJu0YywniCSpyUfMRbe+8TtNEb036RjjuGph71TRK46fhRNqmiTw3Uk
 yyrdfPRh1Uj0Lzf18zhog2BOFDQG/pN91/4zCpWwzw==
X-Google-Smtp-Source: AGHT+IHo6q0jnXUhFtcIKWUQeWKi4tfHuvrR+GYaDFUxIM1hsEh/NvaiWi0wygsNhKLugMqkNF/sSTbapQgKTUp1u94=
X-Received: by 2002:a05:6402:38e:b0:523:364b:e6a9 with SMTP id
 o14-20020a056402038e00b00523364be6a9mr1013815edv.38.1692328226208; Thu, 17
 Aug 2023 20:10:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230815162623.1824357-1-sughosh.ganu@linaro.org>
 <20230815162623.1824357-3-sughosh.ganu@linaro.org>
 <CAPnjgZ0U7x1FUDNBztecDUFdYDp=3j4kkY0RdWGzPoZ-9WU-Zg@mail.gmail.com>
 <CADg8p96k4S67og6REPt5vF9TruYP+hK+1HcDU_XiauvsF4wXjg@mail.gmail.com>
 <20230816212650.GA1515023@bill-the-cat>
 <CAPnjgZ1HBD0quW+_qos5ZjhVeNtZbR9e1hXnUW+71UQGoaT1oA@mail.gmail.com>
 <20230817151027.GF1515023@bill-the-cat>
In-Reply-To: <20230817151027.GF1515023@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 17 Aug 2023 21:10:17 -0600
Message-ID: <CAPnjgZ0GN9xO4ZT3t6m1ww45+RnQ=vXdhHBQx_pWVpned5DmZw@mail.gmail.com>
Subject: Re: [PATCH 2/5] scripts/Makefile.lib: Embed capsule public key in
 platform's dtb
To: Tom Rini <trini@konsulko.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Takahiro Akashi <takahiro.akashi@linaro.org>
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

Hi Tom,

On Thu, 17 Aug 2023 at 09:10, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Aug 17, 2023 at 07:41:33AM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Wed, 16 Aug 2023 at 15:26, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Aug 16, 2023 at 09:58:42AM +0530, Sughosh Ganu wrote:
> > > > hi Simon,
> > > >
> > > > On Wed, 16 Aug 2023 at 00:09, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > Hi Sughosh,
> > > > >
> > > > > On Tue, 15 Aug 2023 at 10:26, Sughosh Ganu <
sughosh.ganu@linaro.org> wrote:
> > > > > >
> > > > > > The EFI capsule authentication logic in u-boot expects the
public key
> > > > > > in the form of an EFI Signature List(ESL) to be provided as
part of
> > > > > > the platform's dtb. Currently, the embedding of the ESL file
into the
> > > > > > dtb needs to be done manually.
> > > > > >
> > > > > > Add a target for generating a dtsi file which contains the
signature
> > > > > > node with the ESL file included as a property under the
signature
> > > > > > node. Include the dtsi file in the dtb. This brings the
embedding of
> > > > > > the ESL in the dtb into the U-Boot build flow.
> > > > > >
> > > > > > The path to the ESL file is specified through the
> > > > > > CONFIG_EFI_CAPSULE_ESL_FILE symbol.
> > > > > >
> > > > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > > > ---
> > > > > > Changes since RFC series:
> > > > > > * Remove the default value of the config symbol.
> > > > > > * s/include_files/dtsi_include_list
> > > > > > * Add all the dtsi files being included as dependency for the
dtb
> > > > > >   target.
> > > > > >
> > > > > >  lib/efi_loader/Kconfig             |  8 ++++++++
> > > > > >  lib/efi_loader/capsule_esl.dtsi.in | 11 +++++++++++
> > > > > >  scripts/Makefile.lib               | 18 +++++++++++++++++-
> > > > > >  3 files changed, 36 insertions(+), 1 deletion(-)
> > > > > >  create mode 100644 lib/efi_loader/capsule_esl.dtsi.in
> > > > > >
> > > > > > diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> > > > > > index 9989e3f384..d20aaab6db 100644
> > > > > > --- a/lib/efi_loader/Kconfig
> > > > > > +++ b/lib/efi_loader/Kconfig
> > > > > > @@ -272,6 +272,14 @@ config EFI_CAPSULE_MAX
> > > > > >           Select the max capsule index value used for capsule
report
> > > > > >           variables. This value is used to create CapsuleMax
variable.
> > > > > >
> > > > > > +config EFI_CAPSULE_ESL_FILE
> > > > > > +       string "Path to the EFI Signature List File"
> > > > >
> > > > > Do we need this, or could we name it as we do with the .env file?
It
> > > > > seems confusing to have to set this for each board - it might be
> > > > > better to have it in a defined location.
> > > >
> > > > The reason I put this is because I thought this gave the user the
> > > > flexibility to provide the location and name of the ESL. But I
suppose
> > > > that the board directory would be a good location to expect this
file.
> > > > Then this file can have a name like capsule_pub_key,esl. Tom, what
are
> > > > your thoughts on this?
> > >
> > > I feel like an automatic name we can guess isn't likely how this will
be
> > > used in the real world, so we should leave this as configurable.
> >
> > Are we expecting these files to end up in the source tree? Where would
they go?
>
> Yes, they should be
> board/vendor/common/whatever-vendor-uses-internally.esl or so.  As I
> think I mentioned on IRC, in theory someone like Asus should be using
> the same file here for their rockchip-based tinker board and their x8664
> based motherboards too.  And it's a public key, not a private key.  But
> we still need to ask here because a vendor may care more about
> "security" and so have the key /over/somewhere/else more than
> reproducible builds.

OK.

Regards,
Simon
