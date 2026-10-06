Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CD57CA5FFC
	for <u-boot@archiver.kernel.org>; Tue,  6 Oct 2026 16:02:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 580B64054E;
	Tue,  6 Oct 2026 16:02:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8wdDKEoPrQi8; Tue,  6 Oct 2026 16:02:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 434B8404DE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791302573;
	b=XYEOE1pNExGf54A6KqmagKiQV9ag9l4FXg78Jnd8qEp1Yb1YrDNuF7j3CDFHzPkZqU5P
	 +CEJ81g+4CBr+XSsben23aOqnTHI8Cp8gEb5EjIZWPDJYvtKXbPWf/doM+z8vIkczEbDI
	 TiTZnQzgBu/c8jqdtqbxWAg3DdMc0vRf2+6mvmLuFz2hhge8MvgIb0DU0e17ud0aWnRQI
	 4NsXIRV1jm7ahMow8is2skd3bD2dui+j6NghH+9h6CcW97EhKAoGLuD9A75y2z4pN//Jq
	 Wg9aphLEvqb598HDAvraTCmCa4fWUw/SkKWVfLHg3Z44pV6x3Qqn64hzYLD3FqSls0A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791302573;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:X-ZohoMailClient:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=yiCYfEWn8ul6fC0C8USvrEIuP9D/aK02IdQhqwupjAQ=;
	b=cPq3gC8676+Gk7ens4NkufOUCF7n3ytQrKUd4Caa59Jw6v/mSk/vWNQ3RZByr8F7yiv3
	 jd6LAWwkYKm/z37w+s8DPcqmODanEjCFJHeog+GD1yDKcI+jVzmAhHvOLLFRU+mNEweBc
	 cPMDNXm+vxT3aBZ7pmjn6nfSdh2IojtFZmYA3TN3ris1sJwHOmQKNLVS2qWym5QkA9TjR
	 +w4QD2BdRkCxd9H/24gE/lVkcdvo7sARSm7va76G8Jp1NYaVdbD6KozZgxl98OTOpZR/8
	 bGfkyf4StT2VClIm9qx0Jj/L5VCU/o1snbuPxIV4sLZDU2E/Pkl1IxbAfn1YEXDKl1A==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=zohomail.com;
	dkim=pass header.d=zohomail.com header.i=zhuxu_ran@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=LsmpznY7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791302573;
	bh=yiCYfEWn8ul6fC0C8USvrEIuP9D/aK02IdQhqwupjAQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nMjwZVLgqUcLxC0Xw9w+YSCPoKuL417gDeeBf2WzvHitDw873JQBjns+f5VXMR4m9
	 jJQzRXBeK2uwPY61MSC/v0POePJ1rKxi7QsAHf6PEaoToTMIcDxnL6olGcEGG8uaL1
	 DhcTEMJZRAIXL+BrlXq29wH2XhzNm6b4CaVcwATk6E+bubdKQ5AGZJ9NZQG9neiPLi
	 uf7/PPqchip2q3cAvhFfzOR7SIM1K9nDlwx4UEhxP7POXt+nv5Pme6d5sMxyrGXk6G
	 a7MsaBXDVEiVsjzVYtKsAVmvPajDJnr38WZacDXDTkwX1s4i5k1NwrOBNh+a9FBLS0
	 3p4XmO7M0W/cA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 434B8404DE;
	Tue,  6 Oct 2026 16:02:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4E0BA32F
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 15:49:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3EAC9405D8
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 15:49:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T57rpA1vkdBY for <u-boot@lists.u-boot-project.org>;
 Tue,  6 Oct 2026 15:49:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 480D64061A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.95
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791301755;
 b=ccgnxmnIzBNkux93rWQmyGTv6AsmZa85YWKZG/j2WOy0R8HpySW7Vx0DApOIQ5crfPmD
 HoKGizTa02ShZ2fy5krvzB+o1C1kQ7Xmvl3kmXx3ZtA+559CAUsLUcxJEJT1UFKRFr8VB
 l7HmKg1C/9tSI0UwVTJcNXiIfNRVytqeEgwSTAiRfhIs5e34fmgWDT0NWbaZhY4FVh8ZH
 ceEdxFYK02IdEjdf2n9rUZT9yNEZxrTlD9tYPVYmJcJIUgNRLub5X60IlnsGHmqsaSL/W
 Ny282X5ddbtQt3g2Mv+0JeUYJg1nPpuxqXD7mnqKOpkR9y/D4yUZvJFxz+X8fnfPdag==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791301755;
 h=Received-SPF:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:
 X-ZohoMailClient;
 bh=yiCYfEWn8ul6fC0C8USvrEIuP9D/aK02IdQhqwupjAQ=;
 b=C3XX2Hb1kLSquif+RPv+iY/czlpGnQxDk5igAm8gces4UMCljAZj5mCdc5fVzw6oRywb
 nTCsONxhTQia+9hcZNtaoOB5b4iL3PR8InJvMcU0mOEzCDjUKhCl+QnKa7xTPZ5i3dEET
 e50Nodxhh8oyyA17Q7yMLe+oGTgm2na5JqHF6FVuVvwe694aKvQg/Scx4E+wf44hnUcMf
 ftf8vn+KDetcL7FrCp1EIu68P1vtpe3GEElDkukwKMaibPENOuivDjBC8giSvV7q4mjmX
 jF5eg8+l1Em7hn2nXd+JlaJUJpnYWED4qdxoz+XSOIQZ1Z2BrW6nbsHeyfjh9PP3Qtw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=zohomail.com; 
 dkim=pass header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=LsmpznY7; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.95;
 helo=sender5-pp-o95.zoho.com; envelope-from=zhuxu_ran@zohomail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=zohomail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=LsmpznY7
