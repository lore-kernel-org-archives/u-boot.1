Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C878CA0ED1
	for <u-boot@archiver.kernel.org>; Fri, 15 Aug 2025 20:42:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8E0D83AEC;
	Fri, 15 Aug 2025 22:42:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="WSt9xiMh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 476C083B0A; Fri, 15 Aug 2025 22:42:33 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1840B83AEA
 for <u-boot@lists.denx.de>; Fri, 15 Aug 2025 22:42:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 934487de-7a18-11f0-84d2-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 934487de-7a18-11f0-84d2-005056992ed3;
 Fri, 15 Aug 2025 22:44:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=lZHMWXDZE09z7hdPqceQ8fBjEtQbFpmuVg5z7u3R59Q=;
 b=WSt9xiMhKEX/86DqN94FB1E6FqBA3llGY8kLYrJaJ7Q3Ap530IQNwEN+xfS15vsEZUwZCZ7gNCoOM
 CLKhcdvCSwdi8OFp+zZsBdd74eKL8O4mRHCV159xsR+Xh+APYzJzqKOBFHx2ZAZ/8aiky6iYouJ8TH
 2sisbQIUCkZBTe/AXvBa+iNihZZujfCB866FP3RAzrDi7F/Tm6bgSfmkTr/FHYd6jwBJIm4dO3oP92
 j8CvkoJ8ZWg8YIfvS/NEVScy5d+T+mIraOuoaSi+YM5kA4TsCi6y9606CGxTd6WLAkuxDOmFkt5B11
 fvhC07eWcCRK6wNLYXOYPxd8ZnJnnTQ==
X-KPN-MID: 33|g23iKpQ7dLvkB/KFEpfNFODjNJvnnd05OPEuXSj8GTMkBda0UmxS+y3uyIv3JCM
 xCXTIIB/Psz0JmOl+HuSRK1NeBOfKIhprJkTc8HWzZeI=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|mEXuCiyQrFPYIOCJHldMlt92wzJstqM2gIs7EQ4DAYS1R+1Q8uNGApkQeTpAlcv
 C4V71mh33OK/bHN0jGekhhQ==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 5c6be3c1-7a18-11f0-889f-00505699d6e5;
 Fri, 15 Aug 2025 22:42:30 +0200 (CEST)
Date: Fri, 15 Aug 2025 22:42:29 +0200
Message-Id: <877bz4l3ka.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Tom Rini <trini@konsulko.com>
Cc: andrew.goodbody@linaro.org, kettenis@openbsd.org,
	u-boot@lists.denx.de
In-Reply-To: <20250815201717.GA66660@bill-the-cat> (message from Tom Rini on
 Fri, 15 Aug 2025 14:17:17 -0600)
Subject: Re: [PATCH] pci: apple: i needs to be initialised and used
References: <20250806-pcie_apple-v1-1-1a99f83d3cc5@linaro.org>
 <20250815201717.GA66660@bill-the-cat>
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

> Date: Fri, 15 Aug 2025 14:17:17 -0600
> From: Tom Rini <trini@konsulko.com>

Hi Tom,

> On Wed, Aug 06, 2025 at 12:30:00PM +0100, Andrew Goodbody wrote:
> > In apple_pcie_probe the variable 'i' is declared and then its value
> > printed on an error but 'i' is not initialised nor is it made use of.
> > Add an initial value for 'i' and have it incremented in the for loop.
> > 
> > This issue was found by Smatch.
> > 
> > Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> > ---
> >  drivers/pci/pcie_apple.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/pcie_apple.c b/drivers/pci/pcie_apple.c
> > index 6a8e715d4b6..216b6512af1 100644
> > --- a/drivers/pci/pcie_apple.c
> > +++ b/drivers/pci/pcie_apple.c
> > @@ -335,7 +335,7 @@ static int apple_pcie_probe(struct udevice *dev)
> >  	struct apple_pcie_priv *pcie = dev_get_priv(dev);
> >  	fdt_addr_t addr;
> >  	ofnode of_port;
> > -	int i, ret;
> > +	int i = 0, ret;
> >  
> >  	pcie->hw = (struct reg_info *)dev_get_driver_data(dev);
> >  
> > @@ -353,7 +353,7 @@ static int apple_pcie_probe(struct udevice *dev)
> >  	INIT_LIST_HEAD(&pcie->ports);
> >  
> >  	for (of_port = ofnode_first_subnode(dev_ofnode(dev));
> > -	     ofnode_valid(of_port);
> > +	     ofnode_valid(of_port), i++;
> >  	     of_port = ofnode_next_subnode(of_port)) {
> >  		if (!ofnode_is_enabled(of_port))
> >  			continue;
> 
> I don't think this is right because with this applied:
>             apple_m1       : all -1425 rodata -101 text -1324
>                u-boot: add: 0/-3, grow: 0/-1 bytes: 0/-1324 (-1324)
>                  function                                   old     new   delta
>                  gpio_request_by_name_nodev                  12       -     -12
>                  devfdt_get_addr_name                        80       -     -80
>                  _gpio_request_by_name_nodev                156       -    -156
>                  apple_pcie_probe                          1204     128   -1076
> 
> So the probe becomes an almost nothing func (that I assume returns
> early) and we can discard some other functions.

The i++ is in the wrong place.

The variable is only really used to identify the port that is failing
to initialize.  Doesn't happen under normal circumstances, and if it
happens it is probably better to identify the port by its "reg"
property.  I'll try to come up with a diff for that.
