Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A146CC3DA42
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 08:33:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31DFC88A69;
	Wed, 17 Jul 2024 10:31:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DVJJfAuF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8A56886E5; Wed, 17 Jul 2024 10:31:25 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0678D88A5D
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 10:31:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-367ac08f80fso3497722f8f.1
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 01:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721205082; x=1721809882; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EjsUGi3ZuYXbSchQPh0GrVPJK/9IvnxEb8nCYiT0VqE=;
 b=DVJJfAuFcBBPfvpHrvJUyXbWx++PCQR+e1DMTqC+7msdU/cDj2vDwXWqHXqILOSOix
 vHSlNzYBlV7JuVanujZ+7iIKfZ8bgfEC3F6EUDZdEt6/ib63FxlUMI0kyX8DSUkbXsom
 q7mCoG2TCYy89ekOQvVOan5eVr36uSyVrRw1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721205082; x=1721809882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EjsUGi3ZuYXbSchQPh0GrVPJK/9IvnxEb8nCYiT0VqE=;
 b=LLQm51KVJ2lqB7DvnU2KuWtzQcgn0I0U7p2kZjsn+g+ICGRKskBQrrExXQrEGdRrJe
 1t5HIEAUuNY8/m7AyR54J63c5h6qGPWNEz+YT9gd6aEM2/rOwtY5HQLD45jpNa4xhWQ6
 D7GplMz/WiWcxHnNJ+C/nyPUUzHfYRDiyy6AdblSVp1++sSjfGiJwMZZpsZxXMI600az
 1Z408PvyltCIfzc3QRUZFBpyHtzgF2RZAv4z2WIbblWA+2zlrYqt4rLXiSfQV3+vFMx1
 lnHknoUXZi+5NwXkppsmrEty7sWrWTOIPj8NxVgkbQzVr15Yll1V5RWSJ0Oetz+ubGmT
 12Iw==
X-Gm-Message-State: AOJu0Yx42cuYCDzlTPqMAEtxK7gBuF8YCEuSk0x7CHt2bcQaiTUPuUeL
 OXEas7WDQaZU9YEXumHcTPobY8DAr53MqhqAwKYF0LJFmfAFcWoTsf335gArtUuFCnbJF7875bY
 =
X-Google-Smtp-Source: AGHT+IGevp0JjzT3GjKGEV55+U6Q5jOD0nMiJY7phOBY0jFu5ahwNTw2KopHK6bqwZaKIzTAE6EwCA==
X-Received: by 2002:a5d:5231:0:b0:367:9881:7d66 with SMTP id
 ffacd0b85a97d-3683170e3d9mr914105f8f.41.1721205082262; 
 Wed, 17 Jul 2024 01:31:22 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dafbb5bsm11069930f8f.80.2024.07.17.01.31.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 01:31:21 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 10/14] bootstd: Correct handling of script from network
Date: Wed, 17 Jul 2024 09:31:00 +0100
Message-Id: <20240717083104.1963431-11-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240717083104.1963431-1-sjg@chromium.org>
References: <20240717083104.1963431-1-sjg@chromium.org>
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
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
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

