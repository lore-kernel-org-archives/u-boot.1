Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D261AE7718F
	for <u-boot@archiver.kernel.org>; Mon, 30 Dec 2024 10:31:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1930180628;
	Mon, 30 Dec 2024 11:31:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ic774IJV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3554805EA; Mon, 30 Dec 2024 11:31:08 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AA60805ED
 for <u-boot@lists.denx.de>; Mon, 30 Dec 2024 11:31:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3863703258fso5902972f8f.1
 for <u-boot@lists.denx.de>; Mon, 30 Dec 2024 02:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735554665; x=1736159465; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CV0gAxLfFjdiPnKV+byW+aIIrcjIiUgNZiyDZtqpiPg=;
 b=ic774IJVJW0uBtEfxIoS9QVG5n9eks8yLw0Hng6rbBILmVZSI3hkvDFcf28tUwveBe
 InQvtnLB+iSHg3wkEIBxYJ/YhZ1fSf8ee+1vRncIuFq3MBPs5flpa04cOgaEUx32NvVq
 N0pFqvpekdU2hMwPSssjjZJUZycRiGHmr9uqXeAJKihgX8UIy3C9DZK7EfqALKyp+Hvw
 v9nIKLyDgE6EFeZm0H98rLYWR5QrwNNv8vsHEqRb0ENzVKnXvYtuUFOtRS7rLIn+Oaod
 3tDL55vkkWPHZ7xSVruqtB9A09QaP1R4h+P9xcMSlxzloJtY78XJb4SsEBjhNhO5j3+h
 YdxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735554665; x=1736159465;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CV0gAxLfFjdiPnKV+byW+aIIrcjIiUgNZiyDZtqpiPg=;
 b=AUHcgC1qCGOfdwjw+mn6VfClIhliEaOO+s3glG2fmzIng+ggITBJw6iqpjO+szrGPH
 Jb4qodqohOU8ijYkxoKzan1DmW43tf5o5XBH8z+YoZNkbtizKnImdAgWBO0Uo0+BMS6u
 l0uZqFVmgDjZfYw5QKh99bPgIk+noSM+R1tt525zcOA/5AMUwRSgmLJrvmgYA1WN0RlB
 AeJTLREk3Iw24iaF+B7VAfBCbIX3Fw+HN8NoMhmJurEdUJhK0VrfKVoLVXtnfvMIB8Xq
 Rkkf+Vcq1PfVzfJbUph9qKypG1G3Cw9A/s659zL4Jr8CMU39dVg8GANHTiKENGbu74cY
 bnwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCz+TAIqQesbs5Jy0GMpQHkaxcLqDaftGGWB8ieRq/Taj9iMCarZoyMb9Dsx2hMlmRPthJ+H4=@lists.denx.de
X-Gm-Message-State: AOJu0YxARvGDBQOYCW8ftyYO7AixeTqLW+VZA5gVYSCVU4LS2alnuUoV
 gcadtbPOrjN2NW8dlHdeuT4E6BHRaN1Qv5FQTUPjTSlZm6qOxDQ0qGUbm8+NuMo=
X-Gm-Gg: ASbGncu/Ac6PqMBadIsRPs/3CDQOiLO697WSLUMw/Bl+aWr+Dz73TfYtt2CtPc7UGTM
 utp+7ntwrL9plJcTGFb+m4sDbgAI3m1cjF8Nh9c1Tg2SiP2H8RtJx2ozMsJuDSZUaEwBVkKrxC+
 93QnC7IYUrvJESZuOvKUKowfGqm8VFLQTrQ/7zecm364y5OP8PJsE6IVnGZal5QOiCUnWTjAPT/
 +DBJ96aE3RqNrbzPbwXDVA2rA/bd8xr94LWYHHDXkiwsVG+3qj7L3DrRMs/3bDLMbx1iteUEai0
 Mg==
X-Google-Smtp-Source: AGHT+IEFPdyd4c43lDeYDQkjLvGcgpre0TQ105IkorreBC/4aj3hiUJ6T/0zGGUvZzdDU+bnfiLUnw==
X-Received: by 2002:a5d:5f8a:0:b0:382:45db:6a1e with SMTP id
 ffacd0b85a97d-38a22a1983dmr31952476f8f.14.1735554664850; 
 Mon, 30 Dec 2024 02:31:04 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c89e1c0sm30201550f8f.77.2024.12.30.02.31.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Dec 2024 02:31:04 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 30 Dec 2024 11:30:57 +0100
