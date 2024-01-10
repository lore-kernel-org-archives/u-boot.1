Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47574C4707B
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 12:30:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0AA887AC5;
	Wed, 10 Jan 2024 13:29:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="BZTei+wy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HxCmRue1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BZTei+wy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HxCmRue1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1956086D2E; Wed, 10 Jan 2024 13:29:29 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 699EB87AC7
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 13:29:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=iivanov@suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1A3352201D;
 Wed, 10 Jan 2024 12:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704889766; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oxcJASwTh4WxHfjrNv4T72q2biGXRjM33F3qFGwIZgg=;
 b=BZTei+wyXPbaS435fTXOVS1BWWQX3n14vqYpdRaQv2ua5Zi6brVN5u/CNAXEpzBmHGCxzi
 6OjwuPtcpC9x+Oz1vi8XVuVxGM9pLYAN35CRKeb4cF+0kRxlr4yKccNp0hF33pWYs8EK4t
 GKzZZ691P+TNJ6ED9Fo1+00QRUUmR9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704889766;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oxcJASwTh4WxHfjrNv4T72q2biGXRjM33F3qFGwIZgg=;
 b=HxCmRue13lwe8gz7GjaarU3ISd8VkWW2CcBtuU5jDO8Ydz3F/fPXA34gIB4Be3u8oP3afY
 Y+IMq0o5CKhBmdBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704889766; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oxcJASwTh4WxHfjrNv4T72q2biGXRjM33F3qFGwIZgg=;
 b=BZTei+wyXPbaS435fTXOVS1BWWQX3n14vqYpdRaQv2ua5Zi6brVN5u/CNAXEpzBmHGCxzi
 6OjwuPtcpC9x+Oz1vi8XVuVxGM9pLYAN35CRKeb4cF+0kRxlr4yKccNp0hF33pWYs8EK4t
 GKzZZ691P+TNJ6ED9Fo1+00QRUUmR9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704889766;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oxcJASwTh4WxHfjrNv4T72q2biGXRjM33F3qFGwIZgg=;
 b=HxCmRue13lwe8gz7GjaarU3ISd8VkWW2CcBtuU5jDO8Ydz3F/fPXA34gIB4Be3u8oP3afY
 Y+IMq0o5CKhBmdBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 788C213CB5;
 Wed, 10 Jan 2024 12:29:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6JYBG6WNnmUZPgAAD6G6ig
 (envelope-from <iivanov@suse.de>); Wed, 10 Jan 2024 12:29:25 +0000
From: "Ivan T. Ivanov" <iivanov@suse.de>
To: Matthias Brugger <mbrugger@suse.com>, Peter Robinson <pbrobinson@gmail.com>
Cc: Dmitry Malkin <dmitry@bedrocksystems.com>,
 Thomas Fitzsimmons <fitzsim@fitzsim.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>,
 wahrenst@gmx.net, florian.fainelli@broadcom.com, u-boot@lists.denx.de,
 "Ivan T. Ivanov" <iivanov@suse.de>
Subject: [PATCH v4 6/6] configs: rpi_arm64: enable SDHCI BCMSTB driver
Date: Wed, 10 Jan 2024 14:29:08 +0200
Message-ID: <20240110122908.31612-7-iivanov@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110122908.31612-1-iivanov@suse.de>
References: <20240110122908.31612-1-iivanov@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [4.90 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.net];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BROKEN_CONTENT_TYPE(1.50)[];
 R_RATELIMIT(0.00)[to_ip_from(RL9dd9h8xg9qpm5f14t9e5w4zz)];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_SEVEN(0.00)[11]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FREEMAIL_TO(0.00)[suse.com,gmail.com];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[bedrocksystems.com,fitzsim.org,nxp.com,samsung.com,denx.de,gmx.net,broadcom.com,lists.denx.de,suse.de];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[29.34%]
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

RPi5 have "brcm,bcm2712-sdhci" controller which is
handled by "sdhci-bcmstb" driver, so enable it.

Signed-off-by: Ivan T. Ivanov <iivanov@suse.de>
---
 configs/rpi_arm64_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/rpi_arm64_defconfig b/configs/rpi_arm64_defconfig
index 08bb30b1d7..11ede9435d 100644
--- a/configs/rpi_arm64_defconfig
+++ b/configs/rpi_arm64_defconfig
@@ -33,6 +33,7 @@ CONFIG_BCM2835_GPIO=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_BCM2835=y
+CONFIG_MMC_SDHCI_BCMSTB=y
 CONFIG_BCMGENET=y
 CONFIG_PCI_BRCMSTB=y
 CONFIG_PINCTRL=y
-- 
2.35.3

