Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 743C9106B533
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 13:26:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B671684073;
	Wed, 25 Mar 2026 14:25:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="gd8l1zud";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CUTM3jtl";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gd8l1zud";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CUTM3jtl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7278A83FA7; Wed, 25 Mar 2026 12:51:57 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FBE580077
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 12:51:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pfalcato@suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D46B45BCD0;
 Wed, 25 Mar 2026 11:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774439514; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CUu1WbLa1lpWCoL1/D+66dYNkzFs7XNjhbUPWYy2aWw=;
 b=gd8l1zudbwN6kmo2a1TXpNg+jQNddnnYp2RMyTpFV4BoB12wYFIcebx289kScawoDwx7y6
 mzQMxkTFnAB8EacT33CajxRldrm6eUoJJee+KDHPzxUVg04KUo4IRQNtea9WSThb3a8EMh
 9w6rgefhBaA3lcO/FyKhRUapKDRQWKE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774439514;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CUu1WbLa1lpWCoL1/D+66dYNkzFs7XNjhbUPWYy2aWw=;
 b=CUTM3jtlQfboq4grZ+pXgOkYg6Tf5lZYxKGCRonLq/MvEvR305dqMc2B22JAm+Mz9jZjpy
 o5MqbdAm86LeFeDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gd8l1zud;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=CUTM3jtl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774439514; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CUu1WbLa1lpWCoL1/D+66dYNkzFs7XNjhbUPWYy2aWw=;
 b=gd8l1zudbwN6kmo2a1TXpNg+jQNddnnYp2RMyTpFV4BoB12wYFIcebx289kScawoDwx7y6
 mzQMxkTFnAB8EacT33CajxRldrm6eUoJJee+KDHPzxUVg04KUo4IRQNtea9WSThb3a8EMh
 9w6rgefhBaA3lcO/FyKhRUapKDRQWKE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774439514;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CUu1WbLa1lpWCoL1/D+66dYNkzFs7XNjhbUPWYy2aWw=;
 b=CUTM3jtlQfboq4grZ+pXgOkYg6Tf5lZYxKGCRonLq/MvEvR305dqMc2B22JAm+Mz9jZjpy
 o5MqbdAm86LeFeDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 75B91443AC;
 Wed, 25 Mar 2026 11:51:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OIlYGVnMw2m2IwAAD6G6ig
 (envelope-from <pfalcato@suse.de>); Wed, 25 Mar 2026 11:51:53 +0000
Date: Wed, 25 Mar 2026 11:51:51 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Torsten Duwe <duwe@lst.de>
Cc: Peter Robinson <pbrobinson@gmail.com>, 
 Matthias Brugger <mbrugger@suse.com>, Tom Rini <trini@konsulko.com>, 
 Jan =?utf-8?B?xIxlcm3DoWs=?= <sairon@sairon.cz>,
 Andrea della Porta <andrea.porta@suse.com>, 
 "Ivan T. Ivanov" <iivanov@suse.de>,
 Stanimir Varbanov <stanimir.varbanov@suse.com>, 
 Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
 Volodymyr Babchuk <volodymyr_babchuk@epam.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Christian Marangi <ansuelsmth@gmail.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Huan Zhou <me@per1cycle.org>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Joseph Chen <chenjh@rock-chips.com>, 
 Elaine Zhang <zhangqing@rock-chips.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 0/9] ARM: RPi5: Enable PCIe
Message-ID: <h62tu5tdy5g72vcb6llkcrbcdcqosfqs3rydezk7xm4gyxx6an@uqh4wjittlqc>
References: <20260227152046.42DE068B05@verein.lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227152046.42DE068B05@verein.lst.de>
X-Spamd-Result: default: False [-2.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWELVE(0.00)[22]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FREEMAIL_CC(0.00)[gmail.com,suse.com,konsulko.com,sairon.cz,suse.de,epam.com,mailbox.org,bp.renesas.com,foss.st.com,per1cycle.org,rock-chips.com,kwiboo.se,lists.denx.de];
 RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TAGGED_RCPT(0.00)[renesas];
 DKIM_TRACE(0.00)[suse.de:+]; MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.de:dkim, suse.de:email]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D46B45BCD0
X-Mailman-Approved-At: Wed, 25 Mar 2026 14:25:38 +0100
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

On Fri, Feb 27, 2026 at 04:20:46PM +0100, Torsten Duwe wrote:
> Hi Peter,
> 
> here is a rework of the RPi5 PCIe changes, hopefully the way you
> requested. This first series only enables the BCM2712 root complexes
> and allows for PCI enumeration. In order to be useful besides any
> already-supported PCIe hardware in a generic adapter, at least one
> serious NVMe fix is needed, as well as some device tree trickery,
> which I'll both follow up with in order to demonstrate the
> functionality.
> 
> 	Torsten
>

For the series:

Tested-by: Pedro Falcato <pfalcato@suse.de>

Ihanks for the awesome work!! 

-- 
Pedro