Subject: [PATCH v2 3/6] ufs: core: cosmetic fixups
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241230-topic-ufs-cleanup-v2-3-4c6d7994a45d@linaro.org>
References: <20241230-topic-ufs-cleanup-v2-0-4c6d7994a45d@linaro.org>
In-Reply-To: <20241230-topic-ufs-cleanup-v2-0-4c6d7994a45d@linaro.org>
To: Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>
Cc: michal.simek@amd.com, marek.vasut+renesas@mailbox.org, 
 bmeng.cn@gmail.com, venkatesh.abbarapu@amd.com, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>, Love Kumar <love.kumar@amd.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3846;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=0O2a6fVetyGy23roKN7lUNXvdabRfBfIX3Zg1p9emJ0=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBncnZjXG0uyzo+A2dLIy8pbPqYtopUj3zKE1qphNYf
 aExIJPuJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ3J2YwAKCRB33NvayMhJ0Z6uD/
 9vehNg/V0EIaa+X+qPCeZ7Ssd3ImjROzwTT5coFKCNcExR3ImgXE1vnvARQASwCJxoETzNuQZ/Z6hf
 8jDDWcVQTLpQQ/q8Ot/HqtR0jvwFd4lbncDKx8irvXxjQG5QiryBXj13QMXdW1PYqYxfynk+GioUPu
 pzgl/v0tQG1CsvmA5G7pjMuUsjrgwXAfVQL8gPDAcSOKLPgQhEN0d/lvnOsZbizF62vUlRDBN0iDNi
 QN/9iaaxub4NAiQqx/7SKI0CN6Lc7L0RgVk25BohXNoqO28EdCUKuJ3vzGBE4qPpRH1hLtkFN4XWhJ
 x1mOd6gtVJjnqhJgUplJS8aXxV15b1v8Mj8eZ+QyhKCgbFtUzH7V0GmFdRthoDram9JaBDM++cSFgh
 4CsN+uJ4taxC82yOgpXpf83xOyMVh73nKZHQ29T+zZAgy2K/fIjFrJX9psAf/1R4iBFYYrU/nTzw5o
 iZhHNrJ4NsJ+lOOEVDh7Tf/C6BIGZJDZjJhhX/iuSBW1CPkolNUc6N78S9ppdgxhDoX0zfq3+oJpLg
 VfbgHD12de1dQC7sCP95CxnNe3L3Rwikw0Lz4WcXZBxMJCvcjiR7EaISpNbhfFGOM1pGgEV04cw4wG
 kpvFRQcx+/OsBNNGLqaEApOB3gsSO31AvckRiKB172FUsC9iBc78SOMZBPrA==
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

Fixes some alignment warnings, missing comments on write barrier,
missing parenthesis around macro parameters and a comment typo.

No functional changes intended.

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
Tested-by: Love Kumar <love.kumar@amd.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/ufs/ufs.c    | 16 ++++++----------
 drivers/ufs/ufs.h    |  6 +++---
 drivers/ufs/unipro.h |  4 ++--
 3 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
