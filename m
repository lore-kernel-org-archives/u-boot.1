Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD28CF5399
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 14:52:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5516289092;
	Wed, 23 Oct 2024 16:52:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="GH7kP8Ei";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DFE98912A; Wed, 23 Oct 2024 16:52:21 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D65089024
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 16:52:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=andriy.shevchenko@linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729695139; x=1761231139;
 h=date:from:to:subject:message-id:references:mime-version:
 in-reply-to; bh=747De215ydzfZq7orasBKM2POiX8hIzCAbJaqL2Bfp8=;
 b=GH7kP8EiL4wcDUwNM59cZpJ14+U4AIARy/mdPU8u3gFpa7nQj0mup0Z1
 NM1F1XxpdOZGSzrh9NRaStBGRFCADDNTM81vmrdX2bN4cio3TKcF3AuOH
 DZ4uOKEaMjKFmQNFhSaE/eNksus2dsJX/Ua5lrhHxDQmQSgRrpE4cw2IH
 pZByTdlODGTnaCA9fy+IVIg6bhLn19dXD0BHsGkPbOaQg0PgvJWX/7mDO
 33Ykf0XOHrF/QFMJHsOO0YGOCmF2EPjXZGXl1wVWTsGQs/XwJ3++wsoGw
 QROsM1nhTqwMihGcg8I/hzF1vXBKscnUyR6cnqLiely+GjcaLeVzSsuiK A==;
X-CSE-ConnectionGUID: 7dBdlFs7SA+Fvuplx8UW0g==
X-CSE-MsgGUID: 5/RVvSsvTqKzHJ4/InBoZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="29391033"
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; d="scan'208";a="29391033"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2024 07:52:17 -0700
X-CSE-ConnectionGUID: vXcVeeKISH+mIb7RtlkLvw==
X-CSE-MsgGUID: wc0uc2WvSTakKQOobSOStw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; d="scan'208";a="79902011"
Received: from smile.fi.intel.com ([10.237.72.154])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2024 07:52:15 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1t3cia-00000006F9z-2bum; Wed, 23 Oct 2024 17:52:12 +0300
Date: Wed, 23 Oct 2024 17:52:12 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Bin Meng <bmeng.cn@gmail.com>
Subject: Re: enabling W=1 by default
Message-ID: <ZxkNnJxVHSlxNjSV@smile.fi.intel.com>
References: <ZxZk4K4ff1T3gUVm@smile.fi.intel.com>
 <CAFLszTjuodDFZW8fJDL1Q3nByLVzcTTEAeJfws-sbtupCwNd8w@mail.gmail.com>
 <ZxenO05qCbt5IIZS@smile.fi.intel.com>
 <20241023-gizzard-untracked-4a1c6d2f6be6@thorsis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023-gizzard-untracked-4a1c6d2f6be6@thorsis.com>
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

On Wed, Oct 23, 2024 at 09:52:09AM +0200, Alexander Dahl wrote:
> Am Tue, Oct 22, 2024 at 04:23:07PM +0300 schrieb Andy Shevchenko:
> > On Mon, Oct 21, 2024 at 06:32:21PM +0200, Simon Glass wrote:
> > > On Mon, 21 Oct 2024 at 16:27, Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > >
> > > > looking at the redness of the output of `make W=1` here is the question:
> > > > isn't it a good time to enable `make W=1` by default. Yes, I understand
> > > > the impact, but at least we can do it mandatory for a _new_ code submitted to
> > > > U-Boot, right?
> > > >
> > > > Ideally I would have what Linux kernel has for a few releases already, i.e.
> > > > Werror by default and getting close to make a clean builds with that and
> > > > make W=1` at least against default configurations (yeah, with U-Boot there is
> > > > probably no default, but sandbox one).
> > > 
> > > Warnings should be warnings...
> > 
> > Yes, and ideally the code should not have warnings, right?
> 
> +1
> 
> > Otherwise how can we do better? It's quite similar to what you wrote WRT
> > documenting the function prototypes, the same applies to the new contribution
> > WRT `make W=1`.
> > 
> > > if you would like to enable it for CI that is fine by me,
> > 
> > Yes, that's the idea, but I'm not the owner of any U-Boot CIs,
> > hence it's a proposal.
> > 
> > > but the U-Boot makefile shouldn't do it. It defeats the purpose of
> > > having a distinction between errors and warnings.
> > 
> > While it's not what I wanted, I disagree on your comment. The idea is to make
> > rules stricter (for new code) to make it better and that's why Linus enabled
> > Werror by default in the Linux kernel. And personally I consider that as a good
> > thing to follow.
> 
> Long term experience: each time you upgrade your toolchain you get new
> warnings.  Each package (u-boot, kernel, userland, does not matter
> which) enabling -Werror breaks the BSP build.  What should a developer
> do then?  Fix each warning in each foreign project and bring it
> upstream?  Or disable -Werror?  Last thing is what is usually done.
> You can see several patches in buildroot or ptxdist disabling -Werror
> for this reason.

That's why the set of enabled/disabled warnings are spread over W=<n> and hence
hidden when known to be PITA. W=1 is kinda special in a sense that we put the
warnings that might affect code generation, size of the binary, etc. In some cases
it even might prevent security bugs.

-- 
With Best Regards,
Andy Shevchenko


