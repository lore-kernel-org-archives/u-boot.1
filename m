Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DA5CCEB2D0
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 13:22:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7759589211;
	Tue,  1 Oct 2024 15:19:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="STGBQMak";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB5B4891B8; Tue,  1 Oct 2024 15:07:04 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AC7988D09
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 15:07:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6cb7f5f9fb7so866116d6.1
 for <u-boot@lists.denx.de>; Tue, 01 Oct 2024 06:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727788015; x=1728392815; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2k4PXbuPVAAZijPWlEFotLy87sZXzua9Rp0insH/hvw=;
 b=STGBQMak7scKcfTdIYOVkwV0v3NBrdwR5pjaNTaJY2ISpZn2BKQfa3uOUMgAPCuM1I
 c0bFIyOVWUID5m7auL6D02V2lxtbLJUm8Mm0fkgulQuVTblpaQyH6PI3kASUAzrroWBM
 7E/t2fRT/WHWod8mUELfot+UM64LdVyPXQhV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727788015; x=1728392815;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2k4PXbuPVAAZijPWlEFotLy87sZXzua9Rp0insH/hvw=;
 b=XCqOWoglbi37X12CTWbvOX1w6BMKC9nb8j3CZWitv8+6XzjcqfsPnaA1Eu6slgvDsB
 pYGTvMfgmGeUADforxgnyuxYIxWp6DGSziqlGSeXsHd+DMXkVQcIQ+JR1ihCOEKq+BvS
 dEdJ6P1HMN5vnj56JHBH3wjlxmVnzMzQMplyi3/qyAiAh2jLqQsJpakzbMVriZKSLGoz
 YGwoPvym4uzf2dzbsg6XrA9raI3LQ3/l19X68l6lPQcTP3ofXfLvCnAC4QpTL85rI7TV
 jHzab7zTLL09Hp+ptEaHk2Ukik/DxCb98CyqC605HDgSidCJlbhtKCdoyZld3M7otsTn
 usZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiPb46FCCN65W2xDQ4tB24npRBZboPBaCeEtiW4LkqFPl4cUfabe8wVI6cMweQ/xMYnf46g0w=@lists.denx.de
X-Gm-Message-State: AOJu0YyS2czk7Axv5pEJK8BTgsOb06aiXZ20Gfpada7Q+KbsayxylAWx
 O/SVhEOgNeqMOSfn14qw636+/kDXa2KRK/MIkiysOkf2p/ni3qu019VnkEGvlj/gPn2FUxV5Tm+
 6g1/84tLSZVAOX2iSwIKP9vHGd5IFCyLI5CfL
X-Google-Smtp-Source: AGHT+IF9ypY2c+uXcQ5eRbAYHLsT9gGa9WB4QLlzWNIyALcsdf9H+7jDOh935DUngHI4ZSS0x500C0GhcSb/UOAkSQU=
X-Received: by 2002:a05:6214:4c03:b0:6cb:410a:ef5d with SMTP id
 6a1803df08f44-6cb410af56bmr154057946d6.5.1727788014870; Tue, 01 Oct 2024
 06:06:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240823204824.443631-1-sjg@chromium.org>
 <CAFLszTjrxJA_ZmU-Uptb=kYJcvaXwCwNHg0MeGVW=DNUhPoSaw@mail.gmail.com>
 <87cykkc9hi.fsf@baylibre.com> <8be3b3b6-b805-4459-81af-815d6168edbb@cherry.de>
