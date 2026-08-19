Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC903C5DF6D
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 07:08:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8739440661;
	Wed, 19 Aug 2026 07:08:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nCZrO7DqXkGu; Wed, 19 Aug 2026 07:08:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787123303;
	bh=9kR5aH5UduGLke8hEoV2Z43VVVgiKxNy03va90hrPw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DqUYfOH2//QCXY6f1FWGzzYRc8HyJrBizkNv8BvdyVc86FzLUUZcuq2ypwuVtn/OV
	 po8hRjZ0e99o/ngX9N4ccBIG9LtoKWgCB20QjL4pgJMFKHLni8hFrgr+nkmedq7A/W
	 qhtyh7OAdng3+XaO9BjlLWOXCbMTJ80QhAjUZFlm0m6Kc7mVScPN3/e5KLH4MWW+Vm
	 TnVqPuHIr58uKP6EatLZJnMwv189dgpe8u8xI3xjH7IJSamqSW74ytU5eQq2RtoSi5
	 gkcHT/l4KORhys6/6iCgO+2G7JGXiq0K1f/+01P/9U0MAFaoDMk6HnYEpX7w1n9wvb
	 d84sy4ouD++Dw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 99641406DB;
	Wed, 19 Aug 2026 07:08:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8D7D83AC
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 07:08:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 73BFF80E5D
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 07:08:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cItHsLCC1r5e for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 07:08:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.203.77.234;
 helo=mail.fris.de; envelope-from=frieder@fris.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=fris.de header.i=@fris.de header.a=rsa-sha256
 header.s=mail header.b=SzqzusjG
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9A94E80E5C
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 07:08:18 +0000 (UTC)
From: Frieder Schrempf <frieder@fris.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=mail;
 t=1787123296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9kR5aH5UduGLke8hEoV2Z43VVVgiKxNy03va90hrPw4=;
 b=SzqzusjGBOE/+CDTg0Lr+X7xSfLogmCor6fj9Ms/snWLqG7IJKwg2iGnP9BPB3o2KVbhaR
 IvRgG+Dag3z7RJPal5I8avOtuVMrYwqigTmBjNAgQW0ZuzhgRCUJXzKopg9y7KtJJkmnZ1
 J7FPlhxJzpnKhM2gAATVPpIdp94OLdiifRinHncS+gSYxD7QFKgjv9Wk8vDYoLqVnm65su
 SqCRaOREgSxhOmNELDBx/M9q6iJW0vvZW5v4bucxvAIcGaeO+ptSQx8cfrl6jo1SkuNAi4
 P7bxpW6MbGDoso1EuY2xgUelGLSHtOMawU1f/i6+zRZwIIuVPzWV0C/cOHWrCw==
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Cc: uboot-imx@nxp.com, Frieder Schrempf <frieder.schrempf@kontron.de>,
 Marek Vasut <marex@nabladev.com>, Simona Toaca <simona.toaca@nxp.com>,
 Viorel Suman <viorel.suman@nxp.com>
Subject: [PATCH v2 3/4] ddr: imx: Allow to call ddr init without logging
 failure
Date: Wed, 19 Aug 2026 09:07:54 +0200
Message-ID: <20260819070758.51350-3-frieder@fris.de>
In-Reply-To: <20260819070758.51350-1-frieder@fris.de>
References: <20260819070758.51350-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

In some cases we need to call ddr_init() multiple times to try
different configurations. In this case failures are expected and
error messages cause confusion. Introduce ddr_init_silent_fail()
for those cases.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 arch/arm/include/asm/arch-imx8m/ddr.h |  4 +++-
 arch/arm/include/asm/arch-imx9/ddr.h  |  4 +++-
 drivers/ddr/imx/imx8m/ddr_init.c      | 14 ++++++++++++--
 drivers/ddr/imx/imx9/ddr_init.c       | 14 ++++++++++++--
 drivers/ddr/imx/phy/ddrphy_train.c    |  5 +++--
 5 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/arch/arm/include/asm/arch-imx8m/ddr.h b/arch/arm/include/asm/arch-imx8m/ddr.h
index 5092ccae188..442c45237f9 100644
--- a/arch/arm/include/asm/arch-imx8m/ddr.h
+++ b/arch/arm/include/asm/arch-imx8m/ddr.h
@@ -9,6 +9,7 @@
 #include <asm/io.h>
 #include <asm/types.h>
 #include <asm/arch/imx-regs.h>
+#include <linux/types.h>
 
 #define DDRC_DDR_SS_GPR0		0x3d000000
 #define DDRC_IPS_BASE_ADDR_0		0x3f400000
