Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 765C5C52D6D
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 13:15:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CBC788BBF;
	Fri,  2 Aug 2024 15:14:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="A9m2t1LA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78D3788B9B; Fri,  2 Aug 2024 15:14:53 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EBB488BB9
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 15:14:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-367ab76d5e1so3358722f8f.3
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 06:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722604491; x=1723209291; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0kc5jErkHDqt4NR8kxa2tZ2WKp4oAlxRMnVV/OhyJiA=;
 b=A9m2t1LA5oZn4jJIqlXu0wzEqTx+7Z+A8SXZG95ypW7AZb45DWouRbtsrfmD0M4v/S
 fWd34fmyKoYHAT/eSzHbt4gmD5VGkabW4IQtQ634CD5xGw6W+8QiZyJ73hVPpmh7liHB
 nbCaQGrC/027I2vfX8UV3OelV016Y/cdOBoN2X1BmDRp82OsvFvY/G3PoAuZ0xne06Sd
 aPB+LdoWDUFLHiWqapTWhvABkLJQR347NPli+EA+BaLRBc1xRSod0T9fjZXRlIFuG2XY
 WqqF4QuTNdAPpDTWb8286EUPtxJ3HtgNCtv2RTttRo9muLfCeN1v0D0O7AZTMFMYhS3A
 5Kmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722604491; x=1723209291;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0kc5jErkHDqt4NR8kxa2tZ2WKp4oAlxRMnVV/OhyJiA=;
 b=RM2jKKPDf7/ztRYnKvGaEsoQwL5gsxJDvKLHk1DMjueFFEApBwFZmVNzEQf9SRypiu
 MafFSaWgP7JCrkideHKXCxgOislCyKyIF+q4EyX96Bo5wZJcUG9Y/waamdwED4vSuGkj
 qO17G1w7QyxOcobujI1Ci7dQ3dFn8rYmpv0Z0ubBee9xtBdiO7hHIbAfWIeAoFCYZVUL
 ABVSddXCBCJ0nYHvDlcyKoTffhj6+1yPSLeP940jaKAqT1CqBywcXXBSNgboCNbW2Rt9
 iMEE6xK48XthctGzMzUUlYXwhYel5PINsoNaf/FY2F6P4a+jxcEvuudpHhpQeIOC9Wxa
 Pg2Q==
X-Gm-Message-State: AOJu0Yz8BW27To/MI6x/MeNY/EhJjSn5zoKC6ArsftyTFJa+MzAcL0+J
 rb5BVnRErpp0cLB1WCtgI9V/5//RO7RiORPw4VZOKPgYxr5ztdm332mh1KWyxplwBfxA5cdI/EF
 farH0rkGw
X-Google-Smtp-Source: AGHT+IHlni+ZXJhTntYsk8lFulHIrzJyNRasTLeemybX4uYrnoJcvsHxfINBaD1rbe3FdEaWRNfnsQ==
X-Received: by 2002:a5d:4d89:0:b0:360:791c:aff2 with SMTP id
 ffacd0b85a97d-36bbc171338mr2110492f8f.47.1722604490798; 
 Fri, 02 Aug 2024 06:14:50 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:4fc9:a3ab:c134:cdf4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbcf0cc58sm1970304f8f.2.2024.08.02.06.14.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 06:14:50 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 William Zhang <william.zhang@broadcom.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Michal Simek <michal.simek@amd.com>, Fabio Estevam <festevam@denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v6 06/20] net: eth-uclass: add function eth_start_udev()
Date: Fri,  2 Aug 2024 15:13:53 +0200
Message-Id: <d5fb829e251e39690614cf3be684fec5769cb117.1722601509.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1722601509.git.jerome.forissier@linaro.org>
References: <cover.1722601509.git.jerome.forissier@linaro.org>
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
index 0c294ad79f1..4f000368609 100644
--- a/include/net-common.h
+++ b/include/net-common.h
@@ -149,6 +149,7 @@ int eth_env_set_enetaddr_by_index(const char *base_name, int index,
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

