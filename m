Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DC7ACDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 17:03:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 828CB86963;
	Mon, 16 Oct 2023 19:03:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="MKYvcSP1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 998B086BA6; Mon, 16 Oct 2023 19:03:40 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE0DD85F3D
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 19:03:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=detlev.casanova@collabora.com
Received: from arisu.localnet (mtl.collabora.ca [66.171.169.34])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: detlev)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 9561E6607122;
 Mon, 16 Oct 2023 18:03:37 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1697475818;
 bh=SzL6BwlhMO3/bTp9p3AklYIdGyeMXDkdt20WYSL8uSI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=MKYvcSP1/sfKgA6anCC0+Zkr/Go/Xz0A+Yd3nqPAjkZOT/uJEVjxqGRZjGelsIo4K
 PoDFEf9O6tNJFpX8PLC12WPvtGzlLFyXedgusdyO63OlMEl+PDdu7S8WymIuYv26Wh
 0o5Eyar6+22BgaLquJn8f9yRkV3R0t4r6O474WeEe/0JPdGdiSB6qqA7zPDCdroxYS
 XRCQdVOY//+67NNxGB37ItoTNBli9evdR1h1h9Bjy6PZ3iSiS09idig97mDfgyp237
 SLFP0+mKdjwUENJpVFUuqpPuCSpXF1CjEiPqHBI3K2IGIxF3sFGWobj7ppSBFsTF1r
 GplfUYjGKrBTw==
From: Detlev Casanova <detlev.casanova@collabora.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut@mailbox.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hai Pham <hai.pham.ud@renesas.com>, Tam Nguyen <tam.nguyen.xa@renesas.com>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v5 6/6] sysinfo: rcar3: Implement BOARD_ID and BOARD_REV_*
Date: Mon, 16 Oct 2023 13:03:46 -0400
Message-ID: <6050643.DvuYhMxLoT@arisu>
In-Reply-To: <affa00c1-b6ae-4ef0-9f5f-8a6d6d74d0d8@mailbox.org>
References: <20231002152142.76516-1-detlev.casanova@collabora.com>
 <20231002152142.76516-7-detlev.casanova@collabora.com>
 <affa00c1-b6ae-4ef0-9f5f-8a6d6d74d0d8@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
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

On Saturday, October 7, 2023 5:35:27 P.M. EDT Marek Vasut wrote:
> On 10/2/23 17:20, Detlev Casanova wrote:
> > Expose that information to the sysinfo command to let scripts make
> > decisions based on the board id and revision.
> > 
> > Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> > ---
> > 
> >   drivers/sysinfo/rcar3.c | 89 +++++++++++++++++++++++++++++------------
> >   1 file changed, 63 insertions(+), 26 deletions(-)
> > 
> > diff --git a/drivers/sysinfo/rcar3.c b/drivers/sysinfo/rcar3.c
> > index 633e80bc19b..a554323506a 100644
> > --- a/drivers/sysinfo/rcar3.c
> > +++ b/drivers/sysinfo/rcar3.c
> > @@ -32,6 +32,10 @@
> > 
> >    */
> >   
> >   struct sysinfo_rcar_priv {
> >   
> >   	char	boardmodel[64];
> > 
> > +	u8	id;
> > +	u8	rev_major;
> > +	u8	rev_minor;
> > +	bool	has_rev;
> > 
> >   	u8	val;
> >   
> >   };
> > 
> > @@ -56,9 +60,33 @@ static int sysinfo_rcar_get_str(struct udevice *dev,
> > int id, size_t size, char *> 
> >   	};
> >   
> >   }
> > 
> > +static int sysinfo_rcar_get_int(struct udevice *dev, int id, int *val)
> > +{
> > +	struct sysinfo_rcar_priv *priv = dev_get_priv(dev);
> > +
> > +	switch (id) {
> > +	case SYSINFO_ID_BOARD_ID:
> > +		*val = priv->id;
> > +		return 0;
> > +	case SYSINFO_ID_BOARD_REV_MAJOR:
> > +		if (!priv->has_rev)
> > +			return -EINVAL;
> > +		*val = priv->rev_major;
> > +		return 0;
> > +	case SYSINFO_ID_BOARD_REV_MINOR:
> > +		if (!priv->has_rev)
> > +			return -EINVAL;
> > +		*val = priv->rev_minor;
> > +		return 0;
> > +	default:
> > +		return -EINVAL;
> > +	};
> > +}
> > +
> > 
> >   static const struct sysinfo_ops sysinfo_rcar_ops = {
> >   
> >   	.detect = sysinfo_rcar_detect,
> >   	.get_str = sysinfo_rcar_get_str,
> > 
> > +	.get_int = sysinfo_rcar_get_int,
> > 
> >   };
> >   
> >   static void sysinfo_rcar_parse(struct sysinfo_rcar_priv *priv)
> > 
> > @@ -69,8 +97,9 @@ static void sysinfo_rcar_parse(struct sysinfo_rcar_priv
> > *priv)> 
> >   	bool ebisu_4d = false;
> >   	bool condor_i = false;
> >   	char rev[4] = "?.?";
> > 
> > -	u8 rev_major = 0;
> > -	u8 rev_minor = 0;
> > +
> > +	priv->id = board_id;
> > +	priv->has_rev = false;
> 
> Would it make more sense to assign
> 
> priv->rev_major = 1;
> priv->rev_minor = 0;
> 
> And get rid of priv->has_rev entirely ?
> 
> Basically say that the default case is rev. 1.0 board.
> 
> [...]

I'm not really sure about this has it doesn't differentiate between rev 1.0 and 
unknown revision.



