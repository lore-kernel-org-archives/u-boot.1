Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 969FEC83F3C
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 19:05:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 454CD8682C;
	Thu, 31 Aug 2023 21:03:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cZgN5XKr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A60C886784; Thu, 31 Aug 2023 21:03:29 +0200 (CEST)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B2FD86844
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 21:03:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-d7766072ba4so3156287276.1
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 12:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693508604; x=1694113404; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5ayvHmZd3l0NOG6yuOtnYO6iVpbSld9fB7x5qkOofbo=;
 b=cZgN5XKrZc/N+HT2sQ8MMovbr/+00A7xrO0QT8T5MByxAFfI3feQdVrL9SUiLDk4BK
 HKyw7x5SKBylNZt/3fw89XwNendXTZ3/zSU/P9QdkX8Aer2iUdo7yCfUw2rGzGM4vbZY
 7M4ccNjIu53++b+Ve9p28yOq7yeW8nKBQCTDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693508604; x=1694113404;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5ayvHmZd3l0NOG6yuOtnYO6iVpbSld9fB7x5qkOofbo=;
 b=Hl70jGbd1HYpRmgRl2uXvR6mKy6SL0VE5wquAsnCDLb5T5USRFj8be/Dp8BoHbTbD8
 LFrjir9Nl6snFBL4+LGQpIWfVvCcUJljms+XYY29TuUuvcafjz6BJ0x1kTOffKoeP3pR
 lL1x9+yjrN6zuodHqlX6aUZEDiZb4aVsQqqdr5K7WmGER+DE0uuW5UQ+ciyposJP3tSL
 4MNCSVEHU/1wtFEwStU9gUsdVv6N3O1VsnpbL5RSHUapZ7ydNvQXWUb7v+R4YBAaSDph
 VHcTogMda+B3mRweJaMU+a+wAJxhrxvAhrM9Gdrj+omTwcX6yDuU0oefz61HgY9Qpn7u
 Kvaw==
X-Gm-Message-State: AOJu0Yx4oz1doTg23dvkFDx15Gv7iX6842EeUVuYKHEctyirWTpio+vl
 QG8kauyX8xis3xAbzmo0C0RvRFjwierhpb+Tbahumw==
X-Google-Smtp-Source: AGHT+IGkbT4a1tIt2MXpvu8kSbrDTkZtI7RoyxReRSDVBFXBoD8vn87RAmq3TmrGkAYQEgd6SL2oprB9LgArHcUMGkM=
X-Received: by 2002:a25:aca6:0:b0:d4a:499d:a881 with SMTP id
 x38-20020a25aca6000000b00d4a499da881mr811415ybi.9.1693508603489; Thu, 31 Aug
 2023 12:03:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230830180524.315916-1-sjg@chromium.org>
 <20230830180524.315916-31-sjg@chromium.org>
 <ZPA8AtGOel8pko6y@hades>
In-Reply-To: <ZPA8AtGOel8pko6y@hades>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 31 Aug 2023 13:02:04 -0600
Message-ID: <CAPnjgZ1gat+g=dRUO4Akk2YMp_=wy7agQM2CuwaRB7J-C6u=kw@mail.gmail.com>
Subject: Re: [PATCH 30/32] fdt: Allow the devicetree to come from a bloblist
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marex@denx.de>, Baruch Siach <baruch@tkos.co.il>,
 Bin Meng <bmeng.cn@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jerry Van Baren <vanbaren@cideas.com>,
 Michal Simek <michal.simek@amd.com>, Nikhil M Jain <n-jain1@ti.com>,
 Qu Wenruo <wqu@suse.com>, Stefan Roese <sr@denx.de>
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

Hi Ilias,

