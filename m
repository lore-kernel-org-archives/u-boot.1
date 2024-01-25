Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B82BEC47258
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 05:43:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CCCD86F6F;
	Thu, 25 Jan 2024 06:43:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="HcKaw5+V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 301B58701D; Thu, 25 Jan 2024 06:43:41 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC04C86F67
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 06:43:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40P5hZXI029818;
 Wed, 24 Jan 2024 23:43:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706161415;
 bh=w9w5b5WtDmtqVhGC/J2ui+nlm37vlaGGCB5DUDwqVJI=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=HcKaw5+VnDiyh5dSBMyoNpNfVAzCGBz9euiIlEVPC8d05PUprWz04WzzKOE6RGyY4
 ujnltSOTjo0Hl/zeQGMnmxlYndhDZLl5Flha89XakSSQVbqS/egPYYUjlSqhibJVDh
 50wS0/z1i2V6hFgBwvqQhYRgU0pekzLeL3HSkHGI=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40P5hZSU010455
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 24 Jan 2024 23:43:35 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 24
 Jan 2024 23:43:35 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 24 Jan 2024 23:43:35 -0600
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40P5hY2e040024;
 Wed, 24 Jan 2024 23:43:35 -0600
Date: Thu, 25 Jan 2024 11:13:34 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Nishanth Menon <nm@ti.com>
CC: Kamlesh Gurudasani <kamlesh@ti.com>, Tom Rini <trini@konsulko.com>,
 <u-boot@lists.denx.de>, Neha Francis <n-francis@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH] firmware: ti_sci: fix the secure_hdr in do_xfer
Message-ID: <20240125054334.zjll7j4fpv66ciyn@dhruva>
References: <20240124101558.184411-1-d-gole@ti.com>
 <87fryn7zoz.fsf@kamlesh.i-did-not-set--mail-host-address--so-tickle-me>
 <20240124130859.sdldy4jafknoa23q@dhruva>
 <20240124163910.sp7gt56lihoujm7k@etching>
 <20240124173723.3wfiwfgf6rhwgwaa@dhruva>
 <20240124180813.azl3ldrrg7a5iosz@spoils>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240124180813.azl3ldrrg7a5iosz@spoils>
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

On Jan 24, 2024 at 12:08:13 -0600, Nishanth Menon wrote:
> On 23:07-20240124, Dhruva Gole wrote:
> > On Jan 24, 2024 at 10:39:10 -0600, Nishanth Menon wrote:
> > > On 18:38-20240124, Dhruva Gole wrote:
> > > > On Jan 24, 2024 at 16:42:12 +0530, Kamlesh Gurudasani wrote:
> > > > > Dhruva Gole <d-gole@ti.com> writes:
> > > > > 
> > > > > > The secure_hdr needs to be 0 init-ed however this was never being put
> > > > > > into the secure_buf, leading to possibility of the first 4 bytes of
> > > > > > secure_buf being possibly garbage.
> > > > > >
> > > > > > Fix this by initialising the secure_hdr itself to the secure_buf
> > > > > > location, thus when we make it 0, it automatically ensures the first 4
> > > > > > bytes are 0.
> > > > > >
> > > > > > Fixes: 32cd25128bd849 ("firmware: Add basic support for TI System Control Interface (TI SCI)")
> > > > > > Signed-off-by: Dhruva Gole <d-gole@ti.com>
> > > > > > ---
> > > > > >
> > > > > > Boot tested for sanity on AM62x SK
> > > > > > https://gist.github.com/DhruvaG2000/724ceba3a0db03f4b0bff47de1160074
> > > > > >
> > > > > > Cc: Nishanth Menon <nm@ti.com>
> > > > > > Cc: Tom Rini <trini@konsulko.com>
> > > > > >
> > > > > >  drivers/firmware/ti_sci.c | 6 +++---
> > > > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
> > > > > > index f5f659c11274..83ee8401a731 100644
> > > > > > --- a/drivers/firmware/ti_sci.c
> > > > > > +++ b/drivers/firmware/ti_sci.c
> > > > > > @@ -236,13 +236,13 @@ static int ti_sci_do_xfer(struct ti_sci_info *info,
> > > > > >  {
> > > > > >  	struct k3_sec_proxy_msg *msg = &xfer->tx_message;
> > > > > >  	u8 secure_buf[info->desc->max_msg_size];
> > > > > > -	struct ti_sci_secure_msg_hdr secure_hdr;
> > > > > > +	struct ti_sci_secure_msg_hdr *secure_hdr = (struct ti_sci_secure_msg_hdr *)secure_buf;
> > > > > >  	int ret;
> > > > > >  
> > > > > >  	if (info->is_secure) {
> > > > > >  		/* ToDo: get checksum of the entire message */
> > > > > > -		secure_hdr.checksum = 0;
> > > > > > -		secure_hdr.reserved = 0;
> > > > > > +		secure_hdr->checksum = 0;
> > > > > > +		secure_hdr->reserved = 0;
> > > > > >  		memcpy(&secure_buf[sizeof(secure_hdr)],xfer->tx_message.buf,
> > > > > secure_hdr is pointer now, the value may be same but (struct
> > > > > ti_sci_secure_msg_hdr) would make more sense
> > > > 
> > > > Good catch Kamlesh! I have sent a new revision addressing this.
> > > > 
> > > 
> > > Makes no sense why we have secure API support in U-Boot. what is using
> > > this?
> > 
> > In my understanding of generic K3 boot flow, things like proc_boot and
> > even applying or removing of firewalls will need a secure channel to
> > talk to TIFS right? From my understanding secure host can only talk to
> > TIFS and make such requests hence secure API.
> 
> U-boot runs in NS world, you cant even talk to the Trustzone Sec proxy
> without triggering a firewall violation.

I am not going to debate on whether U-Boot is or isn't a secure entity.
The original code base was making secure_hdr.checksum = 0;

But this wasn't really being used anywhere. I am just making sure what the
original code base intended to do is being actually done.

> 
> 
> https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/general/TISCI_header.html?highlight=header#secure-messaging-header
> "The Secure Messaging Header is only required when sending messages over
> secure transport. Messages sent over non-secure transport must not
> contain the secure messaging header."

Yes, understood. I do not have the context behind the commit
32cd25128bd849 ("firmware: Add basic support for TI System Control
Interface (TI SCI)") but perhaps you do. So please help me understand
why there's this code:
memcpy(&secure_buf[sizeof(secure_hdr)], xfer->tx_message.buf, xfer->tx_message.len);

which is basically trying to create a 4 byte offset (trying to abide by the secure
msg format?) 
If UBoot as you say is non secure let's just send regular TISCI messages. Are you
suggesting that we trim all of if (info->is_secure) and related "secure"
code from uboot? Then that's a separate cleanup we need to have.


> 
> btw, that checksum field should be renamed integ_check, but anyways..
> 
> So, I do not see a reason to even have that if condition in the first
> place and what real bug was getting fixed in this patch.

"Real" bug or "potential" bug, the code did not seem to be doing what it should have
been doing, that's all. For anyone reading the checksum = 0 that is
there in today's code it's super confusing.

Either get rid of it completely, or else make it do what it was trying
to do. Let me know how we should proceed.


-- 
Best regards,
Dhruva Gole <d-gole@ti.com>
