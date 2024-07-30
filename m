Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7173C3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 12:59:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59C5E889E9;
	Wed, 31 Jul 2024 14:59:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=comcast.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=comcast.net header.i=@comcast.net header.b="pvBmMIow";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A15D388821; Tue, 30 Jul 2024 16:27:25 +0200 (CEST)
Received: from resqmta-c2p-546593.sys.comcast.net
 (resqmta-c2p-546593.sys.comcast.net [IPv6:2001:558:fd00:56::8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84C0487E62
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 16:27:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=comcast.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fventuri@comcast.net
Received: from resomta-c2p-555922.sys.comcast.net ([96.102.18.230])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 256/256 bits)
 (Client did not present a certificate)
 by resqmta-c2p-546593.sys.comcast.net with ESMTPS
 id Ym8Hsyi2BVY9BYnousUG2v; Tue, 30 Jul 2024 14:27:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
 s=20190202a; t=1722349640;
 bh=cqyrFSqBpYVnatQItbQBbNajHJfydisFm1rhE2YIG3s=;
 h=Received:Received:Date:From:To:Message-ID:Subject:MIME-Version:
 Content-Type:Xfinity-Spam-Result;
 b=pvBmMIow892HAmkkYorneT2sHsDoTeXWBW08DxOlFh9WuLxfmFoMyPcIxzYZzDgAD
 eBhcJF+E/e55N+S+5smIDxgJJ+NBcRTd/1LT3X0Xf+y8WmiNdndQARGco588r17vYd
 qpt9VgBlWgsJDvv9wNR947pW5faGFZt8mQMLWfrRMrxQKdlJyNCujS3tdlVd7tkTP0
 WRUzC/5+UXM4ppkFjxZBF8218lnV9jPnwUgeMHnWmwZ6/mSPTUcxk5OCReus8iArKk
 f9SUMjRcbMYXpvc2nZPUmpJH7nisr1jTOx4QACL+NPn4O2ZQYUyU4linpk2WXWHq1S
 dTT4xHZVHgK9A==
Received: from oxapp-ch2f-71o.email.comcast.net ([96.117.87.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 256/256 bits)
 (Client did not present a certificate)
 by resomta-c2p-555922.sys.comcast.net with ESMTPS
 id YnoXshUw8o31gYnoXsqgQv; Tue, 30 Jul 2024 14:26:58 +0000
Date: Tue, 30 Jul 2024 10:26:57 -0400 (EDT)
From: Franco VENTURI <fventuri@comcast.net>
To: Peng Fan <peng.fan@nxp.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Tom Rini <trini@konsulko.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>
Message-ID: <106755270.238150.1722349617215@connect.xfinity.com>
In-Reply-To: <DB9PR04MB8461F1E0FC7BC664F4924C0788B02@DB9PR04MB8461.eurprd04.prod.outlook.com>
References: <20240730133043.12577-1-fventuri@comcast.net>
 <DB9PR04MB8461F1E0FC7BC664F4924C0788B02@DB9PR04MB8461.eurprd04.prod.outlook.com>
Subject: RE: [PATCH v1] mmc: fix signed vs unsigned compare in read check in
 _spl_load()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev59
X-Originating-IP: ::ffff:76.18.214.183
X-Originating-Client: open-xchange-appsuite
X-CMAE-Envelope: MS4xfCEOlHvEqF7qbJi7qQ/A+58rBkdZ+gm0UAy+p3iylLKiSYgqvBDcZ3BiSarEFTWP4aGEjVplvJdzqqLYWLvS1s0VxGmOXbWvMBaNyIClA5dTicND2qJq
 hwSStPH7KTmCRD4zVo86PzWKBjLhMEKUVuBf5WLEuQkiJIwTakjOQscv2S4UihbKfsPPSiAf+wqP34K173hjeASYSrf5TLK5R7EsYUtwCx1Nxw2kJLkiZ8J/
 aZLNGC9imqn8bPig2BddSkjHmrSSH6AOyGbEoWmIkqtI5YV87yHCK+qwyQeHM943Wq50CwP0K+IVyglGzW2VO0bayjr+DpahIU3mfYiD9RNZEkjvJt8DEPjC
 4cxBuGtT
X-Mailman-Approved-At: Wed, 31 Jul 2024 14:59:20 +0200
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

Peng,
no, with just the condition 'read < sizeof(*header)', the variable 'read' (which is a signed integer) will be converted ('balanced') to unsigned to match the type of 'sizeof()' as per the C standard specification (see https://stackoverflow.com/a/17294164).

This means that a value read = -2 will be converted to unsigned  0xFFFFFFFE, the comparison 'read < sizeof(*header)' will be false, and the _spl_load() function will not return -EIO

In order to fix this bug one has to check first if the value of 'read' is negative *and* then check 'read' against 'sizeof(*header)'.

Hope this makes sense,
Franco
 

> On 07/30/2024 9:45 AM EDT Peng Fan <peng.fan@nxp.com> wrote:
> 
>  
> > Subject: [PATCH v1] mmc: fix signed vs unsigned compare in read
> > check in _spl_load()
> > 
> > Fix signed vs unsigned compare in read check in _spl_load()
> > 
> > Issue: when info->read() returns a negative value because of an error,
> >        the comparison of 'read' (signed) with 'sizeof(*header)'
> >        (unsigned silently converts the negative value into a very
> >        large unsigned value and the check on the error condition
> >        always return false, i.e. the error is not detected
> > Symptoms: if spl_load_image_fat() is unable to find the file 'uImage',
> >           the SPL phase of the boot process just hangs after displaying
> >           the following line:
> >           Trying to boot from MMC1
> > Fix: first check if 'read' is negative then check its value against
> >      'sizeof(*header)'
> > Reference:
> > 
> > Signed-off-by: Franco Venturi <fventuri@comcast.net>
> > ---
> > 
> >  include/spl_load.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/spl_load.h b/include/spl_load.h index
> > 1c2b296c0a..1e05599d29 100644
> > --- a/include/spl_load.h
> > +++ b/include/spl_load.h
> > @@ -22,7 +22,7 @@ static inline int _spl_load(struct spl_image_info
> > *spl_image,
> > 
> >  	read = info->read(info, offset, ALIGN(sizeof(*header),
> >  					      spl_get_bl_len(info)),
> > header);
> > -	if (read < sizeof(*header))
> > +	if (read < 0 || read < sizeof(*header))
> 
> "read < 0" will imply that "read < sizeof(*header)", so there
> should no need to include this change.
> 
> Regards,
> Peng.
> 
> >  		return -EIO;
> > 
> >  	if (image_get_magic(header) == FDT_MAGIC) {
> > --
> > 2.45.2
