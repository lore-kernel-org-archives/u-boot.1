Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CB1DCA5FDD
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 12:48:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E7DFD4134C;
	Sat,  3 Oct 2026 12:48:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JGZrLLsdIh-0; Sat,  3 Oct 2026 12:48:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9039341126
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791031689;
	b=jZW28wEu6O/kQeBA5Hg7jccBP39Gq0z4GBKky3BUMBIBvVwQ5PAnN0JOIkPFBCU8mT4O
	 zvxgcLBW1+OyJasBWG26ATxZM9XSFk92tJ1sMOSAF8F3Bv1PABzNnGBS2BDeboGtO1/rX
	 maDue3neNiTQtd8WwEkNZJekbJC8dpp+HLeWuq/N1zV/FVHo8P7sZQHtbHIDmKb67oVwY
	 ial9Q/kvKozkxtQsjqg1esCVZ02SM3xoW9f94xoGsXQsmG8dRo61C2PfI8+51CaHpzMVJ
	 GZ9UlpqDl8krA70Fy0YcnhhaijBb3Ez+Cd2TTo7itE8+9ggO8dG5MriuWiga6WgvgYA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791031689;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:X-ZohoMailClient:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=p60Nng67Qw8cJFlVTsGlctic1HSwbbLsIhHAGmBz7Yw=;
	b=QCaDVMuCvqOkPOHsuwDsBFz/bsuQNNcLcZfCD5OIb7lFCNBfQ8JNi9lMX9SmV+j/rNtW
	 bVrFHQabeArsdS7tjMt3FqLauSz5wNQ9Q1Z0wQ60YTIKFqfuoGKOFaqExbrfoWGKIliPZ
	 /DfmS7O5vOiPbSRukSTIgg45yClppPOg/vPUd84gYorCpahzoSejBNgomjTYu17aRhQSX
	 AwHC12/myYPrE3mqllnpS8zgjLWhNZ1fsdOf5XSWB5EKYecVJ34tmGmzbaH6INnFCb6ep
	 pzah7HcLRNbwKmdnMf/A8yL6cA/nB0t0QO22RUMpAwqOaFlzMe5ck3R5aR683Rbe+ZQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791031689;
	bh=p60Nng67Qw8cJFlVTsGlctic1HSwbbLsIhHAGmBz7Yw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CJuYDKFXom2ZKNnoNWpJZq7Fj7CCE6DCAul6Xv6/9vqsRRsDQIozIKCwusJBdE/+v
	 QrSkYjOMrtkFmcdYOsC+76H+5h5nM3TZe+Ks5hPPG0ZrofSKaPGBg/TIpOB/GEZ7Tu
	 aWFmnHrdhD7LiaU5ydwSoGaeglewAW/De+Q8u3MkBjL4a8SFhWEUz9tEa28wikJL8Y
	 wT4NTS27aOL8WfgbTdVTu/qkPtybFIFnQRjT4+CyP7Hh/d0vloFL5+j2Pb3vXgGNA1
	 advGfiqW7GQgqUpqhiqtgs2i+hw21T5RNFAqJJn3ugkAFihTN/o5y/47N/tL9y5zWo
	 EmXn/D0+Lxerw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9039341126;
	Sat,  3 Oct 2026 12:48:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A68AB263
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 11:58:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 98BB460F0E
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 11:58:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y9Rm9RcszCVh for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 11:58:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 813F160DC7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.95
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791028709;
 b=b27BJJogL+akvfNE1QRRxod7y1SS4pzchE8ov8ETAAwCpCTariuPYsBJdSaqs8VjtGuJ
 SuJLQQu31wyhVKl9NjDUGAhLb5MbBPTOWEG/xH6/AcFBqyIRwSwwCUJBAyM2Ii4+0YiZD
 nCoH0+NiWQhR0xstK+qF+I8ZSyQyuTaF+mi7Wt0JWW9QhWEmjPAb+GMcEnU/emqFfAWtm
 w4y1VA06vYjBc3RqUy7keuQwh8BHDwyhUwn6r+Jh0o0288xnLo9WwXFNZ7NEJJgvPJeBc
 2p5oAjgA2W7zcOfV6B0pbuYii8+++F1j1suknEX3DgzrpQ6Uwm/nrCucDlxOQUbSfaA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791028709;
 h=Received-SPF:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:
 X-ZohoMailClient;
 bh=p60Nng67Qw8cJFlVTsGlctic1HSwbbLsIhHAGmBz7Yw=;
 b=LVF1edNwj+xIhL0od/WjsFBrE0SQT5JL+sDRv64oRgkewwik2tRzV7qNoM6cMxUgxpYV
 k9uevDHuy53tZSMAB5wVQYOmSoHRPHflgQj/ThhPJp2YnUyMZrcf9JUlNdci5fwmR9czu
 +o0TTBLM8eC7yB57b1rkF84TWTqyfE8Tp3yODhQEGpkDozC+xY6RlbdmghebokIuYKMit
 8t/3QJc2TAxKFNBXwB7FOO9qw5GWHbDGc1QdO59ocfZyWG+hWNPnirHV4z5qDcWS9Cjbp
 aFpSlPXvwLQkdF20p8kd0rZnRJRFtchqHm8hHomxSbjRL7zClnwJ2aAz4XJt2wds/qA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=zohomail.com; 
 dkim=pass header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=HynfIeQP; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.95;
 helo=sender5-pp-o95.zoho.com; envelope-from=zhuxu_ran@zohomail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=zohomail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=HynfIeQP
