Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB2D7CA9ED5
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 05:37:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 95C2B606F8;
	Mon, 12 Oct 2026 05:37:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W8mfvH69o6gy; Mon, 12 Oct 2026 05:37:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EAD1B6072B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791783426;
	b=AGTqlqsfePd1cuKcpQaRi6OiS5nH5FTfCztVIxDp3iqglEFZ715VO+9g8hOCj0Zlm8+g
	 lWxUo1e+9g9uJ3u+6l7orlPS1atnvxefJS2d1V0SFbLoukWrqe3uQynauMeEq0cDuZGy/
	 KNzdIn1nWqxQsgCDPe24ZMbQl54TcXCT+USIdsJwVGZxRH+nu16bWUE92r4VEaJ68Z3az
	 UYHSyK9iYWjoBbm0SWj5jqkXDcdva15oNxLmfoqUZaf/0GL90Z2EdSbbeVNG0ER/f5xvS
	 pVlEaCFuYjjuYpQ6FQHtRARjrkLtCdHYUKWdVqpGcWAQNFS2/rancoZApBx6RaHzrcw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791783426;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:X-ZohoMailClient:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=j8UDNZYlSwvNZN93odJaVd14X6XbTq99QdUuVrJpyrI=;
	b=CgCqmpzW7If9hqNbTBSidAM8+AZQO8LzCUI120Sl3jxxc1mH9RjMs4QoB9oOhu36rpYV
	 FY2N4ZhzvWIkIZVM9vcX2z8gAQCvlj/EeyEAdcsT9w1S2h2f9JR/8KOdpGcDTJUJQdXpb
	 N78d1alyhdyxXbAqKnepEO0aLuznq0xdp6QKqpoPGHkITqzDNJUxS+AJxISvkGZqZQTP/
	 IpoOYDJSgpvQ1+PrEOIV2gseAvIQQiJ+a9LmxFx1edf6KQ+Sc07npVmqsW0bi+U5kYVGK
	 ru5llqMLhzSP3YloxfL46BLyCTcIVjezZbcvWKyqkzOaYNNr5c+hGyq05rPmHRdCA2w==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=zohomail.com;
	dkim=pass header.d=zohomail.com header.i=zhuxu_ran@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=C6ew5vy3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791783426;
	bh=j8UDNZYlSwvNZN93odJaVd14X6XbTq99QdUuVrJpyrI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vk8lOXTlViKaRjU0Jccz9L75pwqOwORl4Tqg3ONM86pnHzvBllNV0hfILXVZmZX/s
	 82k1nWCW9K8rNVxIm+0P0z6I3Bhj9uS0eMTc0i0JPWx538wMxiCZSLgGlKeopbZo7B
	 Vkbb/f00pIv2/ZNaLYYk9ClJ2tS0N43kQXULOoe02rbRgi9ets797fkqMYIsgV1Uhd
	 Hk1D5tFSjKdkkPxoCjN/0lk8P5fFMtH765y0RNwand8dzBWcFGSZSiwtQjEyos1ekK
	 rRJ/tYOM3jIMh9D8d4/YfJcjGkHwI2GQyKpJPjVuYCuubH8bMVDw7Odph6vQIWSylB
	 pPM7GGbfpK+zA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EAD1B6072B;
	Mon, 12 Oct 2026 05:37:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3BB8575
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 04:28:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 21B9B60619
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 04:28:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1e3XVl28YZ6K for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 04:28:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 20EC2605F1
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.95
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791779296;
 b=rliq0OkWJ5g6RMXorvgCTK1e5BnZ9U670oNDP8FBXJY4TqEoY/okb1Za5wDMVvZzM0St
 xQxc2ZeOXkwxZKqL4JN5zFTY0ZeWPvEMGvMUEvPgugqfJAWfblGeT4v49S68wbwJxJWKB
 AqVfFrHU1hijkjMA04r8apqEhROHSqFbu629s7M/+UizXhG1TmC/jmbRWnsLcMGO+Yf0V
 rENvUuNFm9cy6tK+qrgQzyDR3e28ijoedDX5uRD6etgEvlux25B94r1zHvwzUlmie/EYc
 GsdyqEs0BKApLd0WoxMx2g95rsFSYbZ48zUSAh85hijjd5DKzqS2i/1+8MrKbP8ujag==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791779296;
 h=Received-SPF:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:
 X-ZohoMailClient;
 bh=j8UDNZYlSwvNZN93odJaVd14X6XbTq99QdUuVrJpyrI=;
 b=l67dlPLJEZMrDMy1h8FB5Vx4IhnzrCppM+mrejM8084eDVj4pFjZ36gTBCYNqjXx8k1Z
 i6blodpWUNkCxWfQc3nvWg57BIlnIMShm3FZKSNhjNBOIybIhvTaWbeGZNo8lRyo7rggI
 RY3YIDP5tiusClkemw+64YbLXqeOhmJ2N1Ray8Tm4bx7erreGN+fdlTrbjKCGIMdS0qB7
 j04dbWkux7/fiuMICvRCPadYQ88MWRIGR0WXAr4hBcoxOcBN7FL32r6pqudQ09mAvstLI
 HhqE2AIrj+w1gq44HVkgRa+ezvVNwg4qk7xrQcb9ZyMHwMOuWDO8WtWJG3Tg60CDV8g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=zohomail.com;
 dkim=pass header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=C6ew5vy3; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.95;
 helo=sender5-pp-o95.zoho.com; envelope-from=zhuxu_ran@zohomail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=zohomail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=C6ew5vy3
