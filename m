Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7898CD42BA6
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 16:27:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBB118910B;
	Tue, 12 Nov 2024 17:27:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="zw22XqkD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Axs0RLKx";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zw22XqkD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Axs0RLKx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F2D98918E; Tue, 12 Nov 2024 17:27:25 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 206DD890FD
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 17:27:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=schwab@suse.de
Received: from hawking.nue2.suse.org (unknown [10.168.4.11])
 by smtp-out1.suse.de (Postfix) with ESMTP id 87D3721274
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 16:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1731428842; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=J3CpLQ8Gv1f2aThzu8PE3enWIjgBUnlHhAr0RX4vv5A=;
 b=zw22XqkDxPhqlv1CQnG6ea0Mt09UJqgAvKIBhIBhjT/aGRfmBUk8Pc0/HZB/DYw6zv04Go
 IZleZwa3CijG+ribYtclMYa//+lkapeO36hTWs1bShM/0aealuR9/nVMQZpGy61DeZlPDN
 fuc3rA/1z137884joZG5lI7kFvuHWqc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1731428842;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=J3CpLQ8Gv1f2aThzu8PE3enWIjgBUnlHhAr0RX4vv5A=;
 b=Axs0RLKxuQdXMqxIdNWndl0LksmFTqn4/nTI6AtyTxiioLzj7ooWoNhoC2aTK9GUEQ6fUx
 l0JQiPFg68hXodAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1731428842; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=J3CpLQ8Gv1f2aThzu8PE3enWIjgBUnlHhAr0RX4vv5A=;
 b=zw22XqkDxPhqlv1CQnG6ea0Mt09UJqgAvKIBhIBhjT/aGRfmBUk8Pc0/HZB/DYw6zv04Go
 IZleZwa3CijG+ribYtclMYa//+lkapeO36hTWs1bShM/0aealuR9/nVMQZpGy61DeZlPDN
 fuc3rA/1z137884joZG5lI7kFvuHWqc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1731428842;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=J3CpLQ8Gv1f2aThzu8PE3enWIjgBUnlHhAr0RX4vv5A=;
 b=Axs0RLKxuQdXMqxIdNWndl0LksmFTqn4/nTI6AtyTxiioLzj7ooWoNhoC2aTK9GUEQ6fUx
 l0JQiPFg68hXodAA==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
 id 5AE8A4A0564; Tue, 12 Nov 2024 17:27:22 +0100 (CET)
From: Andreas Schwab <schwab@suse.de>
To: u-boot@lists.denx.de
Subject: [PATCH] configs: visionfive2: re-enable SPL_SYS_MMCSD_RAW_MODE
Date: Tue, 12 Nov 2024 17:27:22 +0100
Message-ID: <mvmy11ov2mt.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.15 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.15)[-0.766]; MIME_GOOD(-0.10)[text/plain];
 RCVD_NO_TLS_LAST(0.10)[]; ARC_NA(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_ONE(0.00)[1]; MID_RHS_MATCH_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_NONE(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
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
Signed-off-by: Andreas Schwab <schwab@suse.de>
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
