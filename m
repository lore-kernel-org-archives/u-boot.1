Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5BBCC47077
	for <u-boot@archiver.kernel.org>; Tue, 16 Jan 2024 09:14:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D918F876EF;
	Tue, 16 Jan 2024 10:14:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="bQ3sIC+M";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qUi3qgTw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bQ3sIC+M";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qUi3qgTw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3061D8796E; Tue, 16 Jan 2024 10:14:09 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A79286D82
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 10:14:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=iivanov@suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 926E11FD55;
 Tue, 16 Jan 2024 09:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705396446; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WqG71fgLG3FRgKt5Ua57qvSjMnXgYZ4eknUwmttR2P8=;
 b=bQ3sIC+Mi+lUmB6yfAw6+jjaAEAtKp7YIdwB7p7QRnmcoNGG8R0wTw8vT22PPYUZ2PMpcP
 VZDmw3hmMNcrUcTMIB3wylOvTacGkR2Fj+CTW2JU7G1WQdNX8HgMbsmXTxxaupSAEUINJL
 C94E80S2qzK6xZcL6wyI7aFKwIWkiN4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705396446;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WqG71fgLG3FRgKt5Ua57qvSjMnXgYZ4eknUwmttR2P8=;
 b=qUi3qgTwQjLHcV6/yrTfRcg01NmdLU4nRgB4P3+OvTwmawuzvtol/dKFs5AWPx0qKzoIn1
 NfdEHt8JzozIPCBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705396446; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WqG71fgLG3FRgKt5Ua57qvSjMnXgYZ4eknUwmttR2P8=;
 b=bQ3sIC+Mi+lUmB6yfAw6+jjaAEAtKp7YIdwB7p7QRnmcoNGG8R0wTw8vT22PPYUZ2PMpcP
 VZDmw3hmMNcrUcTMIB3wylOvTacGkR2Fj+CTW2JU7G1WQdNX8HgMbsmXTxxaupSAEUINJL
 C94E80S2qzK6xZcL6wyI7aFKwIWkiN4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705396446;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WqG71fgLG3FRgKt5Ua57qvSjMnXgYZ4eknUwmttR2P8=;
 b=qUi3qgTwQjLHcV6/yrTfRcg01NmdLU4nRgB4P3+OvTwmawuzvtol/dKFs5AWPx0qKzoIn1
 NfdEHt8JzozIPCBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 71062132FA;
 Tue, 16 Jan 2024 09:14:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RIByGd5IpmWDDgAAD6G6ig
 (envelope-from <iivanov@suse.de>); Tue, 16 Jan 2024 09:14:06 +0000
Date: Tue, 16 Jan 2024 11:14:05 +0200
From: "Ivan T. Ivanov" <iivanov@suse.de>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Matthias Brugger <mbrugger@suse.com>, 
 Peter Robinson <pbrobinson@gmail.com>,
 Dmitry Malkin <dmitry@bedrocksystems.com>, 
 Thomas Fitzsimmons <fitzsim@fitzsim.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>, 
 florian.fainelli@broadcom.com, u-boot@lists.denx.de
Subject: Re: Re: Re: [PATCH v4 5/6] mmc: bcmstb: Add support for bcm2712 SD
 controller
Message-ID: <pafdu7lrvmk5rfezzxy7rpygih6atnrco2emooku2wim7io2sg@cvuxtvx5pu52>
References: <20240110122908.31612-1-iivanov@suse.de>
 <20240110122908.31612-6-iivanov@suse.de>
 <ce4b4620-58ed-44c1-83bc-5c536e8fc015@gmx.net>
 <ahlzpwryiue44gkdr3nb2hcijyvawmhqq67gyyre3xsqqbiie3@gkouzitj2ef6>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahlzpwryiue44gkdr3nb2hcijyvawmhqq67gyyre3xsqqbiie3@gkouzitj2ef6>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [0.40 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.net];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_SEVEN(0.00)[10]; FREEMAIL_TO(0.00)[gmx.net];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 FREEMAIL_CC(0.00)[suse.com,gmail.com,bedrocksystems.com,fitzsim.org,nxp.com,samsung.com,denx.de,broadcom.com,lists.denx.de];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[24.66%]
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

Hi,

> On 01-12 09:44, Ivan T. Ivanov wrote:
> On 01-11 23:07, Stefan Wahren wrote:
> > 
> > Hi Ivan,
> > 
> > Am 10.01.24 um 13:29 schrieb Ivan T. Ivanov:
> > > Borrow SD quirks from vendor Linux driver.
> > > 
> > > "BCM2712 unfortunately carries with it a perennial bug with the SD
> > > controller register interface present on previous chips (2711/2709/2708).
> > > Accesses must be dword-sized and a read-modify-write cycle to the 32-bit
> > > registers containing the COMMAND, TRANSFER_MODE, BLOCK_SIZE and
> > > BLOCK_COUNT registers tramples the upper/lower 16 bits of data written.
> > > BCM2712 does not seem to need the extreme delay between each write as on
> > > previous chips, just the serialisation of writes to these registers in a
> > > single 32-bit operation."
> > > 
> > > Signed-off-by: Ivan T. Ivanov <iivanov@suse.de>
> > did you noticed this commit/pull request?
> > 
> > https://github.com/raspberrypi/linux/pull/5842/commits/3c9d840dc933cfb13a77fd3c03356ee4adacc30b
> 
> Doh, no. Let me check.

And indeed, no special accessors are needed. I am preparing new version
and will send it shortly.

Thanks,
Ivan

