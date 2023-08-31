Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5F78C83F21
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 02:50:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4EDE86586;
	Thu, 31 Aug 2023 04:50:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AEqctE1U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2AE486582; Thu, 31 Aug 2023 04:50:06 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E19AD86574
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 04:49:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-4fe15bfb1adso798131e87.0
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 19:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693450199; x=1694054999; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=U5DBtCPLaO97kfjCvKTMOwQc3T925PoJC5ExntPTne4=;
 b=AEqctE1UWcvk2wBxvU+O8KF3hevBQi9ffqGOgsJdB30rPfDXAG1b6y8QdYyAKkt7X9
 fF680FBPf45MYjwwQnDrklHXQrZIo3YO+MXE2faKkB9ADhY4z3bc024loqu1x3Nd1PBd
 hOKdSy/Q2zoZPSRi4OLCEntaGYaSXDIej9AuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693450199; x=1694054999;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U5DBtCPLaO97kfjCvKTMOwQc3T925PoJC5ExntPTne4=;
 b=Nqp59ZWWYdAW70MFraJt49D2MkDGhgdcy9m5gCzJQN+6zH5ukKAx04CDEtpvgpg/Hi
 +EKFaeq5tKDYl2ncKMoquAFFWvuFTDPFS6PZV3UBtTaDgtKbWAOXTdLGK+9Jaeqb9HQA
 SUeCYT1tmaBFpgIxUczBjhzX/suWe/T70cjFgdPkqOdPwp8gGlh3GSmlLaj8CZC90v2D
 JvIfJWU/dqjbTy4lwPrLugGCd5kPQGF0oSo0lAaiDOnu5P653rXBQF5XApAzZciFja7M
 oS2ceyKvCUiI+qGZdb/ePQ1sWdHPs79nVISfVNAx0QXReeCpS8RnmDOSuOITs0ENbqGy
 SCGQ==
X-Gm-Message-State: AOJu0Yx22Cwt7L5o5IzIid3JCK9GPH9Dvf+bmwU4UYBKgXZE2eEkTUK/
 dtNshoq52gJSG/MZw3jK382I6Dh1PhinIyDZZzDyUA==
X-Google-Smtp-Source: AGHT+IFbxue/jZSPI01w2oR3Jz4LbZ6cPvB9uwxqt8UZsvoj2JkqwfCWN9FC+GxN9Y5YbQDO7v0C8HtqTGNH3X8+VWQ=
X-Received: by 2002:a05:6512:3b9c:b0:4fe:5a4b:911d with SMTP id
 g28-20020a0565123b9c00b004fe5a4b911dmr3647975lfv.64.1693450198954; Wed, 30
 Aug 2023 19:49:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230829221457.101469-1-afd@ti.com>
 <20230829221457.101469-3-afd@ti.com>
 <20230830123151.rp7wkhi5m4leg6ny@ravishing>
 <0cbbf080-491f-a0fc-300c-d32cbd06ba70@ti.com>
 <20230830145936.iwl3ew4274adpr4z@litigate>
 <9fdaef14-2065-155e-6c4d-a505d49995f9@ti.com>
In-Reply-To: <9fdaef14-2065-155e-6c4d-a505d49995f9@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 30 Aug 2023 20:49:22 -0600
Message-ID: <CAPnjgZ0sTA5RB5qZJB9Pscv9TnSNdso93DPc6eZH9z07eX_aHA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] configs: Add am62x_beagleplay_* defconfigs
To: Andrew Davis <afd@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Tom Rini <trini@konsulko.com>, 
 Bryan Brattlof <bb@ti.com>, Praneeth Bajjuri <praneeth@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, u-boot@lists.denx.de
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

