Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08A9EC47DA9
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 15:07:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB7B686E88;
	Wed, 17 Jan 2024 16:07:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="KIYYzPrM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YyrEEuO/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KIYYzPrM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YyrEEuO/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CDB887B12; Wed, 17 Jan 2024 16:07:11 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0C3F86BFA
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 16:07:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=iivanov@suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4D26021EDD;
 Wed, 17 Jan 2024 15:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705504027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JBo5HWrHBtvdj7VXyeEAeoB+Gd5rwrws0lxl2oIMFp4=;
 b=KIYYzPrMHtdMaYJBf/zKWAn182EuvUPz9wqAUIdOhzJ5tsZSnWSc9TvshJNa9utVk+ctWd
 v6vGnLFx6WpXq9EU5V7sPu8egeXojO/4L9Dlsw3uW4NhDruc0UEPHt5WBUxDmaqLBAmUUg
 Ond1dL7jwT6fSoxe0d5ckk+vbjux/yE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705504027;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JBo5HWrHBtvdj7VXyeEAeoB+Gd5rwrws0lxl2oIMFp4=;
 b=YyrEEuO/TgvrUbzXccXa9AdWBz/uWUtCJuuS4Cnn29Ja6eTmwW9qbvXbM63EFB+AEHPuvi
 TZVCk0+3Ms/4GMDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705504027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JBo5HWrHBtvdj7VXyeEAeoB+Gd5rwrws0lxl2oIMFp4=;
 b=KIYYzPrMHtdMaYJBf/zKWAn182EuvUPz9wqAUIdOhzJ5tsZSnWSc9TvshJNa9utVk+ctWd
 v6vGnLFx6WpXq9EU5V7sPu8egeXojO/4L9Dlsw3uW4NhDruc0UEPHt5WBUxDmaqLBAmUUg
 Ond1dL7jwT6fSoxe0d5ckk+vbjux/yE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705504027;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JBo5HWrHBtvdj7VXyeEAeoB+Gd5rwrws0lxl2oIMFp4=;
 b=YyrEEuO/TgvrUbzXccXa9AdWBz/uWUtCJuuS4Cnn29Ja6eTmwW9qbvXbM63EFB+AEHPuvi
 TZVCk0+3Ms/4GMDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3359E13800;
 Wed, 17 Jan 2024 15:07:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GBkrChvtp2U3EgAAD6G6ig
 (envelope-from <iivanov@suse.de>); Wed, 17 Jan 2024 15:07:07 +0000
Date: Wed, 17 Jan 2024 17:07:06 +0200
From: "Ivan T. Ivanov" <iivanov@suse.de>
To: Jens Maus <mail@jens-maus.de>
Cc: u-boot@lists.denx.de
Subject: Re: Re: [PATCH v4 0/6] rpi5: initial support
Message-ID: <sfo77vzvmblyv5g5ek6uc6oxrf5n7dcp3vsw2g2lvfnnrlyaft@kc6s7vvspwvz>
References: <BD4D4B77-9C54-4FD7-8EEF-A65E674E0747@jens-maus.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BD4D4B77-9C54-4FD7-8EEF-A65E674E0747@jens-maus.de>
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KIYYzPrM;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="YyrEEuO/"
X-Spamd-Result: default: False [-1.81 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.de:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; BAYES_HAM(-0.00)[42.09%];
 ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,opensuse.org:url];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4D26021EDD
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

On 01-12 14:10, Jens Maus wrote:
> 
> Hi Ivan,
> 
> first of all, thanks for the updated rpi5 patchset. However, I am unable to reproduce that it is actually working as you suggest. Could you please quickly elaborate on your test environment and the test config.txt for the RaspberryPi5? Here I have compiled U-Boot 2024.01 with your patches applied and using the „rpi_arm64_defconfig“, put the u-boot.bin file on the sd card and then added „kernel=u-boot.bin“ to the config.txt file. The environment I am using is a buildroot-based system which boots nicely with the default RaspberryPi boot loader and a RaspberryPi5. However, as soon as I replace the „kernel=Image“ line with „kernel=u-boot.bin“ the system stalls and there is no HDMI output (nor any console output) with the u-boot 2024.01 version and your patches applied.
> 

Yes, I am using rpi_arm64_defconfig for building the U-Boot.
And as I wrote in the cover letter I am using openSUSE Tumbleweed
image[1], [2]. Once you copy image to uSD card mount EFI uSD
partition and copy new u-boot.bin over existing one. That
it is. Just make sure you clearly sync, unmount the card.
You can find config.txt file in the EFI partition.

Regards,
Ivan

[1] https://en.opensuse.org/HCL:Raspberry_Pi4
[2] http://download.opensuse.org/ports/aarch64/tumbleweed/appliances/openSUSE-Tumbleweed-ARM-XFCE-raspberrypi.aarch64.raw.xz

