Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82637CA9ED5
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 05:37:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4DC836073E;
	Mon, 12 Oct 2026 05:37:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0L0HYtllqV0z; Mon, 12 Oct 2026 05:37:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 56A3460718
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791783430;
	b=nssJIpOYDHzCe5m8L4fAP5X9ler7cNilDVc+9cbW1YpPuHjQ7HM9tA04W6bMAyiH5XAw
	 iRLAaDAz0gDqA/Hr0YrY4yMriGyjJpkxI55cQiXTaXUyxI+DXsn9+mF1MWeWAI2OyNfqp
	 lo1QoSKhcrC2/+Ix6WOyf79jMfZRB+5n2EFtBDrzK4LnnIKMEMjkKPv17gW5EQ81X96MO
	 2KpJ6+6NgBu1WCpzhbahFpoJOVRmX0Lzx2cs00k0z7pQbRTwFhxVJQOnEKM53QxRkXeAG
	 mnqaeX2ZNeT9XsqnkRi1iU64YKE0cH6ZyLs3UANZlWRuzIb/TmnLB3xk1o/Nr6WBfLQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791783430;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:X-ZohoMailClient:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=RqrBEjTcwVFElJ46ks4PeTzcEAkxFmSQkqI3pI9Ia+E=;
	b=CLCS2RXvSA2rnLP4j97rzeV6f3ZKNakI+I8uTa7iolA9yA5cnCKZjMQ9ZZw9CLxmI+Rl
	 vcwr3KThhXUDnMn6kSgt4nU+bqGbePoAU2sG+19FwKvxxV6LzkDp+iNUpG+2k/34MDvPK
	 60G5iNXfG/6QCgk3gL4gLkCKWnatES0mbf/7yVFXSAstqbkt39V7yaVWO0IabJJGVBv8w
	 yGWp0kTaCYazRkg3lve8tfDywt7kXPCdpIv8b426xgacLZTRbhskQUhAlaOkRqAMJPHDO
	 hYB8QnK0tXs0nG/JLcbEs9W6A8DyeyI6p2S0Mb1tSfNWe+okzkQEiHTuSweA9JJkv3w==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791783430;
	bh=RqrBEjTcwVFElJ46ks4PeTzcEAkxFmSQkqI3pI9Ia+E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QSwQCuZRm9cGREwwm4Q7XbhGnfwG1D2dO8Z3+CvfzuI+BzfbB0V9IhJJpPAeLAsDf
	 8NQcsdUO8BVepcxIzqckkrJ+j173nnEBV/DVwrof3SzmjenqsWTuWAGeflmLPRQzt+
	 DmV2zNfpIA6/koaGUvZRKPgrfQwfjWkKqwwvPMr61+sCxD65x0f4hLCnxWcSom0tZY
	 ScKK80qVELdlvgQbMpvwlRUNiG1aOtFwbWxIo65P15NoY7VyMYObf//V2+JhQg8GN+
	 tlldo+fk1zEREa3O23buvN4CJ2TBzWBob6RHgPVwio0GImBVQBzkYRuedZTOoZc9Wg
	 xNXlfuBCMfhYQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 56A3460718;
	Mon, 12 Oct 2026 05:37:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 41BB81DE
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 04:29:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 27B0680CD8
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 04:29:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dEkTMgW4VP76 for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 04:29:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0293880CD3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.95
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791779358;
 b=db7cxdCvTx+bB+eSvn/mkg0l/FwLBboym2/NEuvjo+hNuRmKaD7ZCDXUMZVWaaA5TwZG
 jxyPLhmIyyROBzECV2IGBnVynH/Mjm5J2cRiBYshCLPSZ0RZYf1l1gY1xooDrgU4WZyOG
 jlpdtfFHwQOCcWVz6hpbZxUX7zQYP6/mZHH7jYWGeN9CfRUj0RM/UFASjl0DRkbv3L2fS
 PukUPNS1Om+ZMZQCB2AHZWanhD1xQr3g2y51QSdcMGYS3MxYBmY1T42w+ozcp+XUwdylV
 US9PTSH11mNNkyjSimtpTNNje2uxZ9/1Ht98puuvzR2fiTDNgwPCq0o1/kHBkRbGiFg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791779358;
 h=Received-SPF:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:Feedback-ID:X-Zoho-CM-AccountID:
 X-ZohoMailClient;
 bh=RqrBEjTcwVFElJ46ks4PeTzcEAkxFmSQkqI3pI9Ia+E=;
 b=hNBkRZJmBnBSJU/X4O/lfcxfqXFmCz6ZKgfg+OFuxgK+pBbXr3S42LdNgehk+4QJWRjS
 EDz4RyW/ihwJbhIUvGRsFeM7favwRUZ+Q7xvZN1zqjvffQPpLktSID5/ROEl8x0IjevFB
 JbnPDzXcL2Q8X1Quz3uVOcNRJgFasM7cQsGOcFBZKyWC46unwcIylokCsncUJatjDO6Eq
 IkofIjUG2LwuJkrFqdHf9ZrX65YCi9vSUj0l7EuO/6iPqhMTUPqd4ovSe3jcx7I443VS2
 +bkLmPd7dvCxfgu418wRcwNzCHfhBsZwWuXtZk9JT/dmbqdjbsIzEtXaRo1i25C37Hw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=zohomail.com;
 dkim=pass header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=RzoQZPNZ; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.95;
 helo=sender5-pp-o95.zoho.com; envelope-from=zhuxu_ran@zohomail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=zohomail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=RzoQZPNZ