On Wed, 30 Aug 2023 at 09:17, Andrew Davis <afd@ti.com> wrote:
>
> On 8/30/23 9:59 AM, Nishanth Menon wrote:
> > On 09:31-20230830, Andrew Davis wrote:
> >> On 8/30/23 7:31 AM, Nishanth Menon wrote:
> >>> On 17:14-20230829, Andrew Davis wrote:
> >>>> Add am62x_beagleplay_r5_defconfig for R5 SPL and
> >>>> am62x_beagleplay_a53_defconfig for A53 SPL and U-Boot support.
> >>>>
> >>>> These defconfigs are composite defconfigs built from the config fragment
> >>>> board/ti/am62x/beagleplay_*.config applied onto the base
> >>>> am62x_evm_*_defconfig.
> >>>>
> >>>> Signed-off-by: Andrew Davis <afd@ti.com>
> >>>> ---
> >>>>    configs/am62x_beagleplay_a53_defconfig | 3 +++
> >>>>    configs/am62x_beagleplay_r5_defconfig  | 3 +++
> >>>>    2 files changed, 6 insertions(+)
> >>>>    create mode 100644 configs/am62x_beagleplay_a53_defconfig
> >>>>    create mode 100644 configs/am62x_beagleplay_r5_defconfig
> >>>>
> >>>> diff --git a/configs/am62x_beagleplay_a53_defconfig b/configs/am62x_beagleplay_a53_defconfig
> >>>> new file mode 100644
> >>>> index 00000000000..ad708e15397
> >>>> --- /dev/null
> >>>> +++ b/configs/am62x_beagleplay_a53_defconfig
> >>>> @@ -0,0 +1,3 @@
> >>>> +// The BeaglePlay defconfig for A53 core
> >>>> +#include "configs/am62x_evm_a53_defconfig"
> >>>> +#include "board/ti/am62x/beagleplay_a53.config"
> >>>> diff --git a/configs/am62x_beagleplay_r5_defconfig b/configs/am62x_beagleplay_r5_defconfig
> >>>> new file mode 100644
> >>>> index 00000000000..276b1f81a3e
> >>>> --- /dev/null
> >>>> +++ b/configs/am62x_beagleplay_r5_defconfig
> >>>> @@ -0,0 +1,3 @@
> >>>> +// The BeaglePlay defconfig for R5 core
> >>>> +#include "configs/am62x_evm_r5_defconfig"
> >>>> +#include "board/ti/am62x/beagleplay_r5.config"
> >>>> --
> >>>> 2.39.2
> >>>>
> >>>
> >>> my only complaint is that if we add lets say
> >>> board/ti/am62x/dfu.config, Then:
> >>>
> >>> R5:
> >>> 1. am62x_evm_r5_defconfig = am62x_evm_r5_defconfig
> >>> 2. am62x_beagleplay_r5_defconfig = am62x_evm_r5_defconfig + beagleplay_r5.config
> >>> 3. am62x_evm_r5_dfu_defconfig = am62x_evm_r5_defconfig + dfu.config
> >>> 4. am62x_beagleplay_r5_dfu_defconfig = am62x_evm_r5_defconfig + beagleplay_r5.config + dfu.config
> >>>
> >>> This information can be in a single txt file Rather than have a
> >>> defconfig file for each combination.
> >>>
> >>
> >> Having every combination in a text file vs in a directory of files doesn't
> >> seem like much difference to me. `cat combinations.txt` vs `ls -l configs/`.
> >> But using a file would mean extra tooling and non-standard usage.
> >
> > The .config usage is a standard already in kernel - nothing new there.
> >
> > What we are attempting to solve is CI build coverage and test aspect of
> > things.
> >
>
> Exactly, when I say "standard" I mean CI standard, which is to take all
> the configs/* and build them. No parsing these new combination files needed.
> Just add a new configs/xx_defconfig for a combination you want to be
> CI tested and you are done.
>
> > Thinking aloud here:
> > some sort of board/<vendor>/<board>/ci.conf yaml could probably be a better
> > approach with description of build, automated test information,
> > potentially board revisions etc.
> >
> >> Let's simply try to avoid these combinatorial problems by avoiding adding
> >> too many fragments that apply broadly. That adds testing burden. When features
> >
> > The combinations will be valid since the intent is a supported
> > configuration.
> >
>
> In theory anything you do in menuconfig should result in a valid configuration
> (if we have our kconfig symbol dependencies in order). And randomconfig testing
> can handle that. The combinations we want always tested should be limited, and
> making each have a dedicated configs/ file does that.

I think this is a reasonable solution to what I see as the problem (we
don't know what we can build) but I am very open to others.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
