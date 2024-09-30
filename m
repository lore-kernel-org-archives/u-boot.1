Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B786DCF6499
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 12:45:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2299E88EFB;
	Mon, 30 Sep 2024 14:44:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pjMIK9fV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FE3C88D9B; Mon, 30 Sep 2024 14:44:40 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EDC988E1A
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 14:44:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-42cb0f28bfbso33328605e9.1
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 05:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727700274; x=1728305074; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Q3f/dQcwAhnGcS9GQKvNZXgCdNcW1/Vm7vzvFXIm/Mo=;
 b=pjMIK9fVy/B8dCsbB8z/OpA6LIXrGgP9WXzXXrDo4Im3W+3ep/mIoy4WS4vH5oyaL5
 XxK/b/JHq70QsuPIvZlNypniMrwBaEacNW52JN4DhmkzfuMI+soSvZcLoFjYAhLqop/C
 WZ8E0AUMs+XO5zP9d8pnEmhJoVJ/+au6tkyR313JXYY0p4xDMZ/Tsq1X31JV0wm1WEpU
 ZkomjqVMMnWCcvqj+487+GPLPmhu7OGirg6w4YugGJKnAVpjqfBMRWfgtBRSpTB7O9uR
 /WmWphevWuZLWoTkPpg7hpjWLdCw8pGSVTJHt8+TdNGUMn4jy483w2cNOqAcxzcH3mkx
 LkpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727700274; x=1728305074;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q3f/dQcwAhnGcS9GQKvNZXgCdNcW1/Vm7vzvFXIm/Mo=;
 b=qv1V5SREiRKIEgvdb1ZlEXXvdOWlBi8XI1mZGvaDKaRO+d90QH3XyGBH2+PHRcfJnf
 pg3mxe+c8myD2uM9ChxnTvtIM5Esx/A1VCJqqaNO5GNKkb6H+Cckem4SiMhR/Qd5etJc
 4f7xNwYAHH2zjL9Kodab/zI2PVLVgQeI5MS3ZJ9tnBlAq4Gt+fhi/VlC4cL+DQuh64sg
 UzAwoYUexIsyA3hTHJYE1fZl9opCrnrdagkPbCiZ2YyvoQ9KB7dSJIgQlO0oTeOB8xZt
 0KSd94FQ/eK+Ww4aGg9eviJDkYL9XN+AzfzhZzFYq/BV37VHDRMNyinzGZXNA8CTnTH6
 2XOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/jxIS+6RDoCO9T/Ihy/TR2CyLPW0K+IxUHL1DM8efHUvUx17Illl+SyKtiprGjw1kW2/hdHI=@lists.denx.de
X-Gm-Message-State: AOJu0YxULi3fk8fMWCKegNvpduIXbrVVir7WOxRx7WGFjqjU6rhyMizj
 pqs5pVCtp1mOURwX5EqmWsOnvUTxnMjH2lc7zHxJK1nWHyP7OsjOSodfYrwqe6M=
X-Google-Smtp-Source: AGHT+IEzt23HOzSvvK9+snPaCGK+42r8xHvL4nwzpYSMmHPUZ+Np6zVPIB6LIr5S1Q+tSNe1M7OAkQ==
X-Received: by 2002:a05:600c:3b87:b0:42c:c401:6d67 with SMTP id
 5b1f17b1804b1-42f58409e21mr81381425e9.6.1727700274517; 
 Mon, 30 Sep 2024 05:44:34 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e96a36597sm149362745e9.31.2024.09.30.05.44.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2024 05:44:33 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 30 Sep 2024 14:44:25 +0200
