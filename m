Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC0A3C41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 08:40:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1648486FBD;
	Tue, 19 Dec 2023 09:40:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="ytOkps4L";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Jrea0Cu/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ytOkps4L";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Jrea0Cu/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F56286FB8; Tue, 19 Dec 2023 09:40:45 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CF0286FBD
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 09:40:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=iivanov@suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9400C1F7B6;
 Tue, 19 Dec 2023 08:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1702975241; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kQcwKt+4UoS9LJx8KVXvgf8dXiG7xNgLqbMRyDVwdnc=;
 b=ytOkps4LEUujda3H8XlrdGNXTfMV5WGAj3xGhBxbsd1z8+u6hVqDUdXw8FpEllsoJB1grR
 2oqZGVJHCMJSQiE7kHNB3x6YwU8XeYI94cJFW7L9TY8DoD8FKdBOdHFRlV1Eh3KNEX7mfK
 VikO+0J4Yrw95gLDI/YLaTfnBQRwpZA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1702975241;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kQcwKt+4UoS9LJx8KVXvgf8dXiG7xNgLqbMRyDVwdnc=;
 b=Jrea0Cu/ojiu/zUE5PUJmYsM0ghubI6T5B3bz91kqr46x4lPexpOpwyM7D1s1JbnfRAO17
 sgbLrBz8wM4AR9Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1702975241; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kQcwKt+4UoS9LJx8KVXvgf8dXiG7xNgLqbMRyDVwdnc=;
 b=ytOkps4LEUujda3H8XlrdGNXTfMV5WGAj3xGhBxbsd1z8+u6hVqDUdXw8FpEllsoJB1grR
 2oqZGVJHCMJSQiE7kHNB3x6YwU8XeYI94cJFW7L9TY8DoD8FKdBOdHFRlV1Eh3KNEX7mfK
 VikO+0J4Yrw95gLDI/YLaTfnBQRwpZA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1702975241;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kQcwKt+4UoS9LJx8KVXvgf8dXiG7xNgLqbMRyDVwdnc=;
 b=Jrea0Cu/ojiu/zUE5PUJmYsM0ghubI6T5B3bz91kqr46x4lPexpOpwyM7D1s1JbnfRAO17
 sgbLrBz8wM4AR9Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7157C136A5;
 Tue, 19 Dec 2023 08:40:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7I5nGQlXgWXnBgAAD6G6ig
 (envelope-from <iivanov@suse.de>); Tue, 19 Dec 2023 08:40:41 +0000
Date: Tue, 19 Dec 2023 10:40:36 +0200
From: "Ivan T. Ivanov" <iivanov@suse.de>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Matthias Brugger <mbrugger@suse.com>, 
 Peter Robinson <pbrobinson@gmail.com>,
 Dmitry Malkin <dmitry@bedrocksystems.com>, 
 Thomas Fitzsimmons <fitzsim@fitzsim.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>, 
 florian.fainelli@broadcom.com, u-boot@lists.denx.de
Subject: Re: [PATCH v3 1/7] rpi5: add initial memory map for bcm2712
Message-ID: <rtatihjkufxwf6rk67j272za4rmbrg5maa37pbnnnadoxpht3e@4rqvi7h5eeta>
References: <20231218210341.30073-1-iivanov@suse.de>
 <20231218210341.30073-2-iivanov@suse.de>
 <9d0fc4f9-3f58-4ebc-9af6-82b8823f08dc@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d0fc4f9-3f58-4ebc-9af6-82b8823f08dc@gmx.net>
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ytOkps4L;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="Jrea0Cu/"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.01 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.net];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[10];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
 FREEMAIL_TO(0.00)[gmx.net]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[];
 FREEMAIL_CC(0.00)[suse.com,gmail.com,bedrocksystems.com,fitzsim.org,nxp.com,samsung.com,denx.de,broadcom.com,lists.denx.de];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: 9400C1F7B6
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

On 12-18 23:25, Stefan Wahren wrote:
> > 
> > +static struct mm_region bcm2712_mem_map[MEM_MAP_MAX_ENTRIES] = {
> > +	{
> in comparison to mach-imx/imx9/soc.c most of the memory maps doesn't
> have a describing comment.

Yep, I have thinking to add more comments, but decided to not modify too
much patch from Dmitry. On the other side there is not much excitement
stuff here.

> > +		.virt = 0x00000000UL,
> > +		.phys = 0x00000000UL,
> > +		.size = 0x3f800000UL,
> > +		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
> > +			 PTE_BLOCK_INNER_SHARE
> > +	}, {
> > +		.virt = 0x3f800000UL,
> > +		.phys = 0x3f800000UL,
> > +		.size = 0x00800000UL,
> > +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> > +			 PTE_BLOCK_NON_SHARE |
> > +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> > +	}, {
> > +		/* Beginning of AXI bus where uSD controller lives */
> > +		.virt = 0x1000000000UL,
> > +		.phys = 0x1000000000UL,
> > +		.size = 0x0002000000UL,
> > +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> > +			 PTE_BLOCK_NON_SHARE |
> > +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> > +	}, {
> > +		.virt = 0x107c000000UL,
> > +		.phys = 0x107c000000UL,
> > +		.size = 0x0004000000UL,
> > +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> > +			 PTE_BLOCK_NON_SHARE |
> > +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> > +	}, {
> > +		/* List terminator */
> > +		0,
> > +	}
> > +};
> > +
> >   struct mm_region *mem_map = bcm283x_mem_map;
> > 
> >   /*
> > @@ -78,6 +113,7 @@ static const struct udevice_id board_ids[] = {
> >   	{ .compatible = "brcm,bcm2837", .data = (ulong)&bcm283x_mem_map},
> >   	{ .compatible = "brcm,bcm2838", .data = (ulong)&bcm2711_mem_map},
> >   	{ .compatible = "brcm,bcm2711", .data = (ulong)&bcm2711_mem_map},
> > +	{ .compatible = "brcm,bcm2712", .data = (ulong)&bcm2712_mem_map},
> >   	{ },
> >   };
> > 
> Looking at the complete file, i saw the function print_cpuinfo().
> Personally i think it's wrong to print BCM283x in case of a RPI 4 or 5.

CONFIG_DISPLAY_CPUINFO is not set for RPi's, but I suppose this could be nice
aesthetic enhancement.

Thanks,
Ivan


