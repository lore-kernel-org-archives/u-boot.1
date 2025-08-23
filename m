Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B390CA0EE4
	for <u-boot@archiver.kernel.org>; Sat, 23 Aug 2025 14:05:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EF4581D5D;
	Sat, 23 Aug 2025 16:05:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="LB89GSOz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CED183020; Sat, 23 Aug 2025 16:05:48 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1794C80422
 for <u-boot@lists.denx.de>; Sat, 23 Aug 2025 16:05:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 8d65046e-802a-11f0-84d2-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 8d65046e-802a-11f0-84d2-005056992ed3;
 Sat, 23 Aug 2025 16:07:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=QU6iFEpaEBAZKNu8wFbQSWHjBP00e8oPIJHMiXJpDeU=;
 b=LB89GSOzymQew4kMqKSAWUrSn7xwRT75JavgRyrLxbDpKjSTfSnR813l/uSqhnf/cCZB4n50m6nK/
 gyO6DkiCIPUA++R++fxig3iVM6AeO4A1EjVQV+Q3pNA+iLccC5+21boB8EAmb16Ynm5t5zSaTCadVf
 rhuNvJjyiekij/xJDxhoJ4jjskqVsP7ipzh+FpyaLBuo5e3uOPL5D4zQS48ZNBAI8Fxh+jml3nLpHX
 j686GjaN0cb+JdAlP0+cQ5ItjkF92F0vQUnD+hrTq+02tog0iqA4H/TmsoIYM4dIIv/FEtQh1Vw6is
 LEjuD6nnybbrMZ2e97ZdtmOfc8iHU2g==
X-KPN-MID: 33|5QyPhYI/iSG0ip9k8KsrpxdsjhmvInvWbB6Tk4Xw+bL4raDL10cmbHgvzfHSD3d
 tTveW/YWpesI8DRzuicgVbJCRUGpbxj30bXvRdFmiD2w=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|N1I0S3VLHtrgNTrpH6zddg2yLc2YJLZz8cEz0881WieqDtkptsWJVxJ0ltfaeG5
 FkblcQYoc/hRTRo36HP7UYA==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 42d93a63-802a-11f0-8d55-00505699b758;
 Sat, 23 Aug 2025 16:05:45 +0200 (CEST)
Date: Sat, 23 Aug 2025 16:05:44 +0200
Message-Id: <87ms7qi153.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: trini@konsulko.com, andrew.goodbody@linaro.org,
 kettenis@openbsd.org, u-boot@lists.denx.de
In-Reply-To: <877bz4l3ka.fsf@bloch.sibelius.xs4all.nl> (message from Mark
 Kettenis on Fri, 15 Aug 2025 22:42:29 +0200)
Subject: Re: [PATCH] pci: apple: i needs to be initialised and used
References: <20250806-pcie_apple-v1-1-1a99f83d3cc5@linaro.org>
 <20250815201717.GA66660@bill-the-cat>
 <877bz4l3ka.fsf@bloch.sibelius.xs4all.nl>
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

> Date: Fri, 15 Aug 2025 22:42:29 +0200
> From: Mark Kettenis <mark.kettenis@xs4all.nl>
> 
> > Date: Fri, 15 Aug 2025 14:17:17 -0600
> > From: Tom Rini <trini@konsulko.com>
> 
> Hi Tom,
> 
> > On Wed, Aug 06, 2025 at 12:30:00PM +0100, Andrew Goodbody wrote:
> > > In apple_pcie_probe the variable 'i' is declared and then its value
> > > printed on an error but 'i' is not initialised nor is it made use of.
> > > Add an initial value for 'i' and have it incremented in the for loop.
> > > 
> > > This issue was found by Smatch.
> > > 
> > > Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> > > ---
> > >  drivers/pci/pcie_apple.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/pci/pcie_apple.c b/drivers/pci/pcie_apple.c
> > > index 6a8e715d4b6..216b6512af1 100644
> > > --- a/drivers/pci/pcie_apple.c
> > > +++ b/drivers/pci/pcie_apple.c
> > > @@ -335,7 +335,7 @@ static int apple_pcie_probe(struct udevice *dev)
> > >  	struct apple_pcie_priv *pcie = dev_get_priv(dev);
> > >  	fdt_addr_t addr;
> > >  	ofnode of_port;
> > > -	int i, ret;
> > > +	int i = 0, ret;
> > >  
> > >  	pcie->hw = (struct reg_info *)dev_get_driver_data(dev);
> > >  
> > > @@ -353,7 +353,7 @@ static int apple_pcie_probe(struct udevice *dev)
> > >  	INIT_LIST_HEAD(&pcie->ports);
> > >  
> > >  	for (of_port = ofnode_first_subnode(dev_ofnode(dev));
> > > -	     ofnode_valid(of_port);
> > > +	     ofnode_valid(of_port), i++;
> > >  	     of_port = ofnode_next_subnode(of_port)) {
> > >  		if (!ofnode_is_enabled(of_port))
> > >  			continue;
> > 
> > I don't think this is right because with this applied:
> >             apple_m1       : all -1425 rodata -101 text -1324
> >                u-boot: add: 0/-3, grow: 0/-1 bytes: 0/-1324 (-1324)
> >                  function                                   old     new   delta
> >                  gpio_request_by_name_nodev                  12       -     -12
> >                  devfdt_get_addr_name                        80       -     -80
> >                  _gpio_request_by_name_nodev                156       -    -156
> >                  apple_pcie_probe                          1204     128   -1076
> > 
> > So the probe becomes an almost nothing func (that I assume returns
> > early) and we can discard some other functions.
> 
> The i++ is in the wrong place.
> 
> The variable is only really used to identify the port that is failing
> to initialize.  Doesn't happen under normal circumstances, and if it
> happens it is probably better to identify the port by its "reg"
> property.  I'll try to come up with a diff for that.

Just sent a diff for that to the list.

