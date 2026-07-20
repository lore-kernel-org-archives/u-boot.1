Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA400C44529
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 20:09:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A13536071D;
	Mon, 20 Jul 2026 20:09:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ux8QPSu2-dbP; Mon, 20 Jul 2026 20:09:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 42A33606A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784578145;
	bh=QWMKns+HJ2WEhn7CNq1QnwT8ldmpGbwWw+kwtSQX2Lo=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=BuRBsy3+ecHkWBtysh5/oZ2KXHtqbSfzc3GvjyWQfDAxPCcHKSLNjvdhEpzIAFJxi
	 +WwKbUDgyD+Ic1sOBq5UC8BCd3Pfw1jbuynm4oBlEhWna9fgLnFNvL6P2nCmaqwz6A
	 KQpVypDZm/PIw6y4SauHUFzwHl52xmPanJCGQVTWcQfPgZ9HjMkaHttajlc/rGoEfl
	 Z5rDhC+A+bYHBxz3XacnfiP9J1CBrgWpx+j6XeIL+tfmEMnKkmPv+7HTwHKiHRGkL/
	 0Y1owPyqJi8l2I6QyuTm+pb+YJt+bt2inTOdnXy+squ+vMgUa3u50uDz2HVYMYovXe
	 35X66a0Ap13vg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 42A33606A7;
	Mon, 20 Jul 2026 20:09:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 21F07DF0
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 20:09:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0833A606A7
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 20:09:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FKJkd9wUt5mC for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 20:09:03 +0000 (UTC)
X-Greylist: delayed 308 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 20 Jul 2026 20:09:02 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 8625260667
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8625260667
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=andriy.shevchenko@intel.com;
 receiver=<UNKNOWN> 
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8625260667
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 20:09:02 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8445B842FC; Mon, 20 Jul 2026 22:03:52 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA4CB82991
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 22:03:48 +0200 (CEST)
X-CSE-ConnectionGUID: 8FOqvojxTIiAaEGHsLam7A==
X-CSE-MsgGUID: E3/StYVtRxGYxsbPph5mww==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="84297837"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; d="scan'208";a="84297837"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 13:03:46 -0700
X-CSE-ConnectionGUID: hFo9ZM6GSN6DQbiG+GaE/A==
X-CSE-MsgGUID: N+YB9L/iSIiy6h6XdxxlAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; d="scan'208";a="256364630"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost)
 ([10.245.244.175])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 13:03:43 -0700
Date: Mon, 20 Jul 2026 23:03:41 +0300
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>,
 Raymond Mao <raymondmaoca@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v3 4/5] CI: Add an sjg-lab job for the Intel Edison
Message-ID: <al5_HaKU8CpvqSei@ashevche-desk.local>
References: <20260705104231.3846672-1-sjg@chromium.org>
 <20260705104231.3846672-5-sjg@chromium.org>
 <CAFLszTgC1SF3rS37GDXu6k1=6mcQTfSEA9UhrRX8nsqCdyLnxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTgC1SF3rS37GDXu6k1=6mcQTfSEA9UhrRX8nsqCdyLnxA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784577829; x=1816113829;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=bl0WS/9lz3kwKG7dDEFSwJnvgdGOMlQDjqCWjBjr6dU=;
 b=gL6C3O5zG/cti8Dk22EJCyN7q06CcefaGglOpW5FYzz1OhCIxuFksal3
 U3wWqFulsoYxo749RKSxC5XJU4fHmIYB2vYEw6LVR3GSrE5O6+a0rJ6JS
 Ej99UyYp2U2q0innXh10ZlkU4G/IKeDVdA9WRoEyNqHc2QLoihUWkoZv9
 o+4RBwxxQJVudBaPhQD+a6a5bUf/B51jpsyGSjIw7CLpjffx+OGpTvsdO
 RAa5cp0BtjZDE/tR0gmOXcwYBH/jJLQZBGkCIfXbMNGnFrDMERpOWu7mY
 Rt5PiSSM6PMWtUCdbZxghVG7jXGtKArVRf+B+RR8lzkyT1Npc39oFlCJp
 g==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=gL6C3O5z
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=andriy.shevchenko@intel.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=intel.com header.i=@intel.com header.b="gL6C3O5z"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Andy Shevchenko via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Andy Shevchenko <andriy.shevchenko@intel.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Mon, Jul 20, 2026 at 10:14:01AM -0600, Simon Glass wrote:
> On Sun, 5 Jul 2026 at 04:42, Simon Glass <sjg@chromium.org> wrote:


> > +# Intel Edison (Merrifield/Tangier); U-Boot sent over DFU into eMMC u-boot0
> > +edison:
> > +  variables:
> > +    ROLE: edison
> > +  <<: *sjg_lab_dfn
> 
> Unfortunately somehow the board seems to have died - does not appear
> on USB anymore...perhaps it doesn't like all the cycling in the lab?

Do you have external power supply connected?
It might be this:
https://edison-fw.github.io/edison-wiki/edison-fixup

-- 
With Best Regards,
Andy Shevchenko


