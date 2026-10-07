Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43D2FCA5FFC
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 13:16:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B8630607D9;
	Wed,  7 Oct 2026 13:16:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bmpO7xJna0j3; Wed,  7 Oct 2026 13:16:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org DD96660789
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791379017;
	b=OAlWLPbrBJ0d+/qyPea/n2t9qzxaaxTplPRQLL7j1wFqXMwR5ewXB2Ml3DkSVuiA3g7H
	 C6aMMmcqU51g9AFW5v0y9QGKrVSJQTFDYb6+2RgIGPosDWaR5eh/aCk4l2I6JEV7a0spu
	 Wt5yGfgypW7gM8VpfpeRrNxI3u0guddzzrjH4vw0q7K/1tDk2sp0H9Rzg6aB+kFfKgyGQ
	 N/DhfVR2Xggr5UA2DnOmymXDDqHuUq8WebTjDpYp9mSyDPc7vIMLiN+PTTODSIsT4IW2u
	 +qhnprhGpBKP05ktJqiWuh3r9rPz7Vvag/jWQrngOH/Ni5utcE3VkfEwL7iGmO6o41A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791379017;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:X-ZohoMailClient:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=2Yczko9kF3iI7aAW2jZYaVLWpLv2g1W+8nFKWgKkGwc=;
	b=gBlf4bTi3PD7z2bb/Y+LA2oNFQoZ6xzQOXPnsW6En1OQb6+t3n/pr6T6bx3CsHpjdufe
	 xydmyc5Q4FMakZnmUpyIBrAA9dX3Hk1lQQRFbXGn9SOZFEdtU6wFoVYP7QCtDsVd3AElY
	 RV14MPEgZXB/qrDfPo2jiPlDoEKzvqXyM3leXLxEZ6FJSixoWTUkAqm6n/AIg3TDR/OyK
	 Q27yHWi0J8CeF2DNVU+t3plYqkz/H9po6K91QDvkb2k6z2w7IcoBdpNP6o5+KsQTwdo8J
	 9Zix3UbbRbhGjXkDz/aGkhg5cXaqlxxe4c1HKNxKmIApmqz4LHo3LR7GOULZCNUM++g==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791379017;
	bh=2Yczko9kF3iI7aAW2jZYaVLWpLv2g1W+8nFKWgKkGwc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SliVbtkNVPX6Y/ojRvEVnkAOrJbfMUpAq+Hi3Uo9mynU/kxTl2L5p35sDbjxFLw+Q
	 pVSt1kwtFsSrHuxsjBUPpsi4bMTlR6BDuIfZOfUtwbnlO16v9LOB83bSmhBazM+yjd
	 bE7ZPQD0il+Geb//W/P5Mn8w/OE+BlD/sl9ztz4RroYWUILcYVC5X+zwElj8lKoeZR
	 1N3QjsW8ilTXFoLjFYRbyiTMW6H/VlUmbqw6ifavC4w+BZpZl8UJ0D1slUrW/kNqI1
	 3M19qFhJ38jPLVa1wE7WBGnmkOglEiTiPVNfNpgBGRntCchkjW8KihLc5thU302M6c
	 2GuAhDVChushA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DD96660789;
	Wed,  7 Oct 2026 13:16:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B6A8232F
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 04:24:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A845340070
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 04:24:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KXZ8XAJb5VRJ for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 04:24:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 98A0D400D0
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.95
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791347042;
 b=SYLZLhEh/fR+JVlWndV3/u9/Sko1XU+gFiD0suHtNbRGIPGkYhhO4ApSmbBCIljrfzwb
 j2qCXpsaaDKBb5WAtRfECcCUAqQZv53GjwC2TOiIyjSKNZ6Yz9szjjNunOsGycD+kaEmq
 HE6L/OxbUzw5bknbt+IZdSrO+TNk/MIKga3NYQpeuIg77zZ+edACexJ9IiOKajTm483SZ
 4POze7Pb7BAxUelqLsqOzQovFcM5OJyc++7ni+IZpNZiC5qeIWOcCY+vHrfAORzCb1B0C
 mHZnhKUFmV/E79rYVK8VvuFE/gEvwDI+O0A+xqVcASAY4fkwQkAExY3wnx/zgtn0YaQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791347042;
 h=Received-SPF:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:
 X-ZohoMailClient;
 bh=2Yczko9kF3iI7aAW2jZYaVLWpLv2g1W+8nFKWgKkGwc=;
 b=kxeyh0YWl9M9Rt/gn9TWPPxO1pm6V5NB/SlxnskBrV9fjbHvseXJfIEgPM57vLQ1ASiz
 l4hl13D/XWqfOO5lxkwPvs19EcgvhVyBZZHbTW7OV2cM4kvalOq2XiFf99fpQ7Cy5TtDg
 JcXBpynh/0AQlmyzjnnOF8sMjkZ8vZu7DJU+YL3YNN6JGeeQuUcmwpEPZWDVQzlRLn+n8
 /1fTcT1+Xt/i/u5jnMEUl30S1vNjgS5GNLZeRFO7JpzN8SGLaOO3GkARfTVGRij+PbPB7
 MHxoK204nYWbJD/u34zXud9CBzJlNgQTHk2GYStMAZMqno1C/sdFEAQ0UkxMX92NICA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=zohomail.com; 
 dkim=pass header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=e0vtIFZA; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.95;
 helo=sender6-pp-o95.zoho.com; envelope-from=zhuxu_ran@zohomail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=zohomail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=e0vtIFZA
