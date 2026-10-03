Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E00E4CA5FDD
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 12:48:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9B6604137A;
	Sat,  3 Oct 2026 12:48:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pk2ZATib4xSL; Sat,  3 Oct 2026 12:48:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C2C9F41395
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791031694;
	b=Y4gt+P6PcaS94GnTgbeTS0WHMe9UvKsOn664o15dcGyqq2E/E3D3qEjLwHwhHI4gpoL7
	 hNCS9jBMBWENwPH9+AscJsaG/YkwlvZ7Bnk7beIZmu3a0gcPNqw5C66YMRuJ3gh41UkOR
	 c53W3J8P16oVuvvtZq3P0d/AoZ37+SJI5rKhs+LhbhXPoc5poabUd/eN/S23lnnRkjLTI
	 1h2haAyNdURlBp6lRxhXmCJegVyvtIDzI4BHR0+xlvCPA28K9HRtJvYStO9/N59dla8zj
	 C7u7Qw/AlESPKYmlBevrC05WbftyLVA3QA56G18QBDEjCysysyUeoZHULFs+c7D4dyw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791031694;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:X-ZohoMailClient:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=/dWUMx8xb89c6MEqSmi+dEklKrYH+NuD8ngtMNzf2nc=;
	b=EvvrblgFaX18BT+s41A6cEtITh4vmrDQmFF1dlSWmks3H6Tc4d6T+WnJ3htpID1x3QJB
	 H8MHli1QSOpP+Loe6iyuHQZyarLTw9SrCAzZETavcJkhiDF/Yx1c92++gjzFPkFRpbLx6
	 g4UQeOscZYBVtGDwC4jUaK3cqA7jmzbG9uJE+IYYVWvWcUMnxZmQkRiuCV2HkGel8s6Si
	 ajah9ztU/erWMBzeZ0vcmhNoMHrDnXSLxH2QlJnRTxr3He1ooOL5a4UCYClgMNX9t6P55
	 QwL8xERmQYw/JpJhvXKgPWzZqz7yLKyrd8pht1V4jUeTIga4bs5HaAknFqpTg6L6pzw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791031693;
	bh=/dWUMx8xb89c6MEqSmi+dEklKrYH+NuD8ngtMNzf2nc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yu5Wfuj8hdw7nr4IKcHBbqwpuGuqZ6w8MG+l9Pin6Kum/G0HOXEGpFYPOsDTl7qJq
	 2CoeoPDaPULdHxI1IaVZcFUX8GxKvvuo3RJn/BPEt2md5JAEVEgEib0snPzqt4JEfK
	 LQN1dCAYw1Tydb0iINheqP1SjvgHQwlJhD2mvYkR3CG64lNzqFURgdUZsGoNm53txK
	 O5yRZIBD2eAvBb4gFIx8IA7xshVxAc8AIOIrFuDQ7VGX/jXvuirvV5RDmR795ZDyOg
	 YW/0vczZEuvGFAyb6wcjBOLClAzPbNMEhWHVUIrI900SG9ONd5FtzTx+SgUMVKqVwX
	 hPkQ3Ko2O2wDw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C2C9F41395;
	Sat,  3 Oct 2026 12:48:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id EC04F34E
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 11:59:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D226B40064
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 11:59:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0xBNC6rfAmOe for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 11:59:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 0422C40059
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.95
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791028770;
 b=FyOrHyYm7Ni1qS7wEoeASVAVoe/tR38S4N24dKhnHttiGb823mjYJoy9MmfeKW/w8F23
 v8UH4nn5MQioCaD4sMlC+s/YBDFbLxMBIOHRrtvxmcgvDy/7hiYC0WR+Z2PFukK+0aKFR
 1G1AQ7R+pHogNMw1P3rQT/rKEKPPRXohsOWlkxLhRwJfe/PPJMWCab1Qttw/ASVJFgP0/
 WKuihCwCuuChyKNvozvxgzIv4oBrz9skAk1dYwDvLCcXJOl6SCsqqtzXpBb1k8pfpvZiI
 O4WPmh6cGKtZHyxu0R9qxbZAq5ygeGJdIixVLLqviZeruVUWTTEvrQW5XRxnhuXmYQw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791028770;
 h=Received-SPF:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:
 X-ZohoMailClient;
 bh=/dWUMx8xb89c6MEqSmi+dEklKrYH+NuD8ngtMNzf2nc=;
 b=pOjrjY/Z1poq0Q03Z4D2ryT+j4NmVqjRxSDASkSf/SZwQzwVMnfYglTA8+WeE2EhcBgQ
 DqyQvceq45mLMmX7X16UHzEafv2+SgP/VT2iAq2q8NDJV1SGauvy/OWjVpI+2QuxY729t
 HeiREGUKo3N5627N8AIe186JQ/LLgmSEvGejA/zbMI/UsGPoYG5Mur56rYr13rtCnHiVg
 QiQjKlajfRGLMdJg+twFMs6wrabI/bZ+u9638G0uFfkGf6Qa+gLEdaGp2UpF/v/wt4E6K
 ZVVTygtHmobpzIGLsmfCwhPKwrApRGLVHET+qfIVQZr13mVqy1LNAxYP6NL5+GNBR2Q==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=zohomail.com; 
 dkim=pass header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=CuXZMuDi; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.95;
 helo=sender5-pp-o95.zoho.com; envelope-from=zhuxu_ran@zohomail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=zohomail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=CuXZMuDi