Subject: [PATCH v3 03/13] ufs: split flush and invalidate to only
 invalidate when required
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240930-topic-ufs-enhancements-v3-3-58234f84ab89@linaro.org>
References: <20240930-topic-ufs-enhancements-v3-0-58234f84ab89@linaro.org>
In-Reply-To: <20240930-topic-ufs-enhancements-v3-0-58234f84ab89@linaro.org>
To: Tom Rini <trini@konsulko.com>, Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>
Cc: Michal Simek <michal.simek@amd.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, bmeng.cn@gmail.com, 
 u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=5705;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=dZauaajcNAzB67hUPDnxtn7pEfA386aQNWWZ4IUJBzg=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm+p0pUT83UK3adW4eI+tCOnkMHx8MJXoW6pWXjOZC
 paTV/l6JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZvqdKQAKCRB33NvayMhJ0dy2EA
 C59jBy8emSftY6w4umBDM348IxChQ9qIbJOGnIwXfoOrQjSsfPhl145tMi4B5VwN+QK37TPSBSvg8X
 WHrY1cuKLF/pU1MSyHHhnBFC+BjuXw/RgtnVLlMrjBh1SfNhNP1q5UcZwZRfWjhcSjDXYqTshhkxeD
 WRUG3ZJIZgdkduWcZ2hWLkoWmADSnEgKGkTH6qRliAd2bP/X7Scgp/lJPNbLT9tVkMmRAjzUa1uUou
 NK20KbW8QYlKeDPmDNebWK//BtHTmftMth0TuH/O8GGwDAPucXjpAqFtm/sQmGl7KlQZ9WLr+kV2ey
 +TVqE07hg/gNf6FxyQOTXou5PF9e39upLmDMxFQKSnfG7s4qZj8MXYzZxR69U5ys8lQNd//7FLCzCZ
 RxlQ4JX8nRsSaHTXJWl4ZFOF7leHsGtZknEgDajKkJX1UXDub+yUFjaWF4YKg9PofjGIJlYkbKb7wP
 HU4tyrt1wjnibepbm5aaZ+tqFIefuxl3Zblx1ap48xLK/CEHInSYtKMdiLyU2KPDZexULy7ciwy9Jc
 rwRg8hH2isccbGR7L91oDT43IUCaEc7Og6Dw5y3/yiqFDqWeuYhFLHpjirJQiZ2ufK5Kc7jfUAZ27P
 Sf5ZvBH/sPGOFXcAkbrJietQCsge5ArHF3FpgkKBzpqapMj9jOLZu6ugUDcg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

There is no need to flush and invalidate all data updated by the
driver, mainly because on ARM platforms flush also invalidates
the cachelines.

Split the function in two and add the appropriate cacheline
invalidates after the UFS DMA operation finishes to make sure
we read from memory.

Flushing then invalidating cacheline unaligned data causes data
corruption issues on Qualcomm platforms, and is largely unnecessary
anyway, so let's cleanup the cache operations.

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
Tested-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/ufs/ufs.c | 45 ++++++++++++++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 15 deletions(-)

diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
index 3d9a7d7ee12..5845fd694d3 100644
--- a/drivers/ufs/ufs.c
+++ b/drivers/ufs/ufs.c
@@ -696,17 +696,28 @@ static inline u8 ufshcd_get_upmcrs(struct ufs_hba *hba)
 }
 
 /**
- * ufshcd_cache_flush_and_invalidate - Flush and invalidate cache
+ * ufshcd_cache_flush - Flush cache
  *
- * Flush and invalidate cache in aligned address..address+size range.
- * The invalidation is in place to avoid stale data in cache.
+ * Flush cache in aligned address..address+size range.
  */
-static void ufshcd_cache_flush_and_invalidate(void *addr, unsigned long size)
+static void ufshcd_cache_flush(void *addr, unsigned long size)
 {
 	uintptr_t start_addr = (uintptr_t)addr & ~(ARCH_DMA_MINALIGN - 1);
 	uintptr_t end_addr = ALIGN((uintptr_t)addr + size, ARCH_DMA_MINALIGN);
 
 	flush_dcache_range(start_addr, end_addr);
+}
+
+/**
+ * ufshcd_cache_invalidate - Invalidate cache
+ *
+ * Invalidate cache in aligned address..address+size range.
+ */
+static void ufshcd_cache_invalidate(void *addr, unsigned long size)
+{
+	uintptr_t start_addr = (uintptr_t)addr & ~(ARCH_DMA_MINALIGN - 1);
+	uintptr_t end_addr = ALIGN((uintptr_t)addr + size, ARCH_DMA_MINALIGN);
+
 	invalidate_dcache_range(start_addr, end_addr);
 }
 
