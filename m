Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D81E7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 13:20:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6647801CF;
	Tue, 17 Dec 2024 14:20:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="hUIdl/Vw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E852801FB; Tue, 17 Dec 2024 14:20:53 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F51F801CE
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 14:20:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4BHDKekS070997;
 Tue, 17 Dec 2024 07:20:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1734441640;
 bh=RqFG5PEi8GPgzxnDit3erle/Ug9OQCu05PTN+iayzTU=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=hUIdl/VwYHB063BHvDb+V4KD0lOvbM+FETbpHBhiD7T94tGQso6HHQw+CHLT66SEn
 uTOjxNnQrDkBgZM5IlqXXTREMBEcPryGoysIHOav+UD/dWb1PNJa1bWyJRnVqznGtG
 8+vryiT2HzyVbMr+loPz+Bw4a6hstv+XmmgQ6+Z0=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BHDKe9f030743
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 17 Dec 2024 07:20:40 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 17
 Dec 2024 07:20:39 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 17 Dec 2024 07:20:39 -0600
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.81])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BHDKcgb018522;
 Tue, 17 Dec 2024 07:20:39 -0600
Date: Tue, 17 Dec 2024 18:50:38 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Jon Humphreys <j-humphreys@ti.com>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <vigneshr@ti.com>, <bb@ti.com>, 
 <trini@konsulko.com>, <m-chawdhry@ti.com>, <rogerq@kernel.org>,
 <nm@ti.com>, <sjg@chromium.org>, <devarsht@ti.com>,
 <ilias.apalodimas@linaro.org>, <afd@ti.com>, <u-kumar1@ti.com>,
 <u-boot@lists.denx.de>, <srk@ti.com>
Subject: Re: [PATCH v2 0/5] EFI Capsule "dfu_alt_info" fixes for TI Boards
Message-ID: <jcoqvbwyyjrr5vzqfliqgprdl57cw5deabn2t7npqfflmktcx2@gpuzlzoe6drh>
References: <20241124070828.617558-1-s-vadapalli@ti.com>
 <86ed2y69tx.fsf@udb0321960.dhcp.ti.com>
 <ytjx5tv4f2ykgakmjmodfi24r7vg6blfrjaxj4dmk3usa6pnbh@w6rwxbdsxwt5>
 <86bjxz6g9m.fsf@udb0321960.dhcp.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <86bjxz6g9m.fsf@udb0321960.dhcp.ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

On Thu, Nov 28, 2024 at 12:09:41AM -0600, Jon Humphreys wrote:

Hello Jon,

> Siddharth Vadapalli <s-vadapalli@ti.com> writes:
> 
> > On Mon, Nov 25, 2024 at 07:51:54PM -0600, Jon Humphreys wrote:
> >
> > Hello Jon,
> >
> > [...]
> >
> >> 
> >> Hi Siddharth, this is an issue that I also discovered while working on a
> >> separate issue with Collabora, but haven't posted a patch yet.  The issue
> >> is that when DFU booting, spl_dfu_cmd() will setup it's own value for
> >> dfu_alt_info before calling run_dfu().  In our existing code, however, this
> >> will get overridden by set_dfu_alt_info().  This issue isn't specific to TI
> >> boards.
> >> 
> >> Can you try this patch to drivers/dfu/dfu.c to see if it solves the
> >> problems you are seeing:
> >> 
> >> @@ -153,10 +153,11 @@ int dfu_init_env_entities(char *interface, char
> >> *devstr)
> >> 
> >>   dfu_reinit_needed = false;
> >> 
> >> + str_env = env_get("dfu_alt_info");
> >>  #ifdef CONFIG_SET_DFU_ALT_INFO
> >> - set_dfu_alt_info(interface, devstr);
> >> + if (!str_env) {
> >> + set_dfu_alt_info(interface, devstr);
> >> + str_env = env_get("dfu_alt_info");
> >> + }
> >> #endif
> >> - str_env = env_get("dfu_alt_info");
> >>   if (!str_env) {
> >>   pr_err("\"dfu_alt_info\" env variable not defined!\n");
> >>   return -EINVAL;
> >
> > Yes, this patch fixes the issue. Do you plan to post this patch? Or has
> > it already been posted and is under discussion? Please let me know.
> >
> 
> no patch posted yet, but I will do that next week.

Since this fix is required not only for AM62x, but also for AM62Px, I
have included the fix as a patch with your authorship in my series for
enabling USB DFU Boot on AM62Px at:
https://patchwork.ozlabs.org/project/uboot/cover/20241217131658.2920799-1-s-vadapalli@ti.com/

I have copied you in the series. Please review the patch (and the series
also if possible) and share your feedback in case of any concerns with
either the commit message or the changes made in that patch.

Regards,
Siddharth.
