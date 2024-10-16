Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E751D1AD3E
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 10:05:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5FDF88FAF;
	Wed, 16 Oct 2024 12:04:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xmS1GzFs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B09F688FAF; Wed, 16 Oct 2024 12:04:51 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B16F88FF1
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 12:04:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4314311959aso12676575e9.1
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 03:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729073085; x=1729677885; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vlz3ngfSd00AiIHBl1lrcajvkbsIxEryhXrcWbIeGOM=;
 b=xmS1GzFsiAPkfcJH/AW3oWcAVn6iuAw1Fgf4S5y1B5qdqESlpwTUPW+osuKrZ1eFgn
 DB6TWzkC4ay6wUls3+KfviGGrx5rjOTWhpES/vm4wduUL3Fns7erximQ/2xfySA/92YP
 pbredQhl5Dd1MVn0N6Djhwfm61JSJLhTPA3/0JZhOG0UEFuq2Y07QGUy6V6fLPqcGjML
 SBrVYhCOYVnIABFtcXHqgUF3+w6nikmoIzZuHGFImeqITk0IPmM1EpGvoPYLKUKoKwpR
 wP0oy5OSVOghWBAYKtoGvPP4q8foO8EM7BA+o4hra81FXy0keu4NTDJD4WUY7hDd8yh6
 pmAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729073085; x=1729677885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vlz3ngfSd00AiIHBl1lrcajvkbsIxEryhXrcWbIeGOM=;
 b=WknUQyXs4BSTIJ1AN0rpi/kJZwL3MwgtLfN7tpMAtsnU0KN/F4afNETrfRGg/DXTJg
 Tpa65DJENzLVoNRJJVxgHSsabD9nfay7+5srs4nxpkc1I3zPD7+lqyFJqp3+97ARRLk1
 bl+qbo36FF2+k/4dpEkKjUVElzJEWDSuWekB/Ztkgs7WavKdOkE4sjEeQAhOCFxPxhxx
 X0P5ivsdUFz5tK8zf2PCyaZCxvAOljJ7vpAyAgw4TqZ99qPjc1mhnqekqpHuH0Tc338g
 /9kJV0We/u3X95DNv/OtvfuE9sHEVIsA9LLINo9aDeRc33LQKKGM1YTJKh3WeLfSRTsl
 4kqA==
X-Gm-Message-State: AOJu0YxmgYoeLhAgNII5jcedUg5PMHXIdocrWNPGSk7Q3Mia4MlDLXZ7
 oER4NxCUHhvqODr1A52PwY9Cj+G2h3rnwtc/1jDseoEwsWMpGx633GXxzaimtqN/IQ0QbablRqn
 DDmMq7Mmo
X-Google-Smtp-Source: AGHT+IE56srWb5idBu5qCzhOIeAY3Gr4bjAZsbXEdJX++VwmEOImQedtpbX3Ja4VQy3TB5IGKZoXQg==
X-Received: by 2002:a05:600c:190f:b0:431:251a:9dc9 with SMTP id
 5b1f17b1804b1-431256099fdmr127017025e9.25.1729073085266; 
 Wed, 16 Oct 2024 03:04:45 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6417:8cf6:a7f7:ee38])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4313f56f241sm44634515e9.22.2024.10.16.03.04.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 03:04:44 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, Fabio Estevam <festevam@denx.de>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Michal Simek <michal.simek@amd.com>
Subject: [PATCH v13 07/21] net: eth-uclass: add function eth_start_udev()
Date: Wed, 16 Oct 2024 12:04:01 +0200
Message-Id: <c3e956e94127fb826afbfd8218257626a156e371.1729070678.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1729070678.git.jerome.forissier@linaro.org>
References: <cover.1729070678.git.jerome.forissier@linaro.org>
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

