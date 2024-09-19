Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5BCBCF3944
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 14:19:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E728A89282;
	Thu, 19 Sep 2024 16:16:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="YDZ8jZKM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UU11QHFR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FIfAXeb3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XW5zML70";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF44D89266; Thu, 19 Sep 2024 16:16:10 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CC5F892A5
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 16:16:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=iivanov@suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7DC4F33921;
 Thu, 19 Sep 2024 14:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726755367; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C9GxfU+tEyRVqUufvuzBX/Y4kNU2t1H+Gb8NnyC3528=;
 b=YDZ8jZKMiAbpvwmO5SrA9eA72hozvaEmF7FuYWOyF8JBrG1AIjB11EiCt0ZauHaiYyQvWp
 quo1hqvTpMmVoGt6Mk6SirrEpT/VmSMGvt58NFtPJ9SBy56haBcWKR+dIcPFjCivXCggSF
 z6jnhoFlhIwi2daUHupE3cyqBTjFR70=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726755367;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C9GxfU+tEyRVqUufvuzBX/Y4kNU2t1H+Gb8NnyC3528=;
 b=UU11QHFRgwAiZ6cUHHclMg1M6ZnKClzJVEOxsSqSZqXlQMojWHN7p7duptnAYNbEubl317
 O04Dko58XLGYodDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=FIfAXeb3;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=XW5zML70
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726755366; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C9GxfU+tEyRVqUufvuzBX/Y4kNU2t1H+Gb8NnyC3528=;
 b=FIfAXeb3pKIYwwXZ2nSxrtuVHNV8Qr+NeU+h0rDR5u/S4X4sUNiQgBg1zPKMT0gPR/hlBX
 IiVOb5g/GlGNppp4GNKRVO5FgXcA7vYGyp9YjcNmuUYCPqIU1K/KknEWgmXpfXbyU+0XoT
 wuydMhieppSnv6nawQeTTTw84yR8FJU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726755366;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C9GxfU+tEyRVqUufvuzBX/Y4kNU2t1H+Gb8NnyC3528=;
 b=XW5zML70/bAi0NyEjG6wtTtV1OQF6BLorpfzVjxku7npKYPfxzN2+D0HTU68UOvVxSy/Oj
 0gXbAX3itOdS+6Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 590DE13A5F;
 Thu, 19 Sep 2024 14:16:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id JbAdFCYy7GalTAAAD6G6ig
 (envelope-from <iivanov@suse.de>); Thu, 19 Sep 2024 14:16:06 +0000
Date: Thu, 19 Sep 2024 17:22:00 +0300
From: "Ivan T. Ivanov" <iivanov@suse.de>
To: Stefan Agner <stefan@agner.ch>
Cc: Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Dmitry Malkin <dmitry@bedrocksystems.com>,
 Thomas Fitzsimmons <fitzsim@fitzsim.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Anatolij Gustschin <agust@denx.de>, wahrenst@gmx.net,
 florian.fainelli@broadcom.com, u-boot@lists.denx.de,
 Jan =?utf-8?B?xIxlcm3DoWs=?= <sairon@sairon.cz>
Subject: Re: [PATCH v4 0/6] rpi5: initial support
Message-ID: <20240919142200.qbt3hadsxexamtn5@localhost.localdomain>
References: <20240110122908.31612-1-iivanov@suse.de>
 <9943877347134e40cee8c0d9cc7f641c@agner.ch>
 <B1136352-B9D3-4990-B5E5-7C318809C957@suse.de>
 <1c9ebab90accb47abbd7ef2205c6b409@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1c9ebab90accb47abbd7ef2205c6b409@agner.ch>
X-Rspamd-Queue-Id: 7DC4F33921
X-Spamd-Result: default: False [-6.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.net];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCPT_COUNT_TWELVE(0.00)[12]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_CC(0.00)[suse.com,gmail.com,bedrocksystems.com,fitzsim.org,nxp.com,samsung.com,denx.de,gmx.net,broadcom.com,lists.denx.de,sairon.cz];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[localhost.localdomain:mid, agner.ch:email,
 suse.de:dkim, imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
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

On 09-19 16:01, Stefan Agner wrote:
> Hi Ivan,
> 
> Thanks for the quick response!
> 
> On 2024-09-19 11:52, Ivan T. Ivanov wrote:
> > Hi Stefan,
> > 
> >> On 19 Sep 2024, at 12:36, Stefan Agner <stefan@agner.ch> wrote:
> >> 
> >> Hi Ivan,
> >> 
> >> I am looking into enabling NVMe boot support using U-Boot on Raspberry
> >> Pi 5. Which brings me to some questions wrt PCIe support (see below).
> >> 
> >> On 2024-01-10 13:29, Ivan T. Ivanov wrote:
> >>> 
> > 
> > 
> >>> * I am dropping PCIe patch for now. I made some progress on porting changes
> >>>  from vendor Linux tree to U-Boot. Unfortunatly testing it is little bit
> >>>  tricky. They are many devices behind PCIe, but more or less all of them
> >>>  requires missing either "reset-controller" or "clock-controller" or
> >>>  "pin-controller" drivers. I was able to probe "cdns,macb" device, but
> >>>  access to ethernet PHY over MDIO bus is stucking. Then I ported
> >>>  "raspberrypi,rp1-adc" driver from vendor Linux tree, but it requires
> >>>  missing clock. And on top of that machine that I used for developing this
> >>>  crashed and I lost my PCIe changes :-|. Anyway.
> >> 
> >> Have you tried using a M.2 HAT? This likely won't require much in terms
> >> of enabling the device.
> >> 
> >> You write that you made some progress, is that compared to v3? Do you
> >> mind sharing the latest version of your patches?
> > 
> > 
> > No further progress on PCIe for U-Boot from my side was made, sorry.
> > 
> 
> So v3 the patch you've shared in v3 is your latest state? I was
> wondering since you wrote in this v4 patch set "I made some progress on
> porting changes
>  from vendor Linux tree to U-Boot."...

And then " .. And on top of that machine that I used for developing this
crashed and I lost my PCIe changes ... ". Reading the whole paragraph
now I agree it is not completely clear what happened.

> 
> 
> > Stan is working on adding support for 2712 PCIe in Linux [1]. Perhaps
> > once this is complete we can work on adding U-Boot support for the same,
> > unless someone don’t beat us, of course. 
> 
> Hm, it seems the link did not make it. I guess you meant to link this
> patch set [1]
> 
> --
> Stefan
> 
> [1]
> https://lore.kernel.org/lkml/20240910151845.17308-1-svarbanov@suse.de/T/

Yes.

Regards,
Ivan

