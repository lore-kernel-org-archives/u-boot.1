Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE32C4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 08:02:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0418089136;
	Fri, 26 Apr 2024 10:02:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=tq-group.com header.i=@tq-group.com header.b="Y45efIPD";
	dkim=fail reason="key not found in DNS" (0-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="N9fE+yKZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F6C68913D; Fri, 26 Apr 2024 10:02:49 +0200 (CEST)
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 845D889139
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 10:02:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=matthias.schiffer@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
 t=1714118566; x=1745654566;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=WmsrqWFmE3CyPLWQW7cOuqj6tBY9xE8lf8jDl87gQcQ=;
 b=Y45efIPDppYK2DKXA37PFVsbR3o2WFYoP3eCETVCFrn+azintCiqNUdy
 YNsV0m5Z1lIQULMsElil1nLKTZd1sa4Utm5Wh1LIy+hxtZSE7AR9YdPTv
 2toFMiFIX+h+oPL+iI5KAg8Vz9Z4A/AE78q8tPbGqEHVCIRmFPpMsllcU
 gENQKWWOJGv284nd6otoJ3S6oKRgyXtDoEdTeVStrI/Jx4VAN5E5XM1DO
 vjjcOUEAGrUx1O5IWz9RnfX2lGY23R7WQTyYiB9jxfSABg9jUfTbERcaY
 auTSAGqbxI3p3ZNp3s7p/YO7mUiMD9UvCtArf7k7YwCSuT/lJo87JbERF A==;
X-IronPort-AV: E=Sophos;i="6.07,231,1708383600"; d="scan'208";a="36629234"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
 by mx1.tq-group.com with ESMTP; 26 Apr 2024 10:02:45 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C5D8E16E982; Fri, 26 Apr 2024 10:02:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
 s=dkim; t=1714118561;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=WmsrqWFmE3CyPLWQW7cOuqj6tBY9xE8lf8jDl87gQcQ=;
 b=N9fE+yKZSMCX4qTZ++Pgw2DKy6QiaO4ztOgBCSVXSJaBAyQjlAHeEzO9EaAPPzmxCkBtgw
 qpMQwFVZtF4aQF9aDSuHou2fuxOfhewiG/W3VMUMCDQgG/RAWvmAKdrweLr+IbCSRdSZ/n
 4H1GejhgZ0EormUEJV2Wond+UDUEq3pMGX5UK/lX6ls3QnBL5fB0SSw0slw8MfyC+tgs/y
 Gj4b0EjGneiiRRiejsWxI2QsJ/3mPM6sX4BzqTB7V3Imaa3+JmRg35AHJhqYWQD/jDy2cP
 4OaDVZlq2Ryzxo9O3gnPcb7Jvo6Q6AjT+5WcMvtovq2AetQAoHmI3U85tl8Nlg==
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, MD Danish Anwar <danishanwar@ti.com>,
 Jai Luthra <j-luthra@ti.com>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Nishanth Menon <nm@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Suman Anna <s-anna@ti.com>
Cc: u-boot@lists.denx.de, u-boot@ew.tq-group.com,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 1/5] net: eth-uclass: guard against reentrant
 eth_init()/eth_halt() calls
Date: Fri, 26 Apr 2024 10:02:24 +0200
Message-ID: <de7fe2da7ae4a85252d63904fae61585e4641936.1714117337.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

With netconsole, any log message can result in an eth_init(), possibly
causing an reentrant call into eth_init() if a driver's ops print
anything:

    eth_init() -> driver.start() -> printf() -> netconsole -> eth_init()
    eth_halt() -> driver.stop() -> printf() -> netconsole -> eth_init()

Rather than expecting every single Ethernet driver to handle this case,
prevent the reentrant calls in eth_init() and eth_halt().

The issue was noticed on an AM62x board, where a bootm after
simultaneous netconsole and TFTP would result in a crash.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 net/eth-uclass.c | 40 ++++++++++++++++++++++++++++++++--------
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/net/eth-uclass.c b/net/eth-uclass.c
index 3d0ec91dfa4..193218a328b 100644
--- a/net/eth-uclass.c
+++ b/net/eth-uclass.c
@@ -48,6 +48,8 @@ struct eth_uclass_priv {
 
 /* eth_errno - This stores the most recent failure code from DM functions */
 static int eth_errno;
+/* Are we currently in eth_init() or eth_halt()? */
+static bool in_init_halt;
 
 /* board-specific Ethernet Interface initializations. */
 __weak int board_interface_eth_init(struct udevice *dev,
@@ -285,11 +287,19 @@ U_BOOT_ENV_CALLBACK(ethaddr, on_ethaddr);
 
 int eth_init(void)
 {
-	char *ethact = env_get("ethact");
-	char *ethrotate = env_get("ethrotate");
 	struct udevice *current = NULL;
 	struct udevice *old_current;
 	int ret = -ENODEV;
+	char *ethrotate;
+	char *ethact;
+
+	if (in_init_halt)
+		return -EBUSY;
+
+	in_init_halt = true;
+
+	ethact = env_get("ethact");
+	ethrotate = env_get("ethrotate");
 
 	/*
 	 * When 'ethrotate' variable is set to 'no' and 'ethact' variable
@@ -298,8 +308,10 @@ int eth_init(void)
 	if ((ethrotate != NULL) && (strcmp(ethrotate, "no") == 0)) {
 		if (ethact) {
 			current = eth_get_dev_by_name(ethact);
-			if (!current)
-				return -EINVAL;
+			if (!current) {
+				ret = -EINVAL;
+				goto end;
+			}
 		}
 	}
 
@@ -307,7 +319,8 @@ int eth_init(void)
 		current = eth_get_dev();
 		if (!current) {
 			log_err("No ethernet found.\n");
-			return -ENODEV;
+			ret = -ENODEV;
+			goto end;
 		}
 	}
 
@@ -324,7 +337,8 @@ int eth_init(void)
 
 					priv->state = ETH_STATE_ACTIVE;
 					priv->running = true;
-					return 0;
+					ret = 0;
+					goto end;
 				}
 			} else {
 				ret = eth_errno;
@@ -344,6 +358,8 @@ int eth_init(void)
 		current = eth_get_dev();
 	} while (old_current != current);
 
+end:
+	in_init_halt = false;
 	return ret;
 }
 
@@ -352,17 +368,25 @@ void eth_halt(void)
 	struct udevice *current;
 	struct eth_device_priv *priv;
 
+	if (in_init_halt)
+		return;
+
+	in_init_halt = true;
+
 	current = eth_get_dev();
 	if (!current)
-		return;
+		goto end;
 
 	priv = dev_get_uclass_priv(current);
 	if (!priv || !priv->running)
-		return;
+		goto end;
 
 	eth_get_ops(current)->stop(current);
 	priv->state = ETH_STATE_PASSIVE;
 	priv->running = false;
+
+end:
+	in_init_halt = false;
 }
 
 int eth_is_active(struct udevice *dev)
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

