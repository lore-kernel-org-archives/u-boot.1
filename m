Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E33D5C5DF81
	for <u-boot@archiver.kernel.org>; Sun, 23 Aug 2026 20:39:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AC2CD60731;
	Sun, 23 Aug 2026 20:39:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d1CUsiP2BOhC; Sun, 23 Aug 2026 20:39:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787517582;
	bh=JcCDhufm1Z4JZBeUleoczxNT8kqNIw07eL5cEa2EO28=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zQrZrv/gxgqg9aOjQGiBgS0uF2/uHppPnMQ1V0pa9/kmzRhIPgf9dLPDNRIyyYA8l
	 u360lzY1ZvHFS3eiTJbf6aqbSOMgr4ubjC3YiWuDeeXZtENbKsqnf9buq5Ue5124pL
	 V/8a4Os2A2UnL9V64sDhN7v8DiDpAJxPTM43Q7Klue/r/QRGFvnIffBNCed4Vdwgwk
	 q2U160ZJR40IhBCtOu11HSSL4V4ZYmzR2fxrcOTFsicg9rrhR6JLyT5MDSSZpm63Z1
	 Muh0S3SludpUdBPCfg1F6KHCO4g/3hfyWhlCOAvg8uxWCxt6zSMbzTR1eHTzpvv+4Y
	 spgPRP3RfZIMQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CFF0160617;
	Sun, 23 Aug 2026 20:39:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DB9F742B
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 20:39:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C1C5740386
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 20:39:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BXqhIjCp9X19 for <u-boot@lists.u-boot-project.org>;
 Sun, 23 Aug 2026 20:39:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=linusw@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ZCyfTktp
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 307F440381
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 20:39:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 858FB43FD7;
 Sun, 23 Aug 2026 20:39:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F5CD1F000E9;
 Sun, 23 Aug 2026 20:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787517577;
 bh=JcCDhufm1Z4JZBeUleoczxNT8kqNIw07eL5cEa2EO28=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=ZCyfTktpPkNzDoEtulyjO+C909ARXnHMLsDGeeS7TGOkmZ6Jnw8Cqkmb/rh9kq/iz
 8Z6VmVBghRyd7nxsIIuzAS07iOp0YRlq2sERDoDs3HV2EgnE48AEJiVKjBiEA6g+88
 NEahAtwYFb3PxdGguPAxE8PRSFrys2TOGwL5vjqFz8wqZo+j7lTaLKULGH54zb2d7K
 YWd6wE4O2PL61ub04voKuOARGgUa1o8yjssDRq0h/tJSJIXeOt/m7eCCbcjxpJC6G1
 4Xoo/xrXPCdl264fgl/aBz6OrK+ASGQMZzjuGtUBigMSCZjBBgw7GeiS/PVEmcBfHA
 aTxcx7dWQwmdw==
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 23 Aug 2026 22:39:24 +0200
Subject: [PATCH v5 05/13] mmc: arm_pl180: Set initial supply voltages
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260823-ux500-external-sdcard-v5-5-07ca794e2b94@kernel.org>
References: <20260823-ux500-external-sdcard-v5-0-07ca794e2b94@kernel.org>
In-Reply-To: <20260823-ux500-external-sdcard-v5-0-07ca794e2b94@kernel.org>
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Stefan Hansson <newbyte@postmarketos.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0
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

Obtain the optional vmmc and vqmmc regulators and configure them for
the normal SD voltage range before card initialization.

Request the standard 3.3 V target within the allowed 2.7-3.6 V range.
The regulator clamp operation lets regulators with discrete selectors
choose the closest supported voltage. This selects 2.91 V on AB8500 and
3.05 V on AB8505.

Ignore the unsupported set-value operation for fixed regulators; their
voltage is already described by their fixed constraints.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/mmc/arm_pl180_mmci.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/mmc/arm_pl180_mmci.c b/drivers/mmc/arm_pl180_mmci.c
index 528612359789..8483d859fb96 100644
--- a/drivers/mmc/arm_pl180_mmci.c
+++ b/drivers/mmc/arm_pl180_mmci.c
@@ -16,6 +16,7 @@
 #include <log.h>
 #include <malloc.h>
 #include <mmc.h>
+#include <power/regulator.h>
 #include <dm/device_compat.h>
 #include <dm.h>
 
@@ -28,11 +29,21 @@
 #define MMC_CLOCK_MAX	48000000
 #define MMC_CLOCK_MIN	400000
 
+#define SD_VOLTAGE_MIN_UV	2700000
+#define SD_VOLTAGE_UV		3300000
+#define SD_VOLTAGE_MAX_UV	3600000
+
 struct arm_pl180_mmc_plat {
 	struct mmc_config cfg;
 	struct mmc mmc;
 };
 
+static int arm_pl180_set_supply_voltage(struct udevice *supply)
+{
+	return regulator_set_value_clamp(supply, SD_VOLTAGE_MIN_UV,
+					 SD_VOLTAGE_UV, SD_VOLTAGE_MAX_UV);
+}
+
 static int wait_for_command_end(struct mmc *dev, struct mmc_cmd *cmd)
 {
 	u32 hoststatus, statusmask;
@@ -445,6 +456,24 @@ static int arm_pl180_mmc_probe(struct udevice *dev)
 	if (dev_read_bool(dev, "st,sig-pin-fbclk"))
 		host->pwr_init |= SDI_PWR_FBCLKEN;
 
+	if (CONFIG_IS_ENABLED(DM_REGULATOR)) {
+		ret = device_get_supply_regulator(dev, "vmmc-supply",
+						  &mmc->vmmc_supply);
+		if (!ret) {
+			ret = arm_pl180_set_supply_voltage(mmc->vmmc_supply);
+			if (ret && ret != -ENOSYS)
+				return ret;
+		}
+
+		ret = device_get_supply_regulator(dev, "vqmmc-supply",
+						  &mmc->vqmmc_supply);
+		if (!ret) {
+			ret = arm_pl180_set_supply_voltage(mmc->vqmmc_supply);
+			if (ret && ret != -ENOSYS)
+				return ret;
+		}
+	}
+
 	gpio_request_by_name(dev, "cd-gpios", 0, &host->cd_gpio, GPIOD_IS_IN);
 
 	ret = mmc_of_parse(dev, cfg);

-- 
2.55.0