index 654f8b6799ec6735f2db4f6e1c81ee94ec14a74e..91f6ad3bfef9846aab39331efd9493b1a98432d3 100644
--- a/drivers/ufs/ufs.c
+++ b/drivers/ufs/ufs.c
@@ -314,16 +314,12 @@ static int ufshcd_disable_tx_lcc(struct ufs_hba *hba, bool peer)
 		ufshcd_dme_peer_get(hba, UIC_ARG_MIB(PA_CONNECTEDTXDATALANES),
 				    &tx_lanes);
 	for (i = 0; i < tx_lanes; i++) {
+		unsigned int val = UIC_ARG_MIB_SEL(TX_LCC_ENABLE,
+						   UIC_ARG_MPHY_TX_GEN_SEL_INDEX(i));
 		if (!peer)
-			err = ufshcd_dme_set(hba,
-					     UIC_ARG_MIB_SEL(TX_LCC_ENABLE,
-					     UIC_ARG_MPHY_TX_GEN_SEL_INDEX(i)),
-					     0);
+			err = ufshcd_dme_set(hba, val, 0);
 		else
-			err = ufshcd_dme_peer_set(hba,
-					UIC_ARG_MIB_SEL(TX_LCC_ENABLE,
-					UIC_ARG_MPHY_TX_GEN_SEL_INDEX(i)),
-					0);
+			err = ufshcd_dme_peer_set(hba, val, 0);
 		if (err) {
 			dev_err(hba->dev, "%s: TX LCC Disable failed, peer = %d, lane = %d, err = %d\n",
 				__func__, peer, i, err);
@@ -1962,7 +1958,7 @@ int ufshcd_probe(struct udevice *ufs_dev, struct ufs_hba_ops *hba_ops)
 
 	ufshcd_ops_init(hba);
 
-	/* Read capabilties registers */
+	/* Read capabilities registers */
 	hba->capabilities = ufshcd_readl(hba, REG_CONTROLLER_CAPABILITIES);
 	if (hba->quirks & UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS)
 		hba->capabilities &= ~MASK_64_ADDRESSING_SUPPORT;
@@ -2001,7 +1997,7 @@ int ufshcd_probe(struct udevice *ufs_dev, struct ufs_hba_ops *hba_ops)
 		      REG_INTERRUPT_STATUS);
 	ufshcd_writel(hba, 0, REG_INTERRUPT_ENABLE);
 
-	mb();
+	mb(); /* flush previous writes */
 
 	/* Reset the attached device */
 	ufshcd_device_reset(hba);
diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
index 00ecca350c350cc930d9056aba8ada0475a280dd..f4f042005e7fc2638ea6b33f26839c668d22bc9e 100644
--- a/drivers/ufs/ufs.h
+++ b/drivers/ufs/ufs.h
@@ -130,8 +130,8 @@ enum {
 					(sizeof(struct utp_upiu_header)))
 #define RESPONSE_UPIU_SENSE_DATA_LENGTH	18
 #define UPIU_HEADER_DWORD(byte3, byte2, byte1, byte0)\
-			cpu_to_be32((byte3 << 24) | (byte2 << 16) |\
-			 (byte1 << 8) | (byte0))
+			cpu_to_be32(((byte3) << 24) | ((byte2) << 16) |\
+			 ((byte1) << 8) | (byte0))
 /*
  * UFS Protocol Information Unit related definitions
  */
@@ -915,7 +915,7 @@ static inline int ufshcd_ops_get_max_pwr_mode(struct ufs_hba *hba,
 }
 
 static inline int ufshcd_ops_hce_enable_notify(struct ufs_hba *hba,
-						bool status)
+					       bool status)
 {
 	if (hba->ops && hba->ops->hce_enable_notify)
 		return hba->ops->hce_enable_notify(hba, status);
diff --git a/drivers/ufs/unipro.h b/drivers/ufs/unipro.h
index 6df953e6e6073748ac640faea00aa6ac2a8c8663..0aa35ef31dfd263739c0b5c75c26f9191f38e8ec 100644
--- a/drivers/ufs/unipro.h
+++ b/drivers/ufs/unipro.h
@@ -59,7 +59,7 @@
 #define RXSQCTRL				0x00B5
 #define CFGRXOVR6				0x00BF
 
-#define is_mphy_tx_attr(attr)			(attr < RX_MODE)
+#define is_mphy_tx_attr(attr)			((attr) < RX_MODE)
 #define RX_MIN_ACTIVATETIME_UNIT_US		100
 #define HIBERN8TIME_UNIT_US			100
 
@@ -77,7 +77,7 @@
 #define CBPRGPLL2				UNIPRO_CB_OFFSET(0x00F8)
 #define CBPRGTUNING				UNIPRO_CB_OFFSET(0x00FB)
 
-#define UNIPRO_CB_OFFSET(x)			(0x8000 | x)
+#define UNIPRO_CB_OFFSET(x)			(0x8000 | (x))
 
 /*
  * PHY Adpater attributes

-- 
2.34.1