Received: from sender5-pp-o95.zoho.com (sender5-pp-o95.zoho.com
 [165.173.182.95])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 480D64061A
 for <u-boot@lists.u-boot-project.org>; Tue,  6 Oct 2026 15:49:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791301710; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=R+30Ud3VrCxx2BZ0wn/rzp9pLdsu+1SJZGB1vQy36OTy66Q0x9VfXpl40zdcZFBD3XZJrru6JLnUPad+cJl7kluohH6ghOX/LGtO6C0S6xEFNdHpKF0Z+Rm+7omyjPOohXWtDqW7+kUzUc3cVuGydNKDagmOqchlghXMQQrEusI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791301710;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=yiCYfEWn8ul6fC0C8USvrEIuP9D/aK02IdQhqwupjAQ=; 
 b=jMiXzYtH82I08iztcHi9gbQHUupVV706+/IPeuDh6p1gzGTcFQ5FnYYC4K40IsQF7/JrZDb60C0wRaAI/vR11pqYcXcVlUKhpGF4q49SHgxGkyuo/y2654MnWuehl7HlgyMCwVQUYeGBY3tXtPhiU7qmZFGP2J+pfT6MShFpjDM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=zohomail.com;
 spf=pass  smtp.mailfrom=zhuxu_ran@zohomail.com;
 dmarc=pass header.from=<zhuxu_ran@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791301710; 
 s=zm2022; d=zohomail.com; i=zhuxu_ran@zohomail.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
 bh=yiCYfEWn8ul6fC0C8USvrEIuP9D/aK02IdQhqwupjAQ=;
 b=LsmpznY7/shfvk3VTbxCIQqkIUUdkUUPaoYP8DZfIABC/SwT/t3NO7ZhHUhkJjsK
 eBi3IQBjoQm66ehlrY+4I+i6j0T8CnBqp7R7KPZX9aSEZz4c5VHlbGD2OzTSnHhFhad
 TYZ6OfsLv6V8HH3HvPsltTn5vicFqf5s3OAhh1hQ=
Received: by smtp.zohomail.com with SMTPS id 1791301709956396.8908959474918;
 Tue, 6 Oct 2026 08:48:29 -0700 (PDT)
From: Zhuxu Ran <zhuxu_ran@zohomail.com>
Date: Tue, 06 Oct 2026 23:45:06 +0800
Subject: [PATCH v2 1/3] rtc: cv1800b: Add seconds counter support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-cv18xx-rtc-sysreset-v2-1-67872888384e@zohomail.com>
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
Feedback-ID: zu080112270292656724c44fb1877a60a10000cf530c0cae3a374f766fd24df98547a4d07aaf517933319585:ZohoMail
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

Add a driver for the CV1800B RTC seconds counter described by the
upstream devicetree. Map the node's register range, enable the RTC
clock, and implement reading and setting the 32-bit counter. Bind
the existing sysreset driver as a child when enabled.

Adapt the register definitions and seconds-counter sequence from
Linux drivers/rtc/rtc-cv1800.c by Jingbao Qiu.

Link: https://git.kernel.org/linus/d9f82683b123ce315cc36c4b20a5bc3d8644f947

Signed-off-by: Zhuxu Ran <zhuxu_ran@zohomail.com>
---
 drivers/rtc/Kconfig       |   9 ++++
 drivers/rtc/Makefile      |   1 +
 drivers/rtc/rtc-cv1800b.c | 123 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 133 insertions(+)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 5b44cc99c97..52d0e51acc3 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -54,6 +54,15 @@ config RTC_ARMADA38X
 	  This adds support for the in-chip RTC that can be found in the
 	  Armada 38x Marvell's SoC devices.
 
