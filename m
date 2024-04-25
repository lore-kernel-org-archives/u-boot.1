Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D0C8C4345F
	for <u-boot@archiver.kernel.org>; Thu, 25 Apr 2024 23:03:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 053538908D;
	Fri, 26 Apr 2024 01:03:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1714086220;
	bh=zgc46nVk/3cy/vZvU6irfshn7+UnbpqdoxgdtQIUTfY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=dUoGIwf3+SilU5k8zyvR5GpK9U+Tfqn/3op34bYAJB0J/Bu8dkElGn7omVWr9AWmn
	 ubg4HHO3EXS2IbWJ3ygWSGZIzIJW78a0GTc2QacN/eTjwTcph/1whqVct6PYXOraOv
	 FKh5hvhkLaj3YrSPDWV2jtxZP3fwxmMc40mlB5lA5Qhz8uPgjqbXGkMTjJOTw25waX
	 UAuGlqrhztlPeub7CpMIO39pHAgf+sdAB8AJHYH8oYVw6UhzbFee77w71qWtUD834+
	 L2e1wNPgsw5yKuedQhKrhc76uz7hxIWu4Q2fRnY6CCcIaoFIsKhfPIS87wOK5Ewl0e
	 91pk1u2qcSuvw==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id B9421886E3;
 Fri, 26 Apr 2024 01:03:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1714086218;
 bh=zgc46nVk/3cy/vZvU6irfshn7+UnbpqdoxgdtQIUTfY=;
 h=From:To:Cc:Subject:Date:From;
 b=Lszo34KG7oVm8tonBO0gGyGLOgQ/riMSxXRKM7PE4vZwZXhRoxVYiZlO7N/tZV57R
 qhDU+QNjpCm5/p6BOMl8p9QUxFIW8ALCfb5WXASptDtyggCbjrXj8vnERXxjjTPb9G
 VpV2V54UPoF7ky22BbWKymv6bm6vf5U/BFfWwHGOU5y9ZtQqYCU5N9S8Fvxo337RMx
 gHYn8M5g8rJBUTPdteScM6JUKKc+CKQQdpQYmpZLLQnPUnfAUzcurEmDyPNoEChRzC
 FUQNDIO0FF2xb9oGBDh01/oT86xC2zsKat7FUGnXBJzoNe1BuE2hysaEE/AJX3SyNF
 BcJ9febme7Mkw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Angelo Dureghello <angelo@kernel-space.org>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Fabio Estevam <festevam@gmail.com>, Gaurav Jain <gaurav.jain@nxp.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/3] rng: Introduce SPL_DM_RNG
Date: Fri, 26 Apr 2024 01:02:07 +0200
Message-ID: <20240425230314.497203-1-marex@denx.de>
X-Mailer: git-send-email 2.43.0
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

Add SPL variant of DM_RNG so that the DM_RNG can be disabled in SPL
if necessary. This may be necessary due to e.g. size constraints of
the SPL.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Angelo Dureghello <angelo@kernel-space.org>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Gaurav Jain <gaurav.jain@nxp.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Marek Vasut <marex@denx.de>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Stefan Roese <sr@denx.de>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 boot/pxe_utils.c        | 4 +---
 boot/vbe_request.c      | 2 +-
 drivers/Makefile        | 2 +-
 drivers/crypto/fsl/jr.c | 4 ++--
 drivers/rng/Kconfig     | 7 +++++++
 drivers/rng/Makefile    | 2 +-
 lib/uuid.c              | 2 +-
 net/net_rand.h          | 2 +-
 test/dm/Makefile        | 2 +-
 9 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index 96205626750..5c1c962ff4c 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -21,9 +21,7 @@
 #include <errno.h>
 #include <linux/list.h>
 
-#ifdef CONFIG_DM_RNG
 #include <rng.h>
-#endif
 
 #include <splash.h>
 #include <asm/io.h>