Received: from sender5-pp-o95.zoho.com (sender5-pp-o95.zoho.com
 [165.173.182.95])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 813F160DC7
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 11:58:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791028654; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=CzCTYM5K9BPSxpEcMKGQA4pPt9iK/desmuia7clV4OvhJhX20FlPk4hA34If8CnlsgF1kEyMnYjyC9BCScBu74MBkWgnwFiVMDBA5SkA2xNec7ngMhNY1knUEa996uEc5mfR1TuA1KNJQgq0nz8vHlNhKckP11TaU02N8duvskA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791028654;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=p60Nng67Qw8cJFlVTsGlctic1HSwbbLsIhHAGmBz7Yw=; 
 b=JEcNHwUyn2TMnkJB+4wrKU7ynG0NL+MY15A/HzSxqlrzDu9kQjhkVnPScKikQxD5e5ViEqeU8/kd0W8LJ/As/ILJcmRHXRwYQZhO9UUmRfZ1/JYsR8reuFdPRAqjO6XNsaEuA5zzXHoSksuCOmKGf9AaZvEH4Gc2WZH7dp3s6AA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=zohomail.com;
 spf=pass  smtp.mailfrom=zhuxu_ran@zohomail.com;
 dmarc=pass header.from=<zhuxu_ran@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791028654; 
 s=zm2022; d=zohomail.com; i=zhuxu_ran@zohomail.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
 bh=p60Nng67Qw8cJFlVTsGlctic1HSwbbLsIhHAGmBz7Yw=;
 b=HynfIeQPTsgiDA5xGLCds5W9NA3oucdEWfphXjBCAwiNYOI5lbiI96S1sKp2I6qz
 +pAx5nuXOxd3mkrUEccP5KKSPSDLZoIpZsfwsf1aQ9kSTuTh5VpL9KLn9jsaf5cZI/t
 sdz+nfSBvhRXxH28TlNioMU7jOx+XZwz9DulvJTo=
Received: by smtp.zohomail.com with SMTPS id 1791028653820629.3574829008472;
 Sat, 3 Oct 2026 04:57:33 -0700 (PDT)
