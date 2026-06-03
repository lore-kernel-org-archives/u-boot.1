Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F0A1CD6E60
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 15:58:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 942A684881;
	Wed,  3 Jun 2026 17:58:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="key not found in DNS" (0-bit key; unprotected) header.d=mobileye.com header.i=@mobileye.com header.b="edPza2BV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 956CF84879; Wed,  3 Jun 2026 14:46:05 +0200 (CEST)
Received: from esa2.hc555-34.eu.iphmx.com (esa2.hc555-34.eu.iphmx.com
 [23.90.104.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFB2183FF5
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 14:46:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=mobileye.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raz.benyehuda@mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
 t=1780490763; x=1812026763;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=w9aMwcNgVV6g++SSkq19wK/WI4WHS4pZvkyifVJj80A=;
 b=edPza2BV8nqWNmY1NR6OC/Yo+LMe3iwCLtc/c2hCWlfAUo7o9DhjHGb2
 fJPjlcr0OKoN+L66LlE4tKLofv7cd1Jz1RFdNQnGHxcutyOZUfLiUORzv
 VGTRB6QsJjFF3eUUP9qx5CxVHdGoSHAwxiy1egnrDfKZpi5BGLSPXesrh
 VdotAguMDvnHbV7Ql6oXlIxu53aCxMO7FA+CBmv6Y5Y3LyfDuuHuMPwLY
 HsgCgiyryeEr5pRIrlppR+Zgwo/js4Q0lG3rETazibqcdQfqLbVWaY4pa
 7GiBnn12za4oheq/SINkWk8TNLaUvxcjdInAlf/4xJe+GGM15GqQdfkf5 w==;
X-CSE-ConnectionGUID: UQHC+q+RTdSyKP4FCfKLOg==
X-CSE-MsgGUID: Y4kFEtioRgaZxHhK2ZRu/Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces03_data.me-corp.lan) ([146.255.191.134])
 by esa2.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2026 15:46:02 +0300
X-CSE-ConnectionGUID: gLao5qugQvCfVCnvvcDdJA==
X-CSE-MsgGUID: Y7aQWkazQouTZbG37axKgQ==
Received: from unknown (HELO epgd041.me-corp.lan) ([10.154.54.2])
 by ces03_data.me-corp.lan with SMTP; 03 Jun 2026 15:50:37 +0300
Received: by epgd041.me-corp.lan (sSMTP sendmail emulation);
 Wed, 03 Jun 2026 15:46:00 +0300
From: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
To: u-boot@lists.denx.de
Cc: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
Subject: [PATCH 2/5] ufs: Expose selected UFS functions
Date: Wed,  3 Jun 2026 15:45:36 +0300
Message-ID: <20260603124553.3763516-2-raz.benyehuda@mobileye.com>
In-Reply-To: <20260603124553.3763516-1-raz.benyehuda@mobileye.com>
References: <20260603124553.3763516-1-raz.benyehuda@mobileye.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 03 Jun 2026 17:58:19 +0200
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

Remove the static qualifier from selected functions to allow
future reuse.

Signed-off-by: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
---
 drivers/ufs/ufs-uclass.c | 18 +++++++++---------
 drivers/ufs/ufs.h        | 16 ++++++++++++++++
 2 files changed, 25 insertions(+), 9 deletions(-)

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
index 0f6c93fbce7..75b7ff83155 100644
--- a/drivers/ufs/ufs.h
+++ b/drivers/ufs/ufs.h
@@ -218,6 +218,9 @@ enum flag_idn {
 	QUERY_FLAG_IDN_BUSY_RTC				= 0x09,
 	QUERY_FLAG_IDN_RESERVED3			= 0x0A,
 	QUERY_FLAG_IDN_PERMANENTLY_DISABLE_FW_UPDATE	= 0x0B,
+	QUERY_FLAG_IDN_F_WRITE_BOOSTER_EN               = 0x0E,
+	QUERY_FLAG_IDN_F_WB_BUF_FLUSH_EN                = 0x0F,
+	QUERY_FLAG_IDN_F_WB_BUF_FLUSH_HIBERN8           = 0x10
 };
 
 /* Attribute idn for Query requests */
@@ -809,4 +812,17 @@ static inline void ufshcd_rmwl(struct ufs_hba *hba, u32 mask, u32 val, u32 reg)
 
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

