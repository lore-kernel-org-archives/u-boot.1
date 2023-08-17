Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71DD9C2FC27
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 13:41:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D14586B5C;
	Thu, 17 Aug 2023 15:41:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CsLNWG0K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48CD186B68; Thu, 17 Aug 2023 15:41:54 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1AFA86B5E
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 15:41:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-4fe3b86cec1so12169739e87.2
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 06:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692279711; x=1692884511;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4JjTx1p/zg/JcpRVwG9LP6HREHob/MDjMgwV9IFssxY=;
 b=CsLNWG0KpPnMd+uCJGzpHHfAfMZqoXpItyjnXPOLdLyvPJ7i+dpMYpaNDslkt50FKI
 OBv+qIt/0IkA34znKtoSn+/whR1TY4qz+f7+FkeFkQ6+zuhozM2WFaT3aO9NLpFqn6wx
 W5Hv6M/supiwCu9qirv4+oSFlXZu9pvgY6nn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692279711; x=1692884511;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4JjTx1p/zg/JcpRVwG9LP6HREHob/MDjMgwV9IFssxY=;
 b=EDeGqPBKYThnrXl5NNyrGvgnpaWpTVQMHqWDhnXV8EjUbQ+fSPvKGEo7+GZu0qbo01
 hNdVkaDvMn+6mBBBjfZitpOKx8gWrH9+OcX8ypNvRcsvzK/6RqBlNevlYJYzgyEC3wus
 IbUxt9CXur7LMxq1fa7/0CCacRuczq7c4gWOl/+QRKm9DweQB0xn0hpv1/RiuQ0X937Z
 bnQ9Jg6K3mzylv/A3ZmbgTHFPy7BdvtdGoS2i56sHptuS35TiEFSUsd9DHwGFNclG/cD
 H/lyK52d4YMIEFOTV4rx+V1uZ8dE7tMKmgT77EdSzc1BYAeZNewOuMFsnRsPW01s51ta
 Ph7w==
X-Gm-Message-State: AOJu0YwwR4lqtgpn5OHhEZd5YlUP4+FSHeSeYoXIpZ7W/e259r1JgfEb
 BVKgRWBtvvJAzLINB8kr8iTyJtt0EBYodkuYvv5Z6Q==
X-Google-Smtp-Source: AGHT+IFSx+o/f8sMzF3A4J+3qg0tUV6LOHG84I4doZ460ji9HSGS+01C4CxCQXkhmBo1BpRKuT6p9nquGxz+kUS7fx0=
X-Received: by 2002:a05:6512:348f:b0:4fb:7b50:3fc9 with SMTP id
 v15-20020a056512348f00b004fb7b503fc9mr3496027lfr.58.1692279710531; Thu, 17
 Aug 2023 06:41:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230815162623.1824357-1-sughosh.ganu@linaro.org>
 <20230815162623.1824357-3-sughosh.ganu@linaro.org>
 <CAPnjgZ0U7x1FUDNBztecDUFdYDp=3j4kkY0RdWGzPoZ-9WU-Zg@mail.gmail.com>
 <CADg8p96k4S67og6REPt5vF9TruYP+hK+1HcDU_XiauvsF4wXjg@mail.gmail.com>
 <20230816212650.GA1515023@bill-the-cat>
In-Reply-To: <20230816212650.GA1515023@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 17 Aug 2023 07:41:33 -0600
Message-ID: <CAPnjgZ1HBD0quW+_qos5ZjhVeNtZbR9e1hXnUW+71UQGoaT1oA@mail.gmail.com>
Subject: Re: [PATCH 2/5] scripts/Makefile.lib: Embed capsule public key in
 platform's dtb
To: Tom Rini <trini@konsulko.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Takahiro Akashi <takahiro.akashi@linaro.org>
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

On Wed, 16 Aug 2023 at 15:26, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Aug 16, 2023 at 09:58:42AM +0530, Sughosh Ganu wrote:
> > hi Simon,
> >
> > On Wed, 16 Aug 2023 at 00:09, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Sughosh,
> > >
> > > On Tue, 15 Aug 2023 at 10:26, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > >
> > > > The EFI capsule authentication logic in u-boot expects the public key
> > > > in the form of an EFI Signature List(ESL) to be provided as part of
> > > > the platform's dtb. Currently, the embedding of the ESL file into the
> > > > dtb needs to be done manually.
> > > >
> > > > Add a target for generating a dtsi file which contains the signature
> > > > node with the ESL file included as a property under the signature
> > > > node. Include the dtsi file in the dtb. This brings the embedding of
> > > > the ESL in the dtb into the U-Boot build flow.
> > > >
> > > > The path to the ESL file is specified through the
> > > > CONFIG_EFI_CAPSULE_ESL_FILE symbol.
> > > >
> > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > ---
> > > > Changes since RFC series:
> > > > * Remove the default value of the config symbol.
> > > > * s/include_files/dtsi_include_list
> > > > * Add all the dtsi files being included as dependency for the dtb
> > > >   target.
> > > >
> > > >  lib/efi_loader/Kconfig             |  8 ++++++++
> > > >  lib/efi_loader/capsule_esl.dtsi.in | 11 +++++++++++
> > > >  scripts/Makefile.lib               | 18 +++++++++++++++++-
> > > >  3 files changed, 36 insertions(+), 1 deletion(-)
> > > >  create mode 100644 lib/efi_loader/capsule_esl.dtsi.in
> > > >
> > > > diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> > > > index 9989e3f384..d20aaab6db 100644
> > > > --- a/lib/efi_loader/Kconfig
> > > > +++ b/lib/efi_loader/Kconfig
> > > > @@ -272,6 +272,14 @@ config EFI_CAPSULE_MAX
> > > >           Select the max capsule index value used for capsule report
> > > >           variables. This value is used to create CapsuleMax variable.
> > > >
> > > > +config EFI_CAPSULE_ESL_FILE
> > > > +       string "Path to the EFI Signature List File"
> > >
> > > Do we need this, or could we name it as we do with the .env file? It
> > > seems confusing to have to set this for each board - it might be
> > > better to have it in a defined location.
> >
> > The reason I put this is because I thought this gave the user the
> > flexibility to provide the location and name of the ESL. But I suppose
> > that the board directory would be a good location to expect this file.
> > Then this file can have a name like capsule_pub_key,esl. Tom, what are
> > your thoughts on this?
>
> I feel like an automatic name we can guess isn't likely how this will be
> used in the real world, so we should leave this as configurable.

Are we expecting these files to end up in the source tree? Where would they go?

Regards,
Simon
