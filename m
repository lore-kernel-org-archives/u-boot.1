Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3BF4C4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 12:52:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF44887773;
	Wed, 29 Nov 2023 13:51:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C98D186EA3; Wed, 29 Nov 2023 11:07:13 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67564869F7
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 11:07:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=andy.shevchenko@gmail.com
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="392002749"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; d="scan'208";a="392002749"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Nov 2023 02:07:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="942268304"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; d="scan'208";a="942268304"
Received: from smile.fi.intel.com ([10.237.72.54])
 by orsmga005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Nov 2023 02:07:07 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
 (envelope-from <andy.shevchenko@gmail.com>)
 id 1r8HTE-00000000PTW-1fw1; Wed, 29 Nov 2023 12:07:04 +0200
Date: Wed, 29 Nov 2023 12:07:04 +0200
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>
Subject: Re: [PATCH v1 1/1] Makefile.lib: Always rebuild DSDT
Message-ID: <ZWcNSPgiVXcVbbTL@smile.fi.intel.com>
References: <20211020123742.31098-1-andriy.shevchenko@linux.intel.com>
 <CAPnjgZ048LVSrHZxveOZKfai2tHGmuwiTc4d9LR4gUx6e5M0dQ@mail.gmail.com>
 <CAHp75Vf-xRgwmfQp3ypp1h2RCdP3Vvv2hm2ndZtOUuUgsj0auQ@mail.gmail.com>
 <CAPnjgZ0BhPdk2OwpKx0zJUev3OLfVY9LLO=f7OFM4zMVe=Ja6Q@mail.gmail.com>
 <YXb8/ZOGh8zaFNkb@smile.fi.intel.com>
 <YkQhFc07R2pOMyyR@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkQhFc07R2pOMyyR@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Mailman-Approved-At: Wed, 29 Nov 2023 13:51:59 +0100
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

On Wed, Mar 30, 2022 at 12:21:25PM +0300, Andy Shevchenko wrote:
> On Mon, Oct 25, 2021 at 09:52:45PM +0300, Andy Shevchenko wrote:
> > On Mon, Oct 25, 2021 at 09:18:56AM -0600, Simon Glass wrote:
> > > On Mon, 25 Oct 2021 at 01:34, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > > On Sun, Oct 24, 2021 at 11:00 PM Simon Glass <sjg@chromium.org> wrote:
> > > > > On Wed, 20 Oct 2021 at 06:37, Andy Shevchenko
> > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > >
> > > > > > The dsdt.asl is usually combined out of several files that are included
> > > > > > in the main one. Whenever we change the content of any of such files,
> > > > > > build system is not able to recognize them. Hence the easiest way is to
> > > > > > force DSDT rebuild each time we run make.
> > > >
> > > > > Ick. Since it uses #include, doesn't the dependency generation work with this?
> > > >
> > > > How?
> > > 
> > > If you do a sandbox build you will see this file:
> > > 
> > > arch/sandbox/dts/.sandbox.dtb.cmd
> > > 
> > > It contains the dependencies used to compile the device tree. Can we
> > > use the same mechanism? There is a .cmd file for the dsdt file but it
> > > does not seem to have the correct contents.
> > 
> > A spent more than couple of hours to fight with `make` and failed.
> > Maybe you can improve the below (it still rebuilds always)
> 
> So, can we fix this annoying bug, please?

Any news here? If no other solution, please apply this patch.

-- 
With Best Regards,
Andy Shevchenko


