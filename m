Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02024CA6004
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 13:17:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9E94760801;
	Wed,  7 Oct 2026 13:17:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qZohaE8TKiq0; Wed,  7 Oct 2026 13:17:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8B06B607F5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791379021;
	b=lF1+0vvZSVJ/8Ijw802jQ6PZN1y+POYPPBhqZIE/6HMB0ZFtLGE4aQq1zSgwnHw7/74p
	 V6ryoKhXeKxpvRtBfQ3pJQLbB5dPlRb+ClEYhjulZDRJqBtoNf0T4VKe7Z9ddhtVCAXqI
	 DDlG+fGIvR7ESCar28JSxtDgtGIulVFxcvr0SzbaeNubF0Fhk0s6tjsjVewo+qJRfgsPb
	 b4QgsBwb3zdVTPV7wvHyukwUPxyYXMweoWpGhaNWb0h7b6ASAb5KKd5CPglFFy0WShtge
	 xUa6nO/ZVM6M2PIZTwCgbUcPjG6pLuVk4JI35IOb4QXYEkGk9rEnKaOXSM8nwjSoFCw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791379021;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:X-ZohoMailClient:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ym3shxAC3zHYIEmwqiFNQNSod9jX46xrkSjMgEj0kY8=;
	b=iLKwikbzDD54GYGUXBAz/9xXLsTz2WGSGNKuVRcd+agXb+Vd0vQ9BjbeNkV5bcYJP2/O
	 Aek2B5ZXSYtUwhpSSJrHC5g70ht95AdmVxQH6iJkroGROJSOe2jOj6Fz/HWhm/goCFSD1
	 frpHT5A3pU3/Q2YTcHvB2vfo3iCyUOTKlP1ne5mV5qPNxQR0JgEbxMcMUp50Sk3zYWj8Z
	 1Mwf2q2uuasmdYhyrj/CKzmue9vW0+bFXLAaNk9yX/Dc3c93RyhrqOw/46TEDkv+t7eOr
	 K47OdVSR7hc+WtODHiU4DbkwKMKbggtVI7CfjmJLGuB3jmdAvU2CzzUHdFxE6DdcgRQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791379021;
	bh=ym3shxAC3zHYIEmwqiFNQNSod9jX46xrkSjMgEj0kY8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zweSMbx05pfR7cDhoSGeOHwOHxXu9caBBYZVFGV5uncZYCgYSuzXcjiHN/wyyu2Vh
	 ZdlZoAdMyTJ3gvjmPJSKxaAkfhXg2rJ8LoBwg6E2/va81fTW+QFzXvvofmIpymdF81
	 S0HlQmYpwCwhvQcT2nFniUFftkO0JA71xMsA554cUoHiINSk5Q0AqnmohJfmbIONPP
	 m9b1Y9LM0VyLFqKp+YLGwEig8fCTl1Ay+LiCOR0mx/jlTBn5oQjQnmolEgE6vXdTyD
	 cakGWjkjsGXZKssy9XJnQPVjsuxXUCq4hGZawT1NuFWT0B37LZVMo5WRuKoroH7oWl
	 QxYjUbU7UIT8Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8B06B607F5;
	Wed,  7 Oct 2026 13:17:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 98D471D2
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 04:25:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7EEF0400D0
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 04:25:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KKr8kt4da5sL for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 04:25:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org B554540070
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.95
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791347105;
 b=ULJNRiqPd1ozOnnN1fneJhF52yjdlkKy9AmFw5V/WJyDDOM6aXiNNtDmf1XbWFon9Yqt
 7PZgePayHJzIvHzarpSi00c4OlvVND+NBoFuJZQQKdY62jz4kpCD6VkCssyXvlx/4fXG5
 ydzw55b48HXoYwe1uXoj4RZ+Acy9IVKqfKS9zPJNNGA2FaG5OZQIODRUIJDxixUqgCKmr
 b5ECd/kyKjvfNJ0/R82tdLIHD5cQshERhlQIpW6Ag3WxZ7avSKW8y+dxH//KVINk8UiAh
 FlKUXplwz6Cv6erVjx9lOEWYVtDTvJCTpFKiLB6vp3fxbreLx+KwhHkCRbjlo7nr9Jg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791347105;
 h=Received-SPF:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:
 X-ZohoMailClient;
 bh=ym3shxAC3zHYIEmwqiFNQNSod9jX46xrkSjMgEj0kY8=;
 b=YkEb9ibow3pVbOrQD/j6Feb1XepdLikVDIym41k+w378fkC6qflWc1WB1RYfDR+xhngA
 5hSmIqaZWlsf47SFb+rFBaIutomF8auB6ToPeLsvdsmPq15xjC+E4Pdmk1+3KWcrM3HTQ
 aPRYLeWitlNBVy8uhniejXVFw1CGx5drYFmjU4DoAiSCqqeRsYCvy23pSUqcqi/INxpcL
 j2EtY90VXM2JQlXqr5fREaMn538fYYt6RRceqhDAJ4G2OiCHmxIIAGBgyxr9wj9qM5sSg
 QvYH3AJhIqaCL3XY4eVM68yoy8c8nxrwZuzpwQCyIa3zRyyVryrv4+1QaWn+L4zOY3w==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=zohomail.com; 
 dkim=pass header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=d18kzUKH; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.95;
 helo=sender6-pp-o95.zoho.com; envelope-from=zhuxu_ran@zohomail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=zohomail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=d18kzUKH
