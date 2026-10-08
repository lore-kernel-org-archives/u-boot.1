Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F4EACA600B
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 12:52:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B88E56065E;
	Thu,  8 Oct 2026 12:52:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h1xRJu6qLXbs; Thu,  8 Oct 2026 12:52:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org CEA6F60B3C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791463938;
	b=RAcfB+rsP4eCumB4gXelZk6Nf7FZWiftQxB8G9i8qXk7/fPG8PMRnTkQSqLqzHOFZBS5
	 +hiiLhNsb4NvmPCZ0xS8g8MidGi2vMrzM0RCdFWxfC/NriFuT2kr/PjB2+ClE6qrAup9n
	 GNOPUyxWYyP8xH6yLj5Zi1M0HwkOtnJ07wbXACZWRdXW8/w5Pf0HvgEUo/yqQDIhhb/Z1
	 v71bYM5g9dBOYOBCZFGVxivoDpgAblYj6slWb7XDC/494pw/fGpaZJfykNTq9rd5bO8Jc
	 UKpHYymVDhsN0CdohrebRz24SQVCgCiBk27uToEJ1HxuJRXNTYE33nkOh0ibaFkT1cA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791463938;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:X-ZohoMailClient:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=O6VJhFV0MtZFMSK45VGeLNpYwJIPQokCcy0jiXFy/uw=;
	b=kjqWoEZVv71qvzUaSYV+w99jhDA+GHwoa0/nKZ5BDo4lQJJnQ2BZxQ27O8Z4C5SWrxUE
	 y4lZW8V3nYilayeytyiup3uCSHgSAo0Olv+CJp97A1ejVZqy7d+h18yW8vMSmjTmJbr/P
	 Zoupex/i8e2u19AV0pgqRV6IhqxDiXG703QZ330gzpi6m0pWHC1cbD9Pwl4QQGqQUzyN2
	 cFXNkn0ACWadx4xMkqxbT9B/bdEFnfeTcxdCemDm11G1FVJQ0xbxyUOzFo7dMJnnVOzN1
	 9Csn8O4uBad2E78QRyIbBOCJ28jC0MVobyEqD6LFZ4V/xfSkGtZQSPJS9fCd4hMf4EQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791463937;
	bh=O6VJhFV0MtZFMSK45VGeLNpYwJIPQokCcy0jiXFy/uw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B/D5htGjPVzjzJBmrW9oe48D+TEkHmXRUL+5Ut09H45SLFb0lqJ2dAie06c1X+RHa
	 NG9hS2/HStu/z1sJdp3ObSY24KbyGzUhtrQvYofzrGVCz3hxOZT44DNqFib27EFVwh
	 EW33O6pvFCoRMw0w2CrHP9OEb+6cKGr8T8aVXTHSd6PUuET8Gby9zjw3A6ha/gfM2A
	 uBS5mD+1bSs9FrfvVdXsmRlJ+e/hBlY5dGk0/gEPkjnqgG7c3SKCDBUaurlvl8RNQt
	 kRIEyCKBDp3WhwvgLqXCP+N9SPw5+Op/NFX4LdD7eqqpV2CJktPtBkoQ5QfnuYq16Q
	 nWNvTjTAAMMtA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CEA6F60B3C;
	Thu,  8 Oct 2026 12:52:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 154D22B2
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 11:42:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5E49C81076
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 11:42:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bzUr5l_6VQgf for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 11:42:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A16238105B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.95
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791459748;
 b=Q3Ws/++h24SKwLhcUbDDdbq8j3mZe4KsvJBELIwtuP3GIDbgEb9IjdVvqDxYyrdI9gEp
 eIJs4l0MaAov/SfWycL4OD3Sxj69TAUSvoSsGu0qrCY/Icy7nxIEQVqrf9ISqTeRF4sSu
 jJUutPvFLPIAulyx12aHqraTyhvPnAx0wipg3VCUQOW1xB4pFEYKiBdth8dyzAD+pNJNQ
 DIwgjURtu4JvhZN0HRPGt+s1lsJ8kVuE22sxcVgwPdSBiIYyJo5DkdQfdVG4tBBJJmIr+
 gNTeyqMDrbEzk1SweJULK2XDvpR4iuC+0qdhhCUImqL8zMQBqjx9O84xtan5BeIr6iQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791459748;
 h=Received-SPF:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:
 X-ZohoMailClient;
 bh=O6VJhFV0MtZFMSK45VGeLNpYwJIPQokCcy0jiXFy/uw=;
 b=GD/MlUx4BulHaf8XS+RUyEIRu/g5XRS+YvEkqyjIoyryyH62kQr+o5XO+mNFZ50Z6m1D
 aKVbIOjkqxXbgOIypUpgV7FZq6WCxF5LMnZU/sa8LcuuzKjAnsJyf1n6b+nuxqAcUkAaA
 DaC4jJMEAnYmsZzD3VVhDOeb5GUlTque/LWmVp9qwhaWOFk6w9444MaGbMkFygss6hOc8
 gwxpkFzz0SaYeC1xCDE+Q5JJoz/GR3M4ZN4Cv8j3BNKSOT1u3KMTr+SkN9WGjjTb38M49
 GAMdACPGd3YVopDUyAfeGNkxJF7rO9LLVz8LY6pykg9gHDaW1OycZLCZM7uVOxvs/kA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=zohomail.com; 
 dkim=pass header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=H17+VJX8; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.95;
 helo=sender5-pp-o95.zoho.com; envelope-from=zhuxu_ran@zohomail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=zohomail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=H17+VJX8
