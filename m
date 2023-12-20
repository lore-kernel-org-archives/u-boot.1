Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ABD1C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 12:08:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 579E787682;
	Wed, 20 Dec 2023 13:08:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="E8qmvarf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="h3otqcMm";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="E8qmvarf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="h3otqcMm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 522A187705; Wed, 20 Dec 2023 13:08:44 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C139871C3
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 13:08:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=iivanov@suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C03411F82B;
 Wed, 20 Dec 2023 12:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1703074121; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hS4D0B0mceq7jddXXfJ7ZfP/8JjooRajrATahS9RbTM=;
 b=E8qmvarfXz9Yoe7v96mufm4WhvZE50iOwO5+GgWoIIe9ux2CD9txYdbutSbOp0A18cdaMz
 urCzH0erPZU/DLhick7DzuAl0+1TEl3CTOcWT/kpFjbmFL/awHD8ahC8XVea0+UCq+NGft
 EzBjHxA3OJSxR6/opJSIwuXvvgQxXNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1703074121;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hS4D0B0mceq7jddXXfJ7ZfP/8JjooRajrATahS9RbTM=;
 b=h3otqcMm8XhTHVE9C9jWn4BxA/6SvCkcKcSCkfOUg2+9p9js0gOmni72lzhCOP6szA7CkV
 LvDxBG1K6ZucRVCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1703074121; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hS4D0B0mceq7jddXXfJ7ZfP/8JjooRajrATahS9RbTM=;
 b=E8qmvarfXz9Yoe7v96mufm4WhvZE50iOwO5+GgWoIIe9ux2CD9txYdbutSbOp0A18cdaMz
 urCzH0erPZU/DLhick7DzuAl0+1TEl3CTOcWT/kpFjbmFL/awHD8ahC8XVea0+UCq+NGft
 EzBjHxA3OJSxR6/opJSIwuXvvgQxXNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1703074121;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hS4D0B0mceq7jddXXfJ7ZfP/8JjooRajrATahS9RbTM=;
 b=h3otqcMm8XhTHVE9C9jWn4BxA/6SvCkcKcSCkfOUg2+9p9js0gOmni72lzhCOP6szA7CkV
 LvDxBG1K6ZucRVCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F7DF13722;
 Wed, 20 Dec 2023 12:08:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zAY1H0nZgmUDfwAAD6G6ig
 (envelope-from <iivanov@suse.de>); Wed, 20 Dec 2023 12:08:41 +0000
Date: Wed, 20 Dec 2023 14:08:32 +0200
From: "Ivan T . Ivanov" <iivanov@suse.de>
To: Matthias Brugger <mbrugger@suse.com>, 
 Peter Robinson <pbrobinson@gmail.com>
Cc: Dmitry Malkin <dmitry@bedrocksystems.com>, 
 Thomas Fitzsimmons <fitzsim@fitzsim.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>,
 wahrenst@gmx.net, florian.fainelli@broadcom.com, u-boot@lists.denx.de
Subject: Re: [PATCH v3 1/7] rpi5: add initial memory map for bcm2712
Message-ID: <wryhkurzctq3jczwdrvzxwyjvpubj3zphnnvzfwlslklmsnvuz@st3bhkk3kl5g>
References: <20231218210341.30073-1-iivanov@suse.de>
 <20231218210341.30073-2-iivanov@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218210341.30073-2-iivanov@suse.de>
X-Spamd-Result: default: False [-2.42 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.net];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_SEVEN(0.00)[10];
 FREEMAIL_TO(0.00)[suse.com,gmail.com];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 FREEMAIL_CC(0.00)[bedrocksystems.com,fitzsim.org,nxp.com,samsung.com,denx.de,gmx.net,broadcom.com,lists.denx.de];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-2.82)[99.21%]
Authentication-Results: smtp-out2.suse.de;
	none
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

On 12-18 23:03, Ivan T. Ivanov wrote:
>  
> +static struct mm_region bcm2712_mem_map[MEM_MAP_MAX_ENTRIES] = {
> +	{
> +		.virt = 0x00000000UL,
> +		.phys = 0x00000000UL,
> +		.size = 0x3f800000UL,

Something that I realized just now. This memory map is valid only if
HDMI cable is plugged in. Otherwise size of this section is 0x3fc00000.
This is how it is populated by the embedded  bootloaader.

Which I am reading as: bootloader do not expose video framebuffer if
HDMI cable is not plugged in at boot time.

With current map, board hang at boot if HDMI is not plugged in.

If I make first region with size 0x3Fc00000 and remove below
dedicated framebuffer region, device boots with and without
HDMI cable plugged in.

> +		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
> +			 PTE_BLOCK_INNER_SHARE
> +	}, {
> +		.virt = 0x3f800000UL,
> +		.phys = 0x3f800000UL,
> +		.size = 0x00800000UL,
> +		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +			 PTE_BLOCK_NON_SHARE |
> +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +	}, {

Sorry that I missed it the first time.

Regards,
Ivan

