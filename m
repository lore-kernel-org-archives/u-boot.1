Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A210C52D73
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 17:13:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9639288BFB;
	Wed,  7 Aug 2024 19:13:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vlEuwBK2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14ECB87873; Wed,  7 Aug 2024 19:13:07 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2451588BFB
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 19:13:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-368313809a4so711298f8f.0
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 10:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723050784; x=1723655584; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mEyqG+Iht4weR7bZeLnJvJAHCYj/ay4Bd8uorlogBVo=;
 b=vlEuwBK2tdGzwYSyGnPVWCtAhJWIN1Ug/dFXk8inT3wqTHC+8St8MSG4PsFzqSxK3o
 3HrXAuMFQAZgGou46iC05dgQmCWKVwXwNgpysRSRNrCcbCx+e0AHr2iwRn+AUYDxPuRn
 f57e+Xm6lUxHu2z9bBtpq2zBqJrKBFIY2OSmeJmObhCRq7XbiMqI2aA3KtDexBhqCi7T
 zg0oSyYONX8yaWSGzSomW9EatZ1bulJ6/NwxxYZ385onQtNxZuogM/rsozHfWIqVOASf
 nVV+7kvyRPLsXbBLlJIoVEmrbzqR4Ou+Q9eKjtAKcEdE1r+JrN6/aVcX39LxKZxV5itT
 aWSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723050784; x=1723655584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mEyqG+Iht4weR7bZeLnJvJAHCYj/ay4Bd8uorlogBVo=;
 b=F/wzzEOx9kHsjFQ71wheUVeP530hnID0Rc0X1UPNg99dwLdvvAOMLt0subwkCipQk0
 p3SGqpxPZP4zXLiiHsKpftKZzwYy2p11I1Oyw8a+mOvKS/K56bux6fVONPw1FYQ+ZUJa
 COtcKckbAjqCEpEhQoD0Wwk6uY0KKUVzaVluQaQRpfdKjxK0hSh3nxdt4op8eKTsc71Z
 0ntFkAcVnGdDsFBN+5kCsisp5wTYwGAwHB7eydUvwQ1oStNT5Qv8DGnEmw5Gzc8cfMet
 gW3RefgFXALSP+bzb1IwGYhRqD68PsdvLH56AZuCefRLjBcDTDuxpKfPSOW8IIrwqGOz
 Gkag==
X-Gm-Message-State: AOJu0YwY0/pc/kBeeJHl9xho9f5eHyOnxJcacftTq1Agt50UqfHu04h/
 90jpX6oboqtA5nkSvOpgVOZNzZ4kJWsW+QksZuC4mLAK0KdtnfXEa4roif2Cpj6TmUwyn92ioJm
 f9UpTuyCs
X-Google-Smtp-Source: AGHT+IEZnvWowOtlf87+ad0Z+mXWrcEjXIH9gIlRQ80rZ1272rGxpsB1bDOf9zDKA/TVtF96dhLP6Q==
X-Received: by 2002:a5d:6949:0:b0:366:e9f7:4e73 with SMTP id
 ffacd0b85a97d-36bf0d91f99mr2349676f8f.5.1723050784361; 
 Wed, 07 Aug 2024 10:13:04 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:bb3d:43b8:4780:757c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbd0597b2sm16623781f8f.81.2024.08.07.10.13.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 10:13:03 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 William Zhang <william.zhang@broadcom.com>,
 Fabio Estevam <festevam@denx.de>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>
Subject: [PATCH v8 08/23] net: eth-uclass: add function eth_start_udev()
Date: Wed,  7 Aug 2024 19:11:52 +0200
Message-Id: <3f19edd18294de99119b361528dd2078f884e6db.1723050310.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1723050310.git.jerome.forissier@linaro.org>
References: <cover.1723050310.git.jerome.forissier@linaro.org>
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
index ed6dbbf49fa..518e4889ab5 100644
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