On Thu, 31 Aug 2023 at 01:06, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> On Wed, Aug 30, 2023 at 12:05:01PM -0600, Simon Glass wrote:
> > Standard passage provides for a bloblist to be passed from one firmware
> > phase to the next. That can be used to pass the devicetree along as well.
> > Add an option to support this.
> >
> > Tests for this will be added as part of the Universal Payload work.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  common/bloblist.c                  |  2 ++
> >  doc/develop/devicetree/control.rst |  3 ++
> >  dts/Kconfig                        |  8 ++++++
> >  include/bloblist.h                 |  5 ++++
> >  include/fdtdec.h                   |  3 +-
> >  lib/fdtdec.c                       | 44 ++++++++++++++++++++++--------
> >  6 files changed, 52 insertions(+), 13 deletions(-)
> >
> > diff --git a/common/bloblist.c b/common/bloblist.c
> > index 6f2a4577708..b07ede11cfe 100644
> > --- a/common/bloblist.c
> > +++ b/common/bloblist.c
> > @@ -48,9 +48,11 @@ static struct tag_name {
> >       { BLOBLISTT_ACPI_TABLES, "ACPI tables for x86" },
> >       { BLOBLISTT_SMBIOS_TABLES, "SMBIOS tables for x86" },
> >       { BLOBLISTT_VBOOT_CTX, "Chrome OS vboot context" },
> > +     { BLOBLISTT_CONTROL_FDT, "Control FDT" },
> >
> >       /* BLOBLISTT_PROJECT_AREA */
> >       { BLOBLISTT_U_BOOT_SPL_HANDOFF, "SPL hand-off" },
> > +     { BLOBLISTT_VBE, "VBE" },
> >       { BLOBLISTT_U_BOOT_VIDEO, "SPL video handoff" },
> >
> >       /* BLOBLISTT_VENDOR_AREA */
> > diff --git a/doc/develop/devicetree/control.rst b/doc/develop/devicetree/control.rst
> > index cbb65c9b177..56e00090166 100644
> > --- a/doc/develop/devicetree/control.rst
> > +++ b/doc/develop/devicetree/control.rst
> > @@ -108,6 +108,9 @@ If CONFIG_OF_BOARD is defined, a board-specific routine will provide the
> >  devicetree at runtime, for example if an earlier bootloader stage creates
> >  it and passes it to U-Boot.
> >
> > +If CONFIG_OF_BLOBLIST is defined, the devicetree comes from a bloblist passed
> > +from a previous stage.
> > +
>
> Is this bloblist in the format described in the firmware handoff [0] ?

Yes

>
> > +config OF_BLOBLIST
> > +     bool "DTB is provided by a bloblist"
> > +     help
> > +       Select this to read the devicetree from the bloblist. This allows
> > +       using a bloblist to transfer the devicetree between  U-Boot phases.
> > +       The devicetree is stored in the bloblist by an early phase so that
> > +       U-Boot can read it.
> > +
>
> I dont think this is a good idea.  We used to have 4-5 different options
> here, which we tried to clean up and ended up with two very discrete
> options.  Why do we have to reintroduce a new one?  Doesn't that bloblist
> have a header of some sort?  The bloblist literally comes from a previous
> stage bootloader which is what OF_BOARD is here for. So why can't we just
> read the header and figure out if the magic of the bloblist matches?

No, OF_BOARD is a hack to allow boards to do what they like with the FDT.

This patch is a standard mechanism to pass the DT from one firmware
phase to the next. We have spent quite a bit of time creating a spec
for it, and we should use it.

The patches to align bloblist with the spec have been sent, but there
is a late-breaking change that we are trying to resolve. Once that is
sorted out, I will send v2 of those patches.

>
> >  config OF_BOARD
> >       bool "Provided by the board (e.g a previous loader) at runtime"
> >       default y if SANDBOX || OF_HAS_PRIOR_STAGE
> > diff --git a/include/bloblist.h b/include/bloblist.h
> > index 080cc46a126..e16d122f4fb 100644
> > --- a/include/bloblist.h
> > +++ b/include/bloblist.h
> > @@ -103,6 +103,11 @@ enum bloblist_tag_t {
> >       BLOBLISTT_ACPI_TABLES = 0x104,  /* ACPI tables for x86 */
> >       BLOBLISTT_SMBIOS_TABLES = 0x105, /* SMBIOS tables for x86 */
> >       BLOBLISTT_VBOOT_CTX = 0x106,    /* Chromium OS verified boot context */
> > +     /*
>
> [...]
>
> >
> [0] https://github.com/FirmwareHandoff/firmware_handoff

Regards,
Simon
