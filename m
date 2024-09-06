Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70105CE7B05
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 12:35:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91AEC88CE7;
	Fri,  6 Sep 2024 14:35:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NGRbMf2t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CB4D88BD6; Fri,  6 Sep 2024 14:34:59 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 966D988CE1
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 14:34:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42bbf138477so17066965e9.2
 for <u-boot@lists.denx.de>; Fri, 06 Sep 2024 05:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725626096; x=1726230896; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wtwVMuEzOP8lc4QJC9T85h8R/u1XDZ+aMqfgZujkeKA=;
 b=NGRbMf2tXtf295sYiPEti7qYDUTHD1RCsYNmmf12Hx+LKLEWa/ceRMyWxasy+snyV7
 HEs0EPOiBloNHoFlVAB8plMHgj2pZPdXbiF3MMD8LQapNpptYRwront3iX/PXI5GfG7D
 fD2HitJXKsA3DScTdv1hGdpV4ZB1zRz+WV2/0iHMtmQD6PvF8fx1z9M+gRZNLzBxxbED
 kFApFwbEADULs7mRrO4kY+RJcgTGqWeXSk3BI0lVaEGWQF5KWaSZLa3m/UirZSN/GDpw
 ezBGHiHF3zXEEyY1j+23z7S9lKVK2GIk0LGNQ36ggs41YBBpZLyQJhBZ5tVb5b/cXdZp
 GZcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725626096; x=1726230896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wtwVMuEzOP8lc4QJC9T85h8R/u1XDZ+aMqfgZujkeKA=;
 b=A0r8MPQeIBotS+FCCPHLqbVXO43ulghYMpn2mgsA1zl7LukQcQJ8SkgfWIN6nhbCsE
 mISYhodzwLffoIAu2Q3erGwJs9Z783Y+/iDRKRBV39UayOGWl9IRd2UMxAFmyylvlwJe
 rSO3/rikCtkxukoWVCNB+uD30N6tkpALyW8Lqx+Fp34OC8BXza4QtjkI3iaavV+JJc3H
 0Qnu0BUm6wJeZLuISSnO8iEI2EmOSuISKppsw6mbJ5/oN95y/gQMD1pen4haS6dORFrV
 9e5Jd70G5gkeCXyrVSFVI0m7v8HWQO2kO7GU+zSBme8WSXw9fqOm+j3nGBGoeG9zXdsJ
 4FXQ==
X-Gm-Message-State: AOJu0YxKVqsl1Tc4XfMSEknZKM5xWZoAGajYCqqr6FLaLsqA4Hp7vVvm
 JTooiWXiNYNql1GAvEnXegNb4YHlwudLQJkoBRMs24tNnB+ptZhnMoXOXL+g27utTq50SnLiiB8
 EKXkKGdky
X-Google-Smtp-Source: AGHT+IEr1TjUqBawrbLjXop5eqhXn/mzA8DVRdrzwwJI3/vpfZyEpVKk71aQvq76p0f0w1mvl/fU/A==
X-Received: by 2002:a05:600c:3516:b0:426:5269:983a with SMTP id
 5b1f17b1804b1-42c9f984be6mr17842795e9.8.1725626095858; 
 Fri, 06 Sep 2024 05:34:55 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:1ff1:215c:d8a4:9f99])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ca05cf0e8sm19640125e9.27.2024.09.06.05.34.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 05:34:55 -0700 (PDT)
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
 Michal Simek <michal.simek@amd.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Fabio Estevam <festevam@denx.de>
Subject: [PATCH v10 06/25] net: eth-uclass: add function eth_start_udev()
Date: Fri,  6 Sep 2024 14:33:22 +0200
Message-Id: <876e9fc7b015d534c96ea20253525cc220b7414c.1725625913.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1725625913.git.jerome.forissier@linaro.org>
References: <cover.1725625913.git.jerome.forissier@linaro.org>
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
index 26674ec7e90..68963a3e9ac 100644
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

