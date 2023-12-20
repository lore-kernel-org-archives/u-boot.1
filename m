Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A24EC3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 08:13:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 110FC86FFE;
	Wed, 20 Dec 2023 09:13:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="DtouY4hS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tOL5ntn0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DtouY4hS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tOL5ntn0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1A9A86CF4; Wed, 20 Dec 2023 09:13:03 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCBF28701C
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 09:13:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=iivanov@suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1D4171F820;
 Wed, 20 Dec 2023 08:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1703059981; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RsV5RSSC6FRiCeuQNSxygSMxh6IMv1QDrYAojZBGvlI=;
 b=DtouY4hSIMnfwMj6tyZOxJBmPGD9NoGCMRxSrQzn7odBHNhlKb03AleMrI5jhoKYo21Qrc
 BVyF2oHCrgRLfJxeVuV6BdYPIbSy/HZ2xcdAmAg7xFugaIVxsFPFB3krZvmB673LaD8S92
 2jupHJwpH3f1Xx6VowmDsdbdUraawKI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1703059981;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RsV5RSSC6FRiCeuQNSxygSMxh6IMv1QDrYAojZBGvlI=;
 b=tOL5ntn08O1olZD/y24uwwMPsKmUeRzaXIi+kHzjAV009YOWUdaFlkWV+7Y3pp7NSBbq2Y
 IA0Pi4h/kmvmBZBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1703059981; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RsV5RSSC6FRiCeuQNSxygSMxh6IMv1QDrYAojZBGvlI=;
 b=DtouY4hSIMnfwMj6tyZOxJBmPGD9NoGCMRxSrQzn7odBHNhlKb03AleMrI5jhoKYo21Qrc
 BVyF2oHCrgRLfJxeVuV6BdYPIbSy/HZ2xcdAmAg7xFugaIVxsFPFB3krZvmB673LaD8S92
 2jupHJwpH3f1Xx6VowmDsdbdUraawKI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1703059981;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RsV5RSSC6FRiCeuQNSxygSMxh6IMv1QDrYAojZBGvlI=;
 b=tOL5ntn08O1olZD/y24uwwMPsKmUeRzaXIi+kHzjAV009YOWUdaFlkWV+7Y3pp7NSBbq2Y
 IA0Pi4h/kmvmBZBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C31B113722;
 Wed, 20 Dec 2023 08:13:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id k6ifKAyigmUxSAAAD6G6ig
 (envelope-from <iivanov@suse.de>); Wed, 20 Dec 2023 08:13:00 +0000
Date: Wed, 20 Dec 2023 10:12:59 +0200
From: "Ivan T. Ivanov" <iivanov@suse.de>
To: Simon Glass <sjg@chromium.org>
Cc: Matthias Brugger <mbrugger@suse.com>, 
 Peter Robinson <pbrobinson@gmail.com>,
 Dmitry Malkin <dmitry@bedrocksystems.com>, 
 Thomas Fitzsimmons <fitzsim@fitzsim.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>,
 wahrenst@gmx.net, florian.fainelli@broadcom.com, u-boot@lists.denx.de
Subject: Re: [PATCH v3 1/7] rpi5: add initial memory map for bcm2712
Message-ID: <5hau3b6hrefjvczekgf37e4gcdpyzhrylur33kwsjl7cfhbnw6@say3fl3cwx7z>
References: <20231218210341.30073-1-iivanov@suse.de>
 <20231218210341.30073-2-iivanov@suse.de>
 <CAPnjgZ2n2o1mu2PtkgwEB1dFeaeRx+uNSkSrSogU76vnLGfKRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPnjgZ2n2o1mu2PtkgwEB1dFeaeRx+uNSkSrSogU76vnLGfKRA@mail.gmail.com>
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DtouY4hS;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=tOL5ntn0
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.94 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.net];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[11];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 FREEMAIL_CC(0.00)[suse.com,gmail.com,bedrocksystems.com,fitzsim.org,nxp.com,samsung.com,denx.de,gmx.net,broadcom.com,lists.denx.de];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-2.93)[99.70%]
X-Rspamd-Queue-Id: 1D4171F820
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

On 12-19 21:45, Simon Glass wrote:
> >
> > +static struct mm_region bcm2712_mem_map[MEM_MAP_MAX_ENTRIES] = {
> 
> Would it be possible to read these from the devicetree?

If there is a devicetree passed, yes, it will be possible.
I have not done this just because I can't test all possible
combinations on older platforms. But for IO regions I am
not sure how feasible this is.

> 
> > +       {
> > +               .virt = 0x00000000UL,
> > +               .phys = 0x00000000UL,
> > +               .size = 0x3f800000UL,
> > +               .attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
> > +                        PTE_BLOCK_INNER_SHARE
> > +       }, {
> 

Regards,
Ivan

