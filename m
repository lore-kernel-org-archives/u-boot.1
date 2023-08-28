Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E831C83F11
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 16:38:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D72F86430;
	Mon, 28 Aug 2023 18:38:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JoEixGGy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10B858645D; Mon, 28 Aug 2023 18:38:00 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6319C805C9
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 18:37:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2b9d07a8d84so49981281fa.3
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 09:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693240677; x=1693845477;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=knIQ+iuaZeD3yJnVTp8WdzAEgv323RLDx6PsWU5kfP0=;
 b=JoEixGGy9J1fiAkNDiL/PnIgZoiREmiMqXMYdDCgcFhr+dFnFlboXRXlXDEp3j/4pg
 oZtF39ZKIQ3v5swU1UQ0MBWK4KP7UTtyrDS/E4yi1JB4GtVaSTPo4k56M7HWesurNOhA
 N1mUNIfdXsIumJ0GYlBA2E+01egGqmAWC/WYqp3U/7fbLuexetpO2tH/RkQI9a316Phn
 gb2BlwYWozhv46mZa9PDRRDUVxh4ldrnKO/kDLwAlx107e3ZXMOebLaOMtAthE3OJlpu
 xaiqiI/4J5ZGyJxpQxDdwVYCQLkBAIlQKZ5r2VNKsxn3t27wZYXEdMYFHXwTGzzx6eqH
 cqPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693240677; x=1693845477;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=knIQ+iuaZeD3yJnVTp8WdzAEgv323RLDx6PsWU5kfP0=;
 b=S2rOuF7gdDYudg9M+7VNzfGf3dIufSP6DxwNfZ2TgDdzBu4EqUuYrhQVMurSxyyrvS
 lEMjJS7YOeC3wCSH8+YrSiGtgN4kg6Suc9vka2bL+FR3GH4DSbtdlVigKGdy3WsKeM/3
 cMePNPQcKFc4vXx0dqTIJlnkoUCHMuRLoZQ3LjFdBeBSjnw61zAgYfTLO2ITRgYzefAL
 wy8eenUQBDSd5VLrBusv/thVn99MM3fh5y0D05V/RnRe1Y3Ndy8mKDbcqfRgsABNF4Ub
 5VEQwN6THBNi9uGGnuQvJ4Q20AtF4Mf7OuaIvd2zZ8tTF+Vka86qXHTXKtw01gCripls
 ybRw==
X-Gm-Message-State: AOJu0Yy7sOKlOYmJieT9J9sleZIBJbRBU/I/7ummbYKS7MOJjQ6JoJPP
 wuNIobJzXoToCn72KqgU4k77dkzMUB0VMIiu4bQvYCUL
X-Google-Smtp-Source: AGHT+IFfVJ1offimJo7GQCOQrq1mtXjGxWj/UWpGRDV0mePbfFZ9UROsdJZMRll3A7NhmVhpre3tj0007oPL8CMLl/o=
X-Received: by 2002:a2e:7202:0:b0:2bc:e961:a383 with SMTP id
 n2-20020a2e7202000000b002bce961a383mr8003859ljc.52.1693240676391; Mon, 28 Aug
 2023 09:37:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230826090633.239342-1-sughosh.ganu@linaro.org>
 <CAPnjgZ3HVJ9+-PjmHSKwQRgCMkcNPWAcfMkk5SMMgiHAcY0SsQ@mail.gmail.com>
In-Reply-To: <CAPnjgZ3HVJ9+-PjmHSKwQRgCMkcNPWAcfMkk5SMMgiHAcY0SsQ@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 28 Aug 2023 17:37:45 +0100
Message-ID: <CALeDE9MMiA9HVfbeOV3tGqfAAC9oYf9qvizBW0T=hLmqcYD=qw@mail.gmail.com>
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

On Mon, Aug 28, 2023 at 5:20=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi,
>
> On Sat, 26 Aug 2023 at 03:07, Sughosh Ganu <sughosh.ganu@linaro.org> wrot=
e:
> >
> >
> > Provide a way for removing certain devicetree nodes and/or properties
> > from the devicetree. This is needed to purge certain nodes and
> > properties which may be relevant only in U-Boot. Such nodes and
> > properties are then removed from the devicetree before it is passed to
> > the kernel. This ensures that the devicetree passed to the OS does not
> > contain any non-compliant nodes and properties.
> >
> > The removal of the nodes and properties is being done through an
> > EVT_FT_FIXUP handler. I am not sure if the removal code needs to be
> > behind any Kconfig symbol.
> >
> > I have only build tested this on sandbox, and tested on qemu arm64
> > virt platform. This being a RFC, I have not put this through a CI run.
> >
> > Sughosh Ganu (5):
> >   dt: Provide a way to remove non-compliant nodes and properties
> >   fwu: Add the fwu-mdata node for removal from devicetree
> >   capsule: Add the capsule-key property for removal from devicetree
> >   bootefi: Call the EVT_FT_FIXUP event handler
> >   doc: Add a document for non-compliant DT node/property removal
> >
> >  cmd/bootefi.c                                 | 18 +++++
> >  .../devicetree/dt_non_compliant_purge.rst     | 64 ++++++++++++++++
> >  drivers/fwu-mdata/fwu-mdata-uclass.c          |  5 ++
> >  include/dt-structs.h                          | 11 +++
> >  lib/Makefile                                  |  1 +
> >  lib/dt_purge.c                                | 73 +++++++++++++++++++
> >  lib/efi_loader/efi_capsule.c                  |  7 ++
> >  7 files changed, 179 insertions(+)
> >  create mode 100644 doc/develop/devicetree/dt_non_compliant_purge.rst
> >  create mode 100644 lib/dt_purge.c
>
> What is the point of removing them? Instead, we should make sure that
> we upstream the bindings and encourage SoC vendors to sync them. If we
> remove them, no one will bother and U-Boot just becomes a dumping
> ground.

Well things like the binman entries in DT are U-Boot specific and not
useful for HW related descriptions or for Linux or another OS being
able to deal with HW so arguably we're already a dumping ground to
some degree for not defining hardware.

> Instead of this, how about working on bringing the DT validation into
> U-Boot so we can see what state things are in?
>
> Please send the bindings for Linaro's recent series (which I suspect
> are motivating this series) so we can start the process.
>
> Regards,
> Simon
