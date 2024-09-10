Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B253ECE564
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 09:21:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB43A88F90;
	Tue, 10 Sep 2024 11:20:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="z1aFuhwi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8738B88F8C; Tue, 10 Sep 2024 11:20:39 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D47DF88F75
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 11:20:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-42cafda818aso27663305e9.2
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 02:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725960031; x=1726564831; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oqKlusR5GPCCrTUypghPMVt4yqn9KaI81pA8qZgjw04=;
 b=z1aFuhwiiaX4GJxZdcaXmA6X78ZsjAfBcMkDtReeSIHjULpf3YJWsXBHaGOODdMeE/
 FMXE1gtjqdkLHYp0rOD3Ue6o9rIOLieRJhk2UIR4WOC66OS6pzvd21qXXvJ74ldFjMK6
 E7RTooowCKHR767WtWTA77CA5hyGuxP8HGz7q8y4XaDs/K74VlFYTuv+0xKq45imJ3c6
 NPpSw2gXl3+Mmyqf6125YAEcaCydaOJWnBK9XAjLM45Gth3DEBE5ANjCzSCXWOVN68N9
 LtcGZe8RQgbIpu+eP5R0xJ9ID+m3nZFqaEE6xVxtJI0yaEPKwTvPLj4Q0/EjPtS1pfME
 7PQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725960031; x=1726564831;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oqKlusR5GPCCrTUypghPMVt4yqn9KaI81pA8qZgjw04=;
 b=r/SbP4ERSLt/HPhXaMzK77bQ7tH86g0zkUD4XPX3a3j5L+cIIKQWiom7FiHc7UiG+2
 lDuQtxKWNz+oEqTSnPI9b586p8BTz3UT2lL3f7RM9XodrKlE+umMzev+3/xnGPnmP2Yv
 7nF+l3uU9YNrI9r9Bvye68BBdIl2JbBowc0vPPsxcx+xyJ+9kDg/HA4r8K8injDSEHYI
 QJ9OMFrBFbMBYbYu5uIxidScgB0pW+9Ad4gKrw9GniQGX0LKi19R/MyyzNEVdQ2AOhRm
 +fGVLAL4RqDnC4X+edb7Ni4moaFj407NkB8tgaUEpLbUjs3XELhiSyb86slZO5DaoxXP
 Bkqw==
X-Gm-Message-State: AOJu0Yz2H8C+W2e3kO19nx2Rk9l5ku2SgqljEm0UUTUs17P84KrUTMbh
 bR/6Fm8K/kD8cgN0fAlawajUbzBbMr4c5sQef1myzLRM5+bhwtnca4ytREcxW0g=
X-Google-Smtp-Source: AGHT+IGkP3brE6LmgzXUzVqPn90sIp5cTBMC1thJWAAyCgz1npY9kMN1OvBbiwiGF0dKkkvoaAseLg==
X-Received: by 2002:a7b:c345:0:b0:42c:b6e4:e3aa with SMTP id
 5b1f17b1804b1-42cb6e4e445mr51403875e9.5.1725960031359; 
 Tue, 10 Sep 2024 02:20:31 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42cb099acf6sm101256245e9.9.2024.09.10.02.20.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 02:20:31 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 10 Sep 2024 11:20:21 +0200
Subject: [PATCH 04/13] ufs: use dcache helpers for scsi_cmd data and only
 invalidate if necessary
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-topic-ufs-enhancements-v1-4-3ee0bffacc64@linaro.org>
References: <20240910-topic-ufs-enhancements-v1-0-3ee0bffacc64@linaro.org>
In-Reply-To: <20240910-topic-ufs-enhancements-v1-0-3ee0bffacc64@linaro.org>
To: Tom Rini <trini@konsulko.com>, Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1884;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=lxI4HS7I1NPzQe4WEGjAEWu+wJ/tDWmbIzQmUpETYAY=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm4A9XKZOOFnS0AMMQKlbGWz/p83lvY6NFAV9oBlUm
 sbFm7juJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZuAPVwAKCRB33NvayMhJ0R9VEA
 CMpaNJQFU69INFouPBXUVEgJr3sjbVCzjeo3yZelU+m6KHNDt5qOcscvyRvOj8fNpRfDfPSkCcGtT6
 FUa9PR36vf83JX1jAvW/IQvdEzuaiK0lPelOJr0gqw79cNslPTI67LFAHIvFS80GDHBE0H79p3la9g
 IJmX1+tQK7uvHtUDa5QCHi3VuRZXqC14yOkSqo6MlRRDTfLRhmAWh24ikWGIilwz2+5fa8S2HYrD4J
 9hw4vqhGCLRYIgts6lv2PL29RhYBv8rRdTIXAbnFpz6QApY8q6o+/aihQk0531zu8lBs+uR/OqGYR+
 1C46MWCOMB8hRv90bHvNVHxTZbWMjcV2OJVh7crOeCjw5ulxWVwJNkh4DE8WOcYFnBKufJihbPsADT
 9MliClw3+rXW0G0uaklFtGyDqc4fFNCTrMCWy3Mtg4ikAZ08sSlKe/GM2hx6SRQF1oUI5QwhXYyyLm
 MAm4OYLJZPjfNUsb/oP+88Kuhjg9rnPauJlq/k6Bvg0qyCCdpqMWsmHt5HVI/SLDrIl7dxlu2OvsUY
 +ls15c7qSkcH3mq7zOxVE6bo2CTFWxYQi29oOz4rPhEJnIzJqU48DoE1ZJi7bMKCbbI9dGuOQsCWGq
 4Fe4vqw4Di2TmmSa5GyZ+iOAqJWpQuNT3mvHm3EJnVbcDtou/fwffB2s8ssA==
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
 drivers/ufs/ufs.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
index 5845fd694d3..d99dcdef7d0 100644
--- a/drivers/ufs/ufs.c
+++ b/drivers/ufs/ufs.c
@@ -1468,7 +1468,6 @@ static void prepare_prdt_table(struct ufs_hba *hba, struct scsi_cmd *pccb)
 {
 	struct utp_transfer_req_desc *req_desc = hba->utrdl;
 	struct ufshcd_sg_entry *prd_table = hba->ucd_prdt_ptr;
-	uintptr_t aaddr = (uintptr_t)(pccb->pdata) & ~(ARCH_DMA_MINALIGN - 1);
 	ulong datalen = pccb->datalen;
 	int table_length;
 	u8 *buf;
@@ -1480,15 +1479,6 @@ static void prepare_prdt_table(struct ufs_hba *hba, struct scsi_cmd *pccb)
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
-
 	table_length = DIV_ROUND_UP(pccb->datalen, MAX_PRDT_ENTRY);
 	buf = pccb->pdata;
 	i = table_length;
@@ -1517,8 +1507,12 @@ static int ufs_scsi_exec(struct udevice *scsi_dev, struct scsi_cmd *pccb)
 	ufshcd_prepare_utp_scsi_cmd_upiu(hba, pccb, upiu_flags);
 	prepare_prdt_table(hba, pccb);
 
+	ufshcd_cache_flush(pccb->pdata, pccb->datalen);
+
 	ufshcd_send_command(hba, TASK_TAG);
 
+	ufshcd_cache_invalidate(pccb->pdata, pccb->datalen);
+
 	ocs = ufshcd_get_tr_ocs(hba);
 	switch (ocs) {
 	case OCS_SUCCESS:

-- 
2.34.1

