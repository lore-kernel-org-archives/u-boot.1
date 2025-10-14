Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7936ACCD184
	for <u-boot@archiver.kernel.org>; Tue, 14 Oct 2025 12:16:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1613982B20;
	Tue, 14 Oct 2025 14:16:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=psihoexpert.ro
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=psihoexpert.ro header.i=@psihoexpert.ro header.b="pYyPHTr2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EB50830E4; Tue, 14 Oct 2025 14:16:07 +0200 (CEST)
Received: from mx1.wiredblade.com (mx1.wiredblade.com [162.216.242.35])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CB7D8206E
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 14:16:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=psihoexpert.ro
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m95d+git@psihoexpert.ro
dkim-signature: v=1; a=rsa-sha256; d=psihoexpert.ro; s=dynu;
 c=relaxed/relaxed; q=dns/txt;
 h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:In-Reply-To:References;
 bh=/qGWnQCwfm6lrAbD9RD00/Z83fUvBmFzv5/bke7mIPw=;
 b=pYyPHTr2dk3NmK68Tq844OPV/H1dOXNy7Q86v7qvHcGEGJXMyBJCsJsKlEWdxKDlUZfmFWKp+fn9BTkfcupAV1J1r2D9IuGgUXtiMD6G98R6gpx3W4IXW9DVPzqrpntOswRafFLel+77OyVap2qmYMsBFawCJBbuHPLpA401Azg716qO4lxxhm0/cVTPNRUa6sluljcRdwSvUkPZVsrRllHPxMfyjriqSqdFOjynqqcqnljZ2plRM5MxvJ
 Wf+eo2umIh9knVx58K5WRPQ9pqWbydB9CTcm3H0gKww46vi8mSjjofUZEiQ+Gciuy2dH7Z/ZgEN106Kpbm23D6pPWcmg==
Received: from GRAPHRT (188-24-192-7.rdsnet.ro [188.24.192.7])
 by mx1.wiredblade.com with ESMTPSA
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256)
 ; Tue, 14 Oct 2025 12:15:50 +0000
Date: Tue, 14 Oct 2025 15:15:57 +0300
From: Marius Dinu <m95d+git@psihoexpert.ro>
To: Tom Rini <trini@konsulko.com>
Cc: Marius Dinu <m95d+git@psihoexpert.ro>, u-boot@lists.denx.de
Subject: Re: [PATCH 2/2] timer: Mark this as incompatible with SYS_ARCH_TIMER
Message-ID: <aO4+/Z9bFa2PSQhp@GRAPHRT>
References: <20250813205511.3420638-1-trini@konsulko.com>
 <20250813205511.3420638-2-trini@konsulko.com>
 <aJ4OR2rhl6eFV3GE@GRAPHRT> <20250814164021.GM124814@bill-the-cat>
 <aJ4mqWaJuJ0Ka+28@GRAPHRT> <20251011180023.GL298503@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251011180023.GL298503@bill-the-cat>
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

On Sat, 2025-10-11 12.00.23 +-0600, Tom Rini wrote:
> On Thu, Aug 14, 2025 at 09:10:49PM +0300, Marius Dinu wrote:
> > On Thu, 2025-08-14 10.40.21 +-0600, Tom Rini wrote:
> > > On Thu, Aug 14, 2025 at 07:26:47PM +0300, Marius Dinu wrote:
> > > > On Wed, 2025-08-13 14.55.11 +-0600, Tom Rini wrote:
> > > > > The timers implemented under SYS_ARCH_TIMER are not part of the TIMER
> > > > > framework and thus cannot be enabled at the same time. Express this
> > > > > dependency in Kconfig and add a note to the help of SYS_ARCH_TIMER.
> > > > > 
> > > > > Reported-by: Marius Dinu <m95d+git@psihoexpert.ro>
> > > > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > > > ---
> > > > > Marius, I ended up reworking things a bit (and also found part 1/2 of
> > > > > this series) but please let me know if you feel this should retain your
> > > > > Author and such instead. Thanks!
> > > > 
> > > > No need for credits.
> > > 
> > > OK.
> > > 
> > > > I think you should keep the warning message in the Timer drivers menu.
> > > > It provides a quick explanation why the menu is empty.
> > > 
> > > I thought about it, and we don't do anything like that for other
> > > either/or choices, and it's now in the help text itself at least. The
> > > other thing however, is that a few platforms do allow for both, because
> > > they play some games with CFG_SYS_TIMER* defines. So I'm not entirely
> > > sure what to do here.
> > > 
> > > > Bugs are reported in this mailing list too?
> > > 
> > > Yes.
> > > 
> > > -- 
> > > Tom
> > 
> > With the original patch I only tried to reduce the number of compilation
> > failures. I encounter a lot. I'm no expert and I can only try to fix little
> > things such as this one.
> > 
> > I belive some people (like myself) would be confused by an empty menu and
> > would not immediately remember the SYS_ARCH_TIMER in a completely different
> > part of menuconfig.
> > 
> > 
> > I tried to find configs with both CONFIG_SYS_ARCH_TIMER and CONFIG_TIMER
> > enabled amd I couldn't find any. So it's probably OK to leave the patch as it
> > is and exceptions, if needed, can be added later.
> 
> I haven't forgotten about this, sorry. I'm just debating with myself
> what's best here, because another part of the proper solution is that we
> should get the generic ARMv8 timer on moved to the framework too, but
> it's more easily said than done, but I have asked some people to look in
> to it.
> 
> -- 
> Tom

No hurry. Take your time.

Marius

