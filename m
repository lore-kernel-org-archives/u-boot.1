Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99300CF34B0
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 15:25:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23F7188E19;
	Thu,  3 Oct 2024 17:24:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nr7MaAHN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71E3F88641; Thu,  3 Oct 2024 17:24:24 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E14F488F0A
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 17:24:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-37cd0b5515fso713955f8f.2
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 08:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727969060; x=1728573860; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vlz3ngfSd00AiIHBl1lrcajvkbsIxEryhXrcWbIeGOM=;
 b=nr7MaAHNZGob6yvWy/0WN+TpSDM3RWix1VRU5i+13W8jTja5Wx7UZ+YH2sCzoplZF9
 Wc0oEceINzwwIE6MaXh8LELmZtjsDu6NI1A0axuH7AhQRv6g017E+3Drfu7ZUKhcDOKE
 GolLZeWoFounuhqwM2i9dVxazHyqS5RMj/qOhvWK78xTpxF1cTC4+asweKDweuRca8O5
 X6exeoGKve2HbZ36oIZFDs2YZjucfsStVa0sScND+PvN6PwvZefPxv+8fZAZbHmrL2nB
 vr2EvYEaKrPl2Rj47GVhZLgsv7nwPI8gS1hEMvcsJqN7mytpYQtxcrTEBRoY8SDutU81
 ed5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727969060; x=1728573860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vlz3ngfSd00AiIHBl1lrcajvkbsIxEryhXrcWbIeGOM=;
 b=i9xpbd3wn58KcLigCORy/Q0pgvnnbI4SGvR16zKU/Pkxd4qmo+7sVv+YesdmU6sUx5
 +LoTvcTaRcI2+MJav80QLkoRiaqbRCjbt+k22j21AIx6rCFBs1d9EiQbqBTtvZ4c9uWw
 1CbNpZ5beeW/V7eHoswGB98MHtqIg6llB2skhBBkLWBT1VuNU218uXfMDHiRK0LssiqT
 QIrRel9r2jH5Dj1vigzMUaYBGlcK2eZprCY19GmRwnU+Ww/AXs734SbDoXauXJQvvAIa
 XkmuJkQs/gq6MjlDTWfUJ0cipuEx+l177aUnm+htsj3C1+qqK1t9FFRYNqHIs9DFbk58
 RlPQ==
X-Gm-Message-State: AOJu0YzNDgyPZUqQiRdHvCZKvG0DrFWxNi7SpgdnSZlNsVjQDGtAZIgE
 3X15087anQUAhHVv0wCN9D6QYAo15vYE1r/oEYTHo60/qXJ3YqzX9kDAR7DTNfZzBSTD3RInSUR
 9OObw7rPb
X-Google-Smtp-Source: AGHT+IFyosDBQwSPQeopOJ7ZC6yfeihcPFNCy720OWDePE4s/pl9wPlIWSSFtuJOr7ODS2J1ySHvlg==
X-Received: by 2002:adf:9b96:0:b0:37c:d515:7662 with SMTP id
 ffacd0b85a97d-37cfb8a5d09mr4387712f8f.1.1727969060048; 
 Thu, 03 Oct 2024 08:24:20 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:d888:7a58:deed:47d6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d081f7482sm1506220f8f.8.2024.10.03.08.24.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 08:24:19 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Fabio Estevam <festevam@denx.de>, Michal Simek <michal.simek@amd.com>
Subject: [PATCH v11 11/29] net: eth-uclass: add function eth_start_udev()
Date: Thu,  3 Oct 2024 17:22:57 +0200
Message-Id: <d8af90bf9124a6c04f1ed2d291a99e1e7f909bac.1727968902.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1727968902.git.jerome.forissier@linaro.org>
References: <cover.1727968902.git.jerome.forissier@linaro.org>
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
---
 include/net-common.h |  1 +
 net/eth-uclass.c     | 38 +++++++++++++++++++++++++-------------
 2 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/include/net-common.h b/include/net-common.h
index 543f528a4a4..6bc76658d9d 100644
--- a/include/net-common.h
+++ b/include/net-common.h
@@ -192,6 +192,7 @@ int eth_env_set_enetaddr_by_index(const char *base_name, int index,
 int usb_ether_init(void);
 
 int eth_init(void);			/* Initialize the device */
+int eth_start_udev(struct udevice *dev); /* ->start() if not already running */
 int eth_send(void *packet, int length);	   /* Send a packet */
 #if defined(CONFIG_API) || defined(CONFIG_EFI_LOADER)
 int eth_receive(void *packet, int length); /* Receive a packet*/
diff --git a/net/eth-uclass.c b/net/eth-uclass.c
index e34d7af0229..5555f82f23e 100644
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
+	if (ret < 0)
+		return ret;
+
+	priv->state = ETH_STATE_ACTIVE;
+	priv->running = true;
+
+	return 0;
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
+				break;
 
 			debug("FAIL\n");
 		} else {
-- 
2.40.1

