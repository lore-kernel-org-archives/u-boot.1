Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB4FCC35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 21:03:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DEC687575;
	Mon, 18 Dec 2023 22:03:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="L5iTwMjp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VIfa6F6r";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ACWmG2oQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="A7V2zry2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B397A87561; Mon, 18 Dec 2023 22:03:51 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E85B87463
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 22:03:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=iivanov@suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C355822228;
 Mon, 18 Dec 2023 21:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1702933429; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ap4rXlWP/4BHAjnsexAsxdTyAucr4qWCadBUgQIBsXo=;
 b=L5iTwMjpAVrklT0TSW/Jl+BRW/95Dvj/gbmwuPxGDeet+tNYRn3QIZnQXZlFuWcDadnrO9
 Ge+zwWInJYR3Y+OgKQ83EkYtdKEUZIftqCaomTECpf4dPqW8CK9vXcgMI/3BzLlxL9LrSj
 duF6E+EoH7UOmusbQQrGDD6rcCvMNcQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1702933429;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ap4rXlWP/4BHAjnsexAsxdTyAucr4qWCadBUgQIBsXo=;
 b=VIfa6F6r4CPOSVXCr4NX7BTD70HEkHUm+l6efyhkHmYj/WrUlK0NRxUkgk/P3PZfc8YCzi
 nNRafawRGwRtsRCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1702933428; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ap4rXlWP/4BHAjnsexAsxdTyAucr4qWCadBUgQIBsXo=;
 b=ACWmG2oQ4uJQH9ijkL2pZjzM60F5WHmvHX+NUeiIe2+GFjOejjiwSFSK+UfVDdb/vrAHXJ
 DoC3gHEmQOpEVis3lOpdE5zRHl8/+ai0l/CSQzylR5OwpJhOkKZiYiy/PQUYA8lebfzY7t
 nbBhNmTaKuNE9o5WeMjQ4PJ/9/t6tTU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1702933428;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ap4rXlWP/4BHAjnsexAsxdTyAucr4qWCadBUgQIBsXo=;
 b=A7V2zry2S6L2Ux6TkIWU1P0lHRmgjD0gWwfTI45XicqqTUcr2gibrlASVAziBgKS05IggO
 E6bGZCPcocytaCBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3256D133E5;
 Mon, 18 Dec 2023 21:03:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id G1XJCbSzgGUtZAAAD6G6ig
 (envelope-from <iivanov@suse.de>); Mon, 18 Dec 2023 21:03:48 +0000
From: "Ivan T. Ivanov" <iivanov@suse.de>
To: Matthias Brugger <mbrugger@suse.com>, Peter Robinson <pbrobinson@gmail.com>
Cc: Dmitry Malkin <dmitry@bedrocksystems.com>,
 Thomas Fitzsimmons <fitzsim@fitzsim.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>,
 wahrenst@gmx.net, florian.fainelli@broadcom.com, u-boot@lists.denx.de,
 "Ivan T. Ivanov" <iivanov@suse.de>
Subject: [PATCH v3 0/7] rpi5: initial support
Date: Mon, 18 Dec 2023 23:03:34 +0200
Message-ID: <20231218210341.30073-1-iivanov@suse.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ACWmG2oQ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=A7V2zry2
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.51 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 BROKEN_CONTENT_TYPE(1.50)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[11]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 FREEMAIL_TO(0.00)[suse.com,gmail.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.net];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 DWL_DNSWL_HI(-3.50)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 FREEMAIL_CC(0.00)[bedrocksystems.com,fitzsim.org,nxp.com,samsung.com,denx.de,gmx.net,broadcom.com,lists.denx.de,suse.de];
 RCVD_TLS_ALL(0.00)[];
 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Queue-Id: C355822228
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

These patches are adding basic support for RPi5.
They are based on v2 series from Dmitry Malkin[1].

With them I am able to _start_ current openSUSE
Tumbleweed without modification. They are still
a lot of things to be added to the upstream Linux
before it runs flawlessly on this device, but at
least in U-Booot SD controller used for uSD card
and Frameboffer and HDMI0 devices are working fine
now. It seems that PCIe controller is working fine
too, but I have not tested it too much.

Serial console and reset are also functional.

Hopefully this will help others add missing pieces
more easily.

Happy hacking!

Regards,
Ivan

[1] https://lore.kernel.org/all/CAKRNjQ0dsWozGo4n8g58m4cCEk3n=qx1R+L24WBgpo-iP1yo7A@mail.gmail.com/

Dmitry Malkin (2):
  rpi5: add initial memory map for bcm2712
  rpi5: Use devicetree as alternative way to read IO base addresses

Ivan T. Ivanov (5):
  rpi5: Use devicetree to retrieve board revision
  bcm2835: brcm,bcm2708-fb device is using r5g6b5 format
  mmc: bcmstb: Add support for bcm2712 SD controller
  configs: rpi_arm64: enable SDHCI BCMSTB driver
  pci: pcie-brcmstb: Add bcm2712 PCIe controller support

 arch/arm/mach-bcm283x/include/mach/base.h  |   5 +-
 arch/arm/mach-bcm283x/include/mach/mbox.h  |   3 +-
 arch/arm/mach-bcm283x/include/mach/sdhci.h |   3 +-
 arch/arm/mach-bcm283x/include/mach/timer.h |   3 +-
 arch/arm/mach-bcm283x/include/mach/wdog.h  |   3 +-
 arch/arm/mach-bcm283x/init.c               |  81 ++++++++--
 board/raspberrypi/rpi/rpi.c                |  22 ++-
 configs/rpi_arm64_defconfig                |   1 +
 drivers/mmc/bcmstb_sdhci.c                 | 173 ++++++++++++++++++++-
 drivers/pci/pcie_brcmstb.c                 |  23 ++-
 drivers/video/bcm2835.c                    |  10 +-
 11 files changed, 296 insertions(+), 31 deletions(-)

-- 
2.35.3