Received: from sender5-pp-o95.zoho.com (sender5-pp-o95.zoho.com
 [165.173.182.95])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 20EC2605F1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 04:28:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791779228; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ZuhwN8EqQWZ+qBwZwhQ7FD8XXYCfo6L0iAmH4fku14rFEV/jv4/TfTc5oxoD2pfsandGD8pch5d2TcPuQMmXIPQiv4Lsx/rc7psyxhlWv0ICjhbvszh430ks3eeRvLNmSi751NAaMdvtRYYUtcx1jXzk0TG5Ojvjxuetrppcez8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791779228;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=j8UDNZYlSwvNZN93odJaVd14X6XbTq99QdUuVrJpyrI=; 
 b=HNU+Bzu6e7GViwya3aCJM29+EbZT1KTJMXGbUFTTCtD4vNjQirdsGLL1crkdNj+YNY/AndfXHHz51t2Yp0AQr6PTRcx2kzv9neYIOvjUlTp+jJlo7oC8zA8ioulBA0yL+UJxaOwBgV72hnNt4uPXwY3NifT2jnh7jAGUXjPhljw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=zohomail.com;
 spf=pass  smtp.mailfrom=zhuxu_ran@zohomail.com;
 dmarc=pass header.from=<zhuxu_ran@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791779228; 
 s=zm2022; d=zohomail.com; i=zhuxu_ran@zohomail.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
 bh=j8UDNZYlSwvNZN93odJaVd14X6XbTq99QdUuVrJpyrI=;
 b=C6ew5vy3rG9Ce7wR28pGE696bq7ohu5lHaU0E1BL/BB8fa2+eXj+O1RZHSnvMvN5
 oCd+pN3Ros4jLasv7IFBp8eiQT196kSetsUX3Hg/B0iuZqJc6oHXSNYPqYj6zDzqCS7
 tEFV+vToG4RgHL8wvzWwR22Xs002r79XszCbi1Vs=
Received: by smtp.zohomail.com with SMTPS id 1791779226503540.3782640273357;
 Sun, 11 Oct 2026 21:27:06 -0700 (PDT)
From: Zhuxu Ran <zhuxu_ran@zohomail.com>
Date: Mon, 12 Oct 2026 11:47:33 +0800
Subject: [PATCH v5 1/3] rtc: cv1800b: Add seconds counter support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-cv18xx-rtc-sysreset-v5-1-413de1605cb4@zohomail.com>
References: <20261012-cv18xx-rtc-sysreset-v5-0-413de1605cb4@zohomail.com>
In-Reply-To: <20261012-cv18xx-rtc-sysreset-v5-0-413de1605cb4@zohomail.com>
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
Feedback-ID: zu0801122752575f1e6fecf4e756cf95c00000d73205b44509ed39b9642ef51d1fe43b6eb86ef7a6d52e2b95:ZohoMail
X-Zoho-CM-AccountID: 475a6e82b6074d1cdb8624e432e1257a5f0812bb6089f487c4846d9f660201e2
X-ZohoMailClient: External
X-Mailman-Approved-At: Mon, 12 Oct 2026 05:36:56 +0000
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
Reviewed-by: Yao Zi <me@ziyao.cc>
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