@@ -754,7 +765,7 @@ static void ufshcd_prepare_req_desc_hdr(struct ufs_hba *hba,
 
 	req_desc->prd_table_length = 0;
 
-	ufshcd_cache_flush_and_invalidate(req_desc, sizeof(*req_desc));
+	ufshcd_cache_flush(req_desc, sizeof(*req_desc));
 }
 
 static void ufshcd_prepare_utp_query_req_upiu(struct ufs_hba *hba,
@@ -785,13 +796,13 @@ static void ufshcd_prepare_utp_query_req_upiu(struct ufs_hba *hba,
 	/* Copy the Descriptor */
 	if (query->request.upiu_req.opcode == UPIU_QUERY_OPCODE_WRITE_DESC) {
 		memcpy(ucd_req_ptr + 1, query->descriptor, len);
-		ufshcd_cache_flush_and_invalidate(ucd_req_ptr, 2 * sizeof(*ucd_req_ptr));
+		ufshcd_cache_flush(ucd_req_ptr, 2 * sizeof(*ucd_req_ptr));
 	} else {
-		ufshcd_cache_flush_and_invalidate(ucd_req_ptr, sizeof(*ucd_req_ptr));
+		ufshcd_cache_flush(ucd_req_ptr, sizeof(*ucd_req_ptr));
 	}
 
 	memset(hba->ucd_rsp_ptr, 0, sizeof(struct utp_upiu_rsp));
-	ufshcd_cache_flush_and_invalidate(hba->ucd_rsp_ptr, sizeof(*hba->ucd_rsp_ptr));
+	ufshcd_cache_flush(hba->ucd_rsp_ptr, sizeof(*hba->ucd_rsp_ptr));
 }
 
 static inline void ufshcd_prepare_utp_nop_upiu(struct ufs_hba *hba)
@@ -809,8 +820,8 @@ static inline void ufshcd_prepare_utp_nop_upiu(struct ufs_hba *hba)
 
 	memset(hba->ucd_rsp_ptr, 0, sizeof(struct utp_upiu_rsp));
 
-	ufshcd_cache_flush_and_invalidate(ucd_req_ptr, sizeof(*ucd_req_ptr));
-	ufshcd_cache_flush_and_invalidate(hba->ucd_rsp_ptr, sizeof(*hba->ucd_rsp_ptr));
+	ufshcd_cache_flush(ucd_req_ptr, sizeof(*ucd_req_ptr));
+	ufshcd_cache_flush(hba->ucd_rsp_ptr, sizeof(*hba->ucd_rsp_ptr));
 }
 
 /**
@@ -877,6 +888,8 @@ static int ufshcd_send_command(struct ufs_hba *hba, unsigned int task_tag)
  */
 static inline int ufshcd_get_req_rsp(struct utp_upiu_rsp *ucd_rsp_ptr)
 {
+	ufshcd_cache_invalidate(ucd_rsp_ptr, sizeof(*ucd_rsp_ptr));
+
 	return be32_to_cpu(ucd_rsp_ptr->header.dword_0) >> 24;
 }
 
@@ -888,6 +901,8 @@ static inline int ufshcd_get_tr_ocs(struct ufs_hba *hba)
 {
 	struct utp_transfer_req_desc *req_desc = hba->utrdl;
 
+	ufshcd_cache_invalidate(req_desc, sizeof(*req_desc));
+
 	return le32_to_cpu(req_desc->header.dword_2) & MASK_OCS;
 }
 
@@ -1437,8 +1452,8 @@ void ufshcd_prepare_utp_scsi_cmd_upiu(struct ufs_hba *hba,
 	memcpy(ucd_req_ptr->sc.cdb, pccb->cmd, cdb_len);
 
 	memset(hba->ucd_rsp_ptr, 0, sizeof(struct utp_upiu_rsp));
-	ufshcd_cache_flush_and_invalidate(ucd_req_ptr, sizeof(*ucd_req_ptr));
-	ufshcd_cache_flush_and_invalidate(hba->ucd_rsp_ptr, sizeof(*hba->ucd_rsp_ptr));
+	ufshcd_cache_flush(ucd_req_ptr, sizeof(*ucd_req_ptr));
+	ufshcd_cache_flush(hba->ucd_rsp_ptr, sizeof(*hba->ucd_rsp_ptr));
 }
 
 static inline void prepare_prdt_desc(struct ufshcd_sg_entry *entry,
@@ -1461,7 +1476,7 @@ static void prepare_prdt_table(struct ufs_hba *hba, struct scsi_cmd *pccb)
 
 	if (!datalen) {
 		req_desc->prd_table_length = 0;
-		ufshcd_cache_flush_and_invalidate(req_desc, sizeof(*req_desc));
+		ufshcd_cache_flush(req_desc, sizeof(*req_desc));
 		return;
 	}
 
@@ -1487,8 +1502,8 @@ static void prepare_prdt_table(struct ufs_hba *hba, struct scsi_cmd *pccb)
 	prepare_prdt_desc(&prd_table[table_length - i - 1], buf, datalen - 1);
 
 	req_desc->prd_table_length = table_length;
-	ufshcd_cache_flush_and_invalidate(prd_table, sizeof(*prd_table) * table_length);
-	ufshcd_cache_flush_and_invalidate(req_desc, sizeof(*req_desc));
+	ufshcd_cache_flush(prd_table, sizeof(*prd_table) * table_length);
+	ufshcd_cache_flush(req_desc, sizeof(*req_desc));
 }
 
 static int ufs_scsi_exec(struct udevice *scsi_dev, struct scsi_cmd *pccb)

-- 
2.34.1

