Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC1EC5B572
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 13:34:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5931C40811;
	Mon, 17 Aug 2026 13:34:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eYKg1r4p2sdf; Mon, 17 Aug 2026 13:34:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A33DE40756
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786973671;
	bh=FDu/oC9cF7oNrqyE/Y7iwyQDnDzchEFEUaakcDYd/es=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HL7ox7D7EeombSTgF+JVNYBDq+CJBoT2PD8cKcywPsMqnuQXMMCLbD/OHsVAZ3tBm
	 F2iHImZfA+Aed58bYPamebV/V2IMHTAg0EvsoXOB3vLIEX2qZC7Ki/1qYERrQ334aJ
	 bxsw/fkmYJYzSEEtg7zctJPNkMOWSV0qxncMj5aXBxErAGeGoyeX1pMxrlOFOPuSB5
	 /2rXJmiegvNWpwKaNf1ZsuNjCncy/UJ7kEJEgHP9K2Ss0k4WbzXsn7x6RMLmB/kkVQ
	 ubbN/QVW1hSCoXv1EbswlOGeTVBUg8T7zG/GR+nmjl/LqbtpO+tcE5saR6npoFtlrz
	 h87imEAmxoIMw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A33DE40756;
	Mon, 17 Aug 2026 13:34:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C02AC333
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 09:31:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A607A80EC9
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 09:31:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u8mOeO5Rlm4l for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 09:31:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=linusw@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 1540580EC5
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1540580EC5
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=EsFsRfRn
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1540580EC5
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 09:31:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C7DF343BB7;
 Mon, 17 Aug 2026 09:31:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7878A1F000E9;
 Mon, 17 Aug 2026 09:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786959118;
 bh=FDu/oC9cF7oNrqyE/Y7iwyQDnDzchEFEUaakcDYd/es=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=EsFsRfRnwKASqeX17c63ihg4P/0g85YA24IHpBf5lV4+GRAU8K5/KoxCf35RkpWw9
 msJeOne/rCRuCLUKPvZYfBIvtnbh2DvHUNm6QrACsaMu7VXW0hgNFVHSnm/MFmAYn5
 ZODqKhqQx3AB2XyuRNbjK9Nzf3ecjsiVZnb3I7vYuMs0Y3dqUBNFjhSe64k31b27wz
 OK4eNBOGkQurvfgIoribZdlPfFNBzB8PUdxj/Aze2kORd6v7Or+CkgPeEQGQWTQCEu
 kCYYXjaM63KrD+fqIqPnsuCqXtvm1DgfK/mmArGFn69XPx6NvVmv4XbvSbmlgzclgb
 8Lcox/pgEto2w==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 17 Aug 2026 11:31:52 +0200
Subject: [PATCH v2 3/8] mmc: arm_pl180: Set initial supply voltages
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-ux500-external-sdcard-v2-3-ca9a110bd9c6@kernel.org>
References: <20260817-ux500-external-sdcard-v2-0-ca9a110bd9c6@kernel.org>
In-Reply-To: <20260817-ux500-external-sdcard-v2-0-ca9a110bd9c6@kernel.org>
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Stefan Hansson <newbyte@postmarketos.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0
X-Mailman-Approved-At: Mon, 17 Aug 2026 13:33:58 +0000
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

