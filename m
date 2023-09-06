Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA76EE14A1
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 14:59:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 360E18698E;
	Wed,  6 Sep 2023 16:59:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JY7zrJaQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EB0A869B1; Wed,  6 Sep 2023 16:59:27 +0200 (CEST)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF191865A0
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 16:59:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2ba1e9b1fa9so62138651fa.3
 for <u-boot@lists.denx.de>; Wed, 06 Sep 2023 07:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694012364; x=1694617164; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q1LrNb7QHBKIA9255KZLxhSuzD8G/WX1zHSr42ebP+o=;
 b=JY7zrJaQwuaKYb9acRxMgPeS8aeYEeZidOvjizM2jaELdqYl7kL+VWCpmQEcbfEOOn
 v3rVkLSYdBrR6+FIjUK02EpIosVvyk36qSh7HWxsDb7f6xzzHoJpD8YczFcC7eMiNiFD
 gHq94Rybwh5oMN1yYikg5QySnM8kjJR1ifN7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694012364; x=1694617164;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q1LrNb7QHBKIA9255KZLxhSuzD8G/WX1zHSr42ebP+o=;
 b=HF2GejDYt9/EJ7dNA+j2L6oV7ro3vSjtegsDrQxYWl8iaLIolAN2sKTm60lAife5hI
 Cz6w4KEn8NIzMoURTTf87lV5CG+NRdZY1DufscB32Qy9bqDQdLuxpuXNInVf9tiLryy2
 hRtG7KbwM5UEBwupmtPvBK5uFDZgR/BEih6ksmUBLU6tE8xMbe1/5rEM9pM0bJyQBRjx
 iSf9TXlO91GPYlgY3/RvAm2XnRisbPUZoV+UcEmv/XTL4JCMt/lI5IOuHgfazH9CTali
 oTj9Qlf3Wf4b6WeIx/rq23rIdyjUvmhWDPmLdg++Q3BNFgmWLajQptMZXj1F4HV/cCqb
 Lkcw==
X-Gm-Message-State: AOJu0Yz45XxcqWCnjjlXVq2KfsjkitqU0uUUgoQxWeN4R7g93Hd1QO/d
 +d0SuEXBjbiPXNoWEvBtkgRX0Rowu/SgHi8F8PWGpA==
X-Google-Smtp-Source: AGHT+IEu/VIdkx5UcahGSsIer3DtrhPYRAHAY6j+nASJfp+Ys/kHE2iyV2RMZbp8mfnramRWs6oPKbSU4SsISKs1RXk=
X-Received: by 2002:a2e:2c19:0:b0:2bc:c28c:a2b5 with SMTP id
 s25-20020a2e2c19000000b002bcc28ca2b5mr2397185ljs.51.1694012363624; Wed, 06
 Sep 2023 07:59:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230826090633.239342-1-sughosh.ganu@linaro.org>
 <CAPnjgZ3HVJ9+-PjmHSKwQRgCMkcNPWAcfMkk5SMMgiHAcY0SsQ@mail.gmail.com>
 <CALeDE9MMiA9HVfbeOV3tGqfAAC9oYf9qvizBW0T=hLmqcYD=qw@mail.gmail.com>
 <CAPnjgZ1pgvxhntJvkuAsxKXUVxcWACNTpuDqgonFCrOLr=934Q@mail.gmail.com>
 <CALeDE9ODEwV0Z9APwb1N8QNZFQSB1dkMTMHPW2p2xTLiUZjQ1A@mail.gmail.com>
 <CAPnjgZ1FiqjjxjL+Ve-s5WEafksOZsSP3XyW4xYdjyP-U_TZzQ@mail.gmail.com>
 <20230906142139.GA1236014-robh@kernel.org>
In-Reply-To: <20230906142139.GA1236014-robh@kernel.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 6 Sep 2023 08:59:11 -0600
Message-ID: <CAPnjgZ1wyoH2i1Ez1s+qQv6ViEYQ-6YkLtcLZaQJvTAyCGPiFw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] Allow for removal of DT nodes and properties
To: Rob Herring <robh@kernel.org>
Cc: Peter Robinson <pbrobinson@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de, 
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

Hi Rob,

On Wed, 6 Sept 2023 at 08:21, Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Aug 28, 2023 at 04:09:29PM -0600, Simon Glass wrote:
> > Hi Peter,
> >
> > On Mon, 28 Aug 2023 at 14:29, Peter Robinson <pbrobinson@gmail.com> wro=
te:
> > >
> > > On Mon, Aug 28, 2023 at 6:54=E2=80=AFPM Simon Glass <sjg@chromium.org=
> wrote:
> > > >
> > > > Hi Peter,
> > > >
> > > > On Mon, 28 Aug 2023 at 10:37, Peter Robinson <pbrobinson@gmail.com>=
 wrote:
