Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4CA1EE57DF
	for <u-boot@archiver.kernel.org>; Mon, 11 Sep 2023 16:43:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDDFE86E92;
	Mon, 11 Sep 2023 18:42:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="Xb27+FCQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1399586D06; Mon, 11 Sep 2023 18:36:00 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E919C86E39
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 18:35:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 6FF8012000A;
 Mon, 11 Sep 2023 19:35:53 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 6FF8012000A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1694450153;
 bh=iIW/GxTj5/gdDn4tbs3xdArStw0S+GugN2ySrF87KjQ=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=Xb27+FCQ/RyHMFnCE7bowv9yUISevQ0aikazm0Tucx6af5cjO1jlqk2NFiBC3re75
 CmfrNTSmJeiJQHVpt0fbozeJB6hN5JpK0bHhfO8aqWEnh1FyI6gzE4MgOTVRZQ2kVf
 m419TAnn+XkLlyhc7alzCnLc/NmE2SmZLISlADXtJgUy69/IQ9q46Zg4dsHC+Ierfa
 dZNZdWpd8kFk242WkaFTAXfGuBlciLGJdJiy2R6/UXmv8N6II4nbNMkXZlnmBu4oNs
 hoRmVPcw9WMFfL8D/mPFcvQ8OqRD2WmGZT5jo9iKEu9HsyiReP4ZykafmLi8/7O6/T
 Qx/S+XQQVqe/Q==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Mon, 11 Sep 2023 19:35:53 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 11 Sep 2023 19:35:52 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: <neil.armstrong@linaro.org>, <narmstrong@baylibre.com>, <sjg@google.com>, 
 <takahiro.akashi@linaro.org>, <ilias.apalodimas@linaro.org>,
 <post@lespocky.de>, <marex@denx.de>, <msuchanek@suse.de>,
 <sughosh.ganu@linaro.org>, <jh80.chung@samsung.com>,
 <paul.barker@sancloud.com>
CC: <u-boot-amlogic@groups.io>, <u-boot@lists.denx.de>,
 <kernel@sberdevices.ru>, Alexey Romanov <avromanov@salutedevices.com>
