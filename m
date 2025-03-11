Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18DD9C28B2F
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 16:49:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A93F819B1;
	Tue, 11 Mar 2025 17:48:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eESBNYV3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 205CF81197; Tue, 11 Mar 2025 17:48:10 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1EEE8186D
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 17:48:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-223a7065ff8so14309625ad.0
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 09:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741711686; x=1742316486; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pdvjil9kCPP/Tasdb3O69fPR/VtpdsA5e+2kJ6S4bsM=;
 b=eESBNYV3zZspNG1k0wxVeMl/ejFdJkJR+W+F8P/3ncJnxUGUljkAQ6DYJzk6WbHQme
 kg0mtRyH7/puOGyAIcEaGXmW64IAc6DqEnNTUb303J1iQEnKpSN4U3tW6zAR2yCjH+s2
 STghzfSw54aaRO7hbwo/tIz9ntFgj4bZiUIbycRg5xhmpeHW2RlJwvMcIbRmA2c1rkKF
 YOFarUNFcJdXy+7TfXtqnnudXaNokT7HmU/SYE8DQzfumb1gqW+fsqPcYQjgbAGpqhkb
 VCBKyzuonfUfwHAcE39JYITHBJ4Z/ua1a8x26tfY0iEywZTuOLRxfNaIksjrwElqT3ir
 cYug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741711686; x=1742316486;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pdvjil9kCPP/Tasdb3O69fPR/VtpdsA5e+2kJ6S4bsM=;
 b=vg3z+Sr51j6jG1EE4NOXLnvyVWm9XQIbtbziID/GUATtH/ZTgRtf/kn80epytmP3kZ
 28f3LpxId2TX+aj9SwtxASABfoCTWOd6mJoAmWp0wjr7RaW1/mgKIRt2/FzI/eSn5Riz
 2Top0js4GfJGmhvIsoHBdllmGBQ8C4fCO2qqKPW4IVWDQdOHjjEIGOFF8sh3/mPn+Sr+
 PfAWKJUMMX0eOGhKVzVq+BFYpN3LmG0ycfXwwfbLEEJ5ryf4toDCLEKgqDc6gP7Z7yIT
 Hhg3+wTost8Fkrfpp4WGCVq/W28Qx8CxDPaorWa/u5jTQCdpQb54MOw7IOsBRwTCE2mg
 nJhQ==
X-Gm-Message-State: AOJu0YzHXLftof4p2ZbUmf/AxVLzjqRu0begbwUVxNJTDwf4feJnTSwU
 11XcanyZbCFufCqxsZ4q3k0wh/N7tKA1AHTFs49WtaLilqcQqzJ764ULX3MrI1M=
X-Gm-Gg: ASbGncuAaYo4VREMYEzwCV23esSzziDr72JDF5Ced4XXa8BY4Gq1YDkulZqFJ1/hlFR
 TVBn38mHeFeF8amrJlJoANittnr4DLurpBr8g8zyBLzWGkb8FVALBQBKdZZknWs4kp6/srLM1Q+
 mkHKBTtROqvpusonR2vFsqYxlynpWvIeoRQKER90gj9T1/eaEPEN8WroW2u4QSK0HJE2jMDP6Sy
 3KAYom9rVual+04UXP4ql9x6XAcnHF18OhsH2jBe7ynobDQCXQD/AcwiehWjOw+YW7NdDtaKbQ3
 i1/FBD1rTJf47E7Zw1uzh1mgGO3fWbAmaeHtOf+7aGWBHUo25BlFr8w=
X-Google-Smtp-Source: AGHT+IF7ptCwnGwt6OD47IrmTW2+8/Sl3uhlg+zpu5x8pKkMTFHbcNdS0sFPiCu3jgtWULY+2avwfQ==
X-Received: by 2002:a05:6a00:4b11:b0:736:42a8:a742 with SMTP id
 d2e1a72fcca58-736aa9fe534mr25792263b3a.11.1741711686283; 
 Tue, 11 Mar 2025 09:48:06 -0700 (PDT)
Received: from adriano.. ([190.215.89.187]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736bf09ae2bsm6941749b3a.74.2025.03.11.09.48.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 09:48:06 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, =trini@konsulko.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 07/16] eth_uclass: Add eth_create_device to create a net
 udevice
Date: Tue, 11 Mar 2025 13:47:49 -0300
Message-ID: <20250311164758.421900-8-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311164758.421900-1-adriano.cordova@canonical.com>
References: <20250311164758.421900-1-adriano.cordova@canonical.com>
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

This comes in preparation to support calling connect_controller with a
handle with the efi_simple_network_protocol installed.

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---
 include/net-common.h |  2 ++
 net/eth-uclass.c     | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/include/net-common.h b/include/net-common.h
index 1d507b13b06..ba343af4c66 100644
--- a/include/net-common.h
+++ b/include/net-common.h
@@ -203,6 +203,8 @@ int eth_receive(void *packet, int length); /* Receive a packet*/
 extern void (*push_packet)(void *packet, int length);
 #endif
 int eth_rx(void);			/* Check for received packets */
+int eth_create_device(struct udevice *parent, const char *drv_name,
+		      const char *name, struct udevice **devp);
 
 /**
  * reset_phy() - Reset the Ethernet PHY
diff --git a/net/eth-uclass.c b/net/eth-uclass.c
index 5555f82f23e..952df419b70 100644
--- a/net/eth-uclass.c
+++ b/net/eth-uclass.c
@@ -12,10 +12,12 @@
 #include <dm.h>
 #include <env.h>
 #include <log.h>
+#include <malloc.h>
 #include <net.h>
 #include <nvmem.h>
 #include <asm/global_data.h>
 #include <dm/device-internal.h>
+#include <dm/lists.h>
 #include <dm/uclass-internal.h>
 #include <net/pcap.h>
 #include "eth_internal.h"
@@ -528,6 +530,36 @@ int eth_initialize(void)
 	return num_devices;
 }
 
+int eth_create_device(struct udevice *parent, const char *drv_name,
+		      const char *name, struct udevice **devp)
+{
+	char temp[40], *str;
+	int devnum;
+	struct uclass *uc;
+	int ret;
+
+	ret = uclass_get(UCLASS_ETH, &uc);
+	if (ret)
+		return -1;
+
+	devnum = uclass_find_next_free_seq(uc);
+	if (devnum < 0)
+		return -1;
+
+	snprintf(temp, sizeof(temp), "%s_eth%d", name, devnum);
+	temp[sizeof(temp) - 1] = '\0';
+	str = strdup(temp);
+
+	ret = device_bind_driver(parent, drv_name, str, devp);
+	if (ret) {
+		free(str);
+		return ret;
+	}
+	device_set_name_alloced(*devp);
+
+	return 0;
+}
+
 static int eth_post_bind(struct udevice *dev)
 {
 	struct eth_uclass_priv *priv = uclass_get_priv(dev->uclass);
-- 
2.48.1

