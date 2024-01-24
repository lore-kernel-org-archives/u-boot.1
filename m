Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD390C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 13:09:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D01DA87C54;
	Wed, 24 Jan 2024 14:09:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="sXqUs7j7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1088887C54; Wed, 24 Jan 2024 14:09:10 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F11087C39
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 14:09:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40OD919Q015862;
 Wed, 24 Jan 2024 07:09:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706101741;
 bh=KTENUy28WuWBSEpLF7YT3TnBiTLNv++Le3bAwAEps8Y=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=sXqUs7j7BalaGr1KiIsnk68zZdyYKJFUm8EkNmyNpp5KT6us1nvVeqqJJWdYwa3sE
 V0HTn0t51uc+xYIDA+jF5ku6DPtg50SaomdlM8QmAeD8TL8zkV75h3RdOziU+ISPjN
 n1yjJTGLNdwsBBcUha9Ch5/zGKj5QNllzldWi4cI=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40OD915g012475
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 24 Jan 2024 07:09:01 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 24
 Jan 2024 07:09:01 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 24 Jan 2024 07:09:01 -0600
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40OD90Wv046309;
 Wed, 24 Jan 2024 07:09:00 -0600
Date: Wed, 24 Jan 2024 18:38:59 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Kamlesh Gurudasani <kamlesh@ti.com>
CC: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>, Neha Francis
 <n-francis@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] firmware: ti_sci: fix the secure_hdr in do_xfer
Message-ID: <20240124130859.sdldy4jafknoa23q@dhruva>
References: <20240124101558.184411-1-d-gole@ti.com>
 <87fryn7zoz.fsf@kamlesh.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87fryn7zoz.fsf@kamlesh.i-did-not-set--mail-host-address--so-tickle-me>
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

On Jan 24, 2024 at 16:42:12 +0530, Kamlesh Gurudasani wrote:
> Dhruva Gole <d-gole@ti.com> writes:
> 
> > The secure_hdr needs to be 0 init-ed however this was never being put
> > into the secure_buf, leading to possibility of the first 4 bytes of
> > secure_buf being possibly garbage.
> >
> > Fix this by initialising the secure_hdr itself to the secure_buf
> > location, thus when we make it 0, it automatically ensures the first 4
> > bytes are 0.
> >
> > Fixes: 32cd25128bd849 ("firmware: Add basic support for TI System Control Interface (TI SCI)")
> > Signed-off-by: Dhruva Gole <d-gole@ti.com>
> > ---
> >
> > Boot tested for sanity on AM62x SK
> > https://gist.github.com/DhruvaG2000/724ceba3a0db03f4b0bff47de1160074
> >
> > Cc: Nishanth Menon <nm@ti.com>
> > Cc: Tom Rini <trini@konsulko.com>
> >
> >  drivers/firmware/ti_sci.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
> > index f5f659c11274..83ee8401a731 100644
> > --- a/drivers/firmware/ti_sci.c
> > +++ b/drivers/firmware/ti_sci.c
> > @@ -236,13 +236,13 @@ static int ti_sci_do_xfer(struct ti_sci_info *info,
> >  {
> >  	struct k3_sec_proxy_msg *msg = &xfer->tx_message;
> >  	u8 secure_buf[info->desc->max_msg_size];
> > -	struct ti_sci_secure_msg_hdr secure_hdr;
> > +	struct ti_sci_secure_msg_hdr *secure_hdr = (struct ti_sci_secure_msg_hdr *)secure_buf;
> >  	int ret;
> >  
> >  	if (info->is_secure) {
> >  		/* ToDo: get checksum of the entire message */
> > -		secure_hdr.checksum = 0;
> > -		secure_hdr.reserved = 0;
> > +		secure_hdr->checksum = 0;
> > +		secure_hdr->reserved = 0;
> >  		memcpy(&secure_buf[sizeof(secure_hdr)],xfer->tx_message.buf,
> secure_hdr is pointer now, the value may be same but (struct
> ti_sci_secure_msg_hdr) would make more sense

Good catch Kamlesh! I have sent a new revision addressing this.

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>