Subject: [PATCH v2 8/8] arch: meson: use secure monitor driver
Date: Mon, 11 Sep 2023 19:35:36 +0300
Message-ID: <20230911163536.20735-9-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230911163536.20735-1-avromanov@salutedevices.com>
References: <20230911163536.20735-1-avromanov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 179783 [Sep 11 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 530 530
 ecb1547b3f72d1df4c71c0b60e67ba6b4aea5432,
 {Tracking_from_domain_doesnt_match_to},
 p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1; salutedevices.com:7.1.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; 127.0.0.199:7.1.2;
 100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2023/09/11 06:02:00 #21866861
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Mon, 11 Sep 2023 18:42:19 +0200
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

Now we have to use UCLASS_SM driver instead of
raw smc_call() function call.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
---
 arch/arm/mach-meson/Kconfig |   1 +
 arch/arm/mach-meson/sm.c    | 110 +++++++++++++++++++-----------------
 2 files changed, 58 insertions(+), 53 deletions(-)

diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
index 669ca09a00..d6c8905806 100644
--- a/arch/arm/mach-meson/Kconfig
+++ b/arch/arm/mach-meson/Kconfig
@@ -11,6 +11,7 @@ config MESON64_COMMON
 	select PWRSEQ
 	select MMC_PWRSEQ
 	select BOARD_LATE_INIT
+	select MESON_SM
 	imply CMD_DM
 
 config MESON_GX
diff --git a/arch/arm/mach-meson/sm.c b/arch/arm/mach-meson/sm.c
index b5dd6c6d39..0c60aa8695 100644
--- a/arch/arm/mach-meson/sm.c
+++ b/arch/arm/mach-meson/sm.c
@@ -9,6 +9,7 @@
 #include <dm.h>
 #include <log.h>
 #include <regmap.h>
+#include <sm.h>
 #include <syscon.h>
 #include <asm/arch/sm.h>
 #include <asm/cache.h>
@@ -18,70 +19,62 @@
 #include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/bitfield.h>
+#include <meson/sm.h>
 
-#define FN_GET_SHARE_MEM_INPUT_BASE	0x82000020
-#define FN_GET_SHARE_MEM_OUTPUT_BASE	0x82000021
-#define FN_EFUSE_READ			0x82000030
-#define FN_EFUSE_WRITE			0x82000031
-#define FN_CHIP_ID			0x82000044
-#define FN_PWRDM_SET			0x82000093
-
-static void *shmem_input;
-static void *shmem_output;
-
-static void meson_init_shmem(void)
+static inline struct udevice *meson_get_sm_device(void)
 {
-	struct pt_regs regs;
-
-	if (shmem_input && shmem_output)
-		return;
+	struct udevice *dev;
+	int err;
 
-	regs.regs[0] = FN_GET_SHARE_MEM_INPUT_BASE;
-	smc_call(&regs);
-	shmem_input = (void *)regs.regs[0];
-
-	regs.regs[0] = FN_GET_SHARE_MEM_OUTPUT_BASE;
-	smc_call(&regs);
-	shmem_output = (void *)regs.regs[0];
+	err = uclass_get_device_by_name(UCLASS_SM, "secure-monitor", &dev);
+	if (err) {
+		pr_err("Mesom SM device not found\n");
+		return ERR_PTR(err);
+	}
 
-	debug("Secure Monitor shmem: 0x%p 0x%p\n", shmem_input, shmem_output);
+	return dev;
 }
 
 ssize_t meson_sm_read_efuse(uintptr_t offset, void *buffer, size_t size)
 {
-	struct pt_regs regs;
+	struct udevice *dev;
+	struct pt_regs regs = { 0 };
+	int err;
 
-	meson_init_shmem();
+	dev = meson_get_sm_device();
+	if (IS_ERR(dev))
+		return PTR_ERR(dev);
 
-	regs.regs[0] = FN_EFUSE_READ;
 	regs.regs[1] = offset;
 	regs.regs[2] = size;
 
-	smc_call(&regs);
+	err = sm_call_read(dev, buffer, size,
+			   MESON_SMC_CMD_EFUSE_READ, &regs);
+	if (err < 0)
+		pr_err("Failed to read efuse memory (%d)\n", err);
 
-	if (regs.regs[0] == 0)
-		return -1;
-
-	memcpy(buffer, shmem_output, min(size, regs.regs[0]));
-
-	return regs.regs[0];
+	return err;
 }
 
 ssize_t meson_sm_write_efuse(uintptr_t offset, void *buffer, size_t size)
 {
-	struct pt_regs regs;
-
-	meson_init_shmem();
+	struct udevice *dev;
+	struct pt_regs regs = { 0 };
+	int err;
 
-        memcpy(shmem_input, buffer, size);
+	dev = meson_get_sm_device();
+	if (IS_ERR(dev))
+		return PTR_ERR(dev);
 
-	regs.regs[0] = FN_EFUSE_WRITE;
 	regs.regs[1] = offset;
 	regs.regs[2] = size;
 
-	smc_call(&regs);
+	err = sm_call_write(dev, buffer, size,
+			    MESON_SMC_CMD_EFUSE_WRITE, &regs);
+	if (err < 0)
+		pr_err("Failed to write efuse memory (%d)\n", err);
 
-	return regs.regs[0];
+	return err;
 }
 
 #define SM_CHIP_ID_LENGTH	119
@@ -90,18 +83,21 @@ ssize_t meson_sm_write_efuse(uintptr_t offset, void *buffer, size_t size)
 
 int meson_sm_get_serial(void *buffer, size_t size)
 {
-	struct pt_regs regs;
+	struct udevice *dev;
+	struct pt_regs regs = { 0 };
+	u8 id_buffer[SM_CHIP_ID_LENGTH];
+	int err;
 
-	meson_init_shmem();
+	dev = meson_get_sm_device();
+	if (IS_ERR(dev))
+		return PTR_ERR(dev);
 
-	regs.regs[0] = FN_CHIP_ID;
-	regs.regs[1] = 0;
-	regs.regs[2] = 0;
+	err = sm_call_read(dev, id_buffer, SM_CHIP_ID_LENGTH,
+			   MESON_SMC_CMD_CHIP_ID_GET, &regs);
+	if (err < 0)
+		pr_err("Failed to read serial number (%d)\n", err);
 
-	smc_call(&regs);
-
-	memcpy(buffer, shmem_output + SM_CHIP_ID_OFFSET,
-	       min_t(size_t, size, SM_CHIP_ID_SIZE));
+	memcpy(buffer, id_buffer + SM_CHIP_ID_OFFSET, size);
 
 	return 0;
 }
@@ -141,13 +137,21 @@ int meson_sm_get_reboot_reason(void)
 
 int meson_sm_pwrdm_set(size_t index, int cmd)
 {
-	struct pt_regs regs;
+	struct udevice *dev;
+	struct pt_regs regs = { 0 };
+	int err;
+
+	dev = meson_get_sm_device();
+	if (IS_ERR(dev))
+		return PTR_ERR(dev);
 
-	regs.regs[0] = FN_PWRDM_SET;
 	regs.regs[1] = index;
 	regs.regs[2] = cmd;
 
-	smc_call(&regs);
+	err = sm_call(dev, MESON_SMC_CMD_PWRDM_SET, NULL, &regs);
+	if (err)
+		pr_err("Failed to %s power domain ind=%zu (%d)\n", cmd == PWRDM_ON ?
+				"enable" : "disable", index, err);
 
-	return regs.regs[0];
+	return err;
 }
-- 
2.25.1

