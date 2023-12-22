Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE6F5C41535
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 12:33:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FBEE8783E;
	Fri, 22 Dec 2023 13:33:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="lcYdKMlM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sWtMbb3f";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lcYdKMlM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sWtMbb3f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3AC88788A; Fri, 22 Dec 2023 13:33:14 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B09C8781E
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 13:33:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=iivanov@suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AFA9621FF8;
 Fri, 22 Dec 2023 12:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1703248392; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iwbSCGTopwTyUJ/lGqBVFIdBwtNEh7E12jOToHONX70=;
 b=lcYdKMlMkDERkMTmFld9BUuzP4Gl9z2zq2Dbdc2DsH2GjGXdnCph4HGs/XCXXdJ7mVnmyy
 EpnMSl+4Ey6evmVe3PY0pMEMS0kucCVAO7346kmgf5zHL1qf6C/VoElHC+Rw36rx5mzLBW
 +seHbKFIs5dCu+EF+gg73Spn7cEAIco=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1703248392;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iwbSCGTopwTyUJ/lGqBVFIdBwtNEh7E12jOToHONX70=;
 b=sWtMbb3fLXAHWUXdR0reQ3yX2MAJ1D55VWxBbwVKytbAebuPxnQ0XpmPKrUIiu7hdAmhfG
 YwYYSr3iznOCOrDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1703248392; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iwbSCGTopwTyUJ/lGqBVFIdBwtNEh7E12jOToHONX70=;
 b=lcYdKMlMkDERkMTmFld9BUuzP4Gl9z2zq2Dbdc2DsH2GjGXdnCph4HGs/XCXXdJ7mVnmyy
 EpnMSl+4Ey6evmVe3PY0pMEMS0kucCVAO7346kmgf5zHL1qf6C/VoElHC+Rw36rx5mzLBW
 +seHbKFIs5dCu+EF+gg73Spn7cEAIco=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1703248392;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iwbSCGTopwTyUJ/lGqBVFIdBwtNEh7E12jOToHONX70=;
 b=sWtMbb3fLXAHWUXdR0reQ3yX2MAJ1D55VWxBbwVKytbAebuPxnQ0XpmPKrUIiu7hdAmhfG
 YwYYSr3iznOCOrDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8B22513997;
 Fri, 22 Dec 2023 12:33:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jAx5HwiChWUiEgAAD6G6ig
 (envelope-from <iivanov@suse.de>); Fri, 22 Dec 2023 12:33:12 +0000
Date: Fri, 22 Dec 2023 14:33:11 +0200
From: "Ivan T. Ivanov" <iivanov@suse.de>
To: Marc Zyngier <maz@kernel.org>
Cc: Matthias Brugger <mbrugger@suse.com>, 
 Peter Robinson <pbrobinson@gmail.com>,
 Dmitry Malkin <dmitry@bedrocksystems.com>, 
 Thomas Fitzsimmons <fitzsim@fitzsim.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>,
 wahrenst@gmx.net, florian.fainelli@broadcom.com, u-boot@lists.denx.de
Subject: Re: [PATCH v3 0/7] rpi5: initial support
Message-ID: <evdxlvvwhotp77abj23arm2zwbgcqijqxxmuregf2uas4c3clj@jbfqnkc6fc7x>
References: <20231218210341.30073-1-iivanov@suse.de>
 <a277be3746ae7fd3bd2676090a90d233@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a277be3746ae7fd3bd2676090a90d233@kernel.org>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.81 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.net];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 DWL_DNSWL_LOW(-1.00)[suse.de:dkim]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[11];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 FREEMAIL_CC(0.00)[suse.com,gmail.com,bedrocksystems.com,fitzsim.org,nxp.com,samsung.com,denx.de,gmx.net,broadcom.com,lists.denx.de];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lcYdKMlM;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=sWtMbb3f
X-Rspamd-Queue-Id: AFA9621FF8
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

On 12-22 12:19, Marc Zyngier wrote:
> 
> Hi Ivan,
> 
> On 2023-12-18 21:03, Ivan T. Ivanov wrote:
> > Hi,
> > 
> > These patches are adding basic support for RPi5.
> > They are based on v2 series from Dmitry Malkin[1].
> > 
> > With them I am able to _start_ current openSUSE
> > Tumbleweed without modification. They are still
> > a lot of things to be added to the upstream Linux
> > before it runs flawlessly on this device, but at
> > least in U-Booot SD controller used for uSD card
> > and Frameboffer and HDMI0 devices are working fine
> > now. It seems that PCIe controller is working fine
> > too, but I have not tested it too much.
> > 
> > Serial console and reset are also functional.
> > 
> > Hopefully this will help others add missing pieces
> > more easily.
> 
> So I've given this a go, and the basics (serial) worked
> out of the box (thanks for that!) after performing the
> memory-map change you described in your reply to patch 1.
> 
> However, I don't get anything on the PCIe front:
> 
> U-Boot> pci enum
> PCIe BRCM: link down
> PCIe BRCM: link down
> 
> despite having an nvme device connected and enabled
> (the RPi kernel finds it).
> 
> I'm guessing I must be missing something. How did you
> test PCIe?
> 

No, you are not missing anything. I have not tested it
for real. That is why I said "it seems". Sorry.

Yesterday I started looking more closely at what's missing
and unfortunately a lot more changes are needed.

Regards,
Ivan

