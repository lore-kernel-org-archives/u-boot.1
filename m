Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 570D9C71153
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 20:29:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCE198645F;
	Mon, 28 Aug 2023 22:29:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pDiUNpLZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADC6C864A0; Mon, 28 Aug 2023 22:29:30 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9873080569
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 22:29:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2bcc846fed0so55461571fa.2
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 13:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693254567; x=1693859367;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YP4XawLl8+Kexhqs/D4vmhlj1AOWYpt1rw/zaSvlHCI=;
 b=pDiUNpLZMMBRDdvpR5LExkziCokqIRVSZGssPkPO5WDOLrzRWkttit/R5C7cwNwkCM
 H1ZAnOCPIJjWxbKKvAHjPEns2K6jgJ2/Ae2RNcxYqrGlVXqRSMecUDFGkRp8VZzdG683
 zPVGDoLvl+DVTCmn1wKLgfsiSzADjHL9Tq8YVzhHMjacFMBdSTxbNxRqZjB5tEPyIbDW
 NFl/2JlTuHysQyFDak4lRVqk9a2/iuR3talXtZU/LlmSdKJAVSOjNuffREqeviWBrs8s
 mEGoVDbFdzJAKQQdm0sT/om7+ogyJKwO77mimYzVHj2UQNW/7/tC1JpEukc62JKGhxIN
 v2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693254567; x=1693859367;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YP4XawLl8+Kexhqs/D4vmhlj1AOWYpt1rw/zaSvlHCI=;
 b=Nl6JEp12/vp8HlmxrhuPtbU3KFrAO2wgCu/5NMKJV6mSMTn6COchzYCyRDAJkXh10k
 FVn1vnRDpHWXA0jlMe6p7DZwVwZ1MDvO9HhscDYG3e8YFbRqtkw6RIrmshKsNcJXNNvK
 /5UBUMFTlygPySjRXmDVcn66dRNKHPHE4r7YHe7xJ4vLQUb6rYwb/Fj99upLsEv+StR9
 jmKwPGad3CpbAGrR/DBYTt5nBMOWoFgsSvx/FMdZnoaOMj8BtZxdDKkusbSYdrZ8uWvi
 tOciyykoUIqrvjKzVxWdDKW7Qk6f2vAINmGLOcW3SgM25nUFfN8nI/jF2MAkkaz3+tFf
 FBCQ==
X-Gm-Message-State: AOJu0YybjKpOgXajWWbPb8Ov8ITt2b2mSk/XPKaRrE2Hf4yioUrBDaEd
 DdTtz8vB/mUBJ+61lxEJ74zQmm+O17UH3xXFVkw=
X-Google-Smtp-Source: AGHT+IHgtyECrIjJMFFn+pKZUwiJb4FcMkh187v4wAa0Qb8B5tpYeMuvXcP3gYYZnZ5DSkfPUIZqb5ivduHS+D/puwY=
X-Received: by 2002:a2e:3112:0:b0:2b9:f13b:6139 with SMTP id
 x18-20020a2e3112000000b002b9f13b6139mr18685115ljx.20.1693254566599; Mon, 28
 Aug 2023 13:29:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230826090633.239342-1-sughosh.ganu@linaro.org>
 <CAPnjgZ3HVJ9+-PjmHSKwQRgCMkcNPWAcfMkk5SMMgiHAcY0SsQ@mail.gmail.com>
 <CALeDE9MMiA9HVfbeOV3tGqfAAC9oYf9qvizBW0T=hLmqcYD=qw@mail.gmail.com>
 <CAPnjgZ1pgvxhntJvkuAsxKXUVxcWACNTpuDqgonFCrOLr=934Q@mail.gmail.com>
