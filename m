Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA5CFCF6499
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 12:44:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB70088E6B;
	Mon, 30 Sep 2024 14:44:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RoMmGlAW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A729388E68; Mon, 30 Sep 2024 14:44:36 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD1A788E39
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 14:44:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42cb57f8b41so53739385e9.0
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 05:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727700273; x=1728305073; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VIDqema31vmCtP5+5Elm3la8qvd99hg1gL/4Bcd9PXU=;
 b=RoMmGlAWUA6lwHEXWc5cX/TORJ+8Lc7nmiOtWx2Wz7s5sJQHIFFVcx9ST0+7HI9odK
 Q7GEXepQcXZy/Bf0gmrMQUydeqo35NDHnwZtrpgytqxEH4PUymwD1HeW6QY8PtPV0Uqq
 wO/BEE6AdqL0bDQu5WI9miTZxxjr3D3kghp+Ot02jXH25/i31Vtkw+JwbJXV0U+laZyj
 pwuiTPkRPHWi0LZrZP4PTHDMTR+dbsQPG6q2gDcXQnaPh1VkpLide4rM1F55V5lFXF/8
 4+DmaNsURmNMGmlG6hWQH6BwWPOOWnj8EulMb+rqMmrtCul+mLIAX9arAQrPALANlXxe
 MoNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727700273; x=1728305073;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VIDqema31vmCtP5+5Elm3la8qvd99hg1gL/4Bcd9PXU=;
 b=pGmhjokzFIUe2v/I0vEdRHP0JRI0r61yOaDYPIj4p6KgOwevwXwlfmNYycVY/79Gh4
 ORrmQEIjOKQZCggNxLnyZjxZDcd4Ja2NrEcmHXM0YTdeY971eR1ApmFg8V7jJRyH0gd6
 u7Zcsb7M7nOyE2+oAnVXQSX3e/ks5zf3qshS1eeTJILFt0QAj2fBCJLR1ix0fV1kXGm0
 v9b1KKr1i37cy/T9iWYDBt3l8sQb3w8UkZEsV1pGaJl5pHsgpTfZwJmqx/q0WUWu34R9
 A5kyNwzY7Jy2DQmestZhdYFSX3X8z7wo3arm6OUan42B9F2J8tAF3tYA0SICZYSjH8h+
 Eyxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiLPTkIlt0svRAPBnhf+OM3rHBHYOEvMlWHsEDJlRvhFAWz5TUZyltltuV/49ddBziF8tEdi0=@lists.denx.de
X-Gm-Message-State: AOJu0YzoK5Wp8xeJ545MadWz6ZJ7YJJn2rvLrZJycBKvOnwwG1MbHszH
 8X3bHcJ/AnjBdRxYsyTCYR/TlSl7j8oYCnaRr/GGCqssXD3U1UfCqVEojTTNvbw=
X-Google-Smtp-Source: AGHT+IHLYzfrN7DZ0CTo0XTiAgc0ddXQEXdnNyIsRSvA+kyWRC/Ox7mT3txdrkyiEMvzsnzFmVMvZQ==
X-Received: by 2002:a05:600c:1d1e:b0:42b:ac3d:3abc with SMTP id
 5b1f17b1804b1-42f584976b0mr121475245e9.24.1727700273047; 
 Mon, 30 Sep 2024 05:44:33 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e96a36597sm149362745e9.31.2024.09.30.05.44.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2024 05:44:32 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 30 Sep 2024 14:44:24 +0200
Subject: [PATCH v3 02/13] ufs: fix dcache flush and invalidate range
 calculation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240930-topic-ufs-enhancements-v3-2-58234f84ab89@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1993;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=1UTsvGfPS+P9xfQFHCxXJNZU4eiTF4UOb0MRc89nBcg=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm+p0ofaIm8Xuxt0VG2M0ExY1lkNbsRTrfsjpORxaF
 Bk5iXpaJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZvqdKAAKCRB33NvayMhJ0f2cD/
 9oVv7RgRkGhvn8c/v1GcgOn/fZd+qi5c8r7bpF2EPdy5CGpD/zO4VdSHZcwEXRixN4AyDpKtSdQvbY
 xBEcu+rTw3FYFFG1ANvXGLqDnz+MdVNuVtPXZ2+u0vqSVn5h1FekCQTUNfj03w2MW99XJ1bn/cjM8a
 HX2gkNYDL09au4zlL1ejyvOq+tTNqM2VkxCUuko0zPBQ5v/UVGWEzLgrHskYT+wT6fsWhGMfU4WXDo
 dBpsafvwMJ/aeRWqmFUZOr7wg48Zhe55lveRpMJ4/tgtEbwyb/3KNu9ZoUM7uQgBb5M4zf8K/s7Sy7
 1eNWsRvjEnxv9Q8pazmX2RBQjXaqQeibVGww3f5KLY0giRzxSQIpCDLluzl98lMJsuoPXFNP+K9P+e
 0ahaeq3Gtbh5RMKGVLnNYE0PMyerfRjGZUeMKvz7IKlLIqM7vnvqaCe97yvkusyQeMM/AOODvGi7+Q
 BkAykO1J3B6U6yDTufIN7qwa8xx/5tbLZmFzzOTTH41HP9VOfR73r9Lor2kgOujoYUzDnRC1jROHSz
 yfJLbxu5BJaI9AYBwzEj/N8L2Wj64uiytkX5j9fpHq3KQ8XwPRY5eIAaOPNo1mWU0LgOeyDhIM4/IV
 75wUGBEIXz624axCAVVEuoptRd9QyI5hKeZxbE1ghrpcgKrFmq3ioAqI1zkQ==
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

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
Tested-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/ufs/ufs.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
index e005cc90608..3d9a7d7ee12 100644
--- a/drivers/ufs/ufs.c
+++ b/drivers/ufs/ufs.c
@@ -703,11 +703,11 @@ static inline u8 ufshcd_get_upmcrs(struct ufs_hba *hba)
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
@@ -1466,13 +1466,13 @@ static void prepare_prdt_table(struct ufs_hba *hba, struct scsi_cmd *pccb)
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

