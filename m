Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25AFFC54FDF
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 08:39:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3B20080BF0;
	Thu, 30 Jul 2026 08:39:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zdWFCqd2XiLF; Thu, 30 Jul 2026 08:39:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CF60F80C43
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785400782;
	bh=Ja3fJrAfKa5FcBGpBfvyy+9yYWTmDuAy/tKxgKDZQCs=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=sF6Y/g+tnIdqihiYZHwa7vtUjoXst5zGBA8xUml3CpvgBFv90C6jz6QRwg5w9RolY
	 9cKQVx0dSJ23cCWAvPsVxN5/gX6dttWkj8WbHPcPooX12yGW7NTLzZCOi2zgLR0Uln
	 z/8pRcQs0jOzsqU4lBO/18kVa/qR88sZvtWaWQBXFLEhoA6LmMgXUv1rvf0TkKkskj
	 S4dJPdx4iUZeoP+7AWzlB9M+F31kOLxnzT8+ImvcneFUvSU0vQXxjbVidy/W3EQld2
	 skL82byy8NOcIflTHy1V4RZ0/LfEb4DhyJHCV3bwBzp4Obd1QUtM3r+QCU22bT+G9E
	 iqH8n4Bf9w6lg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CF60F80C43;
	Thu, 30 Jul 2026 08:39:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CF7F7352
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 08:39:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C1C5640903
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 08:39:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gcR2QRmWS4Em for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 08:39:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org AEF3E40861
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AEF3E40861
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AEF3E40861
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 08:39:39 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-472326ca506so1308372f8f.2
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 01:39:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785400778; x=1786005578;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Ja3fJrAfKa5FcBGpBfvyy+9yYWTmDuAy/tKxgKDZQCs=;
 b=Uf4h2iLvS9xZ6oqDaRhUyNFUbAkMdQXA85OMJa1MD9jmkus9ylu1L+ZRy3nV4nTmBX
 LW9thA4DEZvICXgGbsPiSr9ThBEWFLl2dPy4Fm8yXuc2AtRjAwwGN851tG2fqZ6++/ok
 OmecmDCSov3jGqPe+9m+9145t8KC2OkWKCaAiCC1mxa9fYzPXGhZGVJmMF1XRQB5jWVC
 yMSSTa1Q0pPQjZI3yARXxseqDzhMERSHCE8F7XFnG0QiV8ItusCDU0qVebsl0JlOpgZD
 h8Xr+8L+eQRm0qiE2pQmYiEcWAgbRcE8QxeALEGNWdTLPAq+L+uJmlfieYrAHUWyn/NZ
 Um6g==
X-Gm-Message-State: AOJu0YzmS+3LXG9Gh3JNvbYC+/+UkZfhiC06wuFp55ZwacZ9nJNg02ZJ
 IUtgr9xEaqcFf8L/+G8JZlyg85QYW+QfMBWfRTLKQIiam6dsudf+IW5nce4ZlEZvvkxq2NsC9J+
 7UaRGo3ughg==
X-Gm-Gg: AR+sD10bWXG7b04kMlSRRDNBwQUPGzIVyv2CXuNRthCh13v6RXzdT5qvhpm785liEXi
 QLeQeBXBXbHPVgcsOcsXzSV4auLdTOsZlfSSpbK+gGge5DneDKXrT2neAdfPfE24pcofGkHnjHy
 jujqjOlAu7NTAfUtcZvrhkcAoheWqoZzcTXPMkKSXACI8b9cppPCC0LvtLDTSVVhxL0nNQHK/Uz
 6DlZIw0obZkX0877SwApPfkIDhWt83nxfGYK1DfErn/vapodYq81t5Bb/90Paxgt1luvD+Gj0o/
 tYpwPIy75dvkGKnp3GlNzSY7Iq52CViUyb5+zOTJgyVNtLWs0xRcjssXrpsAgTROlkBlp6QKVY6
 xLMWQ8fnI8gKxkkGqVEUV4+Al5HIAz1BDu9QWg0Fh5Uw4+guua9hniqlfBstXvA7u70Ppu6FTY+
 XBIRS1a2fCxsOtuN938M35glGwKzMKkTVIIlShkLY6d6zGv5+9a/C+5tj/tE6yhHQeS9mlCBiYk
 5ckLF4mmuWXW5oOxjfmU0FR4XN9JxjSYpkNsm59wg==
X-Received: by 2002:a05:6000:290e:b0:47d:efd0:c026 with SMTP id
 ffacd0b85a97d-47fc80c080fmr2193602f8f.11.1785400777666; 
 Thu, 30 Jul 2026 01:39:37 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-92-99-174-41.alshamil.net.ae.
 [92.99.174.41]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fc89418c5sm4452877f8f.33.2026.07.30.01.39.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 01:39:36 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Thu, 30 Jul 2026 12:39:27 +0400
Subject: [PATCH] board_f: Make printing reset information optional
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-resetinfo-optional-v1-1-0b500903e4b3@flipper.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMSwqEMBBF0a1IjQ3EKP62Ij3QpKLVNImk0iKIe
 zfq8MB79wDGQMjQZwcE3IjJu4Qiz0Avo5tRkEkGJVUtm1KKgIyRnPXCrzGNx58wSk+VNla2nYJ
 0XANa2p/o8HnN/+mLOt4lOM8LNP/genYAAAA=
