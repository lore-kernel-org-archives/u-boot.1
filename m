Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B6BACD8C8C
	for <u-boot@archiver.kernel.org>; Sun,  7 Jun 2026 19:34:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 442E784825;
	Sun,  7 Jun 2026 21:34:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="tzjTieSz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDBDA801A9; Sun,  7 Jun 2026 17:46:10 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 410038466E
 for <u-boot@lists.denx.de>; Sun,  7 Jun 2026 17:46:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+raz.benyehuda.mobileye.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 0EFD743D31;
 Sun,  7 Jun 2026 15:46:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E3018C4AF0E;
 Sun,  7 Jun 2026 15:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1780847164;
 bh=LaQqF/M539crvy+xt8p7kwJ55FrlNd5NEnVcLe+Fcw4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=tzjTieSzDFgBpsHym577M5pp1sbuYBRDWElvQrDBMD2HwFuk6AJNt1ha0JGBDjN6L
 pPyncFg04skJ5AuzXjOC/7yguLWiPdLgEaUGWSL+f2eUPByTBUZSIV++KCygsFwg2e
 rJWavWi6u5VEl0i1uLSw4WJczW2jPAJ3wgzK7W5GHfb4vaVBM9NAuZE5q0NymGKi7T
 YmuJoOfhVEW7XL4Krm/i0iY3snkj1mYsBGsC/2opdzrbbynG4AE4jwcZSIwjxixVA5
 vNiDMCJ1x3/fE0fLU7rKVU0kPQPMzIJDBKjIAstJhiHyn47Euh3/wBMFM6vS+1/+gY
 JmNEzdheUGnSA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id CE352CD8C8E;
 Sun,  7 Jun 2026 15:46:04 +0000 (UTC)
From: Raz Ben Yehuda via B4 Relay
 <devnull+raz.benyehuda.mobileye.com@kernel.org>
Date: Sun, 07 Jun 2026 18:45:31 +0300
Subject: [PATCH v2 1/5] ufs: Expose selected UFS functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260607-ufs_tool2-v2-1-f79ff26ab18c@mobileye.com>
References: <20260607-ufs_tool2-v2-0-f79ff26ab18c@mobileye.com>
In-Reply-To: <20260607-ufs_tool2-v2-0-f79ff26ab18c@mobileye.com>
To: u-boot@lists.denx.de
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Padmarao Begari <padmarao.begari@amd.com>, 
 Michal Simek <michal.simek@amd.com>, Julien Stephan <jstephan@baylibre.com>, 
 Udit Kumar <u-kumar1@ti.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>, Jared McArthur <j-mcarthur@ti.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Heiko Schocher <hs@nabladev.com>, Simon Glass <sjg@chromium.org>, 
 briansune <briansune@gmail.com>, Yao Zi <me@ziyao.cc>, 
 Peng Fan <peng.fan@nxp.com>, Kory Maincent <kory.maincent@bootlin.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Raz Ben Yehuda <raz.benyehuda@mobileye.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3263;
 i=raz.benyehuda@mobileye.com; h=from:subject:message-id;
 bh=tjVVnkP/yyjwwqNo6tVzv9fccgwCQWNEWJR2cUikUkk=;
 b=owEBbQKS/ZANAwAKAZ+a6ZSW6I45AcsmYgBqJZI4Hmv1GBma7JI1CrfHF64wFKbNTlMqQwWMo
 DyVG+zOROqJAjMEAAEKAB0WIQSC7lz5E3UmOrJvRDqfmumUluiOOQUCaiWSOAAKCRCfmumUluiO
 Od2YD/9+OagWPj9ZNmwvNVkHF6UGPI96cnchEN9We7616cuZGIJ1nAL3l/JB7LBN2lPcw8VyRUv
 0PCeWfYDosCnAxubMWhJhAbtihdOXeuweCwlDoq9AXZ3tBbWZ0c5BD7BExUhnNSnP5N6uQyaCKW
 d/g/V3+8VtzgSXV0sl8cmXOdxQC5r+7NFsYEqThQ/3MI+A1Yuxs2lfdcHoHoGfVTxFdx8gMa5e4
 A08sBIBS0ojNERTUGkjT79mFK5UvRlIq4Ils3rVbwPXWd/O3foGXd6e64uAf/ygQeKbZYBdxiuO
 mHsYxUiuOjowBkziwc2nDFq/AO+/9HZ/w3TFfb2rTfHWoOcr4KtYdUPQ8UujSBEZlVANDp//ghb
 NOz4tXEzlXLpHYqqg/z7z9tTaoJCEDMIu20HfEvdichVJLyAueUZAQWTMr0n/7dxggxRc4rHuVM
 PspoSB5JRNURpWJDwg8J4+AJ+/AERHgIUK5OKJ6BjFPEyaq1au++ER8/eRmYJkcW7R+jp1cgm4d
 XHy1OS1Z1PoruCX0hdQraPkJZ6gslDehpLrwAqVmTJMcxMs1RCwjrcrfswh3qCST97ngt3ccb14
 8fE9SJ1t8nBAgGTZ8JivQh0pG1GbPuSgbHsHEq3qPgM8YYHpJRiT4eA3ujZJd8IYY9pKt4DbrVU
 Vnr+5PujlvJQoyA==
