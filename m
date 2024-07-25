Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A6F5C3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 12:59:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9854F87CEB;
	Thu, 25 Jul 2024 14:58:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DNjJQH2J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7721A87CEB; Thu, 25 Jul 2024 14:58:52 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AD30882BE
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 14:58:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-427cede1e86so7290795e9.0
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 05:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721912328; x=1722517128; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jSxhJAh+xcmIxhFAHlcMOYw5uKJVBcNmalgS9ipvLHI=;
 b=DNjJQH2JzHcq4ps4NKX5wy4CfdFxb8IjCpIHecbA1aY+D8IivXMvMZTiwXXnBbbAsl
 LDYvmEytHCzvXioOXRX85DEGVoJ9paY+iQDihdjMujCyobeYND23G/GtISMRkg45s129
 Mm4f67dT5+6IAYxOfLohPFmGktEPs4HZ3OwCijNvqcRNbtEWPWerhgwVWwZhz9VPa4qr
 99RESKPzl/lv7rRzq1mhia9GgqecLasCGNSv6hi7enGKOFEucukTxGDbCZ/IsrsMwS0Q
 /ZUiJhP9KGiwvJ4uou/8wGBnrsgLiG4G+G9Bqx4KC7tgV7qGZCU27u6x53RKf3KPZe9D
 UUEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721912328; x=1722517128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jSxhJAh+xcmIxhFAHlcMOYw5uKJVBcNmalgS9ipvLHI=;
 b=Ak4UBU9d1jlneWIbdPr8mSDSqoy2RGUbs1jXQtR9rYkztkvou7toUlRQ83x6WlCKTJ
 q6qNUX9T9Y80uNlH/eN4ZKr0id0mM7Y9/CuFtS0PDDIsULcE8M0i6YR2oqVhRwxAdahd
 guwQTenWwDBGb82x2c5xnFdRPV7UHKJlTvvgFryc6dGtgh2J+DOKQEECYaUJKgo3Bope
 xsDC5JTXnJW0R5sWanzCXqsNYJyKORZErh/2vTDiE1HiI5WrR36mxTOe90WP8Q9cdCzA
 o43T3wZuFe3C8dEIY5a5Wclv4iVsEKdb9exPmdH/ri8imJW0dWbFWuQoNOMUI8HmQHD+
 lq6g==
X-Gm-Message-State: AOJu0YyaLnlIQAyrliOwbbFlxsTP2mstRkCgzvQb14/N4fzEI9v3/0WD
 MUTLyH6T8+TOkDzccirzcr2Vy+GAFXFhh77Z5sBE+CM9UHvK/u+9NXxT95l04SbhiiimJ0JLgIf
 nOjB5ww==
X-Google-Smtp-Source: AGHT+IE+nxwDIqC12OaTLKIrJetCQvUi9c8FujpYVnjuqPZAzuLRSOyks1NWGYNiCd+o5v8v+ItB5g==
X-Received: by 2002:a05:600c:5114:b0:426:6eac:8314 with SMTP id
 5b1f17b1804b1-42806b5b906mr15322475e9.1.1721912328493; 
 Thu, 25 Jul 2024 05:58:48 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:a701:ef5f:d613:3e14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4280573fd83sm34765205e9.19.2024.07.25.05.58.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 05:58:48 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>, Fabio Estevam <festevam@denx.de>
Subject: [PATCH v5 06/20] net: eth-uclass: add function eth_start_udev()
Date: Thu, 25 Jul 2024 14:57:27 +0200
Message-Id: <c012639090f4a45f004768b8e7840e3e81867ca1.1721910373.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1721910373.git.jerome.forissier@linaro.org>
References: <cover.1721910373.git.jerome.forissier@linaro.org>
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

Add a function to start a given etwork device, and update eth_init()
to use it.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 include/net-common.h |  1 +
 net/eth-uclass.c     | 38 +++++++++++++++++++++++++-------------
 2 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/include/net-common.h b/include/net-common.h
index 29342b6eee5..b9b47197e4a 100644
--- a/include/net-common.h
+++ b/include/net-common.h
@@ -148,6 +148,7 @@ int eth_env_set_enetaddr_by_index(const char *base_name, int index,
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

