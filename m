Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E13D8C3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 14:14:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B14F83C2F;
	Thu, 10 Apr 2025 16:14:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ok4zY81N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BEC882A4B; Thu, 10 Apr 2025 16:14:41 +0200 (CEST)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F320782A4B
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 16:14:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2240b4de12bso11000415ad.2
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 07:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744294475; x=1744899275; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nCoCZdQa7LaDR0MMC4bbic9fDzTmBpbZ44NbJLvGb/E=;
 b=Ok4zY81NDiULx6k5ZSs4/ehah2GrWpYc+hfkwtL5NNIz51V24VHZ8BeR74hx0k7Ghq
 7PCE0mSLXub01rOJQlsgQmsVqsXEl4/EbuOiBs16b2zblK5YYUE6VMGkaOjwwdcd6zSw
 1cT190ogrf35Rupmkj/H15H1ogHvsNesaNtObl7yLk47bdm7GddbUplOVoApCqcsEGSw
 xsU3G2E6/tMlvRReTDH+RcE3zTDpflgGnDS58OluO3fy6YpYmuX77wISzNwzcmVQTri7
 D4OhIU3W9J5KmZLuZmLVBtdoXvdKekn6mrS4BAUqHkZRJFOe7DrZpb4yAeTRm34noXf7
 SnSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744294475; x=1744899275;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nCoCZdQa7LaDR0MMC4bbic9fDzTmBpbZ44NbJLvGb/E=;
 b=E3I9V3eKzsbxp9MXVbxRrJ4EkXaOU8pe/QhcRig2SPPA3omP1FoeuDA7DBMRhpcvrT
 EFe3qVGEkTkKSX//HnD4034XdWfFINROp+Kh+PSDcC/S1VXrL8C0SCFbAY36Axt99tKo
 5scQ230BCQTEfFqKS1i4Npzu4yg4k8fyzGTrjDhSUNIfMSshqz3jbvb5BSoZPsuT6bxE
 FlaTXujaRi2EZfbryI0r82qmq38I0SSFceRXzWFcNiRESz1QCfk+Uknnn+FRJxrOsHzV
 97xwP6SH5tRu+XQpZJ9Eo5GxchSaNDcrRVCxL0wcnm11Ty29Fv9gBkuvpSpu7Wx8TEV4
 b2mA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHzCixUyIvF1eXYkt8/a2yOK6A1o3cda9vFnrGBMuettY9sMyFKs40hdvUCziIhhxtdQngjBA=@lists.denx.de
X-Gm-Message-State: AOJu0YyS4myiMoGxO22knddyfdS8qw7Ihw35TA0eZe+GrHTXY4CmXSKn
 tzO6e5Q7OmQ581tYAH8Z94eFKu3NOZh5ncTK9YhhMbGsl/gbwDtBp2qy9RQKakP8GIR1WP8ZnO9
 YNO2MlGy0kf0I52M97j5v7djCm03JlGfDe8ud6JbH9tBPC3tKbqw=
X-Gm-Gg: ASbGncsgZ72pEfsmfzw0aSVE+QGGhZjhtkwDJSp9O9MSDMurKXQgyddUcj9z3ZeG6q1
 lygZ2sRutPckMoinDBMzfuza8rw29cFhSw+Qqn2zluClhwsN1+BuqROqL1fHzRzR2e/rTFtAu+o
 /VE6T54Ioe/78XhqeAfCvrIkQ=
X-Google-Smtp-Source: AGHT+IFDAby7W/3vpi7/Yw18uDbRlf3cq4fqcfmgOTwEDxM+GSDeRTV3R1IZ23dReY9XQnurJR2ZEIN7yqd1fQEAU3Q=
X-Received: by 2002:a17:902:e801:b0:220:c86d:d7eb with SMTP id
 d9443c01a7336-22b42c43c08mr46620125ad.36.1744294474985; Thu, 10 Apr 2025
 07:14:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250407220011.GS5495@bill-the-cat>
 <0974a2c7-fbe0-4195-ad24-36e815ac4080@linaro.org>
In-Reply-To: <0974a2c7-fbe0-4195-ad24-36e815ac4080@linaro.org>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Thu, 10 Apr 2025 10:14:22 -0400
X-Gm-Features: ATxdqUEnsqTX91yQ1Tpy8OuKQLB7UzmrvolYNDaylEY6nZ3ds0YZiqwIeSidhvo
Message-ID: <CAEfUkU+PKtU85CuCPUgz0=GmFvbbJR0wnFo2hX1vnJY9VurMLQ@mail.gmail.com>
Subject: Re: Community meeting April 8th 2025 (was: Re: [ANN] U-Boot v2025.04
 released)
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
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

Hi all,

I didn't have a chance to join the meeting due to a different time
zone but I have a few comments on bloblist/fdt as below.