In-Reply-To: <CAPnjgZ1pgvxhntJvkuAsxKXUVxcWACNTpuDqgonFCrOLr=934Q@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 28 Aug 2023 21:29:15 +0100
Message-ID: <CALeDE9ODEwV0Z9APwb1N8QNZFQSB1dkMTMHPW2p2xTLiUZjQ1A@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] Allow for removal of DT nodes and properties
To: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Aug 28, 2023 at 6:54=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Peter,
>
> On Mon, 28 Aug 2023 at 10:37, Peter Robinson <pbrobinson@gmail.com> wrote=
:
> >
> > On Mon, Aug 28, 2023 at 5:20=E2=80=AFPM Simon Glass <sjg@chromium.org> =
wrote:
> > >
> > > Hi,
> > >
> > > On Sat, 26 Aug 2023 at 03:07, Sughosh Ganu <sughosh.ganu@linaro.org> =
wrote:
> > > >
> > > >
> > > > Provide a way for removing certain devicetree nodes and/or properti=
es
> > > > from the devicetree. This is needed to purge certain nodes and
> > > > properties which may be relevant only in U-Boot. Such nodes and
> > > > properties are then removed from the devicetree before it is passed=
 to
> > > > the kernel. This ensures that the devicetree passed to the OS does =
not
> > > > contain any non-compliant nodes and properties.
> > > >
> > > > The removal of the nodes and properties is being done through an
> > > > EVT_FT_FIXUP handler. I am not sure if the removal code needs to be
> > > > behind any Kconfig symbol.
> > > >
> > > > I have only build tested this on sandbox, and tested on qemu arm64
> > > > virt platform. This being a RFC, I have not put this through a CI r=
un.
> > > >
> > > > Sughosh Ganu (5):
> > > >   dt: Provide a way to remove non-compliant nodes and properties
> > > >   fwu: Add the fwu-mdata node for removal from devicetree
> > > >   capsule: Add the capsule-key property for removal from devicetree
> > > >   bootefi: Call the EVT_FT_FIXUP event handler
> > > >   doc: Add a document for non-compliant DT node/property removal
> > > >
> > > >  cmd/bootefi.c                                 | 18 +++++
> > > >  .../devicetree/dt_non_compliant_purge.rst     | 64 +++++++++++++++=
+
> > > >  drivers/fwu-mdata/fwu-mdata-uclass.c          |  5 ++
> > > >  include/dt-structs.h                          | 11 +++
> > > >  lib/Makefile                                  |  1 +
> > > >  lib/dt_purge.c                                | 73 +++++++++++++++=
++++
> > > >  lib/efi_loader/efi_capsule.c                  |  7 ++
> > > >  7 files changed, 179 insertions(+)
> > > >  create mode 100644 doc/develop/devicetree/dt_non_compliant_purge.r=
st
> > > >  create mode 100644 lib/dt_purge.c
> > >
> > > What is the point of removing them? Instead, we should make sure that
> > > we upstream the bindings and encourage SoC vendors to sync them. If w=
e
> > > remove them, no one will bother and U-Boot just becomes a dumping
> > > ground.
> >
> > Well things like the binman entries in DT are U-Boot specific and not
> > useful for HW related descriptions or for Linux or another OS being
> > able to deal with HW so arguably we're already a dumping ground to
> > some degree for not defining hardware.
>
> I have started the process to upstream the binman bindings.

I don't think they should be in DT at all, they don't describe
anything to do with hardware, or generally even the runtime of a
device, they don't even describe the boot/runtime state of the
firmware, they describe build time, so I don't see what that has to do
with device tree? Can you explain that? To me those sorts of things
should live in a build time style config file.

> Perhaps we should use the issue tracker[1] to follow progress on all
> of this. We need to clean it up.
>
> >
> > > Instead of this, how about working on bringing the DT validation into
> > > U-Boot so we can see what state things are in?
> > >
> > > Please send the bindings for Linaro's recent series (which I suspect
> > > are motivating this series) so we can start the process.
>
> Regards,
> Simon
>
> [1] https://source.denx.de/u-boot/u-boot/-/issues
