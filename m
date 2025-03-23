Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A263CC36005
	for <u-boot@archiver.kernel.org>; Sun, 23 Mar 2025 11:39:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 378FB81F74;
	Sun, 23 Mar 2025 12:36:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16CFA81F32; Sun, 23 Mar 2025 12:36:39 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 0269281D5A
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 12:36:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3145D339;
 Sun, 23 Mar 2025 04:36:43 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 77DA73F694;
 Sun, 23 Mar 2025 04:36:35 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Mikhail Kalashnikov <iuncuim@gmail.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
Subject: [PATCH 20/34] power: regulator: add AXP323 support
Date: Sun, 23 Mar 2025 11:35:30 +0000
Message-ID: <20250323113544.7933-21-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.3
In-Reply-To: <20250323113544.7933-1-andre.przywara@arm.com>
References: <20250323113544.7933-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

The X-Powers AXP323 is very close sibling to the AXP313A, only that it
adds support for dual-phasing the first two DC/DC converters.

We do not really care about this particular feature, so just add the new
compatible string and tie it to the existing AXP313A support code.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/power/pmic/axp.c                | 1 +
 drivers/power/regulator/axp_regulator.c | 1 +
 include/axp_pmic.h                      | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/power/pmic/axp.c b/drivers/power/pmic/axp.c
index 521a39dd566..fbe9bf239a3 100644
--- a/drivers/power/pmic/axp.c
+++ b/drivers/power/pmic/axp.c
@@ -88,6 +88,7 @@ static const struct udevice_id axp_pmic_ids[] = {
 	{ .compatible = "x-powers,axp221", .data = AXP221_ID },
 	{ .compatible = "x-powers,axp223", .data = AXP223_ID },
 	{ .compatible = "x-powers,axp313a", .data = AXP313_ID },
+	{ .compatible = "x-powers,axp323", .data = AXP323_ID },
 	{ .compatible = "x-powers,axp717", .data = AXP717_ID },
 	{ .compatible = "x-powers,axp803", .data = AXP803_ID },
 	{ .compatible = "x-powers,axp806", .data = AXP806_ID },
diff --git a/drivers/power/regulator/axp_regulator.c b/drivers/power/regulator/axp_regulator.c
index 75cdbca30f6..7794a4f5d92 100644
--- a/drivers/power/regulator/axp_regulator.c
+++ b/drivers/power/regulator/axp_regulator.c
@@ -318,6 +318,7 @@ static const struct axp_regulator_plat *const axp_regulators[] = {
 	[AXP221_ID]	= axp22x_regulators,
 	[AXP223_ID]	= axp22x_regulators,
 	[AXP313_ID]	= axp313_regulators,
+	[AXP323_ID]	= axp313_regulators,
 	[AXP717_ID]	= axp717_regulators,
 	[AXP803_ID]	= axp803_regulators,
 	[AXP806_ID]	= axp806_regulators,
diff --git a/include/axp_pmic.h b/include/axp_pmic.h
index ae62ef0d76d..1806a7270a0 100644
--- a/include/axp_pmic.h
+++ b/include/axp_pmic.h
@@ -33,6 +33,7 @@ enum {
 	AXP221_ID,
 	AXP223_ID,
 	AXP313_ID,
+	AXP323_ID,
 	AXP717_ID,
 	AXP803_ID,
 	AXP806_ID,
-- 
2.46.3

