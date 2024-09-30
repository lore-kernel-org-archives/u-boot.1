Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B143CF6497
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 12:46:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0053A88F4E;
	Mon, 30 Sep 2024 14:44:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IV3gKhKC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3A8188E2D; Mon, 30 Sep 2024 14:44:49 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB76388E24
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 14:44:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42cc43454d5so31428665e9.3
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 05:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727700272; x=1728305072; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=knvPlmaDX5syLFpUIje8nDrZOHvIoGgtObR1QK+uQcA=;
 b=IV3gKhKCRJNtsOnvnwj2b8iG01AgUNPgjEPu4HTt9PkDyhxq78Bk9uks8agJjbUHS0
 8bI98ojc6ENIY/EiVoxWnwnI+X0WBSo+d//+HPaKzew2BcV5ePzghL8NvGc0N3tClbnO
 zxb+HxBt5hxdJriPhzzjrMTN8erY5W7FDCUpgdCVb+rAFkwn/0Widms0gNqyIvhMMUhs
 RiSZwPKmwnWOIgVMcKQpXIfAu/TIj5Y+NiI1dGLAl6Acw/5crd8mCgvMVbYplZTH/ZDn
 W3vNDifxP1uM8gZdtZ8tsT3/a+SRUZJ/i8I4aYN8xSYZ2b+gi59tFw3DbIwIfNbNlq1X
 YubQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727700272; x=1728305072;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=knvPlmaDX5syLFpUIje8nDrZOHvIoGgtObR1QK+uQcA=;
 b=oOFcgoUjraCYyA6JhNuQSTfbtkBJz9mzuA5gImrOtcSlkMUylsdzILw5rqumELjvOe
 IocfrmbyTnxkikaf4Nj30Kbz8GZjRpZDe10JjvohcLuh4FSXjDHUcT4dB8PlPtr/P7oM
 bFV+vSKLJMBHk4no3lMDYohae7Ey5nGI1+KfhS3d+F+gFHiqIn6viNv5IVYFXkE79atp
 +7FKDjwDI4BsLTak9ueDpeG4PsX4W3WIeO7mdg5JluLAuBexUUziSbmVrhQxyXmg1+qZ
 MVROsSzhlGamhsQMu/DGMTpLL0Tnxy7k+pHKWRCFlQEQrBncGnplb9GTtxA4cc91wxv0
 MvAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJm0/nUIVjs1hXVc/rZlSKOlSm1CBj4bTJqdqPkN4jWf3If+Co0YscNr+zltVVxMqA8iLo0Ag=@lists.denx.de
X-Gm-Message-State: AOJu0YyrpetYUz6perOnJCutNnRTzhs8xgliC480LFHVEx590pObB+gk
 P6+kHfP86O31sAhhiizdAsjASOV+xTkxvuZjWwKPQTtOTd7YYSalJA4z1GwutfI=
X-Google-Smtp-Source: AGHT+IEvxR4Usvz07qZkrverYKh/jlr5ZjV3haSXrhLX4MXdh3BM8mv9L7GIjDQlV7VUKmcCkOuYeg==
X-Received: by 2002:a05:600c:17d1:b0:426:6158:962d with SMTP id
 5b1f17b1804b1-42f5c33d132mr61749115e9.23.1727700272129; 
 Mon, 30 Sep 2024 05:44:32 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e96a36597sm149362745e9.31.2024.09.30.05.44.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2024 05:44:31 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 30 Sep 2024 14:44:23 +0200
Subject: [PATCH v3 01/13] ufs: allocate descriptors with size aligned with
 DMA_MINALIGN
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240930-topic-ufs-enhancements-v3-1-58234f84ab89@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1468;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=qjQYv0/dis5SePWQOliF/chMW/9j7B57ftSkErHC/tw=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm+p0op/wassLlxaqKsPS7KuDnWWTe/m33d8+GBsW+
 yGJCikWJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZvqdKAAKCRB33NvayMhJ0Q/LEA
 CwAO1xkW47eviXrfsW5HddJz2taHdiResVR1msA0m0WR9S87I5imFdH11zJnwy4VJ0vrIYULsa2/HV
 posiwnkY9Fcpv58np3/x9KcBM4e5QZyF8HaHzZ0fqiTdt0q4qu/jkGYkSPG7MjNf9NzqNhk1SK1Bi5
 BfPRJouVF8WpL35An+jaTieoYxSfPxwlKT2fKybyH7YecHgM74X6PtJ8z++n/zgWbuipjCWkg6T9kx
 RUae74gwdL7pV/sIO7S7EE3K4rFqf7GHsIh4zPwP19Jjrr8Y/F2VBqD7iH5cZiDSaPU4szaqJUJ/U6
 sFovRtV/vJYVdarF25XpdYQ1arYH+yJ/n7hS0lh8I6H5WKz72JgSwaZXRZ/1B5Dfw5A7NR11haihtb
 0Lq1qsGm/DXEl4X4Cl6Vu4dFNJwwrUDeYxMt0g5JJ69zS0wDlo2+EAn9Bt+Ebri40J8bFqS7/z2+ry
 Mvj07RUl0n72cj5aA5Oz10UnK99UI//zdtoLG98cwjlANlttljZToDwiQGVS8ZPS8xPIeyCjJqzDGg
 q1sR4SafbX3hqz+dZ858TuaQIWie3Dm8O6i4YwrTJgCopUxCs65IS8PWzlzGN7QjQ9OQaIDXLQ92v4
 Gu2y9mAktGGOff4T0w7QfzXMHPqk46FbOS1lotHAC1WKX2PDCMw9ZY2RcCoQ==
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

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
Tested-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
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

