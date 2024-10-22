Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C020FD2C54B
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 13:23:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C5C388EBA;
	Tue, 22 Oct 2024 15:23:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="UkVrHn+Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE54088D3A; Tue, 22 Oct 2024 15:23:16 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6075988EC9
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 15:23:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=andriy.shevchenko@linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729603394; x=1761139394;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=1Lv7ymDDZd59Q8fZfJ0+pHJXUC4qpVeslKnop1svuCg=;
 b=UkVrHn+QoXGY3T4PtGmZQWflL0FoZGQBT+MjU5L/YNTQ3LYwXQtkKZN5
 /BCh9IE3anOGikeVNNGz4NkxSBoKt5pLTxzEg7Pfc79CrDikwU48Rp7kl
 JhrP61V8HllkpRfkzQ+w4WKemt2SOnqFOvQGscQVaAkwm57OlyTh5hIhv
 nOt7hG0BiFoAMmT56AZ6vrLVZocwVwyB/Ufj77mF0tQvTZW4KEGvGsf6W
 uOMD9+FaO8PmWzwLIadQQaXBNXZddN8kHXOY+VFbn8/NRfcBTF/FuYnX4
 LP9/l9o/VfDquEAZ1eSxEVJ1VJq14lBFF5vbYZd3jKlSJ5IO2JVusZ6RD g==;
X-CSE-ConnectionGUID: lx0Nuzl+TxmUT4iWrp4t4Q==
X-CSE-MsgGUID: O1wwRfWtS1K75iySzKYNcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="29344352"
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; d="scan'208";a="29344352"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2024 06:23:12 -0700
X-CSE-ConnectionGUID: EFinJMvzSIuexDIuh+ixDQ==
X-CSE-MsgGUID: B5/2/EoUQzmNEEebzL3mHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; d="scan'208";a="80050113"
Received: from smile.fi.intel.com ([10.237.72.154])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2024 06:23:11 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1t3Eqq-00000005rEN-0vX3; Tue, 22 Oct 2024 16:23:08 +0300
Date: Tue, 22 Oct 2024 16:23:07 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Bin Meng <bmeng.cn@gmail.com>
Subject: Re: enabling W=1 by default
Message-ID: <ZxenO05qCbt5IIZS@smile.fi.intel.com>
References: <ZxZk4K4ff1T3gUVm@smile.fi.intel.com>
 <CAFLszTjuodDFZW8fJDL1Q3nByLVzcTTEAeJfws-sbtupCwNd8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTjuodDFZW8fJDL1Q3nByLVzcTTEAeJfws-sbtupCwNd8w@mail.gmail.com>
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

On Mon, Oct 21, 2024 at 06:32:21PM +0200, Simon Glass wrote:
> On Mon, 21 Oct 2024 at 16:27, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > looking at the redness of the output of `make W=1` here is the question:
> > isn't it a good time to enable `make W=1` by default. Yes, I understand
> > the impact, but at least we can do it mandatory for a _new_ code submitted to
> > U-Boot, right?
> >
> > Ideally I would have what Linux kernel has for a few releases already, i.e.
> > Werror by default and getting close to make a clean builds with that and
> > make W=1` at least against default configurations (yeah, with U-Boot there is
> > probably no default, but sandbox one).
> 
> Warnings should be warnings...

Yes, and ideally the code should not have warnings, right?

Otherwise how can we do better? It's quite similar to what you wrote WRT
documenting the function prototypes, the same applies to the new contribution
WRT `make W=1`.

> if you would like to enable it for CI that is fine by me,

Yes, that's the idea, but I'm not the owner of any U-Boot CIs,
hence it's a proposal.

> but the U-Boot makefile shouldn't do it. It defeats the purpose of
> having a distinction between errors and warnings.

While it's not what I wanted, I disagree on your comment. The idea is to make
rules stricter (for new code) to make it better and that's why Linus enabled
Werror by default in the Linux kernel. And personally I consider that as a good
thing to follow.

-- 
With Best Regards,
Andy Shevchenko


