Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E68B5C5DF74
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 13:34:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D8D09607D2;
	Mon, 17 Aug 2026 13:34:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H0LvSkAx1qd1; Mon, 17 Aug 2026 13:34:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 84D63607C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786973648;
	bh=FDu/oC9cF7oNrqyE/Y7iwyQDnDzchEFEUaakcDYd/es=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K37Qe+CPjhIniC8HCO0x+SB6eH05+x04+AGbidly+eyJ/Iga5CxByYwOaT6pn0G+R
	 UoGF5vXSyfubCGEBsWb27HDu06miAHb5OCL0pn2noKQMxicF6/G+IEgCHeQ9Q/wweN
	 2TqM7fr2TIn0Vxa4vm3/l+CE6CM0e/LJPJfsTJO5aLNNtl6cuML9SRgEfrll0hu31p
	 XUvCN6Sgem+S4fzUfyYSQl7kq0clFmNugT1r7Wqve9WsYKClht8ZHcM2qbmmPzui7a
	 4Ld7VtBbU0gz95s6oKb9JZnAV8TD9EmLng5W7FQKOVIe8cS1wK50AFCdCxu9y09Qo/
	 NNRpHjezkglfg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 84D63607C3;
	Mon, 17 Aug 2026 13:34:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D51F72EF
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 08:44:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BAF8580B4C
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 08:44:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KBlih6vyCzfy for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 08:44:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=linusw@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 1A12380962
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1A12380962
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=oPn3h8i8
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1A12380962
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 08:44:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 939EE4241D;
 Mon, 17 Aug 2026 08:44:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 495421F000E9;
 Mon, 17 Aug 2026 08:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786956260;
 bh=FDu/oC9cF7oNrqyE/Y7iwyQDnDzchEFEUaakcDYd/es=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=oPn3h8i8y5KPKDqSU1eOsTGcc7h9Sg6XQnRetnnz/Kno/LNvTWLO9MtmRrq0QhWN/
 dRrFAFAEBOJwf9AeJZZkY4WiHz9t71kC9Mt1q14/NmE0K3Ce3JlRFlOVZcCb1ncYJq
 WwXmWcsNdz8seSoGqA+VT00nRARdJsR4chtmIynU84Co97ja6TD8CE24j3zuMt6QBE
 eTzM0Ho4lA/tUwpcRIY5LkqFWcec+0PlACgkAKpTyuSJMJT1w43YRio+yz5zcWMxnP
 b2VT3c7AE/WwXRin/c4DtBtdmsFW26/5gZwojxX6dn28o/5u62LSJi1+sH3GIZReEz
 bF8auSu3EEz1g==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 17 Aug 2026 10:44:07 +0200
Subject: [PATCH 3/8] mmc: arm_pl180: Set initial supply voltages
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-ux500-external-sdcard-v1-3-ce1a2d3aa91d@kernel.org>
References: <20260817-ux500-external-sdcard-v1-0-ce1a2d3aa91d@kernel.org>
In-Reply-To: <20260817-ux500-external-sdcard-v1-0-ce1a2d3aa91d@kernel.org>
To: Tom Rini <trini@konsulko.com>, Stefan Hansson <newbyte@postmarketos.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 u-boot@lists.u-boot-project.org
Cc: Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0
X-Mailman-Approved-At: Mon, 17 Aug 2026 13:33:57 +0000
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Obtain the optional vmmc and vqmmc regulators and configure them for
the normal SD voltage range before card initialization.

The Ux500 boards supply their SD cards from AB8500 or AB8505 AUX3,
whose highest voltage selector is 2.91 V. Request that exact voltage
for the Ux500 MMCI variant while retaining the normal 3.3 V target for
other PL180 implementations.

Ignore the unsupported set-value operation for fixed regulators; their
voltage is already described by their fixed constraints.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/mmc/arm_pl180_mmci.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/mmc/arm_pl180_mmci.c b/drivers/mmc/arm_pl180_mmci.c
index af21b814641e..654608b7e74c 100644
--- a/drivers/mmc/arm_pl180_mmci.c
+++ b/drivers/mmc/arm_pl180_mmci.c
@@ -16,6 +16,7 @@
 #include <log.h>
 #include <malloc.h>
 #include <mmc.h>
+#include <power/regulator.h>
 #include <dm/device_compat.h>
 #include <dm.h>
 
@@ -28,11 +29,22 @@
 #define MMC_CLOCK_MAX	48000000
 #define MMC_CLOCK_MIN	400000
 
+#define SD_VOLTAGE_MIN_UV	2700000
+#define SD_VOLTAGE_UV		3300000
+#define SD_VOLTAGE_MAX_UV	3600000
+#define UX500_SD_VOLTAGE_UV	2910000
+
 struct arm_pl180_mmc_plat {
 	struct mmc_config cfg;
 	struct mmc mmc;
 };
 
+static int arm_pl180_set_supply_voltage(struct udevice *supply, int target_uV)
+{
+	return regulator_set_value_clamp(supply, SD_VOLTAGE_MIN_UV,
+					 target_uV, SD_VOLTAGE_MAX_UV);
+}
+
 static int wait_for_command_end(struct mmc *dev, struct mmc_cmd *cmd)
 {
 	u32 hoststatus, statusmask;
@@ -385,6 +397,7 @@ static int arm_pl180_mmc_probe(struct udevice *dev)
 	struct pl180_mmc_host *host = dev_get_priv(dev);
 	struct mmc_config *cfg = &pdata->cfg;
 	struct clk clk;
+	int supply_uV = SD_VOLTAGE_UV;
 	u32 periphid;
 	int ret;
 
@@ -422,6 +435,7 @@ static int arm_pl180_mmc_probe(struct udevice *dev)
 		cfg->voltages = VOLTAGE_WINDOW_MMC;
 		cfg->f_min = host->clock_in / (2 + SDI_CLKCR_CLKDIV_INIT_V2);
 		host->version2 = true;
+		supply_uV = UX500_SD_VOLTAGE_UV;
 		break;
 	default:
 		host->version2 = false; /* ARM variant */
@@ -440,6 +454,26 @@ static int arm_pl180_mmc_probe(struct udevice *dev)
 	if (dev_read_bool(dev, "st,sig-pin-fbclk"))
 		host->pwr_init |= SDI_PWR_FBCLKEN;
 
+	if (CONFIG_IS_ENABLED(DM_REGULATOR)) {
+		ret = device_get_supply_regulator(dev, "vmmc-supply",
+						  &mmc->vmmc_supply);
+		if (!ret) {
+			ret = arm_pl180_set_supply_voltage(mmc->vmmc_supply,
+							   supply_uV);
+			if (ret && ret != -ENOSYS)
+				return ret;
+		}
+
+		ret = device_get_supply_regulator(dev, "vqmmc-supply",
+						  &mmc->vqmmc_supply);
+		if (!ret) {
+			ret = arm_pl180_set_supply_voltage(mmc->vqmmc_supply,
+							   supply_uV);
+			if (ret && ret != -ENOSYS)
+				return ret;
+		}
+	}
+
 	gpio_request_by_name(dev, "cd-gpios", 0, &host->cd_gpio, GPIOD_IS_IN);
 
 	ret = mmc_of_parse(dev, cfg);

-- 
2.55.0