Received: from sender5-pp-o95.zoho.com (sender5-pp-o95.zoho.com
 [165.173.182.95])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A16238105B
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 11:42:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791459638; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ROC85Tqp8Inuc4APZTO+MVetRhn7uG/xqqmRX/9v25uUrnrcZVWELqOsLcSLPd9jFitDgP4QfZ1oLrQLaaAP/xwxvR6KMXIDjq/O8EufJbuw8xZOd2+3D+KlQW/ZmUSSLmhcl3ygKB5Fy61JCHb8mhzgiCiOA7wXDgU+iwh0btg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791459638;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=O6VJhFV0MtZFMSK45VGeLNpYwJIPQokCcy0jiXFy/uw=; 
 b=LeRMigcTLoPo6VxfvPrhVI8mKvWhNDPhd/Zm8P/MFXT8fCyuhO/LpiFUSzQbbJpvaBruBPqToDNaE9iZ1iHuYA0VN7Nh6ZJ29Mb7AUABb/5XbMR/nXq/mHQ//9tWJgZFWGVaemspzntgic3+d2edQpNPWqrHs16oogkYuvgyw9I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=zohomail.com;
 spf=pass  smtp.mailfrom=zhuxu_ran@zohomail.com;
 dmarc=pass header.from=<zhuxu_ran@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791459638; 
 s=zm2022; d=zohomail.com; i=zhuxu_ran@zohomail.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
 bh=O6VJhFV0MtZFMSK45VGeLNpYwJIPQokCcy0jiXFy/uw=;
 b=H17+VJX8MdJZ465kAjTO9kr1VnWLGLz9GX/3WHK96lFqNml0y4WxzcXLvPL4mLZM
 H/VgmqQXqIJIVC4yRYwmt3aspS+2Xjej7ukn/Do7VeieGaBpjulUk+YU3CywnqLHQ5S
 TUSoZzQkfBxD1aVoXN7+H4II/PR2w8Ht21SKfVWY=
Received: by smtp.zohomail.com with SMTPS id 1791459637118699.0917997258724;
 Thu, 8 Oct 2026 04:40:37 -0700 (PDT)
From: Zhuxu Ran <zhuxu_ran@zohomail.com>
Date: Thu, 08 Oct 2026 19:30:48 +0800
Subject: [PATCH v4 3/3] sysreset: cv1800b: Use the RTC device node for
 register access
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-cv18xx-rtc-sysreset-v4-3-62cebd76d440@zohomail.com>
References: <20261008-cv18xx-rtc-sysreset-v4-0-62cebd76d440@zohomail.com>
In-Reply-To: <20261008-cv18xx-rtc-sysreset-v4-0-62cebd76d440@zohomail.com>
To: u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>, Tom Rini <trini@konsulko.com>, 
 Johan Jonker <jbx6244@gmail.com>, Alexander Koch <akoch@initse.com>, 
 Kongyang Liu <seashell11234455@gmail.com>, 
 Hiago De Franco <hfranco@baylibre.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Leo Yu-Chi Liang <leo.liang@sifive.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Heiko Stuebner <heiko@sntech.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marek Vasut <marex@nabladev.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Zhuxu Ran <zhuxu_ran@zohomail.com>
