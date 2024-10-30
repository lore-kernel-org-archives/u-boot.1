Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C030D5CCAF
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 13:46:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71E2E8903C;
	Wed, 30 Oct 2024 14:46:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="BN5boIBL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="U+Xhx/v4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BN5boIBL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="U+Xhx/v4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C8F98918E; Wed, 30 Oct 2024 14:46:42 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4604E88C8F
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 14:46:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=schwab@suse.de
Received: from hawking.nue2.suse.org (unknown
 [IPv6:2a07:de40:a101:3:92b1:1cff:fe69:ddc])
 by smtp-out1.suse.de (Postfix) with ESMTP id 8D63421D78
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 13:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730295999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=xFbHqud0us+yJs9nHa2nSGdZeTNhzSN+g9joWitw0rY=;
 b=BN5boIBLPqT7TQUaEKSCBogMy1shF4S7/xJR9bnM6F0YL1c4DaxH8CJQC2c6KMBLFBFmzL
 uOZ5TF3XNHQ8ghIfs+k3C4bUtXtbTMDhVmPoXUi4OBaBp3CiaQ2Cb2vQ5dKq1kcx6rF7Pl
 SBAU4Jg/Kp2sJH/bsRc1A38L6Bk2yvU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730295999;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=xFbHqud0us+yJs9nHa2nSGdZeTNhzSN+g9joWitw0rY=;
 b=U+Xhx/v40UpVbWt7/FuxadizN0Jg3WdXSxKgGU/FBjXubyrEQAb1PMBuIElDw1tjOoMqCR
 f/F59nd+15oF/mCQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=BN5boIBL;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="U+Xhx/v4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730295999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=xFbHqud0us+yJs9nHa2nSGdZeTNhzSN+g9joWitw0rY=;
 b=BN5boIBLPqT7TQUaEKSCBogMy1shF4S7/xJR9bnM6F0YL1c4DaxH8CJQC2c6KMBLFBFmzL
 uOZ5TF3XNHQ8ghIfs+k3C4bUtXtbTMDhVmPoXUi4OBaBp3CiaQ2Cb2vQ5dKq1kcx6rF7Pl
 SBAU4Jg/Kp2sJH/bsRc1A38L6Bk2yvU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730295999;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=xFbHqud0us+yJs9nHa2nSGdZeTNhzSN+g9joWitw0rY=;
 b=U+Xhx/v40UpVbWt7/FuxadizN0Jg3WdXSxKgGU/FBjXubyrEQAb1PMBuIElDw1tjOoMqCR
 f/F59nd+15oF/mCQ==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
 id 74AA04A055D; Wed, 30 Oct 2024 14:46:39 +0100 (CET)
From: Andreas Schwab <schwab@suse.de>
To: u-boot@lists.denx.de
Subject: [PATCH] configs: visionfive2: re-enable SPL_SYS_MMCSD_RAW_MODE
X-Yow: Bo Derek ruined my life!
Date: Wed, 30 Oct 2024 14:46:39 +0100
Message-ID: <mvmikt91z5s.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [15.29 / 50.00]; SPAM_FLAG(5.00)[];
 NEURAL_SPAM_LONG(3.50)[1.000]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_SPAM_SHORT(3.00)[0.999];
 HFILTER_HOSTNAME_UNKNOWN(2.50)[]; RDNS_NONE(2.00)[];
 ONCE_RECEIVED(1.20)[];
 HFILTER_HELO_IP_A(1.00)[hawking.nue2.suse.org];
 HFILTER_HELO_NORES_A_OR_MX(0.30)[hawking.nue2.suse.org];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_NO_TLS_LAST(0.10)[]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FROM_EQ_ENVFROM(0.00)[];
 DIRECT_TO_MX(0.00)[Gnus/5.13 (Gnus v5.13)];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_ONE(0.00)[1];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MID_RHS_MATCH_FROM(0.00)[]; TO_DN_NONE(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email]
X-Rspamd-Queue-Id: 8D63421D78
X-Rspamd-Action: add header
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Bar: +++++++++++++++
X-Spam: Yes
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

To restore MMC boot, enable SPL_SYS_MMCSD_RAW_MODE and recover
SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION and
SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION.

Fixes: 2a00d73d081 ("spl: mmc: Try to clean up raw-mode options")
---
 configs/starfive_visionfive2_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
index c3508926d6c..11e1332f875 100644
--- a/configs/starfive_visionfive2_defconfig
+++ b/configs/starfive_visionfive2_defconfig
@@ -55,6 +55,9 @@ CONFIG_SPL_PAD_TO=0x0
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
 CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x80000000
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=0x2
 CONFIG_SPL_SYS_MALLOC_SIZE=0x400000
 CONFIG_SPL_I2C=y
 CONFIG_SPL_DM_SPI_FLASH=y
-- 
2.47.0


-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
