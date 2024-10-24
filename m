Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B317D0BB63
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 06:26:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9FEA892F3;
	Thu, 24 Oct 2024 08:26:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="QJ1q17M+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 193ED892E8; Thu, 24 Oct 2024 08:26:30 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6870382BA7
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 08:26:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=andriy.shevchenko@linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729751185; x=1761287185;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=P09N7UOKi/9HwcP25e7a0yyGUrODbPu/yuUikdeB3Ic=;
 b=QJ1q17M+Wwb5y40jV8xBT/DT4ro9T/4cOkMJ+vzcm97r0M3LUygx8ohu
 AmwBCZvNgszmLsEYRqp6+nyjiHZf7hZUj4dbWe57KvM0FmbIM8h+CpQ5w
 wRudNFbipQPgaN3LtgmQpXNoSKLKG8lwPTRL3D0iAD/2yagKD/0XcWXdS
 5HyYhxfK3igTOP54jFxvjiBqgbyjpEPOdiRxvpExdWloEKsfjXs+xyq1/
 A3bcN+DTZVymhn5fr/G2Mt/cM3wSfTgJa/XhIrv/07meAAwTZ8gCXPPSL
 FuohuplaXC+q1O7zFXSNYCgrLrnCJfEQ4KM5xLgWZ4cIOkp8rlbUYMij8 Q==;
X-CSE-ConnectionGUID: ML3nUy/+Sauom1ZmMz2sbg==
X-CSE-MsgGUID: Jn38OrRJSdKUmgvZyF3CSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="39953441"
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; d="scan'208";a="39953441"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2024 23:26:21 -0700
X-CSE-ConnectionGUID: Fahm8uxlS+WqNZIwvl75oA==
X-CSE-MsgGUID: DoFNN9F2R6+VJabcRY05LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; d="scan'208";a="85042104"
Received: from smile.fi.intel.com ([10.237.72.154])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2024 23:26:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1t3rIV-00000006TTz-0jyC; Thu, 24 Oct 2024 09:26:15 +0300
Date: Thu, 24 Oct 2024 09:26:14 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v1 1/1] efi_loader: Mark a function static
Message-ID: <ZxnohqlBa5LuIriK@smile.fi.intel.com>
References: <20241021140546.2969356-1-andriy.shevchenko@linux.intel.com>
 <CAC_iWjL1nUaKGb2kDK=7BKn1xgS3CitQ3FHP94VcwObjcMuuAQ@mail.gmail.com>
 <5fc1929f-c931-4c14-847b-6ea9333037d5@gmx.de>
 <ZxemNUOQ8UUQvAqO@smile.fi.intel.com>
 <5EB571BB-8963-4B47-86EC-1F1C5424D4F1@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5EB571BB-8963-4B47-86EC-1F1C5424D4F1@gmx.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
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

On Thu, Oct 24, 2024 at 07:03:24AM +0200, Heinrich Schuchardt wrote:
> Am 22. Oktober 2024 15:18:45 MESZ schrieb Andy Shevchenko <andriy.shevchenko@linux.intel.com>:
> >On Tue, Oct 22, 2024 at 08:02:46AM +0200, Heinrich Schuchardt wrote:
> >> On 10/21/24 16:40, Ilias Apalodimas wrote:
> >> > On Mon, 21 Oct 2024 at 17:06, Andy Shevchenko
> >> > <andriy.shevchenko@linux.intel.com> wrote:
> >> > > 
> >> > > efi_bootmgr_release_uridp_resource() is not used anywhere except
> >> > > the same file where it is defined. Mark it static.
> >> > > This helps avoiding the compiler warning:
> >> > > 
> >> > >    lib/efi_loader/efi_bootmgr.c:388:14: warning: no previous prototype for ‘efi_bootmgr_release_uridp_resource’ [-Wmissing-prototypes]
> >
> >> The function is called efi_bootmgr_release_uridp() since 292a4a4c7b77
> >> ("efi_loader: shorten efi_bootmgr_release_uridp_resource()").
> >
> >Thanks! The problem is that U-Boot doesn't have the latest tag (yet)
> >that includes this change. You can help with managing the conflict.
> 
> Patches should be based on origin/master (or origin/next once that branch is
> opened typically after -rc2) and not on tags.

I disagree. The problem with moving target that it's been moving...

The tags are very good to follow and easy to maintain and test and report
regressions against. What you are suggesting it's like virtually assigning
tag to very each commit and tell maintainer to cope with this chaos when
one does something in one "tag" out of 100500 ones and another person in
another "tag". So, consider tags as stabilisation points, or points of
stability. Then it's much easier to stick with a few tags that with 100500
commits.

-- 
With Best Regards,
Andy Shevchenko


