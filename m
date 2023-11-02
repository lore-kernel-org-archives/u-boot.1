Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1CC7C4167B
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 12:57:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C47E87772;
	Thu,  2 Nov 2023 13:57:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="PWa7o6ba";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5208875C5; Thu,  2 Nov 2023 10:17:12 +0100 (CET)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD80C86CEC
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 10:17:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 5600210002F;
 Thu,  2 Nov 2023 12:17:10 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 5600210002F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1698916630;
 bh=0e522WdQ88bql7267bwD2OWLhNscuky6CVKshKyNG2Y=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=PWa7o6baeBu/fwhvEgdHzKQzoLSVHkKPn94gOWYgKtEIE1lfn+aHMp5mD9Webc1rC
 /x9DmQcDGD0svof2pnvcG029KoKT8OwXM9XBHOdE4n2Ei5THu/L7fCX7HEFGXnSyaF
 VvqV8R9WjJj1zyTIThUVmmJ/5UgOJwi0pcZUdKk8Y7Ooh1DF7khqO3QL0o5Sr8hQTS
 ZOVlPBV00LwEdvDGlZnlwXPfjhb2u5M2WmdGjdAhR+8EqpngKiECpUau6HqO0PCR/9
 YGMRDHgiivTKNPYtKqu3M4HSeFcQZNcxCPYYObxnJ7CTJa/xYck1lNsRukN0xN8WRc
 Yqmo9mOUIsK6g==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Thu,  2 Nov 2023 12:17:10 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Thu, 2 Nov 2023 12:17:09 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: <sughosh.ganu@linaro.org>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <kernel@sberdevices.ru>, Alexey Romanov
 <avromanov@salutedevices.com>
Subject: [PATCH v2 2/2] rng: add dm_rng_read_default() helper
Date: Thu, 2 Nov 2023 12:16:45 +0300
Message-ID: <20231102091648.40520-3-avromanov@salutedevices.com>
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
 {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;
 p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1; salutedevices.com:7.1.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;
 127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
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

Add dm_rng_read_default() function, which obtain a series
of random bytes. In some cases, such function would be
useful because it allows the caller to abstract away from
RNG device.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
---
 drivers/rng/rng-uclass.c | 18 ++++++++++++++++++
 include/rng.h            | 10 ++++++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/rng/rng-uclass.c b/drivers/rng/rng-uclass.c
index d7236b9335..e298623e1d 100644
--- a/drivers/rng/rng-uclass.c
+++ b/drivers/rng/rng-uclass.c
@@ -35,6 +35,24 @@ int dm_rng_read(struct udevice *dev, void *buffer, size_t size)
 	return ops->read(dev, buffer, size);
 }
 
+int dm_rng_read_default(void *buffer, size_t size)
+{
+	struct udevice *rng;
+	int ret;
+
+	ret = platform_get_rng_device(&rng);
+	if (ret)
+		return ret;
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
index 255c85d3e8..6412fedad2 100644
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
  * platform_get_rng_device() - retrieve random number generator
  *
-- 
2.30.1

