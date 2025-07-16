Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94A10C83F1B
	for <u-boot@archiver.kernel.org>; Wed, 16 Jul 2025 09:44:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A117831C3;
	Wed, 16 Jul 2025 11:44:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A423831C6; Wed, 16 Jul 2025 11:44:43 +0200 (CEST)
Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch
 [185.125.25.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D818831AC
 for <u-boot@lists.denx.de>; Wed, 16 Jul 2025 11:44:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bhrkH6jgfzCDf;
 Wed, 16 Jul 2025 11:44:39 +0200 (CEST)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4bhrkH11X1zbCW; Wed, 16 Jul 2025 11:44:39 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 16 Jul 2025 11:44:08 +0200
Subject: [PATCH] power: rk8xx: allow to customize RK806 reset mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250716-rk8xx-rst-fun-v1-1-269277cb779e@cherry.de>
X-B4-Tracking: v=1; b=H4sIAGd0d2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDMyNz3aJsi4oK3aLiEt200jzdNAvjVPNEs8REE5NEJaCegqLUtMwKsHn
 RsbW1AEGUKldfAAAA
X-Change-ID: 20250627-rk8xx-rst-fun-f83e7a6aa44a
To: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

The RK806 PMIC has a bitfield for configuring the restart/reset behavior
(which I assume Rockchip calls "function") whenever the PMIC is reset
either programmatically (c.f. DEV_RST in the datasheet) or via PWRCTRL
or RESETB pins.

For RK806, the following values are possible for RST_FUN:

0b00 means "Restart PMU"
0b01 means "Reset all the power off reset registers, forcing
	the state to switch to ACTIVE mode"
0b10 means "Reset all the power off reset registers, forcing
	the state to switch to ACTIVE mode, and simultaneously
	pull down the RESETB PIN for 5mS before releasing"
0b11 means the same as for 0b10 just above.

This adds the appropriate logic in the driver to parse the new
rockchip,reset-mode DT property to pass this information. It just
happens that the values in the binding match the values to write in the
bitfield so no mapping is necessary.

For backward compatibility reasons, if the property is missing we set it
to 0b10 (i.e. BIT(7)) like before this commit was merged instead of
leaving it untouched like in the kernel driver.

Note that this does nothing useful for U-Boot at the moment as the ways
to reset the device (e.g. via `reset` command) doesn't interact with the
RK8xx PMIC and simply does a CPU reset.
Considering the upstream Linux kernel left this register untouched until
(assumed) v6.17[1], this is useful for cases in which the U-Boot
bootloader has this patch (and running with a DT with
rockchip,reset-mode property set) and running an upstream kernel before
(assumed) v6.17, or alternatively later without the property in the
kernel DT.

See https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git/commit/?id=e15f4a2e2f0a8ff973562f5f18d40c7fdc3836c8
for the documentation of this DT property.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git/commit/?id=87b48d86b77686013f5c2a8866ed299312b671db

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
The RK3588 Theobroma boards (Tiger and Jaguar) need a different reset
mode for the PMIC to work properly, c.f.
https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git/commit/?id=ee907113430aa02a8202c91bb574c385ecc28aa2
https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git/commit/?id=e82f642b9821384045915dc30e73df7de8424827

While the kernel just recently gained support for setting this
appropriately (assumed to be part of the upcoming 6.17 release), all
upstream kernels before that release will simply not behave
appropriately for those boards. While it is typically much easier to
update the Linux kernel than U-Boot, let's cover all possible scenario
by adding support for setting this reset mode properly from U-Boot so
that there isn't a need for patching or updating the kernel. Note that
this isn't enough for fixing the behavior on Tiger and Jaguar as we
still need DT patches for that to work. They are merged already and
expected to make it to v6.17 release but I cannot backport them before
they land in devicetree-rebasing so it'll have to wait a bit :) It's
also not urgent enough to my taste to warrant manually patching that in
-u-boot.dtsi.
---
 drivers/power/pmic/rk8xx.c | 21 ++++++++++++---------
 include/power/rk8xx_pmic.h |  2 ++
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/power/pmic/rk8xx.c b/drivers/power/pmic/rk8xx.c
index 3bc696d4caaa68f87fd49810682616c34bafb23b..d11f7a7886e8074e7b7833c8a51ea24d77fede34 100644
--- a/drivers/power/pmic/rk8xx.c
+++ b/drivers/power/pmic/rk8xx.c
@@ -89,11 +89,6 @@ void rk8xx_off_for_plugin(struct udevice *dev)
 	}
 }
 
-static struct reg_data rk806_init_reg[] = {
-	/* RST_FUN */
-	{ RK806_REG_SYS_CFG3, BIT(7), GENMASK(7, 6)},
-};
-
 static struct reg_data rk817_init_reg[] = {
 /* enable the under-voltage protection,
  * the under-voltage protection will shutdown the LDO3 and reset the PMIC
@@ -306,12 +301,20 @@ static int rk8xx_probe(struct udevice *dev)
 		value = (power_en2 & 0x0f) | ((power_en3 & 0x0f) << 4);
 		pmic_reg_write(dev, RK817_POWER_EN_SAVE1, value);
 		break;
-	case RK806_ID:
+	case RK806_ID: {
+		u32 rst_fun = 2;
+
 		on_source = RK806_ON_SOURCE;
 		off_source = RK806_OFF_SOURCE;
-		init_data = rk806_init_reg;
-		init_data_num = ARRAY_SIZE(rk806_init_reg);
-		break;
+
+		ret = dev_read_u32(dev, "rockchip,reset-mode", &rst_fun);
+		if (ret)
+			debug("rockchip,reset-mode property missing, defaulting to %d\n",
+			      rst_fun);
+
+		pmic_clrsetbits(dev, RK806_REG_SYS_CFG3, RK806_RST_FUN_MSK,
+				FIELD_PREP(RK806_RST_FUN_MSK, rst_fun));
+		break; }
 	default:
 		printf("Unknown PMIC: RK%x!!\n", show_variant);
 		return -EINVAL;
diff --git a/include/power/rk8xx_pmic.h b/include/power/rk8xx_pmic.h
index 31221aa46b60cf995fd02f5894b3ee97a7475f8a..913b6ebe6d96e08bcfab509cff5db7da8358784a 100644
--- a/include/power/rk8xx_pmic.h
+++ b/include/power/rk8xx_pmic.h
@@ -212,6 +212,8 @@ enum {
 #define RK817_POWER_EN_SAVE0	0x99
 #define RK817_POWER_EN_SAVE1	0xa4
 
+#define RK806_RST_FUN_MSK	GENMASK(7, 6)
+
 #define RK806_POWER_EN(x)			(0x00 + (x))
 /* POWER_ENx register lower 4 bits are write-protected unless the associated top bit is set */
 #define RK806_POWER_EN_CLRSETBITS(bit, val)	(((val) << (bit)) | (1 << ((bit) + 4)))

---
base-commit: bcc7bc69b92ab728790aea0d08b2ae5e22d3b09d
change-id: 20250627-rk8xx-rst-fun-f83e7a6aa44a

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

