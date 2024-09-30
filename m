Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAEB5CF6497
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 12:46:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A41B88F2C;
	Mon, 30 Sep 2024 14:44:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="N6zv1/XG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6128C88E5A; Mon, 30 Sep 2024 14:44:46 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0680488E2D
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 14:44:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42cbbb1727eso38185215e9.2
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 05:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727700282; x=1728305082; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jdNp2b/VeK3hO2gChIybxzHQC/swvtBzI2aD4vEgfYA=;
 b=N6zv1/XGrVLcdWW9MzS+YvFvRBPTUDPWKByE9TFj8B4NQTf3z0F4WXvoFjw4TW8dRo
 lVmIYQP6jg3SHNQZ8aDf0CR5q504D9tUSuGXs7hEhBTMxzgBm0oShilbioDfCw5ZKqwB
 q4WMiOUb587Lg+CQbaoDbriHAcQC32xE3wRNZXt1KTSRhrCsQ9OX//uOg3h+Gdpc3/nl
 0HEiDCp4LJ7kCKjrGRcIV3LO35ymGTMxGU/V5rC0UACW+0/Z7YYHlFdHDGhpHgfjn1CQ
 5UIuI9xznu3voYjQlBXgpCWOChrfm8BWmmGgL0WjzSGRMxgqmHmJpgOgyysZv0KV8C3E
 alWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727700282; x=1728305082;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jdNp2b/VeK3hO2gChIybxzHQC/swvtBzI2aD4vEgfYA=;
 b=oON5v5DgzLa/5TpwxsFrhif+M5W/VBIXFMnnUu65nVQSx9dGqB39EFTPP06yuO+SIr
 MPSX9CA0RQ9tCdcA/A6RTEpvMkh2Zdr75VYV9VQSUcWR0M4l6H+YMVGPouXPON5s8ZTR
 D7rR61jSKInSOnAZQ2P10fdTUXTGj5AR+IavGPJGU+G/12rfksazgaKxgxLkKbvu0Bbd
 UyrgfRKvfd37Luny6vpDul5d115tzLxX5GDPViRlO/tGsybZRZIrVrbnJHnPL7H7GKnQ
 wFfNZmj+Xg2V2uRGOz5lGkUZp6OT26s/n3sRJ/s65FVzCIT7+aFe+jHm63uFDvR2yFBe
 /yJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDPnXqQwQpCvjj9aCY8fyVLzCT81zsUlXtnxc9KZ84KvVVqiHxsLGjv9Nn9EMXX5KpGcLxj7o=@lists.denx.de
X-Gm-Message-State: AOJu0Ywi2bl6kPksFTkj4LSJGLH5FORErdevD0pQNtW/dbCRrE14/tl+
 y6Pr2fimfKRChGnSKHS5+W3uMYR4+m76U1t5uxXV1o/ofjfjwbmnDwe4yscFYnc=
X-Google-Smtp-Source: AGHT+IEeD0F/XcgHWVRLZslAekqLAEfjvl/+KoPeDu4ov9SSSPq08kOwcu/1NdIH+VS1/HfNFaA/iw==
X-Received: by 2002:a05:600c:1912:b0:42c:a905:9384 with SMTP id
 5b1f17b1804b1-42f58441468mr84840315e9.20.1727700282507; 
 Mon, 30 Sep 2024 05:44:42 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e96a36597sm149362745e9.31.2024.09.30.05.44.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2024 05:44:41 -0700 (PDT)
From: neil.armstrong@linaro.org
Date: Mon, 30 Sep 2024 14:44:32 +0200
Subject: [PATCH v3 10/13] ufs: Add missing memory barriers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240930-topic-ufs-enhancements-v3-10-58234f84ab89@linaro.org>
References: <20240930-topic-ufs-enhancements-v3-0-58234f84ab89@linaro.org>
In-Reply-To: <20240930-topic-ufs-enhancements-v3-0-58234f84ab89@linaro.org>
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
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm+p0s+bbVB8SSkZ6D6MqNywADdolMcXRNP1Jq23XD
 LeRh1ZuJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZvqdLAAKCRB33NvayMhJ0XcwD/
 9zDVPDy5nuSY0on5API65AxLXKJr2YH4J3V2RFasE7kvtGT6R+67jYbXd78lopGcf1aqr85lsE09Qb
 LRz5N58/sOrIhEQopJ9AhNtUWlaYL7T5WcFXKcK/y04+NF8Vjo0nx1VqIzoUwEG2kMdZS6pKDYlwgm
 DRzFmpzXcn+WLsv1NLdG7xccWm4u7djIZn1VRAtyF3HV41WaLK6C06Qh9rgLAQCNRjvZXCZ0CXtBT7
 nTbSI9hPoMxVx9bnFzrgPtdRztddteCVF9+M1SX/ogfu7AIqTDuTqD+51jcK7H+lt5N+0e68yCo8zO
 CBciB2w4vehbSEZBO626yHQBaQGYHlnCnNybCtisYOSVeY/vbg9ErGxMQgJpTdoXMNZ3x8/jmL9ubQ
 9y1lTY1j9u8lYcAaHVNyaKhuOJ3cJ/eSzS0oPNs01rAzkCwAfDkHF7UlCgrgCmjJDBtD+5HPS/MbdQ
 vuJo7wcXyOS2oxe9jmbnEBg5CtLMiM2eRj5/w957vwJVNfrbaqlwR7kFKRFlBCPnEgVU1Upcw5ZPoL
 d6gQTOBddmKwmSw93Qo/LaUUWC+WPNGs1RHdw9MnQJZApUV3ELW22Z5FhLlomL6D/IQlLLQkwfqHvG
 h8Mk6ayqWBxKAVwil7gWuTy/K7beBOzZqgcQL6IZ/lDpJqGuVl27SiUjKJFQ==
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

