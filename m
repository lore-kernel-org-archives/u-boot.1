Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59BF7C3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 13:11:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D155D889AE;
	Wed, 31 Jul 2024 15:11:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=comcast.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=comcast.net header.i=@comcast.net header.b="it6OOLq0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 557BE88A05; Wed, 31 Jul 2024 15:11:11 +0200 (CEST)
Received: from resdmta-a2p-658371.sys.comcast.net
 (resdmta-a2p-658371.sys.comcast.net [IPv6:2001:558:fd01:2bb4::d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE78488996
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 15:11:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=comcast.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fventuri@comcast.net
Received: from resomta-a2p-647345.sys.comcast.net ([96.103.145.234])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 256/256 bits)
 (Client did not present a certificate)
 by resdmta-a2p-658371.sys.comcast.net with ESMTPS
 id Z8SyswU44PxKoZ96hs4bO6; Wed, 31 Jul 2024 13:11:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
 s=20190202a; t=1722431467;
 bh=pkJEOjdSTyUJTKB4CxwU9W9WkWZYQl6eURF8qrgLHJg=;
 h=Received:Received:Date:From:To:Message-ID:Subject:MIME-Version:
 Content-Type:Xfinity-Spam-Result;
 b=it6OOLq0yzEiily5fAKpwgyLzycglvBUDlXu2Jh9LCYtlOkX5RxDtWogb9/hnmoYG
 y5vyY5vcpJ3vKiMVTb+ohNHj0kkqFA6OOb2ALKkggfwC8EEX+i24cIwd1NE4QJHMS+
 Wl4wjVWjXdxb1KKp9FL8K4dz2kUX2BUz5kUL19ycYhyJL1og7668SgyjTGt8WOJirv
 nX0k08n+gzSJffcqLapS7tXJDkeRIfhlbJhy69lJ3KcTm1c/dOdhF3Wi5uTJUB+eGQ
 4f/9GRhrk5yUk3ZnwCj/FsiFqbz+ozDFfHN9l/hesp/YDZ/XRKRz3AiZZi/heEZYvI
 07PFDAxx/V8cw==
Received: from oxapp-ch2f-71o.email.comcast.net ([96.117.87.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 256/256 bits)
 (Client did not present a certificate)
 by resomta-a2p-647345.sys.comcast.net with ESMTPS
 id Z96Ks6qN28EV9Z96KsXCZE; Wed, 31 Jul 2024 13:10:45 +0000
Date: Wed, 31 Jul 2024 09:10:44 -0400 (EDT)
From: Franco VENTURI <fventuri@comcast.net>
To: Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>
Message-ID: <1141912962.260308.1722431444412@connect.xfinity.com>
In-Reply-To: <60c5a1ae-763f-d6e4-2200-53916c99e29c@gmail.com>
References: <20240730133043.12577-1-fventuri@comcast.net>
 <60c5a1ae-763f-d6e4-2200-53916c99e29c@gmail.com>
Subject: Re: [PATCH v1] mmc: fix signed vs unsigned compare in read check in
 _spl_load()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev59
X-Originating-IP: ::ffff:76.18.214.183
X-Originating-Client: open-xchange-appsuite
X-CMAE-Envelope: MS4xfH65gO3yi9DkEUsX0gOgHSC2MFzDhiXbOfk9hRyHybvtLig6qgV5ywwd07I7q8PdqZTO3FNVHO9MXm9lWNgv0Yo9SWT12jg6tR/MM006Xoc4B5AStGiE
 UJZU327NeyR+vXio7inyVqtjWI1xX6Y8n7rHoPGBTOzYj8YHPWxcCb52ZFgx2QaMsKokPv25lCA9cCkYY4ysyagB7lpODb1TlYRq0v3Jss44R4rY1mwl6+vY
 d/ugbjo+qPYOQ1fIl1zVrp73T/Z8PDx3oPtvq0RSC12FzxRIXbASajgIBVVj8HnuL+2w1BO8/lti/ft4g2pNWYEFTWmc6prNfih1df5uVpFK96P5oH7GIuJf
 i5CiRi+0
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

Sean, thanks for the quick response.

I just resubmitted version 2 of that patch with a cast to int.

Franco


> On 07/31/2024 8:52 AM EDT Sean Anderson <seanga2@gmail.com> wrote:
> 
>  
> Hi Franco,
> 
> On 7/30/24 09:30, Franco Venturi wrote:
> > Fix signed vs unsigned compare in read check in _spl_load()
> > 
> > Issue: when info->read() returns a negative value because of an error,
> >         the comparison of 'read' (signed) with 'sizeof(*header)'
> >         (unsigned silently converts the negative value into a very
> >         large unsigned value and the check on the error condition
> >         always return false, i.e. the error is not detected
> > Symptoms: if spl_load_image_fat() is unable to find the file 'uImage',
> >            the SPL phase of the boot process just hangs after displaying
> >            the following line:
> >            Trying to boot from MMC1
> > Fix: first check if 'read' is negative then check its value against
> >       'sizeof(*header)'
> > Reference: https://stackoverflow.com/questions/17293749/sizeof-operator-in-if-statement
> > 
> > Signed-off-by: Franco Venturi <fventuri@comcast.net>
> > ---
> > 
> >   include/spl_load.h | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/spl_load.h b/include/spl_load.h
> > index 1c2b296c0a..1e05599d29 100644
> > --- a/include/spl_load.h
> > +++ b/include/spl_load.h
> > @@ -22,7 +22,7 @@ static inline int _spl_load(struct spl_image_info *spl_image,
> >   
> >   	read = info->read(info, offset, ALIGN(sizeof(*header),
> >   					      spl_get_bl_len(info)), header);
> > -	if (read < sizeof(*header))
> > +	if (read < 0 || read < sizeof(*header))
> >   		return -EIO;
> >   
> >   	if (image_get_magic(header) == FDT_MAGIC) {
> 
> Since read and int and sizeof(*header) < INT_MAX, I think the best solution is
> to cast the latter to an int.
> 
> --Sean