Received: from sender5-pp-o95.zoho.com (sender5-pp-o95.zoho.com
 [165.173.182.95])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0293880CD3
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 04:29:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791779254; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=bS8o8oj0lhLU6rfbKNZaNfbkVmy/nWW1heGksyeL6r5EPA4wmFkZkzXB5cIHTKU4FpkQZe75HAi/ggQXTrmO11yoUNUM2uZAvNZtfJpQa61us9bCIoIHWgjlXneFhCD7Uycg7tCx1sgTSeL1AB3yKl2dSeHcFV0HgGbHOH9a3UE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791779254;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=RqrBEjTcwVFElJ46ks4PeTzcEAkxFmSQkqI3pI9Ia+E=; 
 b=TntL1OAUO1nS4VgxTIxJxy0fPQZPbbi377CKHKSWuk2eO+9nSVyR7+FO3/adqmmToe3b8Rl1NK0/ayV6KePvcAyAuxiFPs6EvNFtYm6xzOlcvB+2MCuoWXo9bqFDATL2uCvgEVzdt5sMcTFVB+I2febv9sb9kx2Km4Sd+KU/0nA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=zohomail.com;
 spf=pass  smtp.mailfrom=zhuxu_ran@zohomail.com;
 dmarc=pass header.from=<zhuxu_ran@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791779254; 
 s=zm2022; d=zohomail.com; i=zhuxu_ran@zohomail.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
 bh=RqrBEjTcwVFElJ46ks4PeTzcEAkxFmSQkqI3pI9Ia+E=;
 b=RzoQZPNZTO0h5f9YTd6XE480gQmTsZvz+Sxpik3+upiD+RBe5AScFR0iqi3ivRla
 1nSnc7voOkpjwEl0rRm7VnjjMtfsPWVWA9AYA76+W7hGOMlga/PlFcBGiYRvUqZEdaK
 3DQseKNovfGVgHFJ2gS3w1g7r48olhm2ph5T1yJ4=
Received: by smtp.zohomail.com with SMTPS id 1791779252199567.4944188595337;
 Sun, 11 Oct 2026 21:27:32 -0700 (PDT)
From: Zhuxu Ran <zhuxu_ran@zohomail.com>
Date: Mon, 12 Oct 2026 11:47:35 +0800
Subject: [PATCH v5 3/3] sysreset: cv1800b: Use the RTC device node for
 register access
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-cv18xx-rtc-sysreset-v5-3-413de1605cb4@zohomail.com>
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
Feedback-ID: zu08011227dd77dbced61c50e66e7643f600007b72b0fa6d7bb6b70d532c9711cdfd4c50f257e1b1d05319b7:ZohoMail
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

The CV1800B system reset driver uses hard-coded RTC register
addresses. Initialize a register map from the RTC node shared with
its parent device instead.
Require the RTC driver that binds the sysreset child. Preserve the
existing reset requests, including the warm-reset sequence used for
SYSRESET_COLD.

Reviewed-by: Hiago De Franco <hfranco@baylibre.com>
Reviewed-by: Yao Zi <me@ziyao.cc>
Signed-off-by: Zhuxu Ran <zhuxu_ran@zohomail.com>
---
 drivers/sysreset/Kconfig            |  6 ++--
 drivers/sysreset/sysreset_cv1800b.c | 72 +++++++++++++++++++++----------------
 2 files changed, 46 insertions(+), 32 deletions(-)

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
index 9cd62772ef4..74ba2c2bd8f 100644
--- a/drivers/sysreset/sysreset_cv1800b.c
+++ b/drivers/sysreset/sysreset_cv1800b.c
@@ -1,32 +1,34 @@
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
+#define REG_RTC_CTRL_UNLOCKKEY  0x0004
+#define REG_RTC_CTRL            0x0008
+#define REG_RTC_EN_SHDN_REQ     0x10C0
+#define REG_RTC_EN_PWR_CYC_REQ  0x10C8
+#define REG_RTC_EN_WARM_RST_REQ 0x10CC
 
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
 	[SYSRESET_WARM]      = { REG_RTC_EN_WARM_RST_REQ, BIT_REQ_WARM_RST },
@@ -37,28 +39,38 @@ static struct {
 
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
+	regmap_write(priv->regmap, REG_RTC_CTRL_UNLOCKKEY, CTRL_UNLOCKKEY_MAGIC);
+	regmap_write(priv->regmap, REG_RTC_CTRL,
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

