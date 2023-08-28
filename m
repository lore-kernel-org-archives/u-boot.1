Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C76EC83F12
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 22:10:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84F51864F5;
	Tue, 29 Aug 2023 00:10:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Mb1e8Gew";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D312D864F3; Tue, 29 Aug 2023 00:10:06 +0200 (CEST)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8D8E864D7
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 00:10:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-d7acd3be014so2253086276.3
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 15:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693260597; x=1693865397;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sQt7eEg0XoI/3+Co98gOhaYSkd/7x+HmJxLubX9QwWs=;
 b=Mb1e8GewK0geEblslPu/yp8psmU+GFmo7PW+ZRahYhcxn3Ew7yY9WS6YkGVgSaSy9w
 GCKg6UiJPn8zq9aiucuP5KhMFRb/lW9Ej8cnLMXDl0kjWT7DxFdKpIPkFFh3UJBSXKE+
 DWCmAv7b2U44NHuKsRQ9AYQlJEXuzeRmLelfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693260597; x=1693865397;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sQt7eEg0XoI/3+Co98gOhaYSkd/7x+HmJxLubX9QwWs=;
 b=NHalM9Aim79Yb9nPV0wTk/KI2yXjztPzAx1AqdYbxd5PxJLORqvwU9w2Gc03bTTS8g
 a5KQSaVISA+coTZ1sT4+ida4f/0iSm6kPmVQF8xX54jihRmGhbIArupIwrADPRm/LnlV
 lfyJiUuQlik+ZE7ml6OGG5jbngCbO0gAdyHk8z7mHRyJzhALxg3p0OkWoyGd6VJEvUfI
 +KSt4YP1I0y/YyUAv3PGbS1HH8HpqcqOdYBiVxuyeJWag6xpdvydInaWX1lK1kzwvnZ2
 aM3wesaTH+xygyAh7bKzoPNuTiqIjfWLSo4WmkvvIkrvV8EviTis6ID4ahtsoPbqgxhE
 FmtQ==
X-Gm-Message-State: AOJu0YxCf05h8fhjiIqF6p1HtCKyeizK8VWV5UIZOBR5Hgpki+gPWPDQ
 03kmfVCWIy/TB6+XzW6kVvy3CiplGAAKj4Dtc/uc3w==
X-Google-Smtp-Source: AGHT+IErmeVckOH0P9V5B6qFgD1k/o3Mf6Zr32wNunHj2/T5Je24SPtERtOxEzBwwq+7uiR2Dc4+AxODNL1UVOCvxjk=
X-Received: by 2002:a25:db09:0:b0:d7b:3917:4609 with SMTP id
 g9-20020a25db09000000b00d7b39174609mr2677817ybf.19.1693260597161; Mon, 28 Aug
 2023 15:09:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230826090633.239342-1-sughosh.ganu@linaro.org>
 <CAPnjgZ3HVJ9+-PjmHSKwQRgCMkcNPWAcfMkk5SMMgiHAcY0SsQ@mail.gmail.com>
 <CALeDE9MMiA9HVfbeOV3tGqfAAC9oYf9qvizBW0T=hLmqcYD=qw@mail.gmail.com>
 <CAPnjgZ1pgvxhntJvkuAsxKXUVxcWACNTpuDqgonFCrOLr=934Q@mail.gmail.com>
 <CALeDE9ODEwV0Z9APwb1N8QNZFQSB1dkMTMHPW2p2xTLiUZjQ1A@mail.gmail.com>
In-Reply-To: <CALeDE9ODEwV0Z9APwb1N8QNZFQSB1dkMTMHPW2p2xTLiUZjQ1A@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Aug 2023 16:09:29 -0600
Message-ID: <CAPnjgZ1FiqjjxjL+Ve-s5WEafksOZsSP3XyW4xYdjyP-U_TZzQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] Allow for removal of DT nodes and properties
To: Peter Robinson <pbrobinson@gmail.com>
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

Hi Peter,