From: Zhuxu Ran <zhuxu_ran@zohomail.com>
Date: Sat, 03 Oct 2026 19:55:06 +0800
Subject: [PATCH 1/3] rtc: cv1800: Add seconds counter support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261003-cv18xx-rtc-sysreset-v1-1-c0837e26eb29@zohomail.com>
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
Feedback-ID: zu0801122748c14ce75ab6caa223f443730000a6cca69749467142506be772bbe57ed9e6238b7ec7b267a943:ZohoMail
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

Add a driver for the CV1800 RTC seconds counter described by the
upstream devicetree. Map the node's register range, enable the RTC
clock, and implement reading and setting the 32-bit counter. Bind
the existing sysreset driver as a child when enabled.

Adapt the register definitions and seconds-counter sequence from
Linux drivers/rtc/rtc-cv1800.c by Jingbao Qiu.

Link: https://git.kernel.org/linus/d9f82683b123ce315cc36c4b20a5bc3d8644f947

Signed-off-by: Zhuxu Ran <zhuxu_ran@zohomail.com>
---
 drivers/rtc/Kconfig      |   9 ++++
 drivers/rtc/Makefile     |   1 +
 drivers/rtc/rtc-cv1800.c | 123 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 133 insertions(+)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 5b44cc99c97..547ac1643c9 100644
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
+	  Enable access to the RTC seconds counter found on Sophgo CV1800
+	  series SoCs. When system reset support is enabled, the driver also
+	  binds the reset function provided by the RTC subsystem.
+
 config RTC_PCF2127
 	bool "Enable PCF2127 driver"
 	depends on DM_RTC
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 742481ce185..961fe5409f0 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -7,6 +7,7 @@
 obj-$(CONFIG_$(PHASE_)DM_RTC) += rtc-uclass.o
 
 obj-$(CONFIG_RTC_ARMADA38X) += armada38x.o
+obj-$(CONFIG_RTC_CV1800B) += rtc-cv1800.o
 obj-$(CONFIG_RTC_DAVINCI) += davinci.o
 obj-$(CONFIG_RTC_DS1307) += ds1307.o
 obj-$(CONFIG_RTC_DS1337) += ds1337.o
diff --git a/drivers/rtc/rtc-cv1800.c b/drivers/rtc/rtc-cv1800.c
new file mode 100644
index 00000000000..3a2b7b25748
--- /dev/null
+++ b/drivers/rtc/rtc-cv1800.c
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
+struct cv1800_rtc_priv {
+	struct regmap *regmap;
+	struct clk clk;
+};
+
+static int cv1800_rtc_get(struct udevice *dev, struct rtc_time *time)
+{
+	struct cv1800_rtc_priv *priv = dev_get_priv(dev);
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
+static int cv1800_rtc_set(struct udevice *dev, const struct rtc_time *time)
+{
+	struct cv1800_rtc_priv *priv = dev_get_priv(dev);
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
+static int cv1800_rtc_bind(struct udevice *dev)
+{
+	if (!CONFIG_IS_ENABLED(SYSRESET_CV1800B))
+		return 0;
+
+	return device_bind_driver_to_node(dev, "cv1800b_sysreset",
+					  "sysreset", dev_ofnode(dev), NULL);
+}
+
+static int cv1800_rtc_probe(struct udevice *dev)
+{
+	struct cv1800_rtc_priv *priv = dev_get_priv(dev);
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
+static const struct rtc_ops cv1800_rtc_ops = {
+	.get = cv1800_rtc_get,
+	.set = cv1800_rtc_set,
+};
+
+static const struct udevice_id cv1800_rtc_ids[] = {
+	{ .compatible = "sophgo,cv1800b-rtc" },
+	{ }
+};
+
+U_BOOT_DRIVER(cv1800b_rtc) = {
+	.name = "cv1800b_rtc",
+	.id = UCLASS_RTC,
+	.of_match = cv1800_rtc_ids,
+	.bind = cv1800_rtc_bind,
+	.probe = cv1800_rtc_probe,
+	.ops = &cv1800_rtc_ops,
+	.priv_auto = sizeof(struct cv1800_rtc_priv),
+};

-- 
2.55.0

