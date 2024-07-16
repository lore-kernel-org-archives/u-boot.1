Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE630C3DA59
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 07:06:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AC6F889A1;
	Tue, 16 Jul 2024 09:04:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RbUL7wW0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64582889B9; Tue, 16 Jul 2024 09:04:37 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 101B088995
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 09:04:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4266182a9d7so32536335e9.0
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 00:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721113474; x=1721718274; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=te4pX2QlNebQXULPMa61sFfYtJAwieiQr5fCUvIlQfY=;
 b=RbUL7wW0pt4lZK0vE7azUj06WZTksNseh80jaQRUtNElZ3OC5CNG1Odj7Dcf5QC6U1
 P46aNe5VAJd73nMxLBDwOTUbkur1awyk0NKylfQI4bD/RBEcQ2lbE/YYJb4f+/PXwD/v
 D9eCLstFtyzwSOEsShWrC2YAgwXF05HMjo60w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721113474; x=1721718274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=te4pX2QlNebQXULPMa61sFfYtJAwieiQr5fCUvIlQfY=;
 b=b9cbYTM4fqRRSVEfsn8N2xS+PnvkULl27e8txNNN21TFeAMbV+cVbIsF5XvyWpFrc8
 rTkF0MigEA+rzPZ7V2tsRjZx3+Y9gkaQTglE/YnmmG2x8akwXpy2r5zfPm+iK2dY/BSx
 Eq1VoxC79lNxLR5KK/HQzVuyJRduvqeETkGpgRo1ZlJsZGEejrsNl6mVDlpCx0kwlNDa
 cPf+HMQ8jzmgL3UYVnUYsjbgl8QIDGrChnfZHMk+UFvJR2DQ2dPwDWtWi6u8RuDnbCGs
 7iQX6lnWB4YQQQWHduoGtbwTB2QPpsf80tQau96R2kQ8AS5/y1KsDaD9yARmwJFuJAJy
 aaXw==
X-Gm-Message-State: AOJu0YxqPEBGKx/jv6cxApqaILilm1FvkrmCh8q1ZqyfMjznbmsOtPkX
 M6nEU8CFvdRf4ijc2SqS0YG0OpNP/i8f0j7yXytrzDx1jQY48l5YGkMn6EA9/8JRKcR2z7dA1O4
 =
X-Google-Smtp-Source: AGHT+IGtdjOErHU0LZDR973j+NLsngWSo+pm6Cg0iuixMg8XIllOlY1i6PXhRIKlQZ61qGT2vSuueg==
X-Received: by 2002:a05:600c:5127:b0:426:6099:6eaa with SMTP id
 5b1f17b1804b1-427ba6dbd32mr6455735e9.26.1721113474416; 
 Tue, 16 Jul 2024 00:04:34 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f2cc286sm149446295e9.33.2024.07.16.00.04.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 00:04:34 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 10/14] bootstd: Correct handling of script from network
Date: Tue, 16 Jul 2024 08:04:15 +0100
Message-Id: <20240716070419.1897560-11-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240716070419.1897560-1-sjg@chromium.org>
References: <20240716070419.1897560-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

When reading a script from a network, no block device is available.
Update the implementation to support this correctly, avoiding setting
environment variables which relate only to block devices.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootmeth_script.c | 51 +++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 20 deletions(-)

diff --git a/boot/bootmeth_script.c b/boot/bootmeth_script.c
index 24da47c7259..c5cbf18c2e6 100644
--- a/boot/bootmeth_script.c
+++ b/boot/bootmeth_script.c
@@ -185,31 +185,42 @@ static int script_set_bootflow(struct udevice *dev, struct bootflow *bflow,
 
 static int script_boot(struct udevice *dev, struct bootflow *bflow)
 {
-	struct blk_desc *desc = dev_get_uclass_plat(bflow->blk);
+	struct blk_desc *desc;
 	ulong addr;
 	int ret = 0;
 
-	if (desc->uclass_id == UCLASS_USB) {
-		ret = env_set("devtype", "usb");
+	if (bflow->blk) {
+		desc = dev_get_uclass_plat(bflow->blk);
+		if (desc->uclass_id == UCLASS_USB) {
+			ret = env_set("devtype", "usb");
+		} else {
+			/*
+			 * If the uclass is AHCI, but the driver is ATA
+			 * (not scsi), set devtype to sata
+			 */
+			if (IS_ENABLED(CONFIG_SATA) &&
+			    desc->uclass_id == UCLASS_AHCI)
+				ret = env_set("devtype", "sata");
+			else
+				ret = env_set("devtype", blk_get_devtype(bflow->blk));
+		}
+		if (!ret)
+			ret = env_set_hex("devnum", desc->devnum);
+		if (!ret)
+			ret = env_set_hex("distro_bootpart", bflow->part);
+		if (!ret)
+			ret = env_set("prefix", bflow->subdir);
+		if (!ret && IS_ENABLED(CONFIG_ARCH_SUNXI) &&
+		    !strcmp("mmc", blk_get_devtype(bflow->blk)))
+			ret = env_set_hex("mmc_bootdev", desc->devnum);
 	} else {
-		/* If the uclass is AHCI, but the driver is ATA
-		 * (not scsi), set devtype to sata
-		 */
-		if (IS_ENABLED(CONFIG_SATA) &&
-		    desc->uclass_id == UCLASS_AHCI)
-			ret = env_set("devtype", "sata");
-		else
-			ret = env_set("devtype", blk_get_devtype(bflow->blk));
+		const struct udevice *media = dev_get_parent(bflow->dev);
+
+		ret = env_set("devtype",
+			      uclass_get_name(device_get_uclass_id(media)));
+		if (!ret)
+			ret = env_set_hex("devnum", dev_seq(media));
 	}
-	if (!ret)
-		ret = env_set_hex("devnum", desc->devnum);
-	if (!ret)
-		ret = env_set_hex("distro_bootpart", bflow->part);
-	if (!ret)
-		ret = env_set("prefix", bflow->subdir);
-	if (!ret && IS_ENABLED(CONFIG_ARCH_SUNXI) &&
-	    !strcmp("mmc", blk_get_devtype(bflow->blk)))
-		ret = env_set_hex("mmc_bootdev", desc->devnum);
 	if (ret)
 		return log_msg_ret("env", ret);
 
-- 
2.34.1

