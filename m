Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A88C624C6
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 09:13:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 14E0140730;
	Tue,  1 Sep 2026 09:13:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2WQ5hpCs9ehP; Tue,  1 Sep 2026 09:13:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788253998;
	bh=4qNbJWcf2NQIrACe8XEXF921kJTeqqOf+41ZC380Hag=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BD3N5i2u+wovaUlQEiTRgOiKKptJ1JcXPNHNDqrnuEKLYJjZi1JCtZM0BWQyTMUmV
	 D35w6iv8EwT84KyAbwpYtHmScy0u/DjnUxMh4gSwtRPmNI4GRwb6o4qgjRAZtOFIxZ
	 nlH3kU0AW6LeVPCzuPOIp/3GU6UwN5lCOQA1I3o4xPd32hpB2B/SFD/oGIlmaTqB1E
	 9xFXaHk5SOBEcwArpaqoHfqLvLej//M3BBRpHR2M5QGMNgNRsPagzAp6RenRUVZ0ns
	 a5BSAMwGS0cMvEKSZZIj0XEi7BL2PSmTmrvRzcmN0bVCIsyQxOfwrZrw3ayH7TIWJm
	 jJJ7ts7+AaDYA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 731FB406DB;
	Tue,  1 Sep 2026 09:13:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id DBB2A105
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 09:13:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BECD360754
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 09:13:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kYAjyKA_iXYR for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 09:13:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=linusw@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=BcKmWxdc
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EE40260737
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 09:13:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 365FE41A3C;
 Tue,  1 Sep 2026 09:13:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D7AB1F00A3D;
 Tue,  1 Sep 2026 09:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788253995;
 bh=4qNbJWcf2NQIrACe8XEXF921kJTeqqOf+41ZC380Hag=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=BcKmWxdcMb6IeDdpTkwqioI2E2tmCkLiSeMphaDuYJb6+xurai/2abp1pwteeD0di
 IY3ZmJwW7tIWLxjxMItGhQ60wZ7Qai6EIgI+J7/8yfpMOUzvnSbJQWNeMyMmgIOTs0
 6PqhKKUn1WrZ3UZa69+lr4SM0AWhACD+coT0Zvioh5u+rLNLB7iXDT6oLYBzm1rKHj
 GAfhPSkLUJVSPCXA+3XdQW2DaP3gnI7KoIjGE/RN+NbeosZlJMdXXHwsiQGpvpYA+g
 882Z8JoqwIh5vqoDK6XnKXBHyUwa1l+OPLD2Y45rAJluueAWq4gU2R1QX+mGMD0FT6
 40FZy9rPLSmEQ==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 01 Sep 2026 11:13:03 +0200
Subject: [PATCH v7 05/13] mmc: arm_pl180: Set initial supply voltages
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-ux500-external-sdcard-v7-5-427923e9934b@kernel.org>
References: <20260901-ux500-external-sdcard-v7-0-427923e9934b@kernel.org>
In-Reply-To: <20260901-ux500-external-sdcard-v7-0-427923e9934b@kernel.org>
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Stefan Hansson <newbyte@postmarketos.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
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

Acked-by: Peng Fan <peng.fan@nxp.com>
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

