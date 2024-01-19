Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE322C47DAF
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 13:46:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1009C87C00;
	Fri, 19 Jan 2024 14:46:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="xytXJbtF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hEa5EpQw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xytXJbtF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hEa5EpQw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFB6A87C0B; Fri, 19 Jan 2024 14:46:55 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98BD887BFD
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 14:46:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=iivanov@suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 17EE221EA1;
 Fri, 19 Jan 2024 13:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705672013; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CwVQ4nntugNRhc56o9ep1NA+S4cwX78DlpXS8D8+xHo=;
 b=xytXJbtF8ytjLFsEr41Fjpxhu5LQfACKhc1D8rIbJV3LaglmAtvUz2DatrF/d06azjLOAW
 GXh0+rc4Jaz0KtSlE9z2DRwchLEA8vin1VJVauP4S5P8kMNbL3sYfFM6kkUVg9ffuwhiNk
 4DroViBHzVapzzZ0ykIz+ji6NyO9G3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705672013;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CwVQ4nntugNRhc56o9ep1NA+S4cwX78DlpXS8D8+xHo=;
 b=hEa5EpQwUzV5UHr/4OiEYRjG2aLnQZvukG/ivxWR8s+k4VFTQiqKkXKMIfnF6vP6/WhD4p
 7jpLllTlyO3mzaDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705672013; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CwVQ4nntugNRhc56o9ep1NA+S4cwX78DlpXS8D8+xHo=;
 b=xytXJbtF8ytjLFsEr41Fjpxhu5LQfACKhc1D8rIbJV3LaglmAtvUz2DatrF/d06azjLOAW
 GXh0+rc4Jaz0KtSlE9z2DRwchLEA8vin1VJVauP4S5P8kMNbL3sYfFM6kkUVg9ffuwhiNk
 4DroViBHzVapzzZ0ykIz+ji6NyO9G3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705672013;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CwVQ4nntugNRhc56o9ep1NA+S4cwX78DlpXS8D8+xHo=;
 b=hEa5EpQwUzV5UHr/4OiEYRjG2aLnQZvukG/ivxWR8s+k4VFTQiqKkXKMIfnF6vP6/WhD4p
 7jpLllTlyO3mzaDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F2B321388C;
 Fri, 19 Jan 2024 13:46:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RUL+OEx9qmVBJAAAD6G6ig
 (envelope-from <iivanov@suse.de>); Fri, 19 Jan 2024 13:46:52 +0000
Date: Fri, 19 Jan 2024 15:46:52 +0200
From: "Ivan T. Ivanov" <iivanov@suse.de>
To: Jens Maus <mail@jens-maus.de>
Cc: Stefan Wahren <wahrenst@gmx.net>, u-boot@lists.denx.de
Subject: Re: Re: [PATCH v4 0/6] rpi5: initial support
Message-ID: <ejituxf7ggiu2ciswrwoeqqjytb7mj2vn6gkxllywtnlm4aefi@br4zq7rfytlo>
References: <9AFD4C3E-E1B7-4EA7-8589-7060A2747732@suse.de>
 <5C0A3CD4-2591-4266-B9CC-7EC38C6A88C3@jens-maus.de>
 <454FB8E4-52A8-482D-8671-5650F8C4773C@suse.de>
 <A26CEBAE-9950-4304-B3A2-1BAB4035437A@jens-maus.de>
 <zmxxqxlbhdhngu36ft4yrqxtjkmvalvhbgbl2uzsj2jgnq7zje@qtncpq2nss57>
 <DCAD0173-2377-4B89-92EB-F38ED1CA938B@jens-maus.de>
 <03bbe9ad-7cc6-491d-8bd9-631f1cf04f39@gmx.net>
 <418F8AAE-136A-44A0-80C3-D01FFE00EC2E@jens-maus.de>
 <sjmi6dftbgx56isfyjtaryehzq2iollwxm2etlspiygehh3n6v@k4ws56nsbgfn>
 <6C9E5E0C-9C27-45A4-886F-8B8C641EF7A3@jens-maus.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6C9E5E0C-9C27-45A4-886F-8B8C641EF7A3@jens-maus.de>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.40 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FREEMAIL_ENVRCPT(0.00)[gmx.net];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.0:email,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 FREEMAIL_CC(0.00)[gmx.net,lists.denx.de]; RCVD_TLS_ALL(0.00)[]
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

+ u-boot@lists.denx.de

I am not sure how I drop the list in my last email, sorry.

On 01-19 12:56, Jens Maus wrote:
> Hi Ivan,
> 
> > Am 19.01.2024 um 12:22 schrieb Ivan T. Ivanov <iivanov@suse.de>:
> > 
> > On 01-19 11:49, Jens Maus wrote:
> >>> Am 19.01.2024 um 10:20 schrieb Stefan Wahren <wahrenst@gmx.net>:
> >>> 
> >>> Another idea could be to dump the runtime DT of both variants via sysfs
> >>> (using official RPi OS) and compare them with each other. In the past
> >>> there was a lot DT firmware hackery for the Raspberry Pi 4.
> >> 
> >> Good idea indeed. I just did that and executed "dtc -I fs /sys/firmware/devicetree/base“ in a quick RaspberryPiOS installation.
> >> 
> >> See [1] for the corresponding output. Hopefully Ivan can do the same so that we can see if there are any differences that might
> >> explain why his u-boot patches are working for him while they does not for me.
> >> 
> >> Best Regards,
> >> Jens
> >> 
> >> [1] https://gist.github.com/jens-maus/497e03cf1305ffe8a07e3196c27d6ebd
> > 
> > Thanks! Unfortunately at least first 2 memory banks looks the same as in 4GB version:
> > 
> > memory@0 {
> >    device_type = "memory";
> >    reg = <0x00 0x00 0x3f800000 0x00 0x40000000 0xc0000000>;
> > };
> > 
> > Jens, could you please, disconnect HDMI cable and capture devicetree
> > file again.
> 
> Sure. Here the diff against the other device tree at gist:
> 
> — cut here —
> --- device-tree	2024-01-19 11:33:41.831797039 +0100
> +++ device-tree2	2024-01-19 12:53:11.333845039 +0100
> @@ -2,7 +2,7 @@
>  
>  / {
>  	#address-cells = <0x02>;
> -	memreserve = <0x3f800000 0x800000>;
> +	memreserve = <0x3fc00000 0x400000>;
>  	model = "Raspberry Pi 5 Model B Rev 1.0";
>  	serial-number = "6b206ca09127ae99";
>  	#size-cells = <0x01>;
> @@ -41,7 +41,7 @@
>  
>  	memory@0 {
>  		device_type = "memory";
> -		reg = <0x00 0x00 0x3f800000 0x00 0x40000000 0xc0000000 0x01 0x00 0x80000000 0x01 0x80000000 0x80000000>;
> +		reg = <0x00 0x00 0x3fc00000 0x00 0x40000000 0xc0000000 0x01 0x00 0x80000000 0x01 0x80000000 0x80000000>;
>  	};
>  

Same here, expect that they are more memory banks, of course.
It is really strange that you don't seen even single message
from the U-Boot..

Hm... Ivan

