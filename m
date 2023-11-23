Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BE41C61DF7
	for <u-boot@archiver.kernel.org>; Thu, 23 Nov 2023 15:10:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 194D187687;
	Thu, 23 Nov 2023 16:10:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79A0887680; Thu, 23 Nov 2023 16:10:29 +0100 (CET)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::224])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F21F87677
 for <u-boot@lists.denx.de>; Thu, 23 Nov 2023 16:10:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=foss+uboot@0leil.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 40B97E0008;
 Thu, 23 Nov 2023 15:10:25 +0000 (UTC)
From: Quentin Schulz <foss+uboot@0leil.net>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.denx.de,
 Heiko Stuebner <heiko@sntech.de>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: [PATCH next v2 1/6] rockchip: ringneck-px30: do not hardcode MMC
 controller paths
Date: Thu, 23 Nov 2023 16:10:05 +0100
Message-ID: <20231123-env_default_theobroma-v2-1-a80914c2c114@theobroma-systems.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231123-env_default_theobroma-v2-0-a80914c2c114@theobroma-systems.com>
References: <20231123-env_default_theobroma-v2-0-a80914c2c114@theobroma-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit
X-GND-Sasl: foss@0leil.net
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

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

To prepare to put the similar logic around storage medium selection for
Ringneck PX30 and Puma RK3399 in common, let's not use hardcoded paths
but use uclass functions instead to find udevice based on their DT node
full path.

Cc: Quentin Schulz <foss+uboot@0leil.net>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 .../ringneck_px30/ringneck-px30.c                  | 29 +++++++++++++---------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/board/theobroma-systems/ringneck_px30/ringneck-px30.c b/board/theobroma-systems/ringneck_px30/ringneck-px30.c
index 537ce0d1d11..fb5570767db 100644
--- a/board/theobroma-systems/ringneck_px30/ringneck-px30.c
+++ b/board/theobroma-systems/ringneck_px30/ringneck-px30.c
@@ -68,11 +68,16 @@ static int setup_boottargets(void)
 	 * Make the default boot medium between SD Card and eMMC, the one that
 	 * was used to load U-Boot proper.
 	 */
-	bool sd_booted = !strcmp(boot_device, "/mmc@ff370000");
+	struct udevice *devp;
+
+	if (uclass_find_device_by_ofnode(UCLASS_MMC, ofnode_path(boot_device), &devp)) {
+		debug("%s: not reordering boot_targets, bootdev %s != MMC\n",
+		      __func__, boot_device);
+		return 0;
+	}
+
 	char *mmc0, *mmc1;
 
-	debug("%s: booted from %s\n", __func__,
-	      sd_booted ? "SD-Card" : "eMMC");
 	mmc0 = strstr(env, "mmc0");
 	mmc1 = strstr(env, "mmc1");
 
@@ -87,8 +92,8 @@ static int setup_boottargets(void)
 	 * If mmc1 comes first in the boot order and U-Boot proper was
 	 * loaded from mmc0, swap mmc0 and mmc1 in the list.
 	 */
-	if ((mmc0 < mmc1 && sd_booted) ||
-	    (mmc0 > mmc1 && !sd_booted)) {
+	if ((mmc0 < mmc1 && devp->seq_ == 1) ||
+	    (mmc0 > mmc1 && devp->seq_ == 0)) {
 		mmc0[3] = '1';
 		mmc1[3] = '0';
 		debug("%s: set boot_targets to: %s\n", __func__, env);
@@ -102,6 +107,7 @@ int mmc_get_env_dev(void)
 {
 	const char *boot_device =
 		ofnode_read_chosen_string("u-boot,spl-boot-device");
+	struct udevice *devp;
 
 	if (!boot_device) {
 		debug("%s: /chosen/u-boot,spl-boot-device not set\n",
@@ -111,19 +117,19 @@ int mmc_get_env_dev(void)
 
 	debug("%s: booted from %s\n", __func__, boot_device);
 
-	if (!strcmp(boot_device, "/mmc@ff370000"))
-		return 1;
+	if (uclass_find_device_by_ofnode(UCLASS_MMC, ofnode_path(boot_device), &devp))
+		return CONFIG_SYS_MMC_ENV_DEV;
 
-	if (!strcmp(boot_device, "/mmc@ff390000"))
-		return 0;
+	debug("%s: get MMC ENV from mmc%d\n", __func__, devp->seq_);
 
-	return CONFIG_SYS_MMC_ENV_DEV;
+	return devp->seq_;
 }
 
 enum env_location arch_env_get_location(enum env_operation op, int prio)
 {
 	const char *boot_device =
 		ofnode_read_chosen_string("u-boot,spl-boot-device");
+	struct udevice *devp;
 
 	if (prio > 0)
 		return ENVL_UNKNOWN;
@@ -137,8 +143,7 @@ enum env_location arch_env_get_location(enum env_operation op, int prio)
 	debug("%s: booted from %s\n", __func__, boot_device);
 
 	if (IS_ENABLED(CONFIG_ENV_IS_IN_MMC) &&
-	    (!strcmp(boot_device, "/mmc@ff370000") ||
-	     !strcmp(boot_device, "/mmc@ff390000")))
+	    !uclass_find_device_by_ofnode(UCLASS_MMC, ofnode_path(boot_device), &devp))
 		return ENVL_MMC;
 
 	printf("%s: No environment available: booted from %s but U-Boot "

-- 
2.42.0

