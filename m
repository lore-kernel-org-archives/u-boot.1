Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE5FECF58E7
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 08:01:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26126893FE;
	Fri, 20 Sep 2024 10:00:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="k8mPG6mc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADC6B89412; Fri, 20 Sep 2024 10:00:41 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF781893F4
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 10:00:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3787ddbd5a2so1050430f8f.0
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 01:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726819239; x=1727424039; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ufQB8A7S7HQWqlMl/QZrFootjisZM0DA8sUMyIHcnAc=;
 b=k8mPG6mc7M+5HuAdWj5G1S9aydDZENkeegSxfAuK/rnrAS9ncUlE3sEGr0KP/ix9xD
 FqjbpI6oR827LXevnerVY0XdVtMr138Akh0tKZjXWuoSPcwu3aCC9WLbM3Tm5ekYSm+B
 phq4AWEy5cRwU/On2lM/WYSQbFL6Eonznz9COfnsNKkMkQ9TIVaYEVg0pXWJ4DU2gF2r
 yoE52vJhtFlziMPpyyww6smRxZsSy2hmNQv1QnBM8QEmcUXUi1gH1Nor5mkrSW79cTb+
 O1i3nX1iXMvUjr5OEr+GRUFMsJP6qFkX8B7d95U9qr5JERKuhHC2jmxXht03anUSqJCK
 gyYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726819239; x=1727424039;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ufQB8A7S7HQWqlMl/QZrFootjisZM0DA8sUMyIHcnAc=;
 b=ZieDGuumPufaasJrHws8lxmZy03yi7DrhpUYtL4m6GygI21Z2XXbutZtqxzkZvLTNY
 z7i6qvawH34aiU+VMqiNniTyVQCDpP2Sv46E+mvjWxtzJD1Ekrx87JP6YwNKpXEPYE7S
 uU4v9xB9hWXHvPZim7HTFW8QNzrsVGMYGybBnoiyDGHBAzinF7awv0AfHDE4Uz3xHIAT
 cXGKKMVvUXEkLHdqG81biPrggVa915A0U18JSska9QlM4VQi8ngXhSWmi8tEYCo+dygb
 d6aAaJLQGwK3tKj4RQp2/IQITlL4Jg7GcUdQybQJWflWkwuqGFDYyh2FGhH1ypPWmEKc
 8dpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuT+G4w3W5J3+OMpD3fWSMKWZBJgIY3py+bOrOviobS4XCwVEY6iut4RL85nX0uOlUYfRhiPQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzeByf1XPFMHZNpCSuHLDC4SHLcffGc3enyxW/8JfLOK0AW9V5O
 F4Q5xft9MN4GPgnAtLSmXjesH7NOjRRv35sGe2XbGSy/fbWgGszvR5t8uIAEri0=
X-Google-Smtp-Source: AGHT+IE/j0XQa98iROz2Yf7r1jXghUFlfWhbucfib/ikp4tuBgohnuthUNLROrtDX9d82hWfUamuIA==
X-Received: by 2002:a05:6000:128e:b0:374:ce15:998c with SMTP id
 ffacd0b85a97d-37a422bec5cmr894376f8f.30.1726819239025; 
 Fri, 20 Sep 2024 01:00:39 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e7800313sm17059497f8f.88.2024.09.20.01.00.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 01:00:38 -0700 (PDT)
From: neil.armstrong@linaro.org
Date: Fri, 20 Sep 2024 10:00:28 +0200
Subject: [PATCH v2 07/13] ufs/ufs.h: Add definition of 'ufshcd_rmwl()'
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240920-topic-ufs-enhancements-v2-7-65ae61e73eaa@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1432;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=bbCuD/dyszp/lXuI6ICL/n9qlyT7Tgye7QKx3MCaunc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm7SubwP9LmpTBSNDfznyiSq1d0rsbebhj95DE0RnR
 u2vkJTCJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZu0rmwAKCRB33NvayMhJ0VsoD/
 wIGTUFEwm405Zs26EnSJy+BS3RmhzgVrlsiKc3TVlx+XWPriYbjnxtftjxjCYVtdrKr+IIqzAGnRIT
 FnoLQ/311GzlrbidrQKqS652xgPllikY022nL45sv8FbS2JrzRQ+2agQBZ+jSiMVs2YgM6o2X9el5o
 NpRV4Yol/YSlayZoEfwohXzsEvYHXFYeKLnnxxHWHUAatk1o/qP6WapA9vGa8KaTy+1sbj7tGIjLBr
 Tun4EL9ZvU3bUMUSpseGbcvf4evTTNVT5eCkpGWHz+Gla243y1C7f9llkMHQ6lD/ossP0/E6FgF0w6
 1FjbNCq3yC4luDwLYaqvRt9r1N5CrOdkmYuILgIIyPkYJkic8WXGlHxD0ZioctHzh47vcPFFWzs9/8
 +iIkLuQUF5OShBwdGxDplZuRdP37b8hn3gRaJrw0rpsn2zYAJqN6vQ8r9GNFThU0bWeLj30nmYiUAC
 6o29HCLLM3al8tQ20eFQBJw/l9agKVBOVm0MQE7sx6ViUp14IZfIWOb/jZfbiJkbB/Le0hgYk+Q9Jn
 3fGZGRLr9XSkRBUz4qtVHCaKnEQXMxJNTy9CVd6zQb13j8aKZBGEPFWUuRx9pbFIbd43r1oWrkBewd
 aePEnpyAx2Ihg4H9bm/cdbNhYMo1ajLbJRO6G8hTG5zf8QgAk1oXRosQeqwg==
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