X-Change-ID: 20260730-resetinfo-optional-d2cb4cdf0892
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2854; i=alchark@flipper.net;
 h=from:subject:message-id; bh=/tYRRilmOS3nDO96TmvdUBCbG1Go+UYkU5DW1FT6ApY=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRl8x7auFHZi6vmweT4Q5qu/0pvzpdJPXqbea6M3LrEG
 U1Fm//97pjIwiDGxWAppsgy99sS26lGfLN2eXh8hZnDygQyRFqkgQEIWBj4chPzSo10jPRMtQ31
 DI10jHWMGLg4BWCq1bgY/ieYPDgXqOy7wcZrZXrijRPfGc9wCbPVWqbbzjogzumTdJSRoTvoD5v
 po4i9/+6ukPwkcGLV0/Rdxq9ljN9qqnb+EdZYyw0A
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1785400778; x=1786005578;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Ja3fJrAfKa5FcBGpBfvyy+9yYWTmDuAy/tKxgKDZQCs=;
 b=N31sO5DMYGBRqGiSVbudkV3gNVwS/2vdvvKsvVtfdKZVFv21GzyFsN/Zx3IaZnBqo8
 md6D+ZKVNQYH7TjKQOYUthVvJgCENguBgbZxsSRsCRFQ47G0JVUwYH/Zmf9wjFnurWww
 y/Ut04eOQfs+tS5bK1i73uvx/eyrDCDWYhbAHHyrPk5YBZXpwSw9OQSMg2tIZvtVgz2l
 3lqOwf9YzHkai2d3XK2Q1UX13Tev8Z5SisRMHEEGdfJFy9FWn0lAFY7HmHUpv4ObGjAw
 oo80cGeawqvhW/TklcPQQWNkg9EeuaTRv+YdcUSxl1Dv+JAtRGm77Okyk9hEuTuucIrV
 jriw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=N31sO5DM
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Current code tries to print information about the reset method whenever
sysreset support is enabled. This causes the core to try to bind the
sysreset device in board_init_f, even if the driver doesn't support
reset status reporting, causing pure waste on some platforms (e.g. on
Rockchip RK3576 it increases the boot time by ~0.4s even though the driver
doesn't support reset status reporting).

Make the printing of reset information optional, so that it can be
enabled only on platforms where it is supported and useful.

Only four sysreset drivers actually implement the get_status() op, so
default the new symbol to y wherever one of them can be in use to avoid
regressing those platforms:

 - sysreset_sandbox
 - sysreset_mpc83xx
 - sysreset_psci, whose weak stub get_status() is only overridden by i.MX9;
 - the pca9450 PMIC sysreset child driver.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 common/board_f.c         |  4 ++--
 drivers/sysreset/Kconfig | 14 ++++++++++++++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/common/board_f.c b/common/board_f.c
index 85b888d4bb85..7d1f80cd7fbf 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -122,7 +122,7 @@ static int display_text_info(void)
 	return 0;
 }
 
-#ifdef CONFIG_SYSRESET
+#ifdef CONFIG_SYSRESET_PRINT_RESETINFO
 static int print_resetinfo(void)
 {
 	struct udevice *dev;
@@ -963,7 +963,7 @@ static void initcall_run_f(void)
 	INITCALL(display_options);	/* say that we are here */
 	INITCALL(display_text_info);	/* show debugging info if required */
 	INITCALL(checkcpu);
-#if CONFIG_IS_ENABLED(SYSRESET)
+#if CONFIG_IS_ENABLED(SYSRESET_PRINT_RESETINFO)
 	INITCALL(print_resetinfo);
 #endif
 	/* display cpu info (and speed) */
diff --git a/drivers/sysreset/Kconfig b/drivers/sysreset/Kconfig
index 16ef434a8d9c..a046dd02e66f 100644
--- a/drivers/sysreset/Kconfig
+++ b/drivers/sysreset/Kconfig
@@ -43,6 +43,20 @@ config VPL_SYSRESET
 
 if SYSRESET
 
+config SYSRESET_PRINT_RESETINFO
+	bool "Print reset information during boot"
+	default y if SANDBOX
+	default y if SYSRESET_MPC83XX
+	default y if SYSRESET_PSCI && ARCH_IMX9
+	default y if DM_PMIC_PCA9450
+	help
+	  Print information about the cause of the last reset during early
+	  boot, as reported by the get_status() method of the sysreset
+	  drivers. This requires probing all sysreset devices in
+	  board_init_f(), which costs boot time, so only enable it if at
+	  least one of the sysreset drivers in use actually implements
+	  get_status().
+
 config SYSRESET_CMD_RESET
 	bool "sysreset implementation of the reset command"
 	default y

---
base-commit: 44f0dcf476140c1077ee3dbe16a80fdb6f8265c4
change-id: 20260730-resetinfo-optional-d2cb4cdf0892

Best regards,
--  
Alexey Charkov <alchark@flipper.net>