In-Reply-To: <8be3b3b6-b805-4459-81af-815d6168edbb@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 1 Oct 2024 07:06:44 -0600
Message-ID: <CAFLszThSHKRSQmcMq2cYLyLwxaCLAsx81Q25sW=YsPGLaS2+Ow@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] bootstd: sunxi: Migrate to standard boot
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Andrew Davis <afd@ti.com>,
 Bin Meng <bmeng@tinylab.org>, 
 Bryan Brattlof <bb@ti.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>, 
 Dragan Simic <dsimic@manjaro.org>, Eddie James <eajames@linux.ibm.com>, 
 Hans de Goede <hdegoede@redhat.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Janne Grunau <j@jannau.net>, 
 Jesse Taube <mr.bossman075@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Johan Jonker <jbx6244@gmail.com>, Julien Masson <jmasson@baylibre.com>, 
 Kever Yang <kever.yang@rock-chips.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>, 
 Michal Simek <michal.simek@amd.com>, Nam Cao <namcao@linutronix.de>, 
 Peter Robinson <pbrobinson@gmail.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Stefan Roese <sr@denx.de>, Sumit Garg <sumit.garg@linaro.org>, 
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Tony Dinh <mibodhi@gmail.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 01 Oct 2024 15:19:18 +0200
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

On Tue, 1 Oct 2024 at 06:23, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Mattijs, Simon,
>
> On 10/1/24 2:07 PM, Mattijs Korpershoek wrote:
> > Hi Simon,
> >
> > On mar., oct. 01, 2024 at 05:18, Simon Glass <sjg@chromium.org> wrote:
> >
> >> Hi,
> >>
> >> On Fri, 23 Aug 2024 at 14:48, Simon Glass <sjg@chromium.org> wrote:
> >>>
> >>> This series attempts to migrate all sunxi boards to use standard boot,
> >>> along with a text environment.
> >>>
> >>> Changes in v2:
> >>> - Add new patch to resolve BOOTSTD->BLK recursion with Kconfig
> >>> - Put the FEL bootmeth before all other global bootmeths
> >>> - Convert the other DISTRO_DEFAULTS in the Kconfig too
> >>> - Keep BOOTCMD_SUNXI_COMPAT
> >>> - Keep bootcmd_sunxi_compat if OLD_SUNXI_KERNEL_COMPAT is enabled
> >>>
> >>> Simon Glass (8):
> >>>    blk: Make functions available unconditionally
> >>>    bootstd: Avoid calling unavailable block functions
> >>>    bootstd: Avoid depending on BLK
> >>>    sunxi: Add a bootmeth for FEL
> >>>    sunxi: Move to bootstd
> >>>    sunxi: Drop old distro boot variables
> >>>    env: Provide a work-around for unquoting fdtfile
> >>>    sunxi: Move to text environment
> >>>
> >>>   Makefile                                      |   1 +
> >>>   arch/arm/Kconfig                              |  10 +-
> >>>   board/sunxi/sunxi.env                         | 152 +++++++++++
> >>>   boot/Kconfig                                  |  16 +-
> >>>   boot/Makefile                                 |   1 +
> >>>   boot/bootdev-uclass.c                         |   3 +
> >>>   boot/bootmeth_fel.c                           |  81 ++++++
> >>>   .../gardena-smart-gateway-mt7688_defconfig    |   1 +
> >>>   doc/usage/environment.rst                     |  12 +
> >>>   include/blk.h                                 |   9 +-
> >>>   include/configs/sunxi-common.h                | 238 ------------------
> >>>   11 files changed, 278 insertions(+), 246 deletions(-)
> >>>   create mode 100644 board/sunxi/sunxi.env
> >>>   create mode 100644 boot/bootmeth_fel.c
> >>>
> >>> --
> >>> 2.34.1
> >>>
> >>
> >> I'm just checking on this series. Are there any comments, or can it be applied?
> >
> > Quentin mentioned a typo in patch 3/8, see:
> > https://lore.kernel.org/all/1f963aa8-948a-4657-9f1b-a3bc38df4714@cherry.de/
> >
>
> Well, is it really a typo or was this still a WIP patch that made it to
> the ML somehow? That was basically the "question" or concern about "wip"
> appearing in the commit log :)

It was an ex-wip patch which I modified and failed to remove the
'wip'. It was fixed in v3[1] (which I now see that I should have
replied to here)

Regards,
SImon

[1] https://patchwork.ozlabs.org/project/uboot/patch/20240901222734.462334-4-sjg@chromium.org/
