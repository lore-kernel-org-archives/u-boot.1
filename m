Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15807C3DA5D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 11:01:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE6F888B95;
	Fri, 19 Jul 2024 13:00:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Tvbj/3Kl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 055FE88B95; Fri, 19 Jul 2024 13:00:23 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13B11880D8
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 13:00:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4257d5fc9b7so12217105e9.2
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 04:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721386817; x=1721991617; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ecTGqWxYsH75D+OkZgsgN1XItusa9jXgRfqnEpVZGrA=;
 b=Tvbj/3KlMbJaeh+RJLbSDvJnQiwYKe+Sub22oQMoxwviT1ROXhs39ez9f1WsGp+wwk
 +aXZ7bwbP1UTIc0Y7J49+z8svRTEN/6lZNnBqLOG5Rs8iKBlrqDRpGQ4PhRMU7sF/Ufn
 1vM4AGATIFvI3PIimgVs+cOt9alGRw5w12xZ+tTgHlYwJ005mFK7bxr5rzCpiqunALvD
 nYzzcak55rcoyJ9XocWzpnAA9m80oIuUfttNDowcAS+9NIsISTUvg30yta90CYirnHZ5
 Et+RgWBkoCYCmMrWb8YdvTuiz8ki916Zz+3CUN961gFPPw/yIKcPfghmlCUfTdx7fcaH
 se6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721386817; x=1721991617;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ecTGqWxYsH75D+OkZgsgN1XItusa9jXgRfqnEpVZGrA=;
 b=PJq1XQXKYfHjUVor9FCp4BVx/MsG2arTzUnEilBz3kebmHfa/eEk0zscNhKh2PRVqh
 pTug4/FMbB3TdSWXJLSs2VsaChs+vRiymgcxbR/Aqargu1C1MREf5EntoHXozLIwuwzU
 LOAxGasElvFyI4qV+Rb07FQOUrF8LehkMs3mLdlI7r34HWA9LvDu8Fw2s+uhs9HOI/EC
 yaiZPi/+1r3b1mJMKt5wf8Vsumh0jeonDm6aa6xYxFPs0A/2ziiv+jle3wto5DJhtK1K
 ridw/VbL2lZBn66zfHF9Eb+aLrXgad2TLllUwKy7+U4TrR9BFheVGnzKs1CwSDD5i72B
 QmzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbHzjLMtdC205qCE3hWMbXnQ76wZNFyqC80OYwxU1F63i2ydUs+wZrHRteDqsku0TC+BuXV7KFUmE1n0j3nyfAdVLuPg==
X-Gm-Message-State: AOJu0YzyNJQDxco/OQe5yiy5hHaHsnuc6wEY4LE5VVTtVZVF34AFiWYK
 DCPdBIuEIy/4w5HlasvsaRO8Srp5OTWPYUTtxpsohl0EBgzkykHjI7CC7TS75x0wfk6EQpzh4KA
 U
X-Google-Smtp-Source: AGHT+IG37I7hLvU6EyUjQyCt7auaP5YuUOoGg7Vrb6uYNyzklgC1z57ZzeWGLKKM5gabqC9wk8QJGg==
X-Received: by 2002:a05:600c:3516:b0:426:6bf9:608d with SMTP id
 5b1f17b1804b1-427c2cb8a11mr65545675e9.12.1721386817378; 
 Fri, 19 Jul 2024 04:00:17 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d6697c3fsm20556055e9.0.2024.07.19.04.00.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jul 2024 04:00:17 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 19 Jul 2024 13:00:12 +0200
Subject: [PATCH 3/4] ufs: split flush and invalidate to only invalidate
 when required
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240719-u-boot-ufs-dcache-fixup-v1-3-b044fc9564e9@linaro.org>
References: <20240719-u-boot-ufs-dcache-fixup-v1-0-b044fc9564e9@linaro.org>
In-Reply-To: <20240719-u-boot-ufs-dcache-fixup-v1-0-b044fc9564e9@linaro.org>
To: Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@denx.de>, Caleb Connolly <caleb.connolly@linaro.org>, 
 u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5586;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=EqTxd+V2YU08X0Z1ZtVZtTPclI9ygNLiRvm6Oc0/Xd4=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmmkc95rXdlIyOcVljoTV/YGNa6MbzHtExXK/SESmY
 7fGj8jOJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZppHPQAKCRB33NvayMhJ0bHPD/
 9HPpjK338Vm5gpsfSBoGDsvApApz7E5azJSH8biL82VSR0ACb7Ocf8qQSVzeXMpCSPe2iFP70rQF1Q
 /or9z8t/qOcmlN0fSYdgQA34SqV+o3exsZ8R+fXGI4FUrXiULAa/6Jl0H0q6QOKxjxOWs81En490pj
 OUMw9w7rGoHg9Ygag0hY7E9pIpx6VtE9JExriA6uMu2L9XaNMUwvtviSCCfrTYGhmG13phQd6CZ94c
 QN55S5sRkoQBDsGO5hYPn964H8UJTIwUXv4wHkpdSli7Df/cg56wwpiIGMvQqDYjJiCNQZuI3HPrh1
 IN98rlRSkRI0iqeCCOsSvD7hKyc0nIpc3tn+ii/i4BmEZz6dgBP4tWQ6AdTf7SS5p/QdfPAV5UnG92
 xlUuFXVkRctJTBTcVkli433vmy79ZAhXqe8chSpOPEOi0BgnPffH30UcFIe6JvSRb2knVh+ofW8nyl
 Gl4naY1DfQfDM4uZCMTXdUqBAAwxwd8w9GyFsEZ1Ey8j9jUfqNeAHqbhSSrW7r1t5cMB8zUR27gPs2
 y8mcYUOseA0StHjcmxAjnP/xbZqVd7kIsbOIHyTs5qbNl2XS2+7zASFwuPtDep3ghns4eOk3WPya78
 dDp6vj/uaRULcRfWgCWKgo6erYxx70KTUW+kBoq2HAVjGJMtTuHTd7MAYD/A==
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
index db487d1ff9a..76cda83ce81 100644
--- a/drivers/ufs/ufs.c
+++ b/drivers/ufs/ufs.c
@@ -697,17 +697,28 @@ static inline u8 ufshcd_get_upmcrs(struct ufs_hba *hba)
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
 
