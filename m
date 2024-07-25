Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA36C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 09:33:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F63A87C86;
	Thu, 25 Jul 2024 11:32:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 657DA8752A; Thu, 25 Jul 2024 11:32:50 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88F0E86E35
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 11:32:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Zhiqiang.Hou@nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 50AC220058A;
 Thu, 25 Jul 2024 11:32:48 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 20BDB20058E;
 Thu, 25 Jul 2024 11:32:48 +0200 (CEST)
Received: from mega.am.freescale.net (mega.ap.freescale.net [10.192.208.232])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id
 34659183ACAF; Thu, 25 Jul 2024 17:32:47 +0800 (+08)
From: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To: u-boot@lists.denx.de, trini@konsulko.com, peng.fan@nxp.com,
 festevam@gmail.com, sjg@chromium.org
Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv2 1/9] cpu: add release_core callback
Date: Thu, 25 Jul 2024 17:53:23 +0800
Message-Id: <20240725095331.14245-2-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240725095331.14245-1-Zhiqiang.Hou@nxp.com>
References: <20240725095331.14245-1-Zhiqiang.Hou@nxp.com>
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

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Add a new callback release_core to the cpu_ops, which is used to
release a CPU core to run baremetal or RTOS application on a SoC
with multiple CPU cores.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V2:
 - No change.

 drivers/cpu/cpu-uclass.c | 10 ++++++++++
 include/cpu.h            | 15 +++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/cpu/cpu-uclass.c b/drivers/cpu/cpu-uclass.c
index 16f8f2e5219..2c8e46c05e3 100644
--- a/drivers/cpu/cpu-uclass.c
+++ b/drivers/cpu/cpu-uclass.c
@@ -104,6 +104,16 @@ int cpu_get_vendor(const struct udevice *dev, char *buf, int size)
 	return ops->get_vendor(dev, buf, size);
 }
 
+int cpu_release_core(const struct udevice *dev, phys_addr_t addr)
+{
+	struct cpu_ops *ops = cpu_get_ops(dev);
+
+	if (!ops->release_core)
+		return -ENOSYS;
+
+	return ops->release_core(dev, addr);
+}
+
 U_BOOT_DRIVER(cpu_bus) = {
 	.name	= "cpu_bus",
 	.id	= UCLASS_SIMPLE_BUS,
diff --git a/include/cpu.h b/include/cpu.h
index 2077ff30634..0018910d61f 100644
--- a/include/cpu.h
+++ b/include/cpu.h
@@ -102,6 +102,15 @@ struct cpu_ops {
 	 *         if not.
 	 */
 	int (*is_current)(struct udevice *dev);
+
+	/**
+	 * release_core() - Relase a CPU core to the given address to run application
+	 *
+	 * @dev:	Device to check (UCLASS_CPU)
+	 * @addr:	Address to relese the CPU core
+	 * @return 0 if OK, -ve on error
+	 */
+	int (*release_core)(const struct udevice *dev, phys_addr_t addr);
 };
 
 #define cpu_get_ops(dev)        ((struct cpu_ops *)(dev)->driver->ops)
@@ -164,4 +173,10 @@ int cpu_is_current(struct udevice *cpu);
  */
 struct udevice *cpu_get_current_dev(void);
 
+/**
+ * cpu_release_core() - Relase a CPU core to the given address to run application
+ *
+ * @return 0 if OK, -ve on error
+ */
+int cpu_release_core(const struct udevice *dev, phys_addr_t addr);
 #endif
-- 
2.43.0

