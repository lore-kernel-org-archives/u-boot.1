Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB852D3B7F6
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 09:39:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B86558965B;
	Mon, 25 Nov 2024 10:39:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="WE9UwgW/";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WE9UwgW/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 433F288EC4; Mon, 25 Nov 2024 10:39:12 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2477F890D9
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 10:39:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ldevulder@suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 991211F381
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 09:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1732527549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M38OQQgKrbkd/WS9zAGga/hAUZHcgFm18Lvo1w5Cch4=;
 b=WE9UwgW/Ri+9fFD5Lfnm0cBDbI4JYrsi1JROcJ49+CuGfHWMYRsTzRwPWv2l+vF/AWyVH2
 4WjxSzwa6so+pBv03xUNWE+daNgkEvvt5cvKimxumpDMlt/VBs5VU99KjTUmxxhESOatkS
 ETyGHx+Gn9hG1u66kc4A0G1geVswZTg=
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.com header.s=susede1 header.b="WE9UwgW/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1732527549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M38OQQgKrbkd/WS9zAGga/hAUZHcgFm18Lvo1w5Cch4=;
 b=WE9UwgW/Ri+9fFD5Lfnm0cBDbI4JYrsi1JROcJ49+CuGfHWMYRsTzRwPWv2l+vF/AWyVH2
 4WjxSzwa6so+pBv03xUNWE+daNgkEvvt5cvKimxumpDMlt/VBs5VU99KjTUmxxhESOatkS
 ETyGHx+Gn9hG1u66kc4A0G1geVswZTg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7B1B113A73
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 09:39:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QMMNHL1FRGeoZQAAD6G6ig
 (envelope-from <ldevulder@suse.com>)
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 09:39:09 +0000
From: Loic Devulder <ldevulder@suse.com>
To: u-boot@lists.denx.de
Subject: [PATCH 1/1] configs: visionfive2: enable CONFIG_DISTRO_DEFAULTS
Date: Mon, 25 Nov 2024 10:39:02 +0100
Message-ID: <20241125093908.50903-2-ldevulder@suse.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241125093908.50903-1-ldevulder@suse.com>
References: <20241125093908.50903-1-ldevulder@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 991211F381
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.98%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 PREVIOUSLY_DELIVERED(0.00)[u-boot@lists.denx.de];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_DN_NONE(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_SIGNED(0.00)[suse.com:s=susede1];
 MIME_TRACE(0.00)[0:+]; DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

Supported boot device types are MMC, USB, SF and DHCP.

Signed-off-by: Loic Devulder <ldevulder@suse.com>
---
 configs/starfive_visionfive2_defconfig |  1 +
 include/configs/starfive-visionfive2.h | 29 ++++++++++++++++++++------
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
index 20f89ae6796..e817e63858b 100644
--- a/configs/starfive_visionfive2_defconfig
+++ b/configs/starfive_visionfive2_defconfig
@@ -41,6 +41,7 @@ CONFIG_SD_BOOT=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="console=ttyS0,115200 debug rootwait earlycon=sbi"
+CONFIG_DISTRO_DEFAULTS=y
 CONFIG_USE_PREBOOT=y
 CONFIG_PREBOOT="nvme scan; usb start; setenv fdt_addr ${fdtcontroladdr}; fdt addr ${fdtcontroladdr};"
 CONFIG_SYS_CBSIZE=256
diff --git a/include/configs/starfive-visionfive2.h b/include/configs/starfive-visionfive2.h
index 049b0a06301..7f187307ffe 100644
--- a/include/configs/starfive-visionfive2.h
+++ b/include/configs/starfive-visionfive2.h
@@ -15,14 +15,29 @@
 
 #define __io
 
+#ifdef CONFIG_DISTRO_DEFAULTS
+#define BOOT_TARGET_DEVICES(func) \
+	func(MMC, mmc, 1) \
+	func(MMC, mmc, 0) \
+	func(USB, usb, 0) \
+	func(SF, sf, 0) \
+	func(DHCP, dhcp, na)
+
+#include <config_distro_bootcmd.h>
+#include <env/distro/sf.h>
+#else
+#define BOOTENV
+#define BOOTENV_SF
+#endif
+
 #define TYPE_GUID_SPL		"2E54B353-1271-4842-806F-E436D6AF6985"
-#define TYPE_GUID_UBOOT	"BC13C2FF-59E6-4262-A352-B275FD6F7172"
+#define TYPE_GUID_UBOOT		"BC13C2FF-59E6-4262-A352-B275FD6F7172"
 #define TYPE_GUID_SYSTEM	"EBD0A0A2-B9E5-4433-87C0-68B6B72699C7"
 
-#define PARTS_DEFAULT							\
-		"name=spl,start=2M,size=2M,type=${type_guid_gpt_loader1};" \
-		"name=uboot,size=4MB,type=${type_guid_gpt_loader2};"		\
-		"name=system,size=-,bootable,type=${type_guid_gpt_system};"
+#define PARTS_DEFAULT \
+	"name=spl,start=2M,size=2M,type=${type_guid_gpt_loader1};" \
+	"name=uboot,size=4MB,type=${type_guid_gpt_loader2};" \
+	"name=system,size=-,bootable,type=${type_guid_gpt_system};"
 
 #define CFG_EXTRA_ENV_SETTINGS \
 	"kernel_addr_r=0x40200000\0" \
@@ -37,6 +52,8 @@
 	"type_guid_gpt_loader2=" TYPE_GUID_UBOOT "\0" \
 	"type_guid_gpt_system=" TYPE_GUID_SYSTEM "\0" \
 	"partitions=" PARTS_DEFAULT "\0" \
-	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0"
+	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0" \
+	BOOTENV \
+	BOOTENV_SF
 
 #endif /* _STARFIVE_VISIONFIVE2_H */
-- 
2.47.0

