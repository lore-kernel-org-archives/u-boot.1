Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D48C3DA59
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 11:00:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81B6C88BDC;
	Fri, 19 Jul 2024 13:00:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UB6AOYU1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B49E088B8C; Fri, 19 Jul 2024 13:00:21 +0200 (CEST)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FFD088BC4
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 13:00:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2ebed33cb65so21137731fa.2
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 04:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721386819; x=1721991619; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ctDLNf3aVizt+o7VXs0TqNdmaDkbXYKY9V67ND0pTmI=;
 b=UB6AOYU1gvr2dZ+QRcDMF6L9iLhuxFf9w1g8UTdxn1KlyrOyccRssDzZGb/CZRVz7j
 dcfV5AWGJx0Iz38WCgBgOtAmrIphJpjKmjfCPFhCwnk6PUBvi2+iDnGOS0TcHPK53WO7
 tdr1t1ni80qzz3KYTJAFWvOc9gXTSAyQyC87i677BI1W9Kon2aj8u+H/yfHJpUlrWwzL
 0rz6v0AoSi4O4bxzZb1MEs+J/TkiWUHVYRPTb4sCPYyuWkcIn8VQgFKKwzX0UCcZA5F/
 /f0oPs4hNLj+UHpMHMBa44ERuOVROvKf3zSN4Sk3O56RBq3JKuzvbJqmt4IU869CuyP8
 o4dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721386819; x=1721991619;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ctDLNf3aVizt+o7VXs0TqNdmaDkbXYKY9V67ND0pTmI=;
 b=wELMQdAg06IrgXup03N6VMNKAcYHVHC86gl/imBzxa6C8DpwTC5b0ejtH9pGMDAAHL
 TJKwgA4qujLCB3b7y1Ska0AltI2KICPsKjb3Kss/vfL+kH9JthikbETXLADO2Wgn3KvZ
 kfORSvQYzpW8+1bO/phFZXAh+tml5d6SB9a11F8Ot/DOJ3WOAOMrmK7/nSWLWccaZjkD
 FP31HnHCLSKk+fo5kJfDjbq6dWpEnLGbYMffW/D1p2J2Tl+mufVyz51z78NLxntf+YCh
 YeA8MqFcCGQI3eDKTleTpd/5Hc+w83Jen48cbkioz+P2B9GVxDO7M0al15DeOviLQRy8
 3WSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8zQ8xGrRintrVlu0d65GFXJtmL2JtwpiTiizZ3IPtAZ2rKEwcfTCr9PyyK40P4g4Kqjzi/vtIrrObzHn04APapa8yAg==
X-Gm-Message-State: AOJu0YwVYZAYc0vXMp3QBlZhBE3PDHEVRNzJY2xM+7IpjnjDg5T98TWo
 JoRBpYtuFmwZ/6BZdEXaXtaEFDvX4Yy6QW8Vo5A79GSH3wDGwLzzvL66Yo0xwTM=
X-Google-Smtp-Source: AGHT+IF4HDyixmLb/OrVAHjWmPfy8xnrxbviU2EVwunXaQ8/8n9CaJ7qL7CbAf3HRd+z3LRO9rx5tw==
X-Received: by 2002:a2e:9b84:0:b0:2ec:1042:fb02 with SMTP id
 38308e7fff4ca-2ef05c5749fmr33733761fa.8.1721386818173; 
 Fri, 19 Jul 2024 04:00:18 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d6697c3fsm20556055e9.0.2024.07.19.04.00.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jul 2024 04:00:17 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 19 Jul 2024 13:00:13 +0200
