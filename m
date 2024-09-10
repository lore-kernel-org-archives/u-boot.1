Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64E77ECE58B
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 09:20:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C907A88F72;
	Tue, 10 Sep 2024 11:20:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PGuTLLFy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10F4488F72; Tue, 10 Sep 2024 11:20:35 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0585788F70
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 11:20:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-53660856a21so2922132e87.2
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 02:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725960030; x=1726564830; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=biSm18yZGgi2o3fcqtSUq93PVwUF/FUAc7uacCwORCk=;
 b=PGuTLLFyxlMyGFHG1z9ImcRDExl/i6HUO671RFe1SBxeS7aIlGEu1WGP+WKjI8KiEM
 vSSaLJVzKIxVROuOllAZ5OqylVOuv1roX6ga6jXy9mLWJB3d9nAXaWrKGcxyJuLBMOLL
 qQWH8oIyUg8Nbo4zmIYiAoSbcE6pkE99dZnasFJ8ojvaWoIr8E+0J6DzrWLtBJ90LHWQ
 93EhG7MiJ9B76NhWh6Xbc4s4wMhwd8BacKyNJDo0b4+IkJW9qVqB2Qm7WlOxq9hCPrjh
 P9/ELLtz2wzL6zAv3DPyNR+YO5Am3fkHf8OOrIwB+7QKmBvfIIVXUICcp/2kOmhIVhmH
 DCXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725960030; x=1726564830;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=biSm18yZGgi2o3fcqtSUq93PVwUF/FUAc7uacCwORCk=;
 b=b2c5wbeRoH0BcjoWHJVqnfZj6LYwwTgftSXn704XPMRQcUEZfCMIbDNPnrX8MhDgd2
 0iDxVS5veEC/zBKtj5Y2po9CwZX//QqsIfLDcrfoWq+ngiX+lqu/cWdySuqPy4DT+JCS
 ajfhtqWXyZb2nuWr4MLtmeY67EDW9x48u5iUmeisxc3TulJdY9quCqum12p9N1p/5TyZ
 Z4XV+EIuZakzK67mo386O6eiqM3sYWyFMUJHWYCNRFM7j0GLhDkVF8yFO9lSbi8sQy30
 uxdXQKRwAx3xaGiqtKv1LHxIV+ipnlt0YciPMDMgWK0udjGWOxGtgBYyEYtIcFF8TfRR
 YreQ==
X-Gm-Message-State: AOJu0YwSQuicBDBYourxHsvnDYaFx+CvhfZhThekc+xmd8Zd4Rq0ZQWx
 AqjeIw86yVlAQP5r4WqoNv5KolauaMwOKfkj2mzOQSRRFX1BixazIQZKMf4BSDE=
X-Google-Smtp-Source: AGHT+IHt8nZo3fW+FagtW2kQt24+TTlzXWp3fuoA2TS4CEZ/ZMy2XiBJ7JR26o/vdZSvl7e5I7NYTw==
X-Received: by 2002:a05:6512:31c5:b0:52c:e07d:229c with SMTP id
 2adb3069b0e04-536587b06e0mr10422885e87.22.1725960029075; 
 Tue, 10 Sep 2024 02:20:29 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42cb099acf6sm101256245e9.9.2024.09.10.02.20.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 02:20:28 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 10 Sep 2024 11:20:18 +0200
Subject: [PATCH 01/13] ufs: allocate descriptors with size aligned with
 DMA_MINALIGN
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-topic-ufs-enhancements-v1-1-3ee0bffacc64@linaro.org>
References: <20240910-topic-ufs-enhancements-v1-0-3ee0bffacc64@linaro.org>
In-Reply-To: <20240910-topic-ufs-enhancements-v1-0-3ee0bffacc64@linaro.org>
To: Tom Rini <trini@konsulko.com>, Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1349;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=ZHS2jy/EiG6hVskbTeagCeI2IfA8YWfz33iJ6L6mEhs=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm4A9W+13nYUZOgKbKnDZBdG3CNOrFO2d/WPHOz900
 UrTEM5KJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZuAPVgAKCRB33NvayMhJ0cleEA
 CuGrlxaP+IMpUuTe3DFqooewrSRYv0JzdvigwWr1h0mmdZI9K2kZns2vCxa/ig8ZCvb+kpF9h7CpdR
 6dlwWKi5uWK27KvAGWof7VU96gEDHOKlv/AD4wEYG9kOwsSn/rT8H+QnB3ODqT1suHUlqzykK0NPQr
 eHbI56TAB1ms8vguBraQWhDD2J8X6dYb2DIuPapWCSzC5555qtsjBItHgeM1FwbivpcGEFvvR09QhN
 /xqI+1mzUaczSxDvQUx3z1LCst8POhlRo5asdDuOWPepIw+kRnIm3e1Qx6IA7phdshTDBjfWVadmwr
 i0dXwngfzuD78Cn+WVrC5iyAEwo5sL9AHfq5xfuFhNeQzUY3Uv9eAZ0l4ICC6yRJhdQXC0y22nv9ZM
 BUBJyTMjGdXIkgK3lQS61plEFibVvPM+TSBVO57o8ZAsixl+zeoI8Njb6CtUuFv+YJzKdFNo6f8k0L
 HqRe/ynwA8SuM1BMykqFxTYbyzxLpALPkVk2hQvPbjNpQAezVfJR7SdPlkNkbDcTHyTfdHV9ioKuH8
 6s+troki6LqagvUazf2FFlPYNRr/qnb3hlYkmZfxfvEkqkL4ta2qmw3disosghIF1anS5kiGz/eA74
 QcpelNn3b9trouqWPYOTfOX3hD0LQoW4P6lps2HC+J5k7/ZBW5mhSkEmJBMA==
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

Align the allocation size with DMA_MINALIGN to make sure we do not
flush/invalidate data from following allocations.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/ufs/ufs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
index be64bf971f1..e005cc90608 100644
--- a/drivers/ufs/ufs.c
+++ b/drivers/ufs/ufs.c
@@ -633,7 +633,9 @@ static int ufshcd_memory_alloc(struct ufs_hba *hba)
 	/* Allocate one Transfer Request Descriptor
 	 * Should be aligned to 1k boundary.
 	 */
-	hba->utrdl = memalign(1024, sizeof(struct utp_transfer_req_desc));
+	hba->utrdl = memalign(1024,
+			      ALIGN(sizeof(struct utp_transfer_req_desc),
+				    ARCH_DMA_MINALIGN));
 	if (!hba->utrdl) {
 		dev_err(hba->dev, "Transfer Descriptor memory allocation failed\n");
 		return -ENOMEM;
@@ -642,7 +644,9 @@ static int ufshcd_memory_alloc(struct ufs_hba *hba)
 	/* Allocate one Command Descriptor
 	 * Should be aligned to 1k boundary.
 	 */
-	hba->ucdl = memalign(1024, sizeof(struct utp_transfer_cmd_desc));
+	hba->ucdl = memalign(1024,
+			     ALIGN(sizeof(struct utp_transfer_cmd_desc),
+				   ARCH_DMA_MINALIGN));
 	if (!hba->ucdl) {
 		dev_err(hba->dev, "Command descriptor memory allocation failed\n");
 		return -ENOMEM;

-- 
2.34.1

