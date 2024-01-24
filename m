Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0F3DC47E49
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 17:37:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1921087B34;
	Wed, 24 Jan 2024 18:37:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="aUdNRzjk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FEF887753; Wed, 24 Jan 2024 18:37:30 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EB358786C
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 18:37:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40OHbPHd113853;
 Wed, 24 Jan 2024 11:37:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706117845;
 bh=s+a6UOUxMFXsrKYpeKmk9/gEOub7G0vAA5egIBnhTrU=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=aUdNRzjkhZ4pZ/2VrKKvVFehE0C3iNOOLWEwh/ldc3FxnZMVetMTZGdP5Ix/wknfE
 KKv4XgeXMlN7dRd/H+sHIc+dpBVW1vSECZEGlSStvsGph9JW6sXda2Eu5NPHahWuTk
 cbCYb7n8DhcG+NlAc91V9uYvcjVwDUqYvSpg5IRQ=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40OHbP75070869
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 24 Jan 2024 11:37:25 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 24
 Jan 2024 11:37:24 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 24 Jan 2024 11:37:25 -0600
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40OHbOWJ030349;
 Wed, 24 Jan 2024 11:37:24 -0600
Date: Wed, 24 Jan 2024 23:07:23 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Nishanth Menon <nm@ti.com>
CC: Kamlesh Gurudasani <kamlesh@ti.com>, Tom Rini <trini@konsulko.com>,
 <u-boot@lists.denx.de>, Neha Francis <n-francis@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH] firmware: ti_sci: fix the secure_hdr in do_xfer
Message-ID: <20240124173723.3wfiwfgf6rhwgwaa@dhruva>
References: <20240124101558.184411-1-d-gole@ti.com>
 <87fryn7zoz.fsf@kamlesh.i-did-not-set--mail-host-address--so-tickle-me>
 <20240124130859.sdldy4jafknoa23q@dhruva>
 <20240124163910.sp7gt56lihoujm7k@etching>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240124163910.sp7gt56lihoujm7k@etching>
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

On Jan 24, 2024 at 10:39:10 -0600, Nishanth Menon wrote:
> On 18:38-20240124, Dhruva Gole wrote:
> > On Jan 24, 2024 at 16:42:12 +0530, Kamlesh Gurudasani wrote:
> > > Dhruva Gole <d-gole@ti.com> writes:
> > > 
> > > > The secure_hdr needs to be 0 init-ed however this was never being put
> > > > into the secure_buf, leading to possibility of the first 4 bytes of
> > > > secure_buf being possibly garbage.
> > > >
> > > > Fix this by initialising the secure_hdr itself to the secure_buf
> > > > location, thus when we make it 0, it automatically ensures the first 4
> > > > bytes are 0.
> > > >
> > > > Fixes: 32cd25128bd849 ("firmware: Add basic support for TI System Control Interface (TI SCI)")
> > > > Signed-off-by: Dhruva Gole <d-gole@ti.com>
> > > > ---
> > > >
> > > > Boot tested for sanity on AM62x SK
> > > > https://gist.github.com/DhruvaG2000/724ceba3a0db03f4b0bff47de1160074
> > > >
> > > > Cc: Nishanth Menon <nm@ti.com>
> > > > Cc: Tom Rini <trini@konsulko.com>
> > > >
> > > >  drivers/firmware/ti_sci.c | 6 +++---
> > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
> > > > index f5f659c11274..83ee8401a731 100644
> > > > --- a/drivers/firmware/ti_sci.c
> > > > +++ b/drivers/firmware/ti_sci.c
> > > > @@ -236,13 +236,13 @@ static int ti_sci_do_xfer(struct ti_sci_info *info,
> > > >  {
> > > >  	struct k3_sec_proxy_msg *msg = &xfer->tx_message;
> > > >  	u8 secure_buf[info->desc->max_msg_size];
> > > > -	struct ti_sci_secure_msg_hdr secure_hdr;
> > > > +	struct ti_sci_secure_msg_hdr *secure_hdr = (struct ti_sci_secure_msg_hdr *)secure_buf;
> > > >  	int ret;
> > > >  
> > > >  	if (info->is_secure) {
> > > >  		/* ToDo: get checksum of the entire message */
> > > > -		secure_hdr.checksum = 0;
> > > > -		secure_hdr.reserved = 0;
> > > > +		secure_hdr->checksum = 0;
> > > > +		secure_hdr->reserved = 0;
> > > >  		memcpy(&secure_buf[sizeof(secure_hdr)],xfer->tx_message.buf,
> > > secure_hdr is pointer now, the value may be same but (struct
> > > ti_sci_secure_msg_hdr) would make more sense
> > 
> > Good catch Kamlesh! I have sent a new revision addressing this.
> > 
> 
> Makes no sense why we have secure API support in U-Boot. what is using
> this?

In my understanding of generic K3 boot flow, things like proc_boot and
even applying or removing of firewalls will need a secure channel to
talk to TIFS right? From my understanding secure host can only talk to
TIFS and make such requests hence secure API.

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>