@@ -705,8 +706,9 @@ struct dram_timing_info {
 extern struct dram_timing_info dram_timing;
 
 void ddr_load_train_firmware(enum fw_type type);
+int ddr_init_silent_fail(struct dram_timing_info *timing_info);
 int ddr_init(struct dram_timing_info *timing_info);
-int ddr_cfg_phy(struct dram_timing_info *timing_info);
+int ddr_cfg_phy(struct dram_timing_info *timing_info, bool log_fail);
 void load_lpddr4_phy_pie(void);
 void ddrphy_trained_csr_save(struct dram_cfg_param *param, unsigned int num);
 void *dram_config_save(struct dram_timing_info *info, unsigned long base);
diff --git a/arch/arm/include/asm/arch-imx9/ddr.h b/arch/arm/include/asm/arch-imx9/ddr.h
index b0f90b53f64..c85f4cc7810 100644
--- a/arch/arm/include/asm/arch-imx9/ddr.h
+++ b/arch/arm/include/asm/arch-imx9/ddr.h
@@ -8,6 +8,7 @@
 
 #include <asm/io.h>
 #include <asm/types.h>
+#include <linux/types.h>
 
 #define DDR_CTL_BASE			0x4E300000
 #define DDR_PHY_BASE			0x4E100000
@@ -147,8 +148,9 @@ struct ddrphy_qb_state {
 };
 
 void ddr_load_train_firmware(enum fw_type type);
+int ddr_init_silent_fail(struct dram_timing_info *timing_info);
 int ddr_init(struct dram_timing_info *timing_info);
-int ddr_cfg_phy(struct dram_timing_info *timing_info);
+int ddr_cfg_phy(struct dram_timing_info *timing_info, bool log_fail);
 void load_lpddr4_phy_pie(void);
 void ddrphy_trained_csr_save(struct dram_cfg_param *param, unsigned int num);
 void *dram_config_save(struct dram_timing_info *info, unsigned long base);
diff --git a/drivers/ddr/imx/imx8m/ddr_init.c b/drivers/ddr/imx/imx8m/ddr_init.c
index e9209ce8b61..537c36acc8d 100644
--- a/drivers/ddr/imx/imx8m/ddr_init.c
+++ b/drivers/ddr/imx/imx8m/ddr_init.c
@@ -310,7 +310,7 @@ void update_umctl2_rank_space_setting(unsigned int pstat_num)
 	}
 }
 
-int ddr_init(struct dram_timing_info *dram_timing)
+static int __ddr_init(struct dram_timing_info *dram_timing, bool log_fail)
 {
 	unsigned int tmp, initial_drate, target_freq;
 	int ret;
@@ -390,7 +390,7 @@ int ddr_init(struct dram_timing_info *dram_timing)
 	 */
 	debug("DDRINFO:ddrphy config start\n");
 
-	ret = ddr_cfg_phy(dram_timing);
+	ret = ddr_cfg_phy(dram_timing, log_fail);
 	if (ret)
 		return ret;
 
@@ -470,6 +470,16 @@ int ddr_init(struct dram_timing_info *dram_timing)
 	return 0;
 }
 
+int ddr_init(struct dram_timing_info *dram_timing)
+{
+	return __ddr_init(dram_timing, true);
+}
+
+int ddr_init_silent_fail(struct dram_timing_info *dram_timing)
+{
+	return __ddr_init(dram_timing, false);
+}
+
 ulong ddrphy_addr_remap(uint32_t paddr_apb_from_ctlr)
 {
 	return 4 * paddr_apb_from_ctlr;
diff --git a/drivers/ddr/imx/imx9/ddr_init.c b/drivers/ddr/imx/imx9/ddr_init.c
index 5b0ad773875..f2600c65703 100644
--- a/drivers/ddr/imx/imx9/ddr_init.c
+++ b/drivers/ddr/imx/imx9/ddr_init.c
@@ -335,7 +335,7 @@ void save_trained_mr12_14(struct dram_cfg_param *cfg, u32 cfg_num, u32 mr12, u32
 	}
 }
 
-int ddr_init(struct dram_timing_info *dram_timing)
+static int __ddr_init(struct dram_timing_info *dram_timing, bool log_fail)
 {
 	unsigned int initial_drate;
 	struct dram_timing_info *saved_timing;
@@ -361,7 +361,7 @@ int ddr_init(struct dram_timing_info *dram_timing)
 	 */
 	debug("DDRINFO:ddrphy config start\n");
 
-	ret = ddr_cfg_phy(dram_timing);
+	ret = ddr_cfg_phy(dram_timing, log_fail);
 	if (ret)
 		return ret;
 
@@ -412,6 +412,16 @@ int ddr_init(struct dram_timing_info *dram_timing)
 	return 0;
 }
 
+int ddr_init(struct dram_timing_info *dram_timing)
+{
+	return __ddr_init(dram_timing, true);
+}
+
+int ddr_init_silent_fail(struct dram_timing_info *dram_timing)
+{
+	return __ddr_init(dram_timing, false);
+}
+
 ulong ddrphy_addr_remap(u32 paddr_apb_from_ctlr)
 {
 	u32 paddr_apb_qual;
diff --git a/drivers/ddr/imx/phy/ddrphy_train.c b/drivers/ddr/imx/phy/ddrphy_train.c
index 68468610fd6..770a568d8f2 100644
--- a/drivers/ddr/imx/phy/ddrphy_train.c
+++ b/drivers/ddr/imx/phy/ddrphy_train.c
@@ -8,7 +8,7 @@
 #include <asm/arch/ddr.h>
 #include <asm/arch/sys_proto.h>
 
-int ddr_cfg_phy(struct dram_timing_info *dram_timing)
+int ddr_cfg_phy(struct dram_timing_info *dram_timing, bool log_fail)
 {
 	struct dram_cfg_param *dram_cfg;
 	struct dram_fsp_msg *fsp_msg;
@@ -73,7 +73,8 @@ int ddr_cfg_phy(struct dram_timing_info *dram_timing)
 		/* Wait for the training firmware to complete */
 		ret = wait_ddrphy_training_complete();
 		if (ret) {
-			printf("Training FAILED\n");
+			if (log_fail || _DEBUG)
+				printf("Training FAILED\n");
 			return ret;
 		}
 
-- 
2.55.0

