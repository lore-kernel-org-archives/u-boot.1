Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFDD3C47258
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 08:09:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A08587C8A;
	Tue, 23 Jan 2024 09:08:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="HOOiWW6H";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6e+8Frj7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HOOiWW6H";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6e+8Frj7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E322D87C00; Tue, 23 Jan 2024 09:08:45 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5B1387B30
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 09:08:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=iivanov@suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 40DAD22283;
 Tue, 23 Jan 2024 08:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705997322; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kY+84eNUrr8+gF84B1r6XbfGpUoy9EQND20xsCSclYA=;
 b=HOOiWW6HEPolQev/q4qYAJUK5xqA0m9C+HR+tf0GLvbrrmukW2rVvbCCYN826ocLGaK8jt
 7jMHfQYCnm+YjD+spJJDOBdk3h+7FCy+9HZ8cKFYWVmOYgoWMnHhVAO2P7p05nx9+AXDS+
 FuobwiYfvqBK09eXn/qgSVeKQitm2yw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705997322;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kY+84eNUrr8+gF84B1r6XbfGpUoy9EQND20xsCSclYA=;
 b=6e+8Frj7ALx172y5LH91hKpYtVNpNHixXC6ZAPs0tSt7MTPYQhst1XT4cpCOxWuy0YFJ8Y
 +z1Tpe79Wgvjr1CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705997322; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kY+84eNUrr8+gF84B1r6XbfGpUoy9EQND20xsCSclYA=;
 b=HOOiWW6HEPolQev/q4qYAJUK5xqA0m9C+HR+tf0GLvbrrmukW2rVvbCCYN826ocLGaK8jt
 7jMHfQYCnm+YjD+spJJDOBdk3h+7FCy+9HZ8cKFYWVmOYgoWMnHhVAO2P7p05nx9+AXDS+
 FuobwiYfvqBK09eXn/qgSVeKQitm2yw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705997322;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kY+84eNUrr8+gF84B1r6XbfGpUoy9EQND20xsCSclYA=;
 b=6e+8Frj7ALx172y5LH91hKpYtVNpNHixXC6ZAPs0tSt7MTPYQhst1XT4cpCOxWuy0YFJ8Y
 +z1Tpe79Wgvjr1CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7769413786;
 Tue, 23 Jan 2024 08:08:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2O7dGQl0r2XOagAAD6G6ig
 (envelope-from <iivanov@suse.de>); Tue, 23 Jan 2024 08:08:41 +0000
From: "Ivan T. Ivanov" <iivanov@suse.de>
To: Matthias Brugger <mbrugger@suse.com>, Peter Robinson <pbrobinson@gmail.com>
Cc: Dmitry Malkin <dmitry@bedrocksystems.com>,
 Thomas Fitzsimmons <fitzsim@fitzsim.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>,
 wahrenst@gmx.net, florian.fainelli@broadcom.com, u-boot@lists.denx.de,
 "Ivan T. Ivanov" <iivanov@suse.de>
Subject: [PATCH v5 7/7] configs: rpi_arm64: build position independent code
Date: Tue, 23 Jan 2024 10:07:59 +0200
Message-ID: <20240123080819.13625-8-iivanov@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123080819.13625-1-iivanov@suse.de>
References: <20240123080819.13625-1-iivanov@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.30 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.net];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLY(-4.00)[]; BROKEN_CONTENT_TYPE(1.50)[];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_RATELIMIT(0.00)[to_ip_from(RL9dd9h8xg9qpm5f14t9e5w4zz)];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_SEVEN(0.00)[11];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FREEMAIL_TO(0.00)[suse.com,gmail.com];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[bedrocksystems.com,fitzsim.org,nxp.com,samsung.com,denx.de,gmx.net,broadcom.com,lists.denx.de,suse.de];
 RCVD_TLS_ALL(0.00)[]
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

Latest RPi5 EEPROM firmware versions after "DATE: 2023/10/30", has changed
kernel load address from 0x80000 to 0x200000 which break boot process.
Switch to position independent code to be able to boot the same binary
on top of different EEPROM firmware versions.

Tested on:
Raspberry Pi 5 Model B Rev 1.0
Raspberry Pi 4 Model B Rev 1.1
Raspberry Pi 3 Model B Plus Rev 1.3
Raspberry Pi Zero 2 W Rev 1.0
Raspberry Pi 2 Model B Rev 1.2
Raspberry Pi Compute Module 4 Rev 1.0
Raspberry Pi Compute Module 3 Rev 1.0

Signed-off-by: Ivan T. Ivanov <iivanov@suse.de>
---
 configs/rpi_arm64_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/rpi_arm64_defconfig b/configs/rpi_arm64_defconfig
index 11ede9435d..e4c4aef9a4 100644
--- a/configs/rpi_arm64_defconfig
+++ b/configs/rpi_arm64_defconfig
@@ -1,6 +1,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_BCM283X=y
-CONFIG_TEXT_BASE=0x00080000
+CONFIG_POSITION_INDEPENDENT=y
 CONFIG_TARGET_RPI_ARM64=y
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x7fffe30
-- 
2.43.0

