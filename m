Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B21D13570
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 07:56:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5418688744;
	Mon, 28 Oct 2024 08:56:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="mQgw4OsW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7967881FD; Mon, 28 Oct 2024 08:56:35 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3709589072
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 08:56:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=andriy.shevchenko@linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730102191; x=1761638191;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=XQg7+uehsAv7WWLN74cbCfX4Ef1o224fpwUjcKHLYyA=;
 b=mQgw4OsWqg3qmUw732Fd+tnWqXaDa54AMLDqeDxXn7AbNOThY4p09c/b
 s03Spzs4LjMXFMEanZOdbJhXLWwcixQw/Rf3iGKlNLX/SC1OEoqJC/2vr
 0UbHpbcVcoSsO0fo2WXizEh+0RP0/geVPxAhN9t9rptes1r9AXSCU0lkr
 g6oSEwmqlzX5Ysr+Rz4+eni8oNk7S8ck0NGR1VT3JT2YIPum70XMmh11i
 S0dhemEZ9RiY9zIOryXmw4UNy41VhVmOUc90nCpJQnU/bdy0ojrVQliMr
 0CHoG5jyNRaC6A6Fq6h6UWaN6YD6OWMYwgjORxZhfkQ/AiAdMpzGDts/W Q==;
X-CSE-ConnectionGUID: UiVJ9ob/Qj66SoIA0pTVIA==
X-CSE-MsgGUID: +MRKqOnMTdSVFK/svoSHIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29462050"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="29462050"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2024 00:56:17 -0700
X-CSE-ConnectionGUID: SgPTze8JQqCe40JQu0M2HA==
X-CSE-MsgGUID: rXS/FVaNS46vrwKl/uU20g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; d="scan'208";a="81593227"
Received: from smile.fi.intel.com ([10.237.72.154])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2024 00:56:16 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1t5Kbl-00000007rPu-0I6t; Mon, 28 Oct 2024 09:56:13 +0200
Date: Mon, 28 Oct 2024 09:56:12 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Bin Meng <bmeng.cn@gmail.com>
Subject: Re: enabling W=1 by default
Message-ID: <Zx9DnCc8XXIm7gts@smile.fi.intel.com>
References: <ZxZk4K4ff1T3gUVm@smile.fi.intel.com>
 <CAFLszTjuodDFZW8fJDL1Q3nByLVzcTTEAeJfws-sbtupCwNd8w@mail.gmail.com>
 <ZxenO05qCbt5IIZS@smile.fi.intel.com>
 <20241023-gizzard-untracked-4a1c6d2f6be6@thorsis.com>
 <ZxkNnJxVHSlxNjSV@smile.fi.intel.com>
 <CAC_iWj+adgo3Kyd_j77P3_OWzpad8xOB2Cc8NxsxQNrQrDRi2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC_iWj+adgo3Kyd_j77P3_OWzpad8xOB2Cc8NxsxQNrQrDRi2g@mail.gmail.com>
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

On Sat, Oct 26, 2024 at 11:10:40AM +0300, Ilias Apalodimas wrote:
> On Wed, 23 Oct 2024 at 17:52, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Wed, Oct 23, 2024 at 09:52:09AM +0200, Alexander Dahl wrote:
> > > Am Tue, Oct 22, 2024 at 04:23:07PM +0300 schrieb Andy Shevchenko:
> > > > On Mon, Oct 21, 2024 at 06:32:21PM +0200, Simon Glass wrote:
> > > > > On Mon, 21 Oct 2024 at 16:27, Andy Shevchenko
> > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > >
> > > > > > looking at the redness of the output of `make W=1` here is the question:
> > > > > > isn't it a good time to enable `make W=1` by default. Yes, I understand
> > > > > > the impact, but at least we can do it mandatory for a _new_ code submitted to
> > > > > > U-Boot, right?
> 
> I think this is a good idea and perhaps we can do it per subsystem. I
> cleaned up EFI a few years ago, but some new have crept in.
> I've sent a bunch of no brainer patches, once I clean all of it (and
> assuming it's doable), I 'll try enabling W=1 as the default for
> efi_loader

Thank you!

-- 
With Best Regards,
Andy Shevchenko