X-Mailer: b4 0.15.2
Feedback-ID: zu080112277928a083d4e8ebdf3d6c65c80000eca80d0476cc33b322e889331aa9e2bd6a0c20ba99f5f92a51:ZohoMail
X-Zoho-CM-AccountID: 475a6e82b6074d1cdb8624e432e1257a5f0812bb6089f487c4846d9f660201e2
X-ZohoMailClient: External
X-Mailman-Approved-At: Thu, 08 Oct 2026 12:52:09 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The CV1800B system reset driver uses hard-coded RTC register
addresses. Initialize a register map from the RTC node shared with
its parent device instead, and propagate register access errors.
Require the RTC driver that binds the sysreset child. Preserve the
existing reset requests, including the warm-reset sequence used for
SYSRESET_COLD.

Reviewed-by: Hiago De Franco <hfranco@baylibre.com>
Signed-off-by: Zhuxu Ran <zhuxu_ran@zohomail.com>
---
 drivers/sysreset/Kconfig            |  6 ++-
 drivers/sysreset/sysreset_cv1800b.c | 80 +++++++++++++++++++++----------------
 2 files changed, 50 insertions(+), 36 deletions(-)

diff --git a/drivers/sysreset/Kconfig b/drivers/sysreset/Kconfig
index 16ef434a8d9..c9f2a552b47 100644
--- a/drivers/sysreset/Kconfig
+++ b/drivers/sysreset/Kconfig
@@ -60,9 +60,11 @@ config SYSRESET_CMD_POWEROFF
 endif
 
 config SYSRESET_CV1800B
-	bool "Enable support for Sophgo cv1800b System Reset"
+	bool "Enable support for Sophgo CV1800B system reset"
+	depends on RTC_CV1800B
 	help
-	  Enable system reset support for Sophgo cv1800b SoC.
+	  Enable system reset and power control through the RTC subsystem
+	  found on Sophgo CV1800 series SoCs.
 
 config POWEROFF_GPIO
 	bool "Enable support for GPIO poweroff driver"
diff --git a/drivers/sysreset/sysreset_cv1800b.c b/drivers/sysreset/sysreset_cv1800b.c
index 9cd62772ef4..9b2e3aa7ce2 100644
--- a/drivers/sysreset/sysreset_cv1800b.c
+++ b/drivers/sysreset/sysreset_cv1800b.c
@@ -1,64 +1,76 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
+ * Copyright (c) 2026, Zhuxu Ran <zhuxu_ran@zohomail.com>
  */
 
 #include <dm.h>
-#include <stdbool.h>
+#include <regmap.h>
 #include <sysreset.h>
-#include <wait_bit.h>
-#include <linux/io.h>
+#include <linux/bitops.h>
+#include <linux/err.h>
 #include <linux/errno.h>
 
-#define REG_RTC_BASE             (void *)0x05026000
-#define REG_RTC_CTRL_BASE        (void *)0x05025000
-#define REG_RTC_EN_SHDN_REQ      (REG_RTC_BASE + 0xc0)
-#define REG_RTC_EN_PWR_CYC_REQ   (REG_RTC_BASE + 0xc8)
-#define REG_RTC_EN_WARM_RST_REQ  (REG_RTC_BASE + 0xcc)
-#define REG_RTC_CTRL_UNLOCKKEY   (REG_RTC_CTRL_BASE + 0x4)
-#define REG_RTC_CTRL             (REG_RTC_CTRL_BASE + 0x8)
+#define RTC_CTRL_UNLOCKKEY      0x0004
+#define RTC_CTRL                0x0008
+#define RTC_EN_SHDN_REQ         0x10C0
+#define RTC_EN_PWR_CYC_REQ      0x10C8
+#define RTC_EN_WARM_RST_REQ     0x10CC
 
