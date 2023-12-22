Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E890C46CD4
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 08:22:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B23D9877B1;
	Fri, 22 Dec 2023 09:22:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="nL7oLVAi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="16usCTjq";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gn2/NdAA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JQhpPa8v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCCC3870B5; Fri, 22 Dec 2023 09:22:55 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3C7387768
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 09:22:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=iivanov@suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0D1E821FEE;
 Fri, 22 Dec 2023 08:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1703233373; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R4QNnkOV/7YfCRCumUTsGmD04f97xwUU8VCQgJBoKb0=;
 b=nL7oLVAixYNBUv3ZDepU/kt8V0NCw/qvhl5T2by2x7BJjGqzAl86Z9Qnrn6pk19Ox6TNT0
 hiXkutar6VPH0LB7xpgb8FhQ771CVkVLzgWWcS5MIht4ywVB8f4dq2mtaDTMUEe2HsRKPp
 mp+dZeEaseq18Ou3H3l1RxDihJpPTj4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1703233373;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R4QNnkOV/7YfCRCumUTsGmD04f97xwUU8VCQgJBoKb0=;
 b=16usCTjqi1DuUaCofj0sN/+DXGnXzUpAShrKktk9F6Qq48dgZlyNxiZ+s9jsANLTttEKZD
 CWakY444KF6EjHAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1703233372; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R4QNnkOV/7YfCRCumUTsGmD04f97xwUU8VCQgJBoKb0=;
 b=gn2/NdAAfx1FmunVnI9XBXTeFEOqNFTujcaWqqN3Nk2rtyOjFlHAX3c17mRXYCwFUd04k1
 Q4n59xQrgiqlXNeRd+4BgEVdnPQqGEqh9Zli0zE7kWAGfiTgwNItS9/1UMtY1DWeDHat4j
 2lV25LDXSmTwiK/9K7UNi0MjOGgvoPY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1703233372;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R4QNnkOV/7YfCRCumUTsGmD04f97xwUU8VCQgJBoKb0=;
 b=JQhpPa8vwIIWYfBKaHgeCOilcTuabnZsKAOrXaXE3oitIbiQr+HuUD7rE6fvqd2EDNDSga
 HNj9G023ujstEOBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D9FFF13AB5;
 Fri, 22 Dec 2023 08:22:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id pJfSMltHhWVMZAAAD6G6ig
 (envelope-from <iivanov@suse.de>); Fri, 22 Dec 2023 08:22:51 +0000
Date: Fri, 22 Dec 2023 10:22:51 +0200
From: "Ivan T. Ivanov" <iivanov@suse.de>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Matthias Brugger <mbrugger@suse.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Dmitry Malkin <dmitry@bedrocksystems.com>,
 Thomas Fitzsimmons <fitzsim@fitzsim.org>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Anatolij Gustschin <agust@denx.de>, u-boot@lists.denx.de
Subject: Re: [PATCH v3 5/7] mmc: bcmstb: Add support for bcm2712 SD controller
Message-ID: <ae2fhlqdltlrdkbaai7s3b7rqz44xxmabb6klqsnf2rez7vvjb@hkhxm42xpn3x>
References: <20231218210341.30073-1-iivanov@suse.de>
 <20231218210341.30073-6-iivanov@suse.de>
 <fedeb96c-19db-442d-bab0-e87d6d8bba68@broadcom.com>
 <db91a259-d504-4e8b-8178-dad3e5709b93@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db91a259-d504-4e8b-8178-dad3e5709b93@gmx.net>
X-Spamd-Result: default: False [-2.60 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.net];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_SEVEN(0.00)[10];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FREEMAIL_TO(0.00)[gmx.net]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[];
 FREEMAIL_CC(0.00)[broadcom.com,suse.com,gmail.com,bedrocksystems.com,fitzsim.org,nxp.com,samsung.com,denx.de,lists.denx.de];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
Authentication-Results: smtp-out1.suse.de;
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

On 12-21 16:39, Stefan Wahren wrote:
> To: Florian Fainelli <florian.fainelli@broadcom.com>,  "Ivan T. Ivanov"
> > 
> > On 12/18/2023 10:03 PM, Ivan T. Ivanov wrote:
> > > Borrow SD quirks from vendor Linux driver.
> > > 
> > > "BCM2712 unfortunately carries with it a perennial bug with the SD
> > > controller register interface present on previous chips
> > > (2711/2709/2708).
> > > Accesses must be dword-sized and a read-modify-write cycle to the 32-bit
> > > registers containing the COMMAND, TRANSFER_MODE, BLOCK_SIZE and
> > > BLOCK_COUNT registers tramples the upper/lower 16 bits of data written.
> > > BCM2712 does not seem to need the extreme delay between each write as on
> > > previous chips, just the serialisation of writes to these registers in a
> > > single 32-bit operation."
> > > 
> > > Signed-off-by: Ivan T. Ivanov <iivanov@suse.de>
> > 
> > This is diverging from the Linux sdhci-brcmstb.c driver where no such
> > quirk needs to be carried out, rather the logic for such quirks has
> > been present in sdhci-iproc.c...
> 
> it seems this patch based the downstream kernel changes [1].

Yep.

> I would
> suggest to use an existing driver which already handle this bug
> (iproc_sdhci or bcm2835_sdhci).
> 
> Does the Rpi 5 still works, if the compatible "brcm,bcm2712-sdhci" is
> added to mmc/iproc_sdhci.c?

No, it is not working :-)

Even after I added shadow variables usage in iproc_readw, which do not
have it.

Even after I used hard coded values for "clock-freq-min-max", which are
missing in RPi5 device tree.

Even after I added 2712 specific "cfg" space initialization procedure
from the brcnstb driver.

On the other hand they are some tuning procedures in iproc driver
which I am not sure that are relevant for 2712 controller.

And the diff stat is getting bigger that equivalent for brcmstb driver.

To me it is  a bit easier to add 2712 support to brcmstb driver,
because it will be easier to follow any vendor Linux driver changes.

It looks like hardware engineers are just making the same mistake
when integrating 2712 SDHCI controller as for IPROC controller.

Regards,
Ivan

> 
> [1] -
> https://github.com/raspberrypi/linux/commit/b627647c4500d39cb026924b608841fdf4d4d7e9
