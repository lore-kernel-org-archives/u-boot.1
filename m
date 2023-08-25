Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36759C79F61
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 14:02:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85ECD86A57;
	Fri, 25 Aug 2023 16:02:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="X8uuTrlu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFF4B86A7D; Fri, 25 Aug 2023 16:02:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C89F8680E
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 16:02:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=andriy.shevchenko@linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1692972157; x=1724508157;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=yi/nrPJpaSMeQI77vpxHaj064stV7fON/JmDJwfUpfY=;
 b=X8uuTrluqPRF+k3pamElHfmP95ORVbvJhP+VHzVubfTLNQS9O4xZpH2n
 WQYNRV86z3wEdkHrv440jz4oPzDc7hksiuj4uWOQRzlP2hWX4zWlmBX7t
 FQl3hLa3yaiZ7be4lxLr/TsU+bK5JHPpkiK9tXBA531jx2L27ly+LwV61
 h14ToSuWfLgJDhGxfoKFoXbkMwBkx22JjHAoP/71xvlAnefbgiDKwevQS
 jcDIA7jF/1j31FRLvppfBvAbqwGdjERhDiUcGN0xzfbev5Fm4ShAaoI9I
 MX6m2Hg7MncN2TpD/nVVPLuRTTk9pGEaoZ6FuF9ioEmu113lCHrf7JBiI g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="354247306"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; d="scan'208";a="354247306"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2023 07:02:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="911288535"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; d="scan'208";a="911288535"
Received: from smile.fi.intel.com ([10.237.72.54])
 by orsmga005.jf.intel.com with ESMTP; 25 Aug 2023 07:02:02 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1qZXNw-002lbV-1u; Fri, 25 Aug 2023 17:02:00 +0300
Date: Fri, 25 Aug 2023 17:02:00 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Bin Meng <bmeng.cn@gmail.com>
Subject: Re: [PATCH v1 2/2] x86: Prevent from missing the FADT chaining
Message-ID: <ZOi0WOZZTnJC/mMR@smile.fi.intel.com>
References: <ZOisRZBQQJDW/Pco@smile.fi.intel.com>
 <20230825135141.3210006-1-andriy.shevchenko@linux.intel.com>
 <20230825135141.3210006-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825135141.3210006-2-andriy.shevchenko@linux.intel.com>
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

On Fri, Aug 25, 2023 at 04:51:41PM +0300, Andy Shevchenko wrote:

...

> +static inline int acpi_add_fadt(struct acpi_ctx *ctx, struct acpi_fadt *fadt)
> +{
> +	acpi_add_table(ctx, fadt);
> +	acpi_inc(ctx, sizeof(struct acpi_fadt));
> +	return 0;
> +}

Ideally it should be like

	int ret;

	ret = acpi_add_table(ctx, fadt);
	if (ret)
		return ret;

	acpi_inc(ctx, sizeof(struct acpi_fadt));

	return 0;

-- 
With Best Regards,
Andy Shevchenko


