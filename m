Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F7AC1075275
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 08:37:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89B7D83E36;
	Thu, 19 Mar 2026 09:37:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03FE883F8A; Thu, 19 Mar 2026 09:37:56 +0100 (CET)
Received: from Atcsqr.andestech.com (unknown [60.248.187.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5422683DA6
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 09:37:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTP id 62J8bIUD017661;
 Thu, 19 Mar 2026 16:37:18 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Mar
 2026 16:37:18 +0800
From: Leo Yu-Chi Liang <ycliang@andestech.com>
To: <u-boot@lists.denx.de>
CC: <pbonzini@redhat.com>, <trini@konsulko.com>, <rick@andestech.com>,
 <ycliang@andestech.com>, <jerome.forissier@arm.com>,
 <xypron.glpk@gmx.de>, <ilias.apalodimas@linaro.org>,
 <kory.maincent@bootlin.com>,
 <eric.schikschneit@novatechautomation.com>, <sputnik@on-the-web.ch>,
 <michal.simek@amd.com>, <cnoize@andestech.com>, <qemu-devel@nongnu.org>
Subject: [PATCH 4/6] cache: andes-l2: Add writeback-invalidate operation
Date: Thu, 19 Mar 2026 16:37:11 +0800
Message-ID: <20260319083713.3456894-2-ycliang@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260319083713.3456894-1-ycliang@andestech.com>
References: <20260319083713.3456894-1-ycliang@andestech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 62J8bIUD017661
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

Add a wbinval operation to the cache uclass that performs
writeback-invalidate without the disable/enable cycle that the
existing disable path uses. This is needed for flush_dcache_all()
to properly flush both L1 and L2 caches.

Implement andes_l2_wbinval_all() in the Andes L2 cache driver
which issues the L2_WBINVAL_ALL command while keeping the cache
enabled.

Update flush_dcache_all() in the Andes cache code to also call
L2 wbinval when CONFIG_ANDES_L2_CACHE is enabled.

Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech.com>
---
 arch/riscv/cpu/andes/cache.c   |  4 ++++
 drivers/cache/cache-andes-l2.c | 24 ++++++++++++++++++++++++
 drivers/cache/cache-uclass.c   | 10 ++++++++++
 include/cache.h                | 16 ++++++++++++++++
 4 files changed, 54 insertions(+)

diff --git a/arch/riscv/cpu/andes/cache.c b/arch/riscv/cpu/andes/cache.c
index bb57498d75a..3b325d77954 100644
--- a/arch/riscv/cpu/andes/cache.c
+++ b/arch/riscv/cpu/andes/cache.c
@@ -44,6 +44,10 @@ static void cache_ops(int (*ops)(struct udevice *dev))
 void flush_dcache_all(void)
 {
 	csr_write(CSR_UCCTLCOMMAND, CCTL_L1D_WBINVAL_ALL);
+
+#ifdef CONFIG_ANDES_L2_CACHE
+	cache_ops(cache_wbinval);
+#endif
 }
 
 void flush_dcache_range(unsigned long start, unsigned long end)
diff --git a/drivers/cache/cache-andes-l2.c b/drivers/cache/cache-andes-l2.c
index 45a4f216b07..5ceccf609e5 100644
--- a/drivers/cache/cache-andes-l2.c
+++ b/drivers/cache/cache-andes-l2.c
@@ -91,6 +91,29 @@ static int andes_l2_enable(struct udevice *dev)
 	return 0;
 }
 
+static int andes_l2_wbinval_all(struct udevice *dev)
+{
+	struct andes_l2_plat *plat = dev_get_plat(dev);
+	volatile struct l2cache *regs = plat->regs;
+	u8 hart = gd->arch.boot_hart;
+
+	void __iomem *cctlcmd = (void __iomem *)CCTL_CMD_REG(regs, hart);
+	void __iomem *cctlstatus = (void __iomem *)CCTL_STATUS_REG(regs, hart);
+
+	if ((regs) && (readl(&regs->control) & L2_ENABLE)) {
+		writel(L2_WBINVAL_ALL, cctlcmd);
+
+		while ((readl(cctlstatus) & CCTL_STATUS_MSK(hart))) {
+			if ((readl(cctlstatus) & CCTL_STATUS_ILLEGAL(hart))) {
+				printf("L2 flush illegal! hanging...");
+				hang();
+			}
+		}
+	}
+
+	return 0;
+}
+
 static int andes_l2_disable(struct udevice *dev)
 {
 	struct andes_l2_plat *plat = dev_get_plat(dev);
@@ -192,6 +215,7 @@ static const struct udevice_id andes_l2_cache_ids[] = {
 static const struct cache_ops andes_l2_cache_ops = {
 	.enable		= andes_l2_enable,
 	.disable	= andes_l2_disable,
+	.wbinval	= andes_l2_wbinval_all,
 };
 
 U_BOOT_DRIVER(andes_l2_cache) = {
diff --git a/drivers/cache/cache-uclass.c b/drivers/cache/cache-uclass.c
index 300e7bc86e1..8e77c9e2f4e 100644
--- a/drivers/cache/cache-uclass.c
+++ b/drivers/cache/cache-uclass.c
@@ -38,6 +38,16 @@ int cache_disable(struct udevice *dev)
 	return ops->disable(dev);
 }
 
+int cache_wbinval(struct udevice *dev)
+{
+	struct cache_ops *ops = cache_get_ops(dev);
+
+	if (!ops->wbinval)
+		return -ENOSYS;
+
+	return ops->wbinval(dev);
+}
+
 UCLASS_DRIVER(cache) = {
 	.id		= UCLASS_CACHE,
 	.name		= "cache",
diff --git a/include/cache.h b/include/cache.h
index 296ae3c8b48..45b27ab989c 100644
--- a/include/cache.h
+++ b/include/cache.h
@@ -42,6 +42,14 @@ struct cache_ops {
 	 * @return 0 if OK, -ve on error
 	 */
 	int (*disable)(struct udevice *dev);
+
+	/**
+	 * wbinval() - Writeback and invalidate cache
+	 *
+	 * @dev:	Device to check (UCLASS_CACHE)
+	 * @return 0 if OK, -ve on error
+	 */
+	int (*wbinval)(struct udevice *dev);
 };
 
 #define cache_get_ops(dev)	((struct cache_ops *)(dev)->driver->ops)
@@ -70,4 +78,12 @@ int cache_enable(struct udevice *dev);
  * Return: 0 if OK, -ve on error
  */
 int cache_disable(struct udevice *dev);
+
+/**
+ * cache_wbinval() - Writeback and invalidate cache
+ *
+ * @dev:	Device to check (UCLASS_CACHE)
+ * Return: 0 if OK, -ve on error
+ */
+int cache_wbinval(struct udevice *dev);
 #endif
-- 
2.34.1

