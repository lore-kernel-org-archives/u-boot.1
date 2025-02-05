Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFED5C02198
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 17:19:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8279C80805;
	Wed,  5 Feb 2025 18:19:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=tidylabs.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=tidylabs.net header.i=@tidylabs.net header.b="LWFlIsZJ";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=purelymail.com header.i=@purelymail.com header.b="TE5TcAhe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83864807E0; Wed,  5 Feb 2025 18:19:00 +0100 (CET)
Received: from sendmail.purelymail.com (sendmail.purelymail.com
 [34.202.193.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0145D80805
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 18:18:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=tidylabs.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=justin@tidylabs.net
DKIM-Signature: a=rsa-sha256;
 b=LWFlIsZJCr92P2/5OLGOM2NSLqDmtXSVsuICsiKyZWtpgB68ap+rSsdIpYY7PZLTDTH1e1+TEYc/sIFaUHBcTOzOcerVFFabvAQ2laHfKb8XrgEmOjbtuJTx4RNRoFvwi6HONeQY+OJTjn++HQhXqijpWMp9OjhMUsZwxh0amBOqirlzqoNF5ef1bWH0/tPiHHT+4bAuE6Km4HI46mVee6sXmjdt/LUU5MEZB+T6K6O70OCMVs+3YjjA3S5XxTWSoOtJYgBW+kXGKZ/IlZeIy2i9PcPThFMPxxpPWzKLWb4Nt/42nv20aARUeHW2MBAALlbhIayqRlDrTDQVcjX2+Q==;
 s=purelymail2; d=tidylabs.net; v=1;
 bh=h0iALQF8K8N7sY6UGxVa7xuIHiWyXw/pPHS5ygzrEd4=;
 h=Received:From:To:Subject:Date; 
DKIM-Signature: a=rsa-sha256;
 b=TE5TcAhej56cjsCPSNe8DnfpQGYdXankGckewcFrFTpq/nsvU0gZL1MQHawJ9rwkWvm7fuhwdABHIuAzVT+SNtUKtEZx6VQ3DEKRSngLErU62I4BnYbAXeuQNBQOQY7+j+QHyVftsqygUGClfx0RmyMWD7lQhPZpJkisskwmVmGHPpNqH1F5VrV/lk8h3T1xVc46GwkBX0Kjxml9TUortIneW7e1anRPDfVPruHV9MLSh2k1zJeLd3hi8o14OAPfDe49nfCUV7CS4etYCMSiyVW3GAGUPMZJ38PPUietQ8U47/WXaDGhPYRRL4YISh9b15JGTfP/RyOwFNvwstosPg==;
 s=purelymail2; d=purelymail.com; v=1;
 bh=h0iALQF8K8N7sY6UGxVa7xuIHiWyXw/pPHS5ygzrEd4=;
 h=Feedback-ID:Received:From:To:Subject:Date; 
Feedback-ID: 81901:11097:null:purelymail
X-Pm-Original-To: u-boot@lists.denx.de
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1817051443; 
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Wed, 05 Feb 2025 17:18:39 +0000 (UTC)
From: Justin Klaassen <justin@tidylabs.net>
To: u-boot@lists.denx.de
Cc: Justin Klaassen <justin@tidylabs.net>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Jonas Karlman <jonas@kwiboo.se>,
 Keerthy <j-keerthy@ti.com>, Kever Yang <kever.yang@rock-chips.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, William Wu <william.wu@rock-chips.com>
Subject: [PATCH v3 3/5] regulator: rk8xx: Add CONFIG_SPL_REGULATOR_RK8XX
Date: Wed,  5 Feb 2025 17:16:13 +0000
Message-ID: <20250205171634.826560-4-justin@tidylabs.net>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <20250205171634.826560-1-justin@tidylabs.net>
References: <20250205171634.826560-1-justin@tidylabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8
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

Allows use of the regulator functions of the RK8XX PMIC in SPL, which is
necessary to support the functionality of the Rockchip IO-domain driver
on relevant platforms.

Signed-off-by: Justin Klaassen <justin@tidylabs.net>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---

(no changes since v2)

Changes in v2:
- Added separate patch for added CONFIG_SPL_REGULATOR_RK8XX Kconfig

 drivers/power/regulator/Kconfig | 9 +++++++++
 drivers/power/regulator/rk8xx.c | 8 ++------
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/power/regulator/Kconfig b/drivers/power/regulator/Kcon=
fig
index 958f337c7e7..9b50128f859 100644
--- a/drivers/power/regulator/Kconfig
+++ b/drivers/power/regulator/Kconfig
@@ -241,6 +241,15 @@ config REGULATOR_RK8XX
 =09by the PMIC device. This driver is controlled by a device tree node
 =09which includes voltage limits.
=20
+config SPL_REGULATOR_RK8XX
+=09bool "Enable driver for RK8XX regulators in SPL"
+=09depends on SPL_DM_REGULATOR && SPL_PMIC_RK8XX
+=09help
+=09  Enable support for the regulator functions of the RK8XX PMIC in SPL. =
The
+=09  driver implements get/set api for the various BUCKS and LDOs supporte=
d
+=09  by the PMIC device. This driver is controlled by a device tree node
+=09  which includes voltage limits.
+
 config DM_REGULATOR_S2MPS11
 =09bool "Enable driver for S2MPS11 regulator"
 =09depends on DM_REGULATOR && PMIC_S2MPS11
diff --git a/drivers/power/regulator/rk8xx.c b/drivers/power/regulator/rk8x=
x.c
index 368675ebb9f..88453bb7bdb 100644
--- a/drivers/power/regulator/rk8xx.c
+++ b/drivers/power/regulator/rk8xx.c
@@ -16,10 +16,6 @@
 #include <power/pmic.h>
 #include <power/regulator.h>
=20
-#ifndef CONFIG_XPL_BUILD
-#define ENABLE_DRIVER
-#endif
-
 /* Not used or exisit register and configure */
 #define NA=09=09=090xff
=20
@@ -202,7 +198,7 @@ static const struct rk8xx_reg_info rk818_buck[] =3D {
 =09{ 1800000, 100000, REG_BUCK4_ON_VSEL, REG_BUCK4_SLP_VSEL, REG_BUCK4_CON=
FIG, RK818_BUCK4_VSEL_MASK, 0x00, 0x1f },
 };
=20
-#ifdef ENABLE_DRIVER
+#if CONFIG_IS_ENABLED(REGULATOR_RK8XX)
 static const struct rk8xx_reg_info rk806_nldo[] =3D {
 =09/* nldo 1 */
 =09{  500000, 12500, RK806_NLDO_ON_VSEL(1), RK806_NLDO_SLP_VSEL(1), NA, RK=
806_NLDO_VSEL_MASK, 0x00, 0xe7},
@@ -454,7 +450,7 @@ static int _buck_set_enable(struct udevice *pmic, int b=
uck, bool enable)
 =09return ret;
 }
=20
-#ifdef ENABLE_DRIVER
+#if CONFIG_IS_ENABLED(REGULATOR_RK8XX)
 static int _buck_set_suspend_value(struct udevice *pmic, int buck, int uvo=
lt)
 {
 =09const struct rk8xx_reg_info *info =3D get_buck_reg(pmic, buck, uvolt);
--=20
2.45.3

