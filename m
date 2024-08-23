Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B8CC531DC
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 13:52:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A40788BC4;
	Fri, 23 Aug 2024 15:49:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tuYwHJvC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24674886E7; Fri, 23 Aug 2024 15:49:50 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CA4788A29
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 15:49:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-371936541caso910575f8f.0
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 06:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724420987; x=1725025787; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ErBWxkzTdbtyE92CQBPyiy1jniNtymtJyxMnRxGL814=;
 b=tuYwHJvCKa+I5oI0SkLE2Aa4NDlwvqJmBrjx+RTMqBuiNE4Kt+oiatfjE3AGIptFet
 w2izbm+/4jV3j/+lu3m0AcsFXnuH6WtSC06voF1tpqvrEyA4OsxOR+3myE671nmDiLKG
 W407CeYpntIsb04bwCoMfQqHyFSQ/G4yFrYAZWE//C/hbSYHg5njeME4qO4FL5WYEc6+
 NtaEhwOj1NOeGcRUw1LGYLdjx/CqYKPhEtls0Fps/2BmOj1oPa5B1fYYMV35+amPvpZz
 I2B8kDzeqqHWkecswsyK2XBIEKavlVjzEC/akYNKahE7JycZLSZZdUfXHvXEJx92orAb
 jUug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724420987; x=1725025787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ErBWxkzTdbtyE92CQBPyiy1jniNtymtJyxMnRxGL814=;
 b=SDk+OthUVbSTQ0Gg2Yu+Qzzf/C4H5qijx1slIoJbq+60xChAW9V445CJAyOIGdgnY1
 t+Rdp27DUeeyoIXbxzKLuDWL01gcRNVjA5cIu35jwtSCxzVq4PiYmrgEGNFKlvh5jeNz
 vC/f4zMRJGbR5Fzcns4j+wgHn/T3cYptUnrwD+VswbUP59+pHr3cFtT6/axj0ghvwg7n
 o6Zi87DJFPqGwsw2C7wQrtgq0OyCsT16nzggq5evAy8Dcks0eMSNYoqqx6zt+OG9ffnW
 kX9nWdSNp3pA0vlMNemFn//sbWfKi0RnDaCQWZy7DDP3ETzM2tG3o2DE5I6sR7FRb4rb
 fImQ==
X-Gm-Message-State: AOJu0Yy/P85moA8fEMaR1dhtMkMooauA26ClaGh8ZJIhhnMg2sao2ylF
 XDbOgtIrzjDY06hU3HOO5NToUq4ixXBsof/P6fA8N2LMrepg6PDHlQdC/Q9MrdcNvC5mEMiI5nY
 eA7Wkw/0y
X-Google-Smtp-Source: AGHT+IHHAbDKjBQU8w68SYqzRwAi7kWtXRGp/zlxkPJmeEUx/qjS9PlkyrcennPvLjDwHwXnA8ys2w==
X-Received: by 2002:a5d:6d0a:0:b0:367:95e8:3aef with SMTP id
 ffacd0b85a97d-373118cecb6mr1846006f8f.42.1724420987392; 
 Fri, 23 Aug 2024 06:49:47 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:e668:dc94:35c7:8064])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-373081ffb40sm4201665f8f.76.2024.08.23.06.49.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 06:49:47 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 William Zhang <william.zhang@broadcom.com>, Simon Glass <sjg@chromium.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Fabio Estevam <festevam@denx.de>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Michal Simek <michal.simek@amd.com>
Subject: [PATCH v9 18/37] net: eth-uclass: add function eth_start_udev()
Date: Fri, 23 Aug 2024 15:48:22 +0200
Message-Id: <64779fa9e2c5988a347fe7b9ee55fdf03b464fba.1724419624.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1724419624.git.jerome.forissier@linaro.org>
References: <cover.1724419624.git.jerome.forissier@linaro.org>
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

Add a function to start a given network device, and update eth_init()
to use it.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---
 drivers/mtd/altera_qspi.c |  4 ++--
 include/net-common.h      |  1 +
 net/eth-uclass.c          | 38 +++++++++++++++++++++++++-------------
 3 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/drivers/mtd/altera_qspi.c b/drivers/mtd/altera_qspi.c
index c26615821c8..e5c8df750b7 100644
--- a/drivers/mtd/altera_qspi.c
+++ b/drivers/mtd/altera_qspi.c
@@ -96,7 +96,7 @@ int flash_erase(flash_info_t *info, int s_first, int s_last)
 	ret = mtd_erase(mtd, &instr);
 	flash_set_verbose(0);
 	if (ret)
-		return ERR_PROTECTED;
+		return FL_ERR_PROTECTED;
 
 	puts(" done\n");
 	return 0;
@@ -114,7 +114,7 @@ int write_buff(flash_info_t *info, uchar *src, ulong addr, ulong cnt)
 
 	ret = mtd_write(mtd, to, cnt, &retlen, src);
 	if (ret)
-		return ERR_PROTECTED;
+		return FL_ERR_PROTECTED;
 
 	return 0;
 }
diff --git a/include/net-common.h b/include/net-common.h
index 26674ec7e90..43bc6b9a0d5 100644
--- a/include/net-common.h
+++ b/include/net-common.h
@@ -192,6 +192,7 @@ int eth_env_set_enetaddr_by_index(const char *base_name, int index,
 int usb_ether_init(void);
 
 int eth_init(void);			/* Initialize the device */
+int eth_start_udev(struct udevice *dev);
 int eth_send(void *packet, int length);	   /* Send a packet */
 #if defined(CONFIG_API) || defined(CONFIG_EFI_LOADER)
 int eth_receive(void *packet, int length); /* Receive a packet*/
diff --git a/net/eth-uclass.c b/net/eth-uclass.c
index e34d7af0229..6dd9b9bb98e 100644
--- a/net/eth-uclass.c
+++ b/net/eth-uclass.c
@@ -284,6 +284,27 @@ static int on_ethaddr(const char *name, const char *value, enum env_op op,
 }
 U_BOOT_ENV_CALLBACK(ethaddr, on_ethaddr);
 
+int eth_start_udev(struct udevice *dev)
+{
+	struct eth_device_priv *priv = dev_get_uclass_priv(dev);
+	int ret;
+
+	if (priv->running)
+		return 0;
+
+	if (!device_active(dev))
+		return -EINVAL;
+
+	ret = eth_get_ops(dev)->start(dev);
+	if (ret >= 0) {
+		priv->state = ETH_STATE_ACTIVE;
+		priv->running = true;
+		ret = 0;
+	}
+
+	return ret;
+}
+
 int eth_init(void)
 {
 	struct udevice *current = NULL;
@@ -328,20 +349,11 @@ int eth_init(void)
 		if (current) {
 			debug("Trying %s\n", current->name);
 
-			if (device_active(current)) {
-				ret = eth_get_ops(current)->start(current);
-				if (ret >= 0) {
-					struct eth_device_priv *priv =
-						dev_get_uclass_priv(current);
-
-					priv->state = ETH_STATE_ACTIVE;
-					priv->running = true;
-					ret = 0;
-					goto end;
-				}
-			} else {
+			ret = eth_start_udev(current);
+			if (ret < 0)
 				ret = eth_errno;
-			}
+			else
+				goto end;
 
 			debug("FAIL\n");
 		} else {
-- 
2.40.1