@@ -755,7 +766,7 @@ static void ufshcd_prepare_req_desc_hdr(struct ufs_hba *hba,
 
 	req_desc->prd_table_length = 0;
 
-	ufshcd_cache_flush_and_invalidate(req_desc, sizeof(*req_desc));
+	ufshcd_cache_flush(req_desc, sizeof(*req_desc));
 }
 
 static void ufshcd_prepare_utp_query_req_upiu(struct ufs_hba *hba,
@@ -786,13 +797,13 @@ static void ufshcd_prepare_utp_query_req_upiu(struct ufs_hba *hba,
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
@@ -810,8 +821,8 @@ static inline void ufshcd_prepare_utp_nop_upiu(struct ufs_hba *hba)
 
 	memset(hba->ucd_rsp_ptr, 0, sizeof(struct utp_upiu_rsp));
 
-	ufshcd_cache_flush_and_invalidate(ucd_req_ptr, sizeof(*ucd_req_ptr));
-	ufshcd_cache_flush_and_invalidate(hba->ucd_rsp_ptr, sizeof(*hba->ucd_rsp_ptr));
+	ufshcd_cache_flush(ucd_req_ptr, sizeof(*ucd_req_ptr));
+	ufshcd_cache_flush(hba->ucd_rsp_ptr, sizeof(*hba->ucd_rsp_ptr));
 }
 
 /**
@@ -878,6 +889,8 @@ static int ufshcd_send_command(struct ufs_hba *hba, unsigned int task_tag)
  */
 static inline int ufshcd_get_req_rsp(struct utp_upiu_rsp *ucd_rsp_ptr)
 {
+	ufshcd_cache_invalidate(ucd_rsp_ptr, sizeof(*ucd_rsp_ptr));
+
 	return be32_to_cpu(ucd_rsp_ptr->header.dword_0) >> 24;
 }
 
@@ -889,6 +902,8 @@ static inline int ufshcd_get_tr_ocs(struct ufs_hba *hba)
 {
 	struct utp_transfer_req_desc *req_desc = hba->utrdl;
 
+	ufshcd_cache_invalidate(req_desc, sizeof(*req_desc));
+
 	return le32_to_cpu(req_desc->header.dword_2) & MASK_OCS;
 }
 
@@ -1438,8 +1453,8 @@ void ufshcd_prepare_utp_scsi_cmd_upiu(struct ufs_hba *hba,
 	memcpy(ucd_req_ptr->sc.cdb, pccb->cmd, cdb_len);
 
 	memset(hba->ucd_rsp_ptr, 0, sizeof(struct utp_upiu_rsp));
-	ufshcd_cache_flush_and_invalidate(ucd_req_ptr, sizeof(*ucd_req_ptr));
-	ufshcd_cache_flush_and_invalidate(hba->ucd_rsp_ptr, sizeof(*hba->ucd_rsp_ptr));
+	ufshcd_cache_flush(ucd_req_ptr, sizeof(*ucd_req_ptr));
+	ufshcd_cache_flush(hba->ucd_rsp_ptr, sizeof(*hba->ucd_rsp_ptr));
 }
 
 static inline void prepare_prdt_desc(struct ufshcd_sg_entry *entry,
@@ -1462,7 +1477,7 @@ static void prepare_prdt_table(struct ufs_hba *hba, struct scsi_cmd *pccb)
 
 	if (!datalen) {
 		req_desc->prd_table_length = 0;
-		ufshcd_cache_flush_and_invalidate(req_desc, sizeof(*req_desc));
+		ufshcd_cache_flush(req_desc, sizeof(*req_desc));
 		return;
 	}
 
@@ -1488,8 +1503,8 @@ static void prepare_prdt_table(struct ufs_hba *hba, struct scsi_cmd *pccb)
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

