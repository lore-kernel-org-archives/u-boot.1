Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52E38ECE564
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 09:20:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9125088F83;
	Tue, 10 Sep 2024 11:20:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ittsiPOG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C27D388F70; Tue, 10 Sep 2024 11:20:37 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C139388F71
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 11:20:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-42cb5b3c57eso20719605e9.2
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 02:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725960031; x=1726564831; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LEhQDQDoxZL1RsT+VpAi2rzEIb8vUqNrn2fMKbW+JY8=;
 b=ittsiPOGuNluDrZwNxp3uhmZKGImC9kRDYKl/ogBTpmG9YFVQCA6XTOZrlx4gU6cns
 dBEi6Y+C24beSWLK61HIz6ftkQ/BVTCks/WKAf9Bjrid/wnz4rAOCADgxBG3g7QOx39o
 RFawZOpVFxIiBRyR5eu5POef2wawURhbIr12g7IcUH39zAe6pXu/7yAbwIKcODm0S5Kj
 sxub5BQpD6GXIGFHxDbx6BMH7QOvQa0uKkxZ625cBA5ZAsXl8Vn7gCyT0TnpVTGLdeye
 7e7xQbsmkznxHwQY4CP/wnCaoItqjykbDYfbZlZ9bsBNNrPVpUmqVCHZSViCpbaKLadh
 AdTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725960031; x=1726564831;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LEhQDQDoxZL1RsT+VpAi2rzEIb8vUqNrn2fMKbW+JY8=;
 b=upq2U4Hh6ps0rZTHxL49ElcB34fELQV04bPBRhWfjn2urUuB/QIfHINzGfHP0FUW3b
 wATvLSgPlmZMrp4KJBfSHqVMYMQ2sXqQfzXrTj75e2BH0IAHDx1lMsUkj6ZjTkCcYY2m
 Wds+GPYC+Z33PMMW+RahsistO7HKMgo8eV6EcWAWnalumKMRtidsUhMZpzE63CzddQt9
 zWsIX1zI/duEbwL5P8fZrg+8DAG13r3jCKnNVLvUrngmXnz2e7YyaS/mxJTAA2ho5TkJ
 zq68Djqd12IKyirHVCbwJDqLdpcESZ+Jo15mfU0CMVez4tnCKeOzNLETVKWSE5Z7KNu0
 FUMQ==
X-Gm-Message-State: AOJu0YwIKrCytVys/pMPfIkKQChNCDjYHmCG5WZP7zt+NeAe5Ok2WApa
 TIkWytWl1EBzw6yghFR+XYXNZt9rpvGsTijg5zqs/RrtPGpcY3m1esHVI/QKdRc=
X-Google-Smtp-Source: AGHT+IEps2jcKfK6N1pDArNL/Sdw2ORa5sj49cv468mgC4cjJ73Ks/vE0PHuX0PkjLSveFpmmasTHg==
X-Received: by 2002:a05:600c:1987:b0:42c:bc60:5332 with SMTP id
 5b1f17b1804b1-42cbc60562emr24027485e9.19.1725960030627; 
 Tue, 10 Sep 2024 02:20:30 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42cb099acf6sm101256245e9.9.2024.09.10.02.20.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 02:20:30 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 10 Sep 2024 11:20:20 +0200
Subject: [PATCH 03/13] ufs: split flush and invalidate to only invalidate
 when required
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-topic-ufs-enhancements-v1-3-3ee0bffacc64@linaro.org>
References: <20240910-topic-ufs-enhancements-v1-0-3ee0bffacc64@linaro.org>
In-Reply-To: <20240910-topic-ufs-enhancements-v1-0-3ee0bffacc64@linaro.org>
To: Tom Rini <trini@konsulko.com>, Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=5586;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=BYnT23fIi9xx0noxSPJMps/PiHvLoWV0OfglFfZoTSk=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm4A9WKvnneZzhpV5aQJKs/4Ve4vyxl/Oxtqc2ILkE
 l998h5CJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZuAPVgAKCRB33NvayMhJ0dXzD/
 4zVVC8yC68xaZyKNcHR6CQR/h/fRMZgmqQNO5LAlKiytOsMGnvR4UFKiOZQmdDJE62xezJ/1PqWmp7
 VflBUubro5XHsHEQhvhJ/jE7luAqQAIdDL3/ix3kMrsGQvoa2ms56QXAflCnHNU0vhT8TrSfKrGRGV
 8Mv/Cz24OWFlayhXCt1BgLN9oqCqzHE/cWhi6zZaopdDb429jKpgOoxMWQMVdbP1VE7UTQpU0rGHGT
 SZttk4MKydlNRvdGc/2rC3ub36YduUXPwzx8Y9WmVCPEjDkaIkhG2IJYuOPRRAJ/8qGEIKuVd1Tf2K
 hkJya2783kZvoDmRqaCAqQ2GeieaPXx72gD3t/zzYTqPZhZboZGuCQlgfhhvHfG0dnFUdgx4uIKFNF
 t67ttUY2w2FUw+vYytqbRrUJVHMoiGDW8WRruuSPgcz/qK4SZBsQQABAi5ESmwBxX1X18XuQqugXYp
 hNzwManWmHM64DEP0So9jWd1BLRb2of3pq4P8RLM5zOs4ZiAU6cykRRrQrMEHKGpT/S5V70YqKxMXu
 HxD6gYK1Ue2sDXyj02Cgu7vnFHr+BFn3SS567i3ZfSv2Klu46nXUXIvN6drS0zSKf38fpEJnu0U10Q
 aMvT3ZTeRy83NQsmiL33azdhoQVStVQFk9ExDqiNlwpq/tf2srmd+LGu/yFw==
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

