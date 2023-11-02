Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52922C4332F
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 12:58:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1F9B8777A;
	Thu,  2 Nov 2023 13:57:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="PHLu84sI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1B7686CEC; Thu,  2 Nov 2023 10:17:13 +0100 (CET)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 316D28752D
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 10:17:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 99B3E120009;
 Thu,  2 Nov 2023 12:17:08 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 99B3E120009
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1698916628;
 bh=m3S3VWPKFBwQlPhMltB6QkGTl2rZhk9MeubtkWlEOrA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=PHLu84sIk464hQyj9CbA3A3owWpKEa5c7oygye/EFaDFBviwcjLF/+EsmO4jNo4Ea
 CAY7OZOPmzZxqqzDpRC7zTCfncavIOYrEEtOPQJ/PUmAuvE2UB/FyzJMjggla9XW9a
 rSNqKLGABBocgrXxgBEMc5IHw/3L+PNrrk78jeE28NoPn9he+JegXUsYSdFMFEwJca
 zybqN0g5GkY3Ga7+CPDCGQzsUPtvWo9lbIVPU3zeAfyEJPDIptmAFjz1pD4T18bOMc
 oiPEYxQRt5paswKCKVXZYMX4ULzx4xoeGue8DOSF5Gw4J4fq7or2bX5tGwv8H/6+4r
 UhzfJRNw5glSA==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Thu,  2 Nov 2023 12:17:08 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Thu, 2 Nov 2023 12:17:08 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: <sughosh.ganu@linaro.org>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <kernel@sberdevices.ru>, Alexey Romanov
 <avromanov@salutedevices.com>
Subject: [PATCH v2 1/2] rng: move platform_get_rng_device() to rng-uclass.c
Date: Thu, 2 Nov 2023 12:16:44 +0300
Message-ID: <20231102091648.40520-2-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231102091648.40520-1-avromanov@salutedevices.com>
References: <20231102091648.40520-1-avromanov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181068 [Nov 02 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 543 543
 1e3516af5cdd92079dfeb0e292c8747a62cb1ee4,
 {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;
 salutedevices.com:7.1.1; p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;
 100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2023/11/02 06:57:00 #22385341
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Thu, 02 Nov 2023 13:57:39 +0100
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

The correct declaration place for platform_get_rng_device()
function is here. Also, this function is re-implemented to provide
the first successfully probed RNG device.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
---
 drivers/rng/rng-uclass.c | 16 ++++++++++++++++
 include/efi_rng.h        |  2 --
 include/rng.h            | 11 +++++++++++
 lib/efi_loader/efi_rng.c | 27 ---------------------------
 4 files changed, 27 insertions(+), 29 deletions(-)

diff --git a/drivers/rng/rng-uclass.c b/drivers/rng/rng-uclass.c
index 53108e1b31..d7236b9335 100644
--- a/drivers/rng/rng-uclass.c
+++ b/drivers/rng/rng-uclass.c
@@ -9,6 +9,22 @@
 #include <dm.h>
 #include <rng.h>
 
+int platform_get_rng_device(struct udevice **dev)
+{
+	int ret;
+	struct udevice *devp;
+
+	ret = uclass_first_device_check(UCLASS_RNG, &devp);
+	if (ret) {
+		pr_err("Unable to get RNG device (%d)\n", ret);
+		return -ENODEV;
+	}
+
+	*dev = devp;
+
+	return 0;
+}
+
 int dm_rng_read(struct udevice *dev, void *buffer, size_t size)
 {
 	const struct dm_rng_ops *ops = device_get_ops(dev);
diff --git a/include/efi_rng.h b/include/efi_rng.h
index 3c622381cb..f22e54adb0 100644
--- a/include/efi_rng.h
+++ b/include/efi_rng.h
@@ -23,6 +23,4 @@ struct efi_rng_protocol {
 				       efi_uintn_t rng_value_length, uint8_t *rng_value);
 };
 
-efi_status_t platform_get_rng_device(struct udevice **dev);
-
 #endif /* _EFI_RNG_H_ */
diff --git a/include/rng.h b/include/rng.h
index 37af554363..255c85d3e8 100644
--- a/include/rng.h
+++ b/include/rng.h
@@ -20,6 +20,17 @@ struct udevice;
  */
 int dm_rng_read(struct udevice *dev, void *buffer, size_t size);
 
+/**
+ * platform_get_rng_device() - retrieve random number generator
+ *
+ * This function retrieves the first udevice implementing a hardware
+ * random number generator. Device is already probed.
+ *
+ * @dev:	udevice
+ * Return:	status code
+ */
+int platform_get_rng_device(struct udevice **dev);
+
 /**
  * struct dm_rng_ops - operations for the hwrng uclass
  *
diff --git a/lib/efi_loader/efi_rng.c b/lib/efi_loader/efi_rng.c
index bb11d8d0e0..0d8bf770f5 100644
--- a/lib/efi_loader/efi_rng.c
+++ b/lib/efi_loader/efi_rng.c
@@ -17,33 +17,6 @@ DECLARE_GLOBAL_DATA_PTR;
 
 const efi_guid_t efi_guid_rng_protocol = EFI_RNG_PROTOCOL_GUID;
 
-/**
- * platform_get_rng_device() - retrieve random number generator
- *
- * This function retrieves the udevice implementing a hardware random
- * number generator.
- *
- * This function may be overridden if special initialization is needed.
- *
- * @dev:	udevice
- * Return:	status code
- */
-__weak efi_status_t platform_get_rng_device(struct udevice **dev)
-{
-	int ret;
-	struct udevice *devp;
-
-	ret = uclass_get_device(UCLASS_RNG, 0, &devp);
-	if (ret) {
-		debug("Unable to get rng device\n");
-		return EFI_DEVICE_ERROR;
-	}
-
-	*dev = devp;
-
-	return EFI_SUCCESS;
-}
-
 /**
  * rng_getinfo() - get information about random number generation
  *
-- 
2.30.1