-#define CTRL_UNLOCKKEY_MAGIC     0xAB18
+#define CTRL_UNLOCKKEY_MAGIC    0xAB18
 
-/* REG_RTC_CTRL */
-#define BIT_REQ_SHDN       BIT(0)
-#define BIT_REQ_PWR_CYC    BIT(3)
-#define BIT_REQ_WARM_RST   BIT(4)
+#define BIT_REQ_SHDN            BIT(0)
+#define BIT_REQ_PWR_CYC         BIT(3)
+#define BIT_REQ_WARM_RST        BIT(4)
 
-static struct {
-	void *pre_req_reg;
+struct cv1800b_sysreset_priv {
+	struct regmap *regmap;
+};
+
+static const struct {
+	u32 pre_req_reg;
 	u32 req_bit;
 } reset_info[SYSRESET_COUNT] = {
-	[SYSRESET_WARM]      = { REG_RTC_EN_WARM_RST_REQ, BIT_REQ_WARM_RST },
-	[SYSRESET_COLD]      = { REG_RTC_EN_WARM_RST_REQ, BIT_REQ_WARM_RST },
-	[SYSRESET_POWER]     = { REG_RTC_EN_PWR_CYC_REQ, BIT_REQ_PWR_CYC },
-	[SYSRESET_POWER_OFF] = { REG_RTC_EN_SHDN_REQ, BIT_REQ_SHDN },
+	[SYSRESET_WARM]      = { RTC_EN_WARM_RST_REQ, BIT_REQ_WARM_RST },
+	[SYSRESET_COLD]      = { RTC_EN_WARM_RST_REQ, BIT_REQ_WARM_RST },
+	[SYSRESET_POWER]     = { RTC_EN_PWR_CYC_REQ, BIT_REQ_PWR_CYC },
+	[SYSRESET_POWER_OFF] = { RTC_EN_SHDN_REQ, BIT_REQ_SHDN },
 };
 
 static int cv1800b_sysreset_request(struct udevice *dev, enum sysreset_t type)
 {
-	u32 reg;
+	struct cv1800b_sysreset_priv *priv = dev_get_priv(dev);
+
+	if (type >= SYSRESET_COUNT)
+		return -EINVAL;
 
-	writel(1, reset_info[type].pre_req_reg);
-	writel(CTRL_UNLOCKKEY_MAGIC, REG_RTC_CTRL_UNLOCKKEY);
-	reg = readl(REG_RTC_CTRL);
-	writel(0xFFFF0800 | reset_info[type].req_bit, REG_RTC_CTRL);
+	regmap_write(priv->regmap, reset_info[type].pre_req_reg, 1);
+	regmap_write(priv->regmap, RTC_CTRL_UNLOCKKEY, CTRL_UNLOCKKEY_MAGIC);
+	regmap_write(priv->regmap, RTC_CTRL,
+		     0xFFFF0800 | reset_info[type].req_bit);
 
 	return -EINPROGRESS;
 }
 
+static int cv1800b_sysreset_probe(struct udevice *dev)
+{
+	struct cv1800b_sysreset_priv *priv = dev_get_priv(dev);
+
+	priv->regmap = devm_regmap_init(dev, NULL, NULL, NULL);
+	if (IS_ERR(priv->regmap))
+		return PTR_ERR(priv->regmap);
+
+	return 0;
+}
+
 static struct sysreset_ops cv1800b_sysreset = {
 	.request = cv1800b_sysreset_request,
 };
 
-static const struct udevice_id cv1800b_sysreset_ids[] = {
-	{ .compatible = "sophgo,cv1800b-sysreset", },
-	{},
-};
-
 U_BOOT_DRIVER(sysreset_cv1800b) = {
 	.name = "cv1800b_sysreset",
-	.id	  = UCLASS_SYSRESET,
-	.ops  = &cv1800b_sysreset,
-	.of_match = cv1800b_sysreset_ids
+	.id = UCLASS_SYSRESET,
+	.probe = cv1800b_sysreset_probe,
+	.ops = &cv1800b_sysreset,
+	.priv_auto = sizeof(struct cv1800b_sysreset_priv),
 };

-- 
2.56.0

