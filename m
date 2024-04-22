Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31874C07E8F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 09:48:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72C2B883E8;
	Mon, 22 Apr 2024 11:48:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ltts.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ltts.com header.i=@ltts.com header.b="DXFmB+Cc";
	dkim=pass (1024-bit key; unprotected) header.d=amazonses.com header.i=@amazonses.com header.b="JOPzZdZ3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8041F883DC; Mon, 22 Apr 2024 11:48:37 +0200 (CEST)
Received: from c180-16.smtp-out.ap-south-1.amazonses.com
 (c180-16.smtp-out.ap-south-1.amazonses.com [76.223.180.16])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4177888379
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 11:48:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ltts.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=0109018f05350bb8-2b265fd0-13de-4561-a497-d571ff720ff3-000000@ap-south-1.amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=i3fe3efcd4pbz7ipgssfqjhzqx347xbc; d=ltts.com; t=1713779313;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=LHx7RuJyHy/Jhv2KFY70YEo8We+UaMIDcBLvDTAU7AU=;
 b=DXFmB+CcRC9sAb98jNlm1UfKHnnZWCYKKZy+LR6mtIerRsK4QPfcMRLxeUIASNkd
 EkvSPeTO7k++ybhyccK43auTimcIaI2Xi11fn7nGdIvoc2xA+/oGUcdfukAF+/CQETh
 XFr7biEEfC00BRomO8dyn2amPDYIzAeFP02hM++W33fzS5uK6NbUWcHKfZDikX5Ylue
 HRNPQ8zOZvzYdMRbJI2lbzpD6Q3XyLJm2Pr5SO5XpuhPr9fQ3seosEHqz+aWZQ1aM5m
 5aRLTUL6woB3VlDHsxyM43LQ4nVJen9JU0MuloHp89VTHc1VYEyc2ONNfH9zV6kspX0
 lnFQtJzHPg==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=zpkik46mrueu52d3326ufxxchortqmoc; d=amazonses.com; t=1713779313;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
 bh=LHx7RuJyHy/Jhv2KFY70YEo8We+UaMIDcBLvDTAU7AU=;
 b=JOPzZdZ3hwHnJ1yVX19+1c6UlJ90al6j9EUqEE1AsQKHV4ow6D4UKgNzUa9xWnzs
 +nqbZznmnK3IIsuvfhI1OKJvykEOWC3TGxqXOCLEzJ0UcXlVEDhe1nvhRoh+0JJPSu9
 wHHor9FV0X9mMScjJxP9N0X7U2yqUvHtfNup/BgU=
From: Bhargav Raviprakash <bhargav.r@ltts.com>
To: u-boot@lists.denx.de
Cc: d-gole@ti.com, dan.carpenter@linaro.org, jh80.chung@samsung.com, 
 sjg@chromium.org, trini@konsulko.com, m.nirmaladevi@ltts.com, 
 Bhargav Raviprakash <bhargav.r@ltts.com>
Subject: [PATCH v4 1/5] power: tps65941: Add macros of TPS65224 PMIC
Date: Mon, 22 Apr 2024 09:48:33 +0000
Message-ID: <0109018f05350bb8-2b265fd0-13de-4561-a497-d571ff720ff3-000000@ap-south-1.amazonses.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <0109018f05328901-68599362-7b54-47e2-b54f-aa081ca231b9-000000@ap-south-1.amazonses.com>
References: <0109018f05328901-68599362-7b54-47e2-b54f-aa081ca231b9-000000@ap-south-1.amazonses.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: 1.ap-south-1./RC/PI2M8xOxQmTMPi0M1Q8h2FX69egpT62QKSaMPIA=:AmazonSES
X-SES-Outgoing: 2024.04.22-76.223.180.16
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

Re-use the TPS65941 PMIC driver for TPS65224 PMIC.
Add additional macros of TPS65224 to aid in the driver
re-use.

Signed-off-by: Bhargav Raviprakash <bhargav.r@ltts.com>
Reviewed-by: Dhruva Gole <d-gole@ti.com>
Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 include/power/tps65941.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/include/power/tps65941.h b/include/power/tps65941.h
index a2bc6814ba..cec85333f0 100644
--- a/include/power/tps65941.h
+++ b/include/power/tps65941.h
@@ -3,11 +3,14 @@
 #define TPS659413		0x2
 #define TPS659414		0x3
 #define  LP876441		0x4
+#define  TPS65224		0x5
 
 /* I2C device address for pmic tps65941 */
 #define TPS65941_I2C_ADDR	(0x12 >> 1)
 #define TPS65941_LDO_NUM		4
 #define TPS65941_BUCK_NUM		5
+#define TPS65224_LDO_NUM		3
+#define TPS65224_BUCK_NUM		4
 
 /* Drivers name */
 #define TPS65941_LDO_DRIVER		"tps65941_ldo"
@@ -25,3 +28,30 @@
 #define TPS65941_LDO_MODE_MASK		0x1
 #define TPS65941_LDO_BYPASS_EN		0x80
 #define TP65941_BUCK_CONF_SLEW_MASK	0x7
+
+#define TPS65224_BUCK_VOLT_MAX		3300000
+#define TPS65224_BUCK1_VOLT_MAX_HEX      0xFD
+#define TPS65224_BUCK234_VOLT_MAX_HEX    0x45
+
+#define TPS65224_BUCK_CONF_SLEW_MASK     0x3
+#define TPS65224_LDO_VOLT_MASK    (0x3F << 1)
+
+#define TPS65224_LDO1_VOLT_MIN_HEX       0x0C
+#define TPS65224_LDO23_VOLT_MIN_HEX      0x00
+#define TPS65224_LDO1_VOLT_MAX_HEX       0x36
+#define TPS65224_LDO23_VOLT_MAX_HEX      0x38
+
+#define TPS65224_LDO1_VOLT_MAX        3300000
+#define TPS65224_LDO23_VOLT_MAX       3400000
+#define TPS65224_LDO1_VOLT_MIN        1200000
+#define TPS65224_LDO23_VOLT_MIN        600000
+
+#define TPS65224_LDO_STEP               50000
+
+#define TPS65224_LDO_BYP_CONFIG             7
+
+#define TPS65224_LDO1_VOLT_BYP_MIN    2200000
+#define TPS65224_LDO1_VOLT_BYP_MAX    3600000
+
+#define TPS65224_LDO23_VOLT_BYP_MIN   1500000
+#define TPS65224_LDO23_VOLT_BYP_MAX   5500000
-- 
2.25.1