Received: from sender6-pp-o95.zoho.com (sender6-pp-o95.zoho.com
 [165.173.180.95])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B554540070
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 04:25:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791347014; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ZADLr2E7LU93NPuaXKLAjFCtyPqe5QLUvO5xSWgbQKbxCNZjIVFh4jD43hHDFHY22YTUCEGC7RFRti1w91buJEBUrOfaPh3WruqdVaISxY5P6GxoOpk2IwV501UYCuYzjJZCOBcABxls1kudl4+INvEXkVQwYQzNhFhXSiXCj48=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791347014;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=ym3shxAC3zHYIEmwqiFNQNSod9jX46xrkSjMgEj0kY8=; 
 b=EZeORgOsxySkVIOB6d5w2m/F3AU/PtNb7jPSrYB9v5cFVa8wxp7CrhI92lzbTGj6xvsWnXm8gUcU+slLeAZgOeVIO3it1N7qTTeCvR+M/Z7QPCDYSfGrlTecqtPRcY64M+dbrP+IN6gxN6yYCLQz8Mlrxm94iaMuDd/qCeqSu8g=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=zohomail.com;
 spf=pass  smtp.mailfrom=zhuxu_ran@zohomail.com;
 dmarc=pass header.from=<zhuxu_ran@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791347014; 
 s=zm2022; d=zohomail.com; i=zhuxu_ran@zohomail.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
 bh=ym3shxAC3zHYIEmwqiFNQNSod9jX46xrkSjMgEj0kY8=;
 b=d18kzUKHBuUf0Eyj469n+h7zquUJYpcc4rh7Rc9BmKHek5n2k6IDg4sUVi0WgnBb
 FVdoO9XMbnh9VrH3eznjjFHyYi/F2xtq6j/1Cu30RQz9oZ95QFp04jvJKZdKrL4vIMv
 voiw/jcw/wt3ERqjtYtSTSViyvJJS+/CQH3HEyrY=
Received: by smtp.zohomail.com with SMTPS id 1791347012801993.6889111237201;
 Tue, 6 Oct 2026 21:23:32 -0700 (PDT)
From: Zhuxu Ran <zhuxu_ran@zohomail.com>
Date: Wed, 07 Oct 2026 11:33:07 +0800
Subject: [PATCH v3 3/3] sysreset: cv1800b: Use the RTC device node for
 register access
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-cv18xx-rtc-sysreset-v3-3-194557fd5e78@zohomail.com>
References: <20261007-cv18xx-rtc-sysreset-v3-0-194557fd5e78@zohomail.com>
In-Reply-To: <20261007-cv18xx-rtc-sysreset-v3-0-194557fd5e78@zohomail.com>
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
Feedback-ID: zu08011227380771e0057f0894d8deec0600009f30f3ce10c7c046f994f8628ab1ab211ddcfe3500ba1e19f8:ZohoMail
X-Zoho-CM-AccountID: 475a6e82b6074d1cdb8624e432e1257a5f0812bb6089f487c4846d9f660201e2
X-ZohoMailClient: External
X-Mailman-Approved-At: Wed, 07 Oct 2026 12:54:59 +0000
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

Signed-off-by: Zhuxu Ran <zhuxu_ran@zohomail.com>
---
 drivers/sysreset/Kconfig            |  6 ++-
 drivers/sysreset/sysreset_cv1800b.c | 90 +++++++++++++++++++++++--------------
 2 files changed, 60 insertions(+), 36 deletions(-)

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
index 9cd62772ef4..ff2660b50d9 100644
--- a/drivers/sysreset/sysreset_cv1800b.c
+++ b/drivers/sysreset/sysreset_cv1800b.c
@@ -1,64 +1,86 @@
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
+	int ret;
+
+	if (type >= SYSRESET_COUNT)
+		return -EINVAL;
 
-	writel(1, reset_info[type].pre_req_reg);
-	writel(CTRL_UNLOCKKEY_MAGIC, REG_RTC_CTRL_UNLOCKKEY);
-	reg = readl(REG_RTC_CTRL);
-	writel(0xFFFF0800 | reset_info[type].req_bit, REG_RTC_CTRL);
+	ret = regmap_write(priv->regmap, reset_info[type].pre_req_reg, 1);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(priv->regmap, RTC_CTRL_UNLOCKKEY,
+			   CTRL_UNLOCKKEY_MAGIC);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(priv->regmap, RTC_CTRL,
+			   0xFFFF0800 | reset_info[type].req_bit);
+	if (ret)
+		return ret;
 
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
2.55.0

