Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0F97ECE564
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 09:22:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C386B88FAA;
	Tue, 10 Sep 2024 11:20:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Bi43sfFX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A42DB88FA4; Tue, 10 Sep 2024 11:20:42 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB0FF88F88
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 11:20:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42cae4eb026so29308135e9.0
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 02:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725960036; x=1726564836; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FiZ7d/zss0qv1wKmPr1Qcf9QsjkyREN4pR1f7/QXCVA=;
 b=Bi43sfFXEgBAXAMXRYqEhXlQTO1R5uR0X3TmKkK+EX3vISSSJ2D9BHmQMI+7cl3xs3
 XFPfIYnpkfTf0vGnIYLUZpyDb6IEuESl1TcPWjuESvM/CHtzyTZA5cUGSzynxYsoSNhm
 zZRlunMBMO7HuPQl9bjQjbI19gUClzQB46Rz5psikemv5FCLxb+i5exJOHcwhCu03Atm
 FQmd5412aZ2VjgfBD7xrEXemv0i4awa2xOY1bkBJuWHqYzNjzTU6S1lY+TJfAcNJT4E8
 BUCRsH2kEOpBZ3vg/Ezq/SSE3DTJfw+PUOi5/Hu+pePrA2nUmHXfAYQaNOkClBiwmn4F
 25Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725960036; x=1726564836;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FiZ7d/zss0qv1wKmPr1Qcf9QsjkyREN4pR1f7/QXCVA=;
 b=i5hIajNwZuWrBynpNeZHS2OezSAVh177iu/f+okjgxdQaVUQ6Rbe9N3Qwc7/8d8sRb
 ePKNOJ2KEP0/iYT0LUejGHHyiCS+27BgLcYp21GuwVCChRtH1jgWrdsJrREoWXLYuawk
 39MZ2zbVynAungem8+G3thgG+/DoFd4QFL+trddIwu2MZuH/QzV4uJiap3C65qL+kr5r
 b7e54kL9ET7AO1bry1+KYA4Vuojocx47KGd4HvhCGs9aV86hnXrQZBLXRyPsS+Vv1m9J
 ZRPJ7kSuN73UJEsWoHXze1dO5C4Cqm8pQ0DTZobrNw7WuU2LmZI5qwmci5YIV2vhRG+r
 FALw==
X-Gm-Message-State: AOJu0YyoZ7tVYcYHKRZiGMQn3bc2edpE4tBmPRtYVsxsMAUIux1R+Y3s
 BGhdJ2VL6EGqemhgQ5ZyGlYiSmVLvCbOZjh+cp64lk12lmuj5pwZ7grS2QO1+7USG7QpdIHaOJH
 3
X-Google-Smtp-Source: AGHT+IHspWzbUYfKTVdevvKN7dtJU3HsDYkBgN62QpAtNjqj3aWvWvK7vhpeYLt1Z2gXVoNY7K1cjA==
X-Received: by 2002:a05:600c:4506:b0:427:ab29:30cf with SMTP id
 5b1f17b1804b1-42c9f9768a5mr105140035e9.4.1725960036412; 
 Tue, 10 Sep 2024 02:20:36 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42cb099acf6sm101256245e9.9.2024.09.10.02.20.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 02:20:36 -0700 (PDT)
From: neil.armstrong@linaro.org
Date: Tue, 10 Sep 2024 11:20:27 +0200
Subject: [PATCH 10/13] ufs: Add missing memory barriers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-topic-ufs-enhancements-v1-10-3ee0bffacc64@linaro.org>
References: <20240910-topic-ufs-enhancements-v1-0-3ee0bffacc64@linaro.org>
In-Reply-To: <20240910-topic-ufs-enhancements-v1-0-3ee0bffacc64@linaro.org>
To: Tom Rini <trini@konsulko.com>, Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1550;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=5oG/hJDRzgrfw1H7DuKQEcfPeZJkmu0N1nxQo6XZS64=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm4A9ZVkHT19ZhlfhIdSkNnKZzoCEsYUXcZSYKd92F
 7bJ4EfSJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZuAPWQAKCRB33NvayMhJ0SIhEA
 C80FMzpCUoL7uXVNU45bWmcf0QdEPKhUxv7NOy9+DXJzpZ0DUP1YnL4beBxKlYwSR7I5RJkvlVjX4m
 HJhQdWxjMno62b2CUzNl46hGlqprRmBGQEu6U1MVfeWgkDfJJgkTgjBj4821oavZgLEBLucRcRQn3d
 +S3EfrCcMuSvKjxu2+j+YL9DD36Ie//1CaovgO0D0qPr4Nhh1DyfmGRemPl4jmaXDkVUUNeTYsGiTV
 gZM9MBSh72byTc7V0FI9ov8JHzF3xzzWrgJVacazrlSCdlsyyP6yOBZHu+lmQB7BNnnFljolDLNxqR
 5UfEPlKB+bDhG5eos294bw5Ej/Zq8b3KtV6QFzT1jSPTLZDkHxmY9jm1crrLMXWChIZehhgI0WdccZ
 yI9vM8Zxctb0vKh2CKtC6Hw1nJNw0+S8skBL0zg2k86qqsKSU7yVFxYGVr12rK+0hxyj4vapN2wa7j
 xGRT7NgOCzNsUKWNK2QFN7yEyqNbrRk5yOUvAPer6QHPZKeqNinystndrcovseBaPHMJ83KE6IFK6h
 CoaFjBUwbDBpP+I4ndvSFBftTlNujch46roOIbRSFvjE51iNOpE9ue9Uhl1bq8og43O37Bn+jlM8Zl
 IgKcyAfMoVTMifmjnc6dQ/tCAcqFS0TpUgZk7bvQL7fi6+fAMnANYR1jfHgA==
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

From: Bhupesh Sharma <bhupesh.linux@gmail.com>

Add missing wmb() and mb() barriers in the u-boot UFS core
framework driver to allow registers updates to happen before
follow-up read operations.

This makes the barrier placement similar to the Linux UFS driver.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 drivers/ufs/ufs.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
index 565a6af1404..5d4e5424358 100644
--- a/drivers/ufs/ufs.c
+++ b/drivers/ufs/ufs.c
@@ -432,6 +432,12 @@ static int ufshcd_make_hba_operational(struct ufs_hba *hba)
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
@@ -861,6 +867,9 @@ static int ufshcd_send_command(struct ufs_hba *hba, unsigned int task_tag)
 
 	ufshcd_writel(hba, 1 << task_tag, REG_UTP_TRANSFER_REQ_DOOR_BELL);
 
+	/* Make sure doorbell reg is updated before reading interrupt status */
+	wmb();
+
 	start = get_timer(0);
 	do {
 		intr_status = ufshcd_readl(hba, REG_INTERRUPT_STATUS);
@@ -1994,6 +2003,8 @@ int ufshcd_probe(struct udevice *ufs_dev, struct ufs_hba_ops *hba_ops)
 		      REG_INTERRUPT_STATUS);
 	ufshcd_writel(hba, 0, REG_INTERRUPT_ENABLE);
 
+	mb();
+
 	err = ufshcd_hba_enable(hba);
 	if (err) {
 		dev_err(hba->dev, "Host controller enable failed\n");

-- 
2.34.1

