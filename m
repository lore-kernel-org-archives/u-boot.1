Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7062C28B20
	for <u-boot@archiver.kernel.org>; Wed,  2 Apr 2025 15:23:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6416D81CF0;
	Wed,  2 Apr 2025 17:22:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="N3gcx2HW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9347F8006D; Wed,  2 Apr 2025 17:22:57 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A8F181F4D
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 17:22:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 532FMpal3272444
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 2 Apr 2025 10:22:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1743607371;
 bh=eXP52E7yrGa9YZPeHWI2TpX7THM05cpyHPpt/eQRlxs=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=N3gcx2HWUfvVHKbbin8STbVKJ523fjbNSB+ODwy2q45NOt9Klz1J0VP8u3TiA8hds
 bmg0G+gJUbOlP1CSY+FsgXupOr65G/4GTjhfhHMyXMyw2waoDb2oG7GN/vU5l1Chf/
 8wJTNpY7hrd3ZO6aOpcjdTjmWJCkwNoqNky/Ml2s=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 532FMpjB111882
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 2 Apr 2025 10:22:51 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 2
 Apr 2025 10:22:50 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 2 Apr 2025 10:22:51 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 532FMpdN048234;
 Wed, 2 Apr 2025 10:22:51 -0500
Date: Wed, 2 Apr 2025 10:22:51 -0500
From: Nishanth Menon <nm@ti.com>
To: Dhruva Gole <d-gole@ti.com>
CC: Marek Vasut <marek.vasut+renesas@mailbox.org>, Neha Malcom Francis
 <n-francis@ti.com>, Tom Rini <trini@konsulko.com>,
 Andrew Davis <afd@ti.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Jonas Wood <jw@ti.com>,
 <praneeth@ti.com>, <u-kumar1@ti.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH] firmware: ti_sci: Scan all device instances when
 releasing exclusive devices
Message-ID: <20250402152251.omjw3qrwf6ldad6a@obedience>
References: <20250401205515.4078312-1-nm@ti.com>
 <20250402062730.vgmqbxczm2aee67z@lcpd911>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250402062730.vgmqbxczm2aee67z@lcpd911>
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

On 11:57-20250402, Dhruva Gole wrote:
[...]
> > 
> > As a result of this, the cleanup we intent to do with
> 
> s/intent/intend

Thanks. will pick it up in a respin.

> 
[...]

> > To fix this, let us make ti_sci_cmd_release_exclusive_devices scan the
> > all registrations of tisci instances and cleanup all exclusive devices
> > that have ever been registered.
> 
> Firstly, it seems to me like this issue is mostly specific to the
> AM64/ DM+TIFS combined core arch K3 devices? So it would be good if the
> commit message can specify that for better context. People who are more
> used to the R5 core running DM architecture may find this description
> slightly confusing as there's no TI SCI calls that the R5 SPL can make
> to DM since DM isn't up yet on those devices...

This is not related to TI_SCI. As described in commit message, it is just
the multi_fit_dtb handling challenges. Combined DMSC or split DM arch
devices are probably both susceptible to this. That said, i have tested
this on am64x.

[...]
> > index 190a1e3f5fc3..54d6689ce783 100644
> > --- a/drivers/firmware/ti_sci.c
> > +++ b/drivers/firmware/ti_sci.c
> > @@ -696,20 +696,25 @@ static int ti_sci_cmd_put_device(const struct ti_sci_handle *handle, u32 id)
> >  				       MSG_DEVICE_SW_STATE_AUTO_OFF);
> >  }
> >  
> > -static
> > -int ti_sci_cmd_release_exclusive_devices(const struct ti_sci_handle *handle)
> > +static int ti_sci_cmd_release_exclusive_devices(void)
> >  {
> >  	struct ti_sci_exclusive_dev *dev, *tmp;
> >  	struct ti_sci_info *info;
> >  	int i, cnt;
> >  
> > -	info = handle_to_ti_sci_info(handle);
> > -
> > -	list_for_each_entry_safe(dev, tmp, &info->dev_list, list) {
> > -		cnt = dev->count;
> > -		debug("%s: id = %d, cnt = %d\n", __func__, dev->id, cnt);
> > -		for (i = 0; i < cnt; i++)
> > -			ti_sci_cmd_put_device(handle, dev->id);
> > +	/*
> > +	 * Scan all ti_sci_list registrations, since with FIT images, we could
> > +	 * have started with one device tree registration and switched over
> > +	 * to a final version. This prevents exclusive devices identified
> > +	 * during the first probe to be left orphan.
> > +	 */
> > +	list_for_each_entry(info, &ti_sci_list, list) {
> > +		list_for_each_entry_safe(dev, tmp, &info->dev_list, list) {
> > +			cnt = dev->count;
> > +			debug("%s: id = %d, cnt = %d\n", __func__, dev->id, cnt);
> > +			for (i = 0; i < cnt; i++)
> > +				ti_sci_cmd_put_device(&info->handle, dev->id);
> > +		}
> 
> The other thing I am slightly not comfortable with is this.
> The release_exclusive call is going to be common to every K3 device.
> With your changes, will it result in any sort of increased boot time
> penalty? I feel like it might, unless I maybe mistaken.

It should not. for non-multi-dtb FIT, this logic just flows only 1 list
which is all that is present. for multi-dtb FIT images, it fixes a real
problem.

> 
> Also, to fix just AM64 style devices, we're touching a K3 common piece
> of code like TI SCI. The issue that you described about the TI SCI
> probing the second time causing issues seems more fundamental than the
> fix being offered here.

As described in commit message, calling probe twice is Normal since
there are two dtbs involved in the FIT image (one with which we
identify what is the board and use the information to pick the correct
dtb).

> Quoting the commit message,
> 
> > At this stage, the exclusive devices such as i2c instances used to
> > probe the board information is left in the old info->dev_list that is
> > no longer used actively by the system using the replaced dtb.
> 
> Can we instead try and fix the TI SCI driver behaviour from the first time?
> Like is it possible to implement a .remove for the TI SCI driver such
> that when the old dtb is now out of context, the driver gets cleanly
> removed, and with that calls the release_exclusive of all devices that
> it requested? 

Tried .remove and .unbind and enabling CONFIG_SPL_DM_DEVICE_REMOVE but
then we run into all kind of other dependency issues on dm_uninit

> That way the new instance of TI SCI driver doesn't need to worry about
> doing cleanups from any of it's previous instances right?
> 
> To me that sounds like the right root cause to try and fix. Let me know
> what are your thoughts on this.

I am open to any approach :) - just dont seem to find one that works
other than what I posted.

> 
> >  	}
> >  
> >  	return 0;
> > diff --git a/include/linux/soc/ti/ti_sci_protocol.h b/include/linux/soc/ti/ti_sci_protocol.h
> > index 8e4c43cef311..aa4d105ee988 100644
> > --- a/include/linux/soc/ti/ti_sci_protocol.h
> > +++ b/include/linux/soc/ti/ti_sci_protocol.h
> > @@ -143,7 +143,7 @@ struct ti_sci_dev_ops {
> >  				 u32 reset_state);
> >  	int (*get_device_resets)(const struct ti_sci_handle *handle, u32 id,
> >  				 u32 *reset_state);
> > -	int (*release_exclusive_devices)(const struct ti_sci_handle *handle);
> > +	int (*release_exclusive_devices)(void);
> 
> Nit: Just update the copyright dates of the files you're touching...

not for minor changes such as these.. not worth the diff.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
