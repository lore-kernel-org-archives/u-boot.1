Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4005AD60D14
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 09:23:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5738289677;
	Wed, 20 Nov 2024 10:22:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vQjK19pk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B293489555; Wed, 20 Nov 2024 10:22:52 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AD178965F
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 10:22:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43155abaf0bso38704065e9.0
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 01:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732094570; x=1732699370; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4TSFFfudzoIGZXxZLAT1jPSAmj1lerFDO1XLwxSYPi8=;
 b=vQjK19pk+eKiK+xuUMTAne9w45E2WrUDD171ryzwzk95DoiOmA+SKOeDOfN6EubbKJ
 Cf4T4swhykkTawRBtaVIzgQSa6FIOhK+4xMaGdRo4hFcHUuvmmA0YQn7A6urs8MhIHFl
 e//Chf7qoHR6/cuF+LUjarmLMkuws2/V8WjBjLZf+mbwYmCeQ0H+snaVAY/q/EmgWQY/
 ysJeK5k/FgOtks/jwysNZnktZCdgXns+FW2hhIKLqx4j3UITrVTpFJkLBjjF+lztKSwx
 isVW7+kk7KUSkG+R5kWhvIDqPlXbgqimzSo5jweVmQBb8HwHVxG8C1FrzOiaDP1tf230
 qaGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732094570; x=1732699370;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4TSFFfudzoIGZXxZLAT1jPSAmj1lerFDO1XLwxSYPi8=;
 b=Zz3nvGauWZw/R6y+szV3cNDR8KBFexL1xC9fnTK/IxoLcPpLvyE0vRlFMXhNIX+RcL
 F5Pfw3i0edTCNhjUAfIhotmO9ToUPHeXZsBmQRgKwxoHv7xU3WB9DYAUfSHT4M0J1SAi
 sPbjnOItFc7x4MF1JC3Qekp2DBHHsRoNPa16PmXQCNRrKbFcfl72PhKDO1v+QVtsmzbV
 a+SasVWFd9cuu/8s/sTSG0yrXNIaaNcDUqRMPnXtAvE/dyJhW8ssKfg0ulcJlwZKY5GF
 WHHhoV5Cf6Qv/WdOdm9vBk/7Adr3ThIzvZUUxMG/q+m8+Vr7H+pJScKHA6VdEJYZAYGx
 L7JQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3i+etHX2TOHQuhygzE0qeUTZpDthI70ei6FNNAMtTSa7Sy6ecJmlMvMh6OFopbXI5OLFu/tc=@lists.denx.de
X-Gm-Message-State: AOJu0Yw/azmAy2x3JFq3Lw0iX/R3s5jI9opoIQps+0Y5WGv5S18PDKDj
 lkxB751PLeNVdSXLVmiw1oi4IFi8ltT2awk7Gql+iJ5uHd34PVtsC5s+EQlZJXM=
X-Google-Smtp-Source: AGHT+IGASKP2T79tblZdM35RLTMtxexVSVB1zIcueTHBt53NJLb+UWLbx1qymbguDnMhqbq+YPBGLg==
X-Received: by 2002:a05:600c:138e:b0:431:537d:b3b4 with SMTP id
 5b1f17b1804b1-433489a0703mr16514775e9.11.1732094569984; 
 Wed, 20 Nov 2024 01:22:49 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825490529fsm1557333f8f.4.2024.11.20.01.22.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2024 01:22:49 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 20 Nov 2024 10:22:44 +0100
Subject: [PATCH 3/6] ufs: core: cosmetic fixups
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241120-topic-ufs-cleanup-v1-3-a5cef54b1cdc@linaro.org>
References: <20241120-topic-ufs-cleanup-v1-0-a5cef54b1cdc@linaro.org>
In-Reply-To: <20241120-topic-ufs-cleanup-v1-0-a5cef54b1cdc@linaro.org>
To: Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>
Cc: michal.simek@amd.com, marek.vasut+renesas@mailbox.org, 
 bmeng.cn@gmail.com, venkatesh.abbarapu@amd.com, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3749;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=WuV9P+H5zvUiUBBOnV83QEZqXIh2+aZ6ntIwSPow7JE=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnPapld+Q9a4wR6J+QihCieC3QcMUsyFt+FCcw3Rvw
 J2q/Y+qJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZz2qZQAKCRB33NvayMhJ0bf4D/
 kBqoVNvOPx22cd5lfIqQJd9mJppZXSTsWIIVqKPHgPQedwgHURAUZz2AuyC1IoFzYMrvIROw8SFpJ8
 KxdFTisxMGCorGBbKd38Tqw7QjK3vY/IsF0wlSCTq0yQ8xE4CiDssPZGgo3mpRLV5EiHAaRkJEF3YS
 7lEGas77+bhrjNwOKPOmOhXNhnTBDG9gAlJoJuJL8hKGng50NGJLJ4nIV0nz23j57DK+Ie0xNhyknW
 X/r2foBETv/3LQ6HMSqlK6lGXe7l2Bxq2Vtq+mC6xLQZ/wljqTa2M0SLCBM81I+IXPVfx3IaoOUFEB
 WN5irfPxsjr1lNiQKQJ4ko//MCPnVfhkpne83nR6KmCK7ngAQLFqApP+m+PxDINq9QN0O1DpzqywBo
 Wpg8B02u3tYJIbIQ87Nm7SuazgyFr6nwzL8zb+1AY01bKyhl30s24aLmDDFPoaL84/Ff0zZMa7O5qd
 aMHfs7NLy1rorItDvvb0gnB/wB1bNRwABvfCISJ+cq38TI9WuSyTtkqU+MZLC5ZjUTweFLuFKwld3q
 Mb7HxzW3wKMBvgAF+nXW09L2kIDo4rcm6JKk525f6rLxD2kTxRzMEyGcHDIMVgImbprVQzSUjHMl9I
 K+hZyTkzAzlHWGvxLiFUqxBSl1yqxS4A5EFSeOmu58smfxPNQvTz/cUZq+2Q==
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

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/ufs/ufs.c    | 16 ++++++----------
 drivers/ufs/ufs.h    |  6 +++---
 drivers/ufs/unipro.h |  4 ++--
 3 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
index 8a6c9f1e40b058dfd29bc07d011d576cdfc504cb..173b8d01d2a415999248468890cc9bcb66a21c24 100644
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
@@ -1963,7 +1959,7 @@ int ufshcd_probe(struct udevice *ufs_dev, struct ufs_hba_ops *hba_ops)
 
 	ufshcd_ops_init(hba);
 
-	/* Read capabilties registers */
+	/* Read capabilities registers */
 	hba->capabilities = ufshcd_readl(hba, REG_CONTROLLER_CAPABILITIES);
 	if (hba->quirks & UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS)
 		hba->capabilities &= ~MASK_64_ADDRESSING_SUPPORT;
@@ -2002,7 +1998,7 @@ int ufshcd_probe(struct udevice *ufs_dev, struct ufs_hba_ops *hba_ops)
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

