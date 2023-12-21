Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1B85C46CCD
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 13:51:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FA64876B4;
	Thu, 21 Dec 2023 14:51:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="zVCGnxAf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="t1vXnqeV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zVCGnxAf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="t1vXnqeV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C53EB87845; Thu, 21 Dec 2023 14:51:46 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8F1B876AE
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 14:51:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=iivanov@suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5863321E96;
 Thu, 21 Dec 2023 13:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1703166704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KqRUBN607CLO0yDuQ3lcuFyR2ApTXX6ShftYwPs386U=;
 b=zVCGnxAf057oCmALyKKF4BaK4adEijdghk4UGNmonoc491Z1+jiwjd2v4o1lGP0f5r5jgf
 GoAheDBdQlAdqJnAdAKIW1UZNJCGF1SeRuWGwyajJhBSICxXeohfA/p3UUP00JTAPh7mJO
 oHBrLH9JGibBqWAzsgjfndkWSWpOZ84=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1703166704;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KqRUBN607CLO0yDuQ3lcuFyR2ApTXX6ShftYwPs386U=;
 b=t1vXnqeVBP75AD4yWJUivQV2cYbIThtOhuWnm056gywab2StcTBFqO3IFlPQypkpPohawq
 w5SPBi6wqQiB+7DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1703166704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KqRUBN607CLO0yDuQ3lcuFyR2ApTXX6ShftYwPs386U=;
 b=zVCGnxAf057oCmALyKKF4BaK4adEijdghk4UGNmonoc491Z1+jiwjd2v4o1lGP0f5r5jgf
 GoAheDBdQlAdqJnAdAKIW1UZNJCGF1SeRuWGwyajJhBSICxXeohfA/p3UUP00JTAPh7mJO
 oHBrLH9JGibBqWAzsgjfndkWSWpOZ84=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1703166704;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KqRUBN607CLO0yDuQ3lcuFyR2ApTXX6ShftYwPs386U=;
 b=t1vXnqeVBP75AD4yWJUivQV2cYbIThtOhuWnm056gywab2StcTBFqO3IFlPQypkpPohawq
 w5SPBi6wqQiB+7DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3647213725;
 Thu, 21 Dec 2023 13:51:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 438BC/BChGV2DgAAD6G6ig
 (envelope-from <iivanov@suse.de>); Thu, 21 Dec 2023 13:51:44 +0000
Date: Thu, 21 Dec 2023 15:51:43 +0200
From: "Ivan T. Ivanov" <iivanov@suse.de>
To: Matthias Brugger <mbrugger@suse.com>
Cc: Stefan Wahren <wahrenst@gmx.net>, Peter Robinson <pbrobinson@gmail.com>,
 Dmitry Malkin <dmitry@bedrocksystems.com>, 
 Thomas Fitzsimmons <fitzsim@fitzsim.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>, 
 florian.fainelli@broadcom.com, u-boot@lists.denx.de
Subject: Re: [PATCH v3 4/7] bcm2835: brcm,bcm2708-fb device is using r5g6b5
 format
Message-ID: <qqil5pbsl2vrdpevs4c2k42fctr3pp4tyz5uxcqsuc74d62uio@khp2ttyvtaw6>
References: <20231218210341.30073-1-iivanov@suse.de>
 <20231218210341.30073-5-iivanov@suse.de>
 <7764be07-c3cc-47e0-a284-4ba9420a843f@gmx.net>
 <tosej62qjugymvxevjaqq6kqkkjlo3qpkbzaw4xx4ot6fk3j54@evih5bgvfdtf>
 <27611da0-a16b-4392-9c87-68e03289ccbe@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27611da0-a16b-4392-9c87-68e03289ccbe@suse.com>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Bar: /
X-Spamd-Result: default: False [-0.38 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.net];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[10];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 FREEMAIL_CC(0.00)[gmx.net,gmail.com,bedrocksystems.com,fitzsim.org,nxp.com,samsung.com,denx.de,broadcom.com,lists.denx.de];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.57)[81.30%];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zVCGnxAf;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=t1vXnqeV
X-Rspamd-Queue-Id: 5863321E96
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

On 12-20 09:51, Matthias Brugger wrote:
> > > > 
> > > >    static const struct udevice_id bcm2835_video_ids[] = {
> > > > -	{ .compatible = "brcm,bcm2835-hdmi" },
> > > > -	{ .compatible = "brcm,bcm2711-hdmi0" },
> > > > -	{ .compatible = "brcm,bcm2708-fb" },
> > > > +	{ .compatible = "brcm,bcm2835-hdmi",  .data = VIDEO_BPP32},
> > > > +	{ .compatible = "brcm,bcm2711-hdmi0", .data = VIDEO_BPP32},
> > > > +	{ .compatible = "brcm,bcm2708-fb",    .data = VIDEO_BPP16 },
> > > this change looks wrong to me. Before we used VIDEO_BPP32 for
> > > brcm,bcm2708-fb. I think it's hard to explain why we should downgrade
> > > the other boards. I would expect some brcm,bcm2712 compatible at least
> > > this needs an explanation in the commit message.
> > > 

I think I found better and reliable way to find the right value.

    bpp = pitch / width

Which are queried from firmware.

Tested to work for RPi2b v1.2, RPi3b v1.3, RPi4b v1.1, RPi2 Zero W, RPi5b v1.0.

> 
> I think that was RPi1 maybe RPi2 Zero W as well.
> 

For the record: RPi2 Zero W exposes "brcm,bcm2835-hdmi" device.

Regards,
Ivan

