Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 014E3C5AD49
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 12:07:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EEDA8320C;
	Wed, 28 May 2025 14:07:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D16C98321B; Wed, 28 May 2025 14:07:39 +0200 (CEST)
Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch
 [185.125.25.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EC17831E4
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 14:07:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4b6pCs0J06zCRx;
 Wed, 28 May 2025 14:07:37 +0200 (CEST)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4b6pCr40mWz9KL; Wed, 28 May 2025 14:07:36 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 28 May 2025 14:07:27 +0200
Subject: [PATCH] power: rk8xx: fix swapped mask and value in init registers
 for RK806
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250528-rk8xx-rst_fun-mask-v1-1-e40a6188cb6b@cherry.de>
X-B4-Tracking: v=1; b=H4sIAH78NmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDUyML3aJsi4oK3aLikvi00jzd3MTibF3DFBNLo2RjE1PjRBMloMaCotS
 0zAqwodGxtbUA0fw6/WQAAAA=
X-Change-ID: 20250528-rk8xx-rst_fun-mask-1d492c3453a4
To: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Kever Yang <kever.yang@rock-chips.com>
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

The val (the bits to set) is the second member of the reg_data structure
and mask the third one. We obviously want to clear bits 6 and 7 in order
to only set bit 7 in there instead of only clearing bit 7 in order to
write bits 6 and 7 (which makes no sense).

Fortunately, according to the datasheet, bit 6 value doesn't matter when
bit 7 is set so this is essentially just a cosmetic change, no intended
change in behavior.

Fixes: f172575d92cd ("power: rk8xx: add support for RK806")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
I'm planning on adding support for customizing the RST_FUN value in a
later patch series. I'm currently working[1] on bringing this up to the
Linux kernel first to have a stable DT implementation.

[1] https://lore.kernel.org/linux-rockchip/20250526-rk8xx-rst-fun-v1-0-ea894d9474e0@cherry.de/
---
 drivers/power/pmic/rk8xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/pmic/rk8xx.c b/drivers/power/pmic/rk8xx.c
index a14555cf472f80daed70eab174c2e9b980603580..3bc696d4caaa68f87fd49810682616c34bafb23b 100644
--- a/drivers/power/pmic/rk8xx.c
+++ b/drivers/power/pmic/rk8xx.c
@@ -91,7 +91,7 @@ void rk8xx_off_for_plugin(struct udevice *dev)
 
 static struct reg_data rk806_init_reg[] = {
 	/* RST_FUN */
-	{ RK806_REG_SYS_CFG3, GENMASK(7, 6), BIT(7)},
+	{ RK806_REG_SYS_CFG3, BIT(7), GENMASK(7, 6)},
 };
 
 static struct reg_data rk817_init_reg[] = {

---
base-commit: e04d137231f2e9e14708a32448c879125b8e308f
change-id: 20250528-rk8xx-rst_fun-mask-1d492c3453a4

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

