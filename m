Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 995AFC61DBD
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 19:04:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 667C660746;
	Tue, 25 Aug 2026 19:04:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IztwjQXqJrHp; Tue, 25 Aug 2026 19:04:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787684662;
	bh=BVbANdBXdCoj/Vx5bObGAPlZDYkEFrChebf7auWZ398=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K9XA4Y33o+1PaOtiw2LUgYRnCLGRqRsffOY6MpD5QABsukSfbihV31RZk0jsVJ0NQ
	 3dcROKl+vHQwZkT9VhXFV1w7YvMr3kiKUXuzbmdjok/0oUHKunKG7JBeNzgucoOMci
	 m+FtuO2t3DS8w+EbBvpcfAl7cTfkjehhFR1IulzmhiEgMWXfOnZ74W8GxT/ZRMtYvy
	 UF212qO4l2L4JljU7J5uETkcr7uRVKxI6kWWlWKPUjQt2NlXXPLPAf3Z9hXnwB7UFU
	 85B/pmOBoLCM7fWFk6lIjG9JUAhxa9+bC1Lu15FzwIhE7GWDotuQ0fDlN1YEncppZG
	 KihlE+lct1qYA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EDB4660754;
	Tue, 25 Aug 2026 19:04:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 93AD3334
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:04:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 79E7880BA2
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:04:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8ZxXmaX584rp for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 19:04:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=linusw@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=DEqgEqdz
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D4B7180B97
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 19:04:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7C37760053;
 Tue, 25 Aug 2026 19:04:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06CC81F00A3A;
 Tue, 25 Aug 2026 19:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787684655;
 bh=BVbANdBXdCoj/Vx5bObGAPlZDYkEFrChebf7auWZ398=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=DEqgEqdzTt/ikzcaVg/2qx9628CfU+WNxp6aaUjwIzzKFyT9pUPsnNvTNrFI69iFr
 DrA3pd3cQZhJmgzLiFZV/9Ij5ui28tBmUaPYdyT8i+CouXGOoThWwaifBJec8bXEUX
 /v9NNorjJ62wYzMmGAF3KaafJwGThCmZQoUj8DizYusOzwu7aXuTh4+kd4DVFqQxrl
 lkbwVVbmowhNrc4/xuHU0bEUfldngGHlhtOAADgZekIiwswewpWmesA3h36xdjGyvq
 RLnRjd90srSi8n2NbqJVKD8Z2jKezAOFwFld50yQOEdYw1CO/hQhkstK/P6Vx94c6i
 r9FKBLBXv9TQw==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 25 Aug 2026 21:04:05 +0200
Subject: [PATCH v6 05/13] mmc: arm_pl180: Set initial supply voltages
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-ux500-external-sdcard-v6-5-61446b6c289e@kernel.org>
References: <20260825-ux500-external-sdcard-v6-0-61446b6c289e@kernel.org>
In-Reply-To: <20260825-ux500-external-sdcard-v6-0-61446b6c289e@kernel.org>
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
index 28eb367f2e0a..e4c22d4b0782 100644
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
@@ -444,6 +455,24 @@ static int arm_pl180_mmc_probe(struct udevice *dev)
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

