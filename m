Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD964CA5FED
	for <u-boot@archiver.kernel.org>; Tue,  6 Oct 2026 16:03:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5FADF607DC;
	Tue,  6 Oct 2026 16:03:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id miYX0u-VWK15; Tue,  6 Oct 2026 16:03:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 650F3607C0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791302622;
	b=qCHBGwrWHp8XsbG9TcMET4CxNqPNhQpplk4jgJb93zMf2xwWW3CbUogNSdYgQwr7H1CM
	 KWtjqpA2Ig6IfDq1A9sA0IzjyY38NvofcAxVIHMcytrD9BNdnss9yXuag56s0Dbvowbhr
	 IxSpiZkr+hprEdRD1ijG/fCP9dxk72+Vl/TOmsPLxT6qT5fKCuAbSj5yq2lYg+3qFl0UU
	 8nHaad2oAkREXte+Yvk/FODQS0rg6QTTWb6HX1eQBrzSDgtnHrC+ivWOky7yBfR6c8u6F
	 /AMAjAFjBFbrC/0XDdL89qA+Y2qiyerrbeq8Pp3BziDnFbY19dMlFQA9rsKjYJSy4sg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791302622;
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
	b=QZuwsBG1UQMB+tpFv3LyR6J5TMAe19UmSKrplQH8IQvNx779rJaqam30L0C6dRO4W5hP
	 7q/1umCgligX27oL8M7VI76qbj82dSBTbrO0xDWRWkZy02tlC8rniAVY/8fPOzzw9J3ew
	 BuMzvuRoh0xHsi3TCTw69UxurxXKvc+VwdI2ch9oKCE7u04oVt+/luM/OpoDLlzwfAUBA
	 1OyXFCJEz6mo/y3MDrNNXOOqMAiy92m+ImpuZthbRSjK3zkb7h1cauq9NrCxs6AYg6IRJ
	 2mKTicR1uZDzgsq9H+WBDdcbJyM+eRFzaUDcBxq+6EqHFebriEyQ3DuOwG6FNYhXzFw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791302622;
	bh=/dWUMx8xb89c6MEqSmi+dEklKrYH+NuD8ngtMNzf2nc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z3oQOwYaR5bqU8sZYjNsCWR4k+daPg5M82KVtdI1cE8KDlfpX3kpVnqEz4sJQiZCD
	 mt9LedV7k11LATjejpT9EkgaDkUdvH5/UrNXefAD7GtLzpaft1Qg3vBZL3KuQFVUrf
	 Xyld/LSjgGUb9AKDz94pveE3j+NbfoQfLnv+/OGkkoUu/IYlmbCsslLEHlA8cPKS89
	 PwZsIFv7sKgiVVq3bTA41lLKbz3s8WEJMA02b1EXACEdBLXKhzzXKlcRQeDFDTqkiy
	 cT4kHVXkBiMSGmSCAI1zOWfaRvaM0rWEK6rEF8g5IPcrlT95GKLNU8CUv9prUjpGuE
	 R3ykylEAEwwOg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 650F3607C0;
	Tue,  6 Oct 2026 16:03:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 479F075
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 15:50:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2E15740296
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 15:50:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y7R4qN49nlfC for <u-boot@lists.u-boot-project.org>;
 Tue,  6 Oct 2026 15:50:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 5CA6B40274
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.95
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791301824;
 b=PpuvUPhAi6+PzHGqrx1f/P/DOOdoV9B6UssyCNGB0ysdwSs3Opwk/PEL3JfAJQzIaBky
 n1cdkIjHSZJm+Ceya8hevKAfuM+jLn0glJNROS8t3wY5sh0az+iXGXqufXlmtKTnlePRh
 GTjlGf6Z0dcBfeOjHQnW4OXPy1U3gWT4YZrVodTU8ZktToUIrSKXA9ZTfHNGRkvjwUcb3
 v4CLXK2LuKyUu+34amKEe8yYjxfUIqN//kenlbYOmSl+mGyoAmilsHByDr3kgnqPRnUmb
 VP8IwgCOaWohiH/Ayctp+ZMjJ6jft6j6+y+vUvP7JFv/AfphkPqo59p2uFVr3EYDdjg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791301824;
 h=Received-SPF:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:
 X-ZohoMailClient;
 bh=/dWUMx8xb89c6MEqSmi+dEklKrYH+NuD8ngtMNzf2nc=;
 b=jl0c0lJ4sQFcYzUhHzgFeeIB7YXEye5hX1yr4UbFLkeh9FrhzkyDtWmco/TpZjuUVYcz
 GYmf4wcqDqKVLVhVrMftlFOucW+a+J8XZFhZDAsMtfIhQc1pZtR+zccs+jFCp1qikuGMd
 sB+IaBiPY028bnuSNEOzn+J57ZamvHpsJX7zYPrFnLJjN95zKx+5wBe/57s96VKEEiJio
 WRaBenVwKqkU7CPRfGyADc8U67seP5QeUEaboQzVeNagBYEyL73HZP92L8MGLKMIiyX8x
 NdB1uy5uG1vSrBdjQVFXCdBqP2loi7MG/d8c+wkLo54lZ7hzUNiNPKiMNjxywNJsGpQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=zohomail.com; 
 dkim=pass header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b="GSymram/"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.95;
 helo=sender6-pp-o95.zoho.com; envelope-from=zhuxu_ran@zohomail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=zohomail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=GSymram/
