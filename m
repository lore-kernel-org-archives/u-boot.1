Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33067C3DA59
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 10:15:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5D04888E0;
	Mon, 15 Jul 2024 12:14:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Eg711EzL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A3F7888D1; Mon, 15 Jul 2024 12:14:10 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75A22888B2
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 12:14:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-426636ef8c9so27266575e9.2
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 03:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721038447; x=1721643247; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5X0dmkMeEyCBhVQLWWRh7P8Sd8qOAFul2Ob9fTHI1SE=;
 b=Eg711EzLFo/8naK44EAqeSFFPtVBSa+OdJdD1J53C5TI2uGZypPCCjrYJFkkT3j0qv
 kuGQUOfd4d2HlcrdWV25mZJ+S7RqYmyIOWUIA5B/5s9SJHl+M4sYP37KlJxFVSuzAP41
 h9ZLjGQu5xmyd0hq0tUoqEzs9C4OMuzK32/0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721038447; x=1721643247;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5X0dmkMeEyCBhVQLWWRh7P8Sd8qOAFul2Ob9fTHI1SE=;
 b=puzZMD6fknhuDswiRNfdE9lIXVLW7ofnyDfiSgo+sTwT263HwF2BAQXyQCMusmKrFe
 E+jewnxlqIe0EsoBfU+jRxEmeQqmwLcwMCO8iEBrfZryj3d9PdQss4aGveUQ2Ee5pud8
 wJqG/6biZtOaNVLjTTIh4GP/PDj17FRYkl8u9G+TWdQYrnWy3rxjUnmSBFhPgOgmcnf4
 69yqPl/V5BMu6wtRjK7qpSzDiqkyVzJ1n4M0N/+uxtT7dYIphR9R3+wUfujWOcYrmTnY
 lK118HWEXOYSusU3dGfnhT3jmo164mE488LOfI9KdiY2/+Gki7A9BxOtdPG46g7ETjUh
 q6lA==
X-Gm-Message-State: AOJu0Yw6SyiijBpnozAWyqpKb8E8jyonMzCUP0fdmL4klQsvHWHzL9cK
 BH4iekJ8kqXzTu3lggPLTqyDZfs2wjVfsaYScXamykj73ZWOFQyDINrNG+cZLSe+ZQqCtViUYnw
 =
X-Google-Smtp-Source: AGHT+IEugyGz6VVjandWkpQHAYB4KIH8K8KhQdGtYTDyCoRM4/a/GSspcXL1rW5pDnOpwfufn3nitQ==
X-Received: by 2002:a05:600c:54e7:b0:426:5f06:5462 with SMTP id
 5b1f17b1804b1-426708fa7e9mr122106235e9.37.1721038446800; 
 Mon, 15 Jul 2024 03:14:06 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f27a265sm114293605e9.28.2024.07.15.03.14.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 03:14:06 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, John Clark <inindev@gmail.com>,
 Stefan Roese <sr@denx.de>, Tony Dinh <mibodhi@gmail.com>
Subject: [PATCH 09/13] bootstd: Correct handling of script from network
Date: Mon, 15 Jul 2024 11:13:50 +0100
Message-Id: <20240715101354.97895-10-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240715101354.97895-1-sjg@chromium.org>
References: <20240715101354.97895-1-sjg@chromium.org>
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

