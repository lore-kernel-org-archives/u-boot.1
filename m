Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 414E7ECE564
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 09:20:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D25888F74;
	Tue, 10 Sep 2024 11:20:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Gats2Xex";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3C2F88F89; Tue, 10 Sep 2024 11:20:37 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8CB888F70
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 11:20:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-374b25263a3so3156242f8f.0
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 02:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725960030; x=1726564830; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XbxLFe5fzwN6Jt4d+R2OdF/xYcYZgzxGRtyCuZrKV3I=;
 b=Gats2XexNC3fBdUJu/TtfiG+J44YlP2+lT/CM2FMzv8Vm7ba22r/SDKJjO/9XkvhLR
 HM2V5E9TGy2DCs6Q4h6rvAceYXceVsUo0lEItDbQtFPEi8TEYrxOXkZgkosES98SEm+T
 qCY2I1I+WugwPv/IK7/5VLikv/JliJ/ReWabk5NONiNLKe6D7pP5RcwGWypVz6zVnDXm
 FPEQIizxmQ6zL1wdL6dEKvGYh0oe41ZRRfYUTI2kcwUev29lXvwQCjqPkbEIaCMRlCs+
 F9PACaU89KwQ9axzr1TadjZ5J8bbaEjj5+Rn9J23V1d9S7FaXYfvXjcootTLHFQC80ON
 3pVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725960030; x=1726564830;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XbxLFe5fzwN6Jt4d+R2OdF/xYcYZgzxGRtyCuZrKV3I=;
 b=lXix2IXHkkjVp+nZaui9f3sByCk9bkVYOspw0UedYAOLdmml+Z81u3m5ByFP6NSpUV
 wWHQ33gUAwc8uxVVpo8P7XKfAaQuQEfdUUnUZrvt1rc8WcOuOBNiSwR6SDVN6ChMOBRu
 6PtAywbmXdFC3Hp0SxAfk5IoUefoOE6xRKPwJs8w/adHYfVY6IrLyPhJS7FQxuAbhe4j
 bzOkgOSJQtu+7k00vh1tiCAbcsIB7n7YalRzwm24B1H4uhz9VXMtccV4uWpTrpPpP+Br
 L7Uspl7eduvtZQaf9Q8QBxbfG7oya+e2DucMHU/z71q+xIPZ/lmdxMXDSOd7sV2NF/Ll
 lwMg==
X-Gm-Message-State: AOJu0YxBX+sn5ZdZdvj43qP6jmgwl9V7u+dDEbHyIg8TS3ZurW/W4G/m
 RDZYKJCYB0T5ZzdUbQHUqdpDelTN2kGhh0zp8G+GPAQ6EDaJuTUWB9ej9brOaFY=
X-Google-Smtp-Source: AGHT+IH5B5+Dxqh3hkECazqj9AifFfyarsX5uZZuEdiwP3JwTkvrb90jsR75mTZiGoF7xoiOCHZiNg==
X-Received: by 2002:a5d:5e0e:0:b0:374:af04:d6a3 with SMTP id
 ffacd0b85a97d-3789913417fmr5827602f8f.57.1725960029823; 
 Tue, 10 Sep 2024 02:20:29 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42cb099acf6sm101256245e9.9.2024.09.10.02.20.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 02:20:29 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 10 Sep 2024 11:20:19 +0200
Subject: [PATCH 02/13] ufs: fix dcache flush and invalidate range calculation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-topic-ufs-enhancements-v1-2-3ee0bffacc64@linaro.org>
References: <20240910-topic-ufs-enhancements-v1-0-3ee0bffacc64@linaro.org>
In-Reply-To: <20240910-topic-ufs-enhancements-v1-0-3ee0bffacc64@linaro.org>
To: Tom Rini <trini@konsulko.com>, Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1874;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=oVsz8gmXWVEZJZf1Mg+oM6GpP73pR3b7jLP7OPiK+Sw=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm4A9WNWc17o2C698+AIILxdeWPed6pOpY1TgDkvuA
 gHbQilKJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZuAPVgAKCRB33NvayMhJ0WieEA
 CHNb2WSHPIYL9cqYeBBoFm+aJSg/lqQVjg+g/b6gO+yWVC6h76+N4DjGB2TbyYgfzwA7fXzQfGTA6/
 4BACxlFu2yPWh5gOU6htvsABQE39OioBIlM7vnNLFLvprBCPfOzb2SAMQ5a5sHY4xhOuQUqZjw+AJE
 dDxJ2BfL1iHWpwriLA1UTqWcGahY43dUTfuY5uzC7zGl9LppqpOjxohqWwHkmfa2ZpnrwC4pNIcBVT
 ptrBk/yoHm9krleb814GOmzDxp4JRRfdQzxAa2tnXI7kAGSem8JuVVTy+EzCkl7iOkYJonNaMZUR2p
 /+ebnr3Iw4rEs0qcYEC+L+oqUSGX66oYZJnfbEU8TgxbGsj0YFFK9XRaNBpZzIaXxwyM5x5a4fiKpx
 b4yh/8GizQaLfoWVYUppYrPyv0ktUE5C7hFBDGH8REOxiQR4h7ptpHhcPBIugDGpxybnVOrZgMmOE1
 0CsLJeijS5/OyO7GkHORSqKhBU1ZV4DaTgn8rvuRHttm5rouNdto7gWuJkwxlQWlUQVGs9X7B8jZWx
 tes3L7BHyJ3DhUhCKLBl+D2FhMChCiSzaCXu+ttP85PnAkClMSwZ02Iqo4NF8gwl4D2VKhiE4wLmzP
 1rgCfvzyJOz/vzIhSrzIKPPtOpqfwoI4Xb0UwNxHAJ0legM3LB2Zt1NG/4SQ==
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

