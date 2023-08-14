Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FBD1C001B0
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 21:56:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E479B869B6;
	Mon, 14 Aug 2023 23:55:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CkPKQiQ8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8060B86993; Mon, 14 Aug 2023 23:55:58 +0200 (CEST)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 072F086989
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 23:55:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bhupesh.sharma@linaro.org
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-5657add1073so2122494a12.0
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 14:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692050153; x=1692654953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I2cNB02Pa6jyuBJ45ecjofX2UZ2ZIVJf6N1cut4RTFA=;
 b=CkPKQiQ8k3y4aVhSTHMRhwA1gDomPkLUKzN8P3Ua76w97yS5rSH9Whe1VpJArW1Kaz
 qX4i02x7R48wF4kq7pGQA79A1df5RO1JBgwpDDeVCkSbBlEgGvbsGJQmLA+RPWTJcjP4
 uRm9aKPVfYIEMn0iSlh1EqiqTkpPaFoBz/GzCR9h9NZnpi+rZJtxAflhq65lrRaI4Ssn
 EVo2Cp/DQauDUOEzt/MV9KXZM7G+gW90FiYH49fF1v3XDku+ZA2tD0O9gfdNAY6JcpoZ
 /lvt4JbBp2ZCDtRqvY9S74haCPXcNJBuABLxbORM2vzxXPmbWsv6FA1+KJdmESVZpDHG
 joZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692050153; x=1692654953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I2cNB02Pa6jyuBJ45ecjofX2UZ2ZIVJf6N1cut4RTFA=;
 b=mGwZ/ia3CFzBTCaFEEY5WE5QsNhbObvzMe7qOkhbQEoyFv64f3mwR1wzgC0RvxCYjY
 XiNtlCwoE9QOfC1L8o76j/JsM+IQQHNRw0O0ZRTMg2f0uV3Yz640sFCmeYlkHj+VFRSe
 jId7bAz2nmOWiRSn79/uWdv6D2ZhpJr7fcPg7IApoericYu+n4wCh3SiM6WOVXY/dU8l
 FJNRX2as0dirnIatC6Jt6vIsFuZ1hvk8+Xf2Nxi0UgWJmO4EXVQXDdR8XokuI+IxyGfg
 aMaDXPPeINNMaZS/jOERd6GYvfq2+sBdHerQIUzpRDEk/E1By3hvMWV3SAMgyo2WgJAj
 fLqg==
X-Gm-Message-State: AOJu0YwRJ5Imr8ItCMoU/esApl9KrWF0c1eKGFFdALMOr00ypRNie4Ol
 5ETKqrJ40vmT5O/6LymDrQCZkCDc1H/vO8Yd/WI=
X-Google-Smtp-Source: AGHT+IGu3d3WBZu6JzegtwO2yUkn4wY6i/1z3C/YAKXDOkkAYncD4fKYlNep7oGhM2dZJ4FRYM3wmw==
X-Received: by 2002:a17:90a:644f:b0:268:220a:7080 with SMTP id
 y15-20020a17090a644f00b00268220a7080mr261768pjm.2.1692050152868; 
 Mon, 14 Aug 2023 14:55:52 -0700 (PDT)
Received: from localhost.localdomain
 ([2401:4900:1f3b:3924:6581:8508:2ecb:b5dd])
 by smtp.gmail.com with ESMTPSA id
 n4-20020a170903110400b001bba373919bsm9872075plh.261.2023.08.14.14.55.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 14:55:52 -0700 (PDT)
From: Bhupesh Sharma <bhupesh.sharma@linaro.org>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, bhupesh.sharma@linaro.org,
 bhupesh.linux@gmail.com, marek.vasut+renesas@mailbox.org,
 sumit.garg@linaro.org, rfried.dev@gmail.com, patrice.chotard@foss.st.com,
 jbx6244@gmail.com, kever.yang@rock-chips.com, eugen.hristev@collabora.com
Subject: [PATCH 10/17] ufs: Add missing memory barriers
Date: Tue, 15 Aug 2023 03:24:50 +0530
Message-Id: <20230814215457.4075025-11-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230814215457.4075025-1-bhupesh.sharma@linaro.org>
References: <20230814215457.4075025-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add missing wmb() and mb() barriers in the u-boot UFS core
framework driver to allow registers updates to happen before
follow-up read operations.

This makes the barrier placement similar to the Linux UFS driver.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 drivers/ufs/ufs.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
index 15fa3832b9..a97c45a530 100644
--- a/drivers/ufs/ufs.c
+++ b/drivers/ufs/ufs.c
@@ -503,6 +503,12 @@ static int ufshcd_make_hba_operational(struct ufs_hba *hba)
 	ufshcd_writel(hba, upper_32_bits((dma_addr_t)hba->utmrdl),
 		      REG_UTP_TASK_REQ_LIST_BASE_H);
 
+	/*
+	 * Make sure base address and interrupt setup are updated before
+	 * enabling the run/stop registers below.
+	 */
+	wmb();
+
 	/*
 	 * UCRDY, UTMRLDY and UTRLRDY bits must be 1
 	 */
@@ -892,6 +898,9 @@ static int ufshcd_send_command(struct ufs_hba *hba, unsigned int task_tag)
 
 	ufshcd_writel(hba, 1 << task_tag, REG_UTP_TRANSFER_REQ_DOOR_BELL);
 
+	/* Make sure doorbell reg is updated before reading interrupt status */
+	wmb();
+
 	start = get_timer(0);
 	do {
 		intr_status = ufshcd_readl(hba, REG_INTERRUPT_STATUS);
@@ -1989,6 +1998,8 @@ int ufshcd_probe(struct udevice *ufs_dev, struct ufs_hba_ops *hba_ops)
 		      REG_INTERRUPT_STATUS);
 	ufshcd_writel(hba, 0, REG_INTERRUPT_ENABLE);
 
+	mb();
+
 	err = ufshcd_hba_enable(hba);
 	if (err) {
 		dev_err(hba->dev, "Host controller enable failed\n");
-- 
2.38.1

