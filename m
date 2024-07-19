Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A187FC3DA5D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 11:00:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DE1488BA6;
	Fri, 19 Jul 2024 13:00:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XB1y6Ptq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA69287CF8; Fri, 19 Jul 2024 13:00:20 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BC3188B98
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 13:00:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4266f3e0df8so11202205e9.2
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 04:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721386817; x=1721991617; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rSYHlAeTf5vfAufBpN4+ASNMaeHehsmXJh8iGiG/crE=;
 b=XB1y6PtqP6yNg+bjF6PziFk1aXB6LYyNFLnCRWrr35Dinw9nDgOGLTlJh1NgZSokdk
 JyaivgsQsM3eHfgxZfBaJJ2tHiOCpW2g8RBGVArEoJA6+hKaT1hqiK6IZ4+u8SjRMghd
 /xi5PxeSdKHtPty2109R5voyc7kRINmHl/RIbZd5xvJ7+WK7KNIz8sPiyLb6FXTb+ZF+
 ML8D9gMLaY2tiJGk/36wanDBTieRelsYecyebKoGrFaLwl5GwBwD2/AShFYUMHb18mpG
 Nd0NXxnMePFJ+1RT0zI7NMf97SjRk7vkDzv9zxRCIAudc7L5aV7FOEWyz23TYufpJ/vI
 qYFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721386817; x=1721991617;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rSYHlAeTf5vfAufBpN4+ASNMaeHehsmXJh8iGiG/crE=;
 b=KZB5jp67Tt2SuS6mQbcBqHBC60/BdlQ9JnBSKJ43OadokJxP5s5uAnBJpUVRyj2dYr
 X00NOcxgMu/HwcwTSIOvPQ6FL6JV3HRvyF/BF1dFQeWtJ8TaYB8g3nV7fI24PhOnuQSJ
 qvNHK92Iy5FbJwF5QlHjn/PKEzehE1hEEVis0rrb+s5jvobEQxut3Fn7/NYnPs4XhG4R
 pNqgEGDj8djYl5SYmmNdDfZVxGmb7bP2IkEtSIQdomQrJEYw8fHg2ipjkGT5y8YK3wD3
 29vVw+vZCov7SF/idSGHnQ2yFA4hUxFRgpMktT9obygF0OIh8xyhoDzKq5nLmk2UCczC
 bsHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9lFeZm4E22qbiBk/LsGYM4jDrxkej0l+If2IQOhA9ViXJoO0zXPc/km421OlgQUfs9F3d57VOt0hI+uYRHdcup5RlyQ==
X-Gm-Message-State: AOJu0Yx0459Ris5NcYkkw/Id66QhOpJ4iopHy4+3TsYygcnkl0aYUQ4j
 v6o/kAoUVoh4/r4Kkwt/Q3++neVTedJP9MHK6eoSor4Ln/BRn6kTSNoZevGOiPY=
X-Google-Smtp-Source: AGHT+IHiQmrwm4EQr8AQLNyOO1LDQgf59ZBe0r2NzUYUXZVjZt7locZdMiubEHvU2rNgpC5R8aVL9g==
X-Received: by 2002:a05:600c:310c:b0:427:9dad:e6ac with SMTP id
 5b1f17b1804b1-427c2d0bfccmr58763785e9.34.1721386816592; 
 Fri, 19 Jul 2024 04:00:16 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d6697c3fsm20556055e9.0.2024.07.19.04.00.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jul 2024 04:00:16 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 19 Jul 2024 13:00:11 +0200
