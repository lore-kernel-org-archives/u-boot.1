Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1C0CC4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 14:11:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D45287D0E;
	Wed,  1 Nov 2023 15:11:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="pJmEc2/p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACBE687BF3; Wed,  1 Nov 2023 14:49:21 +0100 (CET)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBBB987701
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 14:49:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 08DB3120032;
 Wed,  1 Nov 2023 16:49:16 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 08DB3120032
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1698846556;
 bh=+R/p8f3ok8XI4EAC5nPaFL4DHpRPUotN9l/T1Kg7F4Y=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=pJmEc2/p0Hl7j4oKtE9X/l5CoxgRf7KkV/eWcZubBt0SGdFXCH1bWUdXeo72VSKPj
 fDGbiXXVhZjv2NUDYbGRWZ3rRyJVAduYP6kXUXOMgBxBozbgQLsUuMAbcCl+JcHTfm
 xlYBgvm2Ma2mqxzFeBeE/gRcEdPB6QITc8ya6GpuBq+AmwYFyeAa9qxyCVpEb4FZJc
 AHn2JQClQmnJ0IF4QHdivbmlHgqjpV14olIewPQE8a/9gz+0Ccx6z3WSLpLiuLY1SW
 so5dFomC5pMqgqJEcIBWhW524515hlS+qIWdemo/d1I6kLWWqisp79tDChJaVvEJB0
 066VfuSYfCfbg==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Wed,  1 Nov 2023 16:49:15 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Wed, 1 Nov 2023 16:49:15 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: <sughosh.ganu@linaro.org>, <xypron.glpk@gmx.de>, <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <kernel@sberdevices.ru>, Alexey Romanov
 <avromanov@salutedevices.com>
Subject: [PATCH v1] rng: add dm_rng_read_default() helper
Date: Wed, 1 Nov 2023 16:49:02 +0300
Message-ID: <20231101134907.8405-1-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181049 [Nov 01 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 543 543
 1e3516af5cdd92079dfeb0e292c8747a62cb1ee4,
 {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;
 p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1; 100.64.160.123:7.1.2;
 127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2023/11/01 06:18:00 #22376334
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Wed, 01 Nov 2023 15:11:11 +0100
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

Add dm_rng_read_default() function, which obtain a series
of random bytes. In some cases, such function would be
useful because it allows the caller to abstract away from
RNG device.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
---
 drivers/rng/rng-uclass.c | 20 ++++++++++++++++++++
 include/rng.h            | 10 ++++++++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/rng/rng-uclass.c b/drivers/rng/rng-uclass.c
index 53108e1b31..3a8fb7d276 100644
--- a/drivers/rng/rng-uclass.c
+++ b/drivers/rng/rng-uclass.c
@@ -19,6 +19,26 @@ int dm_rng_read(struct udevice *dev, void *buffer, size_t size)
 	return ops->read(dev, buffer, size);
 }
 
+int dm_rng_read_default(void *buffer, size_t size)
+{
+	struct udevice *rng;
+	int ret;
+
+	ret = uclass_get_device(UCLASS_RNG, 0, &rng);
+	if (ret) {
+		pr_err("Can't get RNG device (%d)\n", ret);
+		return ret;
+	}
+
+	ret = dm_rng_read(rng, buffer, size);
+	if (ret) {
+		pr_err("Can't read from RNG device (%d)\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 UCLASS_DRIVER(rng) = {
 	.name = "rng",
 	.id = UCLASS_RNG,
diff --git a/include/rng.h b/include/rng.h
index 37af554363..5537daae88 100644
--- a/include/rng.h
+++ b/include/rng.h
@@ -20,6 +20,16 @@ struct udevice;
  */
 int dm_rng_read(struct udevice *dev, void *buffer, size_t size);
 
+/**
+ * dm_rng_read_default() - same as dm_rng_read(), except that caller
+ * don't need to pass an argument with RNG udevice.
+ * @buffer:	input buffer to put the read random seed into
+ * @size:	number of bytes of random seed read
+ *
+ * Return: 0 if OK, -ve on error
+ */
+int dm_rng_read_default(void *buffer, size_t size);
+
 /**
  * struct dm_rng_ops - operations for the hwrng uclass
  *
-- 
2.25.1

