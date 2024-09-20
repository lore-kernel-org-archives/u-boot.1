Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F705CF58E8
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 08:01:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 516F08940C;
	Fri, 20 Sep 2024 10:00:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zEJgR7v2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0146893D7; Fri, 20 Sep 2024 10:00:39 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C573B893D7
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 10:00:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-378c16a4d3eso1792431f8f.1
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 01:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726819234; x=1727424034; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VIDqema31vmCtP5+5Elm3la8qvd99hg1gL/4Bcd9PXU=;
 b=zEJgR7v2msSSDKn8FBPMqZtHFqUpDCteH9F0jmNNwOqIYuu5aFAT3lRqg9qf4PgLSU
 Q6klSyjWIHEfaAFMr/Rp8R8ueExvBFhTr3zn/FBWDnOtxE2eEmhjF8Gr8Y0CIjIJ4+BL
 lUCwfLsN8vlKRAtpQzu/SAXtO3Z5yPH7D0r/g8w557zVgyp7Zqjt0H2JG3s6JClxcX+G
 S4KCPD6/eY2sCNHXjotLbBFv0stNLRMBS/edwHBz62egbkWEuLH4Ax/KxrYlgCzQxuOJ
 77rYXBO2MGmtwzZFDQlPjhwZpqCOP5MC2QiNQFPylRLKATWEWuMB9uTAC5Tec0+xjccd
 KH9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726819234; x=1727424034;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VIDqema31vmCtP5+5Elm3la8qvd99hg1gL/4Bcd9PXU=;
 b=YFsIxZNdFo+JCQjp9LMMYOCgfr5cBwpi5HuKR4NrIAh+z3zWaCPeE83pOMPkoMwsA6
 nei/AnjOua9tGN1wv/d+IphyuSY+hwyqc/AywT20SjGXB08e2kk3Ty5Q85K3iAim4EjD
 dib2zIaS2+9KdpU3HOy38SPiQC5q5cVYSbLNB5lkUeUHY5fF0qhhs2ifYbeQHmSQeUuF
 Bc135tWNad22/ZGr1I84ZjS7hAWJp5fWTNeZaphKkklfT6ZVGzDo3QWgSNdjBv4YZKcp
 gJvdL+oEWjn5NbHPHK/CteYSSUQ2G8FgMUJUCbZUb/RuMopxs5zcNipY3Ltz38r5T8aO
 c81g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1ALbHTxMson6Sh1X0K6rsCY4M0GUKOUvdjxk9MJcoGRZpCh3Dnvq9DbWY9NkdNio6y5UuVWM=@lists.denx.de
X-Gm-Message-State: AOJu0YxjDznjpKklqqMzks72MEnosyyAs31ZhvaIPLx0WC9gd2OMCfnK
 aGQiHJ5wiOtga2pt77jlRZHO9B+OSG7x20qO/n7DbKtn4gT1JwpPDXYPj8yPOo4=
X-Google-Smtp-Source: AGHT+IErGRNHUxezUh+NGQj7VQ/zS2QVPQZ6sLIxJET+Q478Asu1BJTaiEc+bvAf8fxoiC1sTtyWKg==
X-Received: by 2002:adf:e74c:0:b0:374:bde8:66af with SMTP id
 ffacd0b85a97d-37a4238cb41mr1358621f8f.57.1726819234225; 
 Fri, 20 Sep 2024 01:00:34 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e7800313sm17059497f8f.88.2024.09.20.01.00.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 01:00:33 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 20 Sep 2024 10:00:23 +0200
Subject: [PATCH v2 02/13] ufs: fix dcache flush and invalidate range
 calculation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240920-topic-ufs-enhancements-v2-2-65ae61e73eaa@linaro.org>
References: <20240920-topic-ufs-enhancements-v2-0-65ae61e73eaa@linaro.org>
In-Reply-To: <20240920-topic-ufs-enhancements-v2-0-65ae61e73eaa@linaro.org>
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
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm7SuZ8KwTuWc1kckVDvrJL/eSOHEntELey+qcDzCn
 S0BxEs2JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZu0rmQAKCRB33NvayMhJ0XqtD/
 9nm9DbSyPKzQ+rDVj7tAAvVylHnh1V4ihk11yhTbE68w+zbgk8b4ikIDxlR67KqicZFnsBKCSwRdLG
 wAzBfNKxjc01G0M0ZUHCJhxwgPuIJiiYr7fKfkt7hcJKi1Q7QCOeMqIgohiSfS8d383jufoSmYpFVW
 YGaD7/vDM6U/76QKsDvJgKyOkHJjM08jjlVRp0j76m3jAIVEMfAtb+Gw6rJ7EiSxIJ+BU4cyCEJSZP
 tnJqHiEOrbvMDvJMHhECLo7L9DcVPkpzIuk5jxFYzBj+r4u+xxIam0b4/wgkul3hJW8g87XAi9tbNK
 z59bhzpQNItfLSV6mS/A3ldb2KlXRvMY9euIGBUK2xJ07Q8S48PEh1Oo95xTbsgur5VrQk3ldSkLK3
 Kq8ENINxOJ/R2Yq4Pc9D7CWKzQNUi6+A1A39p7FJpUQ5cuG7KFr5fwD3goa6PYk9l+d5KFgk6+kKbj
 G/K3kxdZsdMhKfXsWp4B1AIx38+1RXoygkqaj2Ruax4YKFffygt96iQAKoHVAUaUbac/LAKLd1nP7A
 RHYp2+SYpRMDl+m+KVxtK1nQB/Ip8xlzBLWp8DtHZU+cBDZ0pzPLCu/WBBBUgjcPxXTVAjAvjElAO7
 oHQUR16CIJS5wExK7nT0FnopHFa86PkFI2BfVb5I0vo44cjvgHR1VOkJOGGw==
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