+config RTC_CV1800B
+	bool "Enable Sophgo CV1800B RTC driver"
+	depends on DM_RTC
+	select REGMAP
+	help
+	  Enable access to the RTC seconds counter found on Sophgo CV1800B
+	  SoCs. When system reset support is enabled, the driver also
+	  binds the reset function provided by the RTC subsystem.
+
 config RTC_PCF2127
 	bool "Enable PCF2127 driver"
 	depends on DM_RTC
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 742481ce185..53f704fe511 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -7,6 +7,7 @@
 obj-$(CONFIG_$(PHASE_)DM_RTC) += rtc-uclass.o
 
 obj-$(CONFIG_RTC_ARMADA38X) += armada38x.o
+obj-$(CONFIG_RTC_CV1800B) += rtc-cv1800b.o
 obj-$(CONFIG_RTC_DAVINCI) += davinci.o
 obj-$(CONFIG_RTC_DS1307) += ds1307.o
 obj-$(CONFIG_RTC_DS1337) += ds1337.o
diff --git a/drivers/rtc/rtc-cv1800b.c b/drivers/rtc/rtc-cv1800b.c
new file mode 100644
index 00000000000..e98efb319d7
--- /dev/null
+++ b/drivers/rtc/rtc-cv1800b.c
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2026 Zhuxu Ran <zhuxu_ran@zohomail.com>
+ *
+ * Based on the Linux driver by Jingbao Qiu <qiujingbao.dlmu@gmail.com>.
+ */
+
+#include <clk.h>
+#include <dm.h>
+#include <dm/lists.h>
+#include <regmap.h>
+#include <rtc.h>
+#include <linux/bitops.h>
+#include <linux/errno.h>
+#include <linux/err.h>
+
+#define SEC_PULSE_GEN		0x1004
+#define SET_SEC_CNTR_VAL	0x1010
+#define SET_SEC_CNTR_TRIG	0x1014
+#define SEC_CNTR_VAL		0x1018
+#define MACRO_RG_SET_T		0x1498
+
+#define SEL_SEC_PULSE		BIT(31)
+
+struct cv1800b_rtc_priv {
+	struct regmap *regmap;
+	struct clk clk;
+};
+
+static int cv1800b_rtc_get(struct udevice *dev, struct rtc_time *time)
+{
+	struct cv1800b_rtc_priv *priv = dev_get_priv(dev);
+	u32 value;
+	int ret;
+
+	ret = regmap_read(priv->regmap, SEC_PULSE_GEN, &value);
+	if (ret)
+		return ret;
+	if (value & SEL_SEC_PULSE)
+		return -EINVAL;
+
+	ret = regmap_read(priv->regmap, SEC_CNTR_VAL, &value);
+	if (ret)
+		return ret;
+
+	rtc_to_tm(value, time);
+
+	return 0;
+}
+
+static int cv1800b_rtc_set(struct udevice *dev, const struct rtc_time *time)
+{
+	struct cv1800b_rtc_priv *priv = dev_get_priv(dev);
+	time64_t seconds;
+	int ret;
+
+	if (time->tm_year < 1970)
+		return -EINVAL;
+
+	seconds = rtc_mktime(time);
+	if (seconds < 0 || seconds > U32_MAX)
+		return -ERANGE;
+
+	ret = regmap_write(priv->regmap, SET_SEC_CNTR_VAL, seconds);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(priv->regmap, SET_SEC_CNTR_TRIG, 1);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(priv->regmap, MACRO_RG_SET_T, seconds);
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(priv->regmap, SEC_PULSE_GEN,
+				  SEL_SEC_PULSE, 0);
+}
+
+static int cv1800b_rtc_bind(struct udevice *dev)
+{
+	if (!CONFIG_IS_ENABLED(SYSRESET_CV1800B))
+		return 0;
+
+	return device_bind_driver_to_node(dev, "cv1800b_sysreset",
+					  "sysreset", dev_ofnode(dev), NULL);
+}
+
+static int cv1800b_rtc_probe(struct udevice *dev)
+{
+	struct cv1800b_rtc_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	priv->regmap = devm_regmap_init(dev, NULL, NULL, NULL);
+	if (IS_ERR(priv->regmap))
+		return PTR_ERR(priv->regmap);
+
+	ret = clk_get_by_name(dev, "rtc", &priv->clk);
+	if (ret)
+		return ret;
+
+	return clk_enable(&priv->clk);
+}
+
+static const struct rtc_ops cv1800b_rtc_ops = {
+	.get = cv1800b_rtc_get,
+	.set = cv1800b_rtc_set,
+};
+
+static const struct udevice_id cv1800b_rtc_ids[] = {
+	{ .compatible = "sophgo,cv1800b-rtc" },
+	{ }
+};
+
+U_BOOT_DRIVER(cv1800b_rtc) = {
+	.name = "cv1800b_rtc",
+	.id = UCLASS_RTC,
+	.of_match = cv1800b_rtc_ids,
+	.bind = cv1800b_rtc_bind,
+	.probe = cv1800b_rtc_probe,
+	.ops = &cv1800b_rtc_ops,
+	.priv_auto = sizeof(struct cv1800b_rtc_priv),
+};

-- 
2.55.0

