Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3409AC83F1A
	for <u-boot@archiver.kernel.org>; Mon, 21 Jul 2025 11:33:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C42383123;
	Mon, 21 Jul 2025 13:33:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72DED8313F; Mon, 21 Jul 2025 13:33:35 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 76BCE801DD
 for <u-boot@lists.denx.de>; Mon, 21 Jul 2025 13:33:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=abdellatif.elkhlifi@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1F27153B;
 Mon, 21 Jul 2025 04:33:26 -0700 (PDT)
Received: from e130802.arm.com (e130802.arm.com [10.1.26.61])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A3933F6A8;
 Mon, 21 Jul 2025 04:33:30 -0700 (PDT)
Date: Mon, 21 Jul 2025 12:33:19 +0100
From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
To: Michal Simek <monstr@monstr.eu>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH v2 01/25] arm_ffa: Remove NULL pointer check for ops
Message-ID: <20250721113310.GA63677@e130802.arm.com>
References: <20250711144917.1876948-1-abdellatif.elkhlifi@arm.com>
 <20250711144917.1876948-2-abdellatif.elkhlifi@arm.com>
 <CAHTX3dJgT0FB9f9Ybes=V+xUt1M2wXPXNhqxVtzcAGysNeLJGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHTX3dJgT0FB9f9Ybes=V+xUt1M2wXPXNhqxVtzcAGysNeLJGA@mail.gmail.com>
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

Hi Michal,

> pá 11. 7. 2025 v 16:49 odesílatel <abdellatif.elkhlifi@arm.com> napsal:
> >
> > From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> >
> > Remove NULL pointer check for ops
> >
> > uclasses that use ops typically don't check for NULL.
> >
> > Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > Cc: Jens Wiklander <jens.wiklander@linaro.org>
> > Cc: Tom Rini <trini@konsulko.com>
> > Cc: Simon Glass <sjg@chromium.org>
> > Cc: Casey Connolly <casey.connolly@linaro.org>
> > Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >
> > ---
> >
> > Changelog of changes:
> > ===========================
> >
> > v2:
> >
> > * As suggested by Heinrich: The commit is renamed and the ops NULL check removed
> >
> > v1:
> >
> > * Commit title was "arm_ffa: Add NULL pointer check to the uclass driver operations"
> >
> >  drivers/firmware/arm-ffa/arm-ffa-uclass.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/firmware/arm-ffa/arm-ffa-uclass.c b/drivers/firmware/arm-ffa/arm-ffa-uclass.c
> > index 96c64964bb7..32dd9458da9 100644
> > --- a/drivers/firmware/arm-ffa/arm-ffa-uclass.c
> > +++ b/drivers/firmware/arm-ffa/arm-ffa-uclass.c
> > @@ -1,6 +1,6 @@
> >  // SPDX-License-Identifier: GPL-2.0+
> >  /*
> > - * Copyright 2022-2023 Arm Limited and/or its affiliates <open-source-office@arm.com>
> > + * Copyright 2022-2023, 2025 Arm Limited and/or its affiliates <open-source-office@arm.com>
> >   *
> >   * Authors:
> >   *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> > --
> > 2.25.1
> >
> 
> That commit message is not matching what you do here.

Thank you. Your comment has been addressed in v3 patchset.
The commit has been removed and the copyright text moved
to the next commit.

Cheers
Abdellatif