Received: from sender6-pp-o95.zoho.com (sender6-pp-o95.zoho.com
 [165.173.180.95])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5CA6B40274
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 15:50:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791301755; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Iaqpd8CeGqjpRG7l+nEpOmv7jzVHzuihO8+0DUNqEy6RIGfg/d9gcgK6sm4kDA0gRXVKbcqVDgB1AG3BOkv6B2ToaP6gXt6vun9AqSpwLY9jK9TL/csWegM/oI5pm96SQLzGf4dzHbpeT3cdt2XgGK3/Z3HdoKlYbpH4NsyewsI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791301755;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=/dWUMx8xb89c6MEqSmi+dEklKrYH+NuD8ngtMNzf2nc=; 
 b=Hs63Gjsoi8vO9tJ3CdLo9vqt44noS9/IhBJoqjO9sktea8WO9yJ/hp1ki3GLguEqQtBQmOiM7BuE+l/g2mtjCdn9TLcYcCYlMID+8ITP9VJDg7gNMdVfIqjL1LQVikgQ7qEEtHKaNxqJLSKEZBRHakH91MZTNhON4F6noz+Kqro=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=zohomail.com;
 spf=pass  smtp.mailfrom=zhuxu_ran@zohomail.com;
 dmarc=pass header.from=<zhuxu_ran@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791301755; 
 s=zm2022; d=zohomail.com; i=zhuxu_ran@zohomail.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
 bh=/dWUMx8xb89c6MEqSmi+dEklKrYH+NuD8ngtMNzf2nc=;
 b=GSymram/FzFbIFCo7fi5A4mKW9Q7zhYRjhfmIQPw/1sp1fg2IszdHTY40b6kuTrP
 wG6yKh+aER7tuggp+tTROFqwiDhDpj57knnuTP3T5SCKRz8Q0rzF434/EKVjVZcMX6a
 F6b35PERiJdqcILtEd9/x7pcExY4WyIl+i3gKXI8=
Received: by smtp.zohomail.com with SMTPS id 1791301753761491.97388835131346; 
 Tue, 6 Oct 2026 08:49:13 -0700 (PDT)
From: Zhuxu Ran <zhuxu_ran@zohomail.com>
Date: Tue, 06 Oct 2026 23:45:08 +0800
Subject: [PATCH v2 3/3] sysreset: cv1800b: Use the RTC device node for
 register access
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-cv18xx-rtc-sysreset-v2-3-67872888384e@zohomail.com>
References: <20261006-cv18xx-rtc-sysreset-v2-0-67872888384e@zohomail.com>
In-Reply-To: <20261006-cv18xx-rtc-sysreset-v2-0-67872888384e@zohomail.com>
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
Feedback-ID: zu08011227ae64654ee2eca71c00361572000046deb62e7b34219766bdda1463be164f9f8d3d6a4c60e63f3e:ZohoMail
X-Zoho-CM-AccountID: 475a6e82b6074d1cdb8624e432e1257a5f0812bb6089f487c4846d9f660201e2
X-ZohoMailClient: External
X-Mailman-Approved-At: Tue, 06 Oct 2026 15:59:54 +0000
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

