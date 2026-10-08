Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 008C8CA6007
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 12:52:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CE57F80898;
	Thu,  8 Oct 2026 12:52:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8mLezUB0L73l; Thu,  8 Oct 2026 12:52:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org AC32F81247
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791463932;
	b=DPykK+ZuNThCX2Anf/Fq0VgcUTGXsRtxR841Hxs9u43fBLZ8dbEWmhUwFK4pf0n0oQ+V
	 O8TpOYci6f2xUgNXh9j8jAjGTtbs/eSKWPnPODfTmTFksJKe4Nm1mfgD38ABMCOjgMOVp
	 L3kMyKazK0LeL7684jcwU+tl8JjgqPKeF6BNbnAipyY6N8dRK+riJBMm5AkeW0ko9/a8L
	 HZiR22RrrHHnt1tjJZowpdQJWid/GPtX91kxFeFF89dzBccE8j3rtuHuMzlsSxkMnLMDL
	 4h/UQkCR6iAUIWCN3hIRSM5/XrD+d10NVkAWTqOYqj2TqP89jaK3IkNKVfp/HT9B5AQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791463932;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:X-ZohoMailClient:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=0VB5Uwb07lKJ3H8j05EwHFmv5G00QuQvQfWuyfxyzjo=;
	b=Jsi8qDhXGeAVBq6WZ50zBrrVGwLisb4ajAdueP4ZcJBDbWfkLYp/kcvoKf1lwZ4f470m
	 7cQ71VBRJd5OZDQM2GXgScozN8VmQZ52TYG/HpqFp0D4gwk4aWmwZzhBJr75ZUPD7eXrO
	 OZNL5ox99rmpziwtDbqVS5IbNGXAog7GVZRrw2qrKAHUfWFtj9sgC/PjebXjDLEehhCbK
	 QSvHi2F2ETwZjRDw1FYr06PlnhPpG4igwuPSOVjMRq81f2wu7fuAntuQTrw0zkgaa27fT
	 ltsGHkf42yUR6+KwX709bKBfxChY7Z6giO4b3oKdY7jR8/RYwRT0fze+5jUatX7kzCA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791463932;
	bh=0VB5Uwb07lKJ3H8j05EwHFmv5G00QuQvQfWuyfxyzjo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mtVvvuBizuO6vHmJIVDIJ7/t0V12XySLX48/Qviaf4y9xs1XiPK/4BDVQVisfcTaF
	 UUpKRicXCkhjn5b6PLbPnauyvqSv+BjTWzjWoTI85JdtCHYrY1w0ezMZUGP0emdh26
	 rygY8E5BNdnboPp+jO/LQXAaTZNnaXPYrM27AhqUhnEPWd0/Y2aj9w5fE1T1q83hRM
	 o3QarmuHRkt1pqpmTPxn1ZHVEKNV7oEnXQtO+fihB0/VBIrikrAXGZxOHrpvmGEPsl
	 hVj4I0XAaR8FINvegB7MHLa45+LhQzFwIV0NxyJPmRbZB1PaQLyYKHW13rOtS4Rtx5
	 UQyIOAMB8U4Bw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AC32F81247;
	Thu,  8 Oct 2026 12:52:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 685CC2B2
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 11:41:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 59FDE40456
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 11:41:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sjijR51y0LZ2 for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 11:41:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 3DC0340427
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.95
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791459676;
 b=YyCMn55s+mJ6u3O7BZWFWx6WYfgmc0TO4f195MPuxRs8fkJO+8dsKcAjWWb7lS79DLQx
 jwoT4w8D0+8B0QP9BYwHTiwcAaSd2Sb91J4SYYLMyHSttDS2vTGH5y7vjrKWD1gvfMEME
 VMELCN4bgsyveB99Rmvf+mlMVfE44RzJOWUhq3wSoA5IqIF6NOgHc2DPn6oCrZmwOFlJb
 GOf8w91wVhmMDEVDGtX8dnutb+2vJ2g3cKcRzQcb1ihJYkEXc6jp9jzPiJSQ4WrHQThvo
 b0oItvK6aaRsng+d6MqNhjN+9FRt9uirsHSz9mtGgcMUmtza8EniGxQLS5B1oGcdN3A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791459676;
 h=Received-SPF:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:
 X-ZohoMailClient;
 bh=0VB5Uwb07lKJ3H8j05EwHFmv5G00QuQvQfWuyfxyzjo=;
 b=Bxf7FjCtbFVY/VQhDwiKeiOP1kyMPH3w1Wb6h09/fTa7ELaezy685bMWHdYynClEtvvO
 Dh/MMcxif3HtQZ5lPar0dsCTu0ydsLzJetGad1FfB0rpxuSzIaaraFObsOotDT7XYi7dH
 MVsxDAsGTZ+s6R6q4skVqoGrDRGyZ4fdtsuVoLPrCS+un0OMJsFYCSwlo6yiPEdCw+B9g
 d7NL/37KYa3h4a+hJFcbZbY+Xf0U7nc0Aq1XqVv9ntA3lcACnEOveoMqgq0YzFRPG9LOl
 v6hvaXmHH7rrVp+x9G+Vc2XkrkICukgpSx4sTwe6u6PTPNuDgFanRZWHCAbkbNApnlA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=zohomail.com; 
 dkim=pass header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=Igdj+RoP; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.95;
 helo=sender6-pp-o95.zoho.com; envelope-from=zhuxu_ran@zohomail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=zohomail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=Igdj+RoP
