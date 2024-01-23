Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA6ECC47DDB
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 08:08:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AE2A87C5A;
	Tue, 23 Jan 2024 09:08:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="v46u2xl5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="t2bNSZ+K";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="v46u2xl5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="t2bNSZ+K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A6E087C17; Tue, 23 Jan 2024 09:08:39 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F21187B30
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 09:08:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=iivanov@suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 977311F74D;
 Tue, 23 Jan 2024 08:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705997316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Sl7Rpq5iqdGPnxl+bjiBVA/Oxhwb9LoxFHvM8rfO/0I=;
 b=v46u2xl57e5X86z08F9ZHFys7ijeE7/a0wAcyz66LbpjiYerqcD2ftHvCKMotHOp0++faP
 doEbl6NzYPGwwha3N57Ac0M2iU8EV0y1Izvnn0YgYWrSl8To5iQo6WrAY0ezUkqo1hgXy6
 RDBw9fudGdMYLOhWaoi7iuJzlJFd6xg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705997316;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Sl7Rpq5iqdGPnxl+bjiBVA/Oxhwb9LoxFHvM8rfO/0I=;
 b=t2bNSZ+Kb90upcHA0Say+wS8k8SHZtdc/PPEo9kI4a0AwhGewExaVVQEqSPhvn+KgTeBOw
 V8uDM1QWHN4E1cCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705997316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Sl7Rpq5iqdGPnxl+bjiBVA/Oxhwb9LoxFHvM8rfO/0I=;
 b=v46u2xl57e5X86z08F9ZHFys7ijeE7/a0wAcyz66LbpjiYerqcD2ftHvCKMotHOp0++faP
 doEbl6NzYPGwwha3N57Ac0M2iU8EV0y1Izvnn0YgYWrSl8To5iQo6WrAY0ezUkqo1hgXy6
 RDBw9fudGdMYLOhWaoi7iuJzlJFd6xg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705997316;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Sl7Rpq5iqdGPnxl+bjiBVA/Oxhwb9LoxFHvM8rfO/0I=;
 b=t2bNSZ+Kb90upcHA0Say+wS8k8SHZtdc/PPEo9kI4a0AwhGewExaVVQEqSPhvn+KgTeBOw
 V8uDM1QWHN4E1cCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE4B913786;
 Tue, 23 Jan 2024 08:08:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fB0bMwN0r2XOagAAD6G6ig
 (envelope-from <iivanov@suse.de>); Tue, 23 Jan 2024 08:08:35 +0000
From: "Ivan T. Ivanov" <iivanov@suse.de>
To: Matthias Brugger <mbrugger@suse.com>, Peter Robinson <pbrobinson@gmail.com>
Cc: Dmitry Malkin <dmitry@bedrocksystems.com>,
 Thomas Fitzsimmons <fitzsim@fitzsim.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>,
 wahrenst@gmx.net, florian.fainelli@broadcom.com, u-boot@lists.denx.de,
 "Ivan T. Ivanov" <iivanov@suse.de>
Subject: [PATCH v5 0/7] rpi5: initial support
Date: Tue, 23 Jan 2024 10:07:52 +0200
Message-ID: <20240123080819.13625-1-iivanov@suse.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.30 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.net];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_SEVEN(0.00)[11];
 MID_CONTAINS_FROM(1.00)[];
 FREEMAIL_TO(0.00)[suse.com,gmail.com];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[bedrocksystems.com,fitzsim.org,nxp.com,samsung.com,denx.de,gmx.net,broadcom.com,lists.denx.de,suse.de];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
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

This is new round of patches posted earlier here[1]. They are adding basic
support for RPi5 and are based on v2 series from Dmitry Malkin[2].

What changed sice v4:

* Support for SDHCI controller in 2712 was simplified a lot. It turns out
  that special registers accessors are not needed[3].

* Latest EEPROM firmware changed "kernel" load address from 0x80000
  to 0x200000. And because on RPi’s CONFIG_TEXT_BASE is set to 0x80000
  code execution run through the grass. Switching to position indeended
  code fixed this.

These changes have been tested on following devices:

	Raspberry Pi 5 Model B Rev 1.0
	Raspberry Pi 4 Model B Rev 1.1
	Raspberry Pi 3 Model B Plus Rev 1.3
	Raspberry Pi Zero 2 W Rev 1.0
	Raspberry Pi 2 Model B Rev 1.2
	Raspberry Pi Compute Module 4 Rev 1.0
	Raspberry Pi Compute Module 3 Rev 1.0

Thanks,
Ivan

[1] https://lore.kernel.org/all/20240110122908.31612-1-iivanov@suse.de/
[2] https://lore.kernel.org/all/CAKRNjQ0dsWozGo4n8g58m4cCEk3n=qx1R+L24WBgpo-iP1yo7A@mail.gmail.com/
[3] https://github.com/P33M/linux/commit/8a15e5d99667cb4499836d6f360246a69f020256


Dmitry Malkin (2):
  rpi5: add initial memory map for bcm2712
  rpi5: Use devicetree as alternative way to read IO base addresses

Ivan T. Ivanov (5):
  rpi5: Use devicetree to retrieve board revision
  bcm2835: Dynamically calculate bytes per pixel parameter
  mmc: bcmstb: Add support for bcm2712 SD controller
  configs: rpi_arm64: enable SDHCI BCMSTB driver
  configs: rpi_arm64: build position independent code

 arch/arm/mach-bcm283x/include/mach/base.h  |  5 +-
 arch/arm/mach-bcm283x/include/mach/mbox.h  |  3 +-
 arch/arm/mach-bcm283x/include/mach/sdhci.h |  3 +-
 arch/arm/mach-bcm283x/include/mach/timer.h |  3 +-
 arch/arm/mach-bcm283x/include/mach/wdog.h  |  3 +-
 arch/arm/mach-bcm283x/init.c               | 74 +++++++++++++++++++---
 board/raspberrypi/rpi/rpi.c                | 22 ++++++-
 configs/rpi_arm64_defconfig                |  3 +-
 drivers/mmc/bcmstb_sdhci.c                 | 64 +++++++++++++++++--
 drivers/video/bcm2835.c                    | 18 +++++-
 10 files changed, 171 insertions(+), 27 deletions(-)

-- 
2.43.0