Subject: [PATCH 2/4] ufs: fix dcache flush and invalidate range calculation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240719-u-boot-ufs-dcache-fixup-v1-2-b044fc9564e9@linaro.org>
References: <20240719-u-boot-ufs-dcache-fixup-v1-0-b044fc9564e9@linaro.org>
In-Reply-To: <20240719-u-boot-ufs-dcache-fixup-v1-0-b044fc9564e9@linaro.org>
To: Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@denx.de>, Caleb Connolly <caleb.connolly@linaro.org>, 
 u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1874;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=T3zjfDg6dn9NdCFWLjfaWxgHWLxiPmqgJ07RdmwZ1jQ=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmmkc8202QuuxYoJF3juURPrQYc9nlrAJYN+V3KgJX
 Y4UhS1WJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZppHPAAKCRB33NvayMhJ0TKBEA
 CMFgvIjhMQ62QGtSBua2/xHYQE4xHSofUTGX0HhV7XPkVV9iHbnjTERRqvx4dYENp3FP2lP6Vtkx2x
 gOpSVBWLh+e0yfWLP6bP510tc/MrWPmk+XpBP/p6mWnCKnOVtldxrjRoWbWZYWI+QjYDVFdnoUD26/
 V+/16QbJbS0mNLRORpe/5zCM5oAOzo6CXYxEJBi13xJRNTStTYURs3+RrbucDn9FBdhl+2huDhVhj/
 sR2g06qj0IBWYKsMDHzSBhMFO5r5XFoEu2Q/VH1KCgV5MmxYo7xkr2375yaDfE750ox+frFe8jvYq5
 0vAH8Suw01YLRBrRCZ9/IC9Kh3yNXEwhZVKaBdSC+DgOvVxiocLOBpJ5YAFt2rkg27RpSs/TChVIWu
 72OJMV3pAkc1x9RSVCZpxwFgPw/K/Cg/GhHHf1rOasbVMWvqPlRywgUHWMztMCD0B6aru1UydeCLP8
 DZRktPeVuYQmZdE8lNYKoriurufK1X3TRBw1a6idC2SnSRhnmVs6dy3vI4yFBciMDMn4BbjwZGIoLz
 W0Df/EKXlJdNgIxradjDVwhQE2kVqQOwkq83NXlV8zwIE96Etf289dI6usyFn3njJ2QKhIPHx24i6I
 nhd0bpLvsNAPJa3FXDuBftQMMQ+RlfaQXeXGKof73sFluym69C1iPxgFCx+A==
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

The current calculation will omit doing a flush/invalidate on the last
cacheline if the base address is not aligned with DMA_MINALIGN.

This causes commands failures and write corruptions on Qualcomm
platforms.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/ufs/ufs.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
index bc86903245c..db487d1ff9a 100644
--- a/drivers/ufs/ufs.c
+++ b/drivers/ufs/ufs.c
@@ -704,11 +704,11 @@ static inline u8 ufshcd_get_upmcrs(struct ufs_hba *hba)
  */
 static void ufshcd_cache_flush_and_invalidate(void *addr, unsigned long size)
 {
-	uintptr_t aaddr = (uintptr_t)addr & ~(ARCH_DMA_MINALIGN - 1);
-	unsigned long asize = ALIGN(size, ARCH_DMA_MINALIGN);
+	uintptr_t start_addr = (uintptr_t)addr & ~(ARCH_DMA_MINALIGN - 1);
+	uintptr_t end_addr = ALIGN((uintptr_t)addr + size, ARCH_DMA_MINALIGN);
 
-	flush_dcache_range(aaddr, aaddr + asize);
-	invalidate_dcache_range(aaddr, aaddr + asize);
+	flush_dcache_range(start_addr, end_addr);
+	invalidate_dcache_range(start_addr, end_addr);
 }
 
 /**
@@ -1467,13 +1467,13 @@ static void prepare_prdt_table(struct ufs_hba *hba, struct scsi_cmd *pccb)
 	}
 
 	if (pccb->dma_dir == DMA_TO_DEVICE) {	/* Write to device */
-		flush_dcache_range(aaddr, aaddr +
-				   ALIGN(datalen, ARCH_DMA_MINALIGN));
+		flush_dcache_range(aaddr,
+				   ALIGN((uintptr_t)pccb->pdata + datalen, ARCH_DMA_MINALIGN));
 	}
 
 	/* In any case, invalidate cache to avoid stale data in it. */
-	invalidate_dcache_range(aaddr, aaddr +
-				ALIGN(datalen, ARCH_DMA_MINALIGN));
+	invalidate_dcache_range(aaddr,
+				ALIGN((uintptr_t)pccb->pdata + datalen, ARCH_DMA_MINALIGN));
 
 	table_length = DIV_ROUND_UP(pccb->datalen, MAX_PRDT_ENTRY);
 	buf = pccb->pdata;

-- 
2.34.1