@@ -323,7 +321,7 @@ static int label_localboot(struct pxe_label *label)
 
 static void label_boot_kaslrseed(void)
 {
-#ifdef CONFIG_DM_RNG
+#if CONFIG_IS_ENABLED(DM_RNG)
 	ulong fdt_addr;
 	struct fdt_header *working_fdt;
 	size_t n = 0x8;
diff --git a/boot/vbe_request.c b/boot/vbe_request.c
index 917251afa1c..0293ac6c869 100644
--- a/boot/vbe_request.c
+++ b/boot/vbe_request.c
@@ -36,7 +36,7 @@ static int handle_random_req(ofnode node, int default_size,
 	u32 size;
 	int ret;
 
-	if (!IS_ENABLED(CONFIG_DM_RNG))
+	if (!CONFIG_IS_ENABLED(DM_RNG))
 		return -ENOTSUPP;
 
 	if (ofnode_read_u32(node, "vbe,size", &size)) {
diff --git a/drivers/Makefile b/drivers/Makefile
index bf73b7718ce..9195dafd37e 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -126,7 +126,7 @@ obj-$(CONFIG_W1_EEPROM) += w1-eeprom/
 obj-$(CONFIG_MACH_PIC32) += ddr/microchip/
 obj-$(CONFIG_FUZZ) += fuzz/
 obj-$(CONFIG_DM_HWSPINLOCK) += hwspinlock/
-obj-$(CONFIG_DM_RNG) += rng/
+obj-$(CONFIG_$(SPL_TPL_)DM_RNG) += rng/
 endif
 
 obj-y += soc/
diff --git a/drivers/crypto/fsl/jr.c b/drivers/crypto/fsl/jr.c
index 203f1625215..8ae5c434bdb 100644
--- a/drivers/crypto/fsl/jr.c
+++ b/drivers/crypto/fsl/jr.c
@@ -787,7 +787,7 @@ init:
 	}
 #if CONFIG_IS_ENABLED(OF_CONTROL)
 	if (ofnode_valid(scu_node)) {
-		if (IS_ENABLED(CONFIG_DM_RNG)) {
+		if (CONFIG_IS_ENABLED(DM_RNG)) {
 			ret = device_bind_driver(NULL, "caam-rng", "caam-rng", NULL);
 			if (ret)
 				printf("Couldn't bind rng driver (%d)\n", ret);
@@ -810,7 +810,7 @@ init:
 			return -1;
 		}
 
-		if (IS_ENABLED(CONFIG_DM_RNG)) {
+		if (CONFIG_IS_ENABLED(DM_RNG)) {
 			ret = device_bind_driver(NULL, "caam-rng", "caam-rng",
 						 NULL);
 			if (ret)
diff --git a/drivers/rng/Kconfig b/drivers/rng/Kconfig
index cd72852a479..5758ae192a6 100644
--- a/drivers/rng/Kconfig
+++ b/drivers/rng/Kconfig
@@ -6,6 +6,13 @@ config DM_RNG
 	  This interface is used to initialise the rng device and to
 	  read the random seed from the device.
 
+config SPL_DM_RNG
+	bool "Driver support for Random Number Generator devices in SPL"
+	depends on SPL_DM
+	help
+	  This option is an SPL-variant of the DM_RNG option.
+	  See the help of DM_RNG for details.
+
 if DM_RNG
 
 config RNG_MESON
diff --git a/drivers/rng/Makefile b/drivers/rng/Makefile
index ecae1a3da33..c1f1c616e00 100644
--- a/drivers/rng/Makefile
+++ b/drivers/rng/Makefile
@@ -3,7 +3,7 @@
 # Copyright (c) 2019, Linaro Limited
 #
 
-obj-$(CONFIG_DM_RNG) += rng-uclass.o
+obj-$(CONFIG_$(SPL_TPL_)DM_RNG) += rng-uclass.o
 obj-$(CONFIG_RNG_MESON) += meson-rng.o
 obj-$(CONFIG_RNG_SANDBOX) += sandbox_rng.o
 obj-$(CONFIG_RNG_MSM) += msm_rng.o
diff --git a/lib/uuid.c b/lib/uuid.c
index 2d7d99535e7..dfa2320ba26 100644
--- a/lib/uuid.c
+++ b/lib/uuid.c
@@ -378,7 +378,7 @@ void gen_rand_uuid(unsigned char *uuid_bin)
 	struct udevice *devp;
 	u32 randv = 0;
 
-	if (IS_ENABLED(CONFIG_DM_RNG)) {
+	if (CONFIG_IS_ENABLED(DM_RNG)) {
 		ret = uclass_get_device(UCLASS_RNG, 0, &devp);
 		if (!ret) {
 			ret = dm_rng_read(devp, &randv, sizeof(randv));
diff --git a/net/net_rand.h b/net/net_rand.h
index d3c5559adfd..686e85f2b53 100644
--- a/net/net_rand.h
+++ b/net/net_rand.h
@@ -42,7 +42,7 @@ static inline void srand_mac(void)
 	struct udevice *devp;
 	u32 randv = 0;
 
-	if (IS_ENABLED(CONFIG_DM_RNG)) {
+	if (CONFIG_IS_ENABLED(DM_RNG)) {
 		ret = uclass_get_device(UCLASS_RNG, 0, &devp);
 		if (ret) {
 			ret = dm_rng_read(devp, &randv, sizeof(randv));
diff --git a/test/dm/Makefile b/test/dm/Makefile
index a3ce7b3889f..c12589d487c 100644
--- a/test/dm/Makefile
+++ b/test/dm/Makefile
@@ -102,7 +102,7 @@ obj-$(CONFIG_DM_RESET) += reset.o
 obj-$(CONFIG_SYSRESET) += sysreset.o
 obj-$(CONFIG_DM_REGULATOR) += regulator.o
 obj-$(CONFIG_CMD_RKMTD) += rkmtd.o
-obj-$(CONFIG_DM_RNG) += rng.o
+obj-$(CONFIG_$(SPL_TPL_)DM_RNG) += rng.o
 obj-$(CONFIG_DM_RTC) += rtc.o
 obj-$(CONFIG_SCMI_FIRMWARE) += scmi.o
 obj-$(CONFIG_SCSI) += scsi.o
-- 
2.43.0