> > > > >
> > > > > On Mon, Aug 28, 2023 at 5:20=E2=80=AFPM Simon Glass <sjg@chromium=
.org> wrote:
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > On Sat, 26 Aug 2023 at 03:07, Sughosh Ganu <sughosh.ganu@linaro=
.org> wrote:
> > > > > > >
> > > > > > >
> > > > > > > Provide a way for removing certain devicetree nodes and/or pr=
operties
> > > > > > > from the devicetree. This is needed to purge certain nodes an=
d
> > > > > > > properties which may be relevant only in U-Boot. Such nodes a=
nd
> > > > > > > properties are then removed from the devicetree before it is =
passed to
> > > > > > > the kernel. This ensures that the devicetree passed to the OS=
 does not
> > > > > > > contain any non-compliant nodes and properties.
> > > > > > >
> > > > > > > The removal of the nodes and properties is being done through=
 an
> > > > > > > EVT_FT_FIXUP handler. I am not sure if the removal code needs=
 to be
> > > > > > > behind any Kconfig symbol.
> > > > > > >
> > > > > > > I have only build tested this on sandbox, and tested on qemu =
arm64
> > > > > > > virt platform. This being a RFC, I have not put this through =
a CI run.
> > > > > > >
> > > > > > > Sughosh Ganu (5):
> > > > > > >   dt: Provide a way to remove non-compliant nodes and propert=
ies
> > > > > > >   fwu: Add the fwu-mdata node for removal from devicetree
> > > > > > >   capsule: Add the capsule-key property for removal from devi=
cetree
> > > > > > >   bootefi: Call the EVT_FT_FIXUP event handler
> > > > > > >   doc: Add a document for non-compliant DT node/property remo=
val
> > > > > > >
> > > > > > >  cmd/bootefi.c                                 | 18 +++++
> > > > > > >  .../devicetree/dt_non_compliant_purge.rst     | 64 +++++++++=
+++++++
> > > > > > >  drivers/fwu-mdata/fwu-mdata-uclass.c          |  5 ++
> > > > > > >  include/dt-structs.h                          | 11 +++
> > > > > > >  lib/Makefile                                  |  1 +
> > > > > > >  lib/dt_purge.c                                | 73 +++++++++=
++++++++++
> > > > > > >  lib/efi_loader/efi_capsule.c                  |  7 ++
> > > > > > >  7 files changed, 179 insertions(+)
> > > > > > >  create mode 100644 doc/develop/devicetree/dt_non_compliant_p=
urge.rst
> > > > > > >  create mode 100644 lib/dt_purge.c
> > > > > >
> > > > > > What is the point of removing them? Instead, we should make sur=
e that
> > > > > > we upstream the bindings and encourage SoC vendors to sync them=
. If we
> > > > > > remove them, no one will bother and U-Boot just becomes a dumpi=
ng
> > > > > > ground.
> > > > >
> > > > > Well things like the binman entries in DT are U-Boot specific and=
 not
> > > > > useful for HW related descriptions or for Linux or another OS bei=
ng
> > > > > able to deal with HW so arguably we're already a dumping ground t=
o
> > > > > some degree for not defining hardware.
> > > >
> > > > I have started the process to upstream the binman bindings.
> > >
> > > I don't think they should be in DT at all, they don't describe
> > > anything to do with hardware, or generally even the runtime of a
> > > device, they don't even describe the boot/runtime state of the
> > > firmware, they describe build time, so I don't see what that has to d=
o
> > > with device tree? Can you explain that? To me those sorts of things
> > > should live in a build time style config file.
>
> For the record, I tend to agree.
>
> > I beg to differ. Devicetree is more than just hardware and always has
> > been. See, for example the /chosen and /options nodes.
>
> There are exceptions...

I wish we could stop having this discussion entirely...to me the
devicetree is all that firmware has to handle its configuration, both
within projects and across project boundaries. There is no user space,
no filesystem, etc.

>
> > We need run-time configuration here, since we cannot know at build
> > time what we will be asked to do by a previous firmware phase.
>
> Really, I don't want to have to care about the binman binding. If it is
> u-boot specific, then it should stay in u-boot.

I don't believe it is U-Boot-specific since it describes the system
firmware as a whole. It collects things from multiple projects and we
want to know where they ended up, so we can do firmware update, etc.

> I took /options/u-boot/,
> but now I'm starting to have second thoughts on that being in dtschema
> if it is going to be continually and frequently extended. Validating it
> in SR does little. If a vendor is abusing /options/u-boot/ in some way
> they could just as easily remove the node in their u-boot fork to pass.
> SR is certainly not going to require the node be there.

The challenge here is that we are trying to validate that the U-Boot
DT matches the schema. We don't want to have people adding things
willy nilly, even in /options/u-boot.

>
> On A/B updates, that really doesn't seem like a u-boot specific problem
> to me. No one wants A/B updates in EDK2 or anything else?

I agree we should specify it correctly and in a general manner.

Regards,
Simon
