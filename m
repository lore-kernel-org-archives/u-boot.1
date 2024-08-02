Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31087C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 16:28:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 450AF88BC1;
	Fri,  2 Aug 2024 18:28:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qu58guLI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56C0888BDB; Fri,  2 Aug 2024 18:28:16 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2290A88BC8
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 18:28:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-428035c0bb2so19690315e9.1
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 09:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722616093; x=1723220893; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mEyqG+Iht4weR7bZeLnJvJAHCYj/ay4Bd8uorlogBVo=;
 b=qu58guLIQtsgfeyVMBhRhGuwDWJcpRsZLYD7FAX7U2psEI/UjiHtc8QlKOld7JCOqK
 DkAmmcF/u2zoaJBPr1Madn8jC1Lql8GlUQMw7Yu/roajBBG9pR29Z1PQzLFRKhkJaW5i
 ph6kD5v4A8cQZGI0U6yw7m3fhVoJSlVx53r5NB6lSUrVlANICWuLu8ackr1bVj/KxBWp
 axc4aG/Y/Q+gAgO7Gf8LtZ0gvxCDfvtwOHveyYYWTcVAFMFFgmHFZUpPvonRtkf0NEdo
 tiOG+CWM5Qgunqbgnlbn1GK3yD8efM5bj1mqiV9OgeF4Hkd5dcHrAEA37EmfGpOPhmbI
 0bag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722616093; x=1723220893;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mEyqG+Iht4weR7bZeLnJvJAHCYj/ay4Bd8uorlogBVo=;
 b=UQPmxeWD8x2IisNCwYx21UfJUEJCFUtY2sNKnqUbM6/KXh/A+a6PLK2+BnfpCss6/z
 sF9aTEX9HoXfJxx3SWf8MJAPfqhdMu/ZjXjCIFNaly5K17SdcxhVI2ROeHT0ZZvWG+2R
 3hlKJwMfBJlTz9KVM447TSSe1cNkjP3hU68Acj8Qhvl23CM/rWLq81cMODZcqENR9xWq
 00m0ec3zmi4ffhut1MD/b/WnmhxQAApmQI6kFzZUWywyUX25C3AI4ky0O1xA4C53kXh5
 QKM4P97Rk70sGB6TezXIEwSJPj9dn8FNj49I5BYRqyr8RM0RR9sS5w2x+rk3luZSovGp
 dX2w==
X-Gm-Message-State: AOJu0Yy3LYf8SVPzUz6YXS7wx9uERPnV0MEisSfToGyR/OXPqZzoM6Ig
 tADk9Vt5mtbN5yD8vT/ETv0WQA37oTc/vRzYwFUMAw/vNNejlEXckRkO5+nyNrYbxqXpM+wEfrP
 lH8J27HZO
X-Google-Smtp-Source: AGHT+IEEUrgdD0i1nNUWIAtl3ZUvY5SZ0FgLN2y5yPKZ5TNcvuW3fcG60E6xtB7eWpf4VHXHuLdnIw==
X-Received: by 2002:a5d:5f44:0:b0:366:e9f5:781b with SMTP id
 ffacd0b85a97d-36bbbe75257mr3778483f8f.21.1722616093321; 
 Fri, 02 Aug 2024 09:28:13 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:4fc9:a3ab:c134:cdf4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbd01b5c4sm2297783f8f.42.2024.08.02.09.28.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 09:28:13 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 William Zhang <william.zhang@broadcom.com>,
 Michal Simek <michal.simek@amd.com>, Fabio Estevam <festevam@denx.de>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v7 06/20] net: eth-uclass: add function eth_start_udev()
Date: Fri,  2 Aug 2024 18:26:33 +0200
Message-Id: <6acf4577ea274e0856fe2095876950c7ff035941.1722615735.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1722615735.git.jerome.forissier@linaro.org>
References: <cover.1722615735.git.jerome.forissier@linaro.org>
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

