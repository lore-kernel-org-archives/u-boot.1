Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFDD4CF6497
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 12:45:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0A9D88E5A;
	Mon, 30 Sep 2024 14:44:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="x+pe7wue";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16FD688ED7; Mon, 30 Sep 2024 14:44:42 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D25688E39
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 14:44:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42cd74c0d16so40055265e9.1
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 05:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727700279; x=1728305079; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ufQB8A7S7HQWqlMl/QZrFootjisZM0DA8sUMyIHcnAc=;
 b=x+pe7wuePDSXEb1pPjzxIrsdldfI5ZARf4pTaMdqBmoyNAf77BW32A4bT2nH6bdzGz
 crJqotcjSHCickYrUhsWs2YM08ZtZ1c7hNOf733WqEbsBwnpI+UXBnUvrvL3Cxrflmb8
 k4DyrfQjCJw9HYL85MZwcXr7eQfvANDSUsid4Tnmr7g2HFdJzp0UaYeA+f4umGIgDjOW
 RoEAOkxye7U8WSWnwVjWtoWTkqU9i8ELCfXNRCkBhBS0svgmNkylvW//PvIBoOKSu3aB
 laj8TmvE1iVVl14m/PKHNsdGMg/1np2/gqYFE1StRb7KDQvvzjBpbDc14JTu9joXlwxG
 eERQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727700279; x=1728305079;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ufQB8A7S7HQWqlMl/QZrFootjisZM0DA8sUMyIHcnAc=;
 b=o5BslF+qRF8yB7dKp7WCRxnYmZGWl4TfbdQxN0cHJsaNfEguhGfJls4y+ww/eDVPpZ
 3y/WApiLDBa/ezPIWYuxe2St9y+kP1PFoE6GBrva4b19E7coRPf3/yUSEvFGSHqSbSK4
 3fLO6c4iWb4oLcdW3PkUe14xktjKJ5j1lVoc4NMX1KWdpOiZ7u8aPChltYPZh1zD5PSK
 vGXTmJY2l4AdfStbJ8vs/Ow3rqPBtPIr44Sk15X/cvfejTOXba3rxVQ4Xhe4mJ8F7v1q
 YfOxSP/18MH9Z9ruucXpZfeMFyeDzcmUM6yE86rn1VZT/Xg0bxzvMtqofPcgVtXpqNMw
 JOeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3/0H0Ew4onTGBFd7utzt/vf94Zb2Em8Zk018u5dGRvQls3tjV2mUsyJd4gienERwxJqLqTyc=@lists.denx.de
X-Gm-Message-State: AOJu0YwcSUBg5858YaOj9FekHr8iyHVs/Vl04Ls0vu95ZBwiMuu/mtMG
 S26jjJGjUuJCXp605gcUJ8g//RBY4qrSiMVaB7m5n93lhhm68HxPJm7nhiLxbcQ=
X-Google-Smtp-Source: AGHT+IGMiovAUp6JP4StjN7SvX/Y39dYDa7pSVbDm2q5NTcJN5fu5unvC9iQwPgFQn/bpkINX11VVA==
X-Received: by 2002:a05:600c:1d25:b0:426:5416:67e0 with SMTP id
 5b1f17b1804b1-42f584a20f0mr94853565e9.31.1727700279503; 
 Mon, 30 Sep 2024 05:44:39 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e96a36597sm149362745e9.31.2024.09.30.05.44.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2024 05:44:39 -0700 (PDT)
From: neil.armstrong@linaro.org
Date: Mon, 30 Sep 2024 14:44:29 +0200
Subject: [PATCH v3 07/13] ufs/ufs.h: Add definition of 'ufshcd_rmwl()'
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240930-topic-ufs-enhancements-v3-7-58234f84ab89@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1432;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=bbCuD/dyszp/lXuI6ICL/n9qlyT7Tgye7QKx3MCaunc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm+p0qCP/QYqlZCQghNejycqFF6JtxvbK/YnUBAX5+
 vJHQNmyJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZvqdKgAKCRB33NvayMhJ0U4ND/
 96Ce1FPUlHNo673v6SkuyVusL+0ZtMR6UMxV9fpTp3WyWOYIvd7Nk3VlY8xORJ9ocdMsBdMWU+swfe
 6QEyMq9vnaOXlHu8nZZNWijc6tMifOSSWUvt5eOib08zxNx4TjYtlxORdi+2U9l2rPXHAw99MI4PUU
 lY6xiodZZ1BNVa3Q6pd/qsSOPElb1pBWFbhjgofc61XxWRWpWGUfJDRQuy75/ItI6z7Kaf8aXmk2Im
 z3zsWM++EMuqicU5I72X0/kHnOtveapJ7s7dvVa5NytKBTWx0NHzp2Wu2CmD5BqZkKbr2kJujNN4aP
 4kHQQo8ADt/F95KxtSb57MFGSsuzmdJGxjO1EwKJ1JcgRpfk0345RnDRjkrwaot7t4bAWiTiRg7Nw+
 d6HWqyR5FttJKqwV6Ox8luReqzuTd8zS8sy+lUP9tML89Gaj+lbK2d2xMt97DtSdRCumpQRg8T7Hfu
 f2rrptlPAr3uSnYSsRqtzFimYttXYdnHkQl8WdNoxJ7Z3n4qfCv+v6Tmgnk4pHQG4GK/BMvUin1OBK
 8fuyH1mB3QZIzAL4T7fSctEi8OptMYhi4XGtqqPC+uiPafqJwYBNH8UTh6PswpGZos1IcZW2u0a43G
 94X/Hl4mFHPF1euuCiXwNj7BoBVaid1f2wnqCU9EKUrwp8iXFIwHg6diEb3A==
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

Add definition of 'ufshcd_rmwl()' helper function
which would be later used by Qualcomm UFS driver
to read-modify-write registers.

Ported from Linux kernel commits:
e785060ea3a1 ("ufs: definitions for phy interface")
cff91daf52d3 ("scsi: ufs: Fix kernel-doc syntax in ufshcd.h")

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
Tested-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/ufs/ufs.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
index b55c4a9e996..555f8a6857d 100644
--- a/drivers/ufs/ufs.h
+++ b/drivers/ufs/ufs.h
@@ -3,6 +3,7 @@
 #define __UFS_H
 
 #include <linux/types.h>
+#include <asm/io.h>
 #include "unipro.h"
 
 struct udevice;
@@ -933,6 +934,23 @@ enum {
 #define ufshcd_readl(hba, reg) \
 	readl((hba)->mmio_base + (reg))
 
+/**
+ * ufshcd_rmwl - perform read/modify/write for a controller register
+ * @hba: per adapter instance
+ * @mask: mask to apply on read value
+ * @val: actual value to write
+ * @reg: register address
+ */
+static inline void ufshcd_rmwl(struct ufs_hba *hba, u32 mask, u32 val, u32 reg)
+{
+	u32 tmp;
+
+	tmp = ufshcd_readl(hba, reg);
+	tmp &= ~mask;
+	tmp |= (val & mask);
+	ufshcd_writel(hba, tmp, reg);
+}
+
 /* UTRLRSR - UTP Transfer Request Run-Stop Register 60h */
 #define UTP_TRANSFER_REQ_LIST_RUN_STOP_BIT	0x1
 

-- 
2.34.1