Received: from sender5-pp-o95.zoho.com (sender5-pp-o95.zoho.com
 [165.173.182.95])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0422C40059
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 11:59:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791028676; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=TnNpfyMs8PUdc0SedJlhAlLK1yciAUi6BdzNHteQ/lu3+RWrv6wUtKvc1ivy+shPeNjCruK0U1peEpdy3OSKFePEMNZE+eKW/naCz+LL/HKbXIsGM74QYk08zFIine2CJbp2N3DwBCA4InzzQO/r0h0ULZGtmrXtyJ944ifHfsU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791028676;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=/dWUMx8xb89c6MEqSmi+dEklKrYH+NuD8ngtMNzf2nc=; 
 b=ZQrhk0wdjl7YLZinjEY9O57BkeyvyJV3lk1gmQNnRiYodX4hWkPHko15gNFGox+1mqKWKiCryVxmKwVmMCLwti2jj3StZ95MfSoKbVYuDlsz22t4jPSydB4h1csJVWbMadjRBVS17y/e4ZLuEOxG8QW+TRWIfvoL+QbTItaVo2A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=zohomail.com;
 spf=pass  smtp.mailfrom=zhuxu_ran@zohomail.com;
 dmarc=pass header.from=<zhuxu_ran@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791028676; 
 s=zm2022; d=zohomail.com; i=zhuxu_ran@zohomail.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
 bh=/dWUMx8xb89c6MEqSmi+dEklKrYH+NuD8ngtMNzf2nc=;
 b=CuXZMuDimZUn98NY6vrUU3GSQF/ll/A87VWfOa4MmmyVF2NVy82yvVA7+lvkkveB
 YvQBgyv6IsRr5lqEql8GsKaBOIQ9iFSxCPW79srYDztVNwrv0Q4CpwdwLS3A8eieHBf
 +jywy+DXFlU22zmv/81BkQFf7FdJ53oqXesaBhhA=
Received: by smtp.zohomail.com with SMTPS id 1791028676333548.8767991803586;
 Sat, 3 Oct 2026 04:57:56 -0700 (PDT)
From: Zhuxu Ran <zhuxu_ran@zohomail.com>
Date: Sat, 03 Oct 2026 19:55:08 +0800
Subject: [PATCH 3/3] sysreset: cv1800b: Use the RTC device node for
 register access
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261003-cv18xx-rtc-sysreset-v1-3-c0837e26eb29@zohomail.com>
References: <20261003-cv18xx-rtc-sysreset-v1-0-c0837e26eb29@zohomail.com>
In-Reply-To: <20261003-cv18xx-rtc-sysreset-v1-0-c0837e26eb29@zohomail.com>
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
Feedback-ID: zu080112270b09b9c1d79459bd3b782e7600005a17f69cf9b25a3fee33a86ae35908c2ba2da8eb0d7b948420:ZohoMail
X-Zoho-CM-AccountID: 475a6e82b6074d1cdb8624e432e1257a5f0812bb6089f487c4846d9f660201e2
X-ZohoMailClient: External
X-Mailman-Approved-At: Sat, 03 Oct 2026 12:47:49 +0000
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
index 9cd62772ef4..fa76c8cf38e 100644
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
+#define RTC_CTRL_UNLOCKKEY	0x0004
+#define RTC_CTRL		0x0008
+#define RTC_EN_SHDN_REQ		0x10c0
+#define RTC_EN_PWR_CYC_REQ	0x10c8
+#define RTC_EN_WARM_RST_REQ	0x10cc
 
-#define CTRL_UNLOCKKEY_MAGIC     0xAB18
+#define CTRL_UNLOCKKEY_MAGIC	0xab18
 
-/* REG_RTC_CTRL */
-#define BIT_REQ_SHDN       BIT(0)
-#define BIT_REQ_PWR_CYC    BIT(3)
-#define BIT_REQ_WARM_RST   BIT(4)
+#define BIT_REQ_SHDN		BIT(0)
+#define BIT_REQ_PWR_CYC		BIT(3)
+#define BIT_REQ_WARM_RST	BIT(4)
 
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
+			   0xffff0800 | reset_info[type].req_bit);
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

