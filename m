Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52B54C83F1B
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 15:28:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8373582F49;
	Mon, 14 Jul 2025 17:28:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="yDdZO4++";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D49B82FC7; Mon, 14 Jul 2025 17:28:41 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EBE282E37
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 17:28:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56EFSXmt2404502;
 Mon, 14 Jul 2025 10:28:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1752506913;
 bh=WqhRyL/N+rf2/HgmiZBl6IUqLBszfcaXnZUBQaKh2oo=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=yDdZO4++tJ+Amw0Z79eLbeCGc346NYWYZWYjyS1yaG9an9FDdxugvrY0u2lQo9BEt
 Z/t+pxcgWJWZw0J6i4Zl0z5PIB9juSx3yWTDqsWwS0sWIwcMzilh+bzCb4bQNDmsdu
 1jXHQLDQvdFLYUZNx+fS+oXsdBFJGnMOUq2Z4BcQ=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56EFSXUu3999785
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 14 Jul 2025 10:28:33 -0500
Received: from lewvowa01.ent.ti.com (10.180.75.79) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 14
 Jul 2025 10:28:32 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by lewvowa01.ent.ti.com
 (10.180.75.79) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2507.55; Mon, 14 Jul
 2025 10:28:32 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 14 Jul 2025 10:28:32 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56EFSWGd939652;
 Mon, 14 Jul 2025 10:28:32 -0500
Date: Mon, 14 Jul 2025 10:28:32 -0500
From: Bryan Brattlof <bb@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Yannic Moog <Y.Moog@phytec.de>, Simon Glass <sjg@chromium.org>, "Alper
 Nebi Yasak" <alpernebiyasak@gmail.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Tim Harvey <tharvey@gateworks.com>
Subject: Re: [PATCH v2] binman: Fix typing for python >= 3.5
Message-ID: <20250714152832.kgaiwnqqc45umxju@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20250714-binman-typing-fix-v2-1-dbe6519c43a0@phytec.de>
 <20250714120228.hkxkjzlxapyo4mmw@bryanbrattlof.com>
 <86c6b776c425e422290f72830d6a568123f740b5.camel@phytec.de>
 <20250714135657.fpa35alz45otqyj2@bryanbrattlof.com>
 <20250714142920.GE13084@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250714142920.GE13084@bill-the-cat>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

On July 14, 2025 thus sayeth Tom Rini:
> On Mon, Jul 14, 2025 at 08:56:57AM -0500, Bryan Brattlof wrote:
> > On July 14, 2025 thus sayeth Yannic Moog:
> > > Am Montag, dem 14.07.2025 um 07:02 -0500 schrieb Bryan Brattlof:
> > > > On July 14, 2025 thus sayeth Yannic Moog:
> > > > > To make it work with python 3.5 and 3.6, need type hints from the
> > > > > typing module.
> > > > > 
> > > > > Reported-by: Tim Harvey <tharvey@gateworks.com>
> > > > > Fixes: 21bc3433a43d ("binman: rework dropping absent entries from packaged
> > > > > image")
> > > > > Signed-off-by: Yannic Moog <y.moog@phytec.de>
> > > > > ---
> > > > > Changes in v2:
> > > > > - drop newline changes
> > > > > - Link to v1:
> > > > > https://lore.kernel.org/r/20250711-binman-typing-fix-v1-1-66ab075015ac@phytec.de
> > > > > ---
> > > > >  tools/binman/etype/cbfs.py    | 3 ++-
> > > > >  tools/binman/etype/mkimage.py | 3 ++-
> > > > >  tools/binman/etype/section.py | 3 ++-
> > > > >  3 files changed, 6 insertions(+), 3 deletions(-)
> > > > > 
> > > > > diff --git a/tools/binman/etype/cbfs.py b/tools/binman/etype/cbfs.py
> > > > > index
> > > > > 5879f377231bf94697bea97c3cfc3a2515665b8f..c5e77f3a0df22ff768aa7254e4dd9ecbe6
> > > > > f81684 100644
> > > > > --- a/tools/binman/etype/cbfs.py
> > > > > +++ b/tools/binman/etype/cbfs.py
> > > > > @@ -6,6 +6,7 @@
> > > > >  #
> > > > >  
> > > > >  from collections import OrderedDict
> > > > > +from typing import Dict
> > > > 
> > > > It's been a while from my Python days so I'm still trying to understand 
> > > > what's going on, but my understanding is the 'typing' module is 
> > > > considered deprecated after Python 3.9 with PEP 589[0]
> > > 
> > > That is correct. Afaik it is supposed to be removed with 3.14. (Source: Fluent
> > > Python 2nd Edition).
> > > Python 3.6 (and 3.5) does not have access to __futures__.annotations, that is
> > > why I asked if we strive for python >= 3.5 support or >= 3.7.
> > > 
> > > So it seems to me there are two paths:
> > > 
> > > - remove type annotations again.
> > > - when this typing module gets removed, migrate and require python >= 3.7
> > > 
> > > What do you think is the best course of action?
> > > 
> > 
> > Grepping around some more it looks like mbedtls is still using the 
> > typing module so it's probably fine for now. Though I think 3.14 will 
> > be available by October this year and just in time for this next 
> > release :/
> > 
> > Going off Python's version status page[0] it looks like we're safe to 
> > move the minimum requirement to 3.6 or 3.7. Python 3.5 isn't even 
> > listed as end-of-life anymore.
> > 
> > Debian's oldstable (bullseye) seems to be using 3.9[1]
> > Ubuntu's 22.04 (Jammy) seems to use 3.10[2]
> > Yocto's Dunfell is using 3.8[3]
> > 
> > I seem remember Rocky 8 using 3.6 but I can't find a source for that.
> > 
> > It seems like we should look into bumping the minimum version but I 
> > tend to refresh my system a little more often so I don't know what 
> > pain this would cause others
> > 
> > [0] https://devguide.python.org/versions/
> > [1] https://wiki.debian.org/Python
> > [2] https://packages.ubuntu.com/search?keywords=python3
> > [3] https://github.com/openembedded/openembedded-core/blob/c4fb7d1f0f157ffafd9f907f49ea74b93b2c1d40/meta/recipes-devtools/python/python3_3.8.18.bb#L67
> 
> We partly hit this because Ubuntu 20.04 is on, uh, I forget what Tim
> said now. But I really like to be able to say we work on the oldest
> still supported common LTS distributions. We may have to bump to 3.7 or
> newer after v2025.10 so that we don't run in to too many problems with
> bleeding edge distributions instead.

Ah OK yeah that works for me. I wish Python would be a little better 
with their versions :/

Reviewed-by: Bryan Brattlof <bb@ti.com>

~Bryan
