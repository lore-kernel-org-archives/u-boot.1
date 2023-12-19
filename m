Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC4CC41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 08:51:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6A09871B4;
	Tue, 19 Dec 2023 09:51:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="YHbbkDHE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jYA5V81W";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YHbbkDHE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jYA5V81W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1A9F86F34; Tue, 19 Dec 2023 09:51:24 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4815871B4
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 09:51:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=iivanov@suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 654DB1FD58;
 Tue, 19 Dec 2023 08:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1702975881; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zHHQ4InJCdy0qUaJqhd4XGOVZ1rDsuwvxlmFNq9KYw0=;
 b=YHbbkDHEO79F9WqoyMMU02KYra/bXBjvedIp2vSNf50Ly8msoiqxoEYu5/F2xHytz1FGvb
 bgukxBk/KK95U6w7pwF3JMB0GtEw8LvHVqx2J39Qp9gkN8+cCCF8pnZ3CPBkj74DvOUlXz
 HDLz1m3ErGu5CLG9IPTLfISknZYQHoE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1702975881;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zHHQ4InJCdy0qUaJqhd4XGOVZ1rDsuwvxlmFNq9KYw0=;
 b=jYA5V81W56eBIOk0j8vjd5V0HWTzQ2kfqSbl+E+0zLIA5TaZ7c1GjLV9XVS9/WAS3D3Yju
 VefzYVVYLw3Vm5Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1702975881; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zHHQ4InJCdy0qUaJqhd4XGOVZ1rDsuwvxlmFNq9KYw0=;
 b=YHbbkDHEO79F9WqoyMMU02KYra/bXBjvedIp2vSNf50Ly8msoiqxoEYu5/F2xHytz1FGvb
 bgukxBk/KK95U6w7pwF3JMB0GtEw8LvHVqx2J39Qp9gkN8+cCCF8pnZ3CPBkj74DvOUlXz
 HDLz1m3ErGu5CLG9IPTLfISknZYQHoE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1702975881;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zHHQ4InJCdy0qUaJqhd4XGOVZ1rDsuwvxlmFNq9KYw0=;
 b=jYA5V81W56eBIOk0j8vjd5V0HWTzQ2kfqSbl+E+0zLIA5TaZ7c1GjLV9XVS9/WAS3D3Yju
 VefzYVVYLw3Vm5Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 42D64136A5;
 Tue, 19 Dec 2023 08:51:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gr8WDolZgWW/CQAAD6G6ig
 (envelope-from <iivanov@suse.de>); Tue, 19 Dec 2023 08:51:21 +0000
Date: Tue, 19 Dec 2023 10:51:20 +0200
From: "Ivan T. Ivanov" <iivanov@suse.de>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Matthias Brugger <mbrugger@suse.com>, 
 Peter Robinson <pbrobinson@gmail.com>,
 Dmitry Malkin <dmitry@bedrocksystems.com>, 
 Thomas Fitzsimmons <fitzsim@fitzsim.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>, 
 florian.fainelli@broadcom.com, u-boot@lists.denx.de
Subject: Re: [PATCH v3 4/7] bcm2835: brcm,bcm2708-fb device is using r5g6b5
 format
Message-ID: <tosej62qjugymvxevjaqq6kqkkjlo3qpkbzaw4xx4ot6fk3j54@evih5bgvfdtf>
References: <20231218210341.30073-1-iivanov@suse.de>
 <20231218210341.30073-5-iivanov@suse.de>
 <7764be07-c3cc-47e0-a284-4ba9420a843f@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7764be07-c3cc-47e0-a284-4ba9420a843f@gmx.net>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-1.02 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.net];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; RCPT_COUNT_SEVEN(0.00)[10];
 FREEMAIL_TO(0.00)[gmx.net]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[];
 FREEMAIL_CC(0.00)[suse.com,gmail.com,bedrocksystems.com,fitzsim.org,nxp.com,samsung.com,denx.de,broadcom.com,lists.denx.de];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.22)[72.15%]
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

On 12-18 23:32, Stefan Wahren wrote:
> > 
> >   static const struct udevice_id bcm2835_video_ids[] = {
> > -	{ .compatible = "brcm,bcm2835-hdmi" },
> > -	{ .compatible = "brcm,bcm2711-hdmi0" },
> > -	{ .compatible = "brcm,bcm2708-fb" },
> > +	{ .compatible = "brcm,bcm2835-hdmi",  .data = VIDEO_BPP32},
> > +	{ .compatible = "brcm,bcm2711-hdmi0", .data = VIDEO_BPP32},
> > +	{ .compatible = "brcm,bcm2708-fb",    .data = VIDEO_BPP16 },
> this change looks wrong to me. Before we used VIDEO_BPP32 for
> brcm,bcm2708-fb. I think it's hard to explain why we should downgrade
> the other boards. I would expect some brcm,bcm2712 compatible at least
> this needs an explanation in the commit message.
> 

If you are confident that this semi device was working before with
BPP32 I will try to find better way to handle this. Do you remember
which RPi version was this?

Thanks,
Ivan

