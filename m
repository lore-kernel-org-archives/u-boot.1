Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F7DDC4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 10:21:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B59F387BEE;
	Wed,  1 Nov 2023 11:20:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B71C87BF0; Wed,  1 Nov 2023 11:20:57 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 39C8187BE5
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 11:20:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=abdellatif.elkhlifi@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 283CF2F4;
 Wed,  1 Nov 2023 03:21:34 -0700 (PDT)
Received: from e130802.arm.com (e130802.arm.com [10.1.35.55])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4FA683F67D;
 Wed,  1 Nov 2023 03:20:51 -0700 (PDT)
Date: Wed, 1 Nov 2023 10:20:41 +0000
From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, nd@arm.com, jon.mason@arm.com, rui.silva@linaro.org
Subject: Re: [PATCH 1/3] corstone1000: add compressed kernel support
Message-ID: <20231101102041.GA21252@e130802.arm.com>
References: <20231026125051.321493-1-abdellatif.elkhlifi@arm.com>
 <20231026125051.321493-2-abdellatif.elkhlifi@arm.com>
 <20231031174617.GW496310@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031174617.GW496310@bill-the-cat>
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

Hi Tom,

> On Thu, Oct 26, 2023 at 01:50:49PM +0100, abdellatif.elkhlifi@arm.com wrote:
> 
> > From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> > 
> > unzip the kernel before executing it
> > 
> > The Corstone-1000 kernel has become too large to fit in the available
> > storage.  Switching to a compressed kernel avoids the problem, but
> > requires uncompressing it.
> > 
> > Changes made are generated using savedefconfig.
> > 
> > Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> > Signed-off-by: Jon Mason <jon.mason@arm.com>
> > Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>
> > ---
> >  configs/corstone1000_defconfig | 1551 +++++++++++++++++++++++++++++++-
> >  1 file changed, 1550 insertions(+), 1 deletion(-)
> > 
> > diff --git a/configs/corstone1000_defconfig b/configs/corstone1000_defconfig
> > index 3b5733b777..f25da79ec8 100644
> > --- a/configs/corstone1000_defconfig
> > +++ b/configs/corstone1000_defconfig
> > @@ -1,69 +1,1618 @@
> 
> This wasn't done as savedefconfig, so I had to do a tiny bit of
> reworking to re-save it and then again on 3/3 for it to apply. In the
> future please make sure defconfig changes really are savedefconfig'd,
> thanks and applied to u-boot/master.

Sorry for the extra work done.

However, I already followed these steps to generate the defconfig.
The steps below show that generating the defconfig at the current commit level generates a .config identical to corstone1000_defconfig.
I used the HEAD of next. Please, am I missing something here ?

More details:

b055167ef05898075dc2b2fa3ea244f56932c75e (HEAD) corstone1000: add compressed kernel support
e29b932aa07fa0226d325b35d96cd4eea0370129 (origin/next) Merge branch '2023-09-30-Kconfig-updates' into next

$ make corstone1000_defconfig savedefconfig
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/kconfig/conf.o
  YACC    scripts/kconfig/zconf.tab.c
  LEX     scripts/kconfig/zconf.lex.c
  HOSTCC  scripts/kconfig/zconf.tab.o
  HOSTLD  scripts/kconfig/conf
#
# configuration written to .config
#
scripts/kconfig/conf  --savedefconfig=defconfig Kconfig
$ diff -pruN configs/corstone1000_defconfig .config 
$

Cheers,
Abdellatif
