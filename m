Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21360CF58E7
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 08:03:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D59F08942A;
	Fri, 20 Sep 2024 10:00:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VMbdVQde";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72679893E5; Fri, 20 Sep 2024 10:00:48 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0969893F4
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 10:00:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3770320574aso1077160f8f.2
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 01:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726819242; x=1727424042; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jdNp2b/VeK3hO2gChIybxzHQC/swvtBzI2aD4vEgfYA=;
 b=VMbdVQdeAne63Hq4xPDWgFlTE5UQEXcizx3XKOOINiwAimr94UTBYXUdTzkmbFM7Mn
 bXSptTHP5tecmV5fRFK1XHjfWRDfc742Q4c800gmK8yBoCsBysm/nH7W2/i3pJytaO/a
 +6DTw5azKTGTm7RWxVYpcvtfuvxu9ON0xRJ25d+JSuOkTlcDDgkhXBowtBk31FJUbq9K
 5KTmvdJQE6IAIufG6lyUXEZzRvXaPePUC0U3pCTNsImhCxzOAF5Ya+Di0udro5U2LO4p
 bz1vuMp7Q/dxe9HuUJb30yhX0KvKoLQrjWmIlX75IzqzORxlNwhlimtU4X3u6oriVWbu
 eQIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726819242; x=1727424042;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jdNp2b/VeK3hO2gChIybxzHQC/swvtBzI2aD4vEgfYA=;
 b=nfQwEA5F1HHCgSQpUBl4rIlmJWXutvOGtkyT35jY2bteYqdubewf/cmdkxjtpi6fcH
 Kb9c6/SU/9jUQXAASem47eEp4/gwALlCK4LF9DXLcpWrzd+Xnwn8+sM4k4EuEx52jcAp
 tCUfPE3Qumn9O/tUS+Tp1mh2LsVlQQvDiIYUy9WBgiz+qOk1SbmLsiBIdAUAfFe419tt
 9+3IKKblDI53vWSYMODf4K37OKYMlqRdn7zxTCHbn5xi1viYKXNeNad40rV9nPQArwXJ
 NfAo973mdiI8YlNDIi6EWk5Iev4UR/B4JlgxjoGtAOeBrQZetDDowCr2Snnz5YFmN/Ix
 RPtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXP/ScOWrM9kGI8VAaEl2gPtFnBqpD+CKb969keW0lfOdTqpOP9ayRhszuT59/y5iBepwd+7dw=@lists.denx.de
X-Gm-Message-State: AOJu0YxJ1F+SYWUjU2wSdMboBAP8kVIro6Ss8TbXQzT8w63Ztevjh0js
 VYqOgoodCYe32Z56wCGjCEFdGj+IvlubrJUS76QInIu21RHBsuGecPdwUWFvIjo=
X-Google-Smtp-Source: AGHT+IH9+j7aHroWEwQo24dA7Nr0KIoWYCSGDuWtPQRTMKeN8a+1S1ZoAqBnTNJs3EfuRLpzjPXfsQ==
X-Received: by 2002:adf:f7c9:0:b0:374:c651:4abf with SMTP id
 ffacd0b85a97d-37a431be88cmr1091138f8f.52.1726819241969; 
 Fri, 20 Sep 2024 01:00:41 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e7800313sm17059497f8f.88.2024.09.20.01.00.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 01:00:41 -0700 (PDT)
From: neil.armstrong@linaro.org
Date: Fri, 20 Sep 2024 10:00:31 +0200
Subject: [PATCH v2 10/13] ufs: Add missing memory barriers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240920-topic-ufs-enhancements-v2-10-65ae61e73eaa@linaro.org>
References: <20240920-topic-ufs-enhancements-v2-0-65ae61e73eaa@linaro.org>
In-Reply-To: <20240920-topic-ufs-enhancements-v2-0-65ae61e73eaa@linaro.org>
To: Tom Rini <trini@konsulko.com>, Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>
Cc: Michal Simek <michal.simek@amd.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, bmeng.cn@gmail.com, 
 u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1907;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=VH31kyx3vGlBvfPTBzFzjs7QQX5ry7nhhEz711qZ8eg=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm7SudITlYBYW4VtV7kARszN9PbbU14MjvwAqJZpG/
 LqnwuD+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZu0rnQAKCRB33NvayMhJ0cpnEA
 DMvYZ5wVaJKtU/g7M06PPcGlnYFR2e9m1DBtTHWgeK7hTQuf1C+cTF/30LmCmFDK+tnbviwwtwv2wK
 0S7JcQHX+a5gAW9/Njv820rd/6V0eDY6X8nMmkrbVQ7qYNPPcOK7Tx6J1opM4NICHJxZ3EYAzgIUlt
 3/CW3mHrhoH+g7nWl0DSqfAxLrcxuSoy62CD/EN+AXQYVwcRPRpimPVNuh5i/fM62TMetwO9ec8JFy
 Kz8htx/X5yxuDh+fYbzzOD6EDg+OYAfZZ2/+/u8o7RzGYxfR2wrqx07XljpsRwICOUJDusmUiTRFO+
 Qj9d0YxRDL8jk2fNS9x6xCzpAw8ViId57W6YUOREeSoX/SGGb0bzKDkJJrvpQU689D8zjDfp8Y6Xpu
 rMMarj7LMH41DPLF1cPVU3uU7huqrw3sGD8O2uWdxw6n/09TlSDKrz+KKfdyWzzfykjVRP9doKvxvj
 Gyw1OZqLl+gPU75b3bmnMCc3h357GOXD6js0B8bXjqfiP7pEJ6h8Z3LbuurpuBNjphkN68auSMZSD7
 DWzEG/SmbAQtjMsi0Rqd603R1nCoBMfZ3j4OIXoqC2IcvWX8ewoCoeMlit6dJ4Px+/fEdfrEGrk6Fm
 ikRt6Xw9aPTvpZsnEyk/3HmxQgt9EmKmiflpelt27ZaZFhJf9eu2OMgk8m7w==
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

This makes the barrier placement similar to the Linux UFS driver,
synced from the Linux v6.9 release.

Starting from the v6.10 release, the barriers were replaced with a register
read-back in [1], this will ported to u-boot in a second time.

[1] https://lore.kernel.org/all/20240329-ufs-reset-ensure-effect-before-delay-v5-0-181252004586@redhat.com/

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
Tested-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
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

