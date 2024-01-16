Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF062C4706C
	for <u-boot@archiver.kernel.org>; Tue, 16 Jan 2024 09:11:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A7D08790F;
	Tue, 16 Jan 2024 10:11:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="zhIGeLLe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="P/VHq5Zr";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="B0gJS/8T";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UVE2tMLq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 301F187970; Tue, 16 Jan 2024 10:11:07 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E3C586D82
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 10:11:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=iivanov@suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D4B091FB86;
 Tue, 16 Jan 2024 09:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705396264; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sIMKbKxH9xtolgVZxn4NQV0XLUg9u5xxeuQwbupMVHw=;
 b=zhIGeLLe1dxjuU2e74X/EGl1ENlPjIkQiZOjHQOYRscqfaKUKDPASkIWS9o/8oPZZc12D3
 s7AbQj3JTEu0W8so5WfUnXk52UWKheKDTaFtUlYJzIvH1fGwgbstRNn2j8BA0VT8tjw2Ln
 YfH4VfLIVjRv9nqBULa98L1Av+wI9uA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705396264;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sIMKbKxH9xtolgVZxn4NQV0XLUg9u5xxeuQwbupMVHw=;
 b=P/VHq5Zri6+qvxMen2c54qOdriuyaBsjyYKdcuF45zOiGJLK38S8hZPZzaSHHjnY81VOW6
 /LF7tSex2mDp3LCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705396263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sIMKbKxH9xtolgVZxn4NQV0XLUg9u5xxeuQwbupMVHw=;
 b=B0gJS/8TqqML2xLWxCDq5TxztbnGa863c+YyTSxJ4yMAhE/QcR+zoWoObfwU49FX3p+dyM
 o0Vox7CRzBG/WlCITUCaJRIsiltI+VrI4Cw04xOVjngdLXrE7NMbNKjGMXf570BHllqelY
 jMeExuvcRtVu23/NR+aQNBU5MgiffBY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705396263;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sIMKbKxH9xtolgVZxn4NQV0XLUg9u5xxeuQwbupMVHw=;
 b=UVE2tMLqZRaAWYO5hLYG4Er2fmtVJM8g03750REx7iAmi2X7qDb5GctrlYMxBqOdRKv6o+
 ejdsh2cJ8fy5bSAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B126D132FA;
 Tue, 16 Jan 2024 09:11:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xur4KCdIpmVCDQAAD6G6ig
 (envelope-from <iivanov@suse.de>); Tue, 16 Jan 2024 09:11:03 +0000
Date: Tue, 16 Jan 2024 11:11:03 +0200
From: "Ivan T. Ivanov" <iivanov@suse.de>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Matthias Brugger <mbrugger@suse.com>, 
 Peter Robinson <pbrobinson@gmail.com>,
 Dmitry Malkin <dmitry@bedrocksystems.com>, 
 Thomas Fitzsimmons <fitzsim@fitzsim.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>,
 wahrenst@gmx.net, u-boot@lists.denx.de
Subject: Re: Re: [PATCH v4 2/6] rpi5: Use devicetree as alternative way to
 read IO base addresses
Message-ID: <av6lh6ckkkdx6aci2hkocwhycfymoch2lf4ugf5u5c2ptlelim@32piyfrmwtbw>
References: <20240110122908.31612-1-iivanov@suse.de>
 <20240110122908.31612-3-iivanov@suse.de>
 <170b21a9-89b2-4072-981a-76b9ec772b5f@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170b21a9-89b2-4072-981a-76b9ec772b5f@broadcom.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.80 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.net];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_SEVEN(0.00)[10];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 FREEMAIL_CC(0.00)[suse.com,gmail.com,bedrocksystems.com,fitzsim.org,nxp.com,samsung.com,denx.de,gmx.net,lists.denx.de];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
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

On 01-10 10:00, Florian Fainelli wrote:
> On 1/10/24 04:29, Ivan T. Ivanov wrote:
> > From: Dmitry Malkin <dmitry@bedrocksystems.com>
> > 
> > MBOX and Watchdog on RPi5/bcm2712 has a different base IO offsets.
> 
> s/has a/have a /
> 

Thanks!

> > Find them via devicetree blob passed by bootloader.
> > 
> > Signed-off-by: Dmitry Malkin <dmitry@bedrocksystems.com>
> > Reviewed-by: Matthias Brugger <mbrugger@suse.com>
> > Signed-off-by: Ivan T. Ivanov <iivanov@suse.de>
> > ---
> >   arch/arm/mach-bcm283x/include/mach/base.h  |  5 ++-
> >   arch/arm/mach-bcm283x/include/mach/mbox.h  |  3 +-
> >   arch/arm/mach-bcm283x/include/mach/sdhci.h |  3 +-
> >   arch/arm/mach-bcm283x/include/mach/timer.h |  3 +-
> >   arch/arm/mach-bcm283x/include/mach/wdog.h  |  3 +-
> >   arch/arm/mach-bcm283x/init.c               | 43 ++++++++++++++++++----
> >   6 files changed, 43 insertions(+), 17 deletions(-)
> > 
> > diff --git a/arch/arm/mach-bcm283x/include/mach/base.h b/arch/arm/mach-bcm283x/include/mach/base.h
> > index 4ccaf69693..6de99e7ea1 100644
> > --- a/arch/arm/mach-bcm283x/include/mach/base.h
> > +++ b/arch/arm/mach-bcm283x/include/mach/base.h
> > @@ -6,7 +6,10 @@
> >   #ifndef _BCM283x_BASE_H_
> >   #define _BCM283x_BASE_H_
> > -extern unsigned long rpi_bcm283x_base;
> > +extern unsigned long rpi_mbox_base;
> > +extern unsigned long rpi_timer_base;
> > +extern unsigned long rpi_sdhci_base;
> > +extern unsigned long rpi_wdog_base;
> 
> Maybe suffix those variables with _phys_base to denote they are physical
> addresses, even if you seem to use a 1:1 mapping between virtual and
> physical, knowing which type of address we are dealing with right away is
> clearer.

I am not an expert on U-Boot, but I think mapping is always 1:1, so
explicit naming it that way looks redundant. As you can see even initial
naming don't specify it. But if you insist I could change it.

Regards,
Ivan

