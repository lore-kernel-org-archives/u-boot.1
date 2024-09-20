Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F53ACF58E7
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 08:00:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75D54893EC;
	Fri, 20 Sep 2024 10:00:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UmEbxmOH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01591893CB; Fri, 20 Sep 2024 10:00:36 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DEAD893D2
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 10:00:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42bb7298bdeso20901985e9.1
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 01:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726819233; x=1727424033; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=knvPlmaDX5syLFpUIje8nDrZOHvIoGgtObR1QK+uQcA=;
 b=UmEbxmOHEM9igitlQUyYNK7Dd3TaIC6ccFmzebx66edn2boICzTWJtiOv2kj2kp2wJ
 nSJjXeRvXGDtpc7u7tKvhV/aoUxbRxgmAE4x2LV4qd6qCZvaGptpYpkA3L6bNGNK3dWy
 9/D26MLxpxmJllHinHuEbRFMPNIAEM6AtkG+I8oxr4YH8YLwksqD7ACpsaAcdMdvFc4t
 mSSsX2OffGAXdyAlzD0q26OpAMPqbhoaj3xO2VuQ3ablUj0x7OaoY2E7KGzAFUmhBKmz
 sbHGKJTDDD0mzra4d3sn4v7HwWJBbunuInuqYTZiqjgJzZLcGZ/cTra3dUbGpsaQxHXb
 CCEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726819233; x=1727424033;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=knvPlmaDX5syLFpUIje8nDrZOHvIoGgtObR1QK+uQcA=;
 b=aMewK3l7wLehiPRdhlmMKyMAe1tBgDsFYypH39gDDvPwSjJnlIsbZmycSv5sH3i7vW
 msFGeVKvHNKKTxE1baGbq0uBjqLeVC7Lc+AfF4SvrphM75fFprcQAv9sSeA3dUfX0Ybz
 HHphZcNFfxsi6eaKu3ruFWv5LE12QtTuQhmzp/kVYjmWIS+/S+8Z7rv6ZsUvRg7o4zfI
 12rnMehSjozB9dlDMyBMzoa9Uf3VnLyJLJ5guwQQXq0mw7w6llnYkgbOAaapxWH2zg7A
 ZedeUOxgkymNHTiacGEO7b3BxL92Lsdi8V5ISBoPyYK85hH3BFdqp5SroWgnKCBMe0tM
 kgSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUY+aVOgTTYE8T82KgvRUMBXFyzfO2a7OfLtMTVO6DQfwiOOJDVDvsrNfXZJDY8z10xsLlrkXw=@lists.denx.de
X-Gm-Message-State: AOJu0YyvGzLNJu0UVr7YsOGEWrblALS2fNE8uYDzLlzQzQrjHAr9QsIN
 LKB3no37zvs+gGlX3I295cLEtHv08vGUs/BjI3s2PJSWLzwn0/T0aVvSx2h1tGM=
X-Google-Smtp-Source: AGHT+IFC9md7/BAG6zPv/T0TT4seyLQWY22dHIQ+jrak1EeWno1JQ3DwDMszA4JxfKoQjM8sYmMW6g==
X-Received: by 2002:a05:6000:1fa4:b0:378:8b84:4de9 with SMTP id
 ffacd0b85a97d-37a4225334cmr2129264f8f.12.1726819233353; 
 Fri, 20 Sep 2024 01:00:33 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e7800313sm17059497f8f.88.2024.09.20.01.00.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 01:00:32 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 20 Sep 2024 10:00:22 +0200
Subject: [PATCH v2 01/13] ufs: allocate descriptors with size aligned with
 DMA_MINALIGN
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240920-topic-ufs-enhancements-v2-1-65ae61e73eaa@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1468;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=qjQYv0/dis5SePWQOliF/chMW/9j7B57ftSkErHC/tw=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm7SuZbrNNc2ZVzUdGM8J8fxG8xUbtpb8yvsHbmCIg
 YwgrbC6JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZu0rmQAKCRB33NvayMhJ0cKBD/
 9qOIjUr0+fNV0653bu/r3w9GxHo8WsQeuTLldUmrvpYDeP4VVT8wSAFFxUwKiNvyv7CqKO2CFZ2cOc
 VZahI4gzjbGxdbRC9wB5y9iO530KW4Up2Mf5bXNMMSavkquufbhVF0LGtPsEPjlhsdcUMewRGDv9xm
 OZ8bdckVcleoWXZrYzU9Aq7+RyUbeL7fjL71hayZoAos2Olk1uk5DbkXDUKBmpUF2GXXx/pKO93nJr
 sLVcmpJ9nBrpWPnrmS575yCDZulNBS425mycOEK63u5t69KhkOPGUwSLqNwJPJLCLHArB2zHmnY/kx
 9jAjniG9KYJuGv15i1Xnv5uUlivJgRVevPTXWtP79h30j0x7eJXbkPzpfztVp8U4idy7IvrE7m+cGY
 H8sUzL3iPaI3N15vEEDItNNx889quTgVYasTZrCVNyIsEueHDG7oN9Msr8sMPrT13cFgq4wFhZKj+V
 cSiM9cvJClBepRlIDRc55Fb2Y9FIppcyxx6E1v9oobTUhiA8kcxGuU1YubTuo5UCmIBE4nBwzGTjJM
 RbLSaXz6U0zPc39eNx/EeVqbnOYmvncU1FpjoKo8O3AYh8MR6RHMxB+v/lsflBs1Iqb/rrAaa7M4cH
 dNY838CYQR0a5GQ/PffDYKOMbRzbcJAIsAJ97HlHyl3+R+rwxaJnv+BR9IPA==
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