On Wed, 9 Apr 2025 at 09:46, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Hi Everyone,
>
> On 4/8/25 00:00, Tom Rini wrote:
> > Hey all,
> >
> > It's release day and here's v2025.04. We had some last minute issues
> > reported, but then also resolved.  I want to thank everyone that's
> > contributed to this release, not just in terms of code, but
> > documentation, testing and otherwise ensuring things go as smoothly as
> > they can.
> >
> > In terms of a changelog,
> > git log --merges v2025.04-rc5..v2025.04
> > contains what I've pulled since the last RC or:
> > git log --merges v2025.01..v2025.04
> > for changes since the last full release. As always, more details in
> > pull requests (or the tags referenced by them) will result in more
> > details here.
> >
> > As is becoming reguarly scheduled, we have a community meeting tomorrow
> > (for me anyhow). The meeting details itself are:
> > https://meet.google.com/btj-wgcg-euw
> > April 7th, 2025. 9am (GMT -06:00)
> >
> > To join by phone:
> > https://meet.google.com/tel/btj-wgcg-euw?pin=3D1307528552322&hs=3D1
> >
> > The meeting can be added to your calendar via the link on
> > https://www.u-boot.org/
>
>
> Here are the notes from the meeting, please feel free to clarify any
> points I might have missed or gotten wrong. Thanks Tom for chairing.
>
> # U-Boot Community meeting April 8 2025
>
> * Tom intro: next merged into master, small delay
> * Heinrich: ACPI has regular regressions due to lack of testing in CI
>    * tom proposes adding another QEMU defconfig with ACPI enabled
> * Heinrich: Ubuntu images being used in CI are getting too old
>    * tom: has a patch to update to GCC 14
>    * tom: opened an issue, Simon to investigate (link?)
>    * tom: already tested new GCC/LLVM, no new warnings.
>    * tom: will rebuild docker container this week, adding byacc for
> binman to enable IMX8 testing
>
> * state of Simons patches re: bootflow/EFI/standard boot
>    * issue with standard boot that the EFI bootmgr option is always at
> the top
>    * heinrich: proposes a new virtual device that can be ordered anywhere
>    * heinrich will investigate in the next few weeks
>
> * tom: modernising the Makefile
>    * tom: which platforms are still using old stuff? will consider
> disabling or removing boards
>    * tom: e.g. watchdog (deadline 2019), legacy i2c (deadline 2022.04)
>
> * caleb: FdtFile revival
>    * context: https://github.com/systemd/systemd/issues/36835
>    * would enable picking DTB matching your kernel version
>    * heinrich: robh thinks we should match on compatible instead. Simon
> also agrees
>    * heinrich: fine with adding this patch
>    * simon: significant harm - compatible is the only right way to
> match, anything else is a workaround
>    * caleb/tom: agrees in theory, but in practise this isn't what we
> witness. Having a compressed blob of all DTs would be ideal, and
> compresses well, but nobody is doing this..
>    * heinrich: U-Boot is also not the only firmware, we can't expect
> EDK2 to start shipping this.
>    * Ilias: Agrees, best of the bad options
>    * simon: what would be the right solution?
>      * caleb: have the kernel emit a file with compatible -> fdtfile
> lookups since that's faster to read
>    * Bryan Brattlof: what about overlays?
>      * caleb: probably you have a more vertically integrated system
>      * bryan: customers want yocto and a redhat image that works ootb
>
> * tom/simon: bloblist:
>    * tom: if bloblist is enabled it MUST have the DT, set the "mandatory
> passage flag"
>    * simon: OF_BLOBLIST means DT is in bloblist

Not only DT but other stuff should be considered to be handed over via
the bloblist, currently TPM eventlog and the list will be increasing
in the future. It is a nightmare to create one kconfig for each.
Also, Firmware Handoff spec is in order to unify the handoff between
stages in one standard way but creating one kconfig for each component
implies that we are allowing "partially" compliance with the spec and
able to select which one should be from bloblist and which one should
not be.
We have kconfig BLOBLIST_PASSAGE_MANDATORY and I think we can use it
for all scenarios instead of creating new ones.

>    * tom: it's a bad idea to divorce standard passage handoff from
> bloblist, but if it eases some issues for now and we can revisit in a
> ~year that might be best
>    * ilias: we have discussed this before. doesn't think OF_BLOBLIST
> should exist, because the info is discoverable at runtime.
>    * ilias: we have a standard (firmware handoff), why do we need
> another implementation?
>      * tom: hoping to reconcile over time between fw handoff and bloblist
>    * tom: to re-iterate what Simon said: dt should be either in
> bloblist, embedded, or discovered through board specific means. Need to
> avoid conflating consuming bloblist and creating bloblist (e.g. in SPL).
>      * tom: in SPL, if we don't have a bloblist, we don't need a config
> option.
>      * tom: we should remove BLOBLIST_FIXED
>    * simon: we can get rid of BLOBLIST_FIXED if we have a register
> hand-off firmware (x86)

x86 is out of the scope of Firmware Handoff which is a spec led by Arm.
I agree that maybe x86 needs something similar but we should keep it
as-is until there is a spec telling what should be done.

Regards,
Raymond

>    * out of time... Tom ok to add OF_BLOBLIST if we remove
> BLOBLIST_FIXED. Hopes that in ~1 year we'll all agree that we want the
> same thing...
>
>
> >
> > The merge window is formally open again. I will be merging next in to
> > master shortly. The v2025.07 release is scheduled for Monday, July 7th,
> > 2025 and the merge window will close and -rc1 will be released on the
> > 28th of April, and then the next window will open with -rc2, two weeks
> > later. The keen-eyed among you might notice that I fixed some incorrect
> > -rc1 dates in the future planning section, including for this cycle.
> >
> > Thanks all!
> >
>
> --
> Caleb (they/them)
>
