Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 420DEC4706C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 07:45:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6125B878E5;
	Fri, 12 Jan 2024 08:45:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="B3ljkVey";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="T+EFJZu/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="B3ljkVey";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="T+EFJZu/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E03F5871C3; Fri, 12 Jan 2024 08:45:01 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1907F8794F
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 08:44:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=iivanov@suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6D3D31FC04;
 Fri, 12 Jan 2024 07:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705045497; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TvMDVsrtMyogpl0UKG+UFoUKcDp7XtHWhwSxzdiNNko=;
 b=B3ljkVeyaB4wEVz5w52OeHoVGthYE/hMkQF6wEFq4fDyrB1W/p+0JF9IFYIjZ2wu8JglOB
 5vN41l2M9IxaGlh82Y0hGoEpkWxvtDWPu/VGdofV8fILAdU9AzCzw6/LGgkn/o3+mc6xpE
 M4YXHdh5HBwaugOf5YbW3BpjLh4/19c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705045497;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TvMDVsrtMyogpl0UKG+UFoUKcDp7XtHWhwSxzdiNNko=;
 b=T+EFJZu/9/5FrbcTOYfRkWqsnwoKhyhcKaiu2pKGy4JUT7aDWE0/4RMVnYkyPGqXVq0j1C
 krsOUrBiTISiR2BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705045497; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TvMDVsrtMyogpl0UKG+UFoUKcDp7XtHWhwSxzdiNNko=;
 b=B3ljkVeyaB4wEVz5w52OeHoVGthYE/hMkQF6wEFq4fDyrB1W/p+0JF9IFYIjZ2wu8JglOB
 5vN41l2M9IxaGlh82Y0hGoEpkWxvtDWPu/VGdofV8fILAdU9AzCzw6/LGgkn/o3+mc6xpE
 M4YXHdh5HBwaugOf5YbW3BpjLh4/19c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705045497;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TvMDVsrtMyogpl0UKG+UFoUKcDp7XtHWhwSxzdiNNko=;
 b=T+EFJZu/9/5FrbcTOYfRkWqsnwoKhyhcKaiu2pKGy4JUT7aDWE0/4RMVnYkyPGqXVq0j1C
 krsOUrBiTISiR2BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A52B136A4;
 Fri, 12 Jan 2024 07:44:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4JlUD/ntoGU0GQAAD6G6ig
 (envelope-from <iivanov@suse.de>); Fri, 12 Jan 2024 07:44:57 +0000
Date: Fri, 12 Jan 2024 09:44:48 +0200
From: "Ivan T. Ivanov" <iivanov@suse.de>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Matthias Brugger <mbrugger@suse.com>, 
 Peter Robinson <pbrobinson@gmail.com>,
 Dmitry Malkin <dmitry@bedrocksystems.com>, 
 Thomas Fitzsimmons <fitzsim@fitzsim.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>, 
 florian.fainelli@broadcom.com, u-boot@lists.denx.de
Subject: Re: Re: [PATCH v4 5/6] mmc: bcmstb: Add support for bcm2712 SD
 controller
Message-ID: <ahlzpwryiue44gkdr3nb2hcijyvawmhqq67gyyre3xsqqbiie3@gkouzitj2ef6>
References: <20240110122908.31612-1-iivanov@suse.de>
 <20240110122908.31612-6-iivanov@suse.de>
 <ce4b4620-58ed-44c1-83bc-5c536e8fc015@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce4b4620-58ed-44c1-83bc-5c536e8fc015@gmx.net>
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=B3ljkVey;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="T+EFJZu/"
X-Spamd-Result: default: False [-1.31 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.net];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[10];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FREEMAIL_TO(0.00)[gmx.net]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[];
 FREEMAIL_CC(0.00)[suse.com,gmail.com,bedrocksystems.com,fitzsim.org,nxp.com,samsung.com,denx.de,broadcom.com,lists.denx.de];
 RCVD_TLS_ALL(0.00)[];
 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 6D3D31FC04
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

On 01-11 23:07, Stefan Wahren wrote:
> 
> Hi Ivan,
> 
> Am 10.01.24 um 13:29 schrieb Ivan T. Ivanov:
> > Borrow SD quirks from vendor Linux driver.
> > 
> > "BCM2712 unfortunately carries with it a perennial bug with the SD
> > controller register interface present on previous chips (2711/2709/2708).
> > Accesses must be dword-sized and a read-modify-write cycle to the 32-bit
> > registers containing the COMMAND, TRANSFER_MODE, BLOCK_SIZE and
> > BLOCK_COUNT registers tramples the upper/lower 16 bits of data written.
> > BCM2712 does not seem to need the extreme delay between each write as on
> > previous chips, just the serialisation of writes to these registers in a
> > single 32-bit operation."
> > 
> > Signed-off-by: Ivan T. Ivanov <iivanov@suse.de>
> did you noticed this commit/pull request?
> 
> https://github.com/raspberrypi/linux/pull/5842/commits/3c9d840dc933cfb13a77fd3c03356ee4adacc30b

Doh, no. Let me check.

Thanks!
Ivan