Received: from sender6-pp-o95.zoho.com (sender6-pp-o95.zoho.com
 [165.173.180.95])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3DC0340427
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 11:41:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791459612; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=jLHqT9oSfPS01Q7FnyqmRPLWIxhthiAT/aKinCtby6ounvVJ47zFZCgpgMCdfPeXwQhhhInta+lxEDdFb8xbJhpqlsqj7IRQeez5WAskzQn8EEDF/JWvPV71ZQIyXclW6KJdqWro3B+JRH71FgmzejQiJTFSS8PllQW7cmKMWiw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791459612;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=0VB5Uwb07lKJ3H8j05EwHFmv5G00QuQvQfWuyfxyzjo=; 
 b=MvdGnNu4NCE4j2lLIxe4XUVQ5MF7yG0fsLzcoewODTNqtULFlor+IfRjBmLyl790aA7bs6NqlE1C4r6smsk/7luAfjOvLit3FFrIWdRe7zWmrka7Ih8RprWJICJ2XZgDtwbptF60+VkSr1eEjNNew9lUU8+a4zgKng0uAKr/qVw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=zohomail.com;
 spf=pass  smtp.mailfrom=zhuxu_ran@zohomail.com;
 dmarc=pass header.from=<zhuxu_ran@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791459612; 
 s=zm2022; d=zohomail.com; i=zhuxu_ran@zohomail.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
 bh=0VB5Uwb07lKJ3H8j05EwHFmv5G00QuQvQfWuyfxyzjo=;
 b=Igdj+RoPNvAGPcNYWTJDjiyH2FkwZr/HYWX4ipzAr4GBnHTHjY/NPfRpgTMllUgn
 g5lA2K+7D3I5WaTByDdrMteGbJguWcsYTSMGVsuyLp6LgqiE5UizkxrtmdQRiO/iLDp
 gIp5RVdQk1o4zgfe9tLZ1/Dr//ds9FErn8r/NE0o=
Received: by smtp.zohomail.com with SMTPS id 1791459611263538.2745010227407;
 Thu, 8 Oct 2026 04:40:11 -0700 (PDT)
From: Zhuxu Ran <zhuxu_ran@zohomail.com>
Date: Thu, 08 Oct 2026 19:30:46 +0800
Subject: [PATCH v4 1/3] rtc: cv1800b: Add seconds counter support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-cv18xx-rtc-sysreset-v4-1-62cebd76d440@zohomail.com>
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
Feedback-ID: zu0801122731c70a51267cd6bee07cbf1b000073a70b345c00eb2aa7cef333f6a4a1d82213ad834951085791:ZohoMail
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

Add a driver for the CV1800B RTC seconds counter described by the
upstream devicetree. Map the node's register range, enable the RTC
clock, and implement reading and setting the 32-bit counter. Bind
the existing sysreset driver as a child when enabled.

Adapt the register definitions and seconds-counter sequence from
Linux drivers/rtc/rtc-cv1800.c by Jingbao Qiu.

Link: https://git.kernel.org/linus/d9f82683b123ce315cc36c4b20a5bc3d8644f947

Reviewed-by: Hiago De Franco <hfranco@baylibre.com>
Signed-off-by: Zhuxu Ran <zhuxu_ran@zohomail.com>
---
 drivers/rtc/Kconfig   |   9 +++++
 drivers/rtc/Makefile  |   1 +
 drivers/rtc/cv1800b.c | 110 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 120 insertions(+)

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
index 742481ce185..3c480156498 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -7,6 +7,7 @@
 obj-$(CONFIG_$(PHASE_)DM_RTC) += rtc-uclass.o
 
 obj-$(CONFIG_RTC_ARMADA38X) += armada38x.o
+obj-$(CONFIG_RTC_CV1800B) += cv1800b.o
 obj-$(CONFIG_RTC_DAVINCI) += davinci.o
 obj-$(CONFIG_RTC_DS1307) += ds1307.o
 obj-$(CONFIG_RTC_DS1337) += ds1337.o
diff --git a/drivers/rtc/cv1800b.c b/drivers/rtc/cv1800b.c
new file mode 100644
index 00000000000..4ef73ca05e8
--- /dev/null
+++ b/drivers/rtc/cv1800b.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025 Jingbao Qiu <qiujingbao.dlmu@gmail.com>
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
+};
+
+static int cv1800b_rtc_get(struct udevice *dev, struct rtc_time *time)
+{
+	struct cv1800b_rtc_priv *priv = dev_get_priv(dev);
+	u32 value = 0;
+
+	regmap_read(priv->regmap, SEC_PULSE_GEN, &value);
+	if (value & SEL_SEC_PULSE)
+		return -EINVAL;
+
+	regmap_read(priv->regmap, SEC_CNTR_VAL, &value);
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
+
+	if (time->tm_year < 1970)
+		return -EINVAL;
+
+	seconds = rtc_mktime(time);
+	if (seconds < 0 || seconds > U32_MAX)
+		return -ERANGE;
+
+	regmap_write(priv->regmap, SET_SEC_CNTR_VAL, seconds);
+	regmap_write(priv->regmap, SET_SEC_CNTR_TRIG, 1);
+	regmap_write(priv->regmap, MACRO_RG_SET_T, seconds);
+	regmap_update_bits(priv->regmap, SEC_PULSE_GEN, SEL_SEC_PULSE, 0);
+
+	return 0;
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
+	struct clk clk;
+	int ret;
+
+	priv->regmap = devm_regmap_init(dev, NULL, NULL, NULL);
+	if (IS_ERR(priv->regmap))
+		return PTR_ERR(priv->regmap);
+
+	ret = clk_get_by_name(dev, "rtc", &clk);
+	if (ret)
+		return ret;
+
+	return clk_enable(&clk);
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
2.56.0