Received: from sender6-pp-o95.zoho.com (sender6-pp-o95.zoho.com
 [165.173.180.95])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 98A0D400D0
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 04:24:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791346984; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=gnFHs7nX5B69ToclgFcvipZvLZVRyP663UnOLT1JJrzVA149e1ZXVg3rk2QvMuIxGWMY/FEYJU9dnxG+MWvWztiCXP4DaOKs/Yi/QlwWi1GtooCr4WGfu10xYG8wdeNy+jZBs9cJmjX+lgcxWwU8GzRvqF6KJ9mNK97XcX4vhP4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791346984;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=2Yczko9kF3iI7aAW2jZYaVLWpLv2g1W+8nFKWgKkGwc=; 
 b=WjVHB82BmMKHRPoSIDzC05PG70Ej+C4dMw3YH3LWX0OvwFfXNx/j1wOC6yJnFhHOR963C+35hl/hy/f9SLKaG6gaw0hLbCBki6CfdkOKcZiVZ+v5dzc/9YtZXQfS4hiMkZOXwqZsu1DqVfzVEfg1HrhSwv9Goi7UV4lVUkEuG0Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=zohomail.com;
 spf=pass  smtp.mailfrom=zhuxu_ran@zohomail.com;
 dmarc=pass header.from=<zhuxu_ran@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791346984; 
 s=zm2022; d=zohomail.com; i=zhuxu_ran@zohomail.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
 bh=2Yczko9kF3iI7aAW2jZYaVLWpLv2g1W+8nFKWgKkGwc=;
 b=e0vtIFZAEk2lKJHzXMqC98ZhJVnWWDzUOqZg2Rhg1oJqvqD9hlg65mMLTNdPv2aF
 1mYCKKZy5RSZa/TOYv7YiYKZSG67AIN2XCIwKyr+LqY8fDJbxmCDq3+lkvD+PNqHTVU
 mTCc2ljM4W7/hRt6G9KX94YfOWnOYiAYS7vOJOrg=
Received: by smtp.zohomail.com with SMTPS id 1791346984106888.0517748520034;
 Tue, 6 Oct 2026 21:23:04 -0700 (PDT)
From: Zhuxu Ran <zhuxu_ran@zohomail.com>
Date: Wed, 07 Oct 2026 11:33:05 +0800
Subject: [PATCH v3 1/3] rtc: cv1800b: Add seconds counter support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-cv18xx-rtc-sysreset-v3-1-194557fd5e78@zohomail.com>
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
Feedback-ID: zu08011227a68da8724296c9b97312074e000063eaafe8c0b81f10a2201077c1a1a03fde9a629a25e9c0f9e7:ZohoMail
X-Zoho-CM-AccountID: 475a6e82b6074d1cdb8624e432e1257a5f0812bb6089f487c4846d9f660201e2
X-ZohoMailClient: External
X-Mailman-Approved-At: Wed, 07 Oct 2026 12:54:58 +0000
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
 drivers/rtc/Kconfig   |   9 ++++
 drivers/rtc/Makefile  |   1 +
 drivers/rtc/cv1800b.c | 123 ++++++++++++++++++++++++++++++++++++++++++++++++++
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
index 00000000000..e98efb319d7
--- /dev/null
+++ b/drivers/rtc/cv1800b.c
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