On Mon, 28 Aug 2023 at 14:29, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> On Mon, Aug 28, 2023 at 6:54=E2=80=AFPM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Hi Peter,
> >
> > On Mon, 28 Aug 2023 at 10:37, Peter Robinson <pbrobinson@gmail.com> wro=
te:
> > >
> > > On Mon, Aug 28, 2023 at 5:20=E2=80=AFPM Simon Glass <sjg@chromium.org=
> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Sat, 26 Aug 2023 at 03:07, Sughosh Ganu <sughosh.ganu@linaro.org=
> wrote:
> > > > >
> > > > >
> > > > > Provide a way for removing certain devicetree nodes and/or proper=
ties
> > > > > from the devicetree. This is needed to purge certain nodes and
> > > > > properties which may be relevant only in U-Boot. Such nodes and
> > > > > properties are then removed from the devicetree before it is pass=
ed to
> > > > > the kernel. This ensures that the devicetree passed to the OS doe=
s not
> > > > > contain any non-compliant nodes and properties.
> > > > >
> > > > > The removal of the nodes and properties is being done through an
> > > > > EVT_FT_FIXUP handler. I am not sure if the removal code needs to =
be
> > > > > behind any Kconfig symbol.
> > > > >
> > > > > I have only build tested this on sandbox, and tested on qemu arm6=
4
> > > > > virt platform. This being a RFC, I have not put this through a CI=
 run.
> > > > >
> > > > > Sughosh Ganu (5):
> > > > >   dt: Provide a way to remove non-compliant nodes and properties
> > > > >   fwu: Add the fwu-mdata node for removal from devicetree
> > > > >   capsule: Add the capsule-key property for removal from devicetr=
ee
> > > > >   bootefi: Call the EVT_FT_FIXUP event handler
> > > > >   doc: Add a document for non-compliant DT node/property removal
> > > > >
> > > > >  cmd/bootefi.c                                 | 18 +++++
> > > > >  .../devicetree/dt_non_compliant_purge.rst     | 64 +++++++++++++=
+++
> > > > >  drivers/fwu-mdata/fwu-mdata-uclass.c          |  5 ++
> > > > >  include/dt-structs.h                          | 11 +++
> > > > >  lib/Makefile                                  |  1 +
> > > > >  lib/dt_purge.c                                | 73 +++++++++++++=
++++++
> > > > >  lib/efi_loader/efi_capsule.c                  |  7 ++
> > > > >  7 files changed, 179 insertions(+)
> > > > >  create mode 100644 doc/develop/devicetree/dt_non_compliant_purge=
.rst
> > > > >  create mode 100644 lib/dt_purge.c
> > > >
> > > > What is the point of removing them? Instead, we should make sure th=
at
> > > > we upstream the bindings and encourage SoC vendors to sync them. If=
 we
> > > > remove them, no one will bother and U-Boot just becomes a dumping
> > > > ground.
> > >
> > > Well things like the binman entries in DT are U-Boot specific and not
> > > useful for HW related descriptions or for Linux or another OS being
> > > able to deal with HW so arguably we're already a dumping ground to
> > > some degree for not defining hardware.
> >
> > I have started the process to upstream the binman bindings.
>
> I don't think they should be in DT at all, they don't describe
> anything to do with hardware, or generally even the runtime of a
> device, they don't even describe the boot/runtime state of the
> firmware, they describe build time, so I don't see what that has to do
> with device tree? Can you explain that? To me those sorts of things
> should live in a build time style config file.

I beg to differ. Devicetree is more than just hardware and always has
been. See, for example the /chosen and /options nodes.

We need run-time configuration here, since we cannot know at build
time what we will be asked to do by a previous firmware phase.

>
> > Perhaps we should use the issue tracker[1] to follow progress on all
> > of this. We need to clean it up.
> >
> > >
> > > > Instead of this, how about working on bringing the DT validation in=
to
> > > > U-Boot so we can see what state things are in?
> > > >
> > > > Please send the bindings for Linaro's recent series (which I suspec=
t
> > > > are motivating this series) so we can start the process.
> >
> > Regards,
> > Simon
> >
> > [1] https://source.denx.de/u-boot/u-boot/-/issues

Regards,
Simon