Subject: [PATCH 4/4] ufs: use dcache helpers for scsi_cmd data and only
 invalidate if necessary
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240719-u-boot-ufs-dcache-fixup-v1-4-b044fc9564e9@linaro.org>
References: <20240719-u-boot-ufs-dcache-fixup-v1-0-b044fc9564e9@linaro.org>
In-Reply-To: <20240719-u-boot-ufs-dcache-fixup-v1-0-b044fc9564e9@linaro.org>
To: Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@denx.de>, Caleb Connolly <caleb.connolly@linaro.org>, 
 u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1584;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=pCbHBk8j8/wYJtJSw8HJQGO5K/JRQl2HiE7FdN5Aphw=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmmkc9s4pez6MLIBq2CJNKeZAZqBODph7yx5lkGs6d
 8kgRNaqJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZppHPQAKCRB33NvayMhJ0S01EA
 ClorARNi/yk8t3Ttje12KVNIlHrvGwuUQBgsjOGFJIHNLs30jF/XB1sTNtCfAB60DeLdcxjLnpabLz
 tXnk5BQbX3BrRZ3e8b2ADEdjIgkcZElp54BAeb7MvNEwbFSgLgEAIVsylT8MBoi2h1dJIYZj8Ztecf
 TkrCuC5nYNmAaGLb/A5uE3VEJBx+zcLUDg6VGibghT/AuSkISq8mJRcSSfMXLcNKAvzB12zgpfC5Vj
 8PhRe3MrhhdXGkahmlDRMlTbWGY049auWrJjpXtf5AqpQuf6vo5Hx7jRnDIzRqQX8/N1Q03C7PX1QX
 FC0uNEJuLNeW0N6eaUFZpzz3lZCXw3zfIDJytrAQJdZJoBXGQ44hBztrmr4j3lNHa9dgeyVjax6CIm
 bjy5kGFR0wmOWkEte23pL77pV3P26L8GOnduLqbvEmMnFBujgsGqVg4fRlsXlJRGtDI9TuHkc3fiRL
 W7buKmfW184nf/xwWc8Orlek894hKFA0nbQTyOmq33PMlOB3Ct8QQyLt+xM1k1eTlKb7uhdolMYT+g
 fzKbtgzPMVcGPwbKdxq7XYCPzsq/FeNxrGFJwKprTGECUWOR3xwkq1UUWPTpgIbC18z4jGGAYu/9fP
 3O+zJvaoaMU2PYToaPfvCSGcyKVThG1OF9FXw9CgPhdjumwCrwONwP7e8DhQ==
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

Now we have proper flush and invalidate helpers, we can use them
directly to operate on the scsi_cmd data.

Likewise, we do not need to flush then invalidate, just flush _or_
invalidate depending on the data direction.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/ufs/ufs.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
index 76cda83ce81..646d4856e9c 100644
--- a/drivers/ufs/ufs.c
+++ b/drivers/ufs/ufs.c
@@ -1469,7 +1469,6 @@ static void prepare_prdt_table(struct ufs_hba *hba, struct scsi_cmd *pccb)
 {
 	struct utp_transfer_req_desc *req_desc = hba->utrdl;
 	struct ufshcd_sg_entry *prd_table = hba->ucd_prdt_ptr;
-	uintptr_t aaddr = (uintptr_t)(pccb->pdata) & ~(ARCH_DMA_MINALIGN - 1);
 	ulong datalen = pccb->datalen;
 	int table_length;
 	u8 *buf;
@@ -1481,14 +1480,10 @@ static void prepare_prdt_table(struct ufs_hba *hba, struct scsi_cmd *pccb)
 		return;
 	}
 
-	if (pccb->dma_dir == DMA_TO_DEVICE) {	/* Write to device */
-		flush_dcache_range(aaddr,
-				   ALIGN((uintptr_t)pccb->pdata + datalen, ARCH_DMA_MINALIGN));
-	}
-
-	/* In any case, invalidate cache to avoid stale data in it. */
-	invalidate_dcache_range(aaddr,
-				ALIGN((uintptr_t)pccb->pdata + datalen, ARCH_DMA_MINALIGN));
+	if (pccb->dma_dir == DMA_TO_DEVICE)
+		ufshcd_cache_flush(pccb->pdata, datalen);
+	else
+		ufshcd_cache_invalidate(pccb->pdata, datalen);
 
 	table_length = DIV_ROUND_UP(pccb->datalen, MAX_PRDT_ENTRY);
 	buf = pccb->pdata;

-- 
2.34.1