X-Developer-Key: i=raz.benyehuda@mobileye.com; a=openpgp;
 fpr=82EE5CF91375263AB26F443A9F9AE99496E88E39
X-Endpoint-Received: by B4 Relay for raz.benyehuda@mobileye.com/default
 with auth_id=808
X-Original-From: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
X-Mailman-Approved-At: Sun, 07 Jun 2026 21:34:17 +0200
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
Reply-To: raz.benyehuda@mobileye.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Raz Ben Yehuda <raz.benyehuda@mobileye.com>

Remove static qualifier from selected functios to allow
future use

Signed-off-by: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
---
 drivers/ufs/ufs-uclass.c | 18 +++++++++---------
 drivers/ufs/ufs.h        | 13 +++++++++++++
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
index 6a51f337e47..78f6064ddea 100644
--- a/drivers/ufs/ufs-uclass.c
+++ b/drivers/ufs/ufs-uclass.c
@@ -757,7 +757,7 @@ static inline u8 ufshcd_get_upmcrs(struct ufs_hba *hba)
  *
  * Flush cache in aligned address..address+size range.
  */
-static void ufshcd_cache_flush(void *addr, unsigned long size)
+void ufshcd_cache_flush(void *addr, unsigned long size)
 {
 	uintptr_t start_addr = (uintptr_t)addr & ~(ARCH_DMA_MINALIGN - 1);
 	uintptr_t end_addr = ALIGN((uintptr_t)addr + size, ARCH_DMA_MINALIGN);
@@ -1089,8 +1089,8 @@ static inline void ufshcd_init_query(struct ufs_hba *hba,
 /**
  * ufshcd_query_flag() - API function for sending flag query requests
  */
-static int ufshcd_query_flag(struct ufs_hba *hba, enum query_opcode opcode,
-			     enum flag_idn idn, bool *flag_res)
+int ufshcd_query_flag(struct ufs_hba *hba, enum query_opcode opcode,
+		      enum flag_idn idn, bool *flag_res)
 {
 	struct ufs_query_req *request = NULL;
 	struct ufs_query_res *response = NULL;
@@ -1320,9 +1320,9 @@ out:
 /**
  * ufshcd_query_descriptor_retry - API function for sending descriptor requests
  */
-static int ufshcd_query_descriptor_retry(struct ufs_hba *hba, enum query_opcode opcode,
-					 enum desc_idn idn, u8 index, u8 selector,
-					 u8 *desc_buf, int *buf_len)
+int  ufshcd_query_descriptor_retry(struct ufs_hba *hba, enum query_opcode opcode,
+				   enum desc_idn idn, u8 index, u8 selector,
+				   u8 *desc_buf, int *buf_len)
 {
 	int err;
 	int retries;
@@ -1457,9 +1457,9 @@ static int ufshcd_map_desc_id_to_length(struct ufs_hba *hba, enum desc_idn desc_
  * ufshcd_read_desc_param - read the specified descriptor parameter
  *
  */
-static int ufshcd_read_desc_param(struct ufs_hba *hba, enum desc_idn desc_id,
-				  int desc_index, u8 param_offset,
-				  u8 *param_read_buf, u8 param_size)
+int ufshcd_read_desc_param(struct ufs_hba *hba, enum desc_idn desc_id,
+			   int desc_index, u8 param_offset,
+			   u8 *param_read_buf, u8 param_size)
 {
 	int ret;
 	u8 *desc_buf;
diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
index 0f6c93fbce7..213b489e5e4 100644
--- a/drivers/ufs/ufs.h
+++ b/drivers/ufs/ufs.h
@@ -809,4 +809,17 @@ static inline void ufshcd_rmwl(struct ufs_hba *hba, u32 mask, u32 val, u32 reg)
 
 int ufshcd_probe(struct udevice *dev, struct ufs_hba_ops *hba_ops);
 
+int ufshcd_read_desc_param(struct ufs_hba *hba, enum desc_idn desc_id,
+			   int desc_index, u8 param_offset, u8 *param_read_buf,
+			   u8 param_size);
+
+void ufshcd_cache_flush(void *addr, unsigned long size);
+
+int ufshcd_query_flag(struct ufs_hba *hba, enum query_opcode opcode,
+		      enum flag_idn idn, bool *flag_res);
+
+int ufshcd_query_descriptor_retry(struct ufs_hba *hba, enum query_opcode opcode,
+				  enum desc_idn idn, u8 index, u8 selector,
+				  u8 *desc_buf, int *buf_len);
+
 #endif

-- 
2.43.0


