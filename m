Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60BEACEDDA4
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 14:50:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 837A288DC6;
	Wed,  9 Oct 2024 16:50:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XxVneWHK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0452188DC6; Wed,  9 Oct 2024 16:50:20 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 146C088DC1
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 16:50:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-42cae6bb895so70880035e9.1
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 07:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728485415; x=1729090215; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vlz3ngfSd00AiIHBl1lrcajvkbsIxEryhXrcWbIeGOM=;
 b=XxVneWHKE/MiSrsgccSoqVMlVhZavYeAmG2K+Fcykj1m9o7pLcuV9qcVH2ZHo8a0Bz
 TN6JXfD/Xu3TZ/nbH4Jzgf7vt/AwsbkRihPL+0xqkz311fcjfmZpcQHvCEecM8pIPrKr
 CixTU4VVeGMLZVNeQElAJux5yh5p/N29aM6QltldnmV6Ksx13b6O0Gy0aUOlF1nWbhHw
 CuCyBB5vwjl1+lJmSWB6K4ujPD5cFb+etCf8zjh0EmKeflTrTJyOiG8O3YXScYPKYGrV
 BT5UqHPugSVUvlHkkT6YHlwerDMfC13q9WWy7NzeZ5XebWiC/LuUB0W9Ymi2nWk9mnux
 LfuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728485415; x=1729090215;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vlz3ngfSd00AiIHBl1lrcajvkbsIxEryhXrcWbIeGOM=;
 b=skU0ayXivXMozeUsyGNqMH8bvch9x0rnevpjOsm9jzfWDsngnNUHzfO+x9EpAqOBmv
 5PxFjj3pUDmHIDFvruY0sa8MpBsssTQQlax2ZNzQnRxSgZMyG5AuTOt14uZvxyEMHj1R
 th78f79wkobldj0YaGpbWrr4iXYsnxPL+SmxswZI9MbeW1g+arO+uRH+j7YzAgver+4f
 Vv8yrWxGTltY6Ly2fnbqlKny/G6iN8s8niAV5GYUsdoKgRh8Y4UIcvwJAia2zJdpKyeC
 vLXOTvW54usV1QxAAm30EzvGrXU4xOhS4WGCJIaOmqehlPfrTuBUWFMMQUQHVskmlSjX
 pJdg==
X-Gm-Message-State: AOJu0YyTfhwjiqqNhVyxuVQdtIgkGnW+blshUqT4RHrqojcGh4Nsa9ZB
 s6En5wzhUZdyqrhHj3LetKmb4mpZ4m6mxJEukqgQDzdoFmYIkza8t3qGKaMNJ/9nOP26pB502E3
 VoJaPdeiI
X-Google-Smtp-Source: AGHT+IEt+VEUFRpaHKEreQbHQFBihfwn62p/dLEvZ75I/s9ZemYcQukZYBMWpHAzbU1wdFN/uRnoPQ==
X-Received: by 2002:adf:ec0e:0:b0:374:bb1b:d8a1 with SMTP id
 ffacd0b85a97d-37d3a9c4233mr1875609f8f.13.1728485415290; 
 Wed, 09 Oct 2024 07:50:15 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:9b46:2ad8:5153:1163])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d1691b5ddsm10700957f8f.47.2024.10.09.07.50.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 07:50:15 -0700 (PDT)
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
 Fabio Estevam <festevam@denx.de>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Michal Simek <michal.simek@amd.com>
Subject: [PATCH v12 07/21] net: eth-uclass: add function eth_start_udev()
Date: Wed,  9 Oct 2024 16:49:48 +0200
Message-Id: <187101dc70678f667fef814e7a98c2ad1076de48.1728482473.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1728482473.git.jerome.forissier@linaro.org>
References: <cover.1728482473.git.jerome.forissier@linaro.org>
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

