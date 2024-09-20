Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE39CF58E5
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 08:10:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3FA1893C5;
	Fri, 20 Sep 2024 10:10:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="ufPeDFpp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IrnUMxfw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ufPeDFpp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IrnUMxfw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EACAD892E1; Fri, 20 Sep 2024 10:10:36 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 151C2893BE
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 10:10:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=iivanov@suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A7DB333A11;
 Fri, 20 Sep 2024 08:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726819831; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=92mZTBpOniPPPuvKDm8gpfx5NWALlVlNHaXwuSic4P4=;
 b=ufPeDFppiQsPsi9UGd6BpX7PvT1mcMprUlVPeMv0IeSWi99XYjkqB52LxZQHvgffP/Fm9G
 kK4C85uGmCV5gcyleLyBgnVkon5sUWEhJkc+zyaXOVAc6NMZ1PjxjlhFkf5cq5djwnNmjz
 4fO9K0IoHXjXOzBDGr+VSQZ5XlNbUwU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726819831;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=92mZTBpOniPPPuvKDm8gpfx5NWALlVlNHaXwuSic4P4=;
 b=IrnUMxfwEpJaG+MhDv/q5sJtxexUnSGgr5ury/4Hq5v+xQ+i9oO58isQRKsDDf12YU9e/G
 esvTyO2RKRgYadDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726819831; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=92mZTBpOniPPPuvKDm8gpfx5NWALlVlNHaXwuSic4P4=;
 b=ufPeDFppiQsPsi9UGd6BpX7PvT1mcMprUlVPeMv0IeSWi99XYjkqB52LxZQHvgffP/Fm9G
 kK4C85uGmCV5gcyleLyBgnVkon5sUWEhJkc+zyaXOVAc6NMZ1PjxjlhFkf5cq5djwnNmjz
 4fO9K0IoHXjXOzBDGr+VSQZ5XlNbUwU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726819831;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=92mZTBpOniPPPuvKDm8gpfx5NWALlVlNHaXwuSic4P4=;
 b=IrnUMxfwEpJaG+MhDv/q5sJtxexUnSGgr5ury/4Hq5v+xQ+i9oO58isQRKsDDf12YU9e/G
 esvTyO2RKRgYadDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 860D013AA7;
 Fri, 20 Sep 2024 08:10:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2iVrHvct7WYaXAAAD6G6ig
 (envelope-from <iivanov@suse.de>); Fri, 20 Sep 2024 08:10:31 +0000
Date: Fri, 20 Sep 2024 11:16:25 +0300
From: "Ivan T. Ivanov" <iivanov@suse.de>
To: Martin Stolpe <martinstolpe@gmail.com>
Cc: u-boot@lists.denx.de, Martin Stolpe <martin.stolpe@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>, Francois Berder <fberder@outlook.fr>,
 Matthias Brugger <mbrugger@suse.com>, Nikhil M Jain <n-jain1@ti.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 1/1] rpi: Fix build error when CONFIG_VIDEO is disabled
 for Raspberry Pi
Message-ID: <20240920081625.z3fwz6n7o2zxd4gf@localhost.localdomain>
References: <20240920063204.1049202-1-martin.stolpe@gmail.com>
 <20240920063204.1049202-2-martin.stolpe@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240920063204.1049202-2-martin.stolpe@gmail.com>
X-Spamd-Result: default: False [0.16 / 50.00]; SUSPICIOUS_RECIPS(1.50)[];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 BAYES_HAM(-0.04)[58.75%]; FREEMAIL_TO(0.00)[gmail.com];
 TAGGED_RCPT(0.00)[]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[10];
 FREEMAIL_ENVRCPT(0.00)[gmail.com,outlook.fr];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[lists.denx.de,gmail.com,ti.com,outlook.fr,suse.com,prevas.dk,konsulko.com];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
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

On 09-20 08:32, Martin Stolpe wrote:
> 
> When the CONFIG_VIDEO option is set to disabled for Raspberry Pi devices
> the build will fail with the following error message:
> "undefined reference to `fdt_simplefb_enable_and_mem_rsv'."
> 
> Signed-off-by: Martin Stolpe <martin.stolpe@gmail.com>
> ---
> 
>  board/raspberrypi/rpi/rpi.c | 2 +-
>  boot/fdt_simplefb.c         | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
> index ab5ea85cf9..bc49708f85 100644
> --- a/board/raspberrypi/rpi/rpi.c
> +++ b/board/raspberrypi/rpi/rpi.c
> @@ -572,7 +572,7 @@ int ft_board_setup(void *blob, struct bd_info *bd)
>  	node = fdt_node_offset_by_compatible(blob, -1, "simple-framebuffer");
>  	if (node < 0)
>  		fdt_simplefb_add_node(blob);
> -	else
> +	else if (IS_ENABLED(CONFIG_VIDEO))
>  		fdt_simplefb_enable_and_mem_rsv(blob);

I think there is one more user of this function which end of same
situation stm32mp1.

>  
>  #ifdef CONFIG_EFI_LOADER
> diff --git a/boot/fdt_simplefb.c b/boot/fdt_simplefb.c
> index 5341554845..b6e916ff7d 100644
> --- a/boot/fdt_simplefb.c
> +++ b/boot/fdt_simplefb.c
> @@ -86,6 +86,7 @@ int fdt_simplefb_add_node(void *blob)
>  	return fdt_simplefb_configure_node(blob, off);
>  }
>  
> +#if IS_ENABLED(CONFIG_VIDEO)
>  /**
>   * fdt_simplefb_enable_existing_node() - enable simple-framebuffer DT node
>   *
> @@ -103,7 +104,6 @@ static int fdt_simplefb_enable_existing_node(void *blob)
>  	return fdt_simplefb_configure_node(blob, off);
>  }
>  
> -#if IS_ENABLED(CONFIG_VIDEO)
>  int fdt_simplefb_enable_and_mem_rsv(void *blob)
>  {

Perhaps it will be better if above check is moved inside this function
making it empty in case of CONFIG_VIDEO is not set. This way you will
not need to modify it users.

Regards,
Ivan


