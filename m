Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37DCDC3DA6F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 16:17:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CBF386828;
	Thu, 24 Aug 2023 18:16:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="IzFXuBiE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC73986829; Thu, 24 Aug 2023 18:16:57 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EB49867EA
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 18:16:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37OGGln3120436;
 Thu, 24 Aug 2023 11:16:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692893807;
 bh=KGPbkcPNwDV/CnxACEcjHnzS084kyNcELz1gBcQKLio=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=IzFXuBiEduWXhuwkDJULNj7R1Vdt9MceCHv3HPgUJe63Me9A5sQHzXh0gntEoCmo8
 /UmfrYeIFEF+wHpHXwMhmwj+jHm6YQR4AcfUPmuitB8dFzX7BQRbQU0TaNcykb5U3a
 u+ddyy162dD9xbkoVILcCbSwXeqq6UCOUGSRJMJM=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37OGGlJg008105
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 24 Aug 2023 11:16:47 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 24
 Aug 2023 11:16:47 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 24 Aug 2023 11:16:47 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37OGGlfl084884;
 Thu, 24 Aug 2023 11:16:47 -0500
Date: Thu, 24 Aug 2023 11:16:47 -0500
From: Nishanth Menon <nm@ti.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
CC: <u-boot@lists.denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Neha Francis <n-francis@ti.com>, Tom Rini
 <trini@konsulko.com>
Subject: Re: [RFC PATCH 1/2] doc: sphinx: Add sphinx-prompt
Message-ID: <20230824161647.ymmf6c66tsfvpz7n@obsession>
References: <20230824154036.3650607-1-nm@ti.com>
 <20230824154036.3650607-2-nm@ti.com>
 <dafff1b7-fdf8-0578-64dc-82e15ca3f350@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <dafff1b7-fdf8-0578-64dc-82e15ca3f350@canonical.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

On 17:47-20230824, Heinrich Schuchardt wrote:
> On 24.08.23 17:40, Nishanth Menon wrote:
> > Sphinx-prompt[1] helps bring-in '.. prompt::' option that allows a
> > better rendered documentation, yet be able to copy paste without
> > picking up the prompt from rendered documentation.
> > 
> > [1] https://lore.kernel.org/all/87fs48rgto.fsf@baylibre.com/
> > Suggested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> 
> Looks good to me.
> 
> > ---
> > Version picked is the best that works with Sphinx 3.4.3
> > 
> >   doc/conf.py                 | 2 +-
> >   doc/sphinx/requirements.txt | 1 +
> >   2 files changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/doc/conf.py b/doc/conf.py
> > index 00f241366477..5e2ff1c8f5e2 100644
> > --- a/doc/conf.py
> > +++ b/doc/conf.py
> > @@ -39,7 +39,7 @@ needs_sphinx = '2.4.4'
> >   extensions = ['kerneldoc', 'rstFlatTable', 'kernel_include',
> >                 'kfigure', 'sphinx.ext.ifconfig', # 'automarkup',
> >                 'maintainers_include', 'sphinx.ext.autosectionlabel',
> > -              'kernel_abi', 'kernel_feat']
> > +              'kernel_abi', 'kernel_feat', 'sphinx-prompt']
> 
> We copied our conf.py from kernel.org. Please, check if it can be added
> upstream.

https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git/tree/Documentation/sphinx/requirements.txt

Looks pretty different though :(

> 
> /linux$ scripts/get_maintainer.pl Documentation/conf.py
> Jonathan Corbet <corbet@lwn.net> (maintainer:DOCUMENTATION)
> linux-doc@vger.kernel.org (open list:DOCUMENTATION)
> linux-kernel@vger.kernel.org (open list)
> bpf@vger.kernel.org (open list:BPF [MISC])
> 
> Does the extension exist on their minimum Sphinx version (1.7) or at least
> on the 2.24 in Documentation/requirements.txt?


Trying things out, looks like sphinx-prompt 1.5.0 will work with 2.4.4
as well.

I am just a sphinx newbie.. I can propose, but taking the job up of a
massive Documentation cleanup across kernel documentation is a bit
beyond my availability.

If you think this is the way forward, then I can propose to the kernel
list.

> 
> Best regards
> 
> Heinrich
> 
> >   #
> >   # cdomain is badly broken in Sphinx 3+.  Leaving it out generates *most*
> > diff --git a/doc/sphinx/requirements.txt b/doc/sphinx/requirements.txt
> > index 4f411f78d030..6ccbe527ee79 100644
> > --- a/doc/sphinx/requirements.txt
> > +++ b/doc/sphinx/requirements.txt
> > @@ -15,6 +15,7 @@ requests==2.31.0
> >   six==1.16.0
> >   snowballstemmer==2.2.0
> >   Sphinx==3.4.3
> > +sphinx-prompt==1.5.0
> >   sphinx-rtd-theme==1.0.0
> >   sphinxcontrib-applehelp==1.0.2
> >   sphinxcontrib-devhelp==1.0.2
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
