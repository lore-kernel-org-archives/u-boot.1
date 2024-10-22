Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A88D2C54B
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 13:19:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CA7688FA5;
	Tue, 22 Oct 2024 15:18:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="J88T10Pz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02B31891E9; Tue, 22 Oct 2024 15:18:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F55789251
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 15:18:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=andriy.shevchenko@linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729603132; x=1761139132;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=3M2eQP9x41CIIet1RAI2fXMnVhzDzFT73ektuUJEECI=;
 b=J88T10PzrdN4n+hyY4KO2OGAnYh7y/XtYLzxbD8U9PH3zGhgKLheitTT
 HTX0rIchEYMqMZZ86CKx4MGhBpgcky8NS9mBi1dxV/1llNoLjRoF13Qu9
 MNepc6TJR5pLz1JbTcesIzJXCxMVlvYw4f3ihu57QFExt2mwWcW5O9BEM
 5TIZfiIfeaUrHC+TxZZtCYuo0B2kfZwREag50e1siHD2PQm8RaUERyKKc
 ASt7/DwFuF14lDZZhjr8SxPdpTHQ4ni4B5V9Fr8W7MsIQq4rPqnpC4tif
 U0W0gPNQDmPnK+fIIf/yFdDaMmelvedtiG/gAsybcqCtqPUWM2WBET02g Q==;
X-CSE-ConnectionGUID: /jWH574uRv6oD2ba+dcUFA==
X-CSE-MsgGUID: aECcxmxJRfuEqX49ccXTYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="46601935"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="46601935"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2024 06:18:50 -0700
X-CSE-ConnectionGUID: sir0JxyYS0azIxSBy/Qe6g==
X-CSE-MsgGUID: rbAeeud/R0emTzK8E9ptYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; d="scan'208";a="79779015"
Received: from smile.fi.intel.com ([10.237.72.154])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2024 06:18:48 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1t3Emb-00000005rA5-1gUF; Tue, 22 Oct 2024 16:18:45 +0300
Date: Tue, 22 Oct 2024 16:18:45 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v1 1/1] efi_loader: Mark a function static
Message-ID: <ZxemNUOQ8UUQvAqO@smile.fi.intel.com>
References: <20241021140546.2969356-1-andriy.shevchenko@linux.intel.com>
 <CAC_iWjL1nUaKGb2kDK=7BKn1xgS3CitQ3FHP94VcwObjcMuuAQ@mail.gmail.com>
 <5fc1929f-c931-4c14-847b-6ea9333037d5@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5fc1929f-c931-4c14-847b-6ea9333037d5@gmx.de>
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

On Tue, Oct 22, 2024 at 08:02:46AM +0200, Heinrich Schuchardt wrote:
> On 10/21/24 16:40, Ilias Apalodimas wrote:
> > On Mon, 21 Oct 2024 at 17:06, Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > 
> > > efi_bootmgr_release_uridp_resource() is not used anywhere except
> > > the same file where it is defined. Mark it static.
> > > This helps avoiding the compiler warning:
> > > 
> > >    lib/efi_loader/efi_bootmgr.c:388:14: warning: no previous prototype for ‘efi_bootmgr_release_uridp_resource’ [-Wmissing-prototypes]

> The function is called efi_bootmgr_release_uridp() since 292a4a4c7b77
> ("efi_loader: shorten efi_bootmgr_release_uridp_resource()").

Thanks! The problem is that U-Boot doesn't have the latest tag (yet)
that includes this change. You can help with managing the conflict.

-- 
With Best Regards,
Andy Shevchenko


