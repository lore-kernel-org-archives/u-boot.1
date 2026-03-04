Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B83AEFCE4C
	for <u-boot@archiver.kernel.org>; Wed,  4 Mar 2026 21:02:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01AD083F7D;
	Wed,  4 Mar 2026 22:02:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="NEY43J9m";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PmkIQhZ6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NEY43J9m";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PmkIQhZ6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D6D883AA9; Wed,  4 Mar 2026 20:43:35 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F52583642
 for <u-boot@lists.denx.de>; Wed,  4 Mar 2026 20:43:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pfalcato@suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 85E0C5BE03;
 Wed,  4 Mar 2026 19:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1772653412; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vavgxRSTmaQjGQzptNHqimDOIzFK+6KVHqySeiGXHok=;
 b=NEY43J9mBTpINgzauT7cLhR9mECQGvPUyauQoPp9Mvr6fTV8uu7PPYM/NGfbllI7ptE8jP
 yP15pMojqxpDd/QH/Ohiew8n6aQHquXEnLcE7i/hqlcXZiupCC+Q+brR5FhSYjJvcOqqHT
 ajFjNgbyaGP4gWb6FixJIqA3kC9Ueqk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1772653412;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vavgxRSTmaQjGQzptNHqimDOIzFK+6KVHqySeiGXHok=;
 b=PmkIQhZ6iUfmAjVdunWYdoHA3wrxD5fHZ96iKS3iZjdNwRHBkfOpK9rEk1hpcs8RPaihFP
 xv0MGRAi4cykKVCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NEY43J9m;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=PmkIQhZ6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1772653412; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vavgxRSTmaQjGQzptNHqimDOIzFK+6KVHqySeiGXHok=;
 b=NEY43J9mBTpINgzauT7cLhR9mECQGvPUyauQoPp9Mvr6fTV8uu7PPYM/NGfbllI7ptE8jP
 yP15pMojqxpDd/QH/Ohiew8n6aQHquXEnLcE7i/hqlcXZiupCC+Q+brR5FhSYjJvcOqqHT
 ajFjNgbyaGP4gWb6FixJIqA3kC9Ueqk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1772653412;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vavgxRSTmaQjGQzptNHqimDOIzFK+6KVHqySeiGXHok=;
 b=PmkIQhZ6iUfmAjVdunWYdoHA3wrxD5fHZ96iKS3iZjdNwRHBkfOpK9rEk1hpcs8RPaihFP
 xv0MGRAi4cykKVCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E5EC03EA69;
 Wed,  4 Mar 2026 19:43:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id f4S1NGOLqGn7XwAAD6G6ig
 (envelope-from <pfalcato@suse.de>); Wed, 04 Mar 2026 19:43:31 +0000
Date: Wed, 4 Mar 2026 19:43:30 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Torsten Duwe <duwe@lst.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Matthias Brugger <mbrugger@suse.com>,
 Andrea della Porta <andrea.porta@suse.com>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [hack] help U-Boot find the correct PCIe inbound offset for NVMe
 on Raspberry Pi 5
Message-ID: <khr5tpfjql6l5ide644d7x6v2km6m3u4jnlbxq5zsbqefui65i@dlwpybwg3fym>
References: <20260302135940.550e6051@rocky.lan>
 <20260302164256.29af9995@rocky.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302164256.29af9995@rocky.lan>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,linaro.org,suse.com,konsulko.com,lists.denx.de];
 RCPT_COUNT_SEVEN(0.00)[8]; TAGGED_RCPT(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim]
X-Rspamd-Queue-Id: 85E0C5BE03
X-Mailman-Approved-At: Wed, 04 Mar 2026 22:02:01 +0100
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

Hi Torsten,

On Mon, Mar 02, 2026 at 04:42:56PM +0100, Torsten Duwe wrote:
> On Mon, 2 Mar 2026 13:59:40 +0100
> Torsten Duwe <duwe@lst.de> wrote:
> 
> > This proposed patch uses the already existent dev_phys_to_bus(),
> > which can dig up the correct offset from associated DT nodes and
> > subtract it.
> 
> Just to make it clear, that patch is a necessary but not a sufficient
> condition to boot the RPi5 from NVMe. The PCIe bus node above
> the NVMe is generated dynamically has no DT node with dma-ranges and so
> dev_phys_to_bus() still returns zero. In order to test NVMe on the
> RPi5 you can either:
>

Say I wanted to test NVMe booting on the pi5 (which I actually do).
I would need:
1) this patch
2) one of the two BUS_ADDR() related diffs
3) the fixes posted in https://lore.kernel.org/u-boot/20251105163553.15F2A227AAC@verein.lst.de/
4) anything else?

Thanks,
Pedro

> hard code the 64GiB value when building your private U-Boot binary:
> 
> -#define BUS_ADDR(a)         dev_phys_to_bus(dev->udev, (a))
> +#define BUS_ADDR(a)            ((a)+0x1000000000LL)
> 
> OR use this tricky DT change Andrea has prepared:
> 
> --- a/dts/upstream/src/arm64/broadcom/bcm2712.dtsi
> +++ b/dts/upstream/src/arm64/broadcom/bcm2712.dtsi
> @@ -571,6 +571,15 @@
>  				<0x03000000 0xff 0xfffff000 0x10 0x00131000 0x00 0x00001000>; 
>  			status = "disabled";
> +
> +			pci@0,0 {
> +				reg = <0x00 0x00 0x00 0x00 0x00>;
> +				device_type = "pci";
> +				#address-cells = <0x03>;
> +				#size-cells = <0x02>;
> +				ranges;
> +				dma-ranges;
> +			};
>  		};
>  
>  		pcie2: pcie@1000120000 {
> 
> This pci@0,0 node needs to be below the pcie@1000110000 RC node so it
> can "bridge" dev_phys_to_bus() to the RC node when it climbs up the
> device tree and so helps it find the correct value.
> 
> AFAICS the proper fix should be to add some dma-ranges property when
> dynamic PCI devices are created during enumeration/scan or make
> dev_phys_to_bus() skip those nodes for the lookup.
> 
> 	Torsten
